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
            .WalkTree(pathManager.GetPath("/one-line.ink"));

        var textNodes = textNodesFilter.TextNodesByLine;
        Assert.Contains("one-line.ink", textNodes.Keys);
        Assert.Contains(1, textNodes["one-line.ink"].Keys);
        Assert.AreEqual(1, textNodes["one-line.ink"][1].Count);
        Assert.AreEqual("Just one line.", textNodes["one-line.ink"][1][0].text);
    }

    /// <summary>
    /// Test that TextNodesFilter can parse multiple lines interspersed with other content.
    /// </summary>
    [Test]
    public void TestMultipleLinesInkFile()
    {
        TextNodesFilter textNodesFilter = new(false);

        var subpath = "multiple-lines.ink";

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

        var subpath = "string-variables.ink";

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
}
