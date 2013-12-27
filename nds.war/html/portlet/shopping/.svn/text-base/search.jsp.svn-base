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

<%@ include file="/html/portlet/shopping/init.jsp" %>

<%
String breadcrumbsCategoryId = ParamUtil.getString(request, "breadcrumbsCategoryId");

String categoryIds = ParamUtil.getString(request, "categoryIds");
String[] categoryIdsArray = StringUtil.split(categoryIds);

String keywords = ParamUtil.getString(request, "keywords");
%>

<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace />breadcrumbsCategoryId" type="hidden" value="<%= breadcrumbsCategoryId %>">
<input name="<portlet:namespace />categoryIds" type="hidden" value="<%= categoryIds %>">

<%= ShoppingUtil.getBreadcrumbs(breadcrumbsCategoryId, pageContext, renderRequest, renderResponse) %> &raquo; <%= LanguageUtil.get(pageContext, "search") %>

<br><br>

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/shopping/search");
portletURL.setParameter("breadcrumbsCategoryId", breadcrumbsCategoryId);
portletURL.setParameter("categoryIds", categoryIds);
portletURL.setParameter("keywords", keywords);

List headerNames = new ArrayList();

headerNames.add("sku");
headerNames.add("description");
headerNames.add("min-qty");
headerNames.add("price");
headerNames.add(StringPool.BLANK);

SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, LanguageUtil.format(pageContext, "no-entries-were-found-that-matched-the-keywords-x", "<b>" + keywords + "</b>"));

int total = ShoppingItemLocalServiceUtil.searchCount(portletGroupId, categoryIdsArray, keywords);

searchContainer.setTotal(total);

List results = ShoppingItemLocalServiceUtil.search(portletGroupId, categoryIdsArray, keywords, searchContainer.getStart(), searchContainer.getEnd());

searchContainer.setResults(results);

List resultRows = searchContainer.getResultRows();

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
%>

<input class="form-text" name="<portlet:namespace />keywords" size="30" type="text" value="<%= keywords %>">

<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">

<br><br>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />keywords.focus();
</script>
