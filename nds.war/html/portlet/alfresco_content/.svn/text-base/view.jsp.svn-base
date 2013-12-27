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

<%@ include file="/html/portlet/alfresco_content/init.jsp" %>

<%
String content = (String)request.getAttribute(WebKeys.ALFRESCO_CONTENT);

boolean preview = ParamUtil.getBoolean(renderRequest, "preview");

uuid = (String)renderRequest.getAttribute("uuid");
%>

<div
	<c:if test="<%= preview %>">
		style="border: 2px solid #FF0000; padding: 8px"
	</c:if>
>
	<c:choose>
		<c:when test="<%= Validator.isNotNull(content) %>">
			<%= content %>
		</c:when>
		<c:otherwise>
			<%= LanguageUtil.get(pageContext, "please-contact-the-administrator-to-setup-this-portlet") %>
		</c:otherwise>
	</c:choose>
</div>

<c:if test="<%= themeDisplay.isSignedIn() && !preview %>">
	<br>

	<c:if test="<%= PortletPermission.contains(permissionChecker, plid, PortletKeys.JOURNAL, ActionKeys.CONFIGURATION) %>">
		<liferay-ui:icon image="configuration" message="select-content" url="<%= portletDisplay.getURLConfiguration() %>" />
	</c:if>

	<%
	String ssoSimulateParam = StringPool.BLANK;

	if (GetterUtil.getBoolean(PropsUtil.get(PropsUtil.ALFRESCO_CONTENT_ONE_STEP_EDIT_SSO_SIMULATE))) {
		ssoSimulateParam = "user=" + user.getLogin() + "&";
	}
	%>

	<c:if test="<%= Validator.isNotNull(uuid) && AlfrescoContentUtil.hasPermission(user.getLogin(), PortalUtil.getUserPassword(renderRequest), uuid, org.alfresco.webservice.util.Constants.WRITE) %>">
		<liferay-ui:icon image="edit" message="edit-content" url='<%= "javascript: window.open(\'" + AlfrescoContentUtil.getEndpointAddress() + "/alfresco/integration/ice?nodeid=workspace://SpacesStore/" + uuid + "&p_p_id=" + renderResponse.getNamespace() + "&" + ssoSimulateParam + "\'); void(\'\');" %>' />
	</c:if>
</c:if>
