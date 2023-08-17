using System.Collections.Generic;
using UnityEditor;
using System.Linq;

namespace LemuRivolta.InkTranslate.Editor
{
    public static class Progress
    {
        public class Phase
        {
            public readonly string Info;
            public float Weight;

            public Phase(string info)
            {
                Info = info;
                Weight = 1;
            }

            private bool activated = false;

            public void Register()
            {
                if (activated)
                {
                    throw new System.InvalidProgramException("Cannot register an already registered phase");
                }
                phases.Add(this);
                activated = true;
            }

            public void Do(float progress)
            {
                Progress.Do(this, progress);
            }

            internal void Deactivate()
            {
                activated = false;
            }
        }

        private static readonly List<Phase> phases = new();

        private static float TotalWeight => phases.Sum(phase => phase.Weight);

        public static void ClearPhases()
        {
            foreach (var phase in phases)
            {
                phase.Deactivate();
            }
            phases.Clear();
        }

        private static float PreviousWeights(Phase phase)
        {
            float weight = 0;
            for (var i = 0; phases[i] != phase; i++)
            {
                weight += phases[i].Weight;
            }
            return weight;
        }

        private readonly static string title = "Syncing translations";

        public static void Do(Phase phase, float progress)
        {
            if (progress < 0 || progress > 1)
            {
                UnityEngine.Debug.LogWarning("progress out of bounds");
            }
            float actualProgress = (PreviousWeights(phase) + phase.Weight * progress)
                / TotalWeight;
            //UnityEngine.Debug.Log(actualProgress);
            EditorUtility.DisplayProgressBar(
                title,
                phase.Info,
                actualProgress);
        }

        public static void Stop()
        {
            EditorUtility.ClearProgressBar();
        }
    }

}
