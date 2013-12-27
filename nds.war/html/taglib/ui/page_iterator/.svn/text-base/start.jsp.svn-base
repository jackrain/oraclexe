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

<%@ include file="/html/taglib/init.jsp" %>

<%
String formName = namespace + request.getAttribute("liferay-ui:page-iterator:formName");
String curParam = (String)request.getAttribute("liferay-ui:page-iterator:curParam");
int curValue = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:page-iterator:curValue"));
int delta = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:page-iterator:delta"));
String jsCall = (String)request.getAttribute("liferay-ui:page-iterator:jsCall");
int maxPages = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:page-iterator:maxPages"));
String target = (String)request.getAttribute("liferay-ui:page-iterator:target");
int total = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:page-iterator:total"));
String url = (String)request.getAttribute("liferay-ui:page-iterator:url");
String urlAnchor = (String)request.getAttribute("liferay-ui:page-iterator:urlAnchor");
int pages = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:page-iterator:pages"));
%>

<script type="text/javascript">
	function <%= namespace %>submitPageIterator() {
		var curValue = document.getElementById("<%= namespace %>page-iterator-value").value;

		if (<%= Validator.isNotNull(url) %>) {
			var href = "<%= url + curParam %>" + "=" + curValue + "<%= urlAnchor %>";

			self.location = href;
		}
		else {
			document.<%= formName %>.<%= curParam %>.value = curValue;

			<%= jsCall %>;
		}
	}
</script>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<span class="font-small" style="font-weight: bold;">

		<%= LanguageUtil.get(pageContext, "page") %>

		<input class="form-text" id="<%= namespace %>page-iterator-value" size="1" style="font-weight: italicized;" type="text" value="<%= curValue %>" onKeyPress="if (event.keyCode == 13) { <%= namespace %>submitPageIterator(); return false; }">

		<%= LanguageUtil.get(pageContext, "of") %>

		<%= pages %>

		<liferay-ui:icon image="submit" url='<%= "javascript: " + namespace + "submitPageIterator();" %>' />

		</span>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<span class="font-small">

		<c:if test="<%= curValue != 1 %>">
			<a href="<%= _getHREF(formName, curParam, 1, jsCall, url, urlAnchor) %>" target="<%= target %>">
		</c:if>

		<%= LanguageUtil.get(pageContext, "first") %>

		<c:if test="<%= curValue != 1 %>">
			</a>
		</c:if>

		&nbsp;|&nbsp;

		<c:if test="<%= curValue != 1 %>">
			<a href="<%= _getHREF(formName, curParam, curValue - 1, jsCall, url, urlAnchor) %>" target="<%= target %>">
		</c:if>

		<%= LanguageUtil.get(pageContext, "previous") %>

		<c:if test="<%= curValue != 1 %>">
			</a>
		</c:if>

		&nbsp;|&nbsp;

		<c:if test="<%= curValue != pages %>">
			<a href="<%= _getHREF(formName, curParam, curValue + 1, jsCall, url, urlAnchor) %>" target="<%= target %>">
		</c:if>

		<%= LanguageUtil.get(pageContext, "next") %>

		<c:if test="<%= curValue != pages %>">
			</a>
		</c:if>

		&nbsp;|&nbsp;

		<c:if test="<%= curValue != pages %>">
			<a href="<%= _getHREF(formName, curParam, pages, jsCall, url, urlAnchor) %>" target="<%= target %>">
		</c:if>

		<%= LanguageUtil.get(pageContext, "last") %>

		<c:if test="<%= curValue != pages %>">
			</a>
		</c:if>

		</span>
	</td>
</tr>
</table>

<%!
private String _getHREF(String formName, String curParam, int curValue, String jsCall, String url, String urlAnchor) throws Exception {
	String href = null;

	if (Validator.isNotNull(url)) {
		href = url + curParam + "=" + curValue + urlAnchor;
	}
	else {
		href = "javascript: document." + formName + "." + curParam + ".value = '" + curValue + "'; " + jsCall;
	}

	return href;
}
%>
