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

<%@ include file="/html/taglib/ui/tabs/init.jsp" %>

<%

// URL

String url = GetterUtil.getString((String)request.getAttribute("liferay-ui:tabs:url"));

// Strip existing tab parameter and value from the URL

int x = url.indexOf(param + "=");

if (x != -1) {
	x = url.lastIndexOf("&", x);

	if (x == -1) {
		x = url.lastIndexOf("?", x);
	}

	int y = url.indexOf("&", x + 1);

	if (y == -1) {
		y = url.length();
	}

	url = url.substring(0, x) + url.substring(y, url.length());
}

// Strip training &

if (url.endsWith("&")) {
	url = url.substring(0, url.length() - 1);
}

// Strip anchor

String anchor = StringPool.BLANK;

x = url.indexOf("&#");

if (x != -1) {
	anchor = url.substring(x, url.length());
	url = url.substring(0, x);
}

// Back url

String backURL = (String)request.getAttribute("liferay-ui:tabs:backURL");

// Refresh

boolean refresh = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:tabs:refresh"));
%>

<c:if test="<%= names.length > 0 %>">
	<input name="<%= namespace %><%= param %>TabsScroll" type="hidden">

	<ul class="gamma-tab">

		<%
		for (int i = 0; i < values.length; i++) {
			String curURL = (String)request.getAttribute("liferay-ui:tabs:url" + i);

			if (Validator.isNull(curURL)) {
				if (refresh) {
					curURL = url + "&" + param + "=" + values[i] + anchor;
				}
				else {
					curURL = "javascript: Tabs.show('" + namespace + param + "', " + namesJS + ", '" + names[i] + "');";
				}
			}
		%>

			<li <%= (values.length == 1) || value.equals(values[i]) ? "class=\"current\"" : "" %> id="<%= namespace %><%= param %><%= values[i] %>TabsId">
				<c:if test="<%= values.length > 1 %>">
					<a href="<%= curURL %>">
				</c:if>

				<%= LanguageUtil.get(pageContext, names[i]) %>

				<c:if test="<%= values.length > 1 %>">
					</a>
				</c:if>
			</li>

		<%
		}
		%>

		<c:if test="<%= Validator.isNotNull(backURL) %>">
			<li class="toggle">
				&laquo; <a href="<%= backURL %>"><%= LanguageUtil.get(pageContext, "back") %></a>
			</li>
		</c:if>
	</ul>
</c:if>
