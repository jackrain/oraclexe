<%!
    /**
     * Needed parameters/attribute:
		"listdataconf" : id of nds.web.config.ListDataConfig 
		"listuiconf"   : id of nds.web.config.ListUIConfig in normal window mode
		"namespace"   : namespace, id of all embed html elements should be prefixed with that value
		
     */
	private final static int MAX_COLUMNLENGTH_WHEN_TOO_LONG=30;//QueryUtils.MAX_COLUMN_CHARS -3
%>
<%

String creationLink, title;
int status= 1;
org.json.JSONObject tableObj=new org.json.JSONObject();
/**------check permission---**/
if(! dataConfig.isPublic()){
	String directory;
	directory=table.getSecurityDirectory();
	int perm= WebUtils.getDirectoryPermission(directory, request);
	WebUtils.checkDirectoryReadPermission(directory, request);
}
/**------check permission end---**/

creationLink= NDS_PATH+"/object/object.jsp?table="+tableId+"&action=input";

Hashtable urls=new Hashtable();
String modifyLink=dataConfig.getMainURL();
if(modifyLink!=null)urls.put(new Integer(0), modifyLink);
request.setAttribute("urls", urls);
QueryRequestImpl query=(QueryRequestImpl) request.getAttribute("query");

Expression userExpr= (Expression) request.getAttribute("userExpr");
QueryResult result=null;

SessionContextManager scmanager= WebUtils.getSessionContextManager(session);

if(query ==null){
   
    query=QueryEngine.getInstance().createRequest(userWeb.getSession());

    query.setMainTable(tableId,true, dataConfig.getFilter());
    String resultHandler= (String)request.getAttribute("resulthandler");
    if(nds.util.Validator.isNull(resultHandler))
    	resultHandler="/html/nds/portal/portletlist/table_list.jsp";
    query.setResultHandler(resultHandler);
    		
    query.addSelection(table.getPrimaryKey().getId());
    query.addColumnsToSelection(dataConfig.getColumnMasks(),false, uiConfig.getColumnCount() );
	if( dataConfig.getOrderbyColumnId()!=-1){
		Column orderColumn= manager.getColumn(dataConfig.getOrderbyColumnId());
		if(orderColumn!=null && orderColumn.getTable().getId()== tableId)query.setOrderBy(new int[]{dataConfig.getOrderbyColumnId()}, dataConfig.isAscending());
	}else{
    	query.setOrderBy(new int[]{ table.getPrimaryKey().getId()}, false);
    }
    if(uiConfig.getPageSize()>0)query.setRange(0,uiConfig.getPageSize());
    
    if(userExpr!=null)query.addParam(userExpr);
}else{
  if(nds.util.Validator.isNotNull(dataConfig.getFilter())){
  	query.addParam(dataConfig.getFilter());
  }
}

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

// user filter
if(!dataConfig.isPublic()){
	Expression sexpr= userWeb.getSecurityFilter(table.getName(), 1);// read permission
	query.addParam(sexpr);
}
result= QueryEngine.getInstance().doQuery(query);
request.setAttribute("result", result);
/**
 First selection is always PK of that table
*/
  int range = query.getRange();
  String[] showColumns = query.getDisplayColumnNames(false);
  String orderColumns = "";
  if(query.getOrderColumnLink()!=null)for(int i=0;i< query.getOrderColumnLink().length;i++)
  {
    if(i > 0)orderColumns += ",";
    orderColumns += query.getOrderColumnLink()[i];
  }
  String orderAsc = "true";
  if(!query.isAscendingOrder())   orderAsc = "false";
  int[] showColumnsIds = query.getDisplayColumnIndices();
  String[] showColumnLinks = new String[showColumns.length];
  for(int i =0;i < showColumns.length;i++)
  {
    int[] tmp = query.getSelectionColumnLink(showColumnsIds[i]);
    showColumnLinks[i] = "";
    for(int j=0;j < tmp.length;j++)
    {
      if(j > 0) showColumnLinks[i] += ",";
      showColumnLinks[i] += tmp[j];
    }
  }
  int count = result.getRowCount();
  int totalCount = result.getTotalRowCount();
  int startIndex = query.getStartRowIndex()+1;// 0 is the begin
  int endIndex = startIndex + query.getRange()-1;
  endIndex = (endIndex > totalCount)?totalCount:endIndex;
  if(startIndex > totalCount){startIndex=0;endIndex=0;}
CollectionValueHashtable tableAlertHolder=new CollectionValueHashtable();
%>

