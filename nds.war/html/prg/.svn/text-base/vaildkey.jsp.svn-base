<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
	//com.liferay.portal.util.CookieKeys.addSupportCookie(response);
	String maconly=com.getMAC.GetMACH.get_maconly();
	//String maconly="sdfasdf";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>BOS注册界面</title>
<style type="text/css">
.uploadifyQueueItem {
	font: 11px Verdana, Geneva, sans-serif;
	border: 2px solid #E5E5E5;
	background-color: #F5F5F5;
	margin-top: 5px;
	padding: 5px;
	width: 350px;
}
.uploadifyError {
	border: 2px solid #FBCBBC !important;
	background-color: #FDE5DD !important;
}
.uploadifyQueueItem .cancel {
	float: right;
}
.uploadifyProgress {
	background-color: #FFFFFF;
	border-top: 1px solid #808080;
	border-left: 1px solid #808080;
	border-right: 1px solid #C5C5C5;
	border-bottom: 1px solid #C5C5C5;
	margin-top: 10px;
	width: 100%;
}
.uploadifyProgressBar {
	background-color: #0099FF;
	width: 1px;
	height: 3px;
}     
.title{
width: 939px;
overflow: hidden;
right: 200px;
position: absolute;
}
.main {
width: 100%;
height: 360px;
background: no-repeat left #790000;
position: absolute;
top: 100px;
background-position: 199px 0px;
}
#bottom {
padding-bottom: 0px;
padding-left: 0px;
padding-right: 0px;
padding-top: 453px;
clear: both;
margin: 0 auto;
left: 955px;
top: 438px;
width: 604px;
}
.bottom-logo{
background: url(images/bottom.gif) no-repeat center;
/*position: absolute;*/
width: 87px;
height: 20px;
/*left: 333px;*/
float: left;
display: block;
}
#bottom-right {
padding-bottom: 0px;
padding-top: 0px;
color: #999999;
font-size: 12px;
text-align: center;
}
a.bottom-text {
    color: #FF6600;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 12px;
    font-weight: bold;
    text-decoration: underline;
}
</style>
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico">
<script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-1.7.2.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.3.2/hover_intent.min.js"></script>
<script language="javascript" src="/html/prg/upload/jquery.uploadify.min.js"></script>
<script>
	jQuery.noConflict();
</script>
<script language="javascript" src="/html/nds/js/prototype.js"></script>
<script language="javascript" src="/html/prg/fileupload.js"></script>
<link rel="stylesheet" type="text/css" href="/html/prg/upload/uploadify.css">
</head>
<body>
<div width=100% margin:0 auto>	
<div class="title">
<h4 class="Logo"><img src="/images/left.gif" alt="伯俊logo"></h4>
</div>
<div class="main">
<h1 align="center"><font color="#ffffff">BOS注册本机序号</font></h1>
<div align="center">
	<font  color="#ffff00">
	<c:if test="<%=true %>">
   <c:if test="<%= SessionErrors.contains(request, "VERIFY_KEYFILE_ERROR") %>">
                  <div class="portlet-msg-error"> <%= LanguageUtil.get(pageContext, "inactive-keyfile-error") %></div>
                  <br/>
                </c:if>   
   <c:if test="<%= SessionErrors.contains(request, "VERIFY_KEY_ERROR") %>">
                  <div class="portlet-msg-error"> <%= LanguageUtil.get(pageContext, "inactive-key-error") %></div>
                  <br/>
                </c:if>         
     </c:if>
  </font>
</div>
<div style="margin: 2% 30%;height:100px;">
<textarea id="inputSerialNo" name="localMac" style="width:100%;height:100%;"><%=maconly%></textarea>
</div>
<div style="margin: 0px 35%;">
      <div id="flashcontent">
          <input id="fileInput1" name="file1" size="35" type="file"/>
      </div>
<!--input type='button' id="btnImport" name='Upload' value='开始上传并处理' onclick="javascript:fup.beginUpload();" -->
<script language="javascript">
        var upinit={
            'sizeLimit':1024*1024 *1,
            'buttonText'	: '上传证书',
            'fileDesc'      : '上传文件(dat)',
            'fileExt'		: '*.dat;'
        };
        var para={
            "next-screen":"/html/prg/msgjson.jsp",
            "formRequest":"/html/nds/msg.jsp",
            "JSESSIONID":"<%=session.getId()%>",
        };
        jQuery(document).ready(function(){
              fup.initForm(upinit,para);
        });
	</script>
</div>
<div style="margin:10px 48.3%">
</div>
</div>
<div id="bottom">
  <div id="bottom-right">
  	<span class="bottom-logo"></span>
  	 &copy;2011-2013上海伯俊软件科技有限公司 版权所有 了解更多产品请点击:<a class="bottom-text" target="_parent" href="http://www.burgeon.com.cn">www.burgeon.com.cn</a>
  	</div>
</div>
<fieldset id="output" style="display:none">
  <legend><%=PortletUtils.getMessage(pageContext, "import-result",null)%></legend>
<div id="whole">
</fieldset>
</div>
</body>
</html>
