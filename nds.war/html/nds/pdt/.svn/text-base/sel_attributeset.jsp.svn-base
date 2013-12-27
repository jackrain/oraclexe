<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
    /**
     * parameter:
		name - attributeset name. if set will redirect to attributesetinstance.jsp?input=true&setid=?
		fixedcolumns  - if set will try to figure out if it's set id, if true redirect to next page 
     */
     
String directory;
directory="M_ATTRIBUTESETINSTANCE_LIST";
WebUtils.checkDirectoryWritePermission(directory,request);

PairTable fixedColumns=PairTable.parseIntTable(request.getParameter("fixedcolumns"), null);    
int setId=Tools.getInt(fixedColumns.get(new Integer(TableManager.getInstance().getColumn("m_attributesetinstance","m_attributeset_id").getId())),-1);
if(setId!=-1  ){
	String name= request.getParameter("name");
	if(Validator.isNotNull(name)){
  		setId= Tools.getInt(QueryEngine.getInstance().doQueryOne("select id from m_attributeset where name="+ QueryUtils.TO_STRING(name)+" and ad_client_id="+userWeb.getAdClientId()),-1);
  	}
}
if(setId!=-1){
  	response.sendRedirect(NDS_PATH+"/pdt/attributesetinstance.jsp?setid="+setId);
	return;	
}

String tabName=PortletUtils.getMessage(pageContext, "select-attributeset",null);
%>

<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=PortletUtils.getMessage(pageContext, "select-attributeset",null)%>" />
</liferay-util:include>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * parameter:
		name - attributeset name. if set will redirect to attributesetinstance.jsp?input=true&setid=?
     */

     /**------check permission---**/
String msg=null;
String name= request.getParameter("name");
if(Validator.isNotNull(name)){
  msg= PortletUtils.getMessage(pageContext, "object-not-found",null);
}else name="";
String url=request.getContextPath()+"/servlets/query?table="+TableManager.getInstance().getTable("m_attributeset").getId()+"&return_type=s&accepter_id=form1.attributesetname";
%>
<script language="JavaScript" src="<%=NDS_PATH%>/js/formkey.js"></script>
<p>
<form name="form1" method="post" action="<%=NDS_PATH%>/pdt/sel_attributeset.jsp" >
<br>
<table align="center" border="0" cellpadding="1" cellspacing="1" width="90%">
<%if(msg!=null){%>
	<tr><td height="18" width="100%" nowrap align="center" colspan=2><font color='red'><%= msg%></font></td> </tr>	
<%}%>
    <tr><td height="18" width="40%" nowrap align="right"><%= PortletUtils.getMessage(pageContext, "name",null)%>:</td>
    <td height="18" width="60%" align="left"><input type='text' id="attributesetname" name='name' value='<%=name%>'>
    <span id="cbt_attributesetname"  onaction=popup_window("<%=url%>","<%="T"+System.currentTimeMillis() %>")><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
	<script>createButton(document.getElementById("cbt_attributesetname"));</script>	
    </td>
    </tr>
    <tr>
    <td></td>
    	<td align='left'>    <br>
<input  type='button' name='dosearch' value='<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>' onclick="submitForm(form1);" > &nbsp;&nbsp;
<span id="tag_close_window"></span>
<Script language="javascript">
 // check show close window button or not
 if(  self==top){
 	document.getElementById("tag_close_window").innerHTML=
 	 "<input type='button' name='Cancle' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>' onclick='javascript:window.close();' >";
 }
</script>
    	</td>
    </tr>
 </table>
 
 </form>
    </div>
</div>
		
<%@ include file="/html/nds/footer_info.jsp" %>
