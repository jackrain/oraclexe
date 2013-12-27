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

<style type="text/css">
	.button {
		border-bottom: #E5E4E8 1px solid;
		border-left: #E5E4E8 1px solid;
		border-right: #E5E4E8 1px solid;
		border-top: #E5E4E8 1px solid;
	}

	.button-down {
		border-bottom: 1px solid buttonhighlight;
		border-left: 1px solid buttonshadow;
		border-right: 1px solid buttonhighlight;
		border-top: 1px solid buttonshadow;
	}

	.button-hover {
		border-bottom: 1px solid buttonshadow;
		border-left: 1px solid buttonhighlight;
		border-right: 1px solid buttonshadow;
		border-top: 1px solid buttonhighlight;
	}

	.separator {
		border-bottom: 1px solid buttonhighlight;
		border-left: 1px solid buttonshadow;
		border-right: 1px solid buttonhighlight;
		border-top: 1px solid buttonshadow;
		font-size: 12px;
		width: 2px;
	}
</style>

<script type="text/javascript">
	function <portlet:namespace />buttonDown(button) {
		button.className = "button-down";
	}

	function <portlet:namespace />buttonOut(button) {
		button.className = "button";
	}

	function <portlet:namespace />buttonOver(button) {
		button.className = "button-hover";
	}

	function <portlet:namespace />getHTML() {
		return document.getElementById("textArea").value;
	}

	function <portlet:namespace />setHTML(value) {
		document.getElementById("textArea").value = value;
	}

	function <portlet:namespace />initEditor() {
		<c:choose>
			<c:when test="<%= quote && Validator.isNull(body) && (curParentMessage != null) %>">
				var respondee = "<%= UnicodeFormatter.toString(parentAuthor) %>";
				var quote = "<%= UnicodeFormatter.toString(curParentMessage.getBody(false)) %>";

				<portlet:namespace />insertTag("quote", respondee, quote);
			</c:when>
			<c:otherwise>
				<portlet:namespace />setHTML("<%= UnicodeFormatter.toString(GetterUtil.getString(body)) %>");
			</c:otherwise>
		</c:choose>
	}

	function <portlet:namespace />insertColor() {
		var color = document.getElementById("fontColor").value;

		<portlet:namespace />insertTag("color", color);
	}

	function <portlet:namespace />insertEmail() {
		var addy = prompt("Enter an email address:", "");

		if (addy != null && addy != "") {
			var name = prompt("Enter a name associated with the email:", "");

			<portlet:namespace />resetSelection();

			if (name != null && name != "") {
				<portlet:namespace />insertTag("email", addy, name);
			}
			else {
				<portlet:namespace />insertTag("email", null, addy);
			}
		}
	}

	function <portlet:namespace />insertEmoticon(emoticon) {
		var field = document.getElementById("textArea");

		if (is_ie) {
			field.focus();

			var sel = document.selection.createRange();

			sel.text = emoticon;
		}
		else if (field.selectionStart || field.selectionStart == "0") {
			var startPos = field.selectionStart;
			var endPos = field.selectionEnd;

			var preSel = field.value.substring(0, startPos);
			var postSel = field.value.substring(endPos, field.value.length);

			field.value = preSel + emoticon + postSel;
		}
		else {
			field.value += emoticon;
		}
	}

	function <portlet:namespace />insertImage() {
		var url = prompt("Enter a address for a picture:", "http://");

		if (url != null && url != "") {
			<portlet:namespace />resetSelection();
			<portlet:namespace />insertTag('img', null, url);
		}
	}

	function <portlet:namespace />insertList(ordered) {
		var list = "\n";
		var entry;

		while (entry = prompt("Enter a list item.  Click 'cancel' or leave blank to end the list.", "")) {
			if (entry == null || entry == "") {
				break;
			}

			list += '[*]' + entry + '\n';
		}

		if (list != "\n") {
			<portlet:namespace />resetSelection();
			<portlet:namespace />insertTag("list", ordered, list);
		}
	}

	function <portlet:namespace />insertUrl() {
		var url = prompt("Enter a address:", "http://");

		if (url != null) {
			var title = prompt("Enter a title for the link:");

			if (title != null && title != "") {
				<portlet:namespace />resetSelection();
				<portlet:namespace />insertTag("url", url, title);
			}
			else {
				<portlet:namespace />insertTag("url", url);
			}
		}
	}

	function <portlet:namespace />insertTag(tag, param, content) {
		var begTag;

		if (param != null) {
			begTag = "[" + tag + "=" + param + "]";
		}
		else {
			begTag = "[" + tag + "]";
		}

		var endTag = "[/" + tag + "]";

		var field = document.getElementById("textArea");

		if (is_ie) {
			field.focus();

			var sel = document.selection.createRange();

			if (content != null) {
				sel.text = begTag + content + endTag;
			}
			else {
				sel.text = begTag + sel.text + endTag;
			}
		}
		else if (field.selectionStart || field.selectionStart == "0") {
			var startPos = field.selectionStart;
			var endPos = field.selectionEnd;

			var preSel = field.value.substring(0, startPos);
			var sel = field.value.substring(startPos, endPos);
			var postSel = field.value.substring(endPos, field.value.length);

			if (content != null) {
				field.value = preSel + begTag + content + endTag + postSel;
			}
			else {
				field.value = preSel + begTag + sel + endTag + postSel;
			}
		}
		else {
			field.value += begTag + content + endTag;
		}
	}

	function <portlet:namespace />resetSelection() {
		var field = document.getElementById("textArea");

		if (is_ie) {
			field.focus();

			var sel = document.selection.createRange();

			sel.collapse(false);
			sel.select();
		}
		else if (field.selectionStart) {
			field.selectionEnd = field.selectionStart;
		}
	}

	var colorPicker = new ColorPicker("<%= themeDisplay.getPathJavaScript() %>/colorpicker/colorscale.png", <portlet:namespace />insertColor);
