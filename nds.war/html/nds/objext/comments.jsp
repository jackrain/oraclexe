<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
  /**
* parameters: 
*    record_table* (int) record table
*    record_id*  (int) record id in record table
  */
	Table table=TableManager.getInstance().getTable("U_Comments");
	int tableId= table.getId();
	String tabName= table.getDescription(locale);
%>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
	int record_table_id = ParamUtils.getIntAttributeOrParameter(request, "record_table", -1);
	int record_id = ParamUtils.getIntAttributeOrParameter(request, "record_id", -1);
	Table record_table= TableManager.getInstance().getTable(record_table_id);
	String realTableName=null;
	if( record_table !=null) realTableName= record_table.getRealTableName();
	else{
		out.print("Table not found for parameter: record_table_id="+ record_table_id);
		return;
	}
	
    QueryRequestImpl query=QueryEngine.getInstance().createRequest(userWeb.getSession());
    query.setMainTable(tableId);
    query.addSelection(table.getPrimaryKey().getId());
    query.addSelection(table.getColumn("creationdate").getId());
    query.addSelection(table.getColumn("ownerid").getId());
    query.addSelection(table.getColumn("ownerid").getId(), TableManager.getInstance().getColumn("users","name").getId(), false);
    query.addSelection(table.getColumn("content").getId());

	query.addParam(table.getColumn("TABLENAME").getId(), "="+realTableName);
	query.addParam(table.getColumn("RECORD_ID").getId(), "="+record_id);
	
    int[] orderKey= new int[]{ table.getPrimaryKey().getId()};
    query.setOrderBy(orderKey, false);
	// show all directly
	query.setRange(0, Integer.MAX_VALUE);
	QueryResult result= QueryEngine.getInstance().doQuery(query);
	request.setAttribute("query", query);
	request.setAttribute("table", ""+tableId);

   String directory=table.getSecurityDirectory();
%>
<script language="JavaScript" src="<%=NDS_PATH%>/js/formkey.js"></script>
<script>
	document.title="<%=table.getDescription(locale)%>";
    function checkNotNull(control,desc){
      if(isWhitespace(control.value)){
        alert(desc+" <%= PortletUtils.getMessage(pageContext, "can-not-be-null",null)%>!");
        control.focus();
        return false;
      }
      return true;
    }
    function checkOptions(form){
      if(!checkNotNull(form.content,"<%=table.getColumn("content").getDescription(locale)%>"))
          return false;
      submitForm(form); 
    }	
</script>

<br>
<br>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
<tr><td>
<%=PortletUtils.getMessage(pageContext, "nots-on-comments",null)%>
</td></tr>
</table>
<br>

<table width="90%" border="0" cellspacing="0" cellpadding="0">
<form name="comments_form" method="post" action="<%=contextPath %>/control/command" >
<input type='hidden' name="command" value="U_COMMENTCreate">
<input type='hidden' name="table" value="<%=table.getId()%>">
<input type='hidden' name="next-screen" value="<%=NDS_PATH+"/objext/comments.jsp?record_table="+record_table_id+"&record_id="+record_id%>">
<input type='hidden' name='directory' value='<%= directory%>'>
<input type='hidden' name='tablename' value='<%=realTableName%>'>
<input type='hidden' name='record_id' value='<%=record_id%>'>
<tr><td valign='middle' nowrap >&nbsp;&nbsp;
<%=table.getColumn("content").getDescription(locale)%>:
</td><td>
<textarea name="content" tabIndex="2" wrap="soft" rows="3" cols="50" >
<%=PortletUtils.getMessage(pageContext, "already-read",null)%>
</textarea>
</td><td valign='bottom' align='left'>
<input type="button" value="<%=PortletUtils.getMessage(pageContext, "object.create",null)%>" onclick='javascript:checkOptions(document.comments_form);'>
<input type="button" value="<%=PortletUtils.getMessage(pageContext, "close-window",null)%>" onclick='javascript:window.close();' >
</td></tr>
</form>
</table>
<br>
<table align="center" width="95%" border="1" cellpadding="0" cellspacing="0" bordercolordark="#FFFFFF" bordercolorlight="#999999">
                  <tr bgcolor="EBF5FD">
                    <td height="24" width="5%" >ID</td>
                    <td height="24" width="10%" nowrap align='center'><%= PortletUtils.getMessage(pageContext, "comments-date",null)%></td>
                    <td height="24" width="10%" nowrap align='center'><%=table.getColumn("ownerid").getDescription(locale)%></td>
                    <td height="24" width="75%" nowrap align='center'><%= table.getColumn("content").getDescription(locale)%></td>
                  </tr>
              <%
              if(result.getRowCount() == 0){

              %>
              <tr bgcolor="#FFFFFF">
                      <td align="center" colspan="4">
                      <%= PortletUtils.getMessage(pageContext, "no-data",null)%>
                      </td>
              </tr>
              <%
              }
                    int cnt=0;
                    int usersTableId= TableManager.getInstance().getTable("users").getId();
                    while( result.next()){
                    	cnt++;
                    	int id=Tools.getInt(result.getObject(1),-1);
                        String creationDate= ((java.text.SimpleDateFormat)QueryUtils.smallDateTimeSecondsFormatter.get()).format((java.util.Date)result.getObject(2));
                        int ownerId= Tools.getInt(result.getObject(3),-1);
                        String ownerName= (String) result.getObject(4);
                        String content= (String) result.getObject(5);
                  %>
                  <tr bgcolor="#FFFFFF">
                    <td > <%=id%></td>
                    <td nowrap> <%=creationDate%></td>
                    <td nowrap> <a href="<%=NDS_PATH+"/object/object.jsp?table="+usersTableId+"&id="+ ownerId%>"><%=ownerName%></a></td>
                    <td> <%=content%></td>
                  </tr>
                  <% }//end while(rs.next())
                   %>
</table>

    </div>
</div>
<%@ include file="/html/nds/footer_info.jsp" %> 
