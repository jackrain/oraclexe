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
String redirect = ParamUtil.getString(request, "redirect");

IGImage image = (IGImage)request.getAttribute(WebKeys.IMAGE_GALLERY_IMAGE);

String imageId = BeanParamUtil.getString(image, request, "imageId");

String folderId = BeanParamUtil.getString(image, request, "folderId");
%>

<liferay-ui:tabs names="image" />

<%= IGUtil.getBreadcrumbs(folderId, null, pageContext, renderRequest, renderResponse) %>

<br><br>

<c:if test="<%= image != null %>">
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "thumbnail") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<a href="<%= themeDisplay.getPathImage() %>/image_gallery?img_id=<%= image.getImageId() %>&large=1" target="_blank">
			<img alt="<%= image.getDescription() %>" border="1" src="<%= themeDisplay.getPathImage() %>/image_gallery?img_id=<%= image.getImageId() %>&small=1">
			</a>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<br>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "height") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= image.getHeight() %>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "width") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= image.getWidth() %>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "size") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= TextFormatter.formatKB(image.getSize(), locale) %>k
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<br>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "url") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<a href="<%= PortalUtil.getPortalURL(request) %><%= themeDisplay.getPathImage() %>/image_gallery?img_id=<%= image.getImageId() %>" target="_blank">
			<%= PortalUtil.getPortalURL(request) %><%= themeDisplay.getPathImage() %>/image_gallery?img_id=<%= image.getImageId() %>
			</a>
		</td>
	</tr>
	</table>

	<br>
</c:if>

<%
String uploadProgressId = "igImageUploadProgress";
%>

<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>" var="uploadProgressURL">
	<portlet:param name="struts_action" value="/image_gallery/edit_image" />
	<portlet:param name="redirect" value="<%= redirect %>" />
	<portlet:param name="uploadProgressId" value="<%= uploadProgressId %>" />
	<portlet:param name="imageId" value="<%= imageId %>" />
	<portlet:param name="folderId" value="<%= folderId %>" />
</portlet:renderURL>

<liferay-ui:upload-progress
	id="<%= uploadProgressId %>"
	iframeSrc="<%= uploadProgressURL %>"
	redirect="<%= redirect %>"
/>
