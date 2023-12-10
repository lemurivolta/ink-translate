using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSDocument
    {
        public XDocument XDocument { get; private set; }

        public ODSDocument(XDocument xDocument)
        {
            XDocument = xDocument;
        }

        public IEnumerable<ODSTable> Tables
        {
            get => XDocument
                .Descendants(ODSNamespaces.TableTable)
                .Select(tableElement => new ODSTable(tableElement));
        }
    }
}
