<%
/**
 * Copyright (c) 2000-2006 Liferay, Inc. All rights reserved.
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

/******************************************************************************/
/* Liferay                                                                    */
/******************************************************************************/

/* Global */

<%

String fontXXS = "0.7em";
String fontXS = "0.8em";
String fontS = "0.9em";
String fontDefault = "1em";
String fontL = "1.1em";
String fontXL = "1.2em";
String fontXXL = "1.3em";

%>

a {
	color: <%= colorScheme.getPortletFontDim() %>;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

body {
	border: 0;
	margin: 0;
	padding: 0;
	text-align: center;
	font-family: Tahoma, Arial;
	font-size: 76%;
}

body#portal-body {
	background-color: <%= colorScheme.getBodyBg() %>;
	height: 100%;
}

body * { font-size: <%= fontDefault %>; }

.font-xx-small { font-size: <%= fontXXS %>; }
.font-x-small { font-size: <%= fontXS %>; }
.font-small { font-size: <%= fontS %>; }
.font-large { font-size: <%= fontL %>; }
.font-x-large { font-size: <%= fontXL %>; }
.font-xx-large { font-size: <%= fontXXL %>; }

form {
	margin: 0;
	padding: 0;
}

select {
	border-color: #CCCCCC;
	border-style: solid;
	border-width: 1px;
}

ul {
	list-style-type: none;
	margin: 5px 0 5px 5px;
	padding: 0;
}

img { border: 0; margin: 0; padding: 0 }

input, button, select {/* font-size: <%= fontXS %>;*/ }

textarea { font-family: Arial; font-size: <%= fontDefault %>; }

.form-button {
	border-color: <%= colorScheme.getPortletTitleBg() %>;
	border-style: solid;
	border-width: 1px;
}

.form-button-hover {
	border-bottom: solid 1px <%= colorScheme.getPortletTitleBg() %>;
	border-left: solid 1px <%= colorScheme.getLayoutBg() %>;
	border-right: solid 1px <%= colorScheme.getPortletTitleBg() %>;
	border-top: solid 1px <%= colorScheme.getLayoutBg() %>;
}

.form-text {
	border-color: #CCCCCC;
	border-style: solid;
	border-width: 1px;
}

.tree-js-pop-up DIV {
	background-color: #D3D3D3;
	border: 2px Outset #FFFFFF;
	display: none;
	padding: 4px;
	position: absolute;
	text-align: left;
	z-index: 10;
}

