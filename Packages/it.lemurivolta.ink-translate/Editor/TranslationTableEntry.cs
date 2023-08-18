using System.Collections.Generic;
using System.Linq;
using System.Text;

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

        public override readonly string ToString()
        {
            StringBuilder langs = new();
            foreach(var key in Languages.Keys.OrderBy(key => key))
            {
                langs.AppendJoin(", ", $"{key}=\"{Languages[key]}\"");
            }
            return $"TranslationTableEntry[Key={Key}, {Filename}:{LineNumber}:{StartChar}-{EndChar}, Notes=\"{Notes}\": {langs}]";
        }
    }
}
