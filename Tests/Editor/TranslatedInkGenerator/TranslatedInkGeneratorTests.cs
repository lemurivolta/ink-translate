using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;

using LemuRivolta.InkTranslate.Editor;

using NUnit.Framework;

using UnityEngine.TestTools;

using static LemuRivolta.InkTranslate.InkTranslateAsset;

public class TranslatedInkGeneratorTests
{
    private readonly InkPathManager pathManager = new("/TranslatedInkGenerator");

    [SetUp]
    public void DisableInkPostProcessor()
    {
        Ink.UnityIntegration.InkPostProcessor.disabled = true;
    }

    [TearDown]
    public void EnableInkPostProcessor()
    {
        Ink.UnityIntegration.InkPostProcessor.disabled = false;
    }

    [UnityTest]
    public IEnumerator TestTranslatedInkGenerator()
    {
        // get the list of files we have right now in the directory
        var rootPath = pathManager.GetPath("", checkFileExistence: false);
        var startingFiles = Directory.EnumerateFiles(
            rootPath, "*", SearchOption.AllDirectories).ToHashSet();
        var startingDirectories = Directory.EnumerateDirectories(
            rootPath, "*", SearchOption.AllDirectories).ToHashSet();

        try
        {
            // create the minimum for the translation generator
            Progress.ClearPhases();
            InkVisitorParser.PhaseParse.Register();
            InkVisitorParser.PhaseFilter.Register();
            TranslationTable.Phase.Register();
            TranslatedInkGenerator.Phase.Register();
            var mainFilePath = pathManager.GetPath("/main.inkfile");
            var textNodesFilter = new TextNodesFilter(true);
            var fileLines = new FileLines();
            new InkVisitorParser()
                .RegisterInkVisitor(fileLines)
                .RegisterInkVisitor(textNodesFilter)
                .WalkTree(mainFilePath);
            var translationTable = new TranslationTable(mainFilePath,
                "en-US",
                fileLines.FileContents,
                textNodesFilter.TextNodesByLine,
                new());
            var table = translationTable.Table;
            void SetTextOf(string englishLine, string italianLine)
            {
                var langs = table.First(e => e.Languages["en-US"] == englishLine).Languages;
                langs["it-IT"] = italianLine;
            }
            SetTextOf("First line.", "Prima linea.");
            SetTextOf("Second line.", "Seconda linea.");
            SetTextOf("Third line.", "Terza linea.");
            List<OtherSupportedLanguage> translationLanguages = new()
        {
            new OtherSupportedLanguage {
                LanguageCode = "it-IT",
            }
        };

            var translationGenerator = new TranslatedInkGenerator(
                fileLines.Filenames,
                table,
                mainFilePath,
                translationLanguages,
                fileLines.FileContents
            );
            translationGenerator.GenerateTranslations();
            yield return null;

            // check that the files have been correctly created
            Assert.That(
                GetNormalizedContents("/translation_it-IT/main.inkfile"),
                Is.EqualTo(@"Prima linea.

INCLUDE included/included.inkfile
INCLUDE included/subincluded1/subincluded2/subincluded.inkfile"));
            Assert.That(
                GetNormalizedContents("/translation_it-IT/included/included.inkfile"),
                Is.EqualTo("Seconda linea."));
            Assert.That(
                GetNormalizedContents("/translation_it-IT/included/subincluded1/subincluded2/subincluded.inkfile"),
                Is.EqualTo("Terza linea."));
        }
        finally
        {
            // cleanup generated files and directories
            var currentFiles = Directory.EnumerateFiles(
                rootPath, "*", SearchOption.AllDirectories).ToHashSet();
            var currentDirectories = Directory.EnumerateDirectories(
                rootPath, "*", SearchOption.AllDirectories).ToHashSet();
            currentFiles.ExceptWith(startingFiles);
            currentDirectories.ExceptWith(startingDirectories);
            foreach (var file in currentFiles)
            {
                File.Delete(file);
            }
            foreach (var directory in currentDirectories.OrderByDescending(d => d.Length))
            {
                Directory.Delete(directory);
            }
        }
        yield return null;
    }

    private string GetNormalizedContents(string filePath) =>
        File.ReadAllText(pathManager.GetPath(filePath))
            .Replace("\r\n", "\n")
            .Replace("\n", "\r\n")
            .Trim();
}
