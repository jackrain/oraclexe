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
String cmd = ParamUtil.getString(request, Constants.CMD);

String redirect = ParamUtil.getString(request, "redirect");

String uploadProgressId = ParamUtil.getString(request, "uploadProgressId");

IGImage image = (IGImage)request.getAttribute(WebKeys.IMAGE_GALLERY_IMAGE);

String imageId = BeanParamUtil.getString(image, request, "imageId");

String folderId = BeanParamUtil.getString(image, request, "folderId");
%>

<script type="text/javascript">
	<c:if test="<%= Validator.isNotNull(cmd) && SessionErrors.isEmpty(renderRequest) %>">
		parent.<%= uploadProgressId %>.sendRedirect();
	</c:if>

	function <portlet:namespace />saveImage() {
		parent.<%= uploadProgressId %>.startProgress();

		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= image == null ? Constants.ADD : Constants.UPDATE %>";
		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />selectFolder(folderId, folderName) {
		document.<portlet:namespace />fm.<portlet:namespace />folderId.value = folderId;

		var nameEl = document.getElementById("<portlet:namespace />folderName");

		nameEl.href = "<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/image_gallery/view" /></portlet:renderURL>&<portlet:namespace />folderId=" + folderId;
		nameEl.innerHTML = folderName + "&nbsp;";
	}
</script>

<form action="<portlet:actionURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/image_gallery/edit_image" /></portlet:actionURL>" enctype="multipart/form-data" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />saveImage(); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= redirect %>">
<input name="<portlet:namespace />uploadProgressId" type="hidden" value="<%= uploadProgressId %>">
<input name="<portlet:namespace />imageId" type="hidden" value="<%= imageId %>">
<input name="<portlet:namespace />folderId" type="hidden" value="<%= folderId %>">

<liferay-ui:error exception="<%= ImageNameException.class %>">

	<%
	String[] imageExtensions = PropsUtil.getArray(PropsUtil.IG_IMAGE_EXTENSIONS);
	%>

	<%= LanguageUtil.get(pageContext, "image-names-must-end-with-one-of-the-following-extensions") %> <%= StringUtil.merge(imageExtensions, ", ") %>.
</liferay-ui:error>

<liferay-ui:error exception="<%= ImageSizeException.class %>" message="please-enter-a-file-with-a-valid-file-size" />

<%
String imageMaxSize = Integer.toString(GetterUtil.getInteger(PropsUtil.get(PropsUtil.IG_IMAGE_MAX_SIZE)) / 1024);
%>

<c:if test='<%= !imageMaxSize.equals("0") %>'>
	<%= LanguageUtil.format(pageContext, "upload-images-no-larger-than-x-k", imageMaxSize, false) %>

	<br><br>
</c:if>

<table border="0" cellpadding="0" cellspacing="0">

<c:if test="<%= image != null %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "folder") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>

			<%
			IGFolder folder = IGFolderLocalServiceUtil.getFolder(folderId);
			%>

			<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/image_gallery/view" /><portlet:param name="folderId" value="<%= folderId %>" /></portlet:renderURL>" id="<portlet:namespace />folderName">
			<%= folder.getName() %>
			</a>

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "select") %>' onClick="var folderWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/image_gallery/select_folder" /><portlet:param name="folderId" value="<%= folderId %>" /></portlet:renderURL>', 'folder', 'directories=no,height=640,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no,width=680'); void(''); folderWindow.focus();">
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<br>
		</td>
	</tr>
</c:if>

<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "file") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />file" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="file">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "description") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= IGImage.class %>" bean="<%= image %>" field="description" />
	</td>
</tr>

<c:if test="<%= image == null %>">
	<tr>
		<td colspan="3">
			<br>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "permissions") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<liferay-ui:input-permissions
				modelName="<%= IGImage.class.getName() %>"
			/>
		</td>
	</tr>
</c:if>

</table>

<br>

<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "save") %>'>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="parent.location = '<%= redirect %>';">

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />file.focus();

	Event.addHandler(window, "onload", function() {
		parent.<%= uploadProgressId %>.updateIFrame(document.<portlet:namespace />fm.offsetHeight);
	});
</script>
