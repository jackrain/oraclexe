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

<%@ include file="/html/portlet/portlet_configuration/init.jsp" %>

<%
String propertyPrefix = ParamUtil.getString(request, "propertyPrefix");
String previewObject = ParamUtil.getString(request, "previewObject");
%>

<fieldset>
	<legend><b><%= LanguageUtil.get(pageContext, propertyPrefix + "-text") %></b></legend>

	<table border="0" cellpadding="8" cellspacing="0">
	<tr>
		<td>
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "color") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<html:text property='<%= propertyPrefix + "TextColor" %>' styleClass="form-text" onchange='<%= "preview." + previewObject + ".color = this.value;" %>' /> <img align="absmiddle" src="<%= themeDisplay.getPathJavaScript() %>/colorpicker/colorpicker.gif" style="cursor: pointer;" onclick="colorPicker.toggle(this);" />
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "decoration") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<html:select property='<%= propertyPrefix + "TextDecor" %>' onchange='<%= "preview." + previewObject + ".textDecoration = this.value;" %>'>
						<html:optionsCollection property="listFontDecorations" />
					</html:select>
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "font") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<html:select property='<%= propertyPrefix + "TextFont" %>' onchange='<%= "preview." + previewObject + ".fontFamily = this.value;" %>'>
						<html:optionsCollection property="listFonts" />
					</html:select>
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "size") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<html:select property='<%= propertyPrefix + "TextSize" %>' onchange='<%= "preview." + previewObject + ".fontSize = this.value;" %>'>
						<html:optionsCollection property="listFontSizes" />
					</html:select>
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "style") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>

					<%
					String textStyleOnClick = "preview." + previewObject + ".fontStyle = this.checked ? 'italic' : 'normal';";
					String textBoldOnClick = "preview." + previewObject + ".fontWeight = this.checked ? 'bold' : 'normal';";
					%>

					<html:checkbox styleId='<%= propertyPrefix + "TextStyle" %>' property='<%= propertyPrefix + "TextStyle" %>' onclick="<%= textStyleOnClick %>" /> <%= LanguageUtil.get(pageContext, "italic") %>

					&nbsp;

					<html:checkbox styleId='<%= propertyPrefix + "TextBold" %>' property='<%= propertyPrefix + "TextBold" %>' onclick="<%= textBoldOnClick %>" /> <%= LanguageUtil.get(pageContext, "bold") %>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
</fieldset>
