<?xml version="1.0"?>
<%/**@page errorPage="/html/nds/error.jsp"*/%>
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
	int userId=userWeb.getUserId();


  
   

TableManager manager=TableManager.getInstance();
String tableId="u_note";
Table table,dataTable;
table= manager.getTable(tableId);
if(table ==null) throw new NDSException("Internal Error: message table not found."+ tableId);

/**------check permission---**/
String directory;
directory=table.getSecurityDirectory();
WebUtils.checkDirectoryReadPermission(directory, request);
/**------check permission end---**/

QueryRequestImpl query;
QueryResult result=null;
SessionContextManager scmanager= WebUtils.getSessionContextManager(session);

// only pk,dk will be selected, order by ak asc

query=QueryEngine.getInstance().createRequest(userWeb.getSession());
query.setMainTable(table.getId());
query.addSelection(table.getColumn("ID").getId());
query.addSelection(table.getColumn("CREATIONDATE").getId());
query.addSelection(table.getColumn("NO").getId());
query.addSelection(table.getColumn("priorityrule").getId());
query.addSelection(table.getColumn("TITLE").getId());
query.addSelection(table.getColumn("DESCRIPTION").getId());


query.addParam(table.getColumn("isactive").getId(), "Y");
query.addParam(table.getColumn("USER_ID").getId(), userId+"");
query.addParam(table.getColumn("docstatus").getId(), "INIT");
//query.addParam(table.getColumn("priorityrule").getId(), "3");


int[] orderKey;
int[] orderKey2;
Column colOrderNo=table.getColumn("CREATIONDATE");
Column colOrderNo2=table.getColumn("priorityrule");
if(colOrderNo!=null)orderKey= new int[]{ colOrderNo.getId()};
else orderKey= new int[]{ table.getAlternateKey().getId()};
if(colOrderNo2!=null)orderKey2= new int[]{ colOrderNo2.getId()};
else orderKey2= new int[]{ table.getAlternateKey().getId()};
query.setOrderBy(orderKey2, true);
query.addOrderBy(orderKey, false);

query.setRange(0, Integer.MAX_VALUE  );
Expression sexpr= userWeb.getSecurityFilter(table.getName(), 1);// read permission
query.addParam(sexpr);


//query.addParam("priorityrule<='2'");
result= QueryEngine.getInstance().doQuery(query);

QueryResultMetaData meta=result.getMetaData();
int urgentCount=0;

out.println("<messages>");

for(int j=0;j<result.getRowCount();j++){
    result.next();
    out.println("<message>");
    for(int k=1; k<=meta.getColumnCount();k++){
		if("PRIORITYRULE".equals(table.getColumn(meta.getColumnId(k)).getName())){if("1".equals(result.getObject(k)))urgentCount++;}
		out.print("<"+table.getColumn(meta.getColumnId(k)).getName()+">"+StringUtils.escapeHTMLTags(StringUtils.escapeForXML(result.getObject(k)+"")));
		out.print("</"+table.getColumn(meta.getColumnId(k)).getName()+">");
	}
	out.println("</message>");
}

if(urgentCount==0){
	String mrt=userWeb.getUserOption("MESSAGES_RELOADTIME","15");
	int message_reload_time=15;
	try {message_reload_time=Integer.parseInt(mrt);}catch(Exception NumberFormatException){}
	out.println("<reloadtime>"+message_reload_time+"</reloadtime>");
	if(session.getAttribute("last_messages_showed")==null){
		session.setAttribute("last_messages_showed",System.currentTimeMillis());
	}
	else if((System.currentTimeMillis()-(Long)session.getAttribute("last_messages_showed"))<(60000*message_reload_time)){
		out.print("<noshow/>");
	}else{
		session.setAttribute("last_messages_showed",System.currentTimeMillis());
	}

}
	Long timelap=System.currentTimeMillis();
	if(session.getAttribute("last_messages_showed")!=null)timelap=timelap-(Long)session.getAttribute("last_messages_showed");
out.println("<timelap>"+(timelap)+"</timelap>");

out.println("</messages>");


%>
