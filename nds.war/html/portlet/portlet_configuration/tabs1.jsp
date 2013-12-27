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

<%@ include file="/html/portlet/portlet_configuration/init.jsp" %>

<%
String redirect = ParamUtil.getString(request, "redirect");

String portletResource = ParamUtil.getString(request, "portletResource");
String previewWidth = ParamUtil.getString(request, "previewWidth");

Portlet portlet = PortletLocalServiceUtil.getPortletById(company.getCompanyId(), portletResource);

String tabNames = "look-and-feel,permissions";
String tabValues = tabNames;

if (Validator.isNotNull(portlet.getConfigurationPath())) {
	tabNames = "setup," + tabNames;
	tabValues = "configuration," + tabValues;
}

// Configuration

PortletURL configurationURL = renderResponse.createRenderURL();

configurationURL.setWindowState(WindowState.MAXIMIZED);

configurationURL.setParameter("struts_action", "/portlet_configuration/edit_configuration");
configurationURL.setParameter("redirect", redirect);
configurationURL.setParameter("portletResource", portletResource);
configurationURL.setParameter("previewWidth", previewWidth);

// Look and feel

PortletURL lookAndFeelURL = renderResponse.createRenderURL();

lookAndFeelURL.setWindowState(WindowState.MAXIMIZED);

lookAndFeelURL.setParameter("struts_action", "/portlet_configuration/edit_look_and_feel");
lookAndFeelURL.setParameter("redirect", redirect);
lookAndFeelURL.setParameter("portletResource", portletResource);
lookAndFeelURL.setParameter("previewWidth", previewWidth);

// Permissions

PortletURL permissionsURL = renderResponse.createRenderURL();

permissionsURL.setWindowState(WindowState.MAXIMIZED);

permissionsURL.setParameter("struts_action", "/portlet_configuration/edit_permissions");
permissionsURL.setParameter("redirect", redirect);
permissionsURL.setParameter("portletResource", portletResource);
permissionsURL.setParameter("resourcePrimKey", PortletPermission.getPrimaryKey(layout.getPlid(), portletResource));
permissionsURL.setParameter("previewWidth", previewWidth);
%>

<c:choose>
	<c:when test="<%= Validator.isNotNull(portlet.getConfigurationPath()) %>">
		<liferay-ui:tabs
			names="setup,look-and-feel,permissions"
			url0="<%= configurationURL.toString() %>"
			url1="<%= lookAndFeelURL.toString() %>"
			url2="<%= permissionsURL.toString() %>"
		/>
	</c:when>
	<c:otherwise>
		<liferay-ui:tabs
			names="look-and-feel,permissions"
			url0="<%= lookAndFeelURL.toString() %>"
			url1="<%= permissionsURL.toString() %>"
		/>
	</c:otherwise>
</c:choose>
