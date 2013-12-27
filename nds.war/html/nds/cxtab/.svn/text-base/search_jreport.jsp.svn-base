<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*"%>
<%@ page import="nds.web.config.*" %>
<%
/**
   Only for report that not set ad_table, that means, whole parameters are read from ad_cxtab_jpara table
   or report has pre_procedure set
   params:
   	cxtab* - ad_cxtab.id, either ad_table_id is null, or pre_procedure is not null for that cxtab
*/
	TableManager manager=TableManager.getInstance();
	int cxtabId= ParamUtils.getIntAttributeOrParameter(request, "cxtab", -1);
	if(cxtabId ==-1){
		//try loading as name
		cxtabId=Tools.getInt( QueryEngine.getInstance().doQueryOne("select id from ad_cxtab where ad_client_id="+
				userWeb.getAdClientId()+" and name="+QueryUtils.TO_STRING(request.getParameter("cxtab"))) ,-1);
	}	
	if(cxtabId ==-1) throw new NDSException("Internal error, cxtab id="+ cxtabId + " does not exist");

	int origCxtabId=cxtabId;
	//load last executed cxtab of the same parent
	int parent_id=Tools.getInt( QueryEngine.getInstance().doQueryOne("select parent_id from ad_cxtab where id="+cxtabId), -1);
	String cxtabRootId= String.valueOf((parent_id==-1? cxtabId:parent_id));
	int lastExecCxtabId=Tools.getInt( userWeb.getPreferenceValue("cxtab"+cxtabRootId,cxtabRootId,false),-1);
	if(lastExecCxtabId!=-1)cxtabId= lastExecCxtabId;

	List list=QueryEngine.getInstance().doQueryList("select ad_table_id,name, description,attr1,attr2 from ad_cxtab where id="+ cxtabId);
 	if(list.size()==0)throw new NDSException("Internal error, cxtab id="+ cxtabId + " does not exist");
  	int tableId= Tools.getInt( ((List)list.get(0)).get(0),-1);
  	Table table= manager.getTable(tableId);
  	
	String jreportName=(String) ((List)list.get(0)).get(1);
	String jreportDesc=(String) ((List)list.get(0)).get(2);
	String excelPath= (String) ((List)list.get(0)).get(3);
	String jReportPath= (String) ((List)list.get(0)).get(4);
	int[] columnMasks= new int[]{Column.MASK_QUERY_LIST};
	int listViewPermissionType= 1;
	JSONObject q=new JSONObject();
	q.put("table", table.getName());
	q.put("column_masks", JSONUtils.toJSONArrayPrimitive(columnMasks));
	q.put("dir_perm",listViewPermissionType);
	q.put("init_query",true);
	q.put("start",0);
	q.put("range",QueryUtils.DEFAULT_RANGE);
	boolean firstDateColumnFound=false;	
%>
<div id="page-table-query">
	<div id="page-table-query-tab">
		<ul><li><a href="#tab1"><span><%=PortletUtils.getMessage(pageContext, "rpt-filter-setting",null)%></span></a></li></ul>
		<div id="tab1" class="ui-tabs-panel">
			<div id="rpt-search">
<table border="0" cellspacing="0" cellpadding="0" align='center' width="98%"><tr><td>
<div id="rpt-desc">
	<span style="width:100px;"><%=PortletUtils.getMessage(pageContext, "current-cxtab",null)%>:</span>
			<select name="rep_templet" id="rep_templet" onchange="pc.reloadCxtabHistory()">
					<%
					// current cxtab, brothers of the same parent, parent, sons will be chosen
					// limit only too root and me(2010-7-28)
					List rep_templet=QueryEngine.getInstance().doQueryList("select distinct x.id,x.name from ad_cxtab x, users u where x.ad_table_id="+tableId+" and x.ad_client_id="+
						userWeb.getAdClientId()+" and x.reporttype='S' and (x.id="+origCxtabId+" or x.parent_id="+origCxtabId+
						 (parent_id==-1?"":"or x.id="+ parent_id+" or x.parent_id="+parent_id)+") and u.id=x.ownerid and (x.ownerid="+ userWeb.getUserId()+" or u.name='root')");

					String str="";
					int rep_templet_id;
					if(rep_templet.size()>0){
						for(int i=0;i<rep_templet.size();i++){
							str=(String)((List)(rep_templet.get(i))).get(1);
							rep_templet_id=Tools.getInt(((List)(rep_templet.get(i))).get(0),-1);
						%>
						<option value="<%=rep_templet_id%>" <%=(rep_templet_id==cxtabId)?"selected='selected'":" "%>><%=str%></option>
						<%
						}
					}
					%>
		  	</select></br>
	<span style="width:100px;"><%=PortletUtils.getMessage(pageContext, "description",null)%>:</span><%=jreportDesc%>
