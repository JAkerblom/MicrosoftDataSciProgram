namespace DataUtilities
{
    public class Converter
    {
        public static float BytesToKb(long? bytes)
        {
            return (float)bytes / 1000;
        }
    }
}