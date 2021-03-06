<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%!
 /**
 	#session timeout checker for client portal page, this is to set the interval for checking in minutes, nomally it should be 1/10 of session timeout time
#value 0 (default) means not check timeout of session
	@param "ss" - ad_subsystem.id, if set, will show subsystem only
	@param "table" - table id or name for viewing, should direct to that table immediately
	@param "popup" - only when "false" will update current user's setting, disable popup portal next time, other values will do nothing
	@param redirect - if set, should be an URL, and we will popup that url as welcome window (overwrite default welcome window)
 */ 
 private static int intervalForCheckTimeout=Tools.getInt(((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("portal.session.checkinterval","0"),0);
 private static boolean defaultSsviewFirst="true".equals( ((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("portal.ssview","false"));

%>

<%
 String dialogURL=request.getParameter("redirect");
 if(userWeb==null || userWeb.getUserId()==userWeb.GUEST_ID){
 	/*session.invalidate();
 	com.liferay.util.servlet.SessionErrors.add(request,PrincipalException.class.getName());
 	response.sendRedirect("/login.jsp");*/
 	//System.out.println("portal.jsp:redirect to login");
 	response.sendRedirect("/c/portal/login"+
 		(nds.util.Validator.isNotNull(dialogURL)?"?redirect="+
 			java.net.URLEncoder.encode(dialogURL,"UTF-8"):""));
 	return;
 }
 if(!userWeb.isActive()){
 	session.invalidate();
 	com.liferay.util.servlet.SessionErrors.add(request,"USER_NOT_ACTIVE");
 	response.sendRedirect("/login.jsp");
 	return;
 }

if(nds.util.Validator.isNotNull(dialogURL)){
	response.sendRedirect(dialogURL);
 	return;
}
if(nds.util.Validator.isNull(dialogURL)){
	Boolean welcome=(Boolean)userWeb.getProperty("portal.welcome",Boolean.TRUE);
	if(welcome.booleanValue()){
		dialogURL= userWeb.getWelcomePage();
		//userWeb.setProperty("portal.welcome",Boolean.FALSE);
	}
}
String directTb=request.getParameter("table");
boolean isNotPopupPortal="false".equals(request.getParameter("popup"));//Tools.getYesNo(userWeb.getUserOption("POPUP_PORTAL","Y"), true);
if(isNotPopupPortal){
	//update current user's setting, no exception will be thrown
	userWeb.saveUserOption("POPUP_PORTAL","N",false);
}
TableManager manager=TableManager.getInstance();
Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
nds.query.web.SubSystemView ssv=new nds.query.web.SubSystemView();

boolean ssviewFirst=Tools.getYesNo(userWeb.getUserOption("SSVIEW",defaultSsviewFirst?"Y":"N"),false);
int ssId=Tools.getInt(request.getParameter("ss"),-1);
String mmId=request.getParameter("mm");
if(ssId==-1 && nds.util.Validator.isNull(directTb) && ssviewFirst){
	request.getRequestDispatcher("/html/nds/portal/ssv/index.jsp").forward(request, response);
	return;
}
%>
<html>
<head>
<%@ include file="/html/nds/portal/ssv/top_meta2bpos.jsp" %>
<script>
<%
	if(nds.util.Validator.isNotNull(directTb)){
%>	
jQuery(document).ready(function(){pc.navigate('<%=directTb%>')});
<%	}else{
		if(nds.util.Validator.isNotNull(dialogURL)){
%>
function loadWelcomePage(){
	pc.welcome("<%=dialogURL%>");
	//window.location.href="<%=dialogURL%>";
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
jQuery(document).ready(function(){pc.navigate('<%=mmId%>')});
</script>	
</head>
<body>
<div style="height:100%;overflow-y:auto;position:absolute;top:0px;width:1050px;">		
	<table id="page-table" cellpadding="0" cellspacing="0" >
	<tr>
		<td style="vertical-align:top;align:left;">
	<div id="portal-content" style="width:100%"></div>	
	</td></tr>
	</table>
</div>
<!---<div id="cmdmsg" style="display:none;" ondblclick="$('cmdmsg').hide()"></div>-->
</body>
</html>

