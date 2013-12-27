<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%@ page import="nds.security.*"%>
<%
	String tabName= PortletUtils.getMessage(pageContext, "groupperm2",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<style>
.tabinputline {  
	font: normal 9pt "Verdana", "Arial", "Helvetica", "sans-serif"; 
	border: solid; 
	border-color: #CCCCCC #999999 #000000; 
	vertical-align: middle; 
	border-width: 0px; 
	color: #666666;
	width:550px;
}
</style>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%!
    TableManager manager;
    /**
     * @return array of 3 elements
     *        1. int Directory.READ , Directory.WRITE or -1 if no permission found
     *        2. String description of sqlfilter, if null,means no
     		  3. List<FkFilter> of current dirId;	
     */
    private ArrayList getPermission(int groupId, int dirId, nds.security.GroupFkFilter gff)throws Exception{
    	int ret=0; String filterDesc=null, filterIds="";
        List res= QueryEngine.getInstance().doQueryList("select permission ,filterdesc,SEC_FKFILTER_IDS from groupperm where groupId="+groupId +" and directoryid="+ dirId);
        if(res.size()>0){
        	List o=(List)res.get(0);
            ret= Tools.getInt( o.get(0),-1);
            filterDesc= (String) o.get(1);
            filterIds= (String) o.get(2);
        }
        ArrayList al=new ArrayList();
        al.add(new Integer(ret));
        al.add(filterDesc);
        al.add(gff.list(filterIds));
        return al;
    }
    /**
    * show write detail of the table definition
    */
    private String showWriteDetail(Table table, PageContext pageContext){
    	String s="";
    	if (table ==null){ s+=PortletUtils.getMessage(pageContext, "permission-exec",null); return s;}
    	if( table.isActionEnabled(Table.ADD)) s +=PortletUtils.getMessage(pageContext, "permission-add-short",null);
    	if( table.isActionEnabled(Table.MODIFY)) s +=PortletUtils.getMessage(pageContext, "permission-modify-short",null);
    	if( table.isActionEnabled(Table.DELETE)) s +=PortletUtils.getMessage(pageContext, "permission-delete-short",null);
    	return s;
    }
%>
<%
    /**
     * Will allowing to set permission on directory one by one
     * parameter:
     *      1.  id  - group Id
     *      2. catalog - directory ad_tablecategory_id
     */
String directory;
directory="GROUPPERM_LIST";
WebUtils.checkDirectoryReadPermission(directory,request);//判断当前用户是否有读的权限

manager=TableManager.getInstance();
Table table= manager.getTable("Groups");
int tableId= table.getId();
String catalog= request.getParameter("catalog");
int groupId= ParamUtils.getIntParameter(request, "id", -1);
int subsystemId= ParamUtils.getIntParameter(request, "subsystemId", -1);
ResultSet res= QueryEngine.getInstance().doQuery("select name, description from groups where id="+groupId);
if(!res.next()){
   out.println("Not found specified group!");
   return;
}
String groupName=res.getString(1);
String groupDesc= res.getString(2);
res.close();

nds.security.GroupFkFilter gff=new nds.security.GroupFkFilter(groupId);

res=QueryEngine.getInstance().doQuery("select d.id,d.name, d.description,d.url, d.ad_table_id from directory d, ad_table t where d.ad_tablecategory_id="+catalog+" and t.id(+)=d.ad_table_id and t.isactive='Y' and instr(t.name,'ITEM')=0 order by t.orderno");

%>
<Script language="javascript">
	function table_selectAll(tableId){
		$(tableId+"a").checked= $(tableId+"a").checked |0;
		if ($(tableId+"r")!=null) {
			$(tableId+"r").checked=$(tableId+"a").checked;
		}
		if ($(tableId+"w")!=null) {
			$(tableId+"w").checked=$(tableId+"a").checked;
		}
		if ($(tableId+"u")!=null) {
			$(tableId+"u").checked=$(tableId+"a").checked;
		}
		if ($(tableId+"s")!=null) {
			$(tableId+"s").checked=$(tableId+"a").checked;
		}	
			$(tableId+"e").checked=$(tableId+"a").checked;
			$(tableId+"c").checked=$(tableId+"a").checked;
	}
	
	function table_unselectall(tableId){
  		$(tableId+"a").checked=$(tableId+"r").checked&&$(tableId+"e").checked;
  		if ($(tableId+"w")!=null) {
  			$(tableId+"a").checked=$(tableId+"a").checked&&$(tableId+"w").checked;
  		}
  		if ($(tableId+"s")!=null) {
  			$(tableId+"a").checked=$(tableId+"a").checked&&$(tableId+"s").checked;
  		}
  		if ($(tableId+"u")!=null) {
  			$(tableId+"a").checked=$(tableId+"a").checked&&$(tableId+"u").checked;
  		}
	}
	function selectCheckbox(checkMark,tableId){
			$(tableId+"c").checked=$(tableId+checkMark).checked||$(tableId+"c").checked;
			$(tableId+"r").checked=$(tableId+"c").checked;
	}
	function selectCheckBox(tableId){
		var flag=false;
		flag=$(tableId+"e").checked;
		if ($(tableId+"w")!=null) {
  			flag=flag||$(tableId+"w").checked;
  		}
  		if ($(tableId+"p")!=null) {
  			flag=flag||$(tableId+"p").checked;
  		}
  		if ($(tableId+"u")!=null) {
  			flag=flag||$(tableId+"u").checked;
  		}
  		if ($(tableId+"s")!=null) {
  			flag=flag||$(tableId+"s").checked;
  		}
  		if(flag){
			$(tableId+"r").checked=flag;
		}
		$(tableId+"c").checked=$(tableId+"r").checked;
	}
	function alltable_submit(){
		$("command").value="DirectorySQLFilter";
		$("add_permission").submit();
	}
	function onetable_submit(dirId){
		$("command").value="DirectorySQLFilter";
		$("dirid").value=dirId;
		$("add_permission").submit();
	}
	function tab_action(tableId){
		$(tableId+"t").checked=$(tableId+"r").checked;
	}
</script>
<br>
<form name="add_permission" id="add_permission" method="post" action="<%=request.getContextPath() %>/control/command">
  <input type='hidden' name="groupid" value="<%=groupId %>">
  <input type='hidden' name="next-screen" value="<%=NDS_PATH+"/security/groupperm2.jsp?id="+groupId+"&subsystemId="+subsystemId+"&catalog="+java.net.URLEncoder.encode(catalog) %>">
  <input type='hidden' name="action" value="set">
   <input type='hidden' name="command" id="command">
  <input type='hidden' name="dirid" id="dirid" value="0">
  <table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">
    <tr>
      <td rowspan=2>&nbsp;</td>
          <td>
         </td>
          <td rowspan=2>&nbsp;</td>
        </tr>
        <tr>
          <td>

        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#cccccc" >
          <tr>
            <td height="8">
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr>
            <td valign="bottom">
              <div align="right"><a href="<%=NDS_PATH+"/security/groupperm.jsp?id="+groupId+"&subsystemId="+subsystemId%>"><%=PortletUtils.getMessage(pageContext, "backward",null)%></a></div>
            </td>
          </tr>
        </table>
              <div align="center"> <br>
                <%=PortletUtils.getMessage(pageContext, "current-group",null)%>: <%= groupName%> 
                <%=PortletUtils.getMessage(pageContext, "description",null)%>:<%= groupDesc%> 
                <%=PortletUtils.getMessage(pageContext, "directory-catalog",null)%>: <%=catalog%><br>
                <hr width="50%" size="1" noshade>

				<table width="90%" class="modify_table" border="1" cellpadding="0" cellspacing="0" bordercolordark="#FFFFFF" bordercolorlight="#999999">
                  <thead><tr>
                    <td height="24" width="1%" ><input type="checkbox" id="sall" class="checkbox" name="sall" value="" onclick="javascript:table_selectTotal()"></td>
                    <td height="24" width="49%" ><%=PortletUtils.getMessage(pageContext, "directory",null)%></td>
                    <td height="24" width="8%"  nowrap ><%=PortletUtils.getMessage(pageContext, "permission-read",null)%></td>
                    <td height="24" width="8%"  nowrap  ><%=PortletUtils.getMessage(pageContext, "permission-write",null)%></td>
                    <td height="24" width="8%"  nowrap  ><%=PortletUtils.getMessage(pageContext, "permission-submit",null)%></td>
                    <td height="24" width="8%"  nowrap  ><%=PortletUtils.getMessage(pageContext, "permission-audit",null)%></td>
                    <td height="24" width="8%"  nowrap  ><%=PortletUtils.getMessage(pageContext, "permission-export",null)%></td>
                  </tr></thead>
                  <%
                    
                    boolean showRead, showWrite, showSubmit, showAudit;
                    ArrayList dirTagList=new ArrayList();
                     ArrayList dirIdList=new ArrayList();
                     String column_acc_Id="";
                     String toggle_url="";
                     String sqlDesc="";
                    while( res.next()){
                        int dirId= res.getInt(1);                       
                        String dirTag="d"+ dirId;
                        dirTagList.add(dirTag);
                        dirIdList.add(dirId);
                        String name=res.getString(2);//安全List
                        String desc=res.getString(3);//表字段的描述
                        String url=contextPath+res.getString(4);//地址
                        int dirTableId=res.getInt(5);//table的ad_table_id
                        String tableName= null;
                        table= manager.getTable(dirTableId);
                        if( table ==null){
                        	showRead= true;showWrite=true;showSubmit=false;showAudit=false;
                        }else{
	                        tableName=table.getName();
                        	showWrite= table.isActionEnabled(Table.ADD) || table.isActionEnabled(Table.MODIFY) || table.isActionEnabled(Table.DELETE);
                        	showSubmit= table.isActionEnabled(Table.SUBMIT);
                        	showAudit= table.isActionEnabled(Table.AUDIT);
                        	showRead= table.isActionEnabled(Table.QUERY);
                        }
                  %>
                  <tr>
                    <td height="24"  width="1%" align='left'>
                      <input type="checkbox" class="checkbox" id=<%=dirTag+"a"%> name="directory_total" value="<%=dirTag %>" onclick="javascript:table_selectAll('<%=dirTag%>')">
                    </td>
                    <td height="24"  width="49%">
                          <a target=_blank href="<%= url%>" title='<%= name%>'> <%=desc %></a>
                    <% 
						ArrayList prms=getPermission( groupId,dirId,gff);
						int permission=((Integer)prms.get(0)).intValue();
						sqlDesc = (String)prms.get(1);
						List<FkFilter> ffs=(List<FkFilter>) prms.get(2);
						boolean isRead= (permission & 1)==1;
						boolean isWrite= (permission & 3)==3;
						boolean isSubmit= (permission & 5)==5;
						boolean isAudit= (permission & 9)==9;
						boolean isExport=(permission & 17)==17;
						boolean isChecked= isRead || isWrite || isSubmit ||isAudit||isExport;
						if(table !=null ){
							if (isChecked){
								column_acc_Id="filter_"+dirId;
								toggle_url="/html/nds/query/search.jsp?table="+table.getId()+"&return_type=a&accepter_id="+column_acc_Id;
					%>
								<span id='<%=column_acc_Id+"_link"%>' title="popup" onaction='oq.toggle_m("<%=toggle_url%>","<%=column_acc_Id%>");tab_action("<%=dirTag%>");'><img id='<%=column_acc_Id+"_img"%>' border=0 width=16 height=16 align=absmiddle src='/html/nds/images/add_filter.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'></span>
                               	<script>createButton(document.getElementById("<%=column_acc_Id+"_link"%>"));</script>
                               	<input type="hidden" name="<%=column_acc_Id+"_expr"%>" id="<%=column_acc_Id+"_expr"%>"  value=''>
								<input type="hidden" name="<%=column_acc_Id+"_sql"%>" id="<%=column_acc_Id+"_sql"%>" value=''>
								<%if(request.getHeader("User-Agent").toString().indexOf("Firefox")!=-1){%>
									<div class="sqldesc"><input readonly='on' type="text" name="<%=column_acc_Id%>" id="<%=column_acc_Id%>" class="tabinputline" nowrap="true" size="90"  value='<%=sqlDesc==null?"":sqlDesc %>'></div>	
								<%}else{%>
									<div class="tabinputline" style="word-wrap:break-word;word-break:break-all;">
										<table width="550px" border="0">
										  <tr>
										    <td width="550px" class="tabinputline"  id="tab_<%=column_acc_Id%>"><%=sqlDesc==null?"":sqlDesc %></td>
										  </tr>
										</table>
									<div>
									<input type="hidden" name="<%=column_acc_Id%>" id="<%=column_acc_Id%>" value='<%=sqlDesc==null?"":sqlDesc %>'></div>
								<%}%>
                               	<%
                               	for(int ffi=0;ffi< ffs.size();ffi++){
                               		FkFilter ff=ffs.get(ffi);
                               	%>
                               	<div class="fkfilter">
                               		<%=ff.getDescription()%>
                               	</div>
                               	<%}//end for ffi%>
                            <%
							}else{
								out.print("<a href='#'><img border=0 width=16 height=16 align=absmiddle src='"+ NDS_PATH +"/images/no_filter.gif' alt='"+PortletUtils.getMessage(pageContext, "must-at-last-select-read-permission",null)+"' "+" /></a>");
							}
						}
                     %>
                    <td>
                     <% if( showRead){ %>
                    <input type="checkbox" width="8%" id=<%=dirTag+"r"%> class="checkbox" name="<%=dirTag %>" value="1" <%=((isRead)?"checked":"")%> onclick="javascript:selectCheckBox('<%=dirTag%>');table_unselectall('<%=dirTag%>')">
                    <%}else out.print("<font color='#666666'>"+PortletUtils.getMessage(pageContext, "none-exists",null)+"</font>");%></td><td>
                    <%if (showWrite){%>
                     <input type="checkbox" width="8%"  id=<%=dirTag+"w"%> class="checkbox" name="<%=dirTag %>" value="3" <%=((isWrite)?"checked":"")%>  onclick="javascript:selectCheckbox('w','<%=dirTag%>');table_unselectall('<%=dirTag%>')"><%=showWriteDetail(table,pageContext)%>
                    <%}else out.print("<font color='#666666'>"+PortletUtils.getMessage(pageContext, "none-exists",null)+"</font>");%></td><td>
                    <%if (showSubmit){%>
                     <input type="checkbox" width="8%"  id=<%=dirTag+"s"%> class="checkbox" name="<%=dirTag %>" value="5" <%=((isSubmit)?"checked":"")%>  onclick="javascript:selectCheckbox('s','<%=dirTag%>');table_unselectall('<%=dirTag%>')">
                    <%}else out.print("<font color='#666666'>"+PortletUtils.getMessage(pageContext, "none-exists",null)+"</font>");%></td><td>
                     <%if (showAudit){%>
                     <input type="checkbox" width="8%"  id=<%=dirTag+"u"%> class="checkbox" name="<%=dirTag %>" value="9" <%=((isAudit)?"checked":"")%>  onclick="javascript:selectCheckbox('u','<%=dirTag%>');table_unselectall('<%=dirTag%>')">
                     <%}else out.print("<font color='#666666'>"+PortletUtils.getMessage(pageContext, "none-exists",null)+"</font>");%></td><td>
                     <input type="checkbox" width="8%"  id=<%=dirTag+"e"%> class="checkbox" name="<%=dirTag %>" value="17" <%=((isExport)?"checked":"")%>  onclick="javascript:selectCheckbox('e','<%=dirTag%>');table_unselectall('<%=dirTag%>')">
                     <input type="checkbox" name="directory_id" id=<%=dirTag+"c"%> value="<%=dirId%>" style="display:none" <%=((isChecked)?"checked":"")%>>
                      <input type="checkbox" name="tab_action" id=<%=dirTag+"t"%> value="<%=dirId%>" style="display:none">
                    </td>
                  </tr>
                  <% }//end while(res.next())
                  	res.close();
                   %>
                </table>
                <div align="center">
                <br>
          <table width="51%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="20%">
                <input type='hidden' name="type" value="directory">
                <input type='hidden' name="catalog" value="<%=catalog%>">
              </td>
              <td width="52%">
                <input type="button" name="dosubmit" value="<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>" onClick="javascript:alltable_submit();" >
              </td>
            </tr>
          </table>
        </div>
                <br>
                <br>
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  </form>
  <script>
	  function table_selectTotal(){
	  <%
	    if (dirTagList.size()>0){
	    	StringBuffer sb=new StringBuffer("var dirTags=new Array(\""+ dirTagList.get(0)+"\"");
	    	for( int i=1;i< dirTagList.size();i++){
	    		sb.append(",\"" + dirTagList.get(i)+"\"");
	    	}
	    	sb.append(");\n\rvar i,b;\n\r");
	    	sb.append("b=$(\"sall\").checked;\n\r");
	    	sb.append("for (i=0;i< dirTags.length;i++){$(dirTags[i]+\"a\").checked=b; table_selectAll(dirTags[i]);}");
	    	out.print(sb);
	    }
	  %>
	  }
  </script>
		
    </div>
</div>		

<%@ include file="/html/nds/footer_info.jsp" %>