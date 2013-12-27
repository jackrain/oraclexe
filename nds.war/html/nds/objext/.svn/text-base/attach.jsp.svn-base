<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
    /**
     * Things needed in this page:
     *  table* - (int) table id
     *  column* - (int) column id
     *  objectid* - (int) record id
     *  version - (int ) -1 if not found
     */
%>
<%
	TableManager tableManager=TableManager.getInstance();
	int tableId= ParamUtils.getIntAttributeOrParameter(request, "table", -1);
	int columnId =ParamUtils.getIntAttributeOrParameter(request, "column", -1);
	int objectId= ParamUtils.getIntAttributeOrParameter(request, "objectid", -1);
	int version= ParamUtils.getIntAttributeOrParameter(request, "version", -1);
	Table table;
	if( tableId == -1) {
        	out.println(PortletUtils.getMessage(pageContext, "object-type-not-set",null));
        	return;
	}else{
    	table= tableManager.getTable(tableId);
	}
/**------check permission---**/
if(!userWeb.hasObjectPermission(table.getName(),objectId,  nds.security.Directory.READ)){
   	throw new NDSException(PortletUtils.getMessage(pageContext, "no-permission",null));
}
/**------check permission end---**/

	Column col=tableManager.getColumn(columnId);
	AttachmentManager attm=(AttachmentManager)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.ATTACHMENT_MANAGER);
	Attachment att= attm.getAttachmentInfo(userWeb.getClientDomain()+"/" + table.getRealTableName()+"/"+col.getName(),  objectId+"" , version);
	if(att!=null){
		String fileName= table.getName()+ "_"+ tableManager.getColumn(columnId).getName()+"_"+ objectId+"_"+att.getVersion()+"."+ att.getExtension();
        String ct= Tools.getContentType(att.getExtension(), "application/octetstream");
        response.setContentType(ct+"; charset=GBK");
        response.setContentLength((int)att.getSize());
        //if(ct.indexOf("text/")>-1|| ct.indexOf("image")>-1)
        response.setHeader("Content-Disposition","inline;filename=\""+fileName+"\"");
	
		InputStream is=attm.getAttachmentData(att);
            ServletOutputStream os = response.getOutputStream();
            byte[] b = new byte[8192];
            int bInt;
            while((bInt = is.read(b,0,b.length)) != -1)
            {
                os.write(b,0,bInt);
            }
            os.flush();
            os.close();

		return;
	}
		
	

%>
<html>
<head><title>Attachment</title></head>
<body>
<p> File not found!
</body>
</html>
