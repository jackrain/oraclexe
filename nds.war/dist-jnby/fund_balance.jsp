<%@ page language="java"  pageEncoding="utf-8"%>
<%@ page import="nds.control.web.*,com.liferay.portal.util.ShutdownUtil" %>
<%
	UserWebImpl userWeb =null;
	if(ShutdownUtil.isShutdown()){
		session.invalidate();
	}
	try{
		userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
	}catch(Throwable userWebException){
		System.out.println("########## found userWeb=null##########"+userWebException);
	}
    String idS=request.getParameter("id");
    int id=-1;
    if (idS != null) {
        id=Integer.parseInt(idS);
    }
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>经销商资金</title>
<link href="ph.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="/html/nds/js/prototype.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.2.3/jquery.js"></script>
<script>
jQuery.noConflict();
</script>
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<script language="javascript" src="/html/nds/js/application.js"></script>
<script type="text/javascript" src="/dist-jnby/dist-jnby.js"></script> 
<script type="text/javascript" src="/html/nds/js/init_object_query_zh_CN.js"></script>
<script language="javascript" src="/html/nds/js/init_objcontrol_zh_CN.js"></script>
</head>
<script language="javascript">
	jQuery(document).ready(function(){dist.fundQuery();});
</script>
<body style="width:auto;height:auto;">
<div id="fund_table1">
</div>
</body>
</html>
