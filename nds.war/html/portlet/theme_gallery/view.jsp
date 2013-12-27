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

<%@ include file="/html/portlet/theme_gallery/init.jsp" %>

<%
String categoryId = ParamUtil.getString(request, "categoryId");

int curValue = ParamUtil.getInteger(request, "cur", 1);
int delta = 5;

int start = (curValue - 1) * delta;
int end = start + delta;

List entries = null;
int total = 0;

try {
	entries = ThemeGalleryUtil.getEntries(categoryId, start, end);
	total = ThemeGalleryUtil.getEntriesSize(categoryId);
}
catch (Exception e) {
	entries = new ArrayList();
	total = 0;
}

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setParameter("categoryId", categoryId);
%>

<form action="<portlet:renderURL />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace />categoryId" type="hidden" value="<%= categoryId %>">
<input name="<portlet:namespace />cur" type="hidden" value="1">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td>
		<select onChange="document.<portlet:namespace />fm.<portlet:namespace />categoryId.value = this[this.selectedIndex].value; submitForm(document.<portlet:namespace />fm);">
			<option value=""><%= LanguageUtil.get(pageContext, "all-categories") %></option>

			<%
			String[] categories = ThemeGalleryUtil.getCategories();

			for (int i = 0; i < categories.length; i++) {
			%>

				<option <%= categoryId.equals(categories[i]) ? "selected" : "" %> value="<%= categories[i] %>"><%= categories[i] %></option>

			<%
			}
			%>

		</select>
	</td>

	<c:if test="<%= total > delta %>">
		<td align="right">
			<liferay-ui:page-iterator
				curParam="cur"
				curValue="<%= curValue %>"
				delta="<%= delta %>"
				maxPages="10"
				total="<%= total %>"
				url="<%= portletURL.toString() %>"
			/>
		</td>
	</c:if>
</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0">

<%
for (int i = 0; i < entries.size(); i++) {
	ThemeEntry entry = (ThemeEntry)entries.get(i);
%>

	<tr>
		<td>
			<b><%= entry.getName() %></b>

			<c:if test="<%= Validator.isNotNull(entry.getDownload()) %>">
				- <a href="http://prdownloads.sourceforge.net/lportal/<%= entry.getDownload() %>?download"><%= entry.getDownload() %></a>
			</c:if>

			<br>

			<%= entry.getDescription() %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<a href="http://content.liferay.com/4/images/<%= entry.getImageLarge() %>" target="_blank"><img border="0" src="http://content.liferay.com/4/images/<%= entry.getImageSmall() %>"></a>
		</td>
	</tr>

<%
}
%>

</table>

</form>
