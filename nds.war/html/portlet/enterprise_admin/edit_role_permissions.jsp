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

<%@ include file="/html/portlet/enterprise_admin/init.jsp" %>

<%
tabs1 = "roles";
String tabs2 = ParamUtil.getString(request, "tabs2", "current");

String cur = ParamUtil.getString(request, "cur");

Role role = (Role)request.getAttribute(WebKeys.ROLE);

String portletResource = ParamUtil.getString(request, "portletResource");
String modelResource = ParamUtil.getString(request, "modelResource");

String portletResourceName = null;

if (Validator.isNotNull(portletResource)) {
	Portlet portlet = PortletLocalServiceUtil.getPortletById(company.getCompanyId(), portletResource);

	portletResourceName = PortalUtil.getPortletTitle(portlet, application, locale);
}

String modelResourceName = ResourceActionsUtil.getModelResource(pageContext, modelResource);

String selResource = modelResource;
String selResourceName = modelResourceName;

if (Validator.isNull(modelResource)) {
	selResource = portletResource;
	selResourceName = portletResourceName;
}

int groupScopePos = ParamUtil.getInteger(request, "groupScopePos");
String groupScopeActionIds = ParamUtil.getString(request, "groupScopeActionIds");
String[] groupScopeActionIdsArray = StringUtil.split(groupScopeActionIds);

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/enterprise_admin/edit_role_permissions");
portletURL.setParameter("tabs1", tabs1);
portletURL.setParameter("tabs2", tabs2);
portletURL.setParameter("roleId", role.getRoleId());
portletURL.setParameter("portletResource", portletResource);
portletURL.setParameter("modelResource", modelResource);

// Breadcrumbs

PortletURL breadcrumbsURL = renderResponse.createRenderURL();

breadcrumbsURL.setWindowState(WindowState.MAXIMIZED);

breadcrumbsURL.setParameter("struts_action", "/enterprise_admin/view");
breadcrumbsURL.setParameter("tabs1", tabs1);
breadcrumbsURL.setParameter("roleId", role.getRoleId());

String breadcrumbs = "<a href=\"" + breadcrumbsURL.toString() + "\">" + LanguageUtil.get(pageContext, "roles") + "</a> &raquo; ";

breadcrumbsURL.setParameter("struts_action", "/enterprise_admin/edit_role_permissions");

