<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="nds.monitor.MonitorManager" %>
<%@ page import="nds.web.config.*" %>
<%@ page import="nds.query.QueryEngine" %>
<%@ page import="nds.schema.Table" %>
<%@ page import="nds.schema.TableManager" %>
<%@ page import="nds.util.Tools" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONObject" %>

<%@page errorPage="/html/nds/error.jsp"%>
<%@include file="/html/nds/common/init.jsp"%>
<%
   int cxtabId = ParamUtils.getIntAttributeOrParameter(request, "cxtab", -1);
   if (cxtabId == -1)
   {
     cxtabId = Tools.getInt(QueryEngine.getInstance().doQueryOne("select id from ad_cxtab where ad_client_id=" + userWeb.getAdClientId() + " and name=" + QueryUtils.TO_STRING(request.getParameter("cxtab"))), -1);
   }

   if (cxtabId == -1) throw new NDSException("Internal error, cxtab id=" + request.getParameter("cxtab") + " does not exist");

   int origCxtabId = cxtabId;

   int parent_id = Tools.getInt(QueryEngine.getInstance().doQueryOne("select parent_id from ad_cxtab where id=" + cxtabId), -1);
   String cxtabRootId = String.valueOf(parent_id == -1 ? cxtabId : parent_id);
   int lastExecCxtabId = Tools.getInt(userWeb.getPreferenceValue("cxtab" + cxtabRootId, cxtabRootId, false), -1);
   if (lastExecCxtabId != -1) cxtabId = lastExecCxtabId;

   List list = QueryEngine.getInstance().doQueryList("select ad_table_id,name, description,attr1,attr2,pre_procedure from ad_cxtab where id=" + cxtabId);
   if (list.size() == 0) throw new NDSException("Internal error, cxtab id=" + cxtabId + " does not exist");
   int tableId = Tools.getInt(((List)list.get(0)).get(0), -1);

   String cxtabName = (String)((List)list.get(0)).get(1);
   String cxtabDesc = (String)((List)list.get(0)).get(2);
   String excelPath = (String)((List)list.get(0)).get(3);
   String jReportPath = (String)((List)list.get(0)).get(4);
   String preProcedure = (String)((List)list.get(0)).get(5);

   if ((tableId == -1) || (nds.util.Validator.isNotNull(preProcedure)))
   {
     request.getRequestDispatcher("jreport_search.jsp").forward(request, response);
   }else{
     TableManager manager = TableManager.getInstance();
     Table table = manager.getTable(tableId);
     Table cxtabTable = manager.getTable("ad_cxtab");

     int[] columnMasks = { 4 };
     int listViewPermissionType = 1;
     String return_type = "n";
     String accepter_id = null;
     int tab_count = 1;
     boolean firstDateColumnFound = false;
     ArrayList qColumns = table.getIndexedColumns();
     TableQueryModel model = new TableQueryModel(tableId, qColumns, false, false, locale);
  %>

     <div id="rpt-search">
     	<form id="list_query_form" name="list_query_form" method="post" action="/servlets/QueryInputHandler" onSubmit="return false;" >
     	<input type='hidden' name='table' value="<%=tableId%>">
     	<input type='hidden' name='tab_count' value="<%=tab_count%>">
    	<input type='hidden' name='return_type' value="<%=return_type%>">
     	<input type='hidden' name='accepter_id' value="<%=accepter_id%>">
     	<input type='hidden' name='param_count' value="<%=qColumns.size()%>">
     	<input type='hidden' name='resulthandler' value='/html/nds/portal/table_list.jsp'>
     	<input type='hidden' name='show_maintableid' value='true'>
     	<input type='hidden' name='show_all' value='true'>
 
		<%

         for (int tabIdx = 0; tabIdx < tab_count; tabIdx++)
         {
        %>
           <table border="0" cellspacing="0" cellpadding="0" align='center' width="98%" bordercolordark="#FFFFFF" bordercolorlight="#999999">
           	<tr><td  colspan="2"><table align="center" border="0" cellpadding="1" cellspacing="1" width="98%" >
 		<%
           int columnsPerRow = 2;
           int widthPerColumn = 100 / (columnsPerRow * 2);
 
           for (int i = 0; i < qColumns.size(); i++) {
             Column column = (Column)qColumns.get(i);
 
             String desc = model.getDescriptionForColumn(column);
             String fkDesc = model.getDescriptionForFKColumn(column);
             if (!"".equals(fkDesc)) fkDesc = "(" + fkDesc + ")";
             String inputName = "tab" + tabIdx + "_" + model.getNameForInput(column);
             String cs = model.getColumns(column);
             int inputSize = model.getSizeForInput(column);
             String type = model.getTypeMeaningForInput(column);
 
             PairTable values = column.getValues(locale);
             if (i % columnsPerRow == 0) out.print("<tr>");
             String column_desc = "column_" + column.getId() + "_desc";

		   out.print("<td height=18 width='"+widthPerColumn * 2/3+"%' nowrap align='left'><div class='desc-txt'>"+desc);
		   out.print("<td height=18 width='"+widthPerColumn * 4/3+"%' nowrap align='left'>");
 		   out.print("<input type='hidden' name='"+inputName+"/columns' value='"+cs+"' >");

             if (values != null)
             {
               StringHashtable o = new StringHashtable();
               o.put(PortletUtils.getMessage(pageContext, "combobox-select-all", null), "0");
               Iterator i1 = values.keys();
               Iterator i2 = values.values();
               while ((i1.hasNext()) && (i2.hasNext()))
               {
                 String tmp1 = String.valueOf(i2.next());
                 String tmp2 = String.valueOf(i1.next());
 
                 o.put(tmp1, "=" + tmp2);
               }
               HashMap a = new HashMap();
               inputName = inputName + "/value";
 
               if (("isactive".equalsIgnoreCase(column.getName())) && (!"n".equals(return_type)))
               {
           %>
           <input:select name="<%=inputName%>" default="=Y" attributes="<%=a%>" options="<%=o%>" attributesText=""/>
		   <input type="hidden" name="<%=inputName%>" value="Y" >

           <%}else {%>
           <input:select name="<%=inputName%>" default="0" attributes="<%=a%>" options="<%=o%>" attributesText=""/>
           <%
       		}
   		}else{
           String column_acc_Id = "tab" + tabIdx + "_column_" + column.getId();
           String column_acc_name = inputName;
           Hashtable h = new Hashtable();

           h.put("size", "15");
           if (((column.getReferenceTable() != null) && (column.getReferenceTable().getAlternateKey().isUpperCase())) || (column.isUpperCase()))
           {
             h.put("class", "qmline");
           }
           else h.put("class", "qmline");

           inputName = inputName + "/value";
           if (column.getReferenceTable() != null) {
             h.put("id", column_acc_Id);
             FKObjectQueryModel fkQueryModel = new FKObjectQueryModel(column.getReferenceTable(), column_acc_Id, column, null, false);
             fkQueryModel.setQueryindex(-1);
             String defaultValue = userWeb.getUserOption(column.getName(), "");
             if (nds.util.Validator.isNotNull(defaultValue)) defaultValue = "=" + defaultValue;
           %>
             <input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>"/><%=type%>
			<input type='hidden' name="<%=column_acc_name%>/sql" id="<%=column_acc_Id%>_sql"/>
			<input type='hidden' name="<%=column_acc_name%>/filter" id="<%=column_acc_Id%>_filter"/>
			<span id="<%=column_acc_Id%>_link" title='popup' onaction="<%=fkQueryModel.getButtonClickEventScript(false)%>">
			<img id="<%=column_acc_Id%>_img" border=0 width=16 height=16 align=absmiddle src="<%=fkQueryModel.getImageURL()%>" 
			alt='<%=PortletUtils.getMessage(pageContext,"open-new-page-to-search", null)%>'></span>
			<script>createButton(document.getElementById("<%=column_acc_Id%>_link"));</script>
		<%
			}else if ((column.getType() == 1) || (column.getType() == 3)) {
			String showDefaultRange = firstDateColumnFound ? "N" : "Y";
			String showTime = column.getType() == 1 ? "Y" : "N";
			%>
            <input:daterange id="<%=inputName%>" name="<%=inputName%>" showDefaultRange="<%=showDefaultRange%>" attributes="<%= h %>" showTime="<%=showTime%>"/>
            <%	
            firstDateColumnFound = true;
			} else if (column.getType() == 0){
			%>
			<input:text name="<%=inputName%>" attributes="<%=h%>" default=""/><%=type%>
		   <%
			} else if (column.getType() == 2){
			%>
			<input:text name="<%=inputName%>" attributes="<%=h%>" default=""/><%=type%>
           <%}

    		}
    	out.print("</td>");
		if (i % columnsPerRow == columnsPerRow - 1) out.print("</tr>");
   		}
       out.print("</table></td></tr>");
 	   }
 	   out.print("</from>");
     }
       int dimensionCnt = Tools.getInt(QueryEngine.getInstance().doQueryOne("select count(*) from ad_cxtab_dimension where ad_cxtab_id=" + cxtabId), -1);
       StringBuffer attachType = new StringBuffer("[");
       if (dimensionCnt > 0) {
         attachType.append("'cub','csv',");
       }
         if (com.liferay.util.Validator.isNotNull(jReportPath)) {
           if (jReportPath.endsWith(".jrxml"))
             attachType.append("'pdf','xls',");
           else {
             attachType.append("'xls',");
           }
         }
         attachType.append("'null']");
       %>
      <script>
         mm.setAttachTypes(<%=attachType%>);
    </script>
    <div class="cxbtns"><input class="cbutton" type="button" value="确认条件设置" onclick="mm.cxtabFormConfirmed()"></input>
    	<input class="cbutton" type="button" value="取消" onclick="mm.cxtabFormCanceled()"></input>
    </div></div>
    <input id="queryindex_-1" type="hidden" value="-1" name="queryindex_-1"></input>
