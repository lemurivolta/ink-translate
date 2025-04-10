using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSStyleTableRowProperties : ODSStyleContent
    {
        public XElement Element { get; private set; }

        public bool? UseOptimalRowHeight
        {
            get
            {
                var strValue = Element.Attribute(ODSNamespaces.StyleUseOptimalRowHeight).Value;
                return strValue == null ? null : strValue == "true";
            }
            set => Element.SetAttributeValue(ODSNamespaces.StyleUseOptimalRowHeight,
                value == null ? null : value.Value ? "true" : "false");
        }

        public ODSStyleTableRowProperties(XElement e)
        {
            Element = e;
        }

        public ODSStyleTableRowProperties()
        {
            Element = new XElement(ODSNamespaces.StyleTableRowProperties);
        }
    }
}
