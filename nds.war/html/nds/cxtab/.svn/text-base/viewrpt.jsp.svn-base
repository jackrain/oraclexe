<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
/**
 View html type cxtab file
 This is an frameset page, rpt htm file is contained in internal frame
 @param file - String for file name located in user's web folder
*/
String fileName=request.getParameter("file");
String downloadURL= "/servlets/binserv/GetFile/"+ java.net.URLEncoder.encode(fileName,"UTF-8");
%>
<html>
<head>
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico" />
<title><%=PortletUtils.getMessage(pageContext, "crosstab-report",null)%></title>
</head>
<frameset rows="28,*"   border="0" frameborder="1" FRAMESPACING="0" TOPMARGIN="0" LEFTMARGIN="0" MARGINHEIGHT="0" MARGINWIDTH="0">
  	<frame name="fraToolbar" src="<%=NDS_PATH%>/cxtab/viewrpt_toolbar.jsp?<%=request.getQueryString()%>" scrolling="no" border="0" frameborder="no" TOPMARGIN="0" LEFTMARGIN="0" MARGINHEIGHT="0" MARGINWIDTH="0"></frame>
  	<frame name="listFrame" src="<%=downloadURL%>"  TOPMARGIN="0" LEFTMARGIN="0" MARGINHEIGHT="0" MARGINWIDTH="0" FRAMEBORDER="0" BORDER="1"></frame>
</frameset>
<noframes><body>Error: need browser support frameset
</body></noframes>
</html>


