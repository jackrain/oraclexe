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
String breadcrumbsFolderId = ParamUtil.getString(request, "breadcrumbsFolderId");

String folderIds = ParamUtil.getString(request, "folderIds");
String[] folderIdsArray = StringUtil.split(folderIds);

String keywords = ParamUtil.getString(request, "keywords");
%>

<form action="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/document_library/search" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace />breadcrumbsFolderId" type="hidden" value="<%= breadcrumbsFolderId %>">
<input name="<portlet:namespace />folderIds" type="hidden" value="<%= folderIds %>">

<%= DLUtil.getBreadcrumbs(breadcrumbsFolderId, null, pageContext, renderRequest, renderResponse) %> &raquo; <%= LanguageUtil.get(pageContext, "search") %>

<br><br>

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/document_library/search");
portletURL.setParameter("breadcrumbsFolderId", breadcrumbsFolderId);
portletURL.setParameter("folderIds", folderIds);
portletURL.setParameter("keywords", keywords);

List headerNames = new ArrayList();

headerNames.add("#");
headerNames.add("folder");
headerNames.add("document");
headerNames.add("score");
headerNames.add(StringPool.BLANK);

SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, LanguageUtil.format(pageContext, "no-documents-were-found-that-matched-the-keywords-x", "<b>" + keywords + "</b>"));

Hits hits = DLFolderLocalServiceUtil.search(company.getCompanyId(), portletGroupId, folderIdsArray, keywords);

Hits results = hits.subset(searchContainer.getStart(), searchContainer.getEnd());
int total = hits.getLength();

searchContainer.setTotal(total);

List resultRows = searchContainer.getResultRows();

String rootDir = PropsUtil.get(PropsUtil.DL_ROOT_DIR);
String versionRootDir = PropsUtil.get(PropsUtil.DL_VERSION_ROOT_DIR);

for (int i = 0; i < results.getLength(); i++) {
	Document doc = results.doc(i);

	ResultRow row = new ResultRow(doc, String.valueOf(i), i);

	// Position

	row.addText(searchContainer.getStart() + i + 1 + StringPool.PERIOD);

	// Folder and document

	String repositoryId = doc.get("repositoryId");
	String fileName = doc.get("path");

	DLFileEntry fileEntry = DLFileEntryLocalServiceUtil.getFileEntry(repositoryId, fileName);

	row.setObject(fileEntry);

	DLFolder folder = DLFolderLocalServiceUtil.getFolder(repositoryId);

	PortletURL rowURL = renderResponse.createActionURL();

	rowURL.setWindowState(LiferayWindowState.EXCLUSIVE);

	rowURL.setParameter("struts_action", "/document_library/get_file");
	rowURL.setParameter("folderId", repositoryId);
	rowURL.setParameter("name", fileName);

	row.addText(folder.getName(), rowURL);
	row.addText(fileEntry.getName(), rowURL);

	// Score

	row.addText(String.valueOf(hits.score(i)), rowURL);

	// Action

	row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/document_library/file_entry_action.jsp");

	// Add result row

	resultRows.add(row);
}
%>

<input class="form-text" name="<portlet:namespace />keywords" size="30" type="text" value="<%= keywords %>">

<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">

<br><br>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />keywords.focus();
</script>
