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

<%@ include file="/html/portlet/network/init.jsp" %>

<%
String cmd = ParamUtil.getString(request, Constants.CMD);

String tabs1 = ParamUtil.getString(request, "tabs1", "dns-lookup");

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setParameter("struts_action", "/network/view");
portletURL.setParameter("tabs1", tabs1);
%>

<form action="<portlet:renderURL><portlet:param name="struts_action" value="/network/view" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.SEARCH %>">
<input name="<portlet:namespace />tabs1" type="hidden" value="<%= tabs1 %>">

<liferay-ui:tabs
	names="dns-lookup,ftp,irc,ssh,vnc,whois"
	url="<%= portletURL.toString() %>"
/>

<c:choose>
	<c:when test='<%= tabs1.equals("dns-lookup") %>'>
		<%
		String domain = ParamUtil.getString(request, "domain");

		DNSLookup dnsLookup = null;

		if (cmd.equals(Constants.SEARCH)) {
			dnsLookup = NetworkUtil.getDNSLookup(domain);

			if (dnsLookup == null) {
				SessionErrors.add(renderRequest, DNSLookup.class.getName());
			}
		}
		%>

		<liferay-ui:error exception="<%= DNSLookup.class %>" message="please-enter-a-valid-host-name-or-ip" />

		<input class="form-text" name="<portlet:namespace />domain" size="30" type="text" value="<%= domain %>"> <input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">

		<c:if test="<%= dnsLookup != null %>">
