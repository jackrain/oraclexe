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
ShoppingCategory category = (ShoppingCategory)request.getAttribute(WebKeys.SHOPPING_CATEGORY);

String categoryId = BeanParamUtil.getString(category, request, "categoryId", ShoppingCategoryImpl.DEFAULT_PARENT_CATEGORY_ID);

List categoryIds = new ArrayList();

ShoppingCategoryLocalServiceUtil.getSubcategoryIds(categoryIds, portletGroupId, categoryId);

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/shopping/view");
portletURL.setParameter("tabs1", tabs1);
portletURL.setParameter("categoryId", categoryId);
%>

<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm1" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace />breadcrumbsCategoryId" type="hidden" value="<%= categoryId %>">
<input name="<portlet:namespace />categoryIds" type="hidden" value="<%= StringUtil.merge(categoryIds) %>">

<c:if test="<%= category != null %>">
	<%= ShoppingUtil.getBreadcrumbs(category, pageContext, renderRequest, renderResponse) %>

	<br><br>
</c:if>

<%
List headerNames = new ArrayList();

headerNames.add("category");
headerNames.add("num-of-categories");
headerNames.add("num-of-items");
headerNames.add(StringPool.BLANK);

SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, "cur1", SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

int total = ShoppingCategoryLocalServiceUtil.getCategoriesCount(portletGroupId, categoryId);

searchContainer.setTotal(total);

List results = ShoppingCategoryLocalServiceUtil.getCategories(portletGroupId, categoryId, searchContainer.getStart(), searchContainer.getEnd());

searchContainer.setResults(results);

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
	ShoppingCategory curCategory = (ShoppingCategory)results.get(i);

	ResultRow row = new ResultRow(curCategory, curCategory.getPrimaryKey().toString(), i);

	PortletURL rowURL = renderResponse.createRenderURL();

	rowURL.setWindowState(WindowState.MAXIMIZED);

	rowURL.setParameter("struts_action", "/shopping/view");
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

	ShoppingCategoryLocalServiceUtil.getSubcategoryIds(subcategoryIds, portletGroupId, curCategory.getCategoryId());

	int categoriesCount = subcategoryIds.size() - 1;
	int itemsCount = ShoppingItemLocalServiceUtil.getCategoriesItemsCount(subcategoryIds);

	row.addText(Integer.toString(categoriesCount), rowURL);
	row.addText(Integer.toString(itemsCount), rowURL);

	// Action

	row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/shopping/category_action.jsp");

	// Add result row

	resultRows.add(row);
}

boolean showAddCategoryButton = ShoppingCategoryPermission.contains(permissionChecker, plid, categoryId, ActionKeys.ADD_CATEGORY);
%>

<c:if test="<%= showAddCategoryButton || (results.size() > 0) %>">
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<c:if test="<%= showAddCategoryButton %>">
			<td>
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-category") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/edit_category" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="parentCategoryId" value="<%= categoryId %>" /></portlet:renderURL>';">
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

<c:if test="<%= category != null %>">
	<br>
</c:if>

</form>

<script type="text/javascript">
	if (document.<portlet:namespace />fm1.<portlet:namespace />keywords) {
		document.<portlet:namespace />fm1.<portlet:namespace />keywords.focus();
	}
</script>

