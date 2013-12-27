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

<table border="0" cellpadding="0" cellspacing="0" width="100%">

<c:if test="<%= (category == null) && !entry.getCategoryId().equals(BlogsCategoryImpl.DEFAULT_PARENT_CATEGORY_ID) %>">
	<tr>
		<td>
			<%= BlogsUtil.getBreadcrumbs(entry.getCategoryId(), pageContext, renderRequest, renderResponse) %>

			<br><br>
		</td>
	</tr>
</c:if>

<tr>
	<td>
		<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="viewEntryURL">
			<portlet:param name="struts_action" value="/blogs/view_entry" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="entryId" value="<%= entry.getEntryId() %>" />
		</portlet:renderURL>

		<span style="font-size: small;"><b><a href="<%= viewEntryURL %>"><%= entry.getTitle() %></a></b></span><br>
		<span style="font-size: x-small;"><%= LanguageUtil.get(pageContext, "by") %> <%= PortalUtil.getUserName(entry.getUserId(), entry.getUserName()) %>, <%= LanguageUtil.get(pageContext, "on") %> <%= dateFormatDateTime.format(entry.getDisplayDate()) %></span>
	</td>
</tr>
<tr>
	<td>
		<br>
	</td>
</tr>
<tr>
	<td>
		<c:if test="<%= BlogsEntryPermission.contains(permissionChecker, entry, ActionKeys.UPDATE) %>">
			<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="editEntryURL">
				<portlet:param name="struts_action" value="/blogs/edit_entry" />
				<portlet:param name="redirect" value="<%= currentURL %>" />
				<portlet:param name="entryId" value="<%= entry.getEntryId() %>" />
			</portlet:renderURL>

			<liferay-ui:icon image="edit" url="<%= editEntryURL %>" />
		</c:if>

		<c:if test="<%= BlogsEntryPermission.contains(permissionChecker, entry, ActionKeys.PERMISSIONS) %>">
			<liferay-security:permissionsURL
				modelResource="<%= BlogsEntry.class.getName() %>"
				modelResourceDescription="<%= entry.getTitle() %>"
				resourcePrimKey="<%= entry.getPrimaryKey().toString() %>"
				var="permissionsEntryURL"
			/>

			<liferay-ui:icon image="permissions" url="<%= permissionsEntryURL %>" />
		</c:if>

		<c:if test="<%= BlogsEntryPermission.contains(permissionChecker, entry, ActionKeys.DELETE) %>">
			<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="deleteEntryURL">
				<portlet:param name="struts_action" value="/blogs/edit_entry" />
				<portlet:param name="<%= Constants.CMD %>" value="<%= Constants.DELETE %>" />
				<portlet:param name="redirect" value="<%= currentURL %>" />
				<portlet:param name="entryId" value="<%= entry.getEntryId() %>" />
			</portlet:actionURL>

			<liferay-ui:icon-delete url="<%= deleteEntryURL %>" />
		</c:if>
	</td>
</tr>
<tr>
	<td>
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= entry.getContent() %>
	</td>
</tr>
</table>
