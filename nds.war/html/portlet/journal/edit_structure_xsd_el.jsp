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
Element el = (Element)request.getAttribute(WebKeys.JOURNAL_STRUCTURE_EL);

String elName = el.attributeValue("name", StringPool.BLANK);
String elType = el.attributeValue("type", StringPool.BLANK);

String parentElType = el.getParent().attributeValue("type", StringPool.BLANK);

IntegerWrapper count = (IntegerWrapper)request.getAttribute(WebKeys.JOURNAL_STRUCTURE_EL_COUNT);
Integer depth = (Integer)request.getAttribute(WebKeys.JOURNAL_STRUCTURE_EL_DEPTH);
Boolean hasSiblings = (Boolean)request.getAttribute(WebKeys.JOURNAL_STRUCTURE_EL_SIBLINGS);
IntegerWrapper tabIndex = (IntegerWrapper)request.getAttribute(WebKeys.TAB_INDEX);
%>

<input id="<portlet:namespace />structure_el<%= count.getValue() %>_depth" type="hidden" value="<%= depth %>">

<tr>
	<td><img border="0" height="10" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="1"></td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<c:if test="<%= depth.intValue() > 0 %>">
				<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="<%= depth.intValue() * 50 %>"></td>
			</c:if>

			<td>
				<input class="form-text" id="<portlet:namespace />structure_el<%= count.getValue() %>_name" tabindex="<%= tabIndex.getValue() %>" type="text" size="20" value="<%= elName %>">
			</td>
			<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="10"></td>
			<td>
				<c:choose>
					<c:when test='<%= parentElType.equals("list") || parentElType.equals("multi-list") %>'>
						<input class="form-text" id="<portlet:namespace />structure_el<%= count.getValue() %>_type" tabindex="<%= tabIndex.getValue() %>" type="text" size="20" value="<%= elType %>">
					</c:when>
					<c:otherwise>
						<select id="<portlet:namespace />structure_el<%= count.getValue() %>_type" tabindex="<%= tabIndex.getValue() %>">
							<option value=""></option>
							<option <%= elType.equals("text") ? "selected" : "" %> value="text"><%= LanguageUtil.get(pageContext, "text") %></option>
							<option <%= elType.equals("text_box") ? "selected" : "" %> value="text_box"><%= LanguageUtil.get(pageContext, "text-box") %></option>
							<option <%= elType.equals("text_area") ? "selected" : "" %> value="text_area"><%= LanguageUtil.get(pageContext, "text-area") %></option>
							<option <%= elType.equals("image") ? "selected" : "" %> value="image"><%= LanguageUtil.get(pageContext, "image") %></option>
							<option <%= elType.equals("image_gallery") ? "selected" : "" %> value="image_gallery"><%= PortalUtil.getPortletTitle(PortletKeys.IMAGE_GALLERY, user) %></option>
							<option <%= elType.equals("document_library") ? "selected" : "" %> value="document_library"><%= PortalUtil.getPortletTitle(PortletKeys.DOCUMENT_LIBRARY, user) %></option>
							<option <%= elType.equals("boolean") ? "selected" : "" %> value="boolean"><%= LanguageUtil.get(pageContext, "boolean-flag") %></option>
							<option <%= elType.equals("list") ? "selected" : "" %> value="list"><%= LanguageUtil.get(pageContext, "selection-list") %></option>
							<option <%= elType.equals("multi-list") ? "selected" : "" %> value="multi-list"><%= LanguageUtil.get(pageContext, "multi-selection-list") %></option>
						</select>
					</c:otherwise>
				</c:choose>
			</td>

			<c:if test='<%= !parentElType.equals("list") && !parentElType.equals("multi-list") %>'>
				<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="5"></td>
				<td>
					<a href="javascript: <portlet:namespace />editElement('add', <%= count.getValue() %>);">
					<img border="0" height="9" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_plus.gif" title="<%= LanguageUtil.get(pageContext, "add") %>" vspace="0" width="9">
					</a>
				</td>
			</c:if>

			<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="5"></td>

			<c:choose>
				<c:when test="<%= el.elements().size() == 0 %>">
					<td>
						<a href="javascript: <portlet:namespace />editElement('remove', <%= count.getValue() %>);">
						<img border="0" height="9" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_minus.gif" title="<%= LanguageUtil.get(pageContext, "remove") %>" vspace="0" width="9">
						</a>
					</td>
				</c:when>
				<c:otherwise>
					<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="9"></td>
				</c:otherwise>
			</c:choose>

			<c:if test="<%= hasSiblings.booleanValue() %>">
				<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="10"></td>
				<td>
					<a href="javascript: <portlet:namespace />moveElement(true, <%= count.getValue() %>);">
					<img border="0" height="11" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_up.gif" title="<%= LanguageUtil.get(pageContext, "up") %>" vspace="0" width="11">
					</a>
				</td>
				<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.gif" vspace="0" width="5"></td>
				<td>
					<a href="javascript: <portlet:namespace />moveElement(false, <%= count.getValue() %>);">
					<img border="0" height="11" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_down.gif" title="<%= LanguageUtil.get(pageContext, "down") %>" vspace="0" width="11">
					</a>
				</td>
			</c:if>
		</tr>
		</table>
	</td>
</tr>

<%
tabIndex.setValue(tabIndex.getValue() + 2);
%>
