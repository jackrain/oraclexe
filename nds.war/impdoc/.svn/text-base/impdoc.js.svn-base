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
		var doctype=$("list").value;
		var qtytype=$("list1").value;
		var docno=$("docno").value;
        	var tableid=$("tableId").value;
        	var orderid=$("objectId").value;
                //alert(qtytype);
                //alert(orderid);
		//var objectid=$("object_id").value;
                //var tableid=$("table_id").value;
		if (doctype == "1" || qtytype == "1") {
		        alert("请选择导入条件!");
		        return;
			}
		if(!docno){
			alert("订单编号不能为空!");	
			return;
		}else{
			//var param={"tableid":tableid,"objectid",objectid,"doctype":doctype,"docno":docno};
			var param={"doctype":doctype,"docno":docno,"tableid":tableid,"orderid":orderid,"qtytype":qtytype};
			evt.param=Object.toJSON(param);
			//alert(evt.param);
			evt.table="c_store";
			evt.action="impdocno";
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
	     alert('单据导入成功！请刷新明细！');
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
