using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

using UnityEngine;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSTable
    {
        private readonly XElement tableElement;

        public ODSTable(XElement tableElement)
        {
            this.tableElement = tableElement;
        }

        public string Name
        {
            get => tableElement.Attributes(ODSNamespaces.TableName).Single().Value;
            set => tableElement.SetAttributeValue(ODSNamespaces.TableName, value);
        }

        public IEnumerable<ODSTableRow> TableRows
        {
            get => tableElement.Descendants(ODSNamespaces.TableTableRow).Select(row => new ODSTableRow(row));
        }

        public void AddTableRow(ODSTableRow row)
        {
            tableElement.Add(row.Element);
        }

        public void AddTableRowAfter(ODSTableRow row, ODSTableRow after)
        {
            Debug.Assert(after.Element.Parent == tableElement);
            after.Element.AddAfterSelf(row.Element);
        }
    }
}
