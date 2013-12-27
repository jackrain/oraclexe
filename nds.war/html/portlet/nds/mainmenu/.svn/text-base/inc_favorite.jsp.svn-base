<%
 QueryRequestImpl query= QueryEngine.getInstance().createRequest(userWeb.getSession());
 Table favTable= TableManager.getInstance().getTable("u_favorite");
 query.setMainTable(favTable.getId());
 query.addSelection(favTable.getColumn("name").getId());
 query.addSelection(favTable.getColumn("url").getId());
 query.addSelection(favTable.getColumn("target").getId());
 query.addParam(favTable.getColumn("ownerid").getId(), "="+userWeb.getUserId());
 query.addParam(favTable.getColumn("ISPUBLIC").getId(), "=N"); //not public 
 query.addOrderBy(new int[]{favTable.getColumn("id").getId()}, false);
 
 query.setRange(0,50);
 QueryResult result= QueryEngine.getInstance().doQuery(query);
 if(result.getRowCount()>0){
%>
<tr>
<td valign="top" align="center" colspan="3">
<table border="0" cellpadding="0" cellspacing="0" width='90%' align="center">
<tr><td nowrap><font class="beta"><b><%= PortletUtils.getMessage(pageContext, "my-favorite",null)%></b></font></td>
<td width="90%"><hr width="90%" size="1" noshade color="<%=colorScheme.getPortletBg()%>"></td>
</tr></table>
</td></tr>
<tr>
<td valign="top" align='left'><font class="gamma" size="2">
<%
 for(int i=1;i<result.getRowCount()/2+1;i++){
 	result.next();
%>
<a class="gamma" href="javascript:popup_window('<%=result.getObject(2)%>','<%=result.getObject(3)%>',screen.width,screen.height)"><%=result.getObject(1)%></a><br>
<%}%>
</font></td><td></td>
<td valign="top" align='left'><font class="gamma" size="2">
<%
 for(int i=result.getRowCount()/2+1;i<(result.getRowCount()+1);i++){
 	result.next();
%>
<a class="gamma" href="javascript:popup_window('<%=result.getObject(2)%>','<%=result.getObject(3)%>',screen.width,screen.height)"><%=result.getObject(1)%></a><br>
<%}%></font></td></tr>
<%}%>
<%
 // for public favorite
 query= QueryEngine.getInstance().createRequest(userWeb.getSession());
 
 query.setMainTable(favTable.getId());
 query.addSelection(favTable.getColumn("name").getId());
 query.addSelection(favTable.getColumn("url").getId());
 query.addSelection(favTable.getColumn("target").getId());
 query.addParam(favTable.getColumn("ISPUBLIC").getId(), "=Y"); //public 
 query.addOrderBy(new int[]{favTable.getColumn("id").getId()}, false);
 
 query.setRange(0,50);
 result= QueryEngine.getInstance().doQuery(query);
 if(result.getRowCount()>0){
%>
<tr>
<td valign="top" align="center" colspan="3">
<table border="0" cellpadding="0" cellspacing="0" width='90%' align="center">
<tr><td nowrap><font class="beta"><b><%= PortletUtils.getMessage(pageContext, "public-favorite",null)%></b></font></td>
<td width="90%"><hr width="90%" size="1" noshade color="<%=colorScheme.getPortletBg()%>"></td>
</tr></table>
</td></tr>
<tr>
<td valign="top" align='left'><font class="gamma" size="2">
<%
 for(int i=1;i<result.getRowCount()/2+1;i++){
 	result.next();
%>
<a class="gamma" href="javascript:popup_window('<%=result.getObject(2)%>','<%=result.getObject(3)%>')"><%=result.getObject(1)%></a><br>
<%}%>
</font></td><td></td>
<td valign="top" align='left'><font class="gamma" size="2">
<%
 for(int i=result.getRowCount()/2+1;i<(result.getRowCount()+1);i++){
 	result.next();
%>
<a class="gamma" href="javascript:popup_window('<%=result.getObject(2)%>','<%=result.getObject(3)%>')"><%=result.getObject(1)%></a><br>
<%}%></font></td></tr>
<%}%>

