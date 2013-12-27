<%@ page import="org.json.*" %>
<%
    /**
    included in inc_multiple_object_modify.jsp
     */
final int columnsPerRow=4;  // default Columns Per Row
int tabIndex=10000;
final int maxColumnLength=15;
/**
     support  text(auto)
     */
org.json.JSONArray dcqjsonarraylist=new org.json.JSONArray();
org.json.JSONObject dcqjsonObject=null;
/*
 following class is emtb, for simplicity in css, changed to objtb
*/
%>
<table align="center" border="0" cellpadding="1" cellspacing="1" width="100%" class="emtb">
<%
ArrayList editColumns=table.getColumns(new int[]{Column.MASK_CREATE_EDIT,Column.MASK_MODIFY_EDIT},false,userWeb.getSecurityGrade() ); // not to show uiController
String columnClasses;
int colIdx=-1; // colIdx max to columnsPerRow(equal), each row has (columnsPerRow x 2) <td>;
int widthPerColumn= (int)(100/(columnsPerRow*2));
String columnDomId,columnDomName,colDisplayName;
int maxInputLength;
FKObjectQueryModel fkQueryModel;
TableQueryModel model= new TableQueryModel(tableId, new int[]{Column.MASK_CREATE_EDIT,Column.MASK_MODIFY_EDIT},true,true,locale,userWeb.getSecurityGrade());
ButtonFactory commandFactory= ButtonFactory.getInstance(pageContext,locale);
boolean hideInEditMode;
boolean checkPdtBarcodeOnly=false;
boolean addMatrix=false;
String bindAliasQtyCol="";
for( int i=0;i< editColumns.size();i++){
	colIdx++;
    if(colIdx%columnsPerRow == 0){
       	colIdx=0;
%>        
	<tr>
<%  }   
    Column column=(Column)editColumns.get(i);
    columnDomName="eon_"+ column.getId();
  	columnClasses="";
    if(column.getReferenceTable()!=null) {
        maxInputLength=column.getReferenceTable().getAlternateKey().getLength();
        //columnDomName =columnDomName +"__"+ column.getReferenceTable().getAlternateKey().getName().toLowerCase();
        if(column.getReferenceTable().getAlternateKey().isUpperCase()){
        	columnClasses="ucase";
        }
	    columnDomId="eo_"+ column.getName()+"__"+ column.getReferenceTable().getAlternateKey().getName();
	    hideInEditMode=(column.getJSONProps()!=null&&column.getJSONProps().optBoolean("embed_column_hide",false)==true)||(column.getReferenceTable().getJSONProps()!=null &&
					column.getReferenceTable().getJSONProps().optBoolean("embed_obj_hide",false)==true);
					if(!addMatrix)
			addMatrix=column.getJSONProps()!=null&&column.getJSONProps().optBoolean("matrix_exp",false)==true;
    }else{
    	  if(column.getJSONProps()!=null&&column.getJSONProps().optBoolean("bind_alias",false))
    	  bindAliasQtyCol=column.getName();
        maxInputLength= column.getLength();
        if(column.isUpperCase()){
        	columnClasses="ucase";
        }
        columnDomId="eo_"+ column.getName();
        hideInEditMode=false;
	}
    colDisplayName=  model.getDescriptionForColumn(column);
%>
<%if(!hideInEditMode){%>
<td height="18" width="<%=widthPerColumn*2/3%>%" nowrap align="right" valign='top' class="desc">
<div class="desc-txt<%=(column.isNullable()?"":" nn")%>"  id="lb_<%=columnDomId%>"  > <%=colDisplayName%>:</div>
</td>
<%}else{%>
<span style="display:none"><div id="lb_<%=columnDomId%>"><%=colDisplayName%>:</div></span>
<%}%>
<%if(!hideInEditMode){%>
<td height="18" width="<%=widthPerColumn*4/3%>%" nowrap align="left" valign='top' class="value">
<%}else{%>
	<span style="display:none">
<%}%>
	<div id="tf_<%=columnDomId%>" >
<%
    type= column.getType();
    
    typeIndicator= model.toTypeIndicator(column,columnDomId,locale);
    int inputSize= (column.getStatSize()<=0? maxColumnLength:column.getStatSize());
    values =column.getValues(locale);
    if(values != null){
    // combobox
       Iterator temp = values.keys();
        StringHashtable o = new StringHashtable();
        o.put(PortletUtils.getMessage(pageContext, "combobox-select",null),"0");
        while(temp.hasNext())
        {
            String keyValue = temp.next().toString();
            o.put((String)values.get(keyValue),keyValue.toString());
        }
        java.util.HashMap a = new java.util.HashMap();
        a.put("id",columnDomId);
        a.put("tabIndex", (++tabIndex)+"");
        a.put("onkeypress", "gc.onLineReturn(event, doSaveLine)");
        
        //String defaultValue= (column.getDefaultValue()==null?"0":userWeb.replaceVariables(column.getDefaultValue()));
        String defaultValue=userWeb.getUserOption(column.getName(),column.getDefaultValue() );
        defaultValue= (defaultValue==null?"0":userWeb.replaceVariables(defaultValue));
        
		if(column.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK){
		%>
        <input:checkbox name="<%=columnDomName%>" default="<%=defaultValue%>" value="Y" attributes="<%=a%>" attributesText="class='cbx'"/>
		<%}else{  
			a.put("class", "objsle");
		%>
   		<input:select name="<%=columnDomName%>" default="<%=defaultValue%>" attributes="<%= a %>" options="<%= o %>" />
   		<%}
	}else{// begin for not select
            fixedColumnMark= (fixedColumns.get(new Integer(column.getId())) ==null)?"":"DISABLED";
			isFixedColumn= (fixedColumns.get(new Integer(column.getId())) ==null)?false:true;

            java.util.Hashtable h = new java.util.Hashtable();
            h.put("id",columnDomId);
            h.put("size", String.valueOf(inputSize));
            h.put("maxlength", maxInputLength+"");
            h.put("tabIndex", (++tabIndex)+"");
            //h.put("class","inputline "+ columnClasses); 
            h.put("class", TableQueryModel.getTextInputCssClass(columnsPerRow,column));
			h.put("onkeypress", "gc.onLineReturn(event, doSaveLine)");            
            String defaultValue;
            if(!isFixedColumn) defaultValue=userWeb.replaceVariables(userWeb.getUserOption(column.getName(),column.getDefaultValue()));
            else defaultValue= PortletUtils.getMessage(pageContext, "maintain-by-sys",null);
            
            refTable= column.getReferenceTable();
            if(refTable!=null){		
            	fkQueryModel=new FKObjectQueryModel(false,refTable, columnDomId,column,null);
            	fkQueryModel.setQueryindex(-1);
				if("M_PRODUCT_ID".equals(column.getName())){
            			checkPdtBarcodeOnly= ( column.getJSONProps()!=null?column.getJSONProps().optBoolean("barcode_only"):false);
				}
            	if(column.isAutoComplete() && ( (!"M_PRODUCT_ID".equals(column.getName())) || ("M_PRODUCT_ID".equals(column.getName()) &&!checkPdtBarcodeOnly ))){
            		h.put("onkeydown",fkQueryModel.getKeyEventScript());
	            	dcqjsonObject=new org.json.JSONObject();
					dcqjsonObject.put("column_acc_Id",columnDomId);
					dcqjsonObject.put("tableId",refTable.getId());
					dcqjsonObject.put("columnId",column.getId());
					dcqjsonObject.put("newvalue","");
					dcqjsonObject.put("oldvalue","");
					dcqjsonarraylist.put(dcqjsonObject);
					h.put("autocomplete","off");
				}
			}else{
				fkQueryModel=null;
			}
			if(Validator.isNotNull(column.getRegExpression())){
            	h.put("onchange", column.getRegExpression()+"()");
            }
            if(column.getType()== Column.DATENUMBER){
				h.put("onfocus","WdatePicker()");
			}else if(column.getType()==Column.DATE){
				h.put("onfocus","WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss'})");
			}
            h.put("title", model.getInputBoxIndicator(column,columnDomName,locale));			
    %>
      <input:text name="<%=columnDomName%>" attributes="<%= h %>" default="<%=defaultValue%>"  attributesText="<%=fixedColumnMark%>" /><%= typeIndicator%>
    <%
            if(refTable !=null){
              if(!isFixedColumn){
    %>
    <span id="cbt_<%=columnDomId%>"  onclick="<%=fkQueryModel.getButtonClickEventScript() %>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' title='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
    <script>
    	<%if(Validator.isNotNull(column.getRegExpression())){%>
    		createAction("<%=columnDomId%>", "<%=column.getRegExpression()%>");
    	<%}%>	
    	createButton(document.getElementById("cbt_<%=columnDomId%>"));
	</script>
    <%		  }
            }else{
            	if(column.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_FILE || column.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_IMAGE){
     %>
		<span id="att_<%=columnDomId%>"  onclick="gc.showUploadDlg(<%=column.getId()%>,'<%=columnDomId%>')"><img border=0 width=16 height=16 align=absmiddle src='/html/nds/images/attach.gif' title='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-config" ,null)%>'></span>            	
      	<script>createButton(document.getElementById("att_<%=columnDomId%>"));</script> 	
    <%        	}else{
    %>
    	&nbsp;&nbsp;&nbsp;
   <%			}
   			}
    }// end for not select
%>
</div>
<%if(!hideInEditMode){%>
</td>
<%}else{%>
</span>
<%}%>
<%
   if(colIdx%columnsPerRow == (columnsPerRow -1))out.print("</tr>");
}//end for column iterator
if(colIdx%columnsPerRow != (columnsPerRow -1))out.print("</tr>");

