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

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "enabled") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="enabled" defaultValue="<%= PrefsPropsUtil.getBoolean(PropsUtil.AUTO_DEPLOY_ENABLED) %>" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "deploy-directory") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />deployDir" size="75" type="text" value="<%= PrefsPropsUtil.getString(PropsUtil.AUTO_DEPLOY_DEPLOY_DIR) %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "dest-directory") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />destDir" size="75" type="text" value="<%= PrefsPropsUtil.getString(PropsUtil.AUTO_DEPLOY_DEST_DIR) %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "interval") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />interval">
			<option value="0"><%= LanguageUtil.get(pageContext, "disable") %></option>

			<%
			long interval = PrefsPropsUtil.getInteger(PropsUtil.AUTO_DEPLOY_INTERVAL);

			for (int i = 0;;) {
				if (i < Time.MINUTE) {
					i += Time.SECOND * 5;
				}
				else {
					i += Time.MINUTE;
				}
			%>

				<option <%= (interval == i) ? "selected" : "" %> value="<%= i %>"><%= LanguageUtil.getTimeDescription(pageContext, i) %></option>

			<%
				if (i >= (Time.MINUTE * 5)) {
					break;
				}
			}
			%>

		</select>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "unpack-war") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="unpackWar" defaultValue="<%= PrefsPropsUtil.getBoolean(PropsUtil.AUTO_DEPLOY_UNPACK_WAR) %>" />
	</td>
</tr>

<c:if test="<%= ServerDetector.isTomcat() %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "tomcat-lib-dir") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<input class="form-text" name="<portlet:namespace />tomcatLibDir" size="75" type="text" value="<%= PrefsPropsUtil.getString(PropsUtil.AUTO_DEPLOY_TOMCAT_LIB_DIR) %>">
		</td>
	</tr>
</c:if>

</table>

<br>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveServer('autoDeploy');">

<br><br>

<liferay-ui:tabs
	names="hot-deploy"
	param="tabs2"
/>

<liferay-ui:error exception="<%= UploadException.class %>" message="an-unexpected-error-occurred-while-uploading-your-file" />

<%= LanguageUtil.get(pageContext, "upload-a-war-file-to-hot-deploy-a-layout-template,-portlet,-or-theme") %>

<br><br>

<input class="form-text" name="<portlet:namespace />file" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="file">

<br><br>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "deploy") %>' onClick="<portlet:namespace />saveServer('hotDeploy');">
