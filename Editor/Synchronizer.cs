using System.Collections.Generic;

using static LemuRivolta.InkTranslate.Editor.SerializationFormatHandler;

namespace LemuRivolta.InkTranslate.Editor
{
    public class Synchronizer
    {
        private readonly InkTranslateAsset Asset;

        public Synchronizer(InkTranslateAsset asset)
        {
            Asset = asset;
        }

        public void Synchronize()
        {
            // create serializators
            List<SerializationFormatHandler> serializators = new();
            foreach (var l in Asset.OtherSupportedLanguages)
            {
                List<SerializationFormatHandlerFactory> factories = new();
                if (l.TSVFile != null)
                {
                    factories.Add(TSVSerializationFormatHandler.Factory);
                }
                if (l.ODSFile != null)
                {
                    factories.Add(ODSSerializationFormatHandler.Factory);
                }
                if (l.XLIFFFile != null)
                {
                    factories.Add(XLIFFSerializationFormatHandler.Factory);
                }
                foreach (var factory in factories)
                {
                    serializators.Add(
                        factory(l.LanguageCode,
                            Asset.SourceLanguageCode,
                            Asset.OtherSupportedLanguages));
                }
            }

            // set up progress phases
            Progress.ClearPhases();
            InkVisitorParser.PhaseParse.Register();
            InkVisitorParser.PhaseFilter.Register();
            TranslationTable.Phase.Register();
            foreach (var serializator in serializators)
            {
                serializator.PhaseRead.Register();
            }
            foreach (var serializator in serializators)
            {
                serializator.PhaseWrite.Register();
            }
            TranslatedInkGenerator.Phase.Register();

            try
            {
                string mainFilePath = Asset.InkFileAsset.GetPath().NormalizePath();

                // read the ink sources: the text nodes, the translation notes tags,
                // and info about files and their contents
                var textNodesFilter = new TextNodesFilter(Asset.SkipStringVariables);
                var tagNodesFilter = new TagNodesFilter(Asset.TranslationNotePrefix);
                var fileLines = new FileLines();
                new InkVisitorParser()
                    .RegisterInkVisitor(textNodesFilter)
                    .RegisterInkVisitor(tagNodesFilter)
                    .RegisterInkVisitor(fileLines)
                    .WalkTree(mainFilePath);

                // create a translation table from the contents in the ink files
                var translationTable = new TranslationTable(
                    mainFilePath,
                    Asset.SourceLanguageCode,
                    fileLines.FileContents,
                    textNodesFilter.TextNodesByLine,
                    tagNodesFilter.Tags);

                // read the translations from the files and save them in the translation
                // table
                foreach (var serializator in serializators)
                {
                    serializator.Initialize(translationTable.Table);
                    serializator.Read();
                }
                // save all the lines of the translation table in the files
                foreach (var serializator in serializators)
                {
                    serializator.Write();
                }
                // generate the translated ink files
                var translationGenerator = new TranslatedInkGenerator(
                    fileLines.Filenames,
                    translationTable.Table,
                    mainFilePath,
                    Asset.OtherSupportedLanguages,
                    fileLines.FileContents);
                translationGenerator.GenerateTranslations();
            }
            finally
            {
                // be sure to stop any progress bar running at the end
                Progress.Stop();
            }
        }
    }
}
