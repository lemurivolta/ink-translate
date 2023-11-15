using System.Collections.Generic;
using System.Collections.Specialized;
using System.Runtime.CompilerServices;

namespace LemuRivolta.InkTranslate.Editor
{
    /// <summary>
    /// A bag of (indexed) strings, used to find the most similar string to the
    /// one given.
    /// </summary>
    /// <typeparam name="TKey">Type of the index (keys)</typeparam>
    internal class StringsBag<TKey>
    {
        /// <summary>
        /// The internal dictionary of sets of trigrams
        /// </summary>
        private readonly Dictionary<TKey, ISet<string>> bag;

        private StringsBag() =>
            bag = new();

        /// <summary>
        /// Add a new string to the bag.
        /// </summary>
        /// <param name="key">Key of this string.</param>
        /// <param name="value">The string to add.</param>
        public void AddString(TKey key, string value) =>
            bag[key] = GetTrigrams(value);

        /// <summary>
        /// Get the key of the string most similar to the one given.
        /// </summary>
        /// <param name="search">The string to search.</param>
        /// <returns>The key of the most similar string.</returns>
        public TKey GetMostSimilarStringKey(string search)
        {
            var bestMatchCount = 0;
            TKey bestMatchKey = default;

            var myTrigrams = GetTrigrams(search);

            foreach (var key in bag.Keys)
            {
                var count = 0;
                foreach (var a in bag[key])
                {
                    if (myTrigrams.Contains(a))
                    {
                        count++;
                    }
                }

                if (count > bestMatchCount)
                {
                    bestMatchKey = key;
                    bestMatchCount = count;
                }
            }

            return bestMatchKey;
        }

        /// <summary>
        /// Get all the trigrams of the given string.
        /// </summary>
        /// <param name="s">The string to examine.</param>
        /// <returns>The list of its trigrams.</returns>
        private ISet<string> GetTrigrams(string s)
        {
            s = $"^^{s}$$";

            HashSet<string> set = new(s.Length - 2);
            for (var i = 0; i < s.Length - 3; i++)
            {
                set.Add(s[i..(i + 3)]);
            }

            return set;
        }
    }
}
