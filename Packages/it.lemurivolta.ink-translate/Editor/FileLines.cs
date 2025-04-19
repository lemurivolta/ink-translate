using System.Collections.Generic;

namespace LemuRivolta.InkTranslate.Editor
{
    public class FileLines: InkVisitor
    {
        private readonly Dictionary<string, string[]> fileContents = new();

        public IEnumerable<string> Filenames => fileContents.Keys;

        public Dictionary<string, string[]> FileContents => fileContents;

        public override void VisitFile(string filename, string contents)
        {
            fileContents[filename] = contents.NormalizeNewlines().Split('\n');
        }
    }
}
