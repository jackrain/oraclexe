<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ taglib uri='/WEB-INF/tld/filecache.tld' prefix='filecache' %>
<%
    /**
     * Things needed in this page:
     *  1.  category 
     */
	String category=request.getParameter("category");
	String tabName = (Validator.isNull(category)?PortletUtils.getMessage(pageContext, "object-portal",null):category);
%>
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
	Configurations conf=(Configurations)nds.control.web.WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS);
	String exportRootPath=conf.getProperty("export.root.nds","/act/home");
	
	String filePath =exportRootPath + File.separator+ 
	userWeb.getClientDomain()+File.separator+ userWeb.getUserName()+File.separator+"cache"+File.separator+"tables.cache";
%>
<filecache:cache name="<%=filePath%>" tryCache="<%=Validator.isNull(category) && !("t".equals(refresh))%>">
<%
TableManager manager=TableManager.getInstance();
long windowWidth=RES_TOTAL;
int columnCount=6;

String template="<table width=80% align=center border=0 cellpadding=0 cellspacing=0><tr><td>"+
		"<span class='ct'>$TITLE$"+
		"</span></td><tr valign=top><td>$CONTENT$</td></tr></table>";
 nds.query.web.CreatePortal portalMachine = new nds.query.web.CreatePortal();
 portalMachine.setCategory(category);
 category= portalMachine.getCategory();
 portalMachine.setTemplate(template);
 portalMachine.setPreTableDescText("");
 portalMachine.setCategoryTableIndent(false);
 portalMachine.setCategoryAttributeTexts("class='beta'");
 //portalMachine.setHrefAttributesText("class='gamma'");
 String targetPage="pc.navigate";
%>
<%
 portalMachine.preparePortalHTML(request,targetPage,columnCount);
 Object[] linkTitle= portalMachine.getCategoriesHTML().valueList().toArray();
 StringBuffer[] subHtml=portalMachine.getColumnsHTML();	
%>
<table width='100%' align="center">
<tr>
<% for(int i=0;i< columnCount;i++){%>
<td width='<%=(100/columnCount)%>%' valign='top'><%=subHtml[i]%></td>
<%}%>  	
</tr></table>
</filecache:cache>

