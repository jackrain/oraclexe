<%
	/**
	  1) Metadata
	*/
	EditableGridMetadata meta=new EditableGridMetadata(table, locale, userWeb,EditableGridMetadata.ITEM_COLUMN_MASKS);
	/**
	   2) QueryRequest
	*/
	JSONObject q=new JSONObject();
	q.put("callbackEvent","RefreshGrid");
	q.put("table", table.getName());
	q.put("column_masks", JSONUtils.toJSONArrayPrimitive(meta.ITEM_COLUMN_MASKS));
	q.put("dir_perm", 1);
	q.put("init_query",true);
	q.put("fixedcolumns", fixedColumns.toURLQueryString(null));
	q.put("start",0);
	q.put("range",QueryUtils.DEFAULT_RANGE);
	if( table.getColumn("orderno")!=null){
		q.put("order_columns", table.getColumn("orderno").getId());
		q.put("order_asc", true);
	}else{
		q.put("order_columns", table.getColumn("id").getId());
		q.put("order_asc", false);
	}
	String creationLink=WebUtils.getMainTableLink(request)+"table="+ tableId+"&fixedcolumns="+java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""),request.getCharacterEncoding())+"&next_screen="+java.net.URLEncoder.encode(StringUtils.escapeHTMLTags(urlOfThisPage),request.getCharacterEncoding());
	
	String singleObjectPageURL=(
		nds.util.Validator.isNotNull(table.getRowURL())? nds.util.WebKeys.NDS_URI +  table.getRowURL() +"?":
		nds.util.WebKeys.NDS_URI +"/step/index.jsp?table="+table.getId()
		)
		+"&"+WebUtils.getMainTableLink(request)+"&fixedcolumns="+ java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""))+"&id=";
		
	//String singleObjectPageURL=QueryUtils.getTableRowURL(table)+"&"+WebUtils.getMainTableLink(request)+"&fixedcolumns="+ java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""))+"&id=";
	StringBuffer tas=new StringBuffer();
	if(canAdd) tas.append("A");
	if(canModify) tas.append("M");
	if(canDelete) tas.append("D");
	if(canSubmit) tas.append("S");
	
%>
function GridInitObject(){}
GridInitObject.prototype={
	getGridMetadata: function () {return <%=meta.toJSONObject(refbyTable.allowPopup())%>;},
	getGridQueryObj:function(){return <%=q%>;},
	getInlineMode:function(){return "<%=((isModify && refbyTable!=null)? refbyTable.getInlineMode():"N")%>";},
	getLineCreationLink:function(){ return "<%=creationLink%>";},
	getLinePage:function(){ return "<%=singleObjectPageURL%>";},
	getFixedColumns:function(){ return <%=(new org.json.JSONObject(fixedColumns.toHashMap())).toString()%>;},
	getFixedColumnsStr:function(){return "<%=fixedColumns.toURLQueryString(null)%>"},
	getTableActions:function(){return "<%=tas.toString()%>"; },
	supportAttributeDetail:function(){return <%=table.supportAttributeDetail()%>; }
};

