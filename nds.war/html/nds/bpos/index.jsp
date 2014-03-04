<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
 
if(userWeb==null || userWeb.isGuest()){
	String redirect=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString() ,"UTF-8");
	response.sendRedirect("/login.jsp?redirect="+redirect);
	return;
}
  int objectId=Tools.getInt(request.getParameter("id") ,-1);
   if(objectId!=-1)
 {   
    	int retailTableId=TableManager.getInstance().getTable("m_retail").getId();
    	response.sendRedirect("/html/nds/object/object.jsp?table="+retailTableId+"&id="+objectId );
    	return;
   }
     
String posno=request.getParameter("posno");
String eid=request.getParameter("empid");
String empid = "";
if(eid == null || eid.equals("null")){
  empid ="";
}else{
	empid =eid;
	}

%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="上海伯俊" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="enable_context_menu" value="true" />	
	<liferay-util:param name="table_width" value="100%" />
</liferay-util:include>
<script language="javascript" src="/html/nds/bpos/bpos.js?v=20131104002"></script>
<script language="javascript" src="/html/nds/bpos/bxl.js"></script>
<script language="javascript" src="/html/nds/bpos/jsm.js"></script>
<script language="javascript" src="/html/nds/bpos/strategy.js"></script>
<link href="reset.css" rel="stylesheet" type="text/css" />
<link href="bpos.css" rel="stylesheet" type="text/css" />

<script>
function getFocus(o){
	if(o&&o.value){
		jQuery(o).select();
		dwr.util.selectRange(o, 0,o.value.length);
		$("FOCUS").value=o.value.length;
	}
}
document.onkeydown = function(){
	//f6
	if(window.event && window.event.keyCode == 117) { 
		event.stopPropagation();
		bpos.changeprice();
		return false;
	}
	//f7
	else if(window.event && window.event.keyCode == 118) { 
		event.stopPropagation();
		bpos.repeatPrint();
		return false;
	}
	//f8
	else if(window.event && window.event.keyCode == 119) { 
		event.stopPropagation();
		bpos.deleteline();
		return false;
	}
	//f9
	else if(window.event && window.event.keyCode == 120) { 
		event.stopPropagation();
		bpos.changeretailtype();
		return false;
	}
	//f10
	else if(window.event && window.event.keyCode == 121) { 
		event.stopPropagation();
		bpos.changnumber();
		return false;
	}
 	//f11
	else if(window.event && window.event.keyCode == 122) { 
		event.stopPropagation();
		bpos.new_order();
		return false;
	}
	//f12
	else if(window.event && window.event.keyCode == 123) { 
		event.stopPropagation();
		bpos.discount();
		return false;
	}
}
	function check1(){	
			if(document.getElementById("vip").value==""){ 
				alert("请输入vip卡号！");
				return;
				}else if(document.getElementById("vip").value.indexOf("[")!=-1&&document.getElementById("vip").value.indexOf("]")!=-1&&document.getElementById("vip").value.indexOf("{")!=-1&&document.getElementById("vip").value.indexOf("}")!=-1&&document.getElementById("vip").value.indexOf(":")!=-1&&document.getElementById("vip").value.indexOf(",")!=-1&&document.getElementById("vip").value.indexOf("\"")!=-1){
					alert("请输入正确的vip卡号！");
				}else{
	  				 var form="form1";
      				 bpos.checkvip();   	   
	  			 }
	}
	function check2(){	
			if(document.getElementById("vip").value==""){ 
				alert("请输入vip卡号！");
				return;
				}else if(document.getElementById("vip").value.indexOf("[")!=-1&&document.getElementById("vip").value.indexOf("]")!=-1&&document.getElementById("vip").value.indexOf("{")!=-1&&document.getElementById("vip").value.indexOf("}")!=-1&&document.getElementById("vip").value.indexOf(":")!=-1&&document.getElementById("vip").value.indexOf(",")!=-1&&document.getElementById("vip").value.indexOf("\"")!=-1){
					alert("请输入正确的vip卡号！");
				}else{
	  				 var form="form1";
      				 bpos.checkvip2();   	   
	  			 }
	}
	function check3(){	
		if(document.getElementById("retailno").value==""){ 
				alert("请输入零售单号！");
				return;
				}else if(document.getElementById("retailno").value.indexOf("[")!=-1&&document.getElementById("retailno").value.indexOf("]")!=-1&&document.getElementById("retailno").value.indexOf("{")!=-1&&document.getElementById("retailno").value.indexOf("}")!=-1&&document.getElementById("retailno").value.indexOf(":")!=-1&&document.getElementById("retailno").value.indexOf(",")!=-1&&document.getElementById("retailno").value.indexOf("\"")!=-1){
					alert("请输入正确的零售单号！");
				}else{
      				 bpos.checkretailno();   	   
	  			 }
	}
		function check4(){	
		 var pricex=document.getElementById("tempx").value;
		if(document.getElementById("retailprice").value==""){ 
				alert("请输入退货价格！");
				return;
				}else if(document.getElementById("retailprice").value>pricex){
					alert("你输入的退款价格已大于销售价格！");
				}else if(document.getElementById("retailprice").value<0){
					alert("你输入的退款价格不能为负数！");	
				}else{
					
      				 bpos.checkretailprice();   	   
	  			 }
	} 
	    function checkradio1(){
	     	 var objx;
	          objx=document.getElementsByName("radio_amt");  
	          if(!objx[0].checked){
	           	  if($("discount_0").disabled){
	           	   	$("discount_0").disabled =!$("discount_0").disabled ;
	           	   	$("discount_1").disabled="disabled"; 
	           	   	$("discount_2").disabled="disabled";
	           	    }
	           	}
	   }        	
	      function checkradio2(){
	     	 var objy;
	          objy=document.getElementsByName("radio_amt");      	
	           if(!objy[1].checked){
	           		if($("discount_1").disabled){
	           	   	$("discount_1").disabled =!$("discount_1").disabled ;
	           	   	$("discount_0").disabled="disabled"; 
	           	   	$("discount_2").disabled="disabled";
	           	    }
	          }
	    }     
	       function checkradio3(){
	     	 var objz;
	          objz=document.getElementsByName("radio_amt");      	
	           if(!objz[2].checked){     
	            if($("discount_2").disabled){
	           	   	$("discount_2").disabled =!$("discount_2").disabled ;
	           	   	$("discount_0").disabled="disabled"; 
	           	   	$("discount_1").disabled="disabled";
	           	    }
	         }
	    }
