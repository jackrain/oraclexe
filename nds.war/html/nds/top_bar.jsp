<SCRIPT>
var moduleFrameset=top.module;
var mainFrame=top.mainFrame;
var listFrame=top.listFrame;
function showlist(){
	try{
	if(moduleFrameset!=null && mainFrame!=null){
	moduleFrameset.cols = "240,441*";
	mainFrame.document.getElementById("showtoc").style.display = "none";
	}
	}
	catch(ex){}
}
</SCRIPT>
<table width="<%=ParamUtil.getString(request, "table_width", String.valueOf(DEFAULT_TAB_WIDTH))%>" border="0" cellspacing="0" cellpadding="0" >
  <tr valign="top"> 
    <td width="120" align="left"  nowrap>
	    <DIV id="showtoc" style="DISPLAY: none" name="showlist">
		    <TABLE title="Show List" style="CURSOR: hand" onclick="showlist();" cellSpacing=0 cellPadding=0 align=left border=0>
		    <tr><td><img src="<%=NDS_PATH%>/images/showlist.gif"></td><td><%=PortletUtils.getMessage(pageContext, "show-list",null)%></td></tr></table>
	    </div>
	    <script>
	    try{
			if(listFrame!=null && getFrameSize(listFrame,"Width")<50){
				document.getElementById("showtoc").style.display = "block";	    
			}
		}catch(ex){}
	    </script>
    </td>
    <td align="right"> 
    <%
    if (request.getAttribute("page_help")!=null){
    %>
    <font class="gamma" ><%= PortletUtils.getMessage(pageContext, "dot-mark",null)%></font>
    <a class="gamma" href="javascript:popup_window('<%=((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("wiki.help.path","/wiki")+"/Wiki.jsp?page="+request.getAttribute("page_help")%>','ndshelp')">
	<%= PortletUtils.getMessage(pageContext, "help",null)%></a>
    <%
    }else if(request.getAttribute("table_help")!=null){
	%>
    <font class="gamma" ><%= PortletUtils.getMessage(pageContext, "dot-mark",null)%></font>
    <a class="gamma" href="javascript:popup_window('<%=NDS_PATH+"/help/index.jsp?table="+request.getAttribute("table_help")%>','ndshelp')">
	<%= PortletUtils.getMessage(pageContext, "help",null)%></a>
    <%
    }
    %> 
    <font class="gamma" ><%= PortletUtils.getMessage(pageContext, "dot-mark",null)%></font>
    <a class="gamma" href="<%=NDS_PATH%>/objext/wfmy.jsp"><%=userWeb.getUserDescription()%></a>
    </td>
  </tr>
</table>

