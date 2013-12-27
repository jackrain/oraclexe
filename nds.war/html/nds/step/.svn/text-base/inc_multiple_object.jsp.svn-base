<%
    /**
     *  Modify page of object list
     *  included by multiple_object_modify.jsp
     */
 %>
 <table border="0" width="98%">
  <tr>
    <td nowrap>
    <%@ include file="inc_multiple_object_scroll.jsp" %>
    </td>
  </tr>
</table>
<%
 String divEmbedItemId;
 if(table.getName().endsWith("ITEM")) divEmbedItemId="embed-items";
 else divEmbedItemId="embed-items-short";
%>
<div class="<%=divEmbedItemId%>" id="embed-items">
<table id="modify_table" width="100%" border="1" cellspacing="0" cellpadding="0"  align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFFFFF">
	<thead><tr>
  	<td nowrap align='center' width="70"><%=PortletUtils.getMessage(pageContext, "rowindex",null)%></td>
<%
ArrayList columns=table.getColumns(meta.ITEM_COLUMN_MASKS,false,userWeb.getSecurityGrade() );
int colWidth=15,maxLength=10;
String cid;
PairTable values;
String colName,cId;
boolean isModifiable;
Column col,col2;
int type;
String typeIndicator;
Table refTable;
String fixedColumnMark;
boolean isFixedColumn;

for(int i=0;i< columns.size();i++){
	col=(Column)columns.get(i);
	if(col.getReferenceTable()!=null){
		col2=col.getReferenceTable().getAlternateKey();
		colName=col.getName()+"__"+ col2.getName();	
		maxLength=col2.getLength();
		type= col2.getType();
	}else{
		colName=col.getName();
		maxLength=col.getLength();
		type= col.getType();
	}
	cId= colName;            
    typeIndicator="";// nds.query.web.TableQueryModel.toTypeIndicator(type,locale);
	colWidth=15;
	if(col.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK) colWidth=5;
	// for other columns that are modifiable in both creation form and modification form
	isModifiable=isModify && col.isMaskSet(Column.MASK_CREATE_EDIT)&&col.isMaskSet(Column.MASK_MODIFY_EDIT);
	if(!isModifiable){
		colWidth= col.isColumnLink()? col.getColumnLink().getLastColumn().getLength(): col.getLength();
		if(colWidth>30) colWidth=30;
	}
 %>
  <td nowrap align='center'>
    <span onClick="javascript:gc.orderGrid(<%=col.getId()%>)"><span id="title_<%=col.getId()%>"></span>
    	<%=col.getDescription(locale)%><%= typeIndicator%>
    </span>
  </td>
<%
}//for(int i=0;i< meta.getColumnCount();i++)
%>
  </tr>
 </thead>
 <tbody id="grid_table">
   <tr id="templaterow" style="display:none;">
  	<td width="70" nowrap><span id="row"></span><span id="errmsg"></span><span id="state__"></span><span id="jsonobj"></span></td>
