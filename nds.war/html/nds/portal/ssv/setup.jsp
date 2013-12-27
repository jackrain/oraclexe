<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*"%>
<%
List al=QueryEngine.getInstance().doQueryList("select u.is_out, u.assignee_id, a.name, a.truename from users u, users a where a.id(+)=u.assignee_id and u.id="+userWeb.getUserId());
al=(List)al.get(0);
boolean isOut="Y".equals(al.get(0));
int assigneeId= Tools.getInt(al.get(1), -1);
String assignee= (assigneeId==-1? "": (String)al.get(2));
String desc= (assigneeId==-1? "": (String) al.get(3));
FKObjectQueryModel fkQueryModel=new FKObjectQueryModel(TableManager.getInstance().getTable("users"), "assignee",null);
fkQueryModel.setQueryindex(-1);
%>
<input type='hidden' name='queryindex_-1' id='queryindex_-1' value="-1" />
<form action="/control/command" method="post" name="fm2" id="form1">
<table border="0" cellpadding="4" cellspacing="0" width="100%">
	<input id="command" name="command" type="hidden" value="AuditSetup" act="command">
	<input id="auditActionType" type="hidden" name="auditAction" value="auditSetupAction" act="auditActionType">
	
	<tr>
		<td align="center">
			<table border="0" cellpadding="0" cellspacing="0">
			
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<font class="gamma" size="2">
							<%= LanguageUtil.get(pageContext, "assign-to") %>
							</font>
						</td>
						<td width="10">
							&nbsp;
						</td>
						<td>
							<input class="form-text" type="text" id="assignee2" name="assignee2" value="<%=assignee%>">
		                	<span id="cbt_assignee" onaction="oq.toggle('/html/nds/query/search.jsp?table=10085&return_type=s&accepter_id=assignee2&qdata='+encodeURIComponent(document.getElementById('assignee2').value)+'&queryindex='+encodeURIComponent(document.getElementById('queryindex_-1').value),'assignee2')">
		                		 <img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
		                		<script>
									        createButton(document.getElementById("cbt_assignee"));
								        </script>
		                	<%=desc%>
						</td>
					</tr>
					
					</table>
				</td>
			</tr>
			<tr>
				<td><img border="0" height="8" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
			</tr>
			<tr>
				<td align="center">
					<%if(assigneeId==-1){%>
					   <input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "set-out",null)%>" onclick="pc.submitAuditForm2('setout')" >&nbsp;&nbsp;
					<%}else{%>
					   <input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "save",null)%>" onclick="pc.submitAuditForm2('setout')" >&nbsp;&nbsp;
					   <input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "cancel-out",null)%>" onclick="pc.submitAuditForm2('cancelout')" >&nbsp;&nbsp;
					<%}%>
				</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
</form>

