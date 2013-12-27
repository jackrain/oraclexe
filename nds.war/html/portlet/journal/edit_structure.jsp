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

JournalStructure structure = (JournalStructure)request.getAttribute(WebKeys.JOURNAL_STRUCTURE);

String groupId = BeanParamUtil.getString(structure, request, "groupId", portletGroupId);

String structureId = BeanParamUtil.getString(structure, request, "structureId");
String newStructureId = ParamUtil.getString(request, "newStructureId");

String xsd = request.getParameter("xsd");

if ((xsd == null) || (xsd.equals(StringPool.NULL))) {
	xsd = "<root></root>";

	if (structure != null) {
		xsd = structure.getXsd();
	}
}

// Bug with dom4j requires you to remove "\r\n" and "  " or else root.elements()
// and root.content() will return different number of objects

xsd = StringUtil.replace(xsd, "\r\n", "");
xsd = StringUtil.replace(xsd, "  ", "");

int tabIndex = 1;
%>

<script type="text/javascript">
	var xmlIndent = "  ";

	function <portlet:namespace />getXsd(cmd, elCount) {
		if (cmd == null) {
			cmd = "add";
		}

		var xsd = "<root>\n";

		if ((cmd == "add") && (elCount == -1)) {
			xsd += "<dynamic-element name='' type=''></dynamic-element>\n"
		}

		for (i = 0; i >= 0; i++) {
			var elDepth = document.getElementById("<portlet:namespace />structure_el" + i + "_depth");
			var elName = document.getElementById("<portlet:namespace />structure_el" + i + "_name");
			var elType = document.getElementById("<portlet:namespace />structure_el" + i + "_type");

			if ((elDepth != null) && (elName != null) && (elType != null)) {
				var elDepthValue = elDepth.value;
				var elNameValue = elName.value;
				var elTypeValue = elType.value;

				if ((cmd == "add") || ((cmd == "remove") && (elCount != i))) {
					for (var j = 0; j <= elDepthValue; j++) {
						xsd += xmlIndent;
					}

					xsd += "<dynamic-element name='" + elNameValue + "' type='" + elTypeValue + "'>";

					if ((cmd == "add") && (elCount == i)) {
						xsd += "<dynamic-element name='' type=''></dynamic-element>\n";
					}

					var nextElDepth = document.getElementById("<portlet:namespace />structure_el" + (i + 1) + "_depth");

					if (nextElDepth != null) {
						nextElDepthValue = nextElDepth.value;

						if (elDepthValue == nextElDepthValue) {
							for (var j = 0; j < elDepthValue; j++) {
								xsd += xmlIndent;
							}

							xsd += "</dynamic-element>\n";
						}
						else if (elDepthValue > nextElDepthValue) {
							var depthDiff = elDepthValue - nextElDepthValue;

							for (var j = 0; j <= depthDiff; j++) {
								if (j != 0) {
									for (var k = 0; k <= depthDiff - j; k++) {
										xsd += xmlIndent;
									}
								}

								xsd += "</dynamic-element>\n";
							}
						}
						else {
							xsd += "\n";
						}
					}
					else {
						for (var j = 0; j <= elDepthValue; j++) {
							if (j != 0) {
								for (var k = 0; k <= elDepthValue - j; k++) {
									xsd += xmlIndent;
								}
							}

							xsd += "</dynamic-element>\n";
						}
					}
				}
				else if ((cmd == "remove") && (elCount == i)) {
					var nextElDepth = document.getElementById("<portlet:namespace />structure_el" + (i + 1) + "_depth");

					if (nextElDepth != null) {
						nextElDepthValue = nextElDepth.value;

						if (elDepthValue > nextElDepthValue) {
							var depthDiff = elDepthValue - nextElDepthValue;

							for (var j = 0; j < depthDiff; j++) {
								xsd += "</dynamic-element>\n";
							}
						}
					}
					else {
						for (var j = 0; j < elDepthValue; j++) {
							xsd += "</dynamic-element>\n";
						}
					}
				}
			}
			else {
				break;
			}
		}

		xsd += "</root>";

		return xsd;
	}

	function <portlet:namespace />editElement(cmd, elCount) {
		document.<portlet:namespace />fm.scroll.value = "<portlet:namespace />xsd";
		document.<portlet:namespace />fm.<portlet:namespace />xsd.value = <portlet:namespace />getXsd(cmd, elCount);
		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />moveElement(moveUp, elCount) {
		document.<portlet:namespace />fm.scroll.value = "<portlet:namespace />xsd";
		document.<portlet:namespace />fm.<portlet:namespace />move_up.value = moveUp;
		document.<portlet:namespace />fm.<portlet:namespace />move_depth.value = elCount;
		document.<portlet:namespace />fm.<portlet:namespace />xsd.value = <portlet:namespace />getXsd();
		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />saveStructure(addAnother) {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= structure == null ? Constants.ADD : Constants.UPDATE %>";

		<c:if test="<%= structure == null %>">
			document.<portlet:namespace />fm.<portlet:namespace />structureId.value = document.<portlet:namespace />fm.<portlet:namespace />newStructureId.value;
		</c:if>

		document.<portlet:namespace />fm.<portlet:namespace />xsd.value = <portlet:namespace />getXsd();
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_structure" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />saveStructure(); return false;">
<input name="scroll" type="hidden" value="">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= redirect %>">
<input name="<portlet:namespace />groupId" type="hidden" value="<%= groupId %>">
<input name="<portlet:namespace />structureId" type="hidden" value="<%= structureId %>">
<input name="<portlet:namespace />move_up" type="hidden" value="">
<input name="<portlet:namespace />move_depth" type="hidden" value="">

<liferay-ui:tabs names="structure" />

<liferay-ui:error exception="<%= DuplicateStructureIdException.class %>" message="please-enter-a-unique-id" />
<liferay-ui:error exception="<%= StructureDescriptionException.class %>" message="please-enter-a-valid-description" />
<liferay-ui:error exception="<%= StructureIdException.class %>" message="please-enter-a-valid-id" />
<liferay-ui:error exception="<%= StructureNameException.class %>" message="please-enter-a-valid-name" />

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
					<c:when test="<%= structure == null %>">
						<liferay-ui:input-field model="<%= JournalStructure.class %>" bean="<%= structure %>" field="structureId" fieldParam="newStructureId" defaultValue="<%= newStructureId %>" />
					</c:when>
					<c:otherwise>
						<%= structureId %>
					</c:otherwise>
				</c:choose>
			</td>
			<td style="padding-left: 30px;"></td>
			<td>
				<c:if test="<%= structure == null %>">
					<liferay-ui:input-checkbox param="autoStructureId" />

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
		<liferay-ui:input-field model="<%= JournalStructure.class %>" bean="<%= structure %>" field="name" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "description") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= JournalStructure.class %>" bean="<%= structure %>" field="description" />
	</td>
</tr>

<c:if test="<%= structure == null %>">
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
				modelName="<%= JournalStructure.class.getName() %>"
			/>
		</td>
	</tr>
</c:if>

</table>

<br>

<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "save") %>'>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">

<br><br>

<liferay-ui:tabs names="xsd" />

<liferay-ui:error exception="<%= StructureXsdException.class %>" message="please-enter-a-valid-xsd" />

<input name="<portlet:namespace />xsd" type="hidden" value="">

<input class="portlet-form-button" type="button" value="<bean:message key="add-row" />" onClick="<portlet:namespace />editElement('add', -1);">

<input class="portlet-form-button" type="button" value="<bean:message key="launch-editor" />" onClick="var structureXsdWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/journal/edit_structure_xsd" /></portlet:renderURL>', 'structureXsd', 'directories=no,height=640,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no,width=680'); void(''); structureXsdWindow.focus();">

<c:if test="<%= structure != null %>">
	<input class="portlet-form-button" type="button" value="<bean:message key="download" />" onClick="self.location = '<%= themeDisplay.getPathMain() %>/journal/get_structure?groupId=<%= structure.getGroupId() %>&structureId=<%= structure.getStructureId() %>';">
</c:if>

<br>

<table border="0" cellpadding="0" cellspacing="0">

<%
SAXReader reader = new SAXReader();

Document doc = reader.read(new StringReader(xsd));

Element root = doc.getRootElement();

String moveUpParam = request.getParameter("move_up");
String moveDepthParam = request.getParameter("move_depth");

if (Validator.isNotNull(moveUpParam) && Validator.isNotNull(moveDepthParam)) {
	_move(root, new IntegerWrapper(0), GetterUtil.getBoolean(moveUpParam), GetterUtil.getInteger(moveDepthParam), new BooleanWrapper(false));
}

IntegerWrapper tabIndexWrapper = new IntegerWrapper(tabIndex);

_format(root, new IntegerWrapper(0), new Integer(-1), tabIndexWrapper, pageContext, request);

tabIndex = tabIndexWrapper.getValue();
%>

</table>

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace /><%= (structure == null) ? "newStructureId" : "name" %>.focus();
</script>

<%!
private void _format(Element root, IntegerWrapper count, Integer depth, IntegerWrapper tabIndex, PageContext pageContext, HttpServletRequest req) throws Exception {
	depth = new Integer(depth.intValue() + 1);

	List children = root.elements();

	Boolean hasSiblings = null;

	if (children.size() > 1) {
		hasSiblings = Boolean.TRUE;
	}
	else {
		hasSiblings = Boolean.FALSE;
	}

	Iterator itr = children.iterator();

	while (itr.hasNext()) {
		Element el = (Element)itr.next();

		req.setAttribute(WebKeys.JOURNAL_STRUCTURE_EL, el);
		req.setAttribute(WebKeys.JOURNAL_STRUCTURE_EL_COUNT, count);
		req.setAttribute(WebKeys.JOURNAL_STRUCTURE_EL_DEPTH, depth);
		req.setAttribute(WebKeys.JOURNAL_STRUCTURE_EL_SIBLINGS, hasSiblings);
		req.setAttribute(WebKeys.TAB_INDEX, tabIndex);

		pageContext.include("/html/portlet/journal/edit_structure_xsd_el.jsp");

		count.increment();

		_format(el, count, depth, tabIndex, pageContext, req);
	}
}

private void _move(Element root, IntegerWrapper count, boolean up, int depth, BooleanWrapper halt) throws Exception {
	List children = root.elements();

	for (int i = 0; i < children.size(); i++) {
		Element el = (Element)children.get(i);

		if (halt.getValue()) {
			return;
		}

		if (count.getValue() == depth) {
			if (up) {
				if (i == 0) {
					children.remove(i);
					children.add(children.size(), el);
				}
				else {
					children.remove(i);
					children.add(i - 1, el);
				}
			}
			else {
				if ((i + 1) == children.size()) {
					children.remove(i);
					children.add(0, el);
				}
				else {
					children.remove(i);
					children.add(i + 1, el);
				}
			}

			halt.setValue(true);

			return;
		}

		count.increment();

		_move(el, count, up, depth, halt);
	}
}
%>
