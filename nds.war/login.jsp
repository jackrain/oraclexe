<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/html/portal/init.jsp" %>

<%
com.liferay.portal.util.CookieKeys.addSupportCookie(response);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>burgeon NewBos--伯俊软件</title>
<link type="text/css" rel="stylesheet" href="/style-portal.css"/>
<link rel="stylesheet" href="/reset.css">
<SCRIPT type=text/javascript>
	function selectTag(showContent,selfObj){
	// 2???
	var tag = document.getElementById("tags").getElementsByTagName("li");
	var taglength = tag.length;
	for(i=0; i<taglength; i++){
		tag[i].className = "";
	}
	selfObj.parentNode.className = "selectTag";
	// 2???
	for(i=0; j=document.getElementById("tagContent"+i); i++){
		j.style.display = "none";
	}
	document.getElementById(showContent).style.display = "block";	
}
 function changevalidate()
    {
     document.getElementById("imag1").src="/servlets/vms?"+Math.random();
    }

function onReturn(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13) submitForm();
}
function submitForm(){
	if(document.getElementById("login").value==""){ 
		alert("请输入会员用户名");
		return;
	}
	else if(document.getElementById("password1").value==""){
		alert("请输入密码");
		return;
	}
	else if(document.getElementById("verifyCode").value==""){
		alert("请输入验证码");
		return;
	}else if(document.getElementById("verifyCode").value.length!=4){
		alert("您的输入验证码的长度不对!");
		return;
	}
	document.fm1.submit();
	document.body.innerHTML=document.getElementById("progress").innerHTML;
}
</SCRIPT>
<style>
	body{
		background: url(/images/login-bg.jpg);
		background-size: 100%;
	}
	#login-main{
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
	#login-user{
		height: 315px;
		margin-top: 13px;
		background: url(/images/login-box.png);
	}
	#login-user table{
		width: 236px;
		margin: 0 auto;
		position: relative; top: 130px;
		color: #1e5100; font-size: 14px;
	}
	#login-user table td{
		padding-bottom: 9px;
	}
	#login-user table input{
		height: 20px; width: 178px;
		border:1px solid #2c7700;
	}
	#verifyCode{
		width: 94px!important;
	}
	#login-user table img{
		display: inline-block;
	}
	#login-user table input[type="submit"],
	#login-user table input[type="reset"]{
		width: 84px; height: 30px;
		margin-top: 4px;
		border: none;
		color: #fff;
		cursor: pointer;
		background: url(/images/login-btn.png);
	}
	#login-user table input[type="submit"]{
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
</style>
</head>

<body>

<div id="login-main">
	<header id="header" class="cl">
		<a href=""><img id="logo" src="/images/logo.png" alt=""></a>
		<img id="tel" src="/images/tel.png" alt="">
	</header>
	<div id="login-user">
		<c:if test="<%=true %>">
			<c:if test='<%= SessionMessages.contains(request, "user_added") %>'>
				<%
				String emailAddress = (String)SessionMessages.get(request, "user_added");
				String password = (String)SessionMessages.get(request, "user_added_password");
				%>
				<div class="portlet-msg-success">
					<c:choose>
						<c:when test="<%= Validator.isNull(password) %>"> <%= LanguageUtil.format(pageContext, "thank-you-for-creating-an-account-your-password-has-been-sent-to-x", emailAddress) %> </c:when>
						<c:otherwise> <%= LanguageUtil.format(pageContext, "thank-you-for-creating-an-account-your-password-is-x", new Object[] {password, emailAddress}) %> </c:otherwise>
					</c:choose>
				</div>
		
            </c:if>
			<c:if test="<%= SessionErrors.contains(request, AuthException.class.getName()) %>">
				<div class="portlet-msg-error"><%= LanguageUtil.get(pageContext, "error-username-or-password") %> </div>
			
			</c:if>
			<c:if test="<%= SessionErrors.contains(request, "VERIFY_CODE_ERROR") %>">
				<div class="portlet-msg-error"> <%= LanguageUtil.get(pageContext, "error-verify-code") %> </div>
		
			</c:if>
			<c:if test="<%= SessionErrors.contains(request, CookieNotSupportedException.class.getName()) %>">
				<div class="portlet-msg-error"> <%= LanguageUtil.get(pageContext, "authentication-failed-please-enable-browser-cookies") %> </div>
		
			</c:if>
			<c:if test="<%= SessionErrors.contains(request, NoSuchUserException.class.getName()) %>">
				<div class="portlet-msg-error"> <%= LanguageUtil.get(pageContext, "error-username-or-password") %> </div>
		
			</c:if>
			<c:if test="<%= SessionErrors.contains(request, PrincipalException.class.getName()) %>">
				<div class="portlet-msg-error"> <%= LanguageUtil.get(pageContext, "you-have-attempted-to-access-a-section-of-the-site-that-requires-authentication") %> <%= LanguageUtil.get(pageContext, "please-sign-in-to-continue") %> </div>
	
			</c:if>
			<c:if test='<%= SessionErrors.contains(request, UserEmailAddressException.class.getName()) %>'>
				<div class="portlet-msg-error"> <%= LanguageUtil.get(pageContext, "error-username-or-password") %> </div>

			</c:if>
			<c:if test="<%= SessionErrors.contains(request, UserPasswordException.class.getName()) %>">
				<div class="portlet-msg-error"> <%= LanguageUtil.get(pageContext, "error-username-or-password") %> </div>

			</c:if>
			<c:if test="<%= SessionErrors.contains(request, "SLEEP_USER") %>">
				<div class="portlet-msg-error"> <%= LanguageUtil.get(pageContext, "inactive-user-exception") %> </div>

			</c:if> 
			<c:if test="<%= SessionErrors.contains(request, "INACTIVE_USER") %>">
				<div class="portlet-msg-error"> <%= LanguageUtil.get(pageContext, "inactive-user-exception") %> </div>
			</c:if>                
		</c:if>
		<form action="/c/portal/login" method="post" name="fm1" id="fm1">
			<input type="hidden" value="already-registered" name="cmd"/>
			<input type="hidden" value="already-registered" name="tabs1"/>
			<%
			String  login ="";
			if(company==null)
			{
				company = com.liferay.portal.service.CompanyLocalServiceUtil.getCompany("liferay.com");
			}
			login =LoginAction.getLogin(request, "login", company);
			%>
			<div id="login-U">
				<table>
					<tr>
						<td>用户名：</td>
						<td><input id="login" name="login" type="text" value="<%=login %>" /></td>
					</tr>
					<tr>
						<td>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
						<td><input id="password1" name="<%= SessionParameters.get(request, "password")%>" type="password" value=""/></td>
					</tr>
					<tr>
						<td>验证码：</td>
						<td>
							<input id="verifyCode" name="verifyCode" class="vm" type="text" onKeyPress="onReturn(event)"/>
							<img src="/servlets/vms" width="64" height="16" align="absmiddle" id="chkimg" onclick="javascript:document.getElementById('chkimg').src='/servlets/vms?'+Math.random()" />
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
			</div>
		</form>
	</div>
</div>
<div id="footer">
	<img src="/images/bos-xe.png" alt="">
	<span>©2008-2014上海伯俊软件科技有限公司 版权所有 保留所有权      了解更多：www.burgeon.com.c</span>
	<img id="ewm" src="/images/rwm.png" alt="">
</div>

<%@ include file="/inc_progress.jsp" %>
</body>
</html>
