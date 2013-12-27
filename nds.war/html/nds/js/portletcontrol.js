var ptc=null;
var PortletControl = Class.create();
// define constructor
PortletControl.prototype = {
	initialize: function() {
		// init dwr
		this._dwrInitialized=false;
	},
	_checkDwr:function(){
		if(this._dwrInitialized) return;
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
		this._dwrInitialized=true;
	},
	executeCmdList:function(cmd){
	    if (cmd.indexOf("Delete")>=0 ){
	        if (!confirm(gMessageHolder.DO_YOU_CONFIRM_DELETE)) {
	            return false;
	        }
	    }
	    if(this._tableObj.actionGROUPSUBMIT==true){
	    	if(cmd.indexOf("Submit")>=0 && this._isMultipleRowSelected() ){
		    	if (!confirm(gMessageHolder.DO_YOU_CONFIRM_GROUPSUBMIT)) {
		            return false;
		        }
	    	}
	    }
	    
	    $("list_form").command.value=cmd;
	    
	    toggleButtons($("list_query_form"),true);
		progressBar.showBar();
		progressBar.togglePause();
		this._isListPageLoaded=false;
		this._listPageLoadTime=0;
		setTimeout("ptc.checkListPageLoaded();",2 * 1000);
		this._loadForm($("list_form"),"/control/command",null, function (xmlHttpReq) {
			var e=$("page-table-content");
			e.innerHTML = xmlHttpReq.responseText;
			executeLoadedScript(e);
			ptc._isListPageLoaded=true;
			ptc._stopListPageLoadingState();
		});
	    
	},
	/**
	 @return main table record ids selected in array
	*/
	_getSelectedItemIds:function(ns){
		var itemIdObjs=$(ns+"list_data_form").getElementsBySelector("input[name='selectedItemIdx']");
		var selectedIds=Array();
		var i=0,j;
		for(j=0;j< itemIdObjs.length;j++){
			if( itemIdObjs[j].checked==true){
			  	var oid=parseInt(itemIdObjs[j].id.replace(/chk_obj_/g, ""));
			  	selectedIds.push(oid);
			}
		}
		//debug("_getSelectedItemIds="+ selectedIds);
		return selectedIds;
	},
	/**
	* Replacement of /home/nds/js/common.js#getSelectedItemIdx, limit search within "list_data_form"
	* @return item ids of checkbox named "selectedItemIdx" if it is checked
	*/
	_getSelectedItemIdx:function(ns){
		var itemIdObjs=$(ns+"list_data_form").getElementsBySelector("input[name='selectedItemIdx']");
		var selectedIdx=Array();
		var i=0,j;
		for(j=0;j< itemIdObjs.length;j++){
			if( itemIdObjs[j].checked==true){
			  	     selectedIdx[i++]= j;
			}
		}
		return selectedIdx;		
	},

	toggleSubTotal:function(ns){
		var b= dwr.util.getValue($(ns+"chk_select_all_fullrange"));
		dwr.util.setValue($(ns+"list_form_fullrange"), !b);
		this.refreshList(ns);
	},	
	/**
	 * mark all check box checked
	 */
	selectAll:function(ns){
		var i;
		var b= dwr.util.getValue($(ns+"chk_select_all"));
        var itemIdObjs=$(ns+"list_data_form").getElementsBySelector("input[name='selectedItemIdx']");
        for(i=0;i< itemIdObjs.length;i++){
           dwr.util.setValue(itemIdObjs[i], b);
		}
	},
	unselectall:function(ns){
		var b= dwr.util.getValue($(ns+"chk_select_all"));
	 	dwr.util.setValue($(ns+"chk_select_all"), !b);
	},
	changeStart:function(ns,start){
		this.refreshList(start,$(ns+"list_form_range"));
	},
	changeRange:function(ns,range){
  	 	this.refreshList($(ns+"list_form_start").value,range);
    },
	scrollPage: function (ns, t) {
		//var t=event.target.id;
		var s;
		var qs=parseInt($(ns+"list_form_start").value,10);
		var qrange=parseInt( $(ns+"list_form_range").value,10);
		var qtot=parseInt($(ns+"list_form_totalrowcount").value,10);
		
		if(t=="begin_btn")s=0;
		else if(t=="prev_btn") s= qs-qrange;
		else if(t=="next_btn") s= qs+qrange;
		else if(t=="end_btn") s= qtot-qrange+1;
		else s= qs;
		
		$(ns+"list_form_start").value=s;
		$(ns+"list_form_range").value=qrange;
		this.queryList(ns,$(ns+"list_form"));
	},
    quickSearch:function(ns,searchBoxName,bSearchInResult){
		try{		
			var tForm =$(ns+"list_form");
			$(ns+"list_form_start").value="1";
			$(ns+"quick_search").value="true";
			$(ns+"quick_search_data").value=$(ns+searchBoxName+"quick_search_data").value;
			$(ns+"quick_search_column").value=$(ns+searchBoxName+"quick_search_column").value;
			if(bSearchInResult==undefined || !bSearchInResult){
				var pe=$(ns+"param_expr");
				pe.value="";
			}
			this.queryList(ns,$(ns+"list_form"));
			//sync searchbox
			var peer="t";
			if(searchBoxName=="t")peer="b";
			var e=$(ns+peer+"quick_search_column");
			if(e!=null){
				e.value=$(ns+searchBoxName+"quick_search_column").value;
				$(ns+peer+"quick_search_data").value=$(ns+searchBoxName+"quick_search_data").value;
			}
		}catch(e){
			alert(gMessageHolder.CAN_NOT_QUICK_SEARCH+":"+e);
		}    	
    },
    refreshList:function(ns,start, range){
    	if(start!=undefined)$(ns+"list_form_start").value=start;
    	if(range!=undefined)$(ns+"list_form_range").value=range;
		this.queryList(ns,$(ns+"list_form"));
    },
	queryList:function(ns,fm){
		var fargs={namespace:ns};
		this._loadForm(fm,"/servlets/QueryInputHandler",null, function (xmlHttpReq,myargs) {
			try{
				var namespace= myargs.namespace;
				var e=$(namespace+"table-content");
				e.innerHTML = xmlHttpReq.responseText;
				executeLoadedScript(e);
			}catch(ex){
				alert(ex);					
			}
		}, fargs);
	},
	reOrder:function( ns,columnValue){
        if($(ns+"list_form_ordercolumns").value == columnValue){
            if($(ns+"list_form_orderasc").value == 'true')
                $(ns+"list_form_orderasc").value = 'false';
            else
                $(ns+"list_form_orderasc").value = 'true';
        }else{
            $(ns+"list_form_ordercolumns").value = columnValue;
            $(ns+"list_form_orderasc").value = 'true';
        }
        this.refreshList(ns,1);
    },
    _submitToNewWindow:function(ns,resulthandler){
		var oldResultHanlder=$(ns+"list_form_resulthandler").value;
        $(ns+"list_form_resulthandler").value=resulthandler;
        $(ns+"list_form").submit();
        $(ns+"list_form_resulthandler").value=oldResultHanlder;
    },
    unselecListAll:function(ns){
    	var e=$(ns+"chk_select_all");
    	if(e!=null && e.checked){
    		dwr.util.setValue(e,false);
		}
    },
    _onListOperation:function(e, bRefreshList){
    	var chkResult=e.getUserData(); // data
		if(chkResult.message){
			msgbox(chkResult.message.replace(/<br>/g,"\n"));
		}
		if(bRefreshList){
			this.refreshList(chckResult.ns);
		}
    },
    _onListSubmit:function(e){
    	this._onListOperation(e,true);
    },
    /* On event returned from server
    */
    _onListDelete:function(e){
		this._onListOperation(e,true);
    },
    /**
    * submit form, normally modify form
    */
    submitForm:function(fm){
    	alert("not implemented yet!");
    },
    doShowObject:function(tableId, objectId){
		var url="/html/nds/object/object.jsp?input=true&table=" +tableId+ "&id=" + objectId;
		popup_window(url);
    },
    doSelectView:function(viewIdString,objectId){
    	var url= "/html/nds/objext/selectview.jsp?table=" +viewIdString + "&id=" + objectId;
    	popup_window(url);
    },
    doCopyTo:function(tableId, objectId, fixedColumns){
    	var url="/html/nds/objext/copyto.jsp?src_table="+ tableId+
		"&dest_table=-1&fixedcolumns="+ fixedColumns+
		"&objectids="+objectId;
		popup_window(url);
    },
    doPrint:function(tableId, objectId){
		popup_window("/html/nds/print/options.jsp?table=" + tableId + "&id=" + objectId);
    },
	doGoModifyPage:function(tableId, objectId, url){
		popup_window(url);
	},
	doCreate:function(ns,tableName){
		var fm=$(ns+"fm");
		//var tableName=fm.getElementsBySelector("input:[name='tablename']")[0];
		fm.getElementsBySelector("input:[name='command']")[0].value=tableName+"Create";
		if(eval(ns+"checkOptions()")==true){
	       	this.submitForm(fm);
    	}
    },
	doModify:function(ns, tableName){
		var fm=$(ns+"fm");
		if(tableName==undefined)
			tableName=fm.getElementsBySelector("input:[name='tablename']")[0];
		fm.getElementsBySelector("input:[name='command']")[0].value=tableName+"Modify";
		if(eval(ns+"checkOptions()")==true){
	       	this.submitForm(fm);
    	}
    },
    doSubmit:function(ns, tableName){
		var fm=$(ns+"fm");
		if(tableName==undefined)
			tableName=fm.getElementsBySelector("input:[name='tablename']")[0];
		fm.getElementsBySelector("input:[name='command']")[0].value=tableName+"Submit";
       	this.submitForm(fm);
    },
	doDelete:function(ns, tableName,tableDesc){
    	if (!confirm(gMessageHolder.DO_YOU_CONFIRM_DELETE+" "+ tableDesc+"?")) {
            return false;
        }
		var fm=$(ns+"fm");
		fm.getElementsBySelector("input:[name='command']")[0].value=tableName+"Delete";
       	this.submitForm(fm);
    },
    doModifyList:function(ns){
		var itemIdObjs=$(ns+"list_data_form").getElementsBySelector("input[name='selectedItemIdx']");
		var i=0,j;
		for(j=0;j< itemIdObjs.length;j++){
			if( itemIdObjs[j].checked==true){
				var oid=itemIdObjs[j].id.replace(/chk_obj_/g, "");
				this.showMainObject(oid);
			  	return;
			}
		}
        alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
    },

    doDeleteList:function(ns){
		var evt={};
		evt.command="ListDelete";
		evt.callbackEvent="ListDelete";
		evt.table=this._tableObj.id;
		evt.tag=ns;
		evt.itemid=this._getSelectedItemIds(ns);
		if(evt.itemid.length==0){
 			alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
            return;				
		}
		this.executeCommandEvent(evt);    	
    },
    doSubmitList:function(ns){
		var evt={};
		evt.command="ListSubmit";
		evt.callbackEvent="ListSubmit";
		evt.table=this._tableObj.id;
		evt.tag=ns;
		evt.itemid=this._getSelectedItemIds(ns);
		if(evt.itemid.length==0){
 			alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
            return;				
		}
		this.executeCommandEvent(evt);    	
    },
    doListAdd:function(){
    	popup_window("/html/nds/objext/object_batchadd.jsp?table="+this._tableObj.id);
    },
    doSmsList:function(){
    	this._submitToNewWindow("/html/nds/reports/create_sms_report.jsp");
    },
    doUpdate:function(){
    	this._submitToNewWindow("/html/nds/objext/batchupdate.jsp");
    },
    doExportList:function(){
    	this._submitToNewWindow("/html/nds/reports/create_report.jsp");
    },
    doReport:function(){
    	this._submitToNewWindow("/html/nds/cxtab/create_cxtabrpt.jsp");
    },
    doPrintList:function(){
    	this._submitToNewWindow("/html/nds/print/options.jsp");
    },
    doImport:function(){
    	popup_window("/html/nds/objext/import_excel.jsp?table="+this._tableObj.id);
    },
	doListCopyTo:function(){
		this._doActionOnSelectedItems("/html/nds/objext/copyto.jsp?src_table="+this._tableObj.id);
	},
	doUpdateSelection:function(){
		this._doActionOnSelectedItems("/html/nds/objext/selectedupdate.jsp?table="+this._tableObj.id);
	}, 
	doUpdateResultSet:function(){
		this._submitToNewWindow("/html/nds/objext/batchupdate.jsp");
	},
	_doActionOnSelectedItems:function(uri){
		var objectIds="";
        var selectedIdx = this._getSelectedItemIdx();
        if (selectedIdx==null || selectedIdx.length ==0) {
            alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
            return false;
        } 
        var itemIdObjs=$("list_data_form").getElementsBySelector("input[name='itemid']");
        var itemIdObj;
        if (itemIdObjs.length ==null){
            // only one item found, and selected
            itemIdObj=itemIdObjs;
            objectIds= objectIds +  itemIdObj.value;
        }else{
            for(i=0;i< selectedIdx.length;i++){
            	itemIdObj= itemIdObjs[selectedIdx[i]];
            	if(i!=0){ objectIds =objectIds + ","; }
            	objectIds = objectIds + itemIdObj.value;
            }
		}
		if(selectedIdx.length>20){
			alert(gMessageHolder.PLEASE_SELECT_LINES_LESS_THAN);
			return false;
		}
		popup_window(uri+ "&objectids="+encodeURIComponent(objectIds));

	},
    printDocument:function(){
    	this._submitToNewWindow("/html/nds/print/options.jsp");
    },
	_stopListPageLoadingState:function(){
		progressBar.togglePause(); 
		progressBar.hideBar();
		toggleButtons($("list_query_form"),false);
	},
	checkListPageLoaded:function(){
  		if(this._isListPageLoaded==true || this._listPageLoadTime>15){
  			if(this._listPageLoadTime>15){
  				alert(gMessageHolder.TIME_OUT);
  			}
  			this._stopListPageLoadingState();
  		}else{
  			this._listPageLoadTime=this._listPageLoadTime+1;
  			setTimeout("ptc.checkListPageLoaded();",2 * 1000);
  		}
     },
	_loadForm:function(form, action, elId, returnFunction,returnArgs) {
		var pos = action.indexOf("?");
	
		var path = action;
		var queryString = "";
	
		if (pos != -1) {
			path = action.substring(0, pos);
			queryString = action.substring(pos + 1, action.length);
		}
	
		if (!queryString.endsWith("&")) {
			queryString += "&";
		}
	
		for (var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];
	
			if ((e.name != null) && (e.value != null)) {
				queryString += e.name + "=" + encodeURIComponent(e.value) + "&";
			}
		}
		loadPage(path, queryString, returnFunction,returnArgs);
		
		/*fm.request({
			onComplete:returnFunction }
		);*/
	},
	
     
	/**
	* Request server handle command event
	* @param evt CommandEvent
	*/
	executeCommandEvent :function (evt) {
		this._checkDwr();
		showProgressWindow(true);
		Controller.handle( Object.toJSON(evt), function(r){
				//try{
					var result= r.evalJSON();
					if (result.code !=0 ){
						msgbox(result.message);
					}else {
						var evt=new BiEvent(result.callbackEvent);
						evt.setUserData(result); // result.data
						application.dispatchEvent(evt);
					}
				/*}catch(ex){
					msgbox(ex.message);
				}*/
			
		});
	}
};
// define static main method
PortletControl.main = function () {
	if(ptc==null)ptc=new PortletControl();
};