breadcrumbs += "<a href=\"" + breadcrumbsURL.toString() + "\">" + role.getName() + "</a>";

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
	function <portlet:namespace />updateActions() {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "actions";
		document.<portlet:namespace />fm.<portlet:namespace />redirect.value = "<%= portletURL.toString() %>";
		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />updateGroupPermissions(groupScopePos) {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "group_permissions";

		var redirect = "";

		if (groupScopePos == -1) {
			redirect = "<%= portletURL.toString() %>";
		}
		else if (groupScopePos == <%= groupScopeActionIdsArray.length %>) {
			redirect = "<%= portletURL.toString() %>&<portlet:namespace />groupScopePos=-1";
		}
		else {
			redirect = "<%= portletURL.toString() %>&<portlet:namespace />groupScopePos=" +
				groupScopePos + "&<portlet:namespace />groupScopeActionIds=<%= groupScopeActionIds %>";

			if (groupScopePos == <%= groupScopePos %>) {
				redirect += "&<portlet:namespace />cur=<%= cur %>";
			}
		}

		document.<portlet:namespace />fm.<portlet:namespace />redirect.value = redirect;
		document.<portlet:namespace />fm.<portlet:namespace />addGroupIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
		document.<portlet:namespace />fm.<portlet:namespace />removeGroupIds.value = listUncheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_role_permissions" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />tabs2" type="hidden" value="<%= tabs2 %>">
<input name="<portlet:namespace />redirect" type="hidden" value="">
<input name="<portlet:namespace />roleId" type="hidden" value="<%= role.getRoleId() %>">
<input name="<portlet:namespace />portletResource" type="hidden" value="<%= portletResource %>">
<input name="<portlet:namespace />modelResource" type="hidden" value="<%= modelResource %>">
<input name="<portlet:namespace />groupScopePos" type="hidden" value="<%= groupScopePos %>">
<input name="<portlet:namespace />groupScopeActionIds" type="hidden" value="<%= groupScopeActionIds %>">

<liferay-util:include page="/html/portlet/enterprise_admin/tabs1.jsp">
	<liferay-util:param name="tabs1" value="<%= tabs1 %>" />
</liferay-util:include>

<c:choose>
	<c:when test="<%= groupScopePos == -1 %>">
		<%= breadcrumbs %>

		<br><br>

		<%= LanguageUtil.format(pageContext, "you-have-successfully-updated-role-x-with-the-following-permissions", "<b>" + role.getName() + "</b>") %>

		<br><br>

		<%
		SearchContainer searchContainer = new SearchContainer();

		List headerNames = new ArrayList();

		headerNames.add("resource");
		headerNames.add("action");
		headerNames.add("scope");
		headerNames.add("communities");

		searchContainer.setHeaderNames(headerNames);

		List results = ResourceActionsUtil.getResourceActions(company.getCompanyId(), portletResource, modelResource);

		Collections.sort(results, new ActionComparator(company.getCompanyId(), locale));

		List resultRows = searchContainer.getResultRows();

		for (int i = 0; i < results.size(); i++) {
			String actionId = (String)results.get(i);

			ResultRow row = new ResultRow(actionId, actionId, i);

			boolean hasCompanyScope = PermissionLocalServiceUtil.hasRolePermission(role.getRoleId(), company.getCompanyId(), selResource, ResourceImpl.TYPE_CLASS, ResourceImpl.SCOPE_COMPANY, actionId);
			boolean hasGroupScope = PermissionLocalServiceUtil.hasRolePermission(role.getRoleId(), company.getCompanyId(), selResource, ResourceImpl.TYPE_CLASS, ResourceImpl.SCOPE_GROUP, actionId);

			row.addText(selResourceName);
			row.addText(ResourceActionsUtil.getAction(pageContext, actionId));

			if (hasCompanyScope) {
				row.addText(LanguageUtil.get(pageContext, "enterprise"));
				row.addText(LanguageUtil.get(pageContext, "not-available"));
			}
			else if (hasGroupScope) {
				row.addText(LanguageUtil.get(pageContext, "community"));

				StringBuffer sb = new StringBuffer();

				LinkedHashMap groupParams = new LinkedHashMap();

				List rolePermissions = new ArrayList();

				rolePermissions.add(selResource);
				rolePermissions.add(ResourceImpl.TYPE_CLASS);
				rolePermissions.add(ResourceImpl.SCOPE_GROUP);
				rolePermissions.add(actionId);
				rolePermissions.add(role.getRoleId());

				groupParams.put("rolePermissions", rolePermissions);

				List groups = GroupLocalServiceUtil.search(company.getCompanyId(), null, null, groupParams, QueryUtil.ALL_POS, QueryUtil.ALL_POS);

				for (int j = 0; j < groups.size(); j++) {
					Group group = (Group)groups.get(j);

					sb.append(group.getName());

					if ((j + 1) != groups.size()) {
						sb.append(", ");
					}
				}

				row.addText(sb.toString());
			}

			if (hasCompanyScope || hasGroupScope) {
				resultRows.add(row);
			}
		}
		%>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<br>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "finished") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/view" /><portlet:param name="tabs1" value="roles" /></portlet:renderURL>';">
	</c:when>
	<c:when test="<%= (groupScopePos >= 0) && (groupScopeActionIdsArray.length > 0) %>">
		<input name="<portlet:namespace />addGroupIds" type="hidden" value="">
		<input name="<portlet:namespace />removeGroupIds" type="hidden" value="">

		<%= breadcrumbs %>

		<br><br>

		<%
		String actionId = groupScopeActionIdsArray[groupScopePos];

		portletURL.setParameter("groupScopePos", String.valueOf(groupScopePos));
		portletURL.setParameter("groupScopeActionIds", groupScopeActionIds);
		%>

		<%= LanguageUtil.format(pageContext, "select-communities-associated-with-the-action-x", "<b>" + ResourceActionsUtil.getAction(pageContext, actionId) + "</b>") %>

		<br><br>

		<liferay-ui:tabs
			names="current,available"
			param="tabs2"
			url="<%= portletURL.toString() %>"
		/>

		<%
		GroupSearch searchContainer = new GroupSearch(renderRequest, portletURL);

		searchContainer.setRowChecker(new GroupPermissionChecker(renderResponse, role, selResource, actionId));
		%>

		<liferay-ui:search-form
			page="/html/portlet/enterprise_admin/group_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<%
		GroupSearchTerms searchTerms = (GroupSearchTerms)searchContainer.getSearchTerms();

		LinkedHashMap groupParams = new LinkedHashMap();

		if (tabs2.equals("current")) {
			List rolePermissions = new ArrayList();

			rolePermissions.add(selResource);
			rolePermissions.add(ResourceImpl.TYPE_CLASS);
			rolePermissions.add(ResourceImpl.SCOPE_GROUP);
			rolePermissions.add(actionId);
			rolePermissions.add(role.getRoleId());

			groupParams.put("rolePermissions", rolePermissions);
		}

		int total = GroupLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription(), groupParams);

		searchContainer.setTotal(total);

		List results = GroupLocalServiceUtil.search(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription(), groupParams, searchContainer.getStart(), searchContainer.getEnd());

		searchContainer.setResults(results);
		%>

		<br><div class="beta-separator"></div><br>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "update-associations") %>' onClick="<portlet:namespace />updateGroupPermissions(<%= groupScopePos %>);">

		<br><br>

		<%
		List resultRows = searchContainer.getResultRows();

		for (int i = 0; i < results.size(); i++) {
			Group group = (Group)results.get(i);

			ResultRow row = new ResultRow(group, group.getPrimaryKey().toString(), i);

			// Name

			row.addText(group.getName());

			// Add result row

			resultRows.add(row);
		}
		%>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

		<br>

		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td>
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "previous") %>' onClick="<portlet:namespace />updateGroupPermissions(<%= groupScopePos - 1 %>);">

				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "next") %>' onClick="<portlet:namespace />updateGroupPermissions(<%= groupScopePos + 1 %>);">
			</td>
		</tr>
		</table>
	</c:when>
	<c:when test="<%= Validator.isNotNull(portletResource) || Validator.isNotNull(modelResource) %>">
		<%= breadcrumbs %>

		<br><br>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "action") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= LanguageUtil.get(pageContext, "scope") %>
			</td>
		</tr>

		<%
		List actions = ResourceActionsUtil.getResourceActions(company.getCompanyId(), portletResource, modelResource);

		Collections.sort(actions, new ActionComparator(company.getCompanyId(), locale));

		for (int i = 0; i < actions.size(); i++) {
			String actionId = (String)actions.get(i);

			boolean hasCompanyScope = PermissionLocalServiceUtil.hasRolePermission(role.getRoleId(), company.getCompanyId(), selResource, ResourceImpl.TYPE_CLASS, ResourceImpl.SCOPE_COMPANY, actionId);
			boolean hasGroupScope = PermissionLocalServiceUtil.hasRolePermission(role.getRoleId(), company.getCompanyId(), selResource, ResourceImpl.TYPE_CLASS, ResourceImpl.SCOPE_GROUP, actionId);
		%>

			<tr>
				<td>
					<%= ResourceActionsUtil.getAction(pageContext, actionId) %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<select name="<portlet:namespace />scope<%= actionId %>">
						<option value=""></option>
						<option <%= hasCompanyScope ? "selected" : "" %> value="<%= ResourceImpl.SCOPE_COMPANY %>"><%= LanguageUtil.get(pageContext, "enterprise") %></option>

						<c:if test="<%= !portletResource.equals(PortletKeys.ENTERPRISE_ADMIN) && !portletResource.equals(PortletKeys.PORTAL) %>">
							<option <%= hasGroupScope ? "selected" : "" %> value="<%= ResourceImpl.SCOPE_GROUP %>"><%= LanguageUtil.get(pageContext, "community") %></option>
						</c:if>
					</select>
				</td>
			</tr>

		<%
		}
		%>

		</table>

		<br>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "next") %>' onClick="<portlet:namespace />updateActions();">

		<c:if test="<%= Validator.isNull(modelResource) %>">

			<%
			List modelResources = ResourceActionsUtil.getPortletModelResources(portletResource);
			%>

			<c:if test="<%= modelResources.size() > 0 %>">
				<br><br>

				<liferay-ui:tabs names="resources" />

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

					rowURL.setParameter("struts_action", "/enterprise_admin/edit_role_permissions");
					rowURL.setParameter("roleId", role.getRoleId());
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
		</c:if>
	</c:when>
	<c:otherwise>

		<%
		List headerNames = new ArrayList();

		headerNames.add("portlet");

		SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

		List portlets = PortletLocalServiceUtil.getPortlets(company.getCompanyId(), false, true);

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

			rowURL.setParameter("struts_action", "/enterprise_admin/edit_role_permissions");
			rowURL.setParameter("roleId", role.getRoleId());
			rowURL.setParameter("portletResource", portlet.getPortletId());

			// Name

			row.addText(PortalUtil.getPortletTitle(portlet, application, locale), rowURL);

			// Add result row

			resultRows.add(row);
		}
		%>

		<%= breadcrumbs %>

		<br><br>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
	</c:otherwise>
</c:choose>

</form>
