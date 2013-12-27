<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<% 
if(userWeb==null || userWeb.isGuest()){
	String redirect=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString() ,"UTF-8");
	response.sendRedirect("/login.jsp?redirect="+redirect);
	return;
}
  int objectId=Tools.getInt(request.getParameter("id") ,-1);
   if(objectId!=-1) {   
    	int retailTableId=TableManager.getInstance().getTable("m_retail").getId();
    	response.sendRedirect("/html/nds/object/object.jsp?table="+retailTableId+"&id="+objectId );
    	return;
   }
  
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="上海伯俊" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="enable_context_menu" value="true" />	
	<liferay-util:param name="table_width" value="100%" />
</liferay-util:include>
<script language="JavaScript" src="/html/nds/js/formkey.js"></script>
<script type='text/javascript' src='/html/nds/js/util.js'></script> 
<script language="javascript" src="/html/nds/js/bpos.js"></script>
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
  	 bpos.insertpayment();
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
        	if(document.getElementById("vip").value==""){ 
	        alert("请输入vip卡号！");
	        }else{
        	 bpos.checkvipenter();
            }
	   }
}
function getFullYear(d){//d is a date object
    yr=d.getYear();if(yr<1000)
    yr+=1900;return yr;
 }
 function getdate(){
  	today=new Date();
  	var date2;
    var isnMonths=new Array("01","02","03","04","05","06","07","08","09","10","11","12");
  	if(today.getDate()<10){
  	date2 ="0"+today.getDate();
    }else{
    	date2=today.getDate();
    } 	  	
  	document.getElementById("sys_date").value=getFullYear(today)+isnMonths[today.getMonth()]+date2;
}

  </script>
</head>
<body id="obj-body">
	
<form id="form1" name="form1" method="post">
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

  document.write("<TR><TD>"+getFullYear(today)+"年"+isnMonths[today.getMonth()]+""+today.getDate()+"日 "+isnDays[today.getDay()]+"</TD></TR>");

document.write("</table>");

//-->
</SCRIPT></div></div></div>
</div>
<table width="953" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="12" rowspan="3"><img src="images/center_left.gif" width="12" height="518" /></td>
    <td width="930" height="8" valign="top" background="images/center_top.gif"></td>
    <td width="11" rowspan="3"><img src="images/center_right.gif" width="11" height="518" /></td>
  </tr>
  <tr>
    <td valign="top" bgcolor="#C6CBDE"><table width="930" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><div class="center">  <div class="obj" id="obj_inputs_1">
    <table class="objtb" cellspacing="0" cellpadding="0" align="center" width="860">
      <tr>
        <td width="80" nowrap="nowrap" align="left" valign='top' ><div class="desc-txt">单据号:</div></td>
        <td class="value" width="120" nowrap="nowrap" align="left" valign='top' ><span id="no"></span></td>
        <td width="80" nowrap="nowrap" align="left" valign='top' >&nbsp;</td>
        <td class="value" width="120" nowrap="nowrap" align="left" valign='top' >&nbsp;</td>
        <td width="80" nowrap="nowrap" align="left" valign='top' ><div class="desc-txt">单据日期:</div></td>
        <td class="value" width="160" nowrap="nowrap" align="left" valign='top' > 
        	<input id="sys_date" type="text" name="sys_date" />
        	<font size="2">
               <a href="javascript:showCalendar('imageCalendar6',false,'sys_date',null,null,true);" onclick="event.cancelBubble=true;">
                <img id="imageCalendar6" height="18" width="16" border="0" align="absmiddle" title="格式：yyyymmdd,如20070823,必须8位" src="/html/nds/images/datenum.gif"/>
              </a>
            </font>
       </td>
      </tr>
      <tr>
        <td width="80" nowrap="nowrap" align="left" valign='top' ><div class="desc-txt">VIP号:</div></td>
        <td class="value" width="120" nowrap="nowrap" align="left" valign='top' ><span id="vipnum">&nbsp;</span> </td>
        <td width="80" nowrap="nowrap" align="left" valign='top' ><div class="desc-txt">卡类型:</div></td>
        <td class="value" width="120" nowrap="nowrap" align="left" valign='top' ><span id="viptype1">&nbsp;</span></td>
        <td width="80" nowrap="nowrap" align="left" valign='top' ><div class="desc-txt">当前营业员:</div></td>
        <td class="value" width="160" nowrap="nowrap" align="left" valign='top' ><span id="emp_name">&nbsp;</span></td>
      </tr>
    </table>
  </div></div></td>
      </tr>
      <tr>
        <td height="5"></td>
      </tr>
      <tr>
        <td><table width="910" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="21"><img src="images/table_left_top.gif" width="21" height="20" /></td>
            <td width="891" background="images/table_center_top.gif" height="20"></td>
            <td width="18"><img src="images/table_right_top.gif" width="18" height="20" /></td>
          </tr>
          <tr>
            <td width="21" height="324" background="images/table_left_center.gif"></td>
            <td width="891" valign="top" background="images/table_center_center.gif"><table width="871" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>    
                	<div id="embed-items" class="listbody"> 
     <%@ include file="/html/nds/bpos/inc_list.jsp" %> 	
