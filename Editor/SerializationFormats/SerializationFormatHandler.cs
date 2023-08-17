using System;
using System.Collections.Generic;

using UnityEditor.VersionControl;

using static LemuRivolta.InkTranslate.InkTranslateAsset;

namespace LemuRivolta.InkTranslate.Editor
{
    public abstract class SerializationFormatHandler
    {
        /// <summary>
        /// Synchronization phase where data is read from the serialized format and translations
        /// are merged into the translation table.
        /// </summary>
        public Progress.Phase PhaseRead { get; private set; }

        /// <summary>
        /// Synchronization phase where the translation table is serialized into the file.
        /// </summary>
        public Progress.Phase PhaseWrite { get; private set; }

        protected readonly string languageCode;
        protected readonly string sourceLanguageCode;
        protected List<OtherSupportedLanguage> translationLanguages;

        private bool initialized = false;
        protected List<TranslationTableEntry> translationTable;

        public SerializationFormatHandler(
            string formatName,
            string languageCode,
            InkTranslateAsset asset
        )
        {
            this.languageCode = languageCode;
            this.sourceLanguageCode = asset.SourceLanguageCode;
            this.translationLanguages = asset.OtherSupportedLanguages;

            PhaseRead =
                new($"Read the {formatName} file for {languageCode}");
            PhaseWrite =
                new($"Write the {formatName} file for {languageCode}");
        }

        public void Initialize(List<TranslationTableEntry> translationTable)
        {
            if (initialized)
            {
                throw new InvalidOperationException("Already initialized");
            }
            this.translationTable = translationTable;
            initialized = true;
        }

        protected InkTranslateAsset.OtherSupportedLanguage GetLanguageInfo()
        {
            if (!initialized)
            {
                throw new InvalidOperationException($"Cannot get language info until initialized");
            }
            foreach (var l in translationLanguages)
            {
                if (l.LanguageCode == languageCode)
                {
                    return l;
                }
            }
            throw new InvalidOperationException($"Cannot find language info for {languageCode}");
        }

        public void Read()
        {
            PhaseRead.Do(0);
            var translations = InnerRead();
            PhaseRead.Do(0.5f);
            foreach (var entry in translationTable)
            {
                if (translations.TryGetValue(entry.Key, out var translation) &&
                    !string.IsNullOrEmpty(translation))
                {
                    entry.Languages[languageCode] = translation;
                }
            }
            PhaseRead.Do(1);
        }

        protected abstract Dictionary<string, string> InnerRead();

        public void Write()
        {
            PhaseWrite.Do(0);
            InnerSerialize();
            PhaseWrite.Do(1);
        }

        protected abstract void InnerSerialize();
    }
}
