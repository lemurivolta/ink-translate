using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;
using System.Text;

using Ink.Parsed;

namespace LemuRivolta.InkTranslate.Editor
{
    public class FileLines
    {
        private readonly Dictionary<string, string[]> fileContents = new();
        private readonly string mainFilePath;

        public FileLines(string mainFilePath)
        {
            this.mainFilePath = mainFilePath;
        }

        public string[] GetFileLines(string filename)
        {
            if (!fileContents.ContainsKey(filename))
            {
                fileContents[filename] = File.ReadAllText(
                    filename.ResolveInkFilename(mainFilePath)
                )
                .Split("\n");
            }
            var childContents = fileContents[filename];
            return childContents;
        }

        public string GetTranslationKey(
            string filename, string knotName, string content)
        {
            // create a hash of the content
            string hashString = GetHashString(content);
            // combine
            return $"{filename}-{knotName}-{hashString}";
        }

        private static string GetHashString(string str)
        {
            char[] stringChars = str.ToCharArray();
            byte[] stringBytes = Encoding.UTF8.GetBytes(stringChars);
            var hashBytes = SHA1.Create().ComputeHash(stringBytes);
            var hashString = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
            hashString = hashString[^8..];
            return hashString;
        }
    }
}
