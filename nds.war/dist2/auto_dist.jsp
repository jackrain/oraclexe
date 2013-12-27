<%@ page language="java"  pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>自动配货</title>
<link href="ph.css" rel="stylesheet" type="text/css" />
</head>

<body style="width:auto">
<form action="" method="get">
<div id="auto-bg">
<div id="auto-main">
<div id="tabsG">
  <ul>
    <li><a href="#" title="Link 1"><span>全部</span></a></li>
    <li><a href="#" title="Link 2"><span>当前</span></a></li>
  </ul>
</div>
<div id="auto-border">
<div id="auto-bl">
<div id="auto-bl-title">设置可配总量比例</div>
<div id="auto-bl-txt">
<table width="440" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="100"><div class="ph-left-txt">当前可配总量：</div></td>
    <td width="40"><div class="ph-right-txt">1000</div></td>
    <td width="100"><div class="ph-left-txt">本次可配比例：</div></td>
    <td width="60"><div class="ph-right-txt"><input name="" type="text" class="ipt-4-1" /></div></td>
    <td width="100"><div class="ph-left-txt">本次可配数量：</div></td>
    <td width="40"><div class="ph-right-txt">100</div></td>
  </tr>
</table>
</div>
</div>
<div class="auto-height"></div>
<div id="auto-cl">
<div id="auto-bl-title">选择配货策略</div>
<div id="auto-cl-txt">
<table width="440" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="13" align="center"><img src="images/icon-11.gif" width="11" height="11" /></td>
    <td width="135"><div class="ph-left-txt">指定配化数量：</div></td>
    <td width="312"><div class="ph-right-txt"><input name="" type="text" class="right-input" /></div></td>
    </tr>
  <tr>
    <td width="13">&nbsp;</td>
    <td colspan="2"><div class="ph-right-txt">说明：所有商品均按此外指定的数量配货。</div></td>
    </tr>
  <tr>
    <td width="13" align="center"><img src="images/icon-11.gif" width="11" height="11" align="absmiddle" /></td>
    <td width="135"><div class="ph-left-txt">按未配量比例配货：</div></td>
    <td width="312"><div class="ph-right-txt"><input name="" type="text" class="right-input" /></div></td>
    </tr>
  <tr>
    <td width="13">&nbsp;</td>
    <td colspan="2"><div class="ph-right-txt">说明：按照未配量<font color="red">*</font>此处指定的比例为所有商品配货。</div></td>
    </tr>
  <tr>
    <td width="13" align="center"><img src="images/icon-11.gif" width="11" height="11" align="absmiddle" /></td>
    <td width="135"><div class="ph-left-txt">按订单订货比例配货：</div></td>
    <td width="312"><div class="ph-right-txt"><input name="" type="text" class="right-input" /></div></td>
    </tr>
  <tr>
    <td width="13">&nbsp;</td>
    <td colspan="2"><div class="ph-right-txt">说明：按照可配量<font color="red">*</font>订货比例为所有商品配货(订货比例指同一商品不同订单订
货数量占所有订单订货总量的比例)。</div></td>
    </tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    </tr>
  <tr>
    <td colspan="3"><div class="ph-right-txt">注意：无论选择哪种配货策略，均受到可配货总量的限制，即配货总数量不能大于
      可配货总量。</div></td>
    </tr>
</table>
</div>
</div>
<div class="auto-height"></div>
<div id="auto-btn"><input name="" type="image" src="images/btn-cd.gif" width="34" height="20" />&nbsp;&nbsp;<input name="" type="image" src="images/btn-qx.gif" width="34" height="20" /></div>
</div>
</div>
</div>
</form>
</body>
</html>
