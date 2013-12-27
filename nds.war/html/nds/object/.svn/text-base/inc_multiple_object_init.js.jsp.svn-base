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
	q.put("nea.tabitems", true);//skip item permission check over parent table, @see AjaxUtils.parseQuery
	q.put("fixedcolumns", fixedColumns.toURLQueryString(null));
	int startIndex=Tools.getInt( ((Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS)).getProperty("object.tab.startidx"),0);
	if( table.getJSONProps()!=null) {
		startIndex=table.getJSONProps().optInt("startidx",startIndex);
	}
	q.put("start",startIndex);
	
	q.put("range",QueryUtils.DEFAULT_RANGE);
	
	JSONArray sporder=null;
	ArrayList orders=new ArrayList();
	if( table.getJSONProps()!=null) sporder=table.getJSONProps().optJSONArray("orderby");
	if(sporder!=null){
		//order by format: {column, asc:boolean}[]
		for(int i=0;i<sporder.length();i++){
			ColumnLink cl=new ColumnLink(table.getName()+"."+sporder.getJSONObject(i).getString("column"));
			cl.setTag(new Boolean(sporder.getJSONObject(i).optBoolean("asc",true)));
			orders.add(cl);
		}
	}else{
		if( table.getColumn("orderno")!=null){
			ColumnLink cl=new ColumnLink(table.getName()+"."+table.getColumn("orderno").getName());
			cl.setTag(Boolean.TRUE);
			orders.add(cl);
		}else{
			ColumnLink cl=new ColumnLink(table.getName()+"."+table.getColumn("ID").getName());
			cl.setTag(Boolean.FALSE);
			orders.add(cl);
		}
	}
	q.put("orders", orders);
	String creationLink=WebUtils.getMainTableLink(request)+"table="+ tableId+"&fixedcolumns="+java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""),request.getCharacterEncoding())+"&next_screen="+java.net.URLEncoder.encode(StringUtils.escapeHTMLTags(urlOfThisPage),request.getCharacterEncoding());
	
	String singleObjectPageURL=(
		nds.util.Validator.isNotNull(table.getRowURL())? nds.util.WebKeys.NDS_URI +  table.getRowURL() +"?":
		nds.util.WebKeys.NDS_URI +"/object/object.jsp?table="+table.getId()
		)
		+"&"+WebUtils.getMainTableLink(request)+"&fixedcolumns="+ java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""))+"&id=";
		
	//String singleObjectPageURL=QueryUtils.getTableRowURL(table)+"&"+WebUtils.getMainTableLink(request)+"&fixedcolumns="+ java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""))+"&id=";
	StringBuffer tas=new StringBuffer();
	if(canAdd) tas.append("A");
	if(canModify) tas.append("M");
	if(canDelete) tas.append("D");
	if(canSubmit) tas.append("S");
	
	String inlineMode=((isModify && refbyTable!=null)? refbyTable.getInlineMode():"N");
	if(refbyTable!=null && inlineMode.equals("Y")) {
		JSONObject jrob=TableManager.getInstance().getTable(refbyTable.getTableId()).getJSONProps();
		if(	jrob!=null && jrob.optBoolean("allow_embed_edit",true)==false){
			inlineMode="B";// not allow to do modify in inline area, but can modify in grid
		}
	}
%>
function GridInitObject(){}
GridInitObject.prototype={
	getGridMetadata: function () {return <%=meta.toJSONObject(refbyTable.allowPopup())%>;},
	getGridQueryObj:function(){return <%=q%>;},
	getInlineMode:function(){return "<%=inlineMode%>";},
	getLineCreationLink:function(){ return "<%=creationLink%>";},
	getLinePage:function(){ return "<%=singleObjectPageURL%>";},
	getFixedColumns:function(){ return <%=(new org.json.JSONObject(fixedColumns.toHashMap())).toString()%>;},
	getFixedColumnsStr:function(){return "<%=fixedColumns.toURLQueryString(null)%>"},
	getTableActions:function(){return "<%=tas.toString()%>"; },
	supportAttributeDetail:function(){return <%=table.supportAttributeDetail()%>; }
};

