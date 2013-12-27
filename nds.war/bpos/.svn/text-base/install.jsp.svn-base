<%@ page language="java" import="java.util.*,java.io.*,nds.query.*,nds.util.Tools" pageEncoding="utf-8"%>
<%
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
	//int verssion=Tools.getInt(QueryEngine.getInstance().doQueryOne("select max(verssion) from webpos_verssion_info"),0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>webpos安装界面</title>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<link href="install.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="/html/nds/js/prototype.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.2.3/jquery.js"></script>
<script>
	function validateActiveX(typeId,v,msg){
		document.getElementById(typeId).value=v;
		document.getElementById("ActivesX").value="B";
		alert(msg);
		open("Untitled-2.html","","toolbars=1,resizable=1,location=1,statusbars=1,menubars=0,scrollbars=0,width=800,height=370");
	}
</script>
  <script>
      jQuery.noConflict();
var dotNETRuntimeVersion = "2.0.0.0";
function HasRuntimeVersion(versionToCheck){
var userAgentString = navigator.userAgent.match(/.NET CLR [0-9.]+/g);
if (userAgentString != null){
   var i;
   for (i = 0; i < userAgentString.length; ++i){
    if (CompareVersions(GetVersion(versionToCheck), GetVersion(userAgentString[i])) <= 0){
     return true;
    }
   }
}
return false;
}
// Extract the numeric part of the version string.

function GetVersion(versionString){
var numericString = versionString.match(/([0-9]+)\.([0-9]+)\.([0-9]+)/i);
return numericString.slice(1);
}

// Compare the 2 version strings by converting them to numeric format.

function CompareVersions(version1, version2){
for (i = 0; i < version1.length; ++i){
   var number1 = new Number(version1[i]);
   var number2 = new Number(version2[i]);
   if (number1 < number2){
    return -1;
   }
   if (number1 > number2){
    return 1;
   }
}
return 0;
}
function address(){
	var address=jQuery.trim(jQuery("#address").val()); 
	var strRegex="^http:\/\/.+\/$"; 
  var re=new RegExp(strRegex); 
  //alert(/^http:\/\/.+\/$/.test(address));
	    if(!re.test(address)){
		     alert("输入的地址格式错误");
		jQuery("#address").val("");
		jQuery("#address").focus();
		}
	}
function checkPosId(){
	var posid=jQuery.trim(jQuery("#posid").val());
	if(!/^[A-Za-z0-9]{2}$/.test(posid)){
		alert("请输入2位数字或字母！");
		jQuery("#posid").val("");
		jQuery("#posid").focus();
	}
}
function validate(){                                               //点击安装是调用validate()验证
	var FrameworkX=true;
	var ActiveXS=true;
	var storecode=jQuery.trim(jQuery("#storecode").val());						//获取店仓编号
	var storepw=jQuery.trim(jQuery("#storepw").val());								//获取初始密
	if(storecode==""||storepw==""){
		alert("店仓和密码不能为空！");
		return;
	}
	jQuery.post("validatestore.jsp",{"u":storecode,"p":storepw},function(data){
		var d=jQuery.trim(data);
		if(d=="error"){
			alert("错误！请确认店仓是否已安装、店仓编号和密码是否正确?");
			return;
		}else{
			var s=eval("("+d+")");
			//alert(s.code);
			var p={};
			var param={};
			param.storeid=s.id;
			param.storecode=s.code;
			param.storename=s.name;
			param.storetele=s.phone||"";
			param.storeaddr=s.addr||"";
			param.url=jQuery.trim(jQuery("#address").val()); 
			param.posno=jQuery.trim(jQuery("#posid").val());
			p.param=param;
			//alert(Object.toJSON(p));
			var ret=null;
			try{
					ret=MainApp.Install(Object.toJSON(p));
					MainApp.SetHiddenConfigFile("URL","http://"+window.location.host+"/");
					MainApp.SetHiddenConfigFile("Verssion","-1");
					MainApp.GetDownLoadUrl(true);
			}catch(e){
				if(!HasRuntimeVersion(dotNETRuntimeVersion))
					alert("请先下载安装Framework2.0!");
				else
			    alert("请确认IE配置是否正确及相关控件是否已安装");
				return;
			}
			ret=ret.evalJSON();
			if(ret&&ret.code=="1"){
				jQuery.post("validatestore.jsp",{"storeid":param.storeid},function(cbdata){
					if(cbdata){
						alert(cbdata);
					}else{
						alert(ret.meg);
						window.location.href="http://"+window.location.host+"/bpos/login.jsp?ref=new";
					}
				});
				
			}else if(ret.code=="-1"){
				alert(ret.meg);
			}
		}
	});
}
jQuery(document).ready(function(){
	jQuery("#hasNewVersion").html("<span>数据下载地址：</span><input onblur=\"address()\" name=\"\" id=\"address\" type=\"text\"  class=\"login_input\" />");
	jQuery("input").removeAttr("disabled");
	if(!HasRuntimeVersion(dotNETRuntimeVersion)){
		jQuery("#isfw").css("display","");
		//jQuery("#UpdateReg").css("display","none");
		//jQuery("#msg").css("display","none");
	}
	
	/*jQuery("#obj").html("<OBJECT ID=\"MainApp\" width=\"160\" height=\"30\" CLASSID=\"CLSID:<%=str.trim()%>\" codebase=\"setup.cab\"></OBJECT>");*/
		
	jQuery("#posid").focus();
	var a="http://"+window.location.host+"/";
	jQuery("#address").val(a);
});
</SCRIPT>
</head>
<body class="system-body">
<form>
<input type="hidden" id="Framework" value="A" /> <!--判断Framework控件是否已经安装  已安装值为 A 反之为B-->
<input type="hidden" id="ActivesX" value="A" /> <!--判断ActivesX控件是否已经安装  已安装值为 A 反之为B-->
</form>
<!--<div class="system-content">
<div class="system-content-height"></div>
<div class="system-content-logo"></div>
<div class="system-text">
<a href="dotnetfx.exe" id="isfw" style="display:none" class="systemTitle">请先下载安装Framework2.0</a>
</div>
<div class="system-content-userBG">

