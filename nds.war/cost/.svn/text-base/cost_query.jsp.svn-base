<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%= PortletUtils.getMessage(pageContext, "price-query",null) %>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="enable_context_menu" value="true" />	
	<liferay-util:param name="table_width" value="100%" />
</liferay-util:include>
<script language="JavaScript" src="/html/nds/js/formkey.js"></script>
<script type='text/javascript' src='/html/nds/js/dw_scroller.js'></script>
<script language="javascript" src="<%=NDS_PATH%>/js/calendar.js"></script>
<script type='text/javascript' src='/html/nds/js/util.js'></script> 
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<script language="javascript" src="/html/nds/js/application.js"></script>
<script language="javascript" src="/html/nds/js/alerts.js"></script>
<script language="javascript" src="/cost/cost.js"></script>
<script type="text/javascript" src="/html/nds/js/init_object_query_zh_CN.js"></script>
<link type="text/css" rel="stylesheet" href="/cost/link.css">
<form id="cost_query" name="cost_query" method="post">
	<br>
<table width="920" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="876" valign="top"><table width="540" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center" valign="top"><div class="from_top_text_list"></div></td>
              </tr>
              <tr>
                <td align="center" valign="top"><div>
				<ul class="Var-Index-width">
				<li>
				<div class="left"><%= PortletUtils.getMessage(pageContext, "dealer_query",null) %><font color="red">*</font>:</div>
				<div class="right">
					<input type="text" id="dealer_query" name="dealer_query" class="Warning_query" onkeypress="pc.onSearchReturn(event)"/>
					<input type='hidden' name="dealer_query_sql" id="dealer_query_sql" />
                    <input type='hidden' name="dealer_query_filter" id="dealer_query_filter"/>
					<span id="dealer_query_link" title="popup" onaction="oq.toggle_m('/html/nds/query/search.jsp?table=c_customer&return_type=m&accepter_id=dealer_query','dealer_query')">
						<img  id="dealer_query_img" border=0 width=16 height=16 align=absmiddle src='/html/nds/images/filterobj.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'></span> 
				</div>
					<script>createButton(document.getElementById("dealer_query_link"));</script>	
				<div class="HackBox"/>
				</li>
				<li>
				<div class="left"><%= PortletUtils.getMessage(pageContext, "productname_query",null)%><font color="red">*</font>:</div>
				<div class="right"><input type="text" id="product_query" name="product_query" class="Warning_query" onkeypress="pc.onSearchReturn(event)"/>
					<input type='hidden' name="product_query_sql" id="product_query_sql" />
                    <input type='hidden' name="product_query_filter" id="product_query_filter"/>
					<span id="product_query_link" title="popup" onaction="oq.toggle_m('/html/nds/query/search.jsp?table=m_product&return_type=m&accepter_id=product_query','product_query')">
						<img  id="product_query_img" border=0 width=16 height=16 align=absmiddle src='/html/nds/images/filterobj.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'>
						</span> 
				</div>
				<script>createButton(document.getElementById("product_query_link"));</script>	
				<div class="HackBox"/>
				</li>
				<li>
				<div class="left">&nbsp;</div>
				<div class="right01"><input type="button" value="<%= PortletUtils.getMessage(pageContext, "return-value",null)%>" onclick="cost.price_query();" /></div>
				<div class="HackBox"/>
				</li>
				</ul>
				</div></td>
              </tr>
              <tr>
			  <td>&nbsp;</td>
			  </tr>
              <tr>
			  <td><table width="500" id="modify_table" cellspacing="1" cellpadding="1" border="1" bgcolor="#486489" align="center">
                <tr class="emtb">
                  <td align="center">经销商</td>
                  <td align="center">商品款号</td>
                  <td align="center">商品品名</td>
                  <td align="center">标准价</td>
                  <td align="center">期货价</td>
                  <td align="center">现货价</td>
                  <td align="center">退货价</td>
                </tr>
                <tr id="price_query_row" style="display:none;" class="emtbts">
                  <td id="retailer_query" >&nbsp;</td>
                  <td id="productname_query" >&nbsp;</td>
                  <td id="productvalue_query" >&nbsp;</td>
                  <td id="pricelist_query" align="right">&nbsp;</td>
                  <td id="price_futures_query" align="right">&nbsp;</td>
                  <td id="price_hand_query" align="right">&nbsp;</td>
                  <td id="price_return_query" align="right">&nbsp;</td>
                </tr>
              </table></td>
			  </tr>
            </table></td>
          </tr>
</table>