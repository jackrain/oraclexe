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

<%@ include file="/html/portlet/workflow/init.jsp" %>

<%
String tabs1 = ParamUtil.getString(request, "tabs1", "definitions");

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/workflow/view");
portletURL.setParameter("tabs1", tabs1);
%>

<form action="<%= portletURL.toString() %>" method="post" name="<portlet:namespace />fm">

<liferay-ui:tabs
	names="definitions,instances,tasks"
	url="<%= portletURL.toString() %>"
/>

<c:choose>
	<c:when test='<%= tabs1.equals("definitions") %>'>

		<%
		DefinitionSearch searchContainer = new DefinitionSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(StringPool.BLANK);
		%>

		<liferay-ui:search-form
			page="/html/portlet/workflow/definition_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">

			<%
			DefinitionSearchTerms searchTerms = (DefinitionSearchTerms)searchContainer.getSearchTerms();

			int total = WorkflowComponentServiceUtil.getDefinitionsCount(searchTerms.getDefinitionId(), searchTerms.getName());

			searchContainer.setTotal(total);

			List results = WorkflowComponentServiceUtil.getDefinitions(searchTerms.getDefinitionId(), searchTerms.getName(), searchContainer.getStart(), searchContainer.getEnd());

			searchContainer.setResults(results);
			%>

			<br><div class="beta-separator"></div><br>

			<c:if test="<%= PortletPermission.contains(permissionChecker, plid, PortletKeys.WORKFLOW, ActionKeys.ADD_DEFINITION) %>">
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/workflow/edit_definition" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>';">

				<br><br>
			</c:if>

			<%
			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				WorkflowDefinition definition = (WorkflowDefinition)results.get(i);

				String definitionId = String.valueOf(definition.getDefinitionId());

				ResultRow row = new ResultRow(definition, definitionId, i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/workflow/edit_definition");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("definitionId", definitionId);

				row.setParameter("rowHREF", rowURL.toString());

				// Definition id

				row.addText(definitionId, rowURL);

				// Definition name

				row.addText(LanguageUtil.get(pageContext, definition.getName()), rowURL);

				// Definition version

				row.addText(String.valueOf(definition.getVersion()), rowURL);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/workflow/definition_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
		</c:if>
	</c:when>
	<c:when test='<%= tabs1.equals("instances") %>'>

		<%
		InstanceSearch searchContainer = new InstanceSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(StringPool.BLANK);
		%>

		<liferay-ui:search-form
			page="/html/portlet/workflow/instance_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">

			<%
			InstanceSearchTerms searchTerms = (InstanceSearchTerms)searchContainer.getSearchTerms();

			int total = WorkflowComponentServiceUtil.getInstancesCount(searchTerms.getDefinitionId(), searchTerms.getInstanceId(), searchTerms.getDefinitionName(), searchTerms.getDefinitionVersion(), searchTerms.getStartDateGT(), searchTerms.getStartDateLT(), searchTerms.getEndDateGT(), searchTerms.getEndDateLT(), searchTerms.isHideEndedTasks(), searchTerms.isAndOperator());

			searchContainer.setTotal(total);

			List results = WorkflowComponentServiceUtil.getInstances(searchTerms.getDefinitionId(), searchTerms.getInstanceId(), searchTerms.getDefinitionName(), searchTerms.getDefinitionVersion(), searchTerms.getStartDateGT(), searchTerms.getStartDateLT(), searchTerms.getEndDateGT(), searchTerms.getEndDateLT(), searchTerms.isHideEndedTasks(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd());

			searchContainer.setResults(results);
			%>

			<br><div class="beta-separator"></div><br>

			<%
			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				WorkflowInstance instance = (WorkflowInstance)results.get(i);

				String instanceId = String.valueOf(instance.getInstanceId());

				WorkflowDefinition definition = instance.getDefinition();
				WorkflowToken token = instance.getToken();

				ResultRow row = new ResultRow(instance, instanceId, i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/workflow/view");
				rowURL.setParameter("tabs1", "definitions");
				rowURL.setParameter("definitionId", String.valueOf(definition.getDefinitionId()));

				row.setParameter("rowHREF", rowURL.toString());

				// Instance id

				row.addText(instanceId, rowURL);

				// Definition name

				row.addText(LanguageUtil.get(pageContext, definition.getName()), rowURL);

				// Definition version

				row.addText(String.valueOf(definition.getVersion()), rowURL);

				// Start date

				row.addText(dateFormatDateTime.format(instance.getStartDate()), rowURL);

				// End date

				if (instance.getEndDate() == null) {
					row.addText(LanguageUtil.get(pageContext, "not-available"), rowURL);
				}
				else {
					row.addText(dateFormatDateTime.format(instance.getEndDate()), rowURL);
				}

				// State

				row.addText(LanguageUtil.get(pageContext, token.getName()), rowURL);

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/workflow/instance_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
		</c:if>
	</c:when>
	<c:when test='<%= tabs1.equals("tasks") %>'>

		<%
		TaskSearch searchContainer = new TaskSearch(renderRequest, portletURL);

		List headerNames = searchContainer.getHeaderNames();

		headerNames.add(StringPool.BLANK);
		%>

		<liferay-ui:search-form
			page="/html/portlet/workflow/task_search.jsp"
			searchContainer="<%= searchContainer %>"
		/>

		<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">

			<%
			TaskSearchTerms searchTerms = (TaskSearchTerms)searchContainer.getSearchTerms();

			int total = WorkflowComponentServiceUtil.getUserTasksCount(searchTerms.getInstanceId(), searchTerms.getTaskName(), searchTerms.getDefinitionName(), searchTerms.getAssignedTo(), searchTerms.getCreateDateGT(), searchTerms.getCreateDateLT(), searchTerms.getStartDateGT(), searchTerms.getStartDateLT(), searchTerms.getEndDateGT(), searchTerms.getEndDateLT(), searchTerms.isHideEndedTasks(), searchTerms.isAndOperator());

			searchContainer.setTotal(total);

			List results = WorkflowComponentServiceUtil.getUserTasks(searchTerms.getInstanceId(), searchTerms.getTaskName(), searchTerms.getDefinitionName(), searchTerms.getAssignedTo(), searchTerms.getCreateDateGT(), searchTerms.getCreateDateLT(), searchTerms.getStartDateGT(), searchTerms.getStartDateLT(), searchTerms.getEndDateGT(), searchTerms.getEndDateLT(), searchTerms.isHideEndedTasks(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd());

			searchContainer.setResults(results);
			%>

			<br><div class="beta-separator"></div><br>

			<%
			List resultRows = searchContainer.getResultRows();

			for (int i = 0; i < results.size(); i++) {
				WorkflowTask task = (WorkflowTask)results.get(i);

				String taskId = String.valueOf(task.getTaskId());

				WorkflowInstance instance = task.getInstance();

				String instanceId = String.valueOf(instance.getInstanceId());

				WorkflowDefinition definition = instance.getDefinition();

				ResultRow row = new ResultRow(task, taskId, i);

				PortletURL rowURL = renderResponse.createRenderURL();

				rowURL.setWindowState(WindowState.MAXIMIZED);

				rowURL.setParameter("struts_action", "/workflow/view");
				rowURL.setParameter("tabs1", "instances");
				rowURL.setParameter("instanceId", instanceId);

				row.setParameter("rowHREF", rowURL.toString());

				// Task id

				row.addText(taskId, rowURL);

				// Task name

				row.addText(LanguageUtil.get(pageContext, task.getName()), rowURL);

				// Instance id

				row.addText(instanceId, rowURL);

				// Definition name

				row.addText(LanguageUtil.get(pageContext, definition.getName()), rowURL);

				// Assigned to

				row.addText(PortalUtil.getUserName(task.getAssignedUserId(), task.getAssignedUserId(), request), rowURL);

				// Create date

				row.addText(dateFormatDateTime.format(task.getCreateDate()), rowURL);

				// Start date

				if (task.getStartDate() == null) {
					row.addText(LanguageUtil.get(pageContext, "not-available"), rowURL);
				}
				else {
					row.addText(dateFormatDateTime.format(task.getStartDate()), rowURL);
				}

				// End date

				if (task.getEndDate() == null) {
					row.addText(LanguageUtil.get(pageContext, "not-available"), rowURL);
				}
				else {
					row.addText(dateFormatDateTime.format(task.getEndDate()), rowURL);
				}

				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/workflow/task_action.jsp");

				// Add result row

				resultRows.add(row);
			}
			%>

			<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

			<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
		</c:if>
	</c:when>
</c:choose>

</form>
