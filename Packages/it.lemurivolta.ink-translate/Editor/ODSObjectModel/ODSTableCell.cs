using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public enum ODSValueType
    {
        // float, percentage, currency, date, time, boolean, string
        String
    }

    public class ODSTableCell
    {
        public XElement Element { get; private set; }

        public ODSTableCell(XElement element)
        {
            Element = element;
        }

        public ODSTableCell()
        {
            Element = new XElement(ODSNamespaces.TableTableCell);
        }

        public string StyleName
        {
            get => Element.Attribute(ODSNamespaces.TableStyleName)?.Value;
            set => Element.SetAttributeValue(ODSNamespaces.TableStyleName, value);
        }

        public ODSValueType ValueType
        {
            get
            {
                var attr = Element.Attribute(ODSNamespaces.OfficeValueType) ??
                    Element.Attribute(ODSNamespaces.CalcextValueType);
                if (attr != null)
                {
                    return attr.Value switch
                    {
                        "string" => ODSValueType.String,
                        _ => throw new System.NotSupportedException($"value type {attr.Value} not supported"),
                    };
                }
                else
                {
                    // is this correct?
                    return ODSValueType.String;
                }
            }
            set
            {
                var attrValue = value switch
                {
                    ODSValueType.String => "string",
                    _ => throw new System.NotImplementedException($"value type {value} not implemented")
                };
                Element.SetAttributeValue(ODSNamespaces.OfficeValueType, attrValue);
                Element.SetAttributeValue(ODSNamespaces.CalcextValueType, attrValue);
            }
        }

        public IEnumerable<ODSTableCellContent> Content
        {
            get => Element.Elements().Select<XElement, ODSTableCellContent>(e =>
            {
                if (e.Name == ODSNamespaces.TextParagraph)
                {
                    return new ODSParagraph(e);
                }
                else if (e.Name == ODSNamespaces.OfficeAnnotation)
                {
                    return new ODSAnnotation(e);
                }
                else
                {
                    UnityEngine.Debug.LogWarning($"unknown {e.Name} content in cell");
                    return null;
                }
            }).Where(result => result != null);
        }

        public void AppendContent(ODSTableCellContent content)
        {
            Element.Add(content.Element);
        }

        public string TextContent =>
            string.Join("", Content.OfType<ODSParagraph>().Select(p => p.Content));
    }
}
