<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/portlet/nds/init.jsp" %>
<%@ page import="nds.control.util.*"%>
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
String np= renderResponse.getNamespace();
String curTime=String.valueOf(System.currentTimeMillis());
if(!userWeb.isActive()){
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td align="center">
<font class="bg" size="2"><span class="bg-neg-alert">
<%= PortletUtils.getMessage(pageContext, "current-are-not-active",null)%>
</span></font>
</td></tr></table>

<%  }else{
%>
<c:if test="<%= SessionErrors.contains(renderRequest, NDSException.class.getName()) %>">
<table border="0" cellpadding="0" cellspacing="0" width="98%">
<tr><td><font class="bg" size="1"><span class="bg-neg-alert"><%= MessagesHolder.getInstance().translateMessage(((Exception)renderRequest.getAttribute(PageContext.EXCEPTION)).getMessage(), locale) %></span></font>
</td></tr>
</table>
</c:if>
<c:if test="<%= SessionMessages.contains(renderRequest, \"execute_audit\") %>">
	<table border="0" cellpadding="0" cellspacing="0" width="98%">
	<tr>
		<td>
			<font class="bg" size="1"><span class="bg-pos-alert"><%=MessagesHolder.getInstance().translateMessage((String)SessionMessages.get(renderRequest,"execute_audit"),locale)%></span></font>
		</td>
	</tr>
	</table>
</c:if>
<%
DateFormat df =((java.text.SimpleDateFormat)QueryUtils.dateFormatter.get());// new java.text.SimpleDateFormat("MM-dd HH");
//df.setTimeZone(timeZone);

TableManager manager=TableManager.getInstance();
int startIndex= ParamUtil.get(renderRequest, "startidx", 0);
int orderColumnId= ParamUtil.get(renderRequest, "order", -1);
int asc= ParamUtil.get(renderRequest, "asc", -1);
if(orderColumnId==-1)
	orderColumnId=TableManager.getInstance().getColumn("u_note","creationdate").getId();

boolean isOut= "Y".equals( QueryEngine.getInstance().doQueryOne("select is_out from users where id="+ userWeb.getUserId()));
boolean showAssignment=ParamUtil.get(renderRequest,"showassign",false);
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
 
%>
<form action="<portlet:actionURL><portlet:param name="struts_action" value="/ndsaudit/audit" /></portlet:actionURL>" method="post" name="fm_<%=renderResponse.getNamespace()%>">
<table border="0" cellpadding="0" cellspacing="0" width="98%">
<input name="<%=np%><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
<input type="hidden" name="<%=np%>auditAction" value="">
<input type='hidden' name='<%=np%>arrayItemSelecter' value='selectedItemIdx'>
<% 
	if(renderRequest.getWindowState() !=WindowState.MAXIMIZED ){
		// wide one
		recordCount=15;
		maxTitleLength=MAX_SUBJECT_LENGTH_WIDE_1024;
	}else{
		// maiximized one
		recordCount=30;
		maxTitleLength=MAX_SUBJECT_LENGTH_MAX_1024;
	}
 	result= AuditUtils.findWaitingInstances(request, recordCount, startIndex, showAssignment);
 	pageRecordCount=result.getRowCount();
%>
<tr><td width=1></td><td colspan="4" align="right">
<%if(isOut){%>
<span class="bg-neg-alert">	<%= PortletUtils.getMessage(pageContext, "is-out",null)%></span>
[<a class="bg" title="<%= PortletUtils.getMessage(pageContext, "click-to-setup-work-state",null)%>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ndsaudit/setup" /></portlet:actionURL>" styleClass="bg">
<%= PortletUtils.getMessage(pageContext, "setup",null)%></a>]
<%}else{%>
[<a class="bg" title="<%= PortletUtils.getMessage(pageContext, "click-to-setup-work-state",null)%>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ndsaudit/setup" /></portlet:actionURL>" styleClass="bg">
	<%= PortletUtils.getMessage(pageContext, "out-setting",null)%>
</a>]
<%}%>
</td></tr>
<tr><td width=1></td><td colspan="4">
<%if(!showAssignment){%>
<%= PortletUtils.getMessage(pageContext, "audit-comments",null)%>:<input type="text" class="form-text" size="20" maxlength="255" name="<%=np%>comments" value="">
<input class="portlet-form-button" type='button' value='<%= PortletUtils.getMessage(pageContext, "object.accept",null)%>' onclick="submitfm_<%=renderResponse.getNamespace()%>('accept')" >&nbsp;&nbsp;
<input class="portlet-form-button" type='button' value='<%= PortletUtils.getMessage(pageContext, "object.reject",null)%>' onclick="submitfm_<%=renderResponse.getNamespace()%>('reject')" >&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;<%= PortletUtils.getMessage(pageContext, "assignee",null)%>:<input type="text" class="form-text" size="15" maxlength="80" id="<%=np%>assignee"  name="<%=np%>assignee" value="">
<span id='<%=renderResponse.getNamespace()%>user' name="popup" onaction=popup_window("<%="/servlets/query?table="+manager.getTable("users").getId()+"&return_type=s&accepter_id="+np+"assignee"%>","<%="T"+System.currentTimeMillis() %>")><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'></span>
<script>
	createButton(document.getElementById("<%=renderResponse.getNamespace()%>user"));
</script>
<input class="portlet-form-button" type='button' value='<%= PortletUtils.getMessage(pageContext, "object.assign",null)%>' onclick="submitfm_<%=renderResponse.getNamespace()%>('assign')" >&nbsp;&nbsp;

<%}else{%>
<input class="portlet-form-button" type='button' value='<%= PortletUtils.getMessage(pageContext, "object.cancel-assign",null)%>' onclick="submitfm_<%=renderResponse.getNamespace()%>('cancel_assign')" >&nbsp;&nbsp;
<%}%>
</td></tr>
<tr><td colspan="5">&nbsp;
</td></tr>
<tr class="beta">
<td width=1><input class='cbx' type="checkbox" name="myCheckBoxAll" value=1 onclick=sel_<%=renderResponse.getNamespace()%>(fm_<%=renderResponse.getNamespace()%>,<%=pageRecordCount%>)> </td>
<td> <font class="beta" size="2"><b><%= PortletUtils.getMessage(portletConfig, locale, "docno" ,null)%> </b></td>
<td> <font class="beta" size="2"><b><%= manager.getTable("au_process").getDescription(locale)%></b> </td>
<td> <font class="beta" size="2"><b><%= PortletUtils.getMessage(portletConfig, locale, "description" ,null)%> </b></td>
<td> <font class="beta" size="2"><b><%= PortletUtils.getMessage(portletConfig, locale, showAssignment?"assignee":"creationdate" ,null)%></b> </td>
</tr>
<%
 if(pageRecordCount==0){
%> 
<tr class="gamma">
			<td align="center" colspan="5" valign="top">
				<font class="gamma" size="2">
				<%= LanguageUtil.get(pageContext, "no-data") %>
				</font>
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
 	 if(table.getRealTableName()!=null) tableId=manager.getTable(table.getRealTableName()).getId();
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
		<tr class="<%=className%>">
		    <td width=1>
		    <input type='hidden' id='akData' name='<%=np%>itemid' value='<%=oid%>' >
		    <input class='cbx' type='checkbox' id='chk_obj_<%=oid%>' name='<%=np%>selectedItemIdx' value='<%=relativeIdx%>' onclick="unsel_<%=renderResponse.getNamespace()%>(fm_<%=renderResponse.getNamespace()%>)">
			</td>
			<td><a class="<%=className%>" href='<%="javascript:op_"+renderResponse.getNamespace()+"("+tableId+","+ recordId+")"%>'><%=recordDocNo%></a></td>
			<td><a class="<%=className%>" href='<%="javascript:op_"+renderResponse.getNamespace()+"("+phaseInstanceTableId+","+ oid+")"%>'><%=processName%></a></td>
			<td><font class="<%=className%>" size="2"><%=brief%></font></td>
			<td>
			<%if(showAssignment){%>
				<a class="<%=className%>" href='<%="javascript:op_"+renderResponse.getNamespace()+"("+userTableId+","+ assigneeId+")"%>'><%=assigneeName%></a>
			<%}else{%>
				<font class="<%=className%>" size="2"><%=creationDate%></font>
			<%}%>
			</td>
		</tr>
		
<%
 }
if(renderRequest.getWindowState() !=WindowState.MAXIMIZED ){
 // wide one
%>

<tr><td align='right' colspan=5><br><font class="gamma" size="2">
 [<a class="bg" href="<portlet:renderURL><portlet:param name="showassign" value="<%=Boolean.toString(!showAssignment)%>" /></portlet:renderURL>" styleClass="bg"><%= PortletUtils.getMessage(pageContext, showAssignment?"show-my-work-list":"show-assign",null)%></a>]&nbsp;
 [<a class="gamma" href="<portlet:renderURL><portlet:param name="t" value="<%=curTime%>" /><portlet:param name="showassign" value="<%=Boolean.toString(showAssignment)%>" /></portlet:renderURL>">
 	<%= PortletUtils.getMessage(portletConfig, locale, "refresh",null)%>
 </a>] &nbsp;  
  [<a class="gamma" href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"/>">
 	<%= PortletUtils.getMessage(portletConfig, locale, "more",null)%>
 </a>]
</font>
</td></tr>

<%
 }else{
 // max one
 int totalCount=AuditUtils.getTotalCount(request,showAssignment);
%>
<tr><td align='right' colspan=5><br><font class="gamma" size="2">
[<a class="bg" href="<portlet:renderURL><portlet:param name="showassign" value="<%=Boolean.toString(!showAssignment)%>" /></portlet:renderURL>" styleClass="bg"><%= PortletUtils.getMessage(pageContext, showAssignment?"show-my-work-list":"show-assign",null)%></a>]&nbsp;
[<% for(i=0 ;i< ((totalCount/recordCount)>15?15:(totalCount/recordCount));i++){ %>
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="startidx" value="<%=""+i*recordCount%>" /><portlet:param name="showassign" value="<%=Boolean.toString(showAssignment)%>" /></portlet:renderURL>" >
 	<%=(i*recordCount)+1%>,&nbsp;
 </a>
<%}%>
&nbsp;&nbsp;
<a class="gamma" href="<portlet:renderURL><portlet:param name="t" value="<%=curTime%>" /><portlet:param name="showassign" value="<%=Boolean.toString(showAssignment)%>" /></portlet:renderURL>">
 	<%= PortletUtils.getMessage(portletConfig, locale, "refresh",null)%>
 </a> &nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="showassign" value="<%=Boolean.toString(showAssignment)%>" /><portlet:param name="startidx" value="<%="0"%>" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "first-page",null)%>
 </a>,&nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="showassign" value="<%=Boolean.toString(showAssignment)%>" /><portlet:param name="startidx" value="<%=""+(startIndex-recordCount)%>" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "previous-page",null)%>
 </a>,&nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="showassign" value="<%=Boolean.toString(showAssignment)%>" /><portlet:param name="startidx" value="<%=""+(startIndex+recordCount)%>" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "next-page",null)%>
 </a>,&nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="showassign" value="<%=Boolean.toString(showAssignment)%>" /><portlet:param name="startidx" value="<%=""+(totalCount-recordCount)%>" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "last-page",null)%>
 </a>,&nbsp;
 ]
