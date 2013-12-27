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

<%@ include file="/html/common/init.jsp" %>

<portlet:defineObjects />

<tiles:useAttribute id="tilesPortletContent" name="portlet_content" classname="java.lang.String" ignore="true" />
<tiles:useAttribute id="tilesPortletDecorate" name="portlet_decorate" classname="java.lang.String" ignore="true" />
<tiles:useAttribute id="tilesPortletPadding" name="portlet_padding" classname="java.lang.String" ignore="true" />

<%
Portlet portlet = (Portlet)request.getAttribute(WebKeys.RENDER_PORTLET);

PortletPreferences portletSetup = PortletPreferencesFactory.getPortletSetup(request, portletDisplay.getId(), true, true);

RenderResponseImpl renderResponseImpl = (RenderResponseImpl)renderResponse;

String currentURL = PortletURLUtil.getCurrent(renderRequest, renderResponse).toString();

// Portlet decorate

boolean tilesPortletDecorateBoolean = GetterUtil.getBoolean(tilesPortletDecorate, true);

boolean portletDecorate = GetterUtil.getBoolean(portletSetup.getValue("portlet-setup-show-borders", String.valueOf(tilesPortletDecorateBoolean)));

//if (!renderRequest.getWindowState().equals(WindowState.NORMAL)) {
//	portletDecorate = true;
//}

// Portlet padding

boolean portletPadding = GetterUtil.getBoolean(tilesPortletPadding, true);

if (!portletDecorate) {
	portletPadding = false;
}

Properties cssProps = PropertiesUtil.load(portletSetup.getValue("portlet-setup-css", StringPool.BLANK));
%>

<c:if test="<%= (cssProps != null) && (cssProps.size() > 0) %>">
	<%@ include file="/html/common/themes/portlet_css.jsp" %>
</c:if>

<%

// Portlet title

String portletTitle = PortletConfigurationUtil.getPortletTitle(portletSetup, LocaleUtil.toLanguageId(locale));

if (portletDisplay.isAccess() && portletDisplay.isActive()) {
	if (Validator.isNull(portletTitle)) {
		portletTitle = renderResponseImpl.getTitle();
	}
}

if (Validator.isNull(portletTitle)) {
	ResourceBundle resourceBundle = portletConfig.getResourceBundle(locale);

	portletTitle = resourceBundle.getString(WebKeys.JAVAX_PORTLET_TITLE);
}

portletDisplay.setTitle(portletTitle);

// URL configuration

PortletURLImpl urlConfiguration = new PortletURLImpl(request, PortletKeys.PORTLET_CONFIGURATION, plid, false);

urlConfiguration.setWindowState(WindowState.MAXIMIZED);

if (Validator.isNotNull(portlet.getConfigurationPath())) {
	urlConfiguration.setParameter("struts_action", "/portlet_configuration/edit_configuration");
}
else {
	urlConfiguration.setParameter("struts_action", "/portlet_configuration/edit_look_and_feel");
}

urlConfiguration.setParameter("portletResource", portletDisplay.getId());
urlConfiguration.setParameter("redirect", currentURL);

portletDisplay.setURLConfiguration("javascript: self.location = '" + Http.encodeURL(urlConfiguration.toString()) + "&" + PortalUtil.getPortletNamespace(PortletKeys.PORTLET_CONFIGURATION) + "previewWidth=' + document.getElementById('p_p_id" + portletDisplay.getNamespace() + "').offsetWidth;");

// URL close

String urlClose = "javascript: closePortlet('" + plid + "', '" + portletDisplay.getId() + "', '" + themeDisplay.getDoAsUserId() + "');";

portletDisplay.setURLClose(urlClose.toString());

// URL edit

PortletURLImpl urlEdit = new PortletURLImpl(request, portletDisplay.getId(), plid, false);

if (portletDisplay.isModeEdit()) {
	urlEdit.setWindowState(WindowState.NORMAL);
	urlEdit.setPortletMode(PortletMode.VIEW);
}
else {
	if (portlet.isMaximizeEdit()) {
		urlEdit.setWindowState(WindowState.MAXIMIZED);
	}
	else {
		urlEdit.setWindowState(WindowState.NORMAL);
	}

	urlEdit.setPortletMode(PortletMode.EDIT);
}

portletDisplay.setURLEdit(urlEdit.toString());

// URL guest edit

PortletURLImpl urlEditGuest = new PortletURLImpl(request, portletDisplay.getId(), plid, false);

if (portletDisplay.isModeEditGuest()) {
	urlEditGuest.setWindowState(WindowState.NORMAL);
	urlEditGuest.setPortletMode(PortletMode.VIEW);
}
else {
	if (portlet.isMaximizeEdit()) {
		urlEditGuest.setWindowState(WindowState.MAXIMIZED);
	}
	else {
		urlEditGuest.setWindowState(WindowState.NORMAL);
	}

	urlEditGuest.setPortletMode(LiferayPortletMode.EDIT_GUEST);
}

portletDisplay.setURLEditGuest(urlEditGuest.toString());

// URL help

PortletURLImpl urlHelp = new PortletURLImpl(request, portletDisplay.getId(), plid, false);

