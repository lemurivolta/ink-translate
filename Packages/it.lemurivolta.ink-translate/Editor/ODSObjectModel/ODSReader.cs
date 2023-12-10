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
            // get the main xml
            var contentXmlEntry = zipArchive.GetEntry("content.xml");
            // parse the main xml
            using var contentXmlStream = contentXmlEntry.Open();
            var xDocument = XDocument.Load(contentXmlStream);
            // wrap it in our main class
            return new ODSDocument(xDocument);
        }
    }
}
