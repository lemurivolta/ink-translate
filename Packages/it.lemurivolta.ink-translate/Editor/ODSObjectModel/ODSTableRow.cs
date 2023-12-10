using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSTableRow
    {
        public XElement Element { get; private set; }

        public ODSTableRow(XElement rowElement)
        {
            // split repeated cells in advance: find the cells to split
            var cellsToSplit = (from tableCell in rowElement.Descendants(ODSNamespaces.TableTableCell)
                                let repeat = CountRepeat(tableCell)
                                where repeat > 1
                                select (tableCell, repeat))
                                .ToArray();
            // for each cell to split...
            foreach (var (row, repeat) in cellsToSplit)
            {
                // ... produce a number of copies of the cell (without the number-columns-repeated attribute)...
                XElement[] copies = new XElement[repeat];
                for (var i = 0; i < repeat; i++)
                {
                    XElement copy = new(row);
                    copy.Attribute(ODSNamespaces.TableNumberColumnsRepeated).Remove();
                    copies[i] = copy;
                }
                // ... and replace the original cell with the copies
                row.ReplaceWith(copies);
            }

            Element = rowElement;
        }

        public ODSTableRow()
        {
            Element = new XElement(ODSNamespaces.TableTableRow);
        }

        private int CountRepeat(XElement tableCell)
        {
            var repeatAttr = tableCell.Attribute(ODSNamespaces.TableNumberColumnsRepeated);
            int repeat = repeatAttr == null ? 1 : int.Parse(repeatAttr.Value);
            return repeat;
        }

        public string StyleName
        {
            get => Element.Attribute(ODSNamespaces.TableStyleName).Value;
            set => Element.SetAttributeValue(ODSNamespaces.TableStyleName, value);
        }

        public IEnumerable<ODSTableCell> TableCells
        {
            get => Element
                .Descendants(ODSNamespaces.TableTableCell)
                .Select(tableCell => new ODSTableCell(tableCell));
        }

        public bool TryGetCellByIndex(int columnIndex, out ODSTableCell cell) =>
            (cell = TableCells.Skip(columnIndex).FirstOrDefault()) != null;

        public void SetCellByIndex(int columnIndex, ODSTableCell cell)
        {
            var numExistingCells = TableCells.Count();
            // add cells until we have at least enough cell before this one
            while (numExistingCells < columnIndex)
            {
                AppendCell(new());
                numExistingCells++;
            }
            if (numExistingCells == columnIndex)
            {
                // this is a new cell at the end
                AppendCell(cell);
            }
            else
            {
                // this is a cell to overwrite
                var toReplace = TableCells.Skip(columnIndex).First();
                toReplace.Element.ReplaceWith(cell.Element);
            }
        }

        public void AppendCell(ODSTableCell cell)
        {
            Element.Add(cell.Element);
        }

        public void Remove()
        {
            Element.Remove();
        }
    }
}
