using System.IO;
using System.IO.Compression;
using System.Xml;
using System.Xml.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSWriter
    {
        public void Serialize(Stream stream, ODSDocument document)
        {
            // copy the stream in memory
            using var memoryStream = new MemoryStream();
            stream.CopyTo(memoryStream);
            memoryStream.Position = 0;
            // open the zip archive
            using (var zipArchive = new ZipArchive(memoryStream, ZipArchiveMode.Update, true))
            {
                // write both content and styles
                WriteXML(zipArchive, "content.xml", document.ContentXDocument);
                WriteXML(zipArchive, "styles.xml", document.StylesXDocument);
            }
            // copy back the memory into the stream
            stream.Position = 0;
            memoryStream.Position = 0;
            memoryStream.CopyTo(stream);
            stream.SetLength(stream.Position);
        }

        private void WriteXML(ZipArchive zipArchive, string entryName, XDocument document)
        {
            // delete the previous context.xml
            zipArchive.GetEntry(entryName).Delete();
            // write a new content.xml
            var contentXmlEntry = zipArchive.CreateEntry(entryName);
            using var contentXmlStream = contentXmlEntry.Open();
            using var xmlWriter = XmlWriter.Create(contentXmlStream, new()
            {
                Indent = true
            });
            document.WriteTo(xmlWriter);
        }
    }
}
