<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
  /**
    * recreate closure table records
      @param table- int id of table
  */
String tabName=PortletUtils.getMessage(pageContext, "close-tree-structure",null);
%>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">

<%
    /**
     * Things needed in this page:
     *  table(*), table id
     */
%>
<%
    TableManager manager= TableManager.getInstance();
    Table table=manager.getTable( ParamUtils.getIntParameter(request, "table", -1));
%>

<br>
<table border="0" cellspacing="4" cellpadding="0" align="center" width="90%">

<form name="closetree_form" method="post" action="/control/command">
	<input type='hidden' name="command" value="CloseTreeTable">
    <input type='hidden' name="table" value="<%=table.getId()%>">
  <tr>
	<td> 
	<%=PortletUtils.getMessage(pageContext, "do-you-confirm-close-tree",null)%>
     </td>
  </tr>
  <tr><td><br>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align="left" height="22">
   <tr>
     <td align="left">
     <input type="button" name="dosubmit" value="<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>" onClick="javascript:submitForm(closetree_form);" >
 	 </td>
   </tr>
</table>	
</td></tr></form></table>
    </div>
</div>
<%@ include file="/html/nds/footer_info.jsp" %>  

