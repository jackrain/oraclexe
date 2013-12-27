<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="nds.control.event.*"%>

<%
    QueryRequestImpl qRequest = null;
    qRequest= (QueryRequestImpl)request.getAttribute("query");
    //QueryResult result = QueryEngine.getInstance().doQuery(qRequest);
    ReportUtils ru = new ReportUtils(request);

    nds.control.util.ValueHolder vh = new nds.control.util.ValueHolder();

    DefaultWebEvent event=new DefaultWebEvent("CommandEvent");
    event.put("nds.query.querysession",userWeb.getSession());
    
     //event parameter:path
    String operatorid=""+userWeb.getUserId();

    //event parameter:operatorid
    event.setParameter("operatorid", operatorid);
    event.put("request", qRequest);
	event.put("groupname", request.getParameter("groupname"));
	event.put("recordno", request.getParameter("recordno"));
	event.put("reportname", request.getParameter("reportname"));
	event.put("lines", request.getParameter("lines"));
	event.put("priority", request.getParameter("priority"));
	event.put("ad_processqueue_name", request.getParameter("ad_processqueue_name"));
    event.setParameter("command", "CreateSMSReport");
    ClientControllerWebImpl controller=(ClientControllerWebImpl)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.WEB_CONTROLLER);
   	request.setAttribute(nds.util.WebKeys.VALUE_HOLDER,controller.handleEvent(event));
    pageContext.getServletContext().getRequestDispatcher(NDS_PATH+"/info.jsp").forward(request,response);
%>
