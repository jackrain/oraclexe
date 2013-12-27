<%@ page import="org.json.*" %>
<%
/**
included in inc_multiple_object_modify.jsp, only show product and qty column
*/
final int columnsPerRow=4;  // default Columns Per Row
int tabIndex=10000;
final int maxColumnLength=25;
/**
     support  text(auto)
*/
org.json.JSONArray dcqjson_product_arraylist=new org.json.JSONArray();
org.json.JSONObject dcqjsonObject_product=null;

/*
 following class is emtb, for simplicity in css, changed to objtb
*/
%>
<table align="center" border="0" cellpadding="1" cellspacing="1" width="100%" class="emtb">
<%
ArrayList editColumns=new ArrayList();//table.getColumns(new int[]{Column.MASK_CREATE_EDIT,Column.MASK_MODIFY_EDIT},false ); // not to show uiController
Column editColumn= table.getColumn("m_product_id");
if(editColumn==null) throw new NDSException("Internal Error: column named m_product_id not found in table "+ table);
editColumns.add(editColumn);
ArrayList allcolumns=table.getColumns(new int[]{0,1},false,userWeb.getSecurityGrade());
editColumn=null;
for(int i=0;i< allcolumns.size();i++){
	if( ((Column)allcolumns.get(i)).getName().indexOf("QTY")>-1){
		editColumn=(Column)allcolumns.get(i);
		break;
	}
}
if(editColumn==null) throw new NDSException("Internal Error: column named qty not found in table "+ table);
editColumns.add(editColumn);

String columnClasses;
int colIdx=-1; // colIdx max to columnsPerRow(equal), each row has (columnsPerRow x 2) <td>;
int widthPerColumn= (int)(100/(columnsPerRow*2));
String columnDomId,columnDomName,colDisplayName;
int maxInputLength;
FKObjectQueryModel fkQueryModel;
TableQueryModel model= new TableQueryModel(tableId, new int[]{Column.MASK_CREATE_EDIT,Column.MASK_MODIFY_EDIT},true,true,locale,userWeb.getSecurityGrade());
ButtonFactory commandFactory= ButtonFactory.getInstance(pageContext,locale);

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
    }else{
        maxInputLength= column.getLength();
        if(column.isUpperCase()){
        	columnClasses="ucase";
        }
        columnDomId="eo_"+ column.getName();
	}
    colDisplayName=  model.getDescriptionForColumn(column);
%>
<td height="18" width="<%=widthPerColumn*2/3%>%" nowrap align="right" valign='top' class="desc">
<div id="lb_<%=columnDomId%>" class="desc-txt<%=column.isNullable()?"":" nn"%>"> <%=colDisplayName%>:</div>
</td>
<td height="18" width="<%=widthPerColumn*4/3%>%" nowrap align="left" valign='top' class="value">
	<div id="tf_<%=columnDomId%>">
<%
    type= column.getType();
    
    typeIndicator= model.toTypeIndicator(column,columnDomName,locale);
    int inputSize=(column.getReferenceTable()==null?10:maxColumnLength );
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
			//h.put("onfocus", "oc.findstoreId()");
            String defaultValue;
            if(!isFixedColumn) defaultValue=userWeb.replaceVariables(userWeb.getUserOption(column.getName(),column.getDefaultValue()));
            else defaultValue= PortletUtils.getMessage(pageContext, "maintain-by-sys",null);
            
            refTable= column.getReferenceTable();
            if(refTable!=null){		
            	fkQueryModel=new FKObjectQueryModel(false,refTable,columnDomId,column,null);
            	fkQueryModel.setQueryindex(-1);
            	h.put("onkeydown",fkQueryModel.getKeyEventScript());
            	dcqjsonObject_product=new org.json.JSONObject();
				dcqjsonObject_product.put("column_acc_Id",columnDomId);
				dcqjsonObject_product.put("tableId",refTable.getId());
				dcqjsonObject_product.put("columnId",column.getId());
				dcqjsonObject_product.put("newvalue","");
				dcqjsonObject_product.put("oldvalue","");
				dcqjson_product_arraylist.put(dcqjsonObject_product);
				h.put("autocomplete","off");
			}else{
				fkQueryModel=null;
			}
    %>
      <input:text name="<%=columnDomName%>" attributes="<%= h %>" default="<%=defaultValue%>"  attributesText="<%=fixedColumnMark%>" /><%= typeIndicator%>
    <%
            if(refTable !=null){
              if(!isFixedColumn){
    %>
    <span id="cbt_<%=columnDomId%>"  onclick="<%=fkQueryModel.getButtonClickEventScript() %>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' title='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
    <script>createButton(document.getElementById("cbt_<%=columnDomId%>"));</script>	
    <%		  }
            }else{
    %>
    	&nbsp;&nbsp;&nbsp;
   <%		}
    }// end for not select
