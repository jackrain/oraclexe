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
	TableManager manager = TableManager.getInstance();
	int cxtabId = ParamUtils.getIntAttributeOrParameter(request, "cxtab", -1);
	if (cxtabId == -1)
	{
	 cxtabId = Tools.getInt(QueryEngine.getInstance().doQueryOne("select id from ad_cxtab where ad_client_id=" + userWeb.getAdClientId() + " and name=" + QueryUtils.TO_STRING(request.getParameter("cxtab"))), -1);
	}

	if (cxtabId == -1) throw new NDSException("Internal error, cxtab id=" + cxtabId + " does not exist");

	int origCxtabId = cxtabId;

	int parent_id = Tools.getInt(QueryEngine.getInstance().doQueryOne("select parent_id from ad_cxtab where id=" + cxtabId), -1);
	String cxtabRootId = String.valueOf(parent_id == -1 ? cxtabId : parent_id);
	int lastExecCxtabId = Tools.getInt(userWeb.getPreferenceValue("cxtab" + cxtabRootId, cxtabRootId, false), -1);
	if (lastExecCxtabId != -1) cxtabId = lastExecCxtabId;

	List list = QueryEngine.getInstance().doQueryList("select ad_table_id,name, description,attr1,attr2 from ad_cxtab where id=" + cxtabId);
	if (list.size() == 0) throw new NDSException("Internal error, cxtab id=" + cxtabId + " does not exist");
	int tableId = Tools.getInt(((List)list.get(0)).get(0), -1);
	Table table = manager.getTable(tableId);

	String jreportName = (String)((List)list.get(0)).get(1);
	String jreportDesc = (String)((List)list.get(0)).get(2);
	String excelPath = (String)((List)list.get(0)).get(3);
	String jReportPath = (String)((List)list.get(0)).get(4);

	JSONObject q = new JSONObject();
	q.put("table", table.getName());
	boolean firstDateColumnFound = false;
	%>
	<div id="rpt-search"><form id="list_query_form" name="list_query_form"><table align="center" border="0" cellpadding="1" cellspacing="1" width="98%">
	<%
       int columnsPerRow = 2;
       int widthPerColumn = 100 / (columnsPerRow * 2);
 
       List paras = QueryEngine.getInstance().doQueryList("select name, paratype, defaultvalue, description, ad_column_id, selectiontype, nullable from ad_cxtab_jpara where isactive='Y' and ad_cxtab_id=" + cxtabId + " order by orderno asc");
 
       for (int i = 0; i < paras.size(); i++) {
         List para = (List)paras.get(i);
         Column column = manager.getColumn(Tools.getInt(para.get(4), -1));
         PairTable values = null;
         String desc = (String)para.get(3);
         String inputName = (String)para.get(0);
         String defaultValue = (String)para.get(2);
         if (nds.util.Validator.isNull(defaultValue)) defaultValue = "";
         String type = (String)para.get(1);
         boolean isMultipleSelection = "M".equalsIgnoreCase((String)para.get(5));
         boolean isNullable = "Y".equalsIgnoreCase((String)para.get(6));
 
         if (!isNullable) desc = desc + "<font color='red'>*</font>";
 
         if (column != null)values = column.getValues(locale);
         if (i % columnsPerRow == 0) out.print("<tr>");
				  
		   out.print("<td height=18 width='"+widthPerColumn * 2/3+"%' nowrap align='left'><div class='desc-txt'>"+desc);
		   out.print("<td height=18 width='"+widthPerColumn * 4/3+"%' nowrap align='left'>");
 
         if (values != null) {
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
           %>
           <input:select name="<%=inputName%>" default="<%=defaultValue%>" attributes="<%=a%>" options="<%=o%>" attributesText=""/>
           <%
 
		}else{

		   Hashtable h = new Hashtable();
           h.put("id", inputName);
           h.put("size", "15");
           if (((column != null) && (column.getReferenceTable() != null) && (column.getReferenceTable().getAlternateKey().isUpperCase())) || ((column != null) && (column.isUpperCase())))
           {
             h.put("class", "qmline");
           }
           else h.put("class", "qmline");
           if ((column != null) && (column.getReferenceTable() != null)){
             String defaultValue2 = userWeb.getUserOption(column.getName(), "");
             if (nds.util.Validator.isNotNull(defaultValue2)) defaultValue = "=" + defaultValue2;
 
             if (isMultipleSelection) {
               FKObjectQueryModel fkQueryModel = new FKObjectQueryModel(column.getReferenceTable(), inputName, column, null, false);
               fkQueryModel.setQueryindex(-1);
               %>
              <input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>"/>
			 
        
               <input type='hidden' name="<%=inputName%>/sql" id="<%=inputName%>_sql"/>
               <input type='hidden' name="<%=inputName%>/filter" id="<%=inputName%>_filter"/>
               <span id="<%=inputName%>_link" title='popup' onaction="<%=fkQueryModel.getButtonClickEventScript()%>">
               	<img id="<%=inputName%>_img" border=0 width=16 height=16 align=absmiddle src="<%=fkQueryModel.getImageURL()%>" 
               	alt='<%=PortletUtils.getMessage(pageContext,"open-new-page-to-search", null)%>'></span>
               	<script>createButton(document.getElementById("<%=inputName%>_link"));</script>
   
              <%}else{

           		FKObjectQueryModel fkQueryModel = new FKObjectQueryModel(column.getReferenceTable(), inputName, column, null, true);
           		DisplaySetting ds = column.getDisplaySetting();
           		%>
           		<input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>"/>
           	   <%
           	   out.print("<input type='hidden' id='fk_"+inputName+"' name='fk_"+inputName+"' value=''><span id='cbt_");
               out.print(inputName+"'  onaction='"+fkQueryModel.getButtonClickEventScript()+"'><img border=0 width=16 height=16 align=absmiddle src='"+fkQueryModel.getImageURL()+"' title='"+PortletUtils.getMessage(pageContext, "open-new-page-to-search", null));
               out.print("'></span><script>createButton(document.getElementById('cbt_"+inputName + "'));</script>");
			}


       	}else if ("d".equalsIgnoreCase(type)) {
            if (isMultipleSelection) {
            String showDefaultRange = firstDateColumnFound ? "N" : "Y";
            %>
            <input:daterange id="<%=inputName%>" name="<%=inputName%>" showDefaultRange="<%=showDefaultRange%>" attributes="<%= h %>"/>
            <%	
            firstDateColumnFound = true;
       		}else {%>
               <input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>"/><%=TableQueryModel.toTypeIndicator(3, 10, null, inputName, locale)%>
           <%}
       }else if ("n".equalsIgnoreCase(type)){%>
       			<input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>"/>

        
   	   <%}else if ("s".equalsIgnoreCase(type)){%>
   	    		<input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>"/>

        <%
   	 }

	
	}
	 out.print("</td>");
	if (i % columnsPerRow == columnsPerRow - 1) out.print("</tr>");
   }
       out.print("</table></form>");
 
       int dimensionCnt = Tools.getInt(QueryEngine.getInstance().doQueryOne("select count(*) from ad_cxtab_dimension where ad_cxtab_id=" + cxtabId), -1);
       StringBuffer attachType = new StringBuffer("[");
       if (dimensionCnt > 0) {
         attachType.append("'cub','csv',");
       }
       if ((com.liferay.util.Validator.isNotNull(jReportPath)) && (jReportPath.endsWith(".jrxml"))) {
         attachType.append("'pdf','xls',");
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