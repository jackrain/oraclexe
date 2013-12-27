<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
	
Properties props=EJBUtils.getApplicationConfig().getConfigurations("schema").getProperties();
if(! "true".equalsIgnoreCase(props.getProperty("modify","true"))){
	throw new NDSException("@no-permission@");
}
	
	String tabName=PortletUtils.getMessage(pageContext, "schema-export",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    TableManager tm= TableManager.getInstance();
    Table table = tm.getTable("AD_TABLE");
    int tableId= table.getId();
    ReportUtils ru = new ReportUtils(request);
    String name = ru.getUserName();

    String svrPath =Tools.encrypt( ru.getExportRootPath() + File.separator +  ru.getUser().getClientDomain()+File.separator+ name);
    
%>
<script language="JavaScript" src="/html/nds/js/ExpCollapse.js"></script>
<br>
<script>
    function saveFilter(){
        if (prefer_form.filter.value==null || prefer_form.filter.value.length <1) {
            alert("<%=PortletUtils.getMessage(pageContext, "must-input-description",null)%>");
            return false;
        }
        if ( prefer_form.filter_sql.value==null ||  prefer_form.filter_sql.value.length < 1) {
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
                  document.getElementById(sObjectID).readOnly =false;
                  document.getElementById(sObjectID).style.borderWidth="0px 0px 1px";
                  document.getElementById(sObjectID).style.backgroundColor='white';
                  document.getElementById(sObjectID).value="";
              }
     }
</script>
<table border="0" cellspacing="0" cellpadding="0" align="center" width="90%">
  <tr>
<td>
              <br>
         <%=PortletUtils.getMessage(pageContext, "setting-filter-pre",null)%><%=table.getDescription(locale) %>
         <%=PortletUtils.getMessage(pageContext, "setting-filter-last",null)%>
	<p>
	<%=PortletUtils.getMessage(pageContext, "file-will-be-saved-to",null)%>:<font color='blue'>appdict.script</font>
<form name="prefer_form" method="post" action="/control/command">
<input type="hidden" name="command" value='ExportSchema'>
<!--<input type="hidden" name="next-screen" value="<%=NDS_PATH%>/reports/index.jsp">-->
<input type="hidden" name="nds.control.ejb.UserTransaction" value="N">
  <%=PortletUtils.getMessage(pageContext, "filter",null)%>:
<%
     String column_acc_Id="filter";
     String url="/html/nds/query/search.jsp?table="+tableId+"&return_type=a&accepter_id="+column_acc_Id;
%>
<input readonly='on' type="text" name="<%=column_acc_Id%>" id="<%=column_acc_Id%>" value='' size="70" maxlength="1500">
<span id='<%=column_acc_Id+"_link"%>'  title="popup" onaction='oq.toggle_m("<%=url%>","<%=column_acc_Id%>")'><img id='<%=column_acc_Id+"_img"%>' border=0 width=16 height=16 align=absmiddle src='../images/find.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'></span>
<script>createButton(document.getElementById("<%=column_acc_Id+"_link"%>"));</script>	
<input type="hidden" name="<%=column_acc_Id+"_expr"%>" id="<%=column_acc_Id+"_expr"%>" value=''>
<input type="hidden" name="<%=column_acc_Id+"_sql"%>" id="<%=column_acc_Id+"_sql"%>" value=''>
<br>
&nbsp;<input type="checkbox" name="include_relate_table" value='Y'><%=PortletUtils.getMessage(pageContext, "include-relate-table",null)%>
<p>
<input type='hidden' name="scriptFileName" value="appdict.script">
<input type="hidden" name="scriptPath" value='<%=svrPath%>'>
<input  type='button' name='saveDesc' value='<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>' onclick="javascript:saveFilter();" >
<span id="tag_close_window"></span>
<Script language="javascript">
 // check show close window button or not
 if(  self==top){
 	document.getElementById("tag_close_window").innerHTML=
 	 "<input type='button' name='Cancle' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>' onclick='javascript:window.close();' >";
 }
</script>
</form>
 <br>
 </td></tr></table>
	
    </div>
</div>
<%@ include file="/html/nds/footer_info.jsp" %>