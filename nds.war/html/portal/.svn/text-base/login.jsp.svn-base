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

<%
String tabs1 = ParamUtil.getString(request, "tabs1", "already-registered");

String tabs1Names = StringPool.BLANK;

if (company.isSendPassword() || company.isStrangers()) {
	tabs1Names = "already-registered";
}

if (company.isSendPassword()) {
	tabs1Names += ",forgot-password";
}

if (company.isStrangers()) {
	tabs1Names += ",create-account";
}

PortletURL createAccountURL = themeDisplay.getURLCreateAccount();
%>

<liferay-ui:tabs
	names="<%= tabs1Names %>"
	url2="<%= createAccountURL.toString() %>"
	refresh="<%= false %>"
>
	<liferay-ui:section>
		<form action="<%= themeDisplay.getPathMain() %>/portal/login" method="post" name="fm1">
		<input name="<%= Constants.CMD %>" type="hidden" value="already-registered">
		<input name="<%= sectionParam %>" type="hidden" value="already-registered">

		<c:if test="<%= sectionSelected.booleanValue() %>">
			<c:if test='<%= SessionMessages.contains(request, "user_added") %>'>

				<%
				String emailAddress = (String)SessionMessages.get(request, "user_added");
				String password = (String)SessionMessages.get(request, "user_added_password");
				%>

				<span class="portlet-msg-success" style="font-size: xx-small;">

				<c:choose>
					<c:when test="<%= Validator.isNull(password) %>">
						<%= LanguageUtil.format(pageContext, "thank-you-for-creating-an-account-your-password-has-been-sent-to-x", emailAddress) %>
					</c:when>
					<c:otherwise>
						<%= LanguageUtil.format(pageContext, "thank-you-for-creating-an-account-your-password-is-x", new Object[] {password, emailAddress}) %>
					</c:otherwise>
				</c:choose>

				</span>

				<br><br>

				<%
				%>

			</c:if>

			<c:if test="<%= SessionErrors.contains(request, AuthException.class.getName()) %>">
				<span class="portlet-msg-error" style="font-size: xx-small;">
				<%= LanguageUtil.get(pageContext, "authentication-failed") %>
				</span>

				<br><br>
			</c:if>

			<c:if test="<%= SessionErrors.contains(request, CookieNotSupportedException.class.getName()) %>">
				<span class="portlet-msg-error" style="font-size: xx-small;">
				<%= LanguageUtil.get(pageContext, "authentication-failed-please-enable-browser-cookies") %>
				</span>

				<br><br>
			</c:if>

			<c:if test="<%= SessionErrors.contains(request, NoSuchUserException.class.getName()) %>">
				<span class="portlet-msg-error" style="font-size: xx-small;">
				<%= LanguageUtil.get(pageContext, "please-enter-a-valid-login") %>
				</span>

				<br><br>
			</c:if>

			<c:if test="<%= SessionErrors.contains(request, PrincipalException.class.getName()) %>">
				<span class="portlet-msg-error" style="font-size: xx-small;">
				<%= LanguageUtil.get(pageContext, "you-have-attempted-to-access-a-section-of-the-site-that-requires-authentication") %>
				<%= LanguageUtil.get(pageContext, "please-sign-in-to-continue") %>
				</span>

				<br><br>
			</c:if>

			<c:if test='<%= SessionErrors.contains(request, UserEmailAddressException.class.getName()) %>'>
				<span class="portlet-msg-error" style="font-size: xx-small;">
				<%= LanguageUtil.get(pageContext, "please-enter-a-valid-login") %>
				</span>

				<br><br>
			</c:if>

			<c:if test="<%= SessionErrors.contains(request, UserPasswordException.class.getName()) %>">
				<span class="portlet-msg-error" style="font-size: xx-small;">
				<%= LanguageUtil.get(pageContext, "please-enter-a-valid-password") %>
				</span>

				<br><br>
			</c:if>
		</c:if>

		<%
		String login = LoginAction.getLogin(request, "login", company);
		String password = StringPool.BLANK;
		boolean rememberMe = ParamUtil.getBoolean(request, "rememberMe");
		%>

		<input name="rememberMe" type="hidden" value="<%= rememberMe %>">

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "login") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input class="form-text" name="login" style="width: 150px;" type="text" value="<%= login %>">
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "password") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input class="form-text" name="<%= SessionParameters.get(request, "password") %>" style="width: 150px" type="password" value="<%= password %>">
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
								document.fm1.rememberMe.value = 'on';
							}
							else {
								document.fm1.rememberMe.value = 'off';
							}"
					>
				</td>
			</tr>
		</c:if>

		</table>

		<br>

		<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "sign-in") %>">

		</form>
	</liferay-ui:section>
	<liferay-ui:section>
		<form action="<%= themeDisplay.getPathMain() %>/portal/login" method="post" name="fm2">
		<input name="<%= Constants.CMD %>" type="hidden" value="<%= sectionName %>">
		<input name="<%= sectionParam %>" type="hidden" value="<%= sectionName %>">

		<c:if test="<%= sectionSelected.booleanValue() %>">
			<c:if test='<%= SessionMessages.contains(request, "request_processed") %>'>
				<span class="portlet-msg-success" style="font-size: xx-small;">
				<%= LanguageUtil.get(pageContext, "your-request-processed-successfully") %>
				</span>

				<br><br>
			</c:if>

			<c:if test="<%= SessionErrors.contains(request, NoSuchUserException.class.getName()) %>">
				<span class="portlet-msg-error" style="font-size: xx-small;">
				<%= LanguageUtil.get(pageContext, "the-email-address-you-requested-is-not-registered-in-our-database") %>
				</span>

				<br><br>
			</c:if>

			<c:if test="<%= SessionErrors.contains(request, SendPasswordException.class.getName()) %>">
				<span class="portlet-msg-error" style="font-size: xx-small;">
				<%= LanguageUtil.get(pageContext, "your-password-can-only-be-sent-to-an-external-email-address") %>
				</span>

				<br><br>
			</c:if>

			<c:if test="<%= SessionErrors.contains(request, UserEmailAddressException.class.getName()) %>">
				<span class="portlet-msg-error" style="font-size: xx-small;">
				<%= LanguageUtil.get(pageContext, "please-enter-a-valid-email-address") %>
				</span>

				<br><br>
			</c:if>
		</c:if>

		<%
		String emailAddress = ParamUtil.getString(request, "emailAddress");
		%>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "email-address") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input class="form-text" name="emailAddress" size="30" type="text" value="<%= emailAddress %>">
			</td>
		</tr>
		</table>

		<br>

		<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "send-new-password") %>">

		</form>
	</liferay-ui:section>
</liferay-ui:tabs>

<script type="text/javascript">
	<c:choose>
		<c:when test='<%= tabs1.equals("already-registered") %>'>
			document.fm1.login.focus();
		</c:when>
		<c:when test='<%= tabs1.equals("forgot-password") %>'>
			document.fm2.emailAddress.focus();
		</c:when>
	</c:choose>
</script>
