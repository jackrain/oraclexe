<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
	request.setAttribute("table", ""+TableManager.getInstance().getTable("AD_SYSCOMMAND").getId());
	String tabName= PortletUtils.getMessage(pageContext, "system-command",null);
	request.setAttribute("resulthandler",NDS_PATH+"/objext/syscommand.jsp");
%>
<script>
	document.title="<%=PortletUtils.getMessage(pageContext, "system-command",null)%>";
</script>
<%
int navTabTotalWidth=DEFAULT_TAB_WIDTH; //total table width
request.setAttribute("internal_table_width", ""+(navTabTotalWidth - 10));
%>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<liferay-util:include page="/html/nds/objext/inc_list.jsp" />
    </div>
</div>
<%@ include file="/html/nds/footer_info.jsp" %>
