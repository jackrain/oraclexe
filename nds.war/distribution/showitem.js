var si=null;
var SHOWITEM=Class.create();
SHOWITEM.prototype={
    initialize: function() {
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        dwr.util.setEscapeHtml(false);
        /** A function to call if something fails. */
        dwr.engine._errorHandler =  function(message, ex) {
            while(ex!=null && ex.cause!=null) ex=ex.cause;
            if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + "," + ex.message+","+ ex.cause.message, true);
            if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
            else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
            else alert(message);
        };
        application.addEventListener("SHOW_ITEM",this._onShowItem,this);
        application.addEventListener("FUND_BALANCE",this._onfundQuery,this);        
    },
     //经销商资金余额
    fundQuery:function(m_allot_id){
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="FUND_BALANCE";
        var param={"m_allot_id":m_allot_id};
        evt.param=Object.toJSON(param);
        evt.table="m_allot";
        evt.action = "cus";
        evt.permission="r";
        this._executeCommandEvent(evt);
    },
    _onfundQuery:function(e){
		var style;
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        var fundStr= ""; 
        if(ret.data=="null"){
						fundStr="<div style='font-size:20px;color:red;text-align:center;font-weight:bold;vertical-align:middle'>没有经销商信息！</div>";
        }else{
            var funditem=new Array();
            if(this.checkIsArray(ret.data)){
            	funditem=ret.data;
            }else{
            	funditem[0]=ret.data;
            }
            for(var i=0;i<funditem.length;i++){
				if(i%2==1){style="style='background-color:#f8f8f8;'"}
				else{style="style='background-color:white;'"}
            	fundStr+="<div class=\"mingxi-sidebar row\"><div class=\"row-line\">"+
											 "<div "+style+" class=\"span-8\">"+(funditem[i].facusitem.NAME||"")+
											 "</div><div "+style+" class=\"span-7\">"+(funditem[i].facusitem.TOT_AMT||0)+
											 "</div><div "+style+" class=\"span-7\">"+(funditem[i].facusitem.FEEALLOT||0)+
											 "</div><div "+style+" class=\"span-9\">"+(funditem[i].facusitem.TOT_QTY||0)+
											 "</div></div></div>";
            }
        }
        jQuery("#fund-main").html(fundStr);
    },
    showItem:function(m_allot_id,undist){
        var evt={};
        evt.command="DBJSONXML";  
        evt.callbackEvent="SHOW_ITEM"; 
        var param;
        if(!undist){
       	 	param={"m_allot_id":m_allot_id,"condition2":"","condition1":"","relation":"","column1":"","undist":"-1","column2":""}; 
      	}else{
      		var con1=jQuery("#v1").val();
      		var con2=jQuery("#v2").val();
      		var col1=jQuery("#con1").val();
      		var col2=jQuery("#con2").val();
      		var rel=jQuery("#rel").val();
      		param={"m_allot_id":m_allot_id,"condition2":con2,"condition1":con1,"relation":rel,"column1":col1,"undist":undist,"column2":col2}; 
      	}
        evt.param=Object.toJSON(param);
        evt.table="m_allot";
        evt.action="tab";
        evt.permission="r";
        this._executeCommandEvent(evt);     	
    },
    _onShowItem:function(e){
		var style;
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        if(!ret.data||ret.data=="null"){
        	alert("没有数据!");
        	jQuery("#mingxi-main").html("");
        	return;
        }
				var datas=new Array();
				if(this.checkIsArray(ret.data)){
					datas=ret.data;
				}else{
					datas[0]=ret.data;
				}
				var str="";
				for(var i=0;i<datas.length;i++){
					if(i%2==1){style="style='background-color:#f8f8f8;'"}
					else{style="style='background-color:white;'"}
					str+="<div class=\"mingxi-sidebar row\">"+
							 "<div class=\"row-line\">"+
							 "<div "+style+" class=\"span-1\">"+datas[i].m_alloitem.PDT+"</div><div "+style+" class=\"span-1\">"+datas[i].m_alloitem.VALUE1+"</div><div "+style+" class=\"span-1\">"+datas[i].m_alloitem.VALUE2+"</div><div "+style+" class=\"span-2\">"+datas[i].m_alloitem.NAME+"</div><div "+style+" class=\"span-1\">"+datas[i].m_alloitem.QTYREM+"</div><div "+style+" class=\"span-"+(datas[i].m_alloitem.QTY_ALLOT==0?11:4)+"\">"+(datas[i].m_alloitem.QTY_ALLOT==0?"是":"否")+"</div>"+
							 "</div></div>";
				}
				jQuery("#mingxi-main").html(str);
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
    },
    checkIsObject:function(o) {
        return (typeof(o)=="object");
    },

    checkIsArray: function(o) {
        return (this.checkIsObject(o) && (o.length) &&(!this.checkIsString(o)));
    },
    checkIsString:function (o) {
        return (typeof(o)=="string");
    },
    checkIsDate:function(month,date,year){
        if(parseInt(month,10)>12||parseInt(month,10)<1||parseInt(date,10)>31||parseInt(date,10)<1||parseInt(year,10)<1980||parseInt(year,10)>3000) {
            return false;
        }
        return true;
    }
}
SHOWITEM.main = function(){
    si=new SHOWITEM();
};
jQuery(document).ready(SHOWITEM.main);
jQuery(document).ready(function(){
   jQuery("body").bind("keyup",function(event){
       if(event.which==13){
           event.stopPropagation();
       }
   });
});