<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
	/**
	Create C_Filter.expression
	@param objectid - c_filter.id
	*/
	String tabName=PortletUtils.getMessage(pageContext, "create-filter",null);
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=tabName%>" />
</liferay-util:include>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * Create C_Filter.expression
	@param objectid - c_filter.id
     */

     /**------check permission on c_filter modification---**/
int filterId= Tools.getInt(request.getParameter("objectid"),-1);
if(!userWeb.hasObjectPermission("C_FILTER", filterId, nds.security.Directory.WRITE)) 
	throw new NDSException(PortletUtils.getMessage(pageContext, "no-permission",null));

int tableId=-1;
String filterName=null;
List al=QueryEngine.getInstance().doQueryList("select ad_table_id,name from c_filter where id="+ filterId);
if(al.size()>0){
	tableId=Tools.getInt(((List)al.get(0)).get(0),-1);
	filterName=(String) ((List)al.get(0)).get(1);
}else{
	throw new NDSException(PortletUtils.getMessage(pageContext, "object-not-find",null));
}

TableManager tm= TableManager.getInstance();
Table table = tm.getTable(tableId);

%>
<br>
<script>
    function saveFilter(){
        if (prefer_form.filter.value==null || prefer_form.filter.value.length <1) {
            alert("<%=PortletUtils.getMessage(pageContext, "please-click-query-button-to-set-filter",null)%>");
            return false;
        }
        submitForm(prefer_form);
    }

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
                  document.getElementById(sObjectID).value="";
              }
     }
</script>
<table border="0" cellspacing="0" cellpadding="0" align="center" width="90%">
  <tr>
    <td rowspan=2>&nbsp;</td>
          <td>
          </td>
          <td rowspan=2>&nbsp;</td>
        </tr>
        <tr>
          <td colspan=3>
		<table border="0" cellspacing="0" cellpadding="0" align="center" width="100%">
          <tr >
            <td> <table border="0" cellspacing="0" cellpadding="0" align="center" width="90%"><tr><td>
              <br>
         <%=PortletUtils.getMessage(pageContext, "setting-filter-pre",null)%><%=filterName %>
         <%=PortletUtils.getMessage(pageContext, "setting-filter-last",null)%>
<form name="prefer_form" method="post" action="/control/command">
  <input type='hidden' name="objectid" value="<%=filterId%>" >
  <input type='hidden' name="command" value="UpdateFilter">
  <input type='hidden' name="table" value="<%=tableId%>">
  <%=PortletUtils.getMessage(pageContext, "filter",null)%>:
<%
     String column_acc_Id="filter";
     String url="/html/nds/query/search.jsp?table="+tableId+"&return_type=m&accepter_id="+column_acc_Id;
%>
<input readonly='on' type="text" name="<%=column_acc_Id%>" id="<%=column_acc_Id%>" value='' size="80" maxlength="1500">
<span id='<%=column_acc_Id+"_link"%>'  title="popup" onaction='oq.toggle("<%=url%>","<%=column_acc_Id%>")'><img id='<%=column_acc_Id+"_img"%>' border=0 width=16 height=16 align=absmiddle src='../images/find.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'></span>
<script>createButton(document.getElementById("<%=column_acc_Id+"_link"%>"));</script>
<input type="hidden" name="<%=column_acc_Id+"_expr"%>" id="<%=column_acc_Id+"_expr"%>" value=''>
<input type="hidden" name="<%=column_acc_Id+"_sql"%>" id="<%=column_acc_Id+"_sql"%>" value=''>

<p>
<input  type='button' name='saveDesc' value='<%=PortletUtils.getMessage(pageContext, "object.modify",null)%>' onclick="javascript:saveFilter();" >
<!--
<input  type='button' name='Cancle' value='<%=PortletUtils.getMessage(pageContext, "close-window",null)%>' onclick="javascript:window.close();" >
-->
</form></td></tr></table>
 </td></tr></table>
 <br>
 </td></tr></table>
    </div>
</div>
		
<%@ include file="/html/nds/footer.jsp" %>
