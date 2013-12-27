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

<%@ include file="/html/portlet/enterprise_admin/init.jsp" %>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

Organization organization = (Organization)row.getObject();

String organizationId = organization.getOrganizationId();

boolean rootOrganization = organization.isRoot();

String strutsAction = "/enterprise_admin/edit_organization";

if (!rootOrganization) {
	strutsAction = "/enterprise_admin/edit_location";
}
%>

<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="editOrganizationURL">
	<portlet:param name="struts_action" value="<%= strutsAction %>" />
	<portlet:param name="organizationId" value="<%= organizationId %>" />
	<portlet:param name="redirect" value="<%= currentURL %>" />
</portlet:renderURL>

<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="deleteOrganizationURL">
	<portlet:param name="struts_action" value="<%= strutsAction %>" />
	<portlet:param name="<%= Constants.CMD %>" value="<%= Constants.DELETE %>" />
	<portlet:param name="deleteOrganizationIds" value="<%= organizationId %>" />
	<portlet:param name="redirect" value="<%= currentURL %>" />
</portlet:actionURL>

<%
String addUserURLString = null;
%>

<c:choose>
	<c:when test="<%= rootOrganization %>">
		<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="addUserToOrganizationURL">
			<portlet:param name="struts_action" value="/enterprise_admin/edit_user" />
			<portlet:param name="organizationId" value="<%= organizationId %>" />
			<portlet:param name="organizationName" value="<%= organization.getName() %>" />
		</portlet:renderURL>

		<%
		addUserURLString = addUserToOrganizationURL;
		%>

	</c:when>
	<c:otherwise>

		<%
		Organization parentOrganizaton = OrganizationLocalServiceUtil.getOrganization(organization.getParentOrganizationId());
		%>

		<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="addUserToLocationURL">
			<portlet:param name="struts_action" value="/enterprise_admin/edit_user" />
			<portlet:param name="organizationId" value="<%= parentOrganizaton.getOrganizationId() %>" />
			<portlet:param name="organizationName" value="<%= parentOrganizaton.getName() %>" />
			<portlet:param name="locationId" value="<%= organizationId %>" />
			<portlet:param name="locationName" value="<%= organization.getName() %>" />
		</portlet:renderURL>

		<%
		addUserURLString = addUserToLocationURL;
		%>

	</c:otherwise>
</c:choose>

<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="viewUsersURL">
	<portlet:param name="struts_action" value="/enterprise_admin/view" />
	<portlet:param name="tabs1" value="users" />
	<portlet:param name="organizationId" value="<%= organizationId %>" />
</portlet:renderURL>

<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="addLocationURL">
	<portlet:param name="struts_action" value="/enterprise_admin/edit_location" />
	<portlet:param name="parentOrganizationId" value="<%= organizationId %>" />
	<portlet:param name="parentOrganizationName" value="<%= organization.getName() %>" />
</portlet:renderURL>

<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="viewLocationsURL">
	<portlet:param name="struts_action" value="/enterprise_admin/view" />
	<portlet:param name="tabs1" value="locations" />
	<portlet:param name="parentOrganizationId" value="<%= organizationId %>" />
</portlet:renderURL>

