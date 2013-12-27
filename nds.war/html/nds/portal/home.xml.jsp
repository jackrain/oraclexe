<?xml version="1.0"?>
<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>
<tree>
<tree icon="/html/nds/images/table.gif"  text="<%=PortletUtils.getMessage(pageContext, "new-user-guide",null)%>" action="javascript:pc.navigate('/html/nds/custom/newuser.html')"/>       
<tree icon="/html/nds/images/table.gif"  text="<%=PortletUtils.getMessage(pageContext, "object-portal",null)%>" action="javascript:pc.navigate('/html/nds/portal/tables.jsp')"/>      
<tree icon="/html/nds/images/table.gif"  text="<%=PortletUtils.getMessage(pageContext, "javax.portlet.title.ndsaudit1",null)%>" action="javascript:pc.navigate('/html/nds/audit/view.jsp')"/>
<tree icon="/html/nds/images/table.gif"  text="<%=PortletUtils.getMessage(pageContext, "my-folder",null)%>" action="javascript:pc.navigate('/html/nds/portal/myfolder.jsp')"/>	
</tree>    	       
