using System.Collections.Generic;

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
            Progress.ClearPhases();
            InkVisitorParser.PhaseParse.Register();
            InkVisitorParser.PhaseFilter.Register();
            TranslationTable.Phase.Register();
            List<SerializationFormatHandler> serializators = new();
            foreach (var l in Asset.OtherSupportedLanguages)
            {
                if (l.TSVFile != null)
                {
                    serializators.Add(
                        new TSVSerializationFormatHandler(l.LanguageCode, Asset));
                }
                if (l.ODSFile != null)
                {
                    serializators.Add(
                        new ODSSerializationFormatHandler(l.LanguageCode, Asset));
                }
                if (l.XLIFFFile != null)
                {
                    serializators.Add(
                        new XLIFFSerializationFormatHandler(l.LanguageCode, Asset));
                }
            }
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

                var textNodesFilter = new TextNodesFilter(Asset.SkipStringVariables);
                var tagNodesFilter = new TagNodesFilter(Asset.TranslationNotePrefix);
                var filenamesTracker = new FilenamesTracker(mainFilePath);

                new InkVisitorParser()
                    .RegisterInkVisitor(textNodesFilter)
                    .RegisterInkVisitor(tagNodesFilter)
                    .RegisterInkVisitor(filenamesTracker)
                    .WalkTree(mainFilePath);

                var fileLines = new FileLines(mainFilePath);

                var translationTable = new TranslationTable(
                    mainFilePath,
                    Asset.SourceLanguageCode,
                    fileLines,
                    textNodesFilter.TextNodesByLine,
                    tagNodesFilter.Tags);

                foreach (var serializator in serializators)
                {
                    serializator.Initialize(translationTable.Table);
                    serializator.Read();
                }
                foreach (var serializator in serializators)
                {
                    serializator.Write();
                }
                var translationGenerator = new TranslatedInkGenerator(
                    filenamesTracker.Filenames,
                    translationTable.Table,
                    mainFilePath,
                    Asset.OtherSupportedLanguages,
                    fileLines);
                translationGenerator.GenerateTranslations();
            }
            finally
            {
                Progress.Stop();
            }
        }
    }
}
