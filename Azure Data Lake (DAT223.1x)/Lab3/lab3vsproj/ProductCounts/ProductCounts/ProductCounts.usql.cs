using Microsoft.Analytics.Interfaces;
using Microsoft.Analytics.Types.Sql;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace ProductCounts
{
    public static class Requests
    {
        public static string GetParameter(string queryString,
                                          string parameterName)
        {
            string paramValue = "";
            int startParam = queryString.IndexOf(parameterName + "=");
            if (startParam >= 0)
            {
                int startVal = queryString.IndexOf("=", startParam) + 1;
                int endVal = queryString.IndexOf("&", startVal);
                if (endVal < 0)
                {
                    endVal = queryString.Length;
                }
                paramValue = queryString.Substring(startVal, endVal - startVal);
            }
            return paramValue;
        }
    }
}
