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

<%@ include file="/html/portlet/search/init.jsp" %>

<%
String defaultKeywords = LanguageUtil.get(pageContext, "search") + "...";
String unicodeDefaultKeywords = UnicodeFormatter.toString(defaultKeywords);

String keywords = ParamUtil.getString(request, "keywords", defaultKeywords);
%>

<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/search/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/search/search");
portletURL.setParameter("keywords", keywords);

List headerNames = new ArrayList();

headerNames.add("#");
headerNames.add("summary");
headerNames.add("score");

SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, LanguageUtil.format(pageContext, "no-pages-were-found-that-matched-the-keywords-x", "<b>" + keywords + "</b>"));

Hits hits = CompanyLocalServiceUtil.search(company.getCompanyId(), keywords);

Hits results = hits.subset(searchContainer.getStart(), searchContainer.getEnd());
int total = hits.getLength();

searchContainer.setTotal(total);

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.getLength(); i++) {
	Document doc = results.doc(i);

	ResultRow row = new ResultRow(doc, String.valueOf(i), i);

	// Position

	row.addText(searchContainer.getStart() + i + 1 + StringPool.PERIOD);

	// Summary

	String portletId = (String)doc.get(LuceneFields.PORTLET_ID);

	Portlet portlet = PortletLocalServiceUtil.getPortletById(company.getCompanyId(), portletId);

	if (portlet != null) {
		String portletTitle = PortalUtil.getPortletTitle(portlet, application, locale);

		String groupId = doc.get(LuceneFields.GROUP_ID);

		String title = null;
		String content = null;

		String portletLayoutId = null;

		if (layout.isPrivateLayout()) {
			portletLayoutId = LayoutImpl.PRIVATE + groupId + ".1";
		}
		else {
			portletLayoutId = LayoutImpl.PRIVATE + groupId + ".1";
		}

		PortletURL rowURL = new PortletURLImpl(request, portletId, portletLayoutId, false);

		rowURL.setWindowState(WindowState.MAXIMIZED);
		rowURL.setPortletMode(PortletMode.VIEW);

		String url = rowURL.toString();

		String[] urls = null;

		if (Validator.isNotNull(portlet.getIndexerClass())) {
			Indexer indexer = (Indexer)InstancePool.get(portlet.getIndexerClass());

			DocumentSummary docSummary = indexer.getDocumentSummary(doc, rowURL);

			title = docSummary.getTitle();
			content = docSummary.getContent();
			url = rowURL.toString();

			if (portlet.getPortletId().equals(PortletKeys.JOURNAL)) {
				String articleId = doc.get("articleId");

				List contentSearches = JournalContentSearchLocalServiceUtil.getArticleContentSearches(company.getCompanyId(), groupId, articleId);

				if (contentSearches.size() > 0) {
					List urlsList = new ArrayList();

					for (int j = 0; j < contentSearches.size(); j++) {
						JournalContentSearch contentSearch = (JournalContentSearch)contentSearches.get(j);

						Layout contentSearchLayout = LayoutLocalServiceUtil.getLayout(contentSearch.getLayoutId(), contentSearch.getOwnerId());

						String contentSearchUrl = PortalUtil.getLayoutURL(contentSearchLayout, themeDisplay);

						urlsList.add(contentSearchUrl);

						if (i == 0) {
							url = contentSearchUrl;
						}
					}

					if (urlsList.size() > 0) {
						urls = (String[])urlsList.toArray(new String[0]);
					}
				}
				else {
					String version = doc.get("version");

					StringBuffer sb = new StringBuffer();

					sb.append(themeDisplay.getPathMain());
					sb.append("/journal_articles/view_article_content?groupId=");
					sb.append(groupId);
					sb.append("&articleId=");
					sb.append(articleId);
					sb.append("&version=");
					sb.append(version);

					url = sb.toString();
				}
			}
		}
		else {
			title = LanguageUtil.format(pageContext, "portlet-x-does-not-have-an-indexer-class-configured", new Object[] {"<b>" + portletTitle + "</b>"});
			content = LanguageUtil.format(pageContext, "portlet-x-does-not-have-an-indexer-class-configured", new Object[] {"<b>" + portletTitle + "</b>"});
		}

		StringBuffer sb = new StringBuffer();

		sb.append("<a href=\"");
		sb.append(url);
		sb.append("\"");

		if (portlet.getPortletId().equals(PortletKeys.JOURNAL)) {
			sb.append(" target=\"_blank\"");
		}

		sb.append(">");
		sb.append(portletTitle);
		sb.append(" &raquo; ");
		sb.append("<i>");
		sb.append(title);
		sb.append("</i>");
		sb.append("<br><br>");
		//sb.append("<span style=\"font-size: x-small;\">");
		sb.append(content);
		//sb.append("</span>");
		sb.append("</a><br>");

		if (urls != null) {
			sb.append("<span style=\"font-size: xx-small;\">");

			for (int j = 0; j < urls.length; j++) {
				sb.append("<br>");
				sb.append("<a href=\"");
				sb.append(urls[j]);
				sb.append("\">");
				sb.append(Http.getProtocol(request));
				sb.append("://");
				sb.append(company.getPortalURL());
				sb.append(StringUtil.shorten(urls[j], 100));
				sb.append("</a>");
			}

			sb.append("</span>");
		}

		row.addText(StringUtil.highlight(sb.toString(), keywords));

		// Score

		row.addText(String.valueOf(hits.score(i)));

		// Add result row

		resultRows.add(row);
	}
}
%>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td>
		<input class="form-text" name="<portlet:namespace />keywords" size="30" type="text" value="<%= keywords %>" onBlur="if (this.value == '') { this.value = '<%= unicodeDefaultKeywords %>'; }" onFocus="if (this.value == '<%= unicodeDefaultKeywords %>') { this.value = ''; }">

		<input align="absmiddle" border="0" src="<%= themeDisplay.getPathThemeImage() %>/common/search.gif" title="<%= LanguageUtil.get(pageContext, "search") %>" type="image">
	</td>
	<td align="right">
		<liferay-ui:search-speed searchContainer="<%= searchContainer %>" hits="<%= hits %>" />
	</td>
</tr>
</table>

<br>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

</form>

<script type="text/javascript">
	if (document.<portlet:namespace />fm.<portlet:namespace />keywords) {
		document.<portlet:namespace />fm.<portlet:namespace />keywords.focus();
	}
</script>
