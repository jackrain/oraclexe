<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="nds.web.config.*" %>
<%
    /**
     * Needed parameters/attribute:
		"listdataconf" : id of nds.web.config.ListDataConfig 
		"listuiconf"   : id of nds.web.config.ListUIConfig in normal window mode
		"namespace"   : namespace, id of all embed html elements should be prefixed with that value
		
     */
	//private final static int MAX_COLUMNLENGTH_WHEN_TOO_LONG=30;//QueryUtils.MAX_COLUMN_CHARS -3
%>
<%
try{
int dataconf = ParamUtils.getIntAttributeOrParameter(request, "listdataconf", -1);
int uiconf =  ParamUtils.getIntAttributeOrParameter(request, "listuiconf", -1);
String namespace=ParamUtils.getAttributeOrParameter(request, "namespace");
PortletConfigManager pcManager=(PortletConfigManager)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.PORTLETCONFIG_MANAGER);
ListDataConfig dataConfig= (ListDataConfig)pcManager.getPortletConfig(dataconf,nds.web.config.PortletConfig.TYPE_LIST_DATA);
ListUIConfig uiConfig= (ListUIConfig)pcManager.getPortletConfig(uiconf,nds.web.config.PortletConfig.TYPE_LIST_UI);
TableManager manager=TableManager.getInstance();
int tableId=dataConfig.getTableId();
Table table;
table= manager.getTable(tableId);

%>
<%@ include file="/html/portlet/nds/list/data_list.jsp" %>
<%@ include file="/html/portlet/nds/list/table_list_result.jsp" %>
<%
}catch(Exception expd){
	expd.printStackTrace();
%>
<p><font color='red'><%= MessagesHolder.getInstance().translateMessage(expd.getMessage(),locale)%></font>
<%	
}
%>
