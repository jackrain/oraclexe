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
	String form_name="single_object_modify";
%>
<form name="<%=namespace%>fm" method="post" action="<%=contextPath %>/control/command" onSubmit="return ptc.submitForm(this);">
<input type='hidden' name='namespace' value='<%= namespace%>'>
<input type='hidden' name='tablename' value='<%= table.getName()%>'>
<input type='hidden' name='directory' value='<%= directory%>'>
<input type='hidden' name="fixedcolumns" value="<%= fixedColumns.toURLQueryString("")%>">
<input type='hidden' name="copyfromid">
<div class="<%=uiConfig.getCssClass()%>">
	<div class="title">
		<%=table.getDescription(locale)%>
	</div>
	<%if(uiConfig.isShowComments()){%>
	<div class="comments">
		<%@ include file="inc_object_comments.jsp" %>
	</div>
	<%}%>
	
	<%
    //if true, will show data without variable, else show variable directly. This is used for template setting page
    //@see inc_template.jsp/inc_batchupdate.jsp
    bReplaceVariable= true;
    //load preference values from ad_user_pref, key name: column.name.tolowercase
    //not do cache, because the synchronization between cache and db is not implemented currently.
    objprefs= userWeb.getPreferenceValues("template."+table.getName().toLowerCase(),false,bReplaceVariable);
	%>			
	<div class="obj">
		<%@ include file="inc_single_object.jsp" %>
	</div>
	<div class="buttons">
		<%@ include file="inc_single_object_modify_buttons.jsp" %>
	</div>
</div>	
</form>

<%}// end if(objectId == -1 || (result!=null && result.getTotalRowCount()>0)){
else{%>
		<div class="msg-error"><%=PortletUtils.getMessage(pageContext, "object-not-exists",null)%></div>
<%}%>


