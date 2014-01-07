<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div id="itemtable" style="height:95%;">
<table width="833" height="100%" border="1" align="center" cellpadding="0" cellspacing="0" id="modify_table">
 <thead>
	<tr id="modify_table_tr">
    <td width="28">&nbsp;</td>
    <td width="70" style="font-size:17px;" align="center">商品</font></td>
    <td width="46" style="font-size:17px;" align="center">品名</td>
    <td width="36" style="font-size:17px;" align="center">数量</td>
    <td width="68" style="font-size:17px;" align="center">标准价</td>
    <td width="54" style="font-size:17px;" align="center">折扣</td>
    <td width="67" style="font-size:17px;" align="center">成交价</td>
    <td width="71" style="font-size:17px;" align="center">成交金额</td>
    <td width="51" style="font-size:17px;" align="center">营业员</td>
    <td width="51" style="font-size:17px;" align="center">状态</td>
  </tr>
</thead>
 <tbody id="content">
    <%
       boolean flag =false;
       for(int i=0;i<10;i++){
        flag=!flag;
     %>
      
    <tr id=<%=i%>_m_retailrow  class="emtbts" >
    <td id=<%=i%>_m_retail style="font-size:15px;" align="center">&nbsp;</td>
    <td id=<%=i%>_m_retail_productno style="font-size:15px;" align="center">&nbsp;</td>
    <td id=<%=i%>_m_retail_productvalue style="font-size:15px;" align="center">&nbsp;</td>
    <td id=<%=i%>_m_retail_qty align="right" style="font-size:15px;" align="center">&nbsp;</td>
    <td id=<%=i%>_m_retail_pricelist align="right" style="font-size:15px;" align="center">&nbsp;</td>
    <td id=<%=i%>_m_retail_discount align="right" style="font-size:15px;" align="center">&nbsp;</td>
    <td id=<%=i%>_m_retail_priceactual align="right" style="font-size:15px;" align="center">&nbsp;</td>
    <td id=<%=i%>_m_retail_price align="right" style="font-size:15px;" align="center">&nbsp;</td>
    <td id=<%=i%>_m_retail_saler style="font-size:15px;" align="center">&nbsp;</td>
    <td id=<%=i%>_m_retail_type style="font-size:15px;" align="center">&nbsp;</td>
  </tr>
   <%}
   %>
<tr id="m_retailrow" style="display:none;" class="emtbts">
	<td width="28" id="m_retail">&nbsp;</td>
    <td width="70" id="m_retail_productno" style="font-size:15px;" align="center">&nbsp;</td>
    <td width="55" id="m_retail_productvalue" style="font-size:15px;" align="center">&nbsp;</td>
    <td width="36" id="m_retail_qty" align="right" style="font-size:15px;" align="center">&nbsp;</td>
    <td width="68" id="m_retail_pricelist" align="right" style="font-size:15px;" align="center">&nbsp;</td>
    <td width="54" id="m_retail_discount" align="right" style="font-size:15px;" align="center">&nbsp;</td>
    <td width="75" id="m_retail_priceactual" align="right" style="font-size:15px;" align="center">&nbsp;</td>
    <td width="71" id="m_retail_price" align="right" style="font-size:15px;" align="center">&nbsp;</td>
    <td width="51" id="m_retail_saler" style="font-size:15px;" align="center">&nbsp;</td>
    <td width="55" id="m_retail_type" style="font-size:15px;" align="center">&nbsp;</td>
  </tr>
</tbody>
</table>
</div>
