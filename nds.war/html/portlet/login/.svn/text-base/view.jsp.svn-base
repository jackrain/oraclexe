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

<%@ include file="/html/portlet/login/init.jsp" %>

<c:choose>
	<c:when test="<%= themeDisplay.isSignedIn() %>">

		<%
		String signedInAs = user.getFullName();

		if (themeDisplay.isShowMyAccountIcon()) {
			signedInAs = "<a href=\"" + themeDisplay.getURLMyAccount().toString() + "\">" + signedInAs + "</a>";
		}
		%>

		<%= LanguageUtil.format(pageContext, "you-are-signed-in-as-x", signedInAs) %>
		<%@ include file="/html/portlet/login/login-ext.jsp" %>
	</c:when>
	<c:otherwise>

		<%
		String login = LoginAction.getLogin(request, "login", company);
		String password = StringPool.BLANK;
		boolean rememberMe = ParamUtil.getBoolean(request, "rememberMe");
		%>

		<form action="<portlet:actionURL><portlet:param name="struts_action" value="/login/view" /><portlet:param name="<%= Constants.CMD %>" value="<%= Constants.UPDATE %>" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm">
		<input name="<portlet:namespace />rememberMe" type="hidden" value="<%= rememberMe %>">

		<liferay-ui:error exception="<%= AuthException.class %>" message="authentication-failed" />
		<liferay-ui:error exception="<%= CookieNotSupportedException.class %>" message="authentication-failed-please-enable-browser-cookies" />
		<liferay-ui:error exception="<%= NoSuchUserException.class %>" message="please-enter-a-valid-login" />
		<liferay-ui:error exception="<%= UserEmailAddressException.class %>" message="please-enter-a-valid-login" />
		<liferay-ui:error exception="<%= UserPasswordException.class %>" message="please-enter-a-valid-password" />

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "login") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input class="form-text" name="<portlet:namespace />login" style="width: 120px;" type="text" value="<%= login %>">
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "password") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input class="form-text" name="<portlet:namespace />password" style="width: 120px;" type="password" value="<%= password %>">
			</td>
		</tr>

		<c:if test="<%= company.isAutoLogin() && !request.isSecure() %>">
			<tr>
				<td>
					<span style="font-size: xx-small;">
					<%= LanguageUtil.get(pageContext, "remember-me") %>
					</span>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<input <%= rememberMe ? "checked" : "" %> type="checkbox"
						onClick="
							if (this.checked) {
								document.<portlet:namespace />fm.<portlet:namespace />rememberMe.value = 'on';
							}
							else {
								document.<portlet:namespace />fm.<portlet:namespace />rememberMe.value = 'off';
							}"
					>
				</td>
			</tr>
		</c:if>

		</table>

		<br>

		<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "sign-in") %>">

		<c:if test="<%= company.isStrangers() %>">
			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "create-account") %>' onClick="self.location = '<%= themeDisplay.getURLCreateAccount() %>';">
		</c:if>

		<c:if test="<%= company.isSendPassword() %>">
			<br><br>

			<a href="<%= themeDisplay.getPathMain() %>/portal/login?tabs1=forgot-password" style="font-size: xx-small;">
			<%= LanguageUtil.get(pageContext, "forgot-password") %>?
			</a>
		</c:if>

		</form>

		<script type="text/javascript">
			document.<portlet:namespace />fm.<portlet:namespace />login.focus();
		</script>
	</c:otherwise>
</c:choose>
