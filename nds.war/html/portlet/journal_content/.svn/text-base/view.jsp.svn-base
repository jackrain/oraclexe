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
String[] content = (String[])request.getAttribute(WebKeys.JOURNAL_ARTICLE_CONTENT);
%>

<c:choose>
	<c:when test="<%= Validator.isNotNull(content) %>">

		<%
		RuntimeLogic portletLogic = new PortletLogic(application, request, response, renderRequest, renderResponse);
		RuntimeLogic actionURLLogic = new ActionURLLogic(renderResponse);
		RuntimeLogic renderURLLogic = new RenderURLLogic(renderResponse);

		for (int i = 0; i < content.length; i++) {
			content[i] = RuntimePortletUtil.processXML(request, content[i], portletLogic);
			content[i] = RuntimePortletUtil.processXML(request, content[i], actionURLLogic);
			content[i] = RuntimePortletUtil.processXML(request, content[i], renderURLLogic);
		%>

			<div id="<portlet:namespace />content<%= i %>">
				<%= content[i] %>
			</div>

		<%
		}
		%>

		<c:if test="<%= content.length > 1 %>">
			<div id="<portlet:namespace />paginator" style="padding: 10px 0px 10px 0px;">
				<span class="font-small" id="<portlet:namespace />prev" style="cursor: pointer; float: left;" onClick="<portlet:namespace />prevPage();"></span>
				<span class="font-small" id="<portlet:namespace />next" style="cursor: pointer; float: right;" onClick="<portlet:namespace />nextPage();"></span>
			</div>

			<script type="text/javascript">
				var <portlet:namespace />index = 0;

				function <portlet:namespace />prevPage() {
					<portlet:namespace />index--;
					<portlet:namespace />updatePage();
				}

				function <portlet:namespace />nextPage() {
					<portlet:namespace />index++;
					<portlet:namespace />updatePage();
				}

				function <portlet:namespace />updatePage() {
					for (var i = 0; i < <%= content.length %>; i++) {
						var editArticle = document.getElementById("<portlet:namespace />editArticle" + i);
						var content = document.getElementById("<portlet:namespace />content" + i);

						if (i == <portlet:namespace />index) {
							content.style.display = "";

							if (editArticle != null) {
								editArticle.style.display = "";
							}
						}
						else {
							content.style.display = "none";

							if (editArticle != null) {
								editArticle.style.display = "none";
							}
						}
					}

					var prev = document.getElementById("<portlet:namespace />prev");
					var next = document.getElementById("<portlet:namespace />next");

					if (<portlet:namespace />index > 0) {
						prev.innerHTML = "<a>&laquo;&nbsp;<%= LanguageUtil.get(pageContext, "previous") %></a>";
					}
					else {
						prev.innerHTML = "";
					}

					if (<portlet:namespace />index < <%= content.length - 1 %>) {
						next.innerHTML = "<a><%= LanguageUtil.get(pageContext, "next") %>&nbsp;&raquo;</a>";
					}
					else {
						next.innerHTML = "";
					}
				}
			</script>
		</c:if>
	</c:when>
	<c:otherwise>
		<%= LanguageUtil.get(pageContext, "please-contact-the-administrator-to-setup-this-portlet") %>

		<br><br>

		<%= LanguageUtil.get(pageContext, "select-an-existing-article-or-add-an-article-to-be-displayed-in-this-portlet") %>

		<br>

		<%
		for (int i = 0; i < articleIds.length; i++) {
		%>

			<c:if test="<%= Validator.isNotNull(articleIds[i]) %>">
				<br>

				<span class="portlet-msg-error">
				<%= LanguageUtil.format(pageContext, "x-is-not-approved,-does-not-have-any-content,-or-no-longer-exists", articleIds[i]) %>
				</span>

				<br>
			</c:if>

		<%
		}
		%>

	</c:otherwise>
</c:choose>

<c:if test="<%= themeDisplay.isSignedIn() %>">
	<br>

	<c:if test="<%= PortletPermission.contains(permissionChecker, plid, PortletKeys.JOURNAL, ActionKeys.CONFIGURATION) %>">
		<liferay-ui:icon image="configuration" message="select-article" url="<%= portletDisplay.getURLConfiguration() %>" />
	</c:if>

	<%
	JournalArticle article = null;

	for (int i = 0; i < articleIds.length; i++) {
		try {
			article = JournalArticleLocalServiceUtil.getLatestArticle(company.getCompanyId(), groupId, articleIds[i]);
	%>

			<span id="<portlet:namespace />editArticle<%= i %>" >
				<c:if test="<%= JournalArticlePermission.contains(permissionChecker, article, ActionKeys.UPDATE) %>">
					<liferay-portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="editURL" portletName="<%= PortletKeys.JOURNAL %>">
						<liferay-portlet:param name="struts_action" value="/journal/edit_article" />
						<liferay-portlet:param name="redirect" value="<%= currentURL %>" />
						<liferay-portlet:param name="groupId" value="<%= article.getGroupId() %>" />
						<liferay-portlet:param name="articleId" value="<%= article.getArticleId() %>" />
						<liferay-portlet:param name="version" value="<%= String.valueOf(article.getVersion()) %>" />
					</liferay-portlet:renderURL>

					<liferay-ui:icon image="edit" message="edit-article" url="<%= editURL %>" />
				</c:if>
			</span>

	<%
		}
		catch (NoSuchArticleException nsae) {
		}
	}
	%>

	<c:if test="<%= PortletPermission.contains(permissionChecker, plid, PortletKeys.JOURNAL, ActionKeys.ADD_ARTICLE) %>">
		<liferay-portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="addArticleURL" portletName="<%= PortletKeys.JOURNAL %>">
			<liferay-portlet:param name="struts_action" value="/journal/edit_article" />
			<liferay-portlet:param name="portletResource" value="<%= portletDisplay.getId() %>" />
			<liferay-portlet:param name="redirect" value="<%= currentURL %>" />
		</liferay-portlet:renderURL>

		<liferay-ui:icon image="add_article" message="add-article" url="<%= addArticleURL %>" />
	</c:if>
</c:if>

<c:if test="<%= content.length > 1 %>">
	<script type="text/javascript">
		<portlet:namespace />updatePage();
	</script>
</c:if>
