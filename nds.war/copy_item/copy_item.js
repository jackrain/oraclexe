var ci=null;
var COPYITEM=Class.create();
COPYITEM.prototype={
     initialize: function() {
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        dwr.util.setEscapeHtml(false);
        dwr.engine._errorHandler =  function(message, ex) {
            while(ex!=null && ex.cause!=null) ex=ex.cause;
            if(ex!=null)message=ex.message;
            if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
            else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
            else alert(message);
        };
        application.addEventListener("DO_COPY",this._onCopy,this);
    },
    copy:function(){
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="DO_COPY";
        var reg=/^\d{8}$/;
        var tableid=$("tableid").value.strip();
        var orderid=$("orderid").value.strip();
        var billdate=$("column_29995").value.strip();
        var year=billdate.substring(0,4);
        var month=billdate.substring(4,6);
        var date=billdate.substring(6,8);
        var bd=month+"/"+date+"/"+year;
        if(!this.checkIsDate(month,date,year)||!reg.test(billdate)){
            alert("开始日期格式不对！请输入8位有效数字。");
            return;
        }
        var c_store_name=$("c_store_name")?$("c_store_name").value:"null";
        var c_dest_name=$("c_dest_name")?$("c_dest_name").value:"null";
        var distes0=$("distes0")?$("distes0").value:"null";
        var distes1=$("distes1")?$("distes1").value:"null";
        var colid0=$("colid0")?$("colid0").value:"";
        var c_store_id=$("fk_column_"+colid0)?$("fk_column_"+colid0).value.strip():"-1";
        if(!c_store_id){
            alert(distes0+"不能为空！");
            return;
        }
        var colid1=$("colid1")?$("colid1").value:"";
        var c_dest_id=$("fk_column_"+colid1)?$("fk_column_"+colid1).value.strip():"-1";
        if(!c_dest_id){
            alert(distes1+"不能为空！");
            return;
        }
        var per=jQuery("#per").val();
        var ctype=$("ctype").value;
        var reprice;
        if($("reprice").checked){
            reprice="Y";
        }else{
            reprice="N";
        }
        var param={"tableid":tableid,"orderid":orderid,"billdate":billdate,"c_store_id":c_store_id,
                    "c_dest_id":c_dest_id,"per":per,"ctype":ctype,"reprice":reprice,
                    "c_store_name":c_store_name,"c_dest_name":c_dest_name}
        evt.param=Object.toJSON(param);
        evt.table="ad_table";
        evt.action="cpitem";
        evt.permission="r";
        this._executeCommandEvent(evt);
    },
    _onCopy:function(e){
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        window.location="/html/nds/object/object.jsp?table="+$("tableid").value+"&fixedcolumns=&id="+ret.data.tableid;
    },
    closeDialog:function(){
		var w = window.opener;
		if(w==undefined)w= window.parent;
		if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
	    		//w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'));",1);
	    		art.dialog.close();
	    		return true;
			}
		}
		return false;
	},
    checkIsDate:function(month,date,year){
        if(parseInt(month,10)>12||parseInt(month,10)<1||parseInt(date,10)>31||parseInt(date,10)<1||parseInt(year,10)<1980||parseInt(year,10)>3000) {
            return false;
        }
        return true;
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
}
COPYITEM.main = function () {
    ci=new COPYITEM();
};
jQuery(document).ready(COPYITEM.main);