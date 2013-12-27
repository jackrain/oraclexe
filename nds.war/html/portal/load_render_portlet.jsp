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

String columnId = (String)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_ID);
Integer columnPos = (Integer)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_POS);
Integer columnCount = (Integer)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_COUNT);
%>

<c:choose>
	<c:when test="<%= portlet.getRenderWeight() >= 1 %>">
		[$TEMPLATE_PORTLET_<%= portlet.getPortletId() %>$]
	</c:when>
	<c:otherwise>

		<%
		boolean tilesPortletDecorateBoolean = true;

		try {
		%>

			<tiles:useAttribute id="tilesPortletDecorate" name="portlet_decorate" classname="java.lang.String" ignore="true" />

		<%
			tilesPortletDecorateBoolean = GetterUtil.getBoolean(tilesPortletDecorate, true);
		}
		catch (Exception e) {
		}

		portletDisplay.setId(portlet.getPortletId());
		portletDisplay.setNamespace(PortalUtil.getPortletNamespace(portlet.getPortletId()));

		PortletPreferences portletSetup = PortletPreferencesFactory.getPortletSetup(request, portletDisplay.getId(), true, true);

		boolean portletDecorate = GetterUtil.getBoolean(portletSetup.getValue("portlet-setup-show-borders", String.valueOf(tilesPortletDecorateBoolean)));

		Properties cssProps = PropertiesUtil.load(portletSetup.getValue("portlet-setup-css", StringPool.BLANK));
		%>

		<c:if test="<%= (cssProps != null) && (cssProps.size() > 0) %>">
			<%@ include file="/html/common/themes/portlet_css.jsp" %>
		</c:if>

		<div id="p_load<%= portletDisplay.getNamespace() %>" style="text-align: left;">
			<img src="<%= themeDisplay.getPathThemeImage() %>/progress_bar/loading_animation.gif" />
		</div>

		<script type="text/javascript">
			function <%= portletDisplay.getNamespace() %>returnPortlet(xmlHttpReq) {
				var portletDiv = document.getElementById("p_load<%= portletDisplay.getNamespace() %>");

				addPortletHTML(xmlHttpReq.responseText, portletDiv.parentNode, portletDiv);

				portletDiv.parentNode.removeChild(portletDiv);
			};

			function <%= portletDisplay.getNamespace() %>loadPortlet() {
				var path = "<%= themeDisplay.getPathMain() %>/portal/render_portlet";
				var queryString = "p_l_id=<%= plid %>&p_p_id=<%= portlet.getPortletId() %>&p_p_action=0&p_p_state=normal&p_p_mode=view&p_p_col_id=<%= columnId %>&p_p_col_pos=<%= columnPos %>&p_p_col_count=<%= columnCount %>";

				<%
				String doAsUserId = themeDisplay.getDoAsUserId();

				if (Validator.isNotNull(doAsUserId)) {
				%>

					queryString += "&doAsUserId=<%= Http.encodeURL(doAsUserId) %>";

				<%
				}

				String ppid = ParamUtil.getString(request, "p_p_id");

				if (ppid.equals(portlet.getPortletId())) {
					Enumeration enu = request.getParameterNames();

					while (enu.hasMoreElements()) {
						String name = (String)enu.nextElement();

						if (!PortalUtil.isReservedParameter(name)) {
							String[] values = request.getParameterValues(name);

							for (int i = 0; i < values.length; i++) {
				%>

								queryString += "&<%= name %>=<%= Http.encodeURL(values[i]) %>";

				<%
							}
						}
					}
				}
				%>

				loadPage(path, queryString, <%= portletDisplay.getNamespace() %>returnPortlet);
			}

			<%= portletDisplay.getNamespace() %>loadPortlet();
		</script>
	</c:otherwise>
</c:choose>