.pop-up-outer { border: 1px solid #383838; background-color: #FFFFFF; }
.pop-up-inner { border: 1px solid #747474; }
.pop-up-header { background-color: #000000; height: 25px; }
.pop-up-title { color: #FFFFFF; font-weight: bold; padding-left: 10px; }
.pop-up-close a { color: #FFFFFF; margin-right: 7px; white-space: nowrap; text-decoration: underline; }

/* Alpha */

.alpha {
	background-color: <%= colorScheme.getPortletTitleBg() %>;
}

.alpha-gradient {
	background: url(<%= themeDisplay.getPathColorSchemeImage() %>/portlet_title_bg_gradient.gif) repeat-x;
}

.alpha-neg-alert {
	color: <%= colorScheme.getPortletMsgError() %>;
}

.alpha-pos-alert {
	color: <%= colorScheme.getPortletMsgSuccess() %>;
}

.alpha-separator {
	background: url(<%= themeDisplay.getPathColorSchemeImage() %>/portlet_title_bg_x.gif) repeat-x;
	height: 1px;
	font-size: 0;
}

A.alpha {
	background: none;
	color: <%= colorScheme.getPortletFont() %>;
	text-decoration: none;
}

A.alpha:hover {
	color: <%= colorScheme.getPortletFont() %>;
	text-decoration: underline;
}

FONT.alpha {
	background: none;
	color: <%= colorScheme.getPortletTitleText() %>;
}

/* Beta */

.beta {
	background-color: <%= colorScheme.getPortletMenuBg() %>;
}

.beta-gradient {
	background: url(<%= themeDisplay.getPathColorSchemeImage() %>/portlet_menu_bg_gradient.gif) repeat-x;
}

.beta-neg-alert {
	color: <%= colorScheme.getPortletMsgError() %>;
}

.beta-pos-alert {
	color: <%= colorScheme.getPortletMsgSuccess() %>;
}

.beta-separator {
	background: url(<%= themeDisplay.getPathColorSchemeImage() %>/portlet_menu_bg_x.gif) repeat-x;
	height: 1px;
	font-size: 0;
}

A.beta {
	background: none;
	color: <%= colorScheme.getPortletFont() %>;
	text-decoration: none;
}

A.beta:hover {
	color: <%= colorScheme.getPortletFont() %>;
	text-decoration: underline;
}

.beta {
	background: none;
	color: <%= colorScheme.getPortletMenuText() %>;
}

/* Gamma */

.gamma {
	background-color: <%= colorScheme.getPortletBg() %>;
}

.gamma-gradient {
	background: url(<%= themeDisplay.getPathColorSchemeImage() %>/portlet_bg_x.gif) repeat-x;
}

.gamma-neg-alert {
	color: <%= colorScheme.getPortletMsgError() %>;
}

.gamma-pos-alert {
	color: <%= colorScheme.getPortletMsgSuccess() %>;
}

.gamma-tab {
	border-bottom: 1px solid <%= colorScheme.getPortletMenuBg() %>;
	margin-left: 0px;
	margin-top: 0px;
	margin-bottom: 15px;
	margin-right: 0px;
	padding-bottom: 27px;
	padding-left: 0px;
}

.gamma-tab ul, .gamma-tab li {
	background: #F6F6F6;
	border: 1px solid #CCCCCC;
	border-bottom: 1px solid <%= colorScheme.getPortletMenuBg() %>;
	color: #CCCCCC;
	display: inline;
	float: left;
	line-height: 22px;
	list-style-type: none;
	margin-right: 8px;
	padding: 2px 10px 2px 10px;
	text-decoration: none;
}

.gamma-tab ul.current, .gamma-tab li.current {
	background: <%= colorScheme.getPortletBg() %>;
	border: 1px solid <%= colorScheme.getPortletMenuBg() %>;
	border-bottom: 1px solid <%= colorScheme.getPortletBg() %>;
	color: <%= colorScheme.getPortletFont() %>;
}

.gamma-tab li a { color: #777777; }
.gamma-tab li.current a { color: <%= colorScheme.getPortletFont() %>; }

.gamma-tab li.toggle {
	background: none;
	border: 0px;
	float: right;
	margin-right: 0px;
	padding-right: 0px;
}

A.gamma {
	background: none;
	color: <%= colorScheme.getPortletFont() %>;
	text-decoration: none;
}

A.gamma:hover {
	color: <%= colorScheme.getPortletFont() %>;
	text-decoration: underline;
}

FONT.gamma {
	background: none;
	color: <%= colorScheme.getPortletFont() %>;
}

/* Bg */

.bg {
	background-color: <%= colorScheme.getLayoutBg() %>;
}

.bg-neg-alert {
	color: <%= colorScheme.getPortletMsgError() %>;
}

.bg-pos-alert {
	color: <%= colorScheme.getPortletMsgSuccess() %>;
}

A.bg {
	background: none;
	color: <%= colorScheme.getPortletFont() %>;
	text-decoration: none;
}

A.bg:hover {
	color: <%= colorScheme.getPortletFont() %>;
	text-decoration: underline;
}

FONT.bg {
	color: <%= colorScheme.getLayoutText() %>;
}

/******************************************************************************/
/* Liferay Layout CSS                                                         */
/******************************************************************************/

#layout-outer-side-decoration {
	background-color: <%= colorScheme.getBodyBg() %>;
	height: 100%;
}

#layout-inner-side-decoration {
	background-color: <%= colorScheme.getLayoutBg() %>;
	height: 100%;
	margin: 0 auto 0 auto;
}

#layout-box {
	text-align: center;
	width: 100%;
}

#layout-top-banner-left {
}
#layout-top-banner-right {
	width: 100%;
}

#layout-top-banner {
	height: 80px;
	position: relative;
	text-align: left;
	z-index: 3;
}

