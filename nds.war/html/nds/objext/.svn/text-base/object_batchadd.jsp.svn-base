<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
    /**
     * Things needed in this page:
     *  1.  table     String|id of table that queried on, 
     *  2.  object_page_url the url of this page, will used in formRequest
     *  3.  fixedcolumns PairTable| key: fixed column id(Integer), Value: String that column's value
     *  4. mainobjecttableid (optinal string or int) 如果当前的页面是作为主表某记录的引用页面（如
     *        单据的明细单）而出现，则应当设置mainobjecttableid为主表的表id
	 *
     */
%>
<%
TableManager manager= TableManager.getInstance();
int tableId= ParamUtils.getIntParameter(request,"table", -1);
Table table= manager.getTable(tableId);
PairTable fixedColumns=PairTable.parseIntTable(request.getParameter("fixedcolumns"), null);

String tabName =table.getDescription(locale);
%>
<script language="JavaScript">
	document.title="<%=tabName%>";
</script>
<script language="JavaScript" src="<%= NDS_PATH %>/js/formkey.js"></script>

<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%!
    private String getIndicator(Column column,Locale locale){
        int type;
        if( column.getReferenceTable() !=null) type= column.getReferenceTable().getAlternateKey().getType();
        else type= column.getType();
        return nds.query.web.TableQueryModel.toTypeIndicator(type,locale);
    }

%>
<%
int maxLineCount=Tools.getInt(((Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS)).getProperty("controller.copy.max"),20);
Object objVH= request.getAttribute(nds.util.WebKeys.VALUE_HOLDER);

if(objVH!=null && objVH instanceof nds.control.util.ValueHolder){
	// from command.CopyTo/CopyItemForMM, which will specify how many lines will be created.
	maxLineCount= Tools.getInt(((nds.control.util.ValueHolder)objVH).get("linecount"),maxLineCount) ;
}
/**------check permission---**/
String directory;
directory=table.getSecurityDirectory();
WebUtils.checkDirectoryWritePermission(directory, request);
/**------check permission end---**/


  ArrayList columns=table.getModifiableColumns(Column.ADD); // not to show uiController
  
  QueryRequestImpl qRequest=QueryEngine.getInstance().createRequest(userWeb.getSession());
  qRequest.setMainTable(table.getId());
  qRequest.addAllModifiableColumnsToSelection(Column.ADD);
  String[] showColumns=qRequest.getDisplayColumnNames(true);
  TableQueryModel model= new TableQueryModel(table.getId(), true,locale);
  String form_name="sheet_item_modify"; // do not change this form name
  String formRequest="/html/nds/sheet/object_batchadd.jsp?table="+ tableId +"&mainobjecttableid="+ParamUtils.getIntAttributeOrParameter(request, "mainobjecttableid",-1)+
  (fixedColumns==null?"":request.getParameter("fixedcolumns"));
%>
<form name="<%=form_name%>" method="post" action="<%=request.getContextPath() %>/control/command" onSubmit="return checkOptions(this);">
    <input type='hidden' name="mainobjecttableid" value="<%= ParamUtils.getIntAttributeOrParameter(request, "mainobjecttableid",-1)%>">
    <input type=hidden name="next-screen" value="/html/nds/info.jsp">
    <input type=hidden name="formRequest" value="<%=formRequest%>">
    <input type='hidden' name="directory" value="<%= directory%>">
    <input type='hidden' name="table" value="<%= table.getId()%>">
	<input type='hidden' name="fixedcolumns" value="<%= fixedColumns.toURLQueryString("")%>">    
    <input type='hidden' name="input" value="true">
                    <%
                        /* the parameter arrayItemSelecter is used by DefaultWebEvent's method
                           getParameterValues().
                           Please refer to DefaultWebEvent for details
                        */
                    %>
    <input type="hidden" name="arrayItemSelecter" value="selectedItemIdx">
<table border="0" cellspacing="0" cellpadding="0" align="center" width="100%">
  <tr><td >
   <table border=0  align="center" width="100%"><tr><td width="80%">
  <br>
<%@ include file="/html/nds/objext/inc_object_batchadd_buttons.jsp" %>
	</td><td align='center' valign="bottom">
      <div id="divScrollController" style="width: 100px;height:20; border: 0px;overflow-x: auto;overflow-y: hidden;">	
		<div style="width: 700px; height=10px;overflow-y: hidden; overflow-x: border: 0px;hidden;padding:0px"> 
	  </div>
	 </div>
	</td></tr></table>
  </td></tr>
  <tr><td colspan="2">
    
