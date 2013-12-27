<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div id="TMPpayment_content" class="payment_content">
<div id="TMPpayment-search">
<div id="TMPq_border">
<div id="TMPpayment_table" class="payment-table">
	<div class="payment-table-head">
	<div class="payment-span-1">付款方式</div><div class="payment-span-2">金额</div>
</div></div>

<div id="TMPpayment-main" class="payment-sidebar" style="height: 170px; width: 245px; visibility: visible; opacity: 1;">	
</div>

</div>
</div>
<div id="TMPquery-search-tab">
<ul class="ui-tabs-nav">
<li class="ui-tabs-selected"><a onclick="bxl.pay()" style="cursor:pointer" id="TMPm"><span>付款</span></a></li>
<li class="" ><a onclick="bxl.vip()" id="TMPv" style="display:none;cursor:pointer"><span>VIP付款</span></a></li>
</ul>
<div id="TMPVIP" class="ui-tabs-panel" style="display: none;">
<div class="payment-VIP">
<ul>
<li>
<div class="vipLeft">卡&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:</div>
<div class="vipRight" id="TMPvip_cardno"></div>
</li>
<li>
<div class="vipLeft">卡内余额:</div>
<div class="vipRight01" id="TMPvip_money"></div>
</li>
<li>
<div class="vipLeft">应&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;付:</div>
<div class="vipRight" id="TMPvip_paymoney"></div>
</li>
<li>
<div class="vipLeft">未&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;付:</div>
<div class="vipRight" id="TMPvip_pay"></div>
</li>

<li>
<div class="vipLeft">支&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;付:</div>
<div class="vipRight02"><input style="text-align:right;" id="TMPvip_currpay" name="" type="text" class="payment-vipTxt" /></div>
</li>
<li>
<div class="vipLeft">支付密码:</div>
<div class="vipRight02"><input name="" id="TMPvip_psw" type="password" class="payment-vipTxt" /></div>
</li>
<li>
<div class="vipBtns">
<input type="button" value="付款" class="ok" id="TMPvip_btn-search"/>
&nbsp;

</div>
</li>
</ul>
</div>
</div>

<div id="TMPqtab1" class="ui-tabs-panel" style="display: block;">
<div id="TMPq_search_condition">
<table cellspacing="1" cellpadding="1" border="0" width="280">
<tbody>
	<tr>
      <td nowrap="" height="18" width="10%" align="right"><div class="desc-txt">当前交易应付款：</div></td>
      <td nowrap="" height="18" width="21%" align="left"><div id="TMPpayable"  class="payment-input"></div></td>
      </tr>
  <tr>
      <td nowrap="" height="18" width="10%" align="right"><div class="desc-txt">顾客付款方式：</div>      </td>
      <td nowrap="" height="18" width="21%" align="left">
       <select id="TMPpayselect" name="TMPselect" class="payment-input""></select></td>
      </tr>
<tr>
  <td nowrap="" height="18" align="right"><div class="desc-txt">支付：</div></td>
  <td nowrap="" height="18" align="left"><input id="TMPcurrpay" name="text"   class="payment-txt" style="text-align:right;" /></td>
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
  <td nowrap="" height="18" align="right"><div class="desc-txt">充值金额：</div></td>
  <td nowrap="" height="18" align="left"><div id="TMPrecharge" class="payment-txt02"></div></td>
  </tr>
<tr>
<tr>
  <td nowrap="" height="18" align="right"><div class="desc-txt">找零：</div></td>
    <td nowrap="" height="18" align="left"><div id="TMPcharge" class="payment-txt02"></div></td>
  </tr>
<tr>
  <td height="18" colspan="2" align="center" nowrap=""><textarea id="TMPdiscription" cols="30" rows="3" class="payment-textarea" readOnly="true">
  </textarea></td>
  </tr>
</tbody></table>
</div>
</div>      
</div>
<div id="TMPqbtns">
<input type="button" value="确定" onclick="javascript:bpos.save()"  class="qinput" id="TMPnext"/>
&nbsp;
<input type="button" value="重付"  onclick="javascript:bpos.repay()" class="qinput" id="TMPre"/>
&nbsp;
<input id="TMPcancle" type="button" class="qinput" value="取消" onclick="javascript:bpos.payclose()"/>
&nbsp;</div>
</div>

