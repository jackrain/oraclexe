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
boolean rootOrganization = tabs1.equals("organizations");

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/enterprise_admin/view");
portletURL.setParameter("tabs1", tabs1);
%>

<script type="text/javascript">
	function <portlet:namespace />deleteOrganizations() {
		if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-" + (rootOrganization ? "organizations" : "locations")) %>')) {
			document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.DELETE %>";
			document.<portlet:namespace />fm.<portlet:namespace />deleteOrganizationIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
			submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_organization" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:actionURL>");
		}
	}

	function <portlet:namespace />deleteUserGroups() {
		if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-user-groups") %>')) {
			document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.DELETE %>";
			document.<portlet:namespace />fm.<portlet:namespace />deleteUserGroupIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
			submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_user_group" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:actionURL>");
		}
	}

	function <portlet:namespace />deleteUsers(cmd) {
		var deleteUsers = true;

		if (cmd == "<%= Constants.DEACTIVATE %>") {
			if (!confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-deactivate-the-selected-users") %>')) {
				deleteUsers = false;
			}
		}
		else if (cmd == "<%= Constants.DELETE %>") {
			if (!confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-permanently-delete-the-selected-users") %>')) {
				deleteUsers = false;
			}
		}

		if (deleteUsers) {
			document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = cmd;
			document.<portlet:namespace />fm.<portlet:namespace />deleteUserIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
			submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_user" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:actionURL>");
		}
	}
</script>

<form action="<%= portletURL.toString() %>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= currentURL %>">

<liferay-util:include page="/html/portlet/enterprise_admin/tabs1.jsp" />

