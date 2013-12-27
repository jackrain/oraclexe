var ql;
var QueryListControl = Class.create();

QueryListControl.prototype = {
	initialize: function() {
	//	dwr.util.useLoadingMessage(gMessageHolder.LOADING)
		dwr.engine.setErrorHandler(function(message, ex) {
			if (message == null || message == "") {
				while(ex!=null && ex.cause!=null) ex=ex.cause;
				if(ex!=null)message=ex.javaClassName;
			//	alert(gMessageHolder.INTERNAL_ERROR+":"+ message);
			}
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else alert(message);
		});		
		application.addEventListener( "QueryList", this._onQueryList, this);
	},
	_getInputs:function(form){
	    form = $(form);
	    var inputs = $A(form.getElementsByTagName('input'));
		inputs=inputs.concat($A(form.getElementsByTagName('textarea')));
	    return inputs.map(Element.extend);
	},
	queryAll : function () {
		var evt={};
		evt.command="QueryList";
		evt.params=$H(Form.serializeElements( this._getInputs("form1"),true));	
	    evt.callbackEvent="QueryList";
		this._executeCommandEvent(evt);	
			
	 },
	_onQueryList : function (e) {
     var r=e.getUserData(); 
		
		if(r.code!=0){
			this._showMessage(r.message,true);
		}
		else {
			window.location="/html/nds/website/001/result.vml";
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
	}
};

QueryListControl.main = function () {
	ql=new QueryListControl();
};

jQuery(document).ready(QueryListControl.main);