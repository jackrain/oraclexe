<%@ page language="java"  pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>自动配货</title>
    <%
        int totCan=0;
        try{
            totCan=Integer.parseInt(request.getParameter("totcan"));
        }catch (NullPointerException e){
            totCan=0;
        }
    %>
<link href="ph.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function  generateCan(){
            var totCan=<%=totCan%>;
            totCan=parseInt(totCan);
            var percentage=document.getElementById("percentage").value;
            percentage=isNaN(parseFloat(percentage))?0:parseFloat(percentage);
            if(percentage>1||percentage<0){
                alert("请输入小于1的正小数！");
                document.getElementById("percentage").value=0;
            }else{
                document.getElementById("currentCan").innerHTML=Math.round(totCan*percentage);
            }
        }
    </script>
</head>

<body style="width:auto">
<form action="" method="get">
<div id="auto-bg">
<div id="auto-menu"><input name="" type="image" src="images/btn-gb.gif" width="21" height="21" /></div>
<div id="auto-main">
<div id="tabsG">
  <ul>
    <li>请选择配货模式</li>
	<li><input name="" type="radio" value="" checked="checked" />整单</li>
    <li><input name="" type="radio" value="" />当前款</li>
  </ul>
</div>
<div id="auto-border">
<div id="auto-bl">
<div id="auto-bl-title">设置可配总量比例</div>
<div id="auto-bl-txt">
<table width="440" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="100"><div class="ph-left-txt">当前可配总量：</div></td>
    <td width="40"><div class="ph-right-txt"><%=totCan%></div></td>
    <td width="100"><div class="ph-left-txt" title="填入小数如：0.66">本次可配比例：</div></td>
    <td width="60"><div class="ph-right-txt"><input type="text" class="ipt-4-1" id="percentage" onblur="generateCan();"/></div></td>
    <td width="100"><div class="ph-left-txt">本次可配数量：</div></td>
    <td width="40"><div class="ph-right-txt" id="currentCan"></div></td>
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
    <td width="13" align="right"><label>
      <input name="radiobutton" type="radio" value="radiobutton" checked="checked" />
      </label></td>
    <td width="150"><div class="ph-left-txt">指定配货数量<font color="red">*</font>：</div></td>
    <td width="297"><div class="ph-right-txt"><input name="" type="text" class="right-input" /></div></td>
    </tr>
  <tr>
    <td width="13">&nbsp;</td>
    <td colspan="2"><div class="ph-right-txt">说明：所有商品均按此外指定的数量配货。</div></td>
    </tr>
  <tr>
    <td width="13" align="right"><label>
      <input type="radio" name="radiobutton" value="radiobutton" />
      </label></td>
    <td width="150"><div class="ph-left-txt">按未配量比例配货<font color="red">*</font>：</div></td>
    <td width="297"><div class="ph-right-txt"><input name="" type="text" class="right-input" /></div></td>
    </tr>
  <tr>
    <td width="13">&nbsp;</td>
    <td colspan="2"><div class="ph-right-txt">说明：按照未配量此处指定的比例为所有商品配货。</div></td>
    </tr>
  <tr>
    <td width="13" align="right"><label>
      <input type="radio" name="radiobutton" value="radiobutton" />
      </label></td>
    <td width="160"><div class="ph-left-txt">按订单订货比例配货<font color="red">*</font>：</div></td>
    <td width="290"><div class="ph-right-txt"><input name="" type="text" class="right-input" /></div></td>
    </tr>
  <tr>
    <td width="13">&nbsp;</td>
    <td colspan="2"><div class="ph-right-txt">说明：按照可配量订货比例为所有商品配货(订货比例指同一商品不同订单订
货数量占所有订单订货总量的比例)。</div></td>
    </tr>
    <td colspan="3" height="10"></td>
    </tr>
  <tr>
    <td colspan="3"><div class="ph-right-notes">注意：无论选择哪种配货策略，均受到可配货总量的限制，即配货总数量不能大于
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
