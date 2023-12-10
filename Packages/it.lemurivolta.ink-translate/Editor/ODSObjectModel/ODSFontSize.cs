namespace LemuRivolta.InkTranslate.Editor
{
    public class ODSFontSize
    {
        public static ODSFontSize Parse(string text)
        {
            if (text.EndsWith("pt"))
            {
                return new ODSLengthFontSize(float.Parse(text[..^2]), ODSSizeUnit.Pt);
            }
            else
            {
                throw new System.NotImplementedException($"Cannot parser length '{text}'");
            }
        }
    }
}
