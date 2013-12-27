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

<%@ include file="/html/portal/init.jsp" %>

<%
Portlet portlet = (Portlet)request.getAttribute(WebKeys.RENDER_PORTLET);

String portletId = portlet.getPortletId();
String rootPortletId = portlet.getRootPortletId();
String instanceId = portlet.getInstanceId();

String queryString = (String)request.getAttribute(WebKeys.RENDER_PORTLET_QUERY_STRING);
String columnId = (String)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_ID);
Integer columnPos = (Integer)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_POS);
Integer columnCount = (Integer)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_COUNT);

String portletPrimaryKey = PortletPermission.getPrimaryKey(plid, portletId);

boolean denyAccess = false;

try {
	ResourceLocalServiceUtil.getResource(company.getCompanyId(), rootPortletId, ResourceImpl.TYPE_CLASS, ResourceImpl.SCOPE_INDIVIDUAL, portletPrimaryKey);
}
catch (NoSuchResourceException nsre) {
	boolean addDefaultResource = false;

	Boolean renderPortletResource = (Boolean)request.getAttribute(WebKeys.RENDER_PORTLET_RESOURCE);

	if ((renderPortletResource != null) && renderPortletResource.booleanValue()) {
		addDefaultResource = true;
	}
	else if (layoutTypePortlet.hasPortletId(portletId)) {
		addDefaultResource = true;
	}
	else if (portlet.isAddDefaultResource()) {
		addDefaultResource = true;
	}
	else if (themeDisplay.isSignedIn()) {
		if (portletId.equals(PortletKeys.LAYOUT_CONFIGURATION) || portletId.equals(PortletKeys.LAYOUT_MANAGEMENT)) {
			Group group = layout.getGroup();

			if (group.isCommunity()) {
				if (GroupPermission.contains(permissionChecker, portletGroupId, ActionKeys.MANAGE_LAYOUTS) ||
					LayoutPermission.contains(permissionChecker, layout, ActionKeys.UPDATE)) {

					addDefaultResource = true;
				}
			}
			else if (group.isUser()) {
				if (group.getClassPK().equals(user.getUserId())) {
					addDefaultResource = true;
				}
			}
		}
	}

	if (!portlet.hasAddPortletPermission(user.getUserId())) {
		addDefaultResource = false;
	}

	if (addDefaultResource) {
		ResourceLocalServiceUtil.addResources(company.getCompanyId(), layout.getGroupId(), null, rootPortletId, portletPrimaryKey, true, true, true);
	}
	else {
		denyAccess = true;
	}
}

boolean access = PortletPermission.contains(permissionChecker, plid, portlet, ActionKeys.VIEW);

boolean stateMax = layoutTypePortlet.hasStateMaxPortletId(portletId);
boolean stateMin = layoutTypePortlet.hasStateMinPortletId(portletId);

boolean modeAbout = layoutTypePortlet.hasModeAboutPortletId(portletId);
boolean modeConfig = layoutTypePortlet.hasModeConfigPortletId(portletId);
boolean modeEdit = layoutTypePortlet.hasModeEditPortletId(portletId);
boolean modeEditDefaults = layoutTypePortlet.hasModeEditDefaultsPortletId(portletId);
boolean modeEditGuest = layoutTypePortlet.hasModeEditGuestPortletId(portletId);
boolean modeHelp = layoutTypePortlet.hasModeHelpPortletId(portletId);
boolean modePreview = layoutTypePortlet.hasModePreviewPortletId(portletId);
boolean modePrint = layoutTypePortlet.hasModePrintPortletId(portletId);

CachePortlet cachePortlet = null;

try {
	cachePortlet = PortletInstanceFactory.create(portlet, application);
}
/*catch (UnavailableException ue) {
	ue.printStackTrace();
}*/
catch (PortletException pe) {
	pe.printStackTrace();
}
catch (RuntimeException re) {
	re.printStackTrace();
}

PortletPreferences portletPrefs = PortletPreferencesLocalServiceUtil.getPreferences(company.getCompanyId(), PortletPreferencesFactory.getPortletPreferencesPK(request, portletId));

PortletConfig portletConfig = PortletConfigFactory.create(portlet, application);
PortletContext portletCtx = portletConfig.getPortletContext();

