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

<%@ include file="/html/portlet/layout_configuration/init.jsp" %>

<%
PortletCategory portletCategory = (PortletCategory)request.getAttribute(WebKeys.PORTLET_CATEGORY);

String oldCategoryPath = (String)request.getAttribute(WebKeys.PORTLET_CATEGORY_PATH);

String newCategoryPath = LanguageUtil.get(pageContext, portletCategory.getName());

if (Validator.isNotNull(oldCategoryPath)) {
	newCategoryPath = oldCategoryPath + ":" + newCategoryPath;
}

List categories = ListUtil.fromCollection(portletCategory.getCategories());

Collections.sort(categories, new PortletCategoryComparator(company.getCompanyId(), locale));

List portlets = new ArrayList();

Iterator itr1 = portletCategory.getPortlets().iterator();

while (itr1.hasNext()) {
	String portletId = (String)itr1.next();

	Portlet portlet = PortletLocalServiceUtil.getPortletById(user.getCompanyId(), portletId);

	if (portlet != null) {
		if (portlet.isSystem()) {
		}
		else if (!portlet.isActive()) {
		}
		else if (!portlet.isInstanceable() && layoutTypePortlet.hasPortletId(portlet.getPortletId())) {
		}
		else if (!portlet.hasAddPortletPermission(user.getUserId())) {
		}
		else {
			portlets.add(portlet);
		}
	}
}

Collections.sort(portlets, new PortletTitleComparator(application, locale));

if ((categories.size() > 0) || (portlets.size() > 0)) {
%>

	<div class="layout_configuration_category" id="<%= newCategoryPath %>">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td>
				<div style="padding: 2px; font-weight: bold;">
					<a href="javascript: void(0);" onClick="LayoutConfiguration.toggleCategory(this);">
					<img src="<%= themeDisplay.getPathThemeImage() + "/arrows/01_right.gif" %>" /> <%= LanguageUtil.get(pageContext, portletCategory.getName()) %>
					</a>
				</div>
			</td>
		</tr>
		<tr>
			<td style="padding-left: 20px;">
				<div class="layout_configuration_category_pane" style="display: none;">

					<%
					Iterator itr2 = categories.iterator();

					while (itr2.hasNext()) {
						request.setAttribute(WebKeys.PORTLET_CATEGORY, itr2.next());
						request.setAttribute(WebKeys.PORTLET_CATEGORY_PATH, newCategoryPath);
					%>

						<liferay-util:include page="/html/portlet/layout_configuration/view_category.jsp" />

					<%
						request.setAttribute(WebKeys.PORTLET_CATEGORY_PATH, oldCategoryPath);
					}

					itr2 = portlets.iterator();

					while (itr2.hasNext()) {
						Portlet portlet = (Portlet)itr2.next();
					%>

						<div class="layout_configuration_portlet" id="<%= newCategoryPath %>:<%= PortalUtil.getPortletTitle(portlet, application, locale) %>">
							<table border="0" cellpadding="2" cellspacing="0" width="100%">
							<tr>
								<td width="99%">
									<%= PortalUtil.getPortletTitle(portlet, application, locale) %>
								</td>
								<td align="right">
									<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "add") %>"
										onClick="
											addPortlet('<%= plid %>', '<%= portlet.getPortletId() %>', '<%= themeDisplay.getDoAsUserId() %>');

											if (<%= !portlet.isInstanceable() %>) {
												var div = document.getElementById('<%= StringUtil.replace(newCategoryPath + ":" + PortalUtil.getPortletTitle(portlet, application, locale), "'", "\\'") %>');

												div.parentNode.removeChild(div);
											};"
									>
								</td>
							</tr>
							</table>
						</div>

					<%
					}
					%>

				</div>
			</td>
		</tr>
		</table>
	</div>

<%
}
%>
