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
String tabs2 = ParamUtil.getString(request, "tabs2", "display");
String tabs3 = ParamUtil.getString(request, "tabs3", "email-addresses");
String tabs4 = ParamUtil.getString(request, "tabs4", "phone-numbers");

User user2 = PortalUtil.getSelectedUser(request);

boolean editable = false;

if (portletName.equals(PortletKeys.ENTERPRISE_ADMIN) || portletName.equals(PortletKeys.LOCATION_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN) || portletName.equals(PortletKeys.MY_ACCOUNT)) {
	if ((user2 == null) || user2.isActive()) {
		editable = true;

		if ((user2 != null) && !UserPermission.contains(permissionChecker, user2.getUserId(), user2.getOrganization().getOrganizationId(), user2.getLocation().getOrganizationId(), ActionKeys.UPDATE)) {
			editable = false;
		}
	}
}

Contact contact2 = null;

if (user2 != null) {
	contact2 = user2.getContact();
}

String emailAddress = BeanParamUtil.getString(user2, request, "emailAddress");
%>

<script type="text/javascript">
	function <portlet:namespace />saveUser(cmd) {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = cmd;
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_user" /></portlet:actionURL>");
	}
</script>

<form method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />tabs2" type="hidden" value="<%= tabs2 %>">
<input name="<portlet:namespace />tabs3" type="hidden" value="<%= tabs3 %>">
<input name="<portlet:namespace />tabs4" type="hidden" value="<%= tabs4 %>">
<input name="<portlet:namespace />redirect" type="hidden" value="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_user" /><portlet:param name="tabs2" value="<%= tabs2 %>" /><portlet:param name="tabs3" value="<%= tabs3 %>" /><portlet:param name="tabs4" value="<%= tabs4 %>" /></portlet:renderURL>&<portlet:namespace />p_u_i_d=">
<input name="<portlet:namespace />p_u_i_d" type="hidden" value='<%= (user2 != null) ? user2.getUserId() : "" %>'>

<liferay-util:include page="/html/portlet/enterprise_admin/tabs1.jsp">
	<liferay-util:param name="tabs1" value="users" />
</liferay-util:include>

<liferay-util:include page="/html/portlet/my_account/tabs1.jsp">
	<liferay-util:param name="tabs1" value="profile" />
</liferay-util:include>

<%@ include file="/html/portlet/enterprise_admin/edit_user_profile.jsp" %>

<c:if test="<%= user2 != null %>">
	<c:if test="<%= editable %>">
		<liferay-ui:tabs
			names="display,password,roles"
			param="tabs2"
			refresh="<%= false %>"
		>
			<liferay-ui:section>
				<%@ include file="/html/portlet/enterprise_admin/edit_user_display.jsp" %>
			</liferay-ui:section>
			<liferay-ui:section>
				<%@ include file="/html/portlet/enterprise_admin/edit_user_password.jsp" %>
			</liferay-ui:section>
			<liferay-ui:section>
				<%@ include file="/html/portlet/enterprise_admin/user_role_iterator.jsp" %>
			</liferay-ui:section>
		</liferay-ui:tabs>
	</c:if>

	<liferay-ui:tabs
		names="email-addresses,addresses,websites"
		param="tabs3"
		refresh="<%= false %>"
	>
		<liferay-ui:section>
			<liferay-util:include page="/html/portlet/enterprise_admin/email_address_iterator.jsp">
				<liferay-util:param name="editable" value="<%= Boolean.toString(editable) %>" />
				<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
				<liferay-util:param name="className" value="<%= Contact.class.getName() %>" />
				<liferay-util:param name="classPK" value="<%= contact2.getContactId() %>" />
			</liferay-util:include>
		</liferay-ui:section>
		<liferay-ui:section>
			<liferay-util:include page="/html/portlet/enterprise_admin/address_iterator.jsp">
				<liferay-util:param name="editable" value="<%= Boolean.toString(editable) %>" />
				<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
				<liferay-util:param name="className" value="<%= Contact.class.getName() %>" />
				<liferay-util:param name="classPK" value="<%= contact2.getContactId() %>" />
				<liferay-util:param name="organizationId" value="<%= organizationId %>" />
				<liferay-util:param name="locationId" value="<%= locationId %>" />
			</liferay-util:include>
		</liferay-ui:section>
		<liferay-ui:section>
			<liferay-util:include page="/html/portlet/enterprise_admin/website_iterator.jsp">
				<liferay-util:param name="editable" value="<%= Boolean.toString(editable) %>" />
				<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
				<liferay-util:param name="className" value="<%= Contact.class.getName() %>" />
				<liferay-util:param name="classPK" value="<%= contact2.getContactId() %>" />
			</liferay-util:include>
		</liferay-ui:section>
	</liferay-ui:tabs>

	<liferay-ui:tabs
		names="phone-numbers,sms-messenger-id,instant-messenger-ids"
		param="tabs4"
		refresh="<%= false %>"
	>
		<liferay-ui:section>
			<liferay-util:include page="/html/portlet/enterprise_admin/phone_iterator.jsp">
				<liferay-util:param name="editable" value="<%= Boolean.toString(editable) %>" />
				<liferay-util:param name="redirect" value="<%= currentURL + sectionRedirectParams %>" />
				<liferay-util:param name="className" value="<%= Contact.class.getName() %>" />
				<liferay-util:param name="classPK" value="<%= contact2.getContactId() %>" />
				<liferay-util:param name="organizationId" value="<%= organizationId %>" />
				<liferay-util:param name="locationId" value="<%= locationId %>" />
			</liferay-util:include>
		</liferay-ui:section>
		<liferay-ui:section>
			<%@ include file="/html/portlet/enterprise_admin/edit_user_sms.jsp" %>
		</liferay-ui:section>
		<liferay-ui:section>
			<%@ include file="/html/portlet/enterprise_admin/edit_user_im.jsp" %>
		</liferay-ui:section>
	</liferay-ui:tabs>

	<%@ include file="/html/portlet/enterprise_admin/edit_user_comments.jsp" %>
</c:if>

</form>
