using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;

using static LemuRivolta.InkTranslate.InkTranslateAsset;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSSerializationFormatHandler2 : SerializationFormatHandler
    {
        #region document access

        private ODSDocument odsDocument;

        private ODSTable MainTable => odsDocument
            .Tables
            .First(table => table.Name == "Translations");

        private IEnumerable<ODSTableRow> TranslationRows => MainTable
            .TableRows
            .Skip(1)
            .Where(tableRow =>
                !string.IsNullOrEmpty(GetTranslationRowKey(tableRow)) &&
                !string.IsNullOrEmpty(GetTranslationRowSource(tableRow)));

        #endregion

        #region interface implementation

        public static ODSSerializationFormatHandler2 Factory(string languageCode,
            string sourceLanguageCode,
            List<OtherSupportedLanguage> translationLanguages) =>
            new(languageCode, sourceLanguageCode, translationLanguages);

        public ODSSerializationFormatHandler2(string languageCode,
            string sourceLanguageCode,
            List<OtherSupportedLanguage> translationLanguages)
            : base("ODS", languageCode, sourceLanguageCode, translationLanguages) { }

        public static byte[] CreateDefaultODSFile()
        {
            var odsPath = Path.GetFullPath("Packages/it.lemurivolta.ink-translate/Editor/SerializationFormats/ODSTemplate.ods");
            using Stream s = File.OpenRead(odsPath);
            using MemoryStream ms = new();
            s.CopyTo(ms);
            return ms.GetBuffer();
        }

        protected override Dictionary<string, string> InnerRead()
        {
            // open the zip archive stream
            using var stream = File.OpenRead(GetLanguageInfo().ODSFile.GetPath());
            // read the ODS document
            var odsReader = new ODSReader();
            odsDocument = odsReader.Deserialize(stream);
            CleanupEmptyRows();
            // add possibly missing styles
            AddMissingStyles();
            // return the translations contained inside
            return TranslationRows.ToDictionary(GetTranslationRowKey, GetTranslationRowTarget);
        }

        private void CleanupEmptyRows()
        {
            // remove all rows in the Translations table without content
            // this is especially important when ODS editors like libreoffice add
            // empty padding covering all lines in a document, with something like:
            /*
             * <table:table-row table:style-name="ro1" table:number-rows-repeated="1048568">
             *      <table:table-cell table:number-columns-repeated="3" />
             * </table:table-row>
             */
            // when we add new translation lines to such a document, we get over the
            // maximum number of rows and make the document unreadable
            var rowsToRemove = MainTable
                                .TableRows
                                .Where(tableRow => tableRow
                                    .TableCells
                                    .Select(tableCell => tableCell.TextContent.Trim().Length)
                                    .All(contentLength => contentLength == 0))
                                .ToArray();
            foreach (var row in rowsToRemove)
            {
                row.Remove();
            }
        }

        private const string removedTranslationStyleName = "Removed Translation";

        private void AddMissingStyles()
        {
            // get or create "removed translation" style
            ODSStyle removedStyle;
            if ((removedStyle = odsDocument.Styles.FirstOrDefault(style => style.Name == removedTranslationStyleName)) == null)
            {
                odsDocument.AppendStyle(removedStyle = new()
                {
                    Name = removedTranslationStyleName
                });
            }
            removedStyle.Family = ODSStyleFamily.TableCell;
            removedStyle.ParentStyleName = "Default";
            // get or create its text properties
            ODSStyleTextProperties styleTextProperties;
            if ((styleTextProperties = removedStyle.Content.OfType<ODSStyleTextProperties>().FirstOrDefault()) == null)
            {
                removedStyle.AppendContent(styleTextProperties = new ODSStyleTextProperties());
            }
            // set or reset the properties of the style
            styleTextProperties.FontSize = new ODSLengthFontSize(8, ODSSizeUnit.Pt);
            styleTextProperties.FontColor = UnityEngine.Color.gray;

            // update default style
            var defaultStyle = odsDocument.Styles.First(style => style.Name == "Default");
            // get or set its table cell properties
            ODSStyleTableCellProperties tableCellProperties;
            if ((tableCellProperties = defaultStyle.Content.OfType<ODSStyleTableCellProperties>().FirstOrDefault()) == null)
            {
                defaultStyle.AppendContent(tableCellProperties = new ODSStyleTableCellProperties());
            }
            // set or reset the properties of the style
            tableCellProperties.WrapOption = ODSWrapOption.Wrap;
            tableCellProperties.VerticalAlign = ODSTableCellVerticalAlign.Middle;
        }

        protected override void InnerSerialize()
        {
            // update the XML document with the translations from the translation table
            var translationRowsByKey = TranslationRows.ToDictionary(GetTranslationRowKey);
            ODSTableRow previousRow = null;
            foreach (var entry in translationTable)
            {
                // get or create the corresponding translation row
                if (!translationRowsByKey.TryGetValue(entry.Key, out var translationRow))
                {
                    translationRow = new()
                    {
                        StyleName = "ro2"
                    };
                    if (previousRow == null)
                    {
                        MainTable.AddTableRowFirst(translationRow);
                    }
                    else
                    {
                        MainTable.AddTableRowAfter(translationRow, previousRow);
                    }
                }
                // get or set the cells inside
                SetTranslationCell(translationRow, 0, entry.Key, annotation: entry.Notes);
                SetTranslationCell(translationRow, 1, entry.Languages[sourceLanguageCode], styleName: "ce3");
                SetTranslationCell(translationRow, 2, entry.Languages.GetValueOrDefault(languageCode, null) ?? "");
                // remember this row
                previousRow = translationRow;
            }
            // check for obsolete translations
            var existingKeys = translationTable.Select(translationEntry => translationEntry.Key).ToHashSet();
            foreach (var translationRow in TranslationRows)
            {
                var key = GetTranslationRowKey(translationRow);
                if (!existingKeys.Contains(key))
                {
                    UnityEngine.Debug.Log($"key {key} is obsolete");
                    foreach (var cell in translationRow.TableCells)
                    {
                        cell.StyleName = removedTranslationStyleName;
                    }
                }
            }
            // write the file
            using (var stream = File.Open(GetLanguageInfo().ODSFile.GetPath(), FileMode.OpenOrCreate, FileAccess.ReadWrite))
            {
                var odsWriter = new ODSWriter();
                odsWriter.Serialize(stream, odsDocument);
            }
            // print statistics
            UnityEngine.Debug.Log($"ODS: num translation rows = {MainTable.TableRows.Skip(1).Count()}");
        }

        #endregion

        #region helper functions

        private void SetTranslationCell(
            ODSTableRow translationRow, int columnIndex, string content, string styleName = null, string annotation = null)
        {
            // handle cell creation / setup
            if (!translationRow.TryGetCellByIndex(columnIndex, out var cell))
            {
                translationRow.SetCellByIndex(columnIndex, cell = new());
            }
            cell.ValueType = ODSValueType.String;
            cell.StyleName = styleName ?? cell.StyleName;

            // handle paragraph inside cell
            ODSParagraph para;
            if ((para = cell.Content.OfType<ODSParagraph>().FirstOrDefault()) == null)
            {
                cell.AppendContent(para = new());
            }
            para.Content = content;

            // handle annotation inside cell
            ODSAnnotation annoElement = cell.Content.OfType<ODSAnnotation>().FirstOrDefault();
            if (annotation != null)
            {
                if (annoElement == null)
                {
                    cell.AppendContent(annoElement = new ODSAnnotation());
                    annoElement.AppendContent(new ODSParagraph());
                }
                annoElement.Content.OfType<ODSParagraph>().First().Content = annotation;
            }
            else
            {
                var existingAnnotations = cell.Content.OfType<ODSAnnotation>().ToArray();
                foreach (var existingAnnotation in existingAnnotations)
                {
                    existingAnnotation.Remove();
                }
            }
        }

        private string GetTranslationRowKey(ODSTableRow tableRow) => TryOrNull(tableRow, 0);
        private string GetTranslationRowSource(ODSTableRow tableRow) => TryOrNull(tableRow, 1);
        private string GetTranslationRowTarget(ODSTableRow tableRow) => TryOrNull(tableRow, 2);

        private string TryOrNull(ODSTableRow tableRow, int index) =>
            tableRow.TryGetCellByIndex(index, out var cell) ?
                cell.TextContent.Trim() :
                null;

        #endregion
    }
}
