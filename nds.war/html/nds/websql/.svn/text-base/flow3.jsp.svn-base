<%@ page import="java.sql.*,sun.jdbc.rowset.*" %> 
<%@ page import="nds.query.*,nds.control.util.*,nds.control.web.*,nds.report.*,nds.util.*" %> 
<%@ page import="java.util.*,java.text.*" %> 
<%@ page import="java.io.*" %> 
<%@	page errorPage="../error.jsp"%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ taglib uri='/WEB-INF/tld/struts-tiles.tld' prefix='tiles' %>
<%!
  static String sqlpage=""+
  "select DTYPE as \"类型\", qty as \"数量\",theDay, AP as \"会计年月\", NO as \"单据编号\",sheettype as \"单据类型\", PEER as \"对方门店\" from ("+
"SELECT '滞后盘点' dtype, qty, no, '滞后盘点' sheettype, 'N/A' peer, to_char(checkdate,'YYYY-MM-DD HH24:MI:SS') theDay, 'N/A' ap"+
"	from  monthcustcheckshtitem item, monthcustchecksht sht where "+
"	item.monthcustcheckshtid= sht.id and item.productid =(select id from product where no='&2') "+
"	and item.customerid=(select id from customer where no='&1') "+
"union all	"+
"select '客户收货' dtype,RECQTY qty, sheetno,"+
" decode(SHEETTYPE,1,'退货到货通知',2,'配货出库',3,'收货数量误差调整',4,'退货数量误差调整',5,'代销商店转移','???'),"+
"	 SENDNO peer,to_char(to_date(recdate,'YYYYMMDD'),'YYYY-MM-DD HH24:MI:SS') theDay, to_char(ap)"+
"  from outletrecftp where RECCUSTNO ='&1' and productno='&2'"+
"  and recdate >= 20031201"+
" union all  "+
"  select '销售', -qty, OUTLETDAYSALESHTNO, '销售', null, "+
"  to_char(DAYSALEDATE,'YYYY-MM-DD HH24:MI:SS'), null from outletdaysaleftp"+
"  where CUSTOMERNO='&1' and productno='&2'"+
" UNION ALL"+
"  select '盘点误差', ADJQTY, CHEQTYERRADJSHTNO, '盘点误差', null, "+
"  to_char(SHEETSUBMITDATE,'YYYY-MM-DD HH24:MI:SS'), to_char(ap) from CheQtyErrAdjFtp"+
"  where OUTLETWHNO='&1' "+
"  and productno='&2'"+
" union all"+
"  select '当前库存',   OUTLETSTORAGE, 'N/A', '当前库存', null, null, null from"+
"  outletstorage where customerid=(select id from customer where no='&1') "+
"  and productid= (select id from product where no='&2') "+
" union all"+
"  select '有POS盘点库存', checkqty, no,    '盘点库存', null,"+
"  to_char(modifieddate,'YYYY-MM-DD HH24:MI:SS'), 'N/A' from checksht sht, checkshtitem item"+
"  where shopid=(select id from customer where no='&1') and productid= (select id from product where no='&2')"+
"  and item.checkshtid=sht.id "+
" union all"+
"  select '盘点库存', CHESTORAGE, no,    '盘点库存', null,"+
"  to_char(modifieddate,'YYYY-MM-DD HH24:MI:SS'), 'N/A' from outletcheqtyerrsht sht, outletcheqtyerrshtitem item"+
"  where customerid=(select id from customer where no='&1') and productid= (select id from product where no='&2')"+
"  and item.OUTLETCHEQTYERRSHTID=sht.id"+
" ) order by theDay";
  

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
	
	String title="查询产品流水";
	
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

<form name="form_list" action="<%=request.getContextPath() %>/websql/flow.jsp" method="POST">
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
