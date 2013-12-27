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

<%@ include file="/html/portlet/web_proxy/init.jsp" %>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "url") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />initUrl" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" value="<%= initUrl %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "scope") %> (<%= LanguageUtil.get(pageContext, "regex") %>)
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />scope" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" value="<%= scope %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "proxy-host") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />proxyHost" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" value="<%= proxyHost %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "proxy-port") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />proxyPort" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" value="<%= proxyPort %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "proxy-authentication") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />proxyAuthentication">
			<option <%= proxyAuthentication.equals("none") ? "selected" : "" %> value="none"><%= LanguageUtil.get(pageContext, "none") %></option>
			<option <%= proxyAuthentication.equals("basic") ? "selected" : "" %> value="basic"><%= LanguageUtil.get(pageContext, "basic") %></option>
			<option <%= proxyAuthentication.equals("ntlm") ? "selected" : "" %> value="ntlm"><%= LanguageUtil.get(pageContext, "ntlm") %></option>
		</select>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "proxy-authentication-username") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />proxyAuthenticationUsername" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" value="<%= proxyAuthenticationUsername %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "proxy-authentication-password") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />proxyAuthenticationPassword" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" value="<%= proxyAuthenticationPassword %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "proxy-authentication-host") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />proxyAuthenticationHost" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" value="<%= proxyAuthenticationHost %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "proxy-authentication-domain") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />proxyAuthenticationDomain" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" value="<%= proxyAuthenticationDomain %>">
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "stylesheet") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<textarea class="form-text" name="<portlet:namespace />stylesheet" style="height: 300px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;" wrap="soft" onKeyDown="checkTab(this); disableEsc();"><%= stylesheet %></textarea>
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">

</form>

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		document.<portlet:namespace />fm.<portlet:namespace />initUrl.focus();
	</script>
</c:if>
