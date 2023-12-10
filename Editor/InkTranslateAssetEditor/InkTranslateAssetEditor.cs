using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;

using UnityEditor;
using UnityEditor.UIElements;

using UnityEngine;
using UnityEngine.UIElements;

namespace LemuRivolta.InkTranslate.Editor
{

    [CustomEditor(typeof(InkTranslateAsset))]
    public class InkTranslateAssetEditor : UnityEditor.Editor
    {
        [SerializeField]
        private VisualTreeAsset m_VisualTreeAsset = default;

        [SerializeField]
        private VisualTreeAsset m_LanguageCodeEntry = default;

        [SerializeField]
        private VisualTreeAsset m_TranslationFiles = default;

        private InkTranslateAsset Asset => (InkTranslateAsset)target;

        private readonly Dictionary<VisualElement, EventCallback<TranslationFileElement.CreateFileEvent>>
            callbacks = new();

        private VisualElement root;

        public override VisualElement CreateInspectorGUI()
        {
            // instantiate the root element
            root = m_VisualTreeAsset.Instantiate();

            root.Q<PropertyField>("MainInkFilePropertyField")
                .RegisterValueChangeCallback(_ => SetMessageHelpBox(ValidateMainInkFile()));

            // setup the dropdown with all the existing languages
            root.Q<DropdownField>("SourceLanguageDropdown").choices =
                InkTranslateAsset.languageCodes;

            // since we use a listview and not a propertyfield, we have to apply
            // [Tooltip] tooltips manually
            ApplyTooltip(
                root.Q<Label>("TranslationLanguagesLabel"),
                typeof(InkTranslateAsset)
                    .GetField(nameof(InkTranslateAsset.OtherSupportedLanguages))
                );

            // define how to make the translation languages list items
            ListView translationLanguagesListView =
                root.Q<ListView>("TranslationLanguagesListView");
            translationLanguagesListView.makeItem = () =>
            {
                var ve = m_LanguageCodeEntry.CloneTree();
                var dropdown = ve.Q<DropdownField>("Dropdown");
                dropdown.choices = InkTranslateAsset.languageCodes;
                dropdown.RegisterValueChangedCallback(_ =>
                {
                    // we should validate just this one
                    // but to know the index, we must add userData in bindItem
                    // but if we get bindItem, then normal binding completely breaks
                    SetMessageHelpBox(ValidateTranslationFiles());
                });
                return ve;
            };
            translationLanguagesListView.itemsAdded += _ =>
                SetMessageHelpBox(ValidateTranslationFiles());
            translationLanguagesListView.itemsRemoved += removed =>
                SetMessageHelpBox(ValidateTranslationFiles(removed));

            // setup the list of files
            var lv = root.Q<ListView>("TranslationFilesListView");
            lv.makeItem = m_TranslationFiles.CloneTree;
            lv.bindItem = (el, idx) =>
            {
                // we have to manually bind the TranslationFileElement's
                var prop = serializedObject.FindProperty(
                    $"{nameof(InkTranslateAsset.OtherSupportedLanguages)}.Array.data[{idx}]");
                var label = el.Q<Label>("Label");
                var nameProp = prop.FindPropertyRelative("LanguageCode");
                label.BindProperty(nameProp);

                var xliff = el.Q<TranslationFileElement>("XLIFFTranslationFileElement");
                var xliffProp = prop.FindPropertyRelative("XLIFFFile");
                xliff.BindProperty(xliffProp);

                var ods = el.Q<TranslationFileElement>("ODSTranslationFileElement");
                var odsProp = prop.FindPropertyRelative("ODSFile");
                ods.BindProperty(odsProp);

                var tsv = el.Q<TranslationFileElement>("TSVTranslationFileElement");
                var tsvProp = prop.FindPropertyRelative("TSVFile");
                tsv.BindProperty(tsvProp);

                // add callbacks for the "create" buttons
                // save them so we can remove them on unbind
                var i = idx;
                callbacks[el] = e =>
                {
                    switch (e.FileFormat)
                    {
                        case InkTranslateAsset.FileFormat.TSV:
                            CreateDefaultTSVFile(i); break;
                        case InkTranslateAsset.FileFormat.ODS:
                            CreateDefaultODSFile(i); break;
                        case InkTranslateAsset.FileFormat.XLIFF:
                            CreateDefaultXLIFFFile(i); break;
                        default:
                            Debug.LogError($"Unknown format {e.FileFormat}"); break;
                    }
                };
                el.RegisterCallback(callbacks[el]);
            };
            lv.unbindItem = (el, idx) =>
            {
                // remove the callback
                el.UnregisterCallback(callbacks[el]);
            };

            // react to "Synchronize" by starting the synchronization process
            root.Q<Button>("SynchronizeButton").clicked += StartSynchronization;

            // reset the validation message
            SetMessageHelpBox(null);

            // return the visual tree
            return root;
        }

