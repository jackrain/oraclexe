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

<%@ include file="/html/portlet/init.jsp" %>

<%
PortletPreferences prefs = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactory.getPortletSetup(request, portletResource, true, true);
}

String adClient = prefs.getValue("ad-client", StringPool.BLANK);
String adChannel = prefs.getValue("ad-channel", StringPool.BLANK);
int adFormat = GetterUtil.getInteger(prefs.getValue("ad-format", StringPool.BLANK));
int adType = GetterUtil.getInteger(prefs.getValue("ad-type", StringPool.BLANK));

String colorBorder = prefs.getValue("color-border", StringPool.BLANK);
String colorBg = prefs.getValue("color-bg", StringPool.BLANK);
String colorLink = prefs.getValue("color-link", StringPool.BLANK);
String colorText = prefs.getValue("color-text", StringPool.BLANK);
String colorUrl = prefs.getValue("color-url", StringPool.BLANK);

String[][] adFormats = {
	{"0", "0", "0", "(0 x 0) - " + LanguageUtil.get(pageContext, "no-banner")},
	{"1", "728", "90", "(728 x 90) - " + LanguageUtil.get(pageContext, "leaderboard")},
	{"2", "468", "60", "(468 x 60) - " + LanguageUtil.get(pageContext, "banner")},
	{"3", "336", "280", "(336 x 280) - " + LanguageUtil.get(pageContext, "large-rectangle")},
	{"4", "300", "250", "(300 x 250) - " + LanguageUtil.get(pageContext, "medium-rectangle")},
	{"5", "250", "250", "(250 x 250) - " + LanguageUtil.get(pageContext, "square")},
	{"6", "234", "60", "(234 x 60) - " + LanguageUtil.get(pageContext, "half-banner")},
	{"7", "200", "200", "(200 x 200) - " + LanguageUtil.get(pageContext, "small-square")},
	{"8", "180", "150", "(180 x 150) - " + LanguageUtil.get(pageContext, "small-rectangle")},
	{"9", "160", "600", "(160 x 600) - " + LanguageUtil.get(pageContext, "wide-skyscraper")},
	{"10", "125", "125", "(125 x 125) - " + LanguageUtil.get(pageContext, "button")},
	{"11", "120", "600", "(120 x 600) - " + LanguageUtil.get(pageContext, "skyscraper")},
	{"12", "120", "240", "(120 x 240) - " + LanguageUtil.get(pageContext, "vertical-banner")}
};

String[][] adTypes = {
	{"0", LanguageUtil.get(pageContext, "none"), "none"},
	{"1", LanguageUtil.get(pageContext, "text"), "text"},
	{"2", LanguageUtil.get(pageContext, "image"), "image"},
	{"3", LanguageUtil.get(pageContext, "text-and-image"), "text_image"}
};

String adTypeValue = adTypes[adType][2];
int adTypeWidth = GetterUtil.getInteger(adFormats[adFormat][1]);
int adTypeHeight = GetterUtil.getInteger(adFormats[adFormat][2]);
%>
