using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

using NUnit.Framework;

public class TestsBase
{
    protected readonly InkPathManager pathManager;

    private readonly bool cleanupExtraFiles;

    private readonly string[] pathsToBackup = null;

    public TestsBase(string localSubPath,
        bool cleanupExtraFiles = true,
        string[] pathsToBackup = null)
    {
        pathsToBackup ??= Array.Empty<string>();
        foreach (var path in pathsToBackup)
        {
            Assert.IsFalse(path.EndsWith(".backup"));
        }
        pathManager = new(localSubPath);
        this.cleanupExtraFiles = cleanupExtraFiles;
        this.pathsToBackup = pathsToBackup;
    }

    [SetUp]
    public void DisableInkPostProcessor()
    {
        Ink.UnityIntegration.InkPostProcessor.disabled = true;
    }

    [TearDown]
    public void EnableInkPostProcessor()
    {
        Ink.UnityIntegration.InkPostProcessor.disabled = false;
    }

    private HashSet<string> startingFiles;
    private HashSet<string> startingDirectories;

    [SetUp]
    public void SaveAlreadyExistingFiles()
    {
        if (cleanupExtraFiles)
        {
            // get the list of files we have right now in the directory
            var rootPath = pathManager.GetPath("", checkFileExistence: false);
            startingFiles = Directory.EnumerateFiles(
                rootPath, "*", SearchOption.AllDirectories).ToHashSet();
            startingDirectories = Directory.EnumerateDirectories(
                rootPath, "*", SearchOption.AllDirectories).ToHashSet();
        }
    }

    [TearDown]
    public void RemoveFilesThatDidntExist()
    {
        if (cleanupExtraFiles)
        {
            // cleanup generated files and directories
            var rootPath = pathManager.GetPath("", checkFileExistence: false);
            var currentFiles = Directory.EnumerateFiles(
                rootPath, "*", SearchOption.AllDirectories).ToHashSet();
            var currentDirectories = Directory.EnumerateDirectories(
                rootPath, "*", SearchOption.AllDirectories).ToHashSet();
            currentFiles.ExceptWith(startingFiles);
            currentDirectories.ExceptWith(startingDirectories);
            foreach (var file in currentFiles)
            {
                File.Delete(file);
            }
            foreach (var directory in currentDirectories.OrderByDescending(d => d.Length))
            {
                Directory.Delete(directory);
            }
        }
    }

    [SetUp]
    public void BackupFiles()
    {
        foreach (var file in pathsToBackup)
        {
            var backupPath = file + ".backup";
            string backupFullFilePath = pathManager.GetPath(
                backupPath, checkFileExistence: false);
            string sourceFullFilePath = pathManager.GetPath(file);
            File.Copy(sourceFullFilePath, backupFullFilePath);
        }
    }

    [TearDown]
    public void RestoreBackups()
    {
        foreach (var file in pathsToBackup)
        {
            var backupPath = file + ".backup";
            string backupFullFilePath = pathManager.GetPath(
                backupPath, checkFileExistence: false);
            File.Copy(backupFullFilePath, pathManager.GetPath(file), true);
            File.Delete(backupFullFilePath);
        }
    }
}
