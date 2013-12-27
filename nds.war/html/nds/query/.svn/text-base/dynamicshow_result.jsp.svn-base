<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*" %>
<%
 /**
 * do dynamic query list in popup window of object.jsp
 
 * param 
 *      table - table id to be queried
 * 		  accepter_id  - element id of document to recieve the result
 *      column      - the column id that will shown as dropdown list
 *			qdata		- query data of AK, can be omitted
 *      fixedcolumns - columns that willl be fixed during query
		must has read permission 
 		
 */
 Table table= TableManager.getInstance().getTable(Tools.getInt(request.getParameter("table"),-1));
 String accepter_id= request.getParameter("accepter_id");
 String qdata= request.getParameter("qdata");
 if(!Validator.isNull(qdata) && userWeb.isPermissionEnabled(table.getSecurityDirectory(),nds.security.Directory.READ )){
 String sqlqdata="";
 Column acceptorColumn=  TableManager.getInstance().getColumn(Tools.getInt(request.getParameter("column"),-1));
 //PairTable fixedColumns=PairTable.parse(request.getParameter("fixedcolumns"), null);    // columnlink=value
 //Expression fixedExpression=Expression.parsePairTable(fixedColumns);// nerver null, maybe empty
 if(acceptorColumn==null)acceptorColumn= QueryUtils.getReturnColumn(accepter_id);
 int dropColumnCount=2;
 if(table.getJSONProps()!=null && table.getJSONProps().optInt("drop_column_cnt",2)==1)dropColumnCount=1;

 QueryRequestImpl qRequest=QueryEngine.getInstance().createRequest(userWeb.getSession());
 qRequest.setMainTable(table.getId());


// show records directly, with only first 2 showable columns
 	qRequest.addSelection(table.getPrimaryKey().getId());
 	qRequest.addSelection(table.getAlternateKey().getId());
 	ArrayList columns=table.getShowableColumns(Column.QUERY_LIST);
 	int colCount= 0;
 	for(int i=0;i< columns.size() && colCount<dropColumnCount-1;i++){
 		
		Column col= (Column) columns.get(i);
		if(col.isAlternateKey() || col.getName().equals("ID"))continue;
        if(col.getDisplaySetting().isUIController()) continue;
        if( col.getReferenceTable() !=null) {
           Column col2=col.getReferenceTable().getAlternateKey();
           qRequest.addSelection(col.getId(),col2.getId(),true);
        } else {
            qRequest.addSelection(col.getId());
        }
        colCount++;
        //if(colCount==2) break;
 	}

  	Expression sexpr= userWeb.getSecurityFilter(table.getName(), 1);
 	Expression expr=(acceptorColumn==null?null:QueryUtils.getDropdownFilter(acceptorColumn));
 	if( expr!=null ){
 		sexpr= expr.combine(sexpr, SQLCombination.SQL_AND, null);
 	};
 
 	expr= WebUtils.parseWildcardFilter(acceptorColumn,request,userWeb);	
	if(expr!=null)sexpr=expr.combine(sexpr,  SQLCombination.SQL_AND, null);
	//isactive checking
	if(table.isAcitveFilterEnabled()){
		expr=new Expression(new ColumnLink(table.getName()+".ISACTIVE"),"=Y",null);
		sexpr=expr.combine(sexpr,  SQLCombination.SQL_AND, null);
	}
	//ak
	Column column=table.getAlternateKey();
	if(column.isUpperCase()){
    	sqlqdata=qdata.toUpperCase()+"%";
  	}else{
		sqlqdata=qdata+"%";
  	}
	expr=new Expression(null,table.getName()+"."+column.getName()+" like '"+sqlqdata+"'",null);
  	
  	//ak2
  	column=table.getAlternateKey2();
	if(column!=null){
		if(column.isUpperCase()){
	    	sqlqdata=qdata.toUpperCase()+"%";
	  	}else{
			sqlqdata=qdata+"%";
	  	}
	  	expr=expr.combine(new Expression(null,table.getName()+"."+column.getName()+" like '"+sqlqdata+"'",null),
	  		SQLCombination.SQL_OR, null);
	}
	sexpr= expr.combine(sexpr, SQLCombination.SQL_AND, null);
	
	qRequest.addParam(sexpr);
	Configurations conf=(Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS);
	int listThreshold= Tools.getInt(conf.getProperty("query.dynamicquery.max"),7);
 	qRequest.setRange(0,listThreshold);
	QueryResult result=QueryEngine.getInstance().doQuery(qRequest);
	if(result.getTotalRowCount()>0){
	  org.json.JSONObject dynobject=new org.json.JSONObject();
	  org.json.JSONArray dynshowjson=new org.json.JSONArray();
	  String strflag;
	  org.json.JSONArray tb=null;
    QueryResultMetaData meta;
    int i=0;
    while(result.next()){
       tb=new org.json.JSONArray();
       tb.put(result.getString(2, true));
       if(dropColumnCount>1){
	       strflag=result.getString(3, true);
	       if(strflag.equals("&nbsp;")){
		         tb.put("");
	        }else{
	    	     tb.put(strflag);
	        }
        }else{
        	 tb.put("");
		}
  	    dynshowjson.put(tb);  	
	  }
	  dynobject.put("dynshowjson",dynshowjson);
	  dynobject.put("qdata",qdata);
	 
%>	
<div id="<%="tdiv_"+accepter_id%>" Style="overflow-x:visible;z-index: 11;padding:0px"> 
<table><tr><td>
<script type="text/javascript">
 dcq.dynjson(<%=dynobject%>);
</script>	
</td></tr></table>
</div>
<%}}%>