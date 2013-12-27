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

<%@ include file="/html/portlet/portlet_configuration/init.jsp" %>

<%
WindowState windowState = WindowState.MAXIMIZED;

if (themeDisplay.isStatePopUp()) {
	windowState = LiferayWindowState.POP_UP;
}

String tabs2 = ParamUtil.getString(request, "tabs2", "users");
String tabs3 = ParamUtil.getString(request, "tabs3", "current");

String cur = ParamUtil.getString(request, "cur");

String redirect = ParamUtil.getString(request, "redirect");

String portletResource = ParamUtil.getString(request, "portletResource");

String modelResource = ParamUtil.getString(request, "modelResource");
String modelResourceDescription = ParamUtil.getString(request, "modelResourceDescription");
String modelResourceName = ResourceActionsUtil.getModelResource(pageContext, modelResource);

String resourcePrimKey = ParamUtil.getString(request, "resourcePrimKey");

String selResource = modelResource;
String selResourceDescription = modelResourceDescription;
String selResourceName = modelResourceName;

if (Validator.isNull(modelResource)) {
	PortletURL portletURL = new PortletURLImpl(request, portletResource, plid, false);

	portletURL.setWindowState(WindowState.NORMAL);
	portletURL.setPortletMode(PortletMode.VIEW);

	redirect = portletURL.toString();

	Portlet portlet = PortletLocalServiceUtil.getPortletById(company.getCompanyId(), portletResource);

	selResource = portlet.getRootPortletId();
	selResourceDescription = PortalUtil.getPortletTitle(portlet, application, locale);
	selResourceName = LanguageUtil.get(pageContext, "portlet");
}

String ownerId = layout.getOwnerId();
String groupId = layout.getGroupId();

if (modelResource.equals(Layout.class.getName())) {
	int x = resourcePrimKey.indexOf("ownerId=");
	int y = resourcePrimKey.indexOf("}", x);

	ownerId = resourcePrimKey.substring(x + 8, y);
	groupId = LayoutImpl.getGroupId(ownerId);
}

Resource resource = null;

try {
	resource = ResourceLocalServiceUtil.getResource(company.getCompanyId(), selResource, ResourceImpl.TYPE_CLASS, ResourceImpl.SCOPE_INDIVIDUAL, resourcePrimKey);
}
catch (NoSuchResourceException nsre) {
	boolean portletActions = Validator.isNull(modelResource);

	ResourceLocalServiceUtil.addResources(company.getCompanyId(), groupId, null, selResource, resourcePrimKey, portletActions, true, true);

	resource = ResourceLocalServiceUtil.getResource(company.getCompanyId(), selResource, ResourceImpl.TYPE_CLASS, ResourceImpl.SCOPE_INDIVIDUAL, resourcePrimKey);
}

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(windowState);

portletURL.setParameter("struts_action", "/portlet_configuration/edit_permissions");
portletURL.setParameter("tabs2", tabs2);
portletURL.setParameter("tabs3", tabs3);
portletURL.setParameter("redirect", redirect);
portletURL.setParameter("portletResource", portletResource);
portletURL.setParameter("modelResource", modelResource);
portletURL.setParameter("modelResourceDescription", modelResourceDescription);
portletURL.setParameter("resourcePrimKey", resourcePrimKey);
%>

