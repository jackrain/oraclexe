	var stores={};
	var sids="";
	var y;
	//测试URL地址是否为广域网地址
	function testUrl(URL){
		var strRegex="^http:\/\/.[^\\ ]+\/$";
		var re=new RegExp(strRegex);
		if(re.test(URL))return true;
		return false;
	}
	function updatecat(){	
		if($("selectdata").value=="all"&&$("ref").value!="new")$("ref").value="new";
		if($("ref").value=="new"){
			try{
				MainApp.SetVerDb("0");
			}catch(e){
				alert("WEBPOS未安装成功！");
			}
		}
	}


	var up=null;
	function selectTag(showContent,selfObj){
		// 2???
		var tag = document.getElementById("tags").getElementsByTagName("li");
		var taglength =tag.length;
		for(i=0; i<taglength; i++){
			tag[i].className = "";
		}
		selfObj.parentNode.className = "selectTag";
		// 2???
		for(i=0; j=document.getElementById("tagContent"+i); i++){
			j.style.display = "none";
		}
		document.getElementById(showContent).style.display = "block";	
	}
	
var pwd="";
var loginUrl="";
function onBlur(){
		jQuery.post("/bpos/validateuser.jsp",{email:document.getElementById("login").value},function(data){
		if(jQuery.trim(data)!="error"){
			jQuery("#alert").html("<font class='use_none'>用户存在</font>");
			pwd=data.substring(data.indexOf("+")+1);
			jQuery("#username").val(jQuery.trim(data));
		}else{
			jQuery("#alert").html("<font class='use_none'>用户不存在</font>");
			return;
		}
	});
}
//显示一个模式窗体
function  popUp(urls){
	var strs ='';
	for(var i=0;i<urls.length;i++){		
		strs +="<li><a href='http://"+jQuery.trim(urls[i])+"/bpos/login.jsp' target=\"_parent\" class=\"address-text\">http://"+urls[i]+"</a></li>\n";
	}
	var ele = Alerts.fireMessageBox({
				width: 400,
				modal: true,
				title: gMessageHolder.EDIT_MEASURE
	});
	var strTemp ="<div class=\"address\">"+
"<div class=\"address-title\">您只能选择以下地址登录</div>"+"<div class=\"address-deatail\">"+
"<div class=\"address-content\">"+"<ul align=center style=\"height: 150px; width: 280px; visibility: visible; opacity: 1; overflow:auto;\">"
+strs+"</ul></div></div><div class=\"address-bottom\"></div></div>";
		ele.innerHTML = strTemp;
		executeLoadedScript(ele);
}

function loginOnline(storeid){
  jQuery.ajax({
  	type:"POST",
  	url:"/bpos/validateuser.jsp",
  	data:{email:document.getElementById("login").value,storeid:storeid},
  	timeout:60000,
  	error:function(){
  		jQuery("#ok,#re,#data").removeAttr("disabled");
  		alert("网络不畅,请稍后再试！");
  	},
  	success:function(data){
			if(jQuery.trim(data)=="error"){
				jQuery("#ok,#re,#data").removeAttr("disabled");
   	    alert("用户不存在！");
   	    jQuery("#login").focus();
   	    return;
   	  } else{

          var urls=data.substring(0,data.indexOf("\t"));
          if(jQuery.trim(urls)!=""&&jQuery.trim(urls)!="null"){
						jQuery("#ok,#re,#data").removeAttr("disabled");
            if(-1==urls.lastIndexOf(window.location.host)){
              urls=urls.split("|");
              if(urls.length==1){
                window.location.href="http://"+jQuery.trim(urls[0])+"/bpos/login.jsp";
              }else{
                popUp(urls);
              }
              return false;
            }
          }
    		  if(jQuery.trim(pwd)==jQuery("#password").val()){  
    		    if(jQuery("#paramjson").val()=="invaildActivex"){
    		    	jQuery("#ok,#re,#data").removeAttr("disabled");
							alert("WEBPOS控件被禁用！请点击右上角帮助！");
							return;	
						}       		          
						if(!jQuery("#paramjson").val()){
							jQuery("#ok,#re,#data").removeAttr("disabled");
							alert("WEBPOS版本已更新，可能您的网速比较慢；请等待下载安装新版本！");
							return;
						}
    			     //调用submit的事件，提交
    			     updatecat();
               document.getElementById("fm").submit(); 
    			}else{
    				jQuery("#ok,#re,#data").removeAttr("disabled");
    			  alert("密码错误,请重新输入");
    			  jQuery("#password").val("");
    			  jQuery("#password").focus();
    			}   		    
	      
			}  		
  	}
  });    
}

