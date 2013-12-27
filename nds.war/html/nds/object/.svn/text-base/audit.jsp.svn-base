<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*" %>
<%@ page import="nds.control.util.*" %>
<%@ page import="nds.web.config.*" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<!--%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %-->
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor" %>
<%! 
    /** 
     如果用户尚未登录系统，将引导向登录窗口
     * Things needed in this page:
     *  1.  table     main table that queried on(can be id or name),如果审核人没有访问此表的权限，自动尝试对应的real_table的相应记录的权限
     *  2.  id        id of object to be displayed, -1 means not found, when param table is set, id should be pk of the table specified
     				  if table is not set, it will be id of table V_AUDITBILL(view of AU_PHASEINSTANCE)
     *  3.  auditid   用于审核人审核单据所定义工作流的id 即 au_phaseinstance.id; 
     */
    String urlOfThisPage;
	private static boolean objHelp="true".equals( ((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("obj.help","false"));

	
%>
<%
String tableName=request.getParameter("table");
int objectId=Tools.getInt(request.getParameter("id"),-1);
int auditid=Tools.getInt(request.getParameter("auditid"),-1);
if(userWeb==null || userWeb.isGuest()){
	String redirect=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString() ,"UTF-8");
	response.sendRedirect("/login.jsp?redirect="+redirect);
	return;
}
QueryEngine engine=QueryEngine.getInstance();
TableManager manager=TableManager.getInstance();
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
// if table is null, id should be pk of V_AUDITBILL
if(table==null){
	List al=engine.doQueryList("select ad_table_id, record_id from AU_PHASEINSTANCE where id="+objectId);
	if(al.size()>0){
		auditid=objectId;
		tableId= Tools.getInt( ((List)al.get(0)).get(0),-1);
		objectId=Tools.getInt( ((List)al.get(0)).get(1),-1);
		table= manager.getTable(tableId);
		if(table==null || objectId==-1) throw new NDSException("Parameter error");
	}else{
		throw new NDSException("Parameter error");
	}
}
// if auditid not set, search over au_phaseinstance for current user and current object,
// if multiple found, latest one will be located.
if(auditid==-1){
	auditid=Tools.getInt(engine.doQueryOne("select pi.id from au_phaseinstance pi, au_pi_user u where u.au_pi_id=pi.id and pi.ad_table_id="+
		tableId+" and pi.record_id="+objectId+" and pi.state='W' and ((u.ad_user_id="+userWeb.getUserId()+
		" and u.assignee_id is null ) or (u.assignee_id="+ userWeb.getUserId()+")) and u.state='W' order by id desc"),-1);
	
	if(auditid<1){
		throw new NDSException("@no-permission@");
	}
}else{
	// check user has audit records on this object
	int cnt=Tools.getInt(engine.doQueryOne("select count(*) from au_pi_user where au_pi_id="+ auditid+
		" and ((ad_user_id="+userWeb.getUserId()+" and assignee_id is null ) or (assignee_id="+ userWeb.getUserId()+")) and state='W'"),-1);
	if(cnt<1){
		throw new NDSException("@no-permission@");
	}
}
PairTable fixedColumns=PairTable.EMPTY_PAIRTABLE;
boolean isInput=false;
String namespace="";
int status=0;
boolean canVoid=false;
boolean isVoid=false;
org.json.JSONArray dcqjsonarraylist=new org.json.JSONArray();
org.json.JSONObject dcqjsonObject=null;

//check user read permission on this record
if(!userWeb.hasObjectPermission(table.getName(),objectId,nds.security.Directory.READ)){
	//check read permission on real table, if has
	if(table.getRealTableName()!=null) {
		table=manager.getTable(table.getRealTableName());
		tableId=table.getId();
		if(!userWeb.hasObjectPermission(table.getName(),objectId,nds.security.Directory.READ)){
			throw new NDSException("@no-permission-or-not-exists@");
		}
	}else{
		throw new NDSException("@no-permission-or-not-exists@");
	}
}

ObjectUIConfig uiConfig=WebUtils.getTableUIConfig(table);

if(table!=null){
	tableName= table.getName();
	request.setAttribute("mastertable", String.valueOf(tableId));
	request.setAttribute("masterid", String.valueOf(objectId));
	// Forbid none menuobject from opening
	//if(!table.isMenuObject()) throw new NDSException("@forbid-none-menuobject@");
}
request.setAttribute("table_help", new Integer(tableId));

int selectedTabId=-1;
NDSServletRequest ndsRequest=new NDSServletRequest(request);
%>
<html>
<head>
<%@ include file="top_meta.jsp" %>
</head>
<body id="obj-body">
<%@ include file="body_meta.jsp"%>

<!--<div id="obj-content">-->
<%

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
	try{
	if( manager.getColumn(table.getName(), "status")!=null )
		status= QueryEngine.getInstance().getSheetStatus(table.getRealTableName(),objectId);
	}catch(Exception e){
		
	}
	boolean hasWritePermission=false;
	boolean isWriteEnabled= ( ((perm & 3 )==3)) ;
	boolean isSubmitEnabled= ( ((perm & 5 )==5)) ;
	
	boolean canDelete= table.isActionEnabled(Table.DELETE) && isWriteEnabled && status !=2;
	boolean canAdd= table.isActionEnabled(Table.ADD) && isWriteEnabled ;
	boolean canModify= table.isActionEnabled(Table.MODIFY) && isWriteEnabled && status !=2;
	boolean canSubmit= table.isActionEnabled(Table.SUBMIT) && isSubmitEnabled && status ==1;
	boolean canEdit= canModify || canAdd;
	/**------check permission end---**/
	List<WebAction> waObjButtons=new ArrayList<WebAction>(), waObjMenuItems=new ArrayList<WebAction>();
	HashMap actionEnv=new HashMap();
	String includePage=null;
	String msgError=null;
	
	includePage="object_view.jsp";
	/*
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
	}//end if(objectId !=-1)
	*/
	
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
		}
	%>
