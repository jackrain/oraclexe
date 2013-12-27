<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>

<%
    /**
     * Things needed in this page:
     *  1.  table     main table that queried on(can be id or name)
     *  2.  id        id of object to be displayed, -1 means not found
     *  3.  select_tab   ref-by-table id of main table, is set, will select that tab.
     *                   if is -1 or 0,means selecting main table object.
     *  4.  fixedcolumns 在列表（关联对象）界面中创建单对象的时候，会有此参数
     *  5.  input	  如果为false，则必定是查看界面，否则根据用户权限自动判断
     */
%>
<%!
	private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("ajaxtab");
	private TableManager manager=TableManager.getInstance();
	/**
	* Get object Id of the ref-by table according to main table's record id
	*/
	private int getObjectId(RefByTable rbt,int mainTableObjectId ) throws Exception{
		int objectId=-1;
		String sql="select ";
		Table rbtb= manager.getTable( rbt.getTableId());
		Column rbtc= manager.getColumn(rbt.getRefByColumnId());
		sql+=rbtb.getPrimaryKey().getName() + " from "+ rbtb.getRealTableName()+
			" where "+ rbtc.getName()+ "="+ mainTableObjectId;
		
		ResultSet rs=QueryEngine.getInstance().doQuery(sql);
		if( rs.next()){
			objectId=rs.getInt(1);
		}
		try{rs.close();}catch(Exception e){}
		return objectId;
	}
%>
<%

Table mainTable=null;

int mainTableId= ParamUtils.getIntParameter(request,"table", -1);
int selectedTabId= ParamUtils.getIntParameter(request,"select_tab", -1);
PairTable fixedColumns= PairTable.parseIntTable(request.getParameter("fixedcolumns"),null );
boolean isInput=ParamUtils.getBooleanParameter(request, "input",true);
int p_nextstep=Tools.getInt(request.getParameter("p_nextstep"),-1);
if( mainTableId == -1){
    // try table as String
    String mainTableName= ParamUtils.getParameter(request,"table");
    mainTable= manager.getTable(mainTableName);
    mainTableId= mainTable.getId();
}else{
    mainTable= manager.getTable(mainTableId);
}

// when creation action executed, will call this

int mainTableObjectId=ParamUtils.getIntParameter(request,"id", -1);
if( mainTableObjectId==-1){
    mainTableObjectId=ParamUtils.getIntParameter(request,nds.util.WebKeys.VALUE_HOLDER_PREFIX+"objectid", -1);
}
int status=0;
if(mainTableObjectId!=-1){
try{
if( manager.getColumn(mainTable.getName(), "status")!=null )
	status= QueryEngine.getInstance().getSheetStatus(mainTable.getRealTableName(),mainTableObjectId);
}catch(Exception e){
	e.printStackTrace();
}
}
//System.out.println("mainTable="+mainTable+",id="+mainTableObjectId+",status="+ status );
if(status==2||p_nextstep==-2) {
	isInput=false;
	request.setAttribute("nds.request.object.mainobject.status", "2");
}	
/**
* Check object permission of real existence according to current user
* if not permission, or not exists, raise exception
*
*/
if (mainTableObjectId!=-1){
	QueryRequestImpl objectquery=QueryEngine.getInstance().createRequest(userWeb.getSession());
    objectquery.setMainTable(mainTableId);
	objectquery.addSelection(mainTable.getPrimaryKey().getId());
	Expression expr1= new Expression(new ColumnLink(new int[]{mainTable.getPrimaryKey().getId()}), ""+ mainTableObjectId, null);
    Expression expr2=userWeb.getSecurityFilter(mainTable.getName(), nds.security.Directory.READ);
    if(expr2!=null && !expr2.isEmpty()){
        expr1=expr1.combine(expr2, SQLCombination.SQL_AND,null);
    }
    objectquery.addParam(expr1);
	QueryResult objectresult=QueryEngine.getInstance().doQuery(objectquery);
	if(objectresult.getTotalRowCount()==0){
		throw new NDSException(PortletUtils.getMessage(pageContext, "object-not-exists",null));
	}
}	
/**
* 如果此记录是在其他表的主表的明细引用中创建，则主表应当设置为此表的主表，
* 否则设置为此记录本身（如果此记录本身的引用表是多行的时候，就有用了）
*/
if(Tools.getInt(request.getParameter("mainobjecttableid"),-1)==-1){
request.setAttribute("mainobjecttableid",""+mainTableId);
}else{
request.setAttribute("mainobjecttableid",request.getParameter("mainobjecttableid"));
}
String object_page_url=NDS_PATH+"/step/index.jsp?"+WebUtils.getMainTableLink(request)+"table="+
	 mainTableId+ "&id="+ mainTableObjectId+ "&select_tab="+ selectedTabId+(isInput?"":"&input=false");
if(fixedColumns!=null)
	 object_page_url +="&fixedcolumns="+ fixedColumns.toURLQueryString("");
request.setAttribute("object_page_url", object_page_url);	 
request.setAttribute("table_help", new Integer(mainTable.getId()));
int navTabTotalWidth=DEFAULT_TAB_WIDTH; //total table width

String borderColor = "class=\"alpha\"";
//Set the maximum length to display a tab name.
int tabNameMaxLength =24; // in bytes, 1.5 has 3 bytes per hanzi, 1.4 has 2
//Set the maximum number of tabs per row.
int tabsPerRow =6;

int tabPixels = (int)(navTabTotalWidth * (((double)1 / tabsPerRow) - .01));
int tabSeparationPixels = 2;

ArrayList rfts= userWeb.constructTabs(mainTable, mainTableObjectId);
int totalTabs = rfts.size(); // ref-by-tables and the table its self
int leftOverPixels = (tabsPerRow < totalTabs) ? (navTabTotalWidth - (tabsPerRow * tabPixels) - (tabsPerRow * tabSeparationPixels)) : (leftOverPixels = navTabTotalWidth - (totalTabs * tabPixels) - (totalTabs * tabSeparationPixels));

int layoutCounter = 0;
int layoutBreak = totalTabs	% tabsPerRow;
RefByTable rft, selectedRefByTable=null;
Table rftTable;


int selectedTabColIdx=0;
int selectedTabWidth=tabPixels;
int tabColIdx=-1;

for (int i = 0; i < rfts.size(); i++) {
	layoutCounter++;
	tabColIdx++;
	rft= (RefByTable) rfts.get(i);
	rftTable= manager.getTable(rft.getTableId());
	
	boolean isSelectedTab =(selectedTabId== rft.getId());
	if(isSelectedTab) {
		selectedRefByTable=rft;
	}
}
%><%@ include file="/html/nds/step/object_tabcontent.jsp" %>