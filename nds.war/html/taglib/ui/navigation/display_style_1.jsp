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

<%@ include file="/html/taglib/ui/navigation/init.jsp" %>

<liferay-ui:breadcrumb />

<%
List selLayoutChildren = layout.getChildren();
%>

<c:if test="<%= (selLayoutChildren != null) && (selLayoutChildren.size() > 0) %>">
	<c:choose>
		<c:when test="<%= bulletStyle == 1 %>">
			<ul>

				<%
				for (int i = 0; i < selLayoutChildren.size(); i++) {
					Layout selLayoutChild = (Layout)selLayoutChildren.get(i);

					if (!selLayoutChild.isHidden() && LayoutPermission.contains(permissionChecker, selLayoutChild, ActionKeys.VIEW)) {
						String layoutURL = PortalUtil.getLayoutURL(selLayoutChild, themeDisplay);
						String target = PortalUtil.getLayoutTarget(selLayoutChild);
				%>

					<li>
						<a href="<%= layoutURL %>" <%= target %>> <%= selLayoutChild.getName(locale) %></a>
					</li>

				<%
					}
				}
				%>

			</ul>
		</c:when>
		<c:otherwise>

			<br />
			<br />

			<%
			for (int i = 0; i < selLayoutChildren.size(); i++) {
				Layout selLayoutChild = (Layout)selLayoutChildren.get(i);

				if (!selLayoutChild.isHidden()) {
					String layoutURL = PortalUtil.getLayoutURL(selLayoutChild, themeDisplay);
					String target = PortalUtil.getLayoutTarget(selLayoutChild);
			%>

				<div style="padding: 2px 0px 2px 0px;">
					<a href="<%= layoutURL %>" <%= target %>> <%= selLayoutChild.getName(locale) %></a>
				</div>

				<div class="alpha-separator"></div>

			<%
				}
			}
			%>

		</c:otherwise>
	</c:choose>
</c:if>

