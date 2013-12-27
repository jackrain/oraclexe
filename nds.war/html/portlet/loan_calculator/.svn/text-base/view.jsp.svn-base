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

<%@ include file="/html/portlet/loan_calculator/init.jsp" %>

<%
int loanAmount = ParamUtil.get(request, "loanAmount", 200000);
double interest = ParamUtil.get(request, "interest", 7.00);
int years = ParamUtil.get(request, "years", 30);
int paymentsPerYear = ParamUtil.get(request, "paymentsPerYear", 12);

double tempValue = Math.pow((1 + (interest / 100 / paymentsPerYear)), (years * paymentsPerYear));
double amountPerPayment = (loanAmount * tempValue * (interest / 100 / paymentsPerYear)) / (tempValue - 1);
double totalPaid = amountPerPayment * years * paymentsPerYear;
double interestPaid = totalPaid - loanAmount;

NumberFormat doubleFormat = NumberFormat.getNumberInstance(locale);

doubleFormat.setMaximumFractionDigits(2);
doubleFormat.setMinimumFractionDigits(2);

NumberFormat integerFormat = NumberFormat.getNumberInstance(locale);

integerFormat.setMaximumFractionDigits(0);
integerFormat.setMinimumFractionDigits(0);

NumberFormat percentFormat = NumberFormat.getPercentInstance(locale);
%>

<form method="post" name="<portlet:namespace />fm" onSubmit="loadForm(document.<portlet:namespace />fm, '<liferay-portlet:renderURL anchor="false"><portlet:param name="struts_action" value="/loan_calculator/view" /></liferay-portlet:renderURL>', 'p_p_id<portlet:namespace />'); return false;">

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "loan-amount") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />loanAmount" size="5" type="text" value="<%= integerFormat.format(loanAmount) %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "interest-rate") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />interest" size="5" type="text" value="<%= doubleFormat.format(interest) %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "years") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />years" size="5" type="text" value="<%= years %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "monthly-payment") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<b><%= integerFormat.format(amountPerPayment) %></b>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "interest-paid") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<b><%= integerFormat.format(interestPaid) %></b>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "total-paid") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<b><%= integerFormat.format(totalPaid) %></b>
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "calculate") %>">

</form>

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		document.<portlet:namespace />fm.<portlet:namespace />loanAmount.focus();
	</script>
</c:if>
