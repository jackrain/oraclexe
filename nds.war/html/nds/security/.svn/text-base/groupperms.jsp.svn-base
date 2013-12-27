<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
	String tabName= PortletUtils.getMessage(pageContext, "groupperms",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
String directory;
directory="GROUPPERM_LIST";
WebUtils.checkDirectoryReadPermission(directory,request);

String creationLink, title;
TableManager manager=TableManager.getInstance();
Table table= manager.getTable("Groups");
int tableId= table.getId();


Hashtable urls=new Hashtable();
// following is for updating each record
String modifyLink=NDS_PATH+"/security/grouperm_subsystem.jsp?table="+tableId;
urls.put(new Integer(0), modifyLink);
request.setAttribute("urls", urls);
QueryResult result=null;
QueryRequestImpl query=(QueryRequestImpl)request.getAttribute("query");
if(query ==null){
    query=QueryEngine.getInstance().createRequest(userWeb.getSession());
    query.setMainTable(tableId);
    query.setResultHandler(NDS_PATH+"/security/grouperm_subsystem.jsp");
    query.addSelection(table.getPrimaryKey().getId());
    query.addAllShowableColumnsToSelection(Column.QUERY_LIST);
    int[] orderKey= new int[]{ table.getPrimaryKey().getId()};
    query.setOrderBy(orderKey, false);
}
result= QueryEngine.getInstance().doQuery(query);
request.setAttribute("result", result);
request.setAttribute("urls", urls);

%>

<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">
  <tr>
          <td>
          <br>
          <br>
<%
int internal_table_width= ParamUtils.getIntAttribute(request,"internal_table_width", -1)-10;
%>          
<div style="behavior: url('<%=NDS_PATH+"/css/syncscroll.htc"%>');width: <%= internal_table_width%>px; <%=21>20?"height=520px;overflow-y: auto;":"overflow-y: hidden;"%> overflow-x: auto; border: 0px;hidden;padding:0px;padding:0px">           
            <table width="98%" border="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#999999">
              <tr><td>
            <br>
            <jsp:include page="/html/nds/query/inc_result.jsp" flush="true" />
              </td></tr>
            </table>
          </td>
</div>          
  </tr>
</table>
	
    </div>
</div>		
<%@ include file="/html/nds/footer_info.jsp" %>