<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
	/**
	Execute process instance immediately
	@param objectid - ad_pinstance.id
	*/
	int objectId= Tools.getInt(request.getParameter("objectid"),-1);
	// check user modify permission on that instance
	if(!userWeb.hasObjectPermission("ad_pinstance", objectId, nds.security.Directory.WRITE)){
		throw new NDSException(PortletUtils.getMessage(pageContext, "no-permission",null));
	}
	ValueHolder vh=nds.process.ProcessUtils.executeImmediateADProcessInstance(objectId , userWeb.getUserId(), false);
	if(vh.get("message")==null) vh.put("message","@complete@");
	request.setAttribute(nds.util.WebKeys.VALUE_HOLDER,vh);
    pageContext.getServletContext().getRequestDispatcher(NDS_PATH+"/info.jsp").forward(request,response);
%>
