using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public enum ODSStyleFamily
    {
        // and many more
        TableCell,
        TableRow
    }

    public class ODSStyle
    {
        public XElement Element { get; private set; }

        public string Name
        {
            get => Element.Attribute(ODSNamespaces.StyleName).Value;
            set => Element.SetAttributeValue(ODSNamespaces.StyleName, value);
        }

        public ODSStyleFamily Family
        {
            get => Element.Attribute(ODSNamespaces.StyleFamily).Value switch
            {
                "table-cell" => ODSStyleFamily.TableCell,
                "table-row" => ODSStyleFamily.TableRow,
                _ => throw new System.NotImplementedException($"style {Element.Attribute(ODSNamespaces.StyleFamily).Value} not implemented")
            };
            set => Element.SetAttributeValue(ODSNamespaces.StyleFamily, value switch
            {
                ODSStyleFamily.TableCell => "table-cell",
                ODSStyleFamily.TableRow => "table-row",
                _ => throw new System.NotImplementedException($"style {value} not implemented")
            });
        }

        public string ParentStyleName
        {
            get => Element.Attribute(ODSNamespaces.StyleParentStyleName).Value;
            set => Element.SetAttributeValue(ODSNamespaces.StyleParentStyleName, value);
        }

        public IEnumerable<ODSStyleContent> Content => Element.Elements()
            .Select<XElement, ODSStyleContent>(e =>
            {
                if (e.Name == ODSNamespaces.StyleTextProperties)
                {
                    return new ODSStyleTextProperties(e);
                }
                else if (e.Name == ODSNamespaces.StyleTableCellProperties)
                {
                    return new ODSStyleTableCellProperties(e);
                }
                else
                {
                    return null;
                }
            }).Where(e => e != null);

        public void AppendContent(ODSStyleContent content)
        {
            Element.Add(content.Element);
        }

        public ODSStyle(XElement element)
        {
            Element = element;
        }

        public ODSStyle()
        {
            Element = new(ODSNamespaces.StyleStyle);
        }
    }
}