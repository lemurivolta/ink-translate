using System.Xml.Linq;

using UnityEngine;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSStyleTextProperties : ODSStyleContent
    {
        public XElement Element { get; private set; }

        public ODSFontSize FontSize
        {
            get => ODSFontSize.Parse(Element.Attribute(ODSNamespaces.FoFontSize).Value);
            set => Element.SetAttributeValue(ODSNamespaces.FoFontSize, value.ToString());
        }

        public Color? FontColor
        {
            get
            {
                var attr = Element.Attribute(ODSNamespaces.FoColor).Value;
                if (attr != null)
                {
                    if (ColorUtility.TryParseHtmlString(attr, out var color))
                    {
                        return color;
                    }
                    else
                    {
                        throw new System.NotImplementedException($"cannot parse color '{attr}'");
                    }
                }
                else
                {
                    return null;
                }
            }
            set => Element.SetAttributeValue(ODSNamespaces.FoColor,
                value.HasValue ? "#" + ColorUtility.ToHtmlStringRGB(value.Value) : null);
        }

        public ODSStyleTextProperties(XElement element)
        {
            Element = element;
        }

        public ODSStyleTextProperties()
        {
            Element = new(ODSNamespaces.StyleTextProperties);
        }
    }
}
