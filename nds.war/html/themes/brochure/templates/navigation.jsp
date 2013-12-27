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
	<div id="layout-nav-container" class="font-small">
		<div class="layout-nav-tabs-left"><div class="layout-nav-tabs-right"><div class="layout-nav-tabs-box">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tr>

<%
int totalTabs = 0;
int tabWidth;
int modBucket;
boolean isSelectedTab = false;
String ancestorLayoutId = "";

if (layout != null) {
	ancestorLayoutId = layout.getAncestorLayoutId();
}

for (int i = 0; i < layouts.size(); i++) {
	Layout curLayout = (Layout)layouts.get(i);

	if (!curLayout.isHidden()) {
		totalTabs++;
	}
}

tabWidth = 100/totalTabs;
modBucket = 100 % totalTabs;

for (int i = 0; i < layouts.size(); i++) {
	Layout curLayout = (Layout)layouts.get(i);

	if (!curLayout.isHidden()) {
		String tabName = curLayout.getName(locale);
		String tabHREF = PortalUtil.getLayoutURL(curLayout, themeDisplay);
		isSelectedTab = selectable && (layout != null && (plid.equals(curLayout.getLayoutId()) || curLayout.getLayoutId().equals(ancestorLayoutId)));

		if (isSelectedTab && layoutTypePortlet.hasStateMax()) {
			String portletId = StringUtil.split(layoutTypePortlet.getStateMax())[0];

			PortletURLImpl portletURLImpl = new PortletURLImpl(request, portletId, plid, false);

			portletURLImpl.setWindowState(WindowState.NORMAL);
			portletURLImpl.setPortletMode(PortletMode.VIEW);
			portletURLImpl.setAnchor(false);

			tabHREF = portletURLImpl.toString();
		}

		String target = PortalUtil.getLayoutTarget(curLayout);
		%>

		<c:if test="<%= i != 0 %>">
			<td valign="middle" align="center" width="0">
				<img align="absmiddle" src="<%= themeDisplay.getPathThemeImage() %>/custom/nav-spacer.png" />
			</td>
		</c:if>

		<td class="layout-tab<%= isSelectedTab ? "-selected" : "" %>"
			valign="middle"
			align="center"
			width="<%= modBucket-- > 0 ? tabWidth + 1 : tabWidth %>%"
			<c:if test="<%= !isSelectedTab %>">
				onmouseover="this.className = 'layout-tab-hover'"
				onmouseout="this.className = 'layout-tab<%= isSelectedTab ? "-selected" : "" %>'"
			</c:if>
			>
			<a href=" <%= tabHREF %>" <%= target %>><%= tabName %></a>
		</td>
	<%
	}
}
%>

			</tr>
			</table>
		</div></div></div>
	</div>
</c:if>

</div></div></div><!-- end layout-top-banner -->

<div id="layout-content"><div id="layout-content-box">
