<%
/**
* defined variables outside:objectId,table,tableId
*/
if(objectId!=-1 && !userWeb.isGuest()){ 
	/*lastCommentInfo: time, userid, username, comments */
	lastCommentInfo=QueryUtils.getLastComments(table.getRealTableName(), objectId);
	if(lastCommentInfo==null){
	%>
		<div class="linkbtn"><a class="btn" href="javascript:popup_window('<%=NDS_PATH+"/sheet/comments.jsp?record_table="+tableId+"&record_id="+objectId%>')">
			<img border=0 width=16 height=16 src='<%=NDS_PATH+"/images/comments.gif"%>'>
			<%=PortletUtils.getMessage(pageContext, "add-comments",null)%>
		</a></div>
	<%
	}else{
	%>		
		<div class="linknote" onclick="popup_window('<%=NDS_PATH+"/sheet/comments.jsp?record_table="+tableId+"&record_id="+objectId%>')">
		<img border=0 width=16 height=16 src='<%=NDS_PATH+"/images/comments.gif"%>'>
		<%= ((java.text.SimpleDateFormat)QueryUtils.smallDateTimeSecondsFormatter.get()).format(lastCommentInfo[0])%>&nbsp;&nbsp;
		<%= lastCommentInfo[3]%> &nbsp;--&nbsp;<%=lastCommentInfo[2]%>
		</div>
	<%}
}%>
