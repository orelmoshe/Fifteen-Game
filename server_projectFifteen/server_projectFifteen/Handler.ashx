<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;

public class Handler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.QueryString["numOfClick"] == null
                || Int32.Parse(context.Request.QueryString["numOfClick"]) != 2)
        {
            context.Response.Write("X");
            return;
        }

        int[] arr1_x = castArrayStringToInt(context.Request.QueryString["list1_x"].Split('_'));
        int[] arr1_y = castArrayStringToInt(context.Request.QueryString["list1_y"].Split('_'));
        int[] arr2_x = castArrayStringToInt(context.Request.QueryString["list2_x"].Split('_'));
        int[] arr2_y = castArrayStringToInt(context.Request.QueryString["list2_y"].Split('_'));

        int dis1_x = distance(arr1_x[0], arr1_x[arr1_x.Length - 1]);
        int dis1_y = distance(arr1_y[0], arr1_y[arr1_y.Length - 1]);
        int dis2_x = distance(arr2_x[0], arr2_x[arr2_x.Length - 1]);
        int dis2_y = distance(arr2_y[0], arr2_y[arr2_y.Length - 1]);

        string res = "";

        // אם גוף החץ צוייר ראשון
        if (Max(dis1_x, dis1_y) > Max(dis2_x, dis2_y))
        {
            res = checkDraw(arr1_x, arr1_y, arr2_x, arr2_y);
        }
        // אם ראש החץ צוייר ראשון
        else
        {
            res = checkDraw(arr2_x, arr2_y, arr1_x, arr1_y);
        }

        context.Response.Write(res);
    }

    public string checkDraw(int[] arr1_x, int[] arr1_y, int[] arr2_x, int[] arr2_y)
    {
        // אם מדובר בקשקוש ולא בחץ
        if (findExtremePoints(arr1_x) > 3
                || findExtremePoints(arr1_y) > 3
                || findExtremePoints(arr2_x) > 2
                || findExtremePoints(arr2_y) > 2)
        {
            return "X";
        }

        string res = "";
        // אם גוף החץ מאונך
        if (distance(arr1_x[0], arr1_x[arr1_x.Length - 1]) < distance(arr1_y[0], arr1_y[arr1_y.Length - 1]))
        {
            // אם גוף החץ צוייר מלמעלה ללמטה
            if (arr1_y[arr1_y.Length - 1] > arr1_y[0])
            {
                // אם ראש החץ מצביע למטה
                if (getMaxNumber(arr2_y) != arr2_y[0] && getMaxNumber(arr2_y) != arr2_y[arr2_y.Length - 1])
                {
                    // אם ראש החץ קרוב לגוף החץ
                    if (between(arr2_x[0], arr1_x[arr1_x.Length - 1], arr2_x[arr2_x.Length - 1])
                        && distance(getMaxNumber(arr2_y), arr1_y[arr1_y.Length - 1]) <= 2 * distance(getMaxNumber(arr2_y), arr2_y[0]))
                    {
                        res = "D";
                    }
                    // אם ראש החץ רחוק מגוף החץ
                    else
                    {
                        res = "X";
                    }
                }
                // אם ראש החץ מצביע למעלה
                else
                {
                    // אם ראש החץ קרוב לגוף החץ
                    if (between(arr2_x[0], arr1_x[0], arr2_x[arr2_x.Length - 1])
                        && distance(getMinNumber(arr2_y), arr1_y[0]) <= 2 * distance(getMinNumber(arr2_y), arr2_y[0]))
                    {
                        res = "U";
                    }
                    // אם ראש החץ רחוק מגוף החץ
                    else
                    {
                        res = "X";
                    }
                }
            }
            // אם גוף החץ צוייר מלמטה ללמעלה
            else
            {
                // אם ראש החץ מצביע למטה
                if (getMaxNumber(arr2_y) != arr2_y[0] && getMaxNumber(arr2_y) != arr2_y[arr2_y.Length - 1])
                {
                    // אם ראש החץ קרוב לגוף החץ
                    if (between(arr2_x[0], arr1_x[0], arr2_x[arr2_x.Length - 1])
                        && distance(getMaxNumber(arr2_y), arr1_y[0]) <= 2 * distance(getMaxNumber(arr2_y), arr2_y[0]))
                    {
                        res = "D";
                    }
                    // אם ראש החץ רחוק מגוף החץ
                    else
                    {
                        res = "X";
                    }
                }
                // אם ראש החץ מצביע למעלה
                else
                {
                    // אם ראש החץ קרוב לגוף החץ
                    if (between(arr2_x[0], arr1_x[arr1_x.Length - 1], arr2_x[arr2_x.Length - 1])
                        && distance(getMinNumber(arr2_y), arr1_y[arr1_y.Length - 1]) <= 2 * distance(getMinNumber(arr2_y), arr2_y[0]))
                    {
                        res = "U";
                    }
                    // אם ראש החץ רחוק מגוף החץ
                    else
                    {
                        res = "X";
                    }
                }
            }
        }
        // אם גוף החץ מאוזן
        else
        {
            // אם גוף החץ צוייר משמאל לימין
            if (arr1_x[arr1_x.Length - 1] > arr1_x[0])
            {
                // אם ראש החץ מצביע לימין
                if (getMaxNumber(arr2_x) != arr2_x[0] && getMaxNumber(arr2_x) != arr2_x[arr2_x.Length - 1])
                {
                    // אם ראש החץ קרוב לגוף החץ
                    if (between(arr2_y[0], arr1_y[arr1_y.Length - 1], arr2_y[arr2_y.Length - 1])
                        && distance(getMaxNumber(arr2_x), arr1_x[arr1_x.Length - 1]) <= 2 * distance(getMaxNumber(arr2_x), arr2_x[0]))
                    {
                        res = "R";
                    }
                    // אם ראש החץ רחוק מגוף החץ
                    else
                    {
                        res = "X";
                    }
                }
                // אם ראש החץ מצביע לשמאל
                else
                {
                    // אם ראש החץ קרוב לגוף החץ
                    if (between(arr2_y[0], arr1_y[0], arr2_y[arr2_y.Length - 1])
                        && distance(getMinNumber(arr2_x), arr1_x[0]) <= 2 * distance(getMinNumber(arr2_x), arr2_x[0]))
                    {
                        res = "L";
                    }
                    // אם ראש החץ רחוק מגוף החץ
                    else
                    {
                        res = "X";
                    }
                }
            }
            // אם גוף החץ צוייר מימין לשמאל
            else
            {
                // אם ראש החץ מצביע לימין
                if (getMaxNumber(arr2_x) != arr2_x[0] && getMaxNumber(arr2_x) != arr2_x[arr2_x.Length - 1])
                {
                    // אם ראש החץ קרוב לגוף החץ
                    if (between(arr2_y[0], arr1_y[0], arr2_y[arr2_y.Length - 1])
                        && distance(getMaxNumber(arr2_x), arr1_x[0]) <= 2 * distance(getMaxNumber(arr2_x), arr2_x[0]))
                    {
                        res = "R";
                    }
                    // אם ראש החץ רחוק מגוף החץ
                    else
                    {
                        res = "X";
                    }
                }
                // אם ראש החץ מצביע לשמאל
                else
                {
                    // אם ראש החץ קרוב לגוף החץ
                    if (between(arr2_y[0], arr1_y[arr1_y.Length - 1], arr2_y[arr2_y.Length - 1])
                        && distance(getMinNumber(arr2_x), arr1_x[arr1_x.Length - 1]) <= 2 * distance(getMinNumber(arr2_x), arr2_x[0]))
                    {
                        res = "L";
                    }
                    // אם ראש החץ רחוק מגוף החץ
                    else
                    {
                        res = "X";
                    }
                }
            }
        }
        return res;
    }

    public int[] castArrayStringToInt(string[] A)
    {
        int[] res = new int[A.Length - 1];
        for (int i = 0; i < A.Length - 1; i++)
        {
            res[i] = Int32.Parse(A[i]);
        }
        return res;
    }

    public int Max(int x, int y)
    {
        if (x > y)
            return x;
        else
            return y;
    }

    public int distance(int a, int b)
    {
        return Math.Abs(a - b);
    }

    public int getMaxNumber(int[] A)
    {
        int max = A[0];
        foreach (int x in A)
        {
            if (x > max)
                max = x;
        }
        return max;
    }

    public int getMinNumber(int[] A)
    {
        int min = A[0];
        foreach (int x in A)
        {
            if (x < min)
                min = x;
        }
        return min;
    }

    public bool between(int x, int middle, int y)
    {
        return (x < middle && middle < y || x > middle && middle > y);
    }

    public int findExtremePoints(int[] A)
    {
        if (A.Length == 0)
            return 0;

        int c = 0;
        bool flag = false;

        for (int i = 1; i < A.Length; i++)
        {
            if (A[i] < A[i - 1] && flag == false)
            {
                c++;
                flag = true;
                continue;
            }
            if (A[i] > A[i - 1] && flag == true)
            {
                c++;
                flag = false;
            }
        }

        return c;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}