/**
* Init
*/
if (window.addEventListener) {
  window.addEventListener("load", PortletControl.main, false);
}
else if (window.attachEvent) {
  window.attachEvent("onload", PortletControl.main);
}
else {
  window.onload = PortletControl.main;
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
	  try{document.getElementById(sObjectID+"_expr").value="";}catch(ex){}
	  try{document.getElementById(sObjectID+"_sql").value="";}catch(ex){}
	  document.getElementById(sObjectID+"_img").src=NDS_PATH+"/images/find.gif";
	  document.getElementById(sObjectID+"_img").alt=gMessageHolder.OPEN_NEW_WINDOW_TO_SEARCH;
	  document.getElementById(sObjectID).value="";
	}
}
function showObject(url){
	popup_window(url);
}

function checkIsDate(fm, inputName,desc){
	var a=fm.getElementsBySelector("input:[name='"+inputName+"']");
	var control=(a.length>0?null:a[0]);
	if( control==null) return true;
    if(!isValidDate(control.value)){
        alert(desc+ gMessageHolder.MUST_BE_DATE_TYPE);
        control.focus();
        return false;
    }
    return true;
}
function checkSelected(fm, inputName,desc){
	var a=fm.getElementsBySelector("input:[name='"+inputName+"']");
	var optionControl=(a.length>0?null:a[0]);
	if( optionControl==null) return true;
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
function checkNotNull(fm, inputName,desc){
	var a=fm.getElementsBySelector("input:[name='"+inputName+"']");
	var control=(a.length>0?null:a[0]);
	if( control==null) return true;
    if(isWhitespace(control.value)){
        alert(desc+ gMessageHolder.CAN_NOT_BE_NULL+"!");
        control.focus();
        return false;
    }
    return true;
}
function checkIsNumber(fm, inputName,desc){
	var a=fm.getElementsBySelector("input:[name='"+inputName+"']");
	var control=(a.length>0?null:a[0]);
	if( control==null) return true;
    if(isNaN(control.value,10)){//Modify by Hawke
        alert(desc+ gMessageHolder.MUST_BE_NUMBER_TYPE+"!");
        control.focus();
        return false;
    }
    return true;
}