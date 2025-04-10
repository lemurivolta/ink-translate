using System.Xml.Linq;

using UnityEngine;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSStyleMap
    {
        public XElement Element { get; private set; }

        public string Condition
        {
            get => Element.Attribute(ODSNamespaces.StyleCondition).Value;
            set => Element.SetAttributeValue(ODSNamespaces.StyleCondition, value);
        }

        public string ApplyStyleName
        {
            get => Element.Attribute(ODSNamespaces.StyleApplyStyleName).Value;
            set => Element.SetAttributeValue(ODSNamespaces.StyleApplyStyleName, value);
        }

        public string BaseCellAddress
        {
            get => Element.Attribute(ODSNamespaces.StyleBaseCellAddress).Value;
            set => Element.SetAttributeValue(ODSNamespaces.StyleBaseCellAddress, value);
        }

        public ODSStyleMap(XElement element)
        {
            Element = element;
        }

        public ODSStyleMap()
        {
            Element = new XElement(ODSNamespaces.StyleMap);
        }
    }
}
