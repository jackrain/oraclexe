<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div id="TMPdlg_vip_content">
<div id="TMPquery-search-content"> 
<table width="595" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="21"><img src="images/table_left_top.gif" width="21" height="20" /></td>
            <td width="556" background="images/table_center_top.gif" height="20"></td>
            <td width="18"><img src="images/table_right_top.gif" width="18" height="20" /></td>
          </tr>
          <tr>
            <td width="21" background="images/table_left_center.gif"></td>
            <td width="556" valign="top" background="images/table_center_center.gif"><table width="585" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><div id="TMPtreatment_td">
      <div id="TMPtreatment_text">新零售单据：请输入VIP卡号</div>
    </div></td>
  </tr>
  <tr>
    <td><div id="TMPtreatment_table">
	<div><table width="575" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100" height="25" align="right"><div class="desc-txt">VIP卡号：</div></td>
    <td width="109"><input id="TMPvip" type="text" size="50" class="q_input_80" onKeyPress="onReturnvip(event);"/></td>
    <td width="100"><input type="button" value="查询" class="qinput" id="TMPbtn-cancel" onclick="check1();"/></td>
    <td>&nbsp;</td>
 </tr>
</table>
</div>
	<table width="575" border="1" align="center" cellpadding="1" cellspacing="1" bgcolor="#486489" id="TMPmodify_table">
  <tr class="emtb">
    <td width="116" align="right">VIP&nbsp;姓名:</td>
    <td width="147"><span id="TMPvipname"></span></td>
    <td width="150" align="right">VIP&nbsp;类型(T):</td>
    <td width="150"><span id="TMPc_viptype"></span></td>
    </tr>
  <tr class="emtbts">
    <td align="right">出生日期(B):</td>
    <td><span id="TMPbirthday" ></span></td>
    <td align="right">英&nbsp;文&nbsp;&nbsp;名(E):</td>
    <td><span id="TMPvipename"></span></td>
    </tr>
 <tr class="emtb">
    <td width="116" align="right">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别(S):</td>
    <td width="147"><span id="TMPsex"></span></td>
    <td width="150" align="right">身份证号(N):</td>
    <td width="150"><span id="TMPidno"></span></td>
   </tr>
  <tr class="emtbts">
    <td align="right">失效日期(V):</td>
    <td><span id="TMPvaliddate" ></span></td>
    <td align="right"></td>
    <td><span></span></td>
    </tr>
</table>

    </div>
	<div id="TMPtreatment_table"></td>
  </tr>
  <tr>
    <td align="center"><div id="TMPtreatment_td" align="center"><div id="TMPtreatment_text">&nbsp;
     <input type="button" value="确定" class="qinput" id="TMPbtn-cancel" onclick="check2();"/>
&nbsp;
<input  type="button" class="qinput" value="取消" onclick="javascript:bpos.tryClose();" /></div>
	</div>
    </td>
  </tr>
</table></td>
            <td width="18" background="images/table_right_center.gif"></td>
          </tr>
          <tr>
            <td><img src="images/table_left_bottom.gif" width="21" height="20" /></td>
            <td background="images/table_center_bottom.gif">&nbsp;</td>
            <td><img src="images/table_right_bottom.gif" width="18" height="20" /></td>
          </tr>
</table>


</div>
</div>
