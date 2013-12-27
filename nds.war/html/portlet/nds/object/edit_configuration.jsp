<%@ include file="/html/portlet/nds/init.jsp" %>
<%
	TableManager manager=TableManager.getInstance();
	PortletConfigManager pcManager=(PortletConfigManager)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.PORTLETCONFIG_MANAGER);

	int uiconf =  Tools.getInt(prefs.getValue("uiConfig", "-1"),-1);
	ObjectUIConfig ouiConfig= (ObjectUIConfig)pcManager.getPortletConfig(uiconf,nds.web.config.PortletConfig.TYPE_OBJECT_UI);
	
	String uiConfig= (ouiConfig==null?"":ouiConfig.getName());
%>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "ui-config") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
<%
   Column column=manager.getColumn("ad_objuiconf","id");
   String column_acc_Id=  renderResponse.getNamespace()+ "uiConfig";
   FKObjectQueryModel fkQueryModel=new FKObjectQueryModel(column.getTable(), column_acc_Id,column);	
   String inputName=renderResponse.getNamespace()+ "uiConfig";
%>
		<input id="<%=column_acc_Id%>" type="text" value="<%=uiConfig%>" onkeydown="<%=fkQueryModel.getKeyEventScript()%>" size="30" maxlength="180" name="<%=inputName%>"/>
		<span id="<portlet:namespace />cbt"  onaction="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
		<script>createButton(document.getElementById("<portlet:namespace />cbt"));</script>
	</td>
</tr>

</table>

<br>

<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">

</form>
