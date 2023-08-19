using LemuRivolta.InkTranslate.Editor;

using NUnit.Framework;

using UnityEditor;

using UnityEngine;

public class InkPathManager
{
    public const string DatabaseAssetRoot =
        "Packages/it.lemurivolta.ink-translate/Tests/Editor";

    public readonly string LocalSubpath;

    public InkPathManager(string localSubpath)
    {
        this.LocalSubpath = localSubpath;
    }

    public string GetPath(string subpath, bool checkFileExistence = true)
    {
        if (checkFileExistence)
        {
            var path = GetAsset<Object>(subpath).GetPath().NormalizePath();
            Assert.IsTrue(System.IO.File.Exists(path), $"File {path} (from subpath={subpath}) does not exist");
            return path;
        }
        else
        {
            var path = GetAsset<Object>("").GetPath().NormalizePath();
            return path + subpath.Replace('/', System.IO.Path.DirectorySeparatorChar);
        }
    }

    public T GetAsset<T>(string subpath) where T: Object =>
        AssetDatabase.LoadAssetAtPath<T>(
            DatabaseAssetRoot + LocalSubpath + subpath);
}