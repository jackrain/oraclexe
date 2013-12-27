<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
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
<div id="folder-note"> <%= PortletUtils.getMessage(pageContext, "folder-note",null)%> </div>
<div id="page-nav-commands"></div>
<div id="clearline"></div>
<form id="myfolderfm" action="<%=NDS_PATH%>/reports/delete_file.jsp" method="post">
<table id="inc_table" width="95%" cellpadding="2" cellspacing="1" class="sort-table">
	<thead><tr>
                <td align="center" width="1%" nowrap>
                 <input type='checkbox' class="checkbox" id='chk_select_all' value="1" onclick="pc.checkAll($('myfolderfm'))"><%= PortletUtils.getMessage(pageContext, "select-all",null)%>
                </td>
                <td align="center"  width="80%" >
                 <%= PortletUtils.getMessage(pageContext, "file-name",null)%>
                </td>
                <td align="center" width="5%" nowrap>
                 <%= PortletUtils.getMessage(pageContext, "file-size",null)%>
                </td>
                <td align="center" width="14%" nowrap>
                 <%= PortletUtils.getMessage(pageContext, "creation-time",null)%>
                </td>
    </tr></thead>
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
                <td align="center" widht="1%">
                <input type='checkbox' class="checkbox" name='itemid' value="<%=files[i].getName()%>" onclick="pc.unselectall()">
                </td>
                <td width="80%"><image src="<%=NDS_PATH+"/images/"+getFileTypeImage(files[i].getName())%>" border=0 height=16 width=16>
                <a href="<%=contextPath%>/servlets/binserv/GetFile?filename=<%=java.net.URLEncoder.encode(files[i].getName(),"UTF-8")%>"><%=files[i].getName()%></a>
                <%=desc%>
                </td>
                <td width="5%" nowrap>
                <%=Tools.formatSize(files[i].length())%>
                </td>
                <td width="14%" nowrap>
                <%=sdf.format(new Date(files[i].lastModified())).toString()%>
                </td>
              </tr>
<%
        }
        
    }else{
        
    }
%>
        
        <tr bgcolor='<%=(fi++%2==0?"#FFFFFF":"#EEEEEE")%>'><td align=center colspan=5><span class="finfo">
        <%= PortletUtils.getMessage(pageContext, "total-space",null)%> :<%=Tools.formatSize(spaceAvailable)%>,
        <%= PortletUtils.getMessage(pageContext, "space-used",null)%> :<%=Tools.formatSize(spaceUsed)%>,
    	<%= PortletUtils.getMessage(pageContext, "space-left",null)%> :<%=Tools.formatSize(spaceAvailable-spaceUsed)%></span>
<script>
	var bt1=new TableCommand("Delete", gMessageHolder.CMD_DELETE,"tb_delete.gif",null,"pc.doDeleteFile");
	var bt2=new TableCommand("Refresh", gMessageHolder.CMD_REFRESH,"tb_refresh.gif",null,"pc.doRefreshMyFolder");
	var str="<div class='table-buttons'>"+bt1.toButtonString()+bt2.toButtonString()+"</div>";
	$("page-nav-commands").innerHTML=str;
	 var selTb= new SelectableTableRows(document.getElementById("inc_table"), false);

</script>		
        </td>
        </tr>
</table>
</form>
	

