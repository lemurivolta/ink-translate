using System;
using System.Collections.Generic;

using Ink.Parsed;

using Ink.Runtime;

using UnityEditor;

using UnityEngine.Assertions;

namespace LemuRivolta.InkTranslate.Editor
{
    public static class Helpers
    {
        /// <summary>
        /// Produce a normalize and unique version of a path.
        /// </summary>
        /// <param name="path">the path to normalize</param>
        /// <returns>The normalized path.</returns>
        public static string NormalizePath(this string path) =>
            System.IO.Path.GetFullPath(new Uri(path).LocalPath)
                .TrimEnd(
                    System.IO.Path.DirectorySeparatorChar,
                    System.IO.Path.AltDirectorySeparatorChar);

        /// <summary>
        /// Resolve the path of an included ink file relative to the main project file.
        /// </summary>
        /// <param name="includeName">The path of the included file.</param>
        /// <param name="mainFilePath">The full path of the main project file.</param>
        /// <returns>The full, normalized path of the included ink file.</returns>
        public static string ResolveInkFilename(
            this string includeName,
            string mainFilePath) =>
            System.IO.Path.IsPathFullyQualified(includeName) ?
                includeName :
                System.IO.Path.Combine(
                    System.IO.Path.GetDirectoryName(mainFilePath),
                    includeName
                ).NormalizePath();

        /// <summary>
        /// Make the path of an ink file relative to the main file. If the path is not
        /// fully qualified, then it's not changed.
        /// E.g.:
        /// <code>
        /// var includeName =
        ///     "c:\\chapter1\\included.ink";
        /// var relativeName = includeName
        ///     .MakeInkPathRelative("c:\\main.ink")
        /// relativeName == "chapter1\\included.ink"
        /// </code>
        /// and
        /// <code>
        /// var includeName =
        ///     "chapter1\\included.ink";
        /// var relativeName = includeName
        ///     .MakeInkPathRelative("c:\\main.ink")
        /// relativeName == "chapter1\\included.ink"
        /// </code>
        /// </summary>
        /// <param name="includeName"></param>
        /// <param name="mainFilePath"></param>
        /// <returns></returns>
        public static string MakeInkPathRelative(
            this string includeName,
            string mainFilePath)
        {
            var mainFileDirectory = System.IO.Path.GetDirectoryName(mainFilePath);
            if (System.IO.Path.IsPathFullyQualified(includeName))
            {
                Assert.IsTrue(includeName.StartsWith(mainFileDirectory));
                return includeName[(mainFileDirectory.Length + 1)..];
            }
            else
            {
                return includeName;
            }
        }

        private class DebugMetadataStartComparer : IComparer<DebugMetadata>
        {
            public int Compare(DebugMetadata x, DebugMetadata y) =>
                x.startLineNumber != y.startLineNumber ?
                    x.startLineNumber.CompareTo(y.startLineNumber) :
                    x.startCharacterNumber.CompareTo(y.startCharacterNumber);
        }

        public static readonly IComparer<DebugMetadata> StartPositionComparer =
            new DebugMetadataStartComparer();

        /// <summary>
        /// Compute the _precise_ debug metadata for the content, fixing some
        /// inconsistencies.
        /// </summary>
        /// <param name="o">The object to consider.</param>
        /// <returns>The precise debug metadata.</returns>
        public static DebugMetadata Pdm(this Ink.Parsed.Object o)
        {
            if (o == null)
            {
                throw new ArgumentNullException(nameof(o));
            }
            var sourceDM = o.debugMetadata;
            if (o is Weave)
            {
                // debug metadata, by default, includes a way bigger range than the
                // actual content of a contentlist
                var startLineNumber = sourceDM?.endLineNumber ?? 0;
                var startCharNumber = sourceDM?.endCharacterNumber ?? 0;
                var endLineNumber = sourceDM?.startLineNumber ?? int.MaxValue;
                var endCharNumber = sourceDM?.startCharacterNumber ?? int.MaxValue;
                var filename = sourceDM?.fileName;
                foreach (var c in o.content)
                {
                    var cDM = c.Pdm();
                    if (cDM == null) { continue; }
                    filename ??= cDM.fileName;
                    if (cDM.startLineNumber < startLineNumber ||
                        (cDM.startLineNumber == startLineNumber && cDM.startCharacterNumber < startCharNumber))
                    {
                        startLineNumber = cDM.startLineNumber;
                        startCharNumber = cDM.startCharacterNumber;
                    }
                    if (cDM.endLineNumber > endLineNumber ||
                        (cDM.endLineNumber == endLineNumber && cDM.endCharacterNumber > endCharNumber))
                    {
                        endLineNumber = cDM.endLineNumber;
                        endCharNumber = cDM.endCharacterNumber;
                    }
                }
                var d = new DebugMetadata
                {
                    fileName = filename,
                    startLineNumber = startLineNumber,
                    startCharacterNumber = startCharNumber,
                    endLineNumber = endLineNumber,
                    endCharacterNumber = endCharNumber,
                };
                return d;
            }
            else
            {
                return sourceDM;
            }
        }

        public static string GetPath(this UnityEngine.Object assetObject)
        {
            var fileAssetPath = AssetDatabase.GetAssetPath(
                assetObject);
            var completePath = System.IO.Path.Combine(
                UnityEngine.Application.dataPath, "..", fileAssetPath);
            return completePath;
        }

        public static TValue GetValueOrCreateDefault<TKey, TValue>(
            this IDictionary<TKey, TValue> dictionary,
            TKey key,
            Func<TValue> defaultValueGetter)
        {
            if (!dictionary.ContainsKey(key))
            {
                dictionary[key] = defaultValueGetter();
            }
            return dictionary[key];
        }

        /// <summary>
        /// Normalize the newslines in the file to just "\n".
        /// </summary>
        /// <param name="s">The string to normalize.</param>
        /// <returns>The string with normalized newlines.</returns>
        public static string NormalizeNewlines(this string s) =>
            s.Replace("\r\n", "\n");
    }
}
