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
<style>
body{
margin: 0;
padding: 0;
border: 0;
overflow: hidden;
height: 100%; 
font-family:Tahoma,Arial;
font-size:12px;
background-color:#EEEEEE;
}	
body *{
font-size:12px;
}	
.table-buttons {
height:24px;
line-height:24px;
vertical-align:center;
padding:0px 0px 0 0;
}
.table-buttons a {
position:relative;
float:left;
margin-left:6px;
line-height:20px;
vertical-align:middle;
height:20px;
width:70px;
text-align:center;
text-decoration:none;
letter-spacing: 1px;
white-space: nowrap;
background:url(<%=userWeb.getThemePath()%>/images/button_on.gif) no-repeat left center;
color: #11449E;
}
</style>	
</head>
<body>
<script>
	function doPrint(){
		var listFrame=parent.listFrame;
		listFrame.focus();
		listFrame.print();
	}
	
</script>
<table width="100%" height="24" border="0"><tr><td><div class="table-buttons">
<a href="javascript:doPrint()"><%=PortletUtils.getMessage(pageContext, "object.print",null)%></a>
<a href="<%=downloadURL%>"><%=PortletUtils.getMessage(pageContext, "download",null)%></a>
<!--<a href="javascript:closeWindow()"><%=PortletUtils.getMessage(pageContext, "close",null)%></a>-->
</div>	</td></tr></table>
	
</body>
</html>


