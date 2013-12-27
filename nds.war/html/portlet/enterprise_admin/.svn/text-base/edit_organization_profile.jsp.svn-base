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
if ((parentOrganizationId == null) || (parentOrganizationId.equals(StringPool.NULL))) {
	parentOrganizationId = OrganizationImpl.DEFAULT_PARENT_ORGANIZATION_ID;

	if (organization != null) {
		parentOrganizationId = organization.getParentOrganizationId();
	}
}

if (!rootOrganization && portletName.equals(PortletKeys.ORGANIZATION_ADMIN)) {
	parentOrganizationId = user.getOrganization().getOrganizationId();
}

String parentOrganizationName = ParamUtil.getString(request, "parentOrganizationName");

if (!parentOrganizationId.equals(OrganizationImpl.DEFAULT_PARENT_ORGANIZATION_ID)) {
	try {
		Organization parentOrganization = OrganizationLocalServiceUtil.getOrganization(parentOrganizationId);

		parentOrganizationName = parentOrganization.getName();
	}
	catch (NoSuchOrganizationException nsoe) {
	}
}

String regionId = BeanParamUtil.getString(organization, request, "regionId");
String countryId = BeanParamUtil.getString(organization, request, "countryId");
String statusId = BeanParamUtil.getString(organization, request, "statusId");
%>

<script type="text/javascript">
	function <portlet:namespace />selectOrganization(organizationId, name) {
		document.<portlet:namespace />fm.<portlet:namespace />parentOrganizationId.value = organizationId;

		var nameEl = document.getElementById("<portlet:namespace />parentOrganizationName");

		nameEl.href = "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_organization" /></portlet:actionURL>&<portlet:namespace />organizationId=" + organizationId;
		nameEl.innerHTML = name + "&nbsp;";
	}
</script>

<liferay-ui:error exception="<%= DuplicateOrganizationException.class %>" message="the-organization-name-is-already-taken" />
<liferay-ui:error exception="<%= NoSuchCountryException.class %>" message="please-select-a-country" />
<liferay-ui:error exception="<%= NoSuchListTypeException.class %>" message="please-select-a-status" />
<liferay-ui:error exception="<%= OrganizationNameException.class %>" message="please-enter-a-valid-name" />
<liferay-ui:error exception="<%= OrganizationParentException.class %>" message="please-enter-a-valid-organization" />

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
				<liferay-ui:input-field model="<%= Organization.class %>" bean="<%= organization %>" field="name" />
			</td>
		</tr>

		<c:if test='<%= !rootOrganization %>'>
			<input name="<portlet:namespace />parentOrganizationId" type="hidden" value="<%= parentOrganizationId %>">

			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "organization") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<a class="portlet-font" href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_organization" /><portlet:param name="organizationId" value="<%= organizationId %>" /></portlet:actionURL>" id="<portlet:namespace />parentOrganizationName" style="font-size: x-small;"><%= parentOrganizationName %></a>

					<c:if test="<%= portletName.equals(PortletKeys.ENTERPRISE_ADMIN) && editable %>">
						<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "select") %>' onClick="var organizationWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/select_organization" /></portlet:renderURL>', 'organization', 'directories=no,height=640,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no,width=680'); void(''); organizationWindow.focus();">
					</c:if>
				</td>
			</tr>
		</c:if>

		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "status") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select name="<portlet:namespace />statusId">
					<option value=""></option>

					<%
					List statuses = ListTypeServiceUtil.getListTypes(ListTypeImpl.ORGANIZATION_STATUS);

					for (int i = 0; i < statuses.size(); i++) {
						ListType status = (ListType)statuses.get(i);
					%>

						<option <%= status.getListTypeId().equals(statusId) ? "selected" : "" %> value="<%= status.getListTypeId() %>"><%= LanguageUtil.get(pageContext, status.getName()) %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
		</table>
	</td>
	<td style="padding-left: 30px;"></td>
	<td valign="top">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "country") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select id="<portlet:namespace />countryId" name="<portlet:namespace />countryId">
					<option value=""></option>

					<%
					List countries = CountryServiceUtil.getCountries(true);

					for (int i = 0; i < countries.size(); i++) {
						Country country = (Country)countries.get(i);
					%>

						<option <%= country.getCountryId().equals(countryId) ? "selected" : "" %> value="<%= country.getCountryId() %>"><%= LanguageUtil.get(pageContext, country.getName()) %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "region") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select id="<portlet:namespace />regionId" name="<portlet:namespace />regionId">
					<option value=""></option>

					<%
					List regions = RegionServiceUtil.getRegions(countryId);

					for (int i = 0; i < regions.size(); i++) {
						Region region = (Region)regions.get(i);
					%>

						<option <%= region.getRegionId().equals(regionId) ? "selected" : "" %> value="<%= region.getRegionId() %>"><%= LanguageUtil.get(pageContext, region.getName()) %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<c:if test="<%= editable %>">
	<br>

	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveOrganization('<%= organization == null ? Constants.ADD : Constants.UPDATE %>');"><br>
</c:if>

<c:if test="<%= organization != null %>">
	<br>
</c:if>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />name.focus();

	function <portlet:namespace />selectCountryPost() {
		setSelectedValue(document.<portlet:namespace />fm.<portlet:namespace />regionId, "<%= regionId %>");
	}

	DynamicSelect.create(
		"<%= themeDisplay.getPathMain() %>/portal/json_regions",
		document.<portlet:namespace />fm.<portlet:namespace />countryId,
		document.<portlet:namespace />fm.<portlet:namespace />regionId,
		<portlet:namespace />selectCountryPost
	)
</script>
