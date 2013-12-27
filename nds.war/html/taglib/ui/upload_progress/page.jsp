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
String id = (String)request.getAttribute("liferay-ui:upload-progress:id");
String iframeSrc = (String)request.getAttribute("liferay-ui:upload-progress:iframe-src");
String redirect = (String)request.getAttribute("liferay-ui:upload-progress:redirect");
%>

<script src="<%= themeDisplay.getPathJavaScript() %>/upload_progress.js" type="text/javascript"></script>

<script type="text/javascript">
	var <%= id %> = new UploadProgress("<%= id %>", "<%= Http.encodeURL(redirect) %>");
</script>

<iframe frameborder="0" id="<%= id %>-iframe" src="<%= iframeSrc %>" style="width: 100%;"></iframe>

<iframe frameborder="0" id="<%= id %>-poller" src="" style="width: 0; height: 0;"></iframe>

<div id="<%= id %>-bar-div" style="text-align: center; display: none;">
	<br>

	<div style="background: url(<%= themeDisplay.getPathThemeImage() %>/progress_bar/incomplete_middle.gif) scroll repeat-x top left; margin: auto; text-align: left; width: 80%;">
		<div style="background: url(<%= themeDisplay.getPathThemeImage() %>/progress_bar/incomplete_left.gif) scroll no-repeat top left;">
			<div style="height: 23px; background: url(<%= themeDisplay.getPathThemeImage() %>/progress_bar/incomplete_right.gif) scroll no-repeat top right;">
				<div id="<%= id %>-bar" style="background: url(<%= themeDisplay.getPathThemeImage() %>/progress_bar/complete_middle.gif) scroll repeat-x top left; overflow: hidden; width: 0;">
					<div style="background: url(<%= themeDisplay.getPathThemeImage() %>/progress_bar/complete_left.gif) scroll no-repeat top left;">
						<div class="font-small" style="font-weight: bold; height: 23px; padding-top: 3px; text-align: center; background: url(<%= themeDisplay.getPathThemeImage() %>/progress_bar/complete_right.gif) scroll no-repeat top right;">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