function onReturn(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13)
  {
  	 bpos.insertLine();
  }
}
function onReturnpay(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13)
  {
  	if($("unpaidnum").value!=0){
  	 bpos.insertpayment();
  	}else if ($("unpaidnum").value==0){
  			var inputs=jQuery("#qbtns > input");
  			jQuery(inputs[0]).click();
  			return false;
  	}
  }
}

function onReturnnum(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13)
  {
  	 bpos.changnum();
  }
}

function onReturnprice(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13)
  {
  	 bpos.changepir();
  }
}

function onReturnretailprice1(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13)
  {   	
 	     var pricex=document.getElementById("tempx").value;
		if(document.getElementById("retailprice").value==""){ 
				alert("请输入退货价格！");
				return;
				}else if(document.getElementById("retailprice").value>pricex){
					alert("你输入的退款价格已大于销售价格！");
				}else if(document.getElementById("retailprice").value<0){
					alert("你输入的退款价格不能为负数！");	
				}else{
					
      				 bpos.checkretailprice(); 	   
	  			 }
  }
} 

function onReturnretailno(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13)
  {	   
	     check3();
  }
}

function onReturnretailprice(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13)
  {
  	 bpos.changamt();
  }
}

function onReturnvip(event){

       if (!event) event = window.event;
       if (event && event.keyCode && event.keyCode == 13)
       {
       	
        if(jQuery("#carno").html()!=""){check2();return;}
       	
       	if(event.currentTarget.id=="vip"){
        	if(document.getElementById("vip").value==""){ 
	        alert("请输入vip卡号！");
	        }else{
        	 bpos.checkvip("vip");
            }
        }
       	if(event.currentTarget.id=="in_phone"){
        	if(document.getElementById("in_phone").value==""){ 
	        alert("请输入手机号码！");
	        }else{
        	 bpos.checkvip("in_phone");
          }
        }
        
	   }
}
function getFullYear(d){//d is a date object
    yr=d.getYear();if(yr<1000)
    yr+=1900;return yr;
 }

  </script>
