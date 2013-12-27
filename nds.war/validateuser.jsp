<%@ page language="java" import="java.util.*,java.util.List,nds.query.QueryEngine,nds.query.QueryUtils" pageEncoding="utf-8"%>
<%
String login=request.getParameter("email");
String email=login.trim();
List al=QueryEngine.getInstance().doQueryList("select PASSWORDHASH,name from users where ad_client_id=37 and email="+QueryUtils.TO_STRING(email));
if(al.size()>0){
	String ph=(String)((List)al.get(0)).get(0);
	String name=(String)((List)al.get(0)).get(1);
%>
<%=name+"+"+ph %>
<%
}else{
	%>
	error
	<%
	}
%>