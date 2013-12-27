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

<%@ include file="/html/portlet/message_boards/init.jsp" %>

<%
MBCategory category = (MBCategory)request.getAttribute(WebKeys.MESSAGE_BOARDS_CATEGORY);

String categoryId = BeanParamUtil.getString(category, request, "categoryId", MBCategoryImpl.DEFAULT_PARENT_CATEGORY_ID);
%>

<form method="post" name="<portlet:namespace />fm">

<liferay-ui:tabs names="categories" />

<c:if test="<%= category != null %>">
	<%= MBUtil.getBreadcrumbs(category, null, pageContext, renderRequest, renderResponse) %>

	<br><br>
</c:if>

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(LiferayWindowState.POP_UP);

portletURL.setParameter("struts_action", "/message_boards/select_category");

List headerNames = new ArrayList();

headerNames.add("category");
headerNames.add("num-of-categories");
headerNames.add("num-of-threads");
headerNames.add("num-of-posts");
headerNames.add(StringPool.BLANK);

SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

int total = MBCategoryLocalServiceUtil.getCategoriesCount(portletGroupId, categoryId);

searchContainer.setTotal(total);

List results = MBCategoryLocalServiceUtil.getCategories(portletGroupId, categoryId, searchContainer.getStart(), searchContainer.getEnd());

searchContainer.setResults(results);

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
	MBCategory curCategory = (MBCategory)results.get(i);

	ResultRow row = new ResultRow(curCategory, curCategory.getPrimaryKey().toString(), i);

	PortletURL rowURL = renderResponse.createRenderURL();

	rowURL.setWindowState(LiferayWindowState.POP_UP);

	rowURL.setParameter("struts_action", "/message_boards/select_category");
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

	MBCategoryLocalServiceUtil.getSubcategoryIds(subcategoryIds, portletGroupId, curCategory.getCategoryId());

	int categoriesCount = subcategoryIds.size() - 1;
	int threadsCount = MBThreadLocalServiceUtil.getCategoriesThreadsCount(subcategoryIds);
	int messagesCount = MBMessageLocalServiceUtil.getCategoriesMessagesCount(subcategoryIds);

	row.addText(Integer.toString(categoriesCount), rowURL);
	row.addText(Integer.toString(threadsCount), rowURL);
	row.addText(Integer.toString(messagesCount), rowURL);

	// Action

	sb = new StringBuffer();

	sb.append("opener.");
	sb.append(renderResponse.getNamespace());
	sb.append("selectCategory('");
	sb.append(curCategory.getCategoryId());
	sb.append("', '");
	sb.append(UnicodeFormatter.toString(curCategory.getName()));
	sb.append("'); window.close();");

	row.addButton("right", SearchEntry.DEFAULT_VALIGN, LanguageUtil.get(pageContext, "choose"), sb.toString());

	// Add result row

	resultRows.add(row);
}
%>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

</form>
