using System.Collections.Generic;

using Localization.Xliff.OM.Core;
using Localization.Xliff.OM.Serialization;

using System.Linq;
using static LemuRivolta.InkTranslate.InkTranslateAsset;

namespace LemuRivolta.InkTranslate.Editor
{
    public class XLIFFSerializationFormatHandler : SerializationFormatHandler
    {
        public static string CreateDefaultXLIFFFile(
            string sourceLanguageCode,
            InkTranslateAsset.OtherSupportedLanguage l)
        {
            using var ms = new System.IO.MemoryStream();
            Segment segment = new()
            {
                Source = new Source("-"),
                Target = new Target("-")
            };

            Unit unit = new("-");
            unit.Resources.Add(segment);

            File file = new("-");
            file.Containers.Add(unit);

            var document = new XliffDocument(sourceLanguageCode)
            {
                TargetLanguage = l.LanguageCode
            };
            document.Files.Add(file);

            var writer = new XliffWriter();
            writer.Serialize(ms, document);

            ms.Position = 0;

            using var sr = new System.IO.StreamReader(ms);

            // create xliff file
            string documentContent = sr.ReadToEnd();
            return documentContent;
        }

        public static XLIFFSerializationFormatHandler Factory(string languageCode,
            string sourceLanguageCode,
            List<OtherSupportedLanguage> translationLanguages) =>
            new(languageCode, sourceLanguageCode, translationLanguages);

        public XLIFFSerializationFormatHandler(string languageCode,
            string sourceLanguageCode,
            List<OtherSupportedLanguage> translationLanguages)
            : base("XLIFF", languageCode, sourceLanguageCode, translationLanguages) { }

        protected override Dictionary<string, string> InnerRead()
        {
            // read document
            XliffDocument xliffDocument = ReadXliffDocument();

            // find all translation entries
            var translations = new Dictionary<string, string>();
            foreach (var file in xliffDocument.Files)
            {
                foreach (var unit in from container in file.Containers
                                     where container is Unit
                                     select container as Unit)
                {
                    var translationKey = unit.Id;
                    foreach (var resource in from resource in unit.Resources
                                             where resource is Segment
                                             select resource as Segment)
                    {
                        string result = null;
                        if (resource.Target != null)
                        {
                            var pieces = (from t in resource.Target.Text
                                          where t is PlainText
                                          select (t as PlainText).Text);
                            result = string.Join("", pieces).Trim();
                            if (result.Length == 0)
                            {
                                result = null;
                            }
                        }
                        translations[translationKey] = result;
                    }
                }
            }

            return translations;
        }

        protected override void InnerSerialize()
        {
            // read the current document
            XliffDocument xliffDocument = ReadXliffDocument();

            // save the references to each file and each unit
            Dictionary<string, File> files = new();
            Dictionary<string, Unit> units = new();

            foreach (var file in xliffDocument.Files)
            {
                files[file.Id] = file;

                foreach (var unit in from container in file.Containers
                                     where container is Unit
                                     select container as Unit)
                {
                    units[unit.Id] = unit;
                }
            }

            // run over the current table to save the contents inside the document
            foreach (var entry in translationTable)
            {
                var sourceText = entry.Languages[sourceLanguageCode];
                var targetText = entry.Languages.GetValueOrDefault(languageCode, null);
                // get the file, or add it if it's not present
                var file = files.GetValueOrCreateDefault(entry.Filename, () =>
                {
                    File newFile = new(entry.Filename)
                    {
                        Original = entry.Filename
                    };
                    xliffDocument.Files.Add(newFile);
                    return newFile;
                });
                // get the unit, or create it if it's not present
                var unit = units.GetValueOrCreateDefault(entry.Key, () =>
                {
                    var source = new Source(sourceText);
                    var segment = new Segment
                    {
                        Source = source,
                    };
                    Unit unit = new(entry.Key);
                    unit.Resources.Add(segment);

                    file.Containers.Add(unit);

                    return unit;
                });
                unit.Notes.Clear();
                if (entry.Notes != null)
                {
                    unit.Notes.Add(new Note(entry.Notes));
                }
                if (!string.IsNullOrEmpty(targetText))
                {
                    (unit.Resources[0] as Segment).Target = new Target(targetText);
                }
            }

            // write the document back
            WriteXliffDocument(xliffDocument);
        }

        private XliffDocument ReadXliffDocument()
        {
            // read the xliff document
            using var fs = System.IO.File.OpenRead(GetLanguageInfo().XLIFFFile.GetPath());
            var reader = new XliffReader();
            XliffDocument xliffDocument = reader.Deserialize(fs);
            return xliffDocument;
        }

        private void WriteXliffDocument(XliffDocument xliffDocument)
        {
            // write the xliff document
            using var fs = System.IO.File.OpenWrite(GetLanguageInfo().XLIFFFile.GetPath());
            var writer = new XliffWriter(new XliffWriterSettings()
            {
                Indent = true,
            });
            writer.Serialize(fs, xliffDocument);
        }
    }
}
