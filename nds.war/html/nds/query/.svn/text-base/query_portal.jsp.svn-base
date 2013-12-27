<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
    /**
     * Things needed in this page:
     *  1.  category 
     */
%>
<%
String category=request.getParameter("category");
TableManager manager=TableManager.getInstance();
Table table=null;

int tableId= ParamUtils.getIntAttributeOrParameter(request,"table", -1);

if( tableId == -1){
    // try table as String
    String tableName= ParamUtils.getParameter(request,"table");
    table= manager.getTable(tableName);
    
}else{
    table= manager.getTable(tableId);
}
if( table !=null){
	response.sendRedirect(NDS_PATH+"/objext/blank.jsp");
	return;	
}
	String tabName = (Validator.isNull(category)?PortletUtils.getMessage(pageContext, "query-portal",null):category);
	String tabHREF = "/query/query_portal.jsp?category="+category ;
%>

<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<script>

function open_nds_window(url){
	//window.open(url ,'_blank','status=yes,resizable=yes,scrollbars=yes,location=no,menubar=no,toolbar=no');
	window.location=url;
}
</script>
<%

long windowWidth=RES_TOTAL;
int columnCount=4;
//if(windowWidth>800) columnCount=5;

String template="<table width=80% align=center border=0 cellpadding=0 cellspacing=0><tr><td>"+
		"<font class='beta'><b>$TITLE$"+
		"</b></font></td><tr valign=top><td>$CONTENT$</td></tr></table>";
 nds.query.web.CreatePortal portalMachine = new nds.query.web.CreatePortal();
 portalMachine.setCategory(category);
 portalMachine.setTemplate(template);
 portalMachine.setPreTableDescText("");
 portalMachine.setCategoryTableIndent(false);
 portalMachine.setCategoryAttributeTexts("class='beta'");
 portalMachine.setHrefAttributesText("class='gamma'");
 String targetPage=NDS_PATH+"/query/query.jsp";
%>
<script>
document.title="<%=PortletUtils.getMessage(pageContext, "query-portal",null)%>";
</script>
<STYLE>
.inputline {  font: normal 9pt "Verdana", "Arial", "Helvetica", "sans-serif"; border: solid; border-color: #CCCCCC #999999 #000000; vertical-align: middle; border-width: 0px 0px 1px; background-color:transparent; color: #333333}
a {  color: #0000CC; text-decoration: none}
A:visited{TEXT-DECORATION: none£»color: #FF0000}
A:hover{color: #FF6600; TEXT-DECORATION: underline}
a:active {  color: #FF0000}
  
</STYLE>
<%=portalMachine.getPortal(request,targetPage,columnCount )%>

<table width=80% align=center border=0 cellpadding=0 cellspacing=0>
<form action="<%=NDS_PATH+"/objext/query_portal.jsp"%>" method="get" name="search_fm">
<tr><td width="15" align='center'>&nbsp;</td><td align='left'>	<input class="form-text" name="category" size="30" type="text">
	<input type="button" value="<%= LanguageUtil.get(pageContext, "search") %>" onClick="submitForm(document.search_fm);">
</td></tr></form>
</table>		
    </div>
</div>		
<%@ include file="/html/nds/footer_info.jsp" %>
