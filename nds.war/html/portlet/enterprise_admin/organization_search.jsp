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
OrganizationSearch searchContainer = (OrganizationSearch)request.getAttribute("liferay-ui:search:searchContainer");

OrganizationDisplayTerms displayTerms = (OrganizationDisplayTerms)searchContainer.getDisplayTerms();
%>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "name") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "street") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "city") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "zip") %>
	</td>
</tr>
<tr>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= OrganizationDisplayTerms.NAME %>" size="20" type="text" value="<%= displayTerms.getName() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= OrganizationDisplayTerms.STREET %>" size="20" type="text" value="<%= displayTerms.getStreet() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= OrganizationDisplayTerms.CITY %>" size="20" type="text" value="<%= displayTerms.getCity() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= OrganizationDisplayTerms.ZIP %>" size="20" type="text" value="<%= displayTerms.getZip() %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "country") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "region") %>
	</td>
	<td colspan="4"></td>
</tr>
<tr>
	<td>
		<select id="<portlet:namespace /><%= OrganizationDisplayTerms.COUNTRY_ID %>" name="<portlet:namespace /><%= OrganizationDisplayTerms.COUNTRY_ID %>">
			<option value=""></option>

			<%
			List countries = CountryServiceUtil.getCountries(true);

			for (int i = 0; i < countries.size(); i++) {
				Country country = (Country)countries.get(i);
			%>

				<option <%= country.getCountryId().equals(displayTerms.getCountryId()) ? "selected" : "" %> value="<%= country.getCountryId() %>"><%= LanguageUtil.get(pageContext, country.getName()) %></option>

			<%
			}
			%>

		</select>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<select id="<portlet:namespace /><%= OrganizationDisplayTerms.REGION_ID %>" name="<portlet:namespace /><%= OrganizationDisplayTerms.REGION_ID %>">
			<option value=""></option>

			<%
			List regions = RegionServiceUtil.getRegions(displayTerms.getCountryId());

			for (int i = 0; i < regions.size(); i++) {
				Region region = (Region)regions.get(i);
			%>

				<option <%= region.getRegionId().equals(displayTerms.getRegionId()) ? "selected" : "" %> value="<%= region.getRegionId() %>"><%= LanguageUtil.get(pageContext, region.getName()) %></option>

			<%
			}
			%>

		</select>
	</td>
	<td colspan="4"></td>
</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<select name="<portlet:namespace /><%= OrganizationDisplayTerms.AND_OPERATOR %>">
			<option <%= displayTerms.isAndOperator() ? "selected" : "" %> value="1"><%= LanguageUtil.get(pageContext, "and") %></option>
			<option <%= !displayTerms.isAndOperator() ? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "or") %></option>
		</select>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">
	</td>
</tr>
</table>

<%
Organization organization = null;

if (Validator.isNotNull(displayTerms.getParentOrganizationId())) {
	try {
		organization = OrganizationLocalServiceUtil.getOrganization(displayTerms.getParentOrganizationId());
	}
	catch (NoSuchOrganizationException nsoe) {
	}
}
%>

<c:if test="<%= organization != null %>">
	<input name="<portlet:namespace /><%= UserDisplayTerms.ORGANIZATION_ID %>" type="hidden" value="<%= organization.getOrganizationId() %>">

	<br>

	<%= LanguageUtil.get(pageContext, "filter-by-" + (organization.isRoot() ? "organization" : "location")) %>: <%= organization.getName() %><br>
</c:if>

<script type="text/javascript">
	function <portlet:namespace />selectCountryPost() {
		document.<portlet:namespace />fm.<portlet:namespace /><%= OrganizationDisplayTerms.REGION_ID %>.options[0] = new Option("", "");
		document.<portlet:namespace />fm.<portlet:namespace /><%= OrganizationDisplayTerms.REGION_ID %>.selectedIndex = 0;
	}

	DynamicSelect.create(
		"<%= themeDisplay.getPathMain() %>/portal/json_regions",
		document.<portlet:namespace />fm.<portlet:namespace /><%= OrganizationDisplayTerms.COUNTRY_ID %>,
		document.<portlet:namespace />fm.<portlet:namespace /><%= OrganizationDisplayTerms.REGION_ID %>,
		<portlet:namespace />selectCountryPost,
		"nullable=1"
	)
</script>
