<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*" %>
<%
    /**
    do scan only for quick input, embed into object.jsp
    @param table - item table id
    @param fixedcolumns - string for fixed columns
     */
TableManager manager=TableManager.getInstance();
int tableId=Tools.getInt( request.getParameter("table"),-1);
if(tableId==-1) throw new NDSException("table not found:"+request.getParameter("table"));
Table table= manager.getTable(tableId);
if(!table.isActionEnabled(Table.ADD))throw new NDSException("table not support add:"+request.getParameter("table"));
PairTable fixedColumns= PairTable.parseIntTable(request.getParameter("fixedcolumns"),null );
int tabIndex=20000;
final int maxColumnLength=15;
int columnsPerRow=4;
nds.util.PairTable values;
int type;
String fixedColumnMark;
boolean isFixedColumn;
Table refTable;
%>
<div id="turboscan_div">
<div id="ts_info">
<%=PortletUtils.getMessage(pageContext, "turbo-scan-info",null)%>
</div>
<table align="center" border="0" cellpadding="1" cellspacing="1" width="100%" class="emtb">
<tr>
<%

ArrayList editColumns=table.getColumns(new int[]{Column.MASK_CREATE_EDIT},false,userWeb.getSecurityGrade() ); // not to show uiController
String columnClasses;
int colIdx=-1; // colIdx max to columnsPerRow(equal), each row has (columnsPerRow x 2) <td>;
int widthPerColumn= (int)(100/(columnsPerRow*2));
String columnDomId,columnDomName,colDisplayName;
boolean hideInEditMode;
int maxInputLength;
FKObjectQueryModel fkQueryModel;
TableQueryModel model= new TableQueryModel(tableId, new int[]{Column.MASK_CREATE_EDIT},true,true,locale,userWeb.getSecurityGrade());
String typeIndicator;
for( int i=0;i< editColumns.size();i++){
	colIdx++;
    Column column=(Column)editColumns.get(i);
    columnDomName="son_"+ column.getId();
  	columnClasses="";
    if(column.getReferenceTable()!=null) {
        maxInputLength=column.getReferenceTable().getAlternateKey().getLength();
        //columnDomName =columnDomName +"__"+ column.getReferenceTable().getAlternateKey().getName().toLowerCase();
        if(column.getReferenceTable().getAlternateKey().isUpperCase()){
        	columnClasses="ucase";
        }
	    columnDomId="so_"+ column.getName()+"__"+ column.getReferenceTable().getAlternateKey().getName();
	    hideInEditMode=(column.getReferenceTable().getJSONProps()!=null &&
					column.getReferenceTable().getJSONProps().optBoolean("embed_obj_hide",false)==true);
    }else{
        maxInputLength= column.getLength();
        if(column.isUpperCase()){
        	columnClasses="ucase";
        }
        columnDomId="so_"+ column.getName();
        hideInEditMode=false;
	}
    colDisplayName=  model.getDescriptionForColumn(column);
%>
<td height="18" width="<%=widthPerColumn*2/3%>%" nowrap align="right" valign='top' class="desc">
<div id="lb_<%=columnDomId%>" class="desc-txt<%=column.isNullable()?"":" nn"%>" <%=hideInEditMode?"style='display:none'":""%>> <%=colDisplayName%>:</div>
</td>
<td height="18" width="<%=widthPerColumn*4/3%>%" nowrap align="left" valign='top' class="value"><div id="tf_<%=columnDomId%>" <%=hideInEditMode?"style='display:none'":""%>>
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
        a.put("onkeydown", "gc.onScanReturn(event)");
        
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
			//System.out.print("aaaaaaa");
            java.util.Hashtable h = new java.util.Hashtable();
            h.put("id",columnDomId);
            h.put("size", String.valueOf(inputSize));
            h.put("maxlength", maxInputLength+"");
            h.put("tabIndex", (++tabIndex)+"");
            //h.put("class","inputline "+ columnClasses); 
            h.put("class", TableQueryModel.getTextInputCssClass(columnsPerRow,column));
			h.put("onkeydown", "gc.onScanReturn(event)");            
            String defaultValue;
            if(!isFixedColumn) defaultValue=userWeb.replaceVariables(userWeb.getUserOption(column.getName(),column.getDefaultValue()));
			else defaultValue= PortletUtils.getMessage(pageContext, "maintain-by-sys",null);
			refTable= column.getReferenceTable();
			if(refTable!=null&&!"M_PRODUCT_ID".equals(column.getName())){
            	fkQueryModel=new FKObjectQueryModel(false,refTable, columnDomId,column,null);
            	fkQueryModel.setQueryindex(-1);
			}else{
				fkQueryModel=null;
			}
    %>
      <input:text name="<%=columnDomName%>" attributes="<%= h %>" default="<%=defaultValue%>"  attributesText="<%=fixedColumnMark%>" /><%= typeIndicator%>
	  <%
	  if(refTable !=null&&!"M_PRODUCT_ID".equals(column.getName())){
	  if(!isFixedColumn){%>
    <span id="cbt_<%=columnDomId%>"  onclick="<%=fkQueryModel.getButtonClickEventScript() %>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' title='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
    <script>
    	<%if(Validator.isNotNull(column.getRegExpression())){%>
    		createAction("<%=columnDomId%>", "<%=column.getRegExpression()%>");
    	<%}%>
    	createButton(document.getElementById("cbt_<%=columnDomId%>"));
	</script>
	<%		}}
	}// end for not select
	%>
</div>
</td>
<%
}//end for column iterator
%>
</tr>
</table>
<div id="ts_sum">
	<div id="ts_desc"><%=PortletUtils.getMessage(pageContext, "scan-sum",null)%>:<span id="ts_qty">0</span></div>
	<div id="ts_close"><input type="button" onclick="javascript:gc.closeTurboScan()" value="<%=PortletUtils.getMessage(pageContext, "close-turbo-scan",null)%>" accesskey="G" class="cbutton"/></div>
</div>
<fieldset id="ts_output">
  <legend><%=PortletUtils.getMessage(pageContext, "turbo-scan-log",null)%></legend>
<div id="ts_whole">
	<span id="tsrow_0" class="tsrow">
</div>
</fieldset>
</div>