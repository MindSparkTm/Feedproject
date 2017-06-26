using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Configuration;
using System.Web.Script.Services;
using System.Web.Services;
using System.Xml;
/// <summary>
/// Summary description for RSScontent
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class RSScontent : System.Web.Services.WebService {

    Dbconfig dr = new Dbconfig();
    DataTable dt = new DataTable();
    private string info;
    public RSScontent () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod]
    public void RSSfeeddata(string info) {
        List<RSSContentdata> list = JsonConvert.DeserializeObject<List<RSSContentdata>>(info);

        dt = JsontoDataTableconversion.ToDataTable<RSSContentdata>(list);

        dr.insertrecords(dt);
       dr.ViewFeeddata();

        
    }

   

    
}
public static class JsontoDataTableconversion
{
    public static DataTable ToDataTable<T>(this IList<T> data)
    {
        PropertyDescriptorCollection props =
        TypeDescriptor.GetProperties(typeof(T));
        DataTable table = new DataTable();
        for (int i = 0; i < props.Count; i++)
        {
            PropertyDescriptor prop = props[i];
            table.Columns.Add(prop.Name, prop.PropertyType);
        }
        object[] values = new object[props.Count];
        foreach (T item in data)
        {
            for (int i = 0; i < values.Length; i++)
            {
                values[i] = props[i].GetValue(item);
            }
            table.Rows.Add(values);
        }
        return table;
    }



}