#layout-top-banner * {
	white-space: nowrap;
}

#portal-dock {
	position: absolute;
	right: 10px;
	top: 25px;
	height: 54px;
	width: 54px;
}

#portal-dock-title {
	text-align: right;
	height: 25px;
	position: absolute;
	right: 10px;
	top: 0;
}

.portal-dock-box {
	cursor: pointer;
	font-size: 0;
	height: 54px;
	padding: 2px;
	position: absolute;
	width: 54px;
	top: 0;
	left: 0;
}
.portal-dock-box div {
	background-color: <%= colorScheme.getLayoutTabSelectedBg() %>;
}
#layout-company-logo {
	position: absolute;
	top: 0px;
	left: 0px;
}
#layout-user-menu {
	position: relative;
	text-align: right;
	height:80px;
}

#layout-global-search {
}

#layout-nav-more-menu li {
	padding: 2px 2px 2px 5px;
}

#layout-nav-container {
	float: left;
	z-index: 2;
}

#layout-nav-divider {
	clear: both;
	font-size: 0;
	height: 10px;
	margin-bottom: 10px;
}

.layout-nav-divider {
	background-color: <%= colorScheme.getLayoutTabBg() %>;
}
.layout-nav-selected  {
	background-color: <%= colorScheme.getLayoutTabSelectedBg() %>;
}

.layout-nav-tabs-box {
	height: 27px;
	position: relative;
}

.layout-tab, #layout-tab-add {
	background-color: <%= colorScheme.getLayoutTabBg() %>;
	float: left;
	font-weight: bold;
	height: 27px;
	margin-right: 1px;
	margin-top: 1px;
	position: relative;
	text-align: right;
}

.layout-tab a {
	color: <%= colorScheme.getLayoutTabText() %>;
}

#layout-tab-add, #layout-tab-add a {
	background-color: <%= colorScheme.getLayoutBg() %>;
	color: <%= colorScheme.getLayoutText() %>;
	font-weight: normal;
}

#layout-tab-selected, #layout-tab-selected a {
	background-color: <%= colorScheme.getLayoutTabSelectedBg() %>;
	color: <%= colorScheme.getLayoutTabSelectedText() %>;
}
.layout-tab-text {
	padding: 6px 10px 0 10px;
}


.layout-tab-text * {
	white-space: nowrap;
}

.layout-tab-text-editing {
	padding: 0 0 0 0;
}

.layout-tab-close {
	margin: 6px 3px 0 0;
}

.layout-tab-input {
	margin: 6px 2px 0 0;
}

#layout-content-outer-decoration {
	z-index: 0;
}

/* Column Layout */

#layout-bottom-container {
	text-align: center;
}

.layout-add-select-style {
}

.portal-add-content {
	padding: 8px;
}

.portal-tool-tip {
	background-color: #FFFFCC;
	border: 1px solid #000000;
	padding: 2px;
	font-size: <%= fontS %>;
}

.layout-column-arrow-up {
	<c:if test="<%= BrowserSniffer.is_ie(request) %>">
		filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= themeDisplay.getPathThemeImage() %>/arrows/arrow-up.png', sizingMethod='scale');
	</c:if>
	<c:if test="<%= !BrowserSniffer.is_ie(request) %>">
		background-image: url(<%= themeDisplay.getPathThemeImage() %>/arrows/arrow-up.png);
	</c:if>
	font-size: 0;
	position: absolute;
	height: 48px;
	width: 40px;
}

.layout-column-arrow-down {
	<c:if test="<%= BrowserSniffer.is_ie(request) %>">
		filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= themeDisplay.getPathThemeImage() %>/arrows/arrow-down.png', sizingMethod='scale');
	</c:if>
	<c:if test="<%= !BrowserSniffer.is_ie(request) %>">
		background-image: url(<%= themeDisplay.getPathThemeImage() %>/arrows/arrow-down.png);
	</c:if>
	font-size: 0;
	position: absolute;
	height: 48px;
	width: 40px;
}

