using System.Collections.Generic;

using Ink.Parsed;

namespace LemuRivolta.InkTranslate.Editor
{
    public class TagNodesFilter : InkVisitor
    {
        /// <summary>
        /// Whether we're inside a tag. Valid only during visit.
        /// </summary>
        private bool insideTag = false;

        private FileDict<List<string>> tags;

        /// <summary>
        /// The list of all tags found while parsing.
        /// </summary>
        public FileDict<List<string>> Tags => tags;

        private readonly string translationNotePrefix;
        private readonly string mainFilePath;

        public TagNodesFilter(string mainInkFile, string translationNotePrefix)
        {
            this.mainFilePath = mainInkFile;
            this.translationNotePrefix = translationNotePrefix;
        }

        public override void BeginParsing(string mainFilePath) =>
            tags = new();

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
                tags.GetValueOrCreateDefault(d.fileName.ResolveInkFilename(mainFilePath), () => new())
                    .GetValueOrCreateDefault(d.startLineNumber, () => new())
                    .Add(t.text[translationNotePrefix.Length..].Trim());
            }
        }

    }
}
