<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%!
private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("POSLogin");
%>
<%
/**
 check user's password with ad_sysconf setting, if ok, will login as specified user
  @param u - user name
  @param p - password hash encoded using md5(<param>t</param>+plain password)
  @param t- random int 
*/
String login=request.getParameter("u");
String userName=login.trim();
String passwd=  request.getParameter("p");
String pj=request.getParameter("pj");
String[] storeParams=pj.split(":");
session.setAttribute("storeId",storeParams[0]);
session.setAttribute("storeName",storeParams[1]);
session.setAttribute("storeCode",storeParams[2]);
List al=QueryEngine.getInstance().doQueryList("select PASSWORDHASH,email from users where ad_client_id=37 and email="+QueryUtils.TO_STRING(userName)+" and isactive='Y'");
if(al.size()>0){
	String ph=(String)((List)al.get(0)).get(0);
	String email=(String)((List)al.get(0)).get(1);
	if(ph.equals(passwd)){
		com.liferay.portal.action.LoginAction.loginSSOUser(request, response, email);
		Cookie cookie=new Cookie("name",userName);
		cookie.setMaxAge(1000000);
		response.addCookie(cookie);
	  response.sendRedirect("/bpos/toindex.jsp?redirect");
		return;
	}else{
		 logger.error("found passwd error:u="+ userName +" p="+passwd +",true pass should be:"+ph );
     response.sendRedirect("/first.jsp");
	}
}else{
	  logger.error("not found user :u="+ userName);
	  response.sendRedirect("/first.jsp");
}
    

%>