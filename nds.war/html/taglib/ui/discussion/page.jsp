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

<%@ page import="com.liferay.portlet.messageboards.model.MBCategory" %>
<%@ page import="com.liferay.portlet.messageboards.model.MBDiscussion" %>
<%@ page import="com.liferay.portlet.messageboards.model.MBMessage" %>
<%@ page import="com.liferay.portlet.messageboards.model.MBMessageDisplay" %>
<%@ page import="com.liferay.portlet.messageboards.model.MBThread" %>
<%@ page import="com.liferay.portlet.messageboards.model.MBTreeWalker" %>
<%@ page import="com.liferay.portlet.messageboards.service.MBMessageLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.messageboards.service.permission.MBDiscussionPermission" %>
<%@ page import="com.liferay.portlet.messageboards.util.comparator.MessageCreateDateComparator" %>

<%
String formName = namespace + request.getAttribute("liferay-ui:discussion:formName");
String formAction = (String)request.getAttribute("liferay-ui:discussion:formAction");
String className = (String)request.getAttribute("liferay-ui:discussion:className");
String classPK = (String)request.getAttribute("liferay-ui:discussion:classPK");
String userId = (String)request.getAttribute("liferay-ui:discussion:userId");
String subject = (String)request.getAttribute("liferay-ui:discussion:subject");
String redirect = (String)request.getAttribute("liferay-ui:discussion:redirect");

MBMessageDisplay messageDisplay = MBMessageLocalServiceUtil.getDiscussionMessageDisplay(userId, className, classPK);

MBCategory category = messageDisplay.getCategory();
MBThread thread = messageDisplay.getThread();
MBTreeWalker treeWalker = messageDisplay.getTreeWalker();
MBMessage rootMessage = treeWalker.getRoot();

DateFormat dateFormatDateTime = DateFormats.getDateTime(locale, timeZone);
%>

<script type="text/javascript">
	function <%= namespace %>deleteMessage(i) {
		eval("var messageId = document.<%= formName %>.<%= namespace %>messageId" + i + ".value;");

		document.<%= formName %>.<%= namespace %><%= Constants.CMD %>.value = "<%= Constants.DELETE %>";
		document.<%= formName %>.<%= namespace %>messageId.value = messageId;
		submitForm(document.<%= formName %>);
	}

	function <%= namespace %>postReply(i) {
		eval("var parentMessageId = document.<%= formName %>.<%= namespace %>parentMessageId" + i + ".value;");
		eval("var subject = document.<%= formName %>.<%= namespace %>postReplySubject" + i + ".value;");
		eval("var body = document.<%= formName %>.<%= namespace %>postReplyBody" + i + ".value;");

		document.<%= formName %>.<%= namespace %><%= Constants.CMD %>.value = "<%= Constants.ADD %>";
		document.<%= formName %>.<%= namespace %>parentMessageId.value = parentMessageId;
		document.<%= formName %>.<%= namespace %>subject.value = subject;
		document.<%= formName %>.<%= namespace %>body.value = body;
		submitForm(document.<%= formName %>);
	}

	function <%= namespace %>scrollIntoView(messageId) {
		document.getElementById("<%= namespace %>messageScroll" + messageId).scrollIntoView();
	}

	function <%= namespace %>updateMessage(i) {
		eval("var messageId = document.<%= formName %>.<%= namespace %>messageId" + i + ".value;");
		eval("var subject = document.<%= formName %>.<%= namespace %>editSubject" + i + ".value;");
		eval("var body = document.<%= formName %>.<%= namespace %>editBody" + i + ".value;");

		document.<%= formName %>.<%= namespace %><%= Constants.CMD %>.value = "<%= Constants.UPDATE %>";
		document.<%= formName %>.<%= namespace %>messageId.value = messageId;
		document.<%= formName %>.<%= namespace %>subject.value = subject;
		document.<%= formName %>.<%= namespace %>body.value = body;
		submitForm(document.<%= formName %>);
	}
</script>

<form action="<%= formAction %>" method="post" name="<%= formName %>">
<input name="<%= namespace %><%= Constants.CMD %>" type="hidden" value="">
<input name="<%= namespace %>redirect" type="hidden" value="<%= redirect %>">
<input name="<%= namespace %>className" type="hidden" value="<%= className %>">
<input name="<%= namespace %>classPK" type="hidden" value="<%= classPK %>">
<input name="<%= namespace %>messageId" type="hidden" value="">
<input name="<%= namespace %>threadId" type="hidden" value="<%= thread.getThreadId() %>">
<input name="<%= namespace %>parentMessageId" type="hidden" value="">
<input name="<%= namespace %>subject" type="hidden" value="">
<input name="<%= namespace %>body" type="hidden" value="">

<table border="0" cellpadding="0" cellspacing="0" id="<%= namespace %>messageScroll0" width="100%">

<%
int i = 0;

MBMessage message = rootMessage;

String postReplyHREF = null;
String topHREF = null;
String editHREF = null;
String deleteHREF = null;
%>

<%@ include file="/html/taglib/ui/discussion/post_reply_form.jsp" %>

</table>

<%
List messages = treeWalker.getMessages();
%>

<c:if test="<%= messages.size() > 1 %>">
	<br>

	<table border="0" cellpadding="4" cellspacing="0" width="100%">
	<tr class="portlet-section-header" style="font-size: x-small; font-weight: bold;">
		<td>
			<%= LanguageUtil.get(pageContext, "threaded-replies") %>
		</td>
		<td></td>
		<td>
			<%= LanguageUtil.get(pageContext, "author") %>
		</td>
		<td></td>
		<td>
			<%= LanguageUtil.get(pageContext, "date") %>
		</td>
	</tr>

	<%
	int[] range = treeWalker.getChildrenRange(rootMessage);

	for (i = range[0]; i < range[1]; i++) {
		message = (MBMessage)messages.get(i);

		boolean lastChildNode = false;

		if ((i + 1) == range[1]) {
			lastChildNode = true;
		}

		request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER, treeWalker);
		request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_SEL_MESSAGE, rootMessage);
		request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_CUR_MESSAGE, message);
		request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_CATEGORY, category);
		request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_LAST_NODE, new Boolean(lastChildNode));
		request.setAttribute(WebKeys.MESSAGE_BOARDS_TREE_WALKER_DEPTH, new Integer(0));
	%>

		<liferay-util:include page="/html/taglib/ui/discussion/view_message_thread.jsp" />

	<%
	}
	%>

	</table>

	<br>

	<table border="0" cellpadding="0" cellspacing="0" width="100%">

	<%
	Collections.sort(messages, new MessageCreateDateComparator(true));

	for (i = 1; i < messages.size(); i++) {
		message = (MBMessage)messages.get(i);
	%>

		<tr>
			<td>
				<b><%= message.getSubject() %></b><br>

				<span style="font-size: xx-small;">
				<%= LanguageUtil.get(pageContext, "by") %> <%= PortalUtil.getUserName(message.getUserId(), message.getUserName(), request) %>, <%= LanguageUtil.get(pageContext, "on") %> <%= dateFormatDateTime.format(message.getModifiedDate()) %>
				</span>

				<br><br>

				<%= StringUtil.replace(message.getBody(), "\n", "<br>") %>
			</td>
		</tr>

		<%@ include file="/html/taglib/ui/discussion/post_reply_form.jsp" %>

		<c:if test="<%= i + 1 < messages.size() %>">
			<tr>
				<td>
					<br><div class="beta-separator"></div><br>
				</td>
			</tr>
		</c:if>

	<%
	}
	%>

	</table>
</c:if>

</form>

