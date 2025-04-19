using LemuRivolta.InkTranslate.Editor;

using NUnit.Framework;

public class TextNodesFilterTests
{
    private readonly InkPathManager pathManager = new("/TextNodesFilter");

    [SetUp]
    public void SetUp()
    {
        Progress.ClearPhases();
        InkVisitorParser.PhaseParse.Register();
        InkVisitorParser.PhaseFilter.Register();
    }

    /// <summary>
    /// Test that TextNodesFilter can find a line containing a single text node.
    /// </summary>
    [Test]
    public void TestOneLineInkFile()
    {
        TextNodesFilter textNodesFilter = new(false);

        new InkVisitorParser()
            .RegisterInkVisitor(textNodesFilter)
            .WalkTree(pathManager.GetPath("/one-line.inkfile"));

        var textNodes = textNodesFilter.TextNodesByLine;
        Assert.Contains("one-line.inkfile", textNodes.Keys);
        Assert.Contains(1, textNodes["one-line.inkfile"].Keys);
        Assert.AreEqual(1, textNodes["one-line.inkfile"][1].Count);
        Assert.AreEqual("Just one line.", textNodes["one-line.inkfile"][1][0].text);
    }

    [Test]
    public void CanNormalizePaths()
    {
        TextNodesFilter textNodesFilter = new(false);

        new InkVisitorParser()
            .RegisterInkVisitor(textNodesFilter)
            .WalkTree(pathManager.GetPath("/normalize-root.inkfile"));

        var textNodes = textNodesFilter.TextNodesByLine;
        Assert.Contains("subdir/normalize-child.inkfile", textNodes.Keys);
        Assert.Contains("subdir/normalize-child-2.inkfile", textNodes.Keys);

        var child1 = textNodes["subdir/normalize-child.inkfile"];
        Assert.Contains(1, child1.Keys);
        Assert.AreEqual(1, child1[1].Count);
        Assert.AreEqual("Just one line.", child1[1][0].text);

        var child2 = textNodes["subdir/normalize-child-2.inkfile"];
        Assert.Contains(1, child2.Keys);
        Assert.AreEqual(1, child2[1].Count);
        Assert.AreEqual("Another line.", child2[1][0].text);
    }

    /// <summary>
    /// Test that TextNodesFilter can parse multiple lines interspersed with other content.
    /// </summary>
    [Test]
    public void TestMultipleLinesInkFile()
    {
        TextNodesFilter textNodesFilter = new(false);

        var subpath = "multiple-lines.inkfile";

        new InkVisitorParser()
            .RegisterInkVisitor(textNodesFilter)
            .WalkTree(pathManager.GetPath("/" + subpath));

        var textNodes = textNodesFilter.TextNodesByLine;
        Assert.Contains(subpath, textNodes.Keys);
        var fileEntry = textNodes[subpath];

        Assert.Contains(3, fileEntry.Keys);
        var firstLine = fileEntry[3];
        Assert.Contains(9, fileEntry.Keys);
        var secondLine = fileEntry[9];
        Assert.Contains(10, fileEntry.Keys);
        var thirdLine = fileEntry[10];

        Assert.AreEqual(1, firstLine.Count);
        Assert.AreEqual("The first line.", firstLine[0].text);
        Assert.AreEqual(5, secondLine.Count);
        Assert.AreEqual("The second line ", secondLine[0].text);
        Assert.AreEqual("one", secondLine[1].text);
        Assert.AreEqual("two", secondLine[2].text);
        Assert.AreEqual("three", secondLine[3].text);
        Assert.AreEqual(".", secondLine[4].text);
        Assert.AreEqual(1, thirdLine.Count);
        Assert.AreEqual("The third line.", thirdLine[0].text);
    }

    /// <summary>
    /// Test that TextNodesFilter honor the skipStringVariables flag.
    /// </summary>
    [Test, Combinatorial]
    public void TestSkipStringVariables([Values(true, false)] bool skipStringVariables)
    {
        TextNodesFilter textNodesFilter = new(skipStringVariables);

        var subpath = "string-variables.inkfile";

        new InkVisitorParser()
            .RegisterInkVisitor(textNodesFilter)
            .WalkTree(pathManager.GetPath("/" + subpath));

        var textNodes = textNodesFilter.TextNodesByLine;
        Assert.Contains(subpath, textNodes.Keys);
        var fileEntry = textNodes[subpath];

        Assert.That(fileEntry.Count, Is.EqualTo(
            skipStringVariables ? 2 : 3));
        Assert.Contains(1, fileEntry.Keys);
        Assert.That(fileEntry[1][0].text, Is.EqualTo("The first line."));
        Assert.Contains(5, fileEntry.Keys);
        Assert.That(fileEntry[5][0].text, Is.EqualTo("The last line."));
        if (!skipStringVariables)
        {
            Assert.Contains(3, fileEntry.Keys);
            var varEntry = fileEntry[3][0];
            Assert.That(varEntry.text, Is.EqualTo("content"));
            Assert.That(varEntry.debugMetadata.startCharacterNumber,
                Is.EqualTo(10));
        }
    }

    [Test]
    public void TestMultipleFiles()
    {
        TextNodesFilter textNodesFilter = new(false);

        var subpath = "multiple-files-main.inkfile";

        new InkVisitorParser()
            .RegisterInkVisitor(textNodesFilter)
            .WalkTree(pathManager.GetPath("/" + subpath));

        var textNodesByLine = textNodesFilter.TextNodesByLine;
        Assert.That(textNodesByLine.Keys.Count, Is.EqualTo(2));
        Assert.That(textNodesByLine.Keys, Is.EquivalentTo(new string[] {
            "multiple-files-main.inkfile",
            "multiple-files-included.inkfile"
        }));
        var mainLines = textNodesByLine["multiple-files-main.inkfile"];
        var includedLines = textNodesByLine["multiple-files-included.inkfile"];

        Assert.That(mainLines.Keys, Is.EquivalentTo(new int[] { 1, 5 }));
        var line1 = mainLines[1];
        var line3 = mainLines[5];
        Assert.That(includedLines.Keys, Is.EquivalentTo(new int[] { 1 }));
        var line2 = includedLines[1];

        Assert.That(line1.Count, Is.EqualTo(1));
        Assert.That(line1[0].text, Is.EqualTo("first line."));
        Assert.That(line2.Count, Is.EqualTo(1));
        Assert.That(line2[0].text, Is.EqualTo("second line."));
        Assert.That(line3.Count, Is.EqualTo(1));
        Assert.That(line3[0].text, Is.EqualTo("third line."));
    }
}
