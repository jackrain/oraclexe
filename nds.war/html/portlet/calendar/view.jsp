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

<%@ include file="/html/portlet/calendar/init.jsp" %>

<%
String tabs1 = ParamUtil.getString(request, "tabs1", "summary");

String eventType = ParamUtil.getString(request, "eventType");

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/calendar/view");
portletURL.setParameter("tabs1", tabs1);
%>

<form method="post" name="<portlet:namespace />fm">

<liferay-util:include page="/html/portlet/calendar/tabs1.jsp" />

<c:choose>
	<c:when test='<%= tabs1.equals("summary") %>'>
		<%@ include file="/html/portlet/calendar/summary.jsp" %>
	</c:when>
	<c:when test='<%= tabs1.equals("day") %>'>
		<%@ include file="/html/portlet/calendar/day.jsp" %>
	</c:when>
	<c:when test='<%= tabs1.equals("week") %>'>
		<%@ include file="/html/portlet/calendar/week.jsp" %>
	</c:when>
	<c:when test='<%= tabs1.equals("month") %>'>
		<%@ include file="/html/portlet/calendar/month.jsp" %>
	</c:when>
	<c:when test='<%= tabs1.equals("year") %>'>
		<%@ include file="/html/portlet/calendar/year.jsp" %>
	</c:when>
	<c:when test='<%= tabs1.equals("events") %>'>
		<%@ include file="/html/portlet/calendar/events.jsp" %>
	</c:when>
</c:choose>

</form>
