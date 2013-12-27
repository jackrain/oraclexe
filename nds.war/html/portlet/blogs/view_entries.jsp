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

<%
boolean showAddEntryButton = tabs1.equals("entries") && PortletPermission.contains(permissionChecker, plid, PortletKeys.BLOGS, ActionKeys.ADD_ENTRY);
%>

<c:if test="<%= showAddEntryButton || (results.size() > 0) %>">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<c:if test="<%= showAddEntryButton %>">
					<td>
						<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-entry") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/blogs/edit_entry" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>';">
					</td>
					<td style="padding-left: 30px;"></td>
				</c:if>

				<c:if test="<%= results.size() > 0 %>">
					<td>
						<input class="form-text" name="<portlet:namespace />keywords" size="30" type="text">

						<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search-entries") %>">
					</td>
				</c:if>
			</tr>
			</table>
		</td>
	</tr>
	</table>

	<c:if test="<%= results.size() > 0 %>">
		<br>
	</c:if>
</c:if>

<%
for (int i = 0; i < results.size(); i++) {
	BlogsEntry entry = (BlogsEntry)results.get(i);
%>

	<%@ include file="/html/portlet/blogs/view_entry_content.jsp" %>

	<c:if test="<%= i + 1 < results.size() %>">
		<br><div class="beta-separator"></div><br>
	</c:if>

<%
}
%>

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
