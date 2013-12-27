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

<%@ include file="/html/portlet/google_gadget/init.jsp" %>

<liferay-portlet:preview
	portletName="<%= portletResource %>"
	queryString="struts_action=/google_gadget/view"
/>

<br><div class="beta-separator"></div><br>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td valign="top">
		<input <%= (!customConf) ? "checked" : "" %> type="radio" name="<portlet:namespace />confType" value="recommended"> <%= LanguageUtil.get(pageContext, "choose-from-the-list-of-recommended-google-gadgets") %>

		<br>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "gadget") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select id="<portlet:namespace />gadgetId" name="<portlet:namespace />gadgetId">

					<%
					for (int i = 0; i < gadgets.length; i++) {
					%>

						<option <%= (gadgetIdPos == i) ? "selected" : "" %> value="<%= gadgets[i][0] %>"><%= gadgets[i][1] %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "title") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input class="form-text" name="<portlet:namespace />title" type="text" value="<%= title %>">
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "width") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input class="form-text" name="<portlet:namespace />width" size="4" type="text" value="<%= width %>"> px
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "height") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input class="form-text" name="<portlet:namespace />height" size="4" type="text" value="<%= height %>"> px
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "border") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select name="<portlet:namespace />borderId">

					<%
					for (int i = 0; i < borders.length; i++) {
					%>

						<option <%= (borderIdPos == i) ? "selected" : "" %> value="<%= borders[i][0] %>"><%= borders[i][1] %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
		</table>
	</td>
	<td style="padding-left: 30px;"></td>
	<td valign="top">
		<input <%= (customConf) ? "checked" : "" %> type="radio" name="<portlet:namespace />confType" value="custom">

		<a href="http://www.google.com/ig/directory?synd=open" target="GoogleGadgets"><%= LanguageUtil.get(pageContext, "or-obtain-the-google-gadget-code-directly-and-paste-it-below") %></a>

		<br>

		<textarea class="form-text" rows="5" cols="50" name="<portlet:namespace />gadgetCode"><%= gadgetCode %></textarea>
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">

</form>

<script type="text/javascript">
	function <portlet:namespace />enableSelectedTypeForm() {
		var state1;
		var state2;

		if (document.<portlet:namespace />fm.<portlet:namespace />confType[0].checked) {
			state1 = false;
			state2 = true;
		}

		if (document.<portlet:namespace />fm.<portlet:namespace />confType[1].checked) {
			state1 = true;
			state2 = false;
		}

		document.<portlet:namespace />fm.<portlet:namespace />gadgetCode.disabled = state2;

		document.<portlet:namespace />fm.<portlet:namespace />gadgetId.disabled = state1;
		document.<portlet:namespace />fm.<portlet:namespace />title.disabled = state1;
		document.<portlet:namespace />fm.<portlet:namespace />width.disabled = state1;
		document.<portlet:namespace />fm.<portlet:namespace />height.disabled = state1;
		document.<portlet:namespace />fm.<portlet:namespace />borderId.disabled = state1;
	}

	function <portlet:namespace />setRecommendedGadgetSize() {
		var widthMatrix = new Array();

		<%
		for (int i = 0; i < gadgets.length; i++) {
		%>

			widthMatrix[<%=i%>] = "<%= gadgets[i][2] %>";

		<%
		}
		%>

		var heightMatrix = new Array();

		<%
		for (int i = 0; i < gadgets.length; i++) {
		%>

			heightMatrix[<%=i%>] = "<%= gadgets[i][3] %>";

		<%
		}
		%>

		var index = document.<portlet:namespace />fm.<portlet:namespace />gadgetId.selectedIndex;

		document.<portlet:namespace />fm.<portlet:namespace />width.value = widthMatrix[index];
		document.<portlet:namespace />fm.<portlet:namespace />height.value = heightMatrix[index];
	}

	document.<portlet:namespace />fm.<portlet:namespace />gadgetId.focus();
	document.<portlet:namespace />fm.<portlet:namespace />gadgetId.onchange = <portlet:namespace />setRecommendedGadgetSize;
	document.<portlet:namespace />fm.<portlet:namespace />confType[0].onclick = <portlet:namespace />enableSelectedTypeForm;
	document.<portlet:namespace />fm.<portlet:namespace />confType[1].onclick = <portlet:namespace />enableSelectedTypeForm;

	<portlet:namespace />enableSelectedTypeForm();
</script>