// check product attribute page
// 1:open when found product, 2: default to close, 3: always close
int checkProductAttribute= Tools.getInt(
	((Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS)).
		getProperty("item.product.checkattribute", "1"), 1);
		
String columnMProductId=null,columnMProductAttributeSetInstanceId=null,columnYMaterialId=null;
for( int i=0;i< editColumns.size();i++){
   Column column=(Column)editColumns.get(i);
   Column rfc=column.getReferenceColumn();
  
   if(rfc!=null && rfc.getTable().getName().equals("M_PRODUCT") && rfc.getName().equals("ID")){
		columnMProductId=column.getName()+"__"+  rfc.getTable().getAlternateKey().getName() ;
   }else if(rfc!=null && rfc.getTable().getName().equals("M_ATTRIBUTESETINSTANCE") && rfc.getName().equals("ID")){
   		columnMProductAttributeSetInstanceId=column.getName()+"__"+  rfc.getTable().getAlternateKey().getName() ;
   }
    //edit by robin 20121009 增加是否物料关联字段的判断
   else if(rfc!=null && rfc.getTable().getRealTableName().equals("Y_MATERIAL") && rfc.getName().equals("ID")){
   		columnYMaterialId=column.getName()+"__"+  rfc.getTable().getAlternateKey().getName();
   }
   
}
%>
<tr class="emtbts">
	<td colspan="<%=columnsPerRow*2%>"> 
		<div id="emtbts_lgd"><div id="legend_line"><%= PortletUtils.getMessage(pageContext, "new-line",null)%></div></div>
	 	<div id="emtbts_cks">
	<%if(checkProductAttribute!=3 && columnMProductId!=null){%>
	<input type="checkbox" id="check_product_attribute" name="<%=columnMProductAttributeSetInstanceId%>" value="<%=columnMProductId%>" <%=(checkProductAttribute==1?"checked":"")%> >
	<%=PortletUtils.getMessage(pageContext, "check-attribute",null)+":"+TableManager.getInstance().getTable("M_PRODUCT").getDescription(locale)%>
	<input type="checkbox" id="product_barcode_only" <%=(checkPdtBarcodeOnly?"checked":"")%> disabled>
	<%=PortletUtils.getMessage(pageContext, "check-barcode-only",null)%>
	<%}
	//add by robin 20121009 新增物料模块控制
	
   if(checkProductAttribute!=3 &&columnYMaterialId!=null&&addMatrix){
	%>
	<input type="checkbox" id="check_material_attribute" value="<%=columnYMaterialId%>" <%=(checkProductAttribute==1?"checked":"")%> >
	<%=PortletUtils.getMessage(pageContext, "check-attribute",null)+":"+TableManager.getInstance().getTable("Y_MATERIAL").getDescription(locale)%>
	<input type="checkbox" id="material_barcode_only" <%=(checkPdtBarcodeOnly?"checked":"")%> disabled>
	<%=PortletUtils.getMessage(pageContext, "check-barcode-only",null)%>
	<%}%>
	<!--end-->
	
	<input type="hidden" id="bind_alias_qty_col"  value="<%=bindAliasQtyCol%>"/>
	<input type="checkbox" id="clear_after_insert" name="clear_after_save" checked><%=PortletUtils.getMessage(pageContext, "clear-after-insert",null)%>&nbsp;
	<input type="checkbox" id="quick_save" name="quick_save" <%=(Tools.getYesNo(userWeb.getUserOption("QUICKSAVE","Y"),true)?"checked":"")%>><%=PortletUtils.getMessage(pageContext, "quick-save",null)%>
		</div>
