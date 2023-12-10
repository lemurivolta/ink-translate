using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public enum ODSWrapOption
    {
        NoWrap,
        Wrap,
        Inherit
    }

    public enum ODSTableCellVerticalAlign
    {
        // and more
        Middle
    }

    public class ODSStyleTableCellProperties : ODSStyleContent
    {
        public XElement Element { get; private set; }

        public ODSWrapOption? WrapOption
        {
            get => Element.Attribute(ODSNamespaces.FoWrapOption).Value switch
            {
                null => null,
                "no-wrap" => ODSWrapOption.NoWrap,
                "wrap" => ODSWrapOption.Wrap,
                "inherit" => ODSWrapOption.Inherit,
                _ => throw new System.InvalidOperationException($"unknown wrap-option: {Element.Attribute(ODSNamespaces.FoWrapOption).Value}")
            };
            set => Element.SetAttributeValue(ODSNamespaces.FoWrapOption, !value.HasValue ? null : value.Value switch
            {
                ODSWrapOption.Wrap => "wrap",
                ODSWrapOption.NoWrap => "no-wrap",
                ODSWrapOption.Inherit => "inherit",
                _ => throw new System.InvalidOperationException($"unknown wrap-option: {value}")
            });
        }

        public ODSTableCellVerticalAlign? VerticalAlign
        {
            get => Element.Attribute(ODSNamespaces.StyleVerticalAlign).Value switch
            {
                null => null,
                "middle" => ODSTableCellVerticalAlign.Middle,
                _ => throw new System.NotImplementedException($"Unknown alignment {Element.Attribute(ODSNamespaces.StyleVerticalAlign).Value}")
            };
            set => Element.SetAttributeValue(ODSNamespaces.StyleVerticalAlign, value switch
            {
                null => null,
                ODSTableCellVerticalAlign.Middle => "middle",
                _ => throw new System.NotImplementedException($"Unknown alignment {value}")
            });
        }

        public ODSStyleTableCellProperties(XElement element)
        {
            Element = element;
        }

        public ODSStyleTableCellProperties()
        {
            Element = new(ODSNamespaces.StyleTableCellProperties);
        }
    }
}
