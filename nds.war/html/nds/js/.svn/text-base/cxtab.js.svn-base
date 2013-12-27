var cxtabControl;
var CxtabControl = Class.create();
// define constructor
CxtabControl.prototype = {
	initialize: function() {
		// init dwr
		dwr.util.useLoadingMessage(gMessageHolder.LOADING);
		dwr.util.setEscapeHtml(false);
		/** A function to call if something fails. */
		dwr.engine._errorHandler =  function(message, ex) {
	  		while(ex!=null && ex.cause!=null) ex=ex.cause;
	  		if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + ", " + ex.message+","+ ex.cause.message, true);
			if (message == null || message == "") msgbox("A server error has occured. More information may be available in the console.");
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else msgbox(message);
		};
		application.addEventListener( "CheckCxtabProcessParam", this._checkCxtabProcessParam, this);
		$("btnExecuteCxrpt").disable();
		
	},
	/** 
	this function will be overriden by processparam.jsp
	*/
	validateProcessParam:function(){
		alert("default validateProcessParam function");
		return true;
	},
	/**
	  Create an event to server, load cxtab process definition and params if needed
	*/
	loadCxtabProcessParam: function(){
		// check matrix first
		var evt={};
		evt.command="CheckCxtabProcessParam";
		evt.callbackEvent="CheckCxtabProcessParam";
		evt.cxtab=$("cxtab").value;
		this._executeCommandEvent(evt);
		$("btnExecuteCxrpt").disable();
	},
	/**
	  make sure that all not null params are set, and direct to differenct page according to runnow checkbox
	*/
	submitForm:function(){
		if(this.validateProcessParam()==false) return;
		if(!checkNotNull($("queue"),gMessageHolder.AUTO_UPDATE_SCHEDULE))return false;		
		if(!checkNotNull($("filename"),gMessageHolder.FILE_NAME))return false;
		cxtabrpt_form.submit();		
				
	},
	/**
	 * handle process infomation display
	 * returned data should contained 3 segments:1 is script, 2 is dom, 3 is other scripts
	   		   
	 */
	_checkCxtabProcessParam:function(e){
		var chkResult=e.getUserData(); // data
		if(chkResult.code!=0){
			msgbox(chkResult.message);
		}else{
			var ele =$("process_param_div");
			ele.innerHTML=chkResult.pagecontent;
			executeLoadedScript(ele);
			ele.show();
			$("btnExecuteCxrpt").enable();	
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
						msgbox(result.message);
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
CxtabControl.main = function () {
	cxtabControl=new CxtabControl();
};

/**
* Init
*/
if (window.addEventListener) {
  window.addEventListener("load", CxtabControl.main, false);
}
else if (window.attachEvent) {
  window.attachEvent("onload", CxtabControl.main);
}
else {
  window.onload = CxtabControl.main;
}

function msgbox(msg, title, boxType ) {
	showProgressWindow(false);
	alert(msg);
}
/**
* Show table object info
*/
function dlgo(tableId, objId){
	popup_window("/html/nds/object/object.jsp?table="+tableId+"&id="+objId);
}

function executeLoadedScript(el) {
	var scripts = el.getElementsByTagName("script"); // to enable all scripts, el must be set in table
	for (var i = 0; i < scripts.length; i++) {
		if (scripts[i].src) {
			var head = document.getElementsByTagName("head")[0];
			var scriptObj = document.createElement("script");

			scriptObj.setAttribute("type", "text/javascript");
			scriptObj.setAttribute("src", scripts[i].src);

			head.appendChild(scriptObj);
		}
		else {
			//try {
				if (is_safari) {
					eval(scripts[i].innerHTML);
				}
				else if (is_mozilla) {
					eval(scripts[i].textContent);
				}
				else {
					eval(scripts[i].text);
				}
			/*}
			catch (e) {
				alert(e);
			}*/
		}
	}
}
function showProgressWindow(bShow){
	
}
function debug(message, stacktrace){
	dwr.engine._debug(message, stacktrace);
}

function pop_up_or_clear(src, url, window_name, sObjectID){
	var oWorkItem = src;
	if ( oWorkItem.name=="popup"){
	  popup_window(url,window_name);
	}else{
	  document.getElementById(sObjectID + "_link").name="popup"; // reset to popup
	  document.getElementById(sObjectID+"_expr").value="";
	  document.getElementById(sObjectID+"_sql").value="";
	  document.getElementById(sObjectID+"_img").src=NDS_PATH+"/images/find.gif";
	  document.getElementById(sObjectID+"_img").alt=gMessageHolder.OPEN_NEW_WINDOW_TO_SEARCH;
	  document.getElementById(sObjectID).value="";
	}
}

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