<div id="emtbts_btns">
<table border="0" cellpadding="0" cellspacing="0" ><tr>
<%if(table.isActionEnabled(Table.ADD)){%>	
<td id="btn_newline" class="coolButton" onclick="gc.newLine()"><img src="<%=NDS_PATH%>/images/tb_newline.gif" width="16" height="16" title="<%=PortletUtils.getMessage(pageContext, "new-line",null)%>"></td>
<td id="btn_copyline" class="coolButton" onclick="gc.copyLine()"><img src="<%=NDS_PATH%>/images/bt_copy.gif" width="16" height="16" title="<%=PortletUtils.getMessage(pageContext, "copy-line",null)%>"></td>
<%}
if(table.isMenuObject()){%>
<td id="btn_openobj" class="coolButton" onclick="gc.openLineInNewWindow()"><img src="<%=NDS_PATH%>/images/tb_new_window.gif" width="25" height="16" title="<%=PortletUtils.getMessage(pageContext, "open-in-new-window",null)%>"></td>
<%}
if(table.isActionEnabled(Table.ADD)){%>
<td id="btn_template" class="coolButton" onclick="gc.openLineTemplate()"><img src="<%=NDS_PATH%>/images/tb_template.gif" width="16" height="16" title="<%=PortletUtils.getMessage(pageContext, "object.template",null)%>"></td>
<%}
if(columnMProductId!=null && columnMProductAttributeSetInstanceId!=null){
%>
<td><input type="button" onclick="javascript:gc.turboScan()" value="<%=PortletUtils.getMessage(pageContext, "turbo-scan",null)%>" accesskey="G" class="cbutton"/></td>
<%}%>
<td><%=commandFactory.getButton("SaveLine").toHTML()%></td>
<%if(table.isActionEnabled(Table.DELETE)){%>
<td>&nbsp;<%=commandFactory.getButton("DeleteLine").toHTML()%></td>
<%}%>
<script>
	if(document.getElementById("btn_openobj")!=null)createButton(document.getElementById("btn_openobj"));
	<%if(table.isActionEnabled(Table.ADD)){%>
	createButton(document.getElementById("btn_template"));
	createButton(document.getElementById("btn_newline"));
	createButton(document.getElementById("btn_copyline"));
	<%}%>
</script>
</tr></table>
</div>
</td></tr>
</table>
<table><tr><td>
	  <script>
	  	 	jQuery(document).ready(function(){dcq.createdynlist(<%=dcqjsonarraylist%>);});
	  </script>
</td></tr></table>
