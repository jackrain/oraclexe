<%
//load cache from file system
    ReportUtils ru = new ReportUtils(request);
    String name = ru.getUserName();
	
    String filePath = ru.getExportRootPath() + File.separator+ 
    		ru.getUser().getClientDomain()+File.separator+ name+File.separator+"olap"+File.separator+reportName+".cache";
    File file = new File(filePath);
    graphCacheExists=file.exists();
	if(graphCacheExists){
		Tools.readFileToWriter(file,out,8192);
		graphUpdateDate=((java.text.SimpleDateFormat)QueryUtils.smallDateTimeSecondsFormatter.get()).format(new Date(file.lastModified()));
	}else{
		out.print(PortletUtils.getMessage(pageContext, "no-display-data",null));
	}
%>

