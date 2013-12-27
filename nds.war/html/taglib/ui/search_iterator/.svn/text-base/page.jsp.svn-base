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

<%@ include file="/html/taglib/init.jsp" %>

<%
SearchContainer searchContainer = (SearchContainer)request.getAttribute("liferay-ui:search:searchContainer");

List resultRows = searchContainer.getResultRows();
List headerNames = searchContainer.getHeaderNames();
Map orderableHeaders = searchContainer.getOrderableHeaders();
RowChecker rowChecker = searchContainer.getRowChecker();

if (rowChecker != null) {
	headerNames.add(0, rowChecker.getAllRowsCheckBox());
}
%>

<c:if test="<%= (resultRows.size() > 0) || ((resultRows.size() == 0) && (searchContainer.getEmptyResultsMessage() != null)) %>">
	<table cellpadding="4" cellspacing="0" style="border: 1px solid <%= colorScheme.getPortletMenuBg() %>;" width="100%">
	<tr class="portlet-section-header" style="font-weight: bold;">

	<%
	for (int i = 0; i < headerNames.size(); i++) {
		String headerName = (String)headerNames.get(i);

		String orderKey = null;
		String orderByType = null;
		boolean orderCurrentHeader = false;

		if (orderableHeaders != null) {
			orderKey = (String)orderableHeaders.get(headerName);

			if (orderKey != null) {
				orderByType = searchContainer.getOrderByType();

				if (orderKey.equals(searchContainer.getOrderByCol())) {
					orderCurrentHeader = true;
				}
			}
		}

		if (orderCurrentHeader) {
			if (orderByType.equals("asc")) {
				orderByType = "desc";
			}
			else {
				orderByType = "asc";
			}
		}
	%>

		<td style="border-bottom: 1px solid <%= colorScheme.getPortletMenuBg() %>;"

			<%--

			// Maximize the width of the second column if and only if the first
			// column is a row checker and there is only one second column.

			--%>

			<c:if test="<%= (rowChecker != null) && (headerNames.size() == 2) && (i == 1) %>">
				width="95%"
			</c:if>
		>
			<c:if test="<%= orderKey != null %>">
				<a href="<%= searchContainer.getIteratorURL().toString() %>&<%= namespace %>orderByCol=<%= orderKey %>&<%= namespace %>orderByType=<%= orderByType %>">
			</c:if>

			<c:if test="<%= orderCurrentHeader %>">
				<i>
			</c:if>

			<%
			String headerNameValue = LanguageUtil.get(pageContext, headerName);
			%>

			<c:choose>
				<c:when test="<%= headerNameValue.equals(StringPool.BLANK) %>">
					<%= StringPool.NBSP %>
				</c:when>
				<c:otherwise>
					<%= headerNameValue %>
				</c:otherwise>
			</c:choose>

			<c:if test="<%= orderCurrentHeader %>">
				</i>
			</c:if>

			<c:if test="<%= orderKey != null %>">
				</a>
			</c:if>
		</td>

	<%
	}
	%>

	</tr>

	<c:if test="<%= (resultRows.size() == 0) && (searchContainer.getEmptyResultsMessage() != null) %>">
		<tr class="portlet-section-body">
			<td align="center" colspan="<%= headerNames.size() %>">
				<%= LanguageUtil.get(pageContext, searchContainer.getEmptyResultsMessage()) %>
			</td>
		</tr>
	</c:if>

	<%
	boolean allRowsIsChecked = true;

	for (int i = 0; i < resultRows.size(); i++) {
		ResultRow row = (ResultRow)resultRows.get(i);

		String className = "portlet-section-alternate";
		String classHoverName = "portlet-section-alternate-hover";

		if (MathUtil.isEven(i)) {
			className = "portlet-section-body";
			classHoverName = "portlet-section-body-hover";
		}

		row.setClassName(className);
		row.setClassHoverName(classHoverName);

		request.setAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW, row);

		List entries = row.getEntries();

		if (rowChecker != null) {
			boolean rowIsChecked = rowChecker.isChecked(row.getObject());

			if (!rowIsChecked) {
				allRowsIsChecked = false;
			}

			row.addText(0, rowChecker.getRowCheckBox(rowIsChecked, row.getPrimaryKey()));
		}
	%>

		<tr class="<%= className %>" style="font-weight: <%= row.isBold() ? "bold" : "normal" %>;"
			<c:if test="<%= searchContainer.isHover() %>">
				onMouseEnter="this.className = '<%= classHoverName %>';" onMouseLeave="this.className = '<%= className %>';"
			</c:if>
		>

		<%
		for (int j = 0; j < entries.size(); j++) {
			SearchEntry entry = (SearchEntry)entries.get(j);
		%>

			<td align="<%= entry.getAlign() %>" valign="<%= entry.getValign() %>">

				<%
				entry.print(pageContext);
				%>

			</td>

		<%
		}
		%>

		</tr>

	<%
	}
	%>

	</table>

	<c:if test="<%= (rowChecker != null) && (resultRows.size() > 0) && Validator.isNotNull(rowChecker.getAllRowsId()) && allRowsIsChecked %>">
		<script type="text/javascript">
			document.<%= rowChecker.getFormName() %>.<%= rowChecker.getAllRowsId() %>.checked = true;
		</script>
	</c:if>
</c:if>
