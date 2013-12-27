<?xml version="1.0"?>
<%@page errorPage="/html/nds/error.jsp"%>

<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>

<%    /**
     * @param 
      		id - tablecategory.id	
     */
     
int tablecategoryId=  ParamUtils.getIntAttributeOrParameter(request, "id", -1);

String NDS_PATH=nds.util.WebKeys.NDS_URI;
UserWebImpl userWeb =null;
try{
	userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
}catch(Exception userWebException){
	System.out.println("########## found userWeb=null##########"+userWebException);
}
Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
nds.query.web.SubSystemView ssv=new nds.query.web.SubSystemView();

//elements are ArrayList, first is cxtab id, second is cxtab name
List cxtabs=ssv.getCxtabs(request,tablecategoryId );

%>
<tree>
<%
for(int j=0;j<cxtabs.size();j++){
	List t=(List)cxtabs.get(j); 
%>
	<tree icon="/html/nds/images/cxtab.gif"  text="<%=StringUtils.escapeForXML( (String)t.get(1))%>" action="javascript:pc.qrpt('<%=t.get(0)%>')"/>       
<%			
	
}
%>
</tree>    
