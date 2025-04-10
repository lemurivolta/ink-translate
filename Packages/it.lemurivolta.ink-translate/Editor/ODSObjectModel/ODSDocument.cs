using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSDocument
    {
        public XDocument ContentXDocument { get; private set; }
        public XDocument StylesXDocument { get; private set; }

        public ODSDocument(XDocument contentXDocument, XDocument stylesXDocument)
        {
            ContentXDocument = contentXDocument;
            StylesXDocument = stylesXDocument;
        }

        public IEnumerable<ODSTable> Tables => ContentXDocument
            .Descendants(ODSNamespaces.TableTable)
            .Select(tableElement => new ODSTable(tableElement));

        public IEnumerable<ODSStyle> Styles => OfficeStyles
            .Descendants(ODSNamespaces.StyleStyle)
            .Select(styleElement => new ODSStyle(styleElement));

        public IEnumerable<ODSStyle> AutomaticStyles => OfficeAutomaticStyles
            .Descendants(ODSNamespaces.StyleStyle)
            .Select(styleElement => new ODSStyle(styleElement));

        public void AppendStyle(ODSStyle style)
        {
            OfficeStyles.Add(style.Element);
        }

        public void AppendAutomaticStyle(ODSStyle style)
        {
            OfficeAutomaticStyles.Add(style.Element);
        }

        private XElement OfficeStyles => StylesXDocument
            .Descendants(ODSNamespaces.OfficeStyles)
            .First();

        private XElement OfficeAutomaticStyles => ContentXDocument
            .Descendants(ODSNamespaces.OfficeAutomaticStyles)
            .First();
    }
}