<%
int internal_table_width= ParamUtils.getIntAttribute(request,"internal_table_width", -1)-10;
if(internal_table_width>0){
%>
<div syncto="divScrollController" syncdirection="horizontal" style="behavior: url('<%=NDS_PATH+"/css/syncscroll.htc"%>');width: <%= internal_table_width%>px; overflow-y:hidden;overflow-x: auto; border-width:thin;border-style:groove ;padding:0px"> 

<%}%>
<table id="modify_table" width="100%" border="1" cellspacing="0" cellpadding="0"  align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFFFFF">
               <thead><tr>
                   <td nowrap>
                   <span name="thisisorder" ><%= PortletUtils.getMessage(pageContext, "serial-no",null)%><span>
                   </td>
                    <%

                    int[] columnInputLengths=new int[columns.size()];
                    String[] columnNames=new String[columns.size()];
                    String[] columnClasses=new String[columns.size()];
                    
                    int totalLength =15;// serial no length is 10, checkbox is 5
                    for( int i=0;i< columns.size();i++){
                        Column colmn=(Column)columns.get(i);
                        String inputName= colmn.getName().toLowerCase();
						columnClasses[i]="";
                        if(colmn.getReferenceTable()!=null) {
                            columnInputLengths[i]=colmn.getReferenceTable().getAlternateKey().getLength();
                            inputName =inputName +"__"+ colmn.getReferenceTable().getAlternateKey().getName().toLowerCase();
                            if(colmn.getReferenceTable().getAlternateKey().isUpperCase()){
                            	columnClasses[i]="ucase";
                            }
                        }else{
                            columnInputLengths[i]= colmn.getLength();
                            if(colmn.isUpperCase()){
                            	columnClasses[i]="ucase";
                            }
                        }
                        
                        columnNames[i]= inputName;
                        totalLength += columnInputLengths[i]>20?20:columnInputLengths[i];
                    }
                    for(int i=0;i< columns.size();i++){
                        String colDisplayName= showColumns[i];
                        int type;
                        Column colmn=(Column)columns.get(i);
                        type= colmn.getType();
                        String typeIndicator= getIndicator(colmn,locale);
                        int inputSize=columnInputLengths[i]>20?20:columnInputLengths[i];
                        int tdWidth=(int)(100* inputSize/ totalLength);
                     %>
                     <td nowrap align='center'>
                     <span><%=colDisplayName%><%= typeIndicator%><span>
                      </td>
                    <%}%>
              </tr></thead>
              <% int tabIndex=0;
              FKObjectQueryModel fkQueryModel;
              String fixedColumnMark; boolean isFixedColumn,whiteBg=false;
                for( int j=0;j<maxLineCount;j++){
                	if(j%1==0) whiteBg = (whiteBg==false);
                  %>
                  <tr bgcolor='<%=(whiteBg?"#FFFFFF":"#f0f0f0")%>'>
                  <td nowrap width="1%"><input:checkbox name="selectedItemIdx" value="<%=String.valueOf(j)%>" attributesText="class='cbx'"/><%=(j+1)%> </td>
                  <%
                    int l = 0;
                        for(int i=0;i< columns.size();i++){
                            String inputName= columnNames[i];
                            int inputSize=columnInputLengths[i]>20?20:columnInputLengths[i];
                            nds.util.PairTable values =((Column) columns.get(i)).getValues(locale);
                            int tdWidth=(int)(100* inputSize/ totalLength);
                            if( tdWidth<1)tdWidth=1;
                            out.println("<td width='"+tdWidth+"%' height='20' nowrap='true'>");
                            if(values != null){
                            // 下拉式列表

                               Iterator temp = values.keys();

                                //Hawke Begin
                                StringHashtable o = new StringHashtable();
                                o.put(PortletUtils.getMessage(pageContext, "combobox-select",null),"0");
                                while(temp.hasNext())
                                {
                                    String keyValue = temp.next().toString();
                                    o.put((String)values.get(keyValue),keyValue.toString());
                                }
                                java.util.HashMap a = new java.util.HashMap();
                                String column_acc_Id2="column_"+j+"_"+l++;
                                a.put("id",column_acc_Id2);
                                a.put("onchange","inputChanged('"+column_acc_Id2+"',event)");
                                a.put("onKeyDown","move('"+column_acc_Id2+"',event)");
                                a.put("tabIndex", (++tabIndex)+"");
                                a.put("ai", String.valueOf(j));//这里的ai只能支持select单选的情况，多选设ai将出现异常
                                // marked as there are error for checkbox
                                String defaultValue= (((Column) columns.get(i)).getDefaultValue()==null?"0":userWeb.replaceVariables(((Column) columns.get(i)).getDefaultValue()));
                                if(false==true){
								//if(((Column) columns.get(i)).getDisplaySetting().getObjectType()==DisplaySetting.OBJ_CHECK){
									a.put("id","chk_"+column_acc_Id2);
                                   	a.put("onchange", "checkboxChanged('"+column_acc_Id2+"',event)");
									java.util.HashMap aHidden = new java.util.HashMap();
									aHidden.put("id",column_acc_Id2);
								%>
                             	<input:hidden name="<%=inputName%>" default="<%=defaultValue%>" attributes="<%=aHidden%>"/>
	                            <input:checkbox name="<%="chkn_"+column_acc_Id2%>" default="<%=defaultValue%>" value="Y" attributes="<%=a%>" attributesText="class='cbx'"/>
								<%										
								}else{
                           %>
                           <input:select name="<%=inputName%>" default="<%=defaultValue%>" attributes="<%= a %>" options="<%= o %>" />
                           <%	}
                            }
                            else{
                            	String column_acc_Id="column_"+j+"_"+l++;
                                if(((Column) columns.get(i)).isModifiable(Column.ADD)){
	                                Table refTable= ((Column)columns.get(i)).getReferenceTable();
	                                if(refTable!=null){		
	                                	fkQueryModel=new FKObjectQueryModel(refTable,column_acc_Id,(Column)columns.get(i));
	                                	fkQueryModel.setQueryindex(-1);
	    	  							
	    	  						}else{
	    	  							fkQueryModel=null;
	    	  						}

                                   fixedColumnMark= (fixedColumns.get(new Integer(((Column) columns.get(i)).getId())) ==null)?"":"DISABLED";
                    			   isFixedColumn= (fixedColumns.get(new Integer(((Column) columns.get(i)).getId())) ==null)?false:true;
                                
                                    java.util.Hashtable h = new java.util.Hashtable();
                                    h.put("ai", String.valueOf(j));
                                    h.put("id",column_acc_Id);
                                    h.put("size", String.valueOf(inputSize));
                                    h.put("maxlength", String.valueOf(columnInputLengths[i]));
                                    h.put("onKeyDown","move('"+column_acc_Id+"',event);"+ (fkQueryModel==null?"": fkQueryModel.getKeyEventScript()));
                                    h.put("tabIndex", (++tabIndex)+"");
                                    h.put("class","inputline "+ columnClasses[i]); 
                                    String defaultValue;
                                    if(!isFixedColumn) defaultValue=userWeb.replaceVariables(((Column)columns.get(i)).getDefaultValue());
                                    else defaultValue= PortletUtils.getMessage(pageContext, "maintain-by-sys",null);
                            %>
                              <input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>"  attributesText="<%=fixedColumnMark%>" />
                            <%
                                    if(refTable !=null){
                                      if(!isFixedColumn){
                            %>
                            <span id="cbt_<%=column_acc_Id%>"  onclick="<%=fkQueryModel.getButtonClickEventScript() %>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
                            <script>createButton(document.getElementById("cbt_<%=column_acc_Id%>"));</script>	
                            <%		  }
                                    }else{
                            %>
                            	&nbsp;&nbsp;&nbsp;
                           <%		}
                                }else{
                            %>
                              	<font color='#999999'><%= PortletUtils.getMessage(pageContext, "maintain-by-sys",null)%></font>
                            <%    }
                            }
                            out.println("</td>");
                        }
                       java.util.Hashtable cf = new java.util.Hashtable();
                       cf.put("ai", String.valueOf(j));
               %>
                          <input:hidden name="copyfromid" attributes="<%= cf %>"/>
                    </tr>
				<%
                }
               %>
</table>
<%
if(internal_table_width>0){
%>
<br>
</div>

<%}%>

   </td></tr>
</table>
	<br>	
	</div>
</div>		

<%@ include file="/html/nds/footer_info.jsp" %>
