<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<%
	String tabName= PortletUtils.getMessage(pageContext, "select-table",null);
%>
<p>
	Please note only Internet Explorer is supported.<p>
<script>
	document.title="<%=tabName%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
  // file should be uploaded
  String saveFile;
  Configurations conf=(Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS);
  
  saveFile= conf.getProperty("upload.root","")+ "/appdict";
  
            DiskFileUpload  fu = new DiskFileUpload();
            // maximum size before a FileUploadException will be thrown
            fu.setSizeMax(1024*1024*1024); // 1GB
            
            List fileItems = fu.parseRequest(request);
            Iterator iter = fileItems.iterator();
            InputStream in=null;
            String fileName="";
            while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {
                    } else {
                        in=item.getInputStream();
                        fileName= item.getName();
                        break;
                    }
            }
            if(in !=null ){//&& !nds.util.Validator.isNull(fileName)){
            	Tools.writeFile(in, saveFile+".script");
            	in.close();
	            System.out.println("Import "+ saveFile);
            }else{
            	// redirect to import.jsp
            	response.sendRedirect( NDS_PATH+"/schema/import.jsp");
            }
  
  // create property file
  SchemaUtils.createHSQLPropertyFile(conf.getProperty("upload.root",""), "appdict");
  // Load db ad_table_transfer information
  List al= (new SchemaUtils()).getTransferTableFromHSQLFile(saveFile);
%>
<br>

<form name="prefer_form" method="post" action="/control/command">
<input type='hidden' name="command" value="ImportSchema">
<input type="hidden" name="nds.control.ejb.UserTransaction" value="N">
<input type='hidden' name="scriptFile" value="<%=nds.util.Tools.encrypt(saveFile)%>">
<table border="0" cellspacing="0" cellpadding="0" align="center" width="90%">
<tr><td>
         	<table border="1" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" bordercolorlight="#999999" width="100%">
              <tr bgcolor="#EBF5FD">
                <td width="10%" align="center">
                  <span><%=PortletUtils.getMessage(pageContext, "select",null)%></span>
                </td>
                <td width="20%" align="center">
                  <span><%=PortletUtils.getMessage(pageContext, "table-name",null)%></span>
                </td>
                <td width="20%" align="center">
                  <span><%=PortletUtils.getMessage(pageContext, "table-description",null)%></span>
                </td>
                <td width="50%" align="center">
                  <span><%=PortletUtils.getMessage(pageContext, "table-comments",null)%></span>
                </td>
              </tr>
              <%
              	for(Iterator it= al.iterator(); it.hasNext();){
              		nds.model.AdTable tb= (nds.model.AdTable) it.next();
              		String cmt=StringUtils.escapeHTMLTags(StringUtils.shorten( tb.getComments(), 40));
              		if(nds.util.Validator.isNull(cmt)) cmt="&nbsp";
              %>
              	<tr> 
              		<td><input type='checkbox' name='ad_table' value='<%=tb.getName()%>' checked></td>
              		<td><%=tb.getName()%></td>
              		<td><%=tb.getDescription()%></td>
              		<td><%=cmt%></td>
              	</tr>
              <%	}
              %>
         	</table>
</td></tr>
<tr>
<td><br>

<input  type='button' name='Sbmit' value='<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>' onclick="javascript:submitForm(prefer_form);" >
<span id="tag_close_window"></span>
<Script language="javascript">
 // check show close window button or not
 if(  self==top){
 	document.getElementById("tag_close_window").innerHTML=
 	 "<input type='button' name='Cancle' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>' onclick='javascript:window.close();' >";
 }
</script>
 <br>
 </td></tr></table>
</form>		
    </div>
</div>		
<%@ include file="/html/nds/footer_info.jsp" %>