</script>

<table border="0" cellpadding="0" cellspacing="0" height="400px" width="100%">
<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
		<tr>
			<td>
				<table bgcolor="#E5E4E8" cellpadding="1" cellspacing="0">
				<tr>
					<td>
					<select onChange="<portlet:namespace />insertTag('font', this[this.selectedIndex].value); this.selectedIndex = 0;">
						<option selected value="Font">Font</option>
						<option value="Arial">Arial</option>
						<option value="Comic Sans MS">Comic Sans MS</option>
						<option value="Courier New">Courier New</option>
						<option value="Tahoma">Tahoma</option>
						<option value="Times New Roman">Times New Roman</option>
						<option value="Verdana">Verdana</option>
						<option value="Wingdings">Wingdings</option>
					</select>
					</td>
					<td>
					<select onChange="<portlet:namespace />insertTag('size', this[this.selectedIndex].value); this.selectedIndex = 0;">
						<option selected value="Size">Size</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
					</select>
					</td>
					<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/spacer.gif" vspace="0" width="2"><span class="separator"></span><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/spacer.gif" vspace="0" width="2"></td>
					<td><div class="button" onClick="<portlet:namespace />insertTag('b');" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Bold" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/bold.gif" title="Bold" vspace="0" width="18"></div></td>
					<td><div class="button" onClick="<portlet:namespace />insertTag('i');" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Italics" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/italic.gif" title="Italics" vspace="0" width="18"></div></td>
					<td><div class="button" onClick="<portlet:namespace />insertTag('u');" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Underline" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/underline.gif" title="Underline" vspace="0" width="18"></div></td>
					<td><div class="button" onClick="<portlet:namespace />insertTag('s');" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Strikethrough" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/strike.gif" title="Strikethrough" vspace="0" width="18"></div></td>
					<td><div class="button" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><input type="hidden" id="fontColor" name="fontColor" value="" class="form-text" onchange=""><img align="absmiddle" alt="Color" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/color.gif" title="Color" vspace="0" width="18" style="cursor: pointer;" onClick="colorPicker.toggle(this)"></input></div></td>
					<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/spacer.gif" vspace="0" width="2"><span class="separator"></span><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/spacer.gif" vspace="0" width="2"></td>
					<td><div class="button" onClick="<portlet:namespace />insertUrl();" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Hyperlink" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/hyperlink.gif" title="Hyperlink" vspace="0" width="18"></div></td>
					<td><div class="button" onClick="<portlet:namespace />insertEmail();" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Email" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/email.gif" title="Email" vspace="0" width="18"></div></td>
					<td><div class="button" onClick="<portlet:namespace />insertImage();" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Image" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/image.gif" title="Image" vspace="0" width="18"></div></td>
					<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/spacer.gif" vspace="0" width="2"><span class="separator"></span><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/spacer.gif" vspace="0" width="2"></td>
					<td><div class="button" onClick="<portlet:namespace />insertList('1');" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Ordered List" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/ordered_list.gif" title="Ordered List" vspace="0" width="18"></div></td>
					<td><div class="button" onClick="<portlet:namespace />insertList();" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Unordered List" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/unordered_list.gif" title="Unordered List" vspace="0" width="18"></div></td>
					<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/spacer.gif" vspace="0" width="2"><span class="separator"></span><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/spacer.gif" vspace="0" width="2"></td>
					<td><div class="button" onClick="<portlet:namespace />insertTag('left');" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Justify Left" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/justify_left.gif" title="Justify Left" vspace="0" width="18"></div></td>
					<td><div class="button" onClick="<portlet:namespace />insertTag('center');" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Justify Center" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/justify_center.gif" title="Justify Center" vspace="0" width="18"></div></td>
					<td><div class="button" onClick="<portlet:namespace />insertTag('right');" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Justify Right" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/justify_right.gif" title="Justify Right" vspace="0" width="18"></div></td>
					<td><div class="button" onClick="<portlet:namespace />insertTag('indent');" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Indent" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/indent.gif" title="Indent" vspace="0" width="18"></div></td>
					<td><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/spacer.gif" vspace="0" width="2"><span class="separator"></span><img border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/spacer.gif" vspace="0" width="2"></td>
					<td><div class="button" onClick="<portlet:namespace />insertTag('quote');" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Quote" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/quote.gif" title="Quote" vspace="0" width="18"></div></td>
					<td><div class="button" onClick="<portlet:namespace />insertTag('code');" onMouseDown="<portlet:namespace />buttonDown(this);" onMouseOut="<portlet:namespace />buttonOut(this);" onMouseOver="<portlet:namespace />buttonOver(this);"><img align="absmiddle" alt="Code" border="0" height="18" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/message_boards/code.gif" title="Code" vspace="0" width="18"></div></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" height="100%">
				<textarea style="font-family: monospace; height: 100%; width: 100%;" id="textArea" name="textArea"></textarea>
			</td>
		</tr>
		</table>
	</td>
	<td>
		<div style="border: 1px solid <%= colorScheme.getPortletFontDim() %>; margin-left: 10px;">
			<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td align="center" bgcolor="#E5E4E8" colspan="4">
					<%= LanguageUtil.get(pageContext, "clickable-emoticons") %>
				</td>
			</tr>

			<%
			String path = themeDisplay.getPathThemeImage() + "/emoticons/";

			for (int i = 0; i < BBCodeUtil.EMOTICONS.length; i++) {
			%>

				<c:if test="<%= (i % 3) == 0 %>">
					<tr>
				</c:if>

				<td align="center"><img src='<%= StringUtil.replace(BBCodeUtil.EMOTICONS[i][0], "@theme_images_path@", themeDisplay.getPathThemeImage()) %>' onClick="<portlet:namespace />insertEmoticon('<%= BBCodeUtil.EMOTICONS[i][1] %>')"></td>

				<c:if test="<%= (i % 3) == 2 %>">
					</tr>
				</c:if>

			<%
			}
			%>

			</table>
		</div>
	</td>
</tr>
</table>

<script type="text/javascript">
	<portlet:namespace />initEditor();
</script>