<c:if test="<%= category != null %>">
	<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm2" onSubmit="submitForm(this); return false;">
	<input name="<portlet:namespace />breadcrumbsCategoryId" type="hidden" value="<%= categoryId %>">
	<input name="<portlet:namespace />categoryIds" type="hidden" value="<%= categoryId %>">

	<liferay-ui:tabs names="items" />

	<%
	String orderByCol = ParamUtil.getString(request, "orderByCol");
	String orderByType = ParamUtil.getString(request, "orderByType");

	if (Validator.isNotNull(orderByCol) && Validator.isNotNull(orderByType)) {
		prefs.setValue(PortletKeys.SHOPPING, "items-order-by-col", orderByCol);
		prefs.setValue(PortletKeys.SHOPPING, "items-order-by-type", orderByType);
	}
	else {
		orderByCol = prefs.getValue(PortletKeys.SHOPPING, "items-order-by-col", "sku");
		orderByType = prefs.getValue(PortletKeys.SHOPPING, "items-order-by-type", "asc");
	}

	OrderByComparator orderByComparator = ShoppingUtil.getItemOrderByComparator(orderByCol, orderByType);

	headerNames.clear();

	headerNames.add("sku");
	headerNames.add("description");
	headerNames.add("min-qty");
	headerNames.add("price");
	headerNames.add(StringPool.BLANK);

	Map orderableHeaders = CollectionFactory.getHashMap();

	orderableHeaders.put("sku", "sku");
	orderableHeaders.put("description", "name");
	orderableHeaders.put("min-qty", "min-qty");
	orderableHeaders.put("price", "price");

	searchContainer = new SearchContainer(renderRequest, null, null, "cur2", SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

	searchContainer.setOrderableHeaders(orderableHeaders);
	searchContainer.setOrderByCol(orderByCol);
	searchContainer.setOrderByType(orderByType);

	total = ShoppingItemLocalServiceUtil.getItemsCount(categoryId);

	searchContainer.setTotal(total);

	results = ShoppingItemLocalServiceUtil.getItems(categoryId, searchContainer.getStart(), searchContainer.getEnd(), orderByComparator);

	searchContainer.setResults(results);

	resultRows = searchContainer.getResultRows();

	for (int i = 0; i < results.size(); i++) {
		ShoppingItem item = (ShoppingItem)results.get(i);

		ResultRow row = new ResultRow(item, item.getPrimaryKey().toString(), i);

		PortletURL rowURL = renderResponse.createRenderURL();

		rowURL.setWindowState(WindowState.MAXIMIZED);

		rowURL.setParameter("struts_action", "/shopping/view_item");
		rowURL.setParameter("itemId", item.getItemId());

		// SKU and small image

		StringBuffer sb = new StringBuffer();

		if (item.isSmallImage()) {
			sb.append("<br>");
			sb.append("<img alt=\"");
			sb.append(item.getSku());
			sb.append("\" border=\"0\" src=\"");

			if (Validator.isNotNull(item.getSmallImageURL())) {
				sb.append(item.getSmallImageURL());
			}
			else {
				sb.append(themeDisplay.getPathImage());
				sb.append("/shopping/item?img_id=");
				sb.append(item.getItemId());
				sb.append("&small=1");
			}

			sb.append("\">");
		}
		else {
			sb.append("<span style=\"font-size: xx-small;\">");
			sb.append(item.getSku());
			sb.append("</span>");
		}

		row.addText(sb.toString(), rowURL);

		// Description

		sb = new StringBuffer();

		sb.append(item.getName());

		sb.append("<span style=\"font-size: xx-small;\">");

		if (Validator.isNotNull(item.getDescription())) {
			sb.append("<br>");
			sb.append(item.getDescription());
		}

		Properties props = new OrderedProperties();

		PropertiesUtil.load(props, item.getProperties());

		Enumeration enu = props.propertyNames();

		while (enu.hasMoreElements()) {
			String propsKey = (String)enu.nextElement();
			String propsValue = props.getProperty(propsKey, StringPool.BLANK);

			sb.append("<br>");
			sb.append(propsKey);
			sb.append(": ");
			sb.append(propsValue);
		}

		sb.append("</span>");

		row.addText(sb.toString(), rowURL);

		// Minimum quantity

		row.addText(String.valueOf(item.getMinQuantity()), rowURL);

		// Price

		if (item.getDiscount() <= 0) {
			row.addText(currency.getSymbol() + doubleFormat.format(item.getPrice()), rowURL);
		}
		else {
			row.addText(
				"<span class=\"portlet-msg-success\">" +
				currency.getSymbol() + doubleFormat.format(ShoppingUtil.calculateActualPrice(item)) +
				"</span>",
				rowURL);
		}

		// Action

		row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/shopping/item_action.jsp");

		// Add result row

		resultRows.add(row);
	}

	boolean showAddItemButton = ShoppingCategoryPermission.contains(permissionChecker, category, ActionKeys.ADD_ITEM);
	%>

	<c:if test="<%= showAddItemButton || (results.size() > 0) %>">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<c:if test="<%= showAddItemButton %>">
				<td>
					<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-item") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/edit_item" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="categoryId" value="<%= categoryId %>" /></portlet:renderURL>';">

					<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-books") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/add_book_items" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="categoryId" value="<%= categoryId %>" /></portlet:renderURL>';">
				</td>
				<td style="padding-left: 30px;"></td>
			</c:if>

			<c:if test="<%= results.size() > 0 %>">
				<td>
					<input class="form-text" name="<portlet:namespace />keywords" size="30" type="text">

					<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search-items") %>">
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
		else if (document.<portlet:namespace />fm2.<portlet:namespace />keywords) {
			document.<portlet:namespace />fm2.<portlet:namespace />keywords.focus();
		}
	</script>
</c:if>
