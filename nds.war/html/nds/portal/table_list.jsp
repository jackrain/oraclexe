<style type="text/css">
.dTable{height:500px;overflow:auto;}
</style>
<form id="fm_list">
<!--div id="embed-lines" style="width:1106px;"--> 
<div id="embed-lines"> 
<!--div style=" height: 100px; overflow:scroll;" id="div1"-->
<table id="inc_table" class="sort-table" style="width:100%">
	<thead><tr id="titletr">
  	<td nowrap align='center' width="40"><%=PortletUtils.getMessage(pageContext, "rowindex",null)%></td>
<%
List<ColumnLink> columns=qlc.getSelections(userWeb.getSecurityGrade());
int colWidth=15,maxLength=10;
String cid;
PairTable values;
String colName,cId,cIdInput;
String pdesc=new String();
boolean isModifiable;
Column col,col2;
int type;
//String typeIndicator;
Table refTable;
String fixedColumnMark;
boolean isFixedColumn;
ColumnLink clink;String ordName;
for(int i=0;i< columns.size();i++){
	clink=columns.get(i);
	col=(Column)clink.getLastColumn();
	cId= clink.toHTMLString();            
	if(col.getReferenceTable()!=null){
		col2=col.getReferenceTable().getAlternateKey();
		colName=cId+"__"+ col2.getName();
		maxLength=col2.getLength();
		type= col2.getType();
		ordName=cId+";"+ col2.getName();
	}else{
		colName=cId;
		maxLength=col.getLength();
		type= col.getType();
		ordName=cId;
	}
    //typeIndicator= nds.query.web.TableQueryModel.toTypeIndicator(type,locale);
	colWidth=15;
	if(col.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK) colWidth=5;
	// for other columns that are modifiable in both creation form and modification form
	isModifiable= isModify &&( clink.length()==1)&&  col.isMaskSet(Column.MASK_MODIFY_EDIT);
	if(!isModifiable){
		colWidth=maxLength;
		if(colWidth>30) colWidth=30;
	}
	pdesc=clink.getDescription(locale);
	if(col.getJSONProps()!=null){
	JSONObject jor=col.getJSONProps();
	if(jor.has("reflable")){
   	 JSONObject jo=col.getJSONProps().getJSONObject("reflable");
   	 int lable_id=jo.optInt("ref_id",0);
		 int lable_tabid=jo.optInt("tabid",0);
		 Table reftable= TableManager.getInstance().getTable(lable_tabid);
		 QueryRequestImpl query=QueryEngine.getInstance().createRequest(userWeb.getSession());
		 query.setMainTable(lable_tabid);
		 query.addSelection(reftable.getAlternateKey().getId());
		 query.addParam( reftable.getPrimaryKey().getId(), ""+ lable_id);
	   QueryResult rs=QueryEngine.getInstance().doQuery(query); 
	   if(lable_id !=0 || (rs!=null && rs.getTotalRowCount()>0)){
	    while(rs.next()) {
	       pdesc=rs.getObject(1).toString(); 
	       //System.out.print(pdesc);
	      }
	    }
		}
	}
 %>
  <td nowrap align='center' onClick="javascript:pc.orderGrid2('<%=ordName%>',event)">
    <span><span id="title_<%=ordName%>" class="odr"></span>
    	<%=pdesc%>
    </span>
  </td>
<%
}//for columns(selections)
%>
  </tr>
 </thead><!--$GRIDTABLE_START-->
<!--/table>
<div class="dTable">
<table-->
<tbody id="grid_table"></tbody><!--$GRIDTABLE_END-->
 <tfoot>
   <tr id="templaterow" style="display:none;">
  	<td width="70" nowrap><span id="row"></span><span id="errmsg"></span><span id="state__"></span></td>
  	
<%
for(int i=0;i< columns.size();i++){
	clink=columns.get(i);
	col=(Column)clink.getLastColumn();
	refTable=col.getReferenceTable();
	cId= clink.toHTMLString(); 
	if(refTable!=null){
		col2=refTable.getAlternateKey();
		colName=cId+"__"+ col2.getName();	
		cIdInput=col.getName()+"__"+ col2.getName();
		maxLength=col2.getLength();
		colWidth= col2.getStatSize();
		type= col2.getType();
	}else{
		colName=cId;
		cIdInput=col.getName();
		maxLength=col.getLength();
		colWidth= col.getStatSize();
		type= col.getType();
	}
	isModifiable=isModify &&( clink.length()==1)&& col.isMaskSet(Column.MASK_MODIFY_EDIT);
	if(colWidth<=0) colWidth=15;
	if(col.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK) colWidth=5;
%>
<td <%=(!isModifiable&& type==Column.NUMBER?"align='right'":"")%> nowrap>
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
	    
	    a.put("id",cIdInput);
	    //a.put("tabIndex", (++tabIndex)+"");
	    a.put("onchange", "pc.cellChanged(event)");
	    a.put("onkeydown", "pc.moveTableFocus(event)");
        if(col.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK){
	 	%>
<input type="checkbox" id="<%=cIdInput%>" value="Y" onchange="pc.cellChanged(event)" class="cbx" <%=isModifiable?"":"DISABLED"%> />
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
           		h.put("id",cIdInput);
           		h.put("onchange", "pc.cellChanged(event)");
           		h.put("onkeydown", "pc.moveTableFocus(event)");
           		//h.put("tabIndex", (++tabIndex)+"");
           		if((refTable!=null &&refTable.getAlternateKey().isUpperCase())||
								col.isUpperCase()){
					h.put("class","inputline ucase"+ (isFixedColumn?" disabled":""));
				}else{
					h.put("class","inputline"+ (isFixedColumn?" disabled":""));
                }       		
                %>
<input:text name="<%=cIdInput%>" attributes="<%=h %>" attributesText="<%=fixedColumnMark%>" />
<%if(refTable!=null){%>
<span id="fk<%=cId%>"></span>
<%}
          }//end getObjectType!=DisplaySetting.OBJ_FILE ||OBJ_IMAGE
            else{// getObjectType==DisplaySetting.OBJ_FILE || OBJ_IMAGE
          %>
          <span id="<%=cIdInput%>"></span>
		  <%}
         }// modifiable
         else{%>
<span id="<%=cIdInput%>"></span>
         <%}
	}%>
    &nbsp;</td>
    <%
}//for
    %>
  </tr><!--templaterow-->
