var ahca;
var AHCA = Class.create();
// define constructor
AHCA.prototype = {
	initialize: function() {
		// init dwr
		dwr.util.useLoadingMessage(gMessageHolder.LOADING);
		dwr.util.setEscapeHtml(false);
		/** A function to call if something fails. */
		dwr.engine._errorHandler =  function(message, ex) {
	  		while(ex!=null && ex.cause!=null) ex=ex.cause;
	  		if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + ", " + ex.message+","+ ex.cause.message, true);
			if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else alert(message);
		};
		this._projectId = -1;
		this._errorCount=0;

		application.addEventListener( "DecriptPrice", this._onDecriptPrice, this);
						
	},
    _onDecriptPrice:function(e){
		var r=e.getUserData(); 
		$("tokens_all").innerHTML= r.tokenAllCount;
		$("token_pagecnt").innerHTML=r.priceObj.length;
		if(r.priceObj.length==0){
			 alert(r.message);
			 $("btn").hide();
			 $("loadimg").hide();
			 return;
		}
		var i, dp;
		var a=new Array();
		for(i=0;i< r.priceObj.length;i++){
			dp= this._decriptPrice(r.priceObj[i].pricecode,r.priceObj[i].id);
		    r.pricecode="";
			if(isNaN(dp,10)){
				this._addError(dp);
				this._errorCount=this._errorCount+1;
				if(this._errorCount>2){
					alert(gMessageHolder.TOO_MANY_ERROR);	
					return;
				}
		    }else{
		    	r.priceObj[i].price= dp;
		    	a.push(r.priceObj[i]);
		    }
		    $("token_pagecnt").innerHTML=r.priceObj.length-i-1;
		} 
		var evt={};
		evt.command="AHYY_LoadPriceCoded2";
		evt.projectid=this._projectId;
		evt.prices=a;
		evt.callbackEvent="DecriptPrice";
		this._executeCommandEvent(evt);
    },
    /**
     * Decript price and return double value
     */
    _decriptPrice:function(pcoded, pid){
    	try{
    		return usbkey.openEnvelopedMsg(pcoded);
    	}catch(ex){
    		return "解密失败(品种id="+pid+"):"+ ex.message;
    	}
    },
	_addError:function(line){
        $("errmsg").innerHTML=$("errmsg").innerHTML+line+"<br>";
	},
	/**
	 * @return true if exists key
	 */
	checkKeyExists:function(){
		try{
			usbkey.selectEncCert();
			return true;
		}catch(ex){
			alert(ex.message);
			return false;
		}
	},
	setProjectId:function(prjId){
		
		this._projectId= prjId;
	},
	/**
	 * Descript all prices
	 */
	beginDecript:function(prjId){
		if(!this.checkKeyExists()) return;
		$("btnprocess").disable();
		$("loadimg").show();
		this._projectId= prjId;
		var evt={};
		evt.command="AHYY_LoadPriceCoded2";
//		evt["nds.control.ejb.UserTransaction"]="N";//each line will have a seperate transaction
		evt.projectid=this._projectId;
		evt.callbackEvent="DecriptPrice";
		this._executeCommandEvent(evt);
		
	},
	
	_showMessage:function(msg, bError){
		if(msg==null ||(String(msg)).blank() ){
			$("message").style.visibility="hidden";
		}else{
			if(bError){
				msg="<div class='err-msg'>"+msg+"</div>";
			}else{
				msg="<div class='info-msg'>"+msg+"</div>";
			}
			$("message_txt").innerHTML=msg+"<div class='ptime'>"+this._currentTime()+"</div>";
			$("message").style.visibility="visible";
		}
	},
	/**
	* Request server handle command event
	* @param evt CommandEvent
	*/
	_executeCommandEvent :function (evt) {
		showProgressWindow(true);
		Controller.handle( Object.toJSON(evt), function(r){
				//try{
					var result= r.evalJSON();
					if (result.code !=0 ){
						alert(result.message);
					}else {
						var evt=new BiEvent(result.callbackEvent);
						evt.setUserData(result.data);
						application.dispatchEvent(evt);
					}
				/*}catch(ex){
					msgbox(ex.message);
				}*/
			
		});
	}
};
// define static main method
AHCA.main = function () {
	ahca=new AHCA();
};
jQuery(document).ready(AHCA.main); 

function msgbox(msg, title, boxType ) {
	alert(msg);
}
/**
* Show table object info
*/
function dlgo(tableId, objId){
	showObject("/html/nds/object/object.jsp?table="+tableId+"&id="+objId);
}

function showProgressWindow(bShow){
	
}
function debug(message, stacktrace){
	dwr.engine._debug(message, stacktrace);
}


