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

<%@ include file="/html/portlet/wiki/init.jsp" %>

<%
WikiNode node = (WikiNode)request.getAttribute(WebKeys.WIKI_NODE);
WikiPage wikiPage = (WikiPage)request.getAttribute(WebKeys.WIKI_PAGE);
%>

<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/wiki/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace />nodeId" type="hidden" value="<%= node.getNodeId() %>">

<%@ include file="/html/portlet/wiki/breadcrumb.jsp" %>

<br><br>

<%@ include file="/html/portlet/wiki/view_page_content.jsp" %>

<br>

<input class="form-text" name="<portlet:namespace />keywords" size="30" type="text">

<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">

<br><br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>

	<%
	PortletURL portletURL = renderResponse.createRenderURL();

	portletURL.setWindowState(WindowState.MAXIMIZED);

	portletURL.setParameter("redirect", currentURL);
	portletURL.setParameter("nodeId", node.getNodeId());
	portletURL.setParameter("title", wikiPage.getTitle());
	%>

	<c:if test="<%= WikiPagePermission.contains(permissionChecker, wikiPage, ActionKeys.UPDATE) %>">
		<td>

			<%
			portletURL.setParameter("struts_action", "/wiki/edit_page");
			%>

			<liferay-ui:icon image="edit" url="<%= portletURL.toString() %>" />

			<a href="<%= portletURL.toString() %>"><%= LanguageUtil.get(pageContext, "edit") %></a>
		</td>
		<td style="padding-left: 15px;"></td>
	</c:if>

	<c:if test="<%= WikiPagePermission.contains(permissionChecker, wikiPage, ActionKeys.PERMISSIONS) %>">
		<td>
			<liferay-security:permissionsURL
				modelResource="<%= WikiPage.class.getName() %>"
				modelResourceDescription="<%= wikiPage.getTitle() %>"
				resourcePrimKey="<%= wikiPage.getResourcePK().toString() %>"
				var="permissionsURL"
			/>

			<liferay-ui:icon image="permissions" url="<%= permissionsURL %>" />

			<a href="<%= permissionsURL %>"><%= LanguageUtil.get(pageContext, "permissions") %></a>
		</td>
		<td style="padding-left: 15px;"></td>
	</c:if>

	<td>

		<%
		portletURL.setParameter("struts_action", "/wiki/view_page_links");
		%>

		<liferay-ui:icon image="links" message="page-links" url="<%= portletURL.toString() %>" />

		<a href="<%= portletURL.toString() %>"><%= LanguageUtil.get(pageContext, "page-links") %></a>
	</td>
	<td style="padding-left: 15px;"></td>
	<td>

		<%
		portletURL.setParameter("struts_action", "/wiki/view_page_history");
		%>

		<liferay-ui:icon image="history" message="page-history" url="<%= portletURL.toString() %>" />

		<a href="<%= portletURL.toString() %>"><%= LanguageUtil.get(pageContext, "page-history") %></a>
	</td>
	<td style="padding-left: 15px;"></td>
	<td>

		<%
		portletURL.setParameter("struts_action", "/wiki/view_recent_changes");
		%>

		<liferay-ui:icon image="recent_changes" message="recent-changes" url="<%= portletURL.toString() %>" />

		<a href="<%= portletURL.toString() %>"><%= LanguageUtil.get(pageContext, "recent-changes") %></a>
	</td>
	<td style="padding-left: 15px;"></td>
	<td>

		<%
		portletURL.setParameter("struts_action", "/wiki/view_all_pages");
		%>

		<liferay-ui:icon image="all_pages" message="all-pages" url="<%= portletURL.toString() %>" />

		<a href="<%= portletURL.toString() %>"><%= LanguageUtil.get(pageContext, "all-pages") %></a>
	</td>
	<td style="padding-left: 15px;"></td>
	<td>

		<%
		portletURL.setParameter("struts_action", "/wiki/view_orphan_pages");
		%>

		<liferay-ui:icon image="orphan_pages" message="orphan-pages" url="<%= portletURL.toString() %>" />

		<a href="<%= portletURL.toString() %>"><%= LanguageUtil.get(pageContext, "orphan-pages") %></a>
	</td>
</tr>
</table>

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />keywords.focus();
</script>
