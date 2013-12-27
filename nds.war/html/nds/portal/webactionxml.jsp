<?xml version="1.0"?>
<%@page errorPage="/html/nds/error.jsp"%>
<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>

<%    /**
		Show webaction as tree
     * @param 
      		id - webaction.id	
     */
     
int actionId=  ParamUtils.getIntAttributeOrParameter(request, "id", -1);
//System.out.println("sdfasdfasdfasdfasdf"+actionId);
TableManager manager=TableManager.getInstance();
WebAction action=manager.getWebAction(actionId);
UserWebImpl userWeb =null;
try{
	userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
}catch(Exception userWebException){
	System.out.println("########## found userWeb=null##########"+userWebException);
}
Locale locale =userWeb.getLocale();
HashMap actionEnv = new HashMap();
actionEnv.put("httpservletrequest", request);
actionEnv.put("userweb", userWeb);
WebAction.ActionTypeEnum ate= action.getActionType();
WebAction.DisplayTypeEnum dst=action.getDisplayType();
if(ate.equals(WebAction.ActionTypeEnum.URL)&&dst.equals(WebAction.DisplayTypeEnum.Accord)){
%>
<!--div-->
<%=action.toHTML(locale,actionEnv)%>
<!--/div-->
<%}else{%>
<tree>
	<%=action.toHTML(locale,actionEnv)%>
</tree>
<%}%>    
