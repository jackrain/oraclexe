<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
Properties props=EJBUtils.getApplicationConfig().getConfigurations("schema").getProperties();
if(! "true".equalsIgnoreCase(props.getProperty("modify","true"))){
	throw new NDSException("@no-permission@");
}

	String tabName=PortletUtils.getMessage(pageContext, "schema-import",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<br>
<script>
 function uploadform(form){
 	if(form.uploadfile.value=""){
 		alert("<%=PortletUtils.getMessage(pageContext, "must-select-file",null)%>");
    	return false;
    }
    submitForm(form);
 }
</script>
<table border="0" cellspacing="0" cellpadding="0" align="center" width="90%">
<tr>
<td><br>
         <%=PortletUtils.getMessage(pageContext, "import-schema-defintion-desc",null)%>
	<p>
	Please note only Internet Explorer is supported.<p>
<form name="prefer_form" method="post" enctype="multipart/form-data" action="<%=NDS_PATH%>/schema/import2.jsp">
  <%=PortletUtils.getMessage(pageContext, "file",null)%>:
  <input type="file" name="uploadfile" size="50" > 
  <p>
<input  type='button' name='nextstep' value='<%=PortletUtils.getMessage(pageContext, "next-step",null)%>' onclick="javascript:uploadform(prefer_form);" >
<span id="tag_close_window"></span>
<Script language="javascript">
 // check show close window button or not
 if(  self==top){
 	document.getElementById("tag_close_window").innerHTML=
 	 "<input type='button' name='Cancle' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>' onclick='javascript:window.close();' >";
 }
</script>
</form>
 <br>
 </td></tr></table>		
    </div>
</div>
<%@ include file="/html/nds/footer_info.jsp" %>
