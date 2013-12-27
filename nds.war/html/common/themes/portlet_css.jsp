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

<%
String portletContainerClass = portletDecorate ? ".portlet-container" : ".portlet-borderless-container";
String portletBoxClass = portletDecorate ? ".portlet-box" : ".portlet-borderless-container";
%>

<style type="text/css">
	#p_p_id<%= portletDisplay.getNamespace() %> <%= portletContainerClass %> {

		<%
		String portletBgColor = cssProps.getProperty("portletBgColor");
		String portletBgImageUrl = cssProps.getProperty("portletBgImageUrl");
		String portletBgImageAttach = cssProps.getProperty("portletBgImageAttach");
		String portletBgImagePos = cssProps.getProperty("portletBgImagePos");
		String portletBgImageTile = cssProps.getProperty("portletBgImageTile");
		String portletBorderWidth = cssProps.getProperty("portletBorderWidth");
		String portletBorderStyle = cssProps.getProperty("portletBorderStyle");
		String portletBorderColor = cssProps.getProperty("portletBorderColor");
		%>

		<c:if test="<%= Validator.isNotNull(portletBgColor) %>">
			background-color: <%= portletBgColor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(portletBgImageUrl) %>">
			background-image: url(<%= portletBgImageUrl %>);
		</c:if>

		<c:if test="<%= Validator.isNotNull(portletBgImageAttach) %>">
			background-attachment: <%= portletBgImageAttach %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(portletBgImagePos) %>">
			background-position: <%= portletBgImagePos %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(portletBgImageTile) %>">
			background-repeat: <%= portletBgImageTile %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(portletBorderWidth) %>">
			border-width: <%= portletBorderWidth %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(portletBorderStyle) %>">
			border-style: <%= portletBorderStyle %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(portletBorderColor) %>">
			border-color: <%= portletBorderColor %>;
		</c:if>
	}

	#p_p_id<%= portletDisplay.getNamespace() %> .portlet-header-bar {

		<%
		String headerBgColor = cssProps.getProperty("headerBgColor");
		String headerBgImageUrl = cssProps.getProperty("headerBgImageUrl");
		String headerBgImageAttach = cssProps.getProperty("headerBgImageAttach");
		String headerBgImagePos = cssProps.getProperty("headerBgImagePos");
		String headerBgImageTile = cssProps.getProperty("headerBgImageTile");
		String headerBorderWidth = cssProps.getProperty("headerBorderWidth");
		String headerBorderStyle = cssProps.getProperty("headerBorderStyle");
		String headerBorderColor = cssProps.getProperty("headerBorderColor");
		%>

		<c:if test="<%= Validator.isNotNull(headerBgColor) %>">
			background-color: <%= headerBgColor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerBgImageUrl) %>">
			background-image: url(<%= headerBgImageUrl %>);
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerBgImageAttach) %>">
			background-attachment: <%= headerBgImageAttach %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerBgImagePos) %>">
			background-position: <%= headerBgImagePos %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerBgImageTile) %>">
			background-repeat: <%= headerBgImageTile %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerBorderWidth) %>">
			border-width: <%= headerBorderWidth %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerBorderStyle) %>">
			border-style: <%= headerBorderStyle %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerBorderColor) %>">
			border-color: <%= headerBorderColor %>;
		</c:if>
	}

	#p_p_id<%= portletDisplay.getNamespace() %> .portlet-title {

		<%
		String headerTextColor = cssProps.getProperty("headerTextColor");
		String headerTextDecor = cssProps.getProperty("headerTextDecor");
		String headerTextFont = cssProps.getProperty("headerTextFont");
		String headerTextSize = cssProps.getProperty("headerTextSize");
		String headerTextStyle = cssProps.getProperty("headerTextStyle");
		String headerTextBold = cssProps.getProperty("headerTextBold");
		%>

		<c:if test="<%= Validator.isNotNull(headerTextColor) %>">
			color: <%= headerTextColor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerTextDecor) %>">
			text-decoration: <%= headerTextDecor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerTextFont) %>">
			font-family: <%= headerTextFont %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerTextSize) %>">
			font-size: <%= headerTextSize %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerTextStyle) %>">
			font-style: italic;
		</c:if>

		<c:if test="<%= Validator.isNotNull(headerTextBold) %>">
			font-weight: bold;
		</c:if>
	}

	#p_p_id<%= portletDisplay.getNamespace() %> <%= portletBoxClass %> {

		<%
		String contentBgColor = cssProps.getProperty("contentBgColor");
		String contentBgImageUrl = cssProps.getProperty("contentBgImageUrl");
		String contentBgImageAttach = cssProps.getProperty("contentBgImageAttach");
		String contentBgImagePos = cssProps.getProperty("contentBgImagePos");
		String contentBgImageTile = cssProps.getProperty("contentBgImageTile");
		String contentBorderWidth = cssProps.getProperty("contentBorderWidth");
		String contentBorderStyle = cssProps.getProperty("contentBorderStyle");
		String contentBorderColor = cssProps.getProperty("contentBorderColor");
		String contentTextColor = cssProps.getProperty("contentTextColor");
		String contentTextDecor = cssProps.getProperty("contentTextDecor");
		String contentTextFont = cssProps.getProperty("contentTextFont");
		String contentTextSize = cssProps.getProperty("contentTextSize");
		String contentTextStyle = cssProps.getProperty("contentTextStyle");
		String contentTextBold = cssProps.getProperty("contentTextBold");
		%>

		<c:if test="<%= Validator.isNotNull(headerBgColor) %>">
			background-color: <%= contentBgColor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentBgImageUrl) %>">
			background-image: url(<%= contentBgImageUrl %>);
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentBgImageAttach) %>">
			background-attachment: <%= contentBgImageAttach %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentBgImagePos) %>">
			background-position: <%= contentBgImagePos %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentBgImageTile) %>">
			background-repeat: <%= contentBgImageTile %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentBorderWidth) %>">
			border-width: <%= contentBorderWidth %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentBorderStyle) %>">
			border-style: <%= contentBorderStyle %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentBorderColor) %>">
			border-color: <%= contentBorderColor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentTextColor) %>">
			color: <%= contentTextColor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentTextDecor) %>">
			text-decoration: <%= contentTextDecor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentTextFont) %>">
			font-family: <%= contentTextFont %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentTextSize) %>">
			font-size: <%= contentTextSize %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentTextStyle) %>">
			font-style: italic;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentTextBold) %>">
			font-weight: bold;
		</c:if>
	}

	#p_p_id<%= portletDisplay.getNamespace() %> <%= portletBoxClass %> A {

		<%
		String contentLinkColor = cssProps.getProperty("contentLinkColor");
		String contentLinkDecor = cssProps.getProperty("contentLinkDecor");
		String contentLinkFont = cssProps.getProperty("contentLinkFont");
		String contentLinkSize = cssProps.getProperty("contentLinkSize");
		String contentLinkStyle = cssProps.getProperty("contentLinkStyle");
		String contentLinkBold = cssProps.getProperty("contentLinkBold");
		%>

		<c:if test="<%= Validator.isNotNull(contentLinkColor) %>">
			color: <%= contentLinkColor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkDecor) %>">
			text-decoration: <%= contentLinkDecor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkFont) %>">
			font-family: <%= contentLinkFont %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkSize) %>">
			font-size: <%= contentLinkSize %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkStyle) %>">
			font-style: italic;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkBold) %>">
			font-weight: bold;
		</c:if>
	}

	#p_p_id<%= portletDisplay.getNamespace() %> <%= portletBoxClass %> A:visited {

		<%
		String contentLinkVisitedColor = cssProps.getProperty("contentLinkVisitedColor");
		String contentLinkVisitedDecor = cssProps.getProperty("contentLinkVisitedDecor");
		String contentLinkVisitedFont = cssProps.getProperty("contentLinkVisitedFont");
		String contentLinkVisitedSize = cssProps.getProperty("contentLinkVisitedSize");
		String contentLinkVisitedStyle = cssProps.getProperty("contentLinkVisitedStyle");
		String contentLinkVisitedBold = cssProps.getProperty("contentLinkVisitedBold");
		%>

		<c:if test="<%= Validator.isNotNull(contentLinkVisitedColor) %>">
			color: <%= contentLinkVisitedColor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkVisitedDecor) %>">
			text-decoration: <%= contentLinkVisitedDecor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkVisitedFont) %>">
			font-family: <%= contentLinkVisitedFont %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkVisitedSize) %>">
			font-size: <%= contentLinkVisitedSize %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkVisitedStyle) %>">
			font-style: italic;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkVisitedBold) %>">
			font-weight: bold;
		</c:if>
	}

	#p_p_id<%= portletDisplay.getNamespace() %> <%= portletBoxClass %> A:hover {

		<%
		String contentLinkHoverColor = cssProps.getProperty("contentLinkHoverColor");
		String contentLinkHoverDecor = cssProps.getProperty("contentLinkHoverDecor");
		String contentLinkHoverFont = cssProps.getProperty("contentLinkHoverFont");
		String contentLinkHoverSize = cssProps.getProperty("contentLinkHoverSize");
		String contentLinkHoverStyle = cssProps.getProperty("contentLinkHoverStyle");
		String contentLinkHoverBold = cssProps.getProperty("contentLinkHoverBold");
		%>

		<c:if test="<%= Validator.isNotNull(contentLinkHoverColor) %>">
			color: <%= contentLinkHoverColor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkHoverDecor) %>">
			text-decoration: <%= contentLinkHoverDecor %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkHoverFont) %>">
			font-family: <%= contentLinkHoverFont %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkHoverSize) %>">
			font-size: <%= contentLinkHoverSize %>;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkHoverStyle) %>">
			font-style: italic;
		</c:if>

		<c:if test="<%= Validator.isNotNull(contentLinkHoverBold) %>">
			font-weight: bold;
		</c:if>
	}
</style>