</font>
</td></tr> 
<%}
%>
</table>
</form>
<script type="text/javascript">
 function sel_<%=renderResponse.getNamespace()%>(fm, len){
    fm.myCheckBoxAll.checked = fm.myCheckBoxAll.checked|0;
    if (len == 0 ){return; }
    if (len ==1 ){try{fm.<%=np%>selectedItemIdx.checked=fm.myCheckBoxAll.checked ; }catch(ex){}}
    if (len>1){
      for (var i = 0; i < len; i++){try{fm.<%=np%>selectedItemIdx[i].checked=fm.myCheckBoxAll.checked;}catch(ex){}}
    } 
 }
 function unsel_<%=renderResponse.getNamespace()%>(fm){
    if(fm.myCheckBoxAll.checked){fm.myCheckBoxAll.checked = fm.myCheckBoxAll.checked&0;}
 }
  function op_<%=renderResponse.getNamespace()%>(tid,oid){
 	popup_window("<%=NDS_PATH%>/object/object.jsp?table="+tid+"&id="+oid);
 }
  function submitfm_<%=renderResponse.getNamespace()%>(action){
 	if(action=='assign'){
	 	var v=fm_<%=renderResponse.getNamespace()%>.<%=np%>assignee.value;
 		if (v==null || v.length==0){
 		 	alert("<%= PortletUtils.getMessage(pageContext, "please-set-assignee",null)%>");
 		 	return false;
 		 }
 	}
 	fm_<%=renderResponse.getNamespace()%>.<%=np%>auditAction.value=action;
 	submitForm(fm_<%=renderResponse.getNamespace()%>);
 }
</script>
<%}//end if acitve
%>
