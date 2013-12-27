<%@page errorPage="/html/nds/error.jsp"%>
<%@ taglib uri='/WEB-INF/tld/filecache.tld' prefix='filecache' %>
<%@ include file="/html/nds/header.jsp" %>
<%
    /**
     * Things needed in this page:
     *  1.  category 
     */
	String category=request.getParameter("category");
	String tabName = (Validator.isNull(category)?PortletUtils.getMessage(pageContext, "object-portal",null):category);
%>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * This page will be cached to user's home folder
     * Things needed in this page:
     *  1.  category 
        2.  reload - forcely reload cache page
     */
%>
<%!
	private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("jsp_sheet_inc_object_portal");
%>
<%
String refresh=request.getParameter("refresh");
%>

<%
	Configurations conf=(Configurations)nds.control.web.WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS);
	String exportRootPath=conf.getProperty("export.root.nds","/act/home");
	
	String filePath =exportRootPath + File.separator+ 
	userWeb.getClientDomain()+File.separator+ userWeb.getUserName()+File.separator+"cache"+File.separator+"object_portal.cache";
%>
<filecache:cache name="<%=filePath%>" tryCache="<%=Validator.isNull(category) && !("t".equals(refresh))%>">
<%
TableManager manager=TableManager.getInstance();
long windowWidth=RES_TOTAL;
int columnCount=4;

String template="<table width=80% align=center border=0 cellpadding=0 cellspacing=0><tr><td>"+
		"<font class='beta'><b>$TITLE$"+
		"</b></font></td><tr valign=top><td>$CONTENT$</td></tr></table>";
 nds.query.web.CreatePortal portalMachine = new nds.query.web.CreatePortal();
 portalMachine.setCategory(category);
 category= portalMachine.getCategory();
 portalMachine.setTemplate(template);
 portalMachine.setPreTableDescText("");
 portalMachine.setCategoryTableIndent(false);
 portalMachine.setCategoryAttributeTexts("class='beta'");
 portalMachine.setHrefAttributesText("class='gamma'");
 String targetPage="opw";
%>
<script>
document.title="<%=(category==null?"":category)+" - " + PortletUtils.getMessage(pageContext, "object-portal",null)%>"
function opw(tid){
 parent.fraToolbar.location="<%=NDS_PATH%>/sheet/toolbar.jsp?table="+tid;
 parent.listFrame.location="<%=NDS_PATH%>/sheet/list.jsp?table="+tid;
 parent.fraQuickSearch.location="<%=NDS_PATH%>/sheet/quicksearch.jsp?table="+tid;
}

</script>
<STYLE>
.inputline {  font: normal 9pt "Verdana", "Arial", "Helvetica", "sans-serif"; border: solid; border-color: #CCCCCC #999999 #000000; vertical-align: middle; border-width: 0px 0px 1px; background-color:transparent; color: #333333}
a {  color: #0000CC; text-decoration: none}
A:visited{TEXT-DECORATION: none£»color: #FF0000}
A:hover{color: #FF6600; TEXT-DECORATION: underline}
a:active {  color: #FF0000}
  
</STYLE>
<%
 portalMachine.preparePortalHTML(request,targetPage,columnCount);
 Object[] linkTitle= portalMachine.getCategoriesHTML().valueList().toArray();
 StringBuffer[] subHtml=portalMachine.getColumnsHTML();	
%>
<table border="0" width="90%" align="center"><tr><td>
<% for(int i=0;i< linkTitle.length;i++){%>
<a class='beta' href="#<%=linkTitle[i]%>"><%=linkTitle[i]%></a> <%=(i==linkTitle.length-1?"":"|")%>
<%}%>  	
</td></tr></table><br>
<table width='100%' align="center"><tr>
<% for(int i=0;i< columnCount;i++){%>
<td width='<%=(100/columnCount)%>%' valign='top'><%=subHtml[i]%></td>
<%}%>  	
</tr></table>
<table width=80% align=center border=0 cellpadding=0 cellspacing=0>
<form action="<%=NDS_PATH+"/sheet/object_portal.jsp"%>" method="get" name="search_fm">
<tr><td width="15" align='center'>&nbsp;</td><td align='left'>	
	<input class="form-text" name="category" size="30" type="text" value="<%=Validator.isNull(category)?"":category%>">
	<input type="button" value="<%= LanguageUtil.get(pageContext, "search") %>" onClick="submitForm(document.search_fm);">
</td></tr></form>
</table>
</filecache:cache>

    </div>
</div>
<%@ include file="/html/nds/footer_info.jsp" %> 
