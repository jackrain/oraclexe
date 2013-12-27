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
Organization organization = (Organization)request.getAttribute(WebKeys.ORGANIZATION);

if (rootOrganization && portletName.equals(PortletKeys.ORGANIZATION_ADMIN)) {
	organization = user.getOrganization();
}

String organizationId = BeanParamUtil.getString(organization, request, "organizationId");

String parentOrganizationId = request.getParameter("parentOrganizationId");

boolean editable = false;

if (portletName.equals(PortletKeys.ENTERPRISE_ADMIN) || (!rootOrganization && portletName.equals(PortletKeys.LOCATION_ADMIN)) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN)) {
	editable = true;

	if (rootOrganization) {
		if (!OrganizationPermission.contains(permissionChecker, organizationId, ActionKeys.UPDATE)) {
			editable = false;
		}

		if (Validator.isNull(organizationId) && PortalPermission.contains(permissionChecker, ActionKeys.ADD_ORGANIZATION)) {
			editable = true;
		}
	}
	else {
		if (!LocationPermission.contains(permissionChecker, organizationId, ActionKeys.UPDATE)) {
			editable = false;
		}

		if (Validator.isNull(organizationId)) {
			editable = true;

			if ((parentOrganizationId != null) && !OrganizationPermission.contains(permissionChecker, parentOrganizationId, ActionKeys.ADD_LOCATION)) {
				editable = false;
			}
		}
	}
}

String strutsAction = "/enterprise_admin/edit_organization";

if (!rootOrganization) {
	strutsAction = "/enterprise_admin/edit_location";
}
%>

<script type="text/javascript">
	function <portlet:namespace />saveOrganization(cmd) {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = cmd;
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="<%= strutsAction %>" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />saveOrganization('<%= organization == null ? Constants.ADD : Constants.UPDATE %>'); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="<%= strutsAction %>" /></portlet:renderURL>&<portlet:namespace />organizationId=">
<input name="<portlet:namespace />organizationId" type="hidden" value="<%= organizationId %>">

<liferay-util:include page="/html/portlet/enterprise_admin/tabs1.jsp">
	<liferay-util:param name="tabs1" value='<%= rootOrganization ? "organizations" : "locations" %>' />
</liferay-util:include>

<liferay-util:include page="/html/portlet/my_account/tabs1.jsp">
	<liferay-util:param name="tabs1" value="profile" />
</liferay-util:include>

<c:if test="<%= portletName.equals(PortletKeys.MY_ACCOUNT) %>">
	<liferay-ui:tabs names='<%= rootOrganization ? "organization" : "location" %>' />
</c:if>

<%@ include file="/html/portlet/enterprise_admin/edit_organization_profile.jsp" %>

<c:if test="<%= organization != null %>">
	<liferay-ui:tabs
		names="email-addresses,addresses,websites,phone-numbers"
		param="tabs2"
		refresh="<%= false %>"
	>
		<liferay-ui:section>
			<liferay-util:include page="/html/portlet/enterprise_admin/email_address_iterator.jsp">
				<liferay-util:param name="editable" value="<%= Boolean.toString(editable) %>" />
				<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
				<liferay-util:param name="className" value="<%= Organization.class.getName() %>" />
				<liferay-util:param name="classPK" value="<%= organizationId %>" />
			</liferay-util:include>
		</liferay-ui:section>
		<liferay-ui:section>
			<liferay-util:include page="/html/portlet/enterprise_admin/address_iterator.jsp">
				<liferay-util:param name="editable" value="<%= Boolean.toString(editable) %>" />
				<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
				<liferay-util:param name="className" value="<%= Organization.class.getName() %>" />
				<liferay-util:param name="classPK" value="<%= organizationId %>" />
			</liferay-util:include>
		</liferay-ui:section>
		<liferay-ui:section>
			<liferay-util:include page="/html/portlet/enterprise_admin/website_iterator.jsp">
				<liferay-util:param name="editable" value="<%= Boolean.toString(editable) %>" />
				<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
				<liferay-util:param name="className" value="<%= Organization.class.getName() %>" />
				<liferay-util:param name="classPK" value="<%= organizationId %>" />
			</liferay-util:include>
		</liferay-ui:section>
		<liferay-ui:section>
			<liferay-util:include page="/html/portlet/enterprise_admin/phone_iterator.jsp">
				<liferay-util:param name="editable" value="<%= Boolean.toString(editable) %>" />
				<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
				<liferay-util:param name="className" value="<%= Organization.class.getName() %>" />
				<liferay-util:param name="classPK" value="<%= organizationId %>" />
			</liferay-util:include>
		</liferay-ui:section>
	</liferay-ui:tabs>

	<liferay-ui:tabs
		names="services"
		param="tabs3"
	>
		<liferay-ui:section>
			<liferay-util:include page="/html/portlet/enterprise_admin/org_labor_iterator.jsp">
				<liferay-util:param name="editable" value="<%= Boolean.toString(editable) %>" />
				<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
			</liferay-util:include>
		</liferay-ui:section>
	</liferay-ui:tabs>

	<%@ include file="/html/portlet/enterprise_admin/edit_organization_comments.jsp" %>
</c:if>

</form>