<script>
var masterObject={
	hiddenInputs:{
		id:<%=objectId %>,table:<%=tableId %>,namespace:"<%= namespace%>", tablename:"<%= table.getName()%>",
			directory:"<%= directory%>",fixedcolumns:null,
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
		boolean bDoModify="object_modify.jsp".equals(includePage);
		if(bDoModify){
	%>
<%@ include file="object_modify.jsp"%>
		<%}else{%>
<%
//String object_page_url=(String) request.getAttribute("object_page_url");
actionType= Column.QUERY_OBJECT;
 
query=QueryEngine.getInstance().createRequest(userWeb.getSession());
query.setMainTable(tableId);
query.addAllShowableColumnsToSelection(actionType);
query.addParam( table.getPrimaryKey().getId(), ""+ objectId );
result=QueryEngine.getInstance().doQuery(query);
try{
if( manager.getColumn(table.getName(), "status")!=null )
	status= QueryEngine.getInstance().getSheetStatus(table.getRealTableName(),objectId);
}catch(Exception e){
}
if(result.getTotalRowCount()==0){
%>
	<div class="msg-error"><%=PortletUtils.getMessage(pageContext, "object-not-exists",null)%></div>
<%}else{
columns=table.getShowableColumns(actionType);
%>
<div id="obj-top">
<div class="buttons">
	&nbsp;&nbsp;
	<%=LanguageUtil.get(pageContext,"audit-comments",null)%>:<input id="comments" class="form-text" type="text" value="" name="comments" maxlength="255" size="80"/>&nbsp;
	<span id="buttons"><!--BUTTONS_BEGIN-->
	<%
	 validCommands.add(commandFactory.newButtonInstance("Accept", PortletUtils.getMessage(pageContext, "object.accept",null),"oc.audit('accept',"+auditid+")","A"));
	 validCommands.add(commandFactory.newButtonInstance("Reject", PortletUtils.getMessage(pageContext, "object.reject",null),"oc.audit('reject',"+auditid+")","R"));
   otherviews= Collections.EMPTY_LIST;
  //item table should not show other views
  if(manager.getParentTable(table)==null) otherviews=userWeb.constructViews(table,objectId);
%>
<%@ include file="inc_command.jsp" %>
			<!--BUTTONS_END--></span>
	<span id="closebtn"></span><a href="workflow.jsp?table=<%=tableId%>&id=<%=objectId%>"><%=PortletUtils.getMessage(pageContext, "view-workflow",null)%></a> 
	</div>
	<div id="message" class="nt"  style="visibility:hidden;">
	</div>
</div>

<div class="<%=uiConfig.getCssClass()%>" id="<%=uiConfig.getCssClass()%>">
<form name="<%=namespace%>fm" method="post" action="<%=contextPath %>/control/command" onSubmit="return false;">
<input type="hidden" name="id" value="<%=objectId %>">
<input type="hidden" name="table" value="<%=tableId %>">
	<%if(uiConfig.isShowComments()){%>
	<!--<div class="comments">
		 include file="inc_object_comments.jsp" 
	</div>-->
	<%}%>
	
<%
	//if true, will show data without variable, else show variable directly. This is used for template setting page
	//@see inc_template.jsp/inc_batchupdate.jsp
	bReplaceVariable= false;
	objprefs= userWeb.getPreferenceValues("template."+table.getName().toLowerCase(),false,bReplaceVariable);

	model= new TableQueryModel(tableId, actionType,isInput,true,locale);
	if(result!=null)result.next();
	columnIndex=0;
	
%>	
	<div class="obj" id="obj_inputs_1"><!--OBJ_INPUTS1_BEGIN-->
		<%@ include file="inc_single_object.jsp" %><!--OBJ_INPUTS1_END-->
	</div>
	<% if( !Boolean.FALSE.equals(request.getAttribute("showtabs"))){%>
		<%@ include file="inc_tabs.jsp" %>
	<%}%>
	<%if(columnIndex!=columns.size()){%>
	<div class="obj" id="obj_inputs_2"><!--OBJ_INPUTS2_BEGIN-->
		<%@ include file="inc_single_object.jsp" %><!--OBJ_INPUTS2_END-->
	</div>
	<%}// end if(columnIndex!=columns.size())
	%>	
</form>	
</div>

<%}// end (result.getTotalRowCount()!=0)
%>

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
<!--</div>end obj-content-->
<%
if(status==2){
%>
<div id="statusimg">
	<img src="<%=NDS_PATH+"/images/submitted-small" + ("CN".equals(locale.getCountry())? "_zh_CN":"")+".gif"%>" width="74" height="58">
</div>
<%}%>
<div id="obj-bottom">
	<%@ include file="bottom.jsp" %>
</div>
</body>
</html>