</div>
</td></tr></table>
<form id="list_query_form" name="list_query_form">
<table align="center" border="0" cellpadding="1" cellspacing="1" width="98%" >
<%
    int columnsPerRow=4;// 4 field per row
    int widthPerColumn= (int)(100/(columnsPerRow*2));
	// construct using ad_jreport_para
	List paras= QueryEngine.getInstance().doQueryList("select name, paratype, defaultvalue, description, ad_column_id, selectiontype, nullable from ad_cxtab_jpara where isactive='Y' and ad_cxtab_id="+ cxtabId+" order by orderno asc");

    for(int i=0;i<paras.size();i++){
          List para= (List) paras.get(i);
		  Column column=manager.getColumn( Tools.getInt( para.get(4),-1));
		  nds.util.PairTable values =null;
          String desc=(String)para.get(3);
          String inputName=(String)para.get(0);
          String defaultValue= (String)para.get(2);
          if(nds.util.Validator.isNull(defaultValue)) defaultValue="";
          String type=(String)para.get(1);
          boolean isMultipleSelection= "M".equalsIgnoreCase( (String)para.get(5));
          boolean isNullable="Y".equalsIgnoreCase( (String)para.get(6));
		  
		  if(!isNullable) desc = desc +"<font color='red'>*</font>";
          //String typeDesc=TableQueryModel.toTypeDesc((String)para.get(1), 0,locale);
		  if(column!=null)	
           	values=column.getValues(locale);
          if(i%columnsPerRow == 0)out.print("<tr>");
        %>
          <td height="18" width="<%=widthPerColumn*2/3%>%" nowrap align="left">
               <div class="desc-txt"><%=desc%>:</div>
          </td>
          <td height="18" width="<%=widthPerColumn*4/3%>%" nowrap align="left">
           <%
            if(values != null){// ÏÔÊ¾combox»òradio
                StringHashtable o = new StringHashtable();
            	o.put(PortletUtils.getMessage(pageContext, "combobox-select-all",null),"0");
                Iterator i1 = values.keys();
                Iterator i2 = values.values();
                while(i1.hasNext() && i2.hasNext())
                {
                    String tmp1 = String.valueOf(i2.next());
                    String tmp2 = String.valueOf(i1.next());
                    // add = so will match identically
                    o.put(tmp1,"="+tmp2); // tmp1 is limit-description, tmp2 is limit-value
                }
                java.util.HashMap a = new java.util.HashMap();
                %>
           <input:select name="<%=inputName%>" default="<%=(nds.util.Validator.isNull(defaultValue)?"0":defaultValue )%>" attributes="<%= a %>" options="<%= o %>" />
           <%
            }// end if(value != null)
            else{
                java.util.Hashtable h = new java.util.Hashtable();
                h.put("id",inputName);
                h.put("size", "15");
	            if((column!=null && column.getReferenceTable()!=null && column.getReferenceTable().getAlternateKey().isUpperCase())
	            		|| (column!=null && column.isUpperCase())){
	            	h.put("class","qline ucase");
	            }else
	            	h.put("class","qline");
				if(column!=null && column.getReferenceTable() !=null){  
					//override default value if user has option set on the same column name
					String defaultValue2= userWeb.getUserOption(column.getName(),"");
					if(nds.util.Validator.isNotNull(defaultValue2)) defaultValue="="+defaultValue2;
				
				    if(isMultipleSelection){                             
	                    FKObjectQueryModel fkQueryModel=new FKObjectQueryModel(column.getReferenceTable(), inputName,column,null,false);
	                    fkQueryModel.setQueryindex(-1);
	                    
            %>
	              		<input:text name="<%=inputName%>" default="<%=defaultValue%>" attributes="<%= h %>" />
	                    <input type='hidden' name='<%=inputName+"/sql"%>' id='<%=inputName + "_sql"%>' />
	                    <input type='hidden' name='<%=inputName+"/filter"%>' id='<%=inputName + "_filter"%>' />
                        <span id='<%=inputName+"_link"%>' title="popup" onclick="<%=fkQueryModel.getButtonClickEventScript()%>"><img id='<%=inputName+"_img"%>' border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'></span>
						<script>createButton(document.getElementById("<%=inputName+"_link"%>"));</script>	
                    <%
                    }else{
                    	//single selection on fk column
	                    FKObjectQueryModel fkQueryModel=new FKObjectQueryModel(column.getReferenceTable(), inputName,column,null,true);

						DisplaySetting ds= column.getDisplaySetting();
		                
			            %>
			            <input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>" />
						<input type="hidden" id="fk_<%=inputName%>" name="fk_<%=inputName%>" value="">
						<span id="cbt_<%=inputName%>"  onclick="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' title='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
                		<script>
                			createButton(document.getElementById("cbt_<%=inputName%>"));
                		</script>						
						<%
                    }
            	}else{
            		//will check type first, for number, construct operator, for date, two fields, for string, contains or equal
            		if("d".equalsIgnoreCase(type)){
            			if(isMultipleSelection){
            				String showDefaultRange=firstDateColumnFound?"N":"Y";// only first date column will have default range set
            		%>
            				<input:daterange id="<%=inputName%>" name="<%=inputName%>" showDefaultRange="<%=showDefaultRange%>" attributes="<%= h %>"/>
            		<%
            				firstDateColumnFound=true;
            			}else{
            		%>
            			<input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>"/><%=TableQueryModel.toTypeIndicator(Column.DATENUMBER,10,null,inputName,locale)%>
            		<%		
            			}
            		}else if("n".equalsIgnoreCase(type)){
            		%>
            		<input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>" />
            		<%
            		}else if("s".equalsIgnoreCase(type)){
            		%>
            		<input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>"/>
            		<%
            		}
            	}
            }%>
          </td>
        <%
        if(i%columnsPerRow == (columnsPerRow -1))out.print("</tr>");
        }%>