WindowState windowState = WindowState.NORMAL;

if (themeDisplay.isStatePopUp()) {
	windowState = LiferayWindowState.POP_UP;
}
else if (stateMax) {
	windowState = WindowState.MAXIMIZED;
}

PortletMode portletMode = PortletMode.VIEW;

if (modeAbout) {
	portletMode = LiferayPortletMode.ABOUT;
}
else if (modeConfig) {
	portletMode = LiferayPortletMode.CONFIG;
}
else if (modeEdit) {
	portletMode = PortletMode.EDIT;
}
else if (modeEditDefaults) {
	portletMode = LiferayPortletMode.EDIT_DEFAULTS;
}
else if (modeEditGuest) {
	portletMode = LiferayPortletMode.EDIT_GUEST;
}
else if (modeHelp) {
	portletMode = PortletMode.HELP;
}
else if (modePreview) {
	portletMode = LiferayPortletMode.PREVIEW;
}
else if (modePrint) {
	portletMode = LiferayPortletMode.PRINT;
}

HttpServletRequest originalReq = PortalUtil.getOriginalServletRequest(request);

RenderRequestImpl renderRequestImpl = RenderRequestFactory.create(originalReq, portlet, cachePortlet, portletCtx, windowState, portletMode, portletPrefs, plid);

if (Validator.isNotNull(queryString)) {
	DynamicServletRequest dynamicReq = (DynamicServletRequest)renderRequestImpl.getHttpServletRequest();

	String[] params = StringUtil.split(queryString, StringPool.AMPERSAND);

	for (int i = 0; i < params.length; i++) {
		String[] kvp = StringUtil.split(params[i], StringPool.EQUAL);

		dynamicReq.setParameter(kvp[0], kvp[1]);
	}
}

StringServletResponse stringServletRes = new StringServletResponse(response);

RenderResponseImpl renderResponseImpl = RenderResponseFactory.create(renderRequestImpl, stringServletRes, portletId, company.getCompanyId(), plid);

renderRequestImpl.defineObjects(portletConfig, renderResponseImpl);

boolean showCloseIcon = true;
boolean showConfigurationIcon = false;
boolean showEditIcon = false;
boolean showEditGuestIcon = false;
boolean showHelpIcon = portlet.hasPortletMode(renderResponseImpl.getContentType(), PortletMode.HELP);
boolean showMaxIcon = true;
boolean showMinIcon = true;
boolean showMoveIcon = !stateMax;
boolean showPrintIcon = portlet.hasPortletMode(renderResponseImpl.getContentType(), LiferayPortletMode.PRINT);

if (!portletId.equals(PortletKeys.PORTLET_CONFIGURATION)) {
	if (PortletPermission.contains(permissionChecker, plid, portletId, ActionKeys.CONFIGURATION)) {
		showConfigurationIcon = true;
	}
}

if (portlet.hasPortletMode(renderResponseImpl.getContentType(), PortletMode.EDIT)) {
	if (PortletPermission.contains(permissionChecker, plid, portletId, ActionKeys.PREFERENCES)) {
		showEditIcon = true;
	}
}

if (portlet.hasPortletMode(renderResponseImpl.getContentType(), LiferayPortletMode.EDIT_GUEST)) {
	if (showEditIcon && !layout.isPrivateLayout() && themeDisplay.isShowAddContentIcon()) {
		showEditGuestIcon = true;
	}
}

// Unauthenticated users and users without UPDATE permission for the layout
// cannot modify the layout

if (!themeDisplay.isSignedIn() ||
	!LayoutPermission.contains(permissionChecker, layout, ActionKeys.UPDATE)) {

	showCloseIcon = false;
	showMaxIcon = GetterUtil.getBoolean(PropsUtil.get(PropsUtil.LAYOUT_GUEST_SHOW_MAX_ICON));
	showMinIcon = GetterUtil.getBoolean(PropsUtil.get(PropsUtil.LAYOUT_GUEST_SHOW_MIN_ICON));
	showMoveIcon = false;
}

// Portlets cannot be moved unless they belong to the layout

