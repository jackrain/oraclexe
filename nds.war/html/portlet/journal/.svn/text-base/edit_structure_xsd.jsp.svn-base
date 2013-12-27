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
String editorType = ParamUtil.getString(request, "editorType");

if (Validator.isNotNull(editorType)) {
	prefs.setValue(PortletKeys.JOURNAL, "editor-type", editorType);
}
else {
	editorType = prefs.getValue(PortletKeys.JOURNAL, "editor-type", "html");
}

boolean useEditorApplet = editorType.equals("applet");
%>

<script type="text/javascript">
	window.onresize = function () {
		var textArea = document.getElementById("<portlet:namespace />xsdContent");
		var structBody = document.getElementsByTagName("body")[0];

		textArea.style.height = (structBody.clientHeight - 100) + "px";
	}

	function getEditorContent() {
		return opener.<portlet:namespace />getXsd();
	}

	function <portlet:namespace />updateEditorType() {

		<%
		String newEditorType = "applet";

		if (useEditorApplet) {
			newEditorType = "html";
		}
		%>

		self.location = "<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/journal/edit_structure_xsd" /><portlet:param name="editorType" value="<%= newEditorType %>" /></portlet:renderURL>";
	}

	function <portlet:namespace />updateStructureXsd() {
		opener.document.<portlet:namespace />fm.scroll.value = "<portlet:namespace />xsd";

		<c:choose>
			<c:when test="<%= useEditorApplet %>">
				opener.document.<portlet:namespace />fm.<portlet:namespace />xsd.value = document.applets["<portlet:namespace />editor"].getText();
			</c:when>
			<c:otherwise>
				opener.document.<portlet:namespace />fm.<portlet:namespace />xsd.value = document.<portlet:namespace />fm.<portlet:namespace />xsdContent.value;
			</c:otherwise>
		</c:choose>

		submitForm(opener.document.<portlet:namespace />fm);

		self.close();
	}
</script>

<form method="post" name="<portlet:namespace />fm">

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<b><%= LanguageUtil.get(pageContext, "editor-type") %></b>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />editorType" onChange="<portlet:namespace />updateEditorType();">
			<option value="1"><%= LanguageUtil.get(pageContext, "html") %></option>
			<option <%= useEditorApplet ? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "applet") %></option>
		</select>
	</td>
</tr>
</table>

<br>

<c:choose>
	<c:when test="<%= useEditorApplet %>">
		<applet archive="editor.jar" code="com.liferay.applets.editor.Editor" codebase="<%= themeDisplay.getPathApplet() %>" height="530" name="<portlet:namespace />editor" width="670" mayscript>
		</applet>
	</c:when>
	<c:otherwise>
		<textarea class="form-text" id="<portlet:namespace />xsdContent" name="<portlet:namespace />xsdContent" style="font-family: 'Courier New', courier, monospace; font-size: 12; width: 100%; height: 540px" wrap="off" onKeyDown="checkTab(this); disableEsc();"></textarea>
	</c:otherwise>
</c:choose>

<br><br>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "update") %>' onClick="<portlet:namespace />updateStructureXsd();">

<c:if test="<%= !useEditorApplet %>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "select-and-copy") %>' onClick="selectAndCopy(document.<portlet:namespace />fm.<portlet:namespace />xsdContent);">
</c:if>

<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "cancel") %>" onClick="self.close();">

</form>

<c:if test="<%= !useEditorApplet %>">
	<script type="text/javascript">
		document.<portlet:namespace />fm.<portlet:namespace />xsdContent.value = getEditorContent();
	</script>
</c:if>
