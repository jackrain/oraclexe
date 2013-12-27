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

<div style="border: 1px solid <%= colorScheme.getPortletFontDim() %>; margin: 5px 0px 0px <%= depth * 10 %>px; <%= BrowserSniffer.is_ie(request) ? "width: 100%;" : "" %>">
	<table cellpadding="0" cellspacing="0" id="<portlet:namespace />messageScroll<%= message.getMessageId() %>" style="table-layout: fixed;" width="100%">
	<tr>
		<td class="<%= className %>" rowspan="2" style="border-right: 1px solid <%= colorScheme.getPortletFontDim() %>; vertical-align: top;" width="100">
			<div class="message-board-thread-left" style="padding:5px;">
				<c:choose>
					<c:when test="<%= message.isAnonymous() %>">
						<%= LanguageUtil.get(pageContext, "anonymous") %>
					</c:when>
					<c:otherwise>
						<b><%= PortalUtil.getUserName(message.getUserId(), message.getUserName(), request) %></b><br>

						<span style="font-size: xx-small;">

							<%
							try {
								User user2 = UserLocalServiceUtil.getUserById(message.getUserId());
								Organization organization = user2.getOrganization();
								int posts = MBStatsUserLocalServiceUtil.getStatsUser(portletGroupId, message.getUserId()).getMessageCount();
								String rank = MBUtil.getUserRank(portletSetup, LocaleUtil.toLanguageId(locale), posts);
							%>

								<img src="<%= themeDisplay.getPathImage() %>/user_portrait?img_id=<%= message.getUserId() %>" style="margin:10px 0px; width: 75%;"><br>

								<c:if test="<%= Validator.isNotNull(organization.getOrganizationId()) %>">
									<%= LanguageUtil.get(pageContext, "organization") %>: <%= organization.getName() %>

									<br><br>
								</c:if>

								<%= LanguageUtil.get(pageContext, "rank") %>: <%= rank %><br>
								<%= LanguageUtil.get(pageContext, "posts") %>: <%= posts %><br>
								<%= LanguageUtil.get(pageContext, "joined") %>: <%= dateFormatDate.format(user2.getCreateDate()) %>

							<%
							}
							catch (NoSuchStatsUserException nssue) {
							}
							catch (NoSuchUserException nsue) {
							}
							%>

						</span>
					</c:otherwise>
				</c:choose>
			</div>
		</td>
		<td class="<%= className %>" valign="top">
			<div class="message-board-thread-top" style="border-bottom: 1px solid <%= colorScheme.getPortletFontDim() %>; padding: 3px 5px;">
				<div style="float: left;">
					<span>
						<b><%= StringUtil.shorten(message.getSubject(), 50) %></b>
					</span>
					<span style="font-size: xx-small;">
						|

						<%= dateFormatDateTime.format(message.getModifiedDate()) %>

						<%
						MBMessage parentMessage = null;

						try {
							parentMessage = MBMessageLocalServiceUtil.getMessage(message.getParentMessageId());
						}
						catch (Exception e) {}
						%>

						<c:if test="<%= parentMessage != null %>">

							<%
							PortletURL parentMessageURL = renderResponse.createRenderURL();

							parentMessageURL.setWindowState(WindowState.MAXIMIZED);

							parentMessageURL.setParameter("struts_action", "/message_boards/view_message");
							parentMessageURL.setParameter("messageId", parentMessage.getMessageId());

							String author = parentMessage.isAnonymous() ? LanguageUtil.get(pageContext, "anonymous") : PortalUtil.getUserName(parentMessage.getUserId(), parentMessage.getUserName());
							%>

							<%= LanguageUtil.format(pageContext, "posted-as-a-reply-to", author) %>
						</c:if>
					</span>
				</div>

				<c:if test="<%= editable %>">
					<div style="float: right;">
						<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<c:if test="<%= MBCategoryPermission.contains(permissionChecker, category, ActionKeys.ADD_MESSAGE) %>">
								<td>
									<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="replyURL">
										<portlet:param name="struts_action" value="/message_boards/edit_message" />
										<portlet:param name="redirect" value="<%= currentURL %>" />
										<portlet:param name="categoryId" value="<%= message.getCategoryId() %>" />
										<portlet:param name="threadId" value="<%= message.getThreadId() %>" />
										<portlet:param name="parentMessageId" value="<%= message.getMessageId() %>" />
									</portlet:renderURL>

									<liferay-ui:icon image="reply" url="<%= replyURL %>" />

									<a href="<%= replyURL.toString() %>"><%= LanguageUtil.get(pageContext, "reply") %></a>
								</td>
								<td style="padding-left: 15px;"></td>
								<td>
									<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="quoteURL">
										<portlet:param name="struts_action" value="/message_boards/edit_message" />
										<portlet:param name="redirect" value="<%= currentURL %>" />
										<portlet:param name="categoryId" value="<%= message.getCategoryId() %>" />
										<portlet:param name="threadId" value="<%= message.getThreadId() %>" />
										<portlet:param name="parentMessageId" value="<%= message.getMessageId() %>" />
										<portlet:param name="quote" value="true" />
									</portlet:renderURL>

									<liferay-ui:icon image="quote" url="<%= quoteURL %>" />

									<a href="<%= quoteURL.toString() %>"><%= LanguageUtil.get(pageContext, "reply-with-quote") %></a>
								</td>
								<td style="padding-left: 15px;"></td>
							</c:if>

							<td>

								<%
								String topHREF = "javascript: " + renderResponse.getNamespace() + "scrollIntoView('0');";
								%>

								<liferay-ui:icon image="top" url="<%= topHREF %>" />

								<a href="<%= topHREF %>"><%= LanguageUtil.get(pageContext, "top") %></a>
							</td>
						</tr>
						</table>
					</div>
				</c:if>

				<div style="clear: both;"></div>
			</div>
			<div class="message-board-thread-body" style="padding: 15px;">

				<%
				String msgBody = message.getBody(false);

				/*String codeStart = "<!--c1--><div class='codetop'>CODE</div><div class='codemain'><!--ec1-->";
				String codeEnd = "<!--c2--></div><!--ec2-->";

				while (true) {
					int x = msgBody.indexOf(codeStart);
					int y = msgBody.indexOf(codeEnd, x);

					if ((x == -1) || (y == -1)) {
						break;
					}

					String code = msgBody.substring(x + codeStart.length(), y);

					code = StringUtil.replace(code, "<br />", "\n");
					code = StringUtil.replace(code, "&nbsp;", " ");
					code = StringUtil.replace(code, "&#60;", "<");
					code = StringUtil.replace(code, "&#62;", ">");

					msgBody = msgBody.substring(0, x) + "[code]" + code + "[/code]" + msgBody.substring(y + codeEnd.length(), msgBody.length());
				}

				String quoteBegin1 = "<!--QuoteBegin-";
				String quoteBegin2 = "<!--QuoteEBegin-->";

				while (true) {
					int x = msgBody.indexOf(quoteBegin1);
					int y = msgBody.indexOf(quoteBegin2, x);

					if ((x == -1) || (y == -1)) {
						break;
					}

					String replace = msgBody.substring(x, y + quoteBegin2.length());

					msgBody = StringUtil.replace(msgBody, replace, "[quote]");
				}

				quoteBegin1 = "<!--quoteo(";
				quoteBegin2 = "<!--quotec-->";

				while (true) {
					int x = msgBody.indexOf(quoteBegin1);
					int y = msgBody.indexOf(quoteBegin2, x);

					if ((x == -1) || (y == -1)) {
						break;
					}

					String replace = msgBody.substring(x, y + quoteBegin2.length());

					msgBody = StringUtil.replace(msgBody, replace, "[quote]");
				}

				String quoteEnd = "<!--QuoteEnd--></div><!--QuoteEEnd-->";

				msgBody = StringUtil.replace(msgBody, quoteEnd, "[/quote]");

				String urlStart = "http://forums.liferay.com/index.php";

				while (true) {
					int x = msgBody.indexOf(urlStart);

					if (x == -1) {
						break;
					}

					int spacePos = msgBody.indexOf(" ", x);
					int singleQuotePos = msgBody.indexOf("'", x);
					int doubleQuotePos = msgBody.indexOf("\"", x);
					int lessThanPos = msgBody.indexOf("<", x);

					int y = -1;

					if (spacePos != -1) {
						y = spacePos;
					}

					if ((y == -1) || ((singleQuotePos != -1) && (y > singleQuotePos))) {
						y = singleQuotePos;
					}

					if ((y == -1) || ((doubleQuotePos != -1) && (y > doubleQuotePos))) {
						y = doubleQuotePos;
					}

					if ((y == -1) || ((lessThanPos != -1) && (y > lessThanPos))) {
						y = lessThanPos;
					}

					if (y == -1) {
						break;
					}

					String url = msgBody.substring(x, y);

					String entryStart = "&#entry";

					int entryIdPos = url.indexOf(entryStart);

					if (entryIdPos != -1) {
						String messageId = url.substring(entryIdPos + entryStart.length(), url.length());

						url = "http://www.liferay.com/web/guest/devzone/forums/message_boards/message/" + messageId;
					}
					else {
						String topicId = Http.getParameter(url, "showtopic", false);

						if (Validator.isNotNull(topicId)) {
							url = "http://www.liferay.com/web/guest/devzone/forums/message_boards/topic/" + topicId;
						}
						else {
							break;
						}
					}

					msgBody = msgBody.substring(0, x) + url + msgBody.substring(y, msgBody.length());
				}

				msgBody = StringUtil.replace(msgBody, "style_emoticons/<#EMO_DIR#>", "@theme_images_path@/emoticons");

				String emoticonsPath = "@theme_images_path@/emoticons";

				int x = 0;
				x = msgBody.indexOf(emoticonsPath, x);

				while (x != -1) {
					int y = msgBody.indexOf(".gif", x);

					String emotionImage = msgBody.substring(x + emoticonsPath.length() + 1, y) + ".gif";

					x = msgBody.indexOf(emoticonsPath, x + 1);
				}*/

				try {
					msgBody = BBCodeUtil.getHTML(msgBody);
				}
				catch (Exception e) {
					_log.error("Could not parse message " + message.getMessageId() + " " + e.getMessage());
				}

				msgBody = StringUtil.replace(msgBody, "@theme_images_path@/emoticons", themeDisplay.getPathThemeImage() + "/emoticons");
				%>

				<%= msgBody %>

				<c:if test="<%= message.isAttachments() %>">
					<br><br>

					<%
					String[] fileNames = null;

					try {
						fileNames = DLServiceUtil.getFileNames(company.getCompanyId(), CompanyImpl.SYSTEM, message.getAttachmentsDir());
					}
					catch (NoSuchDirectoryException nsde) {
					}
					%>

					<c:if test="<%= fileNames != null %>">

						<%
						for (int j = 0; j < fileNames.length; j++) {
							String fileName = FileUtil.getShortFileName(fileNames[j]);

							if (StringUtil.endsWith(fileName, ".gif") || StringUtil.endsWith(fileName, ".jpg") || StringUtil.endsWith(fileName, ".png")) {
						%>

								<img src="<%= themeDisplay.getPathMain() %>/message_boards/get_message_attachment?messageId=<%= message.getMessageId() %>&attachment=<%= Http.encodeURL(fileName) %>">

								<br><br>

						<%
							}
						}
						%>

						<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">
								<b><%= LanguageUtil.get(pageContext, "attachments") %>:</b>
							</td>
							<td style="padding-left: 10px;"></td>
							<td>

								<%
								for (int j = 0; j < fileNames.length; j++) {
									String fileName = FileUtil.getShortFileName(fileNames[j]);
									long fileSize = DLServiceUtil.getFileSize(company.getCompanyId(), CompanyImpl.SYSTEM, fileNames[j]);
								%>

									<a href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>"><portlet:param name="struts_action" value="/message_boards/get_message_attachment" /><portlet:param name="messageId" value="<%= message.getMessageId() %>" /><portlet:param name="attachment" value="<%= fileName %>" /></portlet:actionURL>"><%= fileName %></a> (<%= TextFormatter.formatKB(fileSize, locale) %>k)&nbsp;&nbsp;&nbsp;

								<%
								}
								%>

							</td>
						</tr>
						</table>
					</c:if>
				</c:if>
			</div>
		</td>
	</tr>

	<c:if test="<%= editable %>">
		<tr>
			<td class="<%= className %>" valign="bottom" width="90%">
				<div class="message-board-thread-bottom" style="padding:3px 5px; text-align:right;">
					<c:if test="<%= MBMessagePermission.contains(permissionChecker, message, ActionKeys.UPDATE) %>">
						<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="editURL">
							<portlet:param name="struts_action" value="/message_boards/edit_message" />
							<portlet:param name="redirect" value="<%= currentURL %>" />
							<portlet:param name="messageId" value="<%= message.getMessageId() %>" />
						</portlet:renderURL>

						<liferay-ui:icon image="edit" url="<%= editURL %>" />
					</c:if>

					<c:if test="<%= MBMessagePermission.contains(permissionChecker, message, ActionKeys.PERMISSIONS) %>">
						<liferay-security:permissionsURL
							modelResource="<%= MBMessage.class.getName() %>"
							modelResourceDescription="<%= message.getSubject() %>"
							resourcePrimKey="<%= message.getPrimaryKey().toString() %>"
							var="permissionsURL"
						/>

						<liferay-ui:icon image="permissions" url="<%= permissionsURL %>" />
					</c:if>

					<c:if test="<%= MBMessagePermission.contains(permissionChecker, message, ActionKeys.DELETE) %>">

						<%
						PortletURL categoryURL = renderResponse.createRenderURL();

						categoryURL.setWindowState(WindowState.MAXIMIZED);

						categoryURL.setParameter("struts_action", "/message_boards/view");
						categoryURL.setParameter("categoryId", message.getCategoryId());
						%>

						<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="deleteURL">
							<portlet:param name="struts_action" value="/message_boards/edit_message" />
							<portlet:param name="<%= Constants.CMD %>" value="<%= Constants.DELETE %>" />
							<portlet:param name="redirect" value="<%= categoryURL.toString() %>" />
							<portlet:param name="messageId" value="<%= message.getMessageId() %>" />
						</portlet:actionURL>

						<liferay-ui:icon-delete url="<%= deleteURL %>" />
					</c:if>
				</div>
			</td>
		</tr>
	</c:if>

	</table>
</div>
