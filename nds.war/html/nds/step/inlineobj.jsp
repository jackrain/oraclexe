<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*" %>
<%@ page import="nds.control.util.*" %>
<%@ page import="nds.web.config.*" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>

<%! 
    /**
     * Object that is included as a tab in parent object page, so no buttons, no header/footer
       FOLLOWING DATA IS SET IN HTTPSERVLETREQUEST.ATTRIBUTES:
        1.  refbytable     reference table information (RefByTable)
        2.  inline_id    current object id (String)
        3.  fixedcolumns   identify relationship with master table(PairTable)
        4.  ismodify         "true"|"false"  (String)
     */
    String urlOfThisPage;
%>
<%
PairTable fixedColumns=(PairTable)request.getAttribute("fixedcolumns");
boolean isInput= "true".equals(request.getAttribute("ismodify"));
int objectId=Tools.getInt(request.getAttribute("inline_id"),-1);
RefByTable rfb= (RefByTable)request.getAttribute("refbytable");
if(rfb==null){
  out.println("Internal Error: wrong parameter when calling inlineobj.jsp");
  return;
}

ObjectUIConfig uiConfig= ObjectUIConfig.getDefaultInlineTableUIConfig();

TableManager manager=TableManager.getInstance();
QueryEngine engine=QueryEngine.getInstance();


int tableId= rfb.getTableId();
Table table=manager.getTable(tableId);
String tableName=table.getName();

String namespace="";
int status=0;
	

int selectedTabId=-1;

%>
<div id="inline-obj">
<%
if(table!=null){
	String object_page_url=NDS_PATH+"/step/index.jsp?table="+
		 tableId+ "&id="+ objectId+ "&select_tab="+ selectedTabId+(isInput?"":"&input=false");
	if(fixedColumns!=null)
		 object_page_url +="&fixedcolumns="+ fixedColumns.toURLQueryString("");
	request.setAttribute("object_page_url", object_page_url);	 
	org.json.JSONArray dcqjsonarraylist=new org.json.JSONArray();
	org.json.JSONObject dcqjsonObject=null;
	int columnsPerRow =uiConfig.getColsPerRow();
	int widthPerColumn= (int)(100/(columnsPerRow*2));
	boolean seperateObjectByBlank=false;
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
	try{
	if( manager.getColumn(table.getName(), "status")!=null )
		status= QueryEngine.getInstance().getSheetStatus(table.getRealTableName(),objectId);
	}catch(Exception e){
		
	}
	boolean hasWritePermission=false;
	boolean isWriteEnabled= ( ((perm & 3 )==3)) ;
	boolean isSubmitEnabled= ( ((perm & 5 )==5)) ;
	
	boolean canDelete= table.isActionEnabled(Table.DELETE) && isWriteEnabled && status !=2;
	boolean canAdd= table.isActionEnabled(Table.ADD) && isWriteEnabled;
	boolean canModify= table.isActionEnabled(Table.MODIFY) && isWriteEnabled && status !=2;
	boolean canSubmit= table.isActionEnabled(Table.SUBMIT) && isSubmitEnabled && status !=2;
	boolean canEdit= canModify || canAdd;
	/**------check permission end---**/
	
	String includePage=null;
	String msgError=null;
	if(objectId !=-1){
			hasWritePermission=userWeb.hasObjectPermission(table.getName(),objectId,nds.security.Directory.WRITE);
		 	if(isInput==true && hasWritePermission){
		 		includePage="inlineobj_modify.jsp";
		 	}else if(userWeb.hasObjectPermission(table.getName(),objectId,nds.security.Directory.READ)){
		 		includePage="inlineobj_view.jsp";
		 	}else{
		 		msgError=PortletUtils.getMessage(pageContext, "no-permission-or-not-exists",null);
		 	}
	}else{
		  	// object id==-1
		  	if( (perm&nds.security.Directory.WRITE)==0){
		  		msgError=PortletUtils.getMessage(pageContext, "object-not-exists",null);
		  	}else{
		  		includePage="inlineobj_modify.jsp";
		  	}
	}//end if(objectId !=-1)
	
	if(msgError!=null){
	%>
		<div class="msg-error"><%=msgError%></div>
	<%}else{
	%>
<script>
<%// inlineObject is defined in objcontrol.js
%>	
inlineObject={
	hiddenInputs:{
		id:<%=objectId %>,table:<%=tableId %>,namespace:"<%= namespace%>", tablename:"<%= table.getName()%>",
			directory:"<%= directory%>",fixedcolumns:"<%= fixedColumns.toURLQueryString("")%>",
			copyfromid:null
	},
	table:<%=table.toJSONObject(locale)%>,
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
		if("inlineobj_modify.jsp".equals(includePage)){
	%>
<%@ include file="inlineobj_modify.jsp"%>
		<%}else{%>
<%@include file="inlineobj_view.jsp"%>
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
</div><!--inline-obj-->
<%
if(status==2){
%>
<div id="inline_statusimg">
	<img src="<%=NDS_PATH+"/images/submitted-small" + ("CN".equals(locale.getCountry())? "_zh_CN":"")+".gif"%>" width="74" height="58">
</div>
<%}%>
