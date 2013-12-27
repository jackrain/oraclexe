<%@page contentType= "text/html; charset=GBK"%>
<%@page import="nds.query.*,nds.query.web.*,java.util.*"%>
<%@ taglib uri='/WEB-INF/tld/struts-tiles.tld' prefix='tiles' %>
<%@ page errorPage="../error.jsp"%>
<%
response.sendRedirect(request.getContextPath()+"/query/query_portal.jsp");

%>
