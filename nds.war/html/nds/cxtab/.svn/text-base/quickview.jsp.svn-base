<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
	/** try loading available cxtabs, if more than one, will let user to choose, else, show report directly
	  @param query object
	  @param cxtabid (int) 
	*/
QueryRequestImpl query =(QueryRequestImpl) request.getAttribute("query");
Table factTable=query.getMainTable();
TableManager manager= TableManager.getInstance();
QueryEngine engine=QueryEngine.getInstance();
int cxtabId= Tools.getInt(request.getParameter("cxtabid"), -1);
List cxtabs=null;
if(cxtabId ==-1){
	Table table= manager.getTable("ad_cxtab");
	Expression secExpr= userWeb.getSecurityFilter(table.getName(), 1);
	Expression expr= new Expression(new ColumnLink(new int[]{manager.getColumn("ad_cxtab","ad_table_id").getId()}), 
	 "="+factTable.getId(), null);
	expr=expr.combine(secExpr, SQLCombination.SQL_AND,null);
	QueryRequestImpl cxtabQuery= QueryEngine.getInstance().createRequest(userWeb.getSession());
	cxtabQuery.setMainTable(table.getId());
	cxtabQuery.addSelection(table.getPrimaryKey().getId());
	cxtabQuery.addSelection(table.getAlternateKey().getId());
	cxtabQuery.addParam(expr);
	cxtabs= engine.doQueryList( cxtabQuery.toSQL());
	if(cxtabs.size()==1){
		cxtabId=Tools.getInt( ((List)cxtabs.get(0)).get(0), -1);
	}
}
if(cxtabId!=-1){
%>
<link rel="stylesheet" type="text/css" href="/html/nds/css/cxtab.css"/>
<script>
	document.title="<%=PortletUtils.getMessage(pageContext, "crosstab-report",null)%>";
	document.bgColor="<%=colorScheme.getPortletBg()%>";
</script>	
<%
	// create report and show it
	nds.cxtab.CxtabReport cr=new nds.cxtab.CxtabReport();
    cr.setCxtabId(cxtabId);
    cr.setFilterExpression(query.getParamExpression());
    cr.setUserId(userWeb.getUserId());
	cr.writeHtmlContent(out);
}else if(cxtabs!=null && cxtabs.size()>1){
	// show selection form
%>	
<script language="javascript">
document.title="<%=PortletUtils.getMessage(pageContext, "crosstab-report",null)%>";
document.bgColor="<%=colorScheme.getPortletBg()%>";
</script>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#999999" width="100%">
<form name="select_cxtab" id="select_cxtab" method="post" action="<%=request.getContextPath()+"/servlets/QueryInputHandler"%>">
	<input type="hidden" name="resulthandler" value="<%=NDS_PATH%>/cxtab/quickview.jsp">
    <%=QueryUtils.toHTMLControlForm(query)%>
     <tr>
      <td> <table border="0" cellspacing="5" cellpadding="0" align="left" width="600"><tr>
        <td align='center'><br><%=PortletUtils.getMessage(pageContext, "select-cxtab",null)%>:&nbsp;&nbsp;
<select name="cxtabid" >
<%	
    for(int i=0;i< cxtabs.size();i++){
%>
	 <option value="<%= ((List)cxtabs.get(i)).get(0)%>" <%=(i==0?"selected":"")%>><%= ((List)cxtabs.get(i)).get(1)%></option>      		
<%      
    }
%>
</select>          
		</td></tr>
		<tr><td align='center'><br>
			<input  type='button' name='gotoview' value='<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>' onclick="select_cxtab.submit()">
		</td></tr>
		</table>
 	  </td>
 	</tr>
</form> 	
</table>
<%
} //end selection form
else{
	// tell that no tab found
%>	
	<font color="red"><%= PortletUtils.getMessage(pageContext, "no-cxtab-available",null)%></font>
<%
}
%>

<%@ include file="/html/nds/footer_info.jsp" %>

