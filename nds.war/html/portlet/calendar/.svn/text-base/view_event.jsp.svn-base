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
CalEvent event = (CalEvent)request.getAttribute(WebKeys.CALENDAR_EVENT);

String eventId = event.getEventId();

Recurrence recurrence = null;

int recurrenceType = ParamUtil.getInteger(request, "recurrenceType", Recurrence.NO_RECURRENCE);
if (event.getRepeating()) {
	recurrence = event.getRecurrenceObj();
	recurrenceType = recurrence.getFrequency();
}

int dailyType = ParamUtil.getInteger(request, "dailyType");
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getByDay() != null) {
		dailyType = 1;
	}
}

int dailyInterval = ParamUtil.getInteger(request, "dailyInterval", 1);
if ((event.getRepeating()) && (recurrence != null)) {
	dailyInterval = recurrence.getInterval();
}

int weeklyInterval = ParamUtil.getInteger(request, "weeklyInterval", 1);
if ((event.getRepeating()) && (recurrence != null)) {
	weeklyInterval = recurrence.getInterval();
}

boolean weeklyPosSu = _getWeeklyDayPos(request, Calendar.SUNDAY, event, recurrence);
boolean weeklyPosMo = _getWeeklyDayPos(request, Calendar.MONDAY, event, recurrence);
boolean weeklyPosTu = _getWeeklyDayPos(request, Calendar.TUESDAY, event, recurrence);
boolean weeklyPosWe = _getWeeklyDayPos(request, Calendar.WEDNESDAY, event, recurrence);
boolean weeklyPosTh = _getWeeklyDayPos(request, Calendar.THURSDAY, event, recurrence);
boolean weeklyPosFr = _getWeeklyDayPos(request, Calendar.FRIDAY, event, recurrence);
boolean weeklyPosSa = _getWeeklyDayPos(request, Calendar.SATURDAY, event, recurrence);

int monthlyType = ParamUtil.getInteger(request, "monthlyType");
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getByMonthDay() == null) {
		monthlyType = 1;
	}
}

int monthlyDay0 = ParamUtil.getInteger(request, "monthlyDay0", 15);
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getByMonthDay() != null) {
		monthlyDay0 = recurrence.getByMonthDay()[0];
	}
}

int monthlyInterval0 = ParamUtil.getInteger(request, "monthlyInterval0", 1);
if ((event.getRepeating()) && (recurrence != null)) {
	monthlyInterval0 = recurrence.getInterval();
}

int monthlyPos = ParamUtil.getInteger(request, "monthlyPos", 1);
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getByMonth() != null) {
		monthlyPos = recurrence.getByMonth()[0];
	}
	else if (recurrence.getByDay() != null) {
		monthlyPos = recurrence.getByDay()[0].getDayPosition();
	}
}

int monthlyDay1 = ParamUtil.getInteger(request, "monthlyDay1", Calendar.SUNDAY);
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getByMonth() != null) {
		monthlyDay1 = -1;
	}
	else if (recurrence.getByDay() != null) {
		monthlyDay1 = recurrence.getByDay()[0].getDayOfWeek();
	}
}

int monthlyInterval1 = ParamUtil.getInteger(request, "monthlyInterval1", 1);
if ((event.getRepeating()) && (recurrence != null)) {
	monthlyInterval1 = recurrence.getInterval();
}

int yearlyType = ParamUtil.getInteger(request, "yearlyType");
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getByMonth() != null) {
		yearlyType = 1;
	}
}

int yearlyMonth0 = ParamUtil.getInteger(request, "yearlyMonth0", Calendar.JANUARY);
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getByMonth() == null) {
		yearlyMonth0 = recurrence.getDtStart().get(Calendar.MONTH);
	}
}

int yearlyDay0 = ParamUtil.getInteger(request, "yearlyDay0", 15);
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getByMonth() == null) {
		yearlyDay0 = recurrence.getDtStart().get(Calendar.DATE);
	}
}

int yearlyInterval0 = ParamUtil.getInteger(request, "yearlyInterval0", 1);
if ((event.getRepeating()) && (recurrence != null)) {
	yearlyInterval0 = recurrence.getInterval();
}

int yearlyPos = ParamUtil.getInteger(request, "yearlyPos", 1);
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getByMonth() != null) {
		yearlyPos = recurrence.getByMonth()[0];
	}
	else if (recurrence.getByDay() != null) {
		yearlyPos = recurrence.getByDay()[0].getDayPosition();
	}
}

