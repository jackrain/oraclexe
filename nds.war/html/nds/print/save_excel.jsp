<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="nds.report.*" %>

<%
/**
* save to excel
*/
	// will check permission in     printBackground
	ReportPrinter printer=new ReportPrinter();
	printer.printBackground(request);
	String message=nds.util.WebKeys.VALUE_HOLDER_MESSAGE+"="+ 
		java.net.URLEncoder.encode(PortletUtils.getMessage(pageContext, "file-export-bg",null), "UTF-8");
	response.sendRedirect(NDS_PATH+"/reports/index.jsp?"+message);
%>




