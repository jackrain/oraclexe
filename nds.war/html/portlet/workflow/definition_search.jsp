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

<%@ include file="/html/portlet/workflow/init.jsp" %>

<%
DefinitionSearch searchContainer = (DefinitionSearch)request.getAttribute("liferay-ui:search:searchContainer");

DefinitionDisplayTerms displayTerms = (DefinitionDisplayTerms)searchContainer.getDisplayTerms();
%>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<%--<td>
		<%= LanguageUtil.get(pageContext, "definition-id") %>
	</td>
	<td style="padding-left: 5px;"></td>--%>
	<td>
		<%= LanguageUtil.get(pageContext, "definition-name") %>
	</td>
</tr>
<tr>
	<%--<td>
		<input class="form-text" name="<portlet:namespace /><%= DefinitionDisplayTerms.DEFINITION_ID %>" size="20" type="text" value="<%= displayTerms.getDefinitionIdString() %>">
	</td>
	<td style="padding-left: 5px;"></td>--%>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= DefinitionDisplayTerms.NAME %>" size="20" type="text" value="<%= displayTerms.getName() %>">
	</td>
</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<select name="<portlet:namespace /><%= DefinitionDisplayTerms.AND_OPERATOR %>">
			<option <%= displayTerms.isAndOperator() ? "selected" : "" %> value="1"><%= LanguageUtil.get(pageContext, "and") %></option>
			<option <%= !displayTerms.isAndOperator() ? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "or") %></option>
		</select>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">
	</td>
</tr>
</table>
