<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>

<%!
	private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("sheet_list");
    /**
     * Needed parameters:
     *  table - the table id to be queried on
     *  sheet - the table id to be queried on , has more previllage than table
     *  status - int, not nessisary, but if exist, will make the sheet of that status to be shown
     *           valid only when table is a sheet
     *  resulthandler - if exists, use as request's result handler, else, use NDS_PATH+"/objext/list.jsp?status="+status
     *  nextscreen - if exists, use as command return screen, else, use NDS_PATH+"/objext/list.jsp?table="+ table.getName()
     *  fixedcolumns - additional filter set on the query, HttpRequest.attribute("fixecolumns") first(PairTable), then parameter
     */

%>
<%
//try{

String creationLink, title;
TableManager manager=TableManager.getInstance();
int tableId= ParamUtils.getIntAttributeOrParameter(request, "table", -1);
tableId= ParamUtils.getIntAttributeOrParameter(request, "sheet", tableId);
int status= ParamUtils.getIntAttributeOrParameter(request, "status", 1); // draft
Table table;
if( tableId == -1) {
    String tableName=  request.getParameter("table") ;
    table= manager.getTable(tableName);
    if( table !=null) tableId= table.getId();
    else {
        out.println("Internal Error:object-not-set");
        return;
    }
}else{
    table= manager.getTable(tableId);
}
/**------check permission---**/
String directory;
directory=table.getSecurityDirectory();
int perm= WebUtils.getDirectoryPermission(directory, request);
boolean isWriteEnabled= ( ((perm & 3 )==3)) && status !=2 ;
if ( status ==3 &&  !( ((perm & 9 )==9)) )  isWriteEnabled=false;
boolean isSubmitEnabled= ( ((perm & 5 )==5)) && status !=2;
boolean isAuditEnabled= ( ((perm & 9 )==9)) && table.isActionEnabled(Table.AUDIT) && status !=2;
boolean canDelete= table.isActionEnabled(Table.DELETE) && isWriteEnabled && status !=2 && status !=3;
boolean canAdd= table.isActionEnabled(Table.ADD) && isWriteEnabled && status !=3;
boolean canModify= table.isActionEnabled(Table.MODIFY) && isWriteEnabled && status !=3;
boolean canSubmit= table.isActionEnabled(Table.SUBMIT) && isSubmitEnabled ;
boolean canRequestAudit= table.isActionEnabled(Table.AUDIT) && isWriteEnabled && status !=3;
boolean canAudit= table.isActionEnabled(Table.AUDIT) && isAuditEnabled && (status==3);
boolean hasCommand=  canDelete || canSubmit || canRequestAudit ; //can add is a seperate one , even if it is enabled, form may not be shown
WebUtils.checkDirectoryReadPermission(directory, request);// -- This is commented by Tony
/**------check permission end---**/
boolean isStatusValid= table.isActionEnabled(Table.SUBMIT) || table.isActionEnabled(Table.AUDIT);

boolean isSheetTable;
if ( table.getName().toUpperCase().lastIndexOf("SHT")== table.getName().length()-3)isSheetTable=true;
else isSheetTable=false;

title= table.getDescription(locale)+" "+PortletUtils.getMessage(pageContext, "objects.list" ,null) ;
creationLink= NDS_PATH+"/object/object.jsp?table="+tableId+"&action=input";

boolean isIe = (request.getHeader("User-Agent").indexOf("MSIE") >= 0 )?true:false;

// following is for updating each record
String ifmTmp ="";// (isIe)?"ifm=true&":"";//Hawke

Hashtable urls=(Hashtable)request.getAttribute("urls");

if(urls==null) {
	urls=new Hashtable();
	String modifyLink=NDS_PATH+"/object/object.jsp?"+ifmTmp+"action="+((canModify || canAudit || hasCommand)?"input":"view")+"&table="+tableId;
	urls.put(new Integer(0), modifyLink);
	request.setAttribute("urls", urls);
}
QueryRequestImpl query=(QueryRequestImpl) request.getAttribute("query");
Expression userExpr= (Expression) request.getAttribute("userExpr");
QueryResult result=null;//(QueryResult) request.getAttribute("result");

