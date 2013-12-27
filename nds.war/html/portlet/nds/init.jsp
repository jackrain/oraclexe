<%@ include file="/html/portlet/init.jsp" %>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.web.config.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>
<%
	String NDS_PATH=nds.util.WebKeys.NDS_URI;
	int RES_TOTAL=1024;
	String contextPath="";
	if(themeDisplay==null) themeDisplay= nds.portlet.util.UserUtils.getDefaultThemeDisplay();
	String  COMMON_IMG=themeDisplay.getPathThemeImage();
	
	// tab width in tag page
	int DEFAULT_TAB_WIDTH=740;
	UserWebImpl userWeb =null;
	try{
		userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
	}catch(Throwable userWebException){
		System.out.println("########## count not find userWeb:##########"+userWebException);
	}
	if(colorScheme==null)colorScheme= nds.portlet.util.UserUtils.getDefaultColorScheme();
	PortletPreferences prefs = renderRequest.getPreferences();
	
	String portletResource = ParamUtil.getString(request, "portletResource");
	
	if (Validator.isNotNull(portletResource)) {
		prefs = PortletPreferencesFactory.getPortletSetup(request, portletResource, true, true);
	}
	
	String defaultPage = "";//GetterUtil.getString(prefs.getValue("default-page", StringPool.BLANK));
	String NDS_WEBPATH = contextPath + "/html/portlet/nds";
%>


