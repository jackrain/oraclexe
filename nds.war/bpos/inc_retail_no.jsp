<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div id="TMPr_retail_no_content">
<form id="TMPform2" name="form2"  method="post" onsubmit="return false;">
<div id="TMPquery-search-content-inc" class="sumfooter">
<table width="385" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><div id="TMPtreatment_td_inc">
      <div id="TMPtreatment_text">零售退货</div><input id="TMPretail" type="hidden" class="q_input_80" />
    </div></td>
     <td>
     <select id="TMPsearch_condition" onchange="bpos.search_condition();"><option value="1" selected>原单查询</option><option value="2">条件查询</option></select>
     </td>
  </tr>
  <tr class="emtb" id="TMPretail_no">
    <td align="right" height="30">原单编号：</td><td align="left" ><input id="TMPretailno" type="text" size="80" class="org_q_input_80" onKeyPress="onReturnretailno(event);"/></td>
   </tr>
   <tr class="emtb" id="TMPstore_name"style="display:none">
    <td align="right" height="30">店仓名称：</td><td align="left" ><input id="TMPstorenamer" type="text" size="80" class="org_q_input_80" onKeyPress="onReturnretailno(event);"/><input type="button" id="TMPquerystore"  value="查询" style="height:20px" /></td>
   </tr>
   <tr class="emtb" id="TMPvip_no"style="display:none">
    <td align="right" height="30">VIP卡号&nbsp;：</td><td align="left" ><input id="TMPvipno" type="text" size="80" class="org_q_input_80" onKeyPress="onReturnretailno(event);"/><input type="button" id="TMPqueryvip"  value="查询" style="height:20px" /></td>
   </tr>
   <tr class="emtb" id="TMPsaler_name"style="display:none">
    <td align="right" height="30">营&nbsp;业&nbsp;员&nbsp;：</td><td align="left" ><input id="TMPsaler" type="text" size="80" class="org_q_input_80" onKeyPress="onReturnretailno(event);"/></td>
   </tr>
   <tr class="emtb" id="TMPretail_data"style="display:none">
    <td align="right" height="30">单据日期：</td><td align="left" ><input id="TMPretaildata" type="text" size="80" class="org_q_input_80" onkeypress="onReturnretailno(event);var k=event.keyCode||event.which||event.charCode; return k>=48&&k<=57||k==45||k==32||k==9"  ondragenter="return false" style="ime-mode:Disabled"/>多个用空白字符隔开</td>
   </tr>
  <tr>
    <td colspan="2" align="center"><div id="TMPtreatment_td_inc" align="center"><div id="TMPtreatment_text">&nbsp;
     <input type="button" id="TMPsearch_ok" value="确定" class="qinput" onclick="check3();"/>
  &nbsp;&nbsp; &nbsp; &nbsp;
  <input  type="button" id="TMPsearch_nok" class="qinput" value="取消" onclick="javascript:bpos.tryClose1();" /> 
</div> 
</td><td></td>
</tr> 
</table>
</div>
</form>
</div>
