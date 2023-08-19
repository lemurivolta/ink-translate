using System.Collections;
using System.IO;

using LemuRivolta.InkTranslate;
using LemuRivolta.InkTranslate.Editor;

using NUnit.Framework;

using UnityEngine.TestTools;

public class SynchronizerTests : TestsBase
{
    private const string fillTsvPath = "/FillTSV/Ink Translate_it-IT.tsv";
    private const string fillFromTsvPath = "/FillFromTSV/Ink Translate_it-IT.tsv";

    public SynchronizerTests() : base("/Synchronizer", pathsToBackup: new string[]
    {
        fillTsvPath,
        fillFromTsvPath,
        "/FillFromTSV/translation_it-IT/main.ink"
    })
    { }

    [UnityTest]
    public IEnumerator FillTsvTest()
    {
        var inkTranslateAsset = pathManager.GetAsset<InkTranslateAsset>(
            "/FillTSV/Ink Translate.asset");
        Assert.That(inkTranslateAsset, Is.Not.Null);
        var synchronizer = new Synchronizer(inkTranslateAsset);
        synchronizer.Synchronize();
        yield return null;

        var tsvContents = File.ReadAllLines(pathManager.GetPath(fillTsvPath));
        Assert.That(tsvContents[0], Is.EqualTo("Key\ten-US\tit-IT"));
        Assert.That(tsvContents[1].Split('\t')[1..], Is.EqualTo(new[]
        {
            "First line.", ""
        }));
        Assert.That(tsvContents[2].Split('\t')[1..], Is.EqualTo(new[]
        {
            "Second line.", ""
        }));

        var translatedInkContents = File.ReadAllText(
            pathManager.GetPath(
                "/FillTSV/translation_it-IT/main.ink", checkFileExistence: false));
        Assert.That(
            translatedInkContents.Trim().Replace("\r\n", "\n"),
            Is.EqualTo("First line.\nSecond line."));
    }

    [UnityTest]
    public IEnumerator FillFromTsvTest()
    {
        var inkTranslateAsset = pathManager.GetAsset<InkTranslateAsset>(
            "/FillFromTSV/Ink Translate.asset");
        Assert.That(inkTranslateAsset, Is.Not.Null);
        var synchronizer = new Synchronizer(inkTranslateAsset);
        synchronizer.Synchronize();
        yield return null;

        var tsvContents = File.ReadAllLines(pathManager.GetPath(fillFromTsvPath));
        Assert.That(tsvContents[0], Is.EqualTo("Key\ten-US\tit-IT"));
        Assert.That(tsvContents[1].Split('\t')[1..], Is.EqualTo(new[]
        {
            "First line.", "Prima linea."
        }));
        Assert.That(tsvContents[2].Split('\t')[1..], Is.EqualTo(new[]
        {
            "Second line.", "Seconda linea."
        }));

        var translatedInkContents = File.ReadAllText(
            pathManager.GetPath(
                "/FillFromTSV/translation_it-IT/main.ink", checkFileExistence: false));
        Assert.That(
            translatedInkContents.Trim().Replace("\r\n", "\n"),
            Is.EqualTo("Prima linea.\nSeconda linea."));
    }
}
