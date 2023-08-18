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

        /// <summary>
        /// Create a new tag nodes filter.
        /// </summary>
        /// <param name="translationNotePrefix">The prefix used to identify tags that are
        /// about translations (e.g.: "tnote:").
        /// The prefix is removed from the saved tag.
        /// If <c>null</c> or "", no tag is extracted as a translation note.</param>
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
                // don't extract tags if no translation note prefix is set
                return;
            }

            // track whether we're inside a tag
            if (o is Tag tag)
            {
                insideTag = tag.isStart;
            }
            // check if the content of the tag is of interest to us
            if (insideTag &&
                o is Text t &&
                t.text.StartsWith(translationNotePrefix))
            {
                // it is: save it!
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
