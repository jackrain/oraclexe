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

<liferay-ui:tabs
	names="live-sessions,authentication,default-associations,reserved-users,mail-host-names,emails"
	param="tabs2"
	url="<%= portletURL.toString() %>"
/>

<c:choose>
	<c:when test='<%= tabs2.equals("authentication") %>'>
		<liferay-ui:tabs
			names="general,ldap"
			param="tabs3"
			url="<%= portletURL.toString() %>"
		/>

		<liferay-ui:error key="ldapAuthentication" message="failed-to-bind-to-the-ldap-server-with-given-values" />

		<c:choose>
			<c:when test='<%= tabs3.equals("ldap") %>'>
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "enabled") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<liferay-ui:input-checkbox param="enabled" defaultValue='<%= ParamUtil.getBoolean(request, "enabled", PrefsPropsUtil.getBoolean(company.getCompanyId(), PropsUtil.AUTH_IMPL_LDAP_ENABLED)) %>' />
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "required") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<liferay-ui:input-checkbox param="required" defaultValue='<%= ParamUtil.getBoolean(request, "required", PrefsPropsUtil.getBoolean(company.getCompanyId(), PropsUtil.AUTH_IMPL_LDAP_REQUIRED)) %>' />
					</td>
				</tr>
				</table>

				<br>

				<%= LanguageUtil.get(pageContext, "the-ldap-url-format-is") %>

				<br><br>

				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "base-provider-url") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<input class="form-text" name="<portlet:namespace />baseProviderURL" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value='<%= ParamUtil.getString(request, "baseProviderURL", PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.AUTH_IMPL_LDAP_BASE_PROVIDER_URL)) %>'>
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "base-dn") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<input class="form-text" name="<portlet:namespace />baseDN" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value='<%= ParamUtil.getString(request, "baseDN", PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.AUTH_IMPL_LDAP_BASE_DN)) %>'>
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "principal") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<input class="form-text" name="<portlet:namespace />principal" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value='<%= ParamUtil.getString(request, "principal", PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.AUTH_IMPL_LDAP_SECURITY_PRINCIPAL)) %>'>
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "credentials") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<input class="form-text" name="<portlet:namespace />credentials" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="password" value='<%= ParamUtil.getString(request, "credentials", PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.AUTH_IMPL_LDAP_SECURITY_CREDENTIALS)) %>'>
					</td>
				</tr>
				</table>

				<br>

				<%= LanguageUtil.get(pageContext, "enter-the-search-filter-that-will-be-used-to-test-the-validity-of-a-user") %>

				<br><br>

				<textarea class="form-text" name="<portlet:namespace />searchFilter" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;"><%= ParamUtil.getString(request, "searchFilter", PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.AUTH_IMPL_LDAP_SEARCH_FILTER)) %></textarea>

				<br><br>

				<%= LanguageUtil.get(pageContext, "enter-the-encryption-algorithm-used-for-passwords-stored-in-the-ldap-server") %>

				<br><br>

				<select name="<portlet:namespace />passwordEncryptionAlgorithm">
					<option value=""></option>

					<%
					String passwordEncryptionAlgorithm = PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.AUTH_IMPL_LDAP_PASSWORD_ENCRYPTION_ALGORITHM);

					String[] algorithmTypes = PropsUtil.getArray(PropsUtil.AUTH_IMPL_LDAP_PASSWORD_ENCRYPTION_ALGORITHM_TYPES);

					for (int i = 0; i < algorithmTypes.length; i++) {
					%>

						<option <%= passwordEncryptionAlgorithm.equals(algorithmTypes[i]) ? "selected" : "" %> value="<%= algorithmTypes[i] %>"><%= algorithmTypes[i] %></option>

					<%
					}
					%>

				</select>

				<br><br>

				<%= LanguageUtil.get(pageContext, "if-the-user-is-valid-and-the-user-exists-in-the-ldap-server-but-not-in-liferay") %>

				<br><br>

				<textarea class="form-text" name="<portlet:namespace />userMappings" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;"><%= ParamUtil.getString(request, "userMappings", PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.AUTH_IMPL_LDAP_USER_MAPPINGS)) %></textarea>

				<br><br>

				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<select name="<portlet:namespace />defaultLdap">
							<option></option>
							<option>Apache Directory Server</option>
							<option>Microsoft Active Directory Server</option>
							<option>Novell eDirectory</option>
						</select>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "reset-values") %>' onClick="<portlet:namespace />updateDefaultLdap();">
					</td>
				</tr>
				</table>

				<br>

				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveUsers('updateLdap');">
			</c:when>
			<c:otherwise>
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "how-do-users-authenticate") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<select name="<portlet:namespace />authType">
							<option <%= company.getAuthType().equals(CompanyImpl.AUTH_TYPE_EA) ? "selected" : "" %> value="<%= CompanyImpl.AUTH_TYPE_EA %>"><%= LanguageUtil.get(pageContext, "by-email-address") %></option>
							<option <%= company.getAuthType().equals(CompanyImpl.AUTH_TYPE_ID) ? "selected" : "" %> value="<%= CompanyImpl.AUTH_TYPE_ID %>"><%= LanguageUtil.get(pageContext, "by-user-id") %></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "allow-users-to-automatically-login") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<liferay-ui:input-select param="autoLogin" defaultValue="<%= company.isAutoLogin() %>" />
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "allow-users-to-request-forgotten-passwords") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<liferay-ui:input-select param="sendPassword" defaultValue="<%= company.isSendPassword() %>" />
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "allow-strangers-to-create-accounts") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<liferay-ui:input-select param="strangers" defaultValue="<%= company.isStrangers() %>" />
					</td>
				</tr>
				</table>

				<br>

				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveUsers('updateSecurity');">
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test='<%= tabs2.equals("default-associations") %>'>
		<%= LanguageUtil.get(pageContext, "enter-the-default-community-names-per-line-that-are-associated-with-newly-created-users") %>

		<br><br>

		<textarea class="form-text" name="<portlet:namespace />defaultGroupNames" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;"><%= PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.ADMIN_DEFAULT_GROUP_NAMES) %></textarea>

		<br><br>

		<%= LanguageUtil.get(pageContext, "enter-the-default-role-names-per-line-that-are-associated-with-newly-created-users") %>

		<br><br>

		<textarea class="form-text" name="<portlet:namespace />defaultRoleNames" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;"><%= PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.ADMIN_DEFAULT_ROLE_NAMES) %></textarea>

		<br><br>

		<%= LanguageUtil.get(pageContext, "enter-the-default-user-group-names-per-line-that-are-associated-with-newly-created-users") %>

		<br><br>

		<textarea class="form-text" name="<portlet:namespace />defaultUserGroupNames" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;"><%= PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.ADMIN_DEFAULT_USER_GROUP_NAMES) %></textarea>

		<br><br>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveUsers('updateDefaultGroupsAndRoles');">
	</c:when>
	<c:when test='<%= tabs2.equals("reserved-users") %>'>
		<%= LanguageUtil.get(pageContext, "enter-one-user-id-per-line-to-reserve-the-user-id") %>

		<br><br>

		<textarea class="form-text" name="<portlet:namespace />reservedUserIds" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;"><%= PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.ADMIN_RESERVED_USER_IDS) %></textarea>

		<br><br>

		<%= LanguageUtil.get(pageContext, "enter-one-user-email-address-per-line-to-reserve-the-user-email-address") %>

		<br><br>

		<textarea class="form-text" name="<portlet:namespace />reservedEmailAddresses" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;"><%= PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.ADMIN_RESERVED_EMAIL_ADDRESSES) %></textarea>

		<br><br>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveUsers('updateReservedUsers');">
	</c:when>
	<c:when test='<%= tabs2.equals("mail-host-names") %>'>
		<%= LanguageUtil.format(pageContext, "enter-one-mail-host-name-per-line-for-all-additional-mail-host-names-besides-x", company.getMx(), false) %>

		<br><br>

		<textarea class="form-text" name="<portlet:namespace />mailHostNames" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;"><%= PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.ADMIN_MAIL_HOST_NAMES) %></textarea>

		<br><br>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveUsers('updateMailHostNames');">
	</c:when>
	<c:when test='<%= tabs2.equals("emails") %>'>
		<script type="text/javascript">

			<%
			String emailFromName = ParamUtil.getString(request, "emailFromName", PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.ADMIN_EMAIL_FROM_NAME));
			String emailFromAddress = ParamUtil.getString(request, "emailFromAddress", PrefsPropsUtil.getString(company.getCompanyId(), PropsUtil.ADMIN_EMAIL_FROM_ADDRESS));

			String emailUserAddedSubject = ParamUtil.getString(request, "emailUserAddedSubject", PrefsPropsUtil.getContent(company.getCompanyId(), PropsUtil.ADMIN_EMAIL_USER_ADDED_SUBJECT));
			String emailUserAddedBody = ParamUtil.getString(request, "emailUserAddedBody", PrefsPropsUtil.getContent(company.getCompanyId(), PropsUtil.ADMIN_EMAIL_USER_ADDED_BODY));

			String emailPasswordSentSubject = ParamUtil.getString(request, "emailPasswordSentSubject", PrefsPropsUtil.getContent(company.getCompanyId(), PropsUtil.ADMIN_EMAIL_PASSWORD_SENT_SUBJECT));
			String emailPasswordSentBody = ParamUtil.getString(request, "emailPasswordSentBody", PrefsPropsUtil.getContent(company.getCompanyId(), PropsUtil.ADMIN_EMAIL_PASSWORD_SENT_BODY));

			String editorParam = "";
			String editorContent = "";

			if (tabs3.equals("user-added-email")) {
				editorParam = "emailUserAddedBody";
				editorContent = emailUserAddedBody;
			}
			else if (tabs3.equals("password-sent-email")) {
				editorParam = "emailPasswordSentBody";
				editorContent = emailPasswordSentBody;
			}
			%>

			function initEditor() {
				return "<%= UnicodeFormatter.toString(editorContent) %>";
			}

			function <portlet:namespace />saveEmails() {
				document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "updateEmails";

				<c:if test='<%= tabs3.endsWith("-email") %>'>
					document.<portlet:namespace />fm.<portlet:namespace /><%= editorParam %>.value = parent.<portlet:namespace />editor.getHTML();
				</c:if>

				submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/admin/edit_users" /></portlet:actionURL>");
			}
		</script>

		<liferay-ui:tabs
			names="email-from,user-added-email,password-sent-email"
			param="tabs3"
			url="<%= portletURL.toString() %>"
		/>

		<liferay-ui:error key="emailFromAddress" message="please-enter-a-valid-email-address" />
		<liferay-ui:error key="emailFromName" message="please-enter-a-valid-name" />
		<liferay-ui:error key="emailPasswordSentBody" message="please-enter-a-valid-body" />
		<liferay-ui:error key="emailPasswordSentSubject" message="please-enter-a-valid-subject" />
		<liferay-ui:error key="emailUserAddedBody" message="please-enter-a-valid-body" />
		<liferay-ui:error key="emailUserAddedSubject" message="please-enter-a-valid-subject" />

		<c:choose>
			<c:when test='<%= tabs3.endsWith("-email") %>'>
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "enabled") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<c:choose>
							<c:when test='<%= tabs3.equals("user-added-email") %>'>
								<liferay-ui:input-checkbox param="emailUserAddedEnabled" defaultValue="<%= PrefsPropsUtil.getBoolean(company.getCompanyId(), PropsUtil.ADMIN_EMAIL_USER_ADDED_ENABLED) %>" />
							</c:when>
							<c:when test='<%= tabs3.equals("password-sent-email") %>'>
								<liferay-ui:input-checkbox param="emailPasswordSentEnabled" defaultValue="<%= PrefsPropsUtil.getBoolean(company.getCompanyId(), PropsUtil.ADMIN_EMAIL_PASSWORD_SENT_ENABLED) %>" />
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<br>
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "subject") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<c:choose>
							<c:when test='<%= tabs3.equals("user-added-email") %>'>
								<input class="form-text" name="<portlet:namespace />emailUserAddedSubject" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= emailUserAddedSubject %>">
							</c:when>
							<c:when test='<%= tabs3.equals("password-sent-email") %>'>
								<input class="form-text" name="<portlet:namespace />emailPasswordSentSubject" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= emailPasswordSentSubject %>">
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<br>
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "body") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<liferay-ui:input-editor editorImpl="<%= EDITOR_WYSIWYG_IMPL_KEY %>" />

						<input name="<portlet:namespace /><%= editorParam %>" type="hidden" value="">
					</td>
				</tr>
				</table>

				<br>

				<b><%= LanguageUtil.get(pageContext, "definition-of-terms") %></b>

				<br><br>

				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<b>[$FROM_ADDRESS$]</b>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<%= emailFromAddress %>
					</td>
				</tr>
				<tr>
					<td>
						<b>[$FROM_NAME$]</b>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<%= emailFromName %>
					</td>
				</tr>
				<tr>
					<td>
						<b>[$PORTAL_URL$]</b>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<%= company.getPortalURL() %>
					</td>
				</tr>

				<c:if test='<%= tabs3.equals("password-sent-email") %>'>
					<tr>
						<td>
							<b>[$REMOTE_ADDRESS$]</b>
						</td>
						<td style="padding-left: 10px;"></td>
						<td>
							The browser's remote address
						</td>
					</tr>
					<tr>
						<td>
							<b>[$REMOTE_HOST$]</b>
						</td>
						<td style="padding-left: 10px;"></td>
						<td>
							The browser's remote host
						</td>
					</tr>
				</c:if>

				<tr>
					<td>
						<b>[$TO_ADDRESS$]</b>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						The address of the email recipient
					</td>
				</tr>
				<tr>
					<td>
						<b>[$TO_NAME$]</b>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						The name of the email recipient
					</td>
				</tr>

				<c:if test='<%= tabs3.equals("password-sent-email") %>'>
					<tr>
						<td>
							<b>[$USER_AGENT$]</b>
						</td>
						<td style="padding-left: 10px;"></td>
						<td>
							The browser's user agent
						</td>
					</tr>
				</c:if>

				<tr>
					<td>
						<b>[$USER_ID$]</b>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						The user ID
					</td>
				</tr>
				<tr>
					<td>
						<b>[$USER_PASSWORD$]</b>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						The user password
					</td>
				</tr>
				</table>
			</c:when>
			<c:otherwise>
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "name") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<input class="form-text" name="<portlet:namespace />emailFromName" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= emailFromName %>">
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "address") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<input class="form-text" name="<portlet:namespace />emailFromAddress" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= emailFromAddress %>">
					</td>
				</tr>
				</table>
			</c:otherwise>
		</c:choose>

		<br>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveEmails();">
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="<%= GetterUtil.getBoolean(PropsUtil.get(PropsUtil.SESSION_TRACKER_MEMORY_ENABLED)) %>">

				<%
				SearchContainer searchContainer = new SearchContainer();

				List headerNames = new ArrayList();

				headerNames.add("session-id");
				headerNames.add("user-id");
				headerNames.add("name");
				headerNames.add("email-address");
				headerNames.add("last-request");
				headerNames.add("num-of-hits");

				searchContainer.setHeaderNames(headerNames);

				Map currentUsers = (Map)WebAppPool.get(company.getCompanyId(), WebKeys.CURRENT_USERS);

				Map.Entry[] currentUsersArray = (Map.Entry[])currentUsers.entrySet().toArray(new Map.Entry[0]);

				List results = new ArrayList();

				for (int i = 0; i < currentUsersArray.length; i++) {
					Map.Entry mapEntry = currentUsersArray[i];

					results.add(mapEntry.getValue());
				}

				Collections.sort(results, new UserTrackerModifiedDateComparator());

				List resultRows = searchContainer.getResultRows();

				for (int i = 0; i < results.size(); i++) {
					UserTracker userTracker = (UserTracker)results.get(i);

					ResultRow row = new ResultRow(userTracker, userTracker.getPrimaryKey().toString(), i);

					PortletURL rowURL = renderResponse.createRenderURL();

					rowURL.setWindowState(WindowState.MAXIMIZED);

					rowURL.setParameter("struts_action", "/admin/edit_session");
					rowURL.setParameter("redirect", currentURL);
					rowURL.setParameter("userTrackerId", userTracker.getUserTrackerId());

					User user2 = null;

					try {
						user2 = UserLocalServiceUtil.getUserById(userTracker.getUserId());
					}
					catch (NoSuchUserException nsue) {
					}

					// Session ID

					row.addText(userTracker.getUserTrackerId(), rowURL);

					// User ID

					row.addText(userTracker.getUserId(), rowURL);

					// Name

					row.addText(((user2 != null) ? user2.getFullName() : LanguageUtil.get(pageContext, "not-available")), rowURL);

					// Email Address

					row.addText(((user2 != null) ? user2.getEmailAddress() : LanguageUtil.get(pageContext, "not-available")), rowURL);

					// Last Request

					row.addText(dateFormatDateTime.format(userTracker.getModifiedDate()), rowURL);

					// # of Hits

					row.addText(String.valueOf(userTracker.getHits()), rowURL);

					// Add result row

					resultRows.add(row);
				}
				%>

				<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />
			</c:when>
			<c:otherwise>
				<%= LanguageUtil.format(pageContext, "display-of-live-session-data-is-disabled", PropsUtil.SESSION_TRACKER_MEMORY_ENABLED) %>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>

<%!
public static final String EDITOR_WYSIWYG_IMPL_KEY = "editor.wysiwyg.portal-web.docroot.html.portlet.admin.users.jsp";
%>
