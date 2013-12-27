<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>

<%@page import="java.sql.*,sun.jdbc.rowset.*" %> 

<%
	/**
		Supported param:
		    datasource - string datasource,default to "java:/DataSource"
			sql- string
			excel - string , if not null, should be the excel file name to be stored, 
					the file will be located at reports repository.
	*/

// security check
String directory;
directory="WEBSQL_LIST";
WebUtils.checkDirectoryWritePermission(directory,request);

Properties props=EJBUtils.getApplicationConfig().getConfigurations("schema").getProperties();
if(! "true".equalsIgnoreCase(props.getProperty("modify","true"))){
	throw new NDSException("@no-permission@");
}
	
String title="WEBSQL";
	
String datasource=request.getParameter("datasource");
if(nds.util.Validator.isNull(datasource)) datasource= "java:/DataSource";
String sql=request.getParameter("sql");
String excel=request.getParameter("excel");
String ddl= request.getParameter("ddl");
boolean doSQL=(sql !=null && sql.trim().length()>0);
boolean doExcel= (excel !=null && excel.trim().length()>0);
boolean doDDL="true".equals(ddl);
if(doSQL)WebUtils.checkDirectoryWritePermission(directory,request);

ResultSet results=null;

if(doSQL & doExcel){
	// save to file
	 ReportUtils ru = new ReportUtils(request);
    String name = ru.getUserName();
    String svrPath = ru.getExportRootPath() + File.separator  + ru.getUser().getClientDomain()+File.separator+ name;
    String passPath = ru.getOracleExportRootPath() + File.separator  + ru.getUser().getClientDomain()+File.separator+ name;
	
	String fileName;
    if (!excel.endsWith(".xls")) fileName=excel + ".xls";
    else fileName=excel;

    String filePath = svrPath + File.separator + fileName;
    File file = new File(filePath);

    File svrDir = new File(svrPath);
    if(!svrDir.isDirectory()){
        svrDir.mkdirs();
    }
	nds.excel.ExportExcelBySQL ee=new nds.excel.ExportExcelBySQL();
	ee.setParameter("sql", sql);
	ee.setParameter("location", passPath);
	ee.setParameter("filename", fileName);
	ee.setParameter("datasource", datasource);
	Thread thread=new Thread(ee);
	thread.start();
    pageContext.getServletContext().getRequestDispatcher(NDS_PATH+"/reports/index.jsp").forward(request,response);
    return;
    
}
if( doSQL & !doExcel ){
	javax.naming.InitialContext ctx=new javax.naming.InitialContext();
    javax.sql.DataSource ds= (javax.sql.DataSource) ctx.lookup (datasource);
	Connection conn = ds.getConnection();
	Statement stmt = null;
	ResultSet rs =null;
    		nds.control.util.ValueHolder hd=new nds.control.util.ValueHolder();
    		hd.put("message","Success!") ;
	try{
		stmt = conn.createStatement();
		String[] sqls= sql.split(";");
		if (sqls.length==1){
    	boolean tf = stmt.execute(sql);
    	if (tf ==false){
    		// update sql
    		request.setAttribute(nds.util.WebKeys.VALUE_HOLDER,hd);
    	}else{
	 		rs= stmt.getResultSet();
	 		results= new CachedRowSet();
            ((CachedRowSet)results).populate(rs);
		}
		}else{
			for(int i=0;i<sqls.length;i++){
				stmt.addBatch(sqls[i]);
			}
			stmt.executeBatch();
			request.setAttribute(nds.util.WebKeys.VALUE_HOLDER,hd);
		}
	}catch(Exception e){
		
		request.setAttribute("error", e);
	}finally{
		if(rs!=null)try{ rs.close();}catch(Exception e){}
		if(conn!=null)try{ conn.close();}catch(Exception e){}
	}
}

	SimpleDateFormat sdf = new SimpleDateFormat("MMddHHmm");
	request.setAttribute("cachepage","true");// this is set to allow page be cached, @see /head.jsp
	
%>

<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="show_top" value="true" />
</liferay-util:include>
<br>

 <Script language="javascript">
  document.title="<%=title%>";
  function doCommand(form){
    submitForm(form);
  }
  function getDDL(form){
  	form.ddl.value='true';
  	submitForm(form);
  }
     function checkExcel(form){
		if(form.saveToExcel.checked==0){
			form.excel.disabled=1;
			form.excel.value="";
		}else{
			form.excel.disabled=0;
			form.saveToExcel.blur();
			form.excel.value="<%="SQL"+sdf.format(new java.util.Date())+".xls"%>";
		}
    }
  
 </script>
<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">

        <tr>
          <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#cccccc" background="../images/Nds_table_bg_2.gif">
        <tr>
          <td>
 <form name="form_list" action="<%=NDS_PATH%>/websql/index.jsp" method="POST">
 <input type='hidden' name='ddl' value='false'>
<table align=center width=98% border=0>
<tr>
<td width="1%" nowrap>DataSource:</td><td><input type="text" class="text" name="datasource" size="25" value="<%=datasource%>"></td>
</tr>
<tr>
<td width="1%" nowrap>SQL:</td>
<td><textarea wrap=PHYSICAL id="FormsMultiLine1" name="sql" rows=8 cols=65><%=(sql==null?"":sql)%></textarea></td>
</tr>
<tr><td width="1%" nowrap>To Excel</td>
<td><input type="checkbox" name="saveToExcel" value=<%=(doExcel?"1":"0")%> onClick="javascript:checkExcel(form_list)">
	<input type="text" class="text" name="excel" <%=(doExcel?"":"disabled")%> size="25">
	<input type='button' name='Submit' value='<%= PortletUtils.getMessage(pageContext, "object.submit",null)%>' onclick="javascript:doCommand(form_list)">
	</td>
	
</tr>

</table>     
</form> 

          </td>
        </tr>
      </table>
      <br>
    </td>
  </tr>
  <tr>
  	<td>
<%
	if( results !=null){
		request.setAttribute("sqlresult", results);
%>
		<jsp:include page="/html/nds/websql/sqlresult.jsp" flush="true" />
<%  }
%>
	</td>
  </tr>
</table>

<br>
<%@ include file="/html/nds/footer_info.jsp" %>

