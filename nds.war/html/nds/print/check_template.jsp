<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%@ page import="nds.report.*"%>
<%
/**
* check template of reports,include its relate tables
*  @param table* tableId to be checked
*
*/
int tableId= ParamUtils.getIntAttributeOrParameter(request, "table", -1);

// check directory write permission
TableManager manager=TableManager.getInstance();
String directory= manager.getTable("ad_report").getSecurityDirectory();
WebUtils.checkDirectoryWritePermission(directory, request);

Table table=manager.getTable(tableId);
// check template
ReportSyncManager sync=new ReportSyncManager();
sync.init(userWeb.getClientDomain());
sync.genReports(table);
// with its relate tables
ArrayList al=table.getRefByTables();
for(int i=0;i< al.size();i++){
	RefByTable rft=(RefByTable) al.get(i);
	sync.genReports(manager.getColumn(rft.getRefByColumnId()).getTable());
}
%>

<%= PortletUtils.getMessage(pageContext, "report-template-synchronized",null)%>

<%@ include file="/html/nds/footer_info.jsp" %>
