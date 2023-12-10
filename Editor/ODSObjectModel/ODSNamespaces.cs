using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public static class ODSNamespaces
    {
        public static readonly XNamespace Table =
            "urn:oasis:names:tc:opendocument:xmlns:table:1.0";
        public static readonly XName TableTable = Table + "table"; //
        public static readonly XName TableName = Table + "name"; //
        public static readonly XName TableTableRow = Table + "table-row"; //
        public static readonly XName TableTableCell = Table + "table-cell"; //
        public static readonly XName TableNumberColumnsRepeated = Table + "number-columns-repeated"; //
        public static readonly XName TableStyleName = Table + "style-name"; //

        public static readonly XNamespace Text =
            "urn:oasis:names:tc:opendocument:xmlns:text:1.0";
        public static readonly XName TextParagraph = Text + "p"; //
        //public static readonly XName StyleNameTElName = Text + "style-name";

        public static readonly XNamespace Office =
            "urn:oasis:names:tc:opendocument:xmlns:office:1.0";
        public static readonly XName OfficeValueType = Office + "value-type"; //
        public static readonly XName OfficeAnnotation = Office + "annotation"; //

        public static readonly XNamespace Calcext =
            "urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0";
        public static readonly XName CalcextValueType = Calcext + "value-type"; //
    }
}
