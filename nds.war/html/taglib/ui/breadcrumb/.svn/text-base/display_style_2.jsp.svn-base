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

<%@ include file="/html/taglib/ui/breadcrumb/init.jsp" %>

<%
StringBuffer sb = new StringBuffer();

_buildBreadcrumb(selLayout, selLayoutParam, portletURL, themeDisplay, true, sb);
%>

<%= sb.toString() %>

<%!
private void _buildBreadcrumb(Layout selLayout, String selLayoutParam, PortletURL portletURL, ThemeDisplay themeDisplay, boolean selectedLayout, StringBuffer sb) throws Exception {
	String layoutURL = _getBreadcrumbLayoutURL(selLayout, selLayoutParam, portletURL, themeDisplay);
	String target = PortalUtil.getLayoutTarget(selLayout);
	String layoutParentId = selLayout.getParentLayoutId();

	StringBuffer breadCrumbSB = new StringBuffer();

	if (selectedLayout) {
		if (!layoutParentId.equals(LayoutImpl.DEFAULT_PARENT_LAYOUT_ID)) {
			breadCrumbSB.append("<br />");
			breadCrumbSB.append("<br />");
		}

		breadCrumbSB.append("<div class=\"font-xx-large\" style=\"font-weight: bold;\">");
		breadCrumbSB.append(selLayout.getName(themeDisplay.getLocale()));
		breadCrumbSB.append("</div>");
		breadCrumbSB.append("<br />");
	}
	else {
		breadCrumbSB.append("<a href=\"");
		breadCrumbSB.append(layoutURL);
		breadCrumbSB.append("\" ");
		breadCrumbSB.append(target);
		breadCrumbSB.append(">");
		breadCrumbSB.append(selLayout.getName(themeDisplay.getLocale()));
		breadCrumbSB.append("</a>");
	}

	Layout layoutParent = null;

	if (!layoutParentId.equals(LayoutImpl.DEFAULT_PARENT_LAYOUT_ID)) {
		layoutParent = LayoutLocalServiceUtil.getLayout(layoutParentId, selLayout.getOwnerId());

		_buildBreadcrumb(layoutParent, selLayoutParam, portletURL, themeDisplay, false, sb);

		sb.append(" &raquo; ");
		sb.append(breadCrumbSB.toString());
	}
	else {
		sb.append(breadCrumbSB.toString());
	}
}

private String _getBreadcrumbLayoutURL(Layout selLayout, String selLayoutParam, PortletURL portletURL, ThemeDisplay themeDisplay) throws Exception {
	if (portletURL == null) {
		return PortalUtil.getLayoutURL(selLayout, themeDisplay);
	}
	else {
		portletURL.setParameter(selLayoutParam, selLayout.getPlid());

		return portletURL.toString();
	}
}
%>
