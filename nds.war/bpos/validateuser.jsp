<%@ page language="java" import="java.util.*,java.util.List,nds.query.QueryEngine,nds.query.QueryUtils" pageEncoding="utf-8"%>
<%
String login=request.getParameter("email");
String email=login.trim();
String storeId=request.getParameter("storeid");
String loginUrles="";
if(null!=storeId&&!"".equals(storeId.trim())){
	loginUrles=(String)QueryEngine.getInstance().doQueryOne("select WEBPOSLOGINURL from c_store where id="+storeId);
}
List al=QueryEngine.getInstance().doQueryList("select PASSWORDHASH,name from users where ad_client_id=37 and email="+QueryUtils.TO_STRING(email));
if(al.size()>0){
	String ph=(String)((List)al.get(0)).get(0);
	String name=(String)((List)al.get(0)).get(1);
%>
<%=loginUrles+"\t"+name+"+"+ph %>
<%
}else{
	%>
	error
	<%
	}
%>