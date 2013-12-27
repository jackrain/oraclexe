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

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/shopping/view");
portletURL.setParameter("tabs1", tabs1);
%>

<script type="text/javascript">
	function <portlet:namespace />deleteCoupons() {
		if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-coupons") %>')) {
			document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= Constants.DELETE %>";
			document.<portlet:namespace />fm.<portlet:namespace />deleteCouponIds.value = listCheckedExcept(document.<portlet:namespace />fm, "<portlet:namespace />allRowIds");
			submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/edit_coupon" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:actionURL>");
		}
	}
</script>

<form action="<%= portletURL.toString() %>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />deleteCouponIds" type="hidden" value="">

<%
CouponSearch searchContainer = new CouponSearch(renderRequest, portletURL);

List headerNames = searchContainer.getHeaderNames();

headerNames.add(StringPool.BLANK);

searchContainer.setRowChecker(new RowChecker(renderResponse));
%>

<liferay-ui:search-form
	page="/html/portlet/shopping/coupon_search.jsp"
	searchContainer="<%= searchContainer %>"
/>

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">

	<%
	CouponSearchTerms searchTerms = (CouponSearchTerms)searchContainer.getSearchTerms();

	int total = ShoppingCouponLocalServiceUtil.searchCount(searchTerms.getCouponId(), portletGroupId, company.getCompanyId(), searchTerms.isActive(), searchTerms.getDiscountType(), searchTerms.isAndOperator());

	searchContainer.setTotal(total);

	List results = ShoppingCouponServiceUtil.search(searchTerms.getCouponId(), plid, company.getCompanyId(), searchTerms.isActive(), searchTerms.getDiscountType(), searchTerms.isAndOperator(), searchContainer.getStart(), searchContainer.getEnd());

	searchContainer.setResults(results);
	%>

	<br><div class="beta-separator"></div><br>

	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "add") %>' onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/shopping/edit_coupon" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>';">

	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "delete") %>' onClick="<portlet:namespace />deleteCoupons();">

	<br><br>

	<%
	List resultRows = searchContainer.getResultRows();

	for (int i = 0; i < results.size(); i++) {
		ShoppingCoupon coupon = (ShoppingCoupon)results.get(i);

		ResultRow row = new ResultRow(coupon, coupon.getCouponId(), i);

		PortletURL rowURL = renderResponse.createRenderURL();

		rowURL.setWindowState(WindowState.MAXIMIZED);

		rowURL.setParameter("struts_action", "/shopping/edit_coupon");
		rowURL.setParameter("redirect", currentURL);
		rowURL.setParameter("couponId", coupon.getCouponId());

		// Coupon id

		row.addText(coupon.getCouponId(), rowURL);

		// Name and description

		StringBuffer sb = new StringBuffer();

		sb.append(coupon.getName());

		if (Validator.isNotNull(coupon.getDescription())) {
			sb.append("<br>");
			sb.append("<span style=\"font-size: xx-small;\">");
			sb.append(coupon.getDescription());
			sb.append("</span>");
		}

		row.addText(sb.toString(), rowURL);

		// Start date

		row.addText(dateFormatDateTime.format(coupon.getStartDate()), rowURL);

		// End date

		if (coupon.getEndDate() == null) {
			row.addText(LanguageUtil.get(pageContext, "never"), rowURL);
		}
		else {
			row.addText(dateFormatDateTime.format(coupon.getEndDate()), rowURL);
		}

		// Discount type

		row.addText(LanguageUtil.get(pageContext, coupon.getDiscountType()), rowURL);

		// Action

		row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/shopping/coupon_action.jsp");

		// Add result row

		resultRows.add(row);
	}
	%>

	<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

	<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
</c:if>

</form>
