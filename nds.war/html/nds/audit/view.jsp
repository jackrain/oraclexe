<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*"%>
<%!
	/**
	* Parameters: 
	*   startidx --  start index for query
	*   order    --  order column(int) if not set will set to creationdate of u_note
	*   asc      --  1 for ascending, else for descending, default to desc
	*/
	
	
	/**
	*  max length to be display for the news' subject,
	*  if greater than that, will append ".."
	*/
 	private final static int MAX_SUBJECT_LENGTH_NARROW_1024=30;
 	private final static int MAX_SUBJECT_LENGTH_WIDE_1024=50;
 	private final static int MAX_SUBJECT_LENGTH_MAX_1024=100;
 	private final static int MAX_SUBJECT_LENGTH_NARROW_800=24;
 	private final static int MAX_SUBJECT_LENGTH_WIDE_800=40;
 	private final static int MAX_SUBJECT_LENGTH_MAX_800=80;
	
%>

<%
String curTime=String.valueOf(System.currentTimeMillis());
DateFormat df =((java.text.SimpleDateFormat)QueryUtils.dateFormatter.get());// new java.text.SimpleDateFormat("MM-dd HH");
//df.setTimeZone(timeZone);

TableManager manager=TableManager.getInstance();
int startIndex= ParamUtil.get(request, "startidx", 0);
if(startIndex<0) startIndex=0;
boolean isOut= "Y".equals( QueryEngine.getInstance().doQueryOne("select is_out from users where id="+ userWeb.getUserId()));
boolean showAssignment=ParamUtil.get(request,"showassign",false);
 QueryResult result;
 int oid, recordId,tableId;
 String recordDocNo, brief,processName; 
 String  creationDate=null;
 int recordCount,i, maxTitleLength; 
 int serialno,relativeIdx=-1;
 Table table;
 int phaseInstanceTableId=manager.getTable("au_phaseinstance").getId();
 int pageRecordCount;
 String className,assigneeName=null;
 int assigneeId=-1;
FKObjectQueryModel fkQueryModel=new FKObjectQueryModel(TableManager.getInstance().getTable("users"), "assignee",null); 
fkQueryModel.setQueryindex(-1);
%>
<form action="/control/command" method="post" id="form1">
<div id="audit_toolbar">
<input id="command" name="command" type="hidden" value="ExecuteAudit">
<input id="auditActionType" type="hidden" name="auditAction" value="auditAction">
<input type='hidden' name='arrayItemSelecter' value='selectedItemIdx'>
<% 
	// maiximized one
	recordCount=30;
	maxTitleLength=MAX_SUBJECT_LENGTH_MAX_1024;
 	result= AuditUtils.findWaitingInstances(request, recordCount, startIndex, showAssignment);
 	pageRecordCount=result.getRowCount();
