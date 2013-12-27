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

<%
String tabs1 = ParamUtil.getString(request, "tabs1", "articles");

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/journal/view");
portletURL.setParameter("tabs1", tabs1);
%>

<script type="text/javascript">
	function <portlet:namespace />deleteArticles() {
		if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-articles") %>')) {
			document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.DELETE %>";
			document.<portlet:namespace />fm.<portlet:namespace />deleteArticleIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
			submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_article" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:actionURL>");
		}
	}

	function <portlet:namespace />deleteStructures() {
		if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-structures") %>')) {
			document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.DELETE %>";
			document.<portlet:namespace />fm.<portlet:namespace />deleteStructureIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
			submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_structure" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:actionURL>");
		}
	}

	function <portlet:namespace />deleteTemplates() {
		if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-templates") %>')) {
			document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.DELETE %>";
			document.<portlet:namespace />fm.<portlet:namespace />deleteTemplateIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
			submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_template" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:actionURL>");
		}
	}

	function <portlet:namespace />expireArticles() {
		if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-expire-the-selected-articles") %>')) {
			document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.EXPIRE %>";
			document.<portlet:namespace />fm.<portlet:namespace />expireArticleIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
			submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_article" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:actionURL>");
		}
	}
</script>

<form action="<%= portletURL.toString() %>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">

<liferay-ui:tabs
	names="articles,structures,templates,recent"
	url="<%= portletURL.toString() %>"
/>

