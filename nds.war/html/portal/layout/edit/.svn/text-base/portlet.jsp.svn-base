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

<%@ include file="/html/portal/init.jsp" %>
<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td nowrap>
		<%= LanguageUtil.get(pageContext, "copy-page") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />copyLayoutId">
			<option value=""></option>

			<%
			List layoutList = (List)request.getAttribute(WebKeys.LAYOUT_LISTER_LIST);

			for (int i = 0; i < layoutList.size(); i++) {

				// id | parentId | ls | obj id | name | img | depth

				String layoutDesc = (String)layoutList.get(i);

				String[] nodeValues = StringUtil.split(layoutDesc, "|");

				String objId = nodeValues[3];
				String name = nodeValues[4];

				int depth = 0;

				if (i != 0) {
					depth = GetterUtil.getInteger(nodeValues[6]);
				}

				for (int j = 0; j < depth; j++) {
					name = "-&nbsp;" + name;
				}

				Layout copiableLayout = null;

				try {
					copiableLayout = LayoutLocalServiceUtil.getLayout(LayoutImpl.getLayoutId(objId), LayoutImpl.getOwnerId(objId));
				}
				catch (Exception e) {
				}

				if (copiableLayout != null) {
			%>

					<option value="<%= copiableLayout.getLayoutId() %>"><%= name %></option>

			<%
				}
			}
			%>

		</select>
	</td>
</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td>
		<table border="0" cellpadding="4" cellspacing="0" width="100%">
		<tr>
			<td class="beta-gradient">
				<b><%= LanguageUtil.get(pageContext, "meta-tags") %>:</b>
			</td>
			<td align="right" class="beta-gradient">
				<span style="font-size: xx-small;">
				[<a href="javascript: void(0);" onClick="toggleByIdSpan(this, '<portlet:namespace />metaTags'); self.focus();"><span><%= LanguageUtil.get(pageContext, "show") %></span><span style="display: none;"><%= LanguageUtil.get(pageContext, "hide") %></span></a>]
				</span>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="<portlet:namespace />metaTags" style="display: none;">
			<br>

			<%= LanguageUtil.get(pageContext, "meta-robots") %><br>

			<textarea class="form-text" name="TypeSettingsProperties(meta-robots)" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: 400px;" wrap="soft"><bean:write name="SEL_LAYOUT" property="typeSettingsProperties(meta-robots)" /></textarea>

			<br><br>

			<%= LanguageUtil.get(pageContext, "meta-description") %><br>

			<textarea class="form-text" name="TypeSettingsProperties(meta-description)" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: 400px;" wrap="soft"><bean:write name="SEL_LAYOUT" property="typeSettingsProperties(meta-description)" /></textarea>

			<br><br>

			<%= LanguageUtil.get(pageContext, "meta-keywords") %><br>

			<textarea class="form-text" name="TypeSettingsProperties(meta-keywords)" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: 400px;" wrap="soft"><bean:write name="SEL_LAYOUT" property="typeSettingsProperties(meta-keywords)" /></textarea>

			<br><br>
		</div>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="4" cellspacing="0" width="100%">
		<tr>
			<td class="beta-gradient">
				<b><%= LanguageUtil.get(pageContext, "javascript") %>:</b>
			</td>
			<td align="right" class="beta-gradient">
				<span style="font-size: xx-small;">
				[<a href="javascript: void(0);" onClick="toggleByIdSpan(this, '<portlet:namespace />javascript'); self.focus();"><span><%= LanguageUtil.get(pageContext, "show") %></span><span style="display: none;"><%= LanguageUtil.get(pageContext, "hide") %></span></a>]
				</span>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="<portlet:namespace />javascript" style="display: none;">
			<br>

			<%= LanguageUtil.get(pageContext, "javascript-1") %><br>

			<textarea class="form-text" name="TypeSettingsProperties(javascript-1)" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: 400px;" wrap="soft"><bean:write name="SEL_LAYOUT" property="typeSettingsProperties(javascript-1)" /></textarea>

			<br><br>

			<%= LanguageUtil.get(pageContext, "javascript-2") %><br>

			<textarea class="form-text" name="TypeSettingsProperties(javascript-2)" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: 400px;" wrap="soft"><bean:write name="SEL_LAYOUT" property="typeSettingsProperties(javascript-2)" /></textarea>

			<br><br>

			<%= LanguageUtil.get(pageContext, "javascript-3") %><br>

			<textarea class="form-text" name="TypeSettingsProperties(javascript-3)" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: 400px;" wrap="soft"><bean:write name="SEL_LAYOUT" property="typeSettingsProperties(javascript-3)" /></textarea>
		</div>
	</td>
</tr>
</table>
