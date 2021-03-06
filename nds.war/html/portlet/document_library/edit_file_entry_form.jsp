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
String cmd = ParamUtil.getString(request, Constants.CMD);

String redirect = ParamUtil.getString(request, "redirect");

String uploadProgressId = ParamUtil.getString(request, "uploadProgressId");

DLFileEntry fileEntry = (DLFileEntry)request.getAttribute(WebKeys.DOCUMENT_LIBRARY_FILE_ENTRY);

String folderId = BeanParamUtil.getString(fileEntry, request, "folderId");
String name = BeanParamUtil.getString(fileEntry, request, "name");

Lock lock = null;
Boolean isLocked = Boolean.FALSE;
Boolean hasLock = Boolean.FALSE;

if (fileEntry != null) {
	try {
		lock = LockServiceUtil.getLock(DLFileEntry.class.getName(), fileEntry.getPrimaryKey());

		isLocked = Boolean.TRUE;

		if (lock.getUserId().equals(user.getUserId())) {
			hasLock = Boolean.TRUE;
		}
	}
	catch (Exception e) {
	}
}
%>

<script type="text/javascript">
	<c:if test="<%= Validator.isNotNull(cmd) && SessionErrors.isEmpty(renderRequest) %>">
		parent.<%= uploadProgressId %>.sendRedirect();
	</c:if>

	function <portlet:namespace />saveFileEntry() {
		parent.<%= uploadProgressId %>.startProgress();

		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= fileEntry == null ? Constants.ADD : Constants.UPDATE %>";
		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />selectFolder(folderId, folderName) {
		document.<portlet:namespace />fm.<portlet:namespace />newFolderId.value = folderId;

		var nameEl = document.getElementById("<portlet:namespace />folderName");

		nameEl.href = "javascript: parent.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/view" /></portlet:renderURL>&<portlet:namespace />folderId=" + folderId + "'; void('');";
		nameEl.innerHTML = folderName + "&nbsp;";
	}
</script>

<form action="<portlet:actionURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/document_library/edit_file_entry" /></portlet:actionURL>" enctype="multipart/form-data" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />saveFileEntry(); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= redirect %>">
<input name="<portlet:namespace />uploadProgressId" type="hidden" value="<%= uploadProgressId %>">
<input name="<portlet:namespace />folderId" type="hidden" value="<%= folderId %>">
<input name="<portlet:namespace />newFolderId" type="hidden" value="">
<input name="<portlet:namespace />name" type="hidden" value="<%= name %>">

<liferay-ui:error exception="<%= DuplicateFileException.class %>" message="please-enter-a-unique-document-name" />

<liferay-ui:error exception="<%= FileNameException.class %>">

	<%
	String[] fileExtensions = PropsUtil.getArray(PropsUtil.DL_FILE_EXTENSIONS);
	%>

	<%= LanguageUtil.get(pageContext, "document-names-must-end-with-one-of-the-following-extensions") %> <%= StringUtil.merge(fileExtensions, ", ") %>.
</liferay-ui:error>

<liferay-ui:error exception="<%= SourceFileNameException.class %>">
	<%= LanguageUtil.get(pageContext, "document-extensions-does-not-match") %>
</liferay-ui:error>

<liferay-ui:error exception="<%= FileSizeException.class %>" message="please-enter-a-file-with-a-valid-file-size" />

<%
String fileMaxSize = Integer.toString(GetterUtil.getInteger(PropsUtil.get(PropsUtil.DL_FILE_MAX_SIZE)) / 1024);
%>

<c:if test='<%= !fileMaxSize.equals("0") %>'>
	<%= LanguageUtil.format(pageContext, "upload-documents-no-larger-than-x-k", fileMaxSize, false) %>

	<br><br>
</c:if>

<table border="0" cellpadding="0" cellspacing="0">

<c:if test="<%= fileEntry != null %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "folder") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>

			<%
			DLFolder folder = DLFolderLocalServiceUtil.getFolder(folderId);
			%>

			<a href="javascript: parent.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/view" /><portlet:param name="folderId" value="<%= folderId %>" /></portlet:renderURL>'; void('');" id="<portlet:namespace />folderName">
			<%= folder.getName() %>
			</a>

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "select") %>' onClick="var folderWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/document_library/select_folder" /><portlet:param name="folderId" value="<%= folderId %>" /></portlet:renderURL>', 'folder', 'directories=no,height=640,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no,width=680'); void(''); folderWindow.focus();">
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
		<%= LanguageUtil.get(pageContext, "title") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= DLFileEntry.class %>" bean="<%= fileEntry %>" field="title" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "description") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= DLFileEntry.class %>" bean="<%= fileEntry %>" field="description" />
	</td>
</tr>

<%
if (fileEntry == null) {
	request.setAttribute(WebKeys.DOCUMENT_LIBRARY_FILE_ENTRY, new DLFileEntryImpl());
}
%>

<%@ include file="/html/portlet/document_library/edit_file_entry_form_extra_fields.jsp" %>

<%
if (fileEntry == null) {
	request.removeAttribute(WebKeys.DOCUMENT_LIBRARY_FILE_ENTRY);
}
%>

<c:if test="<%= fileEntry == null %>">
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
				modelName="<%= DLFileEntry.class.getName() %>"
			/>
		</td>
	</tr>
</c:if>

</table>

<br>

<input class="portlet-form-button" <%= isLocked.booleanValue() && !hasLock.booleanValue() ? "disabled" : "" %> type="submit" value='<%= LanguageUtil.get(pageContext, "save") %>'>

<c:if test="<%= (fileEntry != null) && ((isLocked.booleanValue() && hasLock.booleanValue()) || !isLocked.booleanValue()) %>">
	<c:choose>
		<c:when test="<%= !hasLock.booleanValue() %>">
			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "lock") %>' onClick="parent.location = '<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/edit_file_entry" /><portlet:param name="<%= Constants.CMD %>" value="<%= Constants.LOCK %>" /><portlet:param name="redirect" value="<%= redirect %>" /><portlet:param name="folderId" value="<%= folderId %>" /><portlet:param name="name" value="<%= name %>" /></portlet:actionURL>';">
		</c:when>
		<c:otherwise>
			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "unlock") %>' onClick="parent.location = '<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/edit_file_entry" /><portlet:param name="<%= Constants.CMD %>" value="<%= Constants.UNLOCK %>" /><portlet:param name="redirect" value="<%= redirect %>" /><portlet:param name="folderId" value="<%= folderId %>" /><portlet:param name="name" value="<%= name %>" /></portlet:actionURL>';">
		</c:otherwise>
	</c:choose>
</c:if>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="parent.location = '<%= redirect %>';">

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />file.focus();

	Event.addHandler(window, "onload", function() {
		parent.<%= uploadProgressId %>.updateIFrame(document.<portlet:namespace />fm.offsetHeight);
	});
</script>
