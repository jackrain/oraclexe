<%
/**
* defined variables outside:objectId,table,tableId
*/
if(objectId!=-1 && !userWeb.isGuest()){ 
	/*lastCommentInfo: time, userid, username, comments */
	lastCommentInfo=QueryUtils.getLastComments(table.getRealTableName(), objectId);
	if(lastCommentInfo==null){
	%>
		<span><a class="btn" href="javascript:popup_window('<%=NDS_PATH+"/objext/comments.jsp?record_table="+tableId+"&record_id="+objectId%>')">
			<img border=0 width=16 height=16 src='<%=NDS_PATH+"/images/comments.gif"%>'>
			<%=PortletUtils.getMessage(pageContext, "add-comments",null)%>
		</a></span>
	<%
	}else{
	%>		
		<span class="linknote" onclick="popup_window('<%=NDS_PATH+"/objext/comments.jsp?record_table="+tableId+"&record_id="+objectId%>')">
		<img border=0 width=16 height=16 src='<%=NDS_PATH+"/images/comments.gif"%>'>
		<%= ((java.text.SimpleDateFormat)QueryUtils.smallDateTimeSecondsFormatter.get()).format(lastCommentInfo[0])%>&nbsp;&nbsp;
		<%= nds.util.StringUtils.shortenInBytes(lastCommentInfo[3].toString(),50,"...")%> &nbsp;--&nbsp;<%=lastCommentInfo[2]%>
		</span>
	<%}
}%>&nbsp;
 <span><a class="btn" href="javascript:popup_window('<%=NDS_PATH+"/help/index.jsp?table="+table.getId()%>')">
	<img border=0 width=16 height=16 src='<%=NDS_PATH+"/images/help.gif"%>'>
	<%= PortletUtils.getMessage(pageContext, "help",null)%>
</a></span>
