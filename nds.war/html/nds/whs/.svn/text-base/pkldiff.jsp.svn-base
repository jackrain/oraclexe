<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>

<%
/**
  Show diff between m_pick and m_inout
  parameters:
     id - m_pick's id 
     attr - "true" to classify by attribute set instance, else only by product (default)
*/
int pickListId= Tools.getInt(request.getParameter("id"),-1);
boolean bCheckAttributeInstance= "true".equals(request.getParameter("attr"));

String titleName=PortletUtils.getMessage(pageContext, "picking-list-diff",null);
TableManager tm=TableManager.getInstance();
String pname= "\""+tm.getTable("m_product").getDescription(locale)+"\"";
String psdesc= "\""+tm.getTable("m_attributesetinstance").getDescription(locale)+"\"";
String sumpkqty="\""+ PortletUtils.getMessage(pageContext, "sum_pkqty",null)+"\"";
String sumioqty="\""+ PortletUtils.getMessage(pageContext, "sum_ioqty",null)+"\"";
String sumdiffqty="\""+ PortletUtils.getMessage(pageContext, "sum_diffqty",null)+"\"";
String sql;
if(bCheckAttributeInstance)
	sql="select p.name "+pname+", s.description "+psdesc+", sum(pkqty) "+sumpkqty+", sum(ioqty) "+sumioqty+", sum(diffqty) "+sumdiffqty+" from ("+
		"select m_product_id, M_ATTRIBUTESETINSTANCE_ID, l.qty pkqty, 0 ioqty, l.qty diffqty from m_pickitem l where m_pick_id="+pickListId+
		" union all select  m_product_id, M_ATTRIBUTESETINSTANCE_ID,0, MOVE_QTY , -MOVE_QTY from m_inoutitem where m_inout_id=("+
		" select m_inout_id from m_pick where id="+pickListId+")) a, m_product p, m_attributesetinstance s where "+
		" a.m_product_id=p.id(+) and a.M_ATTRIBUTESETINSTANCE_ID=s.id(+) group by p.name, s.description having sum(diffqty)<>0 order by p.name";
else
	sql="select p.name "+pname+", sum(pkqty) "+sumpkqty+", sum(ioqty) "+sumioqty+", sum(diffqty) "+sumdiffqty+" from ("+
		"select m_product_id, l.qty pkqty, 0 ioqty, l.qty diffqty from m_pickitem l where m_pick_id="+pickListId+
		" union all select  m_product_id, 0, MOVE_QTY , -MOVE_QTY from m_inoutitem where m_inout_id=("+
		" select m_inout_id from m_pick where id="+pickListId+")) a, m_product p where "+
		" a.m_product_id=p.id(+) group by p.name having sum(diffqty)<>0 order by p.name";

//System.out.println(sql);
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
        <tr><td align="left">          <br>
<script>
function checkAttr(){
   window.location="<%=NDS_PATH+"/whs/pkldiff.jsp?id="+pickListId+"&attr="%>"+ ( document.getElementById("attrbox").checked?"true":"false");
}
</script>        
<input type="checkbox" id="attrbox" onclick="checkAttr()" value="true" tabIndex="1" class='cbx2' <%=bCheckAttributeInstance?"checked":""%> /><%=PortletUtils.getMessage(pageContext, "show-attribute-diff",null)%>
        </td></tr>
        <tr>
          <td >
			
<jsp:include page="/html/nds/websql/sqlresult.jsp" flush="true" />
          </td>
        </tr>
      </table>

<%@ include file="/html/nds/footer_info.jsp" %>
