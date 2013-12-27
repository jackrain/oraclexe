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
String tabs1 = ParamUtil.getString(request, "tabs1", "users");
String tabs2 = ParamUtil.getString(request, "tabs2", "current");

String cur = ParamUtil.getString(request, "cur");

String redirect = ParamUtil.getString(request, "redirect");

Group group = (Group)request.getAttribute(WebKeys.GROUP);

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/communities/edit_community_assignments");
portletURL.setParameter("tabs1", tabs1);
portletURL.setParameter("tabs2", tabs2);
portletURL.setParameter("redirect", redirect);
portletURL.setParameter("groupId", group.getGroupId());
%>

<script type="text/javascript">
	function <portlet:namespace />updateGroupOrganizations(redirect) {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "group_organizations";
		document.<portlet:namespace />fm.<portlet:namespace />redirect.value = redirect;
		document.<portlet:namespace />fm.<portlet:namespace />addOrganizationIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
		document.<portlet:namespace />fm.<portlet:namespace />removeOrganizationIds.value = listUncheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/communities/edit_community_assignments" /></portlet:actionURL>");
	}

	function <portlet:namespace />updateGroupUserGroups(redirect) {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "group_user_groups";
		document.<portlet:namespace />fm.<portlet:namespace />redirect.value = redirect;
		document.<portlet:namespace />fm.<portlet:namespace />addUserGroupIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
		document.<portlet:namespace />fm.<portlet:namespace />removeUserGroupIds.value = listUncheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/communities/edit_community_assignments" /></portlet:actionURL>");
	}

	function <portlet:namespace />updateGroupUsers(redirect) {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "group_users";
		document.<portlet:namespace />fm.<portlet:namespace />redirect.value = redirect;
		document.<portlet:namespace />fm.<portlet:namespace />addUserIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
		document.<portlet:namespace />fm.<portlet:namespace />removeUserIds.value = listUncheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/communities/edit_community_assignments" /></portlet:actionURL>");
	}
</script>

<form action="<%= portletURL.toString() %>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />tabs1" type="hidden" value="<%= tabs1 %>">
<input name="<portlet:namespace />tabs2" type="hidden" value="<%= tabs2 %>">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= redirect %>">
<input name="<portlet:namespace />groupId" type="hidden" value="<%= group.getGroupId() %>">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "edit-assignments-for-community") %>: <%= group.getName() %>
	</td>
	<td align="right">
		&laquo; <a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "back") %></a>
	</td>
</tr>
</table>

<br>

<liferay-ui:tabs
	names="users,organizations,locations,user-groups"
	param="tabs1"
	url="<%= portletURL.toString() %>"
/>

