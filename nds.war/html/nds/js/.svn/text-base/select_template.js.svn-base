var st;
var Select_templateControl = Class.create();

Select_templateControl.prototype = {
	initialize: function() {
	//	dwr.util.useLoadingMessage(gMessageHolder.LOADING)
		dwr.engine.setErrorHandler(function(message, ex) {
			if (message == null || message == "") {
				while(ex!=null && ex.cause!=null) ex=ex.cause;
				if(ex!=null)message=ex.javaClassName;
			//	alert(gMessageHolder.INTERNAL_ERROR+":"+ message);
			}
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else alert(message);
		});		
		application.addEventListener( "SelectTemplate", this._onselect_template, this);
	},
	cloose_template : function (template,clientId) {
		var evt={};
		evt.command="SelectTemplate";
		evt.params={"template":template,"clientId":clientId};	
	    evt.callbackEvent="SelectTemplate";
		this._executeCommandEvent(evt);	
			
	 },
	_onselect_template : function (e) {
     var r=e.getUserData(); 		
		if(r.code!=0){
			this._showMessage(r.message,true);
		}
		else {
			alert(gMessageHolder.TEMPLATE_UPDATED);
			self.close();
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
				alert(msg);
			}
	},
	page: function(pageindex,totpage){
		/*if(pageindex>=totpage){
			alert("这是最后一页！");
          }else if(pageindex<0){
		  	alert("这是第一页！");
		  }else{
		  		window.open("select_template.jsp?pagesize="+pageindex,"_self","");
		  }*/
		window.location="/html/nds/webclient/select_template.jsp?pagesize="+pageindex;
	}
};

Select_templateControl.main = function () {
	st=new Select_templateControl();
};

jQuery(document).ready(Select_templateControl.main);