<script type="text/javascript">
	<c:if test="<%= themeDisplay.isStatePopUp() %>">
		function <portlet:namespace />resizeParent() {
			var box = document.getElementById("p_p_id_<%= portletDisplay.getId() %>_");
			parent.Alerts.resizeIframe({height: box.scrollHeight});
		}

		Event.addHandler(window, "onload", <portlet:namespace />resizeParent);
		Event.addHandler(document, "onclick", <portlet:namespace />resizeParent);
	</c:if>

	function <portlet:namespace />saveGroupPermissions() {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "group_permissions";
		document.<portlet:namespace />fm.<portlet:namespace />permissionsRedirect.value = "<%= portletURL.toString() %>";
		document.<portlet:namespace />fm.<portlet:namespace />groupIdActionIds.value = listSelect(document.<portlet:namespace />fm.<portlet:namespace />current_actions);
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= windowState.toString() %>"><portlet:param name="struts_action" value="/portlet_configuration/edit_permissions" /></portlet:actionURL>");
	}

	function <portlet:namespace />saveOrganizationPermissions(organizationIdsPos, organizationIdsPosValue) {

		<%
		PortletURL saveOrganizationPermissionsRedirectURL = PortletURLUtil.clone(portletURL, false, renderResponse);

		new OrganizationSearch(renderRequest, saveOrganizationPermissionsRedirectURL);
		%>

		var organizationIds = document.<portlet:namespace />fm.<portlet:namespace />organizationIds.value;

		if (organizationIdsPos == -1) {
			organizationIds = "";
			organizationIdsPos = 0;
		}

		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "organization_permissions";
		document.<portlet:namespace />fm.<portlet:namespace />permissionsRedirect.value = "<%= saveOrganizationPermissionsRedirectURL.toString() %>&<portlet:namespace />cur=<%= cur %>&<portlet:namespace />organizationIds=" + organizationIds + "&<portlet:namespace />organizationIdsPos=" + organizationIdsPos;
		document.<portlet:namespace />fm.<portlet:namespace />organizationIds.value = organizationIds;
		document.<portlet:namespace />fm.<portlet:namespace />organizationIdsPosValue.value = organizationIdsPosValue;
		document.<portlet:namespace />fm.<portlet:namespace />organizationIdActionIds.value = listSelect(document.<portlet:namespace />fm.<portlet:namespace />current_actions);
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= windowState.toString() %>"><portlet:param name="struts_action" value="/portlet_configuration/edit_permissions" /></portlet:actionURL>");
	}

	function <portlet:namespace />saveUserGroupPermissions(userGroupIdsPos, userGroupIdsPosValue) {

		<%
		PortletURL saveUserGroupPermissionsRedirectURL = PortletURLUtil.clone(portletURL, false, renderResponse);

		new UserGroupSearch(renderRequest, saveUserGroupPermissionsRedirectURL);
		%>

		var userGroupIds = document.<portlet:namespace />fm.<portlet:namespace />userGroupIds.value;

		if (userGroupIdsPos == -1) {
			userGroupIds = "";
			userGroupIdsPos = 0;
		}

		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "user_group_permissions";
		document.<portlet:namespace />fm.<portlet:namespace />permissionsRedirect.value = "<%= saveUserGroupPermissionsRedirectURL.toString() %>&<portlet:namespace />cur=<%= cur %>&<portlet:namespace />userGroupIds=" + userGroupIds + "&<portlet:namespace />userGroupIdsPos=" + userGroupIdsPos;
		document.<portlet:namespace />fm.<portlet:namespace />userGroupIds.value = userGroupIds;
		document.<portlet:namespace />fm.<portlet:namespace />userGroupIdsPosValue.value = userGroupIdsPosValue;
		document.<portlet:namespace />fm.<portlet:namespace />userGroupIdActionIds.value = listSelect(document.<portlet:namespace />fm.<portlet:namespace />current_actions);
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= windowState.toString() %>"><portlet:param name="struts_action" value="/portlet_configuration/edit_permissions" /></portlet:actionURL>");
	}

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
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= windowState.toString() %>"><portlet:param name="struts_action" value="/portlet_configuration/edit_permissions" /></portlet:actionURL>");
	}

	function <portlet:namespace />updateOrganizationPermissions() {
		document.<portlet:namespace />fm.<portlet:namespace />organizationIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />updateUserGroupPermissions() {
		document.<portlet:namespace />fm.<portlet:namespace />userGroupIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
		submitForm(document.<portlet:namespace />fm);
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
<input name="<portlet:namespace />resourceId" type="hidden" value="<%= resource.getResourceId() %>">

<c:choose>
	<c:when test="<%= Validator.isNull(modelResource) %>">
		<liferay-util:include page="/html/portlet/portlet_configuration/tabs1.jsp">
			<liferay-util:param name="tabs1" value="permissions" />
		</liferay-util:include>
	</c:when>
	<c:otherwise>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "edit-permissions-for") %> <%= selResourceName %>: <a href="<%= redirect %>"><%= selResourceDescription %></a>
			</td>
			<td align="right">
				&laquo; <a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "back") %></a>
			</td>
		</tr>
		</table>

		<br>
	</c:otherwise>
</c:choose>

<%
//String tabs2Names = "users,organizations,locations,user-groups,community,guest,associated";
String tabs2Names = "users,organizations,locations,user-groups,community,guest";

