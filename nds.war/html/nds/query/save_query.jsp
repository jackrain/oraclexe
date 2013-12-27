<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="java.util.*" %>
<%@ page import="nds.query.*" %>
<%@	page errorPage="../error.jsp"%>
<%

//String url = request.getParameter("url");
//String savePath = config.getRealPath(request.getRequestURI());
String url = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/query/query.jsp?"+request.getParameter("table_name");
out.print("getRemoteAddr save file to " + url);
%>

