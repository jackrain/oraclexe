<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>


<div id="TMPdlg_vip_content">
<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><div id="TMPtreatment_td">
      <div id="TMPtreatment_text">新零售单据：请输入VIP卡号或姓名</div>
    </div></td>
  </tr>
  <tr>
    <td><div id="TMPtreatment_table">
	<div><table width="580" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="52" height="25" align="right"><div class="desc-txt">VIP卡号(N)：</div></td>
    <td width="109"><input name="text" id="TMPvip" type="text" class="q_input_80" /></td>
    </tr>
  <tr>
    <td height="25" align="right"><div class="desc-txt">手&nbsp;机&nbsp;号(I)：</div></td>
    <td><input id="TMPtele" name="text2" type="text" class="q_input_80" /></td>
    </tr>
  <tr>
    <td height="25" align="right"><div class="desc-txt">VIP姓名(I)：&nbsp;</div></td>
    <td><input id="TMPname" name="text22" type="text" class="q_input_80" /></td>
    </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</div>
	<table width="585" border="1" align="center" cellpadding="1" cellspacing="1" bgcolor="#486489" id="TMPmodify_table">
  <tr class="emtb">
    <td width="116" align="right">VIP&nbsp;姓名：</td>
    <td width="167"><span id="TMPvipname"></span></td>
    <td width="150" align="right">VIP&nbsp;类型(T):</td>
    <td width="150"><span id="TMPc_viptype"></span></td>
    </tr>
  <tr class="emtbts">
    <td align="right">英文名(E)：</td>
    <td><span id="TMPvipename"></span></td>
    <td align="right">出生日期(B):<br /></td>
    <td><span id="TMPbirthday" ></span></td>
    </tr>
  <tr class="emtb">
    <td align="right">性&nbsp;&nbsp;&nbsp;&nbsp;别(S)：</td>
    <td><span id="TMPsex"></span></td>
    <td align="right">身份证号(N):</td>
    <td><span id="TMPidno"></span></td>
    </tr>
  <tr class="emtbts">
    <td align="right">失效日期(V):</td>
    <td><span id="TMPvaliddate" ></span></td>
    <td align="right">&nbsp;</td>
    <td><span></span></td>
    </tr>
</table>
    </div>
  </tr>
  <tr>
    <td align="center"><div id="TMPtreatment_td" align="center"><div id="TMPtreatment_text">&nbsp;
<input type="button" value="确定" id="TMPbtn-cancel" onclick="check2();" class="qinput" />
&nbsp;
<input name="c" type="button" class="qinput" value="取消"  onclick="javascript:bpos.tryClose();"  /></div>
	</div>
    </td>
  </tr>
</table>
</div>