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

<%@ include file="/html/portlet/communities/init.jsp" %>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

Object[] objArray = (Object[])row.getObject();

Group group = (Group)objArray[0];
String tabs1 = (String)objArray[1];
%>

<c:if test="<%= GroupPermission.contains(permissionChecker, group.getGroupId(), ActionKeys.UPDATE) %>">
	<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="editURL">
		<portlet:param name="struts_action" value="/communities/edit_community" />
		<portlet:param name="redirect" value="<%= currentURL %>" />
		<portlet:param name="groupId" value="<%= group.getGroupId() %>" />
	</portlet:renderURL>

	<liferay-ui:icon image="edit" url="<%= editURL %>" />
</c:if>

<c:if test="<%= GroupPermission.contains(permissionChecker, group.getGroupId(), ActionKeys.PERMISSIONS) %>">
	<liferay-security:permissionsURL
		modelResource="<%= Group.class.getName() %>"
		modelResourceDescription="<%= group.getName() %>"
		resourcePrimKey="<%= group.getPrimaryKey().toString() %>"
		var="permissionsURL"
	/>

	<liferay-ui:icon image="permissions" url="<%= permissionsURL %>" />
</c:if>

<c:if test="<%= GroupPermission.contains(permissionChecker, group.getGroupId(), ActionKeys.DELEGATE) %>">
	<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="delegateURL">
		<portlet:param name="struts_action" value="/communities/edit_user_permissions" />
		<portlet:param name="redirect" value="<%= currentURL %>" />
		<portlet:param name="groupId" value="<%= group.getGroupId() %>" />
	</portlet:renderURL>

	<liferay-ui:icon image="delegate" url="<%= delegateURL %>" />
</c:if>

<c:if test="<%= GroupPermission.contains(permissionChecker, group.getGroupId(), ActionKeys.MANAGE_LAYOUTS) %>">
	<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="pagesURL">
		<portlet:param name="struts_action" value="/communities/edit_pages" />
		<portlet:param name="redirect" value="<%= currentURL %>" />
		<portlet:param name="groupId" value="<%= group.getGroupId() %>" />
	</portlet:renderURL>

	<liferay-ui:icon image="pages" url="<%= pagesURL %>" />
</c:if>

<c:if test="<%= GroupPermission.contains(permissionChecker, group.getGroupId(), ActionKeys.ASSIGN_USERS) %>">
	<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="assignURL">
		<portlet:param name="struts_action" value="/communities/edit_community_assignments" />
		<portlet:param name="redirect" value="<%= currentURL %>" />
		<portlet:param name="groupId" value="<%= group.getGroupId() %>" />
	</portlet:renderURL>

	<liferay-ui:icon image="assign" url="<%= assignURL %>" />
</c:if>

<c:choose>
	<c:when test='<%= tabs1.equals("current") %>'>
		<c:if test="<%= group.getType().equals(GroupImpl.TYPE_COMMUNITY_OPEN) %>">
			<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="leaveURL">
				<portlet:param name="struts_action" value="/communities/edit_community_assignments" />
				<portlet:param name="<%= Constants.CMD %>" value="group_users" />
				<portlet:param name="redirect" value="<%= currentURL %>" />
				<portlet:param name="groupId" value="<%= group.getGroupId() %>" />
				<portlet:param name="removeUserIds" value="<%= user.getUserId() %>" />
			</portlet:actionURL>

			<liferay-ui:icon image="leave" url="<%= leaveURL %>" />
		</c:if>
	</c:when>
	<c:otherwise>
		<c:if test="<%= group.getType().equals(GroupImpl.TYPE_COMMUNITY_OPEN) %>">
			<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="joinURL">
				<portlet:param name="struts_action" value="/communities/edit_community_assignments" />
				<portlet:param name="<%= Constants.CMD %>" value="group_users" />
				<portlet:param name="redirect" value="<%= currentURL %>" />
				<portlet:param name="groupId" value="<%= group.getGroupId() %>" />
				<portlet:param name="addUserIds" value="<%= user.getUserId() %>" />
			</portlet:actionURL>

			<liferay-ui:icon image="join" url="<%= joinURL %>" />
		</c:if>
	</c:otherwise>
</c:choose>

<c:if test="<%= GroupPermission.contains(permissionChecker, group.getGroupId(), ActionKeys.DELETE) %>">
	<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="deleteURL">
		<portlet:param name="struts_action" value="/communities/edit_community" />
		<portlet:param name="<%= Constants.CMD %>" value="<%= Constants.DELETE %>" />
		<portlet:param name="redirect" value="<%= currentURL %>" />
		<portlet:param name="groupId" value="<%= group.getGroupId() %>" />
	</portlet:actionURL>

	<liferay-ui:icon-delete url="<%= deleteURL %>" />
</c:if>
