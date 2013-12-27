<%@ include file="/html/portlet/nds/init.jsp" %>
<%

	int dataconf = Tools.getInt(prefs.getValue("dataConfig", "-1"),-1);
	int uiconf =  Tools.getInt(prefs.getValue("normalStateUIConfig", "-1"),-1);
	int maxuiconf =  Tools.getInt(prefs.getValue("maxStateUIConfig", ""+uiconf),uiconf);
	
	TableManager manager=TableManager.getInstance();
	PortletConfigManager pcManager=(PortletConfigManager)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.PORTLETCONFIG_MANAGER);

	ListDataConfig listDataConfig= (ListDataConfig)pcManager.getPortletConfig(dataconf,nds.web.config.PortletConfig.TYPE_LIST_DATA);
	ListUIConfig uiConfig= (ListUIConfig)pcManager.getPortletConfig(uiconf,nds.web.config.PortletConfig.TYPE_LIST_UI);
	ListUIConfig maxUiConfig= (ListUIConfig)pcManager.getPortletConfig(maxuiconf,nds.web.config.PortletConfig.TYPE_LIST_UI);

	String dataConfig= (listDataConfig==null?"":listDataConfig.getName());
	String normalStateUIConfig=(uiConfig==null?"":uiConfig.getName());
	String maxStateUIConfig=(maxUiConfig==null?"":maxUiConfig.getName());

%>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "data-config") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
<%
   
   Column column=manager.getColumn("ad_listdataconf","id");
   String column_acc_Id=  renderResponse.getNamespace()+ "dataConfig";
   FKObjectQueryModel fkQueryModel=new FKObjectQueryModel(column.getTable(), column_acc_Id,column);	
   String inputName=renderResponse.getNamespace()+ "dataConfig";
%>
		<input id="<%=column_acc_Id%>" type="text" value="<%=dataConfig%>" onkeydown="<%=fkQueryModel.getKeyEventScript()%>" size="30" maxlength="180" name="<%=inputName%>"/>
		<span id="<portlet:namespace />cbt1"  onaction="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
		<script>createButton(document.getElementById("<portlet:namespace />cbt1"));</script>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "ui-config") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
<%
   
   column=manager.getColumn("ad_listuiconf","id");
   column_acc_Id=  renderResponse.getNamespace()+ "normalStateUIConfig";
   fkQueryModel=new FKObjectQueryModel(column.getTable(), column_acc_Id,column);	
   inputName=renderResponse.getNamespace()+ "normalStateUIConfig";
%>
		<input id="<%=column_acc_Id%>" type="text" value="<%=normalStateUIConfig%>" onkeydown="<%=fkQueryModel.getKeyEventScript()%>" size="30" maxlength="180" name="<%=inputName%>"/>
		<span id="<portlet:namespace />cbt2"  onaction="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
		<script>createButton(document.getElementById("<portlet:namespace />cbt2"));</script>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "max-state-ui-config") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
<%
   
   column=manager.getColumn("ad_listuiconf","id");
   column_acc_Id=  renderResponse.getNamespace()+ "maxStateUIConfig";
   fkQueryModel=new FKObjectQueryModel(column.getTable(), column_acc_Id,column);	
   inputName=renderResponse.getNamespace()+ "maxStateUIConfig";
%>
		<input id="<%=column_acc_Id%>" type="text" value="<%=maxStateUIConfig%>" onkeydown="<%=fkQueryModel.getKeyEventScript()%>" size="30" maxlength="180" name="<%=inputName%>"/>
		<span id="<portlet:namespace />cbt3"  onaction="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
		<script>createButton(document.getElementById("<portlet:namespace />cbt3"));</script>
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">

</form>
