<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="utf-8"%>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);	
    String dialogURL=request.getParameter("redirect");
    if(null==dialogURL){
    	String ref=request.getParameter("ref");
			if(null==ref){
				response.sendRedirect("/bpos/login.jsp?redirect=%2Fbpos%2Ftoindex.jsp");
			}else{
				response.sendRedirect("/bpos/login.jsp?ref="+ref+"&redirect=%2Fbpos%2Ftoindex.jsp");
			}
			return;
    }
    String help=request.getParameter("help");
    session.invalidate();
    //增加客户端为了生存本地静态页面的判断
    String generateHTML=request.getParameter("generateHTML");
    
    File f=new File(request.getRealPath(".")+"/bpos/setup.inf");
		BufferedReader br=null;
		String str="";
		try{
				br=new BufferedReader(new InputStreamReader(new FileInputStream(f),"Unicode"));
				String recode;
				while(null!=(recode=br.readLine())){
						str+=new String(recode.getBytes("Unicode"),"Unicode");
			 	}
		}catch(Exception e){
				out.print(e.getMessage());
		}finally{
				if(null!=br){
       		try{
        		br.close();
       		}catch(IOException e3){}
  			}
		}
	str=str.trim();
	String version="1,0,641,0";
	String name="";
	String oldclsid="";
	boolean isNewVerssion=true;
	java.util.Date d=new java.util.Date();
	String t=d.toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/> 
<head>
<%@ include file="/bpos/login_header.jsp" %>
</head>

<script type="text/javascript">
	 function Thrink(){
 		<%if(null==generateHTML){%>
			jQuery.post("getpriceareaids.jsp",{storeids:sids},function(data){
				if(data.indexOf("area")!=-1){
					try{
						MainApp.Thrink(data.replace("area:",""));
					}catch(e){
						alert("WEBPOS未安装！");
					}
				}else{
					alert(data);
				}
			});
		<%}else{%>	
			try{
				 MainApp.Thrink(0);
			}catch(e){
				 alert("WEBPOS未安装！");
			}
		<%}%>	
	}
	
	jQuery(document).ready(function(){
		if(!window.ActiveXObject){
			alert("请使用IE浏览器！");
			window.close();
			return;
		}
		jQuery("#login").val((Cookies.get("name"))?(Cookies.get("name")):"");
		if(<%=isNewVerssion%>==true){
				jQuery("input").removeAttr("disabled");
				if($("hasNewVersion"))
				jQuery("#hasNewVersion").remove();
		}
		if(document.getElementById("login").value!=""){
	 		document.getElementById("password").focus();
	 		y = jQuery("#password").attr("y");
  	}else{
	 		document.getElementById("login").focus();
	 		y = jQuery("#login").attr("y");
		}
		readyLoadStoreInfo();
		var x = 2;
		jQuery("#fm").bind("keydown",function(event) {			
				if(event.keyCode==13) {
					jQuery("#ok").click();
				}				
				if(event.keyCode==37) {
					if(y==3) {
						document.getElementById("option1").selected==true?document.getElementById("option2").selected=true:document.getElementById("option1").selected=true;
					}
					if(y==4) {
						if(x==1) {
							x=3;
							dwr.util.selectRange(jQuery("[x=3][y=4]"),0,this.MAX_INPUT_LENGTH);
						}else {
							dwr.util.selectRange(jQuery("[x="+(--x)+"][y=4]"),0,this.MAX_INPUT_LENGTH);
						}
					}
				}
				if(event.keyCode==38) {
					if(y==1) {
						y=4;
						dwr.util.selectRange(jQuery("[x=2][y=4]"),0,this.MAX_INPUT_LENGTH);
					}else {	
						dwr.util.selectRange(jQuery("[y="+(--y)+"]"),0,this.MAX_INPUT_LENGTH);
					}
				}
				if(event.keyCode==39) {
					if(y==3) {
						document.getElementById("option2").selected==true?document.getElementById("option1").selected=true:document.getElementById("option2").selected=true;
					}
					if(y==4) {
						if(x==3) {
							x=1;
							dwr.util.selectRange(jQuery("[x=1][y=4]"),0,this.MAX_INPUT_LENGTH);
						}else {
							dwr.util.selectRange(jQuery("[x="+(++x)+"][y=4]"),0,this.MAX_INPUT_LENGTH);
						}
					}
				}
				if(event.keyCode==40) {			
					if(y==4) {
						y=1;
						dwr.util.selectRange(jQuery("[y=1]"),0,this.MAX_INPUT_LENGTH);
					}else if(y==3) {
						dwr.util.selectRange(jQuery("[x=2][y=4]"),0,this.MAX_INPUT_LENGTH);
						++y;
					}else {
						dwr.util.selectRange(jQuery("[y="+(++y)+"]"),0,this.MAX_INPUT_LENGTH);
					}					
				}
			});
			<%if(help!=null){%>
				jQuery.openPopupLayer({
					name:"HELP",
					width:300,
					target:"help"
				});
			<%}%>	
	});
	
	//用户名变成小写
	function loginToLowerCase(event){
		 var e=Event.element(event);
		 var loginName=jQuery(e).val();
		 if(loginName!=""){
		 	 jQuery(e).val(loginName.toLowerCase());
		 	}
		}
