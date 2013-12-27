<%
 // there must set company id in session, while current session may be invalid.
 /*if(session.getAttribute(com.liferay.portal.util.WebKeys.COMPANY_ID)==null){
 	session.setAttribute(com.liferay.portal.util.WebKeys.COMPANY_ID,(String)application.getAttribute(com.liferay.portal.util.WebKeys.COMPANY_ID));
 }*/
 nds.portlet.util.UserUtils.initPageContext(request, response); // portal4.0
%>
<%@ include file="/html/common/init.jsp" %>
<%@ taglib uri='/WEB-INF/tld/input.tld' prefix='input' %>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>

<%
	String NDS_PATH=nds.util.WebKeys.NDS_URI;
	String contextPath="";
	int RES_TOTAL=1024;
	//if(themeDisplay==null) themeDisplay= nds.portlet.util.UserUtils.getDefaultThemeDisplay();
	String  COMMON_IMG=themeDisplay.getPathThemeImage();
	
	// tab width in tag page
	int DEFAULT_TAB_WIDTH=740;
	UserWebImpl userWeb =null;
	if(ShutdownUtil.isShutdown()){
		session.invalidate();
	}

	try{
		userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
	}catch(Throwable userWebException){
		System.out.println("########## found userWeb=null##########"+userWebException);
	}
	if(colorScheme==null)colorScheme= nds.portlet.util.UserUtils.getDefaultColorScheme();
%>

