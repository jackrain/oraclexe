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
		//alert(document.getElementById("note_type").value);
  /*****
		var	tab_div="<ul class=\"news\">";						
		var note_type=document.getElementById("note_type").value;	
		var ret=note_type.evalJSON();
	//alert(ret.size());
		for(var i=0;i<ret.size();i++){	
			if(i==4) tab_div+="</ul><ul class=\"news\">";
			
		  	tab_div+="<li onmouseover=\"ssv.overChangeColor("+i+");\" onmouseout=\"ssv.outChangeColor("+i+");\"><a style=\"color:#0000FF\" href=\"javascript:im.show("+i+");\" id=\"fontColor_"+i+"\"> &nbsp;{"+ret[i].typeTitle+"} "+ret[i].typeDes+"</a></li>";
		 
		}		 
   	tab_div+="</ul>";
   //alert(tab_div);
   	document.getElementById("table_div").innerHTML=tab_div;      	
  *****/
 
  
		//setInterval('im.check()',60000);
   	
   	
	},
   
   
   
	overChangeColor:function(i){
		//alert(i);
		jQuery(document.getElementById("fontColor_"+i)).css("color","red");
		},	
	outChangeColor:function(i){
		//alert(i);
		jQuery(document.getElementById("fontColor_"+i)).css("color","#0000FF");
		},
		
	view:function(ssId){
		window.location="/html/nds/portal/portal.jsp?ss="+ssId;
	}, 
	help:function(d){
		var tgt="ssv-help"
		var url;
		if(!isNaN(d)){
			url= "/html/nds/portal/ssv/help.jsp?ss="+d;
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
	},
	
	
	navigate1:function(tn,tgt){
		alert(tn+":"+tgt);
		
		if(tgt==undefined || tgt==null || tgt=='null')  tgt="portal-content";
		//support iframe, create one if not exists
	
		if(tgt=="ifr"){
			var ifr=$("ifr");
				
			if(ifr==null){
				$("portal-content").innerHTML="<iframe id='ifr' name='ifr' src='/html/js/common/null.html' width='"+this._getContentWidth()+"' height='500px' FRAMEBORDER=0 MARGINWIDTH=0 MARGINHEIGHT=0 SCROLLING='auto'>";
				ifr=$("ifr");
			}
			jQuery(ifr).load(function()
				{
					//alert("loaded iframe");
					// Set inline style to equal the body height of the iframed content.
					this.style.height = this.contentWindow.document.body.offsetHeight + 'px';
				}
			);
			ifr.src=tn;
			return;
		}
		if($(tgt)==null){
			alert( "div id="+ tgt+" not found");
			return;	
		}
		
		this._lastAccessTime= (new Date()).getTime();
		var url;
		if(tn.indexOf(".")<0){
			url= "/html/nds/portal/table.jsp?table="+tn;
		}else{
			url= tn;	
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
	},
	
	
	
	showObject1:function(url, theWidth, theHeight,option){
        if( theWidth==undefined || theWidth==null) theWidth=956;
        if( theHeight==undefined|| theHeight==null) theHeight=570;
        var options={width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE, modal:true,centerMode:"x",maxButton:true,onCenter:true};
        if(option!=undefined){
            Object.extend(options, option);
        }
        Alerts.popupIframe(url,options);
        Alerts.resizeIframe(options);
    },

    
 showNotes:function(id) {
 	var options = {width:1050,height:660,title:"窗口", modal:true,centerMode:"x",maxButton:false,onCenter:true};
	Alerts.popupIframe("/html/nds/portal/ssv/portal-min.jsp?ss=0&mm="+id,options);
	Alerts.resizeIframe(options);
	//jQuery("#MainApp").hide();
 },
  showNotes2:function(id) {  	
 	var options = {width:1000,height:660,title:"详单", modal:true,centerMode:"x",maxButton:false,onCenter:true};
	Alerts.popupIframe("/html/nds/object/object.jsp?table=u_note&id="+id,options);
	Alerts.resizeIframe(options);
	//jQuery("#MainApp").hide();
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