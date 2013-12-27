<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%!
	private final static int MAX_COL_LENGTH=100;
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
    /**
     Convert to time
     @param du should be seconds
    */
    private String convertDuration(Object du){
    	int seconds= Tools.getInt(du, 0);
    	if(seconds>3600) return  (int)(seconds/3600)+"h"+  (int)((seconds%3600)/60)+"m";
    	if(seconds>60) return (int)(seconds/60)+"m" + (seconds%60)+"s";
    	return seconds+"s";
    }
    private final static String[] extTypes=new String[]{"pdf","xls","csv","taxifc","txt","log","html","htm","cub","cuz", "cus"};
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
	class TableFilter implements FileFilter{
			private String prefix;
			public TableFilter(String pre){
				prefix=pre;
			}
			public boolean accept(File pathname){
        		return pathname.getName().startsWith( prefix);
        	}
	}
	
%>
<%
	/**
	  @param id - ad_cxtab.id, must exists
	  
	*/
	int cxtabId=Tools.getInt( request.getParameter("id"),-1);
	int parentId=Tools.getInt( QueryEngine.getInstance().doQueryOne("select parent_id from ad_cxtab where id="+ cxtabId),-1);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd,HH:mm");
%>	
<table width="98%" align="center" cellpadding="2" cellspacing="1" class="sort-table">
	<thead><tr>
                <td align="center" width="80%">
                 <%=PortletUtils.getMessage(pageContext, "recent-reports",null)%>
                </td>
                <td align="center" width="5%" nowrap>
                 <%= PortletUtils.getMessage(pageContext, "file-size",null)%>
                </td>
                <td align="center" width="15%" nowrap>
                 <%= PortletUtils.getMessage(pageContext, "creation-time",null)%>
                </td>
    </tr></thead>
    	<%
			List al=QueryEngine.getInstance().doQueryList("select last_duration,last_rows,tot_time/cnt,tot_rows/cnt from ad_cxtab_stat where user_id="+userWeb.getUserId()+" and ad_cxtab_id="+cxtabId);
			if(al.size()>0){
				String lastDuration=convertDuration( ((List)al.get(0)).get(0));
				int lastRows=Tools.getInt( ((List)al.get(0)).get(1),0);
				String avgDuration= convertDuration( ((List)al.get(0)).get(2));
				int avgRows= Double.valueOf( (((List)al.get(0)).get(3)).toString() ).intValue();
				
		%>	
    <tr height="12" class='even-row'><td colspan="3">
    	<%= PortletUtils.getMessage(pageContext, "cxtab-duration-info",null).replace("V1",lastDuration).replace("V2",String.valueOf(lastRows)).replace("V3",avgDuration).replace("V4",String.valueOf(avgRows)) %>
    </td></tr>
		<%	
			}
    	%>
