using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;
using System.Text;

using Ink.Parsed;

namespace LemuRivolta.InkTranslate.Editor
{
    public class FileLines: InkVisitor
    {
        private readonly Dictionary<string, string[]> fileContents = new();

        public IEnumerable<string> Filenames => fileContents.Keys;

        public Dictionary<string, string[]> FileContents => fileContents;

        public override void VisitFile(string filename, string contents)
        {
            filename = filename.Replace("\\", "/");
            fileContents[filename] = contents.Split('\n');
        }
    }
}
