using System;
using System.IO;
using System.Web.Services;
using APToolkitNET;

namespace CodeExercise
{
  public partial class _default : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      // See if we're here for the first time
      if (!Page.IsPostBack)
      {
        // Start with the Upload panel visible and Convert panel hidden
        divConvert.Visible = false; 
      }
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
      lblStatus.Text = "";
      Session.Remove("imageFile");
      Session.Remove("pdfFile");

      if (fileImage.HasFile)
      {
        try
        {
          string filename = Path.GetFileName(fileImage.FileName);
          fileImage.SaveAs(Server.MapPath("~/Upload/") + filename);
          Session["imageFile"] = Server.MapPath("~/Upload/") + filename;
          lblStatus.Text = "File Uploaded!";
          divUpload.Visible = false;
          divConvert.Visible = true;
          lblConvert.Text = "Uploaded File: " + filename;
        }
        catch (Exception ex)
        {
          lblStatus.Text = "Error Uploading File: " + ex.Message;
        }
      }
      else
      {
        lblStatus.Text = "No File Selected!";
      }
    }

    protected void btnConvert_Click(object sender, EventArgs e)
    {
      // Instantiate Toolkit object
      Toolkit toolkit = new Toolkit();
      string imageFileName = (string)Session["imageFile"];
      // string pdfFileName = Server.MapPath("~/Upload/") + Path.GetFileNameWithoutExtension(imageFileName) + ".pdf";
      string pdfFileName = Server.MapPath("~/Upload/") + "SampleDocument.pdf"; // For this demo, hard code a file name to make things easier
      int result = toolkit.ImageToPDF(imageFileName, pdfFileName);
      if (result != 1)
      {
        lblConvertStatus.Text = "Error Converting Image to PDF (" + (result + "") + ")";
      }
      else
      {
        Session["pdfFile"] = pdfFileName;
        // lblConvertStatus.Text = "<a href=\"/Upload/" + Path.GetFileName(pdfFileName) + "\" target=\"_blank\">" + Path.GetFileName(pdfFileName) + "</a>";
        Response.Redirect("viewer.aspx");
      }
      
    }
  }
}