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
ShoppingItem item = (ShoppingItem)request.getAttribute(WebKeys.SHOPPING_ITEM);

ShoppingItemField[] itemFields = (ShoppingItemField[])ShoppingItemFieldLocalServiceUtil.getItemFields(item.getItemId()).toArray(new ShoppingItemField[0]);
ShoppingItemPrice[] itemPrices = (ShoppingItemPrice[])ShoppingItemPriceLocalServiceUtil.getItemPrices(item.getItemId()).toArray(new ShoppingItemPrice[0]);

String orderByCol = prefs.getValue(PortletKeys.SHOPPING, "items-order-by-col", "sku");
String orderByType = prefs.getValue(PortletKeys.SHOPPING, "items-order-by-type", "asc");

OrderByComparator orderByComparator = ShoppingUtil.getItemOrderByComparator(orderByCol, orderByType);

ShoppingItem[] prevAndNext = ShoppingItemLocalServiceUtil.getItemsPrevAndNext(item.getItemId(), orderByComparator);
%>

<script type="text/javascript">
	function <portlet:namespace />addToCart() {
		document.<portlet:namespace />fm.<portlet:namespace />fields.value = "";

		<%
		for (int i = 0; i < itemFields.length; i++) {
			ShoppingItemField itemField = itemFields[i];

			String fieldName = itemField.getName();
			String[] fieldValues = itemField.getValuesArray();
		%>

			if (document.<portlet:namespace />fm.<portlet:namespace />fieldName<%= fieldName %>.value == "") {
				alert("<%= UnicodeLanguageUtil.get(pageContext, "please-select-all-options") %>");

				return;
			}

			document.<portlet:namespace />fm.<portlet:namespace />fields.value = document.<portlet:namespace />fm.<portlet:namespace />fields.value + '<%= fieldName %>=' + document.<portlet:namespace />fm.<portlet:namespace />fieldName<%= fieldName %>.value + '&';

		<%
		}
		%>

		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/cart" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.ADD %>">
<input name="<portlet:namespace />redirect" type="hidden" value="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/cart" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>">
<input name="<portlet:namespace />itemId" type="hidden" value="<%= item.getItemId() %>">
<input name="<portlet:namespace />fields" type="hidden" value="">

<liferay-util:include page="/html/portlet/shopping/tabs1.jsp">
	<liferay-util:param name="tabs1" value="categories" />
</liferay-util:include>

<%= ShoppingUtil.getBreadcrumbs(item.getCategoryId(), pageContext, renderRequest, renderResponse) %>

<br><br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td valign="top">
		<b><%= item.getSku() %></b>

		<br><br>

		<c:if test="<%= item.isMediumImage() %>">
			<img src="<%= Validator.isNotNull(item.getMediumImageURL()) ? item.getMediumImageURL() : themeDisplay.getPathImage() + "/shopping/item?img_id=" + item.getItemId() + "&medium=1" %>" vspace="0">
		</c:if>

		<c:if test="<%= item.isLargeImage() %>">
			<br>

			<a href="<%= Validator.isNotNull(item.getLargeImageURL()) ? item.getLargeImageURL() : themeDisplay.getPathImage() + "/shopping/item?img_id=" + item.getItemId() + "&large=1" %>" style="font-size: xx-small;" target="_blank">
			<%= LanguageUtil.get(pageContext, "see-large-photo") %>
			</a>
		</c:if>
	</td>
	<td style="padding-left: 30px;"></td>
	<td valign="top">
		<span style="font-size: small;">
		<b><%= item.getName() %></b><br>
		</span>

		<c:if test="<%= Validator.isNotNull(item.getDescription()) %>">
			<br>

			<%= item.getDescription() %>
		</c:if>

		<%
		Properties props = new OrderedProperties();

		//props.load(new ByteArrayInputStream(item.getProperties().getBytes("ISO-8859-1")));
		PropertiesUtil.load(props, item.getProperties());

		Enumeration enu = props.propertyNames();

		while (enu.hasMoreElements()) {
			String propsKey = (String)enu.nextElement();
			String propsValue = props.getProperty(propsKey, StringPool.BLANK);
		%>

			<br>

			<%= propsKey %>: <%= propsValue %>

		<%
		}
		%>

		<br><br>

		<%
		for (int i = 0; i < itemPrices.length; i++) {
			ShoppingItemPrice itemPrice = itemPrices[i];
		%>

			<c:choose>
				<c:when test="<%= (itemPrice.getMinQuantity()) == 0 && (itemPrice.getMaxQuantity() == 0) %>">
					<%= LanguageUtil.get(pageContext, "price") %>:
				</c:when>
				<c:when test="<%= itemPrice.getMaxQuantity() != 0 %>">
					<%= LanguageUtil.format(pageContext, "price-for-x-to-x-items", new Object[] {"<b>" + new Integer(itemPrice.getMinQuantity()) + "</b>", "<b>" + new Integer(itemPrice.getMaxQuantity()) + "</b>"}, false) %>
				</c:when>
				<c:when test="<%= itemPrice.getMaxQuantity() == 0 %>">
					<%= LanguageUtil.format(pageContext, "price-for-x-items-and-above", "<b>" + new Integer(itemPrice.getMinQuantity()) + "</b>", false) %>
				</c:when>
			</c:choose>

			<c:if test="<%= itemPrice.getDiscount() <= 0 %>">
				<%= currency.getSymbol() %><%= doubleFormat.format(itemPrice.getPrice()) %><br>
			</c:if>

			<c:if test="<%= itemPrice.getDiscount() > 0 %>">
				<%= currency.getSymbol() %><strike><%= doubleFormat.format(itemPrice.getPrice()) %></strike> <span class="portlet-msg-success"><%= currency.getSymbol() %><%= doubleFormat.format(ShoppingUtil.calculateActualPrice(itemPrice)) %></span> / <%= LanguageUtil.get(pageContext, "you-save") %>: <span class="portlet-msg-error"><%= currency.getSymbol() %><%= doubleFormat.format(ShoppingUtil.calculateDiscountPrice(itemPrice)) %> (<%= percentFormat.format(itemPrice.getDiscount()) %>)</span><br>
			</c:if>

		<%
		}
		%>

		<br>

		<c:if test="<%= PrefsPropsUtil.getBoolean(company.getCompanyId(), PropsUtil.SHOPPING_ITEM_SHOW_AVAILABILITY) %>">
			<c:choose>
				<c:when test="<%= ShoppingUtil.isInStock(item) %>">
					<%= LanguageUtil.get(pageContext, "availability") %>: <span class="portlet-msg-success"><%= LanguageUtil.get(pageContext, "in-stock") %></span><br>
				</c:when>
				<c:otherwise>
					<%= LanguageUtil.get(pageContext, "availability") %>: <span class="portlet-msg-error"><%= LanguageUtil.get(pageContext, "out-of-stock") %></span><br>
				</c:otherwise>
			</c:choose>

			<br>
		</c:if>

		<%
		for (int i = 0; i < itemFields.length; i++) {
			ShoppingItemField itemField = itemFields[i];

			String fieldName = itemField.getName();
			String[] fieldValues = itemField.getValuesArray();
			String fieldDescription = itemField.getDescription();
		%>

			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<%= fieldName %>:
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<select name="<portlet:namespace />fieldName<%= fieldName %>">
						<option value=""><%= LanguageUtil.get(pageContext, "select-option") %></option>

						<%
						for (int j = 0; j < fieldValues.length; j++) {
						%>

							<option value="<%= fieldValues[j] %>"><%= fieldValues[j] %></option>

						<%
						}
						%>

					</select>
				</td>

				<c:if test="<%= Validator.isNotNull(fieldDescription) %>">
					<td style="padding-left: 10px;"></td>
					<td>
						<%= fieldDescription %>
					</td>
				</c:if>

			</tr>
			</table>

			<br>

		<%
		}
		%>

		<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add-to-shopping-cart") %>' onClick="<portlet:namespace />addToCart();"><br>

		<c:if test="<%= (prevAndNext[0] != null) || (prevAndNext[2] != null) %>">
			<br>

			<c:if test="<%= prevAndNext[0] != null %>">
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "previous") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/view_item" /><portlet:param name="itemId" value="<%= prevAndNext[0].getItemId() %>" /></portlet:renderURL>';">
			</c:if>

			<c:if test="<%= prevAndNext[2] != null %>">
				<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "next") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/view_item" /><portlet:param name="itemId" value="<%= prevAndNext[2].getItemId() %>" /></portlet:renderURL>';">
			</c:if>
		</c:if>
	</td>
</tr>
</table>

</form>
