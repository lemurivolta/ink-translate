using System.Collections.Generic;
using System.Linq;

using LemuRivolta.InkTranslate.Editor;

using NUnit.Framework;

public class TranslationTableTests
{
    private readonly InkPathManager pathManager = new("/TranslationTable");

    [SetUp]
    public void SetUp()
    {
        Progress.ClearPhases();
        InkVisitorParser.PhaseParse.Register();
        InkVisitorParser.PhaseFilter.Register();
    }

    private TranslationTable CreateTestData(string subpath)
    {
        string mainFilePath = pathManager.GetPath(subpath);

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

        return translationTable;
    }

    /// <summary>
    /// A comparer to check two translation table entries are the same, except for the
    /// key.
    /// </summary>
    private class TranslationTableEntryNoKeyComparer :
        IEqualityComparer<TranslationTableEntry>
    {
        public bool Equals(TranslationTableEntry x, TranslationTableEntry y) =>
            Enumerable.SequenceEqual(x.Languages.Keys, y.Languages.Keys) &&
            Enumerable.SequenceEqual(x.Languages.Values, y.Languages.Values) &&
            x.Notes == y.Notes &&
            x.Filename == y.Filename &&
            x.LineNumber == y.LineNumber &&
            x.StartChar == y.StartChar &&
            x.EndChar == y.EndChar;

        public int GetHashCode(TranslationTableEntry obj) =>
            obj.GetHashCode();
    }

    private readonly IEqualityComparer<TranslationTableEntry> comparer =
        new TranslationTableEntryNoKeyComparer();

    [Test]
    public void BasicTranslationTable()
    {
        var tt = CreateTestData("/main.ink");

        var table = tt.Table;

        Assert.That(table.Count, Is.EqualTo(5));
        Assert.That(table.Select(e => e.Key), Is.Unique);
        Assert.That(table, Is.EqualTo(new List<TranslationTableEntry>() {
            new()
            {
                Key = "",
                Filename = "main.ink",
                LineNumber = 2,
                StartChar = 1,
                EndChar = 11,
                Languages = new()
                {
                    { "en-US", "First row." }
                },
                Notes = "note1"
            },
            new()
            {
                Key = "",
                Filename = "main.ink",
                LineNumber = 4,
                StartChar = 1,
                EndChar = 12,
                Languages = new()
                {
                    { "en-US", "Second row." }
                },
                Notes = "note2"
            },
            new()
            {
                Key = "",
                Filename = "main.ink",
                LineNumber = 6,
                StartChar = 1,
                EndChar = 11,
                Languages = new()
                {
                    { "en-US", "Third row." }
                },
                Notes = null
            },
            new()
            {
                Key = "",
                Filename = "main.ink",
                LineNumber = 7,
                StartChar = 1,
                EndChar = 12,
                Languages = new()
                {
                    { "en-US", "Fourth row." }
                },
                Notes = "note3"
            },
            new()
            {
                Key = "",
                Filename = "main.ink",
                LineNumber = 10,
                StartChar = 1,
                EndChar = 11,
                Languages = new()
                {
                    { "en-US", "Fifth row." }
                },
                Notes = "note4"
            }
        }).Using(comparer));
    }
}
