using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSParagraph : ODSTableCellContent, ODSAnnotationContent
    {
        public XElement Element { get; private set; }

        public ODSParagraph(XElement element)
        {
            Element = element;
        }

        public ODSParagraph()
        {
            Element = new XElement(ODSNamespaces.TextParagraph);
        }

        public string Content { get => Element.Value; set => Element.Value = value; }
    }
}
