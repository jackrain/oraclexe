<%@page errorPage="/html/nds/error.jsp"%>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="nds.report.*" %>
<%
/**
*  return OutputStream of JasperReport object, this page could only be viewed from localhost
*  for security concern
*  @param id(*) - report id 
*  @param client(*) - client domain
*  @param version - version number, default to -1
*
*/
	TableManager manager=TableManager.getInstance();
	Table table=manager.getTable("ad_report");
	int tableId= table.getId();
	int columnId =manager.getColumn("ad_report", "FILEURL").getId();
	int objectId= ParamUtils.getIntAttributeOrParameter(request, "id", -1);
	int version= ParamUtils.getIntAttributeOrParameter(request, "version", -1);
	String clientName= request.getParameter("client");
	System.out.println("clientname="+ clientName+",report id="+ objectId);
	if( tableId == -1) {
       	out.println(PortletUtils.getMessage(pageContext, "object-type-not-set",null));
       	return;
	}
	
/**------check permission---**/
/*if(!userWeb.hasObjectPermission(table.getName(),objectId,  nds.security.Directory.READ)){
   	throw new NDSException(PortletUtils.getMessage(pageContext, "no-permission",null));
}*/
/**------check permission end---**/

	Column col=manager.getColumn(columnId);
	AttachmentManager attm=(AttachmentManager)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.ATTACHMENT_MANAGER);
	Attachment att= attm.getAttachmentInfo(clientName+"/" + table.getRealTableName()+"/"+col.getName(),  objectId+"" , version);
	if(att!=null){
		String fileName= table.getName()+ "_"+ manager.getColumn(columnId).getName()+"_"+ objectId+"_"+att.getVersion()+"."+ att.getExtension();
	
		File reportXMLFile=attm.getAttachmentFile(att);
		// generate jasperreport if file not exists or not newer
		String reportName=reportXMLFile.getName().substring(0, reportXMLFile.getName().lastIndexOf("."));
		File reportJasperFile = new File(reportXMLFile.getParent(), reportName+ ".jasper");
		if( !reportJasperFile.exists()|| reportJasperFile.lastModified()<reportXMLFile.lastModified()){
			JasperCompileManager.compileReportToFile(reportXMLFile.getAbsolutePath(),reportJasperFile.getAbsolutePath() );
		}
		InputStream is=new FileInputStream(reportJasperFile);
        response.setContentType("application/octetstream;");
        response.setContentLength((int)reportJasperFile.length());
        
        response.setHeader("Content-Disposition","inline;filename=\""+reportJasperFile.getName()+"\"");
        ServletOutputStream os = response.getOutputStream();
        byte[] b = new byte[8192];
        int bInt;
        while((bInt = is.read(b,0,b.length)) != -1)
            {
                os.write(b,0,bInt);
            }
		is.close();
		return;
	}
		
	

%>
<html>
<head><title>Attachment</title></head>
<body>
<p> File not found!
</body>
</html>  

