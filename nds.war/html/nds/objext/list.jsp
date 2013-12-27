<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<liferay-util:include page="/html/nds/sheet/header.jsp">
	<liferay-util:param name="show_top" value="false" />
</liferay-util:include>
<script>
document.bgColor="#EEEEEE";
document.body.style.margin="0px 0px 0px 0px";
var isLoaded=false;
</script>
<SCRIPT FOR=window EVENT=onload LANGUAGE="JavaScript">
    isLoaded=true;
</SCRIPT>

<%
TableManager manager=TableManager.getInstance();
String viewType= request.getParameter("viewtype");
int tableId= ParamUtils.getIntAttributeOrParameter(request, "table", -1);
tableId= ParamUtils.getIntAttributeOrParameter(request, "sheet", tableId);
Table table;
if( tableId == -1) {
    String tableName=  request.getParameter("table") ;
    table= manager.getTable(tableName);
    if( table !=null) tableId= table.getId();
    else {
        out.println("Internal Error:object-not-set");
        return;
    }
}else{
    table= manager.getTable(tableId);
}
// record to visit log
if(table!=null) userWeb.registerVisit(table.getId());

if(table.isTree() && "tree".equalsIgnoreCase(viewType) ){
%>
 <jsp:include page="/html/nds/sheet/inc_list_tree.jsp" flush="true"/>
<%}else{%>
<jsp:include page="/html/nds/sheet/inc_list.jsp" flush="true"/>
<%}%> 
<%@ include file="/html/nds/footer.jsp" %>

