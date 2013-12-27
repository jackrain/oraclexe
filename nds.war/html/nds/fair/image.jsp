<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
int pdtid= Tools.getInt(request.getParameter("pdtid"),-1);
int imageindex= Tools.getInt(request.getParameter("imageindex"),-1);
%>
<img src="/pdt/<%=pdtid%>_<%=imageindex%>_4.jpg" border="0"/>