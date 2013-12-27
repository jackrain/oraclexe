<%@ include file="/html/portlet/nds/init.jsp" %>
<%
Portlet portlet = PortletManagerUtil.getPortletById(company.getCompanyId(), portletConfig.getPortletName());
String portletName=portletConfig.getPortletName();
String reportName=layoutId+"."+portletName;
Properties props= userWeb.getPreferenceValues(reportName,true);

	String query = ParamUtil.getString(request, "query");
	if(nds.util.Validator.isNull(query))query= props.getProperty("query","");
	
	String queue = ParamUtil.getString(request, "queue");
	
	if(nds.util.Validator.isNull(queue)){
		nds.schedule.JobManager jbm=(nds.schedule.JobManager) WebUtils.getServletContextManager().getActor( nds.util.WebKeys.JOB_MANAGER);
		queue= jbm.findQueueForProcessInstance(reportName,"nds.process.RefreshReport", userWeb.getUserId());
	}
	if(nds.util.Validator.isNull(queue)){
		queue="";
	}
	String title = ParamUtil.getString(request, "title");
	if(nds.util.Validator.isNull(title))title= props.getProperty("title","");
	boolean showBorders ="1".equals(props.getProperty("show_borders","1"));// ParamUtil.get(request, "show_borders", true);
	/*
	String showBordersParam = request.getParameter("show_borders");
	if ((showBordersParam == null) || (showBordersParam.equals("null"))) {
		showBorders=true;
	}*/
%>
	<table border="0" cellpadding="4" cellspacing="0" width="100%">
	<form action="<portlet:renderURL><portlet:param name="struts_action" value="/ndsgraph/setup" /></portlet:renderURL>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">

	<tr>
		<td align="center">
			<table border="0" cellpadding="0" cellspacing="0">

			<c:if test="<%= SessionErrors.contains(renderRequest, NDSException.class.getName()) %>">
				<tr>
					<td>
						<font class="bg" size="1"><span class="bg-neg-alert"><%= MessagesHolder.getInstance().translateMessage(((Exception)renderRequest.getAttribute(PageContext.EXCEPTION)).getMessage(), locale) %></span></font>
					</td>
				</tr>
				<tr>
					<td><img border="0" height="8" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
				</tr>
			</c:if>
			<tr>
				<td><img border="0" height="8" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
			</tr>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<font class="gamma" size="2">
							<%= LanguageUtil.get(pageContext, "title") %>
							</font>
						</td>
						<td width="10">
							&nbsp;
						</td>
						<td>
							<input type="text" name="<portlet:namespace />title" value="<%=title%>">
						</td>
					</tr>
					<tr>
						<td>
							<font class="gamma" size="2">
							<%= LanguageUtil.get(pageContext, "select-query") %>
							</font>
						</td>
						<td width="10">
							&nbsp;
						</td>
						<td>
							<input type="text" id="<portlet:namespace />queryid" name="<portlet:namespace />query" value="<%=query%>">
		                	<span id="<portlet:namespace />cbt_query" onaction=popup_window("<%="/servlets/query?table="+TableManager.getInstance().getTable("ad_query").getId()+"&return_type=s&accepter_id="%><portlet:namespace />fm.<portlet:namespace />queryid","<%="T"+System.currentTimeMillis() %>")><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
		                	<script>createButton(document.getElementById("<portlet:namespace />cbt_query"));</script>
						</td>
					</tr>
					<tr>
						<td><img border="0" height="8" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
					</tr>
					<tr>
						<td>
							<font class="gamma" size="2">
							<%= LanguageUtil.get(pageContext, "auto-update-schedule") %>
							</font>
						</td>
						<td width="10">
							&nbsp;
						</td>
						<td>
							<input type="text" id="<portlet:namespace />queueid" name="<portlet:namespace />queue" value="<%=queue%>">
							<span id="<portlet:namespace />cbt_queue" onaction=popup_window("<%="/servlets/query?table="+TableManager.getInstance().getTable("ad_processqueue").getId()+"&return_type=s&accepter_id="%><portlet:namespace />fm.<portlet:namespace />queueid","<%="T"+System.currentTimeMillis() %>")><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
							<script>
								createButton(document.getElementById("<portlet:namespace />cbt_queue"));
							</script>	
						</td>
					</tr>
					<tr>
						<td><img border="0" height="8" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
					</tr>
					<tr>
						<td>
							<font class="gamma" size="2">
							<%= LanguageUtil.get(pageContext, "show-borders") %>
							</font>
						</td>
						<td width="10">
							&nbsp;
						</td>
						<td>
							<select name="<portlet:namespace />show_borders">
								<option <%= showBorders ? "selected" : "" %> value="1"><%= LanguageUtil.get(pageContext, "true") %></option>
								<option <%= !showBorders ? "selected" : "" %> value="0"><%= LanguageUtil.get(pageContext, "false") %></option>
							</select>
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
					<input type="submit" value="<bean:message key="update" />">

					<input type="button" value="<bean:message key="cancel" />" onClick="self.location = '<portlet:renderURL><portlet:param name="struts_action" value="/ndsgraph/view" /></portlet:renderURL>';">
				</td>
			</tr>
			</table>
		</td>
	</tr>

	</form>

	</table>

