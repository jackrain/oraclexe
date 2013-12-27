<%@ include file="/html/nds/common/init.jsp" %>
<%
    /*
   	Support help&manual now. 
    @param table (int) if not exists go directly to wiki
    @param page (optional) will used as redirect parameter
    */ 
    String wikiPage= request.getParameter("page");
    Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
	String helpHomePage= conf.getProperty("help.homepage","/manual/yunbao56.html");

	int tableId= Tools.getInt(request.getParameter("table"),-1);
	Table table=  TableManager.getInstance().findTable(request.getParameter("table"));
	if( table ==null){
		response.sendRedirect(helpHomePage);
    	return;
    }
	response.sendRedirect(helpHomePage+"?"+ table.getName().toLowerCase()+".htm");
%>

