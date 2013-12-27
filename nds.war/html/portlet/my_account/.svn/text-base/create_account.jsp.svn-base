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

<%@ include file="/html/portlet/my_account/init.jsp" %>

<%
User user2 = null;
Contact contact2 = null;

Calendar birthday = new GregorianCalendar();

birthday.set(Calendar.MONTH, Calendar.JANUARY);
birthday.set(Calendar.DATE, 1);
birthday.set(Calendar.YEAR, 1970);

boolean male = BeanParamUtil.getBoolean(contact2, request, "male", true);
%>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/my_account/create_account" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.ADD %>">

<liferay-ui:error exception="<%= CaptchaTextException.class %>" message="text-verification-failed" />
<liferay-ui:error exception="<%= ContactFirstNameException.class %>" message="please-enter-a-valid-first-name" />
<liferay-ui:error exception="<%= ContactLastNameException.class %>" message="please-enter-a-valid-last-name" />
<liferay-ui:error exception="<%= DuplicateUserEmailAddressException.class %>" message="the-email-address-you-requested-is-already-taken" />
<liferay-ui:error exception="<%= DuplicateUserIdException.class %>" message="the-user-id-you-requested-is-already-taken" />
<liferay-ui:error exception="<%= ReservedUserEmailAddressException.class %>" message="the-email-address-you-requested-is-reserved" />
<liferay-ui:error exception="<%= ReservedUserIdException.class %>" message="the-user-id-you-requested-is-reserved" />
<liferay-ui:error exception="<%= UserEmailAddressException.class %>" message="please-enter-a-valid-email-address" />
<liferay-ui:error exception="<%= UserIdException.class %>" message="please-enter-a-valid-user-id" />

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td valign="top">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "first-name") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="firstName" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "middle-name") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="middleName" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "last-name") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="lastName" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "nickname") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="nickName" />
			</td>
		</tr>

		<c:choose>
			<c:when test="<%= company.getAuthType().equals(CompanyImpl.AUTH_TYPE_ID) %>">
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "user-id") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<liferay-ui:input-field model="<%= User.class %>" bean="<%= user2 %>" field="userId" />
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<input name="<portlet:namespace />autoUserId" type="hidden" value="1">
			</c:otherwise>
		</c:choose>

		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "email-address") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= User.class %>" bean="<%= user2 %>" field="emailAddress" />
			</td>
		</tr>

		<c:choose>
			<c:when test="<%= GetterUtil.getBoolean(PropsUtil.get(PropsUtil.FIELD_ENABLE_COM_LIFERAY_PORTAL_MODEL_CONTACT_BIRTHDAY)) %>">
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "birthday") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="birthday" defaultValue="<%= birthday %>" />
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<input name="<portlet:namespace />birthdayMonth" type="hidden" value="<%= Calendar.JANUARY %>">
				<input name="<portlet:namespace />birthdayDay" type="hidden" value="1">
				<input name="<portlet:namespace />birthdayYear" type="hidden" value="1970">
			</c:otherwise>
		</c:choose>

		<c:if test="<%= GetterUtil.getBoolean(PropsUtil.get(PropsUtil.FIELD_ENABLE_COM_LIFERAY_PORTAL_MODEL_CONTACT_MALE)) %>">
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "gender") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<select name="<portlet:namespace />male">
						<option value="1"><%= LanguageUtil.get(pageContext, "male") %></option>
						<option <%= !male? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "female") %></option>
					</select>
				</td>
			</tr>
		</c:if>

		</table>
	</td>
	<td style="padding-left: 30px;"></td>
	<td valign="top">
		<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>" var="captchaURL">
			<portlet:param name="struts_action" value="/my_account/captcha" />
		</portlet:actionURL>

		<liferay-ui:captcha url="<%= captchaURL %>" />
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "save") %>'>

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />firstName.focus();
</script>
