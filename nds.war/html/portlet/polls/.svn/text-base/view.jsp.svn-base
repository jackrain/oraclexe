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

<%@ include file="/html/portlet/polls/init.jsp" %>

<form method="post" name="<portlet:namespace />fm">

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/polls/view");

List headerNames = new ArrayList();

headerNames.add("question");
headerNames.add("num-of-votes");
headerNames.add("last-vote-date");
headerNames.add("expiration-date");
headerNames.add(StringPool.BLANK);

SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

int total = PollsQuestionLocalServiceUtil.getQuestionsCount(portletGroupId);

searchContainer.setTotal(total);

List results = PollsQuestionLocalServiceUtil.getQuestions(portletGroupId, searchContainer.getStart(), searchContainer.getEnd());

searchContainer.setResults(results);

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
	PollsQuestion question = (PollsQuestion)results.get(i);

	ResultRow row = new ResultRow(question, question.getPrimaryKey().toString(), i);

	PortletURL rowURL = renderResponse.createRenderURL();

	rowURL.setWindowState(WindowState.MAXIMIZED);

	rowURL.setParameter("struts_action", "/polls/view_question");
	rowURL.setParameter("redirect", currentURL);
	rowURL.setParameter("questionId", question.getQuestionId());

	// Title

	row.addText(question.getTitle(), rowURL);

	// Number of votes

	int votesCount = PollsVoteLocalServiceUtil.getVotesCount(question.getQuestionId());

	row.addText(Integer.toString(votesCount), rowURL);

	// Last vote date

	if (question.getLastVoteDate() == null) {
		row.addText(LanguageUtil.get(pageContext, "never"), rowURL);
	}
	else {
		row.addText(dateFormatDateTime.format(question.getLastVoteDate()), rowURL);
	}

	// Expiration date

	if (question.getExpirationDate() == null) {
		row.addText(LanguageUtil.get(pageContext, "never"), rowURL);
	}
	else {
		row.addText(dateFormatDateTime.format(question.getExpirationDate()), rowURL);
	}

	// Action

	row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/polls/question_action.jsp");

	// Add result row

	resultRows.add(row);
}
%>

<c:if test="<%= PortletPermission.contains(permissionChecker, plid, PortletKeys.POLLS, ActionKeys.ADD_QUESTION) %>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-question") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/polls/edit_question" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>';"><br>

	<c:if test="<%= results.size() > 0 %>">
		<br>
	</c:if>
</c:if>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

</form>
