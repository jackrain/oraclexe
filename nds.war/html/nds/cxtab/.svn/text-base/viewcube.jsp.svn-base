<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
/**
 View cube type cxtab file
 @param file - String for file name located in user's web folder
 @param pi  - ad_pinstance.id
*/
String fileName=request.getParameter("file");
String pi= request.getParameter("pi");
String downloadURL= "/servlets/binserv/Download/"+ java.net.URLEncoder.encode(fileName,"UTF-8");
String openURL="opencube.jsp?pi="+pi+"&file="+java.net.URLEncoder.encode(fileName,"UTF-8");
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
<script>
function openCube(){
	try{
		var isclosed=false;
		var w = window.opener;
		if(w==undefined)w= window.parent;
		if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
	    		w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'))",1);
				//reload window
				if(bReload)w.location.reload();
	    		isclosed=true;
			}
		}
	}catch(ex){}
	popup_window("<%=openURL%>");
}
function popup_window(url,tgt,theWidth,theHeight){
    if(tgt==null|| tgt==undefined) tgt="_blank";
    if(theWidth==null|| theWidth==undefined) theWidth=951;
    if(theHeight==null|| theHeight==undefined) theHeight=570;
	var theTop=(screen.height/2)-(theHeight/2);
	var theLeft=(screen.width/2)-(theWidth/2);
	var features="height="+theHeight+",width="+theWidth+",top="+theTop+",left="+theLeft+",dependent=yes,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,status=yes";
    var newWindow=window.open(url,tgt,features);
    newWindow.focus();
}

</script>	
</head>
<body>
<table width="90%" height="100%" border="0"><tr><td align="right"><div class="f">
	<%=PortletUtils.getMessage(pageContext, "rtp-generated",null)%></div></td><td align="left"><div class="table-buttons">
<a href="<%=downloadURL%>"><%=PortletUtils.getMessage(pageContext, "download",null)%></a>
</td></tr>
<%if(WebUtils.getBrowserType(request)==100){%>
<tr valign="top"><td align="center" colspan="2"><div style="text-align:center;width:100px;">
<div class="table-buttons"><a href="javascript:openCube()"><%=PortletUtils.getMessage(pageContext, "open-cube-directly",null)%></a></div>
</div></td></tr>
<%}%>
<tr valign="top"><td align="center" colspan="2">
	<div class="f"><%=PortletUtils.getMessage(pageContext, "install-cube-exe",null)%>: <a href="/html/nds/cxtab/cubsetup.exe"><img src="/html/nds/images/down.gif" border="0"><%=PortletUtils.getMessage(pageContext, "download",null)%></a></div></td></tr>
</table>

</body>
</html>


