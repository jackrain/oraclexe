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

<%@ include file="/html/portlet/journal/init.jsp" %>

<form method="post" name="<portlet:namespace />fm">

<liferay-ui:tabs names="structures" />

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(LiferayWindowState.POP_UP);

portletURL.setParameter("struts_action", "/journal/select_structure");

StructureSearch searchContainer = new StructureSearch(renderRequest, portletURL);

searchContainer.setDelta(10);
%>

<liferay-ui:search-form
	page="/html/portlet/journal/structure_search.jsp"
	searchContainer="<%= searchContainer %>"
/>

<%
StructureSearchTerms searchTerms = (StructureSearchTerms)searchContainer.getSearchTerms();

int total = JournalStructureLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getStructureId(), searchTerms.getName(), searchTerms.getDescription(), searchTerms.isAndOperator());

searchContainer.setTotal(total);

List results = JournalStructureLocalServiceUtil.search(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getStructureId(), searchTerms.getName(), searchTerms.getDescription(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), null);

searchContainer.setResults(results);
%>

<br><div class="beta-separator"></div><br>

<%

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
	JournalStructure structure = (JournalStructure)results.get(i);

	ResultRow row = new ResultRow(structure, structure.getPrimaryKey().toString(), i);

	StringBuffer sb = new StringBuffer();

	sb.append("javascript: opener.");
	sb.append(renderResponse.getNamespace());
	sb.append("selectStructure('");
	sb.append(structure.getStructureId());
	sb.append("', '");
	sb.append(structure.getName());
	sb.append("'); window.close();");

	String rowHREF = sb.toString();

	// Structure id

	row.addText(structure.getStructureId(), rowHREF);

	// Name and description

	sb = new StringBuffer();

	sb.append(structure.getName());

	if (Validator.isNotNull(structure.getDescription())) {
		sb.append("<br>");
		sb.append("<span style=\"font-size: xx-small;\">");
		sb.append(structure.getDescription());
		sb.append("</span>");
	}

	row.addText(sb.toString(), rowHREF);

	// Add result row

	resultRows.add(row);
}
%>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />searchStructureId.focus();
</script>
