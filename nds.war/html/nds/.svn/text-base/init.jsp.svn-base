<%@ include file="/html/common/init.jsp" %>
<%@ taglib uri='/WEB-INF/tld/input.tld' prefix='input' %>

<%@

    page import="nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,
                java.util.*,nds.control.util.*,nds.portlet.util.*"
    
%>
<portlet:defineObjects />
<%
	String NDS_PATH=nds.util.WebKeys.NDS_URI;
	// tab width in tag page
	int DEFAULT_TAB_WIDTH=740;
	UserWebImpl userWeb =null;
	try{
		userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
	}catch(Exception userWebException){
		System.out.println("########## found userWeb=null##########"+userWebException);
	}
	
%>

