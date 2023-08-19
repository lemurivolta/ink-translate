using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

using LemuRivolta.InkTranslate;
using LemuRivolta.InkTranslate.Editor;

using NUnit.Framework;

using UnityEditor;

using UnityEngine.TestTools;

public class TSVSerializationFormatHandlerTests
{
    private readonly InkPathManager pathManager = new("/TSVSerializationFormatHandler");

    [SetUp]
    public void SetUp()
    {
        LemuRivolta.InkTranslate.Editor.Progress.ClearPhases();
        InkVisitorParser.PhaseParse.Register();
        InkVisitorParser.PhaseFilter.Register();
    }

    [UnityTest]
    public IEnumerator TestTSVTranslationWorkflow()
    {
        // create the file in the asset database
        InkTranslateAsset.OtherSupportedLanguage l = new()
        {
            ODSFile = null,
            TSVFile = null,
            LanguageCode = "it-IT",
            XLIFFFile = null
        };
        var content = TSVSerializationFormatHandler.CreateDefaultTSVFile(
            "en-US", l);
        var tsvPath = pathManager.GetPath("/file.tsv", checkExistence: false);
        using (var fs = File.Create(tsvPath))
        {
            fs.Write(Encoding.UTF8.GetBytes(content));
            fs.Close();
        }

        string dbTsvPath = InkPathManager.DatabaseAssetRoot +
            pathManager.LocalSubpath +
            "/file.tsv";
        AssetDatabase.ImportAsset(dbTsvPath);
        AssetDatabase.Refresh();
        l.TSVFile = AssetDatabase.LoadAssetAtPath<DefaultAsset>(dbTsvPath);
        yield return null;

        try
        {
            string mainFilePath = pathManager.GetPath("/main.ink");

            var textNodesFilter = new TextNodesFilter(true);
            var tagNodesFilter = new TagNodesFilter("tnote:");
            var fileLines = new FileLines();

            new InkVisitorParser()
                .RegisterInkVisitor(textNodesFilter)
                .RegisterInkVisitor(tagNodesFilter)
                .RegisterInkVisitor(fileLines)
                .WalkTree(mainFilePath);

            var translationTable = new TranslationTable(
                mainFilePath,
                "en-US",
                fileLines.FileContents,
                textNodesFilter.TextNodesByLine,
                tagNodesFilter.Tags);
            var table = translationTable.Table;
            var line1Idx = table.FindIndex(e => e.Languages["en-US"] == "First line.");
            var line1Key = table[line1Idx].Key;
            var line2Idx = table.FindIndex(e => e.Languages["en-US"] == "Second line.");
            var line2Key = table[line2Idx].Key;
            TranslationTableEntry GetTranslationTableEntry(string key) =>
                table.First(e => e.Key == key);

            var tsvSerializer = TSVSerializationFormatHandler.Factory(
                "it-IT",
                "en-US",
                new List<InkTranslateAsset.OtherSupportedLanguage>()
                {
                    l
                });

            // read and write an empty TSV table
            tsvSerializer.PhaseRead.Register();
            tsvSerializer.PhaseWrite.Register();
            tsvSerializer.Initialize(translationTable.Table);
            tsvSerializer.Read();
            tsvSerializer.Write();

            // check that there are the default contents
            var tsvContent = ReadTSV(tsvPath);
            Assert.That(tsvContent.Count, Is.EqualTo(3));
            Assert.That(tsvContent[0], Is.EqualTo(new[] { "Key", "en-US", "it-IT" }));
            Assert.That(tsvContent[1], Is.EqualTo(new[] { line1Key, "First line.", "" }));
            Assert.That(tsvContent[2], Is.EqualTo(new[] { line2Key, "Second line.", "" }));

            // add some translations (with an error)
            tsvContent[1][2] = "Prima lineo.";
            tsvContent[2][2] = "Seconda linea.";
            WriteTSV(tsvPath, tsvContent);

            // import translations
            tsvSerializer.Read();
            Assert.That(GetTranslationTableEntry(line1Key).Languages["it-IT"],
                Is.EqualTo("Prima lineo."));
            Assert.That(GetTranslationTableEntry(line2Key).Languages["it-IT"],
                Is.EqualTo("Seconda linea."));

            // write them back
            tsvSerializer.Write();
            tsvContent = ReadTSV(tsvPath);
            Assert.That(tsvContent.Count, Is.EqualTo(3));
            Assert.That(tsvContent[0], Is.EqualTo(new[] { "Key", "en-US", "it-IT" }));
            Assert.That(tsvContent[1], Is.EqualTo(new[] { line1Key, "First line.", "Prima lineo." }));
            Assert.That(tsvContent[2], Is.EqualTo(new[] { line2Key, "Second line.", "Seconda linea." }));

            // fix a translation
            tsvContent[1][2] = "Prima linea.";
            WriteTSV(tsvPath, tsvContent);

            // import fixed translations
            tsvSerializer.Read();
            Assert.That(GetTranslationTableEntry(line1Key).Languages["it-IT"],
                Is.EqualTo("Prima linea."));
            Assert.That(GetTranslationTableEntry(line2Key).Languages["it-IT"],
                Is.EqualTo("Seconda linea."));

            // write them back again
            tsvSerializer.Write();
            tsvContent = ReadTSV(tsvPath);
            Assert.That(tsvContent.Count, Is.EqualTo(3));
            Assert.That(tsvContent[0], Is.EqualTo(new[] { "Key", "en-US", "it-IT" }));
            Assert.That(tsvContent[1], Is.EqualTo(new[] { line1Key, "First line.", "Prima linea." }));
            Assert.That(tsvContent[2], Is.EqualTo(new[] { line2Key, "Second line.", "Seconda linea." }));
        }
        finally
        {
            // cleanup the TSV asset
            AssetDatabase.DeleteAsset(dbTsvPath);
        }
        yield return null;
    }

    private List<string[]> ReadTSV(string tsvPath) =>
        File.ReadAllLines(tsvPath, Encoding.UTF8)
            .Select(line => line.Split('\t'))
            .ToList();

    private void WriteTSV(string tsvPath, List<string[]> content) =>
        File.WriteAllLines(
            tsvPath,
            content.Select(line => string.Join('\t', line)).ToArray());
}
