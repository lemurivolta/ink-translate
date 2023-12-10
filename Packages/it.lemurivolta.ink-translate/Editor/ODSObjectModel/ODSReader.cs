using System.IO;
using System.IO.Compression;
using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSReader
    {
        public ODSDocument Deserialize(Stream stream)
        {
            // open the zip archive
            using var zipArchive = new ZipArchive(stream);
            var contentXDocument = getXDocument(zipArchive, "content.xml");
            var stylesXDocument = getXDocument(zipArchive, "styles.xml");
            // wrap it in our main class
            return new ODSDocument(contentXDocument, stylesXDocument);
        }

        private XDocument getXDocument(ZipArchive zipArchive, string name)
        {
            // get the xml
            var contentXmlEntry = zipArchive.GetEntry(name);
            // parse the xml
            using var contentXmlStream = contentXmlEntry.Open();
            var xDocument = XDocument.Load(contentXmlStream);
            // return the document
            return xDocument;
        }
    }
}
