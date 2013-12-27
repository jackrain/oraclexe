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

<%@ include file="/html/portlet/google/init.jsp" %>

<%
GoogleSearchResult searchResult = (GoogleSearchResult)request.getAttribute(WebKeys.GOOGLE_SEARCH_RESULT);

NumberFormat doubleFormat = NumberFormat.getInstance();

doubleFormat.setMaximumFractionDigits(2);

NumberFormat integerFormat = NumberFormat.getInstance(locale);

integerFormat.setMaximumFractionDigits(0);
%>

<form method="post" name="<portlet:namespace />fm"
	onSubmit="
		if (document.<portlet:namespace />fm.<portlet:namespace />directive.selectedIndex == 0) {
			submitForm(this, '<portlet:renderURL><portlet:param name="struts_action" value="/google/search" /></portlet:renderURL>');
		}
		else {
			submitForm(this, '<portlet:renderURL><portlet:param name="struts_action" value="/google/spell" /></portlet:renderURL>');
		}

		return false;"
>

<input class="form-text" name="<portlet:namespace />args" size="30" type="text" value="<%= searchResult.getSearchQuery() %>">

<select name="<portlet:namespace />directive">
	<option selected value="search"><%= LanguageUtil.get(pageContext, "search") %></option>
	<option value="spell"><%= LanguageUtil.get(pageContext, "spell") %></option>
</select>

<input align="absmiddle" border="0" src="<%= themeDisplay.getPathThemeImage() %>/common/search.gif" title="<%= LanguageUtil.get(pageContext, "search") %>" type="image">

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />args.focus();
</script>

<br>

<table border="0" cellpadding="4" cellspacing="0" width="100%">
<tr class="portlet-section-header">
	<td>
		<c:if test='<%= !searchResult.getSearchQuery().startsWith("related:") %>'>
			<%= LanguageUtil.get(pageContext, "searched-the-web-for") %> <b><%= searchResult.getSearchQuery() %></b>.
		</c:if>

		<c:if test='<%= searchResult.getSearchQuery().startsWith("related:") %>'>
			<%= LanguageUtil.get(pageContext, "searched-for-pages-similar-to") %> <b><%= searchResult.getSearchQuery().substring(8, searchResult.getSearchQuery().length()) %></b>.
		</c:if>
	</td>
	<td align="right">
		<c:if test="<%= searchResult.getEstimateIsExact() %>">
			<%= LanguageUtil.format(pageContext, "results-of", new Object[] {"<b>" + searchResult.getStartIndex() + "</b> - <b>" + searchResult.getEndIndex() + "</b>", "<b>" + integerFormat.format(searchResult.getEstimatedTotalResultsCount()) + "</b>"}, false) %>
		</c:if>

		<c:if test="<%= !searchResult.getEstimateIsExact() %>">
			<%= LanguageUtil.format(pageContext, "results-of-about", new Object[] {"<b>" + searchResult.getStartIndex() + "</b> - <b>" + searchResult.getEndIndex() + "</b>", "<b>" + integerFormat.format(searchResult.getEstimatedTotalResultsCount()) + "</b>"}, false) %>
		</c:if>

		<%= LanguageUtil.format(pageContext, "search-took-x-seconds", new LanguageWrapper("<b>", doubleFormat.format(searchResult.getSearchTime()), "</b>"), false) %>
	</td>
</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">

<%
GoogleSearchResultElement[] resultElements = searchResult.getResultElements();

for (int i = 0; i < resultElements.length; i++) {
	GoogleSearchResultElement resultElement = resultElements[i];
%>

	<tr>
		<td>
			<span style="font-size: small;"><a href="<%= resultElement.getURL() %>" target="_blank"><%= resultElement.getTitle() %></a></span><br>

			<%= resultElement.getSnippet() %><br>

			<c:if test="<%= Validator.isNotNull(resultElement.getSummary()) %>">
				<%= LanguageUtil.get(pageContext, "description") %>: <%= resultElement.getSummary() %><br>
			</c:if>

			<%
			String categoryName = resultElement.getDirectoryCategory().getFullViewableName();
			%>

			<c:if test="<%= Validator.isNotNull(categoryName) %>">
				<%= LanguageUtil.get(pageContext, "category") %>: <a href="http://directory.google.com/<%= categoryName %>" target="_blank"><%= StringUtil.replace(categoryName.substring(4, categoryName.length()), "/", " &gt; ") %></a><br>
			</c:if>

			<span class="portlet-msg-success"><%= resultElement.getURL() %> - <%= resultElement.getCachedSize() %></span> - <a href="<%= themeDisplay.getPathMain() %>/google/cached?args=<%= StringUtil.replace(resultElement.getURL(), "http://", StringPool.BLANK) %>" target="_blank"><%= LanguageUtil.get(pageContext, "cached") %></a>

			<c:if test="<%= resultElement.getRelatedInformationPresent() %>">

				<%
				PortletURL portletURL = renderResponse.createRenderURL();

				portletURL.setParameter("struts_action", "/google/search");
				portletURL.setParameter("args", StringUtil.replace(resultElement.getURL(), "http://", "related:"));
				%>

				- <a href="<%= portletURL.toString() %>"><%= LanguageUtil.get(pageContext, "similar-pages") %></a>
			</c:if>
		</td>
	</tr>

	<c:if test="<%= i + 1 < resultElements.length %>">
		<tr>
			<td>
				<br>
			</td>
		</tr>
	</c:if>

<%
}
%>

</table>

<br>

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setParameter("struts_action", "/google/search");
portletURL.setParameter("args", Http.encodeURL(searchResult.getSearchQuery()));
%>

<liferay-ui:page-iterator curParam='<%= renderResponse.getNamespace() + "start" %>' curValue="<%= ParamUtil.get(request, \"start\", 1) %>" delta="10" maxPages="10" total="<%= searchResult.getEstimatedTotalResultsCount() %>" url="<%= Http.decodeURL(portletURL.toString()) %>" />
