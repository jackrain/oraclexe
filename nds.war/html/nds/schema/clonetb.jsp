<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
	String tabName=PortletUtils.getMessage(pageContext, "clone-table",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * parameter:
     *      1.  objectid  - table id of the source
     */

     /**------check permission---**/
String directory;
directory="AD_TABLE_LIST";
WebUtils.checkDirectoryWritePermission(directory,request);


int tableId= ParamUtils.getIntParameter(request, "objectid", -1);
String tableName=(String) QueryEngine.getInstance().doQueryOne("select name from ad_table where id="+ tableId);

%>
<script language="JavaScript" src="<%=NDS_PATH%>/js/formkey.js"></script>
<script>
	function checkOptions(form){
		if( isWhitespace(form.destable.value)){
			alert("<%= PortletUtils.getMessage(pageContext, "please-enter-table-name",null)%>");
			return false;
		}
		submitForm(form); 
	}
</script>
<p>
<form name="form1" method="post" action="<%=contextPath%>/control/command" >
<br>
<table align="center" border="0" cellpadding="1" cellspacing="1" width="90%">
<input type="hidden" name="command" value="CloneTable">
<input type="hidden" name="srctable" value="<%=tableName%>">
	<tr><td align="right"><%= PortletUtils.getMessage(pageContext, "src_table",null)%>:</td>
	<td nowrap><%=tableName%></td>
	</tr>

    <tr><td height="18" width="50%" nowrap align="right"><%= PortletUtils.getMessage(pageContext, "dest-table-name",null)%>:</td>
    <td height="18" width="50%" align="left"><input type='text'  name='destable' value=''></td>
    </tr>
    <tr><td height="18" width="50%" nowrap align="right"><%= PortletUtils.getMessage(pageContext, "dest-table-desc",null)%>:</td>
    <td height="18" width="50%" align="left"><input type='text' name='destdesc' value=''></td>
    </tr>
    <tr>
    <td></td>
    	<td align='left'>    <br>
<input  type='button' name='DoAction' value='<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>' onclick="javascript:checkOptions(document.form1);" > &nbsp;&nbsp;
<span id="tag_close_window"></span>
<Script language="javascript">
 // check show close window button or not
 if(  self==top){
 	document.getElementById("tag_close_window").innerHTML=
 	 "<input type='button' name='Cancle' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>' onclick='javascript:window.close();' >";
 }
</script>
    	</td>
    	<td>
    	</td>
    </tr>
 </table>
 
 </form>

    </div>
</div>
<%@ include file="/html/nds/footer_info.jsp" %>
