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

<%@ include file="/html/portlet/mail/init.jsp" %>

<c:choose>
	<c:when test='<%= SessionMessages.contains(renderRequest, "user_name_registered") %>'>
		<%= LanguageUtil.format(pageContext, "your-new-email-address-is-x", "<b>" + user.getEmailAddress() + "</b>", false) %>

		<%= LanguageUtil.get(pageContext, "this-email-address-will-also-serve-as-your-login") %>

		<br><br>

		<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="portletURL" />

		<%= LanguageUtil.format(pageContext, "you-can-now-check-for-new-messages-in-your-x", "<a class=\"gamma\" href=\"" + portletURL.toString() + "\"><b>" + LanguageUtil.get(pageContext, "INBOX") + "</b></a>", false) %>
	</c:when>
	<c:otherwise>
		<form action="<portlet:actionURL><portlet:param name="struts_action" value="/mail/register" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">

		<liferay-ui:error exception="<%= DuplicateUserEmailAddressException.class %>" message="the-email-address-you-requested-is-already-taken" />
		<liferay-ui:error exception="<%= UserEmailAddressException.class %>" message="please-enter-a-valid-email-address" />

		<%= LanguageUtil.get(pageContext, "choose-a-user-name-for-your-personal-company-email-address") %>

		<br><br>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<input class="form-text" name="<portlet:namespace />userName" type="text">
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<b>@</b>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<b><%= company.getMx() %></b>
			</td>
		</tr>
		</table>

		<br>

		<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "register") %>'>

		</form>

		<script type="text/javascript">
			document.<portlet:namespace />fm.<portlet:namespace />userName.focus();
		</script>
	</c:otherwise>
</c:choose>

<%--
<c:if test="<%= SessionErrors.contains(renderRequest, DuplicateUserEmailAddressException.class.getName()) %>">
	<tr>
		<td colspan="5">
			<font class="portlet-msg-error" style="font-size: xx-small;"><%= LanguageUtil.get(pageContext, "the-email-address-you-requested-is-already-taken") %></font>
		</td>
	</tr>
	<tr>
		<td colspan="5"><img border="0" height="8" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="1"></td>
	</tr>
	</table>
</c:if>

<c:if test="<%= SessionErrors.contains(renderRequest, UserEmailAddressException.class.getName()) %>">
	<tr>
		<td colspan="5">
			<font class="portlet-msg-error" style="font-size: xx-small;"><%= LanguageUtil.get(pageContext, "please-enter-a-valid-email-address") %></font>
		</td>
	</tr>
	<tr>
		<td colspan="5"><img border="0" height="8" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="1"></td>
	</tr>
</c:if>
--%>
