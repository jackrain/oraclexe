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
String tabs1 = ParamUtil.getString(request, "tabs1", "folders");

DLFolder folder = (DLFolder)request.getAttribute(WebKeys.DOCUMENT_LIBRARY_FOLDER);

String folderId = BeanParamUtil.getString(folder, request, "folderId", DLFolderImpl.DEFAULT_PARENT_FOLDER_ID);

List folderIds = new ArrayList();

folderIds.add(folderId);

DLFolderLocalServiceUtil.getSubfolderIds(folderIds, portletGroupId, folderId);

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/document_library/view");
portletURL.setParameter("tabs1", tabs1);
portletURL.setParameter("folderId", folderId);
%>

<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm1" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace />breadcrumbsFolderId" type="hidden" value="<%= folderId %>">
<input name="<portlet:namespace />folderIds" type="hidden" value="<%= StringUtil.merge(folderIds) %>">

<liferay-ui:tabs
	names="folders,my-documents,recent-documents"
	url="<%= portletURL.toString() %>"
/>

<c:choose>
	<c:when test='<%= tabs1.equals("folders") %>'>
		<c:if test="<%= folder != null %>">
			<%= DLUtil.getBreadcrumbs(folder, null, pageContext, renderRequest, renderResponse) %>

			<br><br>
		</c:if>

		<%
		List headerNames = new ArrayList();

		headerNames.add("folder");
		headerNames.add("num-of-folders");
		headerNames.add("num-of-documents");
		headerNames.add(StringPool.BLANK);

		SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, "cur1", SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

		int total = DLFolderLocalServiceUtil.getFoldersCount(portletGroupId, folderId);

		searchContainer.setTotal(total);

		List results = DLFolderLocalServiceUtil.getFolders(portletGroupId, folderId, searchContainer.getStart(), searchContainer.getEnd());

		searchContainer.setResults(results);

		List resultRows = searchContainer.getResultRows();

		for (int i = 0; i < results.size(); i++) {
			DLFolder curFolder = (DLFolder)results.get(i);

			ResultRow row = new ResultRow(curFolder, curFolder.getPrimaryKey().toString(), i);

			PortletURL rowURL = renderResponse.createRenderURL();

			rowURL.setWindowState(WindowState.MAXIMIZED);

			rowURL.setParameter("struts_action", "/document_library/view");
			rowURL.setParameter("folderId", curFolder.getFolderId());

			// Name and description

			StringBuffer sb = new StringBuffer();

			sb.append("<a href=\"");
			sb.append(rowURL);
			sb.append("\">");
			sb.append("<img align=\"left\" border=\"0\" src=\"");
			sb.append(themeDisplay.getPathThemeImage());
			sb.append("/trees/folder.gif\">");
			sb.append("<b>");
			sb.append(curFolder.getName());
			sb.append("</b>");

			if (Validator.isNotNull(curFolder.getDescription())) {
				sb.append("<br>");
				sb.append("<span style=\"font-size: xx-small;\">");
				sb.append(curFolder.getDescription());
				sb.append("</span>");
			}

			sb.append("</a>");

			List subfolders = DLFolderLocalServiceUtil.getFolders(portletGroupId, curFolder.getFolderId(), 0, 5);

			if (subfolders.size() > 0) {
				sb.append("<br>");
				sb.append("<span style=\"font-size: xx-small; font-weight: bold;\"><u>");
				sb.append(LanguageUtil.get(pageContext, "subfolders"));
				sb.append("</u>: ");

				for (int j = 0; j < subfolders.size(); j++) {
					DLFolder subfolder = (DLFolder)subfolders.get(j);

					rowURL.setParameter("folderId", subfolder.getFolderId());

					sb.append("<a href=\"");
					sb.append(rowURL);
					sb.append("\">");
					sb.append(subfolder.getName());
					sb.append("</a>");

					if ((j + 1) < subfolders.size()) {
						sb.append(", ");
					}
				}

				rowURL.setParameter("folderId", curFolder.getFolderId());

				sb.append("</span>");
			}

			row.addText(sb.toString());

			// Statistics

			List subfolderIds = new ArrayList();

			subfolderIds.add(curFolder.getFolderId());

			DLFolderLocalServiceUtil.getSubfolderIds(subfolderIds, portletGroupId, curFolder.getFolderId());

			int foldersCount = subfolderIds.size() - 1;
			int fileEntriesCount = DLFileEntryLocalServiceUtil.getFileEntriesAndShortcutsCount(subfolderIds);

			row.addText(Integer.toString(foldersCount), rowURL);
			row.addText(Integer.toString(fileEntriesCount), rowURL);

			// Action

			row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/document_library/folder_action.jsp");

			// Add result row

			resultRows.add(row);
		}

		boolean showAddFolderButton = DLFolderPermission.contains(permissionChecker, plid, folderId, ActionKeys.ADD_FOLDER);
		%>

		<c:if test="<%= showAddFolderButton || (results.size() > 0) %>">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<c:if test="<%= showAddFolderButton %>">
					<td>
						<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-folder") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/edit_folder" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="parentFolderId" value="<%= folderId %>" /></portlet:renderURL>';">
					</td>
					<td style="padding-left: 30px;"></td>
				</c:if>

				<c:if test="<%= results.size() > 0 %>">
					<td>
						<input class="form-text" name="<portlet:namespace />keywords" size="30" type="text">

						<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search-folders") %>">
					</td>
				</c:if>
			</tr>
			</table>

			<c:if test="<%= results.size() > 0 %>">
				<br>
			</c:if>
		</c:if>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

		<c:if test="<%= folder != null %>">
			<br>
		</c:if>

		</form>

		<script type="text/javascript">
			if (document.<portlet:namespace />fm1.<portlet:namespace />keywords) {
				document.<portlet:namespace />fm1.<portlet:namespace />keywords.focus();
			}
		</script>

		<c:if test="<%= folder != null %>">
			<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm2" onSubmit="submitForm(this); return false;">
			<input name="<portlet:namespace />breadcrumbsFolderId" type="hidden" value="<%= folderId %>">
			<input name="<portlet:namespace />folderIds" type="hidden" value="<%= folderId %>">

			<liferay-ui:tabs names="documents" />

			<%
			headerNames.clear();

			headerNames.add("document");
			headerNames.add("size");
			headerNames.add("downloads");
			headerNames.add("locked");
			headerNames.add(StringPool.BLANK);

			searchContainer = new SearchContainer(renderRequest, null, null, "cur2", SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

			total = DLFileEntryLocalServiceUtil.getFileEntriesAndShortcutsCount(folder.getFolderId());

			searchContainer.setTotal(total);

			results = DLFileEntryLocalServiceUtil.getFileEntriesAndShortcuts(folder.getFolderId(), searchContainer.getStart(), searchContainer.getEnd());

			searchContainer.setResults(results);

			resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				Object result = results.get(i);

				String primaryKey = null;

				DLFileEntry fileEntry = null;
				DLFileShortcut fileShortcut = null;

				if (result instanceof DLFileEntry) {
					fileEntry = (DLFileEntry)result;

					primaryKey = fileEntry.getPrimaryKey().toString();
				}
				else {
					fileShortcut = (DLFileShortcut)result;
					fileEntry = DLFileEntryLocalServiceUtil.getFileEntry(fileShortcut.getToFolderId(), fileShortcut.getToName());

					primaryKey = String.valueOf(fileShortcut.getPrimaryKey());
				}

				ResultRow row = new ResultRow(result, primaryKey, i);

				String rowHREF = null;

				if (fileShortcut == null) {
					rowHREF = themeDisplay.getPathMain() + "/document_library/get_file?folderId=" + fileEntry.getFolderId() + "&name=" + Http.encodeURL(fileEntry.getName());
				}
				else {
					rowHREF = themeDisplay.getPathMain() + "/document_library/get_file?fileShortcutId=" + fileShortcut.getFileShortcutId();
				}

				// Title and description

				StringBuffer sb = new StringBuffer();

				sb.append("<img align=\"left\" border=\"0\" src=\"");
				sb.append(themeDisplay.getPathThemeImage());
				sb.append("/document_library/");
				sb.append(DLUtil.getFileExtension(fileEntry.getName()));
				sb.append(".gif\">");
				sb.append(fileEntry.getTitle());

				if (Validator.isNotNull(fileEntry.getDescription())) {
					sb.append("<br>");
					sb.append("<span style=\"font-size: xx-small;\">");
					sb.append(fileEntry.getDescription());
					sb.append("</span>");
				}

				row.addText(sb.toString(), rowHREF);

				// Statistics

				row.addText(TextFormatter.formatKB(fileEntry.getSize(), locale) + "k", rowHREF);
				row.addText(Integer.toString(fileEntry.getReadCount()), rowHREF);

				// Locked

				boolean isLocked = LockServiceUtil.isLocked(DLFileEntry.class.getName(), fileEntry.getPrimaryKey());

				row.addText(LanguageUtil.get(pageContext, isLocked ? "yes" : "no"), rowHREF);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/document_library/file_entry_action.jsp");

				// Add result row

				resultRows.add(row);
			}

			boolean showAddFileEntryButton = DLFolderPermission.contains(permissionChecker, folder, ActionKeys.ADD_DOCUMENT);
			boolean showAddFileShortcutButton = DLFolderPermission.contains(permissionChecker, folder, ActionKeys.ADD_SHORTCUT);
			%>

			<c:if test="<%= showAddFileEntryButton || showAddFileShortcutButton || (results.size() > 0) %>">
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<c:if test="<%= showAddFileEntryButton || showAddFileShortcutButton %>">
						<td>
							<c:if test="<%= showAddFileEntryButton %>">
								<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-document") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/edit_file_entry" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="folderId" value="<%= folderId %>" /></portlet:renderURL>';">
							</c:if>

							<c:if test="<%= showAddFileShortcutButton %>">
								<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-shortcut") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/edit_file_shortcut" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="folderId" value="<%= folderId %>" /></portlet:renderURL>';">
							</c:if>
						</td>
						<td style="padding-left: 30px;"></td>
					</c:if>

					<c:if test="<%= results.size() > 0 %>">
						<td>
							<input class="form-text" name="<portlet:namespace />keywords" size="30" type="text">

							<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search-folder") %>">
						</td>
					</c:if>
				</tr>
				</table>

				<c:if test="<%= results.size() > 0 %>">
					<br>
				</c:if>
			</c:if>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

			</form>

			<script type="text/javascript">
				if (document.<portlet:namespace />fm1.<portlet:namespace />keywords) {
					document.<portlet:namespace />fm1.<portlet:namespace />keywords.focus();
				}
				else if (document.<portlet:namespace />fm2.<portlet:namespace />keywords) {
					document.<portlet:namespace />fm2.<portlet:namespace />keywords.focus();
				}
			</script>
		</c:if>
	</c:when>
	<c:when test='<%= tabs1.equals("my-documents") || tabs1.equals("recent-documents") %>'>

		<%
		String groupFileEntriesUserId = null;

		if (tabs1.equals("my-documents") && themeDisplay.isSignedIn()) {
			groupFileEntriesUserId = user.getUserId();
		}

		List headerNames = new ArrayList();

		headerNames.add("document");
		headerNames.add("size");
		headerNames.add("downloads");
		headerNames.add("locked");
		headerNames.add(StringPool.BLANK);

		SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

		int total = DLFileEntryLocalServiceUtil.getGroupFileEntriesCount(portletGroupId, groupFileEntriesUserId);

		searchContainer.setTotal(total);

		List results = DLFileEntryLocalServiceUtil.getGroupFileEntries(portletGroupId, groupFileEntriesUserId, searchContainer.getStart(), searchContainer.getEnd());

		searchContainer.setResults(results);

		List resultRows = searchContainer.getResultRows();

		for (int i = 0; i < results.size(); i++) {
			DLFileEntry fileEntry = (DLFileEntry)results.get(i);

			ResultRow row = new ResultRow(fileEntry, fileEntry.getPrimaryKey().toString(), i);

			PortletURL rowURL = renderResponse.createRenderURL();

			rowURL.setWindowState(WindowState.MAXIMIZED);

			rowURL.setParameter("struts_action", "/document_library/edit_file_entry");
			rowURL.setParameter("redirect", currentURL);
			rowURL.setParameter("folderId", fileEntry.getFolderId());
			rowURL.setParameter("name", fileEntry.getName());

			// Title and description

			StringBuffer sb = new StringBuffer();

			sb.append("<img align=\"left\" border=\"0\" src=\"");
			sb.append(themeDisplay.getPathThemeImage());
			sb.append("/document_library/");
			sb.append(DLUtil.getFileExtension(fileEntry.getName()));
			sb.append(".gif\">");
			sb.append(fileEntry.getTitle());

			if (Validator.isNotNull(fileEntry.getDescription())) {
				sb.append("<br>");
				sb.append("<span style=\"font-size: xx-small;\">");
				sb.append(fileEntry.getDescription());
				sb.append("</span>");
			}

			row.addText(sb.toString(), rowURL);

			// Statistics

			row.addText(TextFormatter.formatKB(fileEntry.getSize(), locale) + "k", rowURL);
			row.addText(Integer.toString(fileEntry.getReadCount()), rowURL);

			// Locked

			boolean isLocked = LockServiceUtil.isLocked(DLFileEntry.class.getName(), fileEntry.getPrimaryKey());

			row.addText(LanguageUtil.get(pageContext, isLocked ? "yes" : "no"), rowURL);

			// Action

			row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/document_library/file_entry_action.jsp");

			// Add result row

			resultRows.add(row);
		}
		%>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
	</c:when>
</c:choose>
