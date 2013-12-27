<div id="layout-outer-side-decoration" style="z-index: 0">
	<div id="layout-inner-side-decoration">
		<div id="layout-box">
			<div id="layout-top-banner">
				<div id="layout-company-logo">
					<a href="<%= themeDisplay.getURLHome() %>"><%if(themeDisplay.isSignedIn()){%>
					<img src="<%= themeDisplay.getCompanyLogo() %>">
					<%}else{%>
					<img src="/html/nds/images/custom/company_logo.jpg">
					<%}%>
					</a>
				</div>
				<c:if test="<%= themeDisplay.isSignedIn() %>"> 
				<div id="layout-user-menu">
						<span style="font-weight: bold"><%= user.getGreeting() %></span>(
							<c:if test="<%= themeDisplay.isShowMyAccountIcon() %>">
								<a href="<%= themeDisplay.getURLMyAccount() %>"><bean:message key="my-account" /></a>| 
							</c:if>
							<a href="<%= themeDisplay.getURLSignOut() %>"><bean:message key="sign-out" /></a>)<br/>
							<c:if test="<%= themeDisplay.isShowAddContentIcon() %>">
								<a href="javascript: void(0);" onClick="<%= themeDisplay.getURLAddContent() %>"><bean:message key="add-content" /></a>
								| <a href="javascript: void(0);" onClick="<%= themeDisplay.getURLLayoutTemplates() %>"><bean:message key="layout" /></a>
							</c:if>
							<c:if test="<%= themeDisplay.isShowPageSettingsIcon() %>">
								| <a href="<%= themeDisplay.getURLPageSettings().toString() %>"><bean:message key="page-settings" /></a>
							</c:if>
							<liferay-portlet:runtime portletName="<%= PortletKeys.MY_PLACES %>" />
				</div>
				</c:if>
			</div>	
