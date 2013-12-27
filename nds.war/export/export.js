var export=null;
var EXPORT=Class.create();
EXPORT.prototype={
    initialize:function(){
        dwr.util.setEscapeHtml(false);
        dwr.engine._errorHandler =  function(message, ex) {
            while(ex!=null && ex.cause!=null) ex=ex.cause;
            if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + "," + ex.message+","+ ex.cause.message, true);
            if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
            else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
            else alert(message);
        };
        application.addEventListener("DO_EXPORT",this._onExport,this);
        application.addEventListener("LOAD",this._onLoad,this);
    },
    load:function(){
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="LOAD";
        var param={"type":"log","datebeg":"-1","dateend":"-1"};
        evt.param=Object.toJSON(param);
        evt.table="c_customer";
        evt.action="Export";
        evt.permission="r";
        this._executeCommandEvent(evt);
    },
    _onLoad:function(e){
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        var str="";
        if(ret.data){
            str= "<table width=\"480\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">";
            if(this.checkIsArray(ret.data)){
                for(var i=0;i<ret.data.length;i++){
                    str+="<tr>"+
                         "<td width=\"100\"><div class=\"dd-left-txt\">单据起始时间：</div></td>"+
                         "<td width=\"140\"><div class=\"dd-right-txt\">"+this.fmtDate(ret.data[i].DATEBEG)+"</div></td>"+
                         "<td width=\"100\"><div class=\"dd-left-txt\">单据结束时间：</div></td>"+
                         "<td width=\"140\"><div class=\"dd-right-txt\">"+this.fmtDate(ret.data[i].DATEEND)+"</div></td>"+
                         "</tr>"+
                         "<tr>"+
                         "<td width=\"100\"><div class=\"dd-left-txt\">操作人：</div></td>"+
                         "<td width=\"140\"><div class=\"dd-right-txt\">"+ret.data[i].USERS+"</div></td>"+
                         "<td width=\"100\"><div class=\"dd-left-txt\">操作时间：</div></td>"+
                         "<td width=\"140\"><div class=\"dd-right-txt\">"+ret.data[i].OPERTIME+"</div></td>"+
                         "</tr>"
                }
            }else{
                str+="<tr>"+
                     "<td width=\"100\"><div class=\"dd-left-txt\">单据起始时间：</div></td>"+
                     "<td width=\"140\"><div class=\"dd-right-txt\">"+this.fmtDate(ret.data.DATEBEG)+"</div></td>"+
                     "<td width=\"100\"><div class=\"dd-left-txt\">单据结束时间：</div></td>"+
                     "<td width=\"140\"><div class=\"dd-right-txt\">"+this.fmtDate(ret.data.DATEEND)+"</div></td>"+
                     "</tr>"+
                     "<tr>"+
                     "<td width=\"100\"><div class=\"dd-left-txt\">操作人：</div></td>"+
                     "<td width=\"140\"><div class=\"dd-right-txt\">"+ret.data.USERS+"</div></td>"+
                     "<td width=\"100\"><div class=\"dd-left-txt\">操作时间：</div></td>"+
                     "<td width=\"140\"><div class=\"dd-right-txt\">"+ret.data.OPERTIME+"</div></td>"+
                     "</tr>"
            }
           str+="</table>";
        }
        $("tableContent").innerHTML=str;
    },
    doexport:function(){
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="DO_EXPORT";
        var reg=/^\d{8}$/;
        var datebeg=$("column_29995").value;
        if(!datebeg){
            alert("日期不能为空！请输入8位有效数字！");
            return;
        }else{
            var year=datebeg.substring(0,4);
            var month=datebeg.substring(4,6);
            var date=datebeg.substring(6,8);
            var beg=month+"/"+date+"/"+year;
            if(!this.checkIsDate(month,date,year)||!reg.test(datebeg)){
                alert("开始日期格式不对！请输入8位有效数字。");
                return;
            }
        }
        var dateend=$("column_29997").value;
        if(!dateend){
            alert("日期不能为空！请输入8位有效数字！");
            return;
        }else{
            var year1=dateend.substring(0,4);
            var month1=dateend.substring(4,6);
            var date1=dateend.substring(6,8);
            var end=month1+"/"+date1+"/"+year1;
            if(!this.checkIsDate(month1,date1,year1)||!reg.test(dateend)){
                alert("开始日期格式不对！请输入8位有效数字。");
                return;
            }
        }
        var param={"datebeg":datebeg,"dateend":dateend,"type":"export"};
        evt.param=Object.toJSON(param);
        evt.table="c_customer";
        evt.action="Export";
        evt.permission="r";
        this._executeCommandEvent(evt);
    },
    _onExport:function(e){
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        alert(Object.toJSON(ret));
    },
    fmtDate:function(date){
        return date.substring(0,4)+"-"+date.substring(4,6)+"-"+date.substring(6,8);
    },
    checkIsDate:function(month,date,year){
       if(parseInt(month,10)>12||parseInt(month,10)<1||parseInt(date,10)>31||parseInt(date,10)<1||parseInt(year,10)<1980||parseInt(year,10)>3000) {
              return false;
       }
        return true;
    },
    checkIsObject:function(o){
            return (typeof(o)=="object");
    },

    checkIsArray: function(o){
            return (this.checkIsObject(o) && (o.length) &&(!this.checkIsString(o)));
    },
    checkIsString:function(o){
        return (typeof(o)=="string");
    },
    _executeCommandEvent:function (evt) {
        Controller.handle( Object.toJSON(evt), function(r){
            var result= r.evalJSON();
            if (result.code !=0 ){
                alert(result.message);
            }else{
                var evt=new BiEvent(result.callbackEvent);
                evt.setUserData(result.data);
                application.dispatchEvent(evt);
            }
        });
    }
}
EXPORT.main=function(){
    export=new EXPORT();
}
jQuery(document).ready(EXPORT.main);
