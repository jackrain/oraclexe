<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*" %>
<%@ page import="nds.control.util.*" %>
<%@ page import="nds.web.config.*" %>
<%! 
    /**
     * This page will create html segments only for single object modify content updating, including:
        $("buttons"), $("obj_inputs_1"), $("obj_inputs_2")
        
     * Things needed in this page:
     *  1.  table     main table that queried on(can be id or name)
     *  2.  id        id of object to be displayed, -1 means not found
     *  4.  fixedcolumns 在列表（关联对象）界面中创建单对象的时候，会有此参数
     *  5.  input	  if false, must be view page, else will determined by user permission
     *  
     */
    String urlOfThisPage;
	private static boolean objHelp="true".equals( ((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("obj.help","false"));
%>
<%
request.setAttribute("showtabs",Boolean.FALSE);
String tableName=request.getParameter("table");
int objectId=Tools.getInt(request.getParameter("id"),-1);
PairTable fixedColumns= PairTable.parseIntTable(request.getParameter("fixedcolumns"),null );
boolean isInput=ParamUtils.getBooleanParameter(request, "input",true);
String namespace="";
org.json.JSONArray dcqjsonarraylist=new org.json.JSONArray();
org.json.JSONObject dcqjsonObject=null;
TableManager manager=TableManager.getInstance();
QueryEngine engine=QueryEngine.getInstance();
Table table=null;
int tableId= Tools.getInt(tableName,-1);
if(tableId==-1){
	table=manager.findTable(tableName);
	if(table!=null){
		tableId= table.getId();
	}
}else{
	table=manager.getTable(tableId);
	
}
ObjectUIConfig uiConfig=WebUtils.getTableUIConfig(table);

if(table!=null){
	tableName= table.getName();
	request.setAttribute("mastertable", String.valueOf(tableId));
	request.setAttribute("masterid", String.valueOf(objectId));
}
request.setAttribute("table_help", new Integer(tableId));
int selectedTabId=-1;
NDSServletRequest ndsRequest=new NDSServletRequest(request);

String fkURLTarget= ((Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS)).getProperty("object.url.target");
if(nds.util.Validator.isNotNull(fkURLTarget)){
	fkURLTarget="target=\""+ fkURLTarget+"\"";
}else{
	fkURLTarget="";
}

if(table!=null){
	String object_page_url=NDS_PATH+"/object/object.jsp?table="+
		 tableId+ "&id="+ objectId+ "&select_tab="+ selectedTabId+(isInput?"":"&input=false");
	if(fixedColumns!=null)
		 object_page_url +="&fixedcolumns="+ fixedColumns.toURLQueryString("");
	request.setAttribute("object_page_url", object_page_url);	 
	
	int columnsPerRow =uiConfig.getColsPerRow();
	int widthPerColumn= (int)(100/(columnsPerRow*2));
	boolean seperateObjectByBlank=true;
	int actionType;
	QueryResult result=null;
	QueryRequestImpl query;
	ArrayList columns;
	boolean bReplaceVariable;
	Properties objprefs;
	String lastComment;
	Object[] lastCommentInfo;
	TableQueryModel model;
	FKObjectQueryModel fkQueryModel;
	String data=null;// result item data for display
	String dataWithoutNBSP=null;
	Object dataDB= null; // raw db data 
	String dataValue = null;//Hawke: data's value in select option
	int coid=-1;  // object id if result item will have a URL
	int tabIndex=0; 
	String fixedColumnMark; boolean isFixedColumn;
	DisplaySetting ds;
	int colIdx=-1; // colIdx max to columnsPerRow(equal), each row has (columnsPerRow x 2) <td>;
	Table refTable;
	Column column;
	String inputName;
	String column_acc_Id;
	String type;
	int inputSize;
	nds.util.PairTable values;
	String modifyPageUrl;
	List otherviews;
	String viewIdString;
	int columnIndex;
	Table itemTable;
	Column itemMasterPKColumn;
	PairTable itemFixedColumns;
	ArrayList rfts;
	RefByTable rft;
	int totalTabs;
	boolean itemTableFoundInRFTs;
	ArrayList validCommands=new ArrayList();//element: String
	ButtonFactory commandFactory= ButtonFactory.getInstance(pageContext,locale);
	Button btn;
	/**------check permission---**/
	// for status
	String directory;
	directory=table.getSecurityDirectory();
	
	int perm= userWeb.getPermission(directory);
	int status=0;
	try{
	if( manager.getColumn(table.getName(), "status")!=null )
		status= QueryEngine.getInstance().getSheetStatus(table.getRealTableName(),objectId);
	}catch(Exception e){
		
	}
	boolean isVoid=QueryUtils.isVoid(table,objectId,null);
	boolean hasWritePermission=false;
	boolean isWriteEnabled= ( ((perm & 3 )==3)) && status!=3 && status!=2 && !isVoid;
	boolean isSubmitEnabled= ( ((perm & 5 )==5)) && !isVoid ;
	
	boolean canVoid= table.isActionEnabled(Table.VOID) && !isVoid;
	boolean canUnvoid=table.isActionEnabled(Table.VOID) && isVoid && (!"false".equals(((Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS)).getProperty("table.action.unvoid", "true")));
	boolean canDelete= table.isActionEnabled(Table.DELETE) && 
		(( ((perm & 3 )==3)) && status!=3 && status!=2) && (isVoid || !table.isActionEnabled(Table.VOID) );
	
	boolean canAdd= table.isActionEnabled(Table.ADD) && isWriteEnabled;
	boolean canModify= table.isActionEnabled(Table.MODIFY) && isWriteEnabled && status !=2;
	boolean canSubmit= table.isActionEnabled(Table.SUBMIT) && isSubmitEnabled && status ==1;
	boolean canEdit= canModify || canAdd;
	
	/**------check permission end---**/

	/** -- add support for webaction of listbutton --**/
  Connection actionEnvConnection=null;
  List<WebAction> waObjButtons=new ArrayList<WebAction>(), waObjMenuItems=new ArrayList<WebAction>();
  HashMap actionEnv=new HashMap();
  try{
  	actionEnvConnection=QueryEngine.getInstance().getConnection();
	actionEnv.put("httpservletrequest", request);
	actionEnv.put("userweb", userWeb);
	actionEnv.put("connection", actionEnvConnection);
	actionEnv.put("objectid", String.valueOf(objectId));	
	actionEnv.put("maintable",table.getName());
	
  	List<WebAction> was=table.getWebActions(WebAction.DisplayTypeEnum.ObjButton);
  	for(int wasi=0;wasi<was.size();wasi++){
  		WebAction wa=was.get(wasi);
  		if(wa.canDisplay(actionEnv)){
  			waObjButtons.add(wa);
  		}
  	}
  	was=table.getWebActions(WebAction.DisplayTypeEnum.ObjMenuItem);
  	for(int wasi=0;wasi<was.size();wasi++){
  		WebAction wa=was.get(wasi);
  		if(wa.canDisplay(actionEnv)){
  			waObjMenuItems.add(wa);
  		}
  	}
  }finally{
  	if(actionEnvConnection!=null)try{actionEnvConnection.close();}catch(Throwable ace){}
  }
  /** -- end support for webaction of listbutton --**/	
	String includePage=null;
	String msgError=null;
	if(objectId !=-1){
			hasWritePermission=!isVoid && userWeb.hasObjectPermission(table.getName(),objectId,nds.security.Directory.WRITE) ;
		 	if(isInput==true && hasWritePermission){
		 		includePage="object_modify.jsp";
		 	}else if(userWeb.hasObjectPermission(table.getName(),objectId,nds.security.Directory.READ)){
		 		includePage="object_view.jsp";
		 	}else{
		 		msgError=PortletUtils.getMessage(pageContext, "no-permission-or-not-exists",null);
		 	}
	}else{
		  	// object id==-1
		  	if( (perm&nds.security.Directory.WRITE)==0){
		  		msgError=PortletUtils.getMessage(pageContext, "object-not-exists",null);
		  	}else{
		  		includePage="object_modify.jsp";
		  	}
	}//end if(objectId !=-1)
	
	if(msgError!=null){
	%>
		<div class="msg-error"><%=msgError%></div>
	<%}else{
		JSONObject tableObj=table.toJSONObject(locale);
		tableObj.put("description",table.getCategory().getName()+ " - "+ table.getDescription(locale));
		//load table display condition info
		JSONObject tableProps= WebUtils.loadObjectPropsForClient(table,objectId,userWeb.getSession());
		JSONArray displayConditions=null;
		if(tableProps!=null) {
			tableObj.put("props", tableProps);
			displayConditions=tableProps.optJSONArray("display_condition");
	%>
<script>
var masterObject={
	hiddenInputs:{
		id:<%=objectId %>,table:<%=tableId %>,namespace:"<%= namespace%>", tablename:"<%= table.getName()%>",
			directory:"<%= directory%>",fixedcolumns:"<%= fixedColumns.toURLQueryString("")%>",
			copyfromid:null
	},
	table:<%=tableObj%>,
	<%
	 ArrayList inputColumns=table.getColumns(new int[]{1,3}, false,userWeb.getSecurityGrade());// Columns input for Add/Modify 
	 JSONArray inputColumnsJson=new JSONArray();
	 for(int i=0;i<inputColumns.size();i++){
	 	inputColumnsJson.put( ((Column)inputColumns.get(i)).toJSONObject(locale));
	 } 
	%>
	columns:<%=inputColumnsJson.toString()%>
};
</script>	
		
	<%			
		}
		if("object_modify.jsp".equals(includePage)){
	%>
<%@ include file="object_modify.jsp"%>
		<%}else{%>
<%@include file="object_view.jsp"%>
		<%
		}
	}
}//end (table!=null && objectId!=-1)
 else{
	%>
		<div class="msg-error">
			<%= LanguageUtil.get(pageContext, "parameter-error") %>
		</div>
<%}
%>
