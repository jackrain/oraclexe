<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
	String tabName=PortletUtils.getMessage(pageContext, "export-folder",null);
	// to enable context menu, "enable_context_menu" attribute must be set to true
	// and header.jsp should has "enable_context_menu" to true too
	request.setAttribute("enable_context_menu", "true");
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=tabName%>" />
	<liferay-util:param name="enable_context_menu" value="true" />
</liferay-util:include>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1"><br>
<%!
    /**
    Sort by modifieddate descending
    */
    private File[] sort(File[] files) {
        Vector v=new Vector();
        for( int i=0;i< files.length;i++) {
            v.addElement(files[i]);
        }
        nds.util.ListSort.sort(v, "lastModified", false);
        File[] fs=new File[ v.size()];
        for( int i=0;i< fs.length;i++) {
            fs[i]= (File) v.elementAt(i);
        }
        return fs;
    }
    private final static String[] extTypes=new String[]{"pdf","xls","csv","taxifc","txt","log","html","htm","cub"};
    /**
    * get file type image according to file extension
    */
    private String getFileTypeImage(String fileName){
    	String ext= fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
    	
    	String imgsrc="file";
    	for(int i=0;i<extTypes.length;i++){
    		if(ext.equals(extTypes[i])){
    			imgsrc=ext;
    			break;
    		}
    	}
    	return "ext_"+imgsrc+".gif";
    }

%>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd,HH:mm");
%>

<table width="98%" border="0" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" bordercolorlight="#cccccc" align="center">
<form name="form1" action="<%=NDS_PATH%>/reports/delete_file.jsp" method="post">
<input type="hidden" name="action" value="modify">
<tr><td height="30" valign='top'>
<input  type='button'  value='<%= PortletUtils.getMessage(pageContext, "object.delete",null)%>'  onclick='submitForm(form1)'>
<input  type='button'  value='<%= PortletUtils.getMessage(pageContext, "object.refresh",null)%>' onclick='javascript:window.location="<%=NDS_PATH%>/reports/index.jsp"' >
<script>
function selectAll(){
	 var es=document.getElementsByClassName("checkbox");
	 var b= document.getElementById("seall").checked;
	 if(es!=null)for(var i=0;i<es.length;i++){
	 	es[i].checked=b;
	}
}
</script>	
</td></tr>
<tr><td>
			<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" id="modify_table">
			<thead>
              <tr>
                <td align="center" nowrap>
                <%= PortletUtils.getMessage(pageContext, "select",null)%><input id="seall" type="checkbox" onchange="selectAll()">
                </td>
                <td align="center">
                 <%= PortletUtils.getMessage(pageContext, "file-name",null)%>
                </td>
                
                <td align="center">
                 <%= PortletUtils.getMessage(pageContext, "description",null)%>
                </td>
                <td align="center">
                 <%= PortletUtils.getMessage(pageContext, "file-size",null)%>
                </td>
                <td align="center">
                 <%= PortletUtils.getMessage(pageContext, "creation-time",null)%>
                </td>
              </tr>
             </thead>
<%
    ReportUtils ru = new ReportUtils(request);
    String name = ru.getUserName();
    long spaceUsed = ru.getSpaceUsed();
    long spaceAvailable = ru.getQuota();

    String svrPath = ru.getExportRootPath() + File.separator  + ru.getUser().getClientDomain()+File.separator+ name;
    File dir = new File(svrPath);

    int fi =1; //line no
    if(dir.exists() && dir.isDirectory()){
        File[] files = dir.listFiles();
        files = sort(files);
        for(int i=0;i<files.length;i++){
            if(!files[i].isFile() || !files[i].canRead()) continue;
            File descFile = new File(svrPath + File.separator + "desc" + File.separator + files[i].getName());
            StringBuffer desc =new StringBuffer("");
            if(descFile.exists() && descFile.isFile()){
                String tmp = nds.util.Tools.readFile(descFile.getAbsolutePath(), "UTF-8");
                desc.append(nds.util.StringUtils.escapeHTMLTags(tmp));
            }else{
            	desc.append("&nbsp;");
            }
            
%>
              <tr height="12" class='<%=(fi++%2==0?"even-row":"odd-row")%>'>
                <td align="center">
                <input type='checkbox' class="checkbox" name='filename' value="<%=files[i].getName()%>">
                </td>
                <td><image src="<%=NDS_PATH+"/images/"+getFileTypeImage(files[i].getName())%>" border=0 height=16 width=16>
                <a href="<%=contextPath%>/servlets/binserv/GetFile?filename=<%=java.net.URLEncoder.encode(files[i].getName(),"UTF-8")%>" title="<%=desc%>"><%=files[i].getName()%></a>
                </td>
                <td>
                <%=desc.substring(0,desc.length() > 15?15:desc.length())%>
                </td>
                <td>
                <%=Tools.formatSize(files[i].length())%>
                </td>
                <td>
                <%=sdf.format(new Date(files[i].lastModified())).toString()%>
                </td>
              </tr>
<%
        }
        
    }else{
        
    }
%>
        
        <tr class='<%=(fi++%2==0?"odd-row":"even-row")%>'><td align=center colspan=5>
        <%= PortletUtils.getMessage(pageContext, "total-space",null)%> :<%=Tools.formatSize(spaceAvailable)%>,
        <%= PortletUtils.getMessage(pageContext, "space-used",null)%> :<%=Tools.formatSize(spaceUsed)%>,
        <%= PortletUtils.getMessage(pageContext, "space-left",null)%> :<%=Tools.formatSize(spaceAvailable-spaceUsed)%>
        </td></tr>
        </table> 
        </td>
        </tr>
</form>
</table>
<script>
 new SelectableTableRows($("modify_table"), false);
</script>	
<br>
    </div>
</div>		
<%@ include file="/html/nds/footer.jsp" %>
