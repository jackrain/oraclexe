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

<%@ include file="/html/taglib/init.jsp" %>

<div class="portlet-header-bar" id="portlet-header-bar_<%= portletDisplay.getId() %>"
	<c:if test="<%= !portletDisplay.isShowBackIcon() %>">
		onmouseover="PortletHeaderBar.show(this.id)"
		onmouseout="PortletHeaderBar.hide(this.id)"
	</c:if>
	>

	<liferay-portlet:title />

	<div class="portlet-small-icon-bar" style="display: <%= portletDisplay.isShowBackIcon() ? "block" : "none" %>;">
		<c:choose>
			<c:when test="<%= portletDisplay.isShowBackIcon() %>">
				<liferay-portlet:icon-back />
			</c:when>
			<c:otherwise>
				<liferay-portlet:icon-configuration />

				<liferay-portlet:icon-edit />

				<liferay-portlet:icon-edit-guest />

				<liferay-portlet:icon-help />

				<liferay-portlet:icon-print />

				<liferay-portlet:icon-minimize />

				<liferay-portlet:icon-maximize />

				<liferay-portlet:icon-close />
			</c:otherwise>
		</c:choose>
	</div>
</div>
