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

<%@ include file="/html/portlet/shopping/init.jsp" %>

<%
OrderSearch searchContainer = (OrderSearch)request.getAttribute("liferay-ui:search:searchContainer");

OrderDisplayTerms displayTerms = (OrderDisplayTerms)searchContainer.getDisplayTerms();
%>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "id") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "status") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "first-name") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "last-name") %>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "email-address") %>
	</td>
</tr>
<tr>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= OrderDisplayTerms.ORDER_ID %>" size="20" type="text" value="<%= displayTerms.getOrderId() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<select name="<%= OrderDisplayTerms.STATUS %>">
			<option value=""></option>

			<%
			for (int i = 0; i < ShoppingOrderImpl.STATUSES.length; i++) {
			%>

				<option <%= displayTerms.getStatus().equals(ShoppingOrderImpl.STATUSES[i]) ? "selected" : "" %> value="<%= ShoppingOrderImpl.STATUSES[i] %>"><%= LanguageUtil.get(pageContext, ShoppingOrderImpl.STATUSES[i]) %></option>

			<%
			}
			%>

		</select>
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= OrderDisplayTerms.FIRST_NAME %>" size="20" type="text" value="<%= displayTerms.getFirstName() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= OrderDisplayTerms.LAST_NAME %>" size="20" type="text" value="<%= displayTerms.getLastName() %>">
	</td>
	<td style="padding-left: 5px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace /><%= OrderDisplayTerms.EMAIL_ADDRESS %>" size="20" type="text" value="<%= displayTerms.getEmailAddress() %>">
	</td>
</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<select name="<portlet:namespace /><%= OrderDisplayTerms.AND_OPERATOR %>">
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
