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

<%@ include file="/html/portlet/quick_note/init.jsp" %>

<div id="<portlet:namespace />pad" style="background: <%= color %>; padding: 2px; margin: 2px;">
	<c:if test="<%= portletDisplay.isShowConfigurationIcon() %>">
		<div class="portlet-title-default">
			<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td>
					<img height="5" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" width="5" style="background-color: #FFFFCC; border: thin solid #FFCC00; cursor: pointer;" onClick="<portlet:namespace />changeColor(this)" />
				</td>
				<td>
					<img height="5" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" width="5" style="background-color: #CCFFCC; border: thin solid #00CC00; cursor: pointer;" onClick="<portlet:namespace />changeColor(this)" />
				</td>
				<td>
					<img height="5" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" width="5" style="background-color: #CCCCFF; border: thin solid #330099; cursor: pointer;" onClick="<portlet:namespace />changeColor(this)" />
				</td>
				<td>
					<img height="5" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" width="5" style="background-color: #FFCCCC; border: thin solid #FF0000; cursor: pointer;" onClick="<portlet:namespace />changeColor(this)" />
				</td>
				<td style="padding-left: 0px; padding-right: 0px;" width="90%" />

				<c:if test="<%= portletDisplay.isShowCloseIcon() %>">
					<td>
						<a border="0" href="<%= portletDisplay.getURLClose() %>"><img height="7" src="<%= themeDisplay.getPathThemeImage() %>/portlet/close.gif" width="7" /></a>
					</td>
				</c:if>
			</tr>
			</table>
		</div>
	</c:if>

	<div id="<portlet:namespace />note"><%= data %></div>
</div>

<c:if test="<%= portletDisplay.isShowConfigurationIcon() %>">
	<script type="text/javascript">
		function <portlet:namespace />changeColor(elem) {
			var color = elem.style.backgroundColor;

			$("<portlet:namespace />pad").style.backgroundColor = color;

			var url =
				"<%= themeDisplay.getPathMain() %>/quick_note/save?" +
				"&plid=<%= plid %>" +
				"&portletId=<%= portletDisplay.getId() %>" +
				"&color=" + color;
			AjaxUtil.request(url);
		}

		QuickEdit.create(
			"<portlet:namespace />note",
			{
				inputType: "textarea",
				onEdit:
					function(input, textWidth, textHeight) {
						textHeight += 5;

						if (textHeight < 100) {
							textHeight = 100;
						}

						input.style.height = (textHeight) + "px";
						input.style.width = "100%";
						input.style.padding = "2px";
					},
				onComplete:
					function(newTextObj, oldText) {
						var newText = newTextObj.innerHTML;

						if (oldText != newText) {
							var url =
								"<%= themeDisplay.getPathMain() %>/quick_note/save?" +
								"&plid=<%= plid %>" +
								"&portletId=<%= portletDisplay.getId() %>" +
								"&data=" + encodeURIComponent(newText);

							AjaxUtil.request(url);
						}
				}
			});
	</script>
</c:if>
