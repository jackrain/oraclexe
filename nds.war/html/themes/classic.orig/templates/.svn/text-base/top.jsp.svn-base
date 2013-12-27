<%
/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<div id="layout-outer-side-decoration" style="z-index: 0">
	<div id="layout-inner-side-decoration">

	<c:if test="<%= themeDisplay.isSignedIn() %>">
	<div style="position: relative; z-index: 4;">
		<table cellpadding="0" cellspacing="0" border="0" id="portal-dock-title" style="z-index: 2">
		<tr>
			<td>
				<div class="portal-dock-help" id="portal-dock-text">
					<%= user.getGreeting() %>
				</div>
				<div class="portal-dock-help" id="portal-dock-my-places" style="display: none">
					<liferay-portlet:runtime portletName="<%= PortletKeys.MY_PLACES %>" />
				</div>
				<div class="portal-dock-help" id="portal-dock-search" style="display: none">
					<liferay-ui:journal-content-search />
				</div>
			</td>
		</tr>
		</table>

			<div id="portal-dock" style="position: absolute; z-index: 1;">

				<div class="portal-dock-box"
					 onmouseover="LiferayDock.showText('<%= UnicodeFormatter.toString(user.getGreeting()) %>')">
					 <liferay-ui:png-image image='<%= themeDisplay.getPathThemeImage() + "/dock/icons_nav_main.png" %>' height="50" width="50" />
				</div>

				<div class="portal-dock-box"
					 onmouseover="LiferayDock.showObject('portal-dock-my-places', 10)">
					 <liferay-ui:png-image image='<%= themeDisplay.getPathThemeImage() + "/dock/icons_nav_myPlaces.png" %>' height="50" width="50" />
				</div>

				<div class="portal-dock-box"
					 onclick="window.location='<%= themeDisplay.getURLSignOut() %>'"
					 onmouseover="LiferayDock.showText('<%= UnicodeLanguageUtil.get(pageContext, "sign-out") %>')">
					 <liferay-ui:png-image image='<%= themeDisplay.getPathThemeImage() + "/dock/icons_nav_logout.png" %>' height="50" width="50" />
				</div>

				<div class="portal-dock-box"
					 onclick="window.location='<%= themeDisplay.getURLHome() %>'"
					 onmouseover="LiferayDock.showText('<%= UnicodeLanguageUtil.get(pageContext, "home") %>')">
					 <liferay-ui:png-image image='<%= themeDisplay.getPathThemeImage() + "/dock/icons_nav_home.png" %>' height="50" width="50" />
				</div>

				<div class="portal-dock-box"
					 onclick=""
					 onmouseover="LiferayDock.showObject('portal-dock-search', 10); $('portal-dock-search').getElementsByTagName('input')[0].focus()">
					 <liferay-ui:png-image image='<%= themeDisplay.getPathThemeImage() + "/dock/icons_nav_search.png" %>' height="50" width="50" />
				</div>

				<c:if test="<%= themeDisplay.isShowLayoutTemplatesIcon() %>">
					<div class="portal-dock-box"
						 onclick="showLayoutTemplates()"
						 onmouseover="LiferayDock.showText('<%= UnicodeLanguageUtil.get(pageContext, "layout") %>')">
						 <liferay-ui:png-image image='<%= themeDisplay.getPathThemeImage() + "/dock/icons_nav_layout.png" %>' height="50" width="50" />
					</div>
				</c:if>

				<c:if test="<%= themeDisplay.isShowMyAccountIcon() %>">
					<div class="portal-dock-box"
						 onclick="window.location='<%= themeDisplay.getURLMyAccount() %>'"
						 onmouseover="LiferayDock.showText('<%= UnicodeLanguageUtil.get(pageContext, "my-account") %>')">
						 <liferay-ui:png-image image='<%= themeDisplay.getPathThemeImage() + "/dock/icons_nav_myAccount.png" %>' height="50" width="50" />
					</div>
				</c:if>

				<c:if test="<%= themeDisplay.isShowAddContentIcon() %>">
					<div class="portal-dock-box"
						 onclick="<%= themeDisplay.getURLAddContent() %>"
						 onmouseover="LiferayDock.showText('<%= UnicodeLanguageUtil.get(pageContext, "add-content") %>')">
						 <liferay-ui:png-image image='<%= themeDisplay.getPathThemeImage() + "/dock/icons_nav_addContent.png" %>' height="50" width="50" />
					</div>
				</c:if>

				<c:if test="<%= themeDisplay.isShowPageSettingsIcon() %>">
					<div class="portal-dock-box"
						 onclick="showPageSettings()"
						 onmouseover="LiferayDock.showText('<%= UnicodeLanguageUtil.get(pageContext, "page-settings") %>')">
						 <liferay-ui:png-image image='<%= themeDisplay.getPathThemeImage() + "/dock/icons_nav_pageSettings.png" %>' height="50" width="50" />
					</div>
				</c:if>
			</div>
	</div>

		<script type="text/javascript">
			LiferayDock.initialize("<%= UnicodeFormatter.toString(user.getGreeting()) %>");
		</script>
	</c:if>

		<div id="layout-box">
			<table border="0" cellspacing="0" cellpadding="0" width="100%" id="layout-top-banner">
			<tr>
				<td valign="top" width="100%">
					<a href="<%= themeDisplay.getURLHome() %>"><img src="<%= themeDisplay.getCompanyLogo() %>"></a>
				</td>
				<c:if test="<%= !themeDisplay.isSignedIn() %>">
					<td valign="top" align="right" width="100%">
						<a href="<%= themeDisplay.getURLSignIn() %>"><bean:message key="sign-in" /></a>
					</td>
				</c:if>
			</tr>
			</table>
