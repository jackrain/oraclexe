<%@page errorPage="/html/nds/error.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*"%>
<%!
	
 	private final static int MAX_SUBJECT_LENGTH_NARROW_1024=30;
 	private final static int MAX_SUBJECT_LENGTH_WIDE_1024=50;
 	private final static int MAX_SUBJECT_LENGTH_MAX_1024=100;
 	private final static int MAX_SUBJECT_LENGTH_NARROW_800=24;
 	private final static int MAX_SUBJECT_LENGTH_WIDE_800=40;
 	private final static int MAX_SUBJECT_LENGTH_MAX_800=80;	
%>

<%
String curTime=String.valueOf(System.currentTimeMillis());
java.text.DateFormat df =((java.text.SimpleDateFormat)QueryUtils.dateFormatter.get());// new java.text.SimpleDateFormat("MM-dd HH");
//df.setTimeZone(timeZone);

TableManager manager=TableManager.getInstance();
int startIndex= 0;
if(startIndex<0) startIndex=0;
boolean isOut= "Y".equals( QueryEngine.getInstance().doQueryOne("select is_out from users where id="+ userWeb.getUserId()));
boolean showAssignment=false;
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
<div class="aud">
<form id="form1" method="POST">
<div id="audit_toolbar">
<input id="command" name="command" type="hidden" value="ExecuteAudit">
<input id="auditActionType" type="hidden" name="auditAction" value="auditAction">
<input type='hidden' name='arrayItemSelecter' value='selectedItemIdx'>
<% 
	// maiximized one
	recordCount=5;
	maxTitleLength=MAX_SUBJECT_LENGTH_MAX_1024;
 	result= AuditUtils.findWaitingInstances(request, recordCount, startIndex, showAssignment);
 	pageRecordCount=result.getRowCount();
%>
<%if(!showAssignment){%>
<%="audit-comments"%>: &nbsp;&nbsp;<input type="text" class="form-text2" size="20" maxlength="255" name="comments" id="comments" value="">
<a class="imgbtn" href="javascript:void(0)" onclick="javascript:oa.submitAuditForm('accept')"><img src="/html/nds/portal/ssv/images/accept.png" title="批准"></a>&nbsp;&nbsp;
<a class="imgbtn" href="javascript:void(0)" onclick="javascript:oa.submitAuditForm('reject')"><img src="/html/nds/portal/ssv/images/reject.png" title="驳回"></a>&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;<%="assignee"%>:&nbsp;&nbsp;<input type="text" class="form-text2" size="10" maxlength="80" id="assignee"  name="assignee" value="">
<span id="user" onaction="<%=fkQueryModel.getButtonClickEventScript()%>"><img class="img_class" align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
<script>
	createButton(document.getElementById("user"));
</script>

<input class="cbutton" title="转派" type='button' value='转派' onclick="oa.submitAuditForm('assign')" >&nbsp;&nbsp;

<%}else{%>
<input class="cbutton" type='button' value='<%="object.cancel-assign"%>' onclick="oa.submitAuditForm('cancel_assign')" >&nbsp;&nbsp;
<%}%>

<%if(isOut){%>
<br/>
<span class="bg-neg-alert">	<%="is-out"%></span>
<a title="<%="click-to-setup-work-state"%>" href="javascript:oa.showdlg('/html/nds/portal/ssv/audit_setup.jsp')" styleClass="bgg">
[<%="setup"%>]</a>
<%}else{%>
<a title="<%="click-to-setup-work-state"%>" href="javascript:oa.showdlg('/html/nds/portal/ssv/audit_setup.jsp')" styleClass="bgg">
	[<%="out-setting"%>]
</a>
<%}%>
</div>
<%@include file="/html/nds/portal/ssv/inc_audits_msgs.jsp"%>
<table width="95%" cellspacing="1" cellpadding="2" class="sort-table" id="inc_table">
<thead><tr>
<td width=1><input class='cbx' type="checkbox" id="chk_select_all" name="chk_select_all" value=1 onclick='javscript:oa.checkAll("form1",<%=pageRecordCount%>)'> </td>
<td><%="docno"%></td>
<td><%= manager.getTable("au_process").getDescription(locale)%></td>
<td><%="description"%></td>
<td><%=showAssignment?"assignee":"creationdate"%></td>
</tr>
</thead>
<%
 if(pageRecordCount==0){
%> 
<tr>
			<td align="center" colspan="5" valign="top">
				<%="no-data"%>
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
		<tr id="<%=oid%>_templaterow">
		    <td width=1>
		    <input class='cbx' type='checkbox' id='chk_obj_<%=oid%>' name='itemid' value='<%=oid%>' onclick="oa.unselectall()">
				</td>
				<td><a href="javascript:oa.auditObj(<%=oid%>)"><%=recordDocNo%></a></td>
				<td><a href="javascript:oa.auditObj(<%=oid%>)"><%=processName%></a></td>
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
</form>
</div>
<input type='hidden' name='queryindex_-1' id='queryindex_-1' value="-1" />
<script type="text/javascript">
 var selTb= new SelectableTableRows(document.getElementById("inc_table"), false);
 selTb.ondoubleclick=function(trElement){
	oa.auditObj(trElement.id.replace(/_templaterow/i, ""));
 }; 
</script>
