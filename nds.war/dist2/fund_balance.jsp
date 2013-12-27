<%@ page language="java"  pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*" %>
<%@page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="nds.control.util.*" %>
<%@ page import="nds.web.config.*" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %>
<%
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
<script language="javascript" language="javascript1.5" src="/html/nds/js/ieemu.js"></script>
<script language="javascript" src="/html/nds/js/cb2.js"></script>
<script language="javascript" src="/html/nds/js/prototype.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.2.3/jquery.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.2.3/hover_intent.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.2.3/ui.tabs.js"></script>
<script>
jQuery.noConflict();
</script>
<script language="javascript" src="/html/js/ajax.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<script language="javascript" src="/html/nds/js/application.js"></script>
<script type="text/javascript" src="/distribution/distribution.js"></script> 
<script type="text/javascript" src="/html/nds/js/init_object_query_zh_CN.js"></script>
<script language="javascript" src="/html/nds/js/init_objcontrol_zh_CN.js"></script>
<script language="javascript" src="/html/nds/js/obj_ext.js"></script>
</head>
<script language="javascript">
	jQuery(document).ready(function(){dist.fundQuery();});
</script>
<body style="width:auto;height:auto;">
<div id="fund_table1">
   <table id="fund_table" width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#8db6d9" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#8db6d9" class="modify_table" align="center">
</table> 
</div>
</body>
</html>
