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

<%= ReleaseInfo.getReleaseInfo() %>

<c:if test="<%=! OmniadminUtil.isOmniadmin(user.getUserId()) %>">
	<br><br>

	<%
	Date uptime = (Date)SimpleCachePool.get(StartupAction.class.getName() + ".uptime");
	Date now = new Date();

	long uptimeDiff = now.getTime() - uptime.getTime();
	long days = uptimeDiff / Time.DAY;
	long hours = (uptimeDiff / Time.HOUR) % 24;
	long minutes = (uptimeDiff / Time.MINUTE) % 60;
	long seconds = (uptimeDiff / Time.SECOND) % 60;

	NumberFormat numberFormat = NumberFormat.getInstance();

	numberFormat.setMaximumIntegerDigits(2);
	numberFormat.setMinimumIntegerDigits(2);
	%>

	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "uptime") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<c:if test="<%= days > 0 %>">
				<%= days %> <%= LanguageUtil.get(pageContext, ((days > 1) ? "days" : "day")) %>,
			</c:if>

			<%= numberFormat.format(hours) %>:<%= numberFormat.format(minutes) %>:<%= numberFormat.format(seconds) %>
		</td>
	</tr>

	<%
	Runtime runtime = Runtime.getRuntime();

	numberFormat = NumberFormat.getInstance(locale);
	%>

	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "free-memory") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= numberFormat.format(runtime.freeMemory()) %> <%= LanguageUtil.get(pageContext, "bytes") %>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "total-memory") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= numberFormat.format(runtime.totalMemory()) %> <%= LanguageUtil.get(pageContext, "bytes") %>
		</td>
	</tr>
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "maximum-memory") %>:
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<%= numberFormat.format(runtime.maxMemory()) %> <%= LanguageUtil.get(pageContext, "bytes") %>
		</td>
	</tr>
	</table>

	<c:choose>
		<c:when test="<%= renderRequest.getWindowState().equals(WindowState.NORMAL) %>">
			<br>

			<html:link page="/admin/view?windowState=maximized&portletMode=view&actionURL=0"><bean:message key="more-options" /></html:link> &raquo;
		</c:when>
		<c:otherwise>
			<br><div class="beta-separator"></div><br>

			<%= LanguageUtil.get(pageContext, "shutdown-the-server-in-the-specified-number-of-minutes") %>

			<br><br>

			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "number-of-minutes") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<input class="form-text" name="<portlet:namespace />minutes" size="3" type="text">
				</td>
			</tr>
			<tr>
				<td>
					<%= LanguageUtil.get(pageContext, "custom-message") %>
				</td>
				<td style="padding-left: 10px;"></td>
				<td>
					<textarea class="form-text" name="<portlet:namespace />message" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;"><%= GetterUtil.getString(ShutdownUtil.getMessage()) %></textarea>
				</td>
			</tr>
			</table>

			<br>

			<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "shutdown") %>' onClick="<portlet:namespace />saveServer('shutdown');"><br>

			<br><div class="beta-separator"></div><br>

			<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td>
					<table border="0" cellpadding="4" cellspacing="0" width="100%">
					<tr>
						<td class="beta-gradient">
							<b><%= LanguageUtil.get(pageContext, "tasks") %>:</b>
						</td>
						<td align="right" class="beta-gradient">
							<span style="font-size: xx-small;">
							[<a href="javascript: void(0);" onClick="toggleByIdSpan(this, '<portlet:namespace />tasks'); self.focus();"><span><%= LanguageUtil.get(pageContext, "show") %></span><span style="display: none;"><%= LanguageUtil.get(pageContext, "hide") %></span></a>]
							</span>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<div id="<portlet:namespace />tasks" style="display: none;">
						<table border="0" cellpadding="4" cellspacing="0" width="100%">
						<tr class="portlet-section-alternate">
							<td>
								<%= LanguageUtil.get(pageContext, "run-the-garbage-collector-to-free-up-memory") %>
							</td>
							</td>
							<td align="right">
								<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "execute") %>' onClick="<portlet:namespace />saveServer('gc');">
							</td>
						</tr>
						<tr class="portlet-section-body">
							<td>
								<%= LanguageUtil.get(pageContext, "clear-content-cached-by-this-vm") %>
							</td>
							</td>
							<td align="right">
								<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "execute") %>' onClick="<portlet:namespace />saveServer('cacheSingle');">
							</td>
						</tr>
						<tr class="portlet-section-alternate">
							<td>
								<%= LanguageUtil.get(pageContext, "clear-content-cached-across-the-cluster") %>
							</td>
							</td>
							<td align="right">
								<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "execute") %>' onClick="<portlet:namespace />saveServer('cacheMulti');">
							</td>
						</tr>
						<tr class="portlet-section-body">
							<td>
								<%= LanguageUtil.get(pageContext, "clear-the-database-cache") %>
							</td>
							</td>
							<td align="right">
								<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "execute") %>' onClick="<portlet:namespace />saveServer('cacheDb');">
							</td>
						</tr>
						<tr class="portlet-section-alternate">
							<td>
								<%= LanguageUtil.get(pageContext, "precompile-jsps-for-faster-speed") %>
							</td>
							</td>
							<td align="right">
								<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "execute") %>' onClick="alert('<%= UnicodeLanguageUtil.get(pageContext, "please-be-patient") %>'); <portlet:namespace />saveServer('precompile');">
							</td>
						</tr>
						</table>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<table border="0" cellpadding="4" cellspacing="0" width="100%">
					<tr>
						<td class="beta-gradient">
							<b><%= LanguageUtil.get(pageContext, "log-levels") %>:</b>
						</td>
						<td align="right" class="beta-gradient">
							<span style="font-size: xx-small;">
							[<a href="javascript: void(0);" onClick="toggleByIdSpan(this, '<portlet:namespace />logLevels'); self.focus();"><span><%= LanguageUtil.get(pageContext, "show") %></span><span style="display: none;"><%= LanguageUtil.get(pageContext, "hide") %></span></a>]
							</span>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<div id="<portlet:namespace />logLevels" style="display: none;">

						<%
						Map currentLoggerNames = new TreeMap();

						Enumeration enu = LogManager.getCurrentLoggers();

						while (enu.hasMoreElements()) {
							Logger logger = (Logger)enu.nextElement();

							currentLoggerNames.put(logger.getName(), logger);
						}
						%>

						<table border="0" cellpadding="4" cellspacing="0" width="100%">

						<%
						int counter = 0;

						Iterator itr = currentLoggerNames.entrySet().iterator();

						while (itr.hasNext()) {
							Map.Entry entry = (Map.Entry)itr.next();

							String name = (String)entry.getKey();
							Logger logger = (Logger)entry.getValue();
						%>

							<c:if test="<%= logger.getLevel() != null %>">

								<%
								String className = "portlet-section-body";
								String classHoverName = "portlet-section-body-hover";

								if (MathUtil.isEven(counter++)) {
									className = "portlet-section-alternate";
									classHoverName = "portlet-section-alternate-hover";
								}
								%>

								<tr class="<%= className %>" style="font-size: x-small;" onMouseEnter="this.className = '<%= classHoverName %>';" onMouseLeave="this.className = '<%= className %>';">
									<td>
										<%= name %>
									</td>
									<td>
										<select class="form-button" name="<portlet:namespace />logLevel<%= name %>">

											<%
											for (int i = 0; i < Levels.ALL_LEVELS.length; i++) {
											%>

												<option <%= logger.getLevel().equals(Levels.ALL_LEVELS[i]) ? "selected" : "" %> value="<%= Levels.ALL_LEVELS[i] %>"><%= Levels.ALL_LEVELS[i] %></option>

											<%
											}
											%>

										</select>
									</td>
								</tr>
							</c:if>

						<%
						}
						%>

						</table>

						<br>

						<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "save") %>' onClick="<portlet:namespace />saveServer('updateLogLevels');">

						<br><br>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<table border="0" cellpadding="4" cellspacing="0" width="100%">
					<tr>
						<td class="beta-gradient">
							<b><%= LanguageUtil.get(pageContext, "system-properties") %>:</b>
						</td>
						<td align="right" class="beta-gradient">
							<span style="font-size: xx-small;">
							[<a href="javascript: void(0);" onClick="toggleByIdSpan(this, '<portlet:namespace />systemProperties'); self.focus();"><span><%= LanguageUtil.get(pageContext, "show") %></span><span style="display: none;"><%= LanguageUtil.get(pageContext, "hide") %></span></a>]
							</span>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<div id="<portlet:namespace />systemProperties" style="display: none;">
						<table border="0" cellpadding="4" cellspacing="0" width="100%">

						<%
						counter = 0;

						Properties systemProps = new SortedProperties();

						PropertiesUtil.copyProperties(System.getProperties(), systemProps);

						enu = systemProps.propertyNames();

						while (enu.hasMoreElements()) {
							String name = (String)enu.nextElement();

							String className = "portlet-section-body";
							String classHoverName = "portlet-section-body-hover";

							if (MathUtil.isEven(counter++)) {
								className = "portlet-section-alternate";
								classHoverName = "portlet-section-alternate-hover";
							}

							String value = System.getProperty(name);
						%>

							<tr class="<%= className %>" style="font-size: xx-small;" onMouseEnter="this.className = '<%= classHoverName %>';" onMouseLeave="this.className = '<%= className %>';">
								<td title="<%= name %>">
									<%= StringUtil.shorten(name, 65) %>
								</td>
								<td title="<%= value %>">
									<%= StringUtil.shorten(value, 75) %>
								</td>
							</tr>

						<%
						}
						%>

						</table>

						<br>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<table border="0" cellpadding="4" cellspacing="0" width="100%">
					<tr>
						<td class="beta-gradient">
							<b><%= LanguageUtil.get(pageContext, "portal-properties") %>:</b>
						</td>
						<td align="right" class="beta-gradient">
							<span style="font-size: xx-small;">
							[<a href="javascript: void(0);" onClick="toggleByIdSpan(this, '<portlet:namespace />portalProperties'); self.focus();"><span><%= LanguageUtil.get(pageContext, "show") %></span><span style="display: none;"><%= LanguageUtil.get(pageContext, "hide") %></span></a>]
							</span>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<div id="<portlet:namespace />portalProperties" style="display: none;">
						<table border="0" cellpadding="4" cellspacing="0" width="100%">

						<%
						counter = 0;

						Properties portalProps = new SortedProperties();

						PropertiesUtil.copyProperties(PropsUtil.getProperties(), portalProps);

						enu = portalProps.propertyNames();

						while (enu.hasMoreElements()) {
							String name = (String)enu.nextElement();

							String className = "portlet-section-body";
							String classHoverName = "portlet-section-body-hover";

							if (MathUtil.isEven(counter++)) {
								className = "portlet-section-alternate";
								classHoverName = "portlet-section-alternate-hover";
							}

							String value = PropsUtil.get(name);
						%>

							<tr class="<%= className %>" style="font-size: xx-small;" onMouseEnter="this.className = '<%= classHoverName %>';" onMouseLeave="this.className = '<%= className %>';">
								<td title="<%= name %>">
									<%= StringUtil.shorten(name, 65) %>
								</td>
								<td title="<%= value %>">
									<%= StringUtil.shorten(value, 75) %>
								</td>
							</tr>

						<%
						}
						%>

						</table>
					</div>
				</td>
			</tr>
			</table>
		</c:otherwise>
	</c:choose>
</c:if>
