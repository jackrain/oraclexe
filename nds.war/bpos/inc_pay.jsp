<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div id="TMPpayment_content" class="payment_content">
	<div id="TMPquery-search" class="query-search">
		<div id="TMPq_border">
		   <div id="payment_table" class="payment-table">
	<div class="payment-table-head">
	<div class="payment-span-1">付款方式</div><div class="payment-span-2">金额</div>
</div></div>

<div id="TMPpayment-main" class="payment-sidebar" style="height: 172px; width: 245px; visibility: visible; opacity: 1;">	
</div>
		</div>
	</div>
	<div id="TMPquery-search-tab">
	  <ul class="ui-tabs-nav"><li class="ui-tabs-selected"><a href="#qtab1"><span>付款</span></a></li></ul>
		<div id="TMPqtab1" class="ui-tabs-panel" style="display: block;">
			<div id="TMPq_search_condition">
				<table cellspacing="1" cellpadding="1" border="0" width="280">
				<tbody>
					<tr>
			      <td nowrap="" height="18" width="10%" align="right"><div class="desc-txt">当前交易应付款：</div></td>
			      <td nowrap="" height="18" width="21%" align="left"><div id="TMPpayable"  class="payment-input"></div></td>
			    </tr>
			    <tr>
			      <td nowrap="" height="18" width="10%" align="right"><div class="desc-txt">顾客付款方式：</div></td>
			      <td nowrap="" height="18" width="21%" align="left">
			        <select id="TMPpayselect" name="TMPselect" class="payment-input"">
			        </select>
			      </td>
			    </tr>
			    <tr>
			      <td nowrap="" height="18" align="right"><div class="desc-txt">支付：</div></td>
			      <td nowrap="" height="18" align="left"><input id="TMPcurrpay" name="text"  class="payment-txt" /></td>
			    </tr>
			    <tr>
			      <td nowrap="" height="18" align="right"><div class="desc-txt">已付款总额：</div></td>
			      <td nowrap="" height="18" align="left"><div id="TMPpaidamount" class="q_input"></div></td>
			    </tr>

			    <tr>
			      <td nowrap="" height="18" align="right"><div class="desc-txt">未付款总额：</div></td>
			      <td nowrap="" height="18" align="left"><div id="TMPunpaidamount" class="payment-input"></div></td>
			    </tr>
			    <tr>
			      <td nowrap="" height="18" align="right"><div class="desc-txt">找零：</div></td>
			      <td nowrap="" height="18" align="left"><div id="TMPcharge" class="payment-txt02"></div></td>
			    </tr>
			    <tr>
			       <td height="18" colspan="2" align="center" nowrap=""><textarea id="TMPdiscription" class="payment-textarea" name="" cols="20" rows="3" readonly="true"></textarea></td>
			    </tr>
			   </tbody>
			  </table>
			</div>
		</div>     
	</div>
	<div id="TMPqbtns">
		<input type="button" id="TMPnext" value="确定" onclick="javascript:bpos.save()" class="qinput" id="btn-search"/>
		&nbsp;
		<input type="button" id="TMPre" value="重付" onclick="javascript:bpos.repay()" class="qinput" id="btn-cancel"/>
		&nbsp;
		<input name="cancle" type="button" id="TMPcancle" class="qinput" value="取消"  onclick="javascript:bpos.payclose()"/>
		&nbsp;
	</div>
</div>