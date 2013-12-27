var cost;
var CostControl = Class.create();
CostControl.prototype = {
	initialize: function() {
		dwr.util.useLoadingMessage(gMessageHolder.LOADING)
		dwr.engine.setErrorHandler(function(message, ex) {
			if (message == null || message == "") {
				while(ex!=null && ex.cause!=null) ex=ex.cause;
				if(ex!=null)message=ex.javaClassName;
				alert(gMessageHolder.INTERNAL_ERROR+":"+ message);
			}
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else alert(message);
		});		
		application.addEventListener( "COST_COPY", this._onCost_copy, this);
	},
	//COST_COPY...
 price_copy:function (){
	 	var evt={};
		evt.command="DBJSONXML";
		evt.callbackEvent="COST_COPY";
		var dealer_query=$("fk_dealer_query2").value;
		var dealer_query1_sql=$("dealer_query1").value;
		if(dealer_query==""||dealer_query1_sql==""){
			alert("用户组不能为空!");	
		}else{
			var param={"group_s":dealer_query,"group_m":dealer_query1_sql};
			evt.param=Object.toJSON(param);
			//alert(evt.param);
			evt.table="groups";
			evt.action="permissioncopy";
			evt.permission="r";
			this._executeCommandEvent(evt);	
		}
	},
//COST COPY	
	_onCost_copy:function (e) {
		var data=e.getUserData(); 
					
    	var ret=data.jsonResult.evalJSON();
    //	alert(Object.toJSON(ret));
    	var costdata=ret.data;
    	if(costdata!=null&&costdata.result=='ok'){    		
	    	$(result001).innerHTML="<span style='font-family:Courier, Courier New, monospace ;color:green;font-size:20px'>复制成功!</span>";
    	}else{
    		$(result001).innerHTML="<span style='font-family:Courier, Courier New, monospace ;color:red;font-size:20px'>复制失败!</span>";
    	}
	},	
 _executeCommandEvent :function (evt) {
        Controller.handle( Object.toJSON(evt), function(r){
            var result= r.evalJSON();
            if (result.code !=0 ){
                alert(result.message);
            }else {
                var evt=new BiEvent(result.callbackEvent);
                evt.setUserData(result.data);
                application.dispatchEvent(evt);
            }
        });
    }
};

CostControl.main = function () {
	cost=new CostControl();
};

jQuery(document).ready(CostControl.main);
