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

<%@ include file="/html/portlet/journal/init.jsp" %>

<%
String redirect = ParamUtil.getString(request, "redirect");

JournalTemplate template = (JournalTemplate)request.getAttribute(WebKeys.JOURNAL_TEMPLATE);

String groupId = BeanParamUtil.getString(template, request, "groupId", portletGroupId);

String templateId = BeanParamUtil.getString(template, request, "templateId");
String newTemplateId = ParamUtil.getString(request, "newTemplateId");

String structureId = BeanParamUtil.getString(template, request, "structureId");

String structureName = StringPool.BLANK;

if (Validator.isNotNull(structureId)) {
	try {
		JournalStructure structure = JournalStructureLocalServiceUtil.getStructure(company.getCompanyId(), groupId, structureId);

		structureName = structure.getName();
	}
	catch (NoSuchStructureException nsse) {
	}
}

String xsl = BeanParamUtil.getString(template, request, "xsl");

String langType = BeanParamUtil.getString(template, request, "langType", JournalTemplateImpl.LANG_TYPE_XSL);

boolean smallImage = BeanParamUtil.getBoolean(template, request, "smallImage");
String smallImageURL = BeanParamUtil.getString(template, request, "smallImageURL");
%>

<script type="text/javascript">
	function <portlet:namespace />removeStructure() {
		document.<portlet:namespace />fm.<portlet:namespace />structureId.value = "";

		var nameEl = document.getElementById("<portlet:namespace />structureName");

		nameEl.href = "#";
		nameEl.innerHTML = "";

		document.getElementById("<portlet:namespace />removeStructureButton").disabled = true;
	}

	function <portlet:namespace />saveTemplate() {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= template == null ? Constants.ADD : Constants.UPDATE %>";

		<c:if test="<%= template == null %>">
			document.<portlet:namespace />fm.<portlet:namespace />templateId.value = document.<portlet:namespace />fm.<portlet:namespace />newTemplateId.value;
		</c:if>

		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />selectStructure(structureId, structureName) {
		document.<portlet:namespace />fm.<portlet:namespace />structureId.value = structureId;

		var nameEl = document.getElementById("<portlet:namespace />structureName");

		nameEl.href = "<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_structure" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="groupId" value="<%= groupId %>" /></portlet:renderURL>&<portlet:namespace />structureId=" + structureId;
		nameEl.innerHTML = structureName + "&nbsp;";

		document.getElementById("<portlet:namespace />removeStructureButton").disabled = false;
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_template" /></portlet:actionURL>" enctype="multipart/form-data" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />saveTemplate(); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= redirect %>">
<input name="<portlet:namespace />groupId" type="hidden" value="<%= groupId %>">
<input name="<portlet:namespace />templateId" type="hidden" value="<%= templateId %>">
<input name="<portlet:namespace />xslContent" type="hidden" value="<%= JS.encodeURIComponent(xsl) %>">

<liferay-ui:tabs names="template" />

<liferay-ui:error exception="<%= DuplicateTemplateIdException.class %>" message="please-enter-a-unique-id" />
<liferay-ui:error exception="<%= TemplateDescriptionException.class %>" message="please-enter-a-valid-description" />
<liferay-ui:error exception="<%= TemplateIdException.class %>" message="please-enter-a-valid-id" />
<liferay-ui:error exception="<%= TemplateNameException.class %>" message="please-enter-a-valid-name" />
<liferay-ui:error exception="<%= TemplateXslException.class %>" message="please-enter-a-valid-script-template" />

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "id") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<c:choose>
					<c:when test="<%= template == null %>">
						<liferay-ui:input-field model="<%= JournalTemplate.class %>" bean="<%= template %>" field="templateId" fieldParam="newTemplateId" defaultValue="<%= newTemplateId %>" />
					</c:when>
					<c:otherwise>
						<%= templateId %>
					</c:otherwise>
				</c:choose>
			</td>
			<td style="padding-left: 30px;"></td>
			<td>
				<c:if test="<%= template == null %>">
					<liferay-ui:input-checkbox param="autoTemplateId" />

					<%= LanguageUtil.get(pageContext, "autogenerate-id") %>
				</c:if>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "name") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= JournalTemplate.class %>" bean="<%= template %>" field="name" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "description") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= JournalTemplate.class %>" bean="<%= template %>" field="description" />
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "structure") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input name="<portlet:namespace />structureId" type="hidden" value="<%= structureId %>">

		<c:choose>
			<c:when test="<%= (template == null) || (Validator.isNotNull(structureId)) %>">
				<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_structure" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="groupId" value="<%= groupId %>" /><portlet:param name="structureId" value="<%= structureId %>" /></portlet:renderURL>" id="<portlet:namespace />structureName">
				<%= structureName %>
				</a>
			</c:when>
			<c:otherwise>
				<a id="<portlet:namespace />structureName"></a>
			</c:otherwise>
		</c:choose>

		<c:if test="<%= (template == null) || (Validator.isNull(template.getStructureId())) %>">
			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "select") %>' onClick="var structureWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/journal/select_structure" /><portlet:param name="groupId" value="<%= groupId %>" /></portlet:renderURL>', 'structure', 'directories=no,height=640,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no,width=680'); void(''); structureWindow.focus();">

			<input <%= Validator.isNull(structureId) ? "disabled" : "" %> class="portlet-form-button" id="<portlet:namespace />removeStructureButton" type="button" value='<%= LanguageUtil.get(pageContext, "remove") %>' onClick="<portlet:namespace />removeStructure();">
		</c:if>
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "script") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />xsl" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="file">

		<input class="portlet-form-button" type="button" value="<bean:message key="launch-editor" />" onClick="var templateXslWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/journal/edit_template_xsl" /></portlet:renderURL>&<portlet:namespace />langType=' + document.<portlet:namespace />fm.<portlet:namespace />langType.value, 'templateXsl', 'directories=no,height=640,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no,width=680'); void(''); templateXslWindow.focus();">

		<c:if test="<%= template != null %>">
			<input class="portlet-form-button" type="button" value="<bean:message key="download" />" onClick="self.location = '<%= themeDisplay.getPathMain() %>/journal/get_template?groupId=<%= template.getGroupId() %>&templateId=<%= template.getTemplateId() %>&transform=0';">
		</c:if>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "language-type") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />langType">

			<%
			for (int i = 0; i < JournalTemplateImpl.LANG_TYPES.length; i++) {
			%>

				<option <%= langType.equals(JournalTemplateImpl.LANG_TYPES[i]) ? "selected" : "" %> value="<%= JournalTemplateImpl.LANG_TYPES[i] %>"><%= JournalTemplateImpl.LANG_TYPES[i].toUpperCase() %></option>

			<%
			}
			%>

		</select>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "format-script") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="formatXsl" />
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "small-image-url") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= JournalTemplate.class %>" bean="<%= template %>" field="smallImageURL" />
	</td>
</tr>
<tr>
	<td>
		<span style="font-size: xx-small;">-- <%= LanguageUtil.get(pageContext, "or").toUpperCase() %> --</span> <%= LanguageUtil.get(pageContext, "small-image") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />smallFile" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="file">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "use-small-image") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= JournalTemplate.class %>" bean="<%= template %>" field="smallImage" />
	</td>
</tr>

<c:if test="<%= template == null %>">
	<tr>
		<td colspan="3">
			<br>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "permissions") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<liferay-ui:input-permissions
				modelName="<%= JournalTemplate.class.getName() %>"
			/>
		</td>
	</tr>
</c:if>

</table>

<br>

<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "save") %>'>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace /><%= (template == null) ? "newTemplateId" : "name" %>.focus();
</script>
