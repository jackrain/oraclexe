<%
if (request.getAttribute("page_help")!=null){
%>
<a id="btn_help" name='btn_help' href="javascript:popup_window('<%=((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("wiki.help.path","/wiki")+"/Wiki.jsp?page="+request.getAttribute("page_help")%>','ndshelp')"><img src="/html/nds/images/help.png"/><%=PortletUtils.getMessage(pageContext, "help",null)%></a>
<%
}else if(request.getAttribute("table_help")!=null){
%>
<a id="btn_help" name='btn_help' href="javascript:popup_window('<%=NDS_PATH+"/help/index.jsp?table="+request.getAttribute("table_help")%>','ndshelp')"><img src="/html/nds/images/help.png"/><%=PortletUtils.getMessage(pageContext, "help",null)%></a>
<%
}
%> 



