using LemuRivolta.InkTranslate.Editor;

using NUnit.Framework;

using UnityEditor;

public class InkPathManager
{
    private const string databaseAssetRoot =
        "Packages/it.lemurivolta.ink-translate/Tests/Editor";

    private readonly string localSubpath;

    public InkPathManager(string localSubpath)
    {
        this.localSubpath = localSubpath;
    }

    public string GetPath(string subpath)
    {
        var path = AssetDatabase
            .LoadAssetAtPath<DefaultAsset>(databaseAssetRoot + localSubpath + subpath)
            .GetPath()
            .NormalizePath();
        Assert.IsTrue(System.IO.File.Exists(path), $"File {path} (from subpath={subpath}) does not exist");
        return path;
    }

}