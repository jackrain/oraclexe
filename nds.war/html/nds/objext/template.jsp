<%@ include file="/html/nds/common/init.jsp" %>
<%@ include file="/html/nds/portal/top_meta.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
TableManager manager=TableManager.getInstance();
int tableId= Tools.getInt(request.getParameter("table"), -1);
Table table= manager.getTable(tableId);

	String tabName=PortletUtils.getMessage(pageContext, "object.template",null);
	
	String object_page_url=NDS_PATH+"/objext/template.jsp?table="+table.getId();
	request.setAttribute("page_help", "TableTemplate");
	int navTabTotalWidth=DEFAULT_TAB_WIDTH; //total table width
%>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * Template modification page
     * Things needed in this page (attributes) :
     *  1.  table     String|id of table that queried on, 
     */

int objectId=ParamUtils.getIntAttribute(request,"id", -1);
request.setAttribute("objectid",""+objectId );

PairTable fixedColumns=(PairTable) request.getAttribute("fixedcolumns");
if(fixedColumns==null) fixedColumns=new PairTable();
boolean isInput=true ;

/**------check permission---**/
// for status
String directory;
directory=table.getSecurityDirectory();

int perm= WebUtils.getDirectoryPermission(directory, request);
if(perm==0) throw new NDSException(PortletUtils.getMessage(pageContext, "no-permission",null));
int status=0;
try{
if( manager.getColumn(table.getName(), "status")!=null )
	status= QueryEngine.getInstance().getSheetStatus(table.getRealTableName(),objectId);
}catch(Exception e){}
boolean isWriteEnabled= ( ((perm & 3 )==3)) ;
boolean isSubmitEnabled= ( ((perm & 5 )==5)) ;

boolean canDelete= table.isActionEnabled(Table.DELETE) && isWriteEnabled && status !=2;
boolean canAdd= table.isActionEnabled(Table.ADD) && isWriteEnabled;
boolean canModify= table.isActionEnabled(Table.MODIFY) && isWriteEnabled ;
boolean canSubmit= table.isActionEnabled(Table.SUBMIT) && isSubmitEnabled ;
/**------check permission end---**/
isInput &= ( isSubmitEnabled && canSubmit) || ( isWriteEnabled && status !=2 && (canSubmit||canModify||canDelete||canAdd));
if(!isInput){
  //forward to single_object_view.jsp
  pageContext.getServletContext().getRequestDispatcher(NDS_PATH+"/objext/single_object_view.jsp").forward(request,response);
  return;
}

request.setAttribute("action", isInput?"input":"view");

QueryResult result=null;
if( objectId != -1){
	QueryRequestImpl query=QueryEngine.getInstance().createRequest(userWeb.getSession());
    query.setMainTable(tableId);
	query.addAllShowableColumnsToSelection(Column.MODIFY);
    query.addParam( table.getPrimaryKey().getId(), ""+ objectId );
	result=QueryEngine.getInstance().doQuery(query);
	//logger.debug("result.getTotalRowCount()="+ result.getTotalRowCount()+", sql="+ query.toSQL());
	if(result.getTotalRowCount()==0){
	%>
		<font color='red'><%=PortletUtils.getMessage(pageContext, "object-not-exists",null)%></font>
	<%	return; 
	}
}


int actionType= objectId ==-1?Column.ADD:Column.MODIFY;
ArrayList columns=table.getShowableColumns(actionType);
%>
<iframe id=CalFrame name=CalFrame frameborder=0 src=<%=NDS_PATH%>/common/calendar.jsp style=display:none;position:absolute;z-index:99999></iframe>
<script language="javascript" src="<%=NDS_PATH%>/js/calendar.js"></script>
<%
String form_name="single_object_modify";
%>
<form name="<%=form_name%>" method="post" action="<%=contextPath %>/control/command" onSubmit="return checkOptions(document.single_object_modify);">
<input type='hidden' name="ref_by_table" value="<%=ParamUtils.getIntParameter(request,"select_tab", -1)%>">
<input type='hidden' name="mainobjecttableid" value="<%= ParamUtils.getIntAttributeOrParameter(request, "mainobjecttableid",-1)%>">
<input type='hidden' name="input" value="<%= isInput%>">
<input type='hidden' name="next-screen" value="">
<input type='hidden' name='directory' value='<%= directory%>'>
<input type='hidden' name="fixedcolumns" value="<%= fixedColumns.toURLQueryString("")%>">
<%
String uri = request.getRequestURI();
String queryString = request.getQueryString();
%>
<!--<input type='hidden' name='formRequest' value='<%=uri.substring(NDS_PATH.length())+"?"+queryString%>'>
<input type='hidden' name='formRequest' value='<%=uri+"?"+ValueHolder.removeValueHolderPart(queryString)%>'>
-->
<input type='hidden' name='formRequest' value='<%=object_page_url%>'>

<%
request.setAttribute("form_name", form_name);
%>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="0"><tr><td width="70%">
<!--button-->
<%
ArrayList validCommands=new ArrayList();//element: String
validCommands.add("Create");
%>
<script>
function doCreate(){
	form=document.<%=form_name%>;
	form.command.value="ObjectTemplate";
    showProgressWnd(); 
    submitForm(form);
}
</script>
<%@ include file="/html/nds/objext/inc_command.jsp" %>
<!--end button-->
</td><td>
</td></tr></table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" bordercolorlight="#999999" align="center">
	<tr ><td>
	<br>
		<%
    //if true, will show data without variable, else show variable directly. This is used for template setting page
    //@see inc_template.jsp/inc_batchupdate.jsp
    boolean bReplaceVariable= false;
    //load preference values from ad_user_pref, key name: column.name.tolowercase
    //not do cache, because the synchronization between cache and db is not implemented currently.
    Properties prefs= userWeb.getPreferenceValues("template."+table.getName().toLowerCase(),false,bReplaceVariable);
	request.setAttribute("showcheckbox","false");
	%>
		<%@ include file="/html/nds/objext/inc_single_object.jsp" %>
	<br>
	</td></tr>
</table>
<br>
</form>
</div>
</div>
<input type='hidden' name='queryindex_-1' id='queryindex_-1' value="-1" />
<%@ include file="/html/nds/footer_info.jsp" %>