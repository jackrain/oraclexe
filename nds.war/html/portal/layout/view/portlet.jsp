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

<%@ include file="/html/portal/init.jsp" %>

<%
boolean layoutMaximized = layoutTypePortlet.hasStateMax();

if (!layoutMaximized) {
	String content = LayoutTemplateLocalUtil.getContent(layoutTypePortlet.getLayoutTemplateId(), false, theme.getThemeId());

	RuntimePortletUtil.processTemplate(application, pageContext, request, response, content);
}
else {
	String content = null;

	if (themeDisplay.isStateExclusive()) {
		content = LayoutTemplateLocalUtil.getContent("exclusive", true, theme.getThemeId());
	}
	else {
		content = LayoutTemplateLocalUtil.getContent("max", true, theme.getThemeId());
	}

	RuntimePortletUtil.processTemplate(application, pageContext, request, response, StringUtil.split(layoutTypePortlet.getStateMax())[0], content);
}

if (themeDisplay.isSignedIn() && !themeDisplay.isStateExclusive()) {
	List columns = layoutTypePortlet.getLayoutTemplate().getColumns();
%>

	<script type="text/javascript">
		LayoutColumns.layoutMaximized = <%= layoutMaximized %>;
		LayoutColumns.plid = "<%= plid %>";
		LayoutColumns.doAsUserId = "<%= themeDisplay.getDoAsUserId() %>";

		<c:if test="<%= !layoutMaximized %>">
			LayoutColumns.init([<%
				for (int i = 0; i < columns.size(); i++) {
					out.print("\"" + (String)columns.get(i) + "\"");

					if (i < columns.size() - 1) {
						out.print(",");
					}
				}
				%>]);
		</c:if>
	</script>

<%
}
%>
