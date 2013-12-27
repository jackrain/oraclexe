var ssv;
var SSVIEW = Class.create();
// define constructor
SSVIEW.prototype = {
	initialize: function() {
		// init dwr
		dwr.util.useLoadingMessage(gMessageHolder.LOADING);
		dwr.util.setEscapeHtml(false);
		/** A function to call if something fails. */
		dwr.engine._errorHandler =  function(message, ex) {
	  		while(ex!=null && ex.cause!=null) ex=ex.cause;
	  		if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + ", " + ex.message+","+ ex.cause.message, true);
			if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else alert(message);
		};

		this.help("/help/sshelp_welcome.html");
						
	},
	view:function(ssId){
		window.location="/html/nds/portal/portal.jsp?ss="+ssId;
	}, 
	help:function(d){
		var tgt="ssv-help"
		var url;
		if(!isNaN(d)){
			url= "/html/nds/portal/ssv/help.jsp?ss=" +d;
		}else{
			url= d;	
		}
		new Ajax.Request(url, {
		  method: 'get',
		  onSuccess: function(transport) {
		  	var pt=$(tgt);
		    pt.innerHTML=transport.responseText;
		    executeLoadedScript(pt);
		  },
		  onFailure:function(transport){
		  	//try{
		  	  	if(transport.getResponseHeader("nds.code")=="1"){
		  	  		window.location="/c/portal/login";
		  	  		return;
		  	  	}
		  	  	var exc=transport.getResponseHeader("nds.exception");
		  	  	if(exc!=null && exc.length>0){
		  	  		alert(decodeURIComponent(exc));	
		  	  	}else{
		  	  		var pt=$(tgt);
		    		pt.innerHTML=transport.responseText;
		    		executeLoadedScript(pt);
		  	  	}
		  	//}catch(e){}
		  }
		});	
	}
	
};
SSVIEW.main = function () {
	ssv=new SSVIEW();
};
jQuery(document).ready(SSVIEW.main); 

/*****add by zh*****/
function setOpacity(ele,level){
		if(ele.filters)
			ele.style.filters='alpha(opacity='+level+')';
		else
			ele.style.opacity=level/100;
	}