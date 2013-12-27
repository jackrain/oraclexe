<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>
<script language="javascript" src="/cost/cost.js"></script>

<%   /**
     * 确认用户是经销商，且存在当前有效的订货会
     */
String NDS_PATH=nds.util.WebKeys.NDS_URI;
UserWebImpl userWeb =null;
boolean product_cost=false;
try{
	userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
	Table ta1=TableManager.getInstance().getTable("B_SLPRICEADJ");
	Table ta2=TableManager.getInstance().getTable("B_RTPADJ");
	if((userWeb.getPermission(ta1.getSecurityDirectory())& nds.security.Directory.WRITE)== nds.security.Directory.WRITE ||(userWeb.getPermission(ta2.getSecurityDirectory())& nds.security.Directory.WRITE)== nds.security.Directory.WRITE ){
			product_cost =true;
	}
}catch(Exception userWebException){
	System.out.println("########## found userWeb=null##########"+userWebException);
}
if(product_cost){
if(request.getHeader("User-Agent").toString().indexOf("Firefox")!=-1){
%>
<tree icon="/html/nds/images/outhome.gif"  text="<%= PortletUtils.getMessage(pageContext, "price-adjust-module",null)%>" action="javascript:showObject('/cost/cost_adjust.jsp',957,523)"/>
<%
}else{
%>
<tree icon="/html/nds/images/outhome.gif"  text="<%= PortletUtils.getMessage(pageContext, "price-adjust-module",null)%>" action="javascript:showObject('/cost/cost_adjust.jsp',958,520)"/>
<%
}
%>
<%}%>