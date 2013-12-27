<div id="page-company-logo">
	<%=userWeb.getClientDomainName()%>
</div>
<div id="page-niche-menu">
	<span style="font-weight: bold"><%= user.getGreeting() %></span>|
	<%if(session.getAttribute("saasvendor")==null){
		//alisoft does not allow home page and logout, change password
	%>
	<a class="ph" href="/"><%= PortletUtils.getMessage(pageContext, "home",null)%></a>|
	<%}%>
	<%if(session.getAttribute("saasvendor")==null){%>
	<a class="ph" href="<%= themeDisplay.getURLSignOut() %>"><bean:message key="sign-out" /></a>
	<%}%>
</div>

