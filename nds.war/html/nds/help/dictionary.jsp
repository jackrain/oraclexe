<%@ include file="/html/nds/help/init.jsp" %>
<%
/**
   params:
   method(*) - table|column|columns|reftable_list|category_list
*/   
//System.out.println(Tools.toString(request));
	String method= request.getParameter("method");
	pageContext.getServletContext().getRequestDispatcher(NDS_PATH+"/help/"+method+".jsp").forward(request,response);
%>
