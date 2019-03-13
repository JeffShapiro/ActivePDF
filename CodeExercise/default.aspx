<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="CodeExercise._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>ActivePDF Exercise</title>
  <style>
    * {
			font-family: Arial;
		}
    #divHeader {
      text-align: center;
      font-weight: bold;
      color: blue;
    }
    #divUpload, #divConvert {
      width: 600px;
      margin-top: 15px;
      margin-left: auto;
      margin-right: auto;
      border: 1px solid black;
      text-align: center;
    }
    p {
      margin: 5px;
    }
  </style>
</head>
<body>
<form id="frmMain" runat="server">
  <div id="divHeader">
    Jeff Shapiro - ActivePDF Code Exercise
  </div>
  <asp:Panel ID="divUpload" runat="server">  
    <p>Please select an Image file to upload:</p>
    <p><asp:FileUpload ID="fileImage" runat="server" /></p>
    <p style="margin-top: 10px;"><asp:Button ID="btnUpload" runat="server" Text="Upload Image" OnClick="btnUpload_Click" /></p>
    <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
  </asp:Panel>

  <asp:Panel ID="divConvert" runat="server">
    <p><asp:Label ID="lblConvert" runat="server" Text=""></asp:Label></p>
    <p><asp:Button ID="btnConvert" runat="server" Text="Convert to PDF" OnClick="btnConvert_Click" /></p>
    <p><asp:Label ID="lblConvertStatus" runat="server" Text=""></asp:Label></p>
  </asp:Panel>
</form>
</body>
</html>
