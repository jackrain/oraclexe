var bpos;
var BPOS = Class.create();
// define constructor
BPOS.prototype = {
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
		application.addEventListener( "BPOS_DBJSON", this._dbjson, this);
		this.sendRequest();
	},
	sendRequest: function(){
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_DBJSON";
		var param={'storeid':13,'empid':12, 'product':15, 'str': 'test'};
		evt.param=Object.toJSON(param);
		evt.table="users";
		evt.action="test";
		evt.permission="w";
		
		this._executeCommandEvent(evt);		
	},
	
	_dbjson:function(e){
		var data=e.getUserData(); // data
		console.log(data);
		//{'caller':111,'empid':12,'storeid':13,'product':15,'data':'test'}
		var ret=data.jsonResult.evalJSON();
		
		$("caller").value= ret.caller;
		$("empid").value= ret.empid;
		$("storeid").value=ret.storeid;
		$("product").value=ret.product;
		$("data").value= ret.data;
	},
	/**
	* Request server handle command event
	* @param evt CommandEvent
	*/
	_executeCommandEvent :function (evt) {
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
BPOS.main = function () {
	bpos=new BPOS();
};

/**
* Init
*/
if (window.addEventListener) {
  window.addEventListener("load", BPOS.main, false);
}
else if (window.attachEvent) {
  window.attachEvent("onload", BPOS.main);
}
else {
  window.onload = BPOS.main;
}
