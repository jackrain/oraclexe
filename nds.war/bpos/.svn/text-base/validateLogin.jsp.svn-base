<%@ page language="java" import="java.util.*,java.util.List,nds.query.QueryEngine,nds.query.QueryUtils,nds.control.web.UserWebImpl,nds.control.web.WebUtils" pageEncoding="utf-8"%>
<%
String login=request.getParameter("email");
String email=login.trim();
String p=request.getParameter("pwd");
String pwd=p.trim();
String storeId="";
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
if("".equals(storeId=request.getParameter("storeid").trim()))storeId=(String)session.getAttribute("storeId");
List al=QueryEngine.getInstance().doQueryList("select a.discountlimit,a.ISRET from users a where a."+emailCond+" and a.passwordhash="+QueryUtils.TO_STRING(pwd)+" and a.ISENABLED=1 and a.c_store_id="+QueryUtils.TO_STRING(storeId));
//out.print("select a.discountlimit,a.ISRET from users a where a."+emailCond+" and a.passwordhash="+QueryUtils.TO_STRING(pwd)+"and a.ISENABLED=1 and a.c_store_id="+QueryUtils.TO_STRING(storeId));
if(al.size()>0){
	String discountlimit=String.valueOf(((List)al.get(0)).get(0));
	String isret=(String)((List)al.get(0)).get(1);
%>
<%=discountlimit+"+"+isret %>
<%
}else{
	%>
	error
	<%
	}
%>