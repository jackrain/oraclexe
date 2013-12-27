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

ShoppingCoupon coupon = (ShoppingCoupon)request.getAttribute(WebKeys.SHOPPING_COUPON);

String couponId = BeanParamUtil.getString(coupon, request, "couponId");
String newCouponId = ParamUtil.getString(request, "newCouponId");

Calendar startDate = new GregorianCalendar(timeZone, locale);

if (coupon != null) {
	if (coupon.getStartDate() != null) {
		startDate.setTime(coupon.getStartDate());
	}
}

boolean neverExpire = ParamUtil.getBoolean(request, "neverExpire", true);

Calendar endDate = new GregorianCalendar(timeZone, locale);

endDate.add(Calendar.MONTH, 1);

if (coupon != null) {
	if (coupon.getEndDate() != null) {
		neverExpire = false;

		endDate.setTime(coupon.getEndDate());
	}
}

String limitCategories = BeanParamUtil.getString(coupon, request, "limitCategories");
String limitSkus = BeanParamUtil.getString(coupon, request, "limitSkus");
double minOrder = BeanParamUtil.getDouble(coupon, request, "minOrder");
double discount = BeanParamUtil.getDouble(coupon, request, "discount");
String discountType = BeanParamUtil.getString(coupon, request, "discountType");
%>

<script type="text/javascript">
	function <portlet:namespace />disableInputDate(date, checked) {
		eval("document.<portlet:namespace />fm.<portlet:namespace />" + date + "Month.disabled = " + checked + ";");
		eval("document.<portlet:namespace />fm.<portlet:namespace />" + date + "Day.disabled = " + checked + ";");
		eval("document.<portlet:namespace />fm.<portlet:namespace />" + date + "Year.disabled = " + checked + ";");
		eval("document.<portlet:namespace />fm.<portlet:namespace />" + date + "Hour.disabled = " + checked + ";");
		eval("document.<portlet:namespace />fm.<portlet:namespace />" + date + "Minute.disabled = " + checked + ";");
		eval("document.<portlet:namespace />fm.<portlet:namespace />" + date + "AmPm.disabled = " + checked + ";");
	}

	function <portlet:namespace />saveCoupon() {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= coupon == null ? Constants.ADD : Constants.UPDATE %>";

		<c:if test="<%= coupon == null %>">
			document.<portlet:namespace />fm.<portlet:namespace />couponId.value = document.<portlet:namespace />fm.<portlet:namespace />newCouponId.value;
		</c:if>

		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/edit_coupon" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />saveCoupon(); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= redirect %>">
<input name="<portlet:namespace />couponId" type="hidden" value="<%= couponId %>">

<liferay-util:include page="/html/portlet/shopping/tabs1.jsp">
	<liferay-util:param name="tabs1" value="coupons" />
</liferay-util:include>

<liferay-ui:error exception="<%= CouponDateException.class %>" message="please-enter-a-start-date-that-comes-before-the-expiration-date" />
<liferay-ui:error exception="<%= CouponDescriptionException.class %>" message="please-enter-a-valid-description" />
<liferay-ui:error exception="<%= CouponEndDateException.class %>" message="please-enter-a-valid-expiration-date" />
<liferay-ui:error exception="<%= CouponIdException.class %>" message="please-enter-a-valid-id" />
<liferay-ui:error exception="<%= CouponNameException.class %>" message="please-enter-a-valid-name" />
<liferay-ui:error exception="<%= CouponStartDateException.class %>" message="please-enter-a-valid-start-date" />
<liferay-ui:error exception="<%= DuplicateCouponIdException.class %>" message="please-enter-a-unique-id" />

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "id") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<c:choose>
					<c:when test="<%= coupon == null %>">
						<liferay-ui:input-field model="<%= ShoppingCoupon.class %>" bean="<%= coupon %>" field="couponId" fieldParam="newCouponId" defaultValue="<%= newCouponId %>" />
					</c:when>
					<c:otherwise>
						<%= couponId %>
					</c:otherwise>
				</c:choose>
			</td>
			<td style="padding-left: 30px;"></td>
			<td>
				<c:if test="<%= coupon == null %>">
					<liferay-ui:input-checkbox param="autoCouponId" />

					<%= LanguageUtil.get(pageContext, "autogenerate-id") %>
				</c:if>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "name") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= ShoppingCoupon.class %>" bean="<%= coupon %>" field="name" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "description") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= ShoppingCoupon.class %>" bean="<%= coupon %>" field="description" />
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "start-date") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= ShoppingCoupon.class %>" bean="<%= coupon %>" field="startDate" defaultValue="<%= startDate %>" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "expiration-date") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<liferay-ui:input-field model="<%= ShoppingCoupon.class %>" bean="<%= coupon %>" field="endDate" defaultValue="<%= endDate %>" disabled="<%= neverExpire %>" />
			</td>
			<td style="padding-left: 30px;"></td>
			<td>
				<liferay-ui:input-checkbox param="neverExpire" defaultValue="<%= neverExpire %>" onClick='<%= renderResponse.getNamespace() + "disableInputDate(\'endDate\', this.checked);" %>' />

				<%= LanguageUtil.get(pageContext, "never-expire") %>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "active") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-field model="<%= ShoppingCoupon.class %>" bean="<%= coupon %>" field="active" />
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="submit" value='<%= LanguageUtil.get(pageContext, "save") %>'>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">

