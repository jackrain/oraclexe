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

<%@ include file="/html/portlet/csz_search/init.jsp" %>

<%
String street = ParamUtil.getString(request, "street");
String csz = ParamUtil.getString(request, "csz");
%>

<form action="<portlet:renderURL><portlet:param name="struts_action" value="/csz_search/view" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">

<%= LanguageUtil.get(pageContext, "street-address") %> <i>(<%= LanguageUtil.get(pageContext, "optional") %>)</i><br>

<input class="form-text" name="<portlet:namespace />street" size="30" type="text" value="<%= street %>">

<br><br>

<%= LanguageUtil.get(pageContext, "city-state-or-zip") %><br>

<input class="form-text" name="<portlet:namespace />csz" size="30" type="text" value="<%= csz %>">

<br><br>

<select name="<portlet:namespace />country">
	<option value="USA">USA</option>
</select>

<br><br>

<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">

<c:choose>
	<c:when test="<%= Validator.isNotNull(street) %>">
		<br><br>

		<%
		List list = CSZUtil.getCSZAddressByCityAndState(csz);
		%>

		<c:choose>
			<c:when test="<%= (list == null) %>">
				<span class="portlet-msg-error">
				<%= LanguageUtil.get(pageContext, "an-unexpected-database-error-occurred-while-querying-the-given-street-city-and-state") %>
				</span>
			</c:when>
			<c:when test="<%= (list != null) && (list.size() == 0) %>">
				<%= LanguageUtil.get(pageContext, "no-zip-code-was-found-associated-with-the-given-street-city-and-state") %>
			</c:when>
			<c:otherwise>
				<%= LanguageUtil.get(pageContext, "the-following-zip-code-was-found-associated-with-the-given-street-city-and-state") %>

				<br><br>

				<%
				for (int i = 0; i < list.size(); i++) {
					CSZAddress cszAddress = (CSZAddress)list.get(i);
				%>

					<%= cszAddress.getZip() %><br>

				<%
				}
				%>

			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test="<%= Validator.isNotNull(csz) %>">
		<c:choose>
			<c:when test="<%= Validator.isNumber(csz) %>">
				<br><br>

				<%
				List list = CSZUtil.getCSZAddressByZip(csz);
				%>

				<c:choose>
					<c:when test="<%= (list == null) %>">
						<span class="portlet-msg-error">
						<%= LanguageUtil.get(pageContext, "an-unexpected-database-error-occurred-while-querying-the-given-zip") %>
						</span>
					</c:when>
					<c:when test="<%= (list != null) && (list.size() == 0) %>">
						<%= LanguageUtil.get(pageContext, "no-city-and-state-pairs-were-found-associated-with-the-given-zip") %>
					</c:when>
					<c:otherwise>
						<%= LanguageUtil.get(pageContext, "the-following-city-and-state-pairs-were-found-associated-with-the-given-zip") %>

						<br><br>

						<%
						for (int i = 0; i < list.size(); i++) {
							CSZAddress cszAddress = (CSZAddress)list.get(i);
						%>

							<%= cszAddress.getCity() %>, <%= cszAddress.getState() %><br>

						<%
						}
						%>

					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<br><br>

				<%
				List list = CSZUtil.getCSZAddressByCityAndState(csz);
				%>

				<c:choose>
					<c:when test="<%= (list == null) %>">
						<span class="portlet-msg-error">
						<%= LanguageUtil.get(pageContext, "an-unexpected-database-error-occurred-while-querying-the-given-city-and-state") %>
						</span>
					</c:when>
					<c:when test="<%= (list != null) && (list.size() == 0) %>">
						<%= LanguageUtil.get(pageContext, "no-zip-codes-were-found-associated-with-the-given-city-and-state") %>
					</c:when>
					<c:otherwise>
						<%= LanguageUtil.get(pageContext, "the-following-zip-codes-were-found-associated-with-the-given-city-and-state") %>

						<br><br>

						<%
						for (int i = 0; i < list.size(); i++) {
							CSZAddress cszAddress = (CSZAddress)list.get(i);
						%>

							<%= cszAddress.getZip() %><br>

						<%
						}
						%>

					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</c:when>
</c:choose>

</form>

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		document.<portlet:namespace />fm.<portlet:namespace />street.focus();
	</script>
</c:if>
