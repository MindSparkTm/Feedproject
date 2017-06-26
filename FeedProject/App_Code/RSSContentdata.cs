using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for RSSContentdata
/// </summary>
public class RSSContentdata
{
    public string title { get; set; }
    public string link { get; set; }
    public string pubDate { get; set; }

   

	public RSSContentdata()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public class RootObject
    {
        public string title { get; set; }
        public string pubDate { get; set; }
        public string link { get; set; }
        public string guid { get; set; }
        public string author { get; set; }
        public string thumbnail { get; set; }
        public string description { get; set; }
        public string content { get; set; }
        public RSSContentdata data { get; set; }
        public List<object> categories { get; set; }
    }
}