<pre>
<%= dnsLookup.getResults() %>
</pre>
		</c:if>
	</c:when>
	<c:when test='<%= tabs1.equals("ftp") %>'>
		<c:choose>
			<c:when test="<%= BrowserSniffer.is_ie(request) %>">
				<object classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93" codebase="http://java.sun.com/products/plugin/1.3/jinstall-13-win32.cab#Version=1,3,0,0" height="460" width="100%">
					<param name="archive" value="secureftp.jar" />
					<param name="code" value="edu.sdsc.secureftp.gui.SecureFtpApplet" />
					<param name="codebase" value="<%= themeDisplay.getPathApplet() %>" />
					<param name="type" value="application/x-java-applet;version=1.3" />
				</object>
			</c:when>
			<c:otherwise>
				<embed archive="secureftp.jar" code="edu.sdsc.secureftp.gui.SecureFtpApplet" codebase="<%= themeDisplay.getPathApplet() %>" height="460" pluginspage="http://java.sun.com/products/plugin/1.3/plugin-install.html" type="application/x-java-applet;version=1.3" width="100%">
				</embed>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test='<%= tabs1.equals("irc") %>'>
		<applet archive="jirc_nss.zip" code="Chat" codebase="http://www.jpilot.com/products/jirc/classes" height="460" name="jchat" width="100%">
			<param name="CABBASE" value="jirc_mss.cab" />

			<param name="AllowJoinSound" value="true" />

			<param name="ServerPort" value="6667" />

			<param name="ServerName1" value="irc.aloha.net" />
			<param name="ServerName2" value="irc.aol.com" />
			<param name="ServerName3" value="irc.blessed.net" />
			<param name="ServerName4" value="irc.choopa.net" />
			<param name="ServerName5" value="irc.desync.com" />
			<param name="ServerName6" value="irc.easynews.com" />
			<param name="ServerName7" value="irc.he.net" />
			<param name="ServerName8" value="irc.isprime.com" />
			<param name="ServerName9" value="irc.limelight.us" />
			<param name="ServerName10" value="irc.mindspring.com" />
			<param name="ServerName11" value="irc.nac.net" />
			<param name="ServerName12" value="irc.prison.net" />
			<param name="ServerName13" value="irc.secsup.org" />
			<param name="ServerName14" value="irc.servercentral.net" />
			<param name="ServerName15" value="irc.umich.edu" />
			<param name="ServerName16" value="irc.umn.edu" />
			<param name="ServerName17" value="irc.weblook2k.com" />
			<param name="ServerName18" value="irc.wh.verio.net" />

			<param name="Channel1" value="java" />
			<param name="Channel2" value="movies" />
			<param name="Channel3" value="sports" />

			<param name="AllowURL" value="true" />
			<param name="AllowIdentd" value="true" />

			<param name="IgnoreMOTD" value="true" />

			<param name="WelcomeMessage" value="Welcome <%= user.getFullName() %>!" />
			<param name="RealName" value="<%= user.getFullName() %>" />
			<param name="NickName" value="<%= user.getFirstName() %><%= user.getLastName() %>" />
			<param name="UserName" value="jirc" />
			<param name="isLimitedServers" value="true" />
			<param name="isLimitedChannels" value="true" />

			<param name="BackgroundColor" value="99,132,181" />
			<param name="TextColor" value="black" />
			<param name="TextScreenColor" value="white" />
			<param name="ListTextColor" value="blue" />
			<param name="TitleBackgroundColor" value="black" />
			<param name="TitleForegroundColor" value="white" />
			<param name="NickNameColor" value="3" />

			<param name="IgnoreServerMsg" value="true" />
			<param name="IgnoreMOTD" value="true" />

			<param name="TextFontName" value="Arial" />
			<param name="TextFontSize" value="12" />

			<param name="LogoBgColor" value="white" />
			<param name="BorderVsp" value="2" />
			<param name="DirectStart" value="false" />

			<param name="AliasList" value="/m=/msg,/t=/topic" />
			<param name="FilterKeys" value=":) :( :D :P jcool" />
			<param name="FilterVals" value="smile.gif frown.gif biggrin.gif tongue.gif IRClogo.gif" />

			<param name="FieldNamePrivateChatTitle" value="Private Chat with: " />
			<param name="FieldNameConnected" value="Connected to server, trying to login">
		</applet>
	</c:when>
	<c:when test='<%= tabs1.equals("ssh") %>'>
		<applet archive="SSHTermApplet-signed.jar,SSHTermApplet-jdkbug-workaround-signed.jar,SSHTermApplet-jdk1.3.1-dependencies-signed.jar" code="com.sshtools.sshterm.SshTermApplet" codebase="<%= themeDisplay.getPathApplet() %>/sshterm" height="460" style="border-style: solid; border-width: 1; padding-bottom: 1; padding-left: 4; padding-right: 4; padding-top: 1" width="100%">
		</applet>
	</c:when>
	<c:when test='<%= tabs1.equals("vnc") %>'>
		<applet archive="SSHVncApplet-signed.jar,SSHVncApplet-jdkbug-workaround-signed.jar,SSHVncApplet-jdk1.3.1-dependencies-signed.jar" code="com.sshtools.sshvnc.SshVNCApplet" codebase="<%= themeDisplay.getPathApplet() %>/sshvnc" height="460" style="border-style: solid; border-width: 1; padding-bottom: 1; padding-left: 4; padding-right: 4; padding-top: 1" width="100%">
		</applet>
	</c:when>
	<c:when test='<%= tabs1.equals("whois") %>'>

		<%
		String domain = ParamUtil.getString(request, "domain");

		Whois whois = null;

		if (cmd.equals(Constants.SEARCH)) {
			whois = NetworkUtil.getWhois(domain);

			if (whois == null) {
				SessionErrors.add(renderRequest, Whois.class.getName());
			}
		}
		%>

		<liferay-ui:error exception="<%= Whois.class %>" message="an-unexpected-error-occurred" />

		<input class="form-text" name="<portlet:namespace />domain" size="30" type="text" value="<%= domain %>"> <input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">

		<c:if test="<%= whois != null %>">
<pre>
<%= whois.getResults() %>
</pre>
		</c:if>
	</c:when>
</c:choose>

</form>

<c:if test='<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) && (tabs1.equals("dns-lookup") || tabs1.equals("whois")) %>'>
	<script type="text/javascript">
		document.<portlet:namespace />fm.<portlet:namespace />domain.focus();
	</script>
</c:if>