</div></td>
              </tr>
              <tr>
                <td height="5"></td>
              </tr>
              <tr>
                <td><div id="embed-items">
<table width="861" border="0" cellspacing="0" cellpadding="0" class="modify_table" align="center">
  <tr>
    <td valign="top"><table width="560" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="22"><div class="obj"><table width="540" border="0" align="left" cellpadding="0" cellspacing="0" class="objtb">
      <tr>
        <td width="60" nowrap="nowrap" align="left" valign='top' ><div class="desc-txt">
        	<select name="select" id="m_retailtype" name="m_retailtype">
      <option value="1" selected="selected">正常</option>
      <option value="2">退货</option>
      <option value="3">赠品</option>
      <option value="4">全额</option>
    </select></div></td>
        <td width="160"> &nbsp;&nbsp;<input id="m_retail_idx" name="m_retail_idx" type="text" size="20" maxlength="80" class="q_input" onKeyPress="onReturn(event);" /></td>
        <td width="80" nowrap="nowrap" align="right" valign='top' ><div class="desc-txt-white">总数量：</div></td>
        <td width="80" nowrap="nowrap" align="left" valign='top' ><div class="desc-txt-white" id="tot_num">0</div></td>
        <td width="80" nowrap="nowrap" align="right" valign='top' ><div class="desc-txt-white">原价金额：</div></td>
        <td width="80" nowrap="nowrap" align="left" valign='top' ><div class="desc-txt-white" id="tot_amt">0.00</div></td>
      </tr>
    </table></div></td>
      </tr>
      <tr>
        <td height="22"><div class="obj"><table width="560" border="0" align="left" cellpadding="0" cellspacing="0" class="objtb">
      <tr>
        <td width="60" nowrap="nowrap" align="left" valign='top' ><div class="desc-txt">备注:</div></td>
        <td width="500">&nbsp;&nbsp;<input id="comment" name="comment" type="text" size="70" /></td>
        </tr>
    </table>
    </div></td>
      </tr>
    </table></td>
    <td width="280"><div class="obj"><table width="260" border="0" align="center" cellpadding="0" cellspacing="0" class="objtb">
      <tr>
        <td width="150" nowrap="nowrap" align="right" valign='top' ><div class="desc-txt-red24">应付金额：</div></td>
        <td width="110" nowrap="nowrap" align="left" valign='top' ><div class="desc-txt-red24" id="tot_payable">0.00</div></td>
      </tr>
    </table></div></td>
  </tr>
</table>
</div></td>
              </tr>
            </table></td>
            <td width="18" background="images/table_right_center.gif"></td>
          </tr>
          <tr>
            <td><img src="images/table_left_bottom.gif" width="21" height="20" /></td>
            <td background="images/table_center_bottom.gif">&nbsp;</td>
            <td><img src="images/table_right_bottom.gif" width="18" height="20" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="5"></td>
      </tr>
      <tr>
        <td><div class="center_button"><div id="from_input"><table width="840" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="140"><image src="/html/nds/bpos/images/button01.gif" onclick="bpos.new_order();"/></td>
    <td width="140"><image src="/html/nds/bpos/images/button02.gif" onclick="javascript:bpos.deleteline();"/></td>
    <td width="140"><image src="/html/nds/bpos/images/button03.gif" onclick="javascript:bpos.sales();"/></td>
    <td height="37"><image src="/html/nds/bpos/images/button04.gif" onclick="javascript:bpos.changnumber();"/></td>
    <td width="140"><image src="/html/nds/bpos/images/button05.gif" onclick="javascript:bpos.changprice();"/></td>
    <td width="140"><image src="/html/nds/bpos/images/button06.gif" onclick="javascript:bpos.payprice();"/></td> 
  </tr>
</table>
</div> </div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="9" valign="bottom" background="images/center_bottom.gif"></td>
  </tr>
</table>
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
	<%@ include file="/html/nds/bpos/vip.jsp" %>
</div>	
<div id="r_retail_no" style="display:none">
	<%@ include file="/html/nds/bpos/inc_retail_no.jsp" %>
</div>	
<div id="r_retail_price" style="display:none">
	<%@ include file="/html/nds/bpos/inc_retail_price.jsp" %>
</div>	
</body>
<script>getdate();</script>
</html>
