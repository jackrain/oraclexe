var oa;
var OAControl = Class.create();
// define constructor
OAControl.prototype = {
	initialize: function() {
		// init dwr
		
		//dwr.util.setEscapeHtml(false);
		/** A function to call if something fails. */
  
  /*ajaxController.setLoadingDiv("loadingZone");
		ajaxController._errorHandler=function(message, ex) {
	  		while(ex!=null && ex.cause!=null) ex=ex.cause;
	  		if(ex!=null)message=ex.message;
			if (message == null || message == "") msgbox("A server error has occured. More information may be available in the console.");
	  		else msgbox(message);
		};*/
		application.addEventListener( "ExecuteAudit", this._onExecuteAudit,this);
		application.addEventListener( "GotoERP",this._onGotoERP,this);
		application.addEventListener( "onClearCache", this._onClearCache,this);
	},
	_onGotoERP:function(e){
		var r=e.getUserData(); 
		if(r!=null && r.url!=null)
			window.location=r.url;
	},
	/**
	 @param e struct:
	 getUserData:
	 	code, message, id (if new), name
	*/	
	_onClearCache:function(e){
		window.location.reload(true);	
		//var chkResult=e.getUserData(); // data
		//msgbox(chkResult.message);
	},	
	_onExecuteAudit:function(e){
		var r=e.getUserData(); 
		if(r.message){
			msgbox(r.message.replace(/<br>/g,"\n"));
		}
		window.location="/html/nds/portal/portal.jsp";
		//window.location.reload(true);
	},
	clearCache:function(){
		var evt={};
		evt.command="OAManagerClearCache";
		evt.callbackEvent="onClearCache";
		this._executeCommandEvent(evt);
	},
	gotoERP:function(){
		var evt={};
		evt.command="AppAuthURL";
		evt.appname="erp";
		evt.callbackEvent="GotoERP";
		this._executeCommandEvent(evt);
	},
	/**
	 * mark all check box checked
	 */
	selectAll:function(){
		var i;
		var b= dwr.util.getValue($("chk_select_all"));
		if(this._data==null){
			this.checkAll("fm_list");
		}else{
			for(i=0;i< this._data.length;i++){
				if(["D","E","N"].indexOf(this._data[i][1])>-1) continue;
				 dwr.util.setValue($(this._data[i][0]+"_chk"), b);
				var re=$(this._data[i][0]+"_templaterow");
				if(b) re.addClassName("checked");
				else re.removeClassName("checked");
			}
		}
	},

	checkAll:function(fm){
		var ca=$("chk_select_all");
		
		ca.checked = ca.checked|0;
		var ck= ca.checked;
		var cks=$(fm).getInputs('checkbox', 'itemid');
		for(var i=0;i<cks.length;i++){
			cks[i].checked= ck;
		}
	},

	unselectall:function(){
	 	dwr.util.setValue($("chk_select_all"), false);
	},
	/**
	@param aid - au_phaseinstance.id
	*/
	auditObj:function(aid){
		
		showObject2("/html/nds/object/audit.jsp?id="+aid,{close:function(){pc.navigate('/html/nds/portal/ssv/inc_audit.jsp','audit_cox');}});
	},

	showdlg2:function(url){
		/*
		var popup = Alerts.fireMessageBox2({
				width:530,height:100,modal:true,centerMode:"xy",noCenter:true,title:"外出设置",queryindex:-1,
				onClose: function() {window.location="/html/nds/portal/ssv/index.jsp";}
			});*/
		var options=$H({queryindex:-1,padding: 0,width:530,height:200,border: true,resize:true,title:'外出设置',skin:'chrome',drag:true,lock:true,esc:true,
			close:function(){window.location="/html/nds/portal/portal.jsp";}});
		
		new Ajax.Request(url, {
		  method: 'get',
		  onSuccess: function(transport) {
			  /*
			  var pt=$(popup);
			  pt.innerHTML=transport.responseText;
			  executeLoadedScript(pt);
			  */
			  options.content=transport.responseText;
			  var par=art.dialog(options);
		  },
		  onFailure:function(transport){
		  	  	if(transport.getResponseHeader("nds.code")=="1"){
		  	  		window.location="/c/portal/login";
		  	  		return;
		  	  	}
		  	  	var exc=transport.getResponseHeader("nds.exception");
		  	  	if(exc!=null && exc.length>0){
		  	  		alert(decodeURIComponent(exc));	
		  	  	}else{
				/*var pt=$(popup);
				pt.innerHTML=transport.responseText;
				executeLoadedScript(pt);
				*/
				  options.content=transport.responseText;
				  var par=art.dialog(options);
				}
		  }
		});
		//Alerts.center();
	},
  	
  	showdlg:function(url){
		var popup = Alerts.fireMessageBox({
				width:530,height:100,modal:true,centerMode:"xy",noCenter:true,title:"外出设置",queryindex:-1,
				onClose: function() {window.location="/html/nds/portal/ssv/index.jsp";}
			});
		new Ajax.Request(url, {
		  method: 'get',
		  onSuccess: function(transport) {
		  	var pt=$(popup);
		    pt.innerHTML=transport.responseText;
		    executeLoadedScript(pt);
		  },
		  onFailure:function(transport){
		  	  	if(transport.getResponseHeader("nds.code")=="1"){
		  	  		window.location="/c/portal/login";
		  	  		return;
		  	  	}
		  	  	var exc=transport.getResponseHeader("nds.exception");
		  	  	if(exc!=null && exc.length>0){
		  	  		alert(decodeURIComponent(exc));	
		  	  	}else{
		  	  		var pt=$(popup);
		    		pt.innerHTML=transport.responseText;
		    		executeLoadedScript(pt);
		  	  	}
		  }
		});	
		Alerts.center();  	
		
  	},
	/**
	 * In audit/view.jsp
	 */
	setupAuditForm:function(act){
		var evt={};
		if(act=='assign' || act=='setout'){
		 	var v=$("assignee2").value;
	 		if (v==null || v.length==0){
	 		 	alert(gMessageHolder.PLEASE_SETUP_ASSIGNEE);
	 		 	return false;
	 		 }
	 		 evt.assignee=v;
	 	}
		evt.auditSetupAction= act;
		evt.command="AuditSetup";
		//evt["next-screen"]= "/oa/index.jsp";
		evt.callbackEvent="ExecuteAudit";
		evt["nds.control.ejb.UserTransaction"]="N";
		evt.parsejson="Y"; // to normal event 
		this._executeCommandEvent(evt);    	
	 	
	},	
	/**
	 * In audit/view.jsp
	 */
	submitAuditForm:function(act){
		var evt={};
		if(act=='assign' || act=='setout'){
		 	var v=$("assignee").value;
	 		if (v==null || v.length==0){
	 		 	alert("请选择代办人");
	 		 	$("assignee").focus();
	 		 	return false;
	 		}
	 		
	 		evt.assignee=v;
	 	}
	 	if($("auditActionType").value=="auditAction")
			evt.auditAction= act;
		else{
			evt.auditSetupAction= act;
		}
		evt.command=$("command").value;
		evt["next-screen"]= "/html/nds/portal/portal.jsp";
		evt.callbackEvent="ExecuteAudit";
		evt["nds.control.ejb.UserTransaction"]="N";
		evt.parsejson="Y"; // to normal event 
		if($("comments")!=null)evt.comments=$("comments").value;
		var itemids= $("form1").getInputs("checkbox","itemid");
		var iids=new Array();
		for(var i=0;i<itemids.length;i++ )
			if(itemids[i].checked) iids.push(itemids[i].value);
		evt.itemid= iids;
		if(iids.length==0 && (act=="accept" || act=="reject" || act=="assign")){
				alert("请勾选单据");
				return false;
		}
		this._executeCommandEvent(evt);
	 	
	},	
	submitAuditForm2:function(act){
		var evt={};
		if(act=='assign' || act=='setout'){
		 	var v=$("assignee2").value;
	 		if (v==null || v.length==0){
	 		 	alert("请选择代办人");
	 		 	$("assignee").focus();
	 		 	return false;
	 		}
	 		
	 		evt.assignee=v;
	 	}
	 	if($("auditActionType").value=="auditAction")
			evt.auditAction= act;
		else{
			evt.auditSetupAction= act;
		}
		evt.command=$("command").value;
		evt["next-screen"]= "/html/nds/portal/ssv/home.jsp";
		evt.callbackEvent="ExecuteAudit";
		evt["nds.control.ejb.UserTransaction"]="N";
		evt.parsejson="Y"; // to normal event 
		if($("comments")!=null)evt.comments=$("comments").value;
		var itemids= $("form1").getInputs("checkbox","itemid");
		var iids=new Array();
		for(var i=0;i<itemids.length;i++ )
			if(itemids[i].checked) iids.push(itemids[i].value);
		evt.itemid= iids;
		if(iids.length==0 && (act=="accept" || act=="reject" || act=="assign")){
				alert("请勾选单据");
				return false;
		}
		this._executeCommandEvent(evt);
	 	
	},
	/**
	* @param tn  table name or real url
	  @param tg, target of div to insert into, default to "portal-content"
	*/
	navigate:function(tn,tgt){
		if(tn.indexOf('@')>0){
		tgt=tn.split('@')[1];
		tn=tn.split('@')[0];
		}
		//alert(tn.split('@'))
		//alert(tgt);
		if(tgt==undefined || tgt==null || tgt=='null') tgt="portal-content";
		//support iframe, create one if not exists
		if(tgt=="ifr"){
			var ifr=$("ifr");
			if(ifr==null){
				//src='/html/js/common/null.html'
				$("portal-content").innerHTML="<iframe id='ifr' name='ifr' width='"+this._getContentWidth()+"' height='500px' FRAMEBORDER=0 MARGINWIDTH=0 MARGINHEIGHT=0 SCROLLING='auto'>";
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
	/**
	* Request server handle command event
	* @param evt CommandEvent
	*/
	_executeCommandEvent :function (evt) {
		showProgressWindow(true);
		Controller.handle(Object.toJSON(evt), function(r){
				//console.log(r);
				//try{
					var result= r.evalJSON();
					if (result.code !=0 ){
						alert(result.message);
					}else {
						
						var evt=new BiEvent(result.callbackEvent);
						if(result.data==undefined) result.data={message:result.message};
						evt.setUserData(result.data);
						application.dispatchEvent(evt);
					}
				/*}catch(ex){
					msgbox(ex.message);
				}*/
			
		});
	}

};
// define static main method
OAControl.main = function () {
	oa=new OAControl();
/*
	autoH();
	jQuery(window).resize(function(){
		autoH();
	});
*/
};

jQuery(document).ready(OAControl.main);

function msgbox(msg, title, boxType ) {
	showProgressWindow(false);
	alert(msg);
}

/**
 * Description : to adjust the div elements automatically
 * */
function autoH() {
	var targetH = jQuery(window).height()-jQuery("#topall").height()-jQuery("#ftall").height()-10;
	if(jQuery.browser.msie){
		jQuery("#oaContents").css({"height":targetH,"margin-top":4});
	}else{
		jQuery("#oaContents").css("height",targetH);
	};
	var news = jQuery(".newsbody");
	if(news.is("div")){
		news.children().css("height",(targetH-50));
	};
}

/**
* Show table object info
*/
function dlgo(tableId, objId){
	popup_window("/html/nds/object/object.jsp?table="+tableId+"&id="+objId);
}
/*
function showObject(url, theWidth, theHeight,option){
	if( theWidth==undefined || theWidth==null) theWidth=956;
    if( theHeight==undefined|| theHeight==null) theHeight=570;
	var options=$H({width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE,ifrid:'popup-iframe-0',resize:true,drag:true,lock:true,skin:'chrome',ispop:true,close:new Function('window.location="/html/nds/portal/portal.jsp";')});
	if(option!=undefined) Object.extend(options, option);
	art.dialog.open(url,options);
}

function showObject2(url,option, theWidth, theHeight){
	
	if( theWidth==undefined) theWidth=956;
    if( theHeight==undefined) theHeight=570;
    if(theWidth==-1){
    	//full screen
    	theWidth=screen.availWidth;
    	theHeight=screen.availHeight;
    }
	var options=$H({width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE,ifrid:'popup-iframe-0',resize:true,drag:true,lock:true,skin:'chrome',ispop:true,close:new Function('window.location="/html/nds/portal/portal.jsp";')});
	if(options!=undefined) options.merge(option);
	if(options.iswindow==true){
		popup_window(url,options.target, options.width,options.height);
	}else{
		//alert(options.title);
		art.dialog.open(url,options);
		//Alerts.popupIframe(url,options);
		//Alerts.resizeIframe(options);
		//Alerts.center();
	}
}
*/
function executeLoadedScript(el) {
	var scripts = el.getElementsByTagName("script"); // to enable all scripts, el must be set in table
	for (var i = 0; i < scripts.length; i++) {
		if (scripts[i].src) {
			var head = document.getElementsByTagName("head")[0];
			var scriptObj = document.createElement("script");

			scriptObj.setAttribute("type", "text/javascript");
			scriptObj.setAttribute("src", scripts[i].src);

			head.appendChild(scriptObj);
		}
		else {
			//try {
				if (is_safari) {
					eval(scripts[i].innerHTML);
				}
				else if (is_mozilla) {
					eval(scripts[i].textContent);
				}
				else {
					eval(scripts[i].text);
				}
			/*}
			catch (e) {
				alert(e);
			}*/
		}
	}
}
function showProgressWindow(bShow){
	
}
function debug(message, stacktrace){
}

function pop_up_or_clear(src, url, window_name, sObjectID){
	var oWorkItem = src;
	if ( oWorkItem.name=="popup"){
	  popup_window(url,window_name);
	}else{
	  document.getElementById(sObjectID + "_link").name="popup"; // reset to popup
	  document.getElementById(sObjectID+"_expr").value="";
	  document.getElementById(sObjectID+"_sql").value="";
	  document.getElementById(sObjectID+"_img").src=NDS_PATH+"/images/find.gif";
	  document.getElementById(sObjectID+"_img").title=gMessageHolder.OPEN_NEW_WINDOW_TO_SEARCH;
	  document.getElementById(sObjectID).value="";
	}
}
function popup_window(url,tgt,theWidth,theHeight){
    if(tgt==null|| tgt==undefined) tgt="_blank";
    if(theWidth==null|| theWidth==undefined) theWidth=951;
    if(theHeight==null|| theHeight==undefined) theHeight=570;
	var theTop=(screen.height/2)-(theHeight/2);
	var theLeft=(screen.width/2)-(theWidth/2);
	//alert(theTop+"--"+theLeft);
	var features="height="+theHeight+",width="+theWidth+",top="+theTop+",left="+theLeft+",dependent=yes,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,status=yes";
    var newWindow=window.open(url,tgt,features);
    newWindow.focus();
}



