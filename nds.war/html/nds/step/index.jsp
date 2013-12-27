<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*" %>
<%@ page import="nds.control.util.*" %>
<%@ page import="nds.web.config.*" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %>
<%
String tableName=request.getParameter("table");
PairTable fixedColumns= PairTable.parseIntTable(request.getParameter("fixedcolumns"),null );
int objectId=Tools.getInt(request.getParameter("id"),-1);
int p_nextstep=Tools.getInt(request.getParameter("p_nextstep"),0);
int nextstep=Tools.getInt(request.getParameter("nextstep"),-1);
boolean isInput=true;
String namespace="";
int status=0;
TableManager manager=TableManager.getInstance();
QueryEngine engine=QueryEngine.getInstance();
org.json.JSONArray dcqjsonarraylist=new org.json.JSONArray();
org.json.JSONObject dcqjsonObject=null;
Table table=null;
int tableId= Tools.getInt(tableName,-1);
if(tableId==-1){
	table=manager.getTable(tableName);
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
}

int selectedTabId=-1;

%>
<html>
<head>
<%@ include file="/html/nds/step/top_meta.jsp"%>
</head>
<body id="obj-body">
	<%@ include file="body_meta.jsp"%>
<%
if(table!=null){	 
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
	String fixedColumnMark; 
	boolean isFixedColumn;
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
	int columnIndex;
	Table itemTable;
	Column itemMasterPKColumn;
	PairTable itemFixedColumns;
	ArrayList rfts;
	RefByTable rft;
	int totalTabs;
	boolean itemTableFoundInRFTs;
	ArrayList validCommands=new ArrayList();
	ButtonFactory commandFactory= ButtonFactory.getInstance(pageContext,locale);
	Button btn;
	String includePage="";
	/**------check permission---**/
	// for status
	String directory;
	directory=table.getSecurityDirectory();
	int perm= userWeb.getPermission(directory);
	boolean hasWritePermission=false;
	boolean isWriteEnabled= ( ((perm & 3 )==3)) ;
	boolean isSubmitEnabled= ( ((perm & 5 )==5)) ;
	
	boolean canDelete= table.isActionEnabled(Table.DELETE) && isWriteEnabled && status !=2;
	boolean canAdd= table.isActionEnabled(Table.ADD) && isWriteEnabled ;
	boolean canModify= table.isActionEnabled(Table.MODIFY) && isWriteEnabled && status !=2;
	boolean canSubmit= table.isActionEnabled(Table.SUBMIT) && isSubmitEnabled && status !=2;
	boolean canEdit= canModify || canAdd;
	/**------check permission end---**/
	String msgError=null;
	if( (perm&nds.security.Directory.WRITE)==0){
		 msgError=PortletUtils.getMessage(pageContext, "object-not-exists",null);
	}
	%>
<script>
var masterObject={
	hiddenInputs:{
		id:<%=objectId%>,table:<%=tableId %>,namespace:"<%= namespace%>", tablename:"<%= table.getName()%>",
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
	if(objectId !=-1){
			hasWritePermission=(canDelete || canModify ||canSubmit) && 
				userWeb.hasObjectPermission(table.getName(),objectId,nds.security.Directory.WRITE);
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
	}
%>
<%
boolean bDoModify="object_modify.jsp".equals(includePage);
if(bDoModify){
%>
	<%@ include file="object_modify.jsp"%>
<%}else{%>
	<%@include file="object_view.jsp"%>
<%}
}%>
<%
if(status==2){
%>
<div id="statusimg">
	<img src="<%=NDS_PATH+"/images/submitted-small" + ("CN".equals(locale.getCountry())? "_zh_CN":"")+".gif"%>" width="74" height="58">
</div>
<%}%>
<input type='hidden' name='queryindex_-1' id='queryindex_-1' value="-1" />
<table><tr><td>
	  <script>
	  	 	jQuery(document).ready(function(){dcq.createdynlist(<%=dcqjsonarraylist%>)});
	  	  var ti=setInterval("dcq.dynquery();",500);
	  </script>
</td></tr></table>
</body>
</html>