<style>
	#container{
		margin-left: 15px; margin-right: 8px;
		padding-bottom: 15px;
	}
	#header{
		padding: 12px 0;
	}
	#header .title{
		color: #232323; font-size: 18px; line-height: 18px;
	}
	#header .timer b{
		padding-left: 12px;
		color: #4aa500;
	}
	#side{
		width: 80px;
		margin: 0 10px 0 0;
	}
	.button{
		height: 70px; line-height: 70px;
		margin-bottom: 13px;
		color: #34581d; font-weight: 600; text-align: center;
		border-radius: 4px;
		border: 1px solid #a1bd7c;
		background-image:-webkit-gradient(linear, left top, left bottom, color-stop(0, rgb(239, 247, 227)), color-stop(0.5, rgb(216, 234, 187)), color-stop(0.51, rgb(196, 224, 157)), color-stop(1, rgb(223, 238, 199)));
	}
	.button.active{
		border-color: #f90;
	}
	#wrap{
	}
	#wrap .detail{ 
		/*height: 100px;*/
		font-weight: 600;
		background-color: #f3f3f3;
	}
	#wrap .detail .left{
		margin: 0 0 0 22px;
	}
	#wrap .detail td{
		padding-top: 10px;
	}
	#wrap .detail tr:first-child td{
		padding-bottom: 5px; padding-top: 0;
	}
	#wrap .detail .right{
		font-size: 36px; line-height: 79px; text-align: center;
	}
	#wrap .detail .right b{
		color: #ff5a00; font-size: 48px;
	}
	#list{
		/*border: 1px solid #bebebe;*/
		border-radius: 4px;
	}
	#list tr{
		height: 24px;
	}
	#list thead tr:first-child{
		background-color: #d1ed9f;
	}
	#list tbody tr:nth-child(even){
		background-color: #f5f4f4;
	}
	#input_item{
		height: 36px;line-height: 36px;
		margin-top: 20px;
		/*font-weight: 600;*/
		background-color: #f3f3f3;
	}
	#input_item input{
		width: 104px;
		border: 1px solid #ccc;
	}
	.flex {
	display: flex;
	}
	.mb10, .mtb10 {
	margin-bottom: 10px;
	}
	.tc {
	text-align: center;
	}
	.w100p, .wh100p {
	width: 100%;
	}
	#q_search_condition .left table td {
	padding-bottom: 3px;
}
</style>
</head>
<body id="obj-body" style="">
<iframe id="print_iframe" name="print_iframe" width="1" height="1" src="/html/common/null.html"></iframe>
<form id="form1" name="form1" method="post">
<input type='hidden' id="pos_no" value="<%=posno%>">
<div id="objtb22">
<div id="from_top">
<div id="from_top_left"><div id="c_store_name" class="from_top_text"></div></div>
<div id="from_top_right"><div id="from_top_right_bg"><div id="from_top_right_text" align="center"><SCRIPT language=javascript>
<!--
function initArray()
{

  for(i=0;i<initArray.arguments.length;i++)

  this[i]=initArray.arguments[i];

 }

var isnMonths=new initArray("01月","02月","03月","04月","05月","06月","07月","08月","09月","10月","11月","12月");

 var isnDays=new initArray("星期日","星期一","星期二","星期三","星期四","星期五","星期六","星期日");

 today=new Date();

 hrs=today.getHours();

 min=today.getMinutes();

 sec=today.getSeconds();

 clckh=""+((hrs>12)?hrs-12:hrs);

 clckm=((min<10)?"0":"")+min;clcks=((sec<10)?"0":"")+sec;

 clck=(hrs>=12)?"下午":"上午";

 var stnr="";

 var ns="0123456789";

 var a="";

function getFullYear(d)

{

  yr=d.getYear();if(yr<1000)

  yr+=1900;return yr;}

  document.write("<table align=\"center\">");

  document.write("<TR><TD style=font-weight:600; font-size:14px;>"+getFullYear(today)+"年"+isnMonths[today.getMonth()]+""+today.getDate()+"日 <b style='color: #62b205;'>"+isnDays[today.getDay()]+"</b></TD></TR>");

document.write("</table>");