%>
</div>
</td>
<%
}
// check product attribute page
// 1:open when found product, 2: default to close, 3: always close
int checkProductAttribute= 1;
String columnMProductId=null,columnMProductAttributeSetInstanceId=null;
editColumn= table.getColumn("m_product_id");
columnMProductId= editColumn.getName()+"__"+  editColumn.getReferenceColumn().getTable().getAlternateKey().getName() ;
editColumn= table.getColumn("M_ATTRIBUTESETINSTANCE_ID");
columnMProductAttributeSetInstanceId= editColumn.getName()+"__"+  editColumn.getReferenceColumn().getTable().getAlternateKey().getName();

boolean quickSave=Tools.getYesNo(userWeb.getUserOption("QUICKSAVE","Y"),true);
%>
	<td align="left">
		<input type="checkbox" id="quick_save" name="quick_save" <%=(quickSave?"checked":"")%>><%=PortletUtils.getMessage(pageContext, "quick-save",null)%> &nbsp;&nbsp;
		<input class="cbutton" type="button" accesskey="L" value="<%=PortletUtils.getMessage(pageContext, "command.ok",null)%>(L)"  onclick="javascript:doSaveLine()">
	<%if(table.isActionEnabled(Table.DELETE)){%>
	&nbsp;&nbsp;&nbsp;<%=commandFactory.newButtonInstance("DeleteLine", PortletUtils.getMessage(pageContext, "command.deleteline",null),"doDeleteLine()", "E").toHTML()%>
	<%}%>
	 <%/*<input type="hidden" id="c_store_product_id" name="c_store_product_id" value="">
	 <input type="hidden" id="c_store_product_data" name="c_store_product_data" value="">
	  <input type="hidden" id="c_dest_product_id" name="c_dest_product_id" value="">
	 <input type="hidden" id="c_dest_product_data" name="c_dest_product_data" value="">*/%>
	</td>
<td>
<div id="emtbts_lgd" style="display:none;"><div id="legend_line"><%= PortletUtils.getMessage(pageContext, "new-line",null)%></div></div>
<div id="emtbts_cks" style="display:none;">
	<input checked type="checkbox" id="check_product_attribute" name="<%=columnMProductAttributeSetInstanceId%>" value="<%=columnMProductId%>">
	<%=PortletUtils.getMessage(pageContext, "check-attribute",null)+":"+TableManager.getInstance().getTable("M_PRODUCT").getDescription(locale)%>
	<input checked type="checkbox" id="clear_after_insert" name="clear_after_save"><%=PortletUtils.getMessage(pageContext, "clear-after-insert",null)%>
	<input type="hidden" id="eo_<%=columnMProductAttributeSetInstanceId%>" value="">
</div>
</td>
</tr></table>
<table><tr><td>
	  <script>
	  	 	jQuery(document).ready(function(){dcq.createdynlist(<%=dcqjson_product_arraylist%>)});
	  </script>
</td></tr></table>