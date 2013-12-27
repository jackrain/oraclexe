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
String tabs2 = ParamUtil.getString(request, "tabs2", "public");
String tabs3 = ParamUtil.getString(request, "tabs3", "page");

String redirect = ParamUtil.getString(request, "redirect");

Group group = (Group)request.getAttribute(WebKeys.GROUP);

String groupId = group.getGroupId();

String selPlid = ParamUtil.getString(request, "selPlid", LayoutImpl.DEFAULT_PARENT_LAYOUT_ID);
String layoutId = LayoutImpl.getLayoutId(selPlid);
String ownerId = LayoutImpl.getOwnerId(selPlid);

boolean privateLayout = tabs2.equals("private");

if (Validator.isNull(ownerId)) {
	if (privateLayout) {
		ownerId = LayoutImpl.PRIVATE + groupId;
	}
	else {
		ownerId = LayoutImpl.PUBLIC + groupId;
	}
}

Layout selLayout = null;

try {
	selLayout = LayoutLocalServiceUtil.getLayout(layoutId, ownerId);
}
catch (NoSuchLayoutException nsle) {
}

if (selLayout != null) {
	if (!PortalUtil.isLayoutParentable(selLayout) && tabs3.equals("children")) {
		tabs3 = "page";
	}
	else if (tabs3.equals("import-export") || (tabs3.equals("virtual-host"))) {
		tabs3 = "page";
	}
}

if (selLayout == null) {
	if (tabs3.equals("page")) {
		tabs3 = "children";
	}
}

String parentLayoutId = BeanParamUtil.getString(selLayout, request,  "parentLayoutId", LayoutImpl.DEFAULT_PARENT_LAYOUT_ID);

LayoutLister layoutLister = new LayoutLister();

String rootNodeName = group.isUser() ? contact.getFullName() : group.getName();
LayoutView layoutView = layoutLister.getLayoutView(ownerId, rootNodeName, locale);

List layoutList = layoutView.getList();

request.setAttribute(WebKeys.LAYOUT_LISTER_LIST, layoutList);

PortletURL portletURL = renderResponse.createRenderURL();

if (themeDisplay.isStatePopUp()) {
	portletURL.setWindowState(LiferayWindowState.POP_UP);
}
else {
	portletURL.setWindowState(WindowState.MAXIMIZED);
}

portletURL.setParameter("struts_action", "/communities/edit_pages");
portletURL.setParameter("tabs2", tabs2);
portletURL.setParameter("tabs3", tabs3);
portletURL.setParameter("redirect", redirect);
portletURL.setParameter("groupId", groupId);
%>

