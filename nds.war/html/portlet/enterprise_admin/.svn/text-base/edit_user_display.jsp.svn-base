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

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "language") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />languageId">

			<%
			Locale locale2 = user2.getLocale();

			Locale[] locales = LanguageUtil.getAvailableLocales();

			for (int i = 0; i < locales.length; i++) {
			%>

				<option <%= (locale2.getLanguage().equals(locales[i].getLanguage()) && locale2.getCountry().equals(locales[i].getCountry())) ? "selected" : "" %> value="<%= locales[i].getLanguage() + "_" + locales[i].getCountry() %>"><%= locales[i].getDisplayName(locales[i]) %></option>

			<%
			}
			%>

		</select>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "time-zone") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-time-zone name="timeZoneId" value="<%= user2.getTimeZone().getID() %>" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "greeting") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= User.class %>" bean="<%= user2 %>" field="greeting" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "resolution") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />resolution">
			<option <%= (user2.getResolution().equals(Resolution.S800X600_KEY)) ? "selected" : "" %> value="<%= Resolution.S800X600_KEY %>"><%= LanguageUtil.get(pageContext, "800-by-600-pixels") %></option>
			<option <%= (user2.getResolution().equals(Resolution.S1024X768_KEY)) ? "selected" : "" %> value="<%= Resolution.S1024X768_KEY %>"><%= LanguageUtil.get(pageContext, "1024-by-768-pixels") %></option>
			<option <%= (user2.getResolution().equals(Resolution.FULL_KEY)) ? "selected" : "" %> value="<%= Resolution.FULL_KEY %>"><%= LanguageUtil.get(pageContext, "full-screen") %></option>
		</select>
	</td>
</tr>
</table>

<c:if test="<%= editable %>">
	<br>

	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveUser('display');">
</c:if>

<br><br>