<c:choose>
	<c:when test='<%= tabs1.equals("users") %>'>
		<input name="<portlet:namespace />deleteUserIds" type="hidden" value="">

		<liferay-ui:error exception="<%= RequiredUserException.class %>" message="you-cannot-delete-or-deactivate-yourself" />

		<%
		UserSearch searchContainer = new UserSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(StringPool.BLANK);

		if (portletName.equals(PortletKeys.ENTERPRISE_ADMIN) || portletName.equals(PortletKeys.LOCATION_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN)) {
			RowChecker rowChecker = new RowChecker(renderResponse);
			//RowChecker rowChecker = new RowChecker(renderResponse, RowChecker.FORM_NAME, null, RowChecker.ROW_IDS);

			searchContainer.setRowChecker(rowChecker);
		}
		%>

		<liferay-ui:search-form
			page="/html/portlet/enterprise_admin/user_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">

			<%
			UserSearchTerms searchTerms = (UserSearchTerms)searchContainer.getSearchTerms();

			String organizationId = DAOParamUtil.getString(request, "organizationId");

			if (portletName.equals(PortletKeys.LOCATION_ADMIN)) {
				String locationId = user.getLocation().getOrganizationId();

				organizationId = locationId;
			}
			else if (portletName.equals(PortletKeys.ORGANIZATION_ADMIN)) {
				String parentOrganizationId = user.getOrganization().getOrganizationId();

				if (Validator.isNull(organizationId) || organizationId.equals(parentOrganizationId)) {
					organizationId = parentOrganizationId;
				}
				else {
					try {
						Organization location = OrganizationLocalServiceUtil.getOrganization(organizationId);

						if (!location.getParentOrganizationId().equals(parentOrganizationId)) {
							organizationId = parentOrganizationId;
						}
					}
					catch (Exception e) {
						organizationId = parentOrganizationId;
					}
				}
			}

			LinkedHashMap userParams = new LinkedHashMap();

			userParams.put("usersOrgs", organizationId);

			int total = UserLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getFirstName(), searchTerms.getMiddleName(), searchTerms.getLastName(), searchTerms.getEmailAddress(), searchTerms.isActive(), userParams, searchTerms.isAndOperator());

			searchContainer.setTotal(total);

			List results = UserLocalServiceUtil.search(company.getCompanyId(), searchTerms.getFirstName(), searchTerms.getMiddleName(), searchTerms.getLastName(), searchTerms.getEmailAddress(), searchTerms.isActive(), userParams, searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), new ContactLastNameComparator(true));

			searchContainer.setResults(results);
			%>

			<br><div class="beta-separator"></div><br>

			<c:if test="<%= portletName.equals(PortletKeys.ENTERPRISE_ADMIN) || portletName.equals(PortletKeys.LOCATION_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN) %>">
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_user" /></portlet:renderURL>';">

				<c:if test="<%= searchTerms.isActive() || (!searchTerms.isActive() && GetterUtil.getBoolean(PropsUtil.get(PropsUtil.USERS_DELETE))) %>">
					<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, (searchTerms.isActive() ? Constants.DEACTIVATE : Constants.DELETE)) %>' onClick="<portlet:namespace />deleteUsers('<%= searchTerms.isActive() ? Constants.DEACTIVATE : Constants.DELETE %>');">
				</c:if>

				<c:if test="<%= !searchTerms.isActive() %>">
					<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "restore") %>' onClick="<portlet:namespace />deleteUsers('<%= Constants.RESTORE %>');">
				</c:if>

				<br><br>
			</c:if>

			<%
			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				User user2 = (User)results.get(i);

				ResultRow row = new ResultRow(user2, user2.getPrimaryKey().toString(), i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/enterprise_admin/edit_user");
				rowURL.setParameter("p_u_i_d", user2.getUserId());

				// Name and job title

				Contact contact2 = user2.getContact();

				row.addText(user2.getFullName(), rowURL);
				row.addText(contact2.getJobTitle(), rowURL);

				// Organization or location

				Organization location = user2.getLocation();

				if (Validator.isNull(location.getOrganizationId())) {
					location = user2.getOrganization();
				}

				row.addText(location.getName(), rowURL);

				// City

				Address address = location.getAddress();

				row.addText(address.getCity(), rowURL);

				// Region

				String regionName = address.getRegion().getName();

				if (Validator.isNull(regionName)) {
					try {
						Region region = RegionServiceUtil.getRegion(location.getRegionId());

						regionName = LanguageUtil.get(pageContext, region.getName());
					}
					catch (NoSuchRegionException nsce) {
					}
				}

				row.addText(regionName, rowURL);

				// Country

				String countryName = address.getCountry().getName();

				if (Validator.isNull(countryName)) {
					try {
						Country country = CountryServiceUtil.getCountry(location.getCountryId());

						countryName = LanguageUtil.get(pageContext, country.getName());
					}
					catch (NoSuchCountryException nsce) {
					}
				}

				row.addText(countryName, rowURL);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/enterprise_admin/user_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
		</c:if>
	</c:when>
	<c:when test='<%= tabs1.equals("organizations") || tabs1.equals("locations") %>'>
		<input name="<portlet:namespace />deleteOrganizationIds" type="hidden" value="">

		<c:choose>
			<c:when test="<%= rootOrganization %>">
				<liferay-ui:error exception="<%= RequiredOrganizationException.class %>" message="you-cannot-delete-organizations-that-have-locations-or-users" />
			</c:when>
			<c:otherwise>
				<liferay-ui:error exception="<%= RequiredOrganizationException.class %>" message="you-cannot-delete-locations-that-have-users" />
			</c:otherwise>
		</c:choose>

		<%
		boolean showSearch = false;

		if (rootOrganization && (portletName.equals(PortletKeys.LOCATION_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN))) {
		}
		else if (!rootOrganization && portletName.equals(PortletKeys.LOCATION_ADMIN)) {
		}
		else {
			showSearch = true;
		}

		boolean showButtons = false;

		if (portletName.equals(PortletKeys.ENTERPRISE_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN)) {
			if (rootOrganization && portletName.equals(PortletKeys.ORGANIZATION_ADMIN)) {
			}
			else {
				showButtons = true;
			}
		}

		OrganizationSearch searchContainer = new OrganizationSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(StringPool.BLANK);

		if (showButtons) {
			RowChecker rowChecker = new RowChecker(renderResponse);

			searchContainer.setRowChecker(rowChecker);
		}
		%>

		<c:if test="<%= showSearch %>">
			<liferay-ui:search-form
				page="/html/portlet/enterprise_admin/organization_search.jsp"
				searchContainer="<%= searchContainer %>"
			/>
		</c:if>

		<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) || !showSearch %>">

			<%
			OrganizationSearchTerms searchTerms = (OrganizationSearchTerms)searchContainer.getSearchTerms();

			int total = 0;
			List results = null;

			if (rootOrganization && (portletName.equals(PortletKeys.LOCATION_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN))) {
				total = 1;

				searchContainer.setTotal(total);

				results = new ArrayList();

				results.add(user.getOrganization());
			}
			else if (!rootOrganization && portletName.equals(PortletKeys.LOCATION_ADMIN)) {
				total = 1;

				searchContainer.setTotal(total);

				results = new ArrayList();

				results.add(user.getLocation());
			}
			else {
				String parentOrganizationId = OrganizationImpl.DEFAULT_PARENT_ORGANIZATION_ID;
				String parentOrganizationComparator = StringPool.EQUAL;

				if (!rootOrganization) {
					if (portletName.equals(PortletKeys.ORGANIZATION_ADMIN)) {
						parentOrganizationId = user.getOrganization().getOrganizationId();
						parentOrganizationComparator = StringPool.EQUAL;
					}
					else {
						parentOrganizationId = ParamUtil.getString(request, "parentOrganizationId", OrganizationImpl.DEFAULT_PARENT_ORGANIZATION_ID);

						if (Validator.isNull(parentOrganizationId)) {
							parentOrganizationId = OrganizationImpl.DEFAULT_PARENT_ORGANIZATION_ID;
						}

						if (parentOrganizationId.equals(OrganizationImpl.DEFAULT_PARENT_ORGANIZATION_ID)) {
							parentOrganizationComparator = StringPool.NOT_EQUAL;
						}
					}
				}

				total = OrganizationLocalServiceUtil.searchCount(company.getCompanyId(), parentOrganizationId, parentOrganizationComparator, searchTerms.getName(), searchTerms.getStreet(), searchTerms.getCity(), searchTerms.getZip(), searchTerms.getRegionId(), searchTerms.getCountryId(), null, searchTerms.isAndOperator());

				searchContainer.setTotal(total);

				results = OrganizationLocalServiceUtil.search(company.getCompanyId(), parentOrganizationId, parentOrganizationComparator, searchTerms.getName(), searchTerms.getStreet(), searchTerms.getCity(), searchTerms.getZip(), searchTerms.getRegionId(), searchTerms.getCountryId(), null, searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd());
			}

			searchContainer.setResults(results);

			if (!rootOrganization) {
				searchContainer.setEmptyResultsMessage(OrganizationSearch.EMPTY_RESULTS_MESSAGE_2);
			}
			%>

			<c:if test="<%= showSearch %>">
				<br><div class="beta-separator"></div><br>
			</c:if>

			<c:if test="<%= showButtons %>">
				<c:if test="<%= (rootOrganization && PortalPermission.contains(permissionChecker, ActionKeys.ADD_ORGANIZATION)) || !rootOrganization %>">
					<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value='<%= "/enterprise_admin/edit_" + (rootOrganization ? "organization" : "location") %>' /></portlet:renderURL>';">
				</c:if>

				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "delete") %>' onClick="<portlet:namespace />deleteOrganizations();">

				<br><br>
			</c:if>

			<%
			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				Organization organization = (Organization)results.get(i);

				ResultRow row = new ResultRow(organization, organization.getPrimaryKey().toString(), i);

				String strutsAction = "/enterprise_admin/edit_organization";

				if (!organization.isRoot()) {
					strutsAction = "/enterprise_admin/edit_location";
				}

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", strutsAction);
				rowURL.setParameter("organizationId", organization.getOrganizationId());

				// Name

				row.addText(organization.getName(), rowURL);

				// City

				Address address = organization.getAddress();

				row.addText(address.getCity(), rowURL);

				// Region

				String regionName = address.getRegion().getName();

				if (Validator.isNull(regionName)) {
					try {
						Region region = RegionServiceUtil.getRegion(organization.getRegionId());

						regionName = LanguageUtil.get(pageContext, region.getName());
					}
					catch (NoSuchRegionException nsce) {
					}
				}

				row.addText(regionName, rowURL);

				// Country

				String countryName = address.getCountry().getName();

				if (Validator.isNull(countryName)) {
					try {
						Country country = CountryServiceUtil.getCountry(organization.getCountryId());

						countryName = LanguageUtil.get(pageContext, country.getName());
					}
					catch (NoSuchCountryException nsce) {
					}
				}

				row.addText(countryName, rowURL);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/enterprise_admin/organization_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
		</c:if>
	</c:when>
	<c:when test='<%= tabs1.equals("user-groups") %>'>
		<input name="<portlet:namespace />deleteUserGroupIds" type="hidden" value="">

		<liferay-ui:error exception="<%= RequiredUserGroupException.class %>" message="you-cannot-delete-user-groups-that-have-users" />

		<%
		UserGroupSearch searchContainer = new UserGroupSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(StringPool.BLANK);

		RowChecker rowChecker = new RowChecker(renderResponse);

		searchContainer.setRowChecker(rowChecker);
		%>

		<liferay-ui:search-form
			page="/html/portlet/enterprise_admin/user_group_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">

			<%
			UserGroupSearchTerms searchTerms = (UserGroupSearchTerms)searchContainer.getSearchTerms();

			int total = UserGroupLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription(), null);

			searchContainer.setTotal(total);

			List results = UserGroupLocalServiceUtil.search(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription(), null, searchContainer.getStart(), searchContainer.getEnd());

			searchContainer.setResults(results);
			%>

			<br><div class="beta-separator"></div><br>

			<c:if test="<%= portletName.equals(PortletKeys.ENTERPRISE_ADMIN) && PortalPermission.contains(permissionChecker, ActionKeys.ADD_USER_GROUP) %>">
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_user_group" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>';">
			</c:if>

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "delete") %>' onClick="<portlet:namespace />deleteUserGroups();">

			<br><br>

			<%
			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				UserGroup userGroup = (UserGroup)results.get(i);

				ResultRow row = new ResultRow(userGroup, userGroup.getPrimaryKey().toString(), i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/enterprise_admin/edit_user_group");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("userGroupId", userGroup.getUserGroupId());

				// Name

				row.addText(userGroup.getName(), rowURL);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/enterprise_admin/user_group_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
		</c:if>
	</c:when>
	<c:when test='<%= tabs1.equals("roles") %>'>
		<liferay-ui:error exception="<%= RequiredRoleException.class %>" message="you-cannot-delete-a-system-role" />

		<%
		RoleSearch searchContainer = new RoleSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(StringPool.BLANK);
		%>

		<liferay-ui:search-form
			page="/html/portlet/enterprise_admin/role_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">

			<%
			RoleSearchTerms searchTerms = (RoleSearchTerms)searchContainer.getSearchTerms();

			int total = RoleLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription());

			searchContainer.setTotal(total);

			List results = RoleLocalServiceUtil.search(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription(), searchContainer.getStart(), searchContainer.getEnd());

			searchContainer.setResults(results);
			%>

			<br><div class="beta-separator"></div><br>

			<c:if test="<%= portletName.equals(PortletKeys.ENTERPRISE_ADMIN) && PortalPermission.contains(permissionChecker, ActionKeys.ADD_ROLE) %>">
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_role" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>';">

				<br><br>
			</c:if>

			<%
			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				Role role = (Role)results.get(i);

				ResultRow row = new ResultRow(role, role.getPrimaryKey().toString(), i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/enterprise_admin/edit_role");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("roleId", role.getRoleId());

				// Name

				row.addText(role.getName(), rowURL);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/enterprise_admin/role_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
		</c:if>
	</c:when>
</c:choose>

</form>

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		document.<portlet:namespace />fm.<portlet:namespace /><%= tabs1.equals("users") ? "firstName" : "name" %>.focus();
	</script>
</c:if>