</script>
<title>webpos</title>


<body>
<div class="main">
<div class="kong">
    	<a href="#" class="logo">伯俊软件</a>
		<a target="_blank" class="webpos" href="WEBPOS登陆错误帮助.doc">帮助</a>
    </div><!--end kong-->

<%if(null==generateHTML){%>
<form action="/bpos/validate.jsp" method="post" onsubmit="return false" id="fm">
<%}%>
<div id="help" style="display:none">
	<table bgcolor="#CCFFFF">
		<tr><td align="right"><span class="ph" onclick="jQuery.closePopupLayer('HELP');">关闭</span></td></tr>
		<tr><td style="font-size:16px;font-weight:bold;color:red;">弹出窗口被阻止，<br/>无法正常进入WEBPOS！！！ <br/>请点击此<span class="ph" style="text-decoration:underline;" onclick="javascript:void window.open('/bpos/help.html','_blank','height=400,width=700,menubar=yes,scrollbar=no,Location=0,toolbar=no,resizable=yes,status=no')">---【帮助】---</span>......</td></tr>
	</table>
</div>
<ul>
<li id="singlestore" style="display:none">
<span style="font-family:'微软雅黑';font-weight:bold; color:#FFFFFF;font-size:15px;";>店&nbsp;&nbsp;仓&nbsp;&nbsp;名：</span>
<table align="left" style="text-align:left">
<tr>
<td  id="loginstore" class="login_TXT"></td>
</tr>
</table>
</li>
<%if(isNewVerssion){%>
<li id="hasNewVersion" ><DIV style="font-weight:bold; width:360px;font-size:16px;color:yellow;text-align:center; float:center;">版本升级中，请稍后。。。</DIV></li>
<%}%>
<li id="mulstores" style="display:none">
<span>店&nbsp;&nbsp;仓&nbsp;&nbsp;名：</span><select id="storeselect" class="loginSelect" style="width:225px;"></select>
</li>
<li><span>用&nbsp;&nbsp;户&nbsp;&nbsp;名：</span>
<input y=1 id="login" name="u" type="text" class="login_input" autocomplete="off" style="text-transform:lowercase" onkeyup="loginToLowerCase(event)"value=""/><span id="alert"></span>
</li>
<li><span>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</span>
<input y=2 id="password" name="p" autocomplete="off" <%if(isNewVerssion){%> disabled="true" <%}%> onsubmit="return false" type="password" onfocus="onBlur();" value="" class="login_input" /><input type="hidden" name="pj" id="paramjson"/>
</li>
<li id="loaddata">
<span>数据下载：</span>
	        <%
	    		String ref=request.getParameter("ref");
					if(null!=ref&&ref.trim().equals("new")){
						%>
						<input type="hidden" id="ref" value="new"/>
						<select id="selectdata" disabled="true" class="select_con">
						<%
					}else{
						%>
						<input type="hidden" id="ref" value=""/>
						<select y=3 id="selectdata" class="select_con" >
						<%
					}
    		%>
	
		<option id="option1" value="up" selected="" style="background:#FFFFFF;">增量</option>
		<option id="option2" value="all">全部</option>
	</select>
</li>
<li><span>&nbsp;</span>
<input x=1 y=4 id="ok" name="ok" <%if(isNewVerssion){%> disabled="true" <%}%> type="submit" value="登录" class="button1" onClick="javascript:submitForm()"/>
<input x=2 y=4 id="re" name="" type="reset" value="重置" class="button2" onclick="re();"/><input class="button3" x=3 y=4 id="data" name="data" onclick="Thrink()"/>
</li>	
</ul>
<div class="login-bottom">
&copy;2008-2012上海伯俊软件科技有限公司 版权所有 保留所有权<br />&nbsp;&nbsp;了解更多产品请点击：<a href="http://www.burgeon.com.cn" target="_blank" class="systemTXT">www.burgeon.com.cn </a></div>
<%if(null==generateHTML){%>
</form>
<%}%>
<OBJECT style="display:none" ID="MainApp" width="160" height="30" CLASSID="CLSID:<%=str%>" codebase="setup.cab"></OBJECT>
</div>
</body>

</html>
