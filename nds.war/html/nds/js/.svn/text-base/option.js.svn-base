var uc;
var OptionControl = Class.create();
// define constructor
OptionControl.prototype = {
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
		application.addEventListener( "SaveOption", this._onSaveOption, this);
		this.MAX_INPUT_LENGTH=1000;// this is used for selection range
	},
	_getInputs:function(form){
	    form = $(form);
	    var inputs = $A(form.getElementsByTagName('input'));
		inputs=inputs.concat($A(form.getElementsByTagName('textarea')));
		inputs=inputs.concat($A(form.getElementsByTagName('select')));
	    return inputs.map(Element.extend);
	},
	saveAll : function () {
		if(optionsave()==false) return;
		var evt={};
		evt.command="SaveOption";
		evt.params=$H(Form.serializeElements( this._getInputs("form1"),true));	
	    evt.callbackEvent="SaveOption";
		this._executeCommandEvent(evt);	
			
	 },
	_onSaveOption : function (e) {
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
	    		//w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'))",1);
				//reload window
				if(bReload)w.location.reload();
	    		isclosed=true;
    		}
    			art.dialog.close();
    	}
    	if(!isclosed && msg!=null){
				alert(msg);
    	}
    }
};

OptionControl.main = function () {
	uc=new OptionControl();
};

jQuery(document).ready(OptionControl.main);

function checkIsDate(control,desc){
if( control==undefined) return true;
    if(!isValidDate(control.value)){
        alert(desc+ gMessageHolder.MUST_BE_DATE_TYPE);
        control.focus();
        return false;
    }
    return true;
}
function checkSelected(optionControl, desc){
if( optionControl==undefined) return true;
      for(i=0; i<optionControl.options.length; i++) {
        if (optionControl.options[i].selected) {
            if( optionControl.options[i].value =='0'){
                alert(gMessageHolder.PLEASE_SELECT+desc+"!");
                optionControl.focus();
                return false;
            }
        }
      }
      return true;
}
function checkNotNull(control,desc){
    if(isWhitespace(control.value)){
       alert(desc+ gMessageHolder.CAN_NOT_BE_NULL+"!");
        control.focus();
        return false;
    }
    return true;
}
function checkIsNumber(control,desc){
    if(isNaN(control.value,10)){//Modify by Hawke
        alert(desc+ gMessageHolder.MUST_BE_NUMBER_TYPE+"!");
        control.focus();
        return false;
    }
    return true;
}
