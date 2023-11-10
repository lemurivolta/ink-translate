using System.Collections.Generic;
using System.IO.Compression;
using System.Xml.Linq;
using System.Xml;
using System.Linq;
using static LemuRivolta.InkTranslate.InkTranslateAsset;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSSerializationFormatHandler : SerializationFormatHandler
    {
        public static byte[] CreateDefaultODSFile()
        {
            var odsPath = System.IO.Path.GetFullPath("Packages/it.lemurivolta.ink-translate/Editor/SerializationFormats/ODSTemplate.ods");
            using System.IO.Stream s = System.IO.File.OpenRead(odsPath);
            using System.IO.MemoryStream ms = new();
            s.CopyTo(ms);
            return ms.GetBuffer();
        }

        private static readonly XNamespace nsTable =
            "urn:oasis:names:tc:opendocument:xmlns:table:1.0";
        private readonly XName tableElName = nsTable + "table";
        private readonly XName nameElName = nsTable + "name";
        private readonly XName tableRowElName = nsTable + "table-row";
        private readonly XName tableCellElName = nsTable + "table-cell";
        private readonly XName numberColumnsRepeatedElName = nsTable + "number-columns-repeated";
        private readonly XName styleNameElName = nsTable + "style-name";

        private static readonly XNamespace nsText =
            "urn:oasis:names:tc:opendocument:xmlns:text:1.0";
        private readonly XName pElName = nsText + "p";
        private readonly XName styleNameTElName = nsText + "style-name";

        private static readonly XNamespace nsOffice =
            "urn:oasis:names:tc:opendocument:xmlns:office:1.0";
        private readonly XName officeValueTypeElName = nsOffice + "value-type";
        private readonly XName officeAnnotationElName = nsOffice + "annotation";

        private static readonly XNamespace nsCalcext =
            "urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0";
        private readonly XName calcExtValueTypeElName = nsCalcext + "value-type";

        public static ODSSerializationFormatHandler Factory(string languageCode,
            string sourceLanguageCode,
            List<OtherSupportedLanguage> translationLanguages) =>
            new(languageCode, sourceLanguageCode, translationLanguages);

        public ODSSerializationFormatHandler(string languageCode,
            string sourceLanguageCode,
            List<OtherSupportedLanguage> translationLanguages)
            : base("ODS", languageCode, sourceLanguageCode, translationLanguages) { }

        private struct ODSReaderLine
        {
            public string Key;
            public string Source;
            public string Target;
            public XElement TableRow;
        }

        private XDocument xDocument;
        private XElement xDocumentTable;
        private ODSReaderLine[] lines;
        private Dictionary<string, ODSReaderLine> linesByKey;

        protected override Dictionary<string, string> InnerRead()
        {
            // open the zip archive
            using var zipArchive = ZipFile.Open(
                GetLanguageInfo().ODSFile.GetPath(),
                ZipArchiveMode.Read);
            // get the main xml
            var contentXmlEntry = zipArchive.GetEntry("content.xml");
            // parse the main xml
            using var contentXmlStream = contentXmlEntry.Open();
            xDocument = XDocument.Load(contentXmlStream);
            // normalize the document
            NormalizeDocument();
            // read all the translation lines
            xDocumentTable = xDocument
                .Descendants(tableElName)
                .Single(el => el
                    .Attributes(nameElName)
                    .Single()
                    .Value == "Translations");
            lines = xDocumentTable
                    .Elements(tableRowElName)
                    .Skip(1)
                    .Select(tableRow =>
                    {
                        var columns = tableRow.Elements(tableCellElName).ToArray();
                        string GetColumnValue(int columnIndex)
                        {
                            if (columnIndex >= columns.Length)
                            {
                                return null;
                            }
                            var p = columns[columnIndex]
                                .Descendants(pElName)
                                .FirstOrDefault();
                            if (p != null)
                            {
                                return p.Value
                                .Trim();
                            }
                            else
                            {
                                return null;
                            }
                        }
                        var key = GetColumnValue(0);
                        var source = GetColumnValue(1);
                        var target = GetColumnValue(2);
                        return new ODSReaderLine
                        {
                            Key = key,
                            Source = source,
                            Target = target,
                            TableRow = tableRow
                        };
                    })
                    .Where(o => o.Key != null && o.Source != null)
                    .ToArray();
            linesByKey = lines.ToDictionary(e => e.Key, e => e);

            return lines.ToDictionary(e => e.Key, e => e.Target);
        }

        /// <summary>
        /// Apply various operations on the document in order to have it in a form we can
        /// easily parse.
        /// Specifically:
        /// - remove empty table rows
        /// - expand number-columns-repeated and number-rows-repeated
        /// </summary>
        private void NormalizeDocument()
        {
            // remove empty table rows
            // this is especially important when ODS editors like libreoffice add
            // empty padding covering all lines in a document, with something like:
            /*
             * <table:table-row table:style-name="ro1" table:number-rows-repeated="1048568">
             *      <table:table-cell table:number-columns-repeated="3" />
             * </table:table-row>
             */
            // when we add new translation lines to such a document, we get over the
            // maximum number of rows and make the document unreadable
            (from row in xDocument.Descendants(tableRowElName)
             where row.Descendants(pElName).FirstOrDefault() == null
             select row)
            .Remove();

            // expand table:number-columns-repeated
            // out algorithm counts cell indices; for this to work, there must be no
            // repeated cells of the count is off
            // this could happen when the translation of a line is the same as the
            // original one: this could produce a repeated cell when saved
            var tableCellsWithRepeat = (
                from tableCell in xDocument.Descendants(tableCellElName)
                let numRepeatsAttr = tableCell.Attribute(numberColumnsRepeatedElName)
                where numRepeatsAttr != null
                select (TableCell: tableCell, NumRepeatsAttr: numRepeatsAttr))
                .ToList();
            foreach (var (tableCell, nodes) in
            from t in tableCellsWithRepeat
            let num = int.Parse(t.NumRepeatsAttr.Value)
            let nodes = Enumerable.Range(0, num).Select(_ =>
            {
                var copyTableCell = new XElement(t.TableCell);
                copyTableCell.Attribute(numberColumnsRepeatedElName).Remove();
                return copyTableCell;
            })
            select (t.TableCell, nodes))
            {
                tableCell.ReplaceWith(nodes);
            }
        }

        protected override void InnerSerialize()
        {
            // update the XML document
            foreach (var entry in translationTable)
            {
                var translation =
                    entry.Languages.GetValueOrDefault(languageCode, null) ?? "";
                string source = entry.Languages[sourceLanguageCode];

                ODSReaderLine? maybeLine = linesByKey.ContainsKey(entry.Key) ? linesByKey[entry.Key] : null;
                int numCells = maybeLine == null ? 0 :
                    maybeLine.Value.TableRow.Elements(tableCellElName).Count();
                if (numCells < 3)
                {
                    // there's no line in the table that corresponds to the given entry,
                    // or the line isn't complete: add what's missing in it
                    var (keyTableCell, keyP) = CreateOrGetTableCell(
                        0, entry.Key, out var addedKey);

                    var (srcTableCell, srcP) = CreateOrGetTableCell(
                        1, source, out var addedSource, "ce3");

                    var (trgTableCell, trgP) = CreateOrGetTableCell(
                        2, translation, out var addedTranslation);

                    XElement tableRow = CreateOrGetTableRow();

                    if (addedKey)
                    {
                        tableRow.Add(keyTableCell);
                    }
                    if (addedSource)
                    {
                        tableRow.Add(srcTableCell);
                    }
                    if (addedTranslation)
                    {
                        tableRow.Add(trgTableCell);
                    }

                    if (!maybeLine.HasValue)
                    {
                        xDocumentTable.Add(tableRow);
                    }

                    linesByKey[entry.Key] = new()
                    {
                        Key = entry.Key,
                        Source = source,
                        Target = translation,
                        TableRow = tableRow
                    };

                    (XElement, XElement) CreateOrGetTableCell(int index, string value, out bool added, string styleName = null)
                    {
                        if (numCells <= index)
                        {
                            var tableCell = new XElement(tableCellElName);
                            if (styleName != null)
                            {
                                tableCell.SetAttributeValue(styleNameElName, styleName);
                            }
                            tableCell.SetAttributeValue(officeValueTypeElName, "string");
                            tableCell.SetAttributeValue(calcExtValueTypeElName, "string");

                            var p = new XElement(pElName)
                            {
                                Value = value
                            };
                            tableCell.Add(p);

                            added = true;

                            return (tableCell, p);
                        }
                        else
                        {
                            var tableCell = maybeLine.Value.TableRow
                                .Elements(tableCellElName)
                                .Skip(index)
                                .First();
                            var p = tableCell.Element(pElName);
                            p.Value = value;

                            added = false;

                            return (tableCell, p);
                        }
                    }

                    XElement CreateOrGetTableRow()
                    {
                        if (maybeLine.HasValue)
                        {
                            return maybeLine.Value.TableRow;
                        }
                        else
                        {
                            var tableRow = new XElement(tableRowElName);
                            tableRow.SetAttributeValue(styleNameElName, "ro2");
                            return tableRow;
                        }
                    }
                }
                var line = linesByKey[entry.Key];
                // get the "source" cell
                var sourceTranslationCell = line.TableRow
                    .Elements(tableCellElName)
                    .Skip(1)
                    .First();
                // set the text of source
                sourceTranslationCell.Element(pElName).Value = source;
                CleanupCell(sourceTranslationCell);
                // set an annotation if necessary
                var annotation = sourceTranslationCell.Element(officeAnnotationElName);
                if (string.IsNullOrEmpty(entry.Notes) && annotation != null)
                {
                    annotation.Remove();
                }
                else if (!string.IsNullOrEmpty(entry.Notes))
                {
                    if (annotation == null)
                    {
                        annotation = new XElement(officeAnnotationElName);
                        var p3 = new XElement(pElName);
                        p3.SetAttributeValue(styleNameTElName, "P1");
                        annotation.Add(p3);
                        sourceTranslationCell.Add(annotation);
                    }
                    var p2 = annotation.Element(pElName);
                    p2.Value = entry.Notes;
                }

                // get the "target" cell
                var targetTranslationCell = line.TableRow
                    .Elements(tableCellElName)
                    .Skip(2)
                    .First();
                var p = targetTranslationCell.Element(pElName);
                if (p == null)
                {
                    p = new XElement(pElName);
                    targetTranslationCell.Add(p);
                }
                p.Value = translation;
                CleanupCell(targetTranslationCell);
            }

            // print statistics
            var numTableRows = xDocument.Descendants(tableRowElName).Count();
            UnityEngine.Debug.Log(numTableRows.ToString());

            // write into the zip
            using var zipArchive = ZipFile.Open(
                GetLanguageInfo().ODSFile.GetPath(), ZipArchiveMode.Update);
            zipArchive.GetEntry("content.xml").Delete();
            var contentXmlEntry = zipArchive.CreateEntry("content.xml");
            using var contentXmlStream = contentXmlEntry.Open();
            using var xmlWriter = XmlWriter.Create(contentXmlStream, new()
            {
                Indent = true
            });
            xDocument.WriteTo(xmlWriter);
        }

        private void CleanupCell(XElement sourceTranslationCell)
        {
            var p = sourceTranslationCell.Element(pElName);
            if (p != null && p.Value.Trim() == "")
            {
                p.Remove();
            }
        }
    }
}