<div class="system-content-user">
<ul>
<li id="hasNewVersion">
<DIV style="font-weight:bold;color:red;text-align:right;font-size:15px">数据下载中，请稍后。。。。</DIV>
</li>
<li>
<div class="userTXT-left">POS机编号：</div>
<div class="userTXT-right"><input disabled="true" id="posid" name="" type="text"  class="system-content-userINPUT"/></div>
</li>
<li>
<div class="userTXT-left">店仓编号：</div>
<div class="userTXT-right"><input disabled="true" onfocus="checkPosId()" id="storecode" name="" type="text" class="system-content-userINPUT" /></div>
</li>
<li>
<div class="userTXT-left">初始密码：</div>
<div class="userTXT-right"><input disabled="true" onfocus="checkPosId()" id="storepw" name="" type="password" class="system-content-userINPUT" /></div>
</li>

<li>
<div class="userTXT-left"></div>
<div class="userTXT-center"><input disabled="true" onclick="validate()" name="" type="image" src="images/system-btn-az.png" width="50" height="19" />&nbsp;<input disabled="true" name="" type="image" src="images/system-btn-qx.png" width="50" height="19" /></div>
</li>
</ul>
</div>

</div>

<div class="system-content-bottom">&copy;2008-2010 上海伯俊软件科技有限公司 版权所有 保留所有权<br />了解更多产品请点击：<a href="http://www.burgeon.com.cn" target="_blank" class="systemTXT">www.burgeon.com.cn </a></div>
</div>-->


<div class="main">
	<div class="kong">    
       <a href="dotnetfx.exe" id="isfw" style="display:none;"  class="tips">请先下载安装Framework2.0</a>
    	<a href="#" class="logo">伯俊软件</a>
        <a href="WEBPOS登陆错误帮助.doc" class="webpos">帮助</a>
    </div><!--end kong-->
    <h1>安装界面</h1>
    <ul>
    	<form action="" method="get">
    		<li id="hasNewVersion"><DIV style="font-weight:bold;color:red;text-align:center;font-size:15px">数据下载中，请稍后。。。。</DIV></li>
            <li><span>POS机编号：</span><input disabled="true" id="posid" name="" type="text" class="login_input" /></li>
            <li><span>店仓编号：</span><input disabled="true" onfocus="checkPosId()" id="storecode" name="" type="text" class="login_input" /></li>
            <li><span>初始密码：</span><input disabled="true" onfocus="checkPosId()" id="storepw" name="" type="password"  class="login_input" /></li>

            <li><span>&nbsp;</span><input disabled="true" onclick="validate()" type="button" value="登录" class="button1" /><input disabled="true" name=""   type="reset" value="取消" class="button2" /></li>
        </form>
    </ul>
    <div class="copy">
    	©2008-2012上海伯俊软件科技有限公司 版权所有 保留所有权<br />
  了解更多产品请点击：<a href="http://www.burgeon.com.cn" target="_blank">www.burgeon.com.cn</a>
    </div>
    
</div><!--end main-->
<div style="display:none" id="obj"><OBJECT ID="MainApp" width="160" height="30" CLASSID="CLSID:<%=str.trim()%>" codebase="setup.cab"></OBJECT></div>
</body>
</html>
