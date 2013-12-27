<%@ include file="/html/portlet/nds/init.jsp" %>
<%
	if(!userWeb.isActive()){
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td align="center">
<font class="bg" size="2"><span class="bg-neg-alert">
<%= PortletUtils.getMessage(pageContext, "current-are-not-active",null)%>
</span></font>
</td></tr></table>

<%  }else{
%>

<%

long windowWidth=RES_TOTAL;
int columnCount=4;
if(renderRequest.getWindowState() ==WindowState.MAXIMIZED){
	if(windowWidth>800) columnCount=5;
}

TableManager manager= TableManager.getInstance();

String template="<table width=\"80%\" align=center border=0 cellpadding=0 cellspacing=0><tr><td>"+
		"<font class='beta'><b>$TITLE$</b></font></td><tr valign=top><td>$CONTENT$</td></tr></table>";
 nds.query.web.CreatePortal portalMachine = new nds.query.web.CreatePortal();
 portalMachine.setTemplate(template);
 portalMachine.setPreTableDescText("");
 portalMachine.setCategoryTableIndent(false);
 portalMachine.setCategoryAttributeTexts("class='beta'");
 portalMachine.setHrefAttributesText("class='gamma'");
 String targetPage="opt_";

 portalMachine.preparePortalHTML(request,targetPage,columnCount);
// Object[] linkTitle= portalMachine.getCategoriesHTML().valueList().toArray();
 StringBuffer[] subHtml=portalMachine.getColumnsHTML();	
%>
<table width='100%' align="center"><tr>
<% for(int i=0;i< columnCount;i++){%>
<td width='<%=(100/columnCount)%>%' valign='top'><%=subHtml[i]%></td>
<%}%>  	
</tr></table>

<table width="80%" align=center border=0 cellpadding=0 cellspacing=0>
<form action="<%=NDS_PATH+"/sheet/object_portal.jsp"%>" method="get" name="search_fm">
<tr><td align='left'>	<input class="form-text" name="category" size="30" type="text">
	<input type="button" value="<%= LanguageUtil.get(pageContext, "search") %>" onClick="submitForm(document.search_fm);">
	<a class='gamma' href="javascript:popup_window('/help/Wiki.jsp?page=Help')">[<%= LanguageUtil.get(pageContext, "help") %>]</a>
</td></tr></form>
</table>
<%}//end if acitve
%>
