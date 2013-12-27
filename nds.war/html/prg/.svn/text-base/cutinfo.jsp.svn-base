<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
  int cu= Tools.getInt(request.getParameter("cu"),-1);
  int cs= Tools.getInt(request.getParameter("cs"),-1);
  int un= Tools.getInt(request.getParameter("un"),-1);
  int pn= Tools.getInt(request.getParameter("pn"),-1);
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
height: 400px;
background: no-repeat left #790000;
position: absolute;
top: 100px;
background-position: 199px 0px;
}
#bottom {
padding-bottom: 0px;
padding-left: 0px;
padding-right: 0px;
padding-top: 510px;
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
<style>

table {
*border-collapse: collapse; /* IE7 and lower */
border-spacing: 0;
width: 60%;
margin:auto;
}

.bordered {
border: solid #ccc 1px;
-moz-border-radius: 6px;
-webkit-border-radius: 6px;
border-radius: 6px;
-webkit-box-shadow: 0 1px 1px #ccc;
-moz-box-shadow: 0 1px 1px #ccc;
box-shadow: 0 1px 1px #ccc;
}



.bordered td, .bordered th {
border-left: 1px solid #ccc;
border-top: 1px solid #ccc;
padding: 10px;
text-align: left;
font-size: 24px;
}

.bordered th {
	color: black;
background-color: #dce9f9;
-webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
-moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;
box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
border-top: none;
text-shadow: 0 1px 0 rgba(255,255,255,.5);
}

.bordered td:first-child, .bordered th:first-child {
border-left: none;
}

.bordered th:first-child {
-moz-border-radius: 6px 0 0 0;
-webkit-border-radius: 6px 0 0 0;
border-radius: 6px 0 0 0;
}

.bordered th:last-child {
-moz-border-radius: 0 6px 0 0;
-webkit-border-radius: 0 6px 0 0;
border-radius: 0 6px 0 0;
}

.bordered th:only-child{
-moz-border-radius: 6px 6px 0 0;
-webkit-border-radius: 6px 6px 0 0;
border-radius: 6px 6px 0 0;
}

.bordered tr:last-child td:first-child {
-moz-border-radius: 0 0 0 6px;
-webkit-border-radius: 0 0 0 6px;
border-radius: 0 0 0 6px;
}

.bordered tr:last-child td:last-child {
-moz-border-radius: 0 0 6px 0;
-webkit-border-radius: 0 0 6px 0;
border-radius: 0 0 6px 0;
}





</style>
<title>注册成功</title>
</head>
<body>
<div width=100% margin:0 auto>	
<div class="title">
<h4 class="Logo"><img src="/images/left.gif" alt="伯俊logo"></h4>
</div>
<div class="main" style="text-align:center;">
<font color="#ffffff">
<h1>BOS注册产品信息</h1>
<h2>客户名称：<span><%=cp%></span></h2>
<table class="bordered">
<thead>
  <tr>
    <th>用户数</th>
    <th>当前用户数</th>
    <th>POS数</th>
    <th>当前POS数</th>
  </tr>
 </thead> 
  <tr>
    <td><%=un%></td>
    <td><%=cu%></td>
    <td><%=pn%></td>
    <td><%=cs%></td>
  </tr>
</table>
<font color="yellow">
	<h2>服务到期时间：<span><%=df.format(expdate)%></span></h2>
	<h2>距离服务到期还有：<span><%=(expdate.getTime()-System.currentTimeMillis())/(24*60*60*1000)>0?(expdate.getTime()-System.currentTimeMillis())/(24*60*60*1000):0%></span>天</h2>
</font>
</font>
<h1><a href="/html/nds/portal/portal.jsp"><font color="yellow">继续使用</font></a></h1>
<ul><font color="yellow">当前点数已超过证书授权，系统将于1小时时候自动关闭！</font></ul>
</div>
<div id="bottom">
<div id="bottom-right"><span class="bottom-logo"></span>&copy;2011-2013上海伯俊软件科技有限公司 版权所有 了解更多产品请点击:<a class="bottom-text" target="_parent" href="http://www.burgeon.com.cn">www.burgeon.com.cn</a></div>
</div>
</div>
</body>
</html>
