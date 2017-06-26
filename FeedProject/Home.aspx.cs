using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home : System.Web.UI.Page
{
   public static Dbconfig d = new Dbconfig();
   public static DataTable dr = new DataTable();
   public static GridView gr = new GridView();
    protected void Page_Load(object sender, EventArgs e)
    {
        gr = Rssfeed;

    }


    
    
  

   

    [WebMethod]
    public static void updatefeed()
    {
        gridupdate();

    }
    protected void YourGrid_RowCommand(Object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            GridViewRow rowSelect = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int rowindex = rowSelect.RowIndex;
            Label lbl = (Label)Rssfeed.Rows[rowindex].FindControl("Label1");

            int articleid = Convert.ToInt32(lbl.Text.ToString());
            d.updateFeedviewcount(articleid);


        }
    }


    protected void Timer1_Tick(object sender, EventArgs e)
       {
           gridupdate(); 
       }

    protected void showfeed(object sender, EventArgs e)
    {
        dr = d.ViewFeeddata();

        if (dr.Rows.Count != 0)
        {
            gr.DataSource = dr;
            gr.DataBind();

            Displayfeedresult.Text = "";

        }

        else
        {
            Displayfeedresult.Text = "No New Feed found, click on the GetFeed button first to get newer feeds and then click on Display Feeds button";


        }
    }

    protected static void gridupdate()
    {
        gr.DataSource = null;
        gr.DataBind();
        DataTable ds = d.ViewFeeddatabymostViewedfeed();
        gr.DataSource = ds;
        gr.DataBind();
        
    }

  

    
}