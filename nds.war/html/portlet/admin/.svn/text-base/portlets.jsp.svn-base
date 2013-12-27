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
List headerNames = new ArrayList();

headerNames.add("portlet");
headerNames.add("active");
//headerNames.add("indexed");
headerNames.add("roles");

SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

List portlets = PortletLocalServiceUtil.getPortlets(company.getCompanyId(), false, false);

Collections.sort(portlets, new PortletTitleComparator(application, locale));

int total = portlets.size();

searchContainer.setTotal(total);

List results = ListUtil.subList(portlets, searchContainer.getStart(), searchContainer.getEnd());

searchContainer.setResults(results);

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
	Portlet portlet = (Portlet)results.get(i);

	ResultRow row = new ResultRow(portlet, portlet.getPrimaryKey().toString(), i);

	PortletURL rowURL = renderResponse.createRenderURL();

	rowURL.setWindowState(WindowState.MAXIMIZED);

	rowURL.setParameter("struts_action", "/admin/edit_portlet");
	rowURL.setParameter("redirect", currentURL);
	rowURL.setParameter("portletId", portlet.getPortletId());

	// Name and description

	StringBuffer sb = new StringBuffer();

	String title = PortalUtil.getPortletTitle(portlet, application, locale);
	String displayName = portlet.getDisplayName();

	sb.append(title);

	if (Validator.isNotNull(displayName) && !title.equals(displayName)) {
		sb.append("<br>");
		sb.append("<span style=\"font-size: xx-small;\">");
		sb.append(portlet.getDisplayName());
		sb.append("</span>");
	}

	row.addText(sb.toString(), rowURL);

	// Active

	row.addText(LanguageUtil.get(pageContext, (portlet.isActive() ? "yes" : "no")), rowURL);

	// Indexed

	//row.addText(LanguageUtil.get(pageContext, (Validator.isNotNull(portlet.getIndexerClass()) ? "yes" : "no")), rowURL);

	// Roles

	row.addText(StringUtil.merge(portlet.getRolesArray(), ", "), rowURL);

	// Add result row

	resultRows.add(row);
}
%>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
