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
ArticleSearch searchContainer = (ArticleSearch)request.getAttribute("liferay-ui:search:searchContainer");

ArticleDisplayTerms displayTerms = (ArticleDisplayTerms)searchContainer.getDisplayTerms();
%>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "id") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "version") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "name") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "description") %>
	</td>
</tr>
<tr>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= ArticleDisplayTerms.ARTICLE_ID %>" size="20" type="text" value="<%= displayTerms.getArticleId() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= ArticleDisplayTerms.VERSION %>" size="20" type="text" value="<%= displayTerms.getVersionString() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= ArticleDisplayTerms.TITLE %>" size="20" type="text" value="<%= displayTerms.getTitle() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= ArticleDisplayTerms.DESCRIPTION %>" size="20" type="text" value="<%= displayTerms.getDescription() %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "content") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "type") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td colspan="3">
		<c:choose>
			<c:when test="<%= portletName.equals(PortletKeys.JOURNAL) %>">
				<%= LanguageUtil.get(pageContext, "status") %>
			</c:when>
			<c:otherwise>
				<%= LanguageUtil.get(pageContext, "community") %>
			</c:otherwise>
		</c:choose>
	</td>
</tr>
<tr>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= ArticleDisplayTerms.CONTENT %>" size="20" type="text" value="<%= displayTerms.getContent() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<select name="<portlet:namespace /><%= ArticleDisplayTerms.TYPE %>">
			<option value=""></option>

			<%
			for (int i = 0; i < JournalArticleImpl.TYPES.length; i++) {
			%>

				<option <%= displayTerms.getType().equals(JournalArticleImpl.TYPES[i]) ? "selected" : "" %> value="<%= JournalArticleImpl.TYPES[i] %>"><%= LanguageUtil.get(pageContext, JournalArticleImpl.TYPES[i]) %></option>

			<%
			}
			%>

		</select>
	</td>
	<td style="padding-left: 5px;"></td>
	<td colspan="3">
		<c:choose>
			<c:when test="<%= portletName.equals(PortletKeys.JOURNAL) %>">
				<select name="<portlet:namespace /><%= ArticleDisplayTerms.STATUS %>">
					<option value=""></option>
					<option <%= displayTerms.getStatus().equals("approved") ? "selected" : "" %> value="approved"><%= LanguageUtil.get(pageContext, "approved") %></option>
					<option <%= displayTerms.getStatus().equals("not-approved") ? "selected" : "" %> value="not-approved"><%= LanguageUtil.get(pageContext, "not-approved") %></option>
					<option <%= displayTerms.getStatus().equals("expired") ? "selected" : "" %> value="expired"><%= LanguageUtil.get(pageContext, "expired") %></option>
					<option <%= displayTerms.getStatus().equals("review") ? "selected" : "" %> value="review"><%= LanguageUtil.get(pageContext, "review") %></option>
				</select>
			</c:when>
			<c:otherwise>

				<%
				List communities = GroupLocalServiceUtil.search(company.getCompanyId(), null, null, null, QueryUtil.ALL_POS, QueryUtil.ALL_POS);
				%>

				<select name="<portlet:namespace /><%= ArticleDisplayTerms.GROUP_ID %>">

					<%
					for (int i = 0; i < communities.size(); i++) {
						Group group = (Group)communities.get(i);
					%>

						<option <%= displayTerms.getGroupId().equals(group.getGroupId()) ? "selected" : "" %> value="<%= group.getGroupId() %>"><%= group.getName() %></option>

					<%
					}
					%>

				</select>
			</c:otherwise>
		</c:choose>
	</td>
</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<select name="<portlet:namespace /><%= ArticleDisplayTerms.AND_OPERATOR %>">
			<option <%= displayTerms.isAndOperator() ? "selected" : "" %> value="1"><%= LanguageUtil.get(pageContext, "and") %></option>
			<option <%= !displayTerms.isAndOperator() ? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "or") %></option>
		</select>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">
	</td>
</tr>
</table>

<c:if test="<%= Validator.isNotNull(displayTerms.getStructureId()) %>">
	<input name="<portlet:namespace /><%= ArticleDisplayTerms.STRUCTURE_ID %>" type="hidden" value="<%= displayTerms.getStructureId() %>">

	<br>

	<%= LanguageUtil.get(pageContext, "filter-by-structure") %>: <%= displayTerms.getStructureId() %><br>
</c:if>

<c:if test="<%= Validator.isNotNull(displayTerms.getTemplateId()) %>">
	<input name="<portlet:namespace /><%= ArticleDisplayTerms.TEMPLATE_ID %>" type="hidden" value="<%= displayTerms.getTemplateId() %>">

	<br>

	<%= LanguageUtil.get(pageContext, "filter-by-template") %>: <%= displayTerms.getTemplateId() %><br>
</c:if>
