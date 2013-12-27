<%@page errorPage="/html/nds/error.jsp"%>
<%@ taglib uri='/WEB-INF/tld/input.tld' prefix='input' %>
<%@ include file="/html/portlet/nds/init.jsp" %>
<%!
	/**
	* preference params:
		"uiConfig" : id of nds.web.config.ListDataConfig 
	  parameters from request (attribute named "CURRENT_URL", which has sample like:
	   "/c/portal/layout?p_l_id=PRI.1003.3&table=c_v_po_order&id=657"
	   	 "id" - object id
	   	 "table" - table id
		 "fixedcolumns" - filter for main table
	*/
%>
<%
int uiconf = Tools.getInt(prefs.getValue("uiConfig", "-1"),-1);
PortletConfigManager pcManager=(PortletConfigManager)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.PORTLETCONFIG_MANAGER);
ObjectUIConfig uiConfig= (ObjectUIConfig)pcManager.getPortletConfig(uiconf,nds.web.config.PortletConfig.TYPE_OBJECT_UI);
//if(uiConfig==null) uiConfig= ObjectUIConfig.getDefaultConfig();
String namespace= renderResponse.getNamespace();

if (uiConfig!=null){
	
	TableManager manager=TableManager.getInstance();
	QueryEngine engine=QueryEngine.getInstance();
	String tableName=nds.portlet.util.PortletUtils.findRequestParameter(renderRequest, uiConfig.getTableParamName());
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
	if(table!=null)tableName= table.getName();
	int objectId=Tools.getInt(nds.portlet.util.PortletUtils.findRequestParameter(renderRequest,uiConfig.getIdParamName()),-1);
	PairTable fixedColumns=PairTable.parse(nds.portlet.util.PortletUtils.findRequestParameter(renderRequest,"fixecolumns"),"");
	int selectedTabId=-1;
	
	boolean isInput=(uiConfig.getDefaultAction()== ObjectUIConfig.ACTION_EDIT);
	if(table!=null){
%>
		<div id="<%=namespace%>obj-content">
		<%
		String object_page_url=NDS_PATH+"/sheet/object.jsp?table="+
			 tableId+ "&id="+ objectId+ "&select_tab="+ selectedTabId+(isInput?"":"&input=false");
		if(fixedColumns!=null)
			 object_page_url +="&fixedcolumns="+ fixedColumns.toURLQueryString("");
		request.setAttribute("object_page_url", object_page_url);	 
		
		int columnsPerRow =uiConfig.getColsPerRow();
		int widthPerColumn= (int)(100/(columnsPerRow*2));
		
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
		boolean hasWritePermission=false;
		boolean isWriteEnabled= ( ((perm & 3 )==3)) ;
		boolean isSubmitEnabled= ( ((perm & 5 )==5)) ;
		
		boolean canDelete= table.isActionEnabled(Table.DELETE) && isWriteEnabled && status !=2;
		boolean canAdd= table.isActionEnabled(Table.ADD) && isWriteEnabled;
		boolean canModify= table.isActionEnabled(Table.MODIFY) && isWriteEnabled && status !=2;
		boolean canSubmit= table.isActionEnabled(Table.SUBMIT) && isSubmitEnabled && status !=2;
		/**------check permission end---**/
		
		String includePage=null;
		String msgError=null;
		if(objectId !=-1){
				hasWritePermission=userWeb.hasObjectPermission(table.getName(),objectId,nds.security.Directory.WRITE);
			 	if(isInput==true && hasWritePermission){
			 		includePage="single_object_modify.jsp";
			 	}else if(userWeb.hasObjectPermission(table.getName(),objectId,nds.security.Directory.READ)){
			 		includePage="single_object_view.jsp";
			 	}else{
			 		msgError=PortletUtils.getMessage(pageContext, "no-permission-or-not-exists",null);
			 	}
		}else{
			  	// object id==-1
			  	if( (perm&nds.security.Directory.WRITE)==0){
			  		msgError=PortletUtils.getMessage(pageContext, "object-not-exists",null);
			  	}else{
			  		includePage="single_object_modify.jsp";
			  	}
		}//end if(objectId !=-1)
		
		if(msgError!=null){
		%>
			<div class="msg-error"><%=msgError%></div>
		<%}else{
			if("single_object_modify.jsp".equals(includePage)){
		%>
<%@ include file="single_object_modify.jsp"%>
		<%	}else{%>
<%@include file="single_object_view.jsp"%>
		<%
			}
		}
		%>	 			
		</div><!--<%=namespace%>obj-content-->
	<%}//end (table!=null && objectId!=-1)
	 else{
	%>
				<div class="msg-error">
					<!--<%= LanguageUtil.get(pageContext, "parameter-error") %> (table not set)-->
				</div>
	<%}
}else{	//end uiConfig!=null
%>
		<%= LanguageUtil.get(pageContext, "please-contact-the-administrator-to-setup-this-portlet") %>
<%}%>
