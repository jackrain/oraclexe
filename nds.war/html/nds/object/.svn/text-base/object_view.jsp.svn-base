<%
//String object_page_url=(String) request.getAttribute("object_page_url");
actionType= Column.QUERY_OBJECT;
 
query=QueryEngine.getInstance().createRequest(userWeb.getSession());
query.setMainTable(tableId);
query.addAllShowableColumnsToSelection(actionType);
query.addParam( table.getPrimaryKey().getId(), ""+ objectId );
result=QueryEngine.getInstance().doQuery(query);
try{
if( manager.getColumn(table.getName(), "status")!=null )
	status= QueryEngine.getInstance().getSheetStatus(table.getRealTableName(),objectId);
}catch(Exception e){
}
if(result.getTotalRowCount()==0){
%>
	<div class="msg-error"><%=PortletUtils.getMessage(pageContext, "object-not-exists",null)%></div>
<%}else{
columns=table.getShowableColumns(actionType);
%>
<div id="obj-top">
<div class="buttons">
	<%if(!userWeb.isGuest()){%>
		<span id="buttons"><!--BUTTONS_BEGIN--><%@ include file="inc_single_object_view_buttons.jsp" %>
		<!--input id="objdropbtn" type="button"  class='cbutton' value="<%=PortletUtils.getMessage(pageContext, "more",null)%>"-->
		<a id="objdropbtn"><img src="/html/nds/images/button_more.png"/><%=PortletUtils.getMessage(pageContext, "more",null)%></a>
		<!--BUTTONS_END--></span>
	<%}%>
<%if(objHelp){%>	
<%@ include file="/html/nds/common/helpbtn.jsp"%>
<%}%><span id="closebtn"></span>
<%if (AuditUtils.hasPhaseInstance(tableId, objectId, userWeb.getUserId())) {%>
<a href="workflow.jsp?table=<%=tableId%>&id=<%=objectId%>">
	<%=PortletUtils.getMessage(pageContext, "view-workflow", null)%></a>
<%}%>
</div>
<div id="objmenu" class="obj-dock interactive-mode"><!--OBJMENU_BEGIN--><%@ include file="inc_objmenu_modify.jsp" %><!--OBJMENU_END--></div>
<div id="message" class="nt"><%@ include file="inc_message.jsp" %></div>
</div>

<div class="<%=uiConfig.getCssClass()%>" id="<%=uiConfig.getCssClass()%>">
<form name="<%=namespace%>fm" method="post" action="<%=contextPath %>/control/command" onSubmit="return false;">
<input type="hidden" name="id" value="<%=objectId %>">
<input type="hidden" name="table" value="<%=tableId %>">
	<%if(uiConfig.isShowComments()){%>
	<!--<div class="comments">
		 include file="inc_object_comments.jsp" 
	</div>-->
	<%}%>
	
<%
	//if true, will show data without variable, else show variable directly. This is used for template setting page
	//@see inc_template.jsp/inc_batchupdate.jsp
	bReplaceVariable= false;
	//load preference values from ad_user_pref, key name: column.name.tolowercase
	//not do cache, because the synchronization between cache and db is not implemented currently.
	objprefs= userWeb.getPreferenceValues("template."+table.getName().toLowerCase(),false,bReplaceVariable);

	model= new TableQueryModel(tableId, actionType,isInput,true,locale);
	if(result!=null)result.next();
	columnIndex=0;
	
%>	
	<div class="obj" id="obj_inputs_1"><!--OBJ_INPUTS1_BEGIN-->
		<%@ include file="inc_single_object.jsp" %><!--OBJ_INPUTS1_END-->
	</div>
	<% if( !Boolean.FALSE.equals(request.getAttribute("showtabs"))){%>
		<%@ include file="inc_tabs.jsp" %>
	<%}%>
	<%if(columnIndex!=columns.size()){%>
	<div class="obj" id="obj_inputs_2"><!--OBJ_INPUTS2_BEGIN-->
		<%@ include file="inc_single_object.jsp" %><!--OBJ_INPUTS2_END-->
	</div>
	<%}// end if(columnIndex!=columns.size())
	%>	
</form>	
</div>

<%}// end (result.getTotalRowCount()!=0)
%>

