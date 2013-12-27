<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%!
	private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("dropdown_jsp");
%>
<%
 /**
 * do dropdown list in popup window of object.jsp
 
 * param 
 *      table - table id to be queried
 *      return_type  - "m" for mutiple, and "s" for single
 * 		accepter_id  - element id of document to recieve the result
 				format 1(single object): ${form}.column_${columnId} 
 				format 2(multiple object): ${from}.column_${rowidx}_${colidx}
 *      column      - the column id that will shown as dropdown list
 *      qdata		- query data of AK, can be omitted
 		fixedcolumns - columns that willl be fixed during query
 		wfc_<columnid> - when column isFilteredByWildcard, values of those reference columns can be fetched here
 */
try{ 
 String returnType= request.getParameter("return_type");
 String accepter_id= request.getParameter("accepter_id");
 String qdata= request.getParameter("qdata");
 if(Validator.isNull(qdata))qdata="";
 
 
 Table table= TableManager.getInstance().getTable(Tools.getInt(request.getParameter("table"),-1));
 Column acceptorColumn=  TableManager.getInstance().getColumn(Tools.getInt(request.getParameter("column"),-1));
 if(acceptorColumn==null)acceptorColumn= QueryUtils.getReturnColumn(accepter_id);
 
 int dropColumnCount=2;
 if(table.getJSONProps()!=null && table.getJSONProps().optInt("drop_column_cnt",2)==1)dropColumnCount=1;

 
 PairTable fixedColumns=PairTable.parse(request.getParameter("fixedcolumns"), null);    // columnlink=value
 Expression fixedExpression=Expression.parsePairTable(fixedColumns);// nerver null, maybe empty
 
 QueryRequestImpl qRequest=QueryEngine.getInstance().createRequest(userWeb.getSession());
 qRequest.setMainTable(table.getId());
 
 	// show records directly, with only first 2 showable columns
 	qRequest.addSelection(table.getPrimaryKey().getId());
 	qRequest.addSelection(table.getAlternateKey().getId());
	
 	ArrayList columns=table.getShowableColumns(Column.QUERY_LIST);
 	int colCount= 0;
//支持ak2 字段显示 如没有AK2则只显示AK字段 
	if(table.getAlternateKey2()!=null){
		//System.out.print(table.getAlternateKey2());
 	for(int i=0;i< columns.size() && colCount<dropColumnCount-1;i++){
 		
		Column col= (Column) columns.get(i);
		if(col.isAlternateKey() || col.getName().equals("ID"))continue;
        if(col.getDisplaySetting().isUIController()) continue;
        if(col!=table.getAlternateKey2()) continue;
        if( col.getReferenceTable() !=null) {
           Column col2=col.getReferenceTable().getAlternateKey();
           qRequest.addSelection(col.getId(),col2.getId(),true);
        } else {
            qRequest.addSelection(col.getId());  
        }
        colCount++;
        //if(colCount==2) break;
 		}
 	}

 	qRequest.setResultHandler(NDS_PATH+"/query/dropdown_result.jsp");
 	
 	//filter
	Expression sexpr= userWeb.getSecurityFilter(table.getName(), 1);// read permission
 	Expression expr=(acceptorColumn==null?null:QueryUtils.getDropdownFilter(acceptorColumn));
 	if( expr!=null ){
 		sexpr= expr.combine(sexpr, SQLCombination.SQL_AND, null);
 	};
 	if(sexpr!=null)sexpr= sexpr.combine(fixedExpression,  SQLCombination.SQL_AND, null);
 	else sexpr=fixedExpression;
 	//logger.debug("expr="+sexpr);
	

    //wildcard filter handling
	expr= WebUtils.parseWildcardFilter(acceptorColumn,request,userWeb);
	if(expr!=null)request.setAttribute("wildcardfilter", expr.toString());
	
	if(expr!=null)sexpr=expr.combine(sexpr,  SQLCombination.SQL_AND, null);

	//isactive checking
	if(table.isAcitveFilterEnabled()){
		expr=new Expression(new ColumnLink(table.getName()+".ISACTIVE"),"=Y",null);
		sexpr=expr.combine(sexpr,  SQLCombination.SQL_AND, null);
	}
	
	qRequest.addParam(sexpr);
	//logger.debug("qRequest.expr:"+ qRequest.getParamExpression());
	// limit records to fetch, if more, will be omitted.
	Configurations conf=(Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS);
	int listThreshold= Tools.getInt(conf.getProperty("query.dropdown.max"),40);
 	
 	qRequest.setRange(0,listThreshold);
 	//logger.debug(qRequest.toSQL());
%> 	
<%
	
	QueryResult result=QueryEngine.getInstance().doQuery(qRequest);
	
	request.setAttribute("result", result);
%>

<jsp:include page="/html/nds/query/dropdown_result.jsp" flush="true"/>

<%}catch(Throwable t){
t.printStackTrace();
out.print("Error:"+t.getMessage());
%>
  
<%
}%>

