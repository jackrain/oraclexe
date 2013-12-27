<%@ include file="/html/nds/help/init.jsp" %>
<%
  /**
  * @param table - table name
  */
  TableManager manager=TableManager.getInstance();
  String tableName= request.getParameter("table");
  Table table= manager.findTable(tableName);
  if(table ==null){
  	out.print("table not found.");
  	return;
  }
%>
<%=table.getDescription(locale)%>


