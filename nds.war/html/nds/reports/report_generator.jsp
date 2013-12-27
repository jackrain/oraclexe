<%@ include file="/html/nds/header.jsp" %>
<%@ page import="nds.control.event.*"%>
<%!
	private final static int MAX_REPORT_LINES= 65535; //最大导出行数
	private final static nds.log.Logger logger=nds.log.LoggerManager.getInstance().getLogger("ReportGenerator");
%>
<%
//try{
    String sql = request.getParameter("sql");
    String columnNames = request.getParameter("columnNames");
    QueryRequestImpl qRequest = null;
    qRequest= (QueryRequestImpl)request.getAttribute("query");
    //System.out.println("qRequest:"+ qRequest.getParamExpression());
    QueryResult result = QueryEngine.getInstance().doQuery(qRequest);
    if(result == null){
  	if(sql == null)
        {
            out.println("Internal Error: can not find ResultSet Object or SQL!");
  	    return;
        }
    }else{
        //qRequest = result.getQueryRequest();
    }
	if(qRequest!=null){
		logger.debug("User:"+ userWeb.getUserDescription()+"(id="+ userWeb.getUserId()+"), Query:"+ qRequest.getParamDesc(true));
	}else{
		logger.debug("User:"+ userWeb.getUserDescription()+"(id="+ userWeb.getUserId()+"), Query:"+ sql);
	}
    ReportUtils ru = new ReportUtils(request);
    String name = ru.getUserName();

    String svrPath = ru.getExportRootPath() + File.separator +  ru.getUser().getClientDomain()+File.separator+ name;

    boolean pk = (request.getParameter("pk") != null && request.getParameter("pk").equals("yes"))?true:false;
    boolean ak = (request.getParameter("ak") != null && request.getParameter("ak").equals("yes"))?true:false;
    boolean onlyPage = (request.getParameter("page") != null && request.getParameter("page").equals("yes"))?true:false;
    boolean column = (request.getParameter("column") != null && request.getParameter("column").equals("yes"))?true:false;
    boolean title = (request.getParameter("title") != null && request.getParameter("title").equals("yes"))?true:false;
    String extension = request.getParameter("extension");
    String separator = request.getParameter("txt");
    separator = (separator == null || separator.trim().equals(""))?",":separator.trim();
    String fileName = request.getParameter("fname").trim() + "." + extension;
    String filePath = svrPath + File.separator + fileName;
    String descPath = svrPath + File.separator + "desc" + File.separator + fileName;
    File file = new File(filePath);
    File desc = new File(descPath);

    nds.control.util.ValueHolder vh = new nds.control.util.ValueHolder();


    DefaultWebEvent event=new DefaultWebEvent("CommandEvent");
    String operatorid=""+userWeb.getUserId();
    //event parameter:operatorid
    event.setParameter("operatorid", operatorid);
    //event parameter:filename
    event.setParameter("filename",fileName);
    //header：传给event的参数，descContent：写入说明文件的数据
    String header = null,descContent = "";


    //数据范围，是当前页还是所有数据
    if(onlyPage){//当前页
        	sql=qRequest.getSQLForReportWithRange(pk,ak);
            event.setParameter("sql",sql);
    }else{//所有数据
            if(qRequest != null){
                sql=qRequest.getSQLForReport(pk,ak);
                event.setParameter("sql",sql);
            }else if(sql != null){//直接SQL语句传进来的时候
                event.setParameter("sql",sql);
            }
    }
    event.put("request", qRequest);
    event.setParameter("separator",separator);
	event.setParameter("location", svrPath);
	event.put("showname", new Boolean(column));
	event.put("ak", new Boolean(ak));
	event.put("pk", new Boolean(pk));


    ClientControllerWebImpl controller=(ClientControllerWebImpl)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.WEB_CONTROLLER);
    boolean isExcel=extension.equalsIgnoreCase("xls");
    boolean isnewExcel=extension.equalsIgnoreCase("xlsx");
    //System.out.println(extension);
    //System.out.println(isnewExcel); 
	if (isExcel){
	    event.setParameter("command", "ExportExcel");
    }else if(isnewExcel){ 
    	//System.out.println("newxlsx"); 
    	 event.setParameter("command", "ExportExcel");
    }else{
	    event.setParameter("command", "ExportText");
	}
	nds.control.util.ValueHolder vhRes=controller.handleEvent(event);	
  	request.setAttribute(nds.util.WebKeys.VALUE_HOLDER,vhRes);
    if(vhRes.isOK()){
	    response.sendRedirect("/servlets/binserv/Download?filename="+java.net.URLEncoder.encode(fileName,"UTF-8"));
	    return;
	}else{
	    pageContext.getServletContext().getRequestDispatcher(NDS_PATH+"/reports/index.jsp").forward(request,response);
	}
%>
