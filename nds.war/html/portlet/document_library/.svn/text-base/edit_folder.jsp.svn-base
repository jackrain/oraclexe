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

<%@ include file="/html/portlet/document_library/init.jsp" %>

<%
String redirect = ParamUtil.getString(request, "redirect");

DLFolder folder = (DLFolder)request.getAttribute(WebKeys.DOCUMENT_LIBRARY_FOLDER);

String folderId = BeanParamUtil.getString(folder, request, "folderId");

String parentFolderId = BeanParamUtil.getString(folder, request, "parentFolderId", DLFolderImpl.DEFAULT_PARENT_FOLDER_ID);
%>

<script type="text/javascript">
	function <portlet:namespace />removeFolder() {
		document.<portlet:namespace />fm.<portlet:namespace />parentFolderId.value = "<%= DLFolderImpl.DEFAULT_PARENT_FOLDER_ID %>";

		var nameEl = document.getElementById("<portlet:namespace />parentFolderName");

		nameEl.href = "";
		nameEl.innerHTML = "";
	}

	function <portlet:namespace />saveFolder() {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= folder == null ? Constants.ADD : Constants.UPDATE %>";
		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />selectFolder(parentFolderId, parentFolderName) {
		document.<portlet:namespace />fm.<portlet:namespace />parentFolderId.value = parentFolderId;

		var nameEl = document.getElementById("<portlet:namespace />parentFolderName");

		nameEl.href = "<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/view" /></portlet:renderURL>&<portlet:namespace />folderId=" + parentFolderId;
		nameEl.innerHTML = parentFolderName + "&nbsp;";
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/edit_folder" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />saveFolder(); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= redirect %>">
<input name="<portlet:namespace />folderId" type="hidden" value="<%= folderId %>">
<input name="<portlet:namespace />parentFolderId" type="hidden" value="<%= parentFolderId %>">

<liferay-ui:tabs names="folder" />

<liferay-ui:error exception="<%= FolderNameException.class %>" message="please-enter-a-valid-name" />

<c:if test="<%= !parentFolderId.equals(DLFolderImpl.DEFAULT_PARENT_FOLDER_ID) %>">
	<%= DLUtil.getBreadcrumbs(parentFolderId, null, pageContext, renderRequest, renderResponse) %>

	<br><br>
</c:if>

<table border="0" cellpadding="0" cellspacing="0">

<c:if test="<%= folder != null %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "parent-folder") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>

			<%
			String parentFolderName = "";

			try {
				DLFolder parentFolder = DLFolderLocalServiceUtil.getFolder(parentFolderId);

				parentFolderName = parentFolder.getName();
			}
			catch (NoSuchFolderException nscce) {
			}
			%>

			<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/view" /><portlet:param name="folderId" value="<%= parentFolderId %>" /></portlet:renderURL>" id="<portlet:namespace />parentFolderName">
			<%= parentFolderName %>
			</a>

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "select") %>' onClick="var folderWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/document_library/select_folder" /><portlet:param name="folderId" value="<%= parentFolderId %>" /></portlet:renderURL>', 'folder', 'directories=no,height=640,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no,width=680'); void(''); folderWindow.focus();">

			<input class="portlet-form-button" id="<portlet:namespace />removeFolderButton" type="button" value='<%= LanguageUtil.get(pageContext, "remove") %>' onClick="<portlet:namespace />removeFolder();">
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
		<%= LanguageUtil.get(pageContext, "name") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= DLFolder.class %>" bean="<%= folder %>" field="name" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "description") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= DLFolder.class %>" bean="<%= folder %>" field="description" />
	</td>
</tr>

<c:if test="<%= folder != null %>">
	<tr>
		<td colspan="3">
			<br>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "webdav-url") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>

			<%
			StringBuffer sb = new StringBuffer();

			DLFolder curFolder = folder;

			while (true) {
				sb.insert(0, curFolder.getFolderId());
				sb.insert(0, StringPool.SLASH);

				if (curFolder.getParentFolderId().equals(DLFolderImpl.DEFAULT_PARENT_FOLDER_ID)) {
					break;
				}
				else {
					curFolder = DLFolderLocalServiceUtil.getFolder(curFolder.getParentFolderId());
				}
			}

			sb.insert(0, curFolder.getGroupId());
			sb.insert(0, StringPool.SLASH);
			%>

			<input class="form-text" readonly="true" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= PortalUtil.getPortalURL(request) %>/tunnel-web/secure/webdav/document_library/<%= company.getCompanyId() %><%= sb.toString() %>" onClick="javascript: this.focus(); this.select();">
		</td>
	</tr>
</c:if>

<c:if test="<%= folder == null %>">
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
				modelName="<%= DLFolder.class.getName() %>"
			/>
		</td>
	</tr>
</c:if>

</table>

<br>

<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "save") %>'>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />name.focus();
</script>
