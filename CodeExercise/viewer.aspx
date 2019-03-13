<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewer.aspx.cs" Inherits="CodeExercise.viewer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>ActivePDF Exercise</title>
  <!-- jQuery -->
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />

  <!-- SVG -->
  <script type="text/javascript" src="http://localhost:62625/ReaderPlus/GetResources?resourceName=P3Rest.ReaderPlusAgent.Resources.Scripts.Production.svg.min.js"></script>

  <!-- Reader Plus -->
  <script type="text/javascript" src="http://localhost:62625/ReaderPlus/GetResources?resourceName=P3Rest.ReaderPlusAgent.Resources.Scripts.Production.readerplus.min.js"></script>
  <link rel="stylesheet" type="text/css" href="http://localhost:62625/ReaderPlus/GetResources?resourceName=P3Rest.ReaderPlusAgent.Resources.Styles.readerplus.css" />

<script>
  window.onload = function () {

  // Initialization settings
  readerplus.initializeSettings({
    protocol: "http",
    hostname: 'localhost',
    port: 62625,
    language: 'en',
  });

  readerplus.Document.addEventListener("load", function () {
    // On document load you can add addtional options such as 
    // adding annotations, populating form fields and controlling 
    // elements of the user interface

    // Add new menu in Tools->Insert
    readerplus.mainmenu.Tools.Insert.addItem("SavePrint", "SavePrint", "CustomButton.jpg", false, "", "", function () { doSavePrint(); });
  });

  // Open document
  $.ajax({
    type: "POST",
    url: "viewer.aspx/GetPDFData",
    data: "{}",
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    async: false,
    success: function (data) {
      // Document settings
      var isMasterDocument = 1;
      var editMode = 1;

      // Upload the document into the viewer
      var result = readerplus.Document.upload(data.d, isMasterDocument, editMode, "", "SampleDocument.pdf");
      if (result.Status === 0) {
        // Save document ID in order to reopen a document from the Reader Plus data store
        var docID = readerplus.Document.getDocumentID();
        // Open document in edit mode
        readerplus.Document.edit(docID);
      }
      else {
        // Display alert on error
        alert('Document failed to open!')
        console.error(result.Details);
      }
    },
    error: function (xhr, status, error) {
      alert("Document failed to open!");
    }
  });
  }

  function doSavePrint() {
    readerplus.Document.save(); // ReaderPlus Print automatically saves the document first when calling Print so this is likely unnecessary
    readerplus.Document.print();
  }
</script>
<style>
  * {
		font-family: Arial;
	}
  #divHeader {
    text-align: center;
    font-weight: bold;
    color: blue;
    background-color: white;
    padding-bottom: 10px;
  }
</style>
</head>
<body>
  <div id="divHeader">
    Jeff Shapiro - ActivePDF Code Exercise
  </div>

  <div id="ReaderPlus" class="readerplus" style="width: 100%; height: 650px"></div>
</body>
</html>
