<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div id="TMPamt_content">
<table width="395" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><div id="TMPtreatment_td">
      <div id="TMPtreatment_text">单品折扣（S）：</div>
    </div></td>
  </tr>
  <tr>
    <td><div id="TMPtreatment_table"><div id="amount_botder">
      <table width="350" border="0" align="center" cellpadding="0" cellspacing="0" id="TMPcategoryTable_single">
        <tr>
          <td width="69" height="20" align="right"><div class="desc-txt">
            <input name="radio_amt" type="radio" value="radiobutton" checked="checked" onclick="checkradio(0);"/>
          </div></td>
          <td width="63" align="left"><span class="desc-txt">折&nbsp;&nbsp;扣&nbsp;&nbsp;率：</span></td>
          <td width="218"><input type="text" id="TMPdiscount_0" name="TMPdiscount_0" size="25" onblur="bpos.checkdiscount();"/></td>
        </tr>
        <tr id="TMPdiscount0"style="display:none">
          <td height="30" colspan="2" align="right"><div class="desc-txt">最低折扣限制：</div></td>
          <td><div id="TMPminrate" class="desc-txt">100.00%</div></td>
        </tr>
        <tr>
          <td height="20" align="right"><span class="desc-txt">
             <input name="radio_amt" type="radio" onclick="checkradio(1);" />
          </span></td>
          <td height="20" align="left"><span class="desc-txt">零售金额：</span></td>
          <td><input type="text" id="TMPdiscount_1" name="TMPdiscount_1" size="25"  disabled="disabled" onblur="bpos.checkamount(1);" /></td>
        </tr>
        <tr id="TMPdiscount1"style="display:none">
          <td height="20" colspan="2" align="right"><div class="desc-txt">最低金额限制：</div></td>
          <td><span class="desc-txt" id="TMPminprice">￥1500.00</span></td>
        </tr>
        <tr>
          <td height="20" align="right"><div class="desc-txt">
            <input name="radio_amt" type="radio" onclick="checkradio(2);" />
          </div></td>
          <td height="20" align="left"><div class="desc-txt">优惠金额：</div></td>
          <td><span class="desc-txt">
            <input type="text" id="TMPdiscount_2" name="TMPdiscount_2" size="25" disabled="disabled" onblur="bpos.checkamount(2);" />
          </span></td>
        </tr>
        <tr id="TMPdiscount2"style="display:none">
          <td height="20" colspan="2" align="right"><div class="desc-txt">最高优惠金额限制：</div></td>
          <td><span class="desc-txt" id="TMPmaxprice">￥0.00</span></td>
        </tr>
      </table>
    </div></div></td>
  </tr>
  <tr>
    <td><div id="treatment_td" align="center">
    	<div id="TMPtreatment_text">&nbsp;<input type="button" value="确定" onclick="javascript:bpos.changamt();" class="qinput" id="TMPbtn-ok"/>&nbsp;
			<input  id="TMPcancle" type="button" class="qinput" value="取消" onclick="javascript:bpos.cancelamt();" />
			<input  id="TMPzody_btn_sOh" type="button" class="qinput" value="显示/隐藏" onclick="javascript:bpos.show2_Model();" /></div>
	</div></td>
  </tr>
</table>
</div>

