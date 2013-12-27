<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
	String tabName=PortletUtils.getMessage(pageContext, "select-view",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
		<%
    /**
     * Things needed in this page:
     *  table* - (String) format: "tableId1_tableId2_"
     *  id* - (int) record id
     */
%>
<%
    
	TableManager manager=TableManager.getInstance();
	String tableNames = request.getParameter("table");
	int objectId= ParamUtils.getIntAttributeOrParameter(request, "id", -1);
%>
  

<br>
<table border="0" cellspacing="5" cellpadding="0" align="center" width="90%"><tr>
    <td align='left'><%=PortletUtils.getMessage(pageContext, "option-views",null)%></td></tr>
        	
<%		
	
	Table table;
    StringTokenizer st=new StringTokenizer(tableNames, "_");
    while(st.hasMoreTokens()){
       table= manager.getTable(Tools.getInt(st.nextToken(),-1));
       if( table !=null){
%>
	 <tr>
    <td align='left'>&nbsp; &nbsp;-- &nbsp;<a href="<%=NDS_PATH+ "/object/object.jsp?input=true&id=" + objectId+"&table="+table.getId()%>"><%=table.getDescription(locale)%></a>
	</td></tr>
<%       }
    }
%>

</table>
    </div>
</div>


<%@ include file="/html/nds/footer_info.jsp" %>
