using System.Collections.Generic;

using Ink.Parsed;

using UnityEngine.Assertions;

namespace LemuRivolta.InkTranslate.Editor
{
    /// <summary>
    /// An ink visitor whose purpose is to extract all text nodes, and organize them
    /// by file and line.
    /// </summary>
    public class TextNodesFilter : InkVisitor
    {
        private FileDict<List<Text>> textNodesByLine;

        /// <summary>
        /// All the text nodes, organized by (main-file relative) path and line.
        /// This property is valid only after a walk has been performed.
        /// </summary>
        public FileDict<List<Text>> TextNodesByLine => textNodesByLine;

        /// <summary>
        /// Whether we're inside a tag: in that case, ignore text nodes.
        /// </summary>
        private bool insideTag;

        /// <summary>
        /// Path to the main file.
        /// </summary>
        private string mainFilePath;

        /// <summary>
        /// Whether string variables should be skipped.
        /// </summary>
        private readonly bool skipStringVariables;

        /// <summary>
        /// Create a new TextNodesFilter.
        /// </summary>
        /// <param name="skipStringVariables">Whether string variables should be skipped.</param>
        public TextNodesFilter(bool skipStringVariables)
        {
            this.skipStringVariables = skipStringVariables;
        }

        public override void BeginParsing(string mainFilePath)
        {
            this.mainFilePath = mainFilePath;
            textNodesByLine = new();
            insideTag = false;
        }

        public override void VisitObject(Object o)
        {
            if (o is Tag tag)
            {
                insideTag = tag.isStart;
            }
            if (insideTag)
            {
                return;
            }

            HandleText(o);
        }

        private void HandleText(Object o)
        {
            // only care about text nodes...
            if (o is Text t &&
                // ...excluding newlines and/or empty text nodes, ...
                t.text.Trim().Length != 0 &&
                // ... and excluding string variables, if requested
                (!skipStringVariables || t.parent is not StringExpression))
            {
                var d = t.debugMetadata;
                Assert.AreEqual(d.startLineNumber, d.endLineNumber,
                    "Unsupported multiline text node"); // should never happen, but...
                string mainFileRelativePath =
                    d.fileName.MakeInkPathRelative(mainFilePath);
                textNodesByLine
                    .GetValueOrCreateDefault(mainFileRelativePath, () => new())
                    .GetValueOrCreateDefault(d.startLineNumber, () => new())
                    .Add(t);
            }
        }
    }
}
