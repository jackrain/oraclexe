<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
String fileName=request.getParameter("file");
String pi=request.getParameter("pi");
String cubeName=(String)QueryEngine.getInstance().doQueryOne("select p_string from ad_pinstance_para r where r.ad_pinstance_id=" +pi+ " and r.name='cxtab'");
if(nds.util.Validator.isNull(cubeName)) cubeName ="";
String downloadURL= "/servlets/binserv/Download/"+ java.net.URLEncoder.encode(fileName,"UTF-8");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>CubeView</title>
<script language="JavaScript" src="/html/nds/js/prototype_min.js"></script>
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
#cubedesc {
	font-weight:bold;
}
#ocxerr{
	color:red; 
	border: 1px solid #FF0000;
	width:500px;
	padding:10px;
	margin:5px;
	text-align:center;
}
</style>	
</head>
<body language="javascript" onload="return window_onLoad()">
<table width="300" height="24" border="0"><tr><td><div class="table-buttons">
<a href="javascript:PrintPreview()">打印预览</a>
<a href="<%=downloadURL%>">保存</a>
</div>	</td><td align="left"><span id="cubedesc"><%=cubeName%></span></td></tr></table> 
<div id="ocxerr" style="display:none">
	请使用IE，并<a href="/html/nds/cxtab/cubsetup.exe"><img src="/html/nds/images/down.gif" border="0">安装控件</a>
</div>	
<center>
<object id="DCube" width="98%" height="600" classid="clsid:6D63F73D-3688-3000-9C0F-00A0C90F29FC"></object>
</center>
  
<script language="JavaScript">
<!--
function window_onLoad()
{
	try{
		document.getElementById("DCube").DataPath ="<%=downloadURL%>";
		document.getElementById("DCube").Refresh();
		//document.getElementById("cubedesc").innerHTML=document.getElementById("DCube").HeaderCaption;
	}catch(t){
		document.getElementById("ocxerr").style.display ='';
	}
	Event.observe(window, "resize", resizeCube);
	resizeCube();
}
function resizeCube(){
    var body = document.getElementsByTagName("body")[0];
    var h=body.clientHeight -40;
    if(h < 40) h=40;
	document.getElementById("DCube").height = h+ "px";
}
function PrintPreview()
{
	document.getElementById("DCube").PrintPreview();
}


-->
    </script>
</body>
</html>
