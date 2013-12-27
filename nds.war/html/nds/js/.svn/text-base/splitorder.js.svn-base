var spo=null;
var SplitOrderControl = Class.create();
// define
SplitOrderControl.prototype = {
	initialize: function() {
		dwr.engine.setErrorHandler(function(message, ex) {
			if (message == null || message == "") {
				while(ex!=null && ex.cause!=null) ex=ex.cause;
				if(ex!=null)message=ex.javaClassName;
				alert(gMessageHolder.INTERNAL_ERROR+":"+ message);
			}
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else alert(message);
			spo._toggleButtons(false);
		});		
		application.addEventListener( "SplitOrder", this._onSplitOrder, this);
		
		this.MAX_INPUT_LENGTH=40;
		$("sub1").value="50";
		$("sub2").value="50";
		var i;
		for(i=3;i<=10;i++)$("sub"+i).value="";
		this._tot=100;
	},
	_onSplitOrder:function(e){
		var r=e.getUserData(); 
		if(r.code!=0){
			alert(r.message);
		}else{
			this._closeWindowOrShowMessage(r.message);
		}
	},
	_closeWindowOrShowMessage:function(msg){
		var isclosed=false;
    	var w = window.opener;
    	if(w==undefined)w= window.parent;
    	if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
	    		w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'))",1);
				alert(msg);
	    		isclosed=true;
    		}
    	}
    	if(!isclosed){
			var body = document.getElementsByTagName("body")[0];
			body.innerHTML="<div class='returnmsg'>"+msg+"</div>";
    	}
    },	
	_toggleButtons:function(disable){
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
	splitMethodChanged:function(){
		var m=$("splitmethod").value;
		var uom="";
		if(m=="R"){
			uom="%";
			$("sub1").value="50";
			this._tot=100;
		}else if(m=="W"){
			uom="kg";
			this._tot=initObjSplitOrder.weight;
			$("sub1").value=(initObjSplitOrder.weight/2).toFixed(2);
		}else if(m=="V"){
			uom="m3";
			this._tot=initObjSplitOrder.volume;
			$("sub1").value=(initObjSplitOrder.volume/2).toFixed(2);
		}else{
			this._tot=initObjSplitOrder.qty;
			$("sub1").value=(initObjSplitOrder.qty/2).toFixed(2);
		}
		this._balanceValue($("sub2"));
		var i;
		for(i=3;i<=10;i++)$("sub"+i).value="";
		for(i=1;i<=10;i++)$("uom"+i).innerHTML=uom;
	},
	change:function(ele){
		var n=$(ele).value;
		if(!isNaN(n)){
			var v=Number(n).toFixed(2);
			if(Number(v)==0)$(ele).value="";
			else $(ele).value= v;
		}
		else $(ele).value="";
	},
	moveFocus:function(e){
		var r,ele;
		switch(e.keyCode){
			case 38:{//UP
				r= this._getCurrentPositionInData(e);
				if(r!=null){
					r=r-1;
					if(r>0){
						ele= $("sub"+r);
						this._balanceValue(ele);
						dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
					}
				}
				break;
			}
			case 40://DOWN
			case 13:{//Enter
				r= this._getCurrentPositionInData(e);
				if(r!=null){
					r=r+1;
					if(r<=10){
						ele= $("sub"+r);
						this._balanceValue(ele);
						dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
					}
				}
				break;
			}
		}		
	},
	_balanceValue:function(ele){
		var eId= $(ele).id;
		var d;
		var i,v,sum=0;
		for(i=1;i<11;i++){
			d=$("sub"+i);
			if(d.id!=eId){
				if(!isNaN(d.value)){
					v=Number(Number(d.value).toFixed(2));
					if(v==0)d.value="";
					sum+=v;
				}else{
					d.value="";	
				}
			}
		}
		if(this._tot-sum!=0){
			v=Number((this._tot-sum).toFixed(2));
			if(v==0)$(ele).value="";
			else $(ele).value=(this._tot-sum).toFixed(2);
		}else{
			$(ele).value="";	
		}
	},
	/**
		 * @param e event object
		 * @return null or int
		 */
	_getCurrentPositionInData:function(e){
		if(e!=null) e = e.target != null ? e.target : e.srcElement;
		if(e==null) return null;
		if(isNaN(e.id.substr(3))) return null;
		return Number(e.id.substr(3));
	},
	_checkObjectInputs:function(){
		var d,v,sum=0;
		for(i=1;i<11;i++){
			d=$("sub"+i);
			v=Number(d.value);
			if(v!=NaN && v>=0){
				sum+=v;
			}else{
				alert(gMessageHolder.DATA_ERROR);
				d.focus();
				return false;
			}
		}
		if(sum!=this._tot){
			alert(gMessageHolder.SUM_DATA_ERROR);
			return false;
		}
		return true;
	},
	doSubmit: function () {
		this._toggleButtons(true);		
		if(this._checkObjectInputs()==false){
			this._toggleButtons(false);		
	       	return;
    	}
		var evt={};//$H(Form.serializeElements( $('split_form').getInputs('text') ));
		evt.command="SplitLOrder";
		evt.parsejson="Y";
		evt["nds.control.ejb.UserTransaction"]="N";
		evt.l_order_id=$("objectid").value;
		evt.splitmethod=$("splitmethod").value;
		evt.callbackEvent="SplitOrder";
		for(var i=1;i<=10;i++) evt["sub"+i]= $("sub"+i).value;
		this._executeCommandEvent(evt);
	},	
	/**
	* Request server handle command event
	* @param evt CommandEvent
	*/
	_executeCommandEvent :function (evt) {
		Controller.handle( Object.toJSON(evt), function(r){
				//try{
					spo._toggleButtons(false);
					var result= r.evalJSON();
					if (result.code !=0 ){
						alert(result.message);
					}else {
						var evt=new BiEvent(result.callbackEvent);
						evt.setUserData(result);
						application.dispatchEvent(evt);
					}
				/*}catch(ex){
					msgbox(ex.message);
				}*/
			
		});
	}	
	
};
SplitOrderControl.main = function () {
	spo=new SplitOrderControl();
};
jQuery(document).ready(SplitOrderControl.main); 