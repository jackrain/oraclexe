<?xml version="1.0"?>
<%@page errorPage="/html/nds/error.jsp"%>
<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>

<%    /**
     * Different with tree.xml, this tree will include 2 table content: the structure table and the data table
     * Structure table contains records for tree structure, data table contains table for tree node.
     * example: structure table: m_product_category, data table: m_product, corelation column: m_product.m_product_catgeory_id
     *
     * Needed parameters:
     *  tbstruct - the structure table id to be queried on, for instance, m_product_category, every record in structure table will not be leaf in tree
     *  parentnode - parent node id in structure table, or -1 for root
     *  tbdata  - the data table id to be listed as leaves in tree node
     *  fnc  - action function called when leaf selected or clicked, when empty, will use "tc_"+tbdata.getName() as function
     */
	String NDS_PATH=nds.util.WebKeys.NDS_URI;
	UserWebImpl userWeb =null;
	try{
		userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
	}catch(Exception userWebException){
		System.out.println("########## found userWeb=null##########"+userWebException);
	}

	Locale locale =userWeb.getLocale();

TableManager manager=TableManager.getInstance();
int parentnode=  ParamUtils.getIntAttributeOrParameter(request, "parentnode", -1);
int tableId= ParamUtils.getIntAttributeOrParameter(request, "tbstruct", -1);
int dataTableId= ParamUtils.getIntAttributeOrParameter(request, "tbdata", -1);
int status=1;
Table table,dataTable;
table= manager.getTable(tableId);
if(table ==null) throw new NDSException("Internal Error: not a valid table id for tbstruct="+ tableId);
if(!table.isTree()) {
	throw new NDSException("Internal Error: "+ table+ "is not tree table!");
}
dataTable= manager.getTable(dataTableId);
if(dataTable ==null) throw new NDSException("Internal Error: not a valid table id for tbdata="+ dataTableId);
String action= request.getParameter("fnc");
if(nds.util.Validator.isNull(action)) action="tc_"+dataTable.getName();
/**------check permission---**/
String directory;
directory=table.getSecurityDirectory();
WebUtils.checkDirectoryReadPermission(directory, request);
/**------check permission end---**/

QueryRequestImpl query;
Expression userExpr= (Expression) request.getAttribute("userExpr");
QueryResult result=null;//(QueryResult) request.getAttribute("result");

SessionContextManager scmanager= WebUtils.getSessionContextManager(session);

// only pk,dk will be selected, order by ak asc
query=QueryEngine.getInstance().createRequest(userWeb.getSession());
query.setMainTable(tableId);
query.addSelection(table.getPrimaryKey().getId());
query.addSelection(table.getDisplayKey().getId());
query.addSelection(table.getSummaryColumn().getId());
if(parentnode ==-1){
	query.addParam(table.getParentNodeColumn().getId(), " is null");
}else{
	query.addParam(table.getParentNodeColumn().getId(), ""+parentnode);
}
query.addParam(table.getColumn("isactive").getId(), "Y");
int[] orderKey;
Column colOrderNo=table.getColumn("orderno") ;
if(colOrderNo!=null)orderKey= new int[]{ colOrderNo.getId()};
else orderKey= new int[]{ table.getAlternateKey().getId()};
query.setOrderBy(orderKey, true);
query.setRange(0, Integer.MAX_VALUE  );
Expression sexpr= userWeb.getSecurityFilter(table.getName(), 1);// read permission
query.addParam(sexpr);
result= QueryEngine.getInstance().doQuery(query);
%>
<tree>
<%
	Object pkid,dk;
	boolean isSummary;
	String src;
	ColumnLink categoryIdLink=new ColumnLink("AD_CXTAB.AD_CXTAB_CATEGORY_ID");
	for(int i=0;i< result.getRowCount();i++){
		result.next();
		pkid= result.getObject(1);
		dk=  StringUtils.escapeForXML((String)result.getObject(2));
		isSummary=  Tools.getYesNo(result.getObject(3),false); //  default to false
		src= java.net.URLEncoder.encode("/html/nds/common/tree2.xml.jsp?tbstruct="+tableId+"&parentnode="+pkid+"&tbdata="+dataTableId+"&fnc="+action,request.getCharacterEncoding());
%>
	<tree text="<%=dk%>" src="<%=src%>">
<%
		// load data table records
	QueryRequestImpl queryData;
	QueryResult resultData=null;
	// only pk,dk will be selected, order by ak asc
	queryData=QueryEngine.getInstance().createRequest(userWeb.getSession());
	queryData.setMainTable(dataTableId);
	queryData.addSelection(dataTable.getPrimaryKey().getId());
	queryData.addSelection(dataTable.getDisplayKey().getId());
	queryData.addSelection(dataTable.getColumn("attr2").getId());
	queryData.setOrderBy( new int[]{ dataTable.getAlternateKey().getId()}, true);
	queryData.setRange(0, Integer.MAX_VALUE); 
	Expression expr= new Expression(categoryIdLink,"="+pkid ,null);
	
	//set reporttype to "S"
	expr=expr.combine(new Expression(new ColumnLink("AD_CXTAB.REPORTTYPE"), "=S",null), SQLCombination.SQL_AND,null);
	expr=expr.combine(new Expression(new ColumnLink("AD_CXTAB.ISACTIVE"), "=Y",null), SQLCombination.SQL_AND,null);
		expr=expr.combine(new Expression(new ColumnLink("AD_CXTAB.ISPUBLIC"), "=Y",null), SQLCombination.SQL_AND,null);
	expr=expr.combine(userWeb.getSecurityFilter(dataTable.getName(), 1) ,  SQLCombination.SQL_AND,null);
	queryData.addParam(expr);//read permission

	colOrderNo=dataTable.getColumn("orderno") ;
	if(colOrderNo!=null)orderKey= new int[]{ colOrderNo.getId()};
	else orderKey= new int[]{ dataTable.getAlternateKey().getId()};
	queryData.setOrderBy(orderKey, true);
	resultData= QueryEngine.getInstance().doQuery(queryData);
	String icon;
	for(int j=0;j< resultData.getRowCount();j++){
		resultData.next();
		icon=Validator.isNull((String)resultData.getObject(3) )? "cxtab.gif":"jrpt.gif";
%>
		<tree icon="<%=NDS_PATH%>/images/<%=icon%>" text="<%=StringUtils.escapeForXML((String)resultData.getObject(2))%>" action="javascript:<%=action%>(<%=resultData.getObject(1)%>)" />
<%	}
%>		
	</tree>	
<%		
	}%>	
</tree>

