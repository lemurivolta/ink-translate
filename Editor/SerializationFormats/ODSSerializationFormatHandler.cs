using System.Collections.Generic;
using System.IO.Compression;
using System.Xml.Linq;
using System.Xml;
using System.Linq;

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

        private readonly XNamespace nsTable =
            "urn:oasis:names:tc:opendocument:xmlns:table:1.0";
        private readonly XNamespace nsText =
            "urn:oasis:names:tc:opendocument:xmlns:text:1.0";
        private readonly XNamespace nsOffice =
            "urn:oasis:names:tc:opendocument:xmlns:office:1.0";
        private readonly XNamespace nsCalcext =
            "urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0";

        public ODSSerializationFormatHandler(string languageCode, InkTranslateAsset asset)
            : base("ODS", languageCode, asset) { }

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
            // read all the translation lines
            xDocumentTable = xDocument
                .Descendants(nsTable + "table")
                .Single(el => el
                    .Attributes(nsTable + "name")
                    .Single()
                    .Value == "Translations");
            lines = xDocumentTable
                    .Elements(nsTable + "table-row")
                    .Skip(1)
                    .Select(tableRow =>
                    {
                        var columns = tableRow.Elements(nsTable + "table-cell").ToArray();
                        if (columns.Length < 3)
                        {
                            return new()
                            {
                                Key = null,
                                Source = null,
                                Target = null,
                                TableRow = null
                            };
                        }
                        string GetColumnValue(int columnIndex)
                        {
                            var p = columns[columnIndex]
                                .Descendants(nsText + "p")
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

        protected override void InnerSerialize()
        {
            // update the XML document
            foreach (var entry in translationTable)
            {
                var translation =
                    entry.Languages.GetValueOrDefault(languageCode, null) ?? "";
                string source = entry.Languages[sourceLanguageCode];

                if (!linesByKey.ContainsKey(entry.Key))
                {
                    // there's no line in the table that corresponds to the given entry:
                    // add it
                    (XElement, XElement) CreateTableCell(string styleName = null)
                    {
                        var tableCell = new XElement(nsTable + "table-cell");
                        if (styleName != null)
                        {
                            tableCell.SetAttributeValue(nsTable + "style-name", styleName);
                        }
                        tableCell.SetAttributeValue(nsOffice + "value-type", "string");
                        tableCell.SetAttributeValue(nsCalcext + "value-type", "string");

                        var p = new XElement(nsText + "p");
                        tableCell.Add(p);

                        return (tableCell, p);
                    }

                    var (keyTableCell, keyP) = CreateTableCell();
                    keyP.Value = entry.Key;

                    var (srcTableCell, srcP) = CreateTableCell("ce3");
                    srcP.Value = source;

                    var (trgTableCell, trgP) = CreateTableCell();
                    trgP.Value = translation;

                    var tableRow = new XElement(nsTable + "table-row");
                    tableRow.SetAttributeValue(nsTable + "style-name", "ro2");
                    tableRow.Add(keyTableCell);
                    tableRow.Add(srcTableCell);
                    tableRow.Add(trgTableCell);

                    xDocumentTable.Add(tableRow);

                    linesByKey[entry.Key] = new()
                    {
                        Key = entry.Key,
                        Source = source,
                        Target = translation,
                        TableRow = tableRow
                    };
                }
                var line = linesByKey[entry.Key];
                // get the "source" cell
                var sourceTranslationCell = line.TableRow
                    .Elements(nsTable + "table-cell")
                    .Skip(1)
                    .First();
                // set the text of source
                sourceTranslationCell.Element(nsText + "p").Value = source;
                CleanupCell(sourceTranslationCell);
                // set an annotation if necessary
                var annotation = sourceTranslationCell.Element(nsOffice + "annotation");
                if (string.IsNullOrEmpty(entry.Notes) && annotation != null)
                {
                    annotation.Remove();
                }
                else if (!string.IsNullOrEmpty(entry.Notes))
                {
                    if (annotation == null)
                    {
                        annotation = new XElement(nsOffice + "annotation");
                        var p3 = new XElement(nsText + "p");
                        p3.SetAttributeValue(nsText + "style-name", "P1");
                        annotation.Add(p3);
                        sourceTranslationCell.Add(annotation);
                    }
                    var p2 = annotation.Element(nsText + "p");
                    p2.Value = entry.Notes;
                }

                // get the "target" cell
                var targetTranslationCell = line.TableRow
                    .Elements(nsTable + "table-cell")
                    .Skip(2)
                    .First();
                var p = targetTranslationCell.Element(nsText + "p");
                if (p == null)
                {
                    p = new XElement(nsText + "p");
                    targetTranslationCell.Add(p);
                }
                p.Value = translation;
                CleanupCell(targetTranslationCell);
            }

            var numTableRows = xDocument.Descendants(nsTable + "table-row").Count();
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
            var p = sourceTranslationCell.Element(nsText + "p");
            if (p != null && p.Value.Trim() == "")
            {
                p.Remove();
            }
        }
    }
}
