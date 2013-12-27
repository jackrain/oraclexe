<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
	String tabName= PortletUtils.getMessage(pageContext, "title.copyto",null);
	request.setAttribute("page_help", "CopyTo");
	int navTabTotalWidth=DEFAULT_TAB_WIDTH; //total table width
    TableManager manager= TableManager.getInstance();
    Table srcTable=manager.getTable( ParamUtils.getIntParameter(request, "src_table", -1));
    PairTable fixedColumns=PairTable.parseIntTable(request.getParameter("fixedcolumns"), null);
    int orderId=Tools.getInt(request.getParameter("objectids"),-1);
    String dv=String.valueOf(QueryEngine.getInstance().doQueryOne("select VALUE from AD_PARAM where NAME='portal.copyitem'"));
        if(orderId!=-1){
            //String tableName=srcTable.getRealTableName()==null?srcTable.getName():srcTable.getRealTableName();
            String tableName=srcTable.getName();
            int tableId=srcTable.getId();
            if(dv.contains(tableName)){
                response.sendRedirect("/copy_item/index.jsp?tableid="+tableId+"&id="+orderId);
            }
        }
    
%>

<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=PortletUtils.getMessage(pageContext, "title.copyto",null)%>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="table_width" value="<%=String.valueOf(navTabTotalWidth)%>" />
</liferay-util:include>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * Things needed in this page:
     *  src_table (*), objectids (*), dest_table, fixedcolumns
     */
%>
<%

    Table destTable=manager.getTable( ParamUtils.getIntParameter(request, "dest_table", -1));
    ArrayList al=new ArrayList();
    if(destTable ==null){
    	for(Iterator it=manager.getAllTables().iterator();it.hasNext();){
    		Table tb= (Table)it.next();
    		if(tb.getRealTableName().equalsIgnoreCase(srcTable.getRealTableName()) &&
    		   tb.isActionEnabled(Table.ADD) )
    			al.add(tb);
    	}
    	if(al.size()==1 && srcTable.getId()==((Table)al.get(0)).getId())destTable= (Table)al.get(0);
    }


%>
<script>
	<%
if(destTable!=null){
		// forward to copy command page
		%>
		window.location="<%="/control/command?command=CopyTo&src_table="+ srcTable.getId()+
		"&dest_table="+ destTable.getId()+"&fixedcolumns="+ 
		java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""))+
		"&objectids="+ java.net.URLEncoder.encode(request.getParameter("objectids"))%>";
<%		
	}	
	%>
	function gen_copydata(){
		submitForm(copyto_form);
	}
</script>
<br>

<table border="0" cellspacing="0" cellpadding="0" align="center" width="90%">
<form name="copyto_form" method="post" action="/control/command">
	<input type='hidden' name="src_table" value="<%=request.getParameter("src_table")%>">
	<input type='hidden' name="objectids" value="<%=request.getParameter("objectids")%>">
	<input type='hidden' name="fixedcolumns" value="<%=request.getParameter("fixedcolumns")%>">
	<input type='hidden' name="command" value="CopyTo">
  <tr>
	<td> 
    <%if (al.size()==0){%>
    <font color='red'><%=PortletUtils.getMessage(pageContext, "copyto.no-dest-found",null)%></font>
    <%}else{%>
	<%=PortletUtils.getMessage(pageContext, "copyto-note",null)%>
	<%}%>
      <br>
		<%
		for(int i=0;i<al.size();i++){
			Table tb=(Table) al.get(i);
			boolean b=(tb.getId()==srcTable.getId()) || (al.size()==1);
		%>
		<input type="radio" name="dest_table" value="<%=tb.getId()%>" <%=(b==true?"checked":"")%>><%=tb.getDescription(locale)%><br>
		<%
		}
		%>	
	</td>
  <tr><td>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align="left" height="22">
          <tr>
            <td align="left"><br>
            <%if (al.size()>0){%>
             <input type="button" name="dosubmit" value="<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>" onClick="javascript:gen_copydata();" >
             <%@ include file="/html/nds/common/helpbtn.jsp"%>
            <%}%> </td>
          </tr>
</table>	
</td></tr></form></table>
 
		
    </div>
</div>

<%@ include file="/html/nds/footer_info.jsp" %>
