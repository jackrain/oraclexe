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

<%@ include file="/html/portlet/wiki_display/init.jsp" %>

<%
WikiNode node = (WikiNode)request.getAttribute(WebKeys.WIKI_NODE);
WikiPage wikiPage = (WikiPage)request.getAttribute(WebKeys.WIKI_PAGE);
%>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td>
		<a href="<portlet:renderURL><portlet:param name="struts_action" value="/wiki_display/view" /><portlet:param name="nodeId" value="<%= node.getNodeId() %>" /><portlet:param name="title" value="<%= WikiPageImpl.FRONT_PAGE %>" /></portlet:renderURL>">
		<%= node.getName() %>
		</a>

		&raquo;

		<a href="<portlet:renderURL><portlet:param name="struts_action" value="/wiki_display/view" /><portlet:param name="nodeId" value="<%= node.getNodeId() %>" /><portlet:param name="title" value="<%= wikiPage.getTitle() %>" /></portlet:renderURL>">
		<%= wikiPage.getTitle() %>
		</a>
	</td>
	<td align="right">
	</td>
</tr>
</table>

<br>

<%@ include file="/html/portlet/wiki/view_page_content.jsp" %>

<br>

<c:if test="<%= WikiPagePermission.contains(permissionChecker, wikiPage, ActionKeys.UPDATE) %>">

	<%
	PortletURL portletURL = renderResponse.createRenderURL();

	portletURL.setWindowState(WindowState.MAXIMIZED);

	portletURL.setParameter("struts_action", "/wiki_display/edit_page");
	portletURL.setParameter("redirect", currentURL);
	portletURL.setParameter("nodeId", node.getNodeId());
	portletURL.setParameter("title", wikiPage.getTitle());
	%>

	<liferay-ui:icon image="edit" url="<%= portletURL.toString() %>" />
</c:if>

<c:if test="<%= WikiPagePermission.contains(permissionChecker, wikiPage, ActionKeys.PERMISSIONS) %>">
	<liferay-security:permissionsURL
		modelResource="<%= WikiPage.class.getName() %>"
		modelResourceDescription="<%= wikiPage.getTitle() %>"
		resourcePrimKey="<%= wikiPage.getPrimaryKey().toString() %>"
		var="permissionsURL"
	/>

	<liferay-ui:icon image="permissions" url="<%= permissionsURL %>" />
</c:if>
