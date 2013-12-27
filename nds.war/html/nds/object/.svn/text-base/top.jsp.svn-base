<iframe id="hidden_iframe" name="hidden_iframe" src="<%= contextPath %>/html/common/null.html" style="visibility: hidden;"></iframe>
<div id="page-top">
<ul class="triblack">
	<%
	if (request.getAttribute("page_help")!=null){
	%>
	<li>
	<a class="gamma" href="javascript:popup_window('<%=((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("wiki.help.path","/wiki")+"/Wiki.jsp?page="+request.getAttribute("page_help")%>','ndshelp')">
	<%= PortletUtils.getMessage(pageContext, "help",null)%></a>
	</li>
	<%
	}else if(request.getAttribute("table_help")!=null){
	%>
	<li>
	<a class="gamma" href="javascript:popup_window('<%=NDS_PATH+"/help/index.jsp?table="+request.getAttribute("table_help")%>','ndshelp')">
	<%= PortletUtils.getMessage(pageContext, "help",null)%></a>
	</li>
	<%
	}
	%> 
	<li>
	<a class="gamma" href="<%=NDS_PATH%>/objext/wfmy.jsp"><%=userWeb.getUserDescription()%></a>
	</li>
</ul>
</div>