int yearlyDay1 = ParamUtil.getInteger(request, "yearlyDay1", Calendar.SUNDAY);
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getByMonth() != null) {
		yearlyDay1 = -1;
	}
	else if (recurrence.getByDay() != null) {
		yearlyDay1 = recurrence.getByDay()[0].getDayOfWeek();
	}
}

int yearlyMonth1 = ParamUtil.getInteger(request, "yearlyMonth1", Calendar.JANUARY);
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getByMonth() != null) {
		yearlyMonth1 = recurrence.getByMonth()[0];
	}
}

int yearlyInterval1 = ParamUtil.getInteger(request, "yearlyInterval1", 1);
if ((event.getRepeating()) && (recurrence != null)) {
	yearlyInterval1 = recurrence.getInterval();
}

int endDateType = ParamUtil.getInteger(request, "endDateType");
if ((event.getRepeating()) && (recurrence != null)) {
	if (recurrence.getUntil() != null) {
		endDateType = 2;
	}
	else if (recurrence.getOccurrence() > 0) {
		endDateType = 1;
	}
}
%>

<liferay-util:include page="/html/portlet/calendar/tabs1.jsp">
	<liferay-util:param name="tabs1" value="events" />
</liferay-util:include>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "date-and-time") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<c:choose>
			<c:when test="<%= event.isTimeZoneSensitive() %>">
				<%= dateFormatDate.format(Time.getDate(event.getStartDate(), timeZone)) %>
			</c:when>
			<c:otherwise>
				<%= dateFormatDate.format(event.getStartDate()) %>
			</c:otherwise>
		</c:choose>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "duration") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>

		<%
		boolean allDay = CalUtil.isAllDay(event, timeZone, locale);
		%>

		<c:choose>
			<c:when test="<%= allDay %>">
				<%= LanguageUtil.get(pageContext, "all-day") %>:
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

		<c:if test="<%= allDay %>">
			<%= LanguageUtil.get(pageContext, "all-day") %>
		</c:if>

		<c:if test="<%= event.isTimeZoneSensitive() %>">
			(<%= LanguageUtil.get(pageContext, "time-zone-sensitive") %>)
		</c:if>
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "title") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<%= event.getTitle() %>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "description") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<%= event.getDescription() %>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "type") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, event.getType()) %>
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>

<c:if test="<%= (recurrenceType == Recurrence.DAILY) %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "repeat-daily") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<c:if test="<%= (dailyType == 0) %>">
				<%= dailyInterval %> <%= LanguageUtil.get(pageContext, "day-s") %>
			</c:if>

			<c:if test="<%= (dailyType == 1) %>">
				<%= LanguageUtil.get(pageContext, "every-weekday") %>
			</c:if>
		</td>
	</tr>
</c:if>

<c:if test="<%= (recurrenceType == Recurrence.WEEKLY) %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "repeat-weekly") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= LanguageUtil.get(pageContext, "recur-every") %> <%= dailyInterval %> <%= LanguageUtil.get(pageContext, "weeks-on") %>

			<%= weeklyPosSu ? (days[0] + ",") : "" %>
			<%= weeklyPosMo ? (days[1] + ",") : "" %>
			<%= weeklyPosTu ? (days[2] + ",") : "" %>
			<%= weeklyPosWe ? (days[3] + ",") : "" %>
			<%= weeklyPosTh ? (days[4] + ",") : "" %>
			<%= weeklyPosFr ? (days[5] + ",") : "" %>
			<%= weeklyPosSa ? days[6] : "" %>
		</td>
	</tr>
</c:if>

<c:if test="<%= (recurrenceType == Recurrence.MONTHLY) %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "repeat-monthly") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<c:if test="<%= (monthlyType == 0) %>">
				<%= LanguageUtil.get(pageContext, "day") %> <%= monthlyDay0 %> <%= LanguageUtil.get(pageContext, "of-every") %> <%= monthlyInterval0 %> <%= LanguageUtil.get(pageContext, "month-s") %>
			</c:if>

			<c:if test="<%= (monthlyType == 1) %>">
				<%= LanguageUtil.get(pageContext, "the") %>

				<%= (monthlyPos == 1) ? LanguageUtil.get(pageContext, "first") : "" %>
				<%= (monthlyPos == 2) ? LanguageUtil.get(pageContext, "second") : "" %>
				<%= (monthlyPos == 3) ? LanguageUtil.get(pageContext, "third") : "" %>
				<%= (monthlyPos == 4) ? LanguageUtil.get(pageContext, "fourth") : "" %>
				<%= (monthlyPos == -1) ? LanguageUtil.get(pageContext, "last") : "" %>

				<%= (monthlyDay1 == Calendar.MONDAY) ? LanguageUtil.get(pageContext, "weekday") : "" %>
				<%= (monthlyDay1 == Calendar.SATURDAY) ? LanguageUtil.get(pageContext, "weekend-day") : "" %>
				<%= (monthlyDay1 == Calendar.SUNDAY) ? days[0] : "" %>
				<%= (monthlyDay1 == Calendar.MONDAY) ? days[1] : "" %>
				<%= (monthlyDay1 == Calendar.TUESDAY) ? days[2] : "" %>
				<%= (monthlyDay1 == Calendar.WEDNESDAY) ? days[3] : "" %>
				<%= (monthlyDay1 == Calendar.THURSDAY) ? days[4] : "" %>
				<%= (monthlyDay1 == Calendar.FRIDAY) ? days[5] : "" %>
				<%= (monthlyDay1 == Calendar.SATURDAY) ? days[6] : "" %>

				<%= LanguageUtil.get(pageContext, "of-every") %> <%= monthlyInterval1 %> <%= LanguageUtil.get(pageContext, "month-s") %>
			</c:if>
		</td>
	</tr>
