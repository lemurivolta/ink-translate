using System.Collections.Generic;

namespace LemuRivolta.InkTranslate.Editor
{
    public class FilenamesTracker : InkVisitor
    {
        private HashSet<string> filenames;

        /// <summary>
        /// The list of all filenames, expressed as main-file relative paths.
        /// </summary>
        public HashSet<string> Filenames => filenames;

        public override void VisitFile(string filename)
        {
            filenames.Add(filename);
        }

        public override void BeginParsing(string mainFilePath)
        {
            filenames = new();
        }
    }
}
