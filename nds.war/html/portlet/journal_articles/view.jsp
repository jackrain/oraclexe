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

<%@ include file="/html/portlet/journal_articles/init.jsp" %>

<%
String articleId = ParamUtil.getString(request, "articleId");
double version = ParamUtil.getDouble(request, "version");
%>

<c:choose>
	<c:when test="<%= Validator.isNull(articleId) %>">

		<%
		if (Validator.isNull(type)) {
			type = null;
		}

		Boolean approved = Boolean.TRUE;
		Boolean expired = Boolean.FALSE;
		Date reviewDate = null;

		PortletURL portletURL = renderResponse.createRenderURL();

		portletURL.setWindowState(WindowState.MAXIMIZED);

		portletURL.setParameter("struts_action", "/journal_articles/view");

		ArticleSearch searchContainer = new ArticleSearch(renderRequest, portletURL);

		searchContainer.setDelta(pageDelta);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.clear();

		headerNames.add("name");
		headerNames.add("display-date");
		headerNames.add("author");

		searchContainer.setOrderableHeaders(null);

		ArticleSearchTerms searchTerms = (ArticleSearchTerms)searchContainer.getSearchTerms();

		int total = JournalArticleLocalServiceUtil.searchCount(company.getCompanyId(), groupId, searchTerms.getArticleId(), searchTerms.getVersionObj(), searchTerms.getTitle(), searchTerms.getDescription(), searchTerms.getContent(), type, searchTerms.getStructureId(), searchTerms.getTemplateId(), searchTerms.getDisplayDateGT(), searchTerms.getDisplayDateLT(), approved, expired, reviewDate, searchTerms.isAndOperator());

		searchContainer.setTotal(total);

		List results = JournalArticleLocalServiceUtil.search(company.getCompanyId(), groupId, searchTerms.getArticleId(), searchTerms.getVersionObj(), searchTerms.getTitle(), searchTerms.getDescription(), searchTerms.getContent(), type, searchTerms.getStructureId(), searchTerms.getTemplateId(), searchTerms.getDisplayDateGT(), searchTerms.getDisplayDateLT(), approved, expired, reviewDate, searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), orderByComparator);

		searchContainer.setResults(results);

		List resultRows = searchContainer.getResultRows();

		for (int i = 0; i < results.size(); i++) {
			JournalArticle article = (JournalArticle)results.get(i);

			ResultRow row = new ResultRow(article, article.getArticleId() + EditArticleAction.VERSION_SEPARATOR + article.getVersion(), i);

			String rowHREF = null;

			if (pageURL.equals("popUp")) {
				StringBuffer sb = new StringBuffer();

				sb.append(themeDisplay.getPathMain());
				sb.append("/journal_articles/view_article_content?groupId=");
				sb.append(article.getGroupId());
				sb.append("&articleId=");
				sb.append(article.getArticleId());
				sb.append("&version=");
				sb.append(article.getVersion());

				rowHREF = sb.toString();
			}
			else {
				portletURL.setParameter("groupId", article.getGroupId());
				portletURL.setParameter("articleId", article.getArticleId());
				portletURL.setParameter("version", String.valueOf(article.getVersion()));

				rowHREF = portletURL.toString();
			}

			String target = null;

			if (pageURL.equals("popUp")) {
				target = "_blank";;
			}

			TextSearchEntry rowTextEntry = new TextSearchEntry(SearchEntry.DEFAULT_ALIGN, SearchEntry.DEFAULT_VALIGN, article.getArticleId(), rowHREF, target, null);

			/*// Article id

			row.addText(rowTextEntry);

			// Version

			rowTextEntry = (TextSearchEntry)rowTextEntry.clone();

			rowTextEntry.setName(String.valueOf(article.getVersion()));

			row.addText(rowTextEntry);*/

			// Title

			rowTextEntry = (TextSearchEntry)rowTextEntry.clone();

			rowTextEntry.setName(article.getTitle());

			row.addText(rowTextEntry);

			// Display date

			rowTextEntry = (TextSearchEntry)rowTextEntry.clone();

			rowTextEntry.setName(dateFormatDateTime.format(article.getDisplayDate()));

			row.addText(rowTextEntry);

			// Author

			rowTextEntry = (TextSearchEntry)rowTextEntry.clone();

			rowTextEntry.setName(PortalUtil.getUserName(article.getUserId(), article.getUserName()));

			row.addText(rowTextEntry);

			// Add result row

			resultRows.add(row);
		}
		%>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />
	</c:when>
	<c:otherwise>

		<%
		String languageId = LanguageUtil.getLanguageId(request);

		String content = JournalArticleLocalServiceUtil.getArticleContent(company.getCompanyId(), groupId, articleId, version, languageId, themeDisplay);

		RuntimeLogic portletLogic = new PortletLogic(application, request, response, renderRequest, renderResponse);
		RuntimeLogic actionURLLogic = new ActionURLLogic(renderResponse);
		RuntimeLogic renderURLLogic = new RenderURLLogic(renderResponse);

		content = RuntimePortletUtil.processXML(request, content, portletLogic);
		content = RuntimePortletUtil.processXML(request, content, actionURLLogic);
		content = RuntimePortletUtil.processXML(request, content, renderURLLogic);
		%>

		<%= content %>
	</c:otherwise>
</c:choose>