if (!layoutTypePortlet.hasPortletId(portletId)) {
	showCloseIcon = false;
	showMoveIcon = false;
}

// Static portlets cannot be moved

if (portlet.isStatic()) {
	showCloseIcon = false;
	showMoveIcon = false;
}

// Deny access

if (denyAccess) {
	access = false;

	showCloseIcon = false;
	showConfigurationIcon = false;
	showEditIcon = false;
	showEditGuestIcon = false;
	showHelpIcon = false;
	showMaxIcon = false;
	showMinIcon = false;
	showMoveIcon = false;
	showPrintIcon = false;
}

portletDisplay.recycle();

portletDisplay.setId(portletId);
portletDisplay.setRootPortletId(rootPortletId);
portletDisplay.setInstanceId(instanceId);
portletDisplay.setResourcePK(portletPrimaryKey);
portletDisplay.setPortletName(portletConfig.getPortletName());
portletDisplay.setNamespace(PortalUtil.getPortletNamespace(portletId));

portletDisplay.setAccess(access);
portletDisplay.setActive(portlet.isActive());

portletDisplay.setColumnId(columnId);
portletDisplay.setColumnPos(columnPos.intValue());
portletDisplay.setColumnCount(columnCount.intValue());

portletDisplay.setStateExclusive(themeDisplay.isStateExclusive());
portletDisplay.setStateMax(stateMax);
portletDisplay.setStateMin(stateMin);
portletDisplay.setStatePopUp(themeDisplay.isStatePopUp());

portletDisplay.setModeAbout(modeAbout);
portletDisplay.setModeConfig(modeConfig);
portletDisplay.setModeEdit(modeEdit);
portletDisplay.setModeEditDefaults(modeEditDefaults);
portletDisplay.setModeEditGuest(modeEditGuest);
portletDisplay.setModeHelp(modeHelp);
portletDisplay.setModePreview(modePreview);
portletDisplay.setModePrint(modePrint);

portletDisplay.setShowCloseIcon(showCloseIcon);
portletDisplay.setShowConfigurationIcon(showConfigurationIcon);
portletDisplay.setShowEditIcon(showEditIcon);
portletDisplay.setShowEditGuestIcon(showEditGuestIcon);
portletDisplay.setShowHelpIcon(showHelpIcon);
portletDisplay.setShowMaxIcon(showMaxIcon);
portletDisplay.setShowMinIcon(showMinIcon);
portletDisplay.setShowMoveIcon(showMoveIcon);
portletDisplay.setShowPrintIcon(showPrintIcon);

portletDisplay.setRestoreCurrentView(portlet.isRestoreCurrentView());

if ((cachePortlet != null) && cachePortlet.isStrutsPortlet()) {

	// Make sure the Tiles context is reset for the next portlet

	request.removeAttribute(ComponentConstants.COMPONENT_CONTEXT);
}

boolean portletException = false;

if (portlet.isActive() && access) {
	try {
		cachePortlet.render(renderRequestImpl, renderResponseImpl);
	}
	catch (UnavailableException ue) {
		portletException = true;

		PortletInstanceFactory.destroy(portlet);
	}
	catch (Exception e) {
		portletException = true;

		LogUtil.log(_log, e);
	}

	SessionMessages.clear(renderRequestImpl);
	SessionErrors.clear(renderRequestImpl);
}
%>

<%@ include file="/html/portal/render_portlet-ext.jsp" %>

<c:if test="<%= !themeDisplay.isStateExclusive() %>">
	<div id="p_p_id<%= renderResponseImpl.getNamespace() %>" class="portlet-boundary portlet-boundary<%= PortalUtil.getPortletNamespace(portlet.getRootPortletId()) %>">
		<a name="p_<%= portletId %>"></a>
</c:if>

