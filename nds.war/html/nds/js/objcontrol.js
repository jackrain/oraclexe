var inlineObject=null;// this is for inline object
var oc;
var ObjectControl = Class.create();
// define constructor
ObjectControl.prototype = {
	initialize: function() {
		this._isButtonDisabled=false;
		this._masterObj=masterObject;
		dwr.engine.setErrorHandler(function(message, ex) {
			$("timeoutBox").style.visibility = 'hidden';
			if (message == null || message == "") {
				while(ex!=null && ex.cause!=null) ex=ex.cause;
				if(ex!=null)message=ex.javaClassName;
				msgbox(gMessageHolder.INTERNAL_ERROR+":"+ message);
			}
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else msgbox(message);
	  		oc._showMessage("<font color='#FF0000'>"+message+"</font>", ex);
			oc._toggleButtons(false);
		});		
		application.addEventListener( "SaveObject", this._onSaveObject, this);
		application.addEventListener( "SaveObjectNew", this._onSaveObjectNew, this);
		application.addEventListener( "DeleteObject", this._onDeleteObject, this);
		application.addEventListener( "SubmitObject", this._onSubmitObject, this);
		application.addEventListener( "VoidObject", this._onVoidObject, this);
		application.addEventListener( "UnvoidObject", this._onUnvoidObject, this);
		application.addEventListener( "UnsubmitObject", this._onSubmitObject, this);// share the same handling method _onSubmitObject
		application.addEventListener( "ExecuteAudit", this._onExecuteAudit, this);
		application.addEventListener( "PrintJasper", this._onPrintJasper, this);
		application.addEventListener( "ExportJasper", this._onExportJasper, this);
		application.addEventListener( "ExecuteWebAction", this._onExecuteWebAction, this);
		application.addEventListener( "BSWebAction", this._onExecuteWebAction, this);
		this.MAX_INPUT_LENGTH=1000;// this is used for selection range
		this._tryAddCloseButton();
		this._tryUpdateTitle();
		this._url= window.location.href;
		this._closeWindow=false;// if true, will close window immdiately
		ObjDropMenu.init();
	},
	/**
	hide or show or fix some columns when on column value changed
	@param idx index in _masterObj.table.props.display_condition
	*/
	
	hideOrShowOrFixColumns:function(idx){
		var i,col,hc,j;
		var dc= this._masterObj.table.props.display_condition;
		var columns=this._masterObj.columns;
		for(i=0;i<columns.length;i++){
			col= columns[i];
			//hide
			if(col.props!=null && col.props.hide_condition!=null)hc= col.props.hide_condition;
			else hc=-1;
			var b=false;	
			if(hc==idx){
				if(dc[hc]==true){
					//hide
					b=true;
				}else{
					if(dc[hc].c!=null&&dc[hc].v!=null){
						//find column value
						var v=dwr.util.getValue($("column_" + dc[hc].c));
						var a=dc[hc].v.split(",");
						for(j=0;j<a.length;j++){
							if( a[j].charAt(0)=="!"){
							   b=(a[j].substr(1)!=v || ( v.strip().length>0 && a[j]=="!null" ));
							}else{
							   b=(a[j]==v || (v.strip().length==0 && a[j]=="null"));
							}
							if(b) break;
						}
					}
				}
				this._showColumn(col,!b);
			}
			//fix
			if(col.props!=null && col.props.fix_condition!=null)hc= col.props.fix_condition;
			else hc=-1;
			var b=false;	
			if(hc==idx){
				if(dc[hc]==true){
					//fix
					b=true;
				}else{
					if(dc[hc].c!=null&&dc[hc].v!=null){
						//find column value
						var v=dwr.util.getValue($("column_" + dc[hc].c));
						var a=dc[hc].v.split(",");
						for(j=0;j<a.length;j++){
							if( a[j].charAt(0)=="!"){
							   b=(a[j].substr(1)!=v || ( v.strip().length>0 && a[j]=="!null" ));
							}else{
							   b=(a[j]==v || (v.strip().length==0 && a[j]=="null"));
							}
							if(b) break;
						}
					}
				}
				this._fixColumn(col,b);
			}
		}		
	},
	/**
	hide some columns accroding to column hide_condition property
	*/
	initColumns:function(newMasterObj){
		if(newMasterObj!=undefined && newMasterObj!=null) this._masterObj=newMasterObj;
		var dc=null;//array
		var i,col,hc,j;
		if(this._masterObj.table.props!=null)dc= this._masterObj.table.props.display_condition;
		if(dc!=null && dc.length>0){
			//supervise on dc column/value list
			for(i=0;i<dc.length;i++){
				if(dc[i].c!=null && dc[i].v!=null){
					jQuery("#column_" + dc[i].c).change(function(){
						var d=this.id.substr(7);//remove "column_"		
						var k;
						for(k=0;k<oc._masterObj.table.props.display_condition.length;k++){
							if(	oc._masterObj.table.props.display_condition[k].c==d){
								oc.hideOrShowOrFixColumns(k);
							}
						}
						
					});
				}
			}	
		}
		if(dc!=null && dc.length>0){
			for(i=0;i<dc.length;i++){
				this.hideOrShowOrFixColumns(i);
			}
			
		}
		
	},
	/**
	 @param col column in this._masterObj.columns
	 @param show true for display, false for hide
	*/
	_showColumn:function(col, show){
		$("tdd_"+col.id).style.visibility=(show?"visible":"hidden");
		$("tdv_"+col.id).style.visibility=(show?"visible":"hidden");
	},
	/**
	 @param col column in this._masterObj.columns
	 @param fix true for fix, false for editable
	*/
	_fixColumn:function(col, fix){
		jQuery("#tdv_"+col.id+ " :input").readonly(fix);
		jQuery("#tdv_"+col.id+ " > .coolButton").css("visibility", (fix?"hidden":"visible"));
	},
	webaction:function(actionId, warn,target){
		//this.saveAll();
		if( (warn!=null && confirm(warn)) || warn==null){
			var evt={};
			evt.webaction= actionId;
			//evt.objectid=this.getObjectId();
			evt.objectid= this._masterObj.hiddenInputs.id;
			if(warn!=undefined && target!=null)evt.target=target;
			evt.command="ExecuteWebAction";
			evt.query=this.getQuery();
			evt.callbackEvent="ExecuteWebAction";
			this._executeCommandEvent(evt); 	
		}
	},
	bswebaction:function(actionId,bShouldWarn){
    	if(bShouldWarn){
    		if (!confirm(gMessageHolder.DO_YOU_CONFIRM_SUBMIT)) {
            	return;
        	}
    	}
    	var evt=$H();
			evt.command="ProcessObject";
			evt["nds.control.ejb.UserTransaction"]="N";//each line will have a seperate transaction
			//evt.submitAfterSave="Y"; // then submit
			evt.actionAfterSave=actionId; // then act
			if(gc!=undefined)gc.fillProcessEvent(evt); // grid control
			// hash type
			evt.masterobj=$H(Form.serializeElements( this._getInputs("obj_inputs_1"),true));
			// special treatment on clob type column
			evt.masterobj.merge(this._loadClobs());

			var addtionalInputs=$("obj_inputs_2");
			if(addtionalInputs!=null){
				evt.masterobj.merge(Form.serializeElements( this._getInputs(addtionalInputs),true));
			}
			evt.masterobj.merge(this._masterObj.hiddenInputs);
			evt.callbackEvent="BSWebAction";
			if(oc._toggleButtons(true) ==false) return;
			this._executeCommandEvent(evt);
    },
	/**
	Get current selection from ui, structure: data/selection(1,2,3), data/query(sql),data/id(for obj table),data/table(table id)
	*/
	getQuery:function(){
		var q={};
		if(gc!=null){ 
			q.selection=gc.getSelectedRows();
		}else
			q.selection=[];
		q.query=null;
		q.table=this._masterObj.table.id;
		q.id=this._masterObj.hiddenInputs.id;
		return q;
	},
	/**
		@param r - SPResult, contains 'code' and 'message'
				@param gcErrorFound - if true, something error in grid, will not refresh screen or grid
		@return true, no need to continue following script(window should be closed or refreshed)
	*/
	_handleSPResult:function(r){
		oc._toggleButtons(false);
		var b=false;
		if(r.message && r.code!=4 && r.code!=5){
			msgbox(r.message.replace(/<br>/g,"\n"));
		}
		switch(r.code){
			case 1://refresh list
				//window.location.reload(true);	
				this.doRefresh();
				b=true;
				break;
			case 2://refresh page
				b=true;
				try{
					this.closeDialog("popup-iframe-0");	
					return true;
				}catch(e){}
				window.close();	
				break;
			case 3:
				try{
					if(gc!=null && !gc.isDestroied()){
						gc.refreshGrid(true);
					}else  jQuery("#tabs > ul").tabs();//refresh current tab, only work for jquery ui tabs 3
					return true;
				}catch(e){}
				try{
					this.doRefresh();	
					return true;
				}catch(e){}	
				window.location.reload(true);	
				return true;
			case 4://using message as url, and load target from user data
				var tgt=r.target;
				if(tgt==undefined || tgt==null) tgt="_blank";
				if( tgt.startsWith("_")){
					popup_window(r.message, tgt);
				}else{
					this.navigate(r.message, tgt);	
				}
				break;
			case 5:// message as javascript
				eval(r.message);
				break;
			case 98: // refresh grid and object
				try{
					gc.refreshGrid();
				}catch(e){}
				break;
			case 99://close current page
				window.close();
				b=true;
				break;
			case 101://submit dont close
					this.doRefresh();
					b=true;
					break;		
		}
		return b;
	},
	_onExecuteWebAction:function(e){
		var r=e.getUserData().data; 
		this._handleSPResult(r);
	},		
	/**
	 * Get column by id in master object, return null if not found
	 * column properties:
	 * 	@see nds.schema.Column.toJSONObject(locale)
	 */
	getColumnById:function(id){
		var i;
		for(i=0;i<this._masterObj.columns.length;i++){
			if( this._masterObj.columns[i].id==id) return this._masterObj.columns[i];
		}
		return null;
	},
	timeoutRefresh:function(){
		$("timeoutBox").style.visibility = 'hidden';
		dwr.engine.abortAll();
	    oc._toggleButtons(false);
		this.doRefresh();
	},
	timeoutWait:function(){
		$("timeoutBox").style.visibility = 'hidden';
	},	
	doNewObject:function(){
		var url="/html/nds/object/object.jsp?input=true&table=" +
			this._masterObj.table.id+ "&id=-1";
		window.location=url;
    },
    doShowObject:function(tableId, objectId){
		var url="/html/nds/object/object.jsp?input=true&table=" +tableId+ "&id=" + this._masterObj.hiddenInputs.id;
		window.location=url;
    },
    doSelectView:function(viewIdString){
    	var url= "/html/nds/objext/selectview.jsp?table=" +viewIdString + "&id=" + this._masterObj.hiddenInputs.id;
    	window.location=url;
    },
    doCopyTo:function(){
    	var url="/html/nds/objext/copyto.jsp?src_table="+ this._masterObj.hiddenInputs.table+
		"&dest_table=-1&fixedcolumns="+ this._masterObj.hiddenInputs.fixedcolumns+
		"&objectids="+this._masterObj.hiddenInputs.id;
		window.location=url;
    },
    doPrintSetting:function(){
		var url="/html/nds/print/options.jsp?table=" + 
			this._masterObj.hiddenInputs.table + "&id=" + this._masterObj.hiddenInputs.id;
	    window.location=url;
    },
/**
	@param e either string for file or object from server containing printfile attribute
	*/
	_onExportJasper:function(e){
		oc._toggleButtons(false);
		var pf;
		if(typeof(e)=="string") pf=e;
		else
			pf=e.getUserData().data.printfile;
		var f="/servlets/binserv/Download?filename="+encodeURIComponent(pf);
		var ifm=window.print_obj_iframe;
		window.location.href=f;
	},      
	/**
	@param e either string for file or object from server containing printfile attribute
	*/
	_onPrintJasper:function(e){
		oc._toggleButtons(false);
		var pf;
		if(typeof(e)=="string") pf=e;
		else
			pf=e.getUserData().data.printfile;
		var f="/servlets/binserv/GetFile?filename="+encodeURIComponent(pf)+"&del=Y";
		var ifm=window.print_obj_iframe;
		var disabledZone=$('disabledZone');
		if(disabledZone)disabledZone.style.visibility = 'visible';
		if(Prototype.Browser.IE){
			/*$("print_iframe").onreadystatechange=function () {
    	   		if(this.readyState=="complete"){
					if(disabledZone)disabledZone.style.visibility = 'hidden';
        	   		ifm.focus();
        	   		ifm.print();
    	   			if(oc._closeWindow) {
    	   				alert(gMessageHolder.CLOSE_AFTER_PRINT);
    	   				oc._closeWindowOrShowMessage(null);
    	   			}
    	   		}
     		};*/
			if(disabledZone)disabledZone.style.visibility = 'hidden';
			if(oc._closeWindow) {
				window.location.href=f;
			}else{
				popup_window(f);	
			}
		}else{
			$("print_obj_iframe").onload=function () {
				//firefox will call onload before pdf is loaded completely, so we wait here
 				setTimeout('oc.waitOneMomentToPrint()', 1000);
     		};	
			ifm.location.href= f;
		}

	},
	/*
	    //µÈ´ý´òÓ¡
    waitOneMomentToPrint:function(){

        // detect if browser is Chrome
        //chrome print ºöÂÔ
       // Good! Bug fixed. The bug was fixed as part of v.23 if I'm not wrong
				if(navigator.userAgent.toLowerCase().indexOf("chrome") >  -1) {
				    // wrap private vars in a closure
				    (function() {
				        var realPrintFunc = window.print;
				        var interval = 2500; // 2.5 secs
				        var nextAvailableTime = +new Date(); // when we can safely print again

				        // overwrite window.print function
				        window.print = function() {
				            var now = +new Date();
				            // if the next available time is in the past, print now
				            if(now > nextAvailableTime) {
				                realPrintFunc();
				                nextAvailableTime = now + interval;
				            } else {
				                // print when next available
				                setTimeout(realPrintFunc, nextAvailableTime - now);
				                nextAvailableTime += interval;
				            }
				        }
				    })();
				}
				window.print_obj_iframe.focus();
        window.print_obj_iframe.print()
    },
*/
	waitOneMomentToPrint:function(){
		if($('disabledZone'))$('disabledZone').style.visibility = 'hidden';
   		window.print_obj_iframe.focus();
   		window.print_obj_iframe.print();
   		//console.log("waitOneMomentToPrint:"+ oc._closeWindow);
   		if(oc._closeWindow) {
   			alert(gMessageHolder.CLOSE_AFTER_PRINT);
   			oc._closeWindowOrShowMessage(null);
   		}
	},

    doPrint:function(){
    	var evt={};
		evt.tag="Print";
		evt.command="PrintJasper";
		evt.callbackEvent="PrintJasper";
		evt.params={"table":this._masterObj.hiddenInputs.table,"id":this._masterObj.hiddenInputs.id};	
		this._executeCommandEvent(evt);

    },
    
    doPrintFile:function(){
    	var evt={};
		evt.tag="Print";
		evt.command="PrintJasper";
		evt.callbackEvent="ExportJasper";
		evt.params={"table":this._masterObj.hiddenInputs.table,"id":this._masterObj.hiddenInputs.id};	
		this._executeCommandEvent(evt);

    },
    doGoAuditPage:function(){
    	window.location="/html/nds/object/audit.jsp?table="+this._masterObj.hiddenInputs.table+"&id="+this._masterObj.hiddenInputs.id;
    },
	doGoModifyPage:function(tableId, objectId, url){
		window.location=url;
	},
	doCreate:function(){
		this.saveAll();
    },
    doTemplate:function(){
    	window.location="/html/nds/objext/template.jsp?table="+ this._masterObj.hiddenInputs.table;
	},
	doRefresh:function(){
		window.location=this._url;
		//window.location.reload();
	},
	doModify:function(){
		this.saveAll();
    },
    doUnsubmit:function(bShouldWarn){
    	if(bShouldWarn){
    		if (!confirm(gMessageHolder.DO_YOU_CONFIRM_UNSUBMIT)) {
            	return;
        	}
    	}
    	var evt=$H();
		evt.command=this._masterObj.table.name+"Unsubmit";
		evt.parsejson="Y";
		evt.callbackEvent="UnsubmitObject";
		evt.merge(this._masterObj.hiddenInputs);
		if(oc._toggleButtons(true) ==false) return;
		this._executeCommandEvent(evt);
    },
    doSubmitPrint:function(bSaveFirst,bShouldWarn){
    	if(bShouldWarn){
    		if (!confirm(gMessageHolder.DO_YOU_CONFIRM_SUBMIT)) {
            	return;
        	}
    	}
    	var evt=$H();
		evt.printAfterSubmit="Y"; // submit then print
		if(bSaveFirst){
			if(this._checkObjectInputs()==false){
		       	return;
	    	}
			evt.command="ProcessObject";
			evt["nds.control.ejb.UserTransaction"]="N";//each line will have a seperate transaction
			evt.submitAfterSave="Y"; // then submit
			//evt.actionAfterSave="38"; // then act
			if(gc!=undefined){
			if(gc.checkInputs()==false){
				this._toggleButtons(false);		
	       		return;
			}
			   gc.fillProcessEvent(evt); // grid control
			}
			//if(gc!=undefined)gc.fillProcessEvent(evt); // grid control
			// hash type
			evt.masterobj=$H(Form.serializeElements( this._getInputs("obj_inputs_1"),true));
			// special treatment on clob type column
			evt.masterobj.merge(this._loadClobs());

			var addtionalInputs=$("obj_inputs_2");
			if(addtionalInputs!=null){
				evt.masterobj.merge(Form.serializeElements( this._getInputs(addtionalInputs),true));
			}
			evt.masterobj.merge(this._masterObj.hiddenInputs);
			evt.callbackEvent="SubmitObject";
			if(oc._toggleButtons(true) ==false) return;
			this._executeCommandEvent(evt);
		}else{
			evt.command=this._masterObj.table.name+"Submit";
			evt.parsejson="Y";
			evt.callbackEvent="SubmitObject";
			evt.merge(this._masterObj.hiddenInputs);
			if(oc._toggleButtons(true) ==false) return;
			this._executeCommandEvent(evt);
		}
    },
    doSubmit:function(bSaveFirst,bShouldWarn){
    	if(bShouldWarn){
    		if (!confirm(gMessageHolder.DO_YOU_CONFIRM_SUBMIT)) {
            	return;
        	}
    	}
    	var evt=$H();
    	
		if(bSaveFirst){
			if(this._checkObjectInputs()==false){
		       	return;
	    	}
			evt.command="ProcessObject";
			evt["nds.control.ejb.UserTransaction"]="N";//each line will have a seperate transaction
			evt.submitAfterSave="Y"; // then submit
			//evt.actionAfterSave="38"; // then act
			if(gc!=undefined){
			if(gc.checkInputs()==false){
				this._toggleButtons(false);		
	       		return;
			}
			   gc.fillProcessEvent(evt); // grid control
			}
			//if(gc!=undefined)gc.fillProcessEvent(evt); // grid control
			// hash type
			evt.masterobj=$H(Form.serializeElements( this._getInputs("obj_inputs_1"),true));
			// special treatment on clob type column
			evt.masterobj.merge(this._loadClobs());

			var addtionalInputs=$("obj_inputs_2");
			if(addtionalInputs!=null){
				evt.masterobj.merge(Form.serializeElements( this._getInputs(addtionalInputs),true));
			}
			evt.masterobj.merge(this._masterObj.hiddenInputs);
			evt.callbackEvent="SubmitObject";
			if(oc._toggleButtons(true) ==false) return;
			this._executeCommandEvent(evt);
		}else{
			if(oc._toggleButtons(true) ==false) return;
			this.submitWithConfirmation(false);
			/*
			evt.command=this._masterObj.table.name+"Submit";
			evt.parsejson="Y";
			evt.callbackEvent="SubmitObject";
			evt.merge(this._masterObj.hiddenInputs);
			if(oc._toggleButtons(true) ==false) return;
			this._executeCommandEvent(evt);
			*/
		}
    },
    
    submitWithConfirmation:function(b){
    	var evt=$H();
    	evt.command=this._masterObj.table.name+"Submit";
		evt.parsejson="Y";
		evt.callbackEvent="SubmitObject";
		evt.merge(this._masterObj.hiddenInputs);
		if(b)evt["check_submit.msg"]="ok";
		this._executeCommandEvent(evt);
    },
	
	doDelete:function(){
    	if (!confirm(gMessageHolder.DO_YOU_CONFIRM_DELETE.replace("0","["+ this._masterObj.table.description+"]" ))) {
            return;
        }
		var evt=$H();
		evt.command=this._masterObj.table.name+"Delete";
		evt.parsejson="Y";
		evt.callbackEvent="DeleteObject";
		evt.merge(this._masterObj.hiddenInputs);
		if(oc._toggleButtons(true) ==false) return;
		this._executeCommandEvent(evt);
    },
    doVoid:function(){
    	if (!confirm(gMessageHolder.DO_YOU_CONFIRM_VOID )) {
            return;
        }
		var evt=$H();
		evt.command=this._masterObj.table.name+"Void";
		evt.parsejson="Y";
		evt.callbackEvent="VoidObject";
		evt.merge(this._masterObj.hiddenInputs);
		if(oc._toggleButtons(true) ==false) return;
		this._executeCommandEvent(evt);
    },
    doUnvoid:function(){
    	if (!confirm(gMessageHolder.DO_YOU_CONFIRM_UNVOID )) {
            return;
        }
		var evt=$H();
		evt.command=this._masterObj.table.name+"Unvoid";
		evt.parsejson="Y";
		evt.callbackEvent="UnvoidObject";
		evt.merge(this._masterObj.hiddenInputs);
		if(oc._toggleButtons(true) ==false) return;
		this._executeCommandEvent(evt);
    },
    
    _onUnSubmitObject:function(e){
		var r=e.getUserData(); 
		if(r.code!=0){
			this._showMessage(r.message,true);
		}else{
			if(r.data!=null && r.data.printfile!=null){
				msgbox(r.message);
				this._closeWindow=true;
				this._onPrintJasper(r.data.printfile);
			}else
				this._closeWindowOrShowMessage(r.message);
		}
    },
     
    _onSubmitObject:function(e){
    	//console.log(e);
		var r=e.getUserData(); 
		if(r.code!=0){
			this._showMessage(r.message,true);
		}else{
			if(r.data!=null && r.data.printfile!=null){
				msgbox(r.message);
				this._closeWindow=true;
				this._onPrintJasper(r.data.printfile);
			}else{
				//for check_submit, r.message is json object
				if( r.data!=null &&  r.data.check_submit!=null){
					var chksubmit=r.data.check_submit.evalJSON();
					switch(chksubmit.code){
						case 1:
							msgbox(chksubmit.message);
							this._toggleButtons(false);
							break;
						case 2:
							if(confirm(chksubmit.message)){
								setTimeout("oc.submitWithConfirmation(true)",100);
								return;								
							}else
								this._toggleButtons(false);
							break;
						case 3:
							this._toggleButtons(false);
							eval(chksubmit.message);
							break;
					}
				}
				if(r.data!=null && r.data.sbresult!=null){
				this._handleSPResult(r.data.sbresult);
				}else{
				 this._closeWindowOrShowMessage(r.message);
				}
			}
		}
    },
    _onDeleteObject:function(e){
		var r=e.getUserData(); 
		if(r.code!=0){
			this._showMessage(r.message,true);
		}else{
			this._closeWindowOrShowMessage(r.message);
		}
    },
    _onVoidObject:function(e){
		var r=e.getUserData(); 
		if(r.code!=0){
			this._showMessage(r.message,true);
		}else{
			this._closeWindowOrShowMessage(r.message);
		}
    },
    _onUnvoidObject:function(e){
		var r=e.getUserData(); 
		if(r.code!=0){
			this._showMessage(r.message,true);
		}else{
			//refresh
			window.location=this._url;
		}
    },
    _closeWindowOrShowMessage:function(msg){
		var isclosed=false;
    	var w = window.opener;
    	if(w==undefined)w= window.parent;
    	if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
	    		//w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'))",1);
				if(msg!=null)msgbox(msg);
	    		isclosed=true;
    		}
    		art.dialog.close();
    	}
    	if(!isclosed){
			var body = document.getElementsByTagName("body")[0];
			if(msg==null)msg="";
			body.innerHTML="<div class='returnmsg'>"+msg+"</div>";
			window.close();
    	}
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
	/**
	* Save objects,  create update command and execute
	* only checked lines will be saved
	* @param bIsNew if is new, will callback SaveObjectNew, else SaveObject
	*/
	saveAll : function () {
		this._toggleButtons(true);		
		if(this._checkObjectInputs()==false){
			this._toggleButtons(false);		

	       	return;
    	}
		var inlineObjInputs=$("inline-obj-inputs");
		if(inlineObjInputs!=null){
			if(this._checkInlineObjectInputs()==false){
				this._toggleButtons(false);		
	       		return;
    		}
		}
		var evt={};
		evt.command="ProcessObject";
		evt["nds.control.ejb.UserTransaction"]="N";//each line will have a seperate transaction
		if(gc!=undefined && !gc.isDestroied() ){
			if(gc.checkInputs()==false){
				this._toggleButtons(false);		
	       		return;
			}
			gc.fillProcessEvent(evt); // grid control
		}
		// hash type
		evt.masterobj=$H(Form.serializeElements( this._getInputs("obj_inputs_1"),true));
		// special treatment on clob type column
		evt.masterobj.merge(this._loadClobs());
		
		var addtionalInputs=$("obj_inputs_2");
		if(addtionalInputs!=null){
			evt.masterobj.merge(Form.serializeElements( this._getInputs(addtionalInputs),true));
		}
		evt.masterobj.merge(this._masterObj.hiddenInputs);
		if(inlineObjInputs!=null){
			evt.inlineobj=$H(Form.serializeElements( this._getInputs("inline-obj-inputs"),true));
			evt.inlineobj.merge(inlineObject.hiddenInputs);
		}
		evt.callbackEvent="SaveObject"+(evt.masterobj.id==-1?"New":"");
		//alert(evt);
		this._executeCommandEvent(evt);
	},
	/**
	 * Load clob objects, and will remove hidden object's input value
	 * @return Hash object
	 */
	_loadClobs:function(){
		var clobs={};
		
		var cols= this._masterObj.columns;
		for(var i=0;i<cols.length;i++){
			var col= cols[i];
			if(col.displaySetting=="clob"){
				//Ìæ»»Îªckeditor
				//var oEditor = FCKeditorAPI.GetInstance("column_"+ col.id) ;
				var oEditor=CKEDITOR.instances["column_"+ col.id];
				if(oEditor!=null){
					//clobs[col.name.toLowerCase()] = oEditor.GetHTML();
					clobs[col.name.toLowerCase()]=oEditor.getData();
					clobs["column_"+ col.id]="";
					oEditor.destroy();	
				}
			}
		}
			
		return clobs;
	},
	/**
	@return false if has already toggled to false
	*/
	_toggleButtons:function(disable){
		if(disable && this._isButtonDisabled){
			alert(gMessageHolder.DO_NOT_PRESS_TWICE);
			return false;	
		}
		this._isButtonDisabled=disable;
		var es=$("buttons").getElementsBySelector("input[type='button']");
		if(disable){
			for(var i=0;i< es.length;i++){
				es[i].disable();
			}
		}else{
			for(var i=0;i< es.length;i++){
				es[i].enable();
			}
		}
	},	
	/**
	* Request server handle command event
	* @param evt CommandEvent
	*/
	_executeCommandEvent :function (evt) {
		//showProgressWindow(true);
		Controller.handle( Object.toJSON(evt), function(r){
				//try{
					$("timeoutBox").style.visibility = 'hidden';
					
					var result= r.evalJSON();
					if (result.code !=0 ){
						msgbox(result.message);
						oc._toggleButtons(false);
					}else {
						var evt=new BiEvent(result.callbackEvent);
						evt.setUserData(result);
						application.dispatchEvent(evt);
					}
				/*}catch(ex){
					msgbox(ex.message);
				}*/
			
		});
	},
	_checkInlineObjectInputs: function(){
		var cols=inlineObject.columns,i,col, d;
		var maskPos= inlineObject.hiddenInputs.id==-1?1:3;
		var blank,ele,d;
		for(i=0;i< cols.length;i++){
			col= cols[i];
			if(col.mask.substr(maskPos,1)==1){
				ele=$("column_"+ col.id);
				if(ele==null )continue;
				//if(!ele.disabled && this._checkInput(col,ele)==false) return false;
				if(col.displaySetting=="clob"){
					if(!col.isNullable){
						//var oEditor =FCKeditorAPI.GetInstance("column_"+ col.id) ;
						var oEditor=CKEDITOR.instances["column_"+ col.id];
						if(oEditor!=null && oEditor.getData()==null){
							msgbox( col.description+ gMessageHolder.CAN_NOT_BE_NULL);
							return false;
						}
					}
				}else{
					if(!ele.disabled && this._checkInput(col,ele)==false) return false;
				}
			}				
			}
		return true;	
	},
	/**
	 * @return false if object panel contains invalid data
	 */
	_checkObjectInputs: function(){
		var cols=this._masterObj.columns,i,col, d;
		var maskPos= this._masterObj.hiddenInputs.id==-1?1:3;
		var blank,ele,d;
		for(i=0;i< cols.length;i++){
			col= cols[i];
			if(col.mask.substr(maskPos,1)==1){
				ele=$("column_"+ col.id);
				if(ele==null )continue;
				if(!ele.disabled && this._checkInput(col,ele)==false) return false;
			}
		}
		return true;	
	},
	/**
	 * @param col GridColumn
	 * @param ele Element for input
	 * @return false if contains invalid data
	 */
	_checkInput: function(col,ele){
		var d=String(dwr.util.getValue( ele));
		var blank=(String(d)).blank();
		if(!col.isNullable &&  (blank || (col.isValueLimited && d=="0") )){
			msgbox( col.description+ gMessageHolder.CAN_NOT_BE_NULL);
			dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
			return false;
		}
		if(!col.isValueLimited && !blank ){
			if(col.refColumnId!=-1) col= col.refTableAK;
			if(col.type==Column.NUMBER && isNaN(d,10)){
				msgbox( col.description+ gMessageHolder.MUST_BE_NUMBER_TYPE);
				dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
				return false;
			}else if((col.type==Column.DATE || col.type==Column.DATENUMBER) && !isValidDate(d) ){
				msgbox( col.description+ gMessageHolder.MUST_BE_DATE_TYPE);
				dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
				return false;
			}
		}
		return true;
	},
	_showMessage:function(msg, bError){
		if(msg==null ||(String(msg)).blank() ){
			$("message").style.visibility="hidden";
		}else{
			if(bError){
				msg="<div class='err-msg'>"+msg+"</div>";
			}else{
				msg="<div class='info-msg'>"+msg+"</div>";
			}
			$("message_txt").innerHTML=msg+"<div class='ptime'>"+this._currentTime()+"</div>";
			$("message").style.visibility="visible";
		}
	},
	/**
	 * @return string contains date infomration
	 */
	_currentTime:function(){
		var d=new Date();
		return d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
	},
	/**
	 * try close window
	 */
	_checkShouldClose:function(e){
		var r=e.getUserData().data; 
		if(r.closewindow){
			this._closeWindowOrShowMessage(r.message);
			return true;
		}else{
			return false;
		}
	},
	/**
	 * Current object id
	 */
	getObjectId:function(){
		return this._masterObj.hiddenInputs.id;
	},
	_onSaveObjectNew:function(e){
		if(this._checkShouldClose(e)) return;
		var n=e.getUserData().data.nextscreen;
		if(!n){
			// grid found error
			// reconstruct fixedcolumns and refresh url
			this._masterObj.hiddenInputs.fixedcolumns=e.getUserData().data.fixecolumnstr;
			//alert(this._masterObj.hiddenInputs.fixedcolumns);
			if(gc!=undefined  && !gc.isDestroied()){
				gc.updateFixedColumns( e.getUserData().data.fixecolumnstr,
					e.getUserData().data.fixecolumns.toJSON());
			}
			this._url= e.getUserData().data.url;
			this._onSaveObject(e);
		}else{
			window.location=e.getUserData().data.nextscreen;
		}
	},
	/**
	 * Contains both master object information and detail object information
	 * @param r data set by nds.control.ejb.command.ProcessObject
	 */
	_onSaveObject : function (e) {
		if(this._checkShouldClose(e)) return;
		// spresult of main object
		var spr=e.getUserData().data.spresult;
		if(spr){
			if(this._handleSPResult(spr)){
				return;
			} 
		}
		// detal objects
		if(gc!=undefined  && !gc.isDestroied())gc.updateGrid(e);
		// master object
		var r=e.getUserData().data; 
		this._masterObj.hiddenInputs.id=r.masterid;
		//try{
		var te=r.masterpage;
		var p= te.indexOf("<!--BUTTONS_BEGIN-->");
		var pe= te.indexOf("<!--BUTTONS_END-->");
		if(p>0 && pe>p){
			$("buttons").innerHTML=te.substring(p+ "<!--BUTTONS_BEGIN-->".length,pe);
		}	
		p= te.indexOf("<!--OBJMENU_BEGIN-->");
		pe= te.indexOf("<!--OBJMENU_END-->");
		if(p>0 && pe>p){
			$("objmenu").innerHTML=te.substring(p+ "<!--OBJMENU_BEGIN-->".length,pe);
			ObjDropMenu.init();
		}
		p= te.indexOf("<!--OBJ_INPUTS1_BEGIN-->");
		pe= te.indexOf("<!--OBJ_INPUTS1_END-->");
		if(p>0 && pe>p){
			$("obj_inputs_1").innerHTML=te.substring(p+ "<!--OBJ_INPUTS1_BEGIN-->".length,pe);
			
		}
		p= te.indexOf("<!--OBJ_INPUTS2_BEGIN-->");
		pe= te.indexOf("<!--OBJ_INPUTS2_END-->");
		var inputs2=$("obj_inputs_2");
		if(inputs2!=null){
			if(p>0 && pe>p)
				$("obj_inputs_2").innerHTML=te.substring(p+ "<!--OBJ_INPUTS2_BEGIN-->".length,pe);
		}
		try{executeLoadedScript($("buttons"));}catch(ex){alert("buttons:exception:"+e);}
		try{
			executeLoadedScript($("obj_inputs_1"));
		}catch(ex){alert("obj_inputs_1:exception:"+e);}
		try{
			if(inputs2!=null)executeLoadedScript($("obj_inputs_2"));
		}catch(ex){alert("obj_inputs_2:exception:"+e);}

		// load inline object if current tab is that type
		if(inlineObject!=null){
			var t= jQuery('#tabs > ul');
			if(t!=null){
				t.tabs("select", t.data('selected.ui-tabs') );
			}
		}
/*		}catch(e){
			alert(e);
		}*/
		var msg=e.getUserData().message;
		this._showMessage(msg);

		oc._toggleButtons(false);
		//focus to last saved position
		if(typeof(gc) != undefined && gc!=null && !gc.isDestroied()){
			var ele=gc.getLastFocusElement();
			if(ele!=null)
				dwr.util.selectRange(ele,0,this.MAX_INPUT_LENGTH);
		}
				//support hidden/fixed columns
		oc.initColumns();
	},
	/**
	 * On key press on FK column, will remove hidden input "fk_"+inputId
	 */
	onKeyPress:function(event){
	  var e=$(Event.element(event));
	  if(e.id){
	  	e=$("fk_"+e.id);
	  	if(e!=null && e.value)e.value="";
	  }
	},
	/**
	 * When key pressed in object, move focus next input
	 */
	moveTableFocus: function(e){
		var r,ele,molist;
		switch(e.keyCode){
			case 13:{//enter
				var pos,mol,intype;
				intype=this._masterObj.hiddenInputs.id==-1?"add":"mod";
				r= this._getCurrentPositionInData(e,intype);
				molist=intype=="add"?this._masterObj.addcolumns:this._masterObj.modifycolumns;
				mol=molist.length-1;
				if(r!=null){
				if(this._masterObj.table.mask.indexOf("A")>-1||this._masterObj.table.mask.indexOf("M")>-1){
					if(r.column==mol){pos=mol; return false;}
					pos=r.column+1;
					try{
					var pid=intype=="add"?this._masterObj.addcolumns[pos].id:this._masterObj.modifycolumns[pos].id;
					ele= "column_"+pid;
					dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
					}catch(e){}
					}
					break;
				}else if(inlineObject&&!r){
					//alert("ddd");
					intype=inlineObject.hiddenInputs.id==-1?"add":"mod";
					r= this._getabDataPosition(e,intype);
					molist=intype=="add"?inlineObject.addcolumns:inlineObject.modifycolumns;
					mol=molist.length-1;
					if(r!=null){
						if(inlineObject.table.mask.indexOf("A")>-1||inlineObject.table.mask.indexOf("M")>-1){
							if(r.column==mol){pos=mol; return false;}
							pos=r.column+1;
							try{
							var pid=intype=="add"?inlineObject.addcolumns[pos].id:inlineObject.modifycolumns[pos].id;
							ele= "column_"+pid;
							dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
							}catch(e){}
							}
					}
					break;
				}
				break;
				}
			}
	},
	/**
	 * Get column in this._masterObj of current focus in object form
	 * @param e event object
	 * @return {column:int},null if not found or reach the boundary of grid
	 */
	_getCurrentPositionInData:function(e,intype){
		if(e!=null) e = e.target != null ? e.target : e.srcElement;
		if(e==null) return null;
		var p= e.id.indexOf("_",0);
		var d0= e.id.substr(0,p);
		var d1= e.id.substr(p+1);
		var i, r={column:-1},cols;
		if(intype=='add'){
			cols=this._masterObj.addcolumns;
		}else if(intype=='mod'){
			cols=this._masterObj.modifycolumns;
		}
		for(i=0;i<cols.length;i++ ){
			if(cols[i].id== d1){
				r.column= i;
				break;
			}
		}
		if(r.column==-1){
			//debug("found position error:row="+ r.row+",col="+ r.column);
			return null;
		}
		return r;
	},
		/**
	 * Get column in inlineObject of current focus in tabs object form
	 * @param e event object
	 * @return {column:int},null if not found or reach the boundary of grid
	 */
	_getabDataPosition:function(e,intype){
		if(e!=null) e = e.target != null ? e.target : e.srcElement;
		if(e==null) return null;
		var p= e.id.indexOf("_",0);
		var d0= e.id.substr(0,p);
		var d1= e.id.substr(p+1);
		var i, r={column:-1},cols;
		if(intype=='add'){
			cols=inlineObject.addcolumns;
		}else if(intype=='mod'){
			cols=inlineObject.modifycolumns;
		}
		for(i=0;i<cols.length;i++ ){
			if(cols[i].id== d1){
				r.column= i;
				break;
			}
		}
		if(r.column==-1){
			//debug("found position error:row="+ r.row+",col="+ r.column);
			return null;
		}
		return r;
	},
	/**
	 * @return false if failed to close
	 */
	closeDialog:function(ifr){
		//var webact_id=this._masterObj.table.webact_id;
		//alert(this.id);
		var w = window.opener;
		if(w==undefined)w= window.parent;
		if (w ){
			var iframe=w.document.getElementById(ifr);
			if(iframe){
	    		//w.setTimeout("Alerts.killAlert(document.getElementById('"+ifr+"'));",1);
	    		//var pid=iframe.parentNode.id.toString;
	    		//var dio=pid.substr(0,pid.length-7);
	    		art.dialog.close();
	    		return true;
		            }
		//return false;
      }
    window.location="/html/nds/info.jsp?nds.control.util.ValueHolder_message="+encodeURIComponent(gMessageHolder.COMPLETE_CLOSE);
		return false;  
	},
		/**
	@param input id id of text input
	@param url new url information
	*/
	updateAttach:function(inputId, url){
		var ele=$(inputId);
		if(ele!=null) ele.value=url;
		// 3 conditions: inc_single_object: image/attach, inc_edit_object.jsp: attach
		ele=$("att_"+inputId);
		if(ele!=null && ele.nodeName.toLowerCase()=="span"){
			if(url=="")ele.innerHTML="";
			else ele.innerHTML="<a href='"+url+"'>"+gMessageHolder.NEW_ATTACH+"</a>";
		}
		ele=$("imga_"+ inputId);
		if(ele!=null && ele.nodeName.toLowerCase()=="a"){
			if(url==""){
				ele.hide();
			}else{
				ele.href=url;
				var oimg=$("img_"+ inputId);
				if(url.indexOf("Attach")>0){
				oimg.src=url+"&t="+Math.random()+"&thum=Y";
				}else{
				oimg.src=url;
				}
				ele.show();
				if(jQuery(".zoomPad")){
					jQuery(".zoomPad").remove();
					jQuery("#imga_"+ inputId).removeData("jqzoom");
					jQuery("#imga_"+ inputId).append(oimg);
					executeLoadedScript(ele);
				}
			}
		}
	},
	
	_tryAddCloseButton:function(){
		var w = window.opener;
		if(w==undefined)w= window.parent;
		var bCloseBtn=false;
		//alert(123);
		//alert(w);
		if (w){
			var iframe0=w.document.getElementById("popup-iframe-0");
			//alert(iframe0);
			if(iframe0){
				//alert(123);
				$("closebtn").innerHTML="<a id='btn_help' name='Close' href='javascript:oc.closeDialog(\"popup-iframe-0\")'>"+
				"<img src=\"/html/nds/images/close.png\"/>"+gMessageHolder.CLOSE_DIALOG+"</a>";
				/*
				$("closebtn").innerHTML="<input class='cbutton' type='button' value='"+ gMessageHolder.CLOSE_DIALOG+
					"(C)' accessKey='C' onclick='oc.closeDialog(\"popup-iframe-0\")' name='Close'>";
					*/
				bCloseBtn=true;	
			}
			var iframe1=w.document.getElementById("popup-iframe-1");
			if(iframe1){
				$("closebtn").innerHTML="<a id='btn_help' name='Close' href='javascript:oc.closeDialog(\"popup-iframe-1\")'>"+
				"<img src=\"/html/nds/images/close.png\"/>"+gMessageHolder.CLOSE_DIALOG+"</a>";
				/*
				$("closebtn").innerHTML="<input class='cbutton' type='button' value='"+ gMessageHolder.CLOSE_DIALOG+
					"(C)' accessKey='C' onclick='oc.closeDialog(\"popup-iframe-1\")' name='Close'>";
					*/
				bCloseBtn=true;	
			}
		}
		if(!bCloseBtn){
			if(self==top){
				$("closebtn").innerHTML="<a id='btn_help' name='Close' href='javascript:window.close()'>"+
				"<img src=\"/html/nds/images/close.png\"/>"+gMessageHolder.CLOSE_DIALOG+"</a>";
				/*
				$("closebtn").innerHTML="<input type='button' class='cbutton' value='"+ gMessageHolder.CLOSE_DIALOG+
					"(C)' accessKey='C' onclick='window.close()' name='Close'>";
					*/
			}
		}
	},
	isempty:function(column_acc_Id,fk_column_acc_Id){
			if($(column_acc_Id).value==""){
		 		$(fk_column_acc_Id).value="";
			}
	},	
	audit:function(audittype,objectId){
		if(oc._toggleButtons(true) ==false) return;
		var evt={};
		evt.command="ExecuteAudit";
		evt.callbackEvent="ExecuteAudit";
		evt["nds.control.ejb.UserTransaction"]="N";
		evt.auditAction=audittype;
		evt.parsejson="Y";
		var iids=new Array();
		iids[0]=objectId;
		evt.itemid=iids;
		evt.comments=$("comments").value;
		this._executeCommandEvent(evt);
	},	
	_onExecuteAudit:function(e){
		var r=e.getUserData(); 
		if(r.message){
			msgbox(r.message.replace(/<br>/g,"\n"));
		}
		  this.closeDialog("popup-iframe-0");
	},
		/**
	 *add by robin 20130110 for meterial
	 */
	getStoreInfo2:function(){
		var c_store_meterialId="";
		var c_store_meterial_data="";
		for(i=0;i<this._masterObj.columns.length;i++){
			if( this._masterObj.columns[i].name.indexOf("Y_WAREHOUSE_ID")!=-1&&this._masterObj.columns[i].refColumnId!=-1){
				c_store_meterialId=this._masterObj.columns[i].id;
				if($("column_"+this._masterObj.columns[i].id).value==undefined){
					c_store_meterial_data=$("column_"+this._masterObj.columns[i].id).innerHTML;
				}else{
					c_store_meterial_data=$("column_"+this._masterObj.columns[i].id).value;
				}
			}
		}
		return {"c_store_meterialId":c_store_meterialId,"c_store_meterial_data":c_store_meterial_data};
	},
	/**
	 Only works when grid columns contains "m_product_id" and "m_attributesetinstance_id"
	 @return {c_store_product_id:xxx,c_store_product_data:xxx,c_dest_product_id:xxx,c_dest_product_data:xxx}
	*/
	getStoreInfo:function(){
		var i;
		var c_store_productId="";
		var c_store_product_data="";
		var c_dest_productId="";
		var c_dest_product_data="";
		var flag=false;
		var flag1=false;
		for(i=0;i<this._masterObj.columns.length;i++){
			
			if( this._masterObj.columns[i].name.indexOf("C_ORIG_ID")!=-1&&this._masterObj.columns[i].refColumnId!=-1){
			//	$("c_store_product").value=this._masterObj.columns[i].description;
			//	$("c_store_product_data").value=$("column_"+this._masterObj.columns[i].id).value;
			//	c_store_product=this._masterObj.columns[i].description
				c_store_productId=this._masterObj.columns[i].id;
				if($("column_"+this._masterObj.columns[i].id).value==undefined){
					c_store_product_data=$("column_"+this._masterObj.columns[i].id).innerHTML;
				}else{
					c_store_product_data=$("column_"+this._masterObj.columns[i].id).value;
				}
				flag=true;
			}
			if(flag){
				if( this._masterObj.columns[i].name.indexOf("C_STORE_ID")!=-1&&this._masterObj.columns[i].refColumnId!=-1){
					//c_dest_product=this._masterObj.columns[i].description;
					c_dest_productId=this._masterObj.columns[i].id;
					if($("column_"+this._masterObj.columns[i].id).value==undefined){
						c_dest_product_data=$("column_"+this._masterObj.columns[i].id).innerHTML;
					}else{
						c_dest_product_data=$("column_"+this._masterObj.columns[i].id).value;
					}
				}
			}else{
				if( this._masterObj.columns[i].name.indexOf("C_STORE_ID")!=-1&&this._masterObj.columns[i].refColumnId!=-1){
					//c_store_product=this._masterObj.columns[i].description;
					c_store_productId=this._masterObj.columns[i].id;
					if($("column_"+this._masterObj.columns[i].id).value==undefined){
						c_store_product_data=$("column_"+this._masterObj.columns[i].id).innerHTML;
					}else{
						c_store_product_data=$("column_"+this._masterObj.columns[i].id).value;
					}
				}
				flag1=true;
			}
			if(flag1){
				if( this._masterObj.columns[i].name.indexOf("C_DEST_ID")!=-1&&this._masterObj.columns[i].refColumnId!=-1){
					//c_dest_product=this._masterObj.columns[i].description;
					c_dest_productId=this._masterObj.columns[i].id;
					if($("column_"+this._masterObj.columns[i].id).value==undefined){
						c_dest_product_data=$("column_"+this._masterObj.columns[i].id).innerHTML;
					}else{
						c_dest_product_data=$("column_"+this._masterObj.columns[i].id).value;
					}
				}
			}else{
				if( this._masterObj.columns[i].name.indexOf("C_DEST_ID")!=-1&&this._masterObj.columns[i].refColumnId!=-1){
					//c_store_product=this._masterObj.columns[i].description;
					c_store_productId=this._masterObj.columns[i].id;
					if($("column_"+this._masterObj.columns[i].id).value==undefined){
						c_store_product_data=$("column_"+this._masterObj.columns[i].id).innerHTML;
					}else{
						c_store_product_data=$("column_"+this._masterObj.columns[i].id).value;
					}
				}
			}
		}
		return {c_store_product_id:c_store_productId,
			c_store_product_data:c_store_product_data,
			c_dest_product_id:c_dest_productId,
			c_dest_product_data:c_dest_product_data};
	},
	/**
	 parse store information
	*/
	/*findstoreId:function(){
		var i;
		var c_store_productId="";
		var c_store_product_data="";
		var c_dest_productId="";
		var c_dest_product_data="";
		var flag=false;
		var flag1=false;
		for(i=0;i<this._masterObj.columns.length;i++){
			
			if( this._masterObj.columns[i].name.indexOf("C_ORIG_ID")!=-1&&this._masterObj.columns[i].refColumnId!=-1){
			//	$("c_store_product").value=this._masterObj.columns[i].description;
			//	$("c_store_product_data").value=$("column_"+this._masterObj.columns[i].id).value;
			//	c_store_product=this._masterObj.columns[i].description
				c_store_productId=this._masterObj.columns[i].id;
				if($("column_"+this._masterObj.columns[i].id).value==undefined){
					c_store_product_data=$("column_"+this._masterObj.columns[i].id).innerHTML;
				}else{
					c_store_product_data=$("column_"+this._masterObj.columns[i].id).value;
				}
				flag=true;
			}
			if(flag){
				if( this._masterObj.columns[i].name.indexOf("C_STORE_ID")!=-1&&this._masterObj.columns[i].refColumnId!=-1){
					//c_dest_product=this._masterObj.columns[i].description;
					c_dest_productId=this._masterObj.columns[i].id;
					if($("column_"+this._masterObj.columns[i].id).value==undefined){
						c_dest_product_data=$("column_"+this._masterObj.columns[i].id).innerHTML;
					}else{
						c_dest_product_data=$("column_"+this._masterObj.columns[i].id).value;
					}
				}
			}else{
				if( this._masterObj.columns[i].name.indexOf("C_STORE_ID")!=-1&&this._masterObj.columns[i].refColumnId!=-1){
					//c_store_product=this._masterObj.columns[i].description;
					c_store_productId=this._masterObj.columns[i].id;
					if($("column_"+this._masterObj.columns[i].id).value==undefined){
						c_store_product_data=$("column_"+this._masterObj.columns[i].id).innerHTML;
					}else{
						c_store_product_data=$("column_"+this._masterObj.columns[i].id).value;
					}
				}
				flag1=true;
			}
			if(flag1){
				if( this._masterObj.columns[i].name.indexOf("C_DEST_ID")!=-1&&this._masterObj.columns[i].refColumnId!=-1){
					//c_dest_product=this._masterObj.columns[i].description;
					c_dest_productId=this._masterObj.columns[i].id;
					if($("column_"+this._masterObj.columns[i].id).value==undefined){
						c_dest_product_data=$("column_"+this._masterObj.columns[i].id).innerHTML;
					}else{
						c_dest_product_data=$("column_"+this._masterObj.columns[i].id).value;
					}
				}
			}else{
				if( this._masterObj.columns[i].name.indexOf("C_DEST_ID")!=-1&&this._masterObj.columns[i].refColumnId!=-1){
					//c_store_product=this._masterObj.columns[i].description;
					c_store_productId=this._masterObj.columns[i].id;
					if($("column_"+this._masterObj.columns[i].id).value==undefined){
						c_store_product_data=$("column_"+this._masterObj.columns[i].id).innerHTML;
					}else{
						c_store_product_data=$("column_"+this._masterObj.columns[i].id).value;
					}
				}
			}
		}
			$("c_store_product_id").value=c_store_productId;
			$("c_store_product_data").value=c_store_product_data;
			$("c_dest_product_id").value=c_dest_productId;
			$("c_dest_product_data").value=c_dest_product_data;
	},	*/
	_tryUpdateTitle:function(){
		var w = window.opener;
		if(w==undefined)w= window.parent;
		if (w){
			//alert(123);
			var te=w.document.getElementById("pop-up-title-0");
			if(te){
				//alert(123);
				te.innerHTML=masterObject.table.description;//+" ";
			}
		}
	},
	lable_change:function(p_id){
		jQuery('#tdd_'+p_id).hide();
		jQuery('#tdc_'+p_id).hide();
		jQuery('#column_'+p_id).show();
		},
	show_qlink:function(url,tit){
		var options=$H({width:'auto',height:'auto',title:tit,ifrid:'popup-iframe-0',drag:true,lock:true,esc:true,skin:'chrome',ispop:false,effect:false});
		art.dialog.open(url,options);
	},
	playScan:function(){
		if($("jpsId")&&!is_ie_8){
			/*
        	if(!app1){
            	var app1=FABridge.b_playErrorSound.root();
                app1.setStr($("sound").value.strip());
			}*/
						jQuery("#jpsId").jPlayer("stop");
            jQuery("#jpsId").jPlayer("play");
            return;
      }
	}
};
// define static main method
ObjectControl.main = function () {
	//try{
	oc=new ObjectControl();
	//}catch(e){}
};
/**
* Init
*/
jQuery(document).ready(ObjectControl.main); 
/*
if (window.addEventListener) {
  window.addEventListener("load", ObjectControl.main, false);
}
else if (window.attachEvent) {
  window.attachEvent("onload", ObjectControl.main);
}
else {
  window.onload = ObjectControl.main;
}*/
/*
 * Licensed under the terms of the GNU Lesser General Public License:
 * 		http://www.opensource.org/licenses/lgpl-license.php
 * 
 * File Name: toggleFCKeditor.js
 * toggleFCKeditor function
 * For more information on the script, see http://www.saulmade.nl/FCKeditor/FCKSnippets.php
 * 
 * File Authors:
 * 		Paul Moers (http://www.saulmade.nl, http://www.saulmade.nl/FCKeditor/FCKPlugins.php)
 *
 * Special thanks to Paul York for supporting me!
*/

	// config

	// what do we do with the toolbar when disabling the editor. Possibilities are 'disable', 'hide', 'collapse'.
	// When collapsed the toolbar can be expanded again by the user, but he'll find a disabled toolbar.
	var toolbarDisabledState = "hide";

	function toggleFCKeditor(editorInstance)
	{
		
		if ((!document.all && editorInstance.EditorDocument.designMode.toLowerCase() != "off") || (document.all && editorInstance.EditorDocument.body.contentEditable=="true"))
		{
			// disable the editArea
			if (document.all)
			{
				//editorInstance.EditorDocument.body.disabled = true;
				editorInstance.EditorDocument.body.contentEditable="false"; 
			}
			else
			{
				editorInstance.EditorDocument.designMode = "off";
			}
			// disable the toolbar
			switch (toolbarDisabledState)
			{
				case "collapse" :		editorInstance.EditorWindow.parent.FCK.ToolbarSet._ChangeVisibility(true);
				case "disable" :		editorInstance.EditorWindow.parent.FCK.ToolbarSet.Disable();
											buttonRefreshStateClone = editorInstance.EditorWindow.parent.FCKToolbarButton.prototype.RefreshState;
											specialComboRefreshStateClone = editorInstance.EditorWindow.parent.FCKToolbarSpecialCombo.prototype.RefreshState;
											editorInstance.EditorWindow.parent.FCKToolbarButton.prototype.RefreshState = function(){return false;};
											editorInstance.EditorWindow.parent.FCKToolbarSpecialCombo.prototype.RefreshState = function(){return false;};
											break;
					case "hide" :		if (editorInstance.EditorWindow.parent.document.getElementById("xExpanded").style.display != "none")
											{
												editorInstance.EditorWindow.parent.document.getElementById("xExpanded").isHidden = true;
												editorInstance.EditorWindow.parent.document.getElementById("xExpanded").style.display = "none";
											}
											else
											{
												editorInstance.EditorWindow.parent.document.getElementById("xCollapsed").style.display = "none";
											}
											break;
			}
		}
		else
		{
			// enable the editArea
			if (document.all)
			{
				//editorInstance.EditorDocument.body.disabled = false;
				editorInstance.EditorDocument.body.contentEditable="true"; 
			}
			else
			{
				editorInstance.EditorDocument.designMode = "on";
			}
			// enable the toolbar
			switch (toolbarDisabledState)
			{
				case "collapse" :		editorInstance.EditorWindow.parent.FCK.ToolbarSet._ChangeVisibility(false);
				case "disable" :		editorInstance.EditorWindow.parent.FCK.ToolbarSet.Enable();
											editorInstance.EditorWindow.parent.FCKToolbarButton.prototype.RefreshState = buttonRefreshStateClone;
											editorInstance.EditorWindow.parent.FCKToolbarSpecialCombo.prototype.RefreshState = specialComboRefreshStateClone;
											break;
					case "hide" :		if (editorInstance.EditorWindow.parent.document.getElementById("xExpanded").isHidden == true)
											{
												editorInstance.EditorWindow.parent.document.getElementById("xExpanded").isHidden = false;
												editorInstance.EditorWindow.parent.document.getElementById("xExpanded").style.display = "";
											}
											else
											{
												editorInstance.EditorWindow.parent.document.getElementById("xCollapsed").style.display = "";
											}
											break;
			}
			// set focus on editorArea
			editorInstance.EditorWindow.focus();
			// and update toolbarset
			editorInstance.EditorWindow.parent.FCK.ToolbarSet.RefreshModeState();
		}
	}
