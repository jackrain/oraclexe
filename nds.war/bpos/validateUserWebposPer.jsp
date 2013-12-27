<%@ page language="java" import="java.util.*,java.util.List,nds.query.QueryEngine,nds.query.QueryUtils,nds.control.web.UserWebImpl,nds.control.web.WebUtils" pageEncoding="utf-8"%>
<%
String login=request.getParameter("email");
String emailCond;
if(null==login||"".equals(login.trim())||"当前用户".equals(login.trim())){
	UserWebImpl userWeb =null;
  try{
      userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));
      emailCond="id="+userWeb.getUserId();
  }catch(Throwable userWebException){
      out.print("error");
      return;
  }
}else{
	emailCond="email="+QueryUtils.TO_STRING(login.trim());
}
String p=request.getParameter("pwd");
String pwd=p.trim();
List al=QueryEngine.getInstance().doQueryList("select a.id,a.webpos_per from users a where a."+emailCond+" and a.passwordhash="+QueryUtils.TO_STRING(pwd));
if(al.size()>0){
	String id=String.valueOf(((List)al.get(0)).get(0));
	String webpos_per=String.valueOf(((List)al.get(0)).get(1));
%>
<%=id+"+"+webpos_per %>
<%
}else{
	%>
	error
	<%
	}
%>