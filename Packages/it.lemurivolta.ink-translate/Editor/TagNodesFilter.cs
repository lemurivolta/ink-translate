using System.Collections.Generic;

using Ink.Parsed;

namespace LemuRivolta.InkTranslate.Editor
{
    /// <summary>
    /// An ink visitor that extract all tags starting with a given prefix.
    /// </summary>
    public class TagNodesFilter : InkVisitor
    {
        /// <summary>
        /// Whether we're inside a tag. Valid only during visit.
        /// </summary>
        private bool insideTag = false;

        private FileDict<List<string>> tags;

        /// <summary>
        /// The list of all tags found while parsing, organized by (main-file relative) path
        /// and line..
        /// </summary>
        public FileDict<List<string>> Tags => tags;

        private readonly string translationNotePrefix;
        private string mainFilePath;

        public TagNodesFilter(string translationNotePrefix)
        {
            this.translationNotePrefix = translationNotePrefix;
        }

        public override void BeginParsing(string mainFilePath)
        {
            this.mainFilePath = mainFilePath;
            tags = new();
        }

        public override void VisitObject(Object o)
        {
            if(string.IsNullOrEmpty(translationNotePrefix))
            {
                return;
            }

            if (o is Tag tag)
            {
                insideTag = tag.isStart;
            }
            if (insideTag &&
                o is Text t &&
                t.text.StartsWith(translationNotePrefix))
            {
                var d = o.debugMetadata;
                string mainFileRelativePath =
                    d.fileName.MakeInkPathRelative(mainFilePath);
                tags.GetValueOrCreateDefault(mainFileRelativePath, () => new())
                    .GetValueOrCreateDefault(d.startLineNumber, () => new())
                    .Add(t.text[translationNotePrefix.Length..].Trim());
            }
        }

    }
}
