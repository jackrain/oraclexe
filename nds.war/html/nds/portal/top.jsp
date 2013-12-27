<%@ page language="java" import="nds.rest.*,org.json.*,java.net.*,java.io.*" pageEncoding="utf-8"%>
<div id="page-company-logo">
	<!--%=userWeb.getClientDomainName()%-->
	<a href="http://www.burgeon.com.cn/">
      <!--div class="moniker"></div-->
      <h1 class="logo">dev by burgeon</h1>
  </a>
</div>
<div id="page-niche-menu">
	<span style="font-weight: bold;float: left;"><%= user.getGreeting() %></span>
  <ul><li><a title="设置" class="ph_option" href="javascript:showObject('/html/nds/option/option.jsp',null,null)"></a></li></ul>
  <ul><li><a title="注销" class="ph_quit" href="<%= themeDisplay.getURLSignOut() %>"></a></li></ul>
 
</div>
