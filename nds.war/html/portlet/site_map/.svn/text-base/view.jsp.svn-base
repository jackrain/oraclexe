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

<%@ include file="/html/portlet/site_map/init.jsp" %>

<%
List rootLayouts = LayoutLocalServiceUtil.getLayouts(layout.getOwnerId(), rootLayoutId);

StringBuffer sb = new StringBuffer();

_buildSiteMap(rootLayouts, displayDepth, 1, themeDisplay, sb);
%>

<%= sb.toString() %>

<%!
private void _buildSiteMap(List layouts, int displayDepth, int curDepth, ThemeDisplay themeDisplay, StringBuffer sb) throws Exception {
	sb.append("<ul style=\"padding-left: 25px\">");

	for (int i = 0; i < layouts.size(); i++) {
		Layout layout = (Layout)layouts.get(i);

		if (!layout.isHidden()) {
			String layoutURL = PortalUtil.getLayoutURL(layout, themeDisplay);
			String target = PortalUtil.getLayoutTarget(layout);

			sb.append("<li>");
			sb.append("<a href=\"");
			sb.append(layoutURL);
			sb.append("\" ");
			sb.append(target);
			sb.append("> ");
			sb.append(layout.getName(themeDisplay.getLocale()));
			sb.append("</a>");
			sb.append("</li>");

			if ((displayDepth == 0) || (displayDepth > curDepth)) {
				_buildSiteMap(layout.getChildren(), displayDepth, curDepth + 1, themeDisplay, sb);
			}
		}
	}

	sb.append("</ul>");
}
%>
