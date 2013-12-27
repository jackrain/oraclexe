<%
/**
 * yfzhu changed layout-inner-side-decoration width ((themeDisplay.getResolution() + 20) + "px") to below
 */
%>

<%@ include file="init.jsp" %>

#layout-inner-side-decoration {
	width: <%= (themeDisplay.getResolution() > 0) ?
				((themeDisplay.getResolution() + 0) + "px") :
				("100%") %>;
}

#layout-box {
	width: <%= (themeDisplay.getResolution() > 0) ?
				(themeDisplay.getResolution() + "px") :
				("98%") %>;
}

<c:if test="<%= themeDisplay.isStatePopUp() %>">
	.portlet-container { height: 100%; width: 100%; }
</c:if>
