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
            var mainFilePath = pathManager.GetPath("/main.ink");
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
                GetNormalizedContents("/translation_it-IT/main.ink"),
                Is.EqualTo(@"Prima linea.

INCLUDE included/included.ink
INCLUDE included/subincluded1/subincluded2/subincluded.ink"));
            Assert.That(
                GetNormalizedContents("/translation_it-IT/included/included.ink"),
                Is.EqualTo("Seconda linea."));
            Assert.That(
                GetNormalizedContents("/translation_it-IT/included/subincluded1/subincluded2/subincluded.ink"),
                Is.EqualTo("Terza linea."));
        } finally
        {
            // cleanup generated files and directories
            var currentFiles = Directory.EnumerateFiles(
                rootPath, "*", SearchOption.AllDirectories).ToHashSet();
            var currentDirectories = Directory.EnumerateDirectories(
                rootPath, "*", SearchOption.AllDirectories).ToHashSet();
            currentFiles.ExceptWith(startingFiles);
            currentDirectories.ExceptWith(startingDirectories);
            UnityEngine.Debug.Log("ok");
        }
    }

    private string GetNormalizedContents(string filePath) =>
        File.ReadAllText(pathManager.GetPath(filePath))
            .Replace("\r\n", "\n")
            .Replace("\n", "\r\n")
            .Trim();
}
