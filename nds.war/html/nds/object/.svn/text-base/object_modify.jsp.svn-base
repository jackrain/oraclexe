<%
result=null;
if( objectId != -1){
	query=QueryEngine.getInstance().createRequest(userWeb.getSession());
    query.setMainTable(tableId);
	query.addAllShowableColumnsToSelection(Column.MODIFY);
    query.addParam( table.getPrimaryKey().getId(), ""+ objectId );
	result=QueryEngine.getInstance().doQuery(query);
}
if(objectId == -1 || (result!=null && result.getTotalRowCount()>0)){
	actionType= objectId ==-1?Column.ADD:Column.MODIFY;
	columns=table.getShowableColumns(actionType);
	
%>
<div id="obj-top">
<div class="buttons"><span id="buttons"><!--BUTTONS_BEGIN-->
<%@ include file="inc_single_object_modify_buttons.jsp" %>
<!--input id="objdropbtn" type="button"  class='cbutton' value="<%=PortletUtils.getMessage(pageContext, "more",null)%>"-->
<a id="objdropbtn"><img src="/html/nds/images/button_more.png"/><%=PortletUtils.getMessage(pageContext, "more",null)%></a>
<!--BUTTONS_END-->
</span>
<%if(objHelp){%>
<%@ include file="/html/nds/common/helpbtn.jsp"%>
<%}%><span id="closebtn"></span>
<%if (AuditUtils.hasPhaseInstance(tableId, objectId, userWeb.getUserId())) {%>
<a href="workflow.jsp?table=<%=tableId%>&id=<%=objectId%>">
	<%=PortletUtils.getMessage(pageContext, "view-workflow", null)%></a>
<%}%>
</div>
<div id="objmenu" class="obj-dock interactive-mode"><!--OBJMENU_BEGIN--><%@ include file="inc_objmenu_modify.jsp" %><!--OBJMENU_END--></div>
<div id="message" class="nt">
		<%@ include file="inc_message.jsp" %>
</div>
</div>
<div class="<%=uiConfig.getCssClass()%>" id="<%=uiConfig.getCssClass()%>">
	<%if(uiConfig.isShowComments()){%>
	<!--<div class="comments">
		include file="inc_object_comments.jsp" 
	</div>-->
	<%}%>
	<%
    //if true, will show data without variable, else show variable directly. This is used for template setting page
    //@see inc_template.jsp/inc_batchupdate.jsp
    bReplaceVariable= true;
    //load preference values from ad_user_pref, key name: column.name.tolowercase
    //not do cache, because the synchronization between cache and db is not implemented currently.
    objprefs= userWeb.getPreferenceValues("template."+table.getName().toLowerCase(),false,bReplaceVariable);

	model= new TableQueryModel(tableId, actionType,isInput,true,locale);
	if(result!=null)result.next();
	columnIndex=0;
	//columns will be changed inside,some moved to hiddenColumns as hide_condition adapted, not used
	//List hiddenColumns=WebUtils.filterHiddenColumns(result,columns,displayConditions);
	%>
	<div class="obj" id="obj_inputs_1"><!--OBJ_INPUTS1_BEGIN-->
		<%@ include file="inc_single_object.jsp" %><!--OBJ_INPUTS1_END-->
	</div>
	<% if( !Boolean.FALSE.equals(request.getAttribute("showtabs"))){%>
		<%@ include file="inc_tabs.jsp" %>
	<%}%>
		<div class="obj" id="obj_inputs_2"><!--OBJ_INPUTS2_BEGIN-->
	<%if(columnIndex!=columns.size()){%>

		<%@ include file="inc_single_object.jsp" %>
	<%}// end if(columnIndex!=columns.size())
	%>
	<!--OBJ_INPUTS2_END--></div>
</div>	
<%}// end if(objectId == -1 || (result!=null && result.getTotalRowCount()>0)){
else{%>
		<div class="msg-error"><%=PortletUtils.getMessage(pageContext, "object-not-exists",null)%></div>
<%}%>

