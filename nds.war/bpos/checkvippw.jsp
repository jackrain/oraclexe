<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="nds.control.web.WebUtils" %>
<%@ page import="nds.control.web.UserWebImpl,nds.query.QueryEngine" %>
<%
  UserWebImpl userWeb =null;
  try{
      userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));
  }catch(Throwable userWebException){
      out.println("error");
  } 
	if(userWeb==null || userWeb.isGuest()){
	    out.print("error");
	    return;
	}
	String cardNo=request.getParameter("cardno");
	String pw=request.getParameter("pw");
	if(pw==null){
		pw="";
	}
	if(null!=cardNo&&!cardNo.equals("")){
		String c=String.valueOf(QueryEngine.getInstance().doQueryOne("select count(1) from c_vip a where a.pass_word='"+pw.trim()+"' and a.cardno='"+cardNo.trim()+"'"));
		if(c.equals("1")){
				out.print("true");
		}else{
			%>
			error
			<%
		}
	}else{
		out.print("error");
	}
%>