function FCKeditor_OnComplete(editorInstance){
	toggleFCKeditor(editorInstance);
}

/*
 * jquery-plugin Readonly
 *
 * Version 1.0-beta1
 * 
 * http://dev.powelltechs.com/jquery.readonly
 * http://plugins.jquery.com/project/readonly
 * 
 * Known good compatibility with jQuery 1.3.2
 * 
 * Please read the CHANGELOG for and/or bugzilla.
 * http://dev.powelltechs.com/bugzilla/dashboard.cgi?product=jquery.readonly
 *
 * For examples, please go to http://dev.powelltechs.com/jquery.readonly
 *
 * @todo Finish the documentation for this plugin.
 * @todo Do some half-decent comments in this javascript.
 * @todo Test this plugin with the major browsers, including
 *  IE6-8; FF3.0,3.5; Opera 9,10; Chrome/Chromium; Safari; Konqueror
 * @todo Figure out how to do automated javascript UI testing.
 *
 *
 * Copyright (c) 2009 Charlie Powell <powellc@powelltechs.com>
 * 
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 */
 
 
; // Yes, a random semicolon IS needed here, it's a jQuery thing.


// Define the default options for each readonly overlay object.
// In addition to other static methods.
//
//window.com_powelltechs_readonly_obj = window.com_powelltechs_readonly_obj || {
//	
//	// Just the interval pointer.
//	_interval: 0,
//	
//	defaults: {
//		onClick: null,
//		onDblClick: null,
//		onFocus: null,
//		onKeyPress: function(e){ if(e.keyCode == 9) return true; else return false; },
//		overlayClass: 'readonly_overlay',
//		title: '',
//		zIndex: '100',
//		
//		_dummy: false
//	},
//	
//	_elements: [],
//	
//	handleElement: function(el, opts){
//		/*console.log('@todo do the attach logic.');
//		console.log(el);
//		console.log(opts);*/
//		
//		var obj;
//		var actualEl;
//		
//		if(typeof(el.jquery) == 'undefined'){
//			// el is an actual DOM node!
//			actualEl = el;
//		}
//		else{
//			actualEl = el[0];
//		}
//		
//		// Try to reuse an existing object if it is bound to the dom node.
//		if(typeof(actualEl.com_powelltechs_readonly) != 'undefined'){
//			obj = actualEl.com_powelltechs_readonly;
//		}
//		else{
//			obj = new com_powelltechs_readonly();
//			obj.attachToElement(el);
//		}
//		
//		obj.setOptions(opts);
//	},
//	
//	init: function(){
//		if(window.com_powelltechs_readonly_obj._interval != 0) return;
//		window.com_powelltechs_readonly_obj._interval = setInterval(window.com_powelltechs_readonly_obj._tick, 500);
//	},
//	
//	_tick: function(){
//		//console.log('tock'); return;
//		for(i in window.com_powelltechs_readonly_obj._elements){
//			window.com_powelltechs_readonly_obj._elements[i].updateOverlay();
//		}
//	},
//	
//	_registerObject: function(obj){
//		window.com_powelltechs_readonly_obj._elements.push(obj);
//	},
//	
//	_unregisterObject: function(obj){
//		for(i in window.com_powelltechs_readonly_obj._elements){
//			if(window.com_powelltechs_readonly_obj._elements[i] == obj){
//				window.com_powelltechs_readonly_obj._elements.splice(i, 1);
//				return;
//			}
//		}
//	},	
//	
//
//	// KEEP THIS THE LAST ELEMENT
//	//  It's a trick to prevent the final-comma error in IE.
//	_dummy: false
//};
//
//// Each individual readonly instance will be its own version of this object.
//// This allows for a greater amount of flexibility for defining options.
//function com_powelltechs_readonly(){
//	// First, define all the properties of this new object.
//	this.elementBound = null;
//	
//	// The overlay object.
//	this.elementOverlay = null;
//	
//	// Any options currently set for this object.
//	this.options = jQuery.extend({}, window.com_powelltechs_readonly_obj.defaults);
//	
//	this.isIEHack = false;
//	
//	this.cache = {};
//	
//	this.isActive = function(){
//		return (this.elementOverlay != null);
//	};
//	
//	this.setOptions = function(opts){
//
//		var toggled = false;
//		var gogo = null;
//		var forceActive = false;
//		
//		// It's not a good idea to change options on a currently active element.
//		if(this.isActive()){
//			this.unsetOverlay();
//			toggled = true;
//			forceActive = true;
//		}
//		
//		
//		if(typeof(opts) == 'object'){
//			for (i in opts){
//				if(i == 'active' || i == 'enabled')
//					gogo = opts[i];
//				else if(i == 'toggle')
//					gogo = !this.isActive();
//				else
//					this.options[i] = opts[i];
//			}
//		}
//		
//		if(gogo === true || opts === true){
//			this.setOverlay();
//			forceActive = false;
//		}
//		else if(gogo === false || opts === false){
//			this.unsetOverlay();
//			forceActive = false;
//		}
//		else if(opts == 'toggle'){
//			// Do not toggle if it was toggled automatically!
//			if(!toggled) this.toggle();
//			forceActive = false;
//		}
//		
//		// If it was unset at the beginning of the function... reset it as active.
//		if(forceActive)
//			this.setOverlay();
//	};
//	
//	// Main function to set an overlay on an element.
//	// Will handle all the internals such as internal indexing, positioning,
//	// etc...
//	this.setOverlay = function(){
//		
//		if(this.isActive()){
//			return;
//		};
//		
//		this.elementOverlay = jQuery('<div class="' + this.options.overlayClass + '" title="' + this.options.title + '"></div>');
//		this.elementOverlay.appendTo('body');
//		this.elementOverlay.css('position', 'absolute').css('z-index', this.options.zIndex);
//		
//		// Update any events on this overlay, such as click, dblclick, and focus.
//		if(this.options.onClick != null)
//			this.elementOverlay.bind('click', this.options.onClick);
//		
//		if(this.options.onDblClick != null)
//			this.elementOverlay.bind('dblclick', this.options.onDblClick);
//		
//		if(this.options.onFocus != null)
//			this.elementBound.bind('focus', this.options.onFocus);
//		// Force the original object to reject focus events!
//		else
//			this.elementBound.attr('tabindex', '-1');
//		
//		if(this.options.onKeyPress != null)
//			this.elementBound.bind('keypress', this.options.onKeyPress);
//		
//		
//		//el.bind('focus', this.bindUnfocus).after(overlay);
//		//this._updateOverlay(el);
//		
//		if(this.isIEHack)
//			this.elementBound.css('visibility', 'hidden');
//		
//		// Update the overlay positioning.
//		this.updateOverlay();
//		
//		// Finally, register with the global list of overlays so they can be kept track of.
//		window.com_powelltechs_readonly_obj._registerObject(this);
//	};
//
//	// Main function to unset an overlay from an element.
//	// Will handle all the internals such as internal indexing, positioning,
//	// etc...
//	this.unsetOverlay = function(){
//		if(!this.isActive()){
//			return;
//		};
//		
//		this.elementOverlay.remove();
//		this.elementOverlay = null;
//		
//		//el.unbind('focus', this.bindUnfocus);
//		
//		if(this.isIEHack)
//			this.elementBound.css('visibility', 'visible');
//		
//		// Clear the cache dimensions.
//		this.cache.dimensions = {
//				width: 0,
//				height: 0,
//				left: 0,
//				top: 0
//		};
//		
//		
//		if(this.options.onFocus != null)
//			this.elementBound.unbind('focus', this.options.onFocus);
//		// I guess... if the original objects wants its focus back...
//		else
//			this.elementBound.attr('tabindex', '0');
//		
//		if(this.options.onKeyPress != null)
//			this.elementBound.unbind('keypress', this.options.onKeyPress);
//		
//		// Finally, unregister with the global list of overlays.
//		window.com_powelltechs_readonly_obj._unregisterObject(this);
//	};
//	
//	// Update a jQuery element's overlay position, useful for window resizing and
//	//  initial setting on the element.
//	this.updateOverlay = function(){
//		if(!this.isActive()) return;
//		
//		var d = this.getDimensions();
//		var c = this.cache.dimensions;
//		var doAll = (typeof(c) == 'undefined')? true : false;
//		
//		// Do these new dimensions match the cached ones?
//		if(doAll || d.width != c.width) this.elementOverlay.css('width', d.width);
//		if(doAll || d.height != c.height) this.elementOverlay.css('height', d.height);
//		if(doAll || d.top != c.top) this.elementOverlay.css('top', d.top);
//		if(doAll || d.left != c.left) this.elementOverlay.css('left', d.left);
//
//		// Cache this information for any future checks.
//		this.cache.dimensions = d;
//	};
//	
//	this.toggle = function(){
//		if(this.isActive()) this.unsetOverlay();
//		else this.setOverlay();
//	};
//	
//	this.attachToElement = function(el){
//		if(typeof(el) == 'undefined')
//			this.unbind();
//		else
//			this.bind(el);
//	};
//	
//	this.bind = function(el){
//		
//		this.elementBound = jQuery(el);
//		this.elementBound[0].com_powelltechs_readonly = this;
//		
//		
//		// IE version 6 was so wonderful.... wasn't it?.....
//		// @see http://blogs.msdn.com/ie/archive/2006/01/17/514076.aspx
//		if(this.elementBound[0].tagName == 'SELECT' && jQuery.browser.version == '6.0' && jQuery.browser.msie)
//			this.isIEHack = true;
//	};
//	
//	this.unbind = function(){
//		if(this.elementBound == null) return;
//		if(typeof(this.elementBound.com_powelltechs_readonly) != 'undefined') this.elementBound.com_powelltechs_readonly = null;
//		this.elementBound = null;
//	};
//	
//	
//	
//	
//	// Get dimensions for a jQuery element.
//	//  Internally function, but could probably be used by anything.
//	// @return object { width, height, top, left }
//	this.getDimensions = function(){
//		var ret = {
//			width: 0,
//			height: 0,
//			top: 0,
//			left: 0
//		};
//		
//		if(this.elementBound == null){
//			return ret;
//		}
//		
//		// The multiple acquisitions of the CSS styles are required to cover any border and padding the elements may have.
//		// The Ternary (parseInt(...) || 0) statements fix a bug in IE6 where it returns NaN,
//		//  which doesn't play nicely when adding to numbers...
//		
//		ret.width = this.elementBound.width() 
//		  + (parseInt(this.elementBound.css('borderLeftWidth')) || 0)
//		  + (parseInt(this.elementBound.css('borderRightWidth')) || 0)
//		  + (parseInt(this.elementBound.css('padding-left')) || 0)
//		  + (parseInt(this.elementBound.css('padding-right')) || 0);
//		ret.height = this.elementBound.height() 
//		  + (parseInt(this.elementBound.css('borderTopWidth')) || 0) 
//		  + (parseInt(this.elementBound.css('borderBottomWidth')) || 0)
//		  + (parseInt(this.elementBound.css('padding-bottom')) || 0)
//		  + (parseInt(this.elementBound.css('padding-bottom')) || 0);
//		var offsets = this.elementBound.offset();
//		
//		var zoom = 1;
//		/*
//		if(document.body.clientWidth){
//			var b = document.body.getBoundingClientRect();    
//			zoom = (b.right - b.left) / document.body.clientWidth;
//		}
//		*/
//		ret.left = offsets.left * zoom;
//		ret.top = offsets.top * zoom;
//		
//		return ret;
//	};
//	
//	
//	// Lastly, do any logic required in the constructor.
//	//this.setOptions(options);
//		
//};
//
//
//(function(jQuery) {
//
//  jQuery.extend(jQuery.fn, {
//	// jQuery wrapper around the global handler object.
//	readonly : function(options) {
//	  
//	  // Init the global object if not already, can be called multiple times.
//	  window.com_powelltechs_readonly_obj.init();
//	  
//	  // If no status was given, set it to true.
//	  if (options == undefined) options = true;
//	  
//	  // Run through each element given in by the programmer.
//	  jQuery(this).each(function(){
//		  window.com_powelltechs_readonly_obj.handleElement(this, options);
//	  });
//	  return this;
//	}
//  });
//})(jQuery);

/* END OF FILE jquery.readonly */
