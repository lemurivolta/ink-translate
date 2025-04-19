using Ink;

using UnityEngine;

namespace LemuRivolta.InkTranslate.Editor
{
    /// <summary>
    /// Base class for parse visitors.
    /// </summary>
    public class InkVisitor
    {
        /// <summary>
        /// Called when the Ink parser starts.
        /// <paramref name="mainFilePath">Path of the main file being parsed.</paramref>
        /// </summary>
        public virtual void BeginParsing(string mainFilePath) { }

        /// <summary>
        /// Called when we visit a file during parsing.
        /// </summary>
        /// <param name="filename">The filename, expressed as a main ink file relative path.</param>
        /// <param name="contents">The full contents of the file.</param>
        public virtual void VisitFile(string filename, string contents) { }

        /// <summary>
        /// Called when there's a new node to process.
        /// </summary>
        /// <param name="o">The object to visit.</param>
        public virtual void VisitObject(Ink.Parsed.Object o) { }

        /// <summary>
        /// Called if there's a parsing error.
        /// </summary>
        /// <param name="message">The error message.</param>
        /// <param name="type">The error type.</param>
        public virtual void ErrorHandler(string message, ErrorType type)
        {
            switch (type)
            {
                case ErrorType.Author: Debug.Log(message); break;
                case ErrorType.Warning: Debug.LogWarning(message); break;
                case ErrorType.Error: Debug.LogError(message); break;
            }
        }
    }
}
