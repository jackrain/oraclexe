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

<tr>
	<td id="<%= namespace %>messageScroll<%= message.getMessageId() %>">
		<c:if test="<%= i > 0 %>">
			<br>
		</c:if>

		<input name="<%= namespace %>messageId<%= i %>" type="hidden" value="<%= message.getMessageId() %>">
		<input name="<%= namespace %>parentMessageId<%= i %>" type="hidden" value="<%= message.getMessageId() %>">
	</td>
</tr>
<tr id="<%= namespace %>postReplyForm<%= i %>" style="display: none;">
	<td>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "subject") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input class="form-text" name="<%= namespace %>postReplySubject<%= i %>" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text"><br>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "body") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<textarea class="form-text" name="<%= namespace %>postReplyBody<%= i %>" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;" wrap="soft"></textarea>
			</td>
		</tr>
		</table>

		<br>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "reply") %>' onClick="<%= namespace %>postReply(<%= i %>);">

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="document.getElementById('<%= namespace %>postReplyForm<%= i %>').style.display = 'none'; void('');">

		<br><br>
	</td>
</tr>

<c:if test="<%= MBDiscussionPermission.contains(permissionChecker, portletGroupId, className, classPK, ActionKeys.UPDATE_DISCUSSION) %>">
	<tr id="<%= namespace %>editForm<%= i %>" style="display: none;">
		<td>
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "subject") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<input class="form-text" name="<%= namespace %>editSubject<%= i %>" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= Html.toInputSafe(message.getSubject()) %>"><br>
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "body") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<textarea class="form-text" name="<%= namespace %>editBody<%= i %>" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;" wrap="soft"><%= Html.toInputSafe(message.getBody()) %></textarea>
				</td>
			</tr>
			</table>

			<br>

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "update") %>' onClick="<%= namespace %>updateMessage(<%= i %>);">

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="document.getElementById('<%= namespace %>editForm<%= i %>').style.display = 'none'; void('');">

			<br><br>
		</td>
	</tr>
</c:if>

<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>

				<%
				postReplyHREF = "javascript: document.getElementById('" + namespace + "postReplyForm" + i + "').style.display = ''; void('');";
				%>

				<liferay-ui:icon image="reply" message="post-reply" url="<%= postReplyHREF %>" />

				<a href="<%= postReplyHREF %>"><%= LanguageUtil.get(pageContext, "post-reply") %></a>
			</td>

			<c:if test="<%= i > 0 %>">

				<%
				topHREF = "javascript: " + namespace + "scrollIntoView('0');";
				%>

				<td style="padding-left: 15px;"></td>
				<td>
					<liferay-ui:icon image="top" url="<%= topHREF %>" />

					<a href="<%= topHREF %>"><%= LanguageUtil.get(pageContext, "top") %></a>
				</td>

				<c:if test="<%= MBDiscussionPermission.contains(permissionChecker, portletGroupId, className, classPK, ActionKeys.UPDATE_DISCUSSION) %>">

					<%
					editHREF = "javascript: document.getElementById('" + namespace + "editForm" + i + "').style.display = ''; void('');";
					%>

					<td style="padding-left: 15px;"></td>
					<td>
						<liferay-ui:icon image="edit" url="<%= editHREF %>" />

						<a href="<%= editHREF %>"><%= LanguageUtil.get(pageContext, "edit") %></a>
					</td>
				</c:if>

				<c:if test="<%= MBDiscussionPermission.contains(permissionChecker, portletGroupId, className, classPK, ActionKeys.DELETE_DISCUSSION) %>">

					<%
					deleteHREF = "javascript: " + namespace + "deleteMessage(" + i + ");";
					%>

					<td style="padding-left: 15px;"></td>
					<td>
						<liferay-ui:icon-delete url="<%= deleteHREF %>" />

						<a href="<%= deleteHREF %>"><%= LanguageUtil.get(pageContext, "delete") %></a>
					</td>
				</c:if>
			</c:if>
		</tr>
		</table>
	</td>
</tr>

