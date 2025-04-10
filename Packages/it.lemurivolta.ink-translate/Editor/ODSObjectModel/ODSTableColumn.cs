using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSTableColumn
    {
        public XElement Element { get; private set; }

        public string StyleName
        {
            get => Element.Attribute(ODSNamespaces.StyleName).Value;
            set => Element.SetAttributeValue(ODSNamespaces.StyleName, value);
        }

        public string DefaultCellStyleName
        {
            get => Element.Attribute(ODSNamespaces.TableDefaultCellStyleName).Value;
            set => Element.SetAttributeValue(ODSNamespaces.TableDefaultCellStyleName, value);
        }

        public ODSTableColumn(XElement element)
        {
            Element = element;
        }

        public ODSTableColumn()
        {
            Element = new(ODSNamespaces.TableTableColumn);
        }
    }
}
