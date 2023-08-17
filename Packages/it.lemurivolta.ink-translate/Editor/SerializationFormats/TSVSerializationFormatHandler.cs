using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace LemuRivolta.InkTranslate.Editor
{
    public class TSVSerializationFormatHandler : SerializationFormatHandler
    {
        public static string CreateDefaultTSVFile(
            string sourceLanguageCode,
            InkTranslateAsset.OtherSupportedLanguage l) =>
            $"Key\t{sourceLanguageCode}\t{l.LanguageCode}";

        public TSVSerializationFormatHandler(string languageCode, InkTranslateAsset asset)
            : base("TSV", languageCode, asset)
        {
        }

        protected override Dictionary<string, string> InnerRead()
        {
            // open the TSV stream
            string tsvPath = GetLanguageInfo().TSVFile.GetPath();
            using StreamReader fs = File.OpenText(tsvPath);

            // read the header and find the current language index
            var header = fs.ReadLine().Split('\t');
            var languageIndex = Array.IndexOf(header, languageCode);
            if (languageIndex == -1)
            {
                throw new InvalidOperationException(
                    $"Cannot find language {languageCode} in {tsvPath}");
            }

            // read the translations for this file and save them
            string line;
            var translations = new Dictionary<string, string>();
            while (!string.IsNullOrEmpty(line = fs.ReadLine()))
            {
                var pieces = line.Split('\t');
                translations[pieces[0]] = pieces[languageIndex];
            }

            // return it
            return translations;
        }

        protected override void InnerSerialize()
        {
            using var fs = File.Open(
                GetLanguageInfo().TSVFile.GetPath(),
                FileMode.Create);
            void writeString(string s)
            {
                fs.Write(Encoding.UTF8.GetBytes(s));
            }
            writeString($"Key\t{sourceLanguageCode}\t{languageCode}\n");
            foreach (var entry in translationTable)
            {
                writeString(entry.Key);
                writeString("\t");
                writeString(entry.Languages[sourceLanguageCode]);
                writeString("\t");
                writeString(entry.Languages.GetValueOrDefault(languageCode, null) ?? "");
                writeString("\n");
            }
        }
    }
}
