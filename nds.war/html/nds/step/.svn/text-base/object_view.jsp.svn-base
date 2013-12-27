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
<div class="<%=uiConfig.getCssClass()%>" id="<%=uiConfig.getCssClass()%>">
<form name="<%=namespace%>fm" method="post" action="<%=contextPath %>/control/command" onSubmit="return ptc.submitForm(this);">
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
		<%@ include file="inc_single_object_view.jsp" %><!--OBJ_INPUTS1_END-->
	</div>
	<% if( !Boolean.FALSE.equals(request.getAttribute("showtabs"))){%>
		<%@ include file="inc_tabs_view.jsp" %>
	<%}%>
</form>	
</div>

<%}// end (result.getTotalRowCount()!=0)
%>