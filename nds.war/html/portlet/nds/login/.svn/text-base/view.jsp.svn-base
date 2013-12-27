<%
/**
 * Copyright (c) 2000-2004 Liferay, LLC. All rights reserved.
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

<%@ include file="/html/portlet/my_account/init.jsp" %>

<%
String login = GetterUtil.getString(CookieUtil.get(request.getCookies(), CookieKeys.LOGIN));
if (Validator.isNull(login) && company.getAuthType().equals(Company.AUTH_TYPE_EA)) {
	login = "@" + company.getMx();
}
%>

<table border="0" cellpadding="4" cellspacing="0" width="100%">
<tr>
	<td align="center">
		<c:if test="<%= !signedIn %>">
			<table border="0" cellpadding="0" cellspacing="2">

			<form action="<%= CTX_PATH %>/portal<%= PortalUtil.getAuthorizedPath(request) %>/login" method="post" name="my_account_fm" target="_self">
			<input name="my_account_cmd" type="hidden" value="auth">

			<c:if test="<%= SessionMessages.contains(renderRequest, CreateUserAction.class.getName()) %>">
				<tr>
					<td colspan="5">
						<font class="bg" size="1"><span class="bg-pos-alert"><%= LanguageUtil.get(pageContext, "you-have-successfully-created-an-account") %></span></font>
					</td>
				</tr>
			</c:if>

			<tr>
				<td>
					<font class="gamma" size="2">

					<c:if test="<%= company.getAuthType().equals(Company.AUTH_TYPE_EA) %>">
						<%= LanguageUtil.get(pageContext, "email-address") %>
					</c:if>

					<c:if test="<%= company.getAuthType().equals(Company.AUTH_TYPE_ID) %>">
						<%= LanguageUtil.get(pageContext, "user-id") %>
					</c:if>

					</font>
				</td>
				<td width="10">
					&nbsp;
				</td>
				<td>
					<input class="form-text" name="my_account_login" size="15" tabindex="1" type="text" value="<%= login %>">
				</td>
				<td width="10">
					&nbsp;
				</td>
				<td>
					<c:if test="<%= company.isAutoLogin() && !request.isSecure() %>">
						<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<font class="gamma" size="1"><%= LanguageUtil.get(pageContext, "remember-me") %></font>
							</td>
							<td align="right">
								<input name="my_account_r_m" type="checkbox">
							</td>
						</tr>
						</table>
					</c:if>
				</td>
			</tr>
			<tr>
				<td>
					<font class="gamma" size="2"><%= LanguageUtil.get(pageContext, "password") %></font>
				</td>
				<td width="10">
					&nbsp;
				</td>
				<td>
					<input class="form-text" name="<%= SessionParameters.get(request, "my_account_password") %>" size="15" tabindex="2" type="password" value="" onKeyPress="if (event.keyCode == 13) { submitForm(document.my_account_fm); }">
				</td>
				<td width="10">
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					<font class="bg" size="2"><%= LanguageUtil.get(pageContext, "current_check_no") %></font>
				</td>
				<td width="10">
					&nbsp;
				</td>
				<td>
					<font class="bg" size="2"><b><%= nds.portal.auth.CheckNO.getInstance().currentValue() %></b></font>
				</td>
			</tr>
			<tr>
				<td colspan="5" align="center">
				<input tabindex="3" type="button" value="<%= LanguageUtil.get(pageContext, "sign-in") %>" onClick="submitForm(document.my_account_fm);">
				</td>
			<tr>
			<tr>
				<td align="center" colspan="5">
					<font class="gamma" size="1">

					<c:if test="<%= company.isStrangers() %>">
						<a class="gamma" href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/my_account/create_account" /></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "create-account") %></a>

						/
					</c:if>

					<!--<a class="gamma" href="<%= CTX_PATH %>/portal<%= PortalUtil.getAuthorizedPath(request) %>/login"><%= LanguageUtil.get(pageContext, "forgot-password") %>?</a>-->

					</font>
				</td>
			</tr>

			</form>

			</table>

			<script language="JavaScript">
				<c:if test="<%= Validator.isNotNull(login) %>">
					document.my_account_fm.<%= SessionParameters.get(request, "my_account_password") %>.focus();
				</c:if>

				<c:if test="<%= Validator.isNull(login) || (login.equals(\"@\" + company.getMx()) && company.getAuthType().equals(Company.AUTH_TYPE_EA)) %>">
					document.my_account_fm.my_account_login.focus();
				</c:if>
			</script>
		</c:if>

	</td>
</tr>
</table>
<c:if test="<%= signedIn %>">
<table border="0" cellpadding="4" cellspacing="0" width="100%">
<tr>
	<td align="left">
			<%= LanguageUtil.get(pageContext, "Hello") %>,<%=user.getFullName()%><br>
			<font class="bg" size="1">
				<%= LanguageUtil.get(pageContext, "last-login") %>
				<%
				if (user.getLoginDate() != null) {
					DateFormat loginDateFormat = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT, locale);
				%>
					<%= loginDateFormat.format(user.getLoginDate()) %>&nbsp;&nbsp;
					<%= user.getLoginIP() %><br>
				<%
				}
				else {
				%>
					Never<br>
				<%
				}
				%>
				</font>
				<font class="bg" size="1">
				<%= LanguageUtil.get(pageContext, "failed-login-attempts") %>
				<%= user.getFailedLoginAttempts() %><br>
				</font>			
	</td>
</tr>
</table>		
</c:if>

