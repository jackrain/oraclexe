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

<%@ include file="/html/portlet/journal_content/init.jsp" %>

<%
String cur = ParamUtil.getString(request, "cur");

String type = JournalArticleImpl.TYPES[0];

try {
	if (articleIds.length > 0) {
		JournalArticle article = JournalArticleLocalServiceUtil.getLatestArticle(company.getCompanyId(), groupId, articleIds[0]);

		groupId = article.getGroupId();
		type = article.getType();
	}
}
catch (NoSuchArticleException nsae) {
}

groupId = ParamUtil.getString(request, "groupId", groupId);
type = ParamUtil.getString(request, "type", type);
%>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="portletURL" />

<script type="text/javascript">
	var <portlet:namespace />articleIndex = 0;

	function <portlet:namespace />addArticle(articleId, save) {
		var table = document.getElementById("<portlet:namespace />articles");

		var newRow = table.insertRow(table.rows.length);

		newRow.id = "<portlet:namespace />row" + <portlet:namespace />articleIndex;

		var input = document.createInputElement("<portlet:namespace />article" + <portlet:namespace />articleIndex);

		input.type = "hidden";
		input.value = articleId;

		var text = document.createElement("span");

		text.innerHTML = articleId;

		var del = document.createElement("a");

		del.href = "javascript: <portlet:namespace />removeArticle('" + newRow.id + "');";
		del.innerHTML = "[<%= LanguageUtil.get(pageContext, "remove") %>]";

		newRow.insertCell(0).appendChild(input);
		newRow.insertCell(1).appendChild(text);
		newRow.insertCell(2).appendChild(del);

		newRow.cells[1].style.paddingLeft = "0px";
		newRow.cells[1].style.paddingRight = "10px";

		<portlet:namespace />articleIndex++;

		if (save) {
			<portlet:namespace />saveArticles();
		}
	}

	function <portlet:namespace />removeArticle(id) {
		var delRow = document.getElementById(id);

		document.getElementById("<portlet:namespace />articles").deleteRow(delRow.rowIndex);

		<portlet:namespace />saveArticles();
	}

	function <portlet:namespace />saveArticles() {
		document.<portlet:namespace />pages.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.UPDATE %>";
		loadForm(document.<portlet:namespace />pages, '<liferay-portlet:actionURL portletConfiguration="true" />');
	}
</script>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />pages">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= portletURL.toString() %>&<portlet:namespace />cur=<%= cur %>">
<input name="<portlet:namespace />groupId" type="hidden" value="<%= groupId %>">

<table cellpadding="0" cellspacing="0" border="0" id="<portlet:namespace />articles">
<tr>
	<td colspan="3">
		<%= LanguageUtil.get(pageContext, "displaying-article-pages") %>:
	</td>
</tr>
<tr>
	<td>
		<br>
	</td>
</tr>
</table>

</form>

<br><div class="beta-separator"></div><br>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= portletURL.toString() %>&<portlet:namespace />cur=<%= cur %>">

<liferay-ui:error exception="<%= NoSuchArticleException.class %>" message="the-article-could-not-be-found" />

<%
DynamicRenderRequest dynamicRenderReq = new DynamicRenderRequest(renderRequest);

dynamicRenderReq.setParameter("type", type);
dynamicRenderReq.setParameter("groupId", groupId);

ArticleSearch searchContainer = new ArticleSearch(dynamicRenderReq, portletURL);
%>

<liferay-ui:search-form
	page="/html/portlet/journal/article_search.jsp"
	searchContainer="<%= searchContainer %>"
>
	<liferay-ui:param name="groupId" value="<%= groupId %>" />
	<liferay-ui:param name="type" value="<%= type %>" />
</liferay-ui:search-form>

<br><div class="beta-separator"></div><br>

<%
OrderByComparator orderByComparator = JournalUtil.getArticleOrderByComparator(searchContainer.getOrderByCol(), searchContainer.getOrderByType());

ArticleSearchTerms searchTerms = (ArticleSearchTerms)searchContainer.getSearchTerms();

int total = JournalArticleLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getArticleId(), searchTerms.getVersionObj(), searchTerms.getTitle(), searchTerms.getDescription(), searchTerms.getContent(), searchTerms.getType(), searchTerms.getStructureId(), searchTerms.getTemplateId(), searchTerms.getDisplayDateGT(), searchTerms.getDisplayDateLT(), searchTerms.getApprovedObj(), searchTerms.getExpiredObj(), searchTerms.getReviewDate(), searchTerms.isAndOperator());

searchContainer.setTotal(total);

List results = JournalArticleLocalServiceUtil.search(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getArticleId(), searchTerms.getVersionObj(), searchTerms.getTitle(), searchTerms.getDescription(), searchTerms.getContent(), searchTerms.getType(), searchTerms.getStructureId(), searchTerms.getTemplateId(), searchTerms.getDisplayDateGT(), searchTerms.getDisplayDateLT(), searchTerms.getApprovedObj(), searchTerms.getExpiredObj(), searchTerms.getReviewDate(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), orderByComparator);

searchContainer.setResults(results);

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
	JournalArticle curArticle = (JournalArticle)results.get(i);

	ResultRow row = new ResultRow(null, curArticle.getArticleId() + EditArticleAction.VERSION_SEPARATOR + curArticle.getVersion(), i);

	StringBuffer sb = new StringBuffer();

	sb.append("javascript: ");
	sb.append(renderResponse.getNamespace());
	sb.append("addArticle('");
	sb.append(curArticle.getArticleId());
	sb.append("', true);");

	String rowHREF = sb.toString();

	// Article id

	row.addText(curArticle.getArticleId(), rowHREF);

	// Version

	row.addText(String.valueOf(curArticle.getVersion()), rowHREF);

	// Title

	row.addText(curArticle.getTitle(), rowHREF);

	// Display date

	row.addText(dateFormatDateTime.format(curArticle.getDisplayDate()), rowHREF);

	// Author

	row.addText(PortalUtil.getUserName(curArticle.getUserId(), curArticle.getUserName()), rowHREF);

	// Add result row

	resultRows.add(row);
}
%>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />searchArticleId.focus();

	<%
	for (int i = 0; i < articleIds.length; i++) {
		try {
			JournalArticle article = JournalArticleLocalServiceUtil.getLatestArticle(company.getCompanyId(), groupId, articleIds[i]);
	%>

			<portlet:namespace />addArticle("<%= article.getArticleId() %>", false);

	<%
		}
		catch (NoSuchArticleException nsae) {
		}
	}
	%>

	<portlet:namespace />saveArticles();
</script>
