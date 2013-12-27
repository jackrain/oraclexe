<?xml version="1.0"?>
<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>
<tree>
<tree icon="/html/nds/images/table.gif"  text="<%=PortletUtils.getMessage(pageContext, "new-user-guide",null)%>" action="javascript:pc.navigate('/html/nds/custom/newuser.html')"/>       
<tree icon="/html/nds/images/table.gif"  text="<%=PortletUtils.getMessage(pageContext, "my-folder",null)%>" action="javascript:pc.navigate('/html/nds/portal/myfolder.jsp')"/>	
<%
 if("root".equals(userWeb.getUserName())){
 	//currently only support alisoft to add money
 	if (Tools.getInt(QueryEngine.getInstance().doQueryOne("select count(*) from users where id="+ userWeb.getUserId()+" and saasvendor='alisoft'"),0)>0){
 		// add money page here
 		String payurl=(String)session.getAttribute("payurl");
 		if(payurl!=null){ payurl=StringUtils.escapeForXML(payurl);
%>
	<tree icon="/html/nds/images/table.gif"  text="<%=PortletUtils.getMessage(pageContext, "pay-money",null)%>" action="javascript:popup_window('<%=payurl%>')"/>
<%		}%>		
	<tree icon="/html/nds/images/table.gif"  text="<%=PortletUtils.getMessage(pageContext, "change-password",null)%>" action="javascript:showObject('/html/nds/security/changepassword.jsp')"/>	
<% 		
 	}
 }
%>
</tree>    	       
