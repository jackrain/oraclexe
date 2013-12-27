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

<%
PortletURL iteratorURL = PortletURLUtil.clone(portletURL, false, renderResponse);

List headerNames = new ArrayList();

headerNames.add("date");
headerNames.add("time");
headerNames.add("title");
headerNames.add("type");
headerNames.add(StringPool.BLANK);

SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, iteratorURL, headerNames, null);

int total = CalEventLocalServiceUtil.getEventsCount(portletGroupId, eventType);

searchContainer.setTotal(total);

List results = CalEventLocalServiceUtil.getEvents(portletGroupId, eventType, searchContainer.getStart(), searchContainer.getEnd());

searchContainer.setResults(results);

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
	CalEvent event = (CalEvent)results.get(i);

	ResultRow row = new ResultRow(event, event.getPrimaryKey().toString(), i);

	PortletURL rowURL = renderResponse.createRenderURL();

	rowURL.setWindowState(WindowState.MAXIMIZED);

	rowURL.setParameter("struts_action", "/calendar/view_event");
	rowURL.setParameter("eventId", event.getEventId());

	// Date

	if (event.isTimeZoneSensitive()) {
		row.addText(dateFormatDate.format(Time.getDate(event.getStartDate(), timeZone)), rowURL);
	}
	else {
		row.addText(dateFormatDate.format(event.getStartDate()), rowURL);
	}

	// Time

	boolean allDay = CalUtil.isAllDay(event, timeZone, locale);

	if (allDay) {
		row.addText(LanguageUtil.get(pageContext, "all-day"), rowURL);
	}
	else {
		if (event.isTimeZoneSensitive()) {
			row.addText(
				dateFormatTime.format(Time.getDate(event.getStartDate(), timeZone)) + " &#150; " + dateFormatTime.format(Time.getDate(CalUtil.getEndTime(event), timeZone)),
				rowURL);
		}
		else {
			row.addText(
				dateFormatTime.format(event.getStartDate()) + " &#150; " + dateFormatTime.format(CalUtil.getEndTime(event)),
				rowURL);
		}
	}

	// Title and type

	row.addText(event.getTitle(), rowURL);
	row.addText(LanguageUtil.get(pageContext, event.getType()), rowURL);

	// Action

	row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/calendar/event_action.jsp");

	// Add result row

	resultRows.add(row);
}
%>

<c:if test="<%= PortletPermission.contains(permissionChecker, plid, PortletKeys.CALENDAR, ActionKeys.ADD_EVENT) %>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-event") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/calendar/edit_event" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="month" value="<%= Integer.toString(selMonth) %>" /><portlet:param name="day" value="<%= Integer.toString(selDay) %>" /><portlet:param name="year" value="<%= Integer.toString(selYear) %>" /></portlet:renderURL>';"><br>

	<c:if test="<%= results.size() > 0 %>">
		<br>
	</c:if>
</c:if>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
