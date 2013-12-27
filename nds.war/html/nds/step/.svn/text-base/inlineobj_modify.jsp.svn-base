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

<div class="<%=uiConfig.getCssClass()%>">
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
	%>			
	<div id="inline-obj-inputs"><!--OBJ_INPUTS1_BEGIN-->
		<%@ include file="inc_single_object.jsp" %><!--OBJ_INPUTS1_END-->
	</div>
</div>	
<%}// end if(objectId == -1 || (result!=null && result.getTotalRowCount()>0)){
else{%>
		<div class="msg-error"><%=PortletUtils.getMessage(pageContext, "object-not-exists",null)%></div>
<%}%>


