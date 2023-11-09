using System.Collections.Generic;
using System.Text;

using System.Linq;
using System;
using Ink.Parsed;
using System.Security.Cryptography;
using UnityEngine.Assertions;

namespace LemuRivolta.InkTranslate.Editor
{
    public class TranslationTable
    {
        public static readonly Progress.Phase Phase =
            new("Create a translation table from the text in the ink files");

        private readonly List<TranslationTableEntry> translationTable = new();

        public List<TranslationTableEntry> Table =>
            translationTable;

        #region new implementation

        public TranslationTable(
            string mainFilePath,
            string sourceLanguageCode,
            Dictionary<string, string[]> fileContents,
            FileDict<List<Text>> textNodesByLine,
            FileDict<List<string>> tagsByFileAndLine)
        {
            translationTable = new();

            // run over all the lines
            foreach (var filename in textNodesByLine.Keys)
            {
                foreach (var lineNumber in textNodesByLine[filename].Keys.OrderBy(x => x))
                {
                    var line = fileContents[filename][lineNumber - 1];

                    // sort the text nodes by start character (we have already asserted
                    // that all text nodes are in a single line)
                    var textNodes = textNodesByLine[filename][lineNumber];
                    Assert.AreNotEqual(textNodes.Count, 0);
                    textNodes.Sort((t1, t2) => t1.debugMetadata.startCharacterNumber.CompareTo(
                        t2.debugMetadata.startCharacterNumber));
                    var firstTextNode = textNodes[0];

                    // get the range of characters we're interested in
                    // (skip trailing newlines and the like)
                    var startChar = firstTextNode.debugMetadata.startCharacterNumber;
                    var endChar = textNodes[^1].debugMetadata.endCharacterNumber;
                    while (line[endChar - 2] == '\r' ||
                        line[endChar - 2] == '\n' ||
                        char.IsWhiteSpace(line[endChar - 2]))
                    {
                        endChar--;
                    }

                    // special case for alternatives.
                    // if we include an opening brace for an alternative ("{choice 1|..."),
                    // then we must also include the corresponding closing brace, otherwise
                    // the translation will be correct but very error-prone.
                    // vice-versa, if we include the closing brace ("...|choice n}"), then
                    // we must also include the opening brace.
                    // TODO: is there an option to escape braces? in that case we must skip
                    // them
                    var interestingPart = line[(startChar - 1)..(endChar - 1)];
                    var numOpened = interestingPart.Count(ch => ch == '{');
                    var numClosed = interestingPart.Count(ch => ch == '}');
                    bool found;
                    while (numOpened > numClosed)
                    {
                        // look for the next closed brace
                        found = false;
                        for (var newEndChar = endChar; newEndChar - 1 < line.Length; newEndChar++)
                        {
                            if (IsBrace(line, newEndChar, '}'))
                            {
                                found = true;
                                endChar = newEndChar + 1;
                                numClosed++;
                                break;
                            }
                        }
                        if (!found)
                        {
                            break;
                        }
                    }
                    while (numOpened < numClosed)
                    {
                        // look for the previous open brace
                        found = false;
                        for (var newStartChar = startChar - 1; newStartChar >= 1; newStartChar--)
                        {
                            if (IsBrace(line, newStartChar, '{'))
                            {
                                found = true;
                                startChar = newStartChar;
                                numOpened++;
                                break;
                            }
                        }
                        if (!found)
                        {
                            break;
                        }
                    }

                    // get the translation key
                    var knotName = GetContainingKnotName(firstTextNode);
                    var content = line[(startChar - 1)..(endChar - 1)];
                    var hash = GetHashString(content);
                    var key = $"{System.IO.Path.GetFileNameWithoutExtension(filename)}-{knotName}-{hash}";

                    // find note tags in the current line, and remove them from the tags
                    // list so they don't get re-used
                    List<string> tags = null;
                    if (tagsByFileAndLine.ContainsKey(filename))
                    {
                        var tagsByLine = tagsByFileAndLine[filename];
                        if (tagsByLine.TryGetValue(lineNumber, out tags))
                        {
                            tagsByLine.Remove(lineNumber);
                        }
                        else if (tagsByLine.TryGetValue(lineNumber - 1, out tags))
                        {
                            tagsByLine.Remove(lineNumber - 1);
                        }
                    }
                    Assert.IsTrue(tags == null || tags.Count > 0);

                    // add the entry to the table
                    translationTable.Add(new()
                    {
                        Key = key,
                        Filename = filename,
                        LineNumber = lineNumber,
                        StartChar = startChar,
                        EndChar = endChar,
                        Notes = tags != null ? string.Join("\n", tags) : null,
                        Languages = new() { { sourceLanguageCode, content } }
                    });
                }
            }
        }

        private bool IsBrace(string line, int index, char brace) =>
            // it's a brace if it's, well, a brace, and...
            line[index - 1] == brace && (
                // this is the first character (can't be escaped!), or...
                index - 1 == 0 ||
                // it's not preceded by a \ (so it's not escaped), or...
                line[index - 2] != '\\' ||
                // it's preceded by a \, but the character before it is also a \
                (index - 2 > 0 && line[index - 3] == '\\'));
        // TODO: this isn't actually a good parser, but it should cover 99% of the cases

        private string GetContainingKnotName(Ink.Parsed.Object o)
        {
            string knotName = string.Empty;
            do
            {
                if (o is Knot knot)
                {
                    knotName = knot.name;
                    break;
                }
            }
            while ((o = o.parent) != null);
            return knotName;
        }

        public static string GetHashString(string str)
        {
            char[] stringChars = str.ToCharArray();
            byte[] stringBytes = Encoding.UTF8.GetBytes(stringChars);
            var hashBytes = SHA1.Create().ComputeHash(stringBytes);
            var hashString = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
            hashString = hashString[^8..];
            return hashString;
        }

        #endregion
    }
}
