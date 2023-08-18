using LemuRivolta.InkTranslate.Editor;

using NUnit.Framework;

public class FilenamesTrackerTests
{
    private readonly InkPathManager pathManager = new("/FilenamesTracker");

    [SetUp]
    public void SetUp()
    {
        Progress.ClearPhases();
        InkVisitorParser.PhaseParse.Register();
        InkVisitorParser.PhaseFilter.Register();
    }

    /// <summary>
    /// Test that we correctly track files that have at least some content.
    /// </summary>
    [Test]
    public void TestFilesWithContent()
    {
        FilenamesTracker filenamesTracker = new();

        new InkVisitorParser()
            .RegisterInkVisitor(filenamesTracker)
            .WalkTree(pathManager.GetPath("/test1-main.ink"));

        Assert.That(filenamesTracker.Filenames, Is.EquivalentTo(new[]
        {
            "test1-main.ink",
            "test1-included1.ink",
            "test1-included2.ink"
        }));
    }

    /// <summary>
    /// Test that we correctly track files that have no content expect for the include.
    /// </summary>
    [Test]
    public void TestFilesWithNoContent()
    {
        FilenamesTracker filenamesTracker = new();

        new InkVisitorParser()
            .RegisterInkVisitor(filenamesTracker)
            .WalkTree(pathManager.GetPath("/test2-main.ink"));

        Assert.That(filenamesTracker.Filenames, Is.EquivalentTo(new[]
        {
            "test2-main.ink",
            "test2-included1.ink",
            "test2-included2.ink"
        }));
    }
}
