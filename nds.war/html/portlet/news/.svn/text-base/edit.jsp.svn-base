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

<%@ include file="/html/portlet/news/init.jsp" %>

<%
String tabs1 = ParamUtil.getString(request, "tabs1", "news-selections");

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/news/edit");
portletURL.setParameter("tabs1", tabs1);
%>

<form action="<portlet:actionURL><portlet:param name="struts_action" value="/news/edit" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
<input name="<portlet:namespace />tabs1" type="hidden" value="<%= tabs1 %>">

<liferay-ui:tabs
	names="news-selections,display-settings"
	url="<%= portletURL.toString() %>"
/>

<c:choose>
	<c:when test='<%= tabs1.equals("news-selections") %>'>

		<%
		String categoryName = request.getParameter("categoryName");

		Set selFeeds = NewsUtil.getSelFeeds(prefs);
		%>

		<input name="<portlet:namespace />categoryName" type="hidden" value="<%= categoryName %>">
		<input name="<portlet:namespace />feeds" type="hidden" value="">

		<c:choose>
			<c:when test="<%= Validator.isNull(categoryName) %>">
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="right">
						<b><%= LanguageUtil.get(pageContext, "available-categories") %></b>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<b><%= LanguageUtil.get(pageContext, "your-selections") %></b>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<br>
					</td>
				</tr>

				<%
				Map selCategories = NewsUtil.getSelCategories(selFeeds);

				Set categorySet = NewsUtil.getCategorySet();

				Iterator csIterator = categorySet.iterator();

				while (csIterator.hasNext()) {
					categoryName = (String)csIterator.next();
				%>

					<tr>
						<td align="right" valign="top">
							<b><a href="<portlet:actionURL><portlet:param name="struts_action" value="/news/edit" /><portlet:param name="page" value="categories" /><portlet:param name="categoryName" value="<%= categoryName %>" /></portlet:actionURL>">
							<%= categoryName %>
							</a></b>
						</td>
						<td style="padding-left: 10px;"></td>
						<td>

						<c:if test="<%= selCategories.containsKey(categoryName) %>">

							<%
							List feedList = (List)selCategories.get(categoryName);

							for (int i = 0; i < feedList.size(); i++) {
								Feed feed = (Feed)feedList.get(i);
							%>

								<%= feed.getShortName() %><br>

							<%
							}
							%>

						</c:if>

						</td>
					</tr>
					<tr>
						<td colspan="3">
							<br>
						</td>
					</tr>

				<%
				}
				%>

				</table>
			</c:when>
			<c:otherwise>

				<%
				Set feedSet = (Set)NewsUtil.getCategoryMap().get(categoryName);
				%>

				<b><%= categoryName %></b>

				<br><br>

				<liferay-ui:table-iterator
					list="<%= ListUtil.fromCollection(feedSet) %>"
					listType="com.liferay.portlet.news.model.Feed"
					rowLength="3"
					rowBreak="">

					<input <%= (selFeeds != null) && (selFeeds.contains(tableIteratorObj)) ? "checked" : "" %> name="<portlet:namespace />feed" type="checkbox" value="<%= tableIteratorObj.getFeedURL() %>">

					<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/news/view" /><portlet:param name="url" value="<%= tableIteratorObj.getFeedURL() %>" /></portlet:renderURL>"><%= tableIteratorObj.getShortName() %></a>
				</liferay-ui:table-iterator>

				<br>

				<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="document.<portlet:namespace />fm.<portlet:namespace />feeds.value = listChecked(document.<portlet:namespace />fm); submitForm(document.<portlet:namespace />fm);">

				<input class="portlet-form-button" type="button" value="<bean:message key="back" />" onClick="self.location = '<portlet:actionURL><portlet:param name="struts_action" value="/news/edit" /></portlet:actionURL>';">
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test='<%= tabs1.equals("display-settings") %>'>

		<%
		Set selFeeds = NewsUtil.getSelFeeds(prefs);
		%>

		<input name="<portlet:namespace />feeds" type="hidden" value="">

		<%= LanguageUtil.get(pageContext, "set-the-display-order-of-news-feeds") %>

		<br><br>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>

				<%
				Iterator itr = selFeeds.iterator();
				%>

				<select name="<portlet:namespace />feeds_sel" size="5">

				<%
				while (itr.hasNext()) {
					Feed feed = (Feed)itr.next();
				%>

					<option value="<%= feed.getFeedURL() %>"><%= feed.getShortName() %></option>

				<%
				}
				%>

				</select>
			</td>
			<td style="padding-left: 10px;"></td>
			<td valign="top">
				<a href="javascript: reorder(document.<portlet:namespace />fm.<portlet:namespace />feeds_sel, 0);"><img border="0" height="16" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_up.gif" vspace="2" width="16"></a><br>
				<a href="javascript: reorder(document.<portlet:namespace />fm.<portlet:namespace />feeds_sel, 1);"><img border="0" height="16" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_down.gif" vspace="2" width="16"></a><br>
				<a href="javascript: removeItem(document.<portlet:namespace />fm.<portlet:namespace />feeds_sel);"><img border="0" height="16" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_x.gif" vspace="2" width="16"></a><br>
			</td>
		</tr>
		</table>

		<br>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "num-of-articles-per-selection") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select name="<portlet:namespace />apn">

					<%
					for (int i = 1; i < 10; i++) {
					%>

						<option <%= (i == articlesPerNews) ? "selected" : "" %> value="<%= i %>"><%= i %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
		</table>

		<br>

		<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="document.<portlet:namespace />fm.<portlet:namespace />feeds.value = listSelect(document.<portlet:namespace />fm.<portlet:namespace />feeds_sel); submitForm(document.<portlet:namespace />fm);">
	</c:when>
</c:choose>

</form>
