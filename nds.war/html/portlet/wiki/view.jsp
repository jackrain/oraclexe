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

<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/wiki/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm">

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/wiki/view");

List headerNames = new ArrayList();

headerNames.add("node");
headerNames.add("num-of-pages");
headerNames.add("last-post-date");
headerNames.add(StringPool.BLANK);

SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

int total = WikiNodeLocalServiceUtil.getNodesCount(portletGroupId);

searchContainer.setTotal(total);

List results = WikiNodeLocalServiceUtil.getNodes(portletGroupId, searchContainer.getStart(), searchContainer.getEnd());

searchContainer.setResults(results);

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
	WikiNode node = (WikiNode)results.get(i);

	ResultRow row = new ResultRow(node, node.getPrimaryKey().toString(), i);

	PortletURL rowURL = renderResponse.createRenderURL();

	rowURL.setWindowState(WindowState.MAXIMIZED);

	rowURL.setParameter("struts_action", "/wiki/view_page");
	rowURL.setParameter("nodeId", node.getNodeId());
	rowURL.setParameter("title", WikiPageImpl.FRONT_PAGE);

	// Name

	row.addText(node.getName(), rowURL);

	// Number of pages

	int pagesCount = WikiPageLocalServiceUtil.getPagesCount(node.getNodeId(), true);

	row.addText(Integer.toString(pagesCount), rowURL);

	// Last post date

	if (node.getLastPostDate() == null) {
		row.addText(LanguageUtil.get(pageContext, "never"), rowURL);
	}
	else {
		row.addText(dateFormatDateTime.format(node.getLastPostDate()), rowURL);
	}

	// Action

	row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/wiki/node_action.jsp");

	// Add result row

	resultRows.add(row);
}

boolean showAddNodeButton = PortletPermission.contains(permissionChecker, plid, PortletKeys.WIKI, ActionKeys.ADD_NODE);
%>

<c:if test="<%= showAddNodeButton || (results.size() > 0) %>">
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<c:if test="<%= showAddNodeButton %>">
			<td>
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-node") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/wiki/edit_node" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>';">
			</td>
			<td style="padding-left: 30px;"></td>
		</c:if>

		<c:if test="<%= results.size() > 0 %>">
			<td>
				<input class="form-text" name="<portlet:namespace />keywords" size="30" type="text">

				<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search-nodes") %>">
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
	if (document.<portlet:namespace />fm.<portlet:namespace />keywords) {
		document.<portlet:namespace />fm.<portlet:namespace />keywords.focus();
	}
</script>
