var inlineObject=null;
var oc;
var ObjectControl = Class.create();
ObjectControl.prototype = {
    initialize: function() {
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
        application.addEventListener( "UnsubmitObject", this._onSubmitObject, this);
        this.MAX_INPUT_LENGTH=1000;
        this._url= window.location.href;
        this._closeWindow=false;
        ObjDropMenu.init();
    },
    _onSubmitObject:function(e){
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
    doUnsubmit:function(bShouldWarn){
        if(bShouldWarn){
            if (!confirm(gMessageHolder.DO_YOU_CONFIRM_UNSUBMIT)) {
                return false;
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
    _onDeleteObject:function(e){
        var r=e.getUserData();
        if(r.code!=0){
            this._showMessage(r.message,true);
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
                if(msg!=null)msgbox(msg);
                isclosed=true;
            }
        }
        if(!isclosed){
            var body = document.getElementsByTagName("body")[0];
            if(msg==null)msg="";
            body.innerHTML="<div class='returnmsg'>"+msg+"</div>";
            window.close();
        }
    },
    _executeCommandEvent :function (evt) {
        Controller.handle( Object.toJSON(evt), function(r){
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
        });
    }
};
ObjectControl.main = function () {
    oc=new ObjectControl();
};
jQuery(document).ready(ObjectControl.main);

function popup_window(url,tgt,theWidth,theHeight){
    if(tgt==null|| tgt==undefined) tgt="_blank";
    if(theWidth==null|| theWidth==undefined) theWidth=951;
    if(theHeight==null|| theHeight==undefined) theHeight=570;
	var theTop=(screen.height/2)-(theHeight/2);
	var theLeft=(screen.width/2)-(theWidth/2);
	var features="height="+theHeight+",width="+theWidth+",top="+theTop+",left="+theLeft+",dependent=yes,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,status=yes";
    var newWindow=window.open(url,tgt,features);
    newWindow.focus();
}