<%@ page import="java.sql.*,sun.jdbc.rowset.*" %> 
<%@ page import="nds.query.*,nds.control.util.*,nds.control.web.*,nds.report.*,nds.util.*" %> 
<%@ page import="java.util.*,java.text.*" %> 
<%@ page import="java.io.*" %> 
<%@	page errorPage="../error.jsp"%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ taglib uri='/WEB-INF/tld/struts-tiles.tld' prefix='tiles' %>
<%!
  static String sqlpage=""+
  "select yearmon as \"会计年月\",s_qty as \"期初数\", B_LANDQTY as \"本期入库\",B_TRANSINQTY as \"转入\", B_TRANSOUTQTY as \"转出\",B_SALEQTY as \"销售\" ,B_RETURNQTY as \"退货\",B_CHECKQTY as \"盘点调整\",B_ENDQTY as \"期末数\""+
" from shopmmrdsfmitem where customerid=(select id from customer where no='&1') and productid= (select id from product where no='&2') "+
" order by yearmon";

%>
<%
	/**
		Supported param:
			productno- string
			customerno- string 
	*/

// security check
String directory;
directory="WEBSQL_LIST";
WebUtils.checkDirectoryReadPermission(directory,request);
	
	String title="查询产品月流水";
	
String productno=request.getParameter("productno");
String customerno=request.getParameter("customerno");
String sql=null;
if (productno!=null)  {
	sql= StringUtils.replace(sqlTemplate,"&1", customerno);
	sql= StringUtils.replace(sql,"&2", productno);
}

ResultSet results=null;

if( sql !=null){
	Connection conn = QueryEngine.getInstance().getConnection();
	Statement stmt = null;
	ResultSet rs =null;

	try{
		stmt = conn.createStatement();
    	boolean tf = stmt.execute(sql);
    	if (tf ==false){
    		// update sql
    		ValueHolder holder=new ValueHolder();
    		holder.put("message","命令执行成功!") ;
    		request.setAttribute(nds.util.WebKeys.VALUE_HOLDER,holder);
    	}else{
	 		rs= stmt.getResultSet();
	 		results= new CachedRowSet();
            ((CachedRowSet)results).populate(rs);
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

<tiles:insert page='/header.jsp'>
  <tiles:put name='title' value='<%=title%>' direct='true'/>
</tiles:insert>
<br>

 <Script language="javascript">
  function doCommand(form, cmd){
    form.submit();
  }
 </script>
<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">
  <tr>
    <td rowspan=2>&nbsp;</td>
          <td>
<tiles:insert page='/title.jsp'>
  <tiles:put name='title' value='<%=title %>' direct='true'/>

</tiles:insert>
          </td>
          <td rowspan=2>&nbsp;</td>
        </tr>
        <tr>
          <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#cccccc" background="../images/Nds_table_bg_2.gif">
        <tr>
          <td>

<form name="form_list" action="<%=request.getContextPath() %>/websql/flow2.jsp" method="POST">
<table align=center width=98% border=0>
<tr><td width="1%" nowrap>产品编号：</td>
<td>
<input name=productno value='<%=(productno==null?"":productno)%>'>
客户编号：<input name=customerno value='<%=(customerno==null?"":customerno)%>'>

</td></tr>
<tr><td></td><td>
<input class='command_button' type='button' name='Submit' value='提&nbsp;&nbsp;&nbsp;&nbsp;交' onclick="javascript:doCommand(form_list ,'Submit')">
</td></tr>

</table>     
</form> 

          </td>
        </tr>
      </table>
      <br>
    </td>
  </tr>
  <tr><td></td>
  	<td>
<%
	if( results !=null){
		request.setAttribute("sqlresult", results);
%>
		<jsp:include page="sqlresult.jsp" flush="true" />
<%  }
%>
	</td><td></td>
  </tr>
</table>

<br>
<tiles:insert page='/footer.jsp'>
</tiles:insert>