</table>
<br>
			</div>
		</div>
  </div>
</div>

<div id="rpt-sbtns">
	<a href="javascript:mu.add_mufavorite('<%=table.getDescription(locale)%>','<%=tableId%>',true,'<%=cxtabId%>')"><img src="/html/nds/images/mufa.png"><%=PortletUtils.getMessage(pageContext, "mufavorite",null)%></a>
<%
if(Validator.isNotNull(excelPath)){%>
      <input id="btn_run_rpt2" type="button" class="cbutton" onclick="javascript:pc.doReportOnSelection(true,<%=tableId%>,'xls')" value="<%=PortletUtils.getMessage(pageContext, "execute-xls",null)%>">
      &nbsp;&nbsp;
<%}%>
      <!--<input id="btn_run_rpt" type="button" class="cbutton" onclick="javascript:pc.doReportOnSelection(true,<%=tableId%>,'htm')" value="<%=PortletUtils.getMessage(pageContext, "execute-htm",null)%>">&nbsp;&nbsp;-->
<%if (ConfigValues.get("cxtab.allow.cub", true)) { %>
      <input id="btn_run_cube" type="button" class="cbutton" onclick="javascript:pc.doReportOnSelection(true,<%=tableId%>,'cub')" value="<%=PortletUtils.getMessage(pageContext, "execute-cube",null)%>">&nbsp;&nbsp;
<%}else  if (ConfigValues.get("cxtab.allow.cus", false)) {%>
      <input id="btn_run_cus" type="button" class="cbutton" onclick="javascript:pc.doReportOnSelection(true,<%=tableId%>,'cus')" value="<%=PortletUtils.getMessage(pageContext, "execute-cus",null)%>">&nbsp;&nbsp;
<%}%>
      <input id="btn_run_csv" type="button" class="cbutton" onclick="javascript:pc.doReportOnSelection(true,<%=tableId%>,'csv')" value="<%=PortletUtils.getMessage(pageContext, "fast-export",null)%>">&nbsp;&nbsp;
<%if(Validator.isNotNull(jReportPath)){
	if(jReportPath.endsWith(".jrxml")){%>
      <input id="btn_run_jxls" type="button" class="cbutton" onclick="javascript:pc.doJReportOnSelection(<%=tableId%>,'xls')" value="<%=PortletUtils.getMessage(pageContext, "execute-jxls",null)%>">&nbsp;&nbsp;
      <input id="btn_run_jhtm" type="button" class="cbutton" onclick="javascript:pc.doJReportOnSelection(<%=tableId%>,'htm')" value="<%=PortletUtils.getMessage(pageContext, "execute-jhtm",null)%>">&nbsp;&nbsp;
      <input id="btn_run_jpdf" type="button" class="cbutton" onclick="javascript:pc.doJReportOnSelection(<%=tableId%>,'pdf')" value="<%=PortletUtils.getMessage(pageContext, "execute-jpdf",null)%>">&nbsp;&nbsp;
    <%}%>
<%	
  }
 int objPerm= userWeb.getObjectPermission("AD_CXTAB", cxtabId);
if((objPerm & nds.security.Directory.READ )== nds.security.Directory.READ ){
%>    
      <input type="button" class="cbutton" onclick="javascript:showObject2('/html/nds/cxtab/cxtabdef.jsp?id=<%=cxtabId%>',{close:function(){pc.qrpt(<%=cxtabId%>);}})" value="<%=PortletUtils.getMessage(pageContext, "define-cxtab",null)%>">
<%}%>      
<script>
 pc.initCxtabQuery(<%=q.toString()%>);
 pc.refreshCxtabHistoryFiles(<%=cxtabId%>);
 jQuery('#page-table-query-tab ul').tabs();
 jQuery('#page-table-query-tab ul').attr('class','ui-tabs-nav');
 jQuery('#page-table-query-tab li').attr('class','ui-tabs-selected');
</script>	
</div>      
</form>
<input type='hidden' name='queryindex_-1' id='queryindex_-1' value="-1" />
<input type='hidden' name='queryindex_0' id='queryindex_0' value="-1" />
<div id="history_files"></div>