//-->
</SCRIPT></div></div></div>
</div>

	<div>
		<table id="paybuttons" align="left" width="100px;" border="0" cellpadding="5" cellspacing="5" style="height:540px; background:#fff">
		 	<tr><td><input class="linear-green" id="paybutton" name="Submit24" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="付款F12"  onclick="javascript:bpos.discount();"/></td></tr>
	    	<tr><td><input class="linear-green" id="addnewbutton" name="Submit2" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="开新单F11" onclick="javascript:bpos.new_order();"/></td></tr>
	    	<tr><td><input class="linear-green" id="modinumbutton" name="Submit26" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="改数量F10" onclick="javascript:bpos.changnumber();"/></td></tr>
	    	<tr><td><input class="linear-green" id="modistatebutton" name="Submit23" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="改状态F9" onclick="javascript:bpos.changeretailtype();"/></td></tr>
	    	<tr><td><input class="linear-green" id="deletebutton" name="Submit212" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="删除F8"  onclick="javascript:bpos.deleteline();"/></td></tr>
			<tr><td><input class="linear-green" id="reprintbutton" name="Submit25" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="重复打印F7" onclick="javascript:bpos.repeatPrint();"/></td></tr>
				   	  <tr><td><input class="linear-green" id="reprintbutton" name="Submit25" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="修改价格F6" onclick="javascript:bpos.changeprice();"/></td></tr>
     	</table>
   	</div>
   	<div id="wrap" class="flex flex1 flex-column">
		<div class="flex detail mb10">
			<div class="left self-cen">
				<table id="vipmessage">
					<tr>
						<td width="234" style="font-weight: 600;">VIP号：<span id="vipnum" style="color: #62b205;font-size: 15;"></span></td>
						<td>卡类型：
							<span id="viptype1">&nbsp;</span>
						</td>
					</tr>
					<tr>
						<td>单据日期：<span id="sys_date"></span></td>
						<td>POS机号：<span><%=posno%></span></td>
					</tr>
					<tr>
						<td>小票编号：<span id="ticketNo" ></span></td>
						<td>当日成交笔数：<span id="dealNum"></span></td>
					</tr>
				</table>
			</div>
			<div class="right flex1">
				应收：<b id="tot_payable"></b> 元
			</div>
		</div>
	   
		<div id="list">
			<div id="embed-items" class="listbody" style="overflow-y: auto;max-height: 360px;min-height:360px;"><%@ include file="/html/nds/bpos/inc_list.jsp" %></div>
		</div>
		<div id="input_item"> 
			<span style="width:17%;font-size:13px;">状态:</span>
			<select name="select" id="m_retailtype" name="m_retailtype" style="height: 21px;">
				<option value="1" selected="selected">正常</option>
				<option value="2">退货</option>
			</select>
			<span style="width:8%;"><font color="#000" style="font-size:13px;">收银员:</font></span><span><input id="emp_name" value="<%=empid%>" style="width:10%;border:1px solid #666;height: 21px;" disabled /></span>
			<span style="width:6%;"><font color="#000" style="font-size:13px;">商品:</font></span><span><input id="m_retail_idx" style="width:15%;border:1px solid #666;height: 21px;"/></span>
			<span style="width:6%;"><font color="#000" style="font-size:13px;">数量:</font></span><span><input id="number" style="width:10%;border:1px solid #666;height: 21px;" value="1"/></span>
			<span style="width:6%;display:none;"><font color="#000" style="font-size:13px;">价格:</font></span><span style="display:none;"><input id="price" style="width:15%;border:1px solid #ccc;height: 21px;" value="1"/></span>
		</div>
	</div>
   
</div>
</form>

<div id="pay" style="display:none">
	<%@ include file="/html/nds/bpos/inc_pay.jsp" %>
</div>
<div id="amt" style="display:none">
	<%@ include file="/html/nds/bpos/inc_amt.jsp" %>
</div>
<div id="num" style="display:none">
	<%@ include file="/html/nds/bpos/inc_num.jsp" %>
</div>
<div id="changeprice" style="display:none;">
	<%@ include file="/html/nds/bpos/inc_price.jsp" %>
</div>
<div id="dlg_vip" style="display:none">
	<%@ include file="/html/nds/bpos/vip_new.jsp" %>
</div>	
<div id="r_retail_no" style="display:none">
	<%@ include file="/html/nds/bpos/inc_retail_no.jsp" %>
</div>	
<div id="r_retail_price" style="display:none">
	<%@ include file="/html/nds/bpos/inc_retail_price.jsp" %>
</div>
<div id="strategy" style="display:none;">
	<%@ include file="/html/nds/bpos/strategy.jsp" %>
</div>
</body>
<script>
// jQuery(document).ready(function(){
	// document.getElementById('number').focus();
// });
</script>
</html>
