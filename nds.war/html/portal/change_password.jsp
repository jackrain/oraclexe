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

<%@ include file="/html/portal/init.jsp" %>

<form action="<%= themeDisplay.getPathMain() %>/portal/change_password" method="post" name="fm" onSubmit="submitForm(document.fm); return false;">
<input name="doAsUserId" type="hidden" value="<%= themeDisplay.getDoAsUserId() %>">
<input name="<%= Constants.CMD %>" type="hidden" value="password">
<input name="<%= WebKeys.REFERER %>" type="hidden" value="<%= themeDisplay.getPathMain() %>/portal/layout?doAsUserId=<%= themeDisplay.getDoAsUserId() %>">
<input name="passwordReset" type="hidden" value="false">

<span class="portlet-msg-error">
<%= LanguageUtil.get(pageContext, "the-system-policy-requires-you-to-change-your-password-at-this-time") %>
</span>

<br><br>

<c:if test="<%= SessionErrors.contains(request, UserPasswordException.class.getName()) %>">

	<%
	UserPasswordException upe = (UserPasswordException)SessionErrors.get(request, UserPasswordException.class.getName());
	%>

	<span class="portlet-msg-error" style="font-size: xx-small;">

	<c:if test="<%= upe.getType() == UserPasswordException.PASSWORDS_DO_NOT_MATCH %>">
		<%= LanguageUtil.get(pageContext, "please-enter-matching-passwords") %>
	</c:if>

	<c:if test="<%= upe.getType() == UserPasswordException.PASSWORD_INVALID %>">
		<%= LanguageUtil.get(pageContext, "please-enter-a-valid-password") %>
	</c:if>

	<c:if test="<%= upe.getType() == UserPasswordException.PASSWORD_ALREADY_USED %>">
		<%= LanguageUtil.get(pageContext, "please-enter-a-password-that-has-not-already-been-used") %>
	</c:if>

	</span>

	<br><br>
</c:if>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "password") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="password1" size="30" type="password" value="">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "enter-again") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="password2" size="30" type="password" value="">
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "save") %>">

</form>

<script type="text/javascript">
	document.fm.password1.focus();
</script>
