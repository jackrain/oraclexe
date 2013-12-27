<%@ taglib uri="/WEB-INF/jspwiki.tld" prefix="wiki" %>
<%@ taglib uri="/WEB-INF/taglibs-i18n.tld" prefix="i18n" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
  <title><wiki:Variable var="applicationname"/>: <i18n:message key="UploadTemplate.addAttachment" /></title>
  <%@ include file="cssinclude.js" %>
  <META NAME="ROBOTS" CONTENT="NOINDEX">
</head>

<body class="upload" bgcolor="#FFFFFF">

      <h1 class="pagename"><i18n:message key="UploadTemplate.uploadAttachment" /> <wiki:PageName /></h1>
      <hr /><p>

      <wiki:HasAttachments>
         <B><i18n:message key="UploadTemplate.currentlyExisting" />:</B>

         <div class="attachments" align="center">
         <table width="90%">
         <wiki:AttachmentsIterator id="att">
             <tr>
             <td><wiki:LinkTo><%=att.getFileName()%></wiki:LinkTo></td>
             <td><wiki:PageInfoLink><img src="images/attachment_big.png" border="0" alt="<i18n:message key="UploadTemplate.infoOn" /> <%=att.getFileName()%>"></wiki:PageInfoLink></td>
             <td><%=att.getSize()%> <i18n:message key="UploadTemplate.bytes" /></td>
             </tr>
         </wiki:AttachmentsIterator>
         </table>
         </div>
         <hr />

      </wiki:HasAttachments>

      <table border="0" width="100%">
      <tr>
        <td>
           <form action="attach" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">

           <%-- Do NOT change the order of wikiname and content, otherwise the 
                servlet won't find its parts. --%>

           <input type="hidden" name="page" value="<wiki:Variable var="pagename"/>">

           <i18n:message key="UploadTemplate.instruction" />

           <P>
           <input type="file" name="content">
           <input type="submit" name="upload" value="<i18n:message key="UploadTemplate.upload" />">
           <input type="hidden" name="action" value="upload">
           <input type="hidden" name="nextpage" value="<wiki:UploadLink format="url"/>">
           </form>

        </td>

      </table>


</body>

</html>

