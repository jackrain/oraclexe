<?xml version="1.0"?>
<%@page errorPage="/html/nds/error.jsp"%>
<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*,nds.control.event.*"%>

<%    /**
     * @param 
      		id - ad_client_id
     */
     
int ad_client_id=ParamUtils.getIntAttributeOrParameter(request, "id", -1);

String NDS_PATH=nds.util.WebKeys.NDS_URI;
UserWebImpl userWeb =null;
try{
	userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
}catch(Exception userWebException){
	//System.out.println("########## found userWeb=null##########"+userWebException);
}
if(userWeb==null || userWeb.isGuest()){
	String redirect=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString() ,"UTF-8");
	response.sendRedirect("/login.jsp?redirect="+redirect);
	return;
}
JSONObject tra=new JSONObject();
JSONObject params=new JSONObject();
params.put("p_action","alert(123)")
tra.put("table","m_allot");
tra.put("action","distribution");
tra.put("permission","r");
tra.put("isclob",true);

tra.put("param",params)


Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
DefaultWebEvent event=new DefaultWebEvent("CommandEvent");
event.setParameter("command", "DBJSON");
event.setParameter("jsonObject",jsonobj);
ClientControllerWebImpl controller=(ClientControllerWebImpl)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.WEB_CONTROLLER);
nds.control.util.ValueHolder vhRes=controller.handleEvent(event);	



<%if(vhRes!=null){%>
<h3>运行结果</h3>
return code:<%=vhRes.get("code")%> <p>
return message:<%=vhRes.get("message")%><p>
return data:<%=vhRes.get("data")%><p>

<%}%> 

%>
