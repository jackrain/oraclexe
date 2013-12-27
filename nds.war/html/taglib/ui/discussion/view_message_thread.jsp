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

<%@ include file="/html/portlet/message_boards/init.jsp" %>

<%
MBTreeWalker treeWalker = (MBTreeWalker)request.getAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER);
MBMessage selMessage = (MBMessage)request.getAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_SEL_MESSAGE);
MBMessage message = (MBMessage)request.getAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_CUR_MESSAGE);
MBCategory category = (MBCategory)request.getAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_CATEGORY);
boolean lastNode = ((Boolean)request.getAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_LAST_NODE)).booleanValue();
int depth = ((Integer)request.getAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_DEPTH)).intValue();

String className = "portlet-section-body";
String classHoverName = "portlet-section-body-hover";

if (treeWalker.isOdd()) {
	className = "portlet-section-alternate";
	classHoverName = "portlet-section-alternate-hover";
}
%>

<tr class="<%= className %>" style="font-size: x-small;" onMouseEnter="this.className = '<%= classHoverName %>';" onMouseLeave="this.className = '<%= className %>';">
	<td width="90%">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td style="padding-left: <%= depth * 10 %>px;"></td>
			<td>
				<c:if test="<%= !message.isRoot() %>">
					<c:choose>
						<c:when test="<%= !lastNode %>">
							<img src="<%= themeDisplay.getPathThemeImage() %>/message_boards/t.gif">
						</c:when>
						<c:otherwise>
							<img src="<%= themeDisplay.getPathThemeImage() %>/message_boards/l.gif">
						</c:otherwise>
					</c:choose>
				</c:if>
			</td>
			<td style="padding-left: 5px;"></td>
			<td>

				<%
				String rowHREF = "javascript: " + renderResponse.getNamespace() + "scrollIntoView(" + message.getMessageId() + ");";
				%>

				<a href="<%= rowHREF %>">

				<%
				boolean readFlag = false;

				if (themeDisplay.isSignedIn()) {
					readFlag = MBMessageFlagLocalServiceUtil.hasReadFlag(message.getMessageId(), request.getRemoteUser());
				}
				%>

				<c:if test="<%= !readFlag %>">
					<b>
				</c:if>

				<%= message.getSubject() %>

				<c:if test="<%= !readFlag %>">
					</b>
				</c:if>

				</a>
			</td>
		</tr>
		</table>
	</td>
	<td></td>
	<td nowrap>
		<a href="<%= rowHREF %>">

		<c:choose>
			<c:when test="<%= message.isAnonymous() %>">
				<%= LanguageUtil.get(pageContext, "anonymous") %>
			</c:when>
			<c:otherwise>
				<%= PortalUtil.getUserName(message.getUserId(), message.getUserName()) %>
			</c:otherwise>
		</c:choose>

		</a>
	</td>
	<td></td>
	<td nowrap>
		<a href="<%= rowHREF %>">
		<%= dateFormatDateTime.format(message.getModifiedDate()) %>
		</a>
	</td>
</tr>

<%
List messages = treeWalker.getMessages();
int[] range = treeWalker.getChildrenRange(message);

depth++;

for (int i = range[0]; i < range[1]; i++) {
	MBMessage curMessage = (MBMessage)messages.get(i);

	boolean lastChildNode = false;

	if ((i + 1) == range[1]) {
		lastChildNode = true;
	}

	request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER, treeWalker);
	request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_SEL_MESSAGE, selMessage);
	request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_CUR_MESSAGE, curMessage);
	request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_CATEGORY, category);
	request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_LAST_NODE, new Boolean(lastChildNode));
	request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_DEPTH, new Integer(depth));
%>

	<liferay-util:include page="/html/taglib/ui/discussion/view_message_thread.jsp" />

<%
}
%>
