<%@ include file="/html/portlet/nds/init.jsp" %>
<%
List al=QueryEngine.getInstance().doQueryList("select u.is_out, u.assignee_id, a.name, a.truename from users u, users a where a.id(+)=u.assignee_id and u.id="+userWeb.getUserId());
al=(List)al.get(0);
boolean isOut="Y".equals(al.get(0));
int assigneeId= Tools.getInt(al.get(1), -1);
String assignee= (assigneeId==-1? "": (String)al.get(2));
String desc= (assigneeId==-1? "": (String) al.get(3));

String np= renderResponse.getNamespace();
%>
<script>
 function submitfm2_<%=np%>(action){
 	if(action=='setout'){
 		var e=document.getElementById("<portlet:namespace />assignee").value;
 		if(((e == null) || (e.length == 0))){
 			alert("<%= LanguageUtil.get(pageContext, "please-set-assignee") %>");
 			return false;
 		}
 	}
 	<portlet:namespace />fm2.<%=np%>auditSetupAction.value=action;
 	
 	submitForm(<portlet:namespace />fm2);
 }
</script>

<c:if test="<%= SessionErrors.contains(renderRequest, NDSException.class.getName()) %>">
<table border="0" cellpadding="0" cellspacing="0" width="98%">
<tr><td><font class="bg" size="1"><span class="bg-neg-alert"><%= MessagesHolder.getInstance().translateMessage(((Exception)renderRequest.getAttribute(PageContext.EXCEPTION)).getMessage(), locale) %></span></font>
</td></tr>
</table>
</c:if>
<c:if test="<%= SessionMessages.contains(renderRequest, \"audit_setup\") %>">
	<table border="0" cellpadding="0" cellspacing="0" width="98%">
	<tr>
		<td>
			<font class="bg" size="1"><span class="bg-pos-alert"><%=MessagesHolder.getInstance().translateMessage((String)SessionMessages.get(renderRequest,"audit_setup"),locale)%></span></font>
		</td>
	</tr>
	</table>
	<br>
</c:if>
	<table border="0" cellpadding="4" cellspacing="0" width="100%">
	<form action="<portlet:actionURL><portlet:param name="struts_action" value="/ndsaudit/setup" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm2" onSubmit="submitForm(this); return false;">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<input type="hidden" name="<%=np%>auditSetupAction" value="">
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
							<input class="form-text" type="text" id="<portlet:namespace />assignee" name="<portlet:namespace />assignee" value="<%=assignee%>">
		                	<span id="<portlet:namespace />cbt_assignee" onaction=popup_window("<%="/servlets/query?table="+TableManager.getInstance().getTable("users").getId()+"&return_type=s&accepter_id="%><portlet:namespace />assignee","<%="T"+System.currentTimeMillis() %>")><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
		                		<script>
									createButton(document.getElementById("<portlet:namespace />cbt_assignee"));
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
					<input type="button" value="<%=PortletUtils.getMessage(pageContext, "set-out",null)%>" onclick="submitfm2_<%=np%>('setout')" >&nbsp;&nbsp;
					<%}else{%>
					<input type="button" value="<%=PortletUtils.getMessage(pageContext, "save",null)%>" onclick="submitfm2_<%=np%>('setout')" >&nbsp;&nbsp;
					<input type="button" value="<%=PortletUtils.getMessage(pageContext, "cancel-out",null)%>" onclick="submitfm2_<%=np%>('cancelout')" >&nbsp;&nbsp;
					<%}%>
					<input type="button" value="<%=PortletUtils.getMessage(pageContext, "backward",null)%>" onClick="self.location = '<portlet:renderURL><portlet:param name="struts_action" value="/ndsaudit/view" /></portlet:renderURL>';">
				</td>
			</tr>
			</table>
		</td>
	</tr>

	</form>

	</table>

