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
    <td>
    <%@ include file="inc_multiple_object_quicksearch.jsp" %>
    </td>
    <td>
    <%@ include file="inc_multiple_object_tabbuttons.jsp" %>
    </td>
  </tr>
</table>
<%
 String divEmbedItemId;
 if(table.getName().endsWith("ITEM")) divEmbedItemId="embed-items";
 else divEmbedItemId="embed-items-short";
%>
<!--div class="<%=divEmbedItemId%>" id="embed-items" style="width:902px;"-->
<div class="<%=divEmbedItemId%>" id="embed-items" style="width:100%">
<!--table id="modify_table" style="width:100%" border="1" cellspacing="0" cellpadding="0"  align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFFFFF"-->
<table class="modify_table" id="modify_table">
	<thead><tr id="titletr">
  	<td nowrap align='center'><%=PortletUtils.getMessage(pageContext, "rowindex",null)%></td>
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

//caculate percentage of each column size in table
int[] colSizes=new int[columns.size()];
boolean[] alignRight=new boolean[columns.size()];
int sizeAll=0;
for(int i=0;i< columns.size();i++){
	col=(Column)columns.get(i);
	alignRight[i]= ( col.getType()==Column.NUMBER && col.getReferenceTable()==null && (!col.isValueLimited()));
	isModifiable=isModify /*&& col.isMaskSet(Column.MASK_CREATE_EDIT)*/&&col.isMaskSet(Column.MASK_MODIFY_EDIT);
	colWidth=15;
	if(col.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK) colWidth=5;
	if(!isModifiable){
		colWidth= col.isColumnLink()? col.getColumnLink().getLastColumn().getLength(): col.getLength();
		if(colWidth>15) colWidth=15;
	}else{
		colWidth=(( col.getStatSize()<=0)? 15:col.getStatSize());
	}
	colSizes[i]=colWidth;
	sizeAll+=colWidth;
}
for(int i=0;i<colSizes.length;i++){
	colSizes[i]=(int)( colSizes[i] * 100 / sizeAll);
	if(colSizes[i]==0)colSizes[i]=1;
}
ColumnLink clink;String ordName=null;
for(int i=0;i< columns.size();i++){
	col=(Column)columns.get(i);
	clink=new ColumnLink(new int[]{col.getId()});
	ordName=clink.toHTMLString();
	if(col.getReferenceTable()!=null){
		col2=col.getReferenceTable().getAlternateKey();
		colName=col.getName()+"__"+ col2.getName();	
		maxLength=col2.getLength();
		type= col2.getType();
		ordName=ordName+";"+ col2.getName();
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
	isModifiable=isModify /*&& col.isMaskSet(Column.MASK_CREATE_EDIT)*/&&col.isMaskSet(Column.MASK_MODIFY_EDIT);
	if(!isModifiable){
		colWidth= col.isColumnLink()? col.getColumnLink().getLastColumn().getLength(): col.getLength();
		if(colWidth>30) colWidth=30;
	}
	
 %>
  <td nowrap align='center' onClick="javascript:gc.orderGrid2('<%=ordName%>',event)">
    <span><span id="title_<%=ordName%>" class="odr"></span>
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
  	<td nowrap ><span id="row"></span><span id="errmsg"></span><span id="state__"></span><span id="jsonobj"></span></td>
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
	isModifiable=isModify /*&& col.isMaskSet(Column.MASK_CREATE_EDIT)*/&&col.isMaskSet(Column.MASK_MODIFY_EDIT);
	colWidth=15;
	if(col.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK) colWidth=5;
	if(!isModifiable){
		colWidth= col.isColumnLink()? col.getColumnLink().getLastColumn().getLength(): col.getLength();
		if(colWidth>15) colWidth=15;
	}else{
		colWidth=(( col.getStatSize()<=0)? 15:col.getStatSize());
	}
	isFixedColumn= (fixedColumns.get(new Integer(col.getId())) ==null)?false:true;
%>
<td   <%=(alignRight[i]?"align='right'":"")%>>
	<%if(refTable!=null && !isFixedColumn){
		// hold img link, if column is fk, and not fixed, and can popup(menuItem)
	%>
		<span id="<%=cId%>_url" >&nbsp;</span>
	<%}
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
		   		
				fixedColumnMark= isFixedColumn?"DISABLED":"";
           		java.util.Hashtable h = new java.util.Hashtable();
           		h.put("size", colWidth+"");
           		h.put("maxlength", maxLength+"");
           		h.put("id",cId);
           		h.put("onchange", "gc.cellChanged(event)");
           		h.put("onkeydown", "gc.moveTableFocus(event)");
           		//h.put("tabIndex", (++tabIndex)+"");
           		if(refTable!=null){
           			h.put("onfocus","gc.fkfocus(event)");
           		}
           		if((refTable!=null &&refTable.getAlternateKey().isUpperCase())||
								col.isUpperCase()){
					h.put("class","inputline ucase"+ (isFixedColumn?" disabled":"")+ (alignRight[i]?" num":""));
				}else
					h.put("class","inputline"+ (isFixedColumn?" disabled":"")+ (alignRight[i]?" num":""));
                       		
                %>
<input:text name="<%=cId%>" attributes="<%=h %>" attributesText="<%=fixedColumnMark%>" />
          	<% if(refTable!=null){%>
			<span id="<%=cId%>_find" class="hide mid"></span><%}else{%>
			<%}
          }//end getObjectType!=DisplaySetting.OBJ_FILE ||OBJ_IMAGE
            else{// getObjectType==DisplaySetting.OBJ_FILE || OBJ_IMAGE
          %>
          <span id="<%=cId%>"></span>
		  <%}
         }// end rsColumns[i].isModifiable(Column.MODIFY))
         else{
         	%>
<span id="<%=cId%>"></span>
         <%}
	}%></td>
    <%
}//for
    %></tr>
  </tbody>
</table>
<!--br-->
</div> <!-- embed-items-->
<%
if(isModify && refbyTable!=null){
	//System.out.print(refbyTable.getInlineMode());
	if("Y".equals(refbyTable.getInlineMode())){
	//System.out.print("mode Y");
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
	<%}else if("A".equals(refbyTable.getInlineMode())){
		// if only  modify allowed(no add/delete) will not display this table
		//System.out.print("mode YA");
		String tbDisplay;
		if(!table.isActionEnabled(Table.DELETE) && !table.isActionEnabled(Table.ADD) ){
			tbDisplay="style='display:none'";
		}else{
			tbDisplay="";
		}
%>
	<div id="inc-edit-line" <%=tbDisplay%>>
	<%@ include file="inc_edit_object_add.jsp" %>
	</div>
	<%}else if("N".equals(refbyTable.getInlineMode())){%>
	<div id="inc-line-buttons">
	<%@ include file="inc_multiple_object_buttons.jsp" %>
	</div>
	<%}else if("B".equals(refbyTable.getInlineMode())){%>   
	<div id="inc-edit-line">
	<%@ include file="inc_edit_object_product_only.jsp" %>
	</div>
<%  }
}
%>
<form id="export_form" method="post" action="<%=request.getContextPath()+"/servlets/QueryInputHandler"%>">
	<input type="hidden" id="resulthandler" name="resulthandler" value="<%=NDS_PATH%>/reports/create_report.jsp">
    <input type='hidden' id="query_json" name="query_json" value="">
</form>

