
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for dalLibrary
/// </summary>
public class dalDocument
{
    DatabaseManager dm = new DatabaseManager();
    public dalDocument()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    #region 
    public DataTable InsertDocument(string Category, int ClassId, string Title, string FileName, string VisibleFileName, string Status, string CreatedBy)
    {
        dm.AddParameteres("@Category", Category);
        if (ClassId == 0)
        {
            dm.AddParameteres("@ClassId", DBNull.Value);
        }
        else
        {
            dm.AddParameteres("@ClassId", ClassId);
        }
        dm.AddParameteres("@Title", Title);
        if (string.IsNullOrEmpty(FileName))
        {
            dm.AddParameteres("@FileName", DBNull.Value);
        }
        else
        {
            dm.AddParameteres("@FileName", FileName);
        }
        if (string.IsNullOrEmpty(VisibleFileName))
        {
            dm.AddParameteres("@VisibleFileName", DBNull.Value);
        }
        else
        {
            dm.AddParameteres("@VisibleFileName", VisibleFileName);
        }
        dm.AddParameteres("@Status", Status);
        dm.AddParameteres("@CreatedBy", CreatedBy);
        return dm.ExecuteQuery("USP_Document_Insert");
    }
    public DataTable UpdateDocument(int Id, string Category, int ClassId, string Title, string FileName, string VisibleFileName, string Status, string UpdatedBy)
    {
        dm.AddParameteres("@Category", Category);
        dm.AddParameteres("@Id", Id);
        dm.AddParameteres("@ClassId", ClassId);
        dm.AddParameteres("@Title", Title);
        dm.AddParameteres("@FileName", FileName);
        dm.AddParameteres("@VisibleFileName", VisibleFileName);
        dm.AddParameteres("@Status", Status);
        dm.AddParameteres("@UpdatedBy", SessionManager.SessionName.UserName);
        return dm.ExecuteQuery("USP_Document_Update");
    }
    public DataTable GetDocumentByCriteria(string criteria)
    {
        dm.AddParameteres("@Criteria", criteria);
        return dm.ExecuteQuery("USP_Document_GetByCriteria");
    }
    public DataTable GetDocumentById(int id)
    {
        dm.AddParameteres("@Id", id);
        return dm.ExecuteQuery("USP_Document_GetById");
    }
    #endregion

}