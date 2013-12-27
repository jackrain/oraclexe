<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/portlet/nds/init.jsp" %>
<%!
	/**
	*  max length to be display for the news' subject,
	*  if greater than that, will append ".."
	*/
 	private final static int MAX_SUBJECT_LENGTH_800=28;
 	private final static int MAX_SUBJECT_LENGTH_1024=40;
 	private final static DateFormat df = new java.text.SimpleDateFormat("MM-dd HH");
	private final static DateFormat longdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH");
%>

<%
try{
	/*if(!userWeb.isActive()){
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td align="center">
<font class="bg" size="2"><span class="bg-neg-alert">
<%= PortletUtils.getMessage(pageContext, "current-are-not-active",null)%>
</span></font>
</td></tr></table>
	
<%  
	return;
}*/
%>

<%

 UNewsDAO dao=new UNewsDAO();

Portlet portlet = PortletManagerUtil.getPortletById(company.getCompanyId(), portletConfig.getPortletName());
boolean isNarrow=portlet.isNarrow();
long windowWidth=RES_TOTAL;
//df.setTimeZone(timeZone);
int startIndex= ParamUtil.get(renderRequest, "startidx", 0);
int objectId= ParamUtil.get(renderRequest, "id", -1);
int categoryId= ParamUtil.get(renderRequest, "categoryid",-1);
String keywords= renderRequest.getParameter("keywords");

 QueryResult result;
 int oid;
 String subject,style, contenturl,clientName;
 String date;
 int scrollWidth;
 int columnsPerRow,i=0, recordCount;
 int maxSubjectLength;
 maxSubjectLength= resolution.equals(Resolution.S1024X768_KEY)?MAX_SUBJECT_LENGTH_1024:MAX_SUBJECT_LENGTH_800;
%>
<% 
 // prepare url for scroll.jsp
 PortletURL portletURL =renderResponse.createRenderURL();
 portletURL.setWindowState(WindowState.MAXIMIZED);
 portletURL.setPortletMode(PortletMode.VIEW);
 portletURL.setParameter("id","NEWSOBJECTID");
 String portletURLToString=JS.encodeURIComponent(portletURL.toString());
 
%>
<script>
 function opw_<%=renderResponse.getNamespace()%>(oid){
 	window.location="<%=portletURL.toString()%>".replace( /NEWSOBJECTID/g , oid);
 }
</script>
<style>
.dateview{FONT-SIZE: 9px; COLOR: <%=colorScheme.getPortletTitleBg()%>;}
</style>
<%
if ( objectId!=-1){
%>

<%@include file="/html/portlet/nds/news/inc_object.jsp"%>
<%
  return;
 }
if(isNarrow==true && renderRequest.getWindowState() ==WindowState.NORMAL){
%>
	<%@ include file="/html/portlet/nds/news/inc_narrow.jsp" %>
	
<%}else{
if(renderRequest.getWindowState() !=WindowState.MAXIMIZED ){
%>
	<%@ include file="/html/portlet/nds/news/inc_wide.jsp" %>
<%
}else{
%>
<%@ include file="/html/portlet/nds/news/inc_maximize.jsp" %>

<%}
}
}catch(Exception exyp){
	System.out.println("Found error in news.view.jsp");
	exyp.printStackTrace();
}
%>


