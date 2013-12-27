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
String redirect = ParamUtil.getString(request, "redirect");

WorkflowDefinition definition = (WorkflowDefinition)request.getAttribute(WebKeys.WORKFLOW_DEFINITION);

long definitionId = BeanParamUtil.getLong(definition, request, "definitionId");
%>

<script type="text/javascript">
	function <portlet:namespace />saveDefinition() {
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/workflow/edit_definition" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />saveDefinition(); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.ADD %>">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= redirect %>">
<input name="<portlet:namespace />definitionId" type="hidden" value="<%= definitionId %>">

<liferay-ui:tabs names="definition" />

<liferay-ui:error exception="<%= DefinitionXmlException.class %>" message="an-error-occurred-while-parsing-your-xml-please-check-the-syntax-of-your-xml" />

<c:if test="<%= definition != null %>">
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "name") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= definition.getName() %>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "version") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= definition.getVersion() %>
		</td>
	</tr>
	</table>

	<br>
</c:if>

<%= LanguageUtil.get(pageContext, "enter-the-workflow-definition-below-in-xml-format") %>

<br><br>

<liferay-ui:input-field model="<%= WorkflowDefinition.class %>" bean="<%= definition %>" field="xml" /><br>

<c:if test="<%= definition == null %>">
	<br>

	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "permissions") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<liferay-ui:input-permissions
				modelName="<%= WorkflowDefinition.class.getName() %>"
			/>
		</td>
	</tr>
	</table>
</c:if>

<br>

<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "save-new-version") %>'>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />xml.focus();
</script>
