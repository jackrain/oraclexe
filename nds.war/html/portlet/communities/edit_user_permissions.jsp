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

<%@ include file="/html/portlet/communities/init.jsp" %>

<%
String tabs2 = ParamUtil.getString(request, "tabs2", "current");

String cur = ParamUtil.getString(request, "cur");

String redirect = ParamUtil.getString(request, "redirect");

Group group = (Group)request.getAttribute(WebKeys.GROUP);

String portletResource = ParamUtil.getString(request, "portletResource");
String modelResource = ParamUtil.getString(request, "modelResource");

String portletResourceName = null;
if (Validator.isNotNull(portletResource)) {
	Portlet portlet = PortletLocalServiceUtil.getPortletById(company.getCompanyId(), portletResource);

	portletResourceName = PortalUtil.getPortletTitle(portlet, application, locale);
}

String modelResourceName = ResourceActionsUtil.getModelResource(pageContext, modelResource);

List modelResources = null;

if (Validator.isNotNull(portletResource) && Validator.isNull(modelResource)) {
	modelResources = ResourceActionsUtil.getPortletModelResources(portletResource);
}

String selResource = modelResource;
String selResourceName = modelResourceName;

if (Validator.isNull(modelResource)) {
	selResource = portletResource;
	selResourceName = portletResourceName;
}

Resource resource = null;

if (Validator.isNotNull(portletResource) || Validator.isNotNull(modelResource)) {
	try {
		resource = ResourceLocalServiceUtil.getResource(company.getCompanyId(), selResource, ResourceImpl.TYPE_CLASS, ResourceImpl.SCOPE_GROUP, group.getGroupId());
	}
	catch (com.liferay.portal.NoSuchResourceException nsre) {
		boolean portletActions = Validator.isNull(modelResource);

		ResourceLocalServiceUtil.addResources(company.getCompanyId(), group.getGroupId(), selResource, portletActions);

		resource = ResourceLocalServiceUtil.getResource(company.getCompanyId(), selResource, ResourceImpl.TYPE_CLASS, ResourceImpl.SCOPE_GROUP, group.getGroupId());
	}
}

boolean editUserPermissions = ParamUtil.getBoolean(request, "editUserPermissions");

if ((Validator.isNotNull(portletResource) && Validator.isNotNull(modelResource)) ||
	(Validator.isNotNull(portletResource) && Validator.isNull(modelResource) && (modelResources.size() == 0))) {

	editUserPermissions = true;
}

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/communities/edit_user_permissions");
portletURL.setParameter("tabs2", tabs2);
portletURL.setParameter("redirect", redirect);
portletURL.setParameter("groupId", group.getGroupId());
portletURL.setParameter("portletResource", portletResource);
portletURL.setParameter("modelResource", modelResource);
portletURL.setParameter("editUserPermissions", String.valueOf(editUserPermissions));

// Breadcrumbs

PortletURL breadcrumbsURL = renderResponse.createRenderURL();

breadcrumbsURL.setWindowState(WindowState.MAXIMIZED);

breadcrumbsURL.setParameter("struts_action", "/communities/edit_user_permissions");
breadcrumbsURL.setParameter("redirect", redirect);
breadcrumbsURL.setParameter("tabs2", tabs2);
breadcrumbsURL.setParameter("groupId", group.getGroupId());

String breadcrumbs = "<a href=\"" + breadcrumbsURL.toString() + "\">" + group.getName() + "</a>";

if (Validator.isNotNull(portletResource)) {
	breadcrumbsURL.setParameter("portletResource", portletResource);

	breadcrumbs += " &raquo; <a href=\"" + breadcrumbsURL.toString() + "\">" + portletResourceName + "</a>";
}

if (Validator.isNotNull(modelResource)) {
	breadcrumbsURL.setParameter("modelResource", modelResource);

	breadcrumbs += " &raquo; <a href=\"" + breadcrumbsURL.toString() + "\">" + modelResourceName + "</a>";
}
%>

<script type="text/javascript">
	function <portlet:namespace />saveUserPermissions(userIdsPos, userIdsPosValue) {

		<%
		PortletURL saveUserPermissionsRedirectURL = PortletURLUtil.clone(portletURL, false, renderResponse);

		new UserSearch(renderRequest, saveUserPermissionsRedirectURL);
		%>

		var userIds = document.<portlet:namespace />fm.<portlet:namespace />userIds.value;

		if (userIdsPos == -1) {
			userIds = "";
			userIdsPos = 0;
		}

		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "user_permissions";
		document.<portlet:namespace />fm.<portlet:namespace />permissionsRedirect.value = "<%= saveUserPermissionsRedirectURL.toString() %>&<portlet:namespace />cur=<%= cur %>&<portlet:namespace />userIds=" + userIds + "&<portlet:namespace />userIdsPos=" + userIdsPos;
		document.<portlet:namespace />fm.<portlet:namespace />userIds.value = userIds;
		document.<portlet:namespace />fm.<portlet:namespace />userIdsPosValue.value = userIdsPosValue;
		document.<portlet:namespace />fm.<portlet:namespace />userIdActionIds.value = listSelect(document.<portlet:namespace />fm.<portlet:namespace />current_actions);
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/communities/edit_user_permissions" /></portlet:actionURL>");
	}

	function <portlet:namespace />updateUserPermissions() {
		document.<portlet:namespace />fm.<portlet:namespace />userIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<%= portletURL.toString() %>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />permissionsRedirect" type="hidden" value="">
<input name="<portlet:namespace />cur" type="hidden" value="<%= cur %>">
<input name="<portlet:namespace />groupId" type="hidden" value='<%= group.getGroupId() %>'>
<input name="<portlet:namespace />resourceId" type="hidden" value='<%= (resource != null) ? resource.getResourceId() : "" %>'>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "delegate-permissions-for-community") %>: <%= breadcrumbs %>
	</td>
	<td align="right">
		&laquo; <a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "back") %></a>
	</td>
