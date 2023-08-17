using System.Collections.Generic;

namespace LemuRivolta.InkTranslate.Editor
{
    /// <summary>
    /// A class used to wrap the concept of double-indexed entities, by filename and by line.
    /// </summary>
    /// <typeparam name="T">The type of the entities indexed</typeparam>
    public class FileDict<T> : Dictionary<string, Dictionary<int, T>> { }
}
