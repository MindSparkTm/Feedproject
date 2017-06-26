using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Dbconfig
/// </summary>
public class Dbconfig
{
    string consString = "";
	public Dbconfig()
	{
		
      consString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

	}

    public int checkifrecordsexist()
    {
        int count = 0;
        try
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(consString))
            {

                using (SqlCommand cmd = new SqlCommand("checkiffeedalreadyexists", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {

                        da.Fill(dt);
                        count = dt.Rows.Count;
                        if (count > 0)
                            return count;

                       
                    }
                }

            }
        }
        catch (Exception ex)
        {

        }
        return count;

    }
    public void insertrecords(DataTable dt)
    {
        int res = checkifrecordsexist();

       if(res==0){


           try
           {
               using (SqlConnection con = new SqlConnection(consString))
               {

                   using (SqlCommand cmd = new SqlCommand("Insert_Feed"))
                   {
                       cmd.CommandType = CommandType.StoredProcedure;
                       cmd.Connection = con;
                       cmd.Parameters.AddWithValue("@tblFeed", dt);
                       con.Open();
                       cmd.ExecuteNonQuery();
                       con.Close();
                   }

               }
           }
           catch (Exception ex)
           {

           }



       }


        
       


    }

   
    public DataTable ViewFeeddata()
    {
        DataTable dt = new DataTable();

        try
        {
            using (SqlConnection con = new SqlConnection(consString))
            {

                using (SqlCommand cmd = new SqlCommand("GetFeeddata",con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {

                        da.Fill(dt);
                        
                    }
                }

            }
        }
        catch (Exception ex)
        {

        }



        return dt;
    }

    public DataTable ViewFeeddatabymostViewedfeed()
    {
        DataTable dt = new DataTable();

        try
        {
            using (SqlConnection con = new SqlConnection(consString))
            {

                using (SqlCommand cmd = new SqlCommand("GetFeeddatabyViewCount", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {

                        da.Fill(dt);

                    }
                }

            }
        }
        catch (Exception ex)
        {

        }



        return dt;
    }



    public void updateFeedviewcount(int article_id)
    {

        try
        {
            using (SqlConnection con = new SqlConnection(consString))
            {

                using (SqlCommand cmd = new SqlCommand("Update_FeedCount"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@id", article_id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

            }
        }
        catch (Exception ex)
        {

        }






    }
}