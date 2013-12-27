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
String prefixId = BeanParamUtil.getString(contact2, request, "prefixId");
String suffixId = BeanParamUtil.getString(contact2, request, "suffixId");

Calendar birthday = new GregorianCalendar();

birthday.set(Calendar.MONTH, Calendar.JANUARY);
birthday.set(Calendar.DATE, 1);
birthday.set(Calendar.YEAR, 1970);

if (contact2 != null) {
	birthday.setTime(contact2.getBirthday());
}

boolean male = BeanParamUtil.getBoolean(contact2, request, "male", true);

String organizationName = ParamUtil.getString(request, "organizationName");

String organizationId = request.getParameter("organizationId");

if ((organizationId == null) || (organizationId.equals(StringPool.NULL))) {
	organizationId = "";

	if (user2 != null) {
		Organization organization = user2.getOrganization();

		organizationName = organization.getName();
		organizationId = organization.getOrganizationId();
	}
}
else {
	try {
		Organization organization = OrganizationLocalServiceUtil.getOrganization(organizationId);

		organizationName = organization.getName();
	}
	catch (NoSuchOrganizationException nsoe) {
	}
}

if (portletName.equals(PortletKeys.LOCATION_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN)) {
	Organization organization = user.getOrganization();

	organizationName = organization.getName();
	organizationId = organization.getOrganizationId();
}

String locationName = ParamUtil.getString(request, "locationName");

String locationId = request.getParameter("locationId");

if ((locationId == null) || (locationId.equals(StringPool.NULL))) {
	locationId = "";

	if (user2 != null) {
		Organization location = user2.getLocation();

		locationName = location.getName();
		locationId = location.getOrganizationId();
	}
}
else {
	try {
		Organization location = OrganizationLocalServiceUtil.getOrganization(locationId);

		locationName = location.getName();
	}
	catch (NoSuchOrganizationException nsoe) {
	}
}

if (portletName.equals(PortletKeys.LOCATION_ADMIN)) {
	Organization location = user.getLocation();

	locationName = location.getName();
	locationId = location.getOrganizationId();
}
%>

<script type="text/javascript">
	function <portlet:namespace />removeLocation() {
		document.<portlet:namespace />fm.<portlet:namespace />locationId.value = "";

		var nameEl = document.getElementById("<portlet:namespace />locationName");

		nameEl.href = "#";
		nameEl.innerHTML = "";

		document.getElementById("<portlet:namespace />removeLocationButton").disabled = true;
	}

	function <portlet:namespace />removeOrganization() {
		document.<portlet:namespace />fm.<portlet:namespace />organizationId.value = "";

		var nameEl = document.getElementById("<portlet:namespace />organizationName");

		nameEl.href = "#";
		nameEl.innerHTML = "";

		document.getElementById("<portlet:namespace />removeOrganizationButton").disabled = true;
	}

	function <portlet:namespace />selectLocation(locationId, name) {
		document.<portlet:namespace />fm.<portlet:namespace />locationId.value = locationId;

		var nameEl = document.getElementById("<portlet:namespace />locationName");

		nameEl.href = "<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_location" /></portlet:renderURL>&<portlet:namespace />organizationId=" + locationId;
		nameEl.innerHTML = name + "&nbsp;";
	}

	function <portlet:namespace />selectOrganization(organizationId, name) {
		document.<portlet:namespace />fm.<portlet:namespace />organizationId.value = organizationId;

		var nameEl = document.getElementById("<portlet:namespace />organizationName");

		nameEl.href = "<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_organization" /></portlet:renderURL>&<portlet:namespace />organizationId=" + organizationId;
		nameEl.innerHTML = name + "&nbsp;";
	}
</script>

