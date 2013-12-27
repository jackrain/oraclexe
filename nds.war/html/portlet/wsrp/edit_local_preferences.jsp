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

<%@ include file="/html/portlet/wsrp/init.jsp" %>

<%
PortletPreferences prefs = renderRequest.getPreferences();

String wsrpServiceUrl = prefs.getValue("wsrp-service-url", StringPool.BLANK);
String markupEndpoint = prefs.getValue("markup-endpoint", StringPool.BLANK);
String serviceDescriptionEndpoint = prefs.getValue("service-description-endpoint", StringPool.BLANK);
String registrationEndpoint = prefs.getValue("registration-endpoint", StringPool.BLANK);
String portletManagementEndpoint = prefs.getValue("portlet-management-endpoint", StringPool.BLANK);
String portletHandle = prefs.getValue("portlet-handle", StringPool.BLANK);

PortletDescription[] portletDescs = {};

Throwable error = null;

try {
	Producer producer = (Producer)renderRequest.getAttribute(WebKeys.WSRP_PRODUCER);

	ServiceDescription serviceDesc = producer.getServiceDescription(true);

	portletDescs = serviceDesc.getOfferedPortlets();

	Arrays.sort(portletDescs, WSRPUtil.getPortletDescriptionComparator());
}
catch (Throwable t) {
	error = t;
}
%>

<form action="<portlet:actionURL><portlet:param name="struts_action" value="/wsrp/edit_local_preferences" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm">

<table border="0" cellpadding="4" cellspacing="0" width="100%">
<tr>
	<td align="center">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<table border="0" cellpadding="0" cellspacing="0">
				<c:if test="<%= error != null %>">
					<tr>
						<td colspan="3">
							<font class="portlet-msg-error" style="font-size: xx-small;"><%= LanguageUtil.get(pageContext, "wsrp-your-service-url-or-endpoints-are-unreachable") %></font>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<br>
						</td>
					</tr>
				</c:if>
				<tr>
					<td>
						<font class="portlet-font" style="font-size: x-small;"><%= LanguageUtil.get(pageContext, "wsrp-service-url") %></font>
					</td>
					<td width="10">
						&nbsp;
					</td>
					<td>
						<input name="<portlet:namespace />wsrp_service_url" type="text" size="40" value="<%= wsrpServiceUrl %>" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<br>
					</td>
				</tr>
				<tr>
					<td>
						<font class="portlet-font" style="font-size: x-small;"><%= LanguageUtil.get(pageContext, "wsrp-markup-endpoint") %></font>
					</td>
					<td width="10">
						&nbsp;
					</td>
					<td>
						<input name="<portlet:namespace />markup_endpoint" type="text" size="40" value="<%= markupEndpoint %>" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<br>
					</td>
				</tr>
				<tr>
					<td>
						<font class="portlet-font" style="font-size: x-small;"><%= LanguageUtil.get(pageContext, "wsrp-service-description-endpoint") %></font>
					</td>
					<td width="10">
						&nbsp;
					</td>
					<td>
						<input name="<portlet:namespace />service_description_endpoint" type="text" size="40" value="<%= serviceDescriptionEndpoint %>" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<br>
					</td>
				</tr>
				<tr>
					<td>
						<font class="portlet-font" style="font-size: x-small;"><%= LanguageUtil.get(pageContext, "wsrp-registration-endpoint") %></font>
					</td>
					<td width="10">
						&nbsp;
					</td>
					<td>
						<input name="<portlet:namespace />registration_endpoint" type="text" size="40" value="<%= registrationEndpoint %>" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<br>
					</td>
				</tr>
				<tr>
					<td>
						<font class="portlet-font" style="font-size: x-small;"><%= LanguageUtil.get(pageContext, "wsrp-portlet-management-endpoint") %></font>
					</td>
					<td width="10">
						&nbsp;
					</td>
					<td>
						<input name="<portlet:namespace />portlet_management_endpoint" type="text" size="40" value="<%= portletManagementEndpoint %>" />
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<br>
					</td>
				</tr>
				<tr>
					<td>
						<font class="portlet-font" style="font-size: x-small;"><%= LanguageUtil.get(pageContext, "wsrp-portlet") %></font>
					</td>
					<td width="10">
						&nbsp;
					</td>
					<td>
						<select name="<portlet:namespace />portlet_handle">

							<%
							for (int i = 0; i < portletDescs.length; i++) {
							%>

								<option <%= portletHandle.equals(portletDescs[i].getPortletHandle()) ? "selected" : "" %> value="<%= portletDescs[i].getPortletHandle() %>"><%= portletDescs[i].getTitle().getValue() %></option>

							<%
							}
							%>

						</select>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<br>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<br>
			</td>
		</tr>
		<tr>
			<td align="center">
				<input class="portlet-form-button" type="button" value="<bean:message key="save-settings" />" onClick="submitForm(document.<portlet:namespace />fm);">

				<input class="portlet-form-button" type="button" value="<bean:message key="cancel" />" onClick="self.location = '<portlet:renderURL><portlet:param name="struts_action" value="/wsrp/edit" /></portlet:renderURL>';">
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />wsrp_service_url.focus();
</script>
