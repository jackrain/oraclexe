<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
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
int table_Id= ParamUtils.getIntParameter(request, "table", -1);
int groupId= ParamUtils.getIntParameter(request, "id", -1);
    ResultSet result= QueryEngine.getInstance().doQuery("select name, description from groups where id="+groupId);
    if(!result.next()) {
        out.println("The pointed group is not found, please refresh page and operate again!");
        return;
    }

String groupName=result.getString(1);
String groupDesc= result.getString(2);
ResultSet rs= QueryEngine.getInstance().doQuery("select name,id from ad_subsystem where isactive='Y' order by orderno asc");

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
    <form name="query_subsystem" id="query_subsystem" method="post" action="<%=request.getContextPath()+"/servlets/QueryInputHandler" %>">
        <%=s%>
    </form>
<Script language="javascript">

  function viewPerm(){
    $("query_subsystem").submit();
  }
	function selectReadCheckbox(checkMark,subsystemId){
		$(subsystemId+"c").checked=$(subsystemId+checkMark).checked||$(subsystemId+"c").checked;	
		$(subsystemId+"r").checked=$(subsystemId+"c").checked;
	}
	function checkReadCheckBox(subsystemId){
		var flag=false;
		flag=$(subsystemId+"e").checked;
		if ($(subsystemId+"w")!=null) {
  			flag=flag||$(subsystemId+"w").checked;
  		}
  		if ($(subsystemId+"s")!=null) {
  			flag=flag||$(subsystemId+"s").checked;
  		}
  		if ($(subsystemId+"u")!=null) {
  			flag=flag||$(subsystemId+"u").checked;
  		}
  		if(flag){
			$(subsystemId+"r").checked=flag;
		}
		$(subsystemId+"c").checked=$(subsystemId+"r").checked;
	}
  function subsystem_selectAll(subsystemId){
		$(subsystemId+"a").checked=$(subsystemId+"a").checked|0;
		$(subsystemId+"r").checked=$(subsystemId+"a").checked;
		$(subsystemId+"w").checked=$(subsystemId+"a").checked;
		$(subsystemId+"s").checked=$(subsystemId+"a").checked;
		$(subsystemId+"u").checked=$(subsystemId+"a").checked;
		$(subsystemId+"e").checked=$(subsystemId+"a").checked;
		$(subsystemId+"c").checked=$(subsystemId+"a").checked;
	}
	function subsystem_unselectall(subsystemId){
		$(subsystemId+"a").checked=$(subsystemId+"r").checked&&$(subsystemId+"w").checked&&$(subsystemId+"u").checked&&$(subsystemId+"s").checked&&$(subsystemId+"e").checked;
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
              <div align="right"><a href="<%=NDS_PATH+"/object/object.jsp?table="+tableId+"&&fixedcolumns=&id="+groupId%>"><%=PortletUtils.getMessage(pageContext, "backward",null)%></a></div>
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
                    <td height="24" width="1%" >&nbsp;</td>
                    <td height="24" width="49%" ><%= PortletUtils.getMessage(pageContext, "directory-subsystem",null)%></td>
                    <td height="24" width="10%"  nowrap ><%= PortletUtils.getMessage(pageContext, "permission-read",null)%></td>
                    <td height="24" width="10%"  nowrap  ><%= PortletUtils.getMessage(pageContext, "permission-write",null)%></td>
                    <td height="24" width="10%"  nowrap  ><%= PortletUtils.getMessage(pageContext, "permission-submit",null)%></td>
                    <td height="24" width="10%"  nowrap  ><%= PortletUtils.getMessage(pageContext, "permission-audit",null)%></td>
                    <td height="24" width="10%"  nowrap  ><%= PortletUtils.getMessage(pageContext, "permission-export",null)%></td>
                  </tr></thead>
                  <%
                    int subsystemId=0;
                    ArrayList dirTagList=new ArrayList();
                    while( rs.next()){
                        String catalog= rs.getString(1);
                        if(catalog==null || "".equals(catalog)) continue;
                        //subsystemId++;
                        subsystemId =rs.getInt(2);
                        dirTagList.add(subsystemId+"");
                  %>
                  <tr>
                    <td height="24">
                      <input type="checkbox" class="checkbox" id="<%=subsystemId+"a"%>" name="<%=subsystemId+"a"%>" value="<%=catalog %>" onclick="javascript:subsystem_selectAll(<%=subsystemId%>)">
                      
                    </td>
                    <td height="24" ><a href="<%=(NDS_PATH+"/security/groupperm.jsp?table="+table_Id+"&id="+groupId+"&subsystemId="+subsystemId) %>"><%=catalog %></a></td>
                    <td> <input type="checkbox" id=<%=subsystemId+"r"%> class="checkbox" name="<%=subsystemId %>" value="1" onclick="javascript:checkReadCheckBox(<%=subsystemId%>);subsystem_unselectall(<%=subsystemId %>)">
                    <td> <input type="checkbox" id=<%=subsystemId+"w"%> class="checkbox" name="<%=subsystemId %>" value="3" onclick="javascript:selectReadCheckbox('w',<%=subsystemId%>);subsystem_unselectall(<%=subsystemId %>)">
                    <td> <input type="checkbox" id=<%=subsystemId+"s"%> class="checkbox" name="<%=subsystemId %>" value="5" onclick="javascript:selectReadCheckbox('s',<%=subsystemId%>);subsystem_unselectall(<%=subsystemId %>)">
                    <td> <input type="checkbox" id=<%=subsystemId+"u"%> class="checkbox" name="<%=subsystemId %>" value="9" onclick="javascript:selectReadCheckbox('u',<%=subsystemId%>);subsystem_unselectall(<%=subsystemId %>)">
                    <td> <input type="checkbox" id=<%=subsystemId+"e"%> class="checkbox" name="<%=subsystemId %>" value="17" onclick="javascript:selectReadCheckbox('e',<%=subsystemId%>);subsystem_unselectall(<%=subsystemId %>)">
                    	<input type="checkbox" name="directory_subsystem" id=<%=subsystemId+"c"%> value="<%=subsystemId%>" style="display:none">
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
                <input type='hidden' name="type" value="system">
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
    </div>
</div>		
<%@ include file="/html/nds/footer_info.jsp" %>
