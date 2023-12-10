using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public static class ODSNamespaces
    {
        public static readonly XNamespace Table =
            "urn:oasis:names:tc:opendocument:xmlns:table:1.0";
        public static readonly XName TableTable = Table + "table";
        public static readonly XName TableName = Table + "name";
        public static readonly XName TableTableRow = Table + "table-row";
        public static readonly XName TableTableCell = Table + "table-cell";
        public static readonly XName TableNumberColumnsRepeated = Table + "number-columns-repeated";
        public static readonly XName TableStyleName = Table + "style-name";

        public static readonly XNamespace Text =
            "urn:oasis:names:tc:opendocument:xmlns:text:1.0";
        public static readonly XName TextParagraph = Text + "p";

        public static readonly XNamespace Office =
            "urn:oasis:names:tc:opendocument:xmlns:office:1.0";
        public static readonly XName OfficeValueType = Office + "value-type";
        public static readonly XName OfficeAnnotation = Office + "annotation";
        public static readonly XName OfficeStyles = Office + "styles";

        public static readonly XNamespace Calcext =
            "urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0";
        public static readonly XName CalcextValueType = Calcext + "value-type";

        public static readonly XNamespace Style =
            "urn:oasis:names:tc:opendocument:xmlns:style:1.0";
        public static readonly XName StyleStyle = Style + "style";
        public static readonly XName StyleName = Style + "name";
        public static readonly XName StyleFamily = Style + "family";
        public static readonly XName StyleParentStyleName = Style + "parent-style-name";
        public static readonly XName StyleTextProperties = Style + "text-properties";
        public static readonly XName StyleTableCellProperties = Style + "table-cell-properties";
        public static readonly XName StyleVerticalAlign = Style + "vertical-align";

        public static readonly XNamespace Fo =
            "urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0";
        public static readonly XName FoFontSize = Fo + "font-size";
        public static readonly XName FoColor = Fo + "color";
        public static readonly XName FoWrapOption = Fo + "wrap-option";
    }
}
