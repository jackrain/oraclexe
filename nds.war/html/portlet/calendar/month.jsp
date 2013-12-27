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

cal.set(Calendar.DATE, 1);

int month = cal.get(Calendar.MONTH);
int year = cal.get(Calendar.YEAR);

int maxDayOfMonth = cal.getActualMaximum(Calendar.DATE);
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

DateFormat dateFormat = new SimpleDateFormat("MMMM, yyyy", locale);
DateFormat timeFormat = new SimpleDateFormat("h:mma", locale);
%>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<a href="<%= portletURL.toString() %>&<portlet:namespace />month=<%= cal.get(Calendar.MONTH) - 1 %>&<portlet:namespace />day=<%= selDay %>&<portlet:namespace />year=<%= selYear %>&<portlet:namespace />eventType=<%= eventType %>">
				<img border="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_left.gif">
				</a>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<b><%= dateFormat.format(Time.getDate(cal)) %></b>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<a href="<%= portletURL.toString() %>&<portlet:namespace />month=<%= cal.get(Calendar.MONTH) + 1 %>&<portlet:namespace />day=<%= selDay %>&<portlet:namespace />year=<%= selYear %>&<portlet:namespace />eventType=<%= eventType %>">
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
<tr class="portlet-section-header">

	<%
	for (int i = 0; i < 7;  i++) {
		int daysIndex = (selCal.getFirstDayOfWeek() + i - 1) % 7;
	%>

		<td style="padding-left: 1px;"></td>
		<td align="center" height="25" width="<%= (i == 0 || i == 6) ? "15" : "14" %>%">
			<span style="font-size: x-small;"><b>
			<%= LanguageUtil.get(pageContext, CalendarUtil.DAYS_ABBREVIATION[daysIndex]) %>
			</b></span>
		</td>

	<%
	}
	%>

	<td></td>
</tr>
<tr>

	<%
	if (((selCal.getFirstDayOfWeek()) == Calendar.MONDAY)) {
		if (dayOfWeek == 1) {
			dayOfWeek += 6;
		}
		else {
			dayOfWeek --;
		}
	}

	for (int i = 1; i < dayOfWeek; i++) {
	%>

		<td class="portlet-section-header"></td>
		<td height="100"></td>

	<%
	}

	for (int i = 1; i <= maxDayOfMonth; i++) {
		if (dayOfWeek > 7) {
	%>

				<td class="portlet-section-header"></td>
			</tr>
			<tr>
				<td class="portlet-section-header" colspan="15"></td>
			</tr>
			<tr>

		<%
			dayOfWeek = 1;
		}

		dayOfWeek++;

		Calendar tempCal = (Calendar)selCal.clone();

		tempCal.set(Calendar.MONTH, month);
		tempCal.set(Calendar.DATE, i);
		tempCal.set(Calendar.YEAR, year);

		String className = "";

		if ((tempCal.get(Calendar.MONTH) == curMonth) &&
			(tempCal.get(Calendar.DATE) == curDay) &&
			(tempCal.get(Calendar.YEAR) == curYear)) {

			className = "portlet-section-header";
		}
		%>

		<td class="portlet-section-header"></td>
		<td height="100" valign="top">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr class="<%= className %>">
				<td>
					<table border="0" cellpadding="4" cellspacing="0" width="100%">
					<tr>
						<td>
							<span style="font-size: x-small;"><b>
							<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/calendar/view" /><portlet:param name="tabs1" value="day" /><portlet:param name="month" value="<%= Integer.toString(month) %>" /><portlet:param name="day" value="<%= Integer.toString(i) %>" /><portlet:param name="year" value="<%= Integer.toString(year) %>" /></portlet:renderURL>"><%= i %></a>
							</b></span>

							<c:if test="<%= tempCal.get(Calendar.DAY_OF_WEEK) == cal.getFirstDayOfWeek() %>">
								<span style="font-size: xx-small;">
								[<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/calendar/view" /><portlet:param name="tabs1" value="week" /><portlet:param name="month" value="<%= Integer.toString(month) %>" /><portlet:param name="day" value="<%= Integer.toString(i) %>" /><portlet:param name="year" value="<%= Integer.toString(year) %>" /></portlet:renderURL>"><%= LanguageUtil.get(pageContext, "week") %> <%= tempCal.get(Calendar.WEEK_OF_YEAR) %></a>]
								</span>
							</c:if>
						</td>
						<td align="right">
							<c:if test="<%= PortletPermission.contains(permissionChecker, plid, PortletKeys.CALENDAR, ActionKeys.ADD_EVENT) %>">
								<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/calendar/edit_event" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="month" value="<%= Integer.toString(tempCal.get(Calendar.MONTH)) %>" /><portlet:param name="day" value="<%= Integer.toString(tempCal.get(Calendar.DATE)) %>" /><portlet:param name="year" value="<%= Integer.toString(tempCal.get(Calendar.YEAR)) %>" /></portlet:renderURL>">
								<img border="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_plus.gif" title="<%= LanguageUtil.get(pageContext, "add") %>">
								</a>
							</c:if>
						</td>
					</tr>
					</table>
				</td>
			</tr>

			<%
			List events = CalEventLocalServiceUtil.getEvents(portletGroupId, tempCal, eventType);

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
					<td>
						<div style="padding: 4px;">
							<c:if test="<%= !allDay %>">
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
							</c:if>

							<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/calendar/view_event" /><portlet:param name="eventId" value="<%= event.getEventId() %>" /></portlet:renderURL>">
							<%= StringUtil.shorten(event.getTitle(), 80) %>
							</a>
						</div>
					</td>
				</tr>

			<%
			}
			%>

			</table>
		</td>

	<%
	}

	for (int i = 7; i >= dayOfWeek; i--) {
	%>

		<td class="portlet-section-header"><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="1"></td>
		<td height="100"></td>

	<%
	}
	%>

	<td class="portlet-section-header"><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="1"></td>
</tr>
<tr>
	<td class="portlet-section-header" colspan="15"></td>
</tr>
</table>
