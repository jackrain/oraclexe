var qd;
var QueryDefControl = Class.create();
// define constructor
QueryDefControl.prototype = {
	initialize: function() {
		this._qdf={};
		this._selectedColumn={};
		
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
		application.addEventListener( "QueryListConfig_Load", this._loadQueryListConfig, this);
		application.addEventListener( "QueryListConfig_Save", this._saveQueryListConfig, this);
		application.addEventListener( "QueryListConfig_Delete", this._deleteQueryListConfig, this);
		
		createButton($("d_moveup"));
		createButton($("d_movedown"));
		createButton($("f_moveup"));
		createButton($("f_movedown"));
		createButton($("o_moveup"));
		createButton($("o_movedown"));
		createButton($("o_orderby"));
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
	_getListByTag:function(listTag){
		return (listTag=='d'? this._qdf.selections: listTag=='f'?this._qdf.conditions:this._qdf.orders);
	},
	/**
	@param qdId ad_querylist.id
	*/
	load: function(qdId,tableId){
		var evt={};
		evt.command="QueryListConfig_Load";
		evt.callbackEvent="QueryListConfig_Load";
		evt.qlfId=qdId;
		evt.table=tableId;
		this._executeCommandEvent(evt);		
	},
	setCurrentList:function(listTag){
		this._currentListTag=listTag;
		if(listTag!='o')$("col_o").selectedIndex=-1;
		if(listTag!='d')$("col_d").selectedIndex=-1;
		if(listTag!='f')$("col_f").selectedIndex=-1;
		this.info(gMessageHolder.CURRENT_LIST.replace("0", $("col_"+listTag).title));
	},
	/**
	 * Save all
	 *  @param saveType if "A" will be save as, else just do save 
	 */
	save:function(){
		if(this._qdf.id<1){
			this.openSaveDialog();
			return;
		}
		if(this._qdf.selections.length==0){
			msgbox(gMessageHolder.REQUIRE_AT_LEAST_ONE_SELECTION);
			return false;
		}
		if(this._qdf.conditions.length==0){
			msgbox(gMessageHolder.REQUIRE_AT_LEAST_ONE_CONDITION);
			return false;
		}
		var evt={};
		evt.command="QueryListConfig_Save";
		evt.callbackEvent="QueryListConfig_Save";
		this._qdf["default"]=$("defquery").checked;
		evt.qdf=Object.clone(this._qdf);
		this._executeCommandEvent(evt);
	},
	/**
	Delete current template
	*/
	del:function(){
		if(this._qdf.id<1){
			alert(	gMessageHolder.META_TEMPLATE_NOT_DELETE);
			return;
		}
		if(confirm(gMessageHolder.SURE_TO_DELETE)){
			var evt={};
			evt.command="QueryListConfig_Delete";
			evt.callbackEvent="QueryListConfig_Delete";
			evt.qlfid=this._qdf.id;
			this._executeCommandEvent(evt);	
		}
	},
	setSelected:function(qdId,tableId){
		dwr.util.setValue("seltemplate",String(qdId));
		this.load(qdId, tableId);
	},
	/**
	 when def template changed, will reload here
	*/
	changeSelection:function(){
		this.load( parseInt(dwr.util.getValue("seltemplate")), this._qdf.table);
	},
	/**
	Save new
	*/
	openSaveDialog:function(){
		if(this._qdf.selections.length==0){
			msgbox(gMessageHolder.REQUIRE_AT_LEAST_ONE_SELECTION);
			return false;
		}
		if(this._qdf.conditions.length==0){
			msgbox(gMessageHolder.REQUIRE_AT_LEAST_ONE_CONDITION);
			return false;
		}
		/*
		var ele = Alerts.fireMessageBox(
				{
					width: 550,
					modal: true,
					title: gMessageHolder.SAVE_NEW
				});
		ele.innerHTML= $("dlg_save").innerHTML.replace(/TMPL/g,"");
		executeLoadedScript(ele);
		*/
		options={id:"art_dlg_save_content",lock:true,skin:'chrome',drag:true,esc:true,width: 550,height:'auto',title: gMessageHolder.SAVE_NEW};
		options.content=$("dlg_save").innerHTML.replace(/TMPL/g,"");
		art.dialog(options);
		var ele=$("art_dlg_save_content");
		//executeLoadedScript(ele);
		$("templatename").value=this._qdf.name+"#2";
		$("templatename").focus();
		dwr.util.selectRange($("templatename"), 0,255);
	},
	onNameReturn:function(event){
		if (!event) event = window.event;
  		if (event && event.keyCode && event.keyCode == 13) this.saveNew();
  		else if (event && event.keyCode && event.keyCode == 27) art.dialog.get("art_dlg_save_content").close();//Alerts.killAlert($("art_dlg_save_content"));
	},
	/**
	Save with new name
	*/
	saveNew:function(){
		var info=$("templatename").value;
		if(info.empty() || info=="DEFAULT"){
			alert(gMessageHolder.NAME_MAY_NOT_EMPTY);	
			return;
		}
		//Alerts.killAlert($("dlg_save_content"));		
		art.dialog.get("art_dlg_save_content").close();
		//art.dialog.close();
		var evt={};
		evt.command="QueryListConfig_Save";
		evt.callbackEvent="QueryListConfig_Save";
		this._qdf.name=info;
		evt.qdf=Object.clone(this._qdf);
		evt.qdf.id=-1;
		evt.qdf.name=info;
		this._executeCommandEvent(evt);
	},
	_deleteQueryListConfig:function(e){
		var r=e.getUserData(); 
		this._closeWindowOrShowMessage(r.message,true);
	},
	/**
	 @param e struct:
	 getUserData:
	 	code, message, id (if new), name
	*/	
	_saveQueryListConfig:function(e){
		var chkResult=e.getUserData(); // data
		msgbox(chkResult.message);
		if(chkResult.code==0){
			//refresh selection, set current def as selected
			if(chkResult.id>0){
				var ele=$("seltemplate");
				ele.options[ele.options.length]=new Option(chkResult.name,chkResult.id,false,true);
				this._qdf.id=chkResult.id;
			}
		}
	},
	_loadQueryListConfig: function(e){
		var chkResult=e.getUserData(); // data
		
		this._qdf=chkResult.qdf;
		
		var i;
		var opt;

		var s=$("col_d").options;
		dwr.util.removeAllOptions($("col_d"));
		for(i=0;i<this._qdf.selections.length;i++ ){
			 opt= new Option(this._qdf.selections[i].d, i);
			 s[i] =opt;
		}
		if(s.length>0) $("col_d").selectedIndex=0;
		s=$("col_f").options;
		dwr.util.removeAllOptions($("col_f"));
		for(i=0;i<this._qdf.conditions.length;i++ ){
			 opt= new Option(this._qdf.conditions[i].d, i);
			 s[i] =opt;
		}
		s=$("col_o").options;
		dwr.util.removeAllOptions($("col_o"));
		for(i=0;i<this._qdf.orders.length;i++ ){
			 opt= new Option(this._qdf.orders[i].d+ "("+ (this._qdf.orders[i].t==false?gMessageHolder.DESC:gMessageHolder.ASC)+")", i);
			 s[i] =opt;
		}
		
		$("defquery").checked= this._qdf["default"] ||($("seltemplate").options.length==1);
		this._currentListTag='d';
		this.info(gMessageHolder.WELCOME);
	},
	/**
	show mssage in range time
	*/
	info:function(msg){
		try{clearTimeout(this._timerId);}catch(e){}
		$("info").innerHTML=msg;
		this._timerId= setTimeout("$('info').innerHTML='';",10000);
	},
	setColumn :function(clink, desc){
		this._selectedColumn.c= clink;
		this._selectedColumn.d= desc;
		this.addColumn(this._currentListTag);
	},
	/**
	 * @return null if not found selected column
	 */
	_checkSelectedColumn :function(listTag){
		if(this._selectedColumn.c==null){
			msgbox(gMessageHolder.SELECT_ONE_COLUMN);
			return false;
		}
		//should not exist in listTag
		var a=this._getListByTag(listTag);
		var i;
		for(i=0;i<a.length;i++){
			if(a[i].c==this._selectedColumn.c){
				this.info(gMessageHolder.COLUMN_DUPLICATE.replace("0", $("col_"+listTag).title ));
				var e= $("col_"+ listTag);
				e.options.selectedIndex=i;
				return false;
			}
		}
		return true;
	},
	
	/**
	 * Add selected column to list, under selected item, if none, to the end
	 @param listTag - o for col_o, d for col_d, f for col_f
	 */
	addColumn:function(listTag){
		if(this._checkSelectedColumn(listTag)==false) return;
		var e= $("col_"+ listTag);
		var selectedPos=e.selectedIndex;
		if(selectedPos<0)selectedPos=e.options.length-1;
		var se=e.options[selectedPos+1];
		var eo=document.createElement("option");
		eo.text=this._selectedColumn.d +(listTag=="o"?"("+gMessageHolder.ASC+")":"");
		eo.value=eo.text;
		try{
			e.add(eo,se);	//standards compliant; doesn't work in IE
		}catch(ex){
			e.add(eo, selectedPos+1);// ie only
		}
		e.selectedIndex= selectedPos+1;
		var l= this._getListByTag(listTag);
		l.splice(selectedPos+1,0,{
			c: this._selectedColumn.c, 
			d:this._selectedColumn.d
		});;
		this.info(gMessageHolder.COLUMN_ADDED.replace("0", $("col_"+listTag).title ).replace("1",this._selectedColumn.d ));
	},
	/**
	revert order
	*/
	chkasc:function(){
		var a= this._qdf.orders;
		var e= $("col_o");
		var i;
		for(i = (e.options.length - 1); i >= 0; i--) {
    		if(e.options[i].selected == true) {
      			e.options[i].text=a[i].d+ "("+(a[i].t==false?gMessageHolder.ASC:gMessageHolder.DESC)+")";
      			a[i].t= (a[i].t==false?true:false);
    		}
  		}
	},
	_getSelectedColumn:function(listTag){
		var i;
		var d=null;
		var l= this._getListByTag(listTag);
		var s=$("col_"+ listTag).options;
		for(i=0; i<s.length; i++){
		    if(s[i].selected){
		    	d= l[i];
		    	break;
		    }
		}
		if(d==null){
			msgbox(gMessageHolder.SELECT_ONE_COLUMN);
			return null;
		}
		this._selectedListIdx= i;
		return d;
	},
	editColumn:function(listTag){
		var d= this._getSelectedColumn(listTag);
		if(d==null) return;
		/*
		var ele = Alerts.fireMessageBox(
				{
					width: 550,
					modal: true,
					title: gMessageHolder.EDIT_COLUMN
				});
		ele.innerHTML= $("dlg_clink").innerHTML.replace(/TMPL/g,"");
		executeLoadedScript(ele);
		*/
		options={id:"art_dlg_clink_content",width: 550,height:'auto',lock:true,skin:'chrome',drag:true,esc:true,title: gMessageHolder.EDIT_COLUMN};
		options.content=$("dlg_clink").innerHTML.replace(/TMPL/g,"");
		art.dialog(options);
		$("columnlink").value=d.c;
		$("description").value=d.d;
		$("listtag").value=listTag;
	},
	/**
	 * Save dimension, may add or update existing dim in cxtab
	 */
	saveColumn:function(){
		if(checkNotNull($("columnlink"), $("columnlink").title)==false) return;
		if(checkNotNull($("description"), $("description").title)==false) return;
		var d;
		var listTag= $("listtag").value;
		var list= this._getListByTag(listTag);
		
		d= list[this._selectedListIdx];
		d.c=$("columnlink").value;
		d.d=$("description").value;
		
		// update ui
		var s;
		if(listTag=="o")
			s=new Option(d.d + "("+(d.t==false?gMessageHolder.ASC:gMessageHolder.DESC)+")" ,this._selectedListIdx );
		else
			s=new Option(d.d ,this._selectedListIdx );
			
		$("col_"+listTag).options[this._selectedListIdx]=s
					
		//Alerts.killAlert($("dlg_clink_content"));
		art.dialog.get("art_dlg_clink_content").close();
		
	},
	 /**
	  * @param element the select element, 
	  * @param a array synchronous to element
	  */
	 moveUp: function(listTag) {
	  var element= $("col_"+listTag);
	  var a= this._getListByTag(listTag);
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
	moveDown:function(listTag) {
	  var element= $("col_"+listTag);
	  var a= this._getListByTag(listTag);
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
	
	removeColumn:function(listTag){
	  var element= $("col_"+listTag);
	  var a= this._getListByTag(listTag);
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
	},
	tryClose:function(){
		this._closeWindowOrShowMessage(null,false);
	},
	art_close:function(p_id){
	art.dialog.get(p_id).close();
	},
	 _closeWindowOrShowMessage:function(msg, bReload){
		var isclosed=false;
    	var w = window.opener;
    	if(w==undefined)w= window.parent;
    	if (w ){
			var iframe=w.document.getElementById("popup-iframe-1");
			if(iframe){
	    		//w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'))",1);
				//reload window
				//var pid=jQuery("#popup-iframe-1",parent.document.body).parents(".aui_chrome").attr("id");
				//window.setTimeout("parent.art.dialog.get('"+pid+"').close()",1);
				w.document.getElementById("popup-iframe-0").contentDocument.location.reload(true);
				art.dialog.close();
				if(bReload)
				  //w.location.reload();
	    		isclosed=true;
    		}
    	}
    	if(!isclosed && msg!=null){
				alert(msg);
    	}
    }	
};
// define static main method
QueryDefControl.main = function () {
	qd=new QueryDefControl();
};

jQuery(document).ready(QueryDefControl.main); 

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

