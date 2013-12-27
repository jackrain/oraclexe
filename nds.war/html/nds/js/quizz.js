var uq;
var QuizzControl = Class.create();
// define construqtor
QuizzControl.prototype = {
	initialize: function() {
		dwr.util.useLoadingMessage(gMessageHolder.LOADING)
		dwr.engine.setErrorHandler(function(message, ex) {
			if (message == null || message == "") {
				while(ex!=null && ex.cause!=null) ex=ex.cause;
				if(ex!=null)message=ex.javaClassName;
				alert(gMessageHolder.INTERNAL_ERROR+":"+ message);
			}
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else alert(message);
		});		
		application.addEventListener( "SaveQuizz", this._onSaveQuizz, this);
	},
	saveAll : function () {
		var q= document.getElementById("question").value;
		var a= document.getElementById("answer").value;
		if( isWhitespace(q) ||isWhitespace(a) ){
			alert("提问和回答都不能为空");
			return false;
		}
		var evt={};
		evt.command="SaveQuizz";
		evt.question=q;	
		evt.answer=a;
	    evt.callbackEvent="SaveQuizz";
		this._executeCommandEvent(evt);	
			
	 },
	_onSaveQuizz : function (e) {
     var r=e.getUserData(); 
		
		if(r.code!=0){
			this._showMessage(r.message,true);
		}else{
			this._closeWindowOrShowMessage(r.message,true);

		}   
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
				alert("msg");
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

QuizzControl.main = function () {
	uq=new QuizzControl();
};

jQuery(document).ready(QuizzControl.main);
