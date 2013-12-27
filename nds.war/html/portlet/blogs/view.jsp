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

<%@ include file="/html/portlet/blogs/init.jsp" %>

<%
String tabs1 = ParamUtil.getString(request, "tabs1", "entries");

BlogsCategory category = (BlogsCategory)request.getAttribute(WebKeys.BLOGS_CATEGORY);

String categoryId = BeanParamUtil.getString(category, request, "categoryId", BlogsCategoryImpl.DEFAULT_PARENT_CATEGORY_ID);

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setParameter("struts_action", "/blogs/view");
portletURL.setParameter("tabs1", tabs1);
portletURL.setParameter("categoryId", categoryId);
%>

<liferay-ui:tabs
	names="entries,categories"
	url="<%= portletURL.toString() %>"
/>

<c:choose>
	<c:when test='<%= tabs1.equals("entries") %>'>
		<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/blogs/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm1" onSubmit="submitForm(this); return false;">
		<input name="<portlet:namespace />groupId" type="hidden" value="<%= layout.getGroupId() %>">

		<%
		SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, 5, portletURL, null, null);

		int total = BlogsEntryLocalServiceUtil.getGroupEntriesCount(portletGroupId);

		searchContainer.setTotal(total);

		List results = BlogsEntryLocalServiceUtil.getGroupEntries(portletGroupId, searchContainer.getStart(), searchContainer.getEnd());

		searchContainer.setResults(results);
		%>

		<%@ include file="/html/portlet/blogs/view_entries.jsp" %>

		</form>

		<script type="text/javascript">
			if (document.<portlet:namespace />fm1.<portlet:namespace />keywords) {
				document.<portlet:namespace />fm1.<portlet:namespace />keywords.focus();
			}
		</script>
	</c:when>
	<c:when test='<%= tabs1.equals("categories") %>'>

		<%
		List categoryIds = new ArrayList();

		BlogsCategoryLocalServiceUtil.getSubcategoryIds(categoryIds, categoryId);
		%>

		<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/blogs/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm1" onSubmit="submitForm(this); return false;">
		<input name="<portlet:namespace />breadcrumbsCategoryId" type="hidden" value="<%= categoryId %>">
		<input name="<portlet:namespace />categoryIds" type="hidden" value="<%= StringUtil.merge(categoryIds) %>">

		<c:if test="<%= category != null %>">
			<%= BlogsUtil.getBreadcrumbs(category, pageContext, renderRequest, renderResponse) %>

			<br><br>
		</c:if>

		<%
		List headerNames = new ArrayList();

		headerNames.add("category");
		headerNames.add("num-of-categories");
		headerNames.add("num-of-entries");
		headerNames.add(StringPool.BLANK);

		SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, "cur1", SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

		int total = BlogsCategoryLocalServiceUtil.getCategoriesCount(categoryId);

		searchContainer.setTotal(total);

		List results = BlogsCategoryLocalServiceUtil.getCategories(categoryId, searchContainer.getStart(), searchContainer.getEnd());

		searchContainer.setResults(results);

		List resultRows = searchContainer.getResultRows();

		for (int i = 0; i < results.size(); i++) {
			BlogsCategory curCategory = (BlogsCategory)results.get(i);

			ResultRow row = new ResultRow(curCategory, curCategory.getPrimaryKey().toString(), i);

			PortletURL rowURL = renderResponse.createRenderURL();

			rowURL.setWindowState(WindowState.MAXIMIZED);

			rowURL.setParameter("struts_action", "/blogs/view");
			rowURL.setParameter("tabs1", "categories");
			rowURL.setParameter("categoryId", curCategory.getCategoryId());

			// Name and description

			StringBuffer sb = new StringBuffer();

			sb.append(curCategory.getName());

			if (Validator.isNotNull(curCategory.getDescription())) {
				sb.append("<br>");
				sb.append("<span style=\"font-size: xx-small;\">");
				sb.append(curCategory.getDescription());
				sb.append("</span>");
			}

			row.addText(sb.toString(), rowURL);

			// Statistics

			List subcategoryIds = new ArrayList();

			subcategoryIds.add(curCategory.getCategoryId());

			BlogsCategoryLocalServiceUtil.getSubcategoryIds(subcategoryIds, curCategory.getCategoryId());

			int categoriesCount = subcategoryIds.size() - 1;
			int entriesCount = BlogsEntryLocalServiceUtil.getCategoriesEntriesCount(subcategoryIds);

			row.addText(Integer.toString(categoriesCount), rowURL);
			row.addText(Integer.toString(entriesCount), rowURL);

			// Action

			row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/blogs/category_action.jsp");

			// Add result row

			resultRows.add(row);
		}

		boolean showAddCategoryButton = BlogsCategoryPermission.contains(permissionChecker, categoryId, ActionKeys.ADD_CATEGORY);
		%>

		<c:if test="<%= showAddCategoryButton || (results.size() > 0) %>">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<c:if test="<%= showAddCategoryButton %>">
					<td>
						<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-category") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/blogs/edit_category" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="parentCategoryId" value="<%= categoryId %>" /></portlet:renderURL>';">
					</td>
					<td style="padding-left: 30px;"></td>
				</c:if>

				<c:if test="<%= results.size() > 0 %>">
					<td>
						<input class="form-text" name="<portlet:namespace />keywords" size="30" type="text">

						<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search-categories") %>">
					</td>
				</c:if>
			</tr>
			</table>

			<c:if test="<%= results.size() > 0 %>">
				<br>
			</c:if>
		</c:if>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

		</form>

		<script type="text/javascript">
			if (document.<portlet:namespace />fm1.<portlet:namespace />keywords) {
				document.<portlet:namespace />fm1.<portlet:namespace />keywords.focus();
			}
		</script>

		<c:if test="<%= category != null %>">
			<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/blogs/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm2" onSubmit="submitForm(this); return false;">
			<input name="<portlet:namespace />breadcrumbsCategoryId" type="hidden" value="<%= categoryId %>">
			<input name="<portlet:namespace />categoryIds" type="hidden" value="<%= categoryId %>">

			<%
			searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, 5, portletURL, null, null);

			total = BlogsEntryLocalServiceUtil.getEntriesCount(categoryId);

			searchContainer.setTotal(total);

			results = BlogsEntryLocalServiceUtil.getEntries(categoryId, searchContainer.getStart(), searchContainer.getEnd());

			searchContainer.setResults(results);
			%>

			<c:if test="<%= results.size() > 0 %>">
				<br>

				<liferay-ui:tabs
					names="entries"
					param="tabs2"
				/>

				<%@ include file="/html/portlet/blogs/view_entries.jsp" %>
			</c:if>

			</form>

			<script type="text/javascript">
				if (document.<portlet:namespace />fm1.<portlet:namespace />keywords) {
					document.<portlet:namespace />fm1.<portlet:namespace />keywords.focus();
				}
				else if (document.<portlet:namespace />fm2.<portlet:namespace />keywords) {
					document.<portlet:namespace />fm2.<portlet:namespace />keywords.focus();
				}
			</script>
		</c:if>
	</c:when>
</c:choose>
