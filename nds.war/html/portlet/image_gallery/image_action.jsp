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

<%@ include file="/html/portlet/image_gallery/init.jsp" %>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

IGImage image = (IGImage)row.getObject();
%>

<c:if test="<%= IGImagePermission.contains(permissionChecker, image, ActionKeys.UPDATE) %>">
	<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="editURL">
		<portlet:param name="struts_action" value="/image_gallery/edit_image" />
		<portlet:param name="redirect" value="<%= currentURL %>" />
		<portlet:param name="imageId" value="<%= image.getImageId() %>" />
	</portlet:renderURL>

	<liferay-ui:icon image="edit" url="<%= editURL %>" />
</c:if>

<c:if test="<%= IGImagePermission.contains(permissionChecker, image, ActionKeys.PERMISSIONS) %>">
	<liferay-security:permissionsURL
		modelResource="<%= IGImage.class.getName() %>"
		modelResourceDescription="<%= image.getImageId() %>"
		resourcePrimKey="<%= image.getPrimaryKey().toString() %>"
		var="permissionsURL"
	/>

	<liferay-ui:icon image="permissions" url="<%= permissionsURL %>" />
</c:if>

<c:if test="<%= IGImagePermission.contains(permissionChecker, image, ActionKeys.DELETE) %>">
	<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="deleteURL">
		<portlet:param name="struts_action" value="/image_gallery/edit_image" />
		<portlet:param name="<%= Constants.CMD %>" value="<%= Constants.DELETE %>" />
		<portlet:param name="redirect" value="<%= currentURL %>" />
		<portlet:param name="imageId" value="<%= image.getImageId() %>" />
	</portlet:actionURL>

	<liferay-ui:icon-delete url="<%= deleteURL %>" />
</c:if>
