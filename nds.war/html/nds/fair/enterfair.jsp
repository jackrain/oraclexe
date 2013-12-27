<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>

<%   /**
     * 确认用户是经销商，且存在当前有效的订货会
     */
String NDS_PATH=nds.util.WebKeys.NDS_URI;
UserWebImpl userWeb =null;
try{
	userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
}catch(Exception userWebException){
	System.out.println("########## found userWeb=null##########"+userWebException);
}
boolean hasValidFairs=false;
try{
	hasValidFairs =(nds.fair.FairManager.getInstance().loadFairs(userWeb).size()>0);
}catch(Throwable t){
}
if(hasValidFairs ){
%>
<tree icon="/html/nds/images/outhome.gif"  text="进入订货会" action="javascript:popup_window('/html/nds/fair/index.jsp')"/>
<%}%>	