</tr>
</table>

<br>

<c:choose>
	<c:when test="<%= editUserPermissions %>">

		<%
		String userIds = ParamUtil.getString(request, "userIds");
		String[] userIdsArray = StringUtil.split(userIds);
		int userIdsPos = ParamUtil.getInteger(request, "userIdsPos");
		%>

		<input name="<portlet:namespace />userIds" type="hidden" value="<%= userIds %>">
		<input name="<portlet:namespace />userIdsPos" type="hidden" value="<%= userIdsPos %>">
		<input name="<portlet:namespace />userIdsPosValue" type="hidden" value="">
		<input name="<portlet:namespace />userIdActionIds" type="hidden" value="">

		<c:choose>
			<c:when test="<%= userIdsArray.length == 0 %>">
				<liferay-ui:tabs
					names="current,available"
					param="tabs2"
					url="<%= portletURL.toString() %>"
				/>

				<%
				UserSearch searchContainer = new UserSearch(renderRequest, portletURL);

				searchContainer.setRowChecker(new RowChecker(renderResponse));
				%>

				<liferay-ui:search-form
					page="/html/portlet/enterprise_admin/user_search.jsp"
					searchContainer="<%= searchContainer %>"
				/>

				<%
				UserSearchTerms searchTerms = (UserSearchTerms)searchContainer.getSearchTerms();

				LinkedHashMap userParams = new LinkedHashMap();

				if (tabs2.equals("current")) {
					userParams.put("permission", resource.getResourceId());
				}
				else if (tabs2.equals("available")) {
					userParams.put("usersGroups", group.getGroupId());
				}

				int total = UserLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getFirstName(), searchTerms.getMiddleName(), searchTerms.getLastName(), searchTerms.getEmailAddress(), searchTerms.isActive(), userParams, searchTerms.isAndOperator());

				searchContainer.setTotal(total);

				List results = UserLocalServiceUtil.search(company.getCompanyId(), searchTerms.getFirstName(), searchTerms.getMiddleName(), searchTerms.getLastName(), searchTerms.getEmailAddress(), searchTerms.isActive(), userParams, searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), new ContactLastNameComparator(true));

				searchContainer.setResults(results);
				%>

				<br><div class="beta-separator"></div><br>

				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "update-permissions") %>' onClick="<portlet:namespace />updateUserPermissions();">

				<br><br>

				<%
				List headerNames = new ArrayList();

				headerNames.add("name");
				headerNames.add("email-address");
				headerNames.add("permissions");

				searchContainer.setHeaderNames(headerNames);

				List resultRows = searchContainer.getResultRows();

				for (int i = 0; i < results.size(); i++) {
					User user2 = (User)results.get(i);

					ResultRow row = new ResultRow(user2, user2.getPrimaryKey().toString(), i);

					// Name and email address

					row.addText(user2.getFullName());
					row.addText(user2.getEmailAddress());

					// Permissions

					List permissions = PermissionLocalServiceUtil.getUserPermissions(user2.getUserId(), resource.getResourceId());

					List actions = ResourceActionsUtil.getActions(permissions);
					List actionsNames = ResourceActionsUtil.getActionsNames(pageContext, actions);

					row.addText(StringUtil.merge(actionsNames, ", "));

					// Add result row

					resultRows.add(row);
				}
				%>

				<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

				<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
			</c:when>
			<c:otherwise>

				<%
				User user2 = UserLocalServiceUtil.getUserById(userIdsArray[userIdsPos]);
				%>

				<liferay-ui:tabs names="<%= user2.getFullName() %>" />

				<%
				List permissions = PermissionLocalServiceUtil.getUserPermissions(user2.getUserId(), resource.getResourceId());

				List actions1 = ResourceActionsUtil.getResourceActions(company.getCompanyId(), portletResource, modelResource);
				List actions2 = ResourceActionsUtil.getActions(permissions);

				// Left list

				List leftList = new ArrayList();

				for (int i = 0; i < actions2.size(); i++) {
					String actionId = (String)actions2.get(i);

					leftList.add(new KeyValuePair(actionId, ResourceActionsUtil.getAction(pageContext, actionId)));
				}

				Collections.sort(leftList, new KeyValuePairComparator(false, true));

				// Right list

				List rightList = new ArrayList();

				for (int i = 0; i < actions1.size(); i++) {
					String actionId = (String)actions1.get(i);

					if (!actions2.contains(actionId)) {
						rightList.add(new KeyValuePair(actionId, ResourceActionsUtil.getAction(pageContext, actionId)));
					}
				}

				Collections.sort(rightList, new KeyValuePairComparator(false, true));
				%>

				<liferay-ui:input-move-boxes
					leftTitle='<%= LanguageUtil.get(pageContext, "current") %>'
					rightTitle='<%= LanguageUtil.get(pageContext, "available") %>'
					leftBoxName="current_actions"
					rightBoxName="available_actions"
					leftList="<%= leftList %>"
					rightList="<%= rightList %>"
				/>

				<br>

				<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td>
						<input class="portlet-form-button" <%= userIdsPos > 0 ? "" : "disabled" %> type="button" value='<%= LanguageUtil.get(pageContext, "previous") %>' onClick="<portlet:namespace />saveUserPermissions(<%= userIdsPos - 1 %>, '<%= userIdsArray[userIdsPos] %>');">

						<input class="portlet-form-button" <%= userIdsPos + 1 < userIdsArray.length ? "" : "disabled" %> type="button" value='<%= LanguageUtil.get(pageContext, "next") %>' onClick="<portlet:namespace />saveUserPermissions(<%= userIdsPos + 1 %>, '<%= userIdsArray[userIdsPos] %>');">
					</td>
					<td align="right">
						<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "finished") %>' onClick="<portlet:namespace />saveUserPermissions(-1, '<%= userIdsArray[userIdsPos] %>');">
					</td>
				</tr>
				</table>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test="<%= Validator.isNotNull(portletResource) || Validator.isNotNull(modelResource) %>">
		<c:if test="<%= Validator.isNull(modelResource) %>">
			<%= LanguageUtil.format(pageContext, "proceed-to-the-next-step-to-delegate-permissions-to-the-x-portlet-itself", portletResourceName) %>

			<br><br>

			<%
			portletURL.setParameter("editUserPermissions", "1");
			%>

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "next") %>' onClick="self.location = '<%= portletURL.toString() %>';">

			<%
			portletURL.setParameter("editUserPermissions", String.valueOf(editUserPermissions));
			%>

		</c:if>

		<c:if test="<%= (modelResources != null) && (modelResources.size() > 0) %>">
			<br><br>

			<liferay-ui:tabs names="resources" />

			<%= LanguageUtil.format(pageContext, "delegate-permissions-to-a-resource-that-belongs-to-the-x-portlet", portletResourceName) %>

			<br><br>

			<%
			SearchContainer searchContainer = new SearchContainer();

			List headerNames = new ArrayList();

			headerNames.add("name");

			searchContainer.setHeaderNames(headerNames);

			Collections.sort(modelResources, new ModelResourceComparator(company.getCompanyId(), locale));

			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < modelResources.size(); i++) {
				String curModelResource = (String)modelResources.get(i);

				ResultRow row = new ResultRow(curModelResource, curModelResource, i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/communities/edit_user_permissions");
				rowURL.setParameter("redirect", redirect);
				rowURL.setParameter("groupId", group.getGroupId());
				rowURL.setParameter("portletResource", portletResource);
				rowURL.setParameter("modelResource", curModelResource);

				// Name

				row.addText(ResourceActionsUtil.getModelResource(pageContext, curModelResource), rowURL);

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />
		</c:if>
	</c:when>
	<c:otherwise>

		<%
		List headerNames = new ArrayList();

		headerNames.add("portlet");

		SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

		List portlets = PortletLocalServiceUtil.getPortlets(company.getCompanyId(), false, false);

		Collections.sort(portlets, new PortletTitleComparator(application, locale));

		int total = portlets.size();

		searchContainer.setTotal(total);

		List results = ListUtil.subList(portlets, searchContainer.getStart(), searchContainer.getEnd());

		searchContainer.setResults(results);

		List resultRows = searchContainer.getResultRows();

		for (int i = 0; i < results.size(); i++) {
			Portlet portlet = (Portlet)results.get(i);

			ResultRow row = new ResultRow(portlet, portlet.getPrimaryKey().toString(), i);

			PortletURL rowURL = renderResponse.createRenderURL();

			rowURL.setWindowState(WindowState.MAXIMIZED);

			rowURL.setParameter("struts_action", "/communities/edit_user_permissions");
			rowURL.setParameter("redirect", redirect);
			rowURL.setParameter("groupId", group.getGroupId());
			rowURL.setParameter("portletResource", portlet.getPortletId());

			// Name

			row.addText(PortalUtil.getPortletTitle(portlet, application, locale), rowURL);

			// Add result row

			resultRows.add(row);
		}
		%>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
	</c:otherwise>
</c:choose>

</form>
