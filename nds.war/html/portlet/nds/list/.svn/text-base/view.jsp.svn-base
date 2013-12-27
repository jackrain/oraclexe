<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/portlet/nds/init.jsp" %>
<%!
	/**
	* 3 preference params:
		"dataconf" : id of nds.web.config.ListDataConfig 
		"uiconf"   : id of nds.web.config.ListUIConfig in normal window mode
		"maxuiconf": id of nds.web.config.ListUIConfig in maximized window mode
	*/

%>
<%try{
int dataconf = Tools.getInt(prefs.getValue("dataConfig", "-1"),-1);
int uiconf =  Tools.getInt(prefs.getValue("normalStateUIConfig", "-1"),-1);
int maxuiconf =  Tools.getInt(prefs.getValue("maxStateUIConfig", ""+uiconf),uiconf);
int currentUIConfId= renderRequest.getWindowState().equals(WindowState.MAXIMIZED)?maxuiconf:uiconf;
PortletConfigManager pcManager=(PortletConfigManager)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.PORTLETCONFIG_MANAGER);
ListDataConfig dataConfig= (ListDataConfig)pcManager.getPortletConfig(dataconf,nds.web.config.PortletConfig.TYPE_LIST_DATA);
ListUIConfig uiConfig= (ListUIConfig)pcManager.getPortletConfig(currentUIConfId,nds.web.config.PortletConfig.TYPE_LIST_UI);
String namespace= renderResponse.getNamespace();//ParamUtils.getAttributeOrParameter(request, "namespace");
TableManager manager=TableManager.getInstance();
QueryEngine engine=QueryEngine.getInstance();
int tableId=dataConfig.getTableId();
Table table;
table= manager.getTable(tableId);
%>
<c:choose>
	<c:when test="<%= (dataConfig!=null&&uiConfig!=null) %>">
		<div class="<%=uiConfig.getCssClass()%>-out">
		<%
		 if("TITLE".equals(uiConfig.getMoreStyle())){
		%>
			<div class="<%=uiConfig.getTitleCss()%>">
				<div class="<%=uiConfig.getTitleCss()%>-title">
					<%= portletDisplay.getTitle() %>
				</div>
				<%
					// more link
					String moreURL= uiConfig.getMoreURL();
					if(nds.util.Validator.isNotNull(moreURL)){
				%>
				<div class="<%=uiConfig.getTitleCss()%>-more">
					<a class="action" href="<%=moreURL%>"><%=LanguageUtil.get(pageContext, "text-more")%></a>
				</div>
				<%
					}
				%>
			</div>
		<%		 	
		 }// end TITLE
		%>	
		<c:choose>
			<c:when test="<%=("TABLE".equals(uiConfig.getStyle())) %>">
				<%
				String searchBoxName="t";
				if( "TOP".equals(uiConfig.getSearchBox()) || "BOTH".equals(uiConfig.getSearchBox())){
				%>
				<div id="<portlet:namespace />search-top" class="quicksearch-top">
					<%@ include file="/html/portlet/nds/list/table_search.jsp" %>
				</div>
				<%
				}
				request.setAttribute("listdataconf", String.valueOf(dataconf));
				request.setAttribute("listuiconf", String.valueOf(currentUIConfId));
				request.setAttribute("namespace", renderResponse.getNamespace());
				%>
				<div id="<portlet:namespace />table-content">
					<jsp:include page="/html/portlet/nds/list/table_list.jsp" flush="true"/>
				</div>
				<%
				if( "BOTTOM".equals(uiConfig.getSearchBox()) || "BOTH".equals(uiConfig.getSearchBox())){
					searchBoxName="b";
				%>
				<div id="<portlet:namespace />search-bottom" class="quicksearch-bottom">
					<%@ include file="/html/portlet/nds/list/table_search.jsp" %>
				</div>
				<%
				}%>
			</c:when>
			<c:otherwise>
				<div class="<%=uiConfig.getCssClass()%>-ul">
				<%@ include file="ul_list.jsp" %>
				</div>
			</c:otherwise>
		</c:choose>	
		</div><!--end class=<%=uiConfig.getCssClass()%>-out-->
	</c:when>
	<c:otherwise>
		<%= LanguageUtil.get(pageContext, "please-contact-the-administrator-to-setup-this-portlet") %>
	</c:otherwise>
</c:choose>
<%}catch(Throwable xet){
	xet.printStackTrace();
}%>
