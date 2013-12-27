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
		<%= LanguageUtil.get(pageContext, "aim") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="aimSn" />
	</td>
	<td colspan="2"></td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "icq") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="icqSn" />
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<c:if test="<%= Validator.isNotNull(contact2.getIcqSn()) %>">
			<img border="0" hspace="0" src="http://web.icq.com/whitepages/online?icq=<%= contact2.getIcqSn() %>&img=5" vspace="0">
		</c:if>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "jabber") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="jabberSn" />
	</td>
	<td colspan="2"></td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "msn") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="msnSn" />
	</td>
	<td colspan="2"></td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "skype") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="skypeSn" />
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<c:if test="<%= Validator.isNotNull(contact2.getSkypeSn()) %>">
			<a href="callto://<%= contact2.getSkypeSn() %>"><img src="http://mystatus.skype.com/smallicon/<%= contact2.getSkypeSn() %>"></a>
		</c:if>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "ym") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="ymSn" />
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<c:if test="<%= Validator.isNotNull(contact2.getYmSn()) %>">
			<img border="0" hspace="0" src="http://opi.yahoo.com/online?u=<%= contact2.getYmSn() %>&m=g&t=0" vspace="0">
		</c:if>
	</td>
</tr>
</table>

<c:if test="<%= editable %>">
	<br>

	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveUser('im');"><br>
</c:if>

<br>