<liferay-ui:error exception="<%= ContactFirstNameException.class %>" message="please-enter-a-valid-first-name" />
<liferay-ui:error exception="<%= ContactLastNameException.class %>" message="please-enter-a-valid-last-name" />
<liferay-ui:error exception="<%= DuplicateUserEmailAddressException.class %>" message="the-email-address-you-requested-is-already-taken" />
<liferay-ui:error exception="<%= DuplicateUserIdException.class %>" message="the-user-id-you-requested-is-already-taken" />
<liferay-ui:error exception="<%= NoSuchOrganizationException.class %>" message="please-select-an-organization-and-location" />
<liferay-ui:error exception="<%= OrganizationParentException.class %>" message="please-enter-a-valid-organization-for-the-selected-location" />
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
				<%= LanguageUtil.get(pageContext, "prefix") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select name="<portlet:namespace />prefixId">
					<option value=""></option>

					<%
					List prefixes = ListTypeServiceUtil.getListTypes(ListTypeImpl.CONTACT_PREFIX);

					for (int i = 0; i < prefixes.size(); i++) {
						ListType prefix = (ListType)prefixes.get(i);
					%>

						<option <%= prefix.getListTypeId().equals(prefixId) ? "selected" : "" %> value="<%= prefix.getListTypeId() %>"><%= LanguageUtil.get(pageContext, prefix.getName()) %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
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
				<%= LanguageUtil.get(pageContext, "suffix") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select name="<portlet:namespace />suffixId">
					<option value=""></option>

					<%
					List suffixes = ListTypeServiceUtil.getListTypes(ListTypeImpl.CONTACT_SUFFIX);

					for (int i = 0; i < suffixes.size(); i++) {
						ListType suffix = (ListType)suffixes.get(i);
					%>

						<option <%= suffix.getListTypeId().equals(suffixId) ? "selected" : "" %> value="<%= suffix.getListTypeId() %>"><%= LanguageUtil.get(pageContext, suffix.getName()) %></option>

					<%
					}
					%>

				</select>
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
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "email-address") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= User.class %>" bean="<%= user2 %>" field="emailAddress" />
			</td>
		</tr>
		</table>
	</td>
	<td style="padding-left: 30px;"></td>
	<td valign="top">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "user-id") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<c:choose>
					<c:when test="<%= user2 == null %>">
						<liferay-ui:input-field model="<%= User.class %>" bean="<%= user2 %>" field="userId" />

						<liferay-ui:input-checkbox param="autoUserId" defaultValue="<%= true %>" />

						<%= LanguageUtil.get(pageContext, "autogenerate-id") %>
					</c:when>
					<c:otherwise>
						<%= user2.getUserId() %>
					</c:otherwise>
				</c:choose>
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

		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "organization") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input name="<portlet:namespace />organizationId" type="hidden" value="<%= organizationId %>">

				<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_organization" /><portlet:param name="organizationId" value="<%= organizationId %>" /></portlet:renderURL>" id="<portlet:namespace />organizationName">
				<%= organizationName %>
				</a>

				<c:if test="<%= portletName.equals(PortletKeys.ENTERPRISE_ADMIN) && editable %>">
					<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "select") %>' onClick="var organizationWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/select_organization" /></portlet:renderURL>', 'organization', 'directories=no,height=640,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no,width=680'); void(''); organizationWindow.focus();">

					<c:if test="<%= !GetterUtil.getBoolean(PropsUtil.get(PropsUtil.ORGANIZATIONS_PARENT_ORGANIZATION_REQUIRED)) %>">
						<input <%= Validator.isNull(organizationId) ? "disabled" : "" %> class="portlet-form-button" id="<portlet:namespace />removeOrganizationButton" type="button" value='<%= LanguageUtil.get(pageContext, "remove") %>' onClick="<portlet:namespace />removeOrganization();">
					</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "location") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input name="<portlet:namespace />locationId" type="hidden" value="<%= locationId %>">

				<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_location" /><portlet:param name="organizationId" value="<%= locationId %>" /></portlet:renderURL>" id="<portlet:namespace />locationName">
				<%= locationName %>
				</a>

				<c:if test="<%= (portletName.equals(PortletKeys.ENTERPRISE_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN)) && editable %>">
					<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "select") %>' onClick="var locationWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/select_location" /></portlet:renderURL>&<portlet:namespace />parentOrganizationId=' + document.<portlet:namespace />fm.<portlet:namespace />organizationId.value, 'location', 'directories=no,height=640,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no,width=680'); void(''); locationWindow.focus();">

					<c:if test="<%= !GetterUtil.getBoolean(PropsUtil.get(PropsUtil.ORGANIZATIONS_LOCATION_REQUIRED)) %>">
						<input <%= Validator.isNull(locationId) ? "disabled" : "" %> class="portlet-form-button" id="<portlet:namespace />removeLocationButton" type="button" value='<%= LanguageUtil.get(pageContext, "remove") %>' onClick="<portlet:namespace />removeLocation();">
					</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "job-title") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="jobTitle" />
			</td>
		</tr>
		</table>
	</td>

	<c:if test="<%= user2 != null %>">
		<td style="padding-left: 30px;"></td>
		<td align="center" valign="top">
			<img src="<%= themeDisplay.getPathImage() %>/user_portrait?img_id=<%= user2.getUserId() %>"><br>

			<c:if test="<%= editable %>">
				<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_user_portrait" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="p_u_i_d" value="<%= user2.getUserId() %>" /></portlet:renderURL>" style="font-size: xx-small;"><%= LanguageUtil.get(pageContext, "change") %></a>
			</c:if>
		</td>
	</c:if>
</tr>
</table>

<c:if test="<%= editable %>">
	<br>

	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveUser('<%= user2 == null ? Constants.ADD : Constants.UPDATE %>');"><br>
</c:if>

<c:if test="<%= user2 != null %>">
	<br>
</c:if>
