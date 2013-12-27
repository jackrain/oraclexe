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
String redirect = ParamUtil.getString(request, "redirect");

Address address = (Address)request.getAttribute(WebKeys.ADDRESS);

String addressId = BeanParamUtil.getString(address, request, "addressId");

String className = BeanParamUtil.getString(address, request, "className");
String classPK = BeanParamUtil.getString(address, request, "classPK");

String regionId = BeanParamUtil.getString(address, request, "regionId");
String countryId = BeanParamUtil.getString(address, request, "countryId");
String typeId = BeanParamUtil.getString(address, request, "typeId");
%>

<script type="text/javascript">
	function <portlet:namespace />saveAddress() {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= address == null ? Constants.ADD : Constants.UPDATE %>";
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_address" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />saveAddress(); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= redirect %>">
<input name="<portlet:namespace />addressId" type="hidden" value="<%= addressId %>">
<input name="<portlet:namespace />className" type="hidden" value="<%= className %>">
<input name="<portlet:namespace />classPK" type="hidden" value="<%= classPK %>">

<liferay-ui:tabs names="address" />

<liferay-ui:error exception="<%= AddressCityException.class %>" message="please-enter-a-valid-city" />
<liferay-ui:error exception="<%= AddressStreetException.class %>" message="please-enter-a-valid-street" />
<liferay-ui:error exception="<%= AddressZipException.class %>" message="please-enter-a-valid-zip" />
<liferay-ui:error exception="<%= NoSuchCountryException.class %>" message="please-select-a-country" />
<liferay-ui:error exception="<%= NoSuchRegionException.class %>" message="please-select-a-region" />
<liferay-ui:error exception="<%= NoSuchListTypeException.class %>" message="please-select-a-type" />

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td valign="top">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "street1") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Address.class %>" bean="<%= address %>" field="street1" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "street2") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Address.class %>" bean="<%= address %>" field="street2" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "street3") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Address.class %>" bean="<%= address %>" field="street3" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "city") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Address.class %>" bean="<%= address %>" field="city" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "zip") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Address.class %>" bean="<%= address %>" field="zip" />
			</td>
		</tr>
		</table>
	</td>
	<td style="padding-left: 30px;"></td>
	<td valign="top">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "country") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select id="<portlet:namespace />countryId" name="<portlet:namespace />countryId">
					<option value=""></option>

					<%
					List countries = CountryServiceUtil.getCountries(true);

					for (int i = 0; i < countries.size(); i++) {
						Country country = (Country)countries.get(i);
					%>

						<option <%= country.getCountryId().equals(countryId) ? "selected" : "" %> value="<%= country.getCountryId() %>"><%= LanguageUtil.get(pageContext, country.getName()) %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "region") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select id="<portlet:namespace />regionId" name="<portlet:namespace />regionId">
					<option value=""></option>

					<%
					List regions = RegionServiceUtil.getRegions(countryId);

					for (int i = 0; i < regions.size(); i++) {
						Region region = (Region)regions.get(i);
					%>

						<option <%= region.getRegionId().equals(regionId) ? "selected" : "" %> value="<%= region.getRegionId() %>"><%= LanguageUtil.get(pageContext, region.getName()) %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "type") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select name="<portlet:namespace />typeId">
					<option value=""></option>

					<%
					List addressTypes = ListTypeServiceUtil.getListTypes(className + ListTypeImpl.ADDRESS);

					for (int i = 0; i < addressTypes.size(); i++) {
						ListType suffix = (ListType)addressTypes.get(i);
					%>

						<option <%= suffix.getListTypeId().equals(typeId) ? "selected" : "" %> value="<%= suffix.getListTypeId() %>"><%= LanguageUtil.get(pageContext, suffix.getName()) %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "mailing") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Address.class %>" bean="<%= address %>" field="mailing" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "primary") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= Address.class %>" bean="<%= address %>" field="primary" />
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "save") %>'>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />street1.focus();

	function <portlet:namespace />selectCountryPost() {
		setSelectedValue(document.<portlet:namespace />fm.<portlet:namespace />regionId, "<%= regionId %>");
	}

	DynamicSelect.create(
		"<%= themeDisplay.getPathMain() %>/portal/json_regions",
		document.<portlet:namespace />fm.<portlet:namespace />countryId,
		document.<portlet:namespace />fm.<portlet:namespace />regionId,
		<portlet:namespace />selectCountryPost
	)
</script>
