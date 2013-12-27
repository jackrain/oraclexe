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
InstanceSearch searchContainer = (InstanceSearch)request.getAttribute("liferay-ui:search:searchContainer");

InstanceDisplayTerms displayTerms = (InstanceDisplayTerms)searchContainer.getDisplayTerms();
%>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<%--<td>
		<%= LanguageUtil.get(pageContext, "instance-id") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "definition-id") %>
	</td>
	<td style="padding-left: 5px;"></td>--%>
	<td>
		<%= LanguageUtil.get(pageContext, "definition-name") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "definition-version") %>
	</td>
</tr>
<tr>
	<%--<td>
		<input class="form-text" name="<portlet:namespace /><%= InstanceDisplayTerms.INSTANCE_ID %>" size="20" type="text" value="<%= displayTerms.getInstanceIdString() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= InstanceDisplayTerms.DEFINITION_ID %>" size="20" type="text" value="<%= displayTerms.getDefinitionIdString() %>">
	</td>
	<td style="padding-left: 5px;"></td>--%>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= InstanceDisplayTerms.DEFINITION_NAME %>" size="20" type="text" value="<%= displayTerms.getDefinitionName() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= InstanceDisplayTerms.DEFINITION_VERSION %>" size="20" type="text" value="<%= displayTerms.getDefinitionVersion() %>">
	</td>
</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "start-date") %> (<%= LanguageUtil.get(pageContext, "range") %>)
	</td>
</tr>
<tr>
	<td>
		<liferay-ui:input-field model="<%= WorkflowInstance.class %>" field="<%= InstanceDisplayTerms.START_DATE_GT %>" />

		<%= LanguageUtil.get(pageContext, "to") %>

		<liferay-ui:input-field model="<%= WorkflowInstance.class %>" field="<%= InstanceDisplayTerms.START_DATE_LT %>" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "end-date") %> (<%= LanguageUtil.get(pageContext, "range") %>)
	</td>
</tr>
<tr>
	<td>
		<liferay-ui:input-field model="<%= WorkflowInstance.class %>" field="<%= InstanceDisplayTerms.END_DATE_GT %>" />

		<%= LanguageUtil.get(pageContext, "to") %>

		<liferay-ui:input-field model="<%= WorkflowInstance.class %>" field="<%= InstanceDisplayTerms.END_DATE_LT %>" />

		<input <%= displayTerms.isHideEndedTasks() ? "checked" : "" %> name="<portlet:namespace /><%= InstanceDisplayTerms.HIDE_ENDED_TASKS %>" type="checkbox" onClick="<portlet:namespace />updateEndDates();"> <%= LanguageUtil.get(pageContext, "hide-instances-that-have-already-ended") %>
	</td>
</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<select name="<portlet:namespace /><%= InstanceDisplayTerms.AND_OPERATOR %>">
			<option <%= displayTerms.isAndOperator() ? "selected" : "" %> value="1"><%= LanguageUtil.get(pageContext, "and") %></option>
			<option <%= !displayTerms.isAndOperator() ? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "or") %></option>
		</select>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">
	</td>
</tr>
</table>

<script type="text/javascript">
	<portlet:namespace />updateEndDates();

	function <portlet:namespace />updateEndDates() {
		var form = document.<portlet:namespace />fm;

		var hideEndedTasks = form.<portlet:namespace /><%= InstanceDisplayTerms.HIDE_ENDED_TASKS %>.checked;

		for (var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];

			if (e.name.indexOf("<portlet:namespace />endDate") != -1) {
				e.disabled = hideEndedTasks;
			}
		}

		document.getElementById("<portlet:namespace />endDateGTImageInputId").disabled = hideEndedTasks;
		document.getElementById("<portlet:namespace />endDateLTImageInputId").disabled = hideEndedTasks;
	}
</script>
