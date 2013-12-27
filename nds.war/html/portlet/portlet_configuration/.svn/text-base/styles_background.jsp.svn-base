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
	<legend><b><%= LanguageUtil.get(pageContext, propertyPrefix + "-background") %></b></legend>

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
					<html:text property='<%= propertyPrefix + "BgColor" %>' styleClass="form-text" onchange='<%= "preview." + previewObject + ".backgroundColor = this.value;" %>' /> <img align="absmiddle" src="<%= themeDisplay.getPathJavaScript() %>/colorpicker/colorpicker.gif" style="cursor: pointer;" onClick="colorPicker.toggle(this);" />
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "image") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<html:text property='<%= propertyPrefix + "BgImageUrl" %>' styleClass="form-text" onchange='<%= "preview." + previewObject + ".backgroundImage = \'url(\' + this.value + \')\';" %>' />
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "attachment") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<html:select property='<%= propertyPrefix + "BgImageAttach" %>' onchange='<%= "preview." + previewObject + ".backgroundAttachment = this.value;" %>'>
						<html:optionsCollection property="listImageAttachments" />
					</html:select>
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "position") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<html:select property='<%= propertyPrefix + "BgImagePos" %>' onchange='<%= "preview." + previewObject + ".backgroundPosition = this.value;" %>'>
						<html:optionsCollection property="listImagePositions" />
					</html:select>
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "tile") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<html:select property='<%= propertyPrefix + "BgImageTile" %>' onchange='<%= "preview." + previewObject + ".backgroundRepeat = this.value;" %>'>
						<html:optionsCollection property="listImageTiling" />
					</html:select>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
</fieldset>
