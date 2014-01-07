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
<link href="bpos.css" rel="stylesheet" type="text/css" />
<script>     
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

  document.write("<TR><TD style=font-weight:600; font-size:14px;>"+getFullYear(today)+"年"+isnMonths[today.getMonth()]+""+today.getDate()+"日 "+isnDays[today.getDay()]+"</TD></TR>");

document.write("</table>");

//-->
</SCRIPT></div></div></div>
</div>

		 <div>
		 	<table align="left" width="100px;" border="0" cellpadding="5" cellspacing="5" style="height:540px; background:#fff">
		 		<tr><td><input class="linear-green" id="paybutton" name="Submit24" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="付款F12"  onclick="javascript:bpos.discount();"/></td></tr>
	    	<tr><td><input class="linear-green" id="addnewbutton" name="Submit2" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="开新单F11" onclick="javascript:bpos.new_order();"/></td></tr>
	    	<tr><td><input class="linear-green" id="modinumbutton" name="Submit26" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="改数量F10" onclick="javascript:bpos.changnumber();"/></td></tr>
	    	<tr><td><input class="linear-green" id="modistatebutton" name="Submit23" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="改状态F9" onclick="javascript:bpos.changeretailtype();"/></td></tr>
	    	<tr><td><input class="linear-green" id="deletebutton" name="Submit212" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="删除F8"  onclick="javascript:bpos.deleteline();"/></td></tr>
	   	  <tr><td><input class="linear-green" id="reprintbutton" name="Submit25" type="button" style="background:rgb(218, 227, 234);width:80px;height:70px;" value="重复打印F7" onclick="javascript:bpos.repeatPrint();"/></td></tr>
     	</table>
   	</div>
   	
   	<div style="background:#eee; width:933px;">
   	<div style="float:left;margin-left:10px;width:40%;height:120px;">
     <div style="font-size:40px;height:76%;float:left; padding-top:8px">应收:</div>
     <div style="font-size:40px;height:74%;font-weight:bold; color:#d05013; padding-top:8px" id="tot_payable">0.00</div>
     <div>
     	 <div class="desc-txt" style="float:left;font-size:15px;">VIP号:</div>
       <span id="vipnum" class="value" style="width:120px;float:left;font-weight:600; font-size:14px; color:#6b9e52">&nbsp;</span>
       <div class="desc-txt" style="margin: 0px 0px 7px 33px;
text-align: right;float:left;font-size:15px;">卡类型: 
<!-- <select name="" style="height:24px;">
		<option value="123"></option>
	</select> -->	</div>
       <span id="viptype1" class="value" style="width:120px;float:left;font-weight:600; font-size:14px; color:#6b9e52">&nbsp;</span>
     </div>
     
    </div> 
		 <div style="margin-left:55%;height:120px;">
		 		<div style="padding-top:8px">
		 			<div style="width:50%;float:left;font-size:18px">
		 			   单据日期：<span id="sys_date" style="width:60px;font-size:18px"></span>
          </div>
		 			<span><div style="float:left;font-size:18px">POS机号：</div><div style="width:100px;float:left;font-size:18px"><%=posno%></div></span>
		 		</div>
		 		<br/>
		 		<div style="margin-top:20px;">
		 			<div style="float:left;font-size:18px">小票编号：</div><div id="ticketNo" style="float:left;font-size:18px"></div>
		 		</div>
		 		<br/>
		 		<br/>
		 		<div style="margin-top:20px;">
		 			<div style="float:left;width:60%;text-align:right;font-size:18px">当日成交笔数:</div>
		 			<div id="dealNum" style="float:left;text-align:center;font-size:18px"></div>
			 	</div>
     </div>
   </div>
   
    <div style="margin-top:10px;margin-left:110px;border:1px solid #666);height:360px;overflow-y:auto;">
		 	
		 <div id="embed-items" class="listbody" style="height:100%;"><%@ include file="/html/nds/bpos/inc_list.jsp" %></div></div><div id="input_item" style="margin-top:10px;margin-left:110px;background:#d1ed9f;height:30px;padding-top:4px"> 
		 	<span style="width:17%;"><div style="float:left;padding: 0 3px 0 20px;font-size:14px;">状态:</div>
		 		<div class="desc-txt" style="float:left;">
        	<select name="select" id="m_retailtype" name="m_retailtype">
      <option value="1" selected="selected">正常</option>
      <option value="2">退货</option>
    </select></div>
    	</span>
		 	<span style="width:8%;"><font color="#000" style="font-size:15px;">收银员:</font></span><span><input id="emp_name" value="<%=empid%>" style="width:10%;border:1px solid #666;" disabled /></span>
		 	<span style="width:6%;"><font color="#000" style="font-size:15px;">商品:</font></span><span><input id="m_retail_idx" style="width:15%;border:1px solid #666;"/></span>
		 	<span style="width:6%;"><font color="#000" style="font-size:15px;">数量:</font></span><span><input id="number" style="width:10%;border:1px solid #666;"/></span>
		 	<span style="width:6%;"><font color="#000" style="font-size:15px;">价格:</font></span><span><input id="price" style="width:15%;border:1px solid #ccc;"/></span>
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
jQuery(document).ready(function(){
 document.getElementById('number').focus();
});
</script>
</html>
