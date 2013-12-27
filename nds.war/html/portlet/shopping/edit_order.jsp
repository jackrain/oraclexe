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
String redirect = ParamUtil.getString(request, "redirect");

ShoppingOrder order = (ShoppingOrder)request.getAttribute(WebKeys.SHOPPING_ORDER);

String orderId = BeanParamUtil.getString(order, request, "orderId");

WindowState windowState = renderRequest.getWindowState();
%>

<script type="text/javascript">
	function <portlet:namespace />deleteOrder() {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.DELETE %>";
		document.<portlet:namespace />fm.<portlet:namespace />redirect.value = "<%= redirect %>";
		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />saveOrder() {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.UPDATE %>";
		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />sendEmail(emailType) {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "sendEmail";
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/edit_order" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= currentURL %>">
<input name="<portlet:namespace />orderId" type="hidden" value="<%= orderId %>" />
<input name="<portlet:namespace />emailType" type="hidden" value="" />
<input name="<portlet:namespace />deleteOrderIds" type="hidden" value="<%= orderId %>" />

<c:choose>
	<c:when test="<%= windowState.equals(LiferayWindowState.POP_UP) %>">
		<a href="<%= themeDisplay.getURLHome() %>"><img src="<%= themeDisplay.getCompanyLogo() %>"></a>

		<br><br>

		<span style="font-size: small;">
		<b><%= LanguageUtil.get(pageContext, "invoice") %></b>
		</span>

		<br><br>
	</c:when>
	<c:otherwise>
		<liferay-util:include page="/html/portlet/shopping/tabs1.jsp">
			<liferay-util:param name="tabs1" value="orders" />
		</liferay-util:include>
	</c:otherwise>
</c:choose>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "order") %> #:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<b><%= order.getOrderId() %></b>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "order-date") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<%= dateFormatDateTime.format(order.getCreateDate()) %>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "last-modified") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<%= dateFormatDateTime.format(order.getModifiedDate()) %>
	</td>
</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<b><%= LanguageUtil.get(pageContext, "billing-address") %></b>

		<br><br>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "first-name") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getBillingFirstName() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "last-name") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getBillingLastName() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "email-address") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getBillingEmailAddress() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "company") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getBillingCompany() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "street") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getBillingStreet() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "city") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getBillingCity() %>:
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "state") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getBillingState() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "zip") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getBillingZip() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "country") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getBillingCountry() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "phone") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getBillingPhone() %>
			</td>
		</tr>
		</table>
	</td>
	<td style="padding-left: 30px;"></td>
	<td valign="top">
		<b><%= LanguageUtil.get(pageContext, "shipping-address") %></b>

		<br><br>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "first-name") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getShippingFirstName() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "last-name") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getShippingLastName() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "email-address") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getShippingEmailAddress() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "company") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getShippingCompany() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "street") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getShippingStreet() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "city") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getShippingCity() %>:
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "state") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getShippingState() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "zip") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getShippingZip() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "country") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getShippingCountry() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "phone") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getShippingPhone() %>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<br>

<c:choose>
	<c:when test="<%= shoppingPrefs.usePayPal() %>">
		<b>PayPal</b>

		<br><br>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "status") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select name="<portlet:namespace />ppPaymentStatus">

					<%
					for (int i = 0; i < ShoppingOrderImpl.STATUSES.length; i++) {
					%>

						<option <%= ShoppingUtil.getPpPaymentStatus(ShoppingOrderImpl.STATUSES[i]).equals(order.getPpPaymentStatus()) ? "selected" : "" %> value="<%= ShoppingOrderImpl.STATUSES[i] %>"><%= LanguageUtil.get(pageContext, ShoppingOrderImpl.STATUSES[i]) %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "transaction-id") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= ShoppingOrder.class %>" bean="<%= order %>" field="ppTxnId" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "payment-gross") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= ShoppingOrder.class %>" bean="<%= order %>" field="ppPaymentGross" defaultValue="<%= currency.getSymbol() + doubleFormat.format(order.getPpPaymentGross()) %>" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "receiver-email-address") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= ShoppingOrder.class %>" bean="<%= order %>" field="ppReceiverEmail" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "payer-email-address") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<liferay-ui:input-field model="<%= ShoppingOrder.class %>" bean="<%= order %>" field="ppPayerEmail" />
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "paypal-order") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>

				<%
				String payPalLinkOpen = "<a href=\"" + ShoppingUtil.getPayPalRedirectURL(shoppingPrefs, order, ShoppingUtil.calculateTotal(order), ShoppingUtil.getPayPalReturnURL(renderResponse.createActionURL(), order), ShoppingUtil.getPayPalNotifyURL(company, themeDisplay.getPathMain())) + "\"><b><u>";
				String payPalLinkClose = "</u></b></a>";
				%>

				<%= LanguageUtil.format(pageContext, "please-complete-your-order", new Object[] {payPalLinkOpen, payPalLinkClose}, false) %>
			</td>
		</tr>
		</table>
	</c:when>
	<c:otherwise>
		<b><%= LanguageUtil.get(pageContext, "credit-card") %></b>

		<br><br>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "full-name") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= order.getCcName() %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "type") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= LanguageUtil.get(pageContext, "cc_" + order.getCcType()) %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "number") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= CreditCard.hide(order.getCcNumber()) %>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "expiration-date") %>:
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%= CalendarUtil.getMonths(locale)[order.getCcExpMonth()] %>, <%= order.getCcExpYear() %>
			</td>
		</tr>

		<c:if test="<%= Validator.isNotNull(order.getCcVerNumber()) %>">
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "verification-number") %>:
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<%= order.getCcVerNumber() %>
				</td>
			</tr>
		</c:if>

		</table>
	</c:otherwise>