SessionContextManager scmanager= WebUtils.getSessionContextManager(session);
String message=null;
if(query ==null){
   
    query=QueryEngine.getInstance().createRequest(userWeb.getSession());

    query.setMainTable(tableId);
    String resultHandler= (String)request.getAttribute("resulthandler");
    if(nds.util.Validator.isNull(resultHandler))
    	resultHandler=NDS_PATH+"/objext/list.jsp?status="+status;
    query.setResultHandler(resultHandler);
    		
    query.addSelection(table.getPrimaryKey().getId());
    query.addAllShowableColumnsToSelection(Column.QUERY_LIST);

	int[] orderKey=null;
	// if orderno key exists, use that (asc)
	if( table.getColumn("orderno")!=null){
		orderKey=new int[]{ table.getColumn("orderno").getId()};
		query.setOrderBy(orderKey, true);
	}else{
    	orderKey=new int[]{ table.getPrimaryKey().getId()};
    	query.setOrderBy(orderKey, false);
    }
    if(table.isBig()){
    	// mass storage should not allow query for all, so we limit to id=-1;
    	Expression expr= new Expression(new ColumnLink(new int[]{table.getPrimaryKey().getId()}), "=-1", null);
    	query.addParam(expr);
    	message=PortletUtils.getMessage(pageContext, "please-specify-filter-to-query-big-table" ,null);
    }
}
//------------- 过滤器三部曲：用户的过滤器，当前状态过滤器，安全过滤器

PairTable fixedColumns=(PairTable)request.getAttribute("fixedcolumns");
if(fixedColumns ==null) fixedColumns=PairTable.parseIntTable(request.getParameter("fixedcolumns"), null);

Expression expr1=null, expr2;
for( Iterator it=fixedColumns.keys();it.hasNext();){
   	Integer key=(Integer) it.next();
    Column col=manager.getColumn( key.intValue());
    ColumnLink cl=new ColumnLink( col.getTable().getName()+"."+ col.getName());
    expr2= new Expression(cl,"="+ fixedColumns.get(key),null);
    if( expr1==null) expr1=expr2;
    else expr1=expr1.combine(expr2, SQLCombination.SQL_AND,null);
}
if(expr1!=null) query.addParam(expr1);
/* 加载当前状态过滤器 */
if( isSheetTable){
    // this type of table will only show records with status column as 未提交
    Column statusColumn= manager.getColumn(table.getName(), "status");
    if( statusColumn !=null && statusColumn.getType()==Column.NUMBER)
        query.addParam(statusColumn.getId(), "" + status);// 2 is the default commit status
}
/*  加载安全过滤器 */
Expression sexpr= userWeb.getSecurityFilter(table.getName(), 1);// read permission
//System.out.println( "Sexpr=" + sexpr);
query.addParam(sexpr);
//
result= QueryEngine.getInstance().doQuery(query);
request.setAttribute("result", result);

request.setAttribute("urls", urls);
%>

<script language="javascript">
top.document.title="<%=title%>";
function popup_prefer(){
	popup_window('<%= NDS_PATH%>/prefer/notifyparams.jsp?table=<%=tableId %>');
}
function import_excel(){
	popup_window('<%= NDS_PATH%>/objext/import_excel.jsp?table=<%=tableId %>');
}
function isMultipleRowSelected(){
	var selectedIdx = getSelectedItemIdx();
	return !( (selectedIdx==null || selectedIdx.length < 2));
}
function executeCmd(form, cmd){
    if (cmd.indexOf("Delete")>=0 ){
        if (!confirm("<%= PortletUtils.getMessage(pageContext, "do-you-confirm-delete" ,null)%>")) {
            return false;
        }
    }
    <%
    //for GroupSubmit indication
     if(table.isActionEnabled(Table.GROUPSUBMIT)){
    %>
    if(cmd.indexOf("Submit")>=0 && isMultipleRowSelected() ){
    	 if (!confirm("<%= PortletUtils.getMessage(pageContext, "do-you-confirm-groupsubmit" ,null)%>")) {
            return false;
        }
    }
	<%       
     }
    %>
    showProgressWnd();
    form.command.value=cmd;
    submitForm(form);
}
function doCommand( cmd){
	executeCmd(form_list,cmd);
}
function doActionOnSelectedItems(loca){
		var objectIds="";
        var selectedIdx = getSelectedItemIdx();
        if (selectedIdx==null || selectedIdx.length ==0) {
            alert("<%= PortletUtils.getMessage(pageContext, "please-check-selected-lines",null)%>");
            return false;
        } 
        var itemIdObjs=document.getElementsByName("itemid");
        var itemIdObj;
        if (itemIdObjs.length ==null){
            // only one item found, and selected
            itemIdObj=itemIdObjs;
            objectIds= objectIds +  itemIdObj.value;
        }else{
            for(i=0;i< selectedIdx.length;i++){
            	itemIdObj= itemIdObjs[selectedIdx[i]];
            	if(i!=0){ objectIds =objectIds + ","; }
            	objectIds = objectIds + itemIdObj.value;
            }
		}
		if(selectedIdx.length>20){
			alert("<%= PortletUtils.getMessage(pageContext, "please-select-lines-less-than",null)%>");
			return false;
		}
		f= parent.mainFrame;
		if(f!=null) f.location=loca+ "&objectids="+encodeURIComponent(objectIds);
		else window.location=loca+ "&objectids="+encodeURIComponent(objectIds);

}
function doCopyTo(){
		doActionOnSelectedItems("<%=NDS_PATH%>/objext/copyto.jsp?src_table=<%=tableId%>");
}
function doUpdateSelected(){
		doActionOnSelectedItems("<%=NDS_PATH%>/objext/selectedupdate.jsp?table=<%=tableId%>");
}

