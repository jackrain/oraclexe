<%
	org.json.JSONObject tableObj=new org.json.JSONObject();
	tableObj.put("id", tableId);
	tableObj.put("desc", table.getDescription(locale)+" <"+nds.control.web.WebUtils.getCompany()+">");
	tableObj.put("actionADD", canAdd);
	tableObj.put("actionMODIFY", canModify);
	tableObj.put("actionDELETE", canDelete);
	tableObj.put("actionSUBMIT", canSubmit);
	tableObj.put("actionEXPORT", canExport);
	tableObj.put("actionGROUPSUBMIT", canSubmit &&  table.isActionEnabled(Table.GROUPSUBMIT));
	tableObj.put("actionVOID", canVoid);
	
	/**
	  1) Metadata
	*/
	EditableGridMetadata meta=new EditableGridMetadata(table, locale, userWeb, (ArrayList<ColumnLink>)qlc.getSelections(userWeb.getSecurityGrade()) );
	JSONObject gridMetadata=meta.toJSONObject();
	ArrayList al=new ArrayList();
	for(int i=0;i< meta.getColumns().size();i++){
		GridColumn c=(GridColumn)  meta.getColumns().get(i);
		if(c.isUploadWhenModify())al.add(new Integer(i));
	}
	gridMetadata.put("columnsWhenModify",nds.util.JSONUtils.toJSONArray(al));
	/**
	   2) QueryRequest
	*/
	JSONObject q=new JSONObject();
	q.put("callbackEvent","RefreshGrid");
	q.put("table", table.getName());
	q.put("qlcid", qlc.getId());
	q.put("dir_perm",listViewPermissionType);
	q.put("init_query",false);
	q.put("fixedcolumns", fixedColumns.toURLQueryString(null));
	q.put("start",0);
	q.put("range",QueryUtils.DEFAULT_RANGE);
	if(table.isSubTotalEnabled()){
		q.put("subtotal",true); // show sub total
	}
	q.put("show_alert",true); //show row css accroding to column value
	//order by, now contained with qlcid
	q.put("qlcid",qlc.getId());
	q.put("orders", qlc.getOrderBys(userWeb.getSecurityGrade()));
	/*JSONArray sporder=null;
	if( table.getJSONProps()!=null) sporder=table.getJSONProps().optJSONArray("orderby");
	if(sporder!=null){
		q.put("orderby", sporder);
	}else if( table.getColumn("orderno")!=null){
		q.put("order_columns", table.getColumn("orderno").getId());
		q.put("order_asc", true);
	}else{
		q.put("order_columns", table.getColumn("id").getId());
		q.put("order_asc", false);
	}*/
	// when this parameter set, system will try to load recent one week data
	//q.put("tryrecent",true);
	
	//String creationLink=WebUtils.getMainTableLink(request)+"table="+ tableId+"&fixedcolumns="+java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""),request.getCharacterEncoding())+"&next_screen="+java.net.URLEncoder.encode(StringUtils.escapeHTMLTags(urlOfThisPage),request.getCharacterEncoding());
	String singleObjectPageURL="";
	if( TableManager.getInstance().getColumn(table.getName(),"p_step")!=null ){
		 singleObjectPageURL=(
			nds.util.Validator.isNotNull(table.getRowURL())? nds.util.WebKeys.NDS_URI +  table.getRowURL() +"?":
			nds.util.WebKeys.NDS_URI +"/step/index.jsp?table="+table.getId()
			)
			+"&"+WebUtils.getMainTableLink(request)+"&fixedcolumns="+java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""))+"&id=";
    }else{
		singleObjectPageURL=(
			nds.util.Validator.isNotNull(table.getRowURL())? nds.util.WebKeys.NDS_URI +  table.getRowURL() +"?":
			nds.util.WebKeys.NDS_URI +"/object/object.jsp?table="+table.getId()
			)
			+"&"+WebUtils.getMainTableLink(request)+"&fixedcolumns="+java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""))+"&id=";
	}
		
	//String singleObjectPageURL=QueryUtils.getTableRowURL(table)+"&"+WebUtils.getMainTableLink(request)+"&fixedcolumns="+ java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""))+"&id=";
	StringBuffer tas=new StringBuffer();
	if(canAdd) tas.append("A");
	if(canModify) tas.append("M");
	if(canDelete) tas.append("D");
	if(canSubmit) tas.append("S");	
	boolean shouldWarn=Tools.getYesNo(userWeb.getUserOption("WARN_ON_SUBMIT","Y"),true);
	boolean refreshGridWhenCloseDialog=Tools.getYesNo(userWeb.getUserOption("REFRESH_PORTAL_GRID","Y"),true);
%>
<script>
gridInitObject={
	mainobjurl:"<%=singleObjectPageURL%>",
	metadata: <%=gridMetadata%>,
	query:<%=q%>
};
pc.setWarningOnSubmit(<%=shouldWarn%>);
//pc.setRefreshOnDialogClose(<%=refreshGridWhenCloseDialog%>);
<%
StringBuffer dialogOption=new StringBuffer("{1:1");
if(refreshGridWhenCloseDialog) dialogOption.append(",onClose:refreshPortalGrid");
if(nds.util.Validator.isNotNull(table.getRowURL())){
	if("_blank".equals(table.getRowURLTarget())){
		dialogOption.append(",iswindow:true,width:1000");
	}else if("fullscreen".equals(table.getRowURLTarget())){
		dialogOption.append(",iswindow:true,width:-1");
	}
}
dialogOption.append("}");
%>
pc.setDialogOption(<%=dialogOption%>);	
pc.setTableObj(<%=tableObj.toString()%>);
</script>
