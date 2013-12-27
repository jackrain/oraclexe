<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="价格复制" />
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
<form id="cost_copy" name="cost_copy" method="post">
	<br>
<table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="800" valign="top">
            	<table width="550" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center" valign="top"><div class="from_top_text_list1"></div>
                	<div class="HackBox"/>
                	</td>
              </tr>
              <tr>
                <td align="center" valign="top">
				<ul class="Var-Index-width1">
				<li>
				<div class="left001">
					
				<div class="left002">源经销商<font color="red">*</font>:</div>
				<div class="right002">
					<input type="text" id="dealer_query2" name="dealer_query2" class="Warning_copy" onkeypress="pc.onSearchReturn(event)"/>
					<input type='hidden' name="dealer_query2_sql" id="dealer_query1_sql" />
          <input type='hidden' name="dealer_query2_filter" id="dealer_query1_filter"/>
					<input type="hidden" id="fk_dealer_query2" name="fk_dealer_query2"/>
                    
                    <!--如果是单选：调用 oq.toggle(....return_type=s...)-->
					<span id="dealer_query2_link" title="popup" onaction="oq.toggle('/html/nds/query/search.jsp?table=c_customer&return_type=s&accepter_id=dealer_query2','dealer_query2')">
						<img  id="dealer_query2_img" border=0 width=16 height=16 align=absmiddle src='/html/nds/images/filterobj.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'></span> 
				</div>
					<script>createButton(document.getElementById("dealer_query2_link"));</script>
				</div>
				
			<div class="right001">
					
				<div class="left003">目标经销商<font color="red">*</font>:</div>
				<div class="right003">
					<input type="text" id="dealer_query1" name="dealer_query1" class="Warning_copy" onkeypress="pc.onSearchReturn(event)"/>
					<input type='hidden' name="dealer_query1_sql" id="dealer_query1_sql" />
                    <input type='hidden' name="dealer_query1_filter" id="dealer_query1_filter"/>
                   <!--如果是多选：调用 oq.toggle_m(...return_type=m...)-->
					<span id="dealer_query1_link" title="popup" onaction="oq.toggle_m('/html/nds/query/search.jsp?table=c_customer&return_type=m&accepter_id=dealer_query1','dealer_query1')">
						<img  id="dealer_query1_img" border=0 width=16 height=16 align=absmiddle src='/html/nds/images/filterobj.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'>
						</span> 
				</div>
				<script>createButton(document.getElementById("dealer_query1_link"));</script>	
					
			</div>
			<div class="HackBox"></div>
			<div class="HackBox"></div>
				</li>
				<li>
				<div class="right01"><input type="button" value="确认复制" onclick="cost.price_copy();" /></div>
				<div class="HackBox"/>
				</li>
				<li>
				<div class="result001" name="result001" id="result001"></div>
			  </li>
				</ul>
				</td> 
              </tr>
              <tr>
			  <td></td>
			  </tr>
            </table>
            </td>
          </tr>
		  <script>
			document.getElementById("dealer_query2").readOnly=true;
			document.getElementById("dealer_query1").readOnly=true;
		  </script>
</table>
<a href="/html/nds/distribution/index.jsp">aaaaaaa</a>