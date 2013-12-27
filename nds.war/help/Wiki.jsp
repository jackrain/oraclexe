<%@ page language="java" import="java.util.*,nds.velocity.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %> 
<%@ include file="/html/portal/init.jsp" %>
<%
  int clientId= userWeb.getAdClientId();
  String webDomain=userWeb.getClientDomain();
 
   WebClient myweb=new WebClient(clientId, "",webDomain,false);
   int id=Tools.getInt(request.getParameter("id"),212);
   String content =null;
   if(id==-1){
    	content="" ;
   }else{
    	Map mainnews=null;
    	mainnews=myweb.getObject("u_news",id,2);
    	content=(String)mainnews.get("content");
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>帮助中心</title>
<link href="/style_portal.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div>
<%=content%>
</div>
</body>
</html>