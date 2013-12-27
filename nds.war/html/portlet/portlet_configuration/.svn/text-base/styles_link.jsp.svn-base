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
%>

<fieldset>
	<legend><b><%= LanguageUtil.get(pageContext, "link") %></b></legend>

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
					<html:text property='<%= propertyPrefix + "LinkColor" %>' styleClass="form-text" onchange="preview.aColor(this.value);" /> <img align="absmiddle" src="<%= themeDisplay.getPathJavaScript() %>/colorpicker/colorpicker.gif" style="cursor: pointer;" onclick="colorPicker.toggle(this);" />
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "decoration") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<html:select property='<%= propertyPrefix + "LinkDecor" %>' onchange="preview.aDecor(this.value);">
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
					<html:select property='<%= propertyPrefix + "LinkFont" %>' onchange="preview.aFont(this.value);">
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
					<html:select property='<%= propertyPrefix + "LinkSize" %>' onchange="preview.aSize(this.value);">
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
					<html:checkbox styleId='<%= propertyPrefix + "LinkStyle" %>' property='<%= propertyPrefix + "LinkStyle" %>' onclick="preview.aStyle(this.checked);" /> <%= LanguageUtil.get(pageContext, "italic") %>

					&nbsp;

					<html:checkbox styleId='<%= propertyPrefix + "LinkBold" %>' property='<%= propertyPrefix + "LinkBold" %>' onclick="preview.aWeight(this.checked);" /> <%= LanguageUtil.get(pageContext, "bold") %>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
</fieldset>

<br>

<fieldset>
	<legend><b><%= LanguageUtil.get(pageContext, "hover-link") %></b></legend>

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
					<html:text property='<%= propertyPrefix + "LinkHoverColor" %>' styleClass="form-text" onchange="preview.setHoverStyle('color', this.value);" /> <img align="absmiddle" src="<%= themeDisplay.getPathJavaScript() %>/colorpicker/colorpicker.gif" style="cursor: pointer;" onclick="colorPicker.toggle(this);" />
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "decoration") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<html:select property='<%= propertyPrefix + "LinkHoverDecor" %>' onchange="preview.setHoverStyle('decor', this.value);">
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
					<html:select property='<%= propertyPrefix + "LinkHoverFont" %>' onchange="preview.setHoverStyle('font', this.value);">
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
					<html:select property='<%= propertyPrefix + "LinkHoverSize" %>' onchange="preview.setHoverStyle('size', this.value);">
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
					<html:checkbox styleId='<%= propertyPrefix + "LinkHoverStyle" %>' property='<%= propertyPrefix + "LinkHoverStyle" %>' onclick="preview.setHoverStyle('style', this.checked);" /> <%= LanguageUtil.get(pageContext, "italic") %>

					&nbsp;

					<html:checkbox styleId='<%= propertyPrefix + "LinkHoverBold" %>' property='<%= propertyPrefix + "LinkHoverBold" %>' onclick="preview.setHoverStyle('weight', this.checked);" /> <%= LanguageUtil.get(pageContext, "bold") %>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
</fieldset>

<br>

<fieldset>
	<legend><b><%= LanguageUtil.get(pageContext, "visited-link") %></b></legend>

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
					<html:text property='<%= propertyPrefix + "LinkVisitedColor" %>' styleClass="form-text" onchange="" /> <img align="absmiddle" src="<%= themeDisplay.getPathJavaScript() %>/colorpicker/colorpicker.gif" style="cursor: pointer;" onclick="colorPicker.toggle(this);" />
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "decoration") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<html:select property='<%= propertyPrefix + "LinkVisitedDecor" %>'>
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
					<html:select property='<%= propertyPrefix + "LinkVisitedFont" %>'>
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
					<html:select property='<%= propertyPrefix + "LinkVisitedSize" %>'>
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
					<html:checkbox styleId='<%= propertyPrefix + "LinkVisitedStyle" %>' property='<%= propertyPrefix + "LinkVisitedStyle" %>' /> <%= LanguageUtil.get(pageContext, "italic") %>

					&nbsp;

					<html:checkbox styleId='<%= propertyPrefix + "LinkVisitedBold" %>' property='<%= propertyPrefix + "LinkVisitedBold" %>' /> <%= LanguageUtil.get(pageContext, "bold") %>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
</fieldset>
