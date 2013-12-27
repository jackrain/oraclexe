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
String strutsAction = ParamUtil.getString(request, "struts_action");

String tabs2 = ParamUtil.getString(request, "tabs2", "version-history");

String redirect = ParamUtil.getString(request, "redirect");

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

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", strutsAction);
portletURL.setParameter("tabs2", tabs2);
portletURL.setParameter("redirect", redirect);
portletURL.setParameter("folderId", folderId);
portletURL.setParameter("name", name);
%>

<c:if test="<%= isLocked.booleanValue() %>">
	<c:choose>
		<c:when test="<%= hasLock.booleanValue() %>">

			<%
			String lockExpirationTime = LanguageUtil.getTimeDescription(pageContext, DLFileEntryImpl.LOCK_EXPIRATION_TIME).toLowerCase();
			%>

			<span class="portlet-msg-success" style="font-size: xx-small;">
			<%= LanguageUtil.format(pageContext, "you-now-have-a-lock-on-this-document", lockExpirationTime, false) %>
			</span>
		</c:when>
		<c:otherwise>
			<span class="portlet-msg-error" style="font-size: xx-small;">
			<%= LanguageUtil.format(pageContext, "you-cannot-modify-this-document-because-it-was-locked-by-x-on-x", new Object[] {PortalUtil.getUserName(lock.getUserId(), lock.getUserId()), dateFormatDateTime.format(lock.getDate())}, false) %>
			</span>
		</c:otherwise>
	</c:choose>

	<br><br>
</c:if>

<liferay-ui:tabs
	names="document"
	backURL="<%= redirect %>"
/>

<%= DLUtil.getBreadcrumbs(folderId, null, pageContext, renderRequest, renderResponse) %>

<br><br>

<c:if test="<%= fileEntry != null %>">
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "name") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<a href="<%= themeDisplay.getPathMain() %>/document_library/get_file?folderId=<%= folderId %>&name=<%= Http.encodeURL(name) %>">
			<%= fileEntry.getTitle() %>
			</a>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "version") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= fileEntry.getVersion() %>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "size") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= TextFormatter.formatKB(fileEntry.getSize(), locale) %>k
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "downloads") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= fileEntry.getReadCount() %>
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
			<input class="form-text" readonly="true" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= PortalUtil.getPortalURL(request) %><%= themeDisplay.getPathMain() %>/document_library/get_file?folderId=<%= folderId %>&name=<%= Http.encodeURL(name) %>" onClick="javascript: this.focus(); this.select();">
		</td>
	</tr>
	</table>
</c:if>

<c:if test='<%= strutsAction.equals("/document_library/edit_file_entry") && ((fileEntry == null) || DLFileEntryPermission.contains(permissionChecker, fileEntry, ActionKeys.UPDATE)) %>'>
	<c:if test="<%= fileEntry != null %>">
		<br>
	</c:if>

	<%
	String uploadProgressId = "dlFileEntryUploadProgress";
	%>

	<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>" var="uploadProgressURL">
		<portlet:param name="struts_action" value="/document_library/edit_file_entry" />
		<portlet:param name="tabs2" value="<%= tabs2 %>" />
		<portlet:param name="redirect" value="<%= redirect %>" />
		<portlet:param name="uploadProgressId" value="<%= uploadProgressId %>" />
		<portlet:param name="folderId" value="<%= folderId %>" />
		<portlet:param name="name" value="<%= name %>" />
	</portlet:renderURL>

	<liferay-ui:upload-progress
		id="<%= uploadProgressId %>"
		iframeSrc="<%= uploadProgressURL %>"
		redirect="<%= redirect %>"
	/>

	<c:if test="<%= fileEntry != null %>">
		<br>
	</c:if>
</c:if>

<c:if test="<%= fileEntry != null %>">
	<br>

	<liferay-ui:ratings
		className="<%= DLFileEntry.class.getName() %>"
		classPK="<%= fileEntry.getPrimaryKey().toString() %>"
		url='<%= themeDisplay.getPathMain() + "/document_library/rate_file_entry?folderId=" + fileEntry.getFolderId() + "&name=" + Http.encodeURL(name) %>'
	/>

	<br>

	<%
	String tabs2Names = "version-history,comments";

	if (!DLFileEntryPermission.contains(permissionChecker, fileEntry, ActionKeys.ADD_DISCUSSION)) {
		tabs2Names = "version-history";
	}
	%>

	<liferay-ui:tabs
		names="<%= tabs2Names %>"
		param="tabs2"
		url="<%= portletURL.toString() %>"
	/>

	<c:choose>
		<c:when test='<%= tabs2.equals("version-history") %>'>

			<%
			SearchContainer searchContainer = new SearchContainer();

			List headerNames = new ArrayList();

			headerNames.add("version");
			headerNames.add("date");
			headerNames.add("size");

			if (strutsAction.equals("/document_library/edit_file_entry")) {
				headerNames.add(StringPool.BLANK);
			}

			searchContainer.setHeaderNames(headerNames);

			List results = DLFileVersionLocalServiceUtil.getFileVersions(folderId, name);
			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				DLFileVersion fileVersion = (DLFileVersion)results.get(i);

				ResultRow row = new ResultRow(new Object[] {fileEntry, fileVersion, portletURL, isLocked, hasLock}, fileVersion.getPrimaryKey().toString(), i);

				StringBuffer sb = new StringBuffer();

				sb.append(themeDisplay.getPathMain());
				sb.append("/document_library/get_file?folderId=");
				sb.append(folderId);
				sb.append("&name=");
				sb.append(Http.encodeURL(name));
				sb.append("&version=");
				sb.append(String.valueOf(fileVersion.getVersion()));

				String rowHREF = sb.toString();

				// Statistics

				row.addText(Double.toString(fileVersion.getVersion()), rowHREF);
				row.addText(dateFormatDateTime.format(fileVersion.getCreateDate()), rowHREF);
				row.addText(TextFormatter.formatKB(fileVersion.getSize(), locale) + "k", rowHREF);

				// Action

				if (strutsAction.equals("/document_library/edit_file_entry")) {
					row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/document_library/file_version_action.jsp");
				}

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />
		</c:when>
		<c:when test='<%= tabs2.equals("comments") %>'>
			<c:if test="<%= DLFileEntryPermission.contains(permissionChecker, fileEntry, ActionKeys.ADD_DISCUSSION) %>">
				<portlet:actionURL var="discussionURL">
					<portlet:param name="struts_action" value="/document_library/edit_file_entry_discussion" />
				</portlet:actionURL>

				<liferay-ui:discussion
					formAction="<%= discussionURL %>"
					className="<%= DLFileEntry.class.getName() %>"
					classPK="<%= fileEntry.getPrimaryKey().toString() %>"
					userId="<%= fileEntry.getUserId() %>"
					subject="<%= fileEntry.getTitle() %>"
					redirect="<%= currentURL %>"
				/>
			</c:if>
		</c:when>
	</c:choose>
</c:if>