#layout-column_column-1,
#layout-column_column-2,
#layout-column_column-3,
#layout-column_column-4,
#layout-column_column-5,
#layout-column_column-6,
#layout-column_column-7,
#layout-column_column-8,
#layout-column_column-9,
#layout-column_column-10,
#layout-column_column-11,
#layout-column_column-12,
#layout-column_column-13
{
	<c:choose>
		<c:when test="<%= BrowserSniffer.is_ie(request) %>">
			height: 25px;
		</c:when>
		<c:otherwise>
			min-height: 25px;
		</c:otherwise>
	</c:choose>
}

.layout-column-highlight {
	background: url(<%= themeDisplay.getPathThemeImage() %>/common/diagonal-lines.gif) scroll repeat;
}

/******************************************************************************/
/* Portlet CSS                                                                */
/******************************************************************************/

/* Liferay Portlet */

<%--
<c:choose>
	<c:when test="<%= BrowserSniffer.is_ie(request) %>">
	#portlet-dragging * {
		filter: alpha(opacity=75);
	}
	</c:when>
	<c:otherwise>
	#portlet-dragging {
		opacity: 0.75;
	}
	</c:otherwise>
</c:choose>
--%>

.portlet-dragging-placeholder {
	background-color: <%= colorScheme.getPortletSectionBodyBg() %>;
}

#portlet-place-holder DIV {
	background-color: <%= colorScheme.getPortletMenuBg() %>;
}

.portlet-loading {
	background: url(<%= themeDisplay.getPathThemeImage() %>/progress_bar/loading_animation.gif) no-repeat top left;
	margin-top: 10px;
	padding-top: 40px;
	text-align: left;
}

.portlet-shadow-tl div {
	<c:if test="<%= BrowserSniffer.is_ie(request) %>">
		filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= themeDisplay.getPathThemeImage() %>/shadow/shade-tl.png', sizingMethod='scale');
	</c:if>
	<c:if test="<%= !BrowserSniffer.is_ie(request) %>">
		background-image: url(<%= themeDisplay.getPathThemeImage() %>/shadow/shade-tl.png);
	</c:if>
	font-size: 0;
	height: 3px;
	width: 4px;
}

.portlet-shadow-tc {
	<c:if test="<%= BrowserSniffer.is_ie(request) %>">
		filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= themeDisplay.getPathThemeImage() %>/shadow/shade-tc.png', sizingMethod='scale');
	</c:if>
	<c:if test="<%= !BrowserSniffer.is_ie(request) %>">
		background-image: url(<%= themeDisplay.getPathThemeImage() %>/shadow/shade-tc.png);
	</c:if>
}

.portlet-shadow-tr div {
	<c:if test="<%= BrowserSniffer.is_ie(request) %>">
		filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= themeDisplay.getPathThemeImage() %>/shadow/shade-tr.png', sizingMethod='scale');
	</c:if>
	<c:if test="<%= !BrowserSniffer.is_ie(request) %>">
		background-image: url(<%= themeDisplay.getPathThemeImage() %>/shadow/shade-tr.png);
	</c:if>
	font-size: 0;
	height: 3px;
	width: 4px;
}

.portlet-shadow-ml  {
	<c:if test="<%= BrowserSniffer.is_ie(request) %>">
		filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= themeDisplay.getPathThemeImage() %>/shadow/shade-ml.png', sizingMethod='scale');
	</c:if>
	<c:if test="<%= !BrowserSniffer.is_ie(request) %>">
		background-image: url(<%= themeDisplay.getPathThemeImage() %>/shadow/shade-ml.png);
	</c:if>
}

.portlet-shadow-mr  {
	<c:if test="<%= BrowserSniffer.is_ie(request) %>">
		filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= themeDisplay.getPathThemeImage() %>/shadow/shade-mr.png', sizingMethod='scale');
	</c:if>
	<c:if test="<%= !BrowserSniffer.is_ie(request) %>">
		background-image: url(<%= themeDisplay.getPathThemeImage() %>/shadow/shade-mr.png);
	</c:if>
}

