<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>

<%
/**
  Show materials that need to replenish of current warehouse
  parameters:
     id - m_warehouse's id 
*/
int warehouseId= Tools.getInt(request.getParameter("id"),-1);

String titleName=PortletUtils.getMessage(pageContext, "difference",null);
TableManager tm=TableManager.getInstance();
String pname= "\""+tm.getTable("m_product").getDescription(locale)+"\"";
String sqtyonhand= "\""+tm.getColumn("m_storage","qtyonhand").getDescription(locale)+"\"";
String sqtyordered="\""+tm.getColumn("m_storage","qtyordered").getDescription(locale)+"\"";
String sqtytotal="\""+ PortletUtils.getMessage(pageContext, "total-sum",null)+"\"";
Column replenishType= tm.getColumn("m_replenish","replenishtype");
String replenishtype="\""+ replenishType.getDescription(locale)+"\"";
String levelm="\""+ PortletUtils.getMessage(pageContext, "replenish-level",null)+"\"";
String diff="\""+ PortletUtils.getMessage(pageContext, "difference",null)+"\"";
String below=tm.getColumnValueDescription(replenishType.getId(),"B",locale);
String keep=tm.getColumnValueDescription(replenishType.getId(),"K",locale);

String sql="SELECT P.NAME "+pname+", D.SQTYONHAND "+sqtyonhand+",D.SQTYORDERED "+sqtyordered+",D.SQTYTOTAL "+sqtytotal+", D.REPLENISHTYPE "+replenishtype+",D.LEVELM "+levelm+",D.DIFF "+diff+" from("+
" SELECT S_PRODUCT_ID, SQTYONHAND,SQTYORDERED,SQTYTOTAL, DECODE(E.REPLENISHTYPE,'B','"+below+"','"+keep+"') REPLENISHTYPE,"+
" DECODE(E.REPLENISHTYPE,'B',E.LEVEL_MIN,E.LEVEL_MAX) LEVELM, DECODE(E.REPLENISHTYPE,'B',E.LEVEL_MIN,E.LEVEL_MAX)- SQTYTOTAL DIFF FROM ("+
" SELECT S.M_PRODUCT_ID S_PRODUCT_ID, SUM(S.QTYONHAND) SQTYONHAND, SUM(S.QTYORDERED) SQTYORDERED, NVL(SUM(S.QTYONHAND),0)+NVL(SUM(S.QTYORDERED),0) SQTYTOTAL"+
" FROM M_STORAGE S WHERE M_WAREHOUSE_ID="+warehouseId+" AND EXISTS (SELECT 1 FROM M_REPLENISH R WHERE R.M_WAREHOUSE_ID="+warehouseId+" AND R.M_PRODUCT_ID=S.M_PRODUCT_ID)"+
" GROUP BY S.M_PRODUCT_ID ) A, M_REPLENISH E WHERE E.M_WAREHOUSE_ID="+warehouseId+" AND E.M_PRODUCT_ID=A.S_PRODUCT_ID AND"+
" (( A.SQTYTOTAL<E.LEVEL_MIN AND E.REPLENISHTYPE='B') or (A.SQTYTOTAL<E.LEVEL_MAX AND E.REPLENISHTYPE='K'))) D, M_PRODUCT P WHERE P.ID= D.S_PRODUCT_ID";

ResultSet rs= QueryEngine.getInstance().doQuery(sql);
request.setAttribute("sqlresult", rs);
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=titleName%>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="table_width" value="100%" />
	<liferay-util:param name="enable_context_menu" value="true" />	
</liferay-util:include>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#cccccc">
        <tr>
          <td >
          <br>

<jsp:include page="/html/nds/websql/sqlresult.jsp" flush="true" />
          </td>
        </tr>
      </table>

<%@ include file="/html/nds/footer_info.jsp" %>