        private void CreateDefaultTSVFile(int i)
        {
            InkTranslateAsset.OtherSupportedLanguage l = Asset.OtherSupportedLanguages[i];
            var documentContent = TSVSerializationFormatHandler.CreateDefaultTSVFile(
                Asset.SourceLanguageCode,
                l);
            var o = CreateFile(
                "_" + l.LanguageCode,
                "tsv",
                documentContent
            );
            // update the property
            UpdateProperty(
                $"{nameof(InkTranslateAsset.OtherSupportedLanguages)}.Array.data[{i}].TSVFile",
                o);
        }

        private void CreateDefaultXLIFFFile(int i)
        {
            InkTranslateAsset.OtherSupportedLanguage l = Asset.OtherSupportedLanguages[i];
            var documentContent = XLIFFSerializationFormatHandler.CreateDefaultXLIFFFile(
                Asset.SourceLanguageCode,
                l);
            var o = CreateFile(
                "_" + l.LanguageCode,
                "xliff",
                documentContent
            );
            // update the property
            UpdateProperty(
                $"{nameof(InkTranslateAsset.OtherSupportedLanguages)}.Array.data[{i}].XLIFFFile",
                o);
        }

        private void CreateDefaultODSFile(int i)
        {
            InkTranslateAsset.OtherSupportedLanguage l = Asset.OtherSupportedLanguages[i];
            var documentContent = ODSSerializationFormatHandler2.CreateDefaultODSFile();
            var o = CreateFile(
                "_" + l.LanguageCode,
                "ods",
                documentContent
            );
            // update the property
            UpdateProperty(
                $"{nameof(InkTranslateAsset.OtherSupportedLanguages)}.Array.data[{i}].ODSFile",
                o);
        }

        private DefaultAsset CreateFile(string postfix, string newExtension, string content) =>
            CreateFile(postfix, newExtension, Encoding.UTF8.GetBytes(content));

        private DefaultAsset CreateFile(string postfix, string newExtension, byte[] content)
        {
            // get path
            var translationsAssetPath = AssetDatabase.GetAssetPath(Asset);
            var filename = Path.GetDirectoryName(translationsAssetPath) +
                "/" +
                Path.GetFileNameWithoutExtension(translationsAssetPath)
                +
                postfix + "." + newExtension;
            var completePath = Path.Combine(Application.dataPath, "..", filename);
            completePath = completePath.NormalizePath();
            // create file in asset database
            if (File.Exists(completePath))
            {
                Debug.LogWarning($"file already exists: {completePath}");
            }
            else
            {
                var fs = File.Create(completePath);
                fs.Write(content);
                fs.Close();
            }
            AssetDatabase.ImportAsset(filename);
            AssetDatabase.Refresh();
            var o = AssetDatabase.LoadAssetAtPath<DefaultAsset>(filename);
            return o;
        }

        private void UpdateProperty(string propertyPath, Object o)
        {
            serializedObject.Update();
            var prop = serializedObject.FindProperty(propertyPath);
            prop.objectReferenceValue = o;
            serializedObject.ApplyModifiedProperties();
            serializedObject.Update();
        }

        private void ApplyTooltip(Label label, MemberInfo propertyInfo) =>
            label.tooltip = propertyInfo.GetCustomAttribute<TooltipAttribute>().tooltip;

        private void StartSynchronization()
        {
            if (ValidateAll())
            {
                var synchronizer = new Synchronizer(Asset);
                synchronizer.Synchronize();
            }
        }

        private bool ValidateAll()
        {
            var validations = new List<string>() {
                ValidateMainInkFile(),
                ValidateTranslationFiles()
            };
            var message = string.Join("\n", validations.Where(v => v != null));
            SetMessageHelpBox(message);
            return message == "";
        }

        private string ValidateMainInkFile() =>
            Asset.InkFileAsset == null ? "Must set a main ink file" : null;

        private string ValidateTranslationFiles(IEnumerable<int> skipIndices = null)
        {
            var skipIndicesArray = (skipIndices ?? Enumerable.Empty<int>()).ToArray();
            List<string> validations = new();
            for (var i = 0; i < Asset.OtherSupportedLanguages.Count; i++)
            {
                if (System.Array.IndexOf(skipIndicesArray, i) >= 0)
                {
                    continue;
                }
                validations.Add(ValidateTranslationFile(i));
            }
            var rv = string.Join("\n", validations.Where(v => v != null));
            return string.IsNullOrEmpty(rv) ? null : rv;
        }

        private string ValidateTranslationFile(int i)
        {
            var l = Asset.OtherSupportedLanguages[i];
            return l.TSVFile != null || l.ODSFile != null || l.XLIFFFile != null ?
                null :
                $"At least one import/export file must be set for language {l.LanguageCode}";
        }

        private void SetMessageHelpBox(string message)
        {
            var helpBox = root.Q<HelpBox>("MessagesHelpBox");
            helpBox.style.display = string.IsNullOrEmpty(message) ? DisplayStyle.None : DisplayStyle.Flex;
            helpBox.text = message ?? "";
        }
    }
}