%>
<%if(!showAssignment){%>
<%= LanguageUtil.get(pageContext, "audit-comments",null)%>:<input type="text" class="form-text" size="20" maxlength="255" name="comments" id="comments" value="">
<input class="cbutton" type='button' value='<%= LanguageUtil.get(pageContext, "object.accept",null)%>' onclick="pc.submitAuditForm('accept')" >&nbsp;&nbsp;
<input class="cbutton" type='button' value='<%= LanguageUtil.get(pageContext, "object.reject",null)%>' onclick="pc.submitAuditForm('reject')" >&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;<%= LanguageUtil.get(pageContext, "assignee",null)%>:<input type="text" class="form-text" size="15" maxlength="80" id="assignee"  name="assignee" value="">
<span id="user" onaction="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
<script>
	createButton(document.getElementById("user"));
</script>
<input class="cbutton" type='button' value='<%= LanguageUtil.get(pageContext, "object.assign",null)%>' onclick="pc.submitAuditForm('assign')" >&nbsp;&nbsp;

<%}else{%>
<input class="cbutton" type='button' value='<%= LanguageUtil.get(pageContext, "object.cancel-assign",null)%>' onclick="pc.submitAuditForm('cancel_assign')" >&nbsp;&nbsp;
<%}%>
<%if(isOut){%>
<span class="bg-neg-alert">	<%= LanguageUtil.get(pageContext, "is-out",null)%></span>
<a title="<%= LanguageUtil.get(pageContext, "click-to-setup-work-state",null)%>" href="javascript:pc.navigate('/html/nds/audit/setup.jsp')" styleClass="bg">
[<%= LanguageUtil.get(pageContext, "setup",null)%>]</a>
<%}else{%>
<a title="<%= LanguageUtil.get(pageContext, "click-to-setup-work-state",null)%>" href="javascript:pc.navigate('/html/nds/audit/setup.jsp')" styleClass="bg">
	[<%= LanguageUtil.get(pageContext, "out-setting",null)%>]
</a>
<%}%>
</div>
<table width="95%" cellspacing="1" cellpadding="2" class="sort-table" id="inc_table">
<thead><tr>
<td width=1><input class='cbx' type="checkbox" id="chk_select_all" name="chk_select_all" value=1 onclick='javscript:pc.checkAll("form1",<%=pageRecordCount%>)'> </td>
<td><%= LanguageUtil.get(pageContext,  "docno" )%></td>
<td><%= manager.getTable("au_process").getDescription(locale)%></td>
<td><%= LanguageUtil.get(pageContext,  "description" )%></td>
<td><%= LanguageUtil.get(pageContext,  showAssignment?"assignee":"creationdate")%></td>
</tr>
</thead>
<%
 if(pageRecordCount==0){
%> 
<tr>
			<td align="center" colspan="5" valign="top">
				<%= LanguageUtil.get(pageContext, "no-data") %>
			</td>
</tr> 
<% }
 int userTableId= manager.getTable("users").getId();
 while(result.next()){
 	 
 	 oid=((java.math.BigDecimal)result.getObject(1)).intValue(); // au_phaseinstance.id
 	 processName= (String)result.getObject(2);
 	 tableId=((java.math.BigDecimal)result.getObject(3)).intValue();
 	 table= manager.getTable(tableId);
 	 if( table ==null){
 	 	//special condition when table is not active set by admin
 	 	continue;
 	 }
 	 /* yfzhu marked up following line since real table must not show view's records */
 	 //if(table.getRealTableName()!=null) tableId=manager.getTable(table.getRealTableName()).getId();
 	 recordDocNo= (String)result.getObject(4);
 	 recordId=Tools.getInt(result.getObject(5),-1) ; 
 	 
 	 if(Validator.isNull(recordDocNo)){
 	 	recordDocNo="[null]";
 	 }
 	  brief=StringUtils.shortenInBytes( (String)result.getObject(6), maxTitleLength);
 	 if(!showAssignment){
	 	 if(result.getObject(7) !=null){ 
	 	 	creationDate= df.format((java.util.Date)result.getObject(7));
	 	 }else{
	 	 	creationDate=StringUtils.NBSP;
	 	 }
 	 }else{
		//loading assignee information
		List al=(List)QueryEngine.getInstance().doQueryList("select u.id,u.name from users u, au_pi_user p where p.au_pi_id="+oid+" and p.ad_user_id="+ userWeb.getUserId()+" and p.assignee_id=u.id(+)").get(0);
		assigneeId= Tools.getInt( al.get(0),-1);
		assigneeName= (String)al.get(1);
 	 }
	relativeIdx++;
	className= (relativeIdx%2==1?"gamma":"gamma");
%>
		<tr>
		    <td width=1>
		    <input class='cbx' type='checkbox' id='chk_obj_<%=oid%>' name='itemid' value='<%=oid%>' onclick="pc.unselectall()">
			</td>
			<td><a href="javascript:pc.auditObj('/html/nds/object/audit.jsp?table=<%=tableId%>&id=<%=recordId%>&auditid=<%=oid%>')"><%=recordDocNo%></a></td>
			<td><a href="javascript:dlgo(<%=phaseInstanceTableId%>,<%=oid%>)"><%=processName%></a></td>
			<td><%=brief%></td>
			<td>
			<%if(showAssignment){%>
				<a href="javascript:popup_window('/html/nds/object/object.jsp?table=<%=userTableId%>&id=<%=assigneeId%>')"><%=assigneeName%></a>
			<%}else{%>
				<%=creationDate%>
			<%}%>
			</td>
		</tr>
		
<%
 }
 int totalCount=AuditUtils.getTotalCount(request,showAssignment);
 String url="/html/nds/audit/view.jsp?showassign="+Boolean.toString(showAssignment);
%>
</table>
<div id="audit-nav">
<a href="javascript:pc.navigate('/html/nds/audit/view.jsp?showassign=<%=Boolean.toString(!showAssignment)%>')" styleClass="bg">[<%= LanguageUtil.get(pageContext, showAssignment?"show-my-work-list":"show-assign",null)%>]</a>&nbsp;
<% for(i=0 ;i< ((totalCount/recordCount)>15?15:(totalCount/recordCount));i++){ %>
  <a href="javascript:pc.navigate('<%=url+"&startidx="+(i*recordCount)%>')">
 	[<%=(i*recordCount)+1%>],&nbsp;
 </a>
<%}%>
&nbsp;
<a href="javascript:pc.navigate('<%=url+"&startidx="+(startIndex)%>')">
 	[<%= LanguageUtil.get(pageContext, "refresh")%>]
 </a>&nbsp;
  <a href="javascript:pc.navigate('<%=url+"&startidx="+(0)%>')" >
 [<%= LanguageUtil.get(pageContext, "first-page")%>]
 </a>&nbsp;
  <a href="javascript:pc.navigate('<%=url+"&startidx="+(startIndex-recordCount)%>')" >
 [<%= LanguageUtil.get(pageContext, "previous-page")%>]
 </a>&nbsp;
  <a href="javascript:pc.navigate('<%=url+"&startidx="+(startIndex+recordCount)%>')" >
 [<%= LanguageUtil.get(pageContext, "next-page")%>]
 </a>&nbsp;
 <a href="javascript:pc.navigate('<%=url+"&startidx="+(totalCount-recordCount)%>')" >
 	[<%= LanguageUtil.get(pageContext, "last-page")%>]
 </a>&nbsp; <%=(startIndex+1)%>-<%=(startIndex+pageRecordCount)%>/<%=totalCount%>
 
</div>
</form>
<input type='hidden' name='queryindex_-1' id='queryindex_-1' value="-1" />
<script type="text/javascript">
 //var selTb= new SelectableTableRows(document.getElementById("inc_table"), false);
</script>
