using System;
using System.IO;
using System.Web.Services;

namespace CodeExercise
{
  public partial class viewer : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string GetPDFData()
    {
      return Convert.ToBase64String(File.ReadAllBytes(AppDomain.CurrentDomain.BaseDirectory + "Upload\\SampleDocument.pdf"));
    }
  }
}