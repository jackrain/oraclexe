<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<script src="/html/nds/js/security.js"></script>
<%
	String tabName= PortletUtils.getMessage(pageContext, "groupperm",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**This page mainly shows the catalog of secured directories and let permission set in batch
     * while groupperm2.jsp will allowing setting on directory one by one
     * parameter:
     *      1.  id  - group Id
     */

     /**------check permission---**/
String directory;
directory="GROUPPERM_LIST";
WebUtils.checkDirectoryWritePermission(directory,request);

TableManager manager=TableManager.getInstance();
Table table= manager.getTable("Groups");
int tableId= table.getId();
int groupId= ParamUtils.getIntParameter(request, "id", -1);
int subsystemId= ParamUtils.getIntParameter(request, "subsystemId", -1);
    ResultSet result= QueryEngine.getInstance().doQuery("select name, description from groups where id="+groupId);
    if(!result.next()) {
        out.println("The pointed group is not found, please refresh page and operate again!");
        return;
    }

String groupName=result.getString(1);
String groupDesc= result.getString(2);
ResultSet rs= QueryEngine.getInstance().doQuery("select name,id from ad_tablecategory where isactive='Y' and ad_subsystem_id= "+subsystemId+"order by orderno asc");
int table_Id= ParamUtils.getIntParameter(request, "table", -1);
%>
    <%
        /**
         * Get Group perms of specified group
         */
        QueryRequestImpl query=QueryEngine.getInstance().createRequest(null);
        int groupPermTableId=manager.getTable("GroupPerm").getId();
        query.setMainTable(groupPermTableId);
        query.addSelection(manager.getColumn("GroupPerm","ID").getId());
        query.addAllShowableColumnsToSelection(Column.QUERY_LIST);
        query.addParam(manager.getColumn("GroupPerm","GROUPID").getId(), ""+groupId);
        query.setResultHandler(NDS_PATH+"/query/result.jsp");
        String s=QueryUtils.toHTMLControlForm(query);
    %>
    <form name="query_groupperm" id="query_groupperm" method="post" action="<%=request.getContextPath()+"/servlets/QueryInputHandler" %>">
        <%= s%>
    </form>
<Script language="javascript">
	function viewPerm(){
		$("query_groupperm").submit();
  	}
	function selectReadCheckbox(checkMark,catalogId){
		$(catalogId+"c").checked=$(catalogId+checkMark).checked||$(catalogId+"c").checked;	
		$(catalogId+"r").checked=$(catalogId+"c").checked;
	}
	function checkReadCheckBox(catalogId){
		var flag=false;
		flag=$(catalogId+"e").checked;
		if ($(catalogId+"w")!=null) {
  			flag=flag||$(catalogId+"w").checked;
  		}
  		if ($(catalogId+"s")!=null) {
  			flag=flag||$(catalogId+"s").checked;
  		}
  		if ($(catalogId+"u")!=null) {
  			flag=flag||$(catalogId+"u").checked;
  		}
  		if(flag){
			$(catalogId+"r").checked=flag;
		}
		$(catalogId+"c").checked=$(catalogId+"r").checked;
	}
	function catalog_selectAll(catalogId){
  		$(catalogId+"a").checked= $(catalogId+"a").checked |0;
    	$(catalogId+"r").checked= $(catalogId+"a").checked;
    	$(catalogId+"w").checked= $(catalogId+"a").checked;
    	$(catalogId+"s").checked= $(catalogId+"a").checked;
    	$(catalogId+"u").checked= $(catalogId+"a").checked;
    	$(catalogId+"e").checked= $(catalogId+"a").checked;
    	$(catalogId+"c").checked= $(catalogId+"a").checked;
	}
  	function catalog_unselectall(catalogId){
  		$(catalogId+"a").checked=$(catalogId+"r").checked&&$(catalogId+"w").checked&&$(catalogId+"s").checked&&$(catalogId+"u").checked&&$(catalogId+"e").checked;
	}
</script>
<br>
<form name="add_permission" action="<%=request.getContextPath() %>/control/command" method="post">
  <input type='hidden' name='table' value='<%= groupPermTableId%>'>
  <input type='hidden' name="groupId" value="<%=groupId %>">
  <input type='hidden' name="action" value="set">

  <table border="0" cellspacing="0" cellpadding="0" align="center"  width="100%">
    
        <tr>
          <td>
        <table width="100%" cellspacing="0" cellpadding="0" align="center" >
          <tr>
            <td height="8">
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr>
            <td width="99%" valign="middle">
              <div align="center"><%= PortletUtils.getMessage(pageContext, "current-group",null)%>: <%= groupName%> &nbsp;&nbsp;<%= PortletUtils.getMessage(pageContext, "description",null)%>: <%= groupDesc%></div>
            </td>
            <td nowrap valign="bottom">
              <div align="right"><a href="<%=NDS_PATH+"/security/grouperm_subsystem.jsp?table="+table_Id+"&id="+groupId%>"><%=PortletUtils.getMessage(pageContext, "backward",null)%></a></div>
            </td>
          </tr>
        </table>
              <div align="center">
                <table width="90%" border="0" cellpadding="1" cellspacing="1" bordercolordark="#FFFFFF" bordercolorlight="#CCCCCC">
                  <tr>
                    <td height="24" width="85%" align="center">
                      <a href="javascript:viewPerm()"><%= PortletUtils.getMessage(pageContext, "show-permission",null)%> :<%= groupName%></a>
                    </td>
                  </tr>
                </table>
                <table width="90%" class="modify_table" border="1" cellpadding="0" cellspacing="0" bordercolordark="#FFFFFF" bordercolorlight="#999999">
                  <thead><tr>
                    <td height="24" width="1%" ><input type="checkbox" id="sall" class="checkbox" name="sall" value="" onclick="javascript:selectTotal()"></td>
                    <td height="24" width="59%" ><%= PortletUtils.getMessage(pageContext, "directory-catalog",null)%></td>
                    <td height="24" width="8%"  nowrap ><%= PortletUtils.getMessage(pageContext, "permission-read",null)%></td>
                    <td height="24" width="8%"  nowrap  ><%= PortletUtils.getMessage(pageContext, "permission-write",null)%></td>
                    <td height="24" width="8%"  nowrap  ><%= PortletUtils.getMessage(pageContext, "permission-submit",null)%></td>
                    <td height="24" width="8%"  nowrap  ><%= PortletUtils.getMessage(pageContext, "permission-audit",null)%></td>
                    <td height="24" width="8%"  nowrap  ><%= PortletUtils.getMessage(pageContext, "permission-export",null)%></td>
                  </tr></thead>
                  <%
                    int catalogId=0;
                    ArrayList dirTagList=new ArrayList();
                    while( rs.next()){
                        String catalog= rs.getString(1);
                        if(catalog==null || "".equals(catalog)) continue;
                        //catalogId++;
                        catalogId =rs.getInt(2);
                        dirTagList.add(catalogId+"");
                  %>
                  <tr>
                    <td height="24">
                      <input type="checkbox" class="checkbox" id="<%=catalogId+"a"%>" name="<%=catalogId+"a"%>" value="<%=catalog %>" onclick="javascript:catalog_selectAll(<%=catalogId%>)">
                      
                    </td>
                    <td height="24" ><a href="<%=(NDS_PATH+"/security/groupperm2.jsp?id="+groupId+"&catalog="+catalogId+"&subsystemId="+subsystemId) %>"><%=catalog %></a></td>
                    <td> <input type="checkbox" id=<%=catalogId+"r"%> class="checkbox" name="<%=catalogId %>" value="1" onclick="javascript:checkReadCheckBox(<%=catalogId%>);catalog_unselectall(<%=catalogId%>)"></td>
                    <td> <input type="checkbox" id=<%=catalogId+"w"%> class="checkbox" name="<%=catalogId %>" value="3" onclick="javascript:selectReadCheckbox('w',<%=catalogId%>);catalog_unselectall(<%=catalogId%>)"></td>
                    <td> <input type="checkbox" id=<%=catalogId+"s"%> class="checkbox" name="<%=catalogId %>" value="5" onclick="javascript:selectReadCheckbox('s',<%=catalogId%>);catalog_unselectall(<%=catalogId%>)"></td>
                    <td> <input type="checkbox" id=<%=catalogId+"u"%> class="checkbox" name="<%=catalogId %>" value="9" onclick="javascript:selectReadCheckbox('u',<%=catalogId%>);catalog_unselectall(<%=catalogId%>)"></td>
                    <td> <input type="checkbox" id=<%=catalogId+"e"%> class="checkbox" name="<%=catalogId %>" value="17" onclick="javascript:selectReadCheckbox('e',<%=catalogId%>);catalog_unselectall(<%=catalogId%>)">
                    	<input type="checkbox" name="directory_catalog" id=<%=catalogId+"c"%> value="<%=catalogId%>" style="display:none" >
                  </tr>
                  <% }//end while(rs.next())
                   %>
                </table>
                <div align="center">
                <br>
          <table width="51%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="20%">
                <input type='hidden' name="command" value="GroupSetPermission">
                <input type='hidden' name="type" value="catalog">
              </td>
              <td width="52%">
                <input type="button" name="dosubmit" value="<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>" onClick="submitForm(document.add_permission)" >
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
  function selectTotal(){
  <%
    if (dirTagList.size()>0){
    	StringBuffer sb=new StringBuffer("var dirTags=new Array(\""+ dirTagList.get(0)+"\"");
    	for( int i=1;i< dirTagList.size();i++){
    		sb.append(",\"" + dirTagList.get(i)+"\"");
    	}
    	sb.append(");\n\rvar i,b;\n\r");
    	sb.append("b=$(\"sall\").checked;\n\r");
    	sb.append("for (i=0;i< dirTags.length;i++){$(dirTags[i]+\"a\").checked=b; catalog_selectAll(dirTags[i]);}");
    	out.print(sb);
    }
  %>
  }
  </script>
    </div>
</div>		
<%@ include file="/html/nds/footer_info.jsp" %>