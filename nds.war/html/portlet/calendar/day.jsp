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
%>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>

				<%
				cal.add(Calendar.DATE, -1);
				%>

				<a href="<%= portletURL.toString() %>&<portlet:namespace />month=<%= cal.get(Calendar.MONTH) %>&<portlet:namespace />day=<%= cal.get(Calendar.DATE) %>&<portlet:namespace />year=<%= cal.get(Calendar.YEAR) %>&<portlet:namespace />eventType=<%= eventType %>">
				<img border="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_left.gif">
				</a>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>

				<%
				cal.add(Calendar.DATE, 1);
				%>

				<b><%= dateFormatDate.format(Time.getDate(cal)) %></b>
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

<%@ include file="/html/portlet/calendar/event_iterator.jsp" %>
