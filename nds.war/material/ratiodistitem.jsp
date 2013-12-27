<%@ page language="java" import="org.json.JSONObject,org.json.JSONArray,nds.util.Tools" pageEncoding="utf-8"%>
<%@ page import="nds.control.web.UserWebImpl,nds.schema.*,nds.query.*" %>
<%@ page import="nds.control.web.WebUtils,javax.transaction.UserTransaction, nds.control.util.EJBUtils,java.sql.*,java.util.*" %>

<%!
private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("materiel/ratiodistitem.jsp");
public static int COLUMN_STR=2;
public static int COLUMN_NUM=0;
public static int COLUMN_DATE=1;
public static int COLUMN_DATENUMBER=3;
public String getValueSql(String clink,String colExpr,Column pColumn,String value,int cType)throws Throwable{
	ColumnLink clk=new ColumnLink(clink);
	boolean hasAkExpr=colExpr.indexOf("__")!=-1;
	String condition;
	int[] clinkIds=clk.getColumnIDs();
	boolean upperCase=false;
	Column lastC=clk.getLastColumn();
	if(hasAkExpr){
		Table vkT=lastC.getReferenceTable();
		String vkTname=vkT.getRealTableName();
		Column vkc=vkT.getAlternateKey();
		upperCase = vkc.isUpperCase();
		value=upperCase?value.toUpperCase():value;
		String vkSql="select id from "+vkTname+" where "+vkc.getName()+"="+(cType==COLUMN_NUM?value:"'"+value+"'");		
		condition="=("+vkSql+")";
		if(clinkIds.length==1)return "("+vkSql+")";
	}else{
		upperCase=lastC.isUpperCase();
		value=upperCase?value.toUpperCase():value;
		condition="="+(cType==COLUMN_NUM?value:"'"+value+"'");
	}
	
	
	int[] clkIds=Arrays.copyOfRange(clinkIds,1,clinkIds.length);
	ColumnLink clk2=new ColumnLink(clkIds);
	Expression ep=new Expression(clk2,condition,"");
	QuerySessionImpl qs=new QuerySessionImpl();
	qs.setAttribute("$AD_CLIENT_ID$",37);
	nds.db.oracle.QueryRequestImpl q=new nds.db.oracle.QueryRequestImpl(qs);
	q.setMainTable(TableManager.getInstance().getColumn(clkIds[0]).getTable().getId());
	q.addAllShowableColumnsToSelection(Column.PRINT_LIST, false);
	q.addParam(ep);
	return q.toPKIDSQL(true);
	
}
public String[] getCondtionAndValues(JSONArray ja,String aliasQtyColumn)throws Throwable{
	String cond="",values="";
	for(int i=0;i<ja.length();i++){
		JSONObject jo=(JSONObject)ja.get(i);
		int columnId=jo.getInt("columnId");
		Column cl=TableManager.getInstance().getColumn(columnId);
		Table t=cl.getReferenceTable();
		if(!(t!=null&&(t.getRealTableName().equals("Y_MATERIAL")||t.getRealTableName().equals("Y_MATERIAL_ALIAS")))&&!(cl.getName().equals(aliasQtyColumn))){
			cond+=cl.getName()+",";
			String value=jo.getString("value");
			String name=jo.getString("name");
			int ctype=jo.getInt("type");
			
			if(null!=t){
				String clink=jo.getString("clink");
				String sql=getValueSql(clink,name,cl,value,ctype);
				values+="("+sql+"),";
			}else{
				if(ctype==COLUMN_NUM)values+=value+",";
				else values+="'"+value+"',";
			}
		}
	}
	return new String[]{cond,values};
}
%>

<%
UserWebImpl userWeb =null;
try{
    userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));
}catch(Throwable userWebException){
    System.out.println("########## found userWeb=null##########"+userWebException);
}
if(userWeb==null || userWeb.isGuest()){
	String redirect=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString() ,"UTF-8");
	response.sendRedirect("/login.jsp?redirect="+redirect);
	return;
}

