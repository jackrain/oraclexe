<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="nds.log.*,
                 nds.query.*,
                 nds.query.web.*,
                 nds.schema.*,
                 nds.util.*,
                 java.util.*,
                 java.sql.*,
                 nds.control.web.*"
%>
<%@ taglib uri='/WEB-INF/tld/struts-tiles.tld' prefix='tiles' %>
<%@	page errorPage="../error.jsp" %>
<%
    /**
     * Things needed in this page:
     *  table* - (int) table id
     */
%>
<%!
	/**
	* if ele exists in al, return "checked", else return "";
	*/
	private String getCheckString(ArrayList al, String ele){
		for(int i=0;i< al.size();i++){
			if( ele.equals(al.get(i))) return "checked";
		}
		return "";
	}
%>
<%
    
	TableManager tableManager=TableManager.getInstance();
	int tableId= ParamUtils.getIntAttributeOrParameter(request, "table", -1);
	Table table;
	if( tableId == -1) {
    	String tableName=  request.getParameter("table") ;
    	table= tableManager.getTable(tableName);
    	if( table !=null) tableId= table.getId();
    	else {
        	out.println("对象类型未设置");
        	return;
    	}
	}else{
    	table= tableManager.getTable(tableId);
	}
	String title="设置"+ table.getDescription(locale)+ "状态通知";
/**------check permission---**/
String directory;
directory=table.getSecurityDirectory();
WebUtils.checkDirectoryReadPermission(directory, request);
/**------check permission end---**/
	
    String userName, userDescription;
    int userId=-1;
    SessionContextManager manager= WebUtils.getSessionContextManager(request.getSession());
    UserWebImpl user= null;
    if( manager !=null){
        user= (UserWebImpl)manager.getActor(nds.util.WebKeys.USER);
    }
    if( user!=null){
        userId= user.getUserId();
        userName=user.getUserName();
        userDescription=user.getUserDescription();
    }else{
        userName="guest";
        userDescription="Not Login";
    }
    String email="";
	QueryEngine engine=QueryEngine.getInstance();
	ResultSet rs= engine.doQuery("select email from employee where userid="+ userId);
	if( rs.next()){
		email= rs.getString(1);
	}
	rs.close();
	rs= engine.doQuery("select distinct remark from notifyparams where ownerid="+ userId+ " and tablename='"+
		table.getName()+"'");
	ArrayList storedParams= new ArrayList();
	while( rs.next()){
		storedParams.add(rs.getString(1));
	}
	rs.close();
%>
<% //request.getContextPath()+
    String headerjsp="/header.jsp";
 %>
<tiles:insert page='<%=headerjsp%>'>
  <tiles:put name='title' value='<%=title%>' direct='true'/>
</tiles:insert>

<script>
function checkSelected(optionControl, desc){
      for(i=0; i<optionControl.options.length; i++) {
        if (optionControl.options[i].selected) {
            if( optionControl.options[i].value =='0'){
                alert("\Select "+desc+", Please!!");
                optionControl.focus();
                return false;
            }
        }
      }
      return true;
}
function checkOptions(form){
   if(!checkSelected(form.command,"Command"))  return false;
   return true;
}
  function doCommand(form, cmd){
    if (cmd.indexOf("Delete")>=0 ){
        if (!confirm("你确认要删除吗?")) {
            return false;
        }
    }
    form.command.value=cmd;
   form.submit();

  }
 
</script>
<br>

<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="90%">
  <tr>
    <td rowspan=2>&nbsp;</td>
          <td>
<tiles:insert page='/title.jsp'>
  <tiles:put name='title' value='<%= title %>' direct='true'/>
  </tiles:insert>
          </td>
          <td rowspan=2>&nbsp;</td>
        </tr>
        <tr>
          <td colspan=3>
		<table border="1" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">
          <tr bgcolor="#FDFBE3">
            <td> <table border="0" cellspacing="0" cellpadding="0" align="center" width="90%"><tr><td>
              <br><!-- user infor here-->
<form name="sheet_title_form" method="post" action="<%=request.getContextPath() %>/control/command" onSubmit="return checkOptions(document.sheet_title_form);">
<input type="hidden" name="table" value="<%=table.getName() %>">
<input type="hidden" name="next-screen" value="/prefer/notifyparams.jsp?table=<%=tableId%>">
<p>我的邮箱是<input type="text" size="40" maxlength="80" name="email" value="<%=email%>"></p>
<% if ( table.isActionEnabled(Table.AUDIT)==true ){%>
<p><input type="checkbox" name="param" value="OnMyObjectPermit" <%=getCheckString(storedParams, "OnMyObjectPermit")%>>在我的<b><%=table.getDescription(locale)%></b>被<font color=red>批准</font>时通知我</p>
<p><input type="checkbox" name="param" value="OnMyObjectRollback" <%=getCheckString(storedParams, "OnMyObjectRollback")%>>在我的<b><%=table.getDescription(locale)%></b>被<font color=red>驳回</font>时通知我</p>
<p><input type="checkbox" name="param" value="OnObjectAudit" <%=getCheckString(storedParams, "OnObjectAudit")%>>在任何人的<b><%=table.getDescription(locale)%></b>被提交<font color=red>申请核准</font>时通知我</p>
<p><input type="checkbox" name="param" value="OnObjectPermit" <%=getCheckString(storedParams, "OnObjectPermit")%>>在任何人的<b><%=table.getDescription(locale)%></b>被<font color=red>批准</font>时通知我</p>
<% }else{%>
<p> <b>此对象类型不支持审核流程</b> </p>
<%}%>
<input type='hidden' name="command" value='Command.jsp error'>
          
<input class="command2_button" type='button' name='SetNotifyParams' value='保&nbsp;&nbsp;&nbsp;&nbsp;存' onclick="javascript:doCommand(sheet_title_form, 'SetNotifyParams')" >
<input class="command_button" type='button' name='Cancle' value='关闭窗口' onclick="javascript:window.close();" >

</form></td></tr></table>
 </td></tr></table>
 <br><br>
 </td></tr></table>
<%
    String footerjsp= "/footer2.jsp";
 %>

  <tiles:insert page='<%=footerjsp %>'>
</tiles:insert>