<c:choose>
	<c:when test="<%= portletName.equals(PortletKeys.LOCATION_ADMIN) %>">
		<c:if test="<%= !rootOrganization && LocationPermission.contains(permissionChecker, organizationId, ActionKeys.UPDATE) %>">
			<liferay-ui:icon image="edit" url="<%= editOrganizationURL %>" />
		</c:if>

		<c:if test="<%= LocationPermission.contains(permissionChecker, organizationId, ActionKeys.PERMISSIONS) %>">
			<liferay-security:permissionsURL
				modelResource="com.liferay.portal.model.Location"
				modelResourceDescription="<%= organization.getName() %>"
				resourcePrimKey="<%= organization.getPrimaryKey().toString() %>"
				var="editLocationPermissionsURL"
			/>

			<liferay-ui:icon image="permissions" url="<%= editLocationPermissionsURL %>" />
		</c:if>

		<c:if test="<%= LocationPermission.contains(permissionChecker, organizationId, ActionKeys.ADD_USER) %>">
			<liferay-ui:icon image="add_user" message="add-user" url="<%= addUserURLString %>" />
		</c:if>

		<liferay-ui:icon image="view_users" message="view-users" url="<%= viewUsersURL %>" />

		<c:if test="<%= (portletName.equals(PortletKeys.ENTERPRISE_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN)) && LocationPermission.contains(permissionChecker, organizationId, ActionKeys.DELETE) %>">
			<liferay-ui:icon-delete url="<%= deleteOrganizationURL %>" />
		</c:if>
	</c:when>
	<c:otherwise>
		<c:if test="<%= portletName.equals(PortletKeys.ENTERPRISE_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN) %>">
			<c:choose>
				<c:when test="<%= rootOrganization %>">
					<c:if test="<%= OrganizationPermission.contains(permissionChecker, organizationId, ActionKeys.UPDATE) %>">
						<liferay-ui:icon image="edit" url="<%= editOrganizationURL %>" />
					</c:if>
				</c:when>
				<c:otherwise>
					<c:if test="<%= LocationPermission.contains(permissionChecker, organizationId, ActionKeys.UPDATE) %>">
						<liferay-ui:icon image="edit" url="<%= editOrganizationURL %>" />
					</c:if>
				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="<%= rootOrganization %>">
					<c:if test="<%= OrganizationPermission.contains(permissionChecker, organizationId, ActionKeys.PERMISSIONS) %>">
						<liferay-security:permissionsURL
							modelResource="<%= Organization.class.getName() %>"
							modelResourceDescription="<%= organization.getName() %>"
							resourcePrimKey="<%= organization.getPrimaryKey().toString() %>"
							var="editRootOrganizationPermissionsURL"
						/>

						<liferay-ui:icon image="permissions" url="<%= editRootOrganizationPermissionsURL %>" />
					</c:if>
				</c:when>
				<c:otherwise>
					<c:if test="<%= LocationPermission.contains(permissionChecker, organizationId, ActionKeys.PERMISSIONS) %>">
						<liferay-security:permissionsURL
							modelResource="com.liferay.portal.model.Location"
							modelResourceDescription="<%= organization.getName() %>"
							resourcePrimKey="<%= organization.getPrimaryKey().toString() %>"
							var="editOrganizationPermissionsURL"
						/>

						<liferay-ui:icon image="permissions" url="<%= editOrganizationPermissionsURL %>" />
					</c:if>
				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="<%= rootOrganization %>">
					<c:if test="<%= OrganizationPermission.contains(permissionChecker, organizationId, ActionKeys.ADD_USER) %>">
						<liferay-ui:icon image="add_user" message="add-user" url="<%= addUserURLString %>" />
					</c:if>
				</c:when>
				<c:otherwise>
					<c:if test="<%= LocationPermission.contains(permissionChecker, organizationId, ActionKeys.ADD_USER) %>">
						<liferay-ui:icon image="add_user" message="add-user" url="<%= addUserURLString %>" />
					</c:if>
				</c:otherwise>
			</c:choose>
		</c:if>

		<liferay-ui:icon image="view_users" message="view-users" url="<%= viewUsersURL %>" />

		<c:if test="<%= portletName.equals(PortletKeys.ENTERPRISE_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN) %>">
			<c:if test="<%= rootOrganization && OrganizationPermission.contains(permissionChecker, organizationId, ActionKeys.ADD_LOCATION) %>">
				<liferay-ui:icon image="add_location" message="add-location" url="<%= addLocationURL %>" />
			</c:if>
		</c:if>

		<c:if test="<%= rootOrganization %>">
			<liferay-ui:icon image="view_locations" message="view-locations" url="<%= viewLocationsURL %>" />
		</c:if>

		<c:choose>
			<c:when test="<%= rootOrganization %>">
				<c:if test="<%= portletName.equals(PortletKeys.ENTERPRISE_ADMIN) && OrganizationPermission.contains(permissionChecker, organizationId, ActionKeys.DELETE) %>">
					<liferay-ui:icon-delete url="<%= deleteOrganizationURL %>" />
				</c:if>
			</c:when>
			<c:otherwise>
				<c:if test="<%= LocationPermission.contains(permissionChecker, organizationId, ActionKeys.DELETE) %>">
					<liferay-ui:icon-delete url="<%= deleteOrganizationURL %>" />
				</c:if>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
