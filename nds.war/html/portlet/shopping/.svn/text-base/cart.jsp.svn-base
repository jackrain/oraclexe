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

ShoppingCart cart = ShoppingUtil.getCart(renderRequest);

Map items = cart.getItems();

ShoppingCoupon coupon = cart.getCoupon();

boolean minQuantityMultiple = PrefsPropsUtil.getBoolean(company.getCompanyId(), PropsUtil.SHOPPING_CART_MIN_QTY_MULTIPLE);
%>

<script type="text/javascript">
	var itemsInStock = true;

	function <portlet:namespace />checkout() {
		if (<%= (ShoppingUtil.meetsMinOrder(shoppingPrefs, items)) ? "true" : "false" %>) {
			if (!itemsInStock) {
				if (confirm("<%= UnicodeLanguageUtil.get(pageContext, "your-cart-has-items-that-are-out-of-stock") %>")) {
					document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.CHECKOUT %>";
					document.<portlet:namespace />fm.<portlet:namespace />redirect.value = "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/checkout" /></portlet:actionURL>";
					<portlet:namespace />updateCart();
				}
			}
			else {
				document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.CHECKOUT %>";
				document.<portlet:namespace />fm.<portlet:namespace />redirect.value = "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/checkout" /></portlet:actionURL>";
				<portlet:namespace />updateCart();
			}
		}
		else {
			alert("<%= UnicodeLanguageUtil.format(pageContext, "your-order-cannot-be-processed-because-it-falls-below-the-minimum-required-amount-of-x", currency.getSymbol() + doubleFormat.format(shoppingPrefs.getMinOrder()), false) %>");
		}
	}

	function <portlet:namespace />emptyCart() {
		document.<portlet:namespace />fm.<portlet:namespace />itemIds.value = "";
		document.<portlet:namespace />fm.<portlet:namespace />couponIds.value = "";
		submitForm(document.<portlet:namespace />fm);
	}

	function <portlet:namespace />updateCart() {
		var itemIds = "";
		var count = 0;

		<%
		Iterator itr = items.entrySet().iterator();

		for (int i = 0; itr.hasNext(); i++) {
			Map.Entry entry = (Map.Entry)itr.next();

			ShoppingCartItem cartItem = (ShoppingCartItem)entry.getKey();

			ShoppingItem item = cartItem.getItem();
		%>

			count = document.<portlet:namespace />fm.<portlet:namespace />item_<%= item.getItemId() %>_<%= i %>_count.value;

			for (var i = 0; i < count; i++) {
				itemIds += "<%= cartItem.getCartItemId() %>,";
			}

			count = 0;

		<%
		}
		%>

		document.<portlet:namespace />fm.<portlet:namespace />itemIds.value = itemIds;
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/cart" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />saveCart(); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= currentURL %>">
<input name="<portlet:namespace />itemIds" type="hidden" value="">

<liferay-util:include page="/html/portlet/shopping/tabs1.jsp">
	<liferay-util:param name="tabs1" value="cart" />
	<liferay-util:param name="backURL" value="<%= redirect %>" />
</liferay-util:include>

<liferay-ui:error exception="<%= CartMinQuantityException.class %>">

	<%
	CartMinQuantityException cmqe = (CartMinQuantityException)errorException;

	String[] badItemIds = StringUtil.split(cmqe.getMessage());
	%>

	<%= LanguageUtil.get(pageContext, "all-quantities-must-be-greater-than-the-minimum-quantity-of-the-item") %><br>

	<c:if test="<%= minQuantityMultiple %>">
		<br>

		<%= LanguageUtil.get(pageContext, "all-quantities-must-be-a-multiple-of-the-minimum-quantity-of-the-item") %><br>
	</c:if>

	<br>

	<%= LanguageUtil.get(pageContext, "please-reenter-your-quantity-for-the-items-with-the-following-skus") %>

	<%
	for (int i = 0; i < badItemIds.length; i++) {
		ShoppingItem item = ShoppingItemLocalServiceUtil.getItem(badItemIds[i]);
	%>

		<b><%= item.getSku() %></b><c:if test="<%= i + 1 < badItemIds.length %>">,</c:if>

	<%
	}
	%>

</liferay-ui:error>

<liferay-ui:error exception="<%= CouponActiveException.class %>" message="the-specified-coupon-is-not-active" />
<liferay-ui:error exception="<%= CouponEndDateException.class %>" message="the-specified-coupon-is-no-longer-available" />
<liferay-ui:error exception="<%= CouponStartDateException.class %>" message="the-specified-coupon-is-no-yet-available" />
<liferay-ui:error exception="<%= NoSuchCouponException.class %>" message="please-enter-a-valid-coupon-code" />

<%
SearchContainer searchContainer = new SearchContainer();

List headerNames = new ArrayList();

headerNames.add("sku");
headerNames.add("description");
headerNames.add("quantity");
headerNames.add("price");

searchContainer.setHeaderNames(headerNames);
searchContainer.setEmptyResultsMessage("your-cart-is-empty");
searchContainer.setHover(false);

Set results = items.entrySet();
int total = items.size();

searchContainer.setTotal(total);

List resultRows = searchContainer.getResultRows();

itr = results.iterator();

for (int i = 0; itr.hasNext(); i++) {
	Map.Entry entry = (Map.Entry)itr.next();

	ShoppingCartItem cartItem = (ShoppingCartItem)entry.getKey();
	Integer count = (Integer)entry.getValue();

	ShoppingItem item = cartItem.getItem();
	String[] fieldsArray = cartItem.getFieldsArray();

	ShoppingItemField[] itemFields = (ShoppingItemField[])ShoppingItemFieldLocalServiceUtil.getItemFields(item.getItemId()).toArray(new ShoppingItemField[0]);
	ShoppingItemPrice[] itemPrices = (ShoppingItemPrice[])ShoppingItemPriceLocalServiceUtil.getItemPrices(item.getItemId()).toArray(new ShoppingItemPrice[0]);

	if (!SessionErrors.isEmpty(renderRequest)) {
		count = new Integer(ParamUtil.getInteger(request, "item_" + item.getItemId() + "_" + i + "_count"));
	}

	ResultRow row = new ResultRow(item, item.getPrimaryKey().toString(), i);

	PortletURL rowURL = renderResponse.createRenderURL();

	rowURL.setWindowState(WindowState.MAXIMIZED);

	rowURL.setParameter("struts_action", "/shopping/view_item");
	rowURL.setParameter("itemId", item.getItemId());

	// SKU and small image

	StringBuffer sb = new StringBuffer();

	if (item.isSmallImage()) {
		sb.append("<br>");
		sb.append("<img alt=\"");
		sb.append(item.getSku());
		sb.append("\" border=\"0\" src=\"");

		if (Validator.isNotNull(item.getSmallImageURL())) {
			sb.append(item.getSmallImageURL());
		}
		else {
			sb.append(themeDisplay.getPathImage());
			sb.append("/shopping/item?img_id=");
			sb.append(item.getItemId());
			sb.append("&small=1");
		}

		sb.append("\">");
	}
	else {
		sb.append("<span style=\"font-size: xx-small;\">");
		sb.append(item.getSku());
		sb.append("</span>");
	}

	row.addText(sb.toString(), rowURL);

	// Description

	sb = new StringBuffer();

	sb.append(item.getName());

	sb.append("<span style=\"font-size: xx-small;\">");

	if (Validator.isNotNull(item.getDescription())) {
		sb.append("<br>");
		sb.append(item.getDescription());
	}

	/*Properties props = new OrderedProperties();

	PropertiesUtil.load(props, item.getProperties());

	Enumeration enu = props.propertyNames();

	while (enu.hasMoreElements()) {
		String propsKey = (String)enu.nextElement();
		String propsValue = props.getProperty(propsKey, StringPool.BLANK);

		sb.append("<br>");
		sb.append(propsKey);
		sb.append(": ");
		sb.append(propsValue);
	}*/

	if (PrefsPropsUtil.getBoolean(company.getCompanyId(), PropsUtil.SHOPPING_ITEM_SHOW_AVAILABILITY)) {
		sb.append("<br><br>");

		if (ShoppingUtil.isInStock(item, itemFields, fieldsArray)) {
			sb.append(LanguageUtil.get(pageContext, "availability"));
			sb.append(": ");
			sb.append("<span class=\"portlet-msg-success\">");
			sb.append(LanguageUtil.get(pageContext, "in-stock"));
			sb.append("</span>");
		}
		else {
			sb.append(LanguageUtil.get(pageContext, "availability"));
			sb.append(": ");
			sb.append("<span class=\"portlet-msg-error\">");
			sb.append(LanguageUtil.get(pageContext, "out-of-stock"));
			sb.append("</span>");

			sb.append("<script type=\"text/javascript\">");
			sb.append("itemsInStock = false;");
			sb.append("</script>");
		}
	}

	if (fieldsArray.length > 0) {
		sb.append("<br>");
	}

	for (int j = 0; j < fieldsArray.length; j++) {
		int pos = fieldsArray[j].indexOf("=");

		String fieldName = fieldsArray[j].substring(0, pos);
		String fieldValue = fieldsArray[j].substring(pos + 1, fieldsArray[j].length());

		sb.append("<br>");
		sb.append(fieldName);
		sb.append(": ");
		sb.append(fieldValue);
	}

	if (itemPrices.length > 0) {
		sb.append("<br>");
	}

	for (int j = 0; j < itemPrices.length; j++) {
		ShoppingItemPrice itemPrice = itemPrices[j];

		sb.append("<br>");

		if ((itemPrice.getMinQuantity() == 0) && (itemPrice.getMaxQuantity() == 0)) {
			sb.append(LanguageUtil.get(pageContext, "price"));
			sb.append(": ");
		}
		else if (itemPrice.getMaxQuantity() != 0) {
			sb.append(LanguageUtil.format(pageContext, "price-for-x-to-x-items", new Object[] {"<b>" + new Integer(itemPrice.getMinQuantity()) + "</b>", "<b>" + new Integer(itemPrice.getMaxQuantity()) + "</b>"}, false));
		}
		else if (itemPrice.getMaxQuantity() == 0) {
			sb.append(LanguageUtil.format(pageContext, "price-for-x-items-and-above", "<b>" + new Integer(itemPrice.getMinQuantity()) + "</b>", false));
		}

		if (itemPrice.getDiscount() <= 0) {
			sb.append(currency.getSymbol());
			sb.append(doubleFormat.format(itemPrice.getPrice()));
		}
		else {
			sb.append(currency.getSymbol());
			sb.append("<strike>");
			sb.append(doubleFormat.format(itemPrice.getPrice()));
			sb.append("</strike> ");
			sb.append("<span class=\"portlet-msg-success\">");
			sb.append(currency.getSymbol());
			sb.append(doubleFormat.format(ShoppingUtil.calculateActualPrice(itemPrice)));
			sb.append("</span> / ");
			sb.append(LanguageUtil.get(pageContext, "you-save"));
			sb.append(": ");
			sb.append("<span class=\"portlet-msg-error\">");
			sb.append(currency.getSymbol());
			sb.append(doubleFormat.format(ShoppingUtil.calculateDiscountPrice(itemPrice)));
			sb.append(" (");
			sb.append(percentFormat.format(itemPrice.getDiscount()));
			sb.append(")");
			sb.append("</span>");
		}
	}

	sb.append("</span>");

	row.addText(sb.toString(), rowURL);

	// Quantity

	sb = new StringBuffer();

	if (minQuantityMultiple && (item.getMinQuantity() > 0)) {
		sb.append("<select name=\"");
		sb.append(renderResponse.getNamespace());
		sb.append("item_");
		sb.append(item.getItemId());
		sb.append("_");
		sb.append(i);
		sb.append("_count\">");

		sb.append("<option value=\"0\">0</option>");

		for (int j = 1; j <= 10; j++) {
			int curQuantity = item.getMinQuantity() * j;

			sb.append("<option ");

			if (curQuantity == count.intValue()) {
				sb.append("selected ");
			}

			sb.append("value=\"");
			sb.append(curQuantity);
			sb.append("\">");
			sb.append(curQuantity);
			sb.append("</option>");
		}

		sb.append("</select>");
	}
	else {
		sb.append("<input class=\"form-text\" name=\"");
		sb.append(renderResponse.getNamespace());
		sb.append("item_");
		sb.append(item.getItemId());
		sb.append("_");
		sb.append(i);
		sb.append("_count\" size=\"2\" type=\"text\" value=\"");
		sb.append(count);
		sb.append("\">");
	}

	row.addText(sb.toString());

	// Price

	row.addText(currency.getSymbol() + doubleFormat.format(ShoppingUtil.calculateActualPrice(item, count.intValue()) / count.intValue()), rowURL);

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

		<%
		double subtotal = ShoppingUtil.calculateSubtotal(items);
		double actualSubtotal = ShoppingUtil.calculateActualSubtotal(items);
		double discountSubtotal = ShoppingUtil.calculateDiscountSubtotal(items);
		%>

		<c:if test="<%= subtotal == actualSubtotal %>">
			<%= currency.getSymbol() %><%= doubleFormat.format(subtotal) %>
		</c:if>

		<c:if test="<%= subtotal != actualSubtotal %>">
			<strike><%= currency.getSymbol() %><%= doubleFormat.format(subtotal) %></strike> <span class="portlet-msg-success"><%= currency.getSymbol() %><%= doubleFormat.format(actualSubtotal) %></span>
		</c:if>
	</td>
</tr>

<c:if test="<%= subtotal != actualSubtotal %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "you-save") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<span class="portlet-msg-error">
			<%= currency.getSymbol() %><%= doubleFormat.format(discountSubtotal) %> (<%= percentFormat.format(ShoppingUtil.calculateDiscountPercent(items)) %>)
			</span>
		</td>
	</tr>
</c:if>

<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "shipping") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<c:choose>
			<c:when test="<%= !shoppingPrefs.useAlternativeShipping() %>">
				<%= currency.getSymbol() %><%= doubleFormat.format(ShoppingUtil.calculateShipping(items)) %>
			</c:when>
			<c:otherwise>
				<select name="<portlet:namespace />alternativeShipping">

					<%
					String[][] alternativeShipping = shoppingPrefs.getAlternativeShipping();

					for (int i = 0; i < 10; i++) {
						String altShippingName = alternativeShipping[0][i];
						String altShippingDelta = alternativeShipping[1][i];

						if (Validator.isNotNull(altShippingName) && Validator.isNotNull(altShippingDelta)) {
					%>

							<option <%= i == cart.getAltShipping() ? "selected" : "" %> value="<%= i %>"><%= altShippingName %> (<%= currency.getSymbol() %><%= doubleFormat.format(ShoppingUtil.calculateAlternativeShipping(items, i)) %>)</option>

					<%
						}
					}
					%>

				</select>
			</c:otherwise>
		</c:choose>
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>

<%
double insurance = ShoppingUtil.calculateInsurance(items);
%>

<c:if test="<%= insurance > 0 %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "insurance") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<select name="<portlet:namespace />insure">
				<option <%= !cart.isInsure() ? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "none") %></option>
				<option <%= cart.isInsure() ? "selected" : "" %> value="1"><%= currency.getSymbol() %><%= doubleFormat.format(insurance) %></option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			<br>
		</td>
	</tr>
