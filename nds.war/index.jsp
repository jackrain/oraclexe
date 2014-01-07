<%@ page language="java" import="java.util.*,nds.velocity.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %> 
<%@ include file="/html/portal/init.jsp" %>
<%
  Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS);
   String defaultClientWebDomain=conf.getProperty("webclient.default.webdomain");
   int defaultClientID= Tools.getInt(conf.getProperty("webclient.default.clientid"), 37);
   WebClient myweb=new WebClient(37, "","burgeon",false);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页</title> 
<link href="/reset.css" rel="stylesheet">
<link rel="stylesheet" href="/login.css">
<style type="text/css">
	body{
		background: url(images/login-bg.jpg);
		background-size: 100%;
	}
	#login-box{
		position: absolute; left: 50%; top: 50%;
		margin: -186px 0 0 -319px;
		width: 638px; height: 373px;
	}
	#logo{
		float: left;
		margin-left: 18px;
	}
	#tel{
		float: right;
		margin: 15px 17px 0 0;
	}
	#content{
		height: 315px;
		margin-top: 13px;
		background: url(images/login-box.png);
	}
	#content table{
		width: 236px;
		margin: 0 auto;
		position: relative; top: 130px;
		color: #1e5100; font-size: 14px;
	}
	#content table td{
		padding-bottom: 9px;
	}
	#content table input{
		height: 20px; width: 178px;
		border:1px solid #2c7700;
	}
	#verifyCode{
		width: 94px!important;
	}
	#content table img{
		display: inline-block;
	}
	#content table input[type="submit"],
	#content table input[type="reset"]{
		width: 84px; height: 30px;
		margin-top: 4px;
		border: none;
		color: #fff;
		cursor: pointer;
		background: url(images/login-btn.png);
	}
	#content table input[type="submit"]{
		margin-right: 8px;
	}
	#footer{
		position: fixed; bottom: 0; left: 0; right: 0;
		height: 60px;
		text-align: center; color: #fff;
		background-color: #318002;
	}
	#footer img{
		display: inline-block;
		vertical-align: middle;
	}
	#footer span{
		padding: 0 10px;
	}
	#ewm{
		position: relative; top: -5px;
	}
ul,li{list-style:none;}
body{padding:0;margin:0 auto;}

.login {
width: 100%;
height: 437px;
background: url(images/index.gif) no-repeat left #790000;
position: absolute;
top: 100px;
background-position: 199px 0px;
}

#bottom {
padding-bottom:0px;
padding-left:0px;
padding-right:0px;
padding-top:453px;
clear: both;
margin: 0 auto;
left: 955px;
top: 355px;
/*width:1020px;*/
width: 604px;
}
#bottom-left {
padding-bottom:0px;
padding-top:10px;
color: #333333;
font-size: 12px;
text-align:center;
}
#bottom-right {
padding-bottom:0px;
padding-top:0px;
color: #999999;
font-size: 12px;
text-align:center;
}
a.bottom-text {
    color: #FF6600;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 12px;
    font-weight: bold;
    text-decoration: underline;
}
a.bottom-text:hover {
    color: #024770;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 12px;
    font-weight: bold;
    text-decoration: underline;
}
#Layer2 {
position: absolute;
margin: 10px auto;
width: 339px;
height: 300px;
left: 57%;
top: 63px;
background: url(images/login-b.jpg) no-repeat center;
}
#Layer_2 {
position:absolute;
margin:10px auto;
width:246px;
height:293px;
left: 9%;
top: 0%;
z-index:2;
}
#Layer_3 {
position:absolute;
margin:0px auto;
color:#333399;
width:65px;
height:24px;
left: 25%;
top: 67%;
}
.STYLE29 {
	font-size: 16px;
color: #5C676D;
font-family: "微软雅黑";
font-weight: bold;
	 }
#Layer3 {
position: absolute;
margin: 10px auto;
width: 339px;
height: 300px;
left: 57%;
top: 63px;
background: url(images/login-b.jpg) no-repeat center;
}
#LAYER3{
position: absolute;
margin: 10px auto;
width: 221px;
height: 90px;
left: 20%;
top: 43%;
z-index: 2;
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
	
.bar{
position: absolute;
top: 347px;
display: block;
width: 100%;
height: 90px;
background: url("images/jxy-bg.gif") repeat-x top left;
text-indent: -999em;
-moz-opacity: .6;
filter: alpha(opacity=60);
opacity: 0.6;
	
	}	
	
