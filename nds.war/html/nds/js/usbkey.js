var usbkey;
var USBKey = Class.create();
// define constructor
USBKey.prototype = {
	
	initialize: function() {
		// need usb key
		this.cert=null;
		this.cn=null;
	}, 
	/**
	@bPrompt - prompt user for key selection
	*/
	loadKey:function(bPrompt){
		if(bPrompt){
			this._selectKey();
		}
		if(this.cert==null){
			this.cn =this.getCookie("usbkey");
			if(this.cn= ""){
				this._selectKey();
			}else{
				try{
					CryptoAgency1.CFCA_AddUseCertBySubject ( true,this.cn);
				} catch(e){}
				try{	
					this.cert = CryptoAgency1.CFCA_GetCertContent(true,0);
				}catch(e){
					this._selectKey();
				}
			}
		}
	},
	_selectKey:function(){
		CryptoAgency1.CFCA_SelectSignCerts("CFCA",false);
		//use this key to do sign
		var ct=  CryptoAgency1.CFCA_GetCertContent(true,0); 
		var n=  CryptoAgency1.CFCA_GetCertCN(ct); 
		var sm=CryptoAgency1.CFCA_SignMessageDetached(n,1);
		this.cert =ct ;
		this.cn= n;
		this.setCookie("usbkey",  this.cn, null);
	},
	signMessage:function(str){
		return CryptoAgency1.CFCA_SignMessage(str);
	},
	hashMessage:function(str){
		return CryptoAgency1.CFCA_HashMessage(str);
	},
	selectEncCert:function(){
		CryptoAgency1.CFCA_SelectEncCerts("CFCA",true,false);
	},
	/**
	 will raise exception when error found 
	*/
	envelopeMessage:function(str, bLoadCertFirst){
		if(bLoadCertFirst){
			var bSelectUserCerts = CryptoAgency1.CFCA_SelectEncCerts("CFCA",true,false);
		}
		try{
			return CryptoAgency1.CFCA_EnvelopeMessage(str);
		} catch(e){
			if(!bLoadCertFirst){
				var bSelectUserCerts = CryptoAgency1.CFCA_SelectEncCerts("CFCA",true,false);
				return CryptoAgency1.CFCA_EnvelopeMessage(str);
			}else{
				throw e;
			}
		}
	},
	openEnvelopedMsg:function(estr){
		try{
			return CryptoAgency1.CFCA_OpenEnvelopedMessage(estr);
		} catch(e){
			var bSelectUserCerts = CryptoAgency1.CFCA_SelectEncCerts("CFCA",true,false);
			return CryptoAgency1.CFCA_OpenEnvelopedMessage(estr);
		}
	},
	/**
	@return false if error found
	*/
	ahyyEncryptPrice:function(evt){
		// forcefully request key exists
		this._selectKey();
		var a=evt.modifyList;
		var i,price,line,lp;
		for(i=0;i<a.length;i++){
			line=a[i];
			price=line[4];//4 is price :-)
			if(Math.round (price*100) /100.0!=price) throw {message:"价格最多包含2位小数，请检查:"+ price};
			if(price> 100000000) throw {message:"价格不能超过1亿元，请检查:"+ price};
			//compare price with last price, which is set in line[0]
			lp=pc._data[line[0]][7];
			if(lp!=null && price> lp){
				throw {message:"价格不能高于上次报价"};
			}
			if(price <=0)throw {message:"价格不能小于等于0"};
			line[4]=usbkey.envelopeMessage(Math.round (price*100),false); // may throw exception, this can be decoded later
			
			//also upload current cn for checking
			line.push(this.cn );
			line.push( hex_md5(line[1]+ Math.round (price*100)) ); // last one is md5 of price,line[1] format:M{ROW.ID}
		}
		
	},	
	doPreparePrjPasswd:function(){
		if (!confirm("提交前务必牢记您输入的密码，一旦遗忘，后果严重。您确认记下了密码？")) {
        	return;
    	}
		if(this.cn==null){
			try{
				this.loadKey(true);
			}catch(e){
				alert("请先插入正确的USBKEY("+e.message+")");
				return;
			}
		}
		try{
			$("keycode").value=this.cn;
			$("pwdhash").value=this.envelopeMessage($("password1").value, true);
			$("pfm").submit();
		}catch(e){
			alert(e.message);
		}
		
	},
	reportError:function(err_name,err_message){
	    var err_info;
	    err_info = "错误:" + err_name + "\n错误信息:" + err_message;
	    alert("错误:" + err_name + "\n错误信息:" + err_message);
	},
	getCookie:function(c_name){
		if (document.cookie.length>0)
		  {
		  c_start=document.cookie.indexOf(c_name + "=");
		  if (c_start!=-1)
		    { 
		    c_start=c_start + c_name.length+1; 
		    c_end=document.cookie.indexOf(";",c_start);
		    if (c_end==-1) c_end=document.cookie.length;
		    return unescape(document.cookie.substring(c_start,c_end));
		    } 
		  }
		return "";
	},
	setCookie:function(c_name,value,expiredays){
		var exdate=new Date();
		exdate.setDate(exdate.getDate()+expiredays);
		document.cookie=c_name+ "=" +escape(value)+
		((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
	},
	doQuit:function(){
		if(this.cn==null){
			try{
				this.loadKey(true);
			}catch(e){
				alert("取消签名前请先插入USBKEY");
				return;
			}
		}
		$("keycode").value=this.cn;
		try{
			if( $("contract_info").value ==""){
				alert("合同内容未获取，请刷新当前页面重试");
				return;
			}
			if (!confirm("本合同的电子签名具有法律效力，只有原始签名人才能成功取消签名。您确认要取消签名吗？")) {
            	return;
        	}
			$("signature").value=this.signMessage($("contract_info").value);
			$("fm").submit();
		}catch(e){
			alert(e.message);
		}
	},
	doSign:function(){
		if(this.cn==null){
			try{
				this.loadKey(true);
			}catch(e){
				alert("签名前请先插入USBKEY");
				return;
			}
		}
		$("keycode").value=this.cn;
		try{
			if( $("contract_info").value ==""){
				alert("合同内容未获取，请刷新当前页面重试");
				return;
			} 
			if (!confirm("对本合同的电子签名将具有法律效力，您确认要进行签名吗？")) {
            	return;
        	}			
			$("signature").value=this.signMessage($("contract_info").value);
			$("fm").submit();
		}catch(e){
			alert(e.message);
		}
	},
	/**
		fm is form, fm should has input id/name="keycode"
		@param bForceUSB if true, will ask usb key insert
		@return false if should not submit form
	*/
	updateLoginForm:function(bForceUSB){
		if(this.cn==null){
			try{
				this.loadKey(bForceUSB);
			}catch(e){
				if(bForceUSB){
					alert("登录前请先插入正确的USBKEY("+ e.message+")");
					return false;
				}
			}
		}
		//sign cn
		
		if(this.cn!=null)$("keycode").value=this.cn;
		return true;
	}
	
};
// define static main method
USBKey.main = function () {
	usbkey=new USBKey();
};
//jQuery(document).ready(USBKey.main);
usbkey=new USBKey();
