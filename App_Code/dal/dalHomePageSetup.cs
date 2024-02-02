using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;


public class dalHomePageSetup
{
    DatabaseManager dm = new DatabaseManager();
    public dalHomePageSetup()
    {
    }
    public int Insert(string Category, int Sequence, string Title, string Content, string ImageLink, string YoutubeLink, string Status, string CreatedBy)
    {
        dm.AddParameteres("@Category", Category);
        dm.AddParameteres("@Sequence", Sequence);
        dm.AddParameteres("@Title", Title);
        dm.AddParameteres("@Content", Content);
        dm.AddParameteres("@ImageLink", ImageLink);
        dm.AddParameteres("@YoutubeLink", YoutubeLink);
        dm.AddParameteres("@Status", Status);
        dm.AddParameteres("@CreatedBy", CreatedBy);
        DataTable dt = dm.ExecuteQuery("USP_HomePageSetup_Insert");
        return Convert.ToInt32(dt.Rows[0][0].ToString());
    }
    public DataTable Update(int Id, string Category, int Sequence, string Title, string Content, string ImageLink, string YoutubeLink, string Status, string UpdatedBy)
    {
        dm.AddParameteres("@Id", Id);
        dm.AddParameteres("@Category", Category);
        dm.AddParameteres("@Sequence", Sequence);
        dm.AddParameteres("@Title", Title);
        dm.AddParameteres("@Content", Content);
        dm.AddParameteres("@ImageLink", ImageLink);
        dm.AddParameteres("@YoutubeLink", YoutubeLink);
        dm.AddParameteres("@Status", Status);
        dm.AddParameteres("@UpdatedBy", UpdatedBy);
        return dm.ExecuteQuery("USP_HomePageSetup_Update");
    }
    public DataTable GetAll_Active()
    {
        return dm.ExecuteQuery("USP_HomePageSetup_GetAll_Active");
    }
    public DataTable GetById(int id)
    {
        dm.AddParameteres("@Id", id);
        return dm.ExecuteQuery("USP_HomePageSetup_GetById");
    }
}