#Layer_3 a {
display: block;
float: left;
margin-left: 6px;
line-height: 35px;
vertical-align: middle;
height: 36px;
width: 103px;
text-align: center;
letter-spacing: 1px;
white-space: nowrap;
background: transparent url(images/button.png) repeat scroll 0%;
color: #FDFDFD;
	font-size: 16px;
font-family: "微软雅黑";
font-weight: bold;
text-decoration: none;
}	

.title{
width: 939px;
overflow: hidden;
right: 200px;
position: absolute;
	}

.l{
		font-size: 16px;
color: #5C676D;
font-family: "微软雅黑";
font-weight: bold;
	}	
	
.right_text{
		font-size: 16px;
color: #5C676D;
font-family: "微软雅黑";
font-weight: bold;
	}	

.lx a{
		font-size: 16px;
color: #5C676D;
font-family: "微软雅黑";
font-weight: bold;
	}		
	
</style>
<SCRIPT type=text/javascript>
function onReturn(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13) submitForm();
}
function submitForm(){
	if(document.getElementById("login").value==""){ 
		alert("请输入会员用户名");
		return false;
	}
	else if(document.getElementById("password1").value==""){
		alert("请输入密码");
		return false;
	}
	else if(document.getElementById("verifyCode").value==""){
		alert("请输入验证码");
		return false;
	}else if(document.getElementById("verifyCode").value.length!=4){
		alert("您的输入验证码的长度不对!");
		return false;
	}
	document.fm1.submit();
	document.body.innerHTML=document.getElementById("progress").innerHTML;
}
</SCRIPT>
</head>

<body>
<div id="login-box">
		<header id="header" class="cl">
			<a href=""><img id="logo" src="images/logo.png" alt=""></a>
			<img id="tel" src="images/tel.png" alt="">
		</header>
		<div id="content">
			<form action="/loginproc.jsp" method="post" name="fm1">
				<input type="hidden" value="already-registered" name="cmd"/>
				<input type="hidden" value="already-registered" name="tabs1"/>
				<c:choose>
					<c:when test="<%= (userWeb!=null&&!userWeb.isGuest()) %>">
						<table>
							<tr>
								<td><%= LanguageUtil.get(pageContext, "current-user")%>:</td>
								<td><%=userWeb.getUserDescription() %></td>
							<tr>
							<tr>
								<td><%= LanguageUtil.get(pageContext, "enter-view") %>:</td>
								<td><a href="/html/nds/portal/portal.jsp"><%= LanguageUtil.get(pageContext, "backmanager") %></a></td>
							</tr>
							<tr>
								<td><%= LanguageUtil.get(pageContext, "or") %>:</td>
								<td><a href="/c/portal/logout"><%= LanguageUtil.get(pageContext, "logout") %></a></td>
							</tr>
						</table>
					</c:when>
					<c:otherwise>
						<%
						String  login ="";
						if(company==null){
						company = com.liferay.portal.service.CompanyLocalServiceUtil.getCompany("liferay.com");
						}
						 login =LoginAction.getLogin(request, "login", company);
						%> 
						<table>
							<tr>
								<td>用户名：</td>
								<td>
									<label>
										<input id="login" name="login" type="text" value="<%=login %>" />
									</label>
								</td>
							</tr>
							<tr>
								<td>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
								<td>
									<label>
										<input id="password1" name="<%= SessionParameters.get(request, "password")%>" type="password" value="" />
									</label>
								</td>
							</tr>
							<tr>
								<td>验证码：</td>
								<td>
									<label>
										<input id="verifyCode" name="verifyCode" type="text" onKeyPress="onReturn(event)" class="vm" />
										<img src="/servlets/vms" class="vm" id="chkimg" onclick="javascript:document.getElementById('chkimg').src='/servlets/vms?'+Math.random()" />       
									</label>
								</td>
							</tr>
							<tr>
								<td></td>
								<td>
									<input type="submit" onclick="javascript:submitForm()" value="登陆">
									<input type="reset">
								</td>
							</tr>
						</table>
					</c:otherwise>
				</c:choose>
			</form>
		</div>
    </div>
    <div id="footer">
		<img src="images/bos-xe.png" alt="">
		<span>©2008-2014上海伯俊软件科技有限公司 版权所有 保留所有权      了解更多：www.burgeon.com.cn</span>
		<img id="ewm" src="images/rwm.png" alt="">
    </div>
</body>
</html>
