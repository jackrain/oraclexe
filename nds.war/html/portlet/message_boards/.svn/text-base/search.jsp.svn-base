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
String breadcrumbsCategoryId = ParamUtil.getString(request, "breadcrumbsCategoryId");
String breadcrumbsMessageId = ParamUtil.getString(request, "breadcrumbsMessageId");

String categoryIds = ParamUtil.getString(request, "categoryIds");
String[] categoryIdsArray = StringUtil.split(categoryIds);

String threadId = ParamUtil.getString(request, "threadId");
String keywords = ParamUtil.getString(request, "keywords");
%>

<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/message_boards/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace />breadcrumbsCategoryId" type="hidden" value="<%= breadcrumbsCategoryId %>">
<input name="<portlet:namespace />breadcrumbsMessageId" type="hidden" value="<%= breadcrumbsMessageId %>">
<input name="<portlet:namespace />categoryIds" type="hidden" value="<%= categoryIds %>">
<input name="<portlet:namespace />threadId" type="hidden" value="<%= threadId %>">

<liferay-util:include page="/html/portlet/message_boards/tabs1.jsp" />

<%= MBUtil.getBreadcrumbs(breadcrumbsCategoryId, breadcrumbsMessageId, pageContext, renderRequest, renderResponse) %> &raquo; <%= LanguageUtil.get(pageContext, "search") %>

<br><br>

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/message_boards/search");
portletURL.setParameter("breadcrumbsCategoryId", breadcrumbsCategoryId);
portletURL.setParameter("breadcrumbsMessageId", breadcrumbsMessageId);
portletURL.setParameter("categoryIds", categoryIds);
portletURL.setParameter("threadId", threadId);
portletURL.setParameter("keywords", keywords);

List headerNames = new ArrayList();

headerNames.add("#");
headerNames.add("category");
headerNames.add("message");
headerNames.add("score");

SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, LanguageUtil.format(pageContext, "no-messages-were-found-that-matched-the-keywords-x", "<b>" + keywords + "</b>"));

Hits hits = MBCategoryLocalServiceUtil.search(company.getCompanyId(), portletGroupId, categoryIdsArray, threadId, keywords);

ThreadHits threadHits = new ThreadHits();

threadHits.recordHits(hits);

hits = threadHits;

Hits results = hits.subset(searchContainer.getStart(), searchContainer.getEnd());
int total = hits.getLength();

searchContainer.setTotal(total);

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.getLength(); i++) {
	Document doc = results.doc(i);

	ResultRow row = new ResultRow(doc, String.valueOf(i), i);

	// Position

	row.addText(searchContainer.getStart() + i + 1 + StringPool.PERIOD);

	// Category and message

	String categoryId = doc.get("categoryId");
	String messageId = doc.get("messageId");

	MBCategory category = MBCategoryLocalServiceUtil.getCategory(categoryId);
	MBMessage message = MBMessageLocalServiceUtil.getMessage(messageId);

	PortletURL rowURL = renderResponse.createRenderURL();

	rowURL.setWindowState(WindowState.MAXIMIZED);

	rowURL.setParameter("struts_action", "/message_boards/view_message");
	rowURL.setParameter("messageId", messageId);

	row.addText(category.getName(), rowURL);
	row.addText(message.getSubject(), rowURL);

	// Score

	row.addText(String.valueOf(hits.score(i)), rowURL);

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
