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

<%@ include file="/html/portlet/bookmarks/init.jsp" %>

<%
String tabs1 = ParamUtil.getString(request, "tabs1", "folders");

BookmarksFolder folder = (BookmarksFolder)request.getAttribute(WebKeys.BOOKMARKS_FOLDER);

String folderId = BeanParamUtil.getString(folder, request, "folderId", BookmarksFolderImpl.DEFAULT_PARENT_FOLDER_ID);

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/bookmarks/view");
portletURL.setParameter("folderId", folderId);
%>

<form method="post" name="<portlet:namespace />">

<liferay-ui:tabs
	names="folders,my-entries,recent-entries"
	url="<%= portletURL.toString() %>"
/>

<c:choose>
	<c:when test='<%= tabs1.equals("folders") %>'>
		<c:if test="<%= folder != null %>">
			<%= BookmarksUtil.getBreadcrumbs(folder, null, pageContext, renderRequest, renderResponse) %>

			<br><br>
		</c:if>

		<%
		List headerNames = new ArrayList();

		headerNames.add("folder");
		headerNames.add("num-of-folders");
		headerNames.add("num-of-entries");
		headerNames.add(StringPool.BLANK);

		SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, "cur1", SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

		int total = BookmarksFolderLocalServiceUtil.getFoldersCount(portletGroupId, folderId);

		searchContainer.setTotal(total);

		List results = BookmarksFolderLocalServiceUtil.getFolders(portletGroupId, folderId, searchContainer.getStart(), searchContainer.getEnd());

		searchContainer.setResults(results);

		List resultRows = searchContainer.getResultRows();

		for (int i = 0; i < results.size(); i++) {
			BookmarksFolder curFolder = (BookmarksFolder)results.get(i);

			ResultRow row = new ResultRow(curFolder, curFolder.getPrimaryKey().toString(), i);

			PortletURL rowURL = renderResponse.createRenderURL();

			rowURL.setWindowState(WindowState.MAXIMIZED);

			rowURL.setParameter("struts_action", "/bookmarks/view");
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

			List subfolders = BookmarksFolderLocalServiceUtil.getFolders(portletGroupId, curFolder.getFolderId(), 0, 5);

			if (subfolders.size() > 0) {
				sb.append("<br>");
				sb.append("<span style=\"font-size: xx-small; font-weight: bold;\"><u>");
				sb.append(LanguageUtil.get(pageContext, "subfolders"));
				sb.append("</u>: ");

				for (int j = 0; j < subfolders.size(); j++) {
					BookmarksFolder subfolder = (BookmarksFolder)subfolders.get(j);

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

			BookmarksFolderLocalServiceUtil.getSubfolderIds(subfolderIds, portletGroupId, curFolder.getFolderId());

			int foldersCount = subfolderIds.size() - 1;
			int entriesCount = BookmarksEntryLocalServiceUtil.getFoldersEntriesCount(subfolderIds);

			row.addText(Integer.toString(foldersCount), rowURL);
			row.addText(Integer.toString(entriesCount), rowURL);

			// Action

			row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/bookmarks/folder_action.jsp");

			// Add result row

			resultRows.add(row);
		}
		%>

		<c:if test="<%= BookmarksFolderPermission.contains(permissionChecker, plid, folderId, ActionKeys.ADD_FOLDER) %>">
			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-folder") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/bookmarks/edit_folder" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="parentFolderId" value="<%= folderId %>" /></portlet:renderURL>';"><br>

			<c:if test="<%= results.size() > 0 %>">
				<br>
			</c:if>
		</c:if>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

		<c:if test="<%= folder != null %>">
			<br>

			<liferay-ui:tabs names="entries" />

			<%
			headerNames.clear();

			headerNames.add("entry");
			headerNames.add("url");
			headerNames.add("visits");
			headerNames.add(StringPool.BLANK);

			searchContainer = new SearchContainer(renderRequest, null, null, "cur2", SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

			total = BookmarksEntryLocalServiceUtil.getEntriesCount(folder.getFolderId());

			searchContainer.setTotal(total);

			results = BookmarksEntryLocalServiceUtil.getEntries(folder.getFolderId(), searchContainer.getStart(), searchContainer.getEnd());

			searchContainer.setResults(results);

			resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				BookmarksEntry entry = (BookmarksEntry)results.get(i);

				ResultRow row = new ResultRow(entry, entry.getPrimaryKey().toString(), i);

				StringBuffer sb = new StringBuffer();

				sb.append(themeDisplay.getPathMain());
				sb.append("/bookmarks/open_entry?entryId=");
				sb.append(entry.getEntryId());

				String rowHREF = sb.toString();

				TextSearchEntry rowTextEntry = new TextSearchEntry(SearchEntry.DEFAULT_ALIGN, SearchEntry.DEFAULT_VALIGN, entry.getName(), rowHREF, "_blank", entry.getComments());

				// Name

				row.addText(rowTextEntry);

				// URL

				rowTextEntry = (TextSearchEntry)rowTextEntry.clone();

				rowTextEntry.setName(entry.getUrl());

				row.addText(rowTextEntry);

				// Visits

				rowTextEntry = (TextSearchEntry)rowTextEntry.clone();

				rowTextEntry.setName(String.valueOf(entry.getVisits()));

				row.addText(rowTextEntry);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/bookmarks/entry_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			%>

			<c:if test="<%= BookmarksFolderPermission.contains(permissionChecker, folder, ActionKeys.ADD_ENTRY) %>">
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-entry") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/bookmarks/edit_entry" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="folderId" value="<%= folderId %>" /></portlet:renderURL>';"><br>

				<c:if test="<%= results.size() > 0 %>">
					<br>
				</c:if>
			</c:if>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
		</c:if>

		</form>
	</c:when>
	<c:when test='<%= tabs1.equals("my-entries") || tabs1.equals("recent-entries") %>'>

		<%
		String groupEntriesUserId = null;

		if (tabs1.equals("my-entries") && themeDisplay.isSignedIn()) {
			groupEntriesUserId = user.getUserId();
		}

		List headerNames = new ArrayList();

		headerNames.add("entry");
		headerNames.add("url");
		headerNames.add("visits");
		headerNames.add(StringPool.BLANK);

		SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

		int total = BookmarksEntryLocalServiceUtil.getGroupEntriesCount(portletGroupId, groupEntriesUserId);

		searchContainer.setTotal(total);

		List results = BookmarksEntryLocalServiceUtil.getGroupEntries(portletGroupId, groupEntriesUserId, searchContainer.getStart(), searchContainer.getEnd());

		searchContainer.setResults(results);

		List resultRows = searchContainer.getResultRows();

		for (int i = 0; i < results.size(); i++) {
			BookmarksEntry entry = (BookmarksEntry)results.get(i);

			ResultRow row = new ResultRow(entry, entry.getPrimaryKey().toString(), i);

			StringBuffer sb = new StringBuffer();

			sb.append(themeDisplay.getPathMain());
			sb.append("/bookmarks/open_entry?entryId=");
			sb.append(entry.getEntryId());

			String rowHREF = sb.toString();

			TextSearchEntry rowTextEntry = new TextSearchEntry(SearchEntry.DEFAULT_ALIGN, SearchEntry.DEFAULT_VALIGN, entry.getName(), rowHREF, "_blank", entry.getComments());

			// Name

			row.addText(rowTextEntry);

			// URL

			rowTextEntry = (TextSearchEntry)rowTextEntry.clone();

			rowTextEntry.setName(entry.getUrl());

			row.addText(rowTextEntry);

			// Visits

			rowTextEntry = (TextSearchEntry)rowTextEntry.clone();

			rowTextEntry.setName(String.valueOf(entry.getVisits()));

			row.addText(rowTextEntry);

			// Action

			row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/bookmarks/entry_action.jsp");

			// Add result row

			resultRows.add(row);
		}
		%>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
	</c:when>
</c:choose>
