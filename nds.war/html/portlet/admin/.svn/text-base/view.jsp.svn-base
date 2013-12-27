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

<%@ include file="/html/portlet/admin/init.jsp" %>

<%
String tabs1 = ParamUtil.getString(request, "tabs1");
String tabs2 = ParamUtil.getString(request, "tabs2");
String tabs3 = ParamUtil.getString(request, "tabs3");

PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(WindowState.MAXIMIZED);

portletURL.setParameter("struts_action", "/admin/view");
portletURL.setParameter("tabs1", tabs1);
portletURL.setParameter("tabs2", tabs2);
portletURL.setParameter("tabs3", tabs3);
%>

<script type="text/javascript">
	function <portlet:namespace />saveEnterprise(cmd) {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = cmd;
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/admin/edit_enterprise" /></portlet:actionURL>");
	}

	function <portlet:namespace />saveServer(cmd) {
		if (cmd == "hotDeploy") {
			document.<portlet:namespace />fm.encoding = "multipart/form-data";
		}

		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = cmd;
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/admin/edit_server" /></portlet:actionURL>");
	}

	function <portlet:namespace />saveUsers(cmd) {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = cmd;
		submitForm(document.<portlet:namespace />fm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/admin/edit_users" /></portlet:actionURL>");
	}

	function <portlet:namespace />updateDefaultLdap() {
		var baseProviderURL = "";
		var baseDN = "";
		var principal = "";
		var credentials = "";
		var searchFilter = "";
		var userMappings = "";

		var ldapType = document.<portlet:namespace />fm.<portlet:namespace />defaultLdap.selectedIndex;

		if (ldapType == 1) {
			baseProviderURL = "ldap://localhost:10389";
			baseDN = "dc=example,dc=com";
			principal = "uid=admin,ou=system";
			credentials = "secret";
			searchFilter = "(mail=@email_address@)";
			userMappings = "userId=cn\npassword=userPassword\nemailAddress=mail\nfirstName=givenName\nlastName=sn\njobTitle=title";
		}
		else if (ldapType == 2) {
			baseProviderURL = "ldap://localhost:389";
			baseDN = "dc=example,dc=com";
			principal = "admin";
			credentials = "secret";
			searchFilter = "(&(objectCategory=person)(sAMAccountName=@user_id@))";
			userMappings = "fullName=cn\nuserId=sAMAccountName\nemailAddress=userprincipalname";
		}
		else if (ldapType == 3) {
			url = "ldap://localhost:389";
			baseDN = "";
			principal = "cn=admin,ou=test";
			credentials = "secret";
			searchFilter = "(mail=@email_address@)";
			userMappings = "userId=cn\npassword=userPassword\nemailAddress=mail\nfirstName=givenName\nlastName=sn\njobTitle=title";
		}

		if ((ldapType >= 1) && (ldapType <= 3)) {
			document.<portlet:namespace />fm.<portlet:namespace />baseProviderURL.value = baseProviderURL;
			document.<portlet:namespace />fm.<portlet:namespace />baseDN.value = baseDN;
			document.<portlet:namespace />fm.<portlet:namespace />principal.value = principal;
			document.<portlet:namespace />fm.<portlet:namespace />credentials.value = credentials;
			document.<portlet:namespace />fm.<portlet:namespace />searchFilter.value = searchFilter;
			document.<portlet:namespace />fm.<portlet:namespace />userMappings.value = userMappings;
		}
	}
</script>

<form method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="">
<input name="<portlet:namespace />tabs1" type="hidden" value="<%= tabs1 %>">
<input name="<portlet:namespace />tabs2" type="hidden" value="<%= tabs2 %>">
<input name="<portlet:namespace />tabs3" type="hidden" value="<%= tabs3 %>">
<input name="<portlet:namespace />redirect" type="hidden" value="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/admin/view" /><portlet:param name="tabs1" value="<%= tabs1 %>" /><portlet:param name="tabs2" value="<%= tabs2 %>" /><portlet:param name="tabs3" value="<%= tabs3 %>" /></portlet:renderURL>">

<%
String tabsNames = "server,auto-deploy,enterprise,portlets,users";

if (!OmniadminUtil.isOmniadmin(user.getUserId())) {
	tabsNames = StringUtil.replace(tabsNames, "auto-deploy,", "");
}
%>

<liferay-ui:tabs
	names="<%= tabsNames %>"
	url="<%= portletURL.toString() %>"
/>

<c:choose>
	<c:when test='<%= tabs1.equals("auto-deploy") && OmniadminUtil.isOmniadmin(user.getUserId()) %>'>
		<%@ include file="/html/portlet/admin/auto_deploy.jsp" %>
	</c:when>
	<c:when test='<%= tabs1.equals("enterprise") %>'>
		<%@ include file="/html/portlet/admin/enterprise.jsp" %>
	</c:when>
	<c:when test='<%= tabs1.equals("portlets") %>'>
		<%@ include file="/html/portlet/admin/portlets.jsp" %>
	</c:when>
	<c:when test='<%= tabs1.equals("users") %>'>
		<%@ include file="/html/portlet/admin/users.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="/html/portlet/admin/server.jsp" %>
	</c:otherwise>
</c:choose>

</form>
