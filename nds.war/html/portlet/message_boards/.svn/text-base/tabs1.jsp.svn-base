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

<%@ include file="/html/portlet/message_boards/init.jsp" %>

<%
PortletURL tabs1URL = renderResponse.createRenderURL();

tabs1URL.setWindowState(WindowState.MAXIMIZED);

tabs1URL.setParameter("struts_action", "/message_boards/view");

String tabs1Names = "categories,recent-posts,statistics";

if (themeDisplay.isSignedIn()) {
	tabs1Names = "categories,my-posts,recent-posts,statistics";
}

String url0HREF = tabs1URL.toString();

if (Validator.isNotNull(PortalUtil.getLayoutFriendlyURL(layout, themeDisplay))) {
	url0HREF = PortalUtil.getLayoutURL(layout, themeDisplay) + "/message_boards/";
}
else {
}
%>

<liferay-ui:tabs
	names="<%= tabs1Names %>"
	url="<%= tabs1URL.toString() %>"
	url0="<%= url0HREF %>"
/>
