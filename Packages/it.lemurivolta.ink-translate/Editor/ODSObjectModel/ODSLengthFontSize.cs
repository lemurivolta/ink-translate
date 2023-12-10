namespace LemuRivolta.InkTranslate.Editor
{
    public enum ODSSizeUnit
    {
        // and many more
        Pt
    }

    public class ODSLengthFontSize : ODSFontSize
    {
        public float Value { get; private set; }
        public ODSSizeUnit Unit { get; private set; }

        public ODSLengthFontSize(float value, ODSSizeUnit unit)
        {
            if (value < 0)
            {
                throw new System.ArgumentOutOfRangeException(nameof(value), "value cannot be less than 0");
            }
            Value = value;
            Unit = unit;
        }

        public override string ToString() => Value.ToString() + (Unit switch
        {
            ODSSizeUnit.Pt => "pt",
            _ => throw new System.NotImplementedException($"Unit {Unit} is not implemented")
        });
    }
}
