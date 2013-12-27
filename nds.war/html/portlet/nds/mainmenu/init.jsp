
<%@ include file="/html/common/init.jsp" %>

<%@ page import="nds.util.*" %>
<%@ page import="nds.control.util.*" %>
<%@ page import="nds.control.web.*" %>
<%@ page import="nds.portlet.util.*" %>

<portlet:defineObjects />

<%
PortletPreferences prefs = renderRequest.getPreferences();

String defaultPage = GetterUtil.getString(prefs.getValue("default-page", StringPool.BLANK));
String NDS_WEBPATH = contextPath + "/html/portlet/chain";
%>


