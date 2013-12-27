<%
 int unReadCnt=Tools.getInt(QueryEngine.getInstance().doQueryOne("select count(*) from u_note where user_id="+ userWeb.getUserId()+" and DOCSTATUS='INIT'"), -1);
 if(unReadCnt>0){
%>
<table border="0" cellpadding="0" cellspacing="0" width='<%=tableWidth%>' align="center">
<tr><td align='right'>
<a class="redlink" href="<%=NDS_PATH%>/sheet/objects.jsp?table=U_NOTE" title='<%= PortletUtils.getMessage(pageContext, "you-have-total",null)%><%=unReadCnt%><%= PortletUtils.getMessage(pageContext, "unread-notes",null)%>'>
<img width=16 height=16 border=0 src="<%=contextPath%>/html/nds/images/warn.gif">
</a></td></tr>
</table>
<%}%>
