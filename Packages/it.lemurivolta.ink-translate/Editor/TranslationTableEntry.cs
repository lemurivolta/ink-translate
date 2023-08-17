using System.Collections.Generic;

namespace LemuRivolta.InkTranslate.Editor
{
    public struct TranslationTableEntry
    {
        public string Key;
        public string Filename;
        public int LineNumber;
        public int StartChar;
        public int EndChar;
        public string Notes;
        public Dictionary<string, string> Languages;
    }
}