</c:choose>

<br>

<c:if test="<%= Validator.isNotNull(order.getComments()) %>">
	<b><%= LanguageUtil.get(pageContext, "comments") %></b>

	<br><br>

	<%= order.getComments() %>

	<br><br>
</c:if>

<%
StringBuffer itemIds = new StringBuffer();

SearchContainer searchContainer = new SearchContainer();

List headerNames = new ArrayList();

headerNames.add("sku");
headerNames.add("description");
headerNames.add("quantity");
headerNames.add("price");
headerNames.add("total");

searchContainer.setHeaderNames(headerNames);
searchContainer.setHover(false);

List results = ShoppingOrderItemLocalServiceUtil.getOrderItems(order.getOrderId());
int total = results.size();

searchContainer.setTotal(total);

List resultRows = searchContainer.getResultRows();

Iterator itr = results.iterator();

for (int i = 0; itr.hasNext(); i++) {
	ShoppingOrderItem orderItem = (ShoppingOrderItem)itr.next();

	ShoppingItem item = null;

	try {
		item = ShoppingItemLocalServiceUtil.getItem(ShoppingUtil.getItemId(orderItem.getItemId()));
	}
	catch (Exception e) {
	}

	String[] fieldsArray = StringUtil.split(ShoppingUtil.getItemFields(orderItem.getItemId()), "&");

	int quantity = orderItem.getQuantity();

	ResultRow row = new ResultRow(item, orderItem.getPrimaryKey().toString(), i);

	PortletURL rowURL = null;

	if (item != null) {
		rowURL = renderResponse.createRenderURL();

		rowURL.setWindowState(WindowState.MAXIMIZED);

		rowURL.setParameter("struts_action", "/shopping/view_item");
		rowURL.setParameter("itemId", item.getItemId());
	}

	// SKU

	row.addText(orderItem.getSku(), rowURL);

	// Description

	StringBuffer sb = new StringBuffer();

	sb.append(orderItem.getName());

	if (fieldsArray.length > 0) {
		sb.append(" (");
		sb.append(StringUtil.replace(StringUtil.merge(fieldsArray, ", "), "=", ": "));
		sb.append(")");
	}

	row.addText(sb.toString(), rowURL);

	// Quantity

	row.addText(String.valueOf(quantity), rowURL);

	// Price

	row.addText(currency.getSymbol() + doubleFormat.format(orderItem.getPrice()), rowURL);

	// Total

	row.addText(currency.getSymbol() + doubleFormat.format(orderItem.getPrice() * quantity), rowURL);

	// Add result row

	resultRows.add(row);
}
%>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "subtotal") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<%= currency.getSymbol() %><%= doubleFormat.format(ShoppingUtil.calculateActualSubtotal(results)) %>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "tax") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<%= currency.getSymbol() %><%= doubleFormat.format(order.getTax()) %>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "shipping") %> <%= Validator.isNotNull(order.getAltShipping()) ? "(" + order.getAltShipping() + ")" : StringPool.BLANK %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<%= currency.getSymbol() %><%= doubleFormat.format(order.getShipping()) %>
	</td>
</tr>

<c:if test="<%= order.isInsure() %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "insurance") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= currency.getSymbol() %><%= doubleFormat.format(order.getInsurance()) %>
		</td>
	</tr>
</c:if>

<c:if test="<%= Validator.isNotNull(order.getCouponIds()) %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "coupon-discount") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= currency.getSymbol() %><%= doubleFormat.format(order.getCouponDiscount()) %>

			<a href="javascript: var viewCouponWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/shopping/view_coupon" /><portlet:param name="couponId" value="<%= order.getCouponIds() %>" /></portlet:renderURL>', 'viewCoupon', 'directories=no,height=200,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no,width=280'); void(''); viewCouponWindow.focus();">
			(<%= order.getCouponIds() %>)
			</a>
		</td>
	</tr>
</c:if>

<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "total") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<%= currency.getSymbol() %><%= doubleFormat.format(ShoppingUtil.calculateTotal(order)) %>
	</td>
</tr>
</table>

<c:if test="<%= !windowState.equals(LiferayWindowState.POP_UP) %>">
	<br>

	<c:if test="<%= shoppingPrefs.usePayPal() %>">
		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveOrder();">
	</c:if>

	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "invoice") %>' onClick="window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/shopping/edit_order" /><portlet:param name="orderId" value="<%= orderId %>" /></portlet:renderURL>');">

	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, (order.isSendOrderEmail() ? "" : "re") + "send-confirmation-email") %>' onClick="<portlet:namespace />sendEmail('confirmation');">

	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, (order.isSendShippingEmail() ? "" : "re") + "send-shipping-email") %>' onClick="<portlet:namespace />sendEmail('shipping');">

	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "delete") %>' onClick="<portlet:namespace />deleteOrder();">

	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
</c:if>

</form>

<c:if test="<%= !windowState.equals(LiferayWindowState.POP_UP) %>">
	<br>

	<liferay-ui:tabs names="comments" />

	<portlet:actionURL var="discussionURL">
		<portlet:param name="struts_action" value="/shopping/edit_order_discussion" />
	</portlet:actionURL>

	<liferay-ui:discussion
		formName="fm2"
		formAction="<%= discussionURL %>"
		className="<%= ShoppingOrder.class.getName() %>"
		classPK="<%= order.getPrimaryKey().toString() %>"
		userId="<%= order.getUserId() %>"
		subject="<%= order.getOrderId() %>"
		redirect="<%= currentURL %>"
	/>
</c:if>
