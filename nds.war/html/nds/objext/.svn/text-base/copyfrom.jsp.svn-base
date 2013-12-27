<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
	String tabName=PortletUtils.getMessage(pageContext, "title.copyfrom",null);
	request.setAttribute("page_help", "CopyTo");
	int navTabTotalWidth=DEFAULT_TAB_WIDTH; //total table width
%>

<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=PortletUtils.getMessage(pageContext, "title.copyfrom",null)%>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="table_width" value="<%=String.valueOf(navTabTotalWidth)%>" />
</liferay-util:include>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * Things needed in this page:
     *  dest_table(*), fixedcolumns
     */
%>
<%
    TableManager manager= TableManager.getInstance();
    Table destTable=manager.getTable( ParamUtils.getIntParameter(request, "dest_table", -1));
    ArrayList al=new ArrayList();
    	for(Iterator it=manager.getAllTables().iterator();it.hasNext();){
    		Table tb= (Table)it.next();
    		if(tb.getRealTableName().equalsIgnoreCase(destTable.getRealTableName()) )
    			al.add(tb);
    	}
%>

<script>
    function pop_up_or_clear(src, url, window_name, sObjectID){
              var oWorkItem = src;

              if ( oWorkItem.name=="popup"){
                  // open new query window for anothter object
                  popup_window(url,window_name);
              }else{
                  //clear
                  document.getElementById(sObjectID + "_link").name="popup"; // reset to popup
                  document.getElementById(sObjectID+"_expr").value="";
                  document.getElementById(sObjectID+"_img").src="<%=NDS_PATH%>/images/find.gif";
                  document.getElementById(sObjectID+"_img").alt="<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>";
                  document.getElementById(sObjectID).readOnly =false;
                  document.getElementById(sObjectID).style.borderWidth="0px 0px 1px";
                  document.getElementById(sObjectID).style.backgroundColor='white';
                  document.getElementById(sObjectID).value="";
              }
     }
</script>
<br>
<table border="0" cellspacing="4" cellpadding="0" align="center" width="90%">

<form name="copyto_form" method="post" action="/control/command">
	<input type='hidden' name="command" value="CopyTo">
    <input type='hidden' name="mainobjecttableid" value="<%= ParamUtils.getIntAttributeOrParameter(request, "mainobjecttableid",-1)%>">
	<input type='hidden' name="dest_table" value="<%=request.getParameter("dest_table")%>">
	<input type='hidden' name="fixedcolumns" value="<%=request.getParameter("fixedcolumns")%>">
	<input type='hidden' name='arrayItemSelecter' value='selectedItemIdx'>
  <tr>
	<td colspan=2> 
    <%if (al.size()==0){%>
    <font color='red'><%=PortletUtils.getMessage(pageContext, "copyfrom.no-src-found",null)%></font>
    <%}else{%>
	<%=PortletUtils.getMessage(pageContext, "copyfrom-note",null)%>
	<%}%>
     </td>
  </tr>
		<%
		for(int i=0;i<al.size();i++){
			Table tb=(Table) al.get(i);
			boolean b=(tb.getId()==destTable.getId());
     		String column_acc_Id="filter_"+i;
     		String url="/html/nds/query/search.jsp?table="+tb.getId()+"&return_type=m&accepter_id="+column_acc_Id;
			
		%>
   <tr height="24"><td width="1%" nowrap>		
		<input type='radio' name='selectedItemIdx' value='<%=i%>' <%=(b==true?"checked":"")%>>
		<input type="hidden" name="src_table" value="<%=tb.getId()%>" ><%=tb.getDescription(locale)%>:
	</td><td align="left">	
<input readonly='on' type="text" id="<%=column_acc_Id%>" name="src_query" value='' size="60" maxlength="1500">
<span id='<%=column_acc_Id+"_link"%>' title="popup" onclick='oq.toggle("<%=url%>","<%=column_acc_Id%>")'><img id='<%=column_acc_Id+"_img"%>' border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'></span>
<script>createButton(document.getElementById("<%=column_acc_Id+"_link"%>"));</script>	
<input type="hidden" name="<%=column_acc_Id+"_expr"%>" name= "src_query_expr" value=''>
<input type="hidden" id="<%=column_acc_Id+"_sql"%>"  name="src_query_sql" value=''>
		
		<%
		}
		%>	
	</td></tr>
  <tr><td colspan=2><br>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align="left" height="22">
          <tr>
            <td align="left">
            <%if (al.size()>0){%>
             <input type="button" name="dosubmit" value="<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>" onClick="javascript:submitForm(copyto_form);" >
             <%@ include file="/html/nds/common/helpbtn.jsp"%>
             <%}%></td>
          </tr>
</table>	
</td></tr></form></table>
 
    </div>
</div>

<%@ include file="/html/nds/footer_info.jsp" %>
