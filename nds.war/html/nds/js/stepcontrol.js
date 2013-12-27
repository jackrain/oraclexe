var step;
var StepControl = Class.create();
StepControl.prototype = {
	initialize: function() {
		this._masterObj=masterObject;
		this.inlineflag=false;
		dwr.engine.setErrorHandler(function(message, ex) {
			if (message == null || message == "") {
				while(ex!=null && ex.cause!=null) ex=ex.cause;
				if(ex!=null)message=ex.javaClassName;
				msgbox(gMessageHolder.INTERNAL_ERROR+":"+ message);
			}
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else msgbox(message);
		}
		);	
		application.addEventListener("StepObject", this._onStepObject, this);
		this._tryUpdateTitle();
	},
	/*
	* savehead save add ,modify
	*/
	savehead : function () {
		var inlineObjInputs=$("inline-obj-inputs");
		if(inlineObjInputs!=null){
			if(this._checkInlineObjectInputs()==false){	
	       		return;
    		}
		}
		if(this._checkObjectInputs()==false){
			return;
		}
		var evt={};
		evt.command="ProcessStep";
		evt["nds.control.ejb.UserTransaction"]="N";
		evt.masterobj=$H(Form.serializeElements( this._getInputs("obj_inputs_1"),true));
		evt.masterobj.merge(this._loadClobs());
		evt.masterobj.merge(this._masterObj.hiddenInputs);
		evt.callbackEvent="StepObject";
		evt.inline="N";//only save head
		evt.p_nextstep=$("p_nextstep").value;
		this._executeCommandEvent(evt);
	},
	
	preStep:function(){
		var evt={};
		var flag=true;
		if(gc!=undefined && !gc.isDestroied())gc.fillProcessEvent(evt); 
		if(evt.addList!=""){
			if(!confirm(gMessageHolder.CONFIRM_DISCARD_CHANGE_ADD)){
				flag=false;
			}	
		}else if(evt.modifyList!=""){
			if(!confirm(gMessageHolder.CONFIRM_DISCARD_CHANGE)){
				flag=false;
			}
		}
		if(flag){
			var p_nextstep=$("p_nextstep").value;
			var url="";
			if(p_nextstep==-2){
				var nextstep=$("nextstep").value-1;
				url="/html/nds/step/index.jsp?input=true&table=" +this._masterObj.hiddenInputs.table+ "&id=" + this._masterObj.hiddenInputs.id+"&p_nextstep="+nextstep;
			}else{
				p_nextstep=p_nextstep-1;
				url="/html/nds/step/index.jsp?input=true&table=" +this._masterObj.hiddenInputs.table+ "&id=" + this._masterObj.hiddenInputs.id+"&p_nextstep="+p_nextstep;
			}
			window.location=url;
		}
	},
	
	_onStepObject:function(e){
		var r=e.getUserData(); 
		if(r.code!=0){
			this._showMessage(r.message,true);
		}else{
			window.location=r.data.nextscreen;
		}

	},
	_tryUpdateTitle:function(){
		var w = window.opener;
		if(w==undefined)w= window.parent;
		if (w ){
			var te=w.document.getElementById("pop-up-title-0");
			if(te){
				te.innerHTML=masterObject.table.description;//+" ";
			}
		}
	},
	/*
	* saveinline:save inline
	*/
	saveinline:function(){
		if(this._checkObjectInputs()==false){
	       	return;
    	}
		var inlineObjInputs=$("inline-obj-inputs");
		if(inlineObjInputs!=null){
			if(this._checkInlineObjectInputs()==false){
	       		return;
    		}
		}
		var evt={};
		evt.command="ProcessStep";
		evt["nds.control.ejb.UserTransaction"]="N";//each line will have a seperate transaction
		if(gc!=undefined && !gc.isDestroied())gc.fillProcessEvent(evt); // grid control
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
		evt.callbackEvent="StepObject";
		evt.inline="Y";//save inline add don't save head
		if(this.inlineflag==true){
			evt.inlineflag="Y";
		}else{
			evt.inlineflag="N";//execude next step
		}
		evt.p_nextstep=$("p_nextstep").value;
		this._executeCommandEvent(evt);
	},
	
	doDeleteLine:function(){
		gc.deleteSelected();
		this.inlineflag=true;
		this.saveinline();
	},
	doSaveLine:function(){
		this.inlineflag=true;
		this.saveinline();
	},
	doSaveLineStep:function(){
		this.inlineflag=false;
		this.saveinline();
	},
	saveinline_test:function(){
		window.location="/html/nds/step/index.jsp?input=true&table=" +this._masterObj.hiddenInputs.table+ "&id=" + this._masterObj.hiddenInputs.id+"&p_nextstep=2";
	},
	newLine:function(){
		gc.newLine(true);
		this.inlineflag=true;
		this.saveinline();
	},
	doSubmit:function(){
    	if (!confirm(gMessageHolder.DO_YOU_CONFIRM_SUBMIT)) {
            return false;
        }
 		var evt={};
		evt.command="ProcessStep";
		evt.submitAfterSave="Y"; 
		evt.masterobj=this._masterObj.hiddenInputs;
		evt.callbackEvent="StepObject";
		evt.p_nextstep=$("nextstep").value;
		evt.inline="Y";
		evt.inlineflag="N";
		this._executeCommandEvent(evt);
    },
	 doUnsubmit:function(){
    	if (!confirm(gMessageHolder.DO_YOU_CONFIRM_UNSUBMIT)) {
            return false;
        }
    	var evt={};
		evt.command="ProcessStep";
		evt.unsubmit="Y";
		evt.callbackEvent="StepObject";
		evt.merge(this._masterObj.hiddenInputs);
		evt.p_nextstep=$("nextstep").value;
		evt.inline="Y";
		evt.inlineflag="N";
		this._executeCommandEvent(evt);
    },
	_getInputs:function(form){
	    form = $(form);
	    var inputs = $A(form.getElementsByTagName('input'));
		inputs=inputs.concat($A(form.getElementsByTagName('textarea')));
		inputs=inputs.concat($A(form.getElementsByTagName('select')));
	    return inputs.map(Element.extend);
	},
	_loadClobs:function(){
		var clobs={};
		var cols= this._masterObj.columns;
		for(var i=0;i<cols.length;i++){
			var col= cols[i];
			if(col.displaySetting=="clob"){
				var oEditor = FCKeditorAPI.GetInstance("column_"+ col.id) ;
				if(oEditor!=null){
					clobs[col.name.toLowerCase()] = oEditor.GetHTML();
				}
			}
		}		
		return clobs;
	},
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
	_checkInlineObjectInputs: function(){
		var cols=inlineObject.columns,i,col, d;
		var maskPos= inlineObject.hiddenInputs.id==-1?1:3;
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

	closeDialog:function(){
		var w = window.opener;
		if(w==undefined)w= window.parent;
		if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
	    		w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'));",1);
	    		return true;
			}
		}
		return false;
	},
	_executeCommandEvent :function (evt) {
		//showProgressWindow(true);
		
		Controller.handle( Object.toJSON(evt), function(r){

					var result= r.evalJSON();
					if (result.code !=0 ){
						msgbox(result.message);
					}else {
						var evt=new BiEvent(result.callbackEvent);
						evt.setUserData(result);
						application.dispatchEvent(evt);
					}			
		});
	},	
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
	}
};
StepControl.main = function () {
	try{
	step=new StepControl();
	}catch(e){}
};

jQuery(document).ready(StepControl.main);