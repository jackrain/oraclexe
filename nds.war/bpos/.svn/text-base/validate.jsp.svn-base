<%@ page language="java" import="java.util.List,nds.query.QueryEngine,nds.query.QueryUtils" pageEncoding="utf-8"%>
<%!
	private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("POSLogin");
%>
<%
nds.portlet.util.UserUtils.initPageContext(request, response); 
/**
 check user's password with ad_sysconf setting, if ok, will login as specified user
  @param u - user name
  @param p - password hash encoded using md5(<param>t</param>+plain password)
  @param t- random int 
*/
String login=request.getParameter("u");
String userName=login.trim();
String passwd=request.getParameter("p");
String pj=request.getParameter("pj");
String[] storeParams=pj.split(":");
session.setAttribute("storeId",storeParams[0]);
session.setAttribute("storeName",storeParams[1]);
session.setAttribute("storeCode",storeParams[2]);
session.setAttribute("mochineCode",storeParams[3]);
List al=QueryEngine.getInstance().doQueryList("select PASSWORDHASH,email from users where ad_client_id=37 and email="+QueryUtils.TO_STRING(userName)+" and isactive='Y'");
if(al.size()>0){
	String ph=(String)((List)al.get(0)).get(0);
	String email=(String)((List)al.get(0)).get(1);
	if(ph.equals(passwd)){
		com.liferay.portal.action.LoginAction.loginSSOUser(request, response, email);
		Cookie cookie=new Cookie("name",userName);
		cookie.setMaxAge(1000000);
		Cookie cookie2=new Cookie("storeName",java.net.URLEncoder.encode(storeParams[1],"UTF-8"));
		cookie2.setMaxAge(1000000);
		response.addCookie(cookie);
		response.addCookie(cookie2);
		//out.print("userName:"+userName);
		//out.println("cookielen:"+request.getCookies().length);
	  response.sendRedirect("/bpos/toindex.jsp?redirect");
		return;
	}else{
		 logger.error("found passwd error:u="+ userName +" p="+passwd +",true pass should be:"+ph );
     response.sendRedirect("/bpos/login.jsp");
	}
}else{
	  logger.error("not found user :u="+ userName);
	  response.sendRedirect("/bpos/login.jsp");
}
%>