<c:choose>
	<c:when test='<%= tabs1.equals("articles") %>'>
		<input name="<portlet:namespace />deleteArticleIds" type="hidden" value="">
		<input name="<portlet:namespace />expireArticleIds" type="hidden" value="">

		<%
		String orderByCol = ParamUtil.getString(request, "orderByCol");
		String orderByType = ParamUtil.getString(request, "orderByType");

		if (Validator.isNotNull(orderByCol) && Validator.isNotNull(orderByType)) {
			prefs.setValue(PortletKeys.JOURNAL, "articles-order-by-col", orderByCol);
			prefs.setValue(PortletKeys.JOURNAL, "articles-order-by-type", orderByType);
		}
		else {
			orderByCol = prefs.getValue(PortletKeys.JOURNAL, "articles-order-by-col", "id");
			orderByType = prefs.getValue(PortletKeys.JOURNAL, "articles-order-by-type", "asc");
		}

		OrderByComparator orderByComparator = JournalUtil.getArticleOrderByComparator(orderByCol, orderByType);

		ArticleSearch searchContainer = new ArticleSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(3, "modified-date");
		headerNames.add(StringPool.BLANK);

		searchContainer.setRowChecker(new RowChecker(renderResponse));
		%>

		<liferay-ui:search-form
			page="/html/portlet/journal/article_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">

			<%
			ArticleSearchTerms searchTerms = (ArticleSearchTerms)searchContainer.getSearchTerms();

			int total = JournalArticleLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getArticleId(), searchTerms.getVersionObj(), searchTerms.getTitle(), searchTerms.getDescription(), searchTerms.getContent(), searchTerms.getType(), searchTerms.getStructureId(), searchTerms.getTemplateId(), searchTerms.getDisplayDateGT(), searchTerms.getDisplayDateLT(), searchTerms.getApprovedObj(), searchTerms.getExpiredObj(), searchTerms.getReviewDate(), searchTerms.isAndOperator());

			searchContainer.setTotal(total);

			List results = JournalArticleLocalServiceUtil.search(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getArticleId(), searchTerms.getVersionObj(), searchTerms.getTitle(), searchTerms.getDescription(), searchTerms.getContent(), searchTerms.getType(), searchTerms.getStructureId(), searchTerms.getTemplateId(), searchTerms.getDisplayDateGT(), searchTerms.getDisplayDateLT(), searchTerms.getApprovedObj(), searchTerms.getExpiredObj(), searchTerms.getReviewDate(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), orderByComparator);

			searchContainer.setResults(results);
			%>

			<br><div class="beta-separator"></div><br>

			<c:if test="<%= PortletPermission.contains(permissionChecker, plid, PortletKeys.JOURNAL, ActionKeys.ADD_ARTICLE) %>">
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_article" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>';">
			</c:if>

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "expire") %>' onClick="<portlet:namespace />expireArticles();">

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "delete") %>' onClick="<portlet:namespace />deleteArticles();">

			<br><br>

			<%
			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				JournalArticle article = (JournalArticle)results.get(i);

				ResultRow row = new ResultRow(article, article.getArticleId() + EditArticleAction.VERSION_SEPARATOR + article.getVersion(), i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/journal/edit_article");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("groupId", article.getGroupId());
				rowURL.setParameter("articleId", article.getArticleId());
				rowURL.setParameter("version", String.valueOf(article.getVersion()));

				// Article id

				row.addText(article.getArticleId(), rowURL);

				// Version

				row.addText(String.valueOf(article.getVersion()), rowURL);

				// Title

				row.addText(article.getTitle(), rowURL);

				// Modified date

				row.addText(dateFormatDate.format(article.getModifiedDate()), rowURL);

				// Display date

				row.addText(dateFormatDate.format(article.getDisplayDate()), rowURL);

				// Author

				row.addText(PortalUtil.getUserName(article.getUserId(), article.getUserName()), rowURL);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/journal/article_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
		</c:if>
	</c:when>
	<c:when test='<%= tabs1.equals("structures") %>'>
		<input name="<portlet:namespace />deleteStructureIds" type="hidden" value="">

		<liferay-ui:error exception="<%= RequiredStructureException.class %>" message="required-structures-could-not-be-deleted" />

		<%
		StructureSearch searchContainer = new StructureSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(StringPool.BLANK);

		searchContainer.setRowChecker(new RowChecker(renderResponse));
		%>

		<liferay-ui:search-form
			page="/html/portlet/journal/structure_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">

			<%
			StructureSearchTerms searchTerms = (StructureSearchTerms)searchContainer.getSearchTerms();

			int total = JournalStructureLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getStructureId(), searchTerms.getName(), searchTerms.getDescription(), searchTerms.isAndOperator());

			searchContainer.setTotal(total);

			List results = JournalStructureLocalServiceUtil.search(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getStructureId(), searchTerms.getName(), searchTerms.getDescription(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), null);

			searchContainer.setResults(results);
			%>

			<br><div class="beta-separator"></div><br>

			<c:if test="<%= PortletPermission.contains(permissionChecker, plid, PortletKeys.JOURNAL, ActionKeys.ADD_STRUCTURE) %>">
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_structure" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>';">
			</c:if>

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "delete") %>' onClick="<portlet:namespace />deleteStructures();">

			<br><br>

			<%
			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				JournalStructure structure = (JournalStructure)results.get(i);

				ResultRow row = new ResultRow(structure, structure.getStructureId(), i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/journal/edit_structure");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("groupId", structure.getGroupId());
				rowURL.setParameter("structureId", structure.getStructureId());

				// Structure id

				row.addText(structure.getStructureId(), rowURL);

				// Name and description

				StringBuffer sb = new StringBuffer();

				sb.append(structure.getName());

				if (Validator.isNotNull(structure.getDescription())) {
					sb.append("<br>");
					sb.append("<span style=\"font-size: xx-small;\">");
					sb.append(structure.getDescription());
					sb.append("</span>");
				}

				row.addText(sb.toString(), rowURL);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/journal/structure_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
		</c:if>
	</c:when>
	<c:when test='<%= tabs1.equals("templates") %>'>
		<input name="<portlet:namespace />deleteTemplateIds" type="hidden" value="">

		<liferay-ui:error exception="<%= RequiredTemplateException.class %>" message="required-templates-could-not-be-deleted" />

		<%
		TemplateSearch searchContainer = new TemplateSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(StringPool.BLANK);

		searchContainer.setRowChecker(new RowChecker(renderResponse));
		%>

		<liferay-ui:search-form
			page="/html/portlet/journal/template_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">

			<%
			TemplateSearchTerms searchTerms = (TemplateSearchTerms)searchContainer.getSearchTerms();

			int total = JournalTemplateLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getTemplateId(), searchTerms.getStructureId(), StringPool.EQUAL, searchTerms.getName(), searchTerms.getDescription(), searchTerms.isAndOperator());

			searchContainer.setTotal(total);

			List results = JournalTemplateLocalServiceUtil.search(company.getCompanyId(), searchTerms.getGroupId(), searchTerms.getTemplateId(), searchTerms.getStructureId(), StringPool.EQUAL, searchTerms.getName(), searchTerms.getDescription(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), null);

			searchContainer.setResults(results);
			%>

			<br><div class="beta-separator"></div><br>

			<c:if test="<%= PortletPermission.contains(permissionChecker, plid, PortletKeys.JOURNAL, ActionKeys.ADD_TEMPLATE) %>">
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_template" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>';">
			</c:if>

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "delete") %>' onClick="<portlet:namespace />deleteTemplates();">

			<br><br>

			<%
			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				JournalTemplate template = (JournalTemplate)results.get(i);

				ResultRow row = new ResultRow(template, template.getTemplateId(), i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/journal/edit_template");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("groupId", template.getGroupId());
				rowURL.setParameter("templateId", template.getTemplateId());

				row.setParameter("rowHREF", rowURL.toString());

				// Template id

				row.addText(template.getTemplateId(), rowURL);

				// Name, description, and image

				row.addJSP("/html/portlet/journal/template_description.jsp");

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/journal/template_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
		</c:if>
	</c:when>
	<c:when test='<%= tabs1.equals("recent") %>'>
		<%= LanguageUtil.format(pageContext, "this-page-displays-the-last-x-articles,-structures,-and-templates-that-you-accessed", Integer.toString(JournalUtil.MAX_STACK_SIZE), false) %>

		<br><br>

		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td valign="top" width="33%">
				<table border="0" cellpadding="4" cellspacing="0" width="100%">
				<tr class="portlet-section-header" style="font-size: x-small; font-weight: bold;">
					<td>
						<%= LanguageUtil.format(pageContext, "last-x-articles", Integer.toString(JournalUtil.MAX_STACK_SIZE), false) %>
					</td>
				</tr>

				<%
				Stack recentArticles = JournalUtil.getRecentArticles(renderRequest);

				int recentArticlesSize = recentArticles.size();

				for (int i = recentArticlesSize - 1; i >= 0; i--) {
					JournalArticle article = (JournalArticle)recentArticles.get(i);

					String className = "portlet-section-body";
					String classHoverName = "portlet-section-body-hover";

					if (MathUtil.isEven(i)) {
						className = "portlet-section-alternate";
						classHoverName = "portlet-section-alternate-hover";
					}
				%>

					<tr class="<%= className %>" style="font-size: x-small;" onMouseEnter="this.className = '<%= classHoverName %>';" onMouseLeave="this.className = '<%= className %>';">
						<td nowrap>
							<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_article" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="groupId" value="<%= article.getGroupId() %>" /><portlet:param name="articleId" value="<%= article.getArticleId() %>" /><portlet:param name="version" value="<%= String.valueOf(article.getVersion()) %>" /></portlet:renderURL>"><%= article.getArticleId() %></a>
						</td>
					</tr>

				<%
				}
				%>

				</table>
			</td>
			<td style="padding-left: 5px;"></td>
			<td valign="top" width="33%">
				<table border="0" cellpadding="4" cellspacing="0" width="100%">
				<tr class="portlet-section-header" style="font-size: x-small; font-weight: bold;">
					<td>
						<%= LanguageUtil.format(pageContext, "last-x-structures", Integer.toString(JournalUtil.MAX_STACK_SIZE), false) %>
					</td>
				</tr>

				<%
				Stack recentStructures = JournalUtil.getRecentStructures(renderRequest);

				int recentStructuresSize = recentStructures.size();

				for (int i = recentStructuresSize - 1; i >= 0; i--) {
					JournalStructure structure = (JournalStructure)recentStructures.get(i);

					String className = "portlet-section-body";
					String classHoverName = "portlet-section-body-hover";

					if (MathUtil.isEven(i)) {
						className = "portlet-section-alternate";
						classHoverName = "portlet-section-alternate-hover";
					}
				%>

					<tr class="<%= className %>" style="font-size: x-small;" onMouseEnter="this.className = '<%= classHoverName %>';" onMouseLeave="this.className = '<%= className %>';">
						<td nowrap>
							<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_structure" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="groupId" value="<%= structure.getGroupId() %>" /><portlet:param name="structureId" value="<%= structure.getStructureId() %>" /></portlet:renderURL>"><%= structure.getName() %></a>
						</td>
					</tr>

				<%
				}
				%>

				</table>
			</td>
			<td style="padding-left: 5px;"></td>
			<td valign="top" width="33%">
				<table border="0" cellpadding="4" cellspacing="0" width="100%">
				<tr class="portlet-section-header" style="font-size: x-small; font-weight: bold;">
					<td>
						<%= LanguageUtil.format(pageContext, "last-x-templates", Integer.toString(JournalUtil.MAX_STACK_SIZE), false) %>
					</td>
				</tr>

				<%
				Stack recentTemplates = JournalUtil.getRecentTemplates(renderRequest);

				int recentTemplatesSize = recentTemplates.size();

				for (int i = recentTemplatesSize - 1; i >= 0; i--) {
					JournalTemplate template = (JournalTemplate)recentTemplates.get(i);

					String className = "portlet-section-body";
					String classHoverName = "portlet-section-body-hover";

					if (MathUtil.isEven(recentTemplatesSize - i - 1)) {
						className = "portlet-section-alternate";
						classHoverName = "portlet-section-alternate-hover";
					}
				%>

					<tr class="<%= className %>" style="font-size: x-small;" onMouseEnter="this.className = '<%= classHoverName %>';" onMouseLeave="this.className = '<%= className %>';">
						<td nowrap>
							<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_template" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="groupId" value="<%= template.getGroupId() %>" /><portlet:param name="templateId" value="<%= template.getTemplateId() %>" /></portlet:renderURL>"><%= template.getName() %></a>
						</td>
					</tr>

				<%
				}
				%>

				</table>
			</td>
		</tr>
		</table>
	</c:when>
</c:choose>

</form>

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		<c:choose>
			<c:when test='<%= tabs1.equals("articles") %>'>
				document.<portlet:namespace />fm.<portlet:namespace />searchArticleId.focus();
			</c:when>
			<c:when test='<%= tabs1.equals("structures") %>'>
				document.<portlet:namespace />fm.<portlet:namespace />searchStructureId.focus();
			</c:when>
			<c:when test='<%= tabs1.equals("templates") %>'>
				document.<portlet:namespace />fm.<portlet:namespace />searchTemplateId.focus();
			</c:when>
		</c:choose>
	</script>
</c:if>
