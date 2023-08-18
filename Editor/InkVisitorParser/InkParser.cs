using Ink;

using System.Collections.Generic;
using System.IO;

using IPObject = Ink.Parsed.Object;

namespace LemuRivolta.InkTranslate.Editor
{
    /// <summary>
    /// Visitor interface for the Ink parser.
    /// </summary>
    public class InkVisitorParser
    {
        public static readonly Progress.Phase PhaseParse =
            new("Parse all ink file contents");
        public static readonly Progress.Phase PhaseFilter =
            new("Filter lines with some text content");

        private readonly List<InkVisitor> inkVisitors = new();

        public InkVisitorParser RegisterInkVisitor(InkVisitor inkVisitor)
        {
            inkVisitors.Add(inkVisitor);
            return this;
        }

        /// <summary>
        /// Walks the parsed tree of an ink file.
        /// </summary>
        /// <param name="mainFilePath">Path of the main ink file.</param>
        public void WalkTree(
            string mainFilePath)
        {
            mainFilePath = mainFilePath.NormalizePath();

            PhaseParse.Do(0);
            BeginParsing(mainFilePath);

            var text = File.ReadAllText(mainFilePath);
            Compiler compiler = new(
                text,
                new Compiler.Options()
                {
                    sourceFilename = mainFilePath,
                    errorHandler = ErrorHandler,
                    fileHandler = new FileHandler(mainFilePath),
                });
            var story = compiler.Parse();

            PhaseParse.Do(1);

            PhaseFilter.Do(0);
            Visit(story);
            PhaseFilter.Do(1);
        }

        private void ErrorHandler(string message, ErrorType type)
        {
            foreach (var inkVisitor in inkVisitors)
            {
                inkVisitor.ErrorHandler(message, type);
            }
        }

        private void BeginParsing(string mainFilePath)
        {
            foreach (var inkVisitor in inkVisitors)
            {
                inkVisitor.BeginParsing(mainFilePath);
            }
        }

        private void Visit(
            IPObject parsedObject)
        {
            foreach (var visitor in inkVisitors)
            {
                visitor.VisitObject(parsedObject);
            }
            if (parsedObject.content != null)
            {
                foreach (var child in parsedObject.content)
                {
                    Visit(child);
                }
            }
        }


        private class FileHandler : IFileHandler
        {
            private readonly string mainFilePath;

            public FileHandler(string mainFilePath)
            {
                this.mainFilePath = mainFilePath;
            }

            public string LoadInkFileContents(string fullFilename) =>
                File.ReadAllText(fullFilename);

            public string ResolveInkFilename(string includeName) =>
                includeName.ResolveInkFilename(mainFilePath);
        }

    }
}
