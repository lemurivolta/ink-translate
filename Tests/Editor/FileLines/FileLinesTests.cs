using LemuRivolta.InkTranslate.Editor;

using NUnit.Framework;

public class FileLinesTests
{
    private readonly InkPathManager pathManager = new("/FileLines");

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
        FileLines fileLines = new();

        new InkVisitorParser()
            .RegisterInkVisitor(fileLines)
            .WalkTree(pathManager.GetPath("/test1-main.inkfile"));

        Assert.That(fileLines.Filenames, Is.EquivalentTo(new[]
        {
            "test1-main.inkfile",
            "test1-included1.inkfile",
            "test1-included2.inkfile"
        }));

        Assert.That(fileLines.FileContents["test1-main.inkfile"], Is.EqualTo(new string[]
        {
            "line main before",
            "",
            "INCLUDE test1-included1.inkfile",
            "",
            "line main."
        }));
    }

    /// <summary>
    /// Test that we correctly track files that have no content expect for the include.
    /// </summary>
    [Test]
    public void TestFilesWithNoContent()
    {
        FileLines fileLines = new();

        new InkVisitorParser()
            .RegisterInkVisitor(fileLines)
            .WalkTree(pathManager.GetPath("/test2-main.inkfile"));

        Assert.That(fileLines.Filenames, Is.EquivalentTo(new[]
        {
            "test2-main.inkfile",
            "test2-included1.inkfile",
            "test2-included2.inkfile"
        }));
    }

    [Test]
    public void TestFilesWithSubdirectories()
    {
        FileLines fileLines = new();

        new InkVisitorParser()
            .RegisterInkVisitor(fileLines)
            .WalkTree(pathManager.GetPath("/test3-main.inkfile"));

        Assert.That(fileLines.Filenames, Is.EquivalentTo(new[]
        {
            "test3-main.inkfile",
            "included/subincluded/subsubincluded.inkfile"
        }));

        Assert.That(fileLines.FileContents["included/subincluded/subsubincluded.inkfile"],
            Is.EqualTo(new string[]
            {
                "subincluded."
            }));

    }
}
