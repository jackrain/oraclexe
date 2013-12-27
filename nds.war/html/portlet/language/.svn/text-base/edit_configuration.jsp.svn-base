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

<%@ include file="/html/portlet/language/init.jsp" %>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "display-style") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />displayStyle">
			<option <%= (displayStyle == LanguageTag.LIST_ICON) ? "selected" : "" %> value="<%= LanguageTag.LIST_ICON %>"><%= LanguageUtil.get(pageContext, "icon") %></option>
			<option <%= (displayStyle == LanguageTag.LIST_LONG_TEXT) ? "selected" : "" %> value="<%= LanguageTag.LIST_LONG_TEXT %>"><%= LanguageUtil.get(pageContext, "long-text") %></option>
			<option <%= (displayStyle == LanguageTag.LIST_SHORT_TEXT) ? "selected" : "" %> value="<%= LanguageTag.LIST_SHORT_TEXT %>"><%= LanguageUtil.get(pageContext, "short-text") %></option>
			<option <%= (displayStyle == LanguageTag.SELECT_BOX) ? "selected" : "" %> value="<%= LanguageTag.SELECT_BOX %>"><%= LanguageUtil.get(pageContext, "select-box") %></option>
		</select>
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">

</form>
