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

<%
String strutsAction = ParamUtil.getString(request, "struts_action");
%>

<form method="post" name="<portlet:namespace />fm">

<liferay-ui:tabs names='<%= rootOrganization ? "organizations" : "locations" %>' />

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(LiferayWindowState.POP_UP);

portletURL.setParameter("struts_action", strutsAction);

OrganizationSearch searchContainer = new OrganizationSearch(renderRequest, portletURL);
%>

<liferay-ui:search-form
	page="/html/portlet/enterprise_admin/organization_search.jsp"
	searchContainer="<%= searchContainer %>"
/>

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
%>

<br><div class="beta-separator"></div><br>

<%
List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
	Organization organization = (Organization)results.get(i);

	ResultRow row = new ResultRow(organization, organization.getPrimaryKey().toString(), i);

	StringBuffer sb = new StringBuffer();

	sb.append("javascript: opener.");
	sb.append(renderResponse.getNamespace());
	sb.append("select");

	if (rootOrganization) {
		sb.append("Organization");
	}
	else {
		sb.append("Location");
	}

	sb.append("('");
	sb.append(organization.getOrganizationId());
	sb.append("', '");
	sb.append(UnicodeFormatter.toString(organization.getName()));
	sb.append("'); window.close();");

	String rowHREF = sb.toString();

	// Name

	row.addText(organization.getName(), rowHREF);

	// Address

	Address address = organization.getAddress();

	row.addText(address.getCity(), rowHREF);
	row.addText(address.getRegion().getName(), rowHREF);
	row.addText(address.getCountry().getName(), rowHREF);

	// Add result row

	resultRows.add(row);
}
%>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />name.focus();
</script>
