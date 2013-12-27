<%@ include file="/html/portlet/nds/init.jsp" %>
<script>
function editFavorite(){
   window.location="<%=NDS_PATH+"/sheet/objects.jsp?table=u_favorite"%>";
}
</script>
<table border="0" cellpadding="0" cellspacing="0" width='100%' align="center">
<tr><td valign="top">
<%
	Properties props= userWeb.getPreferenceValues("mainmenu",true);
	boolean bShowFrequent=("Y".equals(props.getProperty("show_frequent", "Y")));
	boolean bShowCategory=("Y".equals(props.getProperty("show_category", "Y")));
	java.util.HashMap a = new java.util.HashMap();
    StringHashtable o = new StringHashtable();
    o.put( PortletUtils.getMessage(pageContext, "yes",null),"Y");
    o.put( PortletUtils.getMessage(pageContext, "no",null),"N");
	
%>

<liferay-ui:tabs names="favorite-display-setting">

<table border="0" cellpadding="0" cellspacing="4" width='80%' align="center">
<form action="/control/command" method="post" name="savepref">
	<input type="hidden" name="command" value="SavePreference">
	<input type="hidden" name="request-handler" value="nds.control.web.reqhandler.SavePreferenceRequestHandler">
	<input type="hidden" name="module" value="mainmenu">
	<input type="hidden" name="preferences" value="show_frequent,show_category">
	<input type="hidden" name="next-screen" value="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/mainmenu/edit" /></portlet:renderURL>">
<%
	String holder_message= request.getParameter(nds.util.WebKeys.VALUE_HOLDER_MESSAGE);
	if( holder_message !=null){
%>
	<tr>
		<td colspan=2>
			<font class="bg" size="1"><span class="bg-pos-alert"><%= holder_message %></span></font>
		</td>
	</tr>
<%	}%>
<tr><td	align="left" width="1%" nowrap>
	<font class="gamma" size="2"> <%= LanguageUtil.get(pageContext, "favorite-show-frequests") %>:</font>
</td><td align="left">
	<input:select name="show_frequent" default="<%=(bShowFrequent?"Y":"N")%>" attributes="<%=a%>" options="<%= o %>" />
</td></tr>
<tr><td	align="left" width="1%" nowrap>
	<font class="gamma" size="2"> <%= LanguageUtil.get(pageContext, "favorite-show-category") %>:</font>
</td><td align="left">
	<input:select name="show_category" default="<%=(bShowCategory?"Y":"N")%>" attributes="<%=a%>" options="<%= o %>" />
</td></tr>
<tr><td align="left" width="1%"></td><td align="left">
	<input type="submit" value="<%= LanguageUtil.get(pageContext, "object.modify")%>"
</td></tr>
</form>
</table>
</liferay-ui:tabs>
</td></tr><tr><td>
<liferay-ui:tabs names="favorite-favorite-control">

<input type="button" value="<%= LanguageUtil.get(pageContext, "edit-favorite")%>" onclick="editFavorite();">
</liferay-ui:tabs>
</td></tr>

</table>

