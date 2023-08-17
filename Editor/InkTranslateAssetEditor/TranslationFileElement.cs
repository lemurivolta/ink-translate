using System.Collections.Generic;

using UnityEditor.UIElements;

using UnityEngine;
using UnityEngine.UIElements;

using BindingFlags = System.Reflection.BindingFlags;

namespace LemuRivolta.InkTranslate.Editor
{
    public class TranslationFileElement : BindableElement, INotifyValueChanged<Object>
    {
        public class CreateFileEvent : EventBase<CreateFileEvent>
        {
            public InkTranslateAsset.FileFormat FileFormat;

            public TranslationFileElement source;

            public CreateFileEvent() => LocalInit();

            protected override void Init()
            {
                base.Init();
                LocalInit();
            }

            private void LocalInit()
            {
                // this is TERRIBLE
                // EventBase sets propagation to EventPropagation.None, and standard events
                // derive from EventBase and set their propagation value in the LocalInit.
                // But we can't, because both EventBase.propagation and EventPropagation
                // are internal to UnityEngine.UIModules.
                // So... here's this horrible hack. Ugh.
                typeof(EventBase)
                    .GetProperty("propagation", BindingFlags.Instance | BindingFlags.NonPublic)
                    .SetValue(this, 3);
            }
        }

        public InkTranslateAsset.FileFormat FileFormat;

        private string text = "";

        private string Text
        {
            get => text;
            set
            {
                text = value;
                if (textLabel != null)

                {
                    textLabel.text = value;
                }
            }
        }

        Object _value;

        public Object value
        {
            get => _value;
            set
            {
                if (_value == value)
                {
                    SetValueWithoutNotify(value);
                }
                else
                {
                    using var evt = ChangeEvent<Object>.GetPooled(_value, value);
                    evt.target = this;
                    SetValueWithoutNotify(value);
                    SendEvent(evt);
                }
                UpdateElementsVisibility();
            }
        }

        public void SetValueWithoutNotify(Object newValue)
        {
            assetField.value = newValue;
            _value = newValue;
        }

        private readonly Label textLabel;

        private readonly ObjectField assetField;

        private readonly Button createAssetField;

        public TranslationFileElement()
        {
            var container = new VisualElement();
            container.style.flexDirection = FlexDirection.Row;

            textLabel = new(text);
            textLabel.style.minWidth = 60;
            container.Add(textLabel);

            assetField = new();
            assetField.style.flexGrow = 1;
            assetField.RegisterValueChangedCallback(_ =>
            {
                value = assetField.value;
            });
            container.Add(assetField);

            createAssetField = new Button
            {
                text = "create"
            };
            createAssetField.style.marginRight = -2;
            createAssetField.clicked += CreateAssetFieldClicked;
            container.Add(createAssetField);

            UpdateElementsVisibility();

            Add(container);
        }

        private void CreateAssetFieldClicked()
        {
            var cfe = CreateFileEvent.GetPooled();
            cfe.FileFormat = FileFormat;
            cfe.source = this;
            cfe.target = this;
            SendEvent(cfe);
        }

        private void UpdateElementsVisibility()
        {
            createAssetField.style.display = assetField.value == null ?
                DisplayStyle.Flex : DisplayStyle.None;
        }

        public new class UxmlFactory : UxmlFactory<TranslationFileElement, UxmlTraits> { }

        public new class UxmlTraits : BindableElement.UxmlTraits
        {
            UxmlStringAttributeDescription m_Text = new UxmlStringAttributeDescription
            {
                name = "Text",
            };

            UxmlEnumAttributeDescription<InkTranslateAsset.FileFormat> m_FileFormat = new()
            {
                name = "FileFormat",
            };

            public override IEnumerable<UxmlChildElementDescription> uxmlChildElementsDescription
            {
                get
                {
                    // can contain no children
                    yield break;
                }
            }

            public override void Init(VisualElement ve, IUxmlAttributes bag, CreationContext cc)
            {
                base.Init(ve, bag, cc);
                TranslationFileElement tfe = ((TranslationFileElement)ve);
                tfe.Text = m_Text.GetValueFromBag(bag, cc);
                tfe.FileFormat = m_FileFormat.GetValueFromBag(bag, cc);
            }
        }
    }

}
