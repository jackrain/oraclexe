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

<%@ include file="/html/portlet/sms/init.jsp" %>

<%
String to = ParamUtil.getString(request, "to");
String subject = ParamUtil.getString(request, "subject");
String message = ParamUtil.getString(request, "message");
%>

<form action="<portlet:actionURL />" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.SEND %>">

<liferay-ui:success key='<%= portletConfig.getPortletName() + ".send" %>' message="you-have-successfully-sent-a-sms-message" />

<liferay-ui:error key="to" message="please-enter-a-valid-email-address" />

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "to") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />to" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= to %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "subject") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />subject" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" onChange="document.<portlet:namespace />fm.<portlet:namespace />length.value = document.<portlet:namespace />fm.<portlet:namespace />subject.value.length + document.<portlet:namespace />fm.<portlet:namespace />message.value.length;" onKeyUp="document.<portlet:namespace />fm.<portlet:namespace />length.value = document.<portlet:namespace />fm.<portlet:namespace />subject.value.length + document.<portlet:namespace />fm.<portlet:namespace />message.value.length;" value="<%= subject %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "message") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<textarea class="form-text" name="<portlet:namespace />message" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;" wrap="soft" onChange="document.<portlet:namespace />fm.<portlet:namespace />length.value = document.<portlet:namespace />fm.<portlet:namespace />subject.value.length + document.<portlet:namespace />fm.<portlet:namespace />message.value.length;" onKeyUp="document.<portlet:namespace />fm.<portlet:namespace />length.value = document.<portlet:namespace />fm.<portlet:namespace />subject.value.length + document.<portlet:namespace />fm.<portlet:namespace />message.value.length;"><%= message %></textarea><br>
	</td>
</tr>
<tr>
	<td colspan="2"></td>
	<td>
		<input class="form-text" disabled maxlength="3" name="<portlet:namespace />length" size="3" type="text" value="<%= subject.length() + message.length() %>">

		<span style="font-size: xx-small;">(500 <%= LanguageUtil.get(pageContext, "characters-maximum") %>)</span>
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "send-text-message") %>">

</form>

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		document.<portlet:namespace />fm.<portlet:namespace />to.focus();
	</script>
</c:if>