int userId=userWeb.getUserId();
int ymtid=Tools.getInt(request.getParameter("ymtid"),-1);
int objId=Tools.getInt(request.getParameter("objId"),-1);
int tableId=Tools.getInt(request.getParameter("tableId"),-1);
int mstTableId=Tools.getInt(request.getParameter("mstTable"),-1);
String aliasQtyColumn=request.getParameter("aliasQtyColumn");
Table table=null,masterTable=null;
String tableName=null,mstTableName=null,fColumnName=null,fMeterialAliasColumnName=null;
try{
	table=TableManager.getInstance().getTable(tableId);
	if(-1==mstTableId){
		masterTable=table.getParentTable();
	}else{
		masterTable=TableManager.getInstance().getTable(mstTableId);
	}

	
	tableName=table.getRealTableName();
	mstTableName=masterTable.getRealTableName();
	List  a=table.getAllColumns();
	for(int i=0;i<a.size();i++){
		 Column c= (Column)a.get(i);
		 if(null!=c.getReferenceTable()){
			 	if(mstTableName.equals(c.getReferenceTable().getRealTableName())){
					fColumnName=c.getName();
					if(null!=fMeterialAliasColumnName)break;
			 	}
			 	if("Y_MATERIAL_ALIAS".equals(c.getReferenceTable().getRealTableName())){
			 		fMeterialAliasColumnName=c.getName();
			 		if(null!=fColumnName)break;
			 	}
		 }
	}
}catch(Throwable t){logger.error("----->"+t.getMessage(),t);}
if(-1==ymtid||null==fColumnName||null==mstTableName||tableName==null||null==fMeterialAliasColumnName){
out.print("无法获取物料、当前表、主表、关联主表字段或关联物料条码字段信息！");
return;
}
String st=request.getParameter("itemdatas");
String cd=request.getParameter("colDate");
JSONArray colja=new JSONArray(cd); 
String[] condtionAndValues=new String[2];
try{
 condtionAndValues=getCondtionAndValues(colja,aliasQtyColumn);
}catch(Throwable t){logger.debug("----->"+t.getMessage(),t);}
String result="success";
JSONArray ja=new JSONArray(st); 
UserTransaction ut=null;
Connection conn=null;
PreparedStatement pstmt=null;
String sql=null;
try {
	ut = EJBUtils.getUserTransaction();
	ut.setTransactionTimeout(14400);
	ut.begin();
	conn = QueryEngine.getInstance().getConnection();
	
	int ms_id=QueryEngine.getInstance().getSequence(tableName, conn);
	List<String> ls=new ArrayList<String>();
	 sql="insert into "+tableName+"("+condtionAndValues[0]+"ID,AD_CLIENT_ID,AD_ORG_ID,"+fColumnName+","+fMeterialAliasColumnName+","+aliasQtyColumn+",OWNERID,MODIFIERID,CREATIONDATE,MODIFIEDDATE) values("+
								condtionAndValues[1]+"?,37,27,"+objId+",?,?,"+userId+","+userId+",sysdate,sysdate)";
	pstmt= conn.prepareStatement(sql);
	//logger.error(sql);
	for(int i=0;i<ja.length();i++){
		JSONObject jo=(JSONObject)ja.get(i);
		int ais=jo.getInt("ais");
		String num=jo.getString("num");
		if(0<Double.parseDouble(num)&&0<ais){
			int msitem_id=QueryEngine.getInstance().getSequence(tableName, conn);
			pstmt.setInt(1,msitem_id);
			pstmt.setInt(2,ais);
			if(num.indexOf(".")!=-1){
			pstmt.setDouble(3,Double.parseDouble(num));
			//logger.error("--------->"+Double.parseDouble(num));
			}
			else {pstmt.setInt(3,Integer.parseInt(num));
			//logger.error("--------->"+Integer.parseInt(num));	
			}
			pstmt.executeUpdate();
			new nds.control.ejb.DefaultWebEventHelper().doTrigger("AC",table,msitem_id,conn);
		}
	}
	new nds.control.ejb.DefaultWebEventHelper().doTrigger("AM",masterTable,objId,conn);
	ut.commit();
}catch(Throwable ta){
	
   if(ut!=null){
			try {
						ut.rollback();
			}catch (Exception e) {
				logger.error("Could not rollback.",e);
			}
		}
		result=ta.getMessage();
}finally{
	if(null!=conn){
     try {
          conn.close();
      }catch(Exception e) {
          logger.error("Can not close connection.",e);
      }
    }
}
out.print(result);
%>



