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

			</div></div><!-- end layout-content -->

			<div id="layout-bottom-container"><div id="layout-bottom-left"><div id="layout-bottom-right">
				<span>

				<script type="text/javascript">
					if (is_ie_5_up) {
						document.write("| <a style=\"cursor: hand\" onClick=\"this.style.behavior='url(#default#homepage)'; this.setHomePage('<%= themeDisplay.getURLPortal() %>');\"><%= LanguageUtil.format(pageContext, "make-x-my-start-page", company.getShortName(), false) %></a>");
					}
					var navHover = new Image();
					navHover.src = "<%= themeDisplay.getPathThemeImage() %>/custom/nav-hover.png"
				</script>

				</span>

				<div id="layout-language-select"><liferay-ui:language /></div>

			</div></div></div>
		</div><!-- End layout-box -->
	</div>
</div><!-- End layout-outer-side-decoration -->
