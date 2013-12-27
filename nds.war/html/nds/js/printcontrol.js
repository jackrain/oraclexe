var prt;
var PrintControl = Class.create();
// define constructor
PrintControl.prototype = {
	initialize: function() {
		dwr.engine.setErrorHandler(function(message, ex) {
			if (message == null || message == "") {
				while(ex!=null && ex.cause!=null) ex=ex.cause;
				if(ex!=null)message=ex.javaClassName;
				msgbox(gMessageHolder.INTERNAL_ERROR+":"+ message);
			}
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else msgbox(message);
		});		
		dwr.util.useLoadingMessage(gMessageHolder.LOADING);
		dwr.util.setEscapeHtml(false);
		application.addEventListener( "SavePrintSetting", this._onSavePrintSetting, this);
		application.addEventListener( "PrintJasper", this._onPrintJasper, this);
		this._tryAddCloseButton();
		this._bPrinted=false;// next time printing will not load from server
		
	},
	doPreview:function(){
		
    	var evt={};
		evt.tag="Preview";
		this._doPrint(evt);
    },
    doPrint:function(){
    	if(this._bPrinted){
    		window.print_iframe.print();
    		return;
		} 
    	var evt={};
		evt.tag="Print";
		this._doPrint(evt);
    },
    _doPrint:function(evt){
    	   	
		evt.command="PrintJasper";
		evt.callbackEvent="PrintJasper";
		evt.params=$H(Form.serializeElements( this._getInputs("form1"),true));	
		evt.params.template=dwr.util.getValue("tmpl");
		evt.params.format=dwr.util.getValue("fmt");

		this._executeCommandEvent(evt);
    },
    /**
	 * Includes input and textarea of parent element
	 */
	_getInputs:function(form){
	    form = $(form);
	    var inputs = $A(form.getElementsByTagName('input'));
		inputs=inputs.concat($A(form.getElementsByTagName('textarea')));
		inputs=inputs.concat($A(form.getElementsByTagName('select')));
	    return inputs.map(Element.extend);
	},
    _onPrintJasper:function(e){
		var d=e.getUserData(); // data
		var f="/servlets/binserv/GetFile?filename="+encodeURIComponent(d.printfile)+"&del=Y";
		
		//console.log(f);
		if(d.tag =="Print" ){
			var ifm=window.print_iframe;//$("print_iframe");
			var disabledZone=$('disabledZone');
			if(disabledZone)disabledZone.style.visibility = 'visible';
 			if(Prototype.Browser.IE){
 				$("print_iframe").onreadystatechange=function () {
        	   		if(this.readyState=="complete"){
						if($('disabledZone'))$('disabledZone').style.visibility = 'hidden';
						//bug here, so popup for easy
						//window.print_iframe.focus();
   						//window.print_iframe.print();
						
        	   		}
         		};
         		if($('disabledZone'))$('disabledZone').style.visibility = 'hidden';
         		window.location.href=f;
         		//window.print();
         		//ifm.location.href= f;
 			}else{
 				$("print_iframe").onload=function () {
 					//firefox will call onload before pdf is loaded completely, so we wait here
 					setTimeout('prt.waitOneMomentToPrint()', 1000);
         		};	
         		ifm.location.href= f;
 			}
			
			
		}else{
			popup_window(f);
		}
	},
	
	waitOneMomentToPrint:function(){
		if($('disabledZone'))$('disabledZone').style.visibility = 'hidden';
   		window.print_iframe.focus();
   		window.print_iframe.print();
   		this._bPrinted=true;
	},
    doSaveSettings:function(){
    	var evt={};
		evt.command="SavePrintSetting";
		evt.callbackEvent="SavePrintSetting";
		evt.tableid= $("tableid").value;
		evt.template=dwr.util.getValue("tmpl");

		evt.format=dwr.util.getValue("fmt");
		this._executeCommandEvent(evt);		
    	
    },
    
	/**
	 * @return false if failed to close
	 */
	closeDialog:function(){
		var w = window.opener;
		if(w==undefined)w= window.parent;
		if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
	    		//w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'));",1);
	    		art.dialog.close();
	    		return true;
			}
		}
		return false;
	},
	_tryAddCloseButton:function(){
		var w = window.opener;
		if(w==undefined)w= window.parent;
		var bCloseBtn=false;
		if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
				$("closebtn").innerHTML="<input class='cbutton' type='button' value='"+ gMessageHolder.CLOSE_DIALOG+
					"' onclick='prt.closeDialog()' name='Close'>";
				bCloseBtn=true;	
			}
		}
		if(!bCloseBtn){
			if(self==top){
				$("closebtn").innerHTML="<input type='button' class='cbutton' value='"+ gMessageHolder.CLOSE_DIALOG+
					"' onclick='window.close()' name='Close'>";
			}
		}
	},
	_onSavePrintSetting:function(e){
		var chkResult=e.getUserData(); // data
		msgbox(chkResult.message);
	},
    
	checkTemplate:function(tid){
    	showDialog("/html/nds/print/check_template.jsp?table="+tid, 400, 200,true);
    },
    editJReport:function(reportId){
    	url="/html/nds/object/object.jsp?table=ad_cxtab&id="+reportId;
    	popup_window(url);
    },
    editReport:function(reportId){
    	url="/html/nds/object/object.jsp?table=ad_report&id="+reportId;
    	popup_window(url);
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
PrintControl.main = function () {
	prt=new PrintControl();
};
jQuery(document).ready(PrintControl.main); 

function msgbox(msg, title, boxType ) {
	showProgressWindow(false);
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
