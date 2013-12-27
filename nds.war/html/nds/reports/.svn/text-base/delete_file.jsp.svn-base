<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="java.io.*,nds.control.web.*,nds.util.*,nds.report.*" %>
<%
try{
    ReportUtils ru = new ReportUtils(request);
    String name = ru.getUserName();
    String svrPath = ru.getExportRootPath() + File.separator + ru.getUser().getClientDomain()+File.separator+ name;
    String[] fileNames = request.getParameterValues("filename");
    
    String msg = "";
    nds.control.util.ValueHolder vh = new nds.control.util.ValueHolder();

    if(fileNames !=null){
    for(int i = 0;i < fileNames.length;i++){
        String filePath = fileNames[i];
        if(filePath!=null && !filePath.trim().equals("")){
            filePath = filePath.trim();
            File file = new File(svrPath+File.separator+filePath);

            if(file.exists() && file.isFile()){
                File desc = new File(svrPath+File.separator+"desc"+File.separator+filePath);
                if(file.delete())
                {
                    String a = "";
                    msg +=  PortletUtils.getMessage(pageContext, "file",null)+"("+file.getName()+") "+PortletUtils.getMessage(pageContext, "deleted",null);
                }else{
                    msg += "<font color=red>"+PortletUtils.getMessage(pageContext, "file",null)+"("+file.getName()+") "+PortletUtils.getMessage(pageContext, "fail-to-delete",null)+"</font>";
                }
            }else
                msg += PortletUtils.getMessage(pageContext, "file",null)+" "+fileNames[i]+" "+  PortletUtils.getMessage(pageContext, "not-exists",null);
        }//end if
    }//end for
    vh.put("message",msg);
    request.setAttribute(nds.util.WebKeys.VALUE_HOLDER,vh);
    }
}catch(Exception ex){
    request.setAttribute("error",ex);
}
pageContext.getServletContext().getRequestDispatcher(NDS_PATH+"/reports/index.jsp").forward(request,response);
%>
