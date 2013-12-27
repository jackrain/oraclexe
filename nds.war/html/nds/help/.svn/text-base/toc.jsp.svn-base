<%@ include file="/html/nds/help/init.jsp" %>
<%
  /**
  * @param 
  */
  TableManager manager=TableManager.getInstance();


  String tableName= request.getParameter("table");
  Table table= manager.findTable(tableName);
  if(table ==null){
  	out.print("table not found.");
  	return;
  }
  String comments= QueryUtils.getComments(table);
  if(comments==null) comments="";
%>
<script language="JavaScript" src="<%=WIKI_HELP_PATH%>/images/ExpCollapse.js"></script>

<span class='tablehead'><%= PortletUtils.getMessage(pageContext, "description",null)%></span><p>
<%=StringUtils.escapeHTMLTags(comments)%></p>
 