<%
for(int i=0;i< columns.size();i++){
	col=(Column)columns.get(i);
	refTable=col.getReferenceTable();
	if(col.getReferenceTable()!=null){
		col2=col.getReferenceTable().getAlternateKey();
		colName=col.getName()+"__"+ col2.getName();	
		maxLength=col2.getLength();
		
	}else{
		colName=col.getName();
		maxLength=col.getLength();
	}
	cId= colName; 
	isModifiable=isModify && col.isMaskSet(Column.MASK_CREATE_EDIT)&&col.isMaskSet(Column.MASK_MODIFY_EDIT);
	colWidth=15;
	if(col.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK) colWidth=5;
	if(!isModifiable){
		colWidth= col.isColumnLink()? col.getColumnLink().getLastColumn().getLength(): col.getLength();
		if(colWidth>15) colWidth=15;
	}else{
		colWidth=(( col.getStatSize()<=0)? 15:col.getStatSize());
	}
%>
<td width="<%=colWidth%>%">
	<%
	values= col.getValues(locale);
	if(values != null){// combox or check
	    String columnDataValue = "0";
	    StringHashtable o = new StringHashtable();
	    o.put(PortletUtils.getMessage(pageContext, "combobox-select",null),"0");
	    Iterator i1 = values.keys();
	    Iterator i2 = values.values();
	    String valueDesc="&nbsp;";
	    while(i1.hasNext() && i2.hasNext()){
	        o.put(String.valueOf(i2.next()),String.valueOf(i1.next()));
	    }
	    java.util.HashMap a = new java.util.HashMap();
	    
	    a.put("id",cId);
	    //a.put("tabIndex", (++tabIndex)+"");
	    a.put("onchange", "gc.cellChanged(event)");
	    a.put("onkeydown", "gc.moveTableFocus(event)");
        if(col.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK){
	 	%>
<input type="checkbox" id="<%=cId%>" value="Y" onchange="gc.cellChanged(event)" class="cbx" <%=isModifiable?"":"DISABLED"%> />
       <%}else{%>
<input:select name="<%=cId%>" default="<%=columnDataValue%>" attributes="<%= a %>" options="<%= o %>" attributesText="<%=isModifiable?"":"DISABLED"%>" />
		<%}
	}// end if(value != null)
    else{
         // virtual column should not be modifiable
       	if(isModifiable){
          if(col.getDisplaySetting().getObjectType()!=DisplaySetting.OBJ_FILE
			          	&& col.getDisplaySetting().getObjectType()!=DisplaySetting.OBJ_IMAGE
			          	&& col.getDisplaySetting().getObjectType()!=DisplaySetting.OBJ_XML){
		   		isFixedColumn= (fixedColumns.get(new Integer(col.getId())) ==null)?false:true;
				fixedColumnMark= isFixedColumn?"DISABLED":"";
           		java.util.Hashtable h = new java.util.Hashtable();
           		h.put("size", colWidth+"");
           		h.put("maxlength", maxLength+"");
           		h.put("id",cId);
           		h.put("onchange", "gc.cellChanged(event)");
           		h.put("onkeydown", "gc.moveTableFocus(event)");
           		//h.put("tabIndex", (++tabIndex)+"");
           		if((refTable!=null &&refTable.getAlternateKey().isUpperCase())||
								col.isUpperCase()){
					h.put("class","inputline ucase"+ (isFixedColumn?" disabled":""));
				}else
					h.put("class","inputline"+ (isFixedColumn?" disabled":""));
                       		
                %>
<input:text name="<%=cId%>" attributes="<%=h %>" attributesText="<%=fixedColumnMark%>" />
          <%}//end getObjectType!=DisplaySetting.OBJ_FILE ||OBJ_IMAGE
            else{// getObjectType==DisplaySetting.OBJ_FILE || OBJ_IMAGE
          %>
          <span id="<%=cId%>"></span>
		  <%}
         }// end rsColumns[i].isModifiable(Column.MODIFY))
         else{%>
<span id="<%=cId%>"></span>
         <%}
	}%>
    &nbsp;&nbsp;</td>
    <%
}//for
    %>
  </tr>
  </tbody>
</table>
<br>
</div> <!-- embed-items-->
<%
if(isModify && refbyTable!=null){
	if("Y".equals(refbyTable.getInlineMode())){
		// if only  modify allowed(no add/delete) will not display this table
		String tbDisplay;
		if(!table.isActionEnabled(Table.DELETE) && !table.isActionEnabled(Table.ADD) ){
			tbDisplay="style='display:none'";
		}else{
			tbDisplay="";
		}
%>
	<div id="inc-edit-line" <%=tbDisplay%>>
	<%@ include file="inc_edit_object.jsp" %>
	</div>
	<%}else if("N".equals(refbyTable.getInlineMode())){%>
	<div id="inc-line-buttons">
	<%@ include file="inc_multiple_object_buttons.jsp" %>
	</div>
	<%}else if("B".equals(refbyTable.getInlineMode())){%>   
	<div id="inc-edit-line">
	<%@ include file="inc_edit_object_product_only.jsp" %>
	</div>
<% 
}}%>
<form id="export_form" method="post" action="<%=request.getContextPath()+"/servlets/QueryInputHandler"%>">
	<input type="hidden" id="resulthandler" name="resulthandler" value="<%=NDS_PATH%>/reports/create_report.jsp">
    <input type='hidden' id="query_json" name="query_json" value="">
</form>

