<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
  int usrnum= Tools.getInt(request.getParameter("user"),-1);
  int posnum= Tools.getInt(request.getParameter("pos"),-1);
  String cp=(String)request.getParameter("cp");
  SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  Date expdate= df.parse((String)request.getParameter("exp"));
  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.title{
width: 939px;
overflow: hidden;
right: 200px;
position: absolute;
}
.main {
width: 100%;
height: 344px;
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
background: url(/images/bottom.gif) no-repeat center;
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
a:link,a:visited{
 text-decoration:none;  /*超链接无下划线*/
}
</style>
<title>注册成功</title>
</head>
<body>
<div width=100% margin:0 auto>	
<div class="title">
<h4 class="Logo"><img src="/images/left.gif" alt="伯俊logo"></h4>
</div>
<div class="main" style="margin-right:auto;margin-left:auto;text-align:center;">
<font color="#ffffff">
<h1>BOS注册产品信息</h1>
<h2>客户名称：<span><%=cp%></span></h2>
<h2>用户数：<span><%=usrnum%></span></h2>
<h2>POS数：<span><%=posnum%></span></h2>
<font color="yellow">
	<h2>服务到期时间：<span><%=df.format(expdate)%></span></h2>
	<h2>距离服务到期还有：<span><%=(expdate.getTime()-System.currentTimeMillis())/(24*60*60*1000)>0?(expdate.getTime()-System.currentTimeMillis())/(24*60*60*1000):0%></span>天</h2>
</font>
</font>
<h1><a href="/"><font color="rgb(60, 155, 192)">登陆</font></a></h1>
</div>
<div id="bottom">
<div id="bottom-right"><span class="bottom-logo"></span>&copy;2011-2013上海伯俊软件科技有限公司 版权所有 了解更多产品请点击:<a class="bottom-text" target="_parent" href="http://www.burgeon.com.cn">www.burgeon.com.cn</a></div>
</div>
</div>
</body>
</html>
