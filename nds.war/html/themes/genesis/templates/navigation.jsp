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

	<%
	int tabNameMaxLength = GetterUtil.getInteger(PropsUtil.get(PropsUtil.LAYOUT_NAME_MAX_LENGTH));
	int tabsPerRow = GetterUtil.getInteger(PropsUtil.get(PropsUtil.LAYOUT_TABS_PER_ROW));
	int totalTabs = layouts.size();
	int totalTabRows = (totalTabs / tabsPerRow);

	if ((totalTabs % tabsPerRow) > 0) {
		totalTabRows++;
	}

	int tabLeftImageWidth = TAB_IMAGE_SIDE_WIDTH;
	int tabSeparatorWidth = TAB_IMAGE_SIDE_WIDTH;
	int tabRightImageWidth = 9;

	int tabOverlap = 18;
	int tabWidth = 0;
	int tabBodyWidth = 0;
	int tabShift = 0;

	String tabBgColor = "none";

	int layoutCounter = 0;
	int rowCounter = 0;
	int tabCounter = 0;

	int currentTab = 0;

	boolean isSelectedTab = false;
	boolean isPrevSelectedTab = false;

	int selectedRow = 0;
	int selectedTab = 0;

	int zIndex = 0;

	String rows[][] = new String[totalTabRows][tabsPerRow];

	String ancestorLayoutId = "";
	if (layout != null) {
		ancestorLayoutId = layout.getAncestorLayoutId();
	}

	for (int i = 0; i < layouts.size(); i++) {
		Layout curLayout = (Layout)layouts.get(i);

		String tabName = StringUtil.shorten(curLayout.getName(locale), tabNameMaxLength);
		String tabToolTipName = curLayout.getName(locale);
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

		if (isSelectedTab) {
			selectedRow = rowCounter;
			selectedTab = currentTab;
		}

		String tabText = null;

		if (!curLayout.isHidden()) {
			tabText = "<a href=\"" + tabHREF + "\" " + target + ">" + tabName + "</a>";
		}
		rows[rowCounter][currentTab] = tabText;

		if (currentTab == tabsPerRow - 1) {
			rowCounter++;
			currentTab = 0;
		}
		else {
			currentTab++;
		}
	}

	// Reorder the array so the row with the selected tab is on the bottom row

	if (rows.length > 1) {
		Collections.swap(Arrays.asList(rows), selectedRow, rows.length - 1);
	}
	%>

	<div id="layout-nav-container">
		<div class="layout-nav-tabs">

			<%

			// Render each row

			for (int i = 0; i < rows.length; i++) {

				// Calculate the number of tabs in this row

				int tabsInRow = 0;

				for (int j = 0; j < rows[i].length; j++) {
					if (rows[i][j] != null) {
						tabsInRow++;
					}
					else {
						break;
					}
				}

				if (i > 0) {
					tabBgColor="none";
				}

				%>
				<div class="layout-nav-row" style="background-color: <%= tabBgColor %>">
				<%

				// Render the tabs

				for (int j = 0; j < tabsInRow; j++) {

					String tabLeft = "";
					String tabRight = "";

					// Set the tab images suffix

						// Are we on the first tab in the row?

						if (j == 0) {
							tabLeft = "-end";
						}

						// Are we on the last tab in the row?

						if (j == tabsInRow - 1) {
							tabRight = "-end";
						}


						int navWidth = themeDisplay.getResolution();
						navWidth = (navWidth > 0) ? navWidth : 1024;

						if (layouts.size() == 1) {
							// Make an exception if there is only one tab
							if (rows.length == 1) {
								// For one row, set lenght to half
								tabWidth = navWidth/2;
								tabRight= "";
							}
							else {
								// Otherwise, set it to full
								tabWidth = navWidth;
							}
						}
						else {
							tabWidth = (navWidth + ((tabsInRow - 1) * tabOverlap)) / tabsInRow;
						}

						tabBodyWidth = tabWidth - tabLeftImageWidth - tabSeparatorWidth;
						tabShift = tabLeftImageWidth + ((tabWidth - tabOverlap) * j);
						zIndex = ((i+1) * 10) - j;

						// Are we on the selected tab?

						if (selectable && (i == rows.length - 1) && (j == selectedTab)) {
							isSelectedTab = true;
							%>
							<div id="tab_<%= i %>_<%= j %>" class="layout-nav-tab-selected" style="width: <%= tabBodyWidth %>; left: <%= tabShift %>px;">
								<div class="layout-nav-tab-selected-left<%= tabLeft %>"></div>
								<div class="layout-nav-tab-selected-right<%= tabRight %>"></div>
								<span class="layout-tab-selected"><%= rows[i][j] %></span>
							</div>
							<%
						}
						else {
							isSelectedTab = false;
							%>
							<style type="text/css">
							#tab_<%= i %>_<%= j %>:hover .layout-nav-tab-left<%= tabLeft %>, .layout-nav-tab-left<%= tabLeft %>-hover {
								background-image:  url(<%= themeDisplay.getPathThemeImage() %>/custom/tabs/tab-light-left<%= tabLeft %>.gif);
							}

							#tab_<%= i %>_<%= j %>:hover .layout-nav-tab-right<%= tabRight %>, .layout-nav-tab-right<%= tabRight %>-hover {
								background-image:  url(<%= themeDisplay.getPathThemeImage() %>/custom/tabs/tab-light-right<%= tabRight %>.gif);
							}

							#tab_<%= i %>_<%= j %>:hover {
								background-image:  url(<%= themeDisplay.getPathThemeImage() %>/custom/tabs/tab-light-middle.gif);
							}
							</style>

							<div id="tab_<%= i %>_<%= j %>" class="layout-nav-tab" style="width: <%= tabBodyWidth %>; z-index: <%= zIndex %>; left: <%= tabShift %>px;" onMouseEnter="document.all.tab_<%= i %>_<%= j %>.style.background = 'url(<%= themeDisplay.getPathThemeImage() %>/custom/tabs/tab-light-middle.gif)'; document.all.tab_left_<%= i %>_<%= j %>.style.background = 'url(<%= themeDisplay.getPathThemeImage() %>/custom/tabs/tab-light-left<%= tabLeft %>.gif)'; document.all.tab_right_<%= i %>_<%= j %>.style.background = 'url(<%= themeDisplay.getPathThemeImage() %>/custom/tabs/tab-light-right<%= tabRight %>.gif)'" onMouseLeave="document.all.tab_<%= i %>_<%= j %>.style.background = 'url(<%= themeDisplay.getPathThemeImage() %>/custom/tabs/tab-medium-middle.gif)'; document.all.tab_left_<%= i %>_<%= j %>.style.background = 'url(<%= themeDisplay.getPathThemeImage() %>/custom/tabs/tab-medium-left<%= tabLeft %>.gif)'; document.all.tab_right_<%= i %>_<%= j %>.style.background = 'url(<%= themeDisplay.getPathThemeImage() %>/custom/tabs/tab-medium-right<%= tabRight %>.gif)'">
								<div id="tab_left_<%= i %>_<%= j %>" class="layout-nav-tab-left<%= tabLeft %>"></div>
								<div id="tab_right_<%= i %>_<%= j %>" class="layout-nav-tab-right<%= tabRight %>"></div>
								<span class="layout-tab"><%= rows[i][j] %></span>
							</div>
							<%
						}

						// After the last tab, display the menu list bar

						if ((i == rows.length - 1) && (j == tabsInRow - 1)) {
							%>
							<div id="layout-nav-menu-bar">
								<div id="layout-nav-menu-bar-left"></div>
								<div id="layout-nav-menu-bar-right"></div>
							</div>
							<%
						}

				} /* Tabs */
			%>
			</div>
			<!-- End layout-nav-row -->
			<%
			} /* Rows */
			%>
		</div>
		<!-- End layout-nav-tabs -->


		<div class="bottom-shadow-decoration">
		</div>

	</div>
	<!-- End layout-nav-container -->

</c:if>
