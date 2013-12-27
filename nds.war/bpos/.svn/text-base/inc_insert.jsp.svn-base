<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script>

	//设置成统一数量 
	function unite(){
	var unite=document.getElementById("unite").value;	
	if(unite==""||unite==null){
		alert("数量为空");
		return;
	}
	//如果是数字，则设置为统一的数量
	else if(!isNaN(unite)&&unite==parseInt(unite)&&parseInt(unite)>0){
   	   var num=document.getElementsByName("TMPnum");
		     for(var i=0;i<num.length;i++ ){
			     //alert(num[i].value);
		        num[i].value=unite;	
			   }
		}else{
			alert("填写格式不正确！");
			}
		}
	</script>
<div id="TMPinsert_num_content">
<table width="726" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><div id="TMPtreatment_td">
      <div id="TMPtreatment_text">批量输入（M）：</div>
    </div></td>
  </tr>
  <tr>
    <td bgcolor="#2d476a">
	<div id="TMPbulk_td"><table width="646" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="52" align="right"><div class="txt-white"><font style="color:red">*</font>款号：</div></td>
    <td width="109"><input id="TMPstyles" name="text" type="text" class="q_input_80" /></td>
    <td width="52"><div class="txt-white">颜色：</div></td>
    <td width="105"><input id="TMPcolor" name="text2" type="text" class="q_input_80" /></td>
    <td width="52"><div class="txt-white">尺寸：</div></td>
    <td width="181"><input id="TMPsize" name="text3" type="text" class="q_input_80" /></td>
    <td width="179" align="right"><input name="button" type="button" class="qinput" id="TMPsearch_num" onclick="javacript:bxl.styles()"  value="查询"/></td>
  </tr>
</table>
</div>
<div class="treatment-table" style="width:716px;">
	<div class="treatment-table-head" id="mulbarcodescape">
		<div class="treatment-span-7">条码</div><div class="treatment-span-10">款号</div><div class="treatment-span-10" >品名</div><div class="treatment-span-6">颜色</div><div class="treatment-span-6">尺寸</div><div class="treatment-span-6">颜色号</div><div class="treatment-span-6">尺寸号</div><div class="treatment-span-8">标准价</div><div class="treatment-span-8">数量</div>
</div></div></div>
	
	<div id="TMPtreatment-main" class="treatment-sidebar" style="height: 202px; width: 716px; visibility: visible; opacity: 1;">	

</div>
	<div id="bulk_td"><table width="706" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="97" align="right"><div class="txt-white">统一设置数量：</div></td>
    <td width="63"><input id="TMPunite" type="text"  name="ins" class="q_input_80" value=""></td>
    <td width="151"><input id="TMPunited" name="button" type="button" class="qinput" value="修改" onclick="unite()" />
    <input id="TMPre" name="button" type="button" class="qinput" value="重置" onclick="bxl.rewrite()" /></td>
    <td width="210">&nbsp</td>
    <td width="119" align="right"><input name="button" type="button" class="qinput" id="TMPs" onclick="javascript:bxl.handlesingledis()" disabled="true" value="确定"/>
      &nbsp;
      <input id=TMPcancle name="button" type="button" class="qinput" value="取消"  onclick="javascript:bxl.tryCancle()"/></td>
  </tr>
</table>
</div>

	</td>
  </tr>
</table>
</div>