.portlet-shadow-bl div {
	<c:if test="<%= BrowserSniffer.is_ie(request) %>">
		filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= themeDisplay.getPathThemeImage() %>/shadow/shade-bl.png', sizingMethod='scale');
	</c:if>
	<c:if test="<%= !BrowserSniffer.is_ie(request) %>">
		background-image: url(<%= themeDisplay.getPathThemeImage() %>/shadow/shade-bl.png);
	</c:if>
	font-size: 0;
	height: 7;
	width: 8px;
}
.portlet-shadow-bc {
	<c:if test="<%= BrowserSniffer.is_ie(request) %>">
		filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= themeDisplay.getPathThemeImage() %>/shadow/shade-bc.png', sizingMethod='scale');
	</c:if>
	<c:if test="<%= !BrowserSniffer.is_ie(request) %>">
		background-image: url(<%= themeDisplay.getPathThemeImage() %>/shadow/shade-bc.png);
	</c:if>
}
.portlet-shadow-br div {
	<c:if test="<%= BrowserSniffer.is_ie(request) %>">
		filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= themeDisplay.getPathThemeImage() %>/shadow/shade-br.png', sizingMethod='scale');
	</c:if>
	<c:if test="<%= !BrowserSniffer.is_ie(request) %>">
		background-image: url(<%= themeDisplay.getPathThemeImage() %>/shadow/shade-br.png);
	</c:if>
	font-size: 0;
	height: 7px;
	width: 8px;
}

.portlet-container {
	background-color: <%= colorScheme.getPortletBg() %>;
}
.portlet-table {
	border: 1px solid <%= colorScheme.getPortletTitleBg() %>;
}
.portlet-box {
	border: 0px solid <%= colorScheme.getPortletTitleBg() %>;
	margin-top: 1px;
}

.portlet-minimum-height {
	<c:if test="<%= BrowserSniffer.is_ie(request) %>">
		height: 1px;
	</c:if>
}

.portlet-header-bar {
	border: 0px solid <%= colorScheme.getPortletTitleBg() %>;
	background: <%= colorScheme.getPortletTitleBg() %> url(<%= themeDisplay.getPathColorSchemeImage() %>/header_gradient.gif) scroll repeat-x center left;
	position: relative;
}

.portlet-borderless-container { position: relative; }
.portlet-borderless-bar { text-align: left; font-size: <%= fontXS %>; }

.portlet-wrap-title {
	height: 20px;
	position: relative;
}

.portlet-title {
	color: <%= colorScheme.getPortletTitleText() %>;
	font-weight: bold;
	position: absolute;
	top: 3px;
	left: 5px;
}

.portlet-small-icon-bar {
	padding-left: 2px;
	position: absolute;
	<c:choose>
		<c:when test="<%= BrowserSniffer.is_ie(request) %>">
			top: 3px;
		</c:when>
		<c:otherwise>
			top: 1px;
		</c:otherwise>
	</c:choose>
	right: 2px;
}

.portlet-spacer {
	font-size: 0;
	height: 1px;
}

/* Fonts */

.portlet-font {
	color: <%= colorScheme.getPortletFont() %>;
}

.portlet-font A {
	color: <%= colorScheme.getPortletFont() %>;
}

.portlet-font-dim {
	color: <%= colorScheme.getPortletFontDim() %>;
}

/* Messages */

.portlet-msg-status {
	color: <%= colorScheme.getPortletMsgStatus() %>;
	font-style: italic;
}

.portlet-msg-info {
	color: <%= colorScheme.getPortletMsgInfo() %>;
}

.portlet-msg-error {
	color: <%= colorScheme.getPortletMsgError() %>;
}

.portlet-msg-alert {
	color: <%= colorScheme.getPortletMsgAlert() %>;
	font-style: italic;
}

.portlet-msg-success {
	color: <%= colorScheme.getPortletMsgSuccess() %>;
}

/* Sections */

