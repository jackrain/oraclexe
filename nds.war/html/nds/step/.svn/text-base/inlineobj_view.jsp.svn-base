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
<div class="<%=uiConfig.getCssClass()%>">
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
	<div id="inline-obj-inputs"><!--OBJ_INPUTS1_BEGIN-->
		<%@ include file="inc_single_object.jsp" %><!--OBJ_INPUTS1_END-->
	</div>

</div>

<%}// end (result.getTotalRowCount()!=0)
%>