<script type="text/javascript">
	function <portlet:namespace />deletePage() {
		if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-page") %>')) {
			document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.DELETE %>";
			document.<portlet:namespace />fm.<portlet:namespace />pagesRedirect.value = "<%= portletURL.toString() %>&<portlet:namespace />selPlid=<%= ownerId + StringPool.PERIOD + parentLayoutId %>";
			submitForm(document.<portlet:namespace />fm);
		}
	}

	function <portlet:namespace />importPages() {
		document.<portlet:namespace />fm.encoding = "multipart/form-data";
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL><portlet:param name="struts_action" value="/communities/import_pages" /><portlet:param name="ownerId" value="<%= ownerId %>" /></portlet:actionURL>");
	}

	<c:if test="<%= themeDisplay.isStatePopUp() %>">
		function <portlet:namespace />resizeParent() {
			var box = document.getElementById("p_p_id_<%= portletDisplay.getId() %>_");
			parent.Alerts.resizeIframe({height: box.scrollHeight});
		}

		Event.addHandler(window, "onload", <portlet:namespace />resizeParent);
		Event.addHandler(document, "onclick", <portlet:namespace />resizeParent);
	</c:if>

	function <portlet:namespace />savePage() {
		<c:choose>
			<c:when test='<%= tabs3.equals("virtual-host") %>'>
				document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "virtual_host";
			</c:when>
			<c:otherwise>
				document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = '<%= tabs3.equals("children") ? Constants.ADD : Constants.UPDATE %>';
			</c:otherwise>
		</c:choose>

		if (document.<portlet:namespace />fm.<portlet:namespace />languageId) {
			document.<portlet:namespace />fm.<portlet:namespace />pagesRedirect.value += "&<portlet:namespace />languageId=" + document.<portlet:namespace />fm.<portlet:namespace />languageId.value;
		}

		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />updateDisplayOrder() {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "display_order";
		document.<portlet:namespace />fm.<portlet:namespace />layoutIds.value = listSelect(document.<portlet:namespace />fm.<portlet:namespace />layoutIdsBox);
		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />updateLookAndFeel(themeId, colorSchemeId) {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "look_and_feel";

		var themeRadio = document.<portlet:namespace />fm.<portlet:namespace />themeId;

		if (themeRadio.length) {
			themeRadio[getSelectedIndex(themeRadio)].value = themeId;
		}
		else {
			themeRadio.value = themeId;
		}

		var colorSchemeRadio = document.<portlet:namespace />fm.<portlet:namespace />colorSchemeId;

		if (colorSchemeRadio.length) {
			colorSchemeRadio[getSelectedIndex(colorSchemeRadio)].value = colorSchemeId;
		}
		else {
			colorSchemeRadio.value = colorSchemeId;
		}

		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/communities/edit_pages" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />savePage(); return false;">
<input name="<portlet:namespace />tabs2" type="hidden" value="<%= tabs2 %>">
<input name="<portlet:namespace />tabs3" type="hidden" value="<%= tabs3 %>">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />pagesRedirect" type="hidden" value="<%= portletURL.toString() %>&<portlet:namespace />selPlid=<%= selPlid %>">
<input name="<portlet:namespace />groupId" type="hidden" value="<%= groupId %>">
<input name="<portlet:namespace />selPlid" type="hidden" value="<%= selPlid %>">
<input name="<portlet:namespace />layoutId" type="hidden" value="<%= layoutId %>">
<input name="<portlet:namespace />ownerId" type="hidden" value="<%= ownerId %>">
<input name="<portlet:namespace />privateLayout" type="hidden" value="<%= privateLayout %>">

<c:if test="<%= portletName.equals(PortletKeys.COMMUNITIES) || portletName.equals(PortletKeys.MY_ACCOUNT) %>">
	<c:if test="<%= portletName.equals(PortletKeys.COMMUNITIES) %>">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "edit-pages-for-community") %>: <%= group.getName() %>
			</td>
			<td align="right">
				&laquo; <a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "back") %></a>
			</td>
		</tr>
		</table>

		<br>
	</c:if>

	<liferay-util:include page="/html/portlet/my_account/tabs1.jsp">
		<liferay-util:param name="tabs1" value="pages" />
	</liferay-util:include>

	<liferay-ui:tabs
		names="public,private"
		param="tabs2"
		url="<%= portletURL.toString() %>"
	/>
</c:if>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td valign="top">
		<div id="<%= renderResponse.getNamespace() %>tree-output"></div>

		<%@ include file="/html/portlet/communities/tree_js.jsp" %>

		<script type="text/javascript">
			var layoutsTree = new Tree("layoutsTree", layoutsArray, layoutsIcons, "gamma");

			layoutsTree.create("<%= SessionTreeJSClicks.getOpenNodes(request, "layoutsTree") %>");

			document.getElementById("<%= renderResponse.getNamespace() %>tree-output").innerHTML = layoutsTree.getHTML();
		</script>
	</td>
	<td style="padding-left: 10px;"></td>
	<td valign="top" width="75%">

		<%
		PortletURL breadcrumbURL = PortletURLUtil.clone(portletURL, false, renderResponse);
		%>

		<c:choose>
			<c:when test="<%= selLayout != null %>">
				<%= LanguageUtil.get(pageContext, "edit-" + (privateLayout ? "private" : "public") + "-page") %>: <a href="<%= breadcrumbURL.toString() %>"><%= rootNodeName %></a> &raquo; <liferay-ui:breadcrumb selLayout="<%= selLayout %>" selLayoutParam="selPlid" portletURL="<%= breadcrumbURL %>" />
			</c:when>
			<c:otherwise>
				<%= LanguageUtil.get(pageContext, "manage-top-" + (privateLayout ? "private" : "public") + "-pages-for") %>: <a href="<%= breadcrumbURL.toString() %>"><%= rootNodeName %></a>
			</c:otherwise>
		</c:choose>

		<br><br>

		<%
		String tabs3Names = "page,children,look-and-feel";

		if ((selLayout != null) && !PortalUtil.isLayoutParentable(selLayout)) {
			tabs3Names = StringUtil.replace(tabs3Names, "children,", StringPool.BLANK);
		}

		if (selLayout == null) {
			tabs3Names = StringUtil.replace(tabs3Names, "page,", StringPool.BLANK);

			if (GroupPermission.contains(permissionChecker, groupId, ActionKeys.UPDATE)) {
				tabs3Names += ",import-export,virtual-host";
			}
		}
		%>

		<liferay-ui:tabs
			names="<%= tabs3Names %>"
			param="tabs3"
			url='<%= portletURL.toString() + "&" + renderResponse.getNamespace() + "selPlid=" + selPlid %>'
		/>

		<liferay-ui:error exception="<%= LayoutFriendlyURLException.class %>">

			<%
			LayoutFriendlyURLException lfurle = (LayoutFriendlyURLException)errorException;
			%>

			<c:if test="<%= lfurle.getType() == LayoutFriendlyURLException.DOES_NOT_START_WITH_SLASH %>">
				<%= LanguageUtil.get(pageContext, "please-enter-a-friendly-url-that-begins-with-a-slash") %>
			</c:if>

			<c:if test="<%= lfurle.getType() == LayoutFriendlyURLException.ENDS_WITH_SLASH %>">
				<%= LanguageUtil.get(pageContext, "please-enter-a-friendly-url-that-does-not-end-with-a-slash") %>
			</c:if>

			<c:if test="<%= lfurle.getType() == LayoutFriendlyURLException.TOO_SHORT %>">
				<%= LanguageUtil.get(pageContext, "please-enter-a-friendly-url-that-is-at-least-two-characters-long") %>
			</c:if>

			<c:if test="<%= lfurle.getType() == LayoutFriendlyURLException.ADJACENT_SLASHES %>">
				<%= LanguageUtil.get(pageContext, "please-enter-a-friendly-url-that-does-not-have-adjacent-slashes") %>
			</c:if>

			<c:if test="<%= lfurle.getType() == LayoutFriendlyURLException.INVALID_CHARACTERS %>">
				<%= LanguageUtil.get(pageContext, "please-enter-a-friendly-url-with-valid-characters") %>
			</c:if>

			<c:if test="<%= lfurle.getType() == LayoutFriendlyURLException.DUPLICATE %>">
				<%= LanguageUtil.get(pageContext, "please-enter-a-unique-friendly-url") %>
			</c:if>

			<c:if test="<%= lfurle.getType() == LayoutFriendlyURLException.KEYWORD_CONFLICT %>">
				<%= LanguageUtil.format(pageContext, "please-enter-a-friendly-url-that-does-not-conflict-with-the-keyword-x", lfurle.getKeywordConflict()) %>
			</c:if>
		</liferay-ui:error>

		<liferay-ui:error exception="<%= LayoutHiddenException.class %>" message="your-first-page-must-not-be-hidden" />
		<liferay-ui:error exception="<%= LayoutNameException.class %>" message="please-enter-a-valid-name" />

		<liferay-ui:error exception="<%= LayoutParentLayoutIdException.class %>">

			<%
			LayoutParentLayoutIdException lplide = (LayoutParentLayoutIdException)errorException;
			%>

			<c:if test="<%= lplide.getType() == LayoutParentLayoutIdException.NOT_PARENTABLE %>">
				<%= LanguageUtil.get(pageContext, "a-page-cannot-become-a-child-of-a-page-that-is-not-parentable") %>
			</c:if>

			<c:if test="<%= lplide.getType() == LayoutParentLayoutIdException.SELF_DESCENDANT %>">
				<%= LanguageUtil.get(pageContext, "a-page-cannot-become-a-child-of-itself") %>
			</c:if>

			<c:if test="<%= lplide.getType() == LayoutParentLayoutIdException.FIRST_LAYOUT_TYPE %>">
				<%= LanguageUtil.get(pageContext, "the-resulting-first-page-must-be-a-portlet-page") %>
			</c:if>

			<c:if test="<%= lplide.getType() == LayoutParentLayoutIdException.FIRST_LAYOUT_HIDDEN %>">
				<%= LanguageUtil.get(pageContext, "the-resulting-first-page-must-not-be-hidden") %>
			</c:if>
		</liferay-ui:error>

		<liferay-ui:error exception="<%= LayoutSetVirtualHostException.class %>" message="please-enter-a-unique-virtual-host" />

		<liferay-ui:error exception="<%= LayoutTypeException.class %>">

			<%
			LayoutTypeException lte = (LayoutTypeException)errorException;
			%>

			<c:if test="<%= lte.getType() == LayoutTypeException.NOT_PARENTABLE %>">
				<%= LanguageUtil.get(pageContext, "your-type-must-allow-children-pages") %>
			</c:if>

			<c:if test="<%= lte.getType() == LayoutTypeException.FIRST_LAYOUT %>">
				<%= LanguageUtil.get(pageContext, "your-first-page-must-be-a-portlet-page") %>
			</c:if>
		</liferay-ui:error>

		<c:choose>
			<c:when test='<%= tabs3.equals("page") %>'>

				<%
				String languageId = LanguageUtil.getLanguageId(request);
				Locale languageLocale = LocaleUtil.fromLanguageId(languageId);

				String name = request.getParameter("name");

				if (Validator.isNull(name)) {
					name = selLayout.getName(languageLocale);
				}

				String title = request.getParameter("title");

				if (Validator.isNull(title)) {
					title = selLayout.getTitle(languageLocale);
				}

				String type = BeanParamUtil.getString(selLayout, request, "type");
				boolean hidden = BeanParamUtil.getBoolean(selLayout, request, "hidden");
				String friendlyURL = BeanParamUtil.getString(selLayout, request, "friendlyURL");
				%>

				<input name="<portlet:namespace />curLanguageId" type="hidden" value="<%= languageId %>">

				<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td>
						<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<%= LanguageUtil.get(pageContext, "parent") %>
							</td>
							<td style="padding-left: 10px;"></td>
							<td>
								<select name="<portlet:namespace />parentLayoutId">

									<%
									for (int i = 0; i < layoutList.size(); i++) {

										// id | parentId | ls | obj id | name | img | depth

										String layoutDesc = (String)layoutList.get(i);

										String[] nodeValues = StringUtil.split(layoutDesc, "|");

										String objId = LayoutImpl.getLayoutId(nodeValues[3]);
										String layoutName = nodeValues[4];

										int depth = 0;

										if (i != 0) {
											depth = GetterUtil.getInteger(nodeValues[6]);
										}

										for (int j = 0; j < depth; j++) {
											layoutName = "-&nbsp;" + layoutName;
										}
									%>

										<option <%= parentLayoutId.equals(objId) ? "selected" : "" %> value="<%= objId %>"><%= layoutName %></option>

									<%
									}
									%>

								</select>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<br>
							</td>
						</tr>
						<tr>
							<td>
								<%= LanguageUtil.get(pageContext, "name") %>
							</td>
							<td style="padding-left: 10px;"></td>
							<td>
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<input class="form-text" name="<portlet:namespace />name" size="30" type="text" value="<%= name %>">
									</td>
									<td style="padding-left: 10px;"></td>
									<td>
										<select name="<portlet:namespace />languageId" onChange="<portlet:namespace />savePage();">

											<%
											Locale[] locales = LanguageUtil.getAvailableLocales();

											for (int i = 0; i < locales.length; i++) {
											%>

												<option <%= (languageId.equals(LocaleUtil.toLanguageId(locales[i]))) ? "selected" : "" %> value="<%= LocaleUtil.toLanguageId(locales[i]) %>"><%= locales[i].getDisplayName(locales[i]) %></option>

											<%
											}
											%>

										</select>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<%= LanguageUtil.get(pageContext, "html-title") %>
							</td>
							<td style="padding-left: 10px;"></td>
							<td>
								<input class="form-text" name="<portlet:namespace />title" size="30" type="text" value="<%= title %>">
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<br>
							</td>
						</tr>
						<tr>
							<td>
								<%= LanguageUtil.get(pageContext, "type") %>
							</td>
							<td style="padding-left: 10px;"></td>
							<td>
								<select name="<portlet:namespace />type">

									<%
									for (int i = 0; i < LayoutImpl.TYPES.length; i++) {
									%>

										<option <%= type.equals(LayoutImpl.TYPES[i]) ? "selected" : "" %> value="<%= LayoutImpl.TYPES[i] %>"><%= LanguageUtil.get(pageContext, "layout.types." + LayoutImpl.TYPES[i]) %></option>

									<%
									}
									%>

								</select>
							</td>
						</tr>
						<tr>
							<td>
								<%= LanguageUtil.get(pageContext, "hidden") %>
							</td>
							<td style="padding-left: 10px;"></td>
							<td>
								<select name="<portlet:namespace />hidden">
									<option <%= (hidden) ? "selected" : "" %> value="1"><%= LanguageUtil.get(pageContext, "yes") %></option>
									<option <%= (!hidden) ? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "no") %></option>
								</select>
							</td>
						</tr>

						<c:if test="<%= (selLayout != null) && PortalUtil.isLayoutFriendliable(selLayout) %>">
							<tr>
								<td>
									<%= LanguageUtil.get(pageContext, "friendly-url") %>
								</td>
								<td style="padding-left: 10px;"></td>
								<td nowrap>

									<%
									String parentFriendlyURL = group.getFriendlyURL();
									%>

									<c:choose>
										<c:when test="<%= Validator.isNull(parentFriendlyURL) %>">
											<a href="<%= portletURL.toString() %>&tabs3=virtual-host"><%= LanguageUtil.get(pageContext, "you-must-first-enter-a-frienly-url-for-the-" + (portletName.equals(PortletKeys.COMMUNITIES) ? "community" : "user")) %></a>
										</c:when>
										<c:otherwise>
											<%= Http.getProtocol(request) %>://<%= company.getPortalURL() %><%= privateLayout ? themeDisplay.getPathFriendlyURLPrivate() : themeDisplay.getPathFriendlyURLPublic() %><%= parentFriendlyURL %>

											<input class="form-text" name="<portlet:namespace />friendlyURL" size="30" type="text" value="<%= friendlyURL %>">
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:if>

						</table>
					</td>
				</tr>

				<c:if test="<%= selLayout != null %>">
					<tr>
						<td>
							<br><div class="beta-separator"></div><br>
						</td>
					</tr>
					<tr>
						<td>

							<%
							request.setAttribute(WebKeys.SEL_LAYOUT, selLayout);
							%>

							<liferay-util:include page="<%= Constants.TEXT_HTML_DIR + PortalUtil.getLayoutEditPage(selLayout) %>" />
						</td>
					</tr>
				</c:if>

				</table>

				<br>

				<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "save") %>'>

				<liferay-security:permissionsURL
					modelResource="<%= Layout.class.getName() %>"
					modelResourceDescription="<%= selLayout.getName() %>"
					resourcePrimKey="<%= selLayout.getPrimaryKey().toString() %>"
					var="permissionURL"
				/>

				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "permissions") %>' onClick="self.location = '<%= permissionURL %>';">

				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "delete") %>' onClick="<portlet:namespace />deletePage();">

				<script type="text/javascript">
					document.<portlet:namespace />fm.<portlet:namespace />name.focus();

					function <portlet:namespace />getChoice(value) {
						for (var i = 0; i < document.<portlet:namespace />fm.<portlet:namespace />languageId.length; i++) {
							if (document.<portlet:namespace />fm.<portlet:namespace />languageId.options[i].value == value) {
								return document.<portlet:namespace />fm.<portlet:namespace />languageId.options[i].index;
							}
						}

						return null;
					}

					<%
					try {
						SAXReader reader = new SAXReader();

						Document doc = reader.read(new StringReader(selLayout.getName()));

						Element root = doc.getRootElement();

						String [] availableLocales = StringUtil.split(root.attributeValue("available-locales"));

						if (availableLocales != null) {
							for (int i = 0; i < availableLocales.length; i++) {
					%>

								document.<portlet:namespace />fm.<portlet:namespace />languageId.options[<portlet:namespace />getChoice("<%= availableLocales[i] %>")].style.color = "<%= colorScheme.getPortletMsgError() %>";

					<%
							}
						}
					}
					catch (Exception e) {
					}
					%>

				</script>
			</c:when>
			<c:when test='<%= tabs3.equals("children") %>'>
				<input name="<portlet:namespace />parentLayoutId" type="hidden" value="<%= (selLayout != null) ? selLayout.getLayoutId() : LayoutImpl.DEFAULT_PARENT_LAYOUT_ID %>">
				<input name="<portlet:namespace />layoutIds" type="hidden" value="">

				<%
				String name = ParamUtil.getString(request, "name");
				String type = ParamUtil.getString(request, "type");
				boolean hidden = ParamUtil.getBoolean(request, "hidden");
				%>

				<%= LanguageUtil.get(pageContext, "add-child-pages") %>

				<br><br>

				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "name") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<input class="form-text" name="<portlet:namespace />name" size="30" type="text" value="<%= name %>">
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<br>
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "type") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<select name="<portlet:namespace />type">

							<%
							for (int i = 0; i < LayoutImpl.TYPES.length; i++) {
							%>

								<option <%= type.equals(LayoutImpl.TYPES[i]) ? "selected" : "" %> value="<%= LayoutImpl.TYPES[i] %>"><%= LanguageUtil.get(pageContext, "layout.types." + LayoutImpl.TYPES[i]) %></option>

							<%
							}
							%>

						</select>
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "hidden") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td>
						<select name="<portlet:namespace />hidden">
							<option <%= (hidden) ? "selected" : "" %> value="1"><%= LanguageUtil.get(pageContext, "yes") %></option>
							<option <%= (!hidden) ? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "no") %></option>
						</select>
					</td>
				</tr>
				</table>

				<br>

				<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "add-page") %>'><br>

				<script type="text/javascript">
					document.<portlet:namespace />fm.<portlet:namespace />name.focus();
				</script>

				<%
				List selLayoutChildren = null;

				if (selLayout != null) {
					selLayoutChildren = selLayout.getChildren();
				}
				else {
					selLayoutChildren = LayoutLocalServiceUtil.getLayouts(ownerId, LayoutImpl.DEFAULT_PARENT_LAYOUT_ID);
				}
				%>

				<c:if test="<%= (selLayoutChildren != null) && (selLayoutChildren.size() > 0) %>">
					<br><div class="beta-separator"></div><br>

					<liferay-ui:error exception="<%= RequiredLayoutException.class %>">

						<%
						RequiredLayoutException rle = (RequiredLayoutException)errorException;
						%>

						<c:if test="<%= rle.getType() == RequiredLayoutException.AT_LEAST_ONE %>">
							<%= LanguageUtil.get(pageContext, "you-must-have-at-least-one-page") %>
						</c:if>

						<c:if test="<%= rle.getType() == RequiredLayoutException.FIRST_LAYOUT_TYPE %>">
							<%= LanguageUtil.get(pageContext, "your-first-page-must-be-a-portlet-page") %>
						</c:if>

						<c:if test="<%= rle.getType() == RequiredLayoutException.FIRST_LAYOUT_HIDDEN %>">
							<%= LanguageUtil.get(pageContext, "your-first-page-must-not-be-hidden") %>
						</c:if>
					</liferay-ui:error>

					<%= LanguageUtil.get(pageContext, "set-the-display-order-of-child-pages") %>

					<br><br>

					<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<select name="<portlet:namespace />layoutIdsBox" size="7">

							<%
							for (int i = 0; i < selLayoutChildren.size(); i++) {
								Layout selLayoutChild = (Layout)selLayoutChildren.get(i);
							%>

								<option value="<%= selLayoutChild.getLayoutId() %>"><%= selLayoutChild.getName(locale) %></option>

							<%
							}
							%>

							</select>
						</td>
						<td style="padding-left: 10px;"></td>
						<td valign="top">
							<a href="javascript: reorder(document.<portlet:namespace />fm.<portlet:namespace />layoutIdsBox, 0);"><img border="0" height="16" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_up.gif" vspace="2" width="16"></a><br>
							<a href="javascript: reorder(document.<portlet:namespace />fm.<portlet:namespace />layoutIdsBox, 1);"><img border="0" height="16" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_down.gif" vspace="2" width="16"></a><br>
							<a href="javascript: removeItem(document.<portlet:namespace />fm.<portlet:namespace />layoutIdsBox);"><img border="0" height="16" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_x.gif" vspace="2" width="16"></a><br>
						</td>
					</tr>
					</table>

					<br>

					<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "update-display-order") %>' onClick="<portlet:namespace />updateDisplayOrder();">
				</c:if>
			</c:when>
			<c:when test='<%= tabs3.equals("look-and-feel") %>'>

				<%
				Theme selTheme = theme;
				ColorScheme selColorScheme = colorScheme;

				if (selLayout != null) {
					selTheme = selLayout.getTheme();
					selColorScheme = selLayout.getColorScheme();
				}
				else {
					LayoutSet layoutSet = LayoutSetLocalServiceUtil.getLayoutSet(ownerId);

					selTheme = layoutSet.getTheme();
					selColorScheme = layoutSet.getColorScheme();
				}
				%>

				<c:if test="<%= selLayout != null %>">
					<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<%= LanguageUtil.get(pageContext, "inherit-look-and-feel-from-the-" + (privateLayout ? "public" : "private") + "-root-node") %>
						</td>
						<td style="padding-left: 10px;"></td>
						<td>
							<select name="<portlet:namespace />hidden" onChange="if (this.value == 1) { <portlet:namespace />updateLookAndFeel('', ''); } else { <portlet:namespace />updateLookAndFeel('<%= selTheme.getThemeId() %>', '<%= selColorScheme.getColorSchemeId() %>'); }">
								<option <%= (selLayout.isInheritLookAndFeel()) ? "selected" : "" %> value="1"><%= LanguageUtil.get(pageContext, "yes") %></option>
								<option <%= (!selLayout.isInheritLookAndFeel()) ? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "no") %></option>
							</select>
						</td>
					</table>

					<br>
				</c:if>

				<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td valign="top">
						<liferay-ui:tabs names="themes" />

						<%
						List themes = ThemeLocalUtil.getThemes(company.getCompanyId());
						%>

						<liferay-ui:table-iterator
							list="<%= themes %>"
							listType="com.liferay.portal.model.Theme"
							rowLength="2">

							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td align="center">
									<%= tableIteratorObj.getName() %> <input <%= selTheme.getThemeId().equals(tableIteratorObj.getThemeId()) ? "checked" : "" %> name="<portlet:namespace />themeId" type="radio" value="<%= tableIteratorObj.getThemeId() %>" onClick="<portlet:namespace />updateLookAndFeel('<%= tableIteratorObj.getThemeId() %>', '');"><br>

									<img border="0" hspace="0" src="<%= tableIteratorObj.getContextPath() %><%= tableIteratorObj.getImagesPath() %>/thumbnail.gif" vspace="0">
								</td>
							</tr>
							</table>
						</liferay-ui:table-iterator>
					</td>
					<td style="padding-left: 30px;"></td>
					<td valign="top">
						<liferay-ui:tabs names="color-schemes" />

						<%
						List colorSchemes = selTheme.getColorSchemes();
						%>

						<liferay-ui:table-iterator
							list="<%= colorSchemes %>"
							listType="com.liferay.portal.model.ColorScheme"
							rowLength="1">

							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td align="center">
									<%= tableIteratorObj.getName() %> <input <%= selColorScheme.getColorSchemeId().equals(tableIteratorObj.getColorSchemeId()) ? "checked" : "" %> name="<portlet:namespace />colorSchemeId" type="radio" value="<%= tableIteratorObj.getColorSchemeId() %>" onClick="<portlet:namespace />updateLookAndFeel('<%= selTheme.getThemeId() %>', '<%= tableIteratorObj.getColorSchemeId() %>')"><br>

									<table border="1" cellpadding="1" cellspacing="1">
									<tr>
										<td>
											<table border="0" cellpadding="2" cellspacing="0">
											<tr>
												<td bgcolor="<%= tableIteratorObj.getLayoutTabSelectedBg() %>">
													<font color="<%= tableIteratorObj.getLayoutTabSelectedText() %>" face="Tahoma, Verdana, Arial" size="2">&nbsp;<b>Tab Selected</b>&nbsp;</font>
												</td>
											</tr>
											<tr>
												<td bgcolor="<%= tableIteratorObj.getLayoutTabBg() %>">
													<font color="<%= tableIteratorObj.getLayoutTabText() %>" face="Tahoma, Verdana, Arial" size="2">&nbsp;<b>Tab Unselected</b>&nbsp;</font>
												</td>
											</tr>
											<tr>
												<td bgcolor="<%= tableIteratorObj.getPortletTitleBg() %>">
													<font color="<%= tableIteratorObj.getPortletTitleText() %>" face="Tahoma, Verdana, Arial" size="2">&nbsp;<b>Portlet Title</b>&nbsp;</font>
												</td>
											</tr>
											<tr>
												<td bgcolor="<%= tableIteratorObj.getPortletMenuBg() %>">
													<font color="<%= tableIteratorObj.getPortletMenuText() %>" face="Tahoma, Verdana, Arial" size="2">&nbsp;Portlet Menu&nbsp;</font>
												</td>
											</tr>
											<tr>
												<td bgcolor="<%= tableIteratorObj.getPortletBg() %>">
													<font color="<%= tableIteratorObj.getPortletFont() %>" face="Tahoma, Verdana, Arial" size="2">&nbsp;Portlet Body&nbsp;</font>
												</td>
											</tr>
											<tr>
												<td bgcolor="<%= tableIteratorObj.getBodyBg() %>">
													<font color="<%= tableIteratorObj.getLayoutText() %>" face="Tahoma, Verdana, Arial" size="2">&nbsp;Page Background&nbsp;<br></font>
												</td>
											</tr>
											</table>
										</td>
									</tr>
									</table>
								</td>
							</tr>
							</table>
						</liferay-ui:table-iterator>
					</td>
				</tr>
				</table>
			</c:when>
			<c:when test='<%= tabs3.equals("import-export") %>'>
				<liferay-ui:error exception="<%= LayoutImportException.class %>" message="an-unexpected-error-occurred-while-importing-your-file" />

				<c:if test="<%= !layout.getOwnerId().equals(ownerId) %>">
					<%= LanguageUtil.get(pageContext, "import-a-lar-file-to-overwrite-the-current-pages-and-preferences") %>

					<br><br>

					<input class="form-text" name="<portlet:namespace />importFileName" size="50" type="file">

					<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "import") %>' onClick="<portlet:namespace />importPages();">

					<br><br>
				</c:if>

				<%= LanguageUtil.get(pageContext, "export-the-current-pages-and-preferences-to-the-given-lar-file-name") %>

				<br><br>

				<input class="form-text" name="<portlet:namespace />exportFileName" size="50" type="text" value="<%= StringUtil.replace(rootNodeName, " ", "_") %>-<%= Time.getShortTimestamp() %>.lar">

				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "export") %>' onClick="self.location = '<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>"><portlet:param name="struts_action" value="/communities/export_pages" /><portlet:param name="ownerId" value="<%= ownerId %>" /></portlet:actionURL>&<portlet:namespace />exportFileName=' + document.<portlet:namespace />fm.<portlet:namespace />exportFileName.value;">
			</c:when>
			<c:when test='<%= tabs3.equals("virtual-host") %>'>
				<%= LanguageUtil.get(pageContext, "enter-the-public-and-private-virtual-host-that-will-map-to-the-public-and-private-friendly-url") %>

				<%= LanguageUtil.format(pageContext, "for-example,-if-the-public-virtual-host-is-www.helloworld.com-and-the-friendly-url-is-/helloworld", new Object[] {Http.getProtocol(request), Http.getProtocol(request) + "://" + company.getPortalURL() + themeDisplay.getPathFriendlyURLPublic()}) %>

				<br><br>

				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "public-virtual-host") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td nowrap>

						<%
						String publicOwnerId = LayoutImpl.PUBLIC + LayoutImpl.getGroupId(ownerId);

						LayoutSet publicLayoutSet = LayoutSetLocalServiceUtil.getLayoutSet(publicOwnerId);

						String publicVirtualHost = ParamUtil.getString(request, "publicVirtualHost", BeanParamUtil.getString(publicLayoutSet, request, "virtualHost"));
						%>

						<input class="form-text" name="<portlet:namespace />publicVirtualHost" size="50" type="text" value="<%= publicVirtualHost %>">
					</td>
				</tr>
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "private-virtual-host") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td nowrap>

						<%
						String privateOwnerId = LayoutImpl.PRIVATE + LayoutImpl.getGroupId(ownerId);

						LayoutSet privateLayoutSet = LayoutSetLocalServiceUtil.getLayoutSet(privateOwnerId);

						String privateVirtualHost = ParamUtil.getString(request, "privateVirtualHost", BeanParamUtil.getString(privateLayoutSet, request, "virtualHost"));
						%>

						<input class="form-text" name="<portlet:namespace />privateVirtualHost" size="50" type="text" value="<%= privateVirtualHost %>">
					</td>
				</tr>
				</table>

				<br>

				<%= LanguageUtil.get(pageContext, "enter-the-friendly-url-that-will-be-used-by-both-public-and-private-pages") %>

				<%= LanguageUtil.format(pageContext, "the-friendly-url-is-appended-to-x-for-public-pages-and-x-for-private-pages", new Object[] {Http.getProtocol(request) + "://" + company.getPortalURL() + themeDisplay.getPathFriendlyURLPublic(), Http.getProtocol(request) + "://" + company.getPortalURL() + themeDisplay.getPathFriendlyURLPrivate()}) %>

				<br><br>

				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<%= LanguageUtil.get(pageContext, "friendly-url") %>
					</td>
					<td style="padding-left: 10px;"></td>
					<td nowrap>

						<%
						String friendlyURL = BeanParamUtil.getString(group, request, "friendlyURL");
						%>

						<input class="form-text" name="<portlet:namespace />friendlyURL" size="30" type="text" value="<%= friendlyURL %>">
					</td>
				</tr>
				</table>

				<br>

				<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "save") %>'>
			</c:when>
		</c:choose>
	</td>
</tr>
</table>

</form>