</SCRIPT>  
<STYLE>
.inputline {  font: normal 9pt "Verdana", "Arial", "Helvetica", "sans-serif"; border: solid; border-color: #CCCCCC #999999 #000000; vertical-align: middle; border-width: 0px 0px 1px; background-color:transparent; color: #333333}
a {  color: #0000CC; text-decoration: none}
A:visited{TEXT-DECORATION: none；color: #FF0000}
A:hover{color: #FF6600; TEXT-DECORATION: underline}
a:active {  color: #FF0000}
</STYLE> 
<%if(message!=null){%>
<span class="warning"><%=message%></span><br>
<%}%>
<table border="0" cellspacing="0" cellpadding="0" align="center"  width="100%" height="100%">
  <tr >
    <td valign="top">
<%
int internal_table_width= ParamUtils.getIntAttribute(request,"internal_table_width", -1)-10;
String internal_table_height= (String)request.getAttribute("internal_table_height");
if(internal_table_width>0){
%>          
<div style="behavior: url('<%=NDS_PATH+"/css/syncscroll.htc"%>');width: <%= internal_table_width%>px; <%=internal_table_height==null?"height=520px;":internal_table_height%> overflow-y: auto; overflow-x: auto; border: 0px;hidden;padding:0px;padding:0px">
<%}%>    

      <table width="100%" cellspacing="0" cellpadding="0"  align="center">
        <tr >
          <td>
            <table width="98%" border="0" align="center"  >
              <tr>
                <td nowrap>
                </td>
              </tr>
              <tr>
                <td>
                  <%
                  	if(hasCommand) {
                  		Hashtable htAtt = new Hashtable();
                  		htAtt.put("select_form", "form_list");
                  		String nextscreen= (String)request.getAttribute("next-screen");
    					if(nds.util.Validator.isNull(nextscreen))
    						nextscreen=NDS_PATH+"/objext/list.jsp?table="+ table.getName();
                  		htAtt.put("next-screen",nextscreen);
                  		htAtt.put("command", "unknown");
                  		htAtt.put("table", ""+table.getId());
                  		//request.setAttribute("select_attribs", htAtt);
                  		request.setAttribute("multi_select", htAtt);
                  	}
                  	if (isStatusValid) request.setAttribute("status", ""+ status);
                    //small_page default to true,unless request explicitly set it 
                    //request.setAttribute("small_page", "true");
                  %>
                  <jsp:include page="<%=NDS_PATH+ \"/query/inc_result.jsp\"  %>" flush="true" />
                  
                </td>
              </tr>
            </table>

          </td>
        </tr>
      </table>
<%if(internal_table_width>0){
%>          
</div>
<%}%>  
    </td>
  </tr>
</table>


<Script language="javascript">
function showProgressWnd() {
	progressBar.showBar();
	progressBar.togglePause();
}
function hideProgressWnd(){
	progressBar.togglePause();
	progressBar.hideBar();
}
</script>
<script language="JavaScript" src="<%=NDS_PATH%>/js/xp_progress.js"></script>
<DIV id=ProgressWnd style="position: absolute; left:10px; top:5px;z-index: 100;display:block;">
<script>
	var progressBar = createBar(200, 20, "#FFFFFF", 1, "#000000", "<%=colorScheme.getPortletTitleBg()%>", 150, 10, 3, "");
	progressBar.togglePause();
	progressBar.hideBar();
</script>
</div>
<%
/*
}catch(Exception expd){
	expd.printStackTrace();
}*/
%>
