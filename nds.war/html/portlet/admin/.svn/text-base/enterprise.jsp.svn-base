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
User user2 = company.getDefaultUser();
%>

<liferay-ui:error exception="<%= AccountNameException.class %>" message="please-enter-a-valid-name" />
<liferay-ui:error exception="<%= CompanyHomeURLException.class %>" message="please-enter-a-valid-home-url" />
<liferay-ui:error exception="<%= CompanyPortalURLException.class %>" message="please-enter-a-valid-portal-url" />

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td valign="top">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "name") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Account.class %>" bean="<%= account %>" field="name" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "legal-name") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Account.class %>" bean="<%= account %>" field="legalName" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "legal-id") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Account.class %>" bean="<%= account %>" field="legalId" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "legal-type") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Account.class %>" bean="<%= account %>" field="legalType" />
			</td>
		</tr>
		</table>
	</td>
	<td style="padding-left: 30px;"></td>
	<td valign="top">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "sic-code") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Account.class %>" bean="<%= account %>" field="sicCode" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "ticker-symbol") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Account.class %>" bean="<%= account %>" field="tickerSymbol" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "industry") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Account.class %>" bean="<%= account %>" field="industry" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "type") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Account.class %>" bean="<%= account %>" field="type" />
			</td>
		</tr>
		</table>
	</td>
	<td style="padding-left: 30px;"></td>
	<td valign="top">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "portal-url") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Company.class %>" bean="<%= company %>" field="portalURL" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "home-url") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Company.class %>" bean="<%= company %>" field="homeURL" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "mail-domain") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Company.class %>" bean="<%= company %>" field="mx" disabled="<%= !GetterUtil.getBoolean(PropsUtil.get(PropsUtil.MAIL_MX_UPDATE)) %>" />
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveEnterprise('<%= Constants.UPDATE %>');">

<br><br>

<liferay-ui:tabs names="display" param="tabs2" />

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td valign="top">
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
	</td>
	<td style="padding-left: 30px;"></td>
	<td align="center" valign="top">
		<img src="<%= themeDisplay.getPathImage() %>/company_logo?img_id=<%= company.getCompanyId() %>"><br>

		<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/admin/edit_enterprise_logo" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>" style="font-size: xx-small;"><%= LanguageUtil.get(pageContext, "change") %></a>
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveEnterprise('display');">

<br><br>

<liferay-ui:tabs
	names="email-addresses,addresses,websites,phone-numbers"
	param="tabs3"
	refresh="<%= false %>"
>
	<liferay-ui:section>
		<liferay-util:include page="/html/portlet/enterprise_admin/email_address_iterator.jsp">
			<liferay-util:param name="editable" value="true" />
			<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
			<liferay-util:param name="className" value="<%= Account.class.getName() %>" />
			<liferay-util:param name="classPK" value="<%= account.getAccountId() %>" />
		</liferay-util:include>
	</liferay-ui:section>
	<liferay-ui:section>
		<liferay-util:include page="/html/portlet/enterprise_admin/address_iterator.jsp">
			<liferay-util:param name="editable" value="true" />
			<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
			<liferay-util:param name="className" value="<%= Account.class.getName() %>" />
			<liferay-util:param name="classPK" value="<%= account.getAccountId() %>" />
		</liferay-util:include>
	</liferay-ui:section>
	<liferay-ui:section>
		<liferay-util:include page="/html/portlet/enterprise_admin/website_iterator.jsp">
			<liferay-util:param name="editable" value="true" />
			<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
			<liferay-util:param name="className" value="<%= Account.class.getName() %>" />
			<liferay-util:param name="classPK" value="<%= account.getAccountId() %>" />
		</liferay-util:include>
	</liferay-ui:section>
	<liferay-ui:section>
		<liferay-util:include page="/html/portlet/enterprise_admin/phone_iterator.jsp">
			<liferay-util:param name="editable" value="true" />
			<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
			<liferay-util:param name="className" value="<%= Account.class.getName() %>" />
			<liferay-util:param name="classPK" value="<%= account.getAccountId() %>" />
		</liferay-util:include>
	</liferay-ui:section>
</liferay-ui:tabs>