<c:choose>
	<c:when test='<%= tabs1.equals("users") %>'>
		<input name="<portlet:namespace />addUserIds" type="hidden" value="">
		<input name="<portlet:namespace />removeUserIds" type="hidden" value="">

		<liferay-ui:tabs
			names="current,available"
			param="tabs2"
			url="<%= portletURL.toString() %>"
		/>

		<%
		UserSearch searchContainer = new UserSearch(renderRequest, portletURL);

		searchContainer.setRowChecker(new UserGroupChecker(renderResponse, group));
		%>

		<liferay-ui:search-form
			page="/html/portlet/enterprise_admin/user_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<%
		UserSearchTerms searchTerms = (UserSearchTerms)searchContainer.getSearchTerms();

		LinkedHashMap userParams = new LinkedHashMap();

		if (tabs2.equals("current")) {
			userParams.put("usersGroups", group.getGroupId());
		}

		int total = UserLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getFirstName(), searchTerms.getMiddleName(), searchTerms.getLastName(), searchTerms.getEmailAddress(), searchTerms.isActive(), userParams, searchTerms.isAndOperator());

		searchContainer.setTotal(total);

		List results = UserLocalServiceUtil.search(company.getCompanyId(), searchTerms.getFirstName(), searchTerms.getMiddleName(), searchTerms.getLastName(), searchTerms.getEmailAddress(), searchTerms.isActive(), userParams, searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd(), new ContactLastNameComparator(true));

		searchContainer.setResults(results);
		%>

		<br><div class="beta-separator"></div><br>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "update-associations") %>' onClick="<portlet:namespace />updateGroupUsers('<%= portletURL.toString() %>&<portlet:namespace />cur=<%= cur %>');">

		<br><br>

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
	<c:when test='<%= tabs1.equals("organizations") || tabs1.equals("locations") %>'>
		<input name="<portlet:namespace />addOrganizationIds" type="hidden" value="">
		<input name="<portlet:namespace />removeOrganizationIds" type="hidden" value="">

		<liferay-ui:tabs
			names="current,available"
			param="tabs2"
			url="<%= portletURL.toString() %>"
		/>

		<%
		OrganizationSearch searchContainer = new OrganizationSearch(renderRequest, portletURL);

		searchContainer.setRowChecker(new OrganizationGroupChecker(renderResponse, group));
		%>

		<liferay-ui:search-form
			page="/html/portlet/enterprise_admin/organization_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<%
		boolean rootOrganization = tabs1.equals("organizations");

		OrganizationSearchTerms searchTerms = (OrganizationSearchTerms)searchContainer.getSearchTerms();

		String parentOrganizationId = OrganizationImpl.DEFAULT_PARENT_ORGANIZATION_ID;
		String parentOrganizationComparator = StringPool.EQUAL;

		if (!rootOrganization) {
			parentOrganizationComparator = StringPool.NOT_EQUAL;
		}

		LinkedHashMap organizationParams = new LinkedHashMap();

		if (tabs2.equals("current")) {
			organizationParams.put("organizationsGroups", group.getGroupId());
		}

		int total = OrganizationLocalServiceUtil.searchCount(company.getCompanyId(), parentOrganizationId, parentOrganizationComparator, searchTerms.getName(), searchTerms.getStreet(), searchTerms.getCity(), searchTerms.getZip(), searchTerms.getRegionId(), searchTerms.getCountryId(), organizationParams, searchTerms.isAndOperator());

		searchContainer.setTotal(total);

		List results = OrganizationLocalServiceUtil.search(company.getCompanyId(), parentOrganizationId, parentOrganizationComparator, searchTerms.getName(), searchTerms.getStreet(), searchTerms.getCity(), searchTerms.getZip(), searchTerms.getRegionId(), searchTerms.getCountryId(), organizationParams, searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd());

		searchContainer.setResults(results);
		%>

		<br><div class="beta-separator"></div><br>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "update-associations") %>' onClick="<portlet:namespace />updateGroupOrganizations('<%= portletURL.toString() %>&<portlet:namespace />cur=<%= cur %>');">

		<br><br>

		<%
		List headerNames = new ArrayList();

		headerNames.add("name");
		headerNames.add("city");

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

			// Add result row

			resultRows.add(row);
		}
		%>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
	</c:when>
	<c:when test='<%= tabs1.equals("user-groups") %>'>
		<input name="<portlet:namespace />addUserGroupIds" type="hidden" value="">
		<input name="<portlet:namespace />removeUserGroupIds" type="hidden" value="">

		<liferay-ui:tabs
			names="current,available"
			param="tabs2"
			url="<%= portletURL.toString() %>"
		/>

		<%
		UserGroupSearch searchContainer = new UserGroupSearch(renderRequest, portletURL);

		searchContainer.setRowChecker(new UserGroupGroupChecker(renderResponse, group));
		%>

		<liferay-ui:search-form
			page="/html/portlet/enterprise_admin/user_group_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<%
		UserGroupSearchTerms searchTerms = (UserGroupSearchTerms)searchContainer.getSearchTerms();

		LinkedHashMap userGroupParams = new LinkedHashMap();

		if (tabs2.equals("current")) {
			userGroupParams.put("userGroupsGroups", group.getGroupId());
		}

		int total = UserGroupLocalServiceUtil.searchCount(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription(), userGroupParams);

		searchContainer.setTotal(total);

		List results = UserGroupLocalServiceUtil.search(company.getCompanyId(), searchTerms.getName(), searchTerms.getDescription(), userGroupParams, searchContainer.getStart(), searchContainer.getEnd());

		searchContainer.setResults(results);
		%>

		<br><div class="beta-separator"></div><br>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "update-associations") %>' onClick="<portlet:namespace />updateGroupUserGroups('<%= portletURL.toString() %>&<portlet:namespace />cur=<%= cur %>');">

		<br><br>

		<%
		List headerNames = new ArrayList();

		headerNames.add("name");

		searchContainer.setHeaderNames(headerNames);

		List resultRows = searchContainer.getResultRows();

		for (int i = 0; i < results.size(); i++) {
			UserGroup userGroup = (UserGroup)results.get(i);

			ResultRow row = new ResultRow(userGroup, userGroup.getPrimaryKey().toString(), i);

			// Name

			row.addText(userGroup.getName());

			// Add result row

			resultRows.add(row);
		}
		%>

		<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

		<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
	</c:when>
</c:choose>

</form>
