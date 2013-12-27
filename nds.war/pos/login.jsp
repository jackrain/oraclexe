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
String userName=request.getParameter("u");
String passwd=  request.getParameter("p");
String r=  request.getParameter("t");
List al=QueryEngine.getInstance().doQueryList("select PASSWORDHASH,email from users where ad_client_id=37 and name="+QueryUtils.TO_STRING(userName));
if(al.size()>0){
	String ph=(String)((List)al.get(0)).get(0);
	String email=(String)((List)al.get(0)).get(1);
	String pd=MD5Sum.toCheckSumStr(r+ph);
/*if(true){
		com.liferay.portal.action.LoginAction.loginSSOUser(request, response, email);
		//System.out.println("logined ok");
		response.sendRedirect("/pos/home.jsp?redirect");
		//System.out.println("redirect to home now...");
		return;
}*/

	if(pd.equals(passwd)){
		com.liferay.portal.action.LoginAction.loginSSOUser(request, response, email);
		response.sendRedirect("/pos/home.jsp?redirect");
		return;
	}else{
		logger.error("found passwd error:u="+ userName +" p="+passwd +",t="+r+", true pass should be:"+pd );
	}
}else{
	logger.error("not found user :u="+ userName);
}
response.sendRedirect("/login.jsp");
return;
%>