<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
/**
 View html type cxtab file
 This is an frameset page, rpt htm file is contained in internal frame
 @param file - String for file name located in user's web folder
*/
String fileName=request.getParameter("file");
String downloadURL= "/servlets/binserv/Download/"+ java.net.URLEncoder.encode(fileName,"UTF-8");
%>
<html>
<head>
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico" />
<title><%=PortletUtils.getMessage(pageContext, "crosstab-report",null)%></title>
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/portal_header.css">
<style>
body *{
font-size:12px;
}	
</style>	
</head>
<body>
<table width="90%" height="100%" border="0"><tr><td align="right"><div class="f">
	<%=PortletUtils.getMessage(pageContext, "rtp-generated",null)%></div></td><td align="left"><div class="table-buttons">
<a href="<%=downloadURL%>"><%=PortletUtils.getMessage(pageContext, "download",null)%></a>
<!--<a href="javascript:closeWindow()"><%=PortletUtils.getMessage(pageContext, "close",null)%></a>-->
</div>	</td></tr></table>

</body>
</html>


