using System;
using System.Collections.Generic;
using System.Linq;

using UnityEditor;

using UnityEngine;

namespace LemuRivolta.InkTranslate
{

    [CreateAssetMenu(fileName = "Ink Translate",
        menuName = "Ink Translate/Create Ink Translate Asset")]
    public class InkTranslateAsset : ScriptableObject
    {
        [Serializable]
        public enum FileFormat
        {
            TSV = 1 << 0,
            ODS = 1 << 1,
            XLIFF = 1 << 2
        };

        [Serializable]
        public class OtherSupportedLanguage
        {
            public string LanguageCode;
            public DefaultAsset XLIFFFile;
            public DefaultAsset ODSFile;
            public DefaultAsset TSVFile;
        }

        [Tooltip("A reference to the main ink file. Note well: this is the Ink file, not the compiled JSON file.")]
        public DefaultAsset InkFileAsset;

        [Tooltip("Language in which the main ink file is written")]
        public string SourceLanguageCode = "EN";

        [Tooltip("All the languages that the story will be translated to")]
        public List<OtherSupportedLanguage> OtherSupportedLanguages;

        [Tooltip("All tags that start with this prefix will be interpreted as notes for the translator. E.g.: \"Mark: hello, John... #tnote:Mark is cold and hostile in here")]
        public string TranslationNotePrefix = "tnote:";

        [Tooltip("Whether to skip the content of string variables (they don't contain any content to display directly to the user) or not.")]
        public bool SkipStringVariables;

#if UNITY_EDITOR

        private void OnValidate()
        {
            // avoid adding the source language between the translation languages
            if (SourceLanguageCode != null)
            {
                var i = OtherSupportedLanguages.FindIndex(l => l.LanguageCode == SourceLanguageCode);
                if (i != -1)
                {
                    Debug.LogWarning($"Cannot add the main ink file language as a translation language. Translation languages must be different from the main ink file language.");
                    OtherSupportedLanguages.RemoveAt(i);
                }
            }
            // avoid duplicate translation languages
            var existingLanguages = (from l in OtherSupportedLanguages
                                     select l.LanguageCode)
                                     .ToHashSet();
            for (var i = 0; i < OtherSupportedLanguages.Count; i++)
            {
                var l = OtherSupportedLanguages[i];
                for (var k = i + 1; k < OtherSupportedLanguages.Count; k++)
                {
                    var l2 = OtherSupportedLanguages[k];
                    if (l.LanguageCode == l2.LanguageCode)
                    {
                        for (var j = 0; j < languageCodes.Count; j++)
                        {
                            if (!existingLanguages.Contains(languageCodes[j]))
                            {
                                l2.LanguageCode = languageCodes[j];
                                existingLanguages.Add(l2.LanguageCode);
                                break;
                            }
                        }
                    }
                }
            }
            // avoid having a file used for multiple translations
            // (this happens e.g. when adding a new element through the ListView,
            // which by default clones the last item)
            HashSet<string> filenames = new();
            DefaultAsset Filter(DefaultAsset currentFile)
            {
                var path = AssetDatabase.GetAssetPath(currentFile);
                if (filenames.Contains(path))
                {
                    return null;
                }
                filenames.Add(path);
                return currentFile;
            }
            foreach (var l in OtherSupportedLanguages)
            {
                l.TSVFile = Filter(l.TSVFile);
                l.ODSFile = Filter(l.ODSFile);
                l.XLIFFFile = Filter(l.XLIFFFile);
            }
        }

        public static readonly List<string> languageCodes = new() {
        "af","af-ZA","ar","ar-AE","ar-BH","ar-DZ","ar-EG","ar-IQ","ar-JO","ar-KW","ar-LB","ar-LY","ar-MA","ar-OM","ar-QA","ar-SA","ar-SY","ar-TN","ar-YE","az","az-AZ","az-AZ","be","be-BY","bg","bg-BG","bs-BA","ca","ca-ES","cs","cs-CZ","cy","cy-GB","da","da-DK","de","de-AT","de-CH","de-DE","de-LI","de-LU","dv","dv-MV","el","el-GR","en","en-AU","en-BZ","en-CA","en-CB","en-GB","en-IE","en-JM","en-NZ","en-PH","en-TT","en-US","en-ZA","en-ZW","eo","es","es-AR","es-BO","es-CL","es-CO","es-CR","es-DO","es-EC","es-ES","es-ES","es-GT","es-HN","es-MX","es-NI","es-PA","es-PE","es-PR","es-PY","es-SV","es-UY","es-VE","et","et-EE","eu","eu-ES","fa","fa-IR","fi","fi-FI","fo","fo-FO","fr","fr-BE","fr-CA","fr-CH","fr-FR","fr-LU","fr-MC","gl","gl-ES","gu","gu-IN","he","he-IL","hi","hi-IN","hr","hr-BA","hr-HR","hu","hu-HU","hy","hy-AM","id","id-ID","is","is-IS","it","it-CH","it-IT","ja","ja-JP","ka","ka-GE","kk","kk-KZ","kn","kn-IN","ko","ko-KR","kok","kok-IN","ky","ky-KG","lt","lt-LT","lv","lv-LV","mi","mi-NZ","mk","mk-MK","mn","mn-MN","mr","mr-IN","ms","ms-BN","ms-MY","mt","mt-MT","nb","nb-NO","nl","nl-BE","nl-NL","nn-NO","ns","ns-ZA","pa","pa-IN","pl","pl-PL","ps","ps-AR","pt","pt-BR","pt-PT","qu","qu-BO","qu-EC","qu-PE","ro","ro-RO","ru","ru-RU","sa","sa-IN","se","se-FI","se-FI","se-FI","se-NO","se-NO","se-NO","se-SE","se-SE","se-SE","sk","sk-SK","sl","sl-SI","sq","sq-AL","sr-BA","sr-BA","sr-SP","sr-SP","sv","sv-FI","sv-SE","sw","sw-KE","syr","syr-SY","ta","ta-IN","te","te-IN","th","th-TH","tl","tl-PH","tn","tn-ZA","tr","tr-TR","tt","tt-RU","ts","uk","uk-UA","ur","ur-PK","uz","uz-UZ","uz-UZ","vi","vi-VN","xh","xh-ZA","zh","zh-CN","zh-HK","zh-MO","zh-SG","zh-TW","zu","zu-ZA"
    };

#endif
    }

}