<%
    ReportUtils ru = new ReportUtils(request);
    String name = ru.getUserName();
    long spaceUsed = ru.getSpaceUsed();
    long spaceAvailable = ru.getQuota();

    String svrPath = ru.getExportRootPath() + File.separator  + ru.getUser().getClientDomain()+File.separator+ name;
    File dir = new File(svrPath);

    int fi =1; //line no
    File[] files=null;
    if(dir.exists() && dir.isDirectory()){
    	TableFilter tf=new TableFilter("CXR_"+cxtabId+"_");
        files = dir.listFiles(tf);
        files = sort(files);
        for(int i=0;i<files.length;i++){
            if(!files[i].isFile() || !files[i].canRead()) continue;
            boolean isJustNow= (files[i].lastModified()> System.currentTimeMillis()-1000*300);
            File descFile = new File(svrPath + File.separator + "desc" + File.separator + files[i].getName());
            StringBuffer desc =new StringBuffer("");
            if(descFile.exists() && descFile.isFile()){
                String tmp = nds.util.Tools.readFile(descFile.getAbsolutePath(), "UTF-8");
                desc.append(nds.util.StringUtils.escapeHTMLTags(tmp));
            }else{
            	desc.append("&nbsp;");
            }
            
            if(isJustNow){
%>
              <tr height="12" class='<%=(fi++%2==0?"even-row":"odd-row")%>'>
                <td width="80%">
                	<b><image src="<%=NDS_PATH+"/images/"+getFileTypeImage(files[i].getName())%>" border=0 height="16" width="16">
                <a href="<%=contextPath%>/servlets/binserv/GetFile?cd=attachment&filename=<%=java.net.URLEncoder.encode(files[i].getName(),"UTF-8")%>"><%=files[i].getName()%></a>
            	<%if(desc.length()>MAX_COL_LENGTH){%>
                	<span title="<%=desc%>"><%=nds.util.StringUtils.shorten(desc.toString(),MAX_COL_LENGTH,"...")%></span>
                <%}else{%>
                	<%=desc.toString()%>
                <%}%>
				</b>
                </td>
                <td  width="5%" nowrap><b><%=Tools.formatSize(files[i].length())%></b>
                </td>
                <td  width="15%" nowrap><b><%= PortletUtils.getMessage(pageContext, "in-five-minutes",null)%></b>
                </td>
              </tr>
<%			}else{%>
			<tr height="12" class='<%=(fi++%2==0?"even-row":"odd-row")%>'>
                <td width="80%">
                	<image src="<%=NDS_PATH+"/images/"+getFileTypeImage(files[i].getName())%>" border=0 height="16" width="16">
                <a href="<%=contextPath%>/servlets/binserv/GetFile?cd=attachment&filename=<%=java.net.URLEncoder.encode(files[i].getName(),"UTF-8")%>"><%=files[i].getName()%></a>
                <%if(desc.length()>MAX_COL_LENGTH){%>
                	<span title="<%=desc%>"><%=nds.util.StringUtils.shorten(desc.toString(),MAX_COL_LENGTH,"...")%></span>
                <%}else{%>
                	<%=desc.toString()%>
                <%}%>
                </td>
                <td  width="5%" nowrap>
                <%=Tools.formatSize(files[i].length())%>
                </td>
                <td  width="15%" nowrap>
                	<%=sdf.format(new Date(files[i].lastModified())).toString()%>
                </td>
              </tr>              
<%
        	}//end justNow
        
    	  }//end for
    	}
%>
        
        <tr class="<%=(fi++%2==0?"even-row":"odd-row")%>"><td align=center colspan=3>
        	<span class="finfo">
        <%= PortletUtils.getMessage(pageContext, "total-space",null)%> :<%=Tools.formatSize(spaceAvailable)%>,
        <%= PortletUtils.getMessage(pageContext, "space-used",null)%> :<%=Tools.formatSize(spaceUsed)%>,
    	<%= PortletUtils.getMessage(pageContext, "space-left",null)%> :<%=Tools.formatSize(spaceAvailable-spaceUsed)%></span>
        	<input type="button" class="cbutton" onclick="javascript:pc.refreshCxtabHistoryFiles(<%=cxtabId%>)" value="<%=PortletUtils.getMessage(pageContext, "refresh",null)%>">&nbsp;&nbsp;
		<%if(files!=null&& files.length>0){%>
        	<input id="btn_clear_cxtab_files" type="button" class="cbutton" onclick="javascript:pc.deleteCxtabFiles(<%=cxtabId%>)" value="<%=PortletUtils.getMessage(pageContext, "delete-cxtab-files",null)%>">
        <%}%>
        <script>
<%
 int dimensionCnt=Tools.getInt(QueryEngine.getInstance().doQueryOne("select count(*) from ad_cxtab_dimension where ad_cxtab_id="+cxtabId),-1);
 int warningDimCnt=Tools.getInt( ((Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS)).getProperty("cxtab.dimension.threshold", "5"), 5);
 if(dimensionCnt>warningDimCnt){
%> 
 if(confirm("<%=PortletUtils.getMessage(pageContext, "too-many-dims-warning",null).replace("0",dimensionCnt+">"+warningDimCnt)%>")){
 	pc.shrinkrep(<%=cxtabId%>,<%=parentId%>);
 }
<%}
%> 
        </script>
        </td>
        </tr>
        
</table>