if (portletDisplay.isModeHelp()) {
	urlHelp.setWindowState(WindowState.NORMAL);
	urlHelp.setPortletMode(PortletMode.VIEW);
}
else {
	if (portlet.isMaximizeHelp()) {
		urlHelp.setWindowState(WindowState.MAXIMIZED);
	}
	else {
		urlHelp.setWindowState(WindowState.NORMAL);
	}

	urlHelp.setPortletMode(PortletMode.HELP);
}

portletDisplay.setURLHelp(urlHelp.toString());

// URL max

boolean action = !portletDisplay.isRestoreCurrentView();

PortletURLImpl urlMax = new PortletURLImpl(request, portletDisplay.getId(), plid, action);

if (portletDisplay.isStateMax()) {
	urlMax.setWindowState(WindowState.NORMAL);
}
else {
	urlMax.setWindowState(WindowState.MAXIMIZED);
}

if (!action) {
	String portletNamespace = portletDisplay.getNamespace();

	Map renderParameters = RenderParametersPool.get(request, plid, portletDisplay.getId());

	Iterator itr = renderParameters.entrySet().iterator();

	while (itr.hasNext()) {
		Map.Entry entry = (Map.Entry)itr.next();

		String key = (String)entry.getKey();

		if (key.startsWith(portletNamespace)) {
			key = key.substring(portletNamespace.length(), key.length());

			String[] values = (String[])entry.getValue();

			urlMax.setParameter(key, values);
		}
	}
}

portletDisplay.setURLMax(urlMax.toString());

// URL min

String urlMin = "javascript: minimizePortlet('" + plid + "', '" + portletDisplay.getId() + "', " + portletDisplay.isStateMin() + ", '" + themeDisplay.getDoAsUserId() + "');";

portletDisplay.setURLMin(urlMin);

// URL print

PortletURLImpl urlPrint = new PortletURLImpl(request, portletDisplay.getId(), plid, false);

if (portletDisplay.isModePrint()) {
	urlPrint.setWindowState(WindowState.NORMAL);
	urlPrint.setPortletMode(PortletMode.VIEW);
}
else {
	if (portlet.isMaximizePrint()) {
		urlPrint.setWindowState(WindowState.MAXIMIZED);
	}
	else {
		urlPrint.setWindowState(WindowState.NORMAL);
	}

	urlPrint.setPortletMode(LiferayPortletMode.PRINT);
}

portletDisplay.setURLPrint(urlPrint.toString());

// URL back

String urlBack = null;

if (portletDisplay.isModeEdit()) {
	urlBack = urlEdit.toString();
}
else if (portletDisplay.isModeHelp()) {
	urlBack = urlHelp.toString();
}
else if (portletDisplay.isModePrint()) {
	urlBack = urlPrint.toString();
}
else if (portletDisplay.isStateMax()) {
	if (portletDisplay.getId().equals(PortletKeys.PORTLET_CONFIGURATION)) {
		String portletResource = ParamUtil.getString(request, "portletResource");

		urlMax.setAnchor(false);

		urlBack = urlMax.toString() + "#p_" + portletResource;
	}
	else {
		urlBack = urlMax.toString();
	}
}

if (urlBack != null) {
	portletDisplay.setShowBackIcon(true);
	portletDisplay.setURLBack(urlBack);
}
%>

<c:choose>
	<c:when test="<%= themeDisplay.isStateExclusive() %>">
		<%@ include file="/html/common/themes/portlet_content_wrapper.jsp" %>
	</c:when>
	<c:when test="<%= themeDisplay.isStatePopUp() %>">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td <%= portletPadding ? "style=\"padding: 4px 8px 10px 8px;\"" : "" %>>
				<c:if test="<%= Validator.isNotNull(tilesPortletContent) %>">
					<liferay-util:include page="<%= Constants.TEXT_HTML_DIR + tilesPortletContent %>" />
				</c:if>

				<c:if test="<%= Validator.isNull(tilesPortletContent) %>">

					<%
					pageContext.getOut().print(renderRequest.getAttribute(WebKeys.PORTLET_CONTENT));
					%>

				</c:if>
			</td>
		</tr>
		</table>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="<%= portletDecorate %>">
				<liferay-theme:box top="portlet_top.jsp" bottom="portlet_bottom.jsp">
					<div id="p_p_content<%= portletDisplay.getNamespace() %>" style="margin-top: 0; margin-bottom: 0;">
						<%@ include file="/html/common/themes/portlet_content_wrapper.jsp" %>
					</div>
				</liferay-theme:box>
			</c:when>
			<c:otherwise>
				<div class="portlet-borderless-container">
					<c:if test="<%= tilesPortletDecorateBoolean && portletDisplay.isShowConfigurationIcon() %>">
						<div class="portlet-borderless-bar">
							<span class="portlet-title-default"><%= portletTitle %></span>

							- <a href="<%= portletDisplay.getURLConfiguration() %>"><bean:message key="configuration" /></a>

							<c:if test="<%= portletDisplay.isShowEditIcon() %>">
								- <a href="<%= portletDisplay.getURLEdit() %>"><bean:message key="preferences" /></a>
							</c:if>

							<c:if test="<%= portletDisplay.isShowCloseIcon() %>">
								- <a href="<%= portletDisplay.getURLClose() %>"><bean:message key="close" /></a>
							</c:if>
						</div>
					</c:if>

					<%@ include file="/html/common/themes/portlet_content_wrapper.jsp" %>
				</div>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
