<?xml version="1.0"?>
<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>

<%!
 	
 private static int posMenuActionId;
 static{
	try{
 		posMenuActionId= Tools.getInt(QueryEngine.getInstance().doQueryOne("select id from ad_action where name='posmenu'"),-1);
 	}catch(Throwable t){
 		posMenuActionId= -1;
 	}
 }

%>

<%  /**
     * pos menu constructor, load xml definition from ad_action named "posmenu"
     */
String NDS_PATH=nds.util.WebKeys.NDS_URI;
UserWebImpl userWeb =null;
try{
	userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
}catch(Exception userWebException){
	System.out.println("########## found userWeb=null##########"+userWebException);
}
Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
Locale locale =userWeb.getLocale();
%>
<tree>
<%
WebAction action=(WebAction)TableManager.getInstance().getWebAction(posMenuActionId) ;
if(action!=null){
%>
	<%=action.toHTML(locale,null)%>
<%}%>
</tree>
