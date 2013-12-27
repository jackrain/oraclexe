<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div id="TMPamt_content">
<table width="398" border="0" cellspacing="0" cellpadding="0" class="center01">
  <tr>
    <td><div id="TMPtreatment_td">
      <div id="TMPtreatment_text">单品折扣（S）：</div>
    </div></td>
  </tr>
  <tr>
    <td><div id="TMPtreatment_table"><div>
      <table width="350" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="69" height="20" align="right"><div class="desc-txt">
            <input name="radio_amt" type="radio" checked="checked" onclick="checkradio1();"  />
          </div></td>
          <td width="63" align="left"><span class="desc-txt">折&nbsp;&nbsp;扣&nbsp;&nbsp;率：</span></td>
          <td width="218"><input type="text" id="TMPdiscount_0" name="TMPdiscount_0" size="25" onKeyPress="onReturnprice(event);"/></td>
        </tr>
        <tr>
          <td height="30" colspan="2" align="right"><div class="desc-txt">最低折扣限制：</div></td>
          <td><div id="TMPminrate" class="desc-txt">100.00%</div></td>
        </tr>
        <tr>
          <td height="20" align="right"><span class="desc-txt">
            <input name="radio_amt" type="radio" onclick="checkradio2();" />
          </span></td>
          <td height="20" align="left"><span class="desc-txt">特价金额：</span></td>
          <td><input type="text" id="TMPdiscount_1" name="TMPdiscount_1" size="25"  disabled="disabled" onKeyPress="onReturnprice(event);" /></td>
        </tr>
        <tr>
          <td height="20" colspan="2" align="right"><div class="desc-txt">最低金额限制：</div></td>
          <td><span class="desc-txt" id="TMPminprice">￥1500.00</span></td>
        </tr>
        <tr>
          <td height="20" align="right"><div class="desc-txt">
            <input name="radio_amt" type="radio" onclick="checkradio3();" />
          </div></td>
          <td height="20" align="left"><div class="desc-txt">优惠金额:</div></td>
          <td><span class="desc-txt">
            <input type="text" id="TMPdiscount_2" name="TMPdiscount_2" size="25" disabled="disabled" onKeyPress="onReturnprice(event);" />
          </span></td>
        </tr>
        <tr>
          <td height="20" colspan="2" align="right"><div class="desc-txt">最高优惠金额限制：</div></td>
          <td><span class="desc-txt" id="TMPmaxprice">￥0.00</span></td>
        </tr>
      </table>
    </div></div></td>
  </tr>
  <tr>
    <td><div id="TMPtreatment_td" align="center"><div id="TMPtreatment_text">&nbsp;
<input type="button" value="确定" onclick="javascript:bpos.changamt();" class="qinput" />
&nbsp;
<input  type="button" class="qinput" value="取消" onclick="javascript:bpos.cancelamt();" /></div>
	</div></td>
  </tr>
</table>
</div>
