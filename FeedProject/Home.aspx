<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>HomePage</title>
    <script src="http://code.jquery.com/jquery-1.6.2.min.js"></script>
     <style type="text/css">
       
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p>This is a simple demo web application to display feeds and track user interactions with feeds</p>
          <asp:Button ID="GetFeed" runat="server" Text="GetToday's Feed from CNN" />
          <asp:Button ID="ViewFeed" runat="server" onclick="showfeed" Text="Display Feeds for Today" />


           
    <div id="news">
        <div>
            <asp:Label ID="Displayfeedresult" runat="server" Text="" Font-Size="Medium"></asp:Label>
        </div>
        <div>
            <a href="#"> <h3>Daily Feed from CNN</h3> </a>
            <small></small>
        </div>
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
 
      

      <asp:Timer ID="Timer1" runat="server" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
          <ContentTemplate>
             
            
 <asp:GridView ID="Rssfeed" runat="server" AutoGenerateColumns="false" onrowcommand="YourGrid_RowCommand" CssClass="Grid">
        
        
        <Columns>
            
            <asp:TemplateField HeaderText="Info">
                <ItemTemplate>
                    Articleid:
                    <asp:Label ID="Label1" Text='<%#Eval("articleid") %>' runat="server" />
                    <br />
                    Title :
                    <asp:Label ID="Label2" Text='<%#Eval("title") %>' runat="server" />
                    <br />
                    Link:
                 <asp:LinkButton ID="LinkButton2" runat="server" CommandName="View">
           <%#Eval("link") %></asp:LinkButton>  
                    <br />                
                    Publicationdate:
                    <asp:Label ID="Label3" Text='<%#Eval("publicationdate") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
                
        </Columns>
    </asp:GridView>

   </ContentTemplate>
          <Triggers>
              <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
 
          </Triggers>
 
      </asp:UpdatePanel>
 
        
        </div>
         <script type="text/javascript">

             $("#GetFeed").click(function (event) {
                 event.preventDefault();
                 var info = [];

                 $.ajax({
                     url: 'https://api.rss2json.com/v1/api.json',
                     method: 'GET',
                     dataType: 'json',
                     data: {
                         rss_url: 'http://rss.cnn.com/rss/edition.rss',
                         api_key: 'g986t9ckvrzysssizyvbeqldlskcgwss1t5gdoxk',
                         count: 50
                     }
                 }).done(function (response) {
                     console.log(response.status);
                     console.log('====== ' + response.feed.title + ' ======');
                     item = response.items;
                     //console.log("item",item);

                     $.each(item, function (key, value) {

                         info.push(value);
                     });
                     info = JSON.stringify(info);
                     //  console.log("info",info);

                     if (response.status == 'ok') {
                         $.ajax({
                             type: 'POST',
                             url: 'RSScontent.asmx/RSSfeeddata',
                             data: { info: info },
                             success: function (data) {

                                 console.log("data", data);

                             },
                             error: function (data) {
                                 console.log('error');
                                 console.log(data)
                             }
                         });
                     }
                 });


             });

             function UpdateGrid() {
                 // code for one time initialization
                 var info = [];

                 $.ajax({
                     url: 'https://api.rss2json.com/v1/api.json',
                     method: 'GET',
                     dataType: 'json',
                     data: {
                         rss_url: 'http://rss.cnn.com/rss/edition.rss',
                         api_key: 'g986t9ckvrzysssizyvbeqldlskcgwss1t5gdoxk', // put your api key here
                         count: 20
                     }
                 }).done(function (response) {
                     console.log(response.status);
                     console.log('====== ' + response.feed.title + ' ======');
                     item = response.items;
                     //console.log("item",item);

                     $.each(item, function (key, value) {

                         info.push(value);
                     });
                     info = JSON.stringify(info);
                     //  console.log("info",info);

                     if (response.status == 'ok') {
                         $.ajax({
                             type: 'POST',
                             url: 'RSScontent.asmx/RSSfeeddata',
                             data: { info: info },
                             success: function (data) {

                                 console.log("data", data);
                             },
                             error: function (data) {
                                 console.log('error');
                                 console.log(data)
                             }
                         });
                     }


                 });
                 $.ajax({

                     type: "POST",

                     url: "Home.aspx/updatefeed",

                     contentType: "application/json; charset=utf-8",

                     dataType: "json",

                     success: OnSuccess,

                     failure: function (response) {

                         //alert(response.d);

                     }

                 });

             }

             function OnSuccess(response) {

                 // alert(response.d);

             }

</script>

    </form>


</body>
</html>

