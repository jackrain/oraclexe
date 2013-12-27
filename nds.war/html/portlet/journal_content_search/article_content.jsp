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

<%@ include file="/html/portlet/journal_content_search/init.jsp" %>

<%
String keywords = ParamUtil.getString(request, "keywords");

ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

Document doc = (Document)row.getObject();

String content = (String)doc.get(LuceneFields.CONTENT);

content = StringUtil.shorten(content, 200);
content = StringUtil.highlight(content, keywords);

String groupId = portletGroupId;
String articleId = doc.get("articleId");

String hitOwnerId = layout.getOwnerId();

List hitLayoutIds = JournalContentSearchLocalServiceUtil.getLayoutIds(hitOwnerId, groupId, articleId);
%>

<%= content %><br>

<c:if test="<%= hitLayoutIds.size() > 0 %>">
	<span style="font-size: xx-small;">

	<%
	for (int i = 0; i < hitLayoutIds.size(); i++) {
		String hitLayoutId = (String)hitLayoutIds.get(i);

		Layout hitLayout = LayoutLocalServiceUtil.getLayout(hitLayoutId, hitOwnerId);

		String hitLayoutURL = PortalUtil.getLayoutURL(hitLayout, themeDisplay);
	%>

		<br><a href="<%= hitLayoutURL %>"><%= Http.getProtocol(request) %>://<%= company.getPortalURL() %><%= StringUtil.shorten(hitLayoutURL, 100) %></a>

	<%
	}
	%>

	</span>
</c:if>