<c:choose>
	<c:when test="<%= !access && !portlet.isShowPortletAccessDenied() %>">
	</c:when>
	<c:when test="<%= !portlet.isActive() && !portlet.isShowPortletInactive() %>">
	</c:when>
	<c:otherwise>

		<%
		boolean useDefaultTemplate = portlet.isUseDefaultTemplate();
		Boolean useDefaultTemplateObj = renderResponseImpl.getUseDefaultTemplate();

		if (useDefaultTemplateObj != null) {
			useDefaultTemplate = useDefaultTemplateObj.booleanValue();
		}

		if ((cachePortlet != null) && cachePortlet.isStrutsPortlet()) {
			if (!access || portletException) {
				PortletRequestProcessor portletReqProcessor = (PortletRequestProcessor)portletCtx.getAttribute(WebKeys.PORTLET_STRUTS_PROCESSOR);

				ActionMapping actionMapping = portletReqProcessor.processMapping(request, response, (String)portlet.getInitParams().get("view-action"));

				ComponentDefinition definition = null;

				if (actionMapping != null) {

					// See action path /weather/view

					String definitionName = actionMapping.getForward();

					if (definitionName == null) {

						// See action path /journal/view_articles

						String[] definitionNames = actionMapping.findForwards();

						for (int definitionNamesPos = 0; definitionNamesPos < definitionNames.length; definitionNamesPos++) {
							if (definitionNames[definitionNamesPos].endsWith("view")) {
								definitionName = definitionNames[definitionNamesPos];

								break;
							}
						}

						if (definitionName == null) {
							definitionName = definitionNames[0];
						}
					}

					definition = TilesUtil.getDefinition(definitionName, request, application);
				}

				String templatePath = Constants.TEXT_HTML_DIR + "/common/themes/portlet.jsp";

				if (definition != null) {
					templatePath = Constants.TEXT_HTML_DIR + definition.getPath();
				}
		%>

				<tiles:insert template="<%= templatePath %>" flush="false">
					<tiles:put name="portlet_content" value="/portal/portlet_error.jsp" />
				</tiles:insert>

		<%
			}
			else {
				if (useDefaultTemplate) {
					renderRequestImpl.setAttribute(WebKeys.PORTLET_CONTENT, stringServletRes.getString());
		%>

					<tiles:insert template='<%= Constants.TEXT_HTML_DIR + "/common/themes/portlet.jsp" %>' flush="false">
						<tiles:put name="portlet_content" value="<%= StringPool.BLANK %>" />
					</tiles:insert>

		<%
				}
				else {
					pageContext.getOut().print(stringServletRes.getString());
				}
			}
		}
		else {
			renderRequestImpl.setAttribute(WebKeys.PORTLET_CONTENT, stringServletRes.getString());

			String portletContent = StringPool.BLANK;

			if (portletException) {
				portletContent = "/portal/portlet_error.jsp";
			}
		%>

			<c:choose>
				<c:when test="<%= useDefaultTemplate || portletException %>">
					<tiles:insert template='<%= Constants.TEXT_HTML_DIR + "/common/themes/portlet.jsp" %>' flush="false">
						<tiles:put name="portlet_content" value="<%= portletContent %>" />
					</tiles:insert>
				</c:when>
				<c:otherwise>
					<%= renderRequestImpl.getAttribute(WebKeys.PORTLET_CONTENT) %>
				</c:otherwise>
			</c:choose>

		<%
		}
		%>

	</c:otherwise>
</c:choose>

<c:if test="<%= !themeDisplay.isStateExclusive() %>">
	</div>
</c:if>

<%
if (themeDisplay.isSignedIn() && !themeDisplay.isStateExclusive()) {
	String staticVar = "no";

	if (portlet.isStatic() || !portletDisplay.isShowMoveIcon()) {
		staticVar = "yes";

		if (portlet.isStaticStart()) {
			staticVar = "start";
		}

		if (portlet.isStaticEnd()) {
			staticVar = "end";
		}
	}
%>

	<script type="text/javascript">
		$("p_p_id<%= portletDisplay.getNamespace() %>").portletId = "<%= portletDisplay.getId() %>";

		<c:if test='<%= !staticVar.equals("no") %>'>
			$("p_p_id<%= portletDisplay.getNamespace() %>").isStatic = "<%= staticVar %>";
		</c:if>
	</script>

<%
}

RenderRequestFactory.recycle(renderRequestImpl);
RenderResponseFactory.recycle(renderResponseImpl);
%>

<%!
private static Log _log = LogFactoryUtil.getLog("portal-web.docroot.html.portal.render_portlet.jsp");
%>
