using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSAnnotation : ODSTableCellContent
    {
        public XElement Element { get; private set; }

        public ODSAnnotation(XElement element)
        {
            Element = element;
        }

        public ODSAnnotation()
        {
            Element = new XElement(ODSNamespaces.OfficeAnnotation);
        }

        public string StyleName { get; set; }

        public IEnumerable<ODSAnnotationContent> Content
        {
            get => Element.Elements().Select<XElement, ODSAnnotationContent>(e =>
            {
                if (e.Name == ODSNamespaces.TextParagraph)
                {
                    return new ODSParagraph(e);
                }
                else
                {
                    UnityEngine.Debug.LogWarning($"unknown {e.Name} content in cell");
                    return null;
                }
            }).Where(result => result != null);
        }

        public void AppendContent(ODSAnnotationContent content)
        {
            Element.Add(content);
        }

        public void Remove()
        {
            Element.Remove();
        }
    }
}
