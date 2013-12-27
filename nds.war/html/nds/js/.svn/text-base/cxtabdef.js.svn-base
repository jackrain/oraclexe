var cxtabDefControl;
var CxtabDefControl = Class.create();
// define constructor
CxtabDefControl.prototype = {
	initialize: function() {
		this._selectedColumn={};
		this._measures=[];
		this._axisP=[];
		this._axisH=[];
		this._axisV=[];
		this._selectedMeasureIdx=-1;
		this._selectedAxisIdx=-1;
		var initObj=new CxtabDefInitObject();
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
		application.addEventListener( "LoadCxtabJson", this._loadCxtabDef, this);
		application.addEventListener( "SaveCxtabJson", this._saveCxtabDef, this);
		this._cxtabId=initObj.getCxtabId();
		this._parentId=initObj.getParentCxtabId();
		if(this._cxtabId!=-1){
			this.loadCxab();
		}else if(this._parentId!=-1){
			this.loadParentCxab();
		}
	},
	//do not load p and h
	loadParentCxab: function(){
		var evt={};
		evt.command="LoadCxtabJson";
		evt.callbackEvent="LoadCxtabJson";
		evt.cxtabId=this._parentId;
		evt.axisH=false;
		evt.axisP=false;
		this._executeCommandEvent(evt);
	},
	loadCxab: function(){
		var evt={};
		evt.command="LoadCxtabJson";
		evt.callbackEvent="LoadCxtabJson";
		evt.cxtabId=this._cxtabId;
		this._executeCommandEvent(evt);		
	},
	/**
	 * Save all
	 */
	saveCxtab:function(savetype, fileName){
		if(this._measures.length==0){
			msgbox(gMessageHolder.REQUIRE_AT_LEAST_ONE_MEASURE);
			return false;
		}
		if(fileName==undefined)fileName="";
		var evt={};
		var info=null;
		evt.command="SaveCxtabJson";
		evt.callbackEvent="SaveCxtabJson";
		evt.cxtabId=this._cxtabId;
		evt.parentId=this._parentId;
		evt.axisP= this._axisP;
		evt.axisH= this._axisH;
		evt.axisV= this._axisV;
		evt.measures= this._measures;
		evt.savetype=savetype;
		if(savetype=="A"){
			info=prompt(gMessageHolder.TEMPLET_NAME,fileName);
			if(info!=null&&info!=""){ 
				evt.name=info;
				this._executeCommandEvent(evt);
			}
		}else{
			evt.name=$("cxtabName").value;
			this._executeCommandEvent(evt);
		}
	},	
	_saveCxtabDef:function(e){
		var chkResult=e.getUserData(); // data
		if(chkResult.code==2){
			alert(gMessageHolder.TEMPLET_NAME_REPEAT);
			this.saveCxtab("A");
		}else{
			msgbox(chkResult.message);
		}
	},
	_loadCxtabDef: function(e){
		var chkResult=e.getUserData(); // data
		if(chkResult.code!=0){
			msgbox(chkResult.message);
		}else{
			var i;
			var opt;
			this._axisP= chkResult.axisP;
			this._axisH= chkResult.axisH;
			this._axisV= chkResult.axisV;
			this._measures= chkResult.measures;

			var s=$("axis_h").options;
			for(i=s.length-1; i>=0; i--) s.remove(i);
			for(i=0;i<this._axisH.length;i++ ){
				 opt= new Option(this._axisH[i].description, i);
				 s[i] =opt;
			}
			s=$("axis_p").options;
			for(i=s.length-1; i>=0; i--) s.remove(i);
			for(i=0;i<this._axisP.length;i++ ){
				 opt= new Option(this._axisP[i].description, i);
				 s[i] =opt;
			}
			s=$("axis_v").options;
			for(i=s.length-1; i>=0; i--) s.remove(i);
			for(i=0;i<this._axisV.length;i++ ){
				 opt= new Option(this._axisV[i].description, i);
				 s[i] =opt;
			}
			s=$("measure").options;
			for(i=s.length-1; i>=0; i--) s.remove(i);
			for(i=0;i<this._measures.length;i++ ){
				 opt= new Option(this._measures[i].description, i);
				 s[i] =opt;
			}
		}		
	},
	setColumn :function(clink, desc){
		this._selectedColumn.clink= clink;
		this._selectedColumn.description= desc;
	},
	/**
	 * @return null if not found selected column
	 */
	_checkSelectedColumn :function(){
		if(this._selectedColumn.clink==null){
			msgbox(gMessageHolder.SELECT_ONE_COLUMN);
			return false;
		}
		return true;
	},
	/**
	This is called when parent column is selected in list
	*/
	onSelectParentColumn:function(){
		var i;
		var d=null;
		var s=$("parent_columns").options;
		for(i=0; i<s.length; i++){
		    if(s[i].selected){
				this.setColumn( s[i].value,s[i].label);
		    	break;
		    }
		}
	},
	addColumnToMeasure:function(){
		if(this._checkSelectedColumn()==false) return;
		if(this._selectedColumn.clink.indexOf(";")>-1){
			msgbox(gMessageHolder.COLUMN_MUST_BE_FROM_FACT_TABLE);
			return false;
		}
		this._measures[this._measures.length]={
			column: this._selectedColumn.clink, 
			description:this._selectedColumn.description,
			userfact:"",
			valueformat:"#0.00",
			function_:"SUM",
			sgrade:"0"
		};
		var m=$("measure").options;
		m[m.length]=new Option(this._selectedColumn.description, m.length);
	},
	_getSelectedMeasure:function(){
		var i;
		var m=null;
		var s=$("measure").options;
		for(i=0; i<s.length; i++){
		    if(s[i].selected){
		    	m= this._measures[i];
		    	break;
		    }
		}
		if(m==null){
			msgbox(gMessageHolder.SELECT_ONE_MEASURE);
			return null;
		}
		this._selectedMeasureIdx= i;
		return m;
	},
	newMeasure:function(){
		var ele = Alerts.fireMessageBox(
				{
					width: 550,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
		ele.innerHTML= $("dlg_measure").innerHTML.replace(/TMPL/g,"");
		executeLoadedScript(ele);
		$("mea_function").style.visibility="visible";
		$("mea_valueformat").style.visibility="visible";
		$("mea_column").value="";
		$("mea_description").value="";
		$("mea_function").value="SUM";
		$("mea_userfact").value="";
		$("mea_valueformat").value="#0.00";
		$("mea_valuename").value="";
		$("mea_sgrade").value="0";
		this._selectedMeasureIdx=-1;
	},
	editMeasure:function(){
		var m= this._getSelectedMeasure();
		if(m==null) return;
		
		var ele = Alerts.fireMessageBox(
				{
					width: 550,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
		ele.innerHTML= $("dlg_measure").innerHTML.replace(/TMPL/g,"");
		executeLoadedScript(ele);
		$("mea_function").style.visibility="visible";
		$("mea_valueformat").style.visibility="visible";
		this._setValue($("mea_column"), m.column);
		this._setValue($("mea_description"), m.description);
		this._setValue($("mea_function"),m.function_);
		this._setValue($("mea_userfact"),m.userfact);
		this._setValue($("mea_valueformat"),m.valueformat);
		this._setValue($("mea_valuename"),m.valuename);
		this._setValue($("mea_sgrade"),m.sgrade);
	},
	_setValue:function(ele, v){
		if(v==null || v==undefined) v="";
		dwr.util.setValue(ele, v);
	},
	/**
	 * Save measure, may add or update existing measure in cxtab
	 */
	saveMeasure:function(){
		if(isWhitespace($("mea_column").value) && isWhitespace($("mea_userfact").value)){
	        alert(gMessageHolder.COLUMN_AND_USERFACT_CAN_NOT_BE_NULL+"!");
	        return;
		}
		if(checkNotNull($("mea_description"), $("mea_description").title)==false) return;
		if(checkSelected($("mea_function"), $("mea_function").title)==false) return;
		if(checkSelected($("mea_valueformat"), $("mea_valueformat").title)==false) return;
		var m;
		if(this._selectedMeasureIdx==-1){
			m={column:$("mea_column").value,description:$("mea_description").value,function_:$("mea_function").value,
			userfact:$("mea_userfact").value,valueformat:$("mea_valueformat").value, 
			valuename:$("mea_valuename").value,sgrade:$("mea_sgrade").value};
			this._measures[this._measures.length]=m;
		}else{
			m= this._measures[this._selectedMeasureIdx];
			m.column=$("mea_column").value;
			m.description=$("mea_description").value;
			m.function_=$("mea_function").value;
			m.userfact=$("mea_userfact").value;
			m.valueformat=$("mea_valueformat").value;
			m.valuename=$("mea_valuename").value;
			m.sgrade=$("mea_sgrade").value;
		}
		// update ui
		if(this._selectedMeasureIdx==-1){
			this._selectedMeasureIdx= this._measures.length-1;
		}
		$("measure").options[this._selectedMeasureIdx]=new Option(m.description,this._selectedMeasureIdx );
		Alerts.killAlert($("dlg_measure_content"));
	},
	/**
	 * Add selected column to dim
	 */
	addColumnToDim:function(axisId){
		if(this._checkSelectedColumn()==false) return;
		var e= $(axisId);
		e.options[e.options.length]=new Option(this._selectedColumn.description, e.options.length);
		var axis= (axisId=='axis_h'? this._axisH: axisId=='axis_v'?this._axisV:this._axisP);
		axis[axis.length]={
			columnlink: this._selectedColumn.clink, 
			description:this._selectedColumn.description,
			hidehtml:"N"
		};
	},
	_getSelectedDimension:function(axisId){
		var i;
		var d=null;
		var axis= (axisId=='axis_h'? this._axisH: axisId=='axis_v'?this._axisV:this._axisP);
		var s=$(axisId).options;
		for(i=0; i<s.length; i++){
		    if(s[i].selected){
		    	d= axis[i];
		    	break;
		    }
		}
		if(d==null){
			msgbox(gMessageHolder.SELECT_ONE_DIMENSION);
			return null;
		}
		this._selectedAxisIdx= i;
		return d;
	},
	editDim:function(axisId){
		var d= this._getSelectedDimension(axisId);
		if(d==null) return;
		var ele = Alerts.fireMessageBox(
				{
					width: 550,
					modal: true,
					title: gMessageHolder.EDIT_DIMENSION
				});
		ele.innerHTML= $("dlg_dim").innerHTML.replace(/TMPL/g,"");
		executeLoadedScript(ele);
		this._setValue($("dim_columnlink"),d.columnlink);
		this._setValue($("dim_description"),d.description);
		this._setValue($("dim_hidehtml"),d.hidehtml=="Y"?true:false);
		$("dim_axis").value=axisId;
	},
	/**
	 * Save dimension, may add or update existing dim in cxtab
	 */
	saveDim:function(){
		if(checkNotNull($("dim_columnlink"), $("dim_columnlink").title)==false) return;
		if(checkNotNull($("dim_description"), $("dim_description").title)==false) return;
		var d;
		var axisId= $("dim_axis").value;
		var dimEle= $(axisId);
		var axis= (axisId=='axis_h'? this._axisH: axisId=='axis_v'?this._axisV:this._axisP);
		if(this._selectedAxisIdx==-1){
			d={columnlink:$("dim_columnlink").value,description:$("dim_description").value,hidehtml:$("dim_hidehtml").checked?"Y":"N"};
			axis[axis.length]=d;
		}else{
			d= axis[this._selectedAxisIdx];
			d.columnlink=$("dim_columnlink").value;
			d.description=$("dim_description").value;
			d.hidehtml=$("dim_hidehtml").checked?"Y":"N";
		}
		// update ui
		if(this._selectedAxisIdx==-1){
			this._selectedAxisIdx= axis.length;
			dimEle.options[this._selectedAxisIdx]=new Option(d.description,this._selectedAxisIdx );
		}else{
			dimEle.options[this._selectedAxisIdx]=new Option(d.description,this._selectedAxisIdx );
		}		
		Alerts.killAlert($("dlg_dim_content"));
	},
	 /**
	  * @param element the select element, 
	  * @param a array synchronous to element
	  */
	 moveUp: function(elementId) {
	  var element= $(elementId);
	  var a= (elementId=='measure'? this._measures: (elementId=='axis_h'? this._axisH: elementId=='axis_v'?this._axisV:this._axisP));
	  var i;
	  for(i = 0; i < element.options.length; i++) {
	    if(element.options[i].selected == true) {
	      if(i != 0) {
	        var temp = new Option(element.options[i-1].text,element.options[i-1].value);
	        var temp2 = new Option(element.options[i].text,element.options[i].value);
	        var ta= a[i-1];
	        element.options[i-1] = temp2;
	        element.options[i-1].selected = true;
	        element.options[i] = temp;
	        a[i-1]=a[i];
	        a[i]=ta;
	      }
	    }
	  }
	},
	moveDown:function(elementId) {
	  var element= $(elementId);
	  var a= (elementId=='measure'? this._measures: (elementId=='axis_h'? this._axisH: elementId=='axis_v'?this._axisV:this._axisP));
	  var element= $(elementId);
	  var i;
	  for(i = (element.options.length - 1); i >= 0; i--) {
	    if(element.options[i].selected == true) {
	      if(i != (element.options.length - 1)) {
	        var temp = new Option(element.options[i+1].text,element.options[i+1].value);
	        var temp2 = new Option(element.options[i].text,element.options[i].value);
	        var ta= a[i+1];
	        element.options[i+1] = temp2;
	        element.options[i+1].selected = true;
	        element.options[i] = temp;
	        a[i+1]= a[i];
	        a[i]= ta;
	      }
	    }
	  }
	},	
	removeSelection:function(elementId){
	  var element= $(elementId);
	  var a= (elementId=='measure'? this._measures: (elementId=='axis_h'? this._axisH: elementId=='axis_v'?this._axisV:this._axisP));
	  var i;
	  for(i = (element.options.length - 1); i >= 0; i--) {
	    if(element.options[i].selected == true) {
	      element.options[i]=null;
	      a.splice(i, 1);
	    }
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
CxtabDefControl.main = function () {
	cxtabDefControl=new CxtabDefControl();
};

/**
* Init
*/
if (window.addEventListener) {
  window.addEventListener("load", CxtabDefControl.main, false);
}
else if (window.attachEvent) {
  window.attachEvent("onload", CxtabDefControl.main);
}
else {
  window.onload = CxtabDefControl.main;
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