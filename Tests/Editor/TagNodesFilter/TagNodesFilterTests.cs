using LemuRivolta.InkTranslate.Editor;

using NUnit.Framework;

public class TagNodesFilterTests
{
    private readonly InkPathManager pathManager = new("/TagNodesFilter");

    [SetUp]
    public void SetUp()
    {
        Progress.ClearPhases();
        InkVisitorParser.PhaseParse.Register();
        InkVisitorParser.PhaseFilter.Register();
    }

    /// <summary>
    /// Finds no tags if there are none.
    /// </summary>
    [Test]
    public void NoTags()
    {
        TagNodesFilter tagNodesFilter = new("tnote:");

        new InkVisitorParser()
            .RegisterInkVisitor(tagNodesFilter)
            .WalkTree(pathManager.GetPath("/no-tags.inkfile"));

        var tags = tagNodesFilter.Tags;
        Assert.That(tags.Keys.Count, Is.EqualTo(0));
    }

    /// <summary>
    /// Check that it can find multiple tags.
    /// </summary>
    [Test]
    public void ManyTags()
    {
        TagNodesFilter tagNodesFilter = new("tnote:");

        new InkVisitorParser()
            .RegisterInkVisitor(tagNodesFilter)
            .WalkTree(pathManager.GetPath("/many-tags.inkfile"));

        var tags = tagNodesFilter.Tags;
        Assert.That(tags.Keys, Is.EquivalentTo(new[]
        {
            "many-tags.inkfile"
        }));
        var fileTags = tags["many-tags.inkfile"];
        Assert.That(fileTags.Keys, Is.EquivalentTo(new[]
        {
            2, 5
        }));
        Assert.That(fileTags[2].Count, Is.EqualTo(1));
        Assert.That(fileTags[2][0], Is.EqualTo("note1"));
        Assert.That(fileTags[5].Count, Is.EqualTo(1));
        Assert.That(fileTags[5][0], Is.EqualTo("note2 with spaces"));
    }
}
