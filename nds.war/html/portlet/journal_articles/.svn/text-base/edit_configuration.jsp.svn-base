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
groupId = ParamUtil.getString(request, "groupId", groupId);

List communities = GroupLocalServiceUtil.search(company.getCompanyId(), null, null, null, QueryUtil.ALL_POS, QueryUtil.ALL_POS);
%>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">

<liferay-ui:error exception="<%= NoSuchGroupException.class %>" message="the-community-could-not-be-found" />

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "community") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />groupId">
			<option value=""></option>

			<%
			for (int i = 0; i < communities.size(); i++) {
				Group group = (Group)communities.get(i);
			%>

				<option <%= groupId.equals(group.getGroupId()) ? "selected" : "" %> value="<%= group.getGroupId() %>"><%= group.getName() %></option>

			<%
			}
			%>

		</select>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "article-type") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />type">
			<option value=""></option>

			<%
			for (int i = 0; i < JournalArticleImpl.TYPES.length; i++) {
			%>

				<option <%= type.equals(JournalArticleImpl.TYPES[i]) ? "selected" : "" %> value="<%= JournalArticleImpl.TYPES[i] %>"><%= LanguageUtil.get(pageContext, JournalArticleImpl.TYPES[i]) %></option>

			<%
			}
			%>

		</select>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "display-url") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />pageURL">
			<option <%= pageURL.equals("maximized") ? "selected" : "" %> value="maximized"><%= LanguageUtil.get(pageContext, "maximized") %></option>
			<option <%= pageURL.equals("popUp") ? "selected" : "" %> value="popUp"><%= LanguageUtil.get(pageContext, "pop-up") %></option>
		</select>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "display-per-page") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />pageDelta">

			<%
			String[] pageDeltaValues = PropsUtil.getArray(PropsUtil.JOURNAL_ARTICLES_PAGE_DELTA_VALUES);

			for (int i = 0; i < pageDeltaValues.length; i++) {
			%>

				<option <%= (pageDelta == GetterUtil.getInteger(pageDeltaValues[i])) ? "selected" : "" %> value="<%= pageDeltaValues[i] %>"><%= pageDeltaValues[i] %></option>

			<%
			}
			%>

		</select>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "order-by-column") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />orderByCol">
			<option <%= orderByCol.equals("display-date") ? "selected" : "" %> value="display-date"><%= LanguageUtil.get(pageContext, "display-date") %></option>
			<option <%= orderByCol.equals("create-date") ? "selected" : "" %> value="create-date"><%= LanguageUtil.get(pageContext, "create-date") %></option>
			<option <%= orderByCol.equals("modified-date") ? "selected" : "" %> value="modified-date"><%= LanguageUtil.get(pageContext, "modified-date") %></option>
			<option <%= orderByCol.equals("title") ? "selected" : "" %> value="title"><%= LanguageUtil.get(pageContext, "article-title") %></option>
			<option <%= orderByCol.equals("articleId") ? "selected" : "" %> value="articleId"><%= LanguageUtil.get(pageContext, "article-id") %></option>
		</select>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "order-by-type") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />orderByType">
			<option <%= orderByType.equals("asc") ? "selected" : "" %> value="asc"><%= LanguageUtil.get(pageContext, "ascending") %></option>
			<option <%= orderByType.equals("desc") ? "selected" : "" %> value="desc"><%= LanguageUtil.get(pageContext, "descending") %></option>
		</select>
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">

</form>
