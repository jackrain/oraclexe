<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
	String tabName=PortletUtils.getMessage(pageContext, "sms-list",null);
	request.setAttribute("page_help", "SMS_REPORT");
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=tabName%>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="table_width" value="100%" />
</liferay-util:include>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%!
  private static int processId=-1;
%>
<%
    ReportUtils ru = new ReportUtils(request);
    QueryRequestImpl qRequest =(QueryRequestImpl) request.getAttribute("query");
    
    // User should have both export permission on specified table, and read permission on ad_process classname='nds.process.CreateSMSReport'
    if(processId==-1) processId=Tools.getInt(QueryEngine.getInstance().doQueryOne("select id from ad_process where classname='nds.process.CreateSMSReport'"),-2);
    if(processId==-2) throw new NDSException("Internal error. class nds.process.CreateSMSReport not defined as process");
    if(!userWeb.hasObjectPermission("ad_process", processId, nds.security.Directory.READ)){
		throw new NDSException("@no-permission@");
    }
    if(qRequest!=null){
    	userWeb.checkPermission(qRequest.getMainTable().getSecurityDirectory(), nds.security.Directory.EXPORT);
    }else{
    	out.println("Internal Error: can not find request object!");
  	    return;
    }
%>
<script language="JavaScript" src="/html/nds/js/formkey.js"></script>
<script language="javascript">
	function checkNotNull(control,desc){
      if(isWhitespace(control.value)){
        alert(desc+" <%= PortletUtils.getMessage(pageContext, "can-not-be-null",null)%>!");
        control.focus();
        return false;
      }
      return true;
    }
    function checkOptions(form){
    	if(!checkNotNull(form.ad_processqueue_name,"<%= TableManager.getInstance().getTable("ad_processqueue").getDescription(locale)%>"))
          return false;
        changeControlValue(form.resulthandler,"<%=NDS_PATH%>/reports/sms_report_generator.jsp");
        submitForm(form);
    }
</script>
<br>
<table width="75%" border="0" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" bordercolorlight="#cccccc" align="center">
<form name= "form1" method="post" action="<%= contextPath+"/servlets/QueryInputHandler" %>" >
		<input type="hidden" name="next-screen" value="<%=NDS_PATH%>/info.jsp">
        <tr>
          <td>
          <table border="0" cellspacing="0" cellpadding="1" align="center">
          <tr>
              <td colspan="2">
              <%= PortletUtils.getMessage(pageContext, "introduce-sms-report",null)%>
              </td>
            </tr>
            <tr>
              <td align="right">
              <%= PortletUtils.getMessage(pageContext, "report-title",null)%>:
              </td>
              <td>
              <input type="text" class="text" name="reportname" size ="20" value="<%="$D"+qRequest.getMainTable().getDescription(locale)%>"> 
              </td>
            </tr>
            <tr>
              <td align="right">
              <%= PortletUtils.getMessage(pageContext, "max-report-lines",null)%>:
              </td>
              <td>
              <input type="text" class="text" name="lines" size ="20" value="20">
              </td>
            </tr>
            <tr>
              <td valign="top" align="right">
              <%= TableManager.getInstance().getTable("ad_processqueue").getDescription(locale)%><font color='red'>*</font>:
              </td>
              <td>
				<input type="text" id="ad_processqueue_name" name="ad_processqueue_name" value="">
            	<span id="cbt_pqname"  onaction=popup_window("<%="/servlets/query?table="+TableManager.getInstance().getTable("ad_processqueue").getId()+"&return_type=s&accepter_id="%>form1.ad_processqueue_name","<%="T"+System.currentTimeMillis() %>")><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
				<script>createButton(document.getElementById("cbt_pqname"));</script>	
              </td>
            </tr>
            
            <% if("root".equals(userWeb.getUserName())){%>
            <tr>
              <td colspan="2">
              <%=  PortletUtils.getMessage(pageContext, "advanced-setting",null)%><div class='hrRule'></div>
              </td>
            </tr>
            <tr>
              <td align="right">
              <%=PortletUtils.getMessage(pageContext, "record-no",null)%>:
              </td><td>
				<input type="text" id="recordno" name="recordno" value="">
              </td>
            </tr>
            <tr>
              <td align="right">
              <%= TableManager.getInstance().getTable("groups").getDescription(locale)%>:
              </td><td>
				<input type="text" id="groupname" name="groupname" value="">
            	<span id="cbt_groupname"  onclick=popup_window("<%="/servlets/query?table="+TableManager.getInstance().getTable("groups").getId()+"&return_type=s&accepter_id="%>form1.groupname","<%="T"+System.currentTimeMillis() %>")><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
				<script>createButton(document.getElementById("cbt_groupname"));</script>	
              </td>
            </tr>
            <tr>
              <td valign="top" align="right">
              <%= PortletUtils.getMessage(pageContext, "priority",null)%>:
              </td>
              <td>
              <input type="text" class="text" name="priority" size ="20" value="1">
              </td>
            </tr>
            <%}//end if is root
            %>
            <tr>
              <td valign="top" align="right">
              &nbsp;
              </td>
              <td>
			<%
			out.print(QueryUtils.toHTMLControlForm(qRequest));
			%>
              <input type="hidden" name="command" value="CreateSMSReport">
              <input type="button" value="<%= PortletUtils.getMessage(pageContext, "create-task",null)%>" onclick="checkOptions(document.form1)"> 
<%@ include file="/html/nds/common/helpbtn.jsp"%>
<span id="closebtn"></span>
<Script language="javascript">
if( window.self==window.top){
	$("closebtn").innerHTML="<input class='command_button' type='button' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>(C)' accessKey='C' onclick='window.close();' name='Close'>";
}
</script>
<br>
<br>
              </td>
            </tr>
            </table>
      </td></tr>
</form>
</table>


    </div>
</div>	
<%@ include file="/html/nds/footer_info.jsp" %>
