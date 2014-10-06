using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         
    }
    [WebMethod]
    public static string GetMoreArticles(int pageIndex)
    {
        return GetDataSets(pageIndex).GetXml(); 

    }

    public static DataSet GetDataSets(int pageIndex)
    {
        int pagesize = 10;
        string query = "[dbo].[SERVIR_LoadDataSetsPageWise]";
        SqlCommand cmd = new SqlCommand(query);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
        cmd.Parameters.AddWithValue("@PageSize", pagesize);
        cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
        return GetData(cmd, pagesize);
    }
    private static DataSet GetData(SqlCommand cmd, int pagesize)
    {
        string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
        using (SqlConnection con = new SqlConnection(strConnString))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;
                sda.SelectCommand = cmd;
                using (DataSet ds = new DataSet())
                {
                    sda.Fill(ds, "DataSets");
                    DataTable dt = new DataTable("PageCount");
                    dt.Columns.Add("PageCount");
                    dt.Rows.Add();
                    dt.Rows[0][0] = ((int.Parse(cmd.Parameters["@RecordCount"].Value.ToString()) / pagesize)+1).ToString();
                    ds.Tables.Add(dt);
                    return ds;
                }
            }
        }
    }


    #region Utilities

    /// <summary>
    /// 
    /// </summary>
    /// <param name="what"></param>
    /// <returns></returns>
    public static string CleanInput(string what)
    {
        string cleanChars = RemoveChars(what);
        return HttpContext.Current.Server.HtmlEncode(cleanChars);

    }
    static string RemoveChars(string str)
    {
        string[] split = str.Split(new char[] { '\t', '\r', '\n' }, StringSplitOptions.None);
        return split.Aggregate<string>((str1, str2) => str1 + str2);
    }


    #endregion

}