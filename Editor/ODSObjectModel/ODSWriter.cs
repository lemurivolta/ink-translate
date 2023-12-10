using System.IO;
using System.IO.Compression;
using System.Xml;

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
                // delete the previous context.xml
                zipArchive.GetEntry("content.xml").Delete();
                // write a new content.xml
                var contentXmlEntry = zipArchive.CreateEntry("content.xml");
                using var contentXmlStream = contentXmlEntry.Open();
                using var xmlWriter = XmlWriter.Create(contentXmlStream, new()
                {
                    Indent = true
                });
                document.XDocument.WriteTo(xmlWriter);
            }
            // copy back the memory into the stream
            stream.Position = 0;
            memoryStream.Position = 0;
            memoryStream.CopyTo(stream);
            stream.SetLength(stream.Position);
        }
    }
}
