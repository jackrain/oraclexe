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
Calendar cal = (Calendar)selCal.clone();

DateFormat dateFormatDayOfWeek = new SimpleDateFormat("EEE", locale);
DateFormat dateFormatMonthAndDay = new SimpleDateFormat("M/d", locale);
%>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>

				<%
				cal.add(Calendar.DATE, -7);
				%>

				<a href="<%= portletURL.toString() %>&<portlet:namespace />month=<%= cal.get(Calendar.MONTH) %>&<portlet:namespace />day=<%= cal.get(Calendar.DATE) %>&<portlet:namespace />year=<%= cal.get(Calendar.YEAR) %>&<portlet:namespace />eventType=<%= eventType %>">
				<img border="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_left.gif">
				</a>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>

				<%
				cal.add(Calendar.DATE, 7);
				%>

				<b><%= dateFormatDate.format(Time.getDate(cal)) %> -

				<%
				cal.add(Calendar.DATE, 6);
				%>

				<%= dateFormatDate.format(Time.getDate(cal)) %></b>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>

				<%
				cal.add(Calendar.DATE, 1);
				%>

				<a href="<%= portletURL.toString() %>&<portlet:namespace />month=<%= cal.get(Calendar.MONTH) %>&<portlet:namespace />day=<%= cal.get(Calendar.DATE) %>&<portlet:namespace />year=<%= cal.get(Calendar.YEAR) %>&<portlet:namespace />eventType=<%= eventType %>">
				<img border="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_right.gif">
				</a>
			</td>
		</tr>
		</table>
	</td>
	<td align="right">
		<select onChange="self.location = '<%= portletURL.toString() %>&<portlet:namespace />month=<%= selMonth %>&<portlet:namespace />day=<%= selDay %>&<portlet:namespace />year=<%= selYear %>&<portlet:namespace />eventType=' + this.value;">
			<option value=""><%= LanguageUtil.get(pageContext, "all-events") %></option>

			<%
			for (int i = 0; i < CalEventImpl.TYPES.length; i++) {
			%>

				<option <%= eventType.equals(CalEventImpl.TYPES[i]) ? "selected" : "" %> value="<%= CalEventImpl.TYPES[i] %>"><%= LanguageUtil.get(pageContext, CalEventImpl.TYPES[i]) %></option>

			<%
			}
			%>

		</select>
	</td>
</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">

<%
cal = (Calendar)selCal.clone();

for (int i = 0; i < 7; i++) {
%>

	<tr>
		<td class="portlet-section-header" colspan="5"></td>
	</tr>
	<tr>
		<td class="portlet-section-header" style="padding-left: 1px;"></td>

		<%
		String className = "portlet-font";

		if ((cal.get(Calendar.MONTH) == curMonth) &&
			(cal.get(Calendar.DATE) == curDay) &&
			(cal.get(Calendar.YEAR) == curYear)) {

			className = "portlet-section-header";
		}
		%>

		<td class="<%= className %>" valign="top">
			<table border="0" cellpadding="8" cellspacing="0">
			<tr>
				<td class="<%= className %>" style="font-size: x-small;">
					<b><%= dateFormatDayOfWeek.format(Time.getDate(cal)) %></b><br>

					<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/calendar/view" /><portlet:param name="tabs1" value="day" /><portlet:param name="month" value="<%= Integer.toString(cal.get(Calendar.MONTH)) %>" /><portlet:param name="day" value="<%= Integer.toString(cal.get(Calendar.DATE)) %>" /><portlet:param name="year" value="<%= Integer.toString(cal.get(Calendar.YEAR)) %>" /></portlet:renderURL>">
					<%= dateFormatMonthAndDay.format(Time.getDate(cal)) %>
					</a>

					<c:if test="<%= PortletPermission.contains(permissionChecker, plid, PortletKeys.CALENDAR, ActionKeys.ADD_EVENT) %>">
						<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/calendar/edit_event" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="month" value="<%= Integer.toString(cal.get(Calendar.MONTH)) %>" /><portlet:param name="day" value="<%= Integer.toString(cal.get(Calendar.DATE)) %>" /><portlet:param name="year" value="<%= Integer.toString(cal.get(Calendar.YEAR)) %>" /></portlet:renderURL>">
						<img border="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_plus.gif" title="<%= LanguageUtil.get(pageContext, "add") %>">
						</a>
					</c:if>
				</td>
			</tr>
			</table>
		</td>
		<td class="portlet-section-header" style="padding-left: 1px;"></td>
		<td valign="top" width="99%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td>
					<table border="0" cellpadding="4" cellspacing="0" width="100%">

					<%
					List events = CalEventLocalServiceUtil.getEvents(portletGroupId, cal, eventType);

					for (int j = 0; j < events.size(); j++) {
						CalEvent event = (CalEvent)events.get(j);

						className = "portlet-section-body";
						String classHoverName = "portlet-section-body-hover";

						if (MathUtil.isEven(j)) {
							className = "portlet-section-alternate";
							classHoverName = "portlet-section-alternate-hover";
						}

						boolean allDay = CalUtil.isAllDay(event, timeZone, locale);
					%>

						<tr class="<%= className %>" style="font-size: xx-small;" onMouseEnter="this.className = '<%= classHoverName %>';" onMouseLeave="this.className = '<%= className %>';">
							<td style="padding-left: 10px;"></td>
							<td nowrap valign="top">
								<c:choose>
									<c:when test="<%= allDay %>">
										<%= LanguageUtil.get(pageContext, "all-day") %>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="<%= event.isTimeZoneSensitive() %>">
												<%= dateFormatTime.format(Time.getDate(event.getStartDate(), timeZone)) %>
											</c:when>
											<c:otherwise>
												<%= dateFormatTime.format(event.getStartDate()) %>
											</c:otherwise>
										</c:choose>

										&#150;

										<c:choose>
											<c:when test="<%= event.isTimeZoneSensitive() %>">
												<%= dateFormatTime.format(Time.getDate(CalUtil.getEndTime(event), timeZone)) %>
											</c:when>
											<c:otherwise>
												<%= dateFormatTime.format(CalUtil.getEndTime(event)) %>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</td>
							<td style="padding-left: 10px;"></td>
							<td valign="top" width="99%">
								<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/calendar/view_event" /><portlet:param name="eventId" value="<%= event.getEventId() %>" /></portlet:renderURL>">
								<%= event.getTitle() %>
								</a>
							</td>
						</tr>

					<%
					}
					%>

					</table>
				</td>
			</tr>
			</table>
		</td>
		<td class="portlet-section-header" style="padding-left: 1px;"></td>
	</tr>

	<c:if test="<%= i + 1 == 7 %>">
		<tr>
			<td class="portlet-section-header" colspan="5"></td>
		</tr>
	</c:if>

<%
	cal.add(Calendar.DATE, 1);
}
%>

</table>
