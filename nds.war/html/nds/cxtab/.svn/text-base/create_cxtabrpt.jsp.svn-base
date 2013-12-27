<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>

<%
	/**
	  Create cxtab report
	  @param query object
	
	*/
	String tabName=PortletUtils.getMessage(pageContext, "crosstab-report",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<script language="javascript">
<%@ include file="/html/nds/cxtab/inc_create_cxtabrpt.js.jsp" %>
</script>
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<script language="javascript" src="<%=NDS_PATH%>/js/application.js"></script>
<script language="javascript" src="<%=NDS_PATH%>/js/alerts.js"></script>
<script language="javascript" src="<%=NDS_PATH%>/js/cxtab.js"></script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
/**------check permission on ad_pinstance creation---**/
WebUtils.checkDirectoryWritePermission("AD_PINSTANCE_LIST",request);

TableManager manager=TableManager.getInstance();
QueryRequestImpl qRequest =(QueryRequestImpl) request.getAttribute("query"); // this is on fact table
Table factTable= qRequest.getMainTable();  
int factTableId=factTable.getId();
nds.query.Expression expr=qRequest.getParamExpression();

Table table =manager.getTable("ad_cxtab"); ; // 
int tableId= table.getId();
int colId=manager.getColumn("ad_cxtab","ad_table_id").getId();

request.setAttribute("table", ""+tableId);
request.setAttribute("one_page","true");
// update request attribute, set query object
QueryRequestImpl query=QueryEngine.getInstance().createRequest(userWeb.getSession());
query.setMainTable(tableId);
query.setResultHandler(NDS_PATH+"/cxtab/create_cxtabrpt.jsp");
query.addSelection(table.getPrimaryKey().getId());
query.addAllShowableColumnsToSelection(Column.QUERY_SUBLIST);
query.addParam(new nds.query.Expression(new ColumnLink(new int[]{colId}),"="+factTableId,null ));
int[] orderKey= new int[]{ table.getPrimaryKey().getId()};
query.setOrderBy(orderKey, false);
request.setAttribute("query", query);//inc_result.jsp will add security filter later

Hashtable urls=new Hashtable();
// following is for updating each record
String modifyLink="javascript:viewCxtabReport(:ID)"; // :ID will be replaced with ad_cxtab.id
urls.put(new Integer(0), modifyLink);
request.setAttribute("urls", urls);
%>
<br>
<table width="98%" cellspacing="0" cellpadding="0" border="0" align="center" bordercolorlight="#999999" bordercolordark="#FFFFFF">
<form name= "cxtabrpt_form" method="post" target="_blank" action="/control/command">
  <input type='hidden' name="command" value="CreateCxtabRunnerProcessInstance">
<tr><td><br>
<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">
<tr>
<td width="10%" valign="top" nowrap height="18" align="left">
<%=PortletUtils.getMessage(pageContext, "data-filter",null)%>:
</td>
<td width="80%" valign="top" nowrap height="18" align="left" colspan="3">
<%
     String filterInputId="filter";
     String url="/html/nds/query/search.jsp?table="+factTableId+"&return_type=m&accepter_id="+filterInputId;
%>
<input readonly='on' type="text" id="<%=filterInputId%>" name="<%=filterInputId%>" value='<%=qRequest.getParamDesc(true).trim()%>' size="80" maxlength="1500">
<span id='<%=filterInputId+"_link"%>'  title="clear" onclick='oq.toggle("<%=url%>","<%=filterInputId%>")'><img id='<%=filterInputId+"_img"%>' border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/clear.gif'></span>
<script>createButton(document.getElementById("<%=filterInputId+"_link"%>"));</script>
<input type="hidden" id="<%=filterInputId+"_expr"%>" name="<%=filterInputId+"_expr"%>" value='<%=(expr==null?"":expr.toHTMLInputElement())%>'>
<input type="hidden" id="<%=filterInputId+"_sql"%>" name="<%=filterInputId+"_sql"%>" value=''>
</td>
</tr>
<tr height="12"><td colspan="4">&nbsp;</td>
</tr>	
<tr>
<%
   // create an input to accept ad_cxtab.name, which will be used as template of the report
   FKObjectQueryModel fkQueryModel;
   Column column=manager.getColumn("ad_cxtab_fact","ad_cxtab_id");
   String column_acc_Id= "cxtab";//"column_"+column.getId();
   //fix ad_table_id to current fact table
   PairTable pt=new PairTable();
   pt.put("ad_cxtab.ad_table_id", String.valueOf(factTableId));
   fkQueryModel=new FKObjectQueryModel(column.getReferenceTable(), column_acc_Id,column,pt);	
   String inputName=column.getName().toLowerCase()+"__"+column.getReferenceTable().getAlternateKey().getName().toLowerCase();
%>	
<td width="10%" valign="top" nowrap="" height="18" align="left"> <%=PortletUtils.getMessage(pageContext, "cxtab-template",null)%><font color="red">*</font>:</td>
<td width="40%" valign="top" nowrap="" height="18" align="left" colspan="1">
<input id="<%=column_acc_Id%>" name="<%=column_acc_Id%>" readonly="on" type="text" onchange="cxtabControl.loadCxtabProcessParam()" value="" onkeydown="<%=fkQueryModel.getKeyEventScript()%>" size="20" maxlength="180" tabindex="4" >
<font size="2"><img width="16" height="18" align="absmiddle" src="<%=NDS_PATH%>/images/char.gif"/></font>
<span id="cbt_<%=column.getId()%>"  onclick="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
<script>createButton(document.getElementById("cbt_<%=column.getId()%>"));</script>
</td>
<td colspan="2">    
	<input type="checkbox" id="chk_run_now" name="chk_run_now" checked value="Y"><%=PortletUtils.getMessage(pageContext, "run-cxrpt-now",null)%>
</td>
</tr>
</table>
<br>
</td></tr>
<tr><td>
	<div id="process_param_div"></div>
</td></tr>
<tr><td>
	<div id="process_queue_div">
<br>
<table align="center" border="0" width="100%" cellpadding="1" cellspacing="1" align="center" >
<tr><td height=18 valign='bottom' align='left' colspan='3'><font class='beta'><b><%=PortletUtils.getMessage(pageContext, "set-cxtab-shedule-params",null)%></b></font><div class='hrRule'></div></td></tr>
<tr>
<%
   // create an input to accept ad_pinstance.AD_PROCESSQUEUE_ID
   column=manager.getColumn("ad_pinstance","AD_PROCESSQUEUE_ID");
   column_acc_Id= "queue";//"column_"+column.getId();
   fkQueryModel=new FKObjectQueryModel(column.getReferenceTable(), column_acc_Id,column);	
   fkQueryModel.setQueryindex(-1);
   inputName="queue";//column.getName().toLowerCase()+"__"+column.getReferenceTable().getAlternateKey().getName().toLowerCase();
   String defaultQueue=(String)QueryEngine.getInstance().doQueryOne("select name from ad_processqueue where isactive='Y' and proctype='O' and issystem='Y'");
%>
<td height="18" width="10%" nowrap align="left"><%= column.getDescription(locale) %><font color="red">*</font>:</td>
<td height="18" width="40%" align="left">
<input id="<%=column_acc_Id%>" class="inputline" type="text" value="<%=defaultQueue%>" onkeydown="<%=fkQueryModel.getKeyEventScript()%>" size="30" maxlength="180" name="<%=inputName%>"/>
<font size="2"><img width="16" height="18" align="absmiddle" src="<%=NDS_PATH%>/images/char.gif"/></font>
<span id="cbt_<%=column.getId()%>"  onclick="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
<script>createButton(document.getElementById("cbt_<%=column.getId()%>"));</script>
</td><td width="50%"><span class='comments' >--<%=LanguageUtil.get(pageContext, "cxtab-queue-comments") %></span></td>
</tr>
<tr>
<%
	String defaultRecordNo= userWeb.getUserName()+"_"+factTable.getName().toLowerCase();
%>	
<td height="18" width="10%" nowrap align="left"><%= LanguageUtil.get(pageContext, "record-no") %>:</td>
<td height="18" width="40%" align="left">
<input type="text" class="inputline" size="30" MAXLENGTH="40" id="recordno" name="recordno" value="<%=defaultRecordNo%>">
<font size="2"><img width="16" height="18" align="absmiddle" src="<%=NDS_PATH%>/images/char.gif"/></font>
</td><td width="50%" align='left'><span class='comments' >--<%=LanguageUtil.get(pageContext, "record-no-comments") %></span></td>
</tr>
<tr>
<td height="18" width="10%"  nowrap align="left"><%= LanguageUtil.get(pageContext, "file-name") %>:<font color="red">*</font></td>
<td height="18" width="40%" align="left">
<%
	SimpleDateFormat sdf = new SimpleDateFormat("MMddHHmm");
	String filename="CXR_"+factTable.getName()+sdf.format(new Date());
%>	
<input type="text" class="inputline"  size="30" MAXLENGTH="255" id="filename" name="filename" value="<%=filename%>">
<font size="2"><img width="16" height="18" align="absmiddle" src="<%=NDS_PATH%>/images/char.gif"/></font>
</td><td width="50%" align='left'><span class='comments' >--<%=LanguageUtil.get(pageContext, "cxtab-filename-comments") %></span></td>
</tr>

</table>
	</div><%/*process_queue_div*/%>
</td></tr>
<tr><td>
<br>	
<input class="command2_button" type='button' id="btnExecuteCxrpt" name='executeCxrpt' value='<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>' onclick="javascript:cxtabControl.submitForm();" >
<%@ include file="/html/nds/common/helpbtn.jsp"%>
</td></tr>
</form>
</table>		
    </div>
</div>		

<%@ include file="/html/nds/footer_info.jsp" %>
