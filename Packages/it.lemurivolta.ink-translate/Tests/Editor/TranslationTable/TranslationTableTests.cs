using System;
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

    private TranslationTable CreateTestData(string subpath,
        out Func<TranslationTableEntry, string> tt)
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

        string GetText(TranslationTableEntry entry) {
            var line = fileLines.FileContents[entry.Filename][entry.LineNumber - 1];
            var part = line[(entry.StartChar - 1)..(entry.EndChar - 1)];
            return part;
        }

        tt = GetText;

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
        var tt = CreateTestData("/main.inkfile", out _);

        var table = tt.Table;

        Assert.That(table.Count, Is.EqualTo(5));
        Assert.That(table.Select(e => e.Key), Is.Unique);
        Assert.That(table, Is.EqualTo(new List<TranslationTableEntry>() {
            new()
            {
                Key = "",
                Filename = "main.inkfile",
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
                Filename = "main.inkfile",
                LineNumber = 4,
                StartChar = 3,
                EndChar = 14,
                Languages = new()
                {
                    { "en-US", "Second row." }
                },
                Notes = "note2"
            },
            new()
            {
                Key = "",
                Filename = "main.inkfile",
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
                Filename = "main.inkfile",
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
                Filename = "main.inkfile",
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

    [Test]
    public void Sequences()
    {
        var tt = CreateTestData("/sequences.inkfile", out var Get);

        var table = tt.Table;

        Assert.That(table.Count, Is.EqualTo(27));
        Assert.That(Get(table[0]),
            Is.EqualTo("{Choice 1 with content|Choice 2 with content} after."));
        Assert.That(Get(table[1]),
            Is.EqualTo("Choice {1 with content before.|2 with content before.}"));
        Assert.That(Get(table[2]),
            Is.EqualTo("Choice {1 with content|2 with content} before and after."));
        Assert.That(Get(table[3]),
            Is.EqualTo("Choice 1 with nothing|Choice 2 with nothing"));
        Assert.That(Get(table[4]),
            Is.EqualTo("{&Choice 1 with content|Choice 2 with content} after."));
        Assert.That(Get(table[5]),
            Is.EqualTo("Choice {&1 with content before.|2 with content before.}"));
        Assert.That(Get(table[6]),
            Is.EqualTo("Choice {&1 with content|2 with content} before and after."));
        Assert.That(Get(table[7]),
            Is.EqualTo("Choice 1 with nothing|Choice 2 with nothing"));
        Assert.That(Get(table[8]),
            Is.EqualTo("{!Choice 1 with content|Choice 2 with content} after."));
        Assert.That(Get(table[9]),
            Is.EqualTo("Choice {!1 with content \\{ before.|2 with content before.}"));
        Assert.That(Get(table[10]),
            Is.EqualTo("Choice {!1 with content|2 with content} before and after."));
        Assert.That(Get(table[11]),
            Is.EqualTo("Choice 1 with nothing|Choice 2 with nothing"));
        Assert.That(Get(table[12]),
            Is.EqualTo("{~Choice 1 with content|Choice 2 with content} after."));
        Assert.That(Get(table[13]),
            Is.EqualTo("Choice {~1 with content before.|2 with content before.}"));
        Assert.That(Get(table[14]),
            Is.EqualTo("Choice {~1 with content|2 with content} before and after."));
        Assert.That(Get(table[15]),
            Is.EqualTo("Choice 1 with nothing|Choice 2 with nothing"));
        Assert.That(Get(table[16]),
            Is.EqualTo("{|||Final choice}."));
        Assert.That(Get(table[17]),
            Is.EqualTo("{Starting choice|||}."));
        Assert.That(Get(table[18]),
            Is.EqualTo("{&|||Final choice}."));
        Assert.That(Get(table[19]),
            Is.EqualTo("{&Starting choice|||}."));
        Assert.That(Get(table[20]),
            Is.EqualTo("{!|||Final choice}."));
        Assert.That(Get(table[21]),
            Is.EqualTo("{!Starting choice|||}."));
        Assert.That(Get(table[22]),
            Is.EqualTo("{~|||Final choice}."));
        Assert.That(Get(table[23]),
            Is.EqualTo("{~Starting choice|||}."));
        Assert.That(Get(table[24]),
            Is.EqualTo("{!Nested|Nesteeeeed} Choice"));
        Assert.That(Get(table[25]),
            Is.EqualTo("Nested{!Choice|Choiceeeee}"));
        Assert.That(Get(table[26]),
            Is.EqualTo("I {waited.|waited some more.|snoozed.|woke up and waited more.|gave up and left. -> leave_post_office}"));
    }
}
