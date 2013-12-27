<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="nds.web.config.*"%>
<%!
	/**
	* 3 preference params:
		"dataconf" : name of nds.web.config.ListDataConfig 
		"uiconf"   : name of nds.web.config.ListUIConfig in normal window mode
		"namespace" - namespance
	*/

%>
<%
String  dataconf =request.getParameter("dataconf");
String  uiconf= request.getParameter("uiconf");
String  namespace= request.getParameter("namespace");
if(namespace==null) namespace="";
PortletConfigManager pcManager=(PortletConfigManager)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.PORTLETCONFIG_MANAGER);
ListDataConfig dataConfig= (ListDataConfig)pcManager.getPortletConfig(dataconf,nds.web.config.PortletConfig.TYPE_LIST_DATA);
ListUIConfig uiConfig= (ListUIConfig)pcManager.getPortletConfig(uiconf,nds.web.config.PortletConfig.TYPE_LIST_UI);

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
				<div id="<%=namespace%>search-top" class="quicksearch-top">
					<%@ include file="table_search.jsp" %>
				</div>
				<%
				}
				request.setAttribute("listdataconf", dataconf);
				request.setAttribute("listuiconf", uiconf);
				request.setAttribute("namespace", namespace);
				%>
				<div id="<%=namespace%>table-content">
					<jsp:include page="table_list.jsp" flush="true"/>
				</div>
				<%
				if( "BOTTOM".equals(uiConfig.getSearchBox()) || "BOTH".equals(uiConfig.getSearchBox())){
					searchBoxName="b";
				%>
				<div id="<%=namespace%>search-bottom" class="quicksearch-bottom">
					<%@ include file="table_search.jsp" %>
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
