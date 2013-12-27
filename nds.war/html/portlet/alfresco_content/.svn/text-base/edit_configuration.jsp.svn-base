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

<%@ include file="/html/portlet/alfresco_content/init.jsp" %>

<%
String keywords = StringPool.BLANK;

ResultSetRow[] searchResults = new ResultSetRow[0];

try {
	keywords = ParamUtil.getString(request, "keywords");

	if (Validator.isNotNull(keywords)) {
		searchResults = AlfrescoContentUtil.getSearchResults(userId, password, keywords);
	}
}
catch (Exception e) {
	_log.error(e);
}
%>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm1">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
<input name="<portlet:namespace />uuid" type="hidden" value="<%= uuid %>">

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "user-id") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />userId" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= userId %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "password") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />password" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="password" value="<%= password %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "maximize-links") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="maximizeLinks" defaultValue="<%= maximizeLinks %>" />
	</td>
</tr>
</table>

</form>

<br>

<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm1);">

<input class="portlet-form-button" type="button" value="<bean:message key="clear-cache" />" onClick="document.<portlet:namespace />fm1.<portlet:namespace /><%= Constants.CMD %>.value = 'clearCache'; submitForm(document.<portlet:namespace />fm1);"><br>

<%
String cmd = ParamUtil.getString(request, Constants.CMD);

String selUuid = request.getParameter("uuid");

if (Validator.isNotNull(cmd)) {
	selUuid = null;
}

try {
	Node node = AlfrescoContentUtil.getNode(userId, password, uuid);

	if (node != null) {
		NamedValue[] nodeNamedValues = node.getProperties();

		String nodeUuid = AlfrescoContentUtil.getNamedValue(nodeNamedValues, "node-uuid");
		String nodeName = AlfrescoContentUtil.getNamedValue(nodeNamedValues, org.alfresco.webservice.util.Constants.PROP_NAME);

		if (selUuid == null) {
			ResultSetRow[] parentNodes = AlfrescoContentUtil.getParentNodes(userId, password, uuid);

			if (parentNodes != null) {
				selUuid = parentNodes[0].getNode().getId();
			}
		}

		if (!nodeUuid.equals(nodeName)) {
%>

			<br>

			<%= LanguageUtil.get(pageContext, "displaying-content") %>: <%= nodeName %><br>

<%
		}
	}
}
catch (Exception e) {
	_log.error(e);
}
%>

<br><div class="beta-separator"></div><br>

<liferay-portlet:actionURL portletConfiguration="true" varImpl="portletURL" />

<%
String breadcrumbs = StringPool.BLANK;

try {
	Node curNode = AlfrescoContentUtil.getNode(userId, password, selUuid);

	if (curNode != null) {
		NamedValue[] curNamedValues = curNode.getProperties();

		String curUuid = AlfrescoContentUtil.getNamedValue(curNamedValues, "node-uuid");
		String curName = AlfrescoContentUtil.getNamedValue(curNamedValues, org.alfresco.webservice.util.Constants.PROP_NAME);

		if (!curUuid.equals(curName)) {
			portletURL.setParameter("uuid", curUuid);

			breadcrumbs = "<a href='" + portletURL.toString() + "'>" + curName + "</a>";
		}

		curUuid = selUuid;

		ResultSetRow[] parentNodes = null;

		for (int i = 0;; i++) {
			parentNodes = AlfrescoContentUtil.getParentNodes(userId, password, curUuid);

			if (parentNodes == null) {
				break;
			}

			ResultSetRow resultSetRow = parentNodes[0];

			ResultSetRowNode node = resultSetRow.getNode();

			curNamedValues = resultSetRow.getColumns();

			curUuid = AlfrescoContentUtil.getNamedValue(curNamedValues, "node-uuid");
			curName = AlfrescoContentUtil.getNamedValue(curNamedValues, org.alfresco.webservice.util.Constants.PROP_NAME);

			if (!curUuid.equals(curName)) {
				portletURL.setParameter("uuid", curUuid);

				breadcrumbs = "<a href='" + portletURL.toString() + "'>" + curName + "</a>" + " &raquo; " + breadcrumbs;
			}
		}

		portletURL.setParameter("uuid", "");

		breadcrumbs = "<a href='" + portletURL.toString() + "'>Alfresco</a>" + " &raquo; " + breadcrumbs;
	}
}
catch (Exception e) {
	_log.error(e);
}
%>

<c:if test="<%= (searchResults != null) && (searchResults.length == 0) %>">
	<%= breadcrumbs %>

	<c:if test="<%= Validator.isNotNull(breadcrumbs) %>">
		<br><br>
	</c:if>
</c:if>

<%
SearchContainer searchContainer = new SearchContainer();

List headerNames = new ArrayList();

headerNames.add("name");

searchContainer.setHeaderNames(headerNames);
searchContainer.setEmptyResultsMessage("no-alfresco-content-was-found");

ResultSetRow[] childNodes = new ResultSetRow[0];

try {
	childNodes = AlfrescoContentUtil.getChildNodes(userId, password, selUuid);

	if (childNodes == null) {
		childNodes = new ResultSetRow[0];
	}

	if ((searchResults != null) && (searchResults.length > 0)) {
		childNodes = searchResults;
	}
}
catch (Exception e) {
	_log.error(e);
}

int total = childNodes.length;

searchContainer.setTotal(total);

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < childNodes.length; i++) {
	ResultSetRow resultSetRow = childNodes[i];

	ResultSetRowNode node = resultSetRow.getNode();

	ResultRow row = new ResultRow(node, node.getId(), i);

	NamedValue[] nodeNamedValues = resultSetRow.getColumns();

	StringBuffer sb = new StringBuffer();

	sb.append("javascript: ");

	String propContent = AlfrescoContentUtil.getNamedValue(nodeNamedValues, org.alfresco.webservice.util.Constants.PROP_CONTENT);

	if (propContent == null) {
		sb.append("document.");
		sb.append(renderResponse.getNamespace());
		sb.append("fm1.");
		sb.append(renderResponse.getNamespace());
		sb.append(Constants.CMD);
		sb.append(".value = ''; ");
	}

	sb.append("document.");
	sb.append(renderResponse.getNamespace());
	sb.append("fm1.");
	sb.append(renderResponse.getNamespace());
	sb.append("uuid.value = '");
	sb.append(node.getId());
	sb.append("'; ");
	sb.append("submitForm(document.");
	sb.append(renderResponse.getNamespace());
	sb.append("fm1);");

	String rowHREF = sb.toString();

	// Name

	sb = new StringBuffer();

	sb.append("<img align=\"left\" border=\"0\" src=\"");
	sb.append(themeDisplay.getPathThemeImage());
	sb.append("/trees/");

	if (propContent == null) {
		sb.append("folder");
	}
	else {
		sb.append("page");
	}

	sb.append(".gif\">");

	String nodeName = AlfrescoContentUtil.getNamedValue(nodeNamedValues, org.alfresco.webservice.util.Constants.PROP_NAME);

	sb.append(nodeName);

	row.addText(sb.toString(), rowHREF);

	// Add result row

	if (!node.getId().equals(nodeName)) {
		resultRows.add(row);
	}
}
%>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm2">

<input class="form-text" name="<portlet:namespace />keywords" size="30" type="text" value="<%= keywords %>">

<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">

</form>

<br>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<script type="text/javascript">
	document.<portlet:namespace />fm1.<portlet:namespace />userId.focus();
</script>

<%!
private static Log _log = LogFactoryUtil.getLog("portal-web.docroot.html.portlet.alfresco_content.edit_configuration.jsp");
%>
