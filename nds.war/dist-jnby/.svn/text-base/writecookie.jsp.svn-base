<%@ page language="java"  pageEncoding="utf-8"%>
<%
		String autoDistType=request.getParameter("disttype");
		String autoDistValue=request.getParameter("distvalue");
    Cookie cookie=new Cookie("JNBYAUTODISTTYPE",autoDistType);
    cookie.setMaxAge(1000000);
    Cookie cookie1=new Cookie("JNBYAUTODISTVALUE",autoDistValue);
    cookie1.setMaxAge(1000000);
    response.addCookie(cookie);
    response.addCookie(cookie1);
%>