function loginOffline(){
	var user=document.getElementById("login").value;
	var pw=document.getElementById("password").value;
	var storejson=jQuery("#paramjson").val();
	storejson=storejson.split(":");
	var storeId=storejson[0];
	if(user&&pw){
		var pw1=getUserInfoByStoreIdAndEmail(storeId,user).PASSWORD;
		if(pw1==pw){
			try{
				Cookies.set("name",user);
				Cookies.set("storeName",storejson[1]);
			}catch(e){}
			var d=new Date();
			var mins=parseInt(getMins(d),10);
			var md5=generateMd5(d.getDate(),(mins+3),storeId,user,pw);
			window.open("index.html?storeid="+storeId+"&storename="+storejson[1]+"&storecode="+storejson[2]+"&email="+user+"&md5="+md5+"&mins="+(mins+3),storeId,"fullscreen","top=0,left=0,menubar=yes,scrollbar=no,Location=0,toolbar=no,resizable=yes,status=no");	  
			if(window.name!=storeId){
				window.opener=null;
				window.open("","_parent","");
				window.close();
			}
			return;
		}
	}
	jQuery("#ok,#re,#data").removeAttr("disabled");
	alert("错误：验证失败！请确认店仓、用户、密码是否正确");
}
function readyLoadStoreInfo(){
			if(isIE()){
			try{
				var param=MainApp.GetConfig();	
				param=param.evalJSON();
				var storeids=jQuery.trim(param.PosConfig.StoreId).split("\t");
				var mochinecode=jQuery.trim(param.PosConfig.机器编号);
				var stn=decodeURIComponent(Cookies.get("storeName"),"UTF-8");
				if(storeids.length>1){
					var storenames=jQuery.trim(param.PosConfig.StoreName).split("\t");
					var storecodes=jQuery.trim(param.PosConfig.StoreCode).split("\t");
					jQuery("#singlestore").hide();
					jQuery("#mulstores").show();		
					var j=0;
					for(var i=0;i<storeids.length;i++){
						if(jQuery.trim(storeids[i])!=""&&jQuery.trim(storenames[i])!=""){
							if(i==0){
								sids+=storeids[i];
							}else{
								sids+=","+storeids[i];
							}
							var sto={};
							sto.storeid=storeids[i];
							sto.storename=storenames[i];
							sto.storecode=storecodes[i];
							sto.mochinecode=mochinecode;
							stores[j]=sto;
							var selectedStr="";
							if(stn==storenames[i])selectedStr="selected='selected'";
							jQuery("#storeselect").append("<option value='"+j+"' "+selectedStr+">"+storenames[i]+"</option>");
							j++;
						}
					}
					jQuery("#paramjson").val(stores[jQuery("#storeselect").val()].storeid+":"+stores[jQuery("#storeselect").val()].storename+":"+stores[jQuery("#storeselect").val()].storecode+":"+stores[jQuery("#storeselect").val()].mochinecode);
					jQuery("#storeselect").bind("change",function(event){
						jQuery("#paramjson").val(stores[jQuery("#storeselect").val()].storeid+":"+stores[jQuery("#storeselect").val()].storename+":"+stores[jQuery("#storeselect").val()].storecode+":"+stores[jQuery("#storeselect").val()].mochinecode);
					});
				}else{
					sids=storeids[0];
					jQuery("#singlestore").show();
					jQuery("#mulstores").hide();
					$("paramjson").value=param.PosConfig.StoreId+":"+param.PosConfig.StoreName+":"+param.PosConfig.StoreCode+":"+mochinecode;
					$("loginstore").innerHTML=param.PosConfig.StoreName;
				}
				
				if(testUrl("http://"+window.location.host+"/")){
					MainApp.SetHiddenConfigFile("URL","http://"+window.location.host+"/");
				}
						
			}catch(e){
				jQuery("#paramjson").val("invaildActivex");
			}
		}
}
//验证用户名和密码是否选中和填写
function submitForm(){
	jQuery("#ok,#re,#data").attr("disabled",true);
 //判断用户名、密码是否为空
		if(document.getElementById("login").value==""||document.getElementById("login").value==null){ 
			jQuery("#ok,#re,#data").removeAttr("disabled");
			alert("用户名不能为空");
			return;
	  }else if(document.getElementById("password").value=="" ||document.getElementById("password").value==null){
      jQuery("#ok,#re,#data").removeAttr("disabled");
      alert("请输入密码");
      jQuery("#password").focus();
      return;
    }else {    
     var paramjson=jQuery("#paramjson").val();
     var storeid="";
     if(paramjson&&paramjson!="invaildActivex"){
       	storeid=paramjson.substring(0,paramjson.indexOf(":"));
     }
     	if(testUrl("http://"+window.location.host+"/")){
     		loginOnline(storeid);
     	}else{
				loginOffline();   	
    	}
    }
}
	function re(){
		var str="";
		jQuery("#alert").html(str);
		delCookie("name");
		document.getElementById("login").value="";
		document.getElementById("password").value="";
		document.getElementById("login").focus();
	}
	//清除cookie
 function delCookie(name){
	  	   var date = new Date();
	  	   //alert("时间："+date.getTime());
         date.setTime(date.getTime() - 1000000);
         document.cookie = name + "=a; expires=" + date.toGMTString();
 }
 	
