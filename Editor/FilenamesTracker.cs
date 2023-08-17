using System.Collections.Generic;

using Ink.Parsed;

namespace LemuRivolta.InkTranslate.Editor
{
    public class FilenamesTracker : InkVisitor
    {
        private HashSet<string> filenames;

        /// <summary>
        /// The list of all filenames, expressed as main-file relative paths.
        /// </summary>
        public HashSet<string> Filenames => filenames;

        private readonly string mainFilePath;

        public FilenamesTracker(string mainFilePath) {
            this.mainFilePath = mainFilePath;
        }

        public override void BeginParsing(string mainFilePath)
        {
            filenames = new() { System.IO.Path.GetFileName(mainFilePath) };
        }

        public override void VisitObject(Object o)
        {
            var d = o.debugMetadata;
            if (d != null)
            {
                filenames.Add(d.fileName.MakeInkPathRelative(mainFilePath));
            }
        }
    }
}
