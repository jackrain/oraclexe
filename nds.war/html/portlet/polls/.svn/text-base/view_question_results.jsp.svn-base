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

<%
NumberFormat numberFormat = NumberFormat.getNumberInstance(locale);
NumberFormat percentFormat = NumberFormat.getPercentInstance(locale);
%>

<table border="0" cellpadding="4" cellspacing="0" width="100%">
<tr>
	<td class="portlet-section-header">
		<table border="0" cellpadding="4" cellspacing="0" width="100%">
		<tr class="portlet-section-header" style="font-size: x-small; font-weight: bold;">
			<td>
				%
			</td>
			<td style="padding-left: 10px;"></td>
			<td colspan="6">
				<%= LanguageUtil.get(pageContext, "votes") %>
			</td>
		</tr>

		<%
		int totalVotes = PollsVoteLocalServiceUtil.getVotesCount(question.getQuestionId());

		for (int i = 0; i < choices.size(); i++) {
			PollsChoice choice = (PollsChoice)choices.get(i);

			int choiceVotes = PollsVoteLocalServiceUtil.getVotesCount(question.getQuestionId(), choice.getChoiceId());

			String className = "portlet-section-body";
			String classHoverName = "portlet-section-body-hover";

			if (MathUtil.isEven(i)) {
				className = "portlet-section-alternate";
				classHoverName = "portlet-section-alternate-hover";
			}

			double votesPercent = 0.0;

			if (totalVotes > 0) {
				votesPercent = (double)choiceVotes / totalVotes;
			}

			int votesPixelWidth = 35;

			if (renderRequest.getWindowState().equals(WindowState.MAXIMIZED)) {
				votesPixelWidth = 100;
			}

			int votesPercentWidth = (int)Math.floor(votesPercent * votesPixelWidth);
		%>

			<tr class="<%= className %>" style="font-size: x-small;" onMouseEnter="this.className = '<%= classHoverName %>';" onMouseLeave="this.className = '<%= className %>';">
				<td>
					<%= percentFormat.format(votesPercent) %>
				</td>
				<td></td>
				<td colspan="<%= votesPercentWidth > 0 ? "1" : "3" %>">
					<%= numberFormat.format(choiceVotes) %>
				</td>

				<c:if test="<%= votesPercentWidth > 0 %>">
					<td></td>
					<td>
						<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td class="alpha"><img border="0" height="5" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="<%= votesPercentWidth %>"></td>
							<td class="beta"><img border="0" height="5" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="<%= votesPixelWidth - votesPercentWidth %>"></td>
						</tr>
						</table>
					</td>
				</c:if>

				<td></td>
				<td>
					<b><%= choice.getChoiceId() %>.</b>
				</td>
				<td width="99%">
					<%= choice.getDescription() %>
				</td>
			</tr>

		<%
		}
		%>

		</table>
	</td>
</tr>
</table>

<br>

<b><%= LanguageUtil.get(pageContext, "total-votes") %>:</b> <%= numberFormat.format(totalVotes) %>

<c:if test="<%= portletName.equals(PortletKeys.POLLS) %>">
	<br><br>

	<b><%= LanguageUtil.get(pageContext, "charts") %>:</b>
	<a href="javascript: var viewChartWindow = window.open('<%= themeDisplay.getPathMain() %>/polls/view_chart?questionId=<%= question.getQuestionId() %>&chartType=area', 'viewChart', 'directories=no,height=430,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no,width=420'); void(''); viewChartWindow.focus();"><%= LanguageUtil.get(pageContext, "area") %></a>,
	<a href="javascript: var viewChartWindow = window.open('<%= themeDisplay.getPathMain() %>/polls/view_chart?questionId=<%= question.getQuestionId() %>&chartType=horizontal_bar', 'viewChart', 'directories=no,height=430,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no,width=420'); void(''); viewChartWindow.focus();"><%= LanguageUtil.get(pageContext, "horizontal-bar") %></a>,
	<a href="javascript: var viewChartWindow = window.open('<%= themeDisplay.getPathMain() %>/polls/view_chart?questionId=<%= question.getQuestionId() %>&chartType=line', 'viewChart', 'directories=no,height=430,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no,width=420'); void(''); viewChartWindow.focus();"><%= LanguageUtil.get(pageContext, "line") %></a>,
	<a href="javascript: var viewChartWindow = window.open('<%= themeDisplay.getPathMain() %>/polls/view_chart?questionId=<%= question.getQuestionId() %>&chartType=pie', 'viewChart', 'directories=no,height=430,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no,width=420'); void(''); viewChartWindow.focus();"><%= LanguageUtil.get(pageContext, "pie") %></a>,
	<a href="javascript: var viewChartWindow = window.open('<%= themeDisplay.getPathMain() %>/polls/view_chart?questionId=<%= question.getQuestionId() %>&chartType=vertical_bar', 'viewChart', 'directories=no,height=430,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no,width=420'); void(''); viewChartWindow.focus();"><%= LanguageUtil.get(pageContext, "vertical-bar") %></a>
</c:if>

<c:if test="<%= question.isExpired() %>">
	<br><br>

	<span style="font-size: xx-small;">
	<%= LanguageUtil.format(pageContext, "voting-is-disabled-because-this-poll-expired-on-x", dateFormatDateTime.format(question.getExpirationDate())) %>.
	</span>
</c:if>
