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

<%@ include file="init.jsp" %>

<style type="text/css">
#portlet-header-bar_<%= portletDisplay.getId() %>:hover .portlet-small-icon-bar {
	visibility: visible;
}
</style>

<div class="portlet-container">
	<div id="portlet-header-bar_<%= portletDisplay.getId() %>" class="portlet-header-bar"
		<c:if test="<%= !portletDisplay.isShowBackIcon() %>">
			onMouseEnter="document.all.portlet_small_icon_bar_<%= portletDisplay.getId() %>.style.visibility='visible'"
			onMouseLeave="document.all.portlet_small_icon_bar_<%= portletDisplay.getId() %>.style.visibility='hidden'"
		</c:if>
		>
		<c:if test="<%= Validator.isNotNull(portletDisplay.getTitle()) %>">
			<div class="portlet-title"><div><div></div></div>

				<div class="portlet-title-text">
					<span style="color: #333333; position: absolute; top: 2px; left: 2px;"><b>&nbsp;<%= portletDisplay.getTitle() %>&nbsp;</b></span>
					<span style="position: absolute;"><b>&nbsp;<%= portletDisplay.getTitle() %>&nbsp;</b></span>
				</div>
			</div>
		</c:if>

		<div id="portlet_small_icon_bar_<%= portletDisplay.getId() %>" class="portlet-small-icon-bar" style="visibility: <%= portletDisplay.isShowBackIcon() ? "visible" : "hidden" %>">
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
		<!-- End portlet-small-icon-bar -->
	</div>

	<!-- Begin Portlet Body -->
	<div class="portlet-box">
		<div class="portlet-content" id="p_p_body_<%= portletDisplay.getId() %>" <%= (portletDisplay.isStateMin()) ? "style=\"display: none;\"" : "block" %>>
		    <div class="portlet-maximize-reference">
