<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%!
 /**
 	#session timeout checker for client portal page, this is to set the interval for checking in minutes, nomally it should be 1/10 of session timeout time
#value 0 (default) means not check timeout of session
	@param "table" - table id or name for viewing, should direct to that table immediately
 */ 
 private static int intervalForCheckTimeout=Tools.getInt(((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("portal.session.checkinterval","0"),0);
%>
<%
 if(userWeb==null || userWeb.getUserId()==userWeb.GUEST_ID){
 	/*session.invalidate();
 	com.liferay.util.servlet.SessionErrors.add(request,PrincipalException.class.getName());
 	response.sendRedirect("/login.jsp");*/
 	response.sendRedirect("/c/portal/login");
 	return;
 }
 if(!userWeb.isActive()){
 	session.invalidate();
 	com.liferay.util.servlet.SessionErrors.add(request,"USER_NOT_ACTIVE");
 	response.sendRedirect("/login.jsp");
 	return;
 }
String dialogURL=null;
String directTb=request.getParameter("table");
%>
<html>
<head>
<%@ include file="top_meta.jsp" %>
<link type="text/css" rel="StyleSheet" href="/html/nds/css/maxlist.css">

<script>
<%
	if(nds.util.Validator.isNotNull(directTb)){
%>	
jQuery(document).ready(function(){
	pc.setDefaultListMode(3);
	pc.setResizable(false);
	pc.navigate('<%=directTb%>')}
);
<%	}else{
		if(dialogURL!=null) {
%>
function loadWelcomePage(){
	pc.welcome("<%=dialogURL%>");
}
jQuery(document).ready(loadWelcomePage);
<%		}	
	}
	// check whether to check timeout for portal page
	if(intervalForCheckTimeout>0){
%>	
	setInterval("checkTimeoutForPortal(<%=session.getMaxInactiveInterval()%>)", <%=intervalForCheckTimeout*60000%>);
<%
	}
%>	
</script>	
</head>
<body>
<%@ include file="body_meta.jsp"%>
<div id="maxlist-main">		
		<table id="page-table" cellpadding="0" cellspacing="0">
	<tr>
	<td width="100%" class="topleft">
	<div id="portal-content"></div>	
	</td>
	</tr></table>
</div>
</body>
</html>

