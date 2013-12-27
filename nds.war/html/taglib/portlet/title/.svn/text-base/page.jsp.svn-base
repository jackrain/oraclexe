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

<%
boolean editable = GetterUtil.getBoolean((String)request.getAttribute("liferay-portlet:title:editable"));
%>

<div class="portlet-wrap-title">
	<span class="portlet-title" id="portlet-title-bar_<%= portletDisplay.getId() %>"><%= portletDisplay.getTitle() %></span>
</div>

<c:if test="<%= Validator.isNotNull(portletDisplay.getId()) && editable && themeDisplay.isSignedIn() && PortletPermission.contains(permissionChecker, themeDisplay.getPlid(), portletDisplay.getId(), ActionKeys.CONFIGURATION) %>">
	<script type="text/javascript">
		QuickEdit.create("portlet-title-bar_<%= portletDisplay.getId() %>", {
			dragId: $("p_p_id_<%= portletDisplay.getId() %>_").isStatic == "no" ? "p_p_id_<%= portletDisplay.getId() %>_" : null,
			onEdit:
				function(input, textWidth) {
					input.style.width = (textWidth) + "px";
					input.style.margin = "1px 0 0 5px";
				},
			onComplete:
				function(newTextObj, oldText) {
					var newText = newTextObj.innerHTML;
					if (oldText != newText) {
						var url = "<%= themeDisplay.getPathMain() %>/portlet_configuration/update_title" +
						"?doAsUserId=<%= themeDisplay.getDoAsUserId() %>" +
						"&layoutId=<%= layout.getLayoutId() %>" +
						"&ownerId=<%= layout.getOwnerId() %>" +
						"&portletId=<%= portletDisplay.getId() %>" +
						"&title=" + encodeURIComponent(newText);

						AjaxUtil.request(url);
					}
				}
			});
	</script>
</c:if>
