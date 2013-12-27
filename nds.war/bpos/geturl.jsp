<%@ page language="java" import="java.util.*,nds.query.*"  pageEncoding="utf-8"%>
<%
String ver=request.getParameter("ver");
String ret=String.valueOf(QueryEngine.getInstance().doQueryOne("select m_retail_$r_upgrade_version("+ver+") from dual"));
out.print(ret);
%>





