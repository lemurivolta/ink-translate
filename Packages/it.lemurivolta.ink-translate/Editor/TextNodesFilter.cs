using System.Collections.Generic;

using Ink.Parsed;

using UnityEngine.Assertions;

namespace LemuRivolta.InkTranslate.Editor
{
    public class TextNodesFilter : InkVisitor
    {
        private FileDict<List<Text>> textNodesByLine;

        /// <summary>
        /// All the text nodes, filed by line.
        /// </summary>
        public FileDict<List<Text>> TextNodesByLine => textNodesByLine;

        private bool insideTag;

        private readonly string mainFilePath;

        public TextNodesFilter(string mainFilePath)
        {
            this.mainFilePath = mainFilePath;
        }

        public override void BeginParsing(string mainFilePath)
        {
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
            // only care about text nodes
            if (o is Text t &&
                // exclude newlines
                t.text.Trim().Length != 0 &&
                // exclude values
                t.parent is not StringExpression)
            {
                var d = t.debugMetadata;
                Assert.AreEqual(d.startLineNumber, d.endLineNumber);
                textNodesByLine
                    .GetValueOrCreateDefault(
                        d.fileName.MakeInkPathRelative(mainFilePath),
                        () => new())
                    .GetValueOrCreateDefault(d.startLineNumber, () => new())
                    .Add(t);
            }
        }
    }
}
