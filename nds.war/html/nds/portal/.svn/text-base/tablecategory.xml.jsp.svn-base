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

List categoryChildren=ssv.getChildrenOfTableCategory(request,tablecategoryId,true/*include webaction*/ );
Locale locale =userWeb.getLocale();
int tableId;
Table table;
//Locale locale =userWeb.getLocale();
HashMap actionEnv = new HashMap();
actionEnv.put("httpservletrequest", request);
actionEnv.put("userweb", userWeb);

String url,cdesc,tdesc;
%>
<tree>
<%
for(int j=0;j<categoryChildren.size();j++){
	if(categoryChildren.get(j)  instanceof Table){
		table=(Table)categoryChildren.get(j);
		tableId =table.getId(); 
		tdesc=table.getDescription(locale);
%>
	<tree icon="/html/nds/images/table.gif"  text="<%=StringUtils.escapeForXML(tdesc)%>" action="javascript:pc.navigate('<%=tableId%>')"/>       
	<%			
	}else if(categoryChildren.get(j)  instanceof WebAction){
		WebAction action=(WebAction)categoryChildren.get(j);
%>
	<%=action.toHTML(locale,actionEnv)%>
<%			
	}
}
%> 
 	<tree text="<%= PortletUtils.getMessage(pageContext, "ref-report",null)%>" src="<%="/html/nds/portal/catrpt.xml.jsp?id="+tablecategoryId%>">
 	</tree>
</tree>    