.portlet-section-header {
	background: <%= colorScheme.getPortletSectionHeaderBg() %>;
	color: <%= colorScheme.getPortletSectionHeader() %>;
	font-weight: bold;
}

.portlet-section-header A {
	color: <%= colorScheme.getPortletSectionHeader() %>;
}

.portlet-section-body {
	color: <%= colorScheme.getPortletSectionBody() %>;
	background: <%= colorScheme.getPortletSectionBodyBg() %>;
}

.portlet-section-body-hover, TR.portlet-section-body:hover {
	color: <%= colorScheme.getPortletSectionBodyHover() %>;
	background: <%= colorScheme.getPortletSectionBodyHoverBg() %>;
}

.portlet-section-body A {
	color: <%= colorScheme.getPortletSectionBody() %>;
}

.portlet-section-body-hover A, TR.portlet-section-body:hover A {
	color: <%= colorScheme.getPortletSectionBodyHover() %>;
}

.portlet-section-alternate {
	color: <%= colorScheme.getPortletSectionAlternate() %>;
	background: <%= colorScheme.getPortletSectionAlternateBg() %>;
}

.portlet-section-alternate-hover, TR.portlet-section-alternate:hover {
	color: <%= colorScheme.getPortletSectionAlternateHover() %>;
	background: <%= colorScheme.getPortletSectionAlternateHoverBg() %>;
}

.portlet-section-alternate A {
	color: <%= colorScheme.getPortletSectionAlternate() %>;
}

.portlet-section-alternate-hover A, TR.portlet-section-alternate:hover A {
	color: <%= colorScheme.getPortletSectionAlternateHover() %>;
}

.portlet-section-selected {
	color: <%= colorScheme.getPortletSectionSelected() %>;
	background: <%= colorScheme.getPortletSectionSelectedBg() %>;
}

.portlet-section-selected-hover, TR.portlet-section-selected:hover {
	color: <%= colorScheme.getPortletSectionSelectedHover() %>;
	background: <%= colorScheme.getPortletSectionSelectedHoverBg() %>;
}

.portlet-section-selected A {
	color: <%= colorScheme.getPortletSectionSelected() %>;
}

.portlet-section-selected-hover A, TR.portlet-section-selected:hover A {
	color: <%= colorScheme.getPortletSectionSelectedHover() %>;
}

.portlet-section-subheader {
	background: <%= colorScheme.getPortletSectionSubheaderBg() %>;
	color: <%= colorScheme.getPortletSectionSubheader() %>;
	padding: 2px;
}

.portlet-section-footer {
	color: <%= colorScheme.getLayoutText() %>;
}

.portlet-section-text {
	color: <%= colorScheme.getLayoutText() %>;
}

/* Forms */

.portlet-form-label {
	color: <%= colorScheme.getPortletFont() %>;
}

.portlet-form-input-field {
	border-color: #CCCCCC;
	border-style: solid;
	border-width: 1px;
}

.portlet-form-button {
	background: url(<%= themeDisplay.getPathColorSchemeImage() %>/button_gradient.gif) repeat-x;
	border-color: <%= colorScheme.getPortletTitleBg() %>;
	border-style: solid;
	border-width: 1px;
}

.portlet-icon-label {
	color: <%= colorScheme.getPortletFont() %>;
}

.portlet-dlg-icon-label {
	color: <%= colorScheme.getPortletFont() %>;
}

.portlet-form-field-label {
	color: <%= colorScheme.getPortletFont() %>;
}

.portlet-form-field {
	color: <%= colorScheme.getPortletFont() %>;
}

TR.even { background-color: <%= colorScheme.getPortletMenuBg() %>; color: #000000; }

TR.odd { background-color: <%= colorScheme.getPortletBg() %>; color: #000000; }

.abody_class{scrollbar-face-color:<%= colorScheme.getPortletBg()%>;scrollbar-shadow-color: <%= colorScheme.getPortletBg()%>;scrollbar-darkshadow-color:#999999;}
.input-text{color:<%=colorScheme.getPortletFont()%>;background-color:<%= colorScheme.getPortletBg()%>;}

