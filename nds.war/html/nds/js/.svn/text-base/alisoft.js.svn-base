var ali;
var AlisoftControl = Class.create();
// define constralitor
AlisoftControl.prototype = {
	initialize: function() {
		dwr.util.useLoadingMessage(gMessageHolder.LOADING)
		dwr.engine.setErrorHandler(function(message, ex) {
			ali.toggleLoading(false);
			if (message == null || message == "") {
				while(ex!=null && ex.cause!=null) ex=ex.cause;
				if(ex!=null)message=ex.javaClassName;
				alert(gMessageHolder.INTERNAL_ERROR+":"+ message);
			}
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else alert(message);
		});		
		application.addEventListener( "LoadProduct", this._onLoadProduct, this);
	}, 
	/**
	 @param b - true for show loading image
	*/
	toggleLoading:function(b){
		if(b){
			$("progress").show();
			$("btn").hide();
		}else{
			$("btn").show();
			$("progress").hide();
		}
	},
	loadProduct : function () {
		ali.toggleLoading(true);
		var evt={}; 
		evt.command="Alisoft_LoadProducts";
	    evt.callbackEvent="LoadProduct";
		this._executeCommandEvent(evt);	
			
	 },
	_onLoadProduct : function (e) {
		ali.toggleLoading(false);
     	var r=e.getUserData(); 
		if(r.data!=null){
			//url for login to taobao
			window.location.href=r.data;
			return;
		}
		this._showMessage(r.message,true);
		/*if(r.code!=0){
			this._showMessage(r.message,true);
		}else{
			this._closeWindowOrShowMessage(r.message,false);
		} */  
	},	
	_executeCommandEvent :function (evt) {
		
		Controller.handle( Object.toJSON(evt), function(r){
				//try{
					var result= r.evalJSON();
					var evt=new BiEvent(result.callbackEvent);
					evt.setUserData(result);
					application.dispatchEvent(evt);
					}
	  );
	},
	_showMessage:function(msg, bError){
		if(msg!=null&&bError){
			alert(msg);
		}
	},
	tryClose:function(){
		// mandatory options should have data on it
		//if(optionsave()==false) return;
		this._closeWindowOrShowMessage(null,false);
	},
	 _closeWindowOrShowMessage:function(msg, bReload){
		var isclosed=false;
    	var w = window.opener;
    	if(w==undefined)w= window.parent;
    	if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
	    		w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'))",1);
				//reload window
				if(bReload)w.location.reload();
	    		isclosed=true;
    		}
    	}
    	if(!isclosed && msg!=null){
			alert(msg);
    	}
    }
};

AlisoftControl.main = function () {
	ali=new AlisoftControl();
};
AlisoftControl.loadPdt=function(){
	ali.loadProduct();
};
jQuery(document).ready(AlisoftControl.main);
