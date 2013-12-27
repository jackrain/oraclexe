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

<%@ include file="/html/portlet/google/init.jsp" %>

<%
String args = ParamUtil.getString(request, "args");
String suggestion = (String)request.getAttribute(WebKeys.GOOGLE_SPELLING_SUGGESTION);
%>

<form method="post" name="<portlet:namespace />fm"
	onSubmit="
		if (document.<portlet:namespace />fm.<portlet:namespace />directive.selectedIndex == 0) {
			submitForm(this, '<portlet:renderURL><portlet:param name="struts_action" value="/google/search" /></portlet:renderURL>');
		}
		else {
			submitForm(this, '<portlet:renderURL><portlet:param name="struts_action" value="/google/spell" /></portlet:renderURL>');
		}

		return false;"
>

<input class="form-text" name="<portlet:namespace />args" size="30" type="text" value="<%= args %>">

<select name="<portlet:namespace />directive">
	<option value="search"><%= LanguageUtil.get(pageContext, "search") %></option>
	<option selected value="spell"><%= LanguageUtil.get(pageContext, "spell") %></option>
</select>

<input align="absmiddle" border="0" src="<%= themeDisplay.getPathThemeImage() %>/common/search.gif" title="<%= LanguageUtil.get(pageContext, "search") %>" type="image">

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />args.focus();
</script>

<br>

<%= LanguageUtil.format(pageContext, "googles-spelling-suggestion-for", new Object[] {"<i>" + args + "</i>", "<b>" + suggestion + "</b>"}, false) %>
