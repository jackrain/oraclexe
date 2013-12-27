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

<script type="text/javascript">
	<portlet:namespace />updateCalendar = function (month, day, year) {
		self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="tabs1" value="day" /><portlet:param name="eventType" value="<%= eventType %>" /></portlet:renderURL>&<portlet:namespace />month=' + month + '&<portlet:namespace />day=' + day + '&<portlet:namespace />year=' + year;
	}
</script>

<div style="float: left; padding-right: 10px;">

	<%
	int maxDayOfMonth = selCal.getActualMaximum(Calendar.DATE);

	Set data = new HashSet();

	for (int i = 1; i <= maxDayOfMonth; i++) {
		Calendar tempCal = (Calendar)selCal.clone();
		tempCal.set(Calendar.MONTH, selMonth);
		tempCal.set(Calendar.DATE, i);
		tempCal.set(Calendar.YEAR, selYear);

		boolean hasEvents = CalEventLocalServiceUtil.hasEvents(portletGroupId, tempCal, eventType);

		if (hasEvents) {
			data.add(new Integer(i));
		}
	}
	%>

	<liferay-ui:calendar
		month="<%= selMonth %>"
		day="<%= selDay %>"
		year="<%= selYear %>"
		headerFormat="<%= DateFormat.getDateInstance(DateFormat.LONG, locale) %>"
		data="<%= data %>"
	/>
</div>

<div style="float: left">
	<%@ include file="/html/portlet/calendar/event_iterator.jsp" %>
</div>

<div style="clear: both"></div>