</c:if>

<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "coupon-code") %>:
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />couponIds" size="30" style="text-transform: uppercase;" type="text" value="<%= cart.getCouponIds() %>">

		<c:if test="<%= coupon != null %>">
			<a href="javascript: var viewCouponWindow = window.open('<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/shopping/view_coupon" /><portlet:param name="couponId" value="<%= coupon.getCouponId() %>" /></portlet:renderURL>', 'viewCoupon', 'directories=no,height=200,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no,width=280'); void(''); viewCouponWindow.focus();" style="font-size: xx-small;">(<%= LanguageUtil.get(pageContext, "description") %>)</a>
		</c:if>
	</td>
</tr>

<c:if test="<%= coupon != null %>">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "coupon-discount") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<span class="portlet-msg-error">
			<%= currency.getSymbol() %><%= doubleFormat.format(ShoppingUtil.calculateCouponDiscount(items, coupon)) %>
			</span>
		</td>
	</tr>
</c:if>

</table>

<br>

<%
String[] ccTypes = shoppingPrefs.getCcTypes();

if (shoppingPrefs.usePayPal()) {
%>

	<img src="<%= themeDisplay.getPathThemeImage() %>/shopping/cc_paypal.gif">

	<br><br>

<%
}
else if (!shoppingPrefs.usePayPal() && (ccTypes.length > 0)) {
	for (int i = 0; i < ccTypes.length; i++) {
%>

		<img src="<%= themeDisplay.getPathThemeImage() %>/shopping/cc_<%= ccTypes[i] %>.gif">

<%
	}
%>

	<br><br>

<%
}
%>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "update-cart") %>' onClick="<portlet:namespace />updateCart();">

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "empty-cart") %>' onClick="<portlet:namespace />emptyCart();">

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "checkout") %>' onClick="<portlet:namespace />checkout();">

</form>
