var lic=null;
var LICENSE=Class.create();
LICENSE.prototype={
	initialize: function() {
	dwr.util.setEscapeHtml(false);
	/** A function to call if something fails. */
	dwr.engine._errorHandler =  function(message, ex) {
	  	while(ex!=null && ex.cause!=null) ex=ex.cause;
	  	if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + "," + ex.message+","+ ex.cause.message, true);
		if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
	  	else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  	else alert(message);	
	}; 
	application.addEventListener( "GenerateLicense", this._onGenerateLicense, this);
  }, 
   gen :function(){
    	var evt={};
    	evt.command="GenerateLicense";
		evt.callbackEvent="GenerateLicense";
		evt.objectid=$("objectid").value;
		evt.password= $("password").value;
		this._executeCommandEvent(evt);	
    },
     _onGenerateLicense :function(e){
		var url=e.getUserData(); // data
		window.location.href=url;
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
LICENSE.main = function () {
	lic=new LICENSE();
};

/**
* Init
*/
jQuery(document).ready(LICENSE.main);