<%
/*
 in following view-only template row, "$" in id will be removed so will concord with previous modifiable row
*/
%>  
  <tr id="$templaterow" style="display:none;">
  	<td width="70" nowrap><span id="$row"></span><span id="$errmsg"></span><span id="$state__"></span></td>
<%
for(int i=0;i< columns.size();i++){
	clink=columns.get(i);
	col=(Column)clink.getLastColumn();
	refTable=col.getReferenceTable();
	if(col.getReferenceTable()!=null){
		col2=col.getReferenceTable().getAlternateKey();
		colName=col.getName()+"__"+ col2.getName();	
		cIdInput=col.getName()+"__"+ col2.getName();
		maxLength=col2.getLength();
		colWidth= col2.getStatSize();
		type= col2.getType();
	}else{
		colName=col.getName();
		cIdInput=col.getName();
		maxLength=col.getLength();
		colWidth= col.getStatSize();
		type= col.getType();
	}
	cId= colName; 
	isModifiable=false;
	if(colWidth<=0) colWidth=15;
	//colWidth=colWidth>20? 20:colWidth;
	if(col.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK) colWidth=5;
%>
<td <%=(!isModifiable&& type==Column.NUMBER?"align='right'":"")%> nowrap>
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
	    
	    a.put("id","$"+cIdInput);
	    //a.put("tabIndex", (++tabIndex)+"");
	    a.put("onchange", "pc.cellChanged(event)");
	    a.put("onkeydown", "pc.moveTableFocus(event)");
        if(col.getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK){
	 	%>
<input type="checkbox" id="$<%=cIdInput%>" value="Y" onchange="pc.cellChanged(event)" class="cbx" <%=isModifiable?"":"DISABLED"%> />
       <%}else{%>
<input:select name="<%=cIdInput%>" default="<%=columnDataValue%>" attributes="<%= a %>" options="<%= o %>" attributesText="<%=isModifiable?"":"DISABLED"%>" />
		<%}
	}// end if(value != null)
    else{
    %>
	<span id="$<%=cIdInput%>"></span>
   <%
	}%>
    &nbsp;&nbsp;</td>
    <%
}//for
    %>
  </tr><!--view-only template row-->  
<%
 // add page subtotal
if ( table.isSubTotalEnabled()){
%>
	<tr nowrap id="tr_pagesum" class="sumfooter"><td colspan="2"><%=PortletUtils.getMessage(pageContext, "page-sum",null)%></td>
<%		
	for(int i=1;i< columns.size();i++){
    	clink=columns.get(i);
		col=(Column)clink.getLastColumn();
    	out.print("<td align='right'>&nbsp;");
    	if(col.getSubTotalMethod()!=null) out.print("<span id='psum_"+ clink.toHTMLString()+"'></span>");
    	out.print("</td>");
    	
   	}
%>   	
	</tr>
	<tr nowrap id="tr_totalsum" class="sumfooter" style="display:none;"><td colspan="2"><%=PortletUtils.getMessage(pageContext, "total-sum",null)%></td>
<%		
	for(int i=1;i< columns.size();i++){
    	clink=columns.get(i);
		col=(Column)clink.getLastColumn();
    	out.print("<td align='right'>&nbsp;");
    	if(col.getSubTotalMethod()!=null) out.print("<span id='tsum_"+ clink.toHTMLString()+"'></span>");
    	out.print("</td>");
   	}
%>   	
	</tr>

<%}// end table.isSubTotalEnabled
%>
  </tfoot>	
</table>
<!--/div-->
</div> <!-- embed-lines-->
<!--
    </td>
    </tr>
  </table>-->
</form>  
<div id="result-filter-desc">
     <font color='red'>*</font><%= PortletUtils.getMessage(pageContext, "current-filter",null)%>:
     <span class=sqldesc id="filter_setting">
     </span>
</div>
<div id="list-legend">
	<%@ include file="inc_table_legend.jsp"%>
</div>	
<div id="message" class="nt">
	<div id="message_txt">
	</div>
</div>
<form id="export_form" method="post" target="_blank" action="<%="/servlets/QueryInputHandler"%>">
	<input type="hidden" id="exp_resulthandler" name="resulthandler" value="<%=NDS_PATH%>/reports/create_report.jsp">
    <input type='hidden' id="query_json" name="query_json" value="">
</form>
<br><br>

