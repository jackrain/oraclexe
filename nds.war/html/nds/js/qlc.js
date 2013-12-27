var qlc;
var QueryListConfig = Class.create();
// define constructor
QueryListConfig.prototype = {
	initialize: function() {
		this._tableId=-1;
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
		application.addEventListener( "QueryListConfig_SavePreference", this._saveQueryListConfig, this);
		this._tryUpdateTitle();
	},
	_tryUpdateTitle:function(){
		var w = window.opener;
		if(w==undefined)w= window.parent;
		if (w ){
			var te=w.document.getElementById("pop-up-title-0");
			if(te){
				te.innerHTML=document.title;
			}
		}
	},
	setTable:function(tid){
		this._tableId=tid;
	},
	/**
	 * Change current user's default view on the table
	 */
	switchView:function(qlcid){
		var evt={};
		evt.command="QueryListConfig_SavePreference";
		evt.callbackEvent="QueryListConfig_SavePreference";
		evt.qlcid=qlcid;
		evt.table=this._tableId;
		this._executeCommandEvent(evt);
	},
	modify:function(qlcId){
		showObject("/html/nds/query/querydef.jsp?table="+this._tableId+"&id="+qlcId, 900,500,{maxButton:false,closeButton:false});
	},
	/**
	 @param e struct:
	 getUserData:
	 	code, message, id (if new), name
	*/	
	_saveQueryListConfig:function(e){
		//console.log(e);
		var chkResult=e.getUserData(); // data
		msgbox(chkResult.message);
		if(chkResult.code==0){
			this.tryClose();
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
	},
	tryClose:function(ifr){
		
//    	var w = window.opener;
//    	if(w==undefined)w= window.parent;
//    	if (w ){
//			var iframe=w.document.getElementById("popup-iframe-0");
//			if(iframe){
//	    		w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'));pc.navigate('"+this._tableId +"')",1);
//    		}
//    	}
		var w = window.opener;
		if(w==undefined)w= window.parent;
		if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
	    		//w.setTimeout("Alerts.killAlert(document.getElementById('"+ifr+"'));",1);
	    		//var pid=iframe.parentNode.id.toString;
	    		//var dio=pid.substr(0,pid.length-7);
	    		 
	    		//art.dialog.closeFn("function(){pc.navigate('"+this._tableId +"')}");
	    		art.dialog.close();
	    		//pc.navigate(this._tableId);
	    		return true;
		            }
		return false;
      }
    	
    }	
};


function showObject(url, theWidth, theHeight,option){
	if( theWidth==undefined || theWidth==null) theWidth=956;
    if( theHeight==undefined|| theHeight==null) theHeight=570;
	//var options={width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE, modal:true,centerMode:"x",noCenter:true,maxButton:true};
    var options=$H({width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE,skin:'aero',ifrid:'popup-iframe-1',drag:true,lock:true,esc:true,skin:'chrome',ispop:false,close:null});
    if(option!=undefined) {
      Object.extend(options, option);
    	art.dialog.open(url,options);
    }
    	//Object.extend(options, option);
	//Alerts.popupIframe(url,options);
	//Alerts.resizeIframe(options);
	//Alerts.center();
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
	  document.getElementById(sObjectID+"_img").title=gMessageHolder.OPEN_NEW_WINDOW_TO_SEARCH;
	  document.getElementById(sObjectID).value="";
	}
}