</c:if>

<c:if test="<%= (recurrenceType == Recurrence.YEARLY) %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "repeat-yearly") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<c:if test="<%= (yearlyType == 0) %>">
				<%= LanguageUtil.get(pageContext, "every") %> <%= months[yearlyMonth0] %> <%= LanguageUtil.get(pageContext, "of-every") %> <%= yearlyInterval0 %> <%= LanguageUtil.get(pageContext, "year-s") %>
			</c:if>

			<c:if test="<%= (yearlyType == 1) %>">
				<%= LanguageUtil.get(pageContext, "the") %>

				<%= (yearlyPos == 1) ? LanguageUtil.get(pageContext, "first") : "" %>
				<%= (yearlyPos == 2) ? LanguageUtil.get(pageContext, "second") : "" %>
				<%= (yearlyPos == 3) ? LanguageUtil.get(pageContext, "third") : "" %>
				<%= (yearlyPos == 4) ? LanguageUtil.get(pageContext, "fourth") : "" %>
				<%= (yearlyPos == -1) ? LanguageUtil.get(pageContext, "last") : "" %>

				<%= (yearlyDay1 == Calendar.MONDAY) ? LanguageUtil.get(pageContext, "weekday") : "" %>
				<%= (yearlyDay1 == Calendar.SATURDAY) ? LanguageUtil.get(pageContext, "weekend-day") : "" %>
				<%= (yearlyDay1 == Calendar.SUNDAY) ? days[0] : "" %>
				<%= (yearlyDay1 == Calendar.MONDAY) ? days[1] : "" %>
				<%= (yearlyDay1 == Calendar.TUESDAY) ? days[2] : "" %>
				<%= (yearlyDay1 == Calendar.WEDNESDAY) ? days[3] : "" %>
				<%= (yearlyDay1 == Calendar.THURSDAY) ? days[4] : "" %>
				<%= (yearlyDay1 == Calendar.FRIDAY) ? days[5] : "" %>
				<%= (yearlyDay1 == Calendar.SATURDAY) ? days[6] : "" %>

				<%= LanguageUtil.get(pageContext, "of") %> <%= months[yearlyMonth1] %> <%= LanguageUtil.get(pageContext, "of-every") %> <%= yearlyInterval1 %> <%= LanguageUtil.get(pageContext, "year-s") %>
			</c:if>
		</td>
	</tr>
</c:if>

<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "end-date") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<c:if test="<%= (endDateType == 0) %>">
			<%= LanguageUtil.get(pageContext, "none") %>
		</c:if>

		<c:if test="<%= (endDateType == 2) %>">
			<%= event.isTimeZoneSensitive() ? dateFormatDate.format(Time.getDate(event.getEndDate(), timeZone)) : dateFormatDate.format(event.getEndDate()) %>
		</c:if>
	</td>
</tr>
</table>

<%!
private boolean _getWeeklyDayPos(HttpServletRequest req, int day, CalEvent event, Recurrence recurrence) {
	boolean weeklyPos = ParamUtil.getBoolean(req, "weeklyDayPos" + day);

	String weeklyPosParam = ParamUtil.getString(req, "weeklyDayPos" + day);

	if (Validator.isNull(weeklyPosParam) && (event != null)) {
		if ((event.getRepeating()) && (recurrence != null)) {
			DayAndPosition[] dayPositions = recurrence.getByDay();

			if (dayPositions != null) {
				for (int i = 0; i < dayPositions.length; i++) {
					if (dayPositions[i].getDayOfWeek() == day) {
						return true;
					}
				}
			}
		}
	}

	return weeklyPos;
}
%>
