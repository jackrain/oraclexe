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

<c:if test="<%= (layouts != null) && (layouts.size() > 0) %>">

<div id="layout-nav-container">

	<%
	int tabNameMaxLength = GetterUtil.getInteger(PropsUtil.get(PropsUtil.LAYOUT_NAME_MAX_LENGTH));

	String className;
	String tabName;
	String tabHREF;
	String target;
	boolean isSelectedTab = false;
	String ancestorLayoutId = "";
	List layoutIds = new ArrayList();
	List hiddenIds = new ArrayList();
	boolean newPage = ParamUtil.getBoolean(request, "newPage");

	if (layout != null) {
		ancestorLayoutId = layout.getAncestorLayoutId();
	}

	for (int i = 0; i < layouts.size(); i++) {
		Layout curLayout = (Layout)layouts.get(i);

		//tabName = StringUtil.shorten(curLayout.getName(locale), tabNameMaxLength);
		tabName = curLayout.getName(locale);
		tabHREF = PortalUtil.getLayoutURL(curLayout, themeDisplay);
		isSelectedTab = selectable && (layout != null && (plid.equals(curLayout.getLayoutId()) || curLayout.getLayoutId().equals(ancestorLayoutId)));
		target = PortalUtil.getLayoutTarget(curLayout);

		if (isSelectedTab && layoutTypePortlet.hasStateMax()) {
			String portletId = StringUtil.split(layoutTypePortlet.getStateMax())[0];

			PortletURLImpl portletURLImpl = new PortletURLImpl(request, portletId, plid, false);

			portletURLImpl.setWindowState(WindowState.NORMAL);
			portletURLImpl.setPortletMode(PortletMode.VIEW);
			portletURLImpl.setAnchor(false);

			tabHREF = portletURLImpl.toString();
		}


		if (curLayout.isHidden()) {
			hiddenIds.add(curLayout.getLayoutId());
		}
		else {
			layoutIds.add(curLayout.getLayoutId());

			if (isSelectedTab) {
				%>
				<div id="layout-tab-selected" class="layout-tab">
					<div class="layout-tab-text"><span id="layout-tab-text-edit"><%= tabName %></span></div>
				</div>
				<%
			}
			else {
				%>
				<div class="layout-tab">
					<div class="layout-tab-text"><a href="<%= tabHREF %>" <%= target %>><%= tabName %></a></div>
				</div>
				<%
			}
		}
	}
	%>

	<c:if test="<%= themeDisplay.isShowPageSettingsIcon() %>">
		<div id="layout-tab-add">
			<div class="layout-tab-text"><a href="javascript: Navigation.addPage()"><bean:message key="add-page" /></a></div>
		</div>
	</c:if>
</div>

<div id="layout-nav-divider" class="layout-nav-<%= selectable ? "selected" : "divider" %>"></div>

<c:if test="<%= themeDisplay.isShowAddContentIcon() && selectable %>">
<script type="text/javascript">
	Navigation.init({
			groupId: "<%= layout.getGroupId() %>",
			language: "<%= LanguageUtil.getLanguageId(request) %>",
			layoutId: "<%= layout.getLayoutId() %>",
			newPage: <%= newPage %>,
			ownerId: "<%= LayoutImpl.getOwnerId(plid) %>",
			isPrivate: <%= layout.isPrivateLayout() %>,
			parent: "<%= layout.getParentLayoutId() %>",
			layoutIds: [<%
				for (int i = 0; i < layoutIds.size(); i++) {
					out.print((String)(layoutIds.get(i)));
					if (i < layoutIds.size() - 1) {
						out.print(",");
					}
				}
				%>],

			hiddenIds: [<%
				for (int i = 0; i < hiddenIds.size(); i++) {
					out.print((String)(hiddenIds.get(i)));
					if (i < hiddenIds.size() - 1) {
						out.print(",");
					}
				}
				%>]
	});
</script>
</c:if>

</c:if>
