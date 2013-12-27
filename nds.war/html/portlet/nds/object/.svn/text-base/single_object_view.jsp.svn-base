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
<form name="<%=namespace%>fm" method="post" action="<%=contextPath %>/control/command" onSubmit="return ptc.submitForm(this);">
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
	bReplaceVariable= false;
	//load preference values from ad_user_pref, key name: column.name.tolowercase
	//not do cache, because the synchronization between cache and db is not implemented currently.
	objprefs= userWeb.getPreferenceValues("template."+table.getName().toLowerCase(),false,bReplaceVariable);
%>	
	<div class="obj">
		<%@ include file="inc_single_object.jsp" %>
	</div>
	<div class="buttons">
	<%if(!userWeb.isGuest()){%>
		<%@ include file="inc_single_object_view_buttons.jsp" %>
	<%}%>
	</div>
<%
if(status==2){
%>
	<div class="submit-status">
	<%
	if("CN".equals(locale.getCountry())){%>
		<img src="<%=NDS_PATH+"/images/submitted-small_zh_CN.gif"%>" width="74" height="58">
	<%}else{%>
		<img src="<%=NDS_PATH+"/images/submitted-small.gif"%>" width="74" height="58">
	<%}%>
	</div>
<%}%>
</div>
</form>
<%}// end (result.getTotalRowCount()==0)
%>

