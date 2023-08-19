using System.Collections.Generic;
using System.IO;
using System.Text;

using UnityEditor;

using UnityEngine.Assertions;

using static LemuRivolta.InkTranslate.InkTranslateAsset;

namespace LemuRivolta.InkTranslate.Editor
{
    public class TranslatedInkGenerator
    {
        public static readonly Progress.Phase Phase = new("Generate the translated ink files");

        private readonly IEnumerable<string> filenames;
        private readonly List<TranslationTableEntry> translationTable;
        private readonly string mainFilePath;
        private readonly List<OtherSupportedLanguage> translationLanguages;
        private readonly Dictionary<string, string[]> fileContents;

        public TranslatedInkGenerator(
            IEnumerable<string> filenames,
            List<TranslationTableEntry> translationTable,
            string mainFilePath,
            List<OtherSupportedLanguage> translationLanguages,
            Dictionary<string, string[]> fileContents)
        {
            this.filenames = filenames;
            this.translationTable = translationTable;
            this.mainFilePath = mainFilePath;
            this.translationLanguages = translationLanguages;
            this.fileContents = fileContents;
        }

        private int numFoundTranslations, numMissingTranslations;

        public void GenerateTranslations()
        {
            numFoundTranslations = 0;
            numMissingTranslations = 0;
            int i = 0;
            Phase.Do(0);
            foreach (var lang in translationLanguages)
            {
                GenerateTranslation(lang.LanguageCode, i++);
            }
            UnityEngine.Debug.Log($"Found {numFoundTranslations} translations, missing {numMissingTranslations} translations.");
        }

        private void GenerateTranslation(string lang, int i)
        {
            var root = Path.Combine(UnityEngine.Application.dataPath, "..")
                .NormalizePath();

            var percentageMultiplier = 1f / translationLanguages.Count;
            var basePercentage = percentageMultiplier * i;
            Phase.Do(basePercentage);

            /// A map between lines in files, and the substitutions that must be applied,
            /// expressed as a list of triples (inclusive 1-based start char, exclusive
            /// 1-based end char, new string value).
            var substitutions = new FileDict<List<(int, int, string)>>();

            // load the translations in "substitutions"
            var (mainInkDir, translationDir) = SetupDirectory(lang);
            int j = 0;
            var sourceFilenames = new HashSet<string>();
            foreach (var entry in translationTable)
            {
                Phase.Do(basePercentage +
                    percentageMultiplier * j++ / translationTable.Count / 2);
                var sourceFilename = entry.Filename.ResolveInkFilename(mainFilePath);
                sourceFilenames.Add(sourceFilename);
                if (!entry.Languages.TryGetValue(lang, out var translation))
                {
                    numMissingTranslations++;
                }
                else
                {
                    substitutions
                        .GetValueOrCreateDefault(entry.Filename, () => new())
                        .GetValueOrCreateDefault(entry.LineNumber, () => new())
                        .Add((
                            entry.StartChar,
                            entry.EndChar,
                            translation
                        ));
                    numFoundTranslations++;
                }
            }
            // sort substitutions from the last to the first
            foreach (var filename in substitutions.Keys)
            {
                foreach (var lineNumber in substitutions[filename].Keys)
                {
                    substitutions[filename][lineNumber].Sort((t1, t2) =>
                        -t1.Item1.CompareTo(t2.Item1));
                }
            }
            // create the files
            j = 0;
            foreach (var filename in filenames)
            {
                var sourceFilename = filename.ResolveInkFilename(mainFilePath);
                if (substitutions.Count > 0)
                {
                    Phase.Do(basePercentage +
                        percentageMultiplier * (0.5f + j++ / substitutions.Count / 2));
                }

                var destFilename = sourceFilename
                    .Replace(mainInkDir, translationDir)
                    .NormalizePath();
                Assert.AreNotEqual(sourceFilename, destFilename);
                var lines = (string[])fileContents[filename].Clone();
                // replace the lines content
                if (substitutions.ContainsKey(filename))
                {
                    foreach (var lineNumber in substitutions[filename].Keys)
                    {
                        foreach (var (startChar, endChar, newString) in substitutions[filename][lineNumber])
                        {
                            var s = lines[lineNumber - 1];
                            // we must re-add spaces, since we trim it for translators
                            var (preSpaces, postSpaces) = GetTrimmableSpaces(
                                s[(startChar - 1)..(endChar - 1)]);
                            lines[lineNumber - 1] = s[0..(startChar - 1)] +
                                preSpaces +
                                newString +
                                postSpaces +
                                s[(endChar - 1)..^0];
                        }
                    }
                }
                // write the result
                if (File.Exists(destFilename))
                {
                    File.Delete(destFilename);
                }
                // write the file, creating missing directories if necessary
                Directory.CreateDirectory(Path.GetDirectoryName(destFilename));
                using var fileStream = File.OpenWrite(destFilename);
                foreach (var line in lines)
                {
                    var l = line + "\n";
                    fileStream.Write(Encoding.UTF8.GetBytes(l));
                }
            }
            foreach (var inkFilename in filenames)
            {
                var filename = inkFilename.ResolveInkFilename(mainFilePath);
                var sourceFilename = filename.NormalizePath();
                var destFilename = sourceFilename.Replace(mainInkDir, translationDir)
                    .NormalizePath();
                Assert.IsTrue(destFilename.StartsWith(root));
                var assetPath = destFilename[(root.Length + 1)..];
                AssetDatabase.ImportAsset(assetPath);
            }
        }

        private (string, string) GetTrimmableSpaces(string s)
        {
            int i, j;
            for (i = 0; i < s.Length && char.IsWhiteSpace(s[i]); i++) { }
            for (j = s.Length - 1; j >= 0 && char.IsWhiteSpace(s[j]); j--) { }
            return (s[0..i], s[(j + 1)..^0]);
        }

        private (string, string) SetupDirectory(string lang)
        {
            var mainInkDir = Path.GetDirectoryName(mainFilePath).NormalizePath();
            var translationDir = Path.Combine(mainInkDir, $"translation_{lang}")
                .NormalizePath();
            if (!Directory.Exists(translationDir))
            {
                Directory.CreateDirectory(translationDir);
            }
            return (mainInkDir, translationDir);
        }
    }
}