if (modelResource.equals(Organization.class.getName()) || modelResource.equals("com.liferay.portal.model.Location") || modelResource.equals("com.liferay.portal.model.Role") || modelResource.equals("com.liferay.portal.model.User")) {
	tabs2Names = StringUtil.replace(tabs2Names, "community,", StringPool.BLANK);
	tabs2Names = StringUtil.replace(tabs2Names, "guest,", StringPool.BLANK);
}
else if (modelResource.equals(Layout.class.getName())) {
	Group group = GroupLocalServiceUtil.getGroup(groupId);

	// User layouts should not have community assignments

	if (group.isUser()) {
		tabs2Names = StringUtil.replace(tabs2Names, "community,", StringPool.BLANK);
	}

	// Private layouts should not have guest assignments

	if (LayoutImpl.isPrivateLayout(ownerId)) {
		tabs2Names = StringUtil.replace(tabs2Names, "guest,", StringPool.BLANK);
	}
}
%>

<liferay-ui:tabs
	names="<%= tabs2Names %>"
	param="tabs2"
	url="<%= portletURL.toString() %>"
/>

<c:choose>
	<c:when test='<%= tabs2.equals("users") %>'>

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
					param="tabs3"
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

				if (tabs3.equals("current")) {
					userParams.put("permission", resource.getResourceId());
				}
				else if (tabs3.equals("available") && modelResource.equals(Layout.class.getName())) {
					String layoutGroupId = StringUtil.split(resourcePrimKey, ".")[1];

					layoutGroupId = StringUtil.replace(layoutGroupId, "}", "");

					userParams.put("usersGroups", layoutGroupId);
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
	<c:when test='<%= tabs2.equals("organizations") || tabs2.equals("locations") %>'>

		<%
		boolean rootOrganization = tabs2.equals("organizations");

		String organizationIds = ParamUtil.getString(request, "organizationIds");
		String[] organizationIdsArray = StringUtil.split(organizationIds);
		int organizationIdsPos = ParamUtil.getInteger(request, "organizationIdsPos");
		%>

		<input name="<portlet:namespace />organizationIds" type="hidden" value="<%= organizationIds %>">
		<input name="<portlet:namespace />organizationIdsPos" type="hidden" value="<%= organizationIdsPos %>">
		<input name="<portlet:namespace />organizationIdsPosValue" type="hidden" value="">
		<input name="<portlet:namespace />organizationIdActionIds" type="hidden" value="">

		<c:choose>
			<c:when test="<%= organizationIdsArray.length == 0 %>">
				<liferay-ui:tabs
					names="current,available"
					param="tabs3"
					url="<%= portletURL.toString() %>"
				/>

				<%
				OrganizationSearch searchContainer = new OrganizationSearch(renderRequest, portletURL);

				searchContainer.setRowChecker(new RowChecker(renderResponse));
				%>

				<liferay-ui:search-form
					page="/html/portlet/enterprise_admin/organization_search.jsp"
					searchContainer="<%= searchContainer %>"
				/>

				<%
				OrganizationSearchTerms searchTerms = (OrganizationSearchTerms)searchContainer.getSearchTerms();

				String parentOrganizationId = OrganizationImpl.DEFAULT_PARENT_ORGANIZATION_ID;
				String parentOrganizationComparator = StringPool.EQUAL;

				if (!rootOrganization) {
					parentOrganizationComparator = StringPool.NOT_EQUAL;
				}

				LinkedHashMap organizationParams = new LinkedHashMap();

				if (tabs3.equals("current")) {
					organizationParams.put("permissionsResourceId", resource.getResourceId());
					organizationParams.put("permissionsGroupId", groupId);
				}

				int total = OrganizationLocalServiceUtil.searchCount(company.getCompanyId(), parentOrganizationId, parentOrganizationComparator, searchTerms.getName(), searchTerms.getStreet(), searchTerms.getCity(), searchTerms.getZip(), searchTerms.getRegionId(), searchTerms.getCountryId(), organizationParams, searchTerms.isAndOperator());

				searchContainer.setTotal(total);

				List results = OrganizationLocalServiceUtil.search(company.getCompanyId(), parentOrganizationId, parentOrganizationComparator, searchTerms.getName(), searchTerms.getStreet(), searchTerms.getCity(), searchTerms.getZip(), searchTerms.getRegionId(), searchTerms.getCountryId(), organizationParams, searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd());

				searchContainer.setResults(results);
				%>

				<br><div class="beta-separator"></div><br>

				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "update-permissions") %>' onClick="<portlet:namespace />updateOrganizationPermissions();">

				<br><br>

				<%
				List headerNames = new ArrayList();

				headerNames.add("name");
				headerNames.add("city");
				headerNames.add("permissions");

				if (!rootOrganization) {
					headerNames.add("exclusive");
				}

				searchContainer.setHeaderNames(headerNames);

				if (!rootOrganization) {
					searchContainer.setEmptyResultsMessage(OrganizationSearch.EMPTY_RESULTS_MESSAGE_2);
				}

				List resultRows = searchContainer.getResultRows();

				for (int i = 0; i < results.size(); i++) {
					Organization organization = (Organization)results.get(i);

					ResultRow row = new ResultRow(organization, organization.getPrimaryKey().toString(), i);

					// Name

					row.addText(organization.getName());

					// Address

					Address address = organization.getAddress();

					row.addText(address.getCity());

					// Permissions

					boolean organizationIntersection = false;

					List permissions = PermissionLocalServiceUtil.getGroupPermissions(organization.getGroup().getGroupId(), resource.getResourceId());

					if (permissions.size() == 0) {
						permissions = PermissionLocalServiceUtil.getOrgGroupPermissions(organization.getOrganizationId(), groupId, resource.getResourceId());

						if (permissions.size() > 0) {
							organizationIntersection = true;
						}
					}

					List actions = ResourceActionsUtil.getActions(permissions);
					List actionsNames = ResourceActionsUtil.getActionsNames(pageContext, actions);

					row.addText(StringUtil.merge(actionsNames, ", "));

					if (!rootOrganization) {
						if (permissions.size() == 0) {
							row.addText(StringPool.BLANK);
						}
						else {
							row.addText(LanguageUtil.get(pageContext, (organizationIntersection ? "yes" : "no")));
						}
					}

					// Add result row

					resultRows.add(row);
				}
				%>

				<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

				<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
			</c:when>
			<c:otherwise>

				<%
				Organization organization = OrganizationLocalServiceUtil.getOrganization(organizationIdsArray[organizationIdsPos]);
				%>

				<liferay-ui:tabs names="<%= Html.escape(organization.getName(), false) %>" />

				<%
				boolean organizationIntersection = false;

				List permissions = PermissionLocalServiceUtil.getGroupPermissions(organization.getGroup().getGroupId(), resource.getResourceId());

				if (permissions.size() == 0) {
					permissions = PermissionLocalServiceUtil.getOrgGroupPermissions(organization.getOrganizationId(), groupId, resource.getResourceId());

					if (permissions.size() > 0) {
						organizationIntersection = true;
					}
				}

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
					formName="fm"
					leftTitle='<%= LanguageUtil.get(pageContext, "current") %>'
					rightTitle='<%= LanguageUtil.get(pageContext, "available") %>'
					leftBoxName="current_actions"
					rightBoxName="available_actions"
					leftList="<%= leftList %>"
					rightList="<%= rightList %>"
				/>

				<br>

				<c:choose>
					<c:when test='<%= rootOrganization %>'>
						<input name="<portlet:namespace />organizationIntersection" type="hidden" value="0">
					</c:when>
					<c:otherwise>
						<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<%= LanguageUtil.get(pageContext, "permission-exclusive-to-members-of-current-location-and-community") %>
							</td>
							<td style="padding-left: 10px;"></td>
							<td>
								<select name="<portlet:namespace />organizationIntersection">
									<option <%= organizationIntersection ? "selected" : "" %> value="1"><%= LanguageUtil.get(pageContext, "yes") %></option>
									<option <%= !organizationIntersection ? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "no") %></option>
								</select>
							</td>
						</tr>
						</table>

						<br>
					</c:otherwise>
				</c:choose>

				<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td>
						<input class="portlet-form-button" <%= organizationIdsPos > 0 ? "" : "disabled" %> type="button" value='<%= LanguageUtil.get(pageContext, "previous") %>' onClick="<portlet:namespace />saveOrganizationPermissions(<%= organizationIdsPos - 1 %>, '<%= organizationIdsArray[organizationIdsPos] %>');">

						<input class="portlet-form-button" <%= organizationIdsPos + 1 < organizationIdsArray.length ? "" : "disabled" %> type="button" value='<%= LanguageUtil.get(pageContext, "next") %>' onClick="<portlet:namespace />saveOrganizationPermissions(<%= organizationIdsPos + 1 %>, '<%= organizationIdsArray[organizationIdsPos] %>');">
					</td>
					<td align="right">
						<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "finished") %>' onClick="<portlet:namespace />saveOrganizationPermissions(-1, '<%= organizationIdsArray[organizationIdsPos] %>');">
					</td>
				</tr>
				</table>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test='<%= tabs2.equals("user-groups") %>'>

		<%
		String userGroupIds = ParamUtil.getString(request, "userGroupIds");
		String[] userGroupIdsArray = StringUtil.split(userGroupIds);
		int userGroupIdsPos = ParamUtil.getInteger(request, "userGroupIdsPos");
		%>

		<input name="<portlet:namespace />userGroupIds" type="hidden" value="<%= userGroupIds %>">
		<input name="<portlet:namespace />userGroupIdsPos" type="hidden" value="<%= userGroupIdsPos %>">
		<input name="<portlet:namespace />userGroupIdsPosValue" type="hidden" value="">
		<input name="<portlet:namespace />userGroupIdActionIds" type="hidden" value="">

		<c:choose>
			<c:when test="<%= userGroupIdsArray.length == 0 %>">
				<liferay-ui:tabs
					names="current,available"
					param="tabs3"
					url="<%= portletURL.toString() %>"
				/>

				<%
				UserGroupSearch searchContainer = new UserGroupSearch(renderRequest, portletURL);

				searchContainer.setRowChecker(new RowChecker(renderResponse));
				%>

				<liferay-ui:search-form
					page="/html/portlet/enterprise_admin/user_group_search.jsp"
					searchContainer="<%= searchContainer %>"
				/>

				<%
				UserGroupSearchTerms searchTerms = (UserGroupSearchTerms)searchContainer.getSearchTerms();

				LinkedHashMap userGroupParams = new LinkedHashMap();

				if (tabs3.equals("current")) {
					userGroupParams.put("permissionsResourceId", resource.getResourceId());
				}

				int total = UserGroupLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription(), userGroupParams);

				searchContainer.setTotal(total);

				List results = UserGroupLocalServiceUtil.search(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription(), userGroupParams, searchContainer.getStart(), searchContainer.getEnd());

				searchContainer.setResults(results);
				%>

				<br><div class="beta-separator"></div><br>

				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "update-permissions") %>' onClick="<portlet:namespace />updateUserGroupPermissions();">

				<br><br>

				<%
				List headerNames = new ArrayList();

				headerNames.add("name");
				headerNames.add("permissions");

				searchContainer.setHeaderNames(headerNames);

				List resultRows = searchContainer.getResultRows();

				for (int i = 0; i < results.size(); i++) {
					UserGroup userGroup = (UserGroup)results.get(i);

					ResultRow row = new ResultRow(userGroup, userGroup.getPrimaryKey().toString(), i);

					// Name

					row.addText(userGroup.getName());

					// Permissions

					List permissions = PermissionLocalServiceUtil.getGroupPermissions(userGroup.getGroup().getGroupId(), resource.getResourceId());

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
				UserGroup userGroup = UserGroupLocalServiceUtil.getUserGroup(userGroupIdsArray[userGroupIdsPos]);
				%>

				<liferay-ui:tabs names="<%= userGroup.getName() %>" />

				<%
				List permissions = PermissionLocalServiceUtil.getGroupPermissions(userGroup.getGroup().getGroupId(), resource.getResourceId());

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
					formName="fm"
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
						<input class="portlet-form-button" <%= userGroupIdsPos > 0 ? "" : "disabled" %> type="button" value='<%= LanguageUtil.get(pageContext, "previous") %>' onClick="<portlet:namespace />saveUserGroupPermissions(<%= userGroupIdsPos - 1 %>, '<%= userGroupIdsArray[userGroupIdsPos] %>');">

						<input class="portlet-form-button" <%= userGroupIdsPos + 1 < userGroupIdsArray.length ? "" : "disabled" %> type="button" value='<%= LanguageUtil.get(pageContext, "next") %>' onClick="<portlet:namespace />saveUserGroupPermissions(<%= userGroupIdsPos + 1 %>, '<%= userGroupIdsArray[userGroupIdsPos] %>');">
					</td>
					<td align="right">
						<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "finished") %>' onClick="<portlet:namespace />saveUserGroupPermissions(-1, '<%= userGroupIdsArray[userGroupIdsPos] %>');">
					</td>
				</tr>
				</table>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test='<%= tabs2.equals("community") || tabs2.equals("guest") %>'>

		<%
		Group group = null;

		if (tabs2.equals("community")) {
			group = GroupLocalServiceUtil.getGroup(groupId);
		}
		else {
			group = GroupLocalServiceUtil.getGroup(company.getCompanyId(), GroupImpl.GUEST);
		}
		%>

		<input name="<portlet:namespace />groupId" type="hidden" value="<%= group.getGroupId() %>">
		<input name="<portlet:namespace />groupIdActionIds" type="hidden" value="">

		<%
		List permissions = PermissionLocalServiceUtil.getGroupPermissions(group.getGroupId(), resource.getResourceId());

		List actions1 = ResourceActionsUtil.getResourceActions(company.getCompanyId(), portletResource, modelResource);
		List actions2 = ResourceActionsUtil.getActions(permissions);

		List guestUnsupportedActions = ResourceActionsUtil.getResourceGuestUnsupportedActions(portletResource, modelResource);

		// Left list

		List leftList = new ArrayList();

		for (int i = 0; i < actions2.size(); i++) {
			String actionId = (String)actions2.get(i);

			if (!tabs2.equals("guest") || (tabs2.equals("guest") && !guestUnsupportedActions.contains(actionId))) {
				leftList.add(new KeyValuePair(actionId, ResourceActionsUtil.getAction(pageContext, actionId)));
			}
		}

		Collections.sort(leftList, new KeyValuePairComparator(false, true));

		// Right list

		List rightList = new ArrayList();

		for (int i = 0; i < actions1.size(); i++) {
			String actionId = (String)actions1.get(i);

			if (!tabs2.equals("guest") || (tabs2.equals("guest") && !guestUnsupportedActions.contains(actionId))) {
				if (!actions2.contains(actionId)) {
					rightList.add(new KeyValuePair(actionId, ResourceActionsUtil.getAction(pageContext, actionId)));
				}
			}
		}

		Collections.sort(rightList, new KeyValuePairComparator(false, true));
		%>

		<liferay-ui:input-move-boxes
			formName="fm"
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
			<td align="right">
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveGroupPermissions();">
			</td>
		</tr>
		</table>
	</c:when>
	<c:when test='<%= false && tabs2.equals("associated") %>'>

		<%
		String selectedActionId = ParamUtil.getString(request, "selectedActionId");
		%>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "list-users-with-the-permission-to-perform-the-action") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select name="<portlet:namespace />selectedActionId">

					<%
					List actions = ResourceActionsUtil.getResourceActions(company.getCompanyId(), portletResource, modelResource);

					Collections.sort(actions, new ActionComparator(company.getCompanyId(), locale));

					for (int i = 0; i < actions.size(); i++) {
						String actionId = (String)actions.get(i);

						if (selectedActionId.equals("")) {
							selectedActionId = actionId;
						}

						%>
						<option <%= actionId.equals(selectedActionId) ? "selected" : "" %> value="<%= actionId %>"><%= ResourceActionsUtil.getAction(pageContext, actionId) %></option>
					<%
					}
					%>

				</select>
			</td>
		</tr>
		</table>

		<br>

		<%
		portletURL.setParameter("selectedActionId", selectedActionId);

		UserSearch searchContainer = new UserSearch(renderRequest, portletURL);
		%>

		<liferay-ui:search-form
			page="/html/portlet/enterprise_admin/user_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<%
		UserSearchTerms searchTerms = (UserSearchTerms)searchContainer.getSearchTerms();

		int total = UserLocalServiceUtil.getPermissionUsersCount(company.getCompanyId(), groupId, modelResource, resourcePrimKey, selectedActionId, searchTerms.getFirstName(), searchTerms.getMiddleName(), searchTerms.getLastName(), searchTerms.getEmailAddress(), searchTerms.isAndOperator());

		searchContainer.setTotal(total);

		List results = UserLocalServiceUtil.getPermissionUsers(company.getCompanyId(), groupId, modelResource, resourcePrimKey, selectedActionId, searchTerms.getFirstName(), searchTerms.getMiddleName(), searchTerms.getLastName(), searchTerms.getEmailAddress(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd());

		searchContainer.setResults(results);
		%>

		<br><div class="beta-separator"></div><br>

		<%
		List headerNames = new ArrayList();

		headerNames.add("name");
		headerNames.add("email-address");

		searchContainer.setHeaderNames(headerNames);

		List resultRows = searchContainer.getResultRows();

		for (int i = 0; i < results.size(); i++) {
			User user2 = (User)results.get(i);

			ResultRow row = new ResultRow(user2, user2.getPrimaryKey().toString(), i);

			// Name and email address

			row.addText(user2.getFullName());
			row.addText(user2.getEmailAddress());

			// Add result row

			resultRows.add(row);
		}
		%>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
	</c:when>
</c:choose>

</form>