<br><br>

<liferay-ui:tabs names="discount" />

<%= LanguageUtil.format(pageContext, "coupons-can-be-set-to-only-apply-to-orders-above-a-minimum-amount", currency.getSymbol() + doubleFormat.format(0), false) %>

<br><br>

<%= LanguageUtil.get(pageContext, "set-the-discount-amount-and-the-discount-type") %>

<br><br>

<%= LanguageUtil.get(pageContext, "if-the-discount-type-is-free-shipping,-then-shipping-charges-are-subtracted-from-the-order") %>

<br><br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "minimum-order") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />minOrder" size="4" type="text" value="<%= currency.getSymbol() %><%= doubleFormat.format(minOrder) %>">
	</td>
	<td style="padding-left: 30px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "discount") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />discount" size="4" type="text" value="<%= doubleFormat.format(discount) %>">
	</td>
	<td style="padding-left: 30px;"></td>
	<td>
		<%= LanguageUtil.get(pageContext, "discount-type") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<select name="<portlet:namespace />discountType">

			<%
			for (int i = 0; i < ShoppingCouponImpl.DISCOUNT_TYPES.length; i++) {
			%>

				<option <%= discountType.equals(ShoppingCouponImpl.DISCOUNT_TYPES[i]) ? "selected" : "" %> value="<%= ShoppingCouponImpl.DISCOUNT_TYPES[i] %>"><%= LanguageUtil.get(pageContext, ShoppingCouponImpl.DISCOUNT_TYPES[i]) %></option>

			<%
			}
			%>

		</select>
	</td>
</tr>
</table>

<br>

<liferay-ui:tabs names="limits" />

<liferay-ui:error exception="<%= CouponLimitCategoriesException.class %>">

	<%
	List categoryIds = (List)errorException;
	%>

	<%= LanguageUtil.get(pageContext, "the-following-are-invalid-category-ids") %> <%= StringUtil.merge((String[])categoryIds.toArray(new String[0])) %>
</liferay-ui:error>

<liferay-ui:error exception="<%= CouponLimitSKUsException.class %>">

	<%
	List skus = (List)errorException;
	%>

	<%= LanguageUtil.get(pageContext, "the-following-are-invalid-item-skus") %> <%= StringUtil.merge((String[])skus.toArray(new String[0])) %>
</liferay-ui:error>

<%= LanguageUtil.get(pageContext, "this-coupon-only-applies-to-items-that-are-children-of-this-comma-delimited-list-of-categories") %>

<%= LanguageUtil.get(pageContext, "leave-this-blank-if-the-coupon-does-not-check-for-the-parent-categories-of-an-item") %>

<br><br>

<liferay-ui:input-field model="<%= ShoppingCoupon.class %>" bean="<%= coupon %>" field="limitCategories" />

<br><br>

<%= LanguageUtil.get(pageContext, "this-coupon-only-applies-to-items-with-a-sku-that-corresponds-to-this-comma-delimited-list-of-item-skus") %>

<%= LanguageUtil.get(pageContext, "leave-this-blank-if-the-coupon-does-not-check-for-the-item-sku") %>

<br><br>

<liferay-ui:input-field model="<%= ShoppingCoupon.class %>" bean="<%= coupon %>" field="limitSkus" />

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace /><%= (coupon == null) ? "newCouponId" : "name" %>.focus();
</script>
