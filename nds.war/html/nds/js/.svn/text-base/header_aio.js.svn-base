function launch_spyWin(){
  if(window.screenTop>10000){
	var theWidth=330;
	var theHeight=200;
	var theTop=(screen.height/2)-(theHeight/2);
	var theLeft=(screen.width/2)-(theWidth/2);
	var features="height="+theHeight+",width="+theWidth+",top="+theTop+",left="+theLeft+",dependent=yes,resizable=no,scrollbars=no,toolbar=no,menubar=no,status=no";
	window.open("/html/nds/common/check_close.jsp","spyWin",features);
	//spyWin = open('/html/nds/common/spywin.htm','spyWin','width=100,height=100,left=2000,top=0,status=0');
	//spyWin.blur();
  }
  return false;
}
function check_close(b){
  if(b==null|| b==undefined) b=false;	
  // since there may exists mutiple frame using top.jsp in the same window, we should check_close 
  // only for the top window
  if( window.top==window || b){
	window.onunload = launch_spyWin;
  }
}
function showDialog(url, theWidth, theHeight,refreshWindowWhenClose){
	if( theWidth==undefined) theWidth=956;
    if( theHeight==undefined) theHeight=570;
	var options={width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE, modal:true,centerMode:"x",noCenter:true,maxButton:false};
	if(refreshWindowWhenClose){
		options.onClose=refreshWindow;
	}
	Alerts.popupIframe(url,options);
	Alerts.resizeIframe(options);
	Alerts.center();
}
function btn_dialog_small(url,warning){
	if(warning!=undefined){
		if(!confirm(warning))return;
	}
	showDialog(url,620,480,true);
}
function btn_dialog_medium(url,warning){
	if(warning!=undefined){
		if(!confirm(warning))return;
	}
	showDialog(url,880,500,true);
}
function btn_dialog_window(url,warning){
	if(warning!=undefined){
		if(!confirm(warning))return;
	}
	dialog_window(url);
}
function redir_window(url,warning){
	if(warning!=undefined){
		if(!confirm(warning))return;
	}
	this.location=url;
}
function pop_self(url,warning){
	if(warning!=undefined){
		if(!confirm(warning))return;
	}
	this.location=url;
}
function pop_top(url,warning){
	if(warning!=undefined){
		if(!confirm(warning))return;
	}
	this.location=url;
}
function pop_parent(url,warning){
	if(warning!=undefined){
		if(!confirm(warning))return;
	}
	this.location=url;
}
function btnreq(url, theWidth, theHeight){
    dialog_window(url,theWidth, theHeight);
}
function refreshWindow(){
	window.location.reload();	
}
function dialog_window(url, theWidth, theHeight, refreshWindowWhenClose){
    /*if(theWidth==null|| theWidth==undefined) theWidth=400;
    if(theHeight==null|| theHeight==undefined) theHeight=200;
    var t="Dialog ";
    try{
    	t=gMessageHolder.IFRAME_TITLE;
    }catch(e){}
	var options={width:theWidth,height:theHeight,title:t,
		 modal:true,centerMode:"xy",noCenter:true,maxButton:false};
	Alerts.popupIframe(url,options);
	Alerts.resizeIframe(options);
	Alerts.center();*/
	if(theWidth==null|| theWidth==undefined) theWidth=400;
    if(theHeight==null|| theHeight==undefined) theHeight=100;
    var t="Dialog ";
    try{
    	t=gMessageHolder.IFRAME_TITLE;
    }catch(e){}
    var working="Processing...";
    try{
    	working=gMessageHolder.LOADING;
    }catch(e){}
    var msg='<center><table border="0" cellpadding="0" cellspacing="0" height="80" width="100%"><tr><td align="center" valign="middle"><br>'+
		working+'</font><br><img src="/html/nds/images/progress.gif"></td></tr></table></center>';
	var option={width: theWidth,height:theHeight,modal:true,centerMode:"none",noCenter: true,title: t,message:msg};
	if(refreshWindowWhenClose){
		option.onClose=refreshWindow;
	}
	var popup = Alerts.fireMessageBox(option);
	var evt=url.toQueryParams();
	Controller.handle( Object.toJSON(evt), function(r){
			try{
				var result= r.evalJSON();
				Alerts.killAlert($(popup));
				if(result.message){
					alert(result.message);
					try{
						// this is for button on object.jsp
					$("message_txt").innerHTML=result.message;
					$("message").style.visibility="visible";
					}catch(e){}
					
				}
				if(result.code==1){
					try{
						pc.refreshGrid();
						return;
					}catch(e){}
					try{
						oc.doRefresh();	
						return;
					}catch(e){}	
					window.location.reload();
				}else if(result.code==2){
					try{
						pc.refreshGrid();
						return;
					}catch(e){}
					try{
						oc.closeDialog();	
						return;
					}catch(e){}
					window.close();	
				}else if(result.code==3){
					try{
						gc.refreshGrid();	
						return;
					}catch(e){}
					try{
						oc.doRefresh();	
						return;
					}catch(e){}	
					window.location.reload();
				}
			}catch(exnb){
				//msgbox(exnb.message);
			}
		});	
}
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
/*function popup_window(url,tgt,theWidth,theHeight){
	var dlgw=600,dlgh=570,bPopup=false;
	var body=document.body;
	if(theWidth==null|| theWidth==undefined){
		if(body.clientWidth>dlgw+30){
			theWidth=body.clientWidth>30?body.clientWidth-30:60;
			if(theWidth>951)theWidth=951;
			bPopup=false;
		}else{
			theWidth=951;
			bPopup=true;
		}
	}else{
		if(body.clientWidth>theWidth+30) bPopup=false;
		else bPopup=true;
	}
	if(theHeight==null|| theHeight==undefined){
		if(body.clientHeight>dlgh+60) theHeight=dlgh;
		else {
			theHeight=body.clientHeight>60?body.clientHeight-60:60;
		}
	}
	try{
		var a=Alerts.OPACITY;
	}catch(e){
		bPopup=true;	
	}
	if(bPopup|| tgt=="_blank"){
		old_popup_window(url,tgt,theWidth,theHeight);
	}else{
		//dlg
		dialog_window(url,theWidth, theHeight);
	}
}
*/
function noContextMenu() {
	event.returnValue = false;
	return false;
}

 function opt_(oid){
 	window.location="/html/nds/portal/portal.jsp?table="+oid;
 }
 function opc_(oid){
 	window.location="/html/nds/objext/objects.jsp?category="+encodeURIComponent(oid);
 }

//if(/MSIE/.test(navigator.userAgent))document.attachEvent( "oncontextmenu",noContextMenu );

/*----------------------------------------------------------------------------\
| Created 2002-??-?? | All changes are in the log above. | Updated 2004-04-13 |
\----------------------------------------------------------------------------*/
var ie = /MSIE/.test(navigator.userAgent);
var moz = !ie && navigator.product == "Gecko";

/*
if (moz) {	// set up ie environment for Moz

	extendEventObject();
	//emulateAttachEvent();
	//emulateFromToElement();
	emulateEventHandlers(["click", "dblclick", "mouseover", "mouseout",
							"mousedown", "mouseup", "mousemove",
							"keydown", "keypress", "keyup"]);
	emulateDocumentAll();
	emulateElement()
	emulateCurrentStyle();

	// It is better to use a constant for event.button
	Event.LEFT = 0;
	Event.MIDDLE = 1;
	Event.RIGHT = 2;
}
else {
	Event = {};
	// IE is returning wrong button number
	Event.LEFT = 1;
	Event.MIDDLE = 4;
	Event.RIGHT = 2;
}
*/



/*
 * Extends the event object with srcElement, cancelBubble, returnValue,
 * fromElement and toElement
 */
function extendEventObject() {
	Event.prototype.__defineSetter__("returnValue", function (b) {
		if (!b) this.preventDefault();
		return b;
	});

	Event.prototype.__defineSetter__("cancelBubble", function (b) {
		if (b) this.stopPropagation();
		return b;
	});

	Event.prototype.__defineGetter__("srcElement", function () {
		var node = this.target;
		while (node!=null && node.nodeType != 1) node = node.parentNode;
		return node;
	});

	Event.prototype.__defineGetter__("fromElement", function () {
		var node;
		if (this.type == "mouseover")
			node = this.relatedTarget;
		else if (this.type == "mouseout")
			node = this.target;
		if (!node) return;
		while (node.nodeType != 1) node = node.parentNode;
		return node;
	});

	Event.prototype.__defineGetter__("toElement", function () {
		var node;
		if (this.type == "mouseout")
			node = this.relatedTarget;
		else if (this.type == "mouseover")
			node = this.target;
		if (!node) return;
		while (node.nodeType != 1) node = node.parentNode;
		return node;
	});

	Event.prototype.__defineGetter__("offsetX", function () {
		return this.layerX;
	});
	Event.prototype.__defineGetter__("offsetY", function () {
		return this.layerY;
	});
}

/*
 * Emulates element.attachEvent as well as detachEvent
 */
function emulateAttachEvent() {
	HTMLDocument.prototype.attachEvent =
	HTMLElement.prototype.attachEvent = function (sType, fHandler) {
		var shortTypeName = sType.replace(/on/, "");
		fHandler._ieEmuEventHandler = function (e) {
			window.event = e;
			return fHandler();
		};
		this.addEventListener(shortTypeName, fHandler._ieEmuEventHandler, false);
	};

	HTMLDocument.prototype.detachEvent =
	HTMLElement.prototype.detachEvent = function (sType, fHandler) {
		var shortTypeName = sType.replace(/on/, "");
		if (typeof fHandler._ieEmuEventHandler == "function")
			this.removeEventListener(shortTypeName, fHandler._ieEmuEventHandler, false);
		else
			this.removeEventListener(shortTypeName, fHandler, true);
	};
}

/*
 * This function binds the event object passed along in an
 * event to window.event
 */
function emulateEventHandlers(eventNames) {
	for (var i = 0; i < eventNames.length; i++) {
		document.addEventListener(eventNames[i], function (e) {
			window.event = e;
		}, true);	// using capture
	}
}

/*
 * Simple emulation of document.all
 * this one is far from complete. Be cautious
 */

function emulateAllModel() {
	var allGetter = function () {
		var a = this.getElementsByTagName("*");
		var node = this;
		a.tags = function (sTagName) {
			return node.getElementsByTagName(sTagName);
		};
		return a;
	};
	HTMLDocument.prototype.__defineGetter__("all", allGetter);
	HTMLElement.prototype.__defineGetter__("all", allGetter);
}

function extendElementModel() {
	HTMLElement.prototype.__defineGetter__("parentElement", function () {
		if (this.parentNode == this.ownerDocument) return null;
		return this.parentNode;
	});

	HTMLElement.prototype.__defineGetter__("children", function () {
		var tmp = [];
		var j = 0;
		var n;
		for (var i = 0; i < this.childNodes.length; i++) {
			n = this.childNodes[i];
			if (n.nodeType == 1) {
				tmp[j++] = n;
				if (n.name) {	// named children
					if (!tmp[n.name])
						tmp[n.name] = [];
					tmp[n.name][tmp[n.name].length] = n;
				}
				if (n.id)		// child with id
					tmp[n.id] = n
			}
		}
		return tmp;
	});

	HTMLElement.prototype.contains = function (oEl) {
		if (oEl == this) return true;
		if (oEl == null) return false;
		return this.contains(oEl.parentNode);
	};
}

function emulateCurrentStyle() {
	HTMLElement.prototype.__defineGetter__("currentStyle", function () {
		return this.ownerDocument.defaultView.getComputedStyle(this, null);
		/*
		var cs = {};
		var el = this;
		for (var i = 0; i < properties.length; i++) {
			cs.__defineGetter__(properties[i], encapsulateObjects(el, properties[i]));
		}
		return cs;
		*/
	});
}

function emulateHTMLModel() {

	// This function is used to generate a html string for the text properties/methods
	// It replaces '\n' with "<BR"> as well as fixes consecutive white spaces
	// It also repalaces some special characters
	function convertTextToHTML(s) {
		s = s.replace(/\&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<BR>");
		while (/\s\s/.test(s))
			s = s.replace(/\s\s/, "&nbsp; ");
		return s.replace(/\s/g, " ");
	}

	HTMLElement.prototype.insertAdjacentHTML = function (sWhere, sHTML) {
		var df;	// : DocumentFragment
		var r = this.ownerDocument.createRange();

		switch (String(sWhere).toLowerCase()) {
			case "beforebegin":
				r.setStartBefore(this);
				df = r.createContextualFragment(sHTML);
				this.parentNode.insertBefore(df, this);
				break;

			case "afterbegin":
				r.selectNodeContents(this);
				r.collapse(true);
				df = r.createContextualFragment(sHTML);
				this.insertBefore(df, this.firstChild);
				break;

			case "beforeend":
				r.selectNodeContents(this);
				r.collapse(false);
				df = r.createContextualFragment(sHTML);
				this.appendChild(df);
				break;

			case "afterend":
				r.setStartAfter(this);
				df = r.createContextualFragment(sHTML);
				this.parentNode.insertBefore(df, this.nextSibling);
				break;
		}
	};

	HTMLElement.prototype.__defineSetter__("outerHTML", function (sHTML) {
	   var r = this.ownerDocument.createRange();
	   r.setStartBefore(this);
	   var df = r.createContextualFragment(sHTML);
	   this.parentNode.replaceChild(df, this);

	   return sHTML;
	});

	HTMLElement.prototype.__defineGetter__("canHaveChildren", function () {
		switch (this.tagName) {
			case "AREA":
			case "BASE":
			case "BASEFONT":
			case "COL":
			case "FRAME":
			case "HR":
			case "IMG":
			case "BR":
			case "INPUT":
			case "ISINDEX":
			case "LINK":
			case "META":
			case "PARAM":
				return false;
		}
		return true;
	});

	HTMLElement.prototype.__defineGetter__("outerHTML", function () {
		var attr, attrs = this.attributes;
		var str = "<" + this.tagName;
		for (var i = 0; i < attrs.length; i++) {
			attr = attrs[i];
			if (attr.specified)
				str += " " + attr.name + '="' + attr.value + '"';
		}
		if (!this.canHaveChildren)
			return str + ">";

		return str + ">" + this.innerHTML + "</" + this.tagName + ">";
	});


	HTMLElement.prototype.__defineSetter__("innerText", function (sText) {
		this.innerHTML = convertTextToHTML(sText);
		return sText;
	});

	var tmpGet;
	HTMLElement.prototype.__defineGetter__("innerText", tmpGet = function () {
		var r = this.ownerDocument.createRange();
		r.selectNodeContents(this);
		return r.toString();
	});

	HTMLElement.prototype.__defineSetter__("outerText", function (sText) {
		this.outerHTML = convertTextToHTML(sText);
		return sText;
	});
	HTMLElement.prototype.__defineGetter__("outerText", tmpGet);

	HTMLElement.prototype.insertAdjacentText = function (sWhere, sText) {
		this.insertAdjacentHTML(sWhere, convertTextToHTML(sText));
	};
}

/*----------------------------------------------------------------------------\
|                                Cool Button 2                                |
|-----------------------------------------------------------------------------|
|                          Created by Erik Arvidsson                          |
|                   (http://webfx.eae.net/contact.html#erik)                  |
|                      For WebFX (http://webfx.eae.net/)                      |
|-----------------------------------------------------------------------------|
|                   Copyright (c) 2001, 2006 Erik Arvidsson                   |
|-----------------------------------------------------------------------------|
| Licensed under the Apache License, Version 2.0 (the "License"); you may not |
| use this file except in compliance with the License.  You may obtain a copy |
| of the License at http://www.apache.org/licenses/LICENSE-2.0                |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| Unless  required  by  applicable law or  agreed  to  in  writing,  software |
| distributed under the License is distributed on an  "AS IS" BASIS,  WITHOUT |
| WARRANTIES OR  CONDITIONS OF ANY KIND,  either express or implied.  See the |
| License  for the  specific language  governing permissions  and limitations |
| under the License.                                                          |
|-----------------------------------------------------------------------------|
| Dependencies: cb2.css             Cool button style declarations            |
|               ieemu.js            Required  for mozilla  support,  provides |
|                                   emulateAttachEvent and extendEventObject. |
|-----------------------------------------------------------------------------|
| 2001-03-17 | First version published.                                       |
| 2006-05-28 | Changed license to Apache Software License 2.0.                |
|-----------------------------------------------------------------------------|
| Created 2001-03-17 | All changes are in the log above. | Updated 2006-05-28 |
\----------------------------------------------------------------------------*/

/* Set up IE Emualtion for Mozilla */
if (window.moz == true && (typeof window.emulateAttachEvent != "function" || typeof window.extendEventObject != "function"))
	alert("Error! IE Emulation file not included.");

if (window.moz) {
	emulateAttachEvent();
	extendEventObject();
}
/* end Mozilla specific emulation initiation */

function createButton(el) {

	el.attachEvent("onmouseover",	createButton.overCoolButton);
	el.attachEvent("onmouseout",	createButton.outCoolButton);
	el.attachEvent("onmousedown",	createButton.downCoolButton);
	el.attachEvent("onmouseup",		createButton.upCoolButton);
	el.attachEvent("onclick",		createButton.clickCoolButton);
	el.attachEvent("ondblclick",	createButton.clickCoolButton);
	el.attachEvent("onkeypress",	createButton.keypressCoolButton);
	el.attachEvent("onkeyup",		createButton.keyupCoolButton);
	el.attachEvent("onkeydown",		createButton.keydownCoolButton);
	el.attachEvent("onfocus",		createButton.focusCoolButton);
	el.attachEvent("onblur",		createButton.blurCoolButton);
	
	el.className = "coolButton";
	
	el.setEnabled	= createButton.setEnabled;
	el.getEnabled	= createButton.getEnabled;
	el.setValue		= createButton.setValue;
	el.getValue		= createButton.getValue;
	el.setToggle	= createButton.setToggle;
	el.getToggle	= createButton.getToggle;
	el.setAlwaysUp	= createButton.setAlwaysUp;
	el.getAlwaysUp	= createButton.getAlwaysUp;
	
	el._enabled		= true;
	el._toggle		= false;
	el._value		= false;
	el._alwaysUp	= false;
	
	return el;
}

createButton.LEFT = window.moz ? 0 : 1;

/* event listeners */

createButton.overCoolButton = function () {
	var toEl = createButton.getParentCoolButton(window.event.toElement);
	var fromEl = createButton.getParentCoolButton(window.event.fromElement);
	if (toEl == fromEl || toEl == null) return;
	
	toEl._over = true;
	
	if (!toEl._enabled) return;
	
	createButton.setClassName(toEl);
};

createButton.outCoolButton = function () {
	var toEl = createButton.getParentCoolButton(window.event.toElement);
	var fromEl = createButton.getParentCoolButton(window.event.fromElement);
	if (toEl == fromEl || fromEl == null) return;
	
	fromEl._over = false;
	fromEl._down = false;
	
	if (!fromEl._enabled) return;	

	createButton.setClassName(fromEl);
};

createButton.downCoolButton = function () {
	if (window.event.button != createButton.LEFT) return;
	
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null) return;
	
	el._down = true;
	
	if (!el._enabled) return;

	createButton.setClassName(el);
};

createButton.upCoolButton = function () {
	if (window.event.button != createButton.LEFT) return;
	
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null) return;
	
	el._down = false;
	
	if (!el._enabled) return;
	
	if (el._toggle)
		el.setValue(!el._value);
	else
		createButton.setClassName(el);
};

createButton.clickCoolButton = function () {
 	var el = createButton.getParentCoolButton(window.event.srcElement);
	el.onaction = el.getAttribute("onaction");
	if (el == null || !el._enabled || el.onaction == "" || el.onaction == null) return;
	
	if (typeof el.onaction == "string")
		el.onaction = new Function ("event", el.onaction);
	
	el.onaction(window.event);
};

createButton.keypressCoolButton = function () {
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null || !el._enabled || window.event.keyCode != 13) return;
	
	el.setValue(!el._value);
	
	if (el.onaction == null) return;
	
	if (typeof el.onaction == "string")
		el.onaction = new Function ("event", el.onaction);
	
	el.onaction(window.event);
};

createButton.keydownCoolButton = function () {
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null || !el._enabled || window.event.keyCode != 32) return;
	createButton.downCoolButton();
};

createButton.keyupCoolButton = function () {
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null || !el._enabled || window.event.keyCode != 32) return;
	createButton.upCoolButton();
	
	//el.setValue(!el._value);	// is handled in upCoolButton()
	
	if (el.onaction == null) return;
	
	if (typeof el.onaction == "string")
		el.onaction = new Function ("event", el.onaction);
	
	el.onaction(window.event);
};

createButton.focusCoolButton = function () {
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null || !el._enabled) return;
	createButton.setClassName(el);
};

createButton.blurCoolButton = function () {
	var el = createButton.getParentCoolButton(window.event.srcElement);
	if (el == null) return;
	
	createButton.setClassName(el)
};

createButton.getParentCoolButton = function (el) {
	if (el == null) return null;
	if (/coolButton/.test(el.className))
		return el;
	return createButton.getParentCoolButton(el.parentNode);
};

/* end event listeners */

createButton.setClassName = function (el) {
	var over = el._over;
	var down = el._down;
	var focused;
	try {
		focused = (el == document.activeElement && el.tabIndex > 0);
	}
	catch (exc) {
		focused = false;
	}
	
	if (!el._enabled) {
		if (el._value)
			el.className = "coolButtonActiveDisabled";
		else
			el.className = el._alwaysUp ? "coolButtonUpDisabled" : "coolButtonDisabled";
	}
	else {
		if (el._value) {
			if (over || down || focused)
				el.className = "coolButtonActiveHover";
			else
				el.className = "coolButtonActive";
		}
		else {
			if (down)
				el.className = "coolButtonActiveHover";
			else if (over || el._alwaysUp || focused)
				el.className = "coolButtonHover";
			else
				el.className = "coolButton";
		}
	}
};

createButton.setEnabled = function (b) {
	if (this._enabled != b) {
		this._enabled = b;
		createButton.setClassName(this, false, false);
		if (!window.moz) {
			if (b)
				this.innerHTML = this.firstChild.firstChild.innerHTML;
			else
				this.innerHTML = "<span class='coolButtonDisabledContainer'><span class='coolButtonDisabledContainer'>" + this.innerHTML + "</span></span>";
		}
	}
};

createButton.getEnabled = function () {
	return this._enabled;
};

createButton.setValue = function (v, bDontTriggerOnChange) {
	if (this._toggle && this._value != v) {
		this._value = v;
		createButton.setClassName(this, false, false);
		
		this.onchange = this.getAttribute("onchange");
		
		if (this.onchange == null || this.onchange == "" || bDontTriggerOnChange) return;
		
		if (typeof this.onchange == "string")
			this.onchange = new Function("", this.onchange);

		this.onchange();
	}
};

createButton.getValue = function () {
	return this._value;
};

createButton.setToggle = function (t) {
	if (this._toggle != t) {
		this._toggle = t;
		if (!t) this.setValue(false);
	}
};

createButton.getToggle = function () {
	return this._toggle;
};

createButton.setAlwaysUp = function (up) {
	if (this._alwaysUp != up) {
		this._alwaysUp = up;
		createButton.setClassName(this, false, false);
	}
};

createButton.getAlwaysUp = function () {
	return this._alwaysUp;
};
var agent = navigator.userAgent.toLowerCase();

var is_ie = (agent.indexOf("msie") != -1);
var is_ie_4 = (is_ie && (agent.indexOf("msie 4") != -1));
var is_ie_5 = (is_ie && (agent.indexOf("msie 5.0") != -1));
var is_ie_5_up = (is_ie && !is_ie_4);
var is_ie_5_5 = (is_ie && (agent.indexOf("msie 5.5") != -1));
var is_ie_5_5_up = (is_ie && !is_ie_4 && !is_ie_5);
var is_ie_6 = (is_ie && (agent.indexOf("msie 6.0") != -1));
var is_ie_7 = (is_ie && (agent.indexOf("msie 7.0") != -1));

var is_mozilla = ((agent.indexOf("mozilla") != -1) && (agent.indexOf("spoofer") == -1) && (agent.indexOf("compatible") == -1) && (agent.indexOf("opera") == -1) && (agent.indexOf("webtv") == -1) && (agent.indexOf("hotjava") == -1));
var is_mozilla_1_3_up = (is_mozilla && (navigator.productSub > 20030210));

var is_ns_4 = (!is_ie && (agent.indexOf("mozilla/4.") != -1));

var is_rtf = (is_ie_5_5_up || is_mozilla_1_3_up);

var is_safari = (agent.indexOf("safari") != -1);
/*  Prototype JavaScript framework, version 1.5.1
 *  (c) 2005-2007 Sam Stephenson
 *
 *  Prototype is freely distributable under the terms of an MIT-style license.
 *  For details, see the Prototype web site: http://www.prototypejs.org/
 *
/*--------------------------------------------------------------------------*/

var Prototype = {
  Version: '1.5.1',

  Browser: {
    IE:     !!(window.attachEvent && !window.opera),
    Opera:  !!window.opera,
    WebKit: navigator.userAgent.indexOf('AppleWebKit/') > -1,
    Gecko:  navigator.userAgent.indexOf('Gecko') > -1 && navigator.userAgent.indexOf('KHTML') == -1
  },

  BrowserFeatures: {
    XPath: !!document.evaluate,
    ElementExtensions: !!window.HTMLElement,
    SpecificElementExtensions:
      (document.createElement('div').__proto__ !==
       document.createElement('form').__proto__)
  },

  ScriptFragment: '<script[^>]*>([\u0001-\uFFFF]*?)</script>',
  JSONFilter: /^\/\*-secure-\s*(.*)\s*\*\/\s*$/,

  emptyFunction: function() { },
  K: function(x) { return x }
}

var Class = {
  create: function() {
    return function() {
      this.initialize.apply(this, arguments);
    }
  }
}

var Abstract = new Object();

Object.extend = function(destination, source) {
  for (var property in source) {
    destination[property] = source[property];
  }
  return destination;
}

Object.extend(Object, {
  inspect: function(object) {
    try {
      if (object === undefined) return 'undefined';
      if (object === null) return 'null';
      return object.inspect ? object.inspect() : object.toString();
    } catch (e) {
      if (e instanceof RangeError) return '...';
      throw e;
    }
  },

  toJSON: function(object) {
    var type = typeof object;
    switch(type) {
      case 'undefined':
      case 'function':
      case 'unknown': return;
      case 'boolean': return object.toString();
    }
    if (object === null) return 'null';
    if (object.toJSON) return object.toJSON();
    if (object.ownerDocument === document) return;
    var results = [];
    for (var property in object) {
      var value = Object.toJSON(object[property]);
      if (value !== undefined)
        results.push(property.toJSON() + ': ' + value);
    }
    return '{' + results.join(', ') + '}';
  },

  keys: function(object) {
    var keys = [];
    for (var property in object)
      keys.push(property);
    return keys;
  },

  values: function(object) {
    var values = [];
    for (var property in object)
      values.push(object[property]);
    return values;
  },

  clone: function(object) {
    return Object.extend({}, object);
  }
});

Function.prototype.bind = function() {
  var __method = this, args = $A(arguments), object = args.shift();
  return function() {
    return __method.apply(object, args.concat($A(arguments)));
  }
}

Function.prototype.bindAsEventListener = function(object) {
  var __method = this, args = $A(arguments), object = args.shift();
  return function(event) {
    return __method.apply(object, [event || window.event].concat(args));
  }
}

Object.extend(Number.prototype, {
  toColorPart: function() {
    return this.toPaddedString(2, 16);
  },

  succ: function() {
    return this + 1;
  },

  times: function(iterator) {
    $R(0, this, true).each(iterator);
    return this;
  },

  toPaddedString: function(length, radix) {
    var string = this.toString(radix || 10);
    return '0'.times(length - string.length) + string;
  },

  toJSON: function() {
    return isFinite(this) ? this.toString() : 'null';
  }
});

Date.prototype.toJSON = function() {
  return '"' + this.getFullYear() + '-' +
    (this.getMonth() + 1).toPaddedString(2) + '-' +
    this.getDate().toPaddedString(2) + 'T' +
    this.getHours().toPaddedString(2) + ':' +
    this.getMinutes().toPaddedString(2) + ':' +
    this.getSeconds().toPaddedString(2) + '"';
};

var Try = {
  these: function() {
    var returnValue;

    for (var i = 0, length = arguments.length; i < length; i++) {
      var lambda = arguments[i];
      try {
        returnValue = lambda();
        break;
      } catch (e) {}
    }

    return returnValue;
  }
}

/*--------------------------------------------------------------------------*/

var PeriodicalExecuter = Class.create();
PeriodicalExecuter.prototype = {
  initialize: function(callback, frequency) {
    this.callback = callback;
    this.frequency = frequency;
    this.currentlyExecuting = false;

    this.registerCallback();
  },

  registerCallback: function() {
    this.timer = setInterval(this.onTimerEvent.bind(this), this.frequency * 1000);
  },

  stop: function() {
    if (!this.timer) return;
    clearInterval(this.timer);
    this.timer = null;
  },

  onTimerEvent: function() {
    if (!this.currentlyExecuting) {
      try {
        this.currentlyExecuting = true;
        this.callback(this);
      } finally {
        this.currentlyExecuting = false;
      }
    }
  }
}
Object.extend(String, {
  interpret: function(value) {
    return value == null ? '' : String(value);
  },
  specialChar: {
    '\b': '\\b',
    '\t': '\\t',
    '\n': '\\n',
    '\f': '\\f',
    '\r': '\\r',
    '\\': '\\\\'
  }
});

Object.extend(String.prototype, {
  gsub: function(pattern, replacement) {
    var result = '', source = this, match;
    replacement = arguments.callee.prepareReplacement(replacement);

    while (source.length > 0) {
      if (match = source.match(pattern)) {
        result += source.slice(0, match.index);
        result += String.interpret(replacement(match));
        source  = source.slice(match.index + match[0].length);
      } else {
        result += source, source = '';
      }
    }
    return result;
  },

  sub: function(pattern, replacement, count) {
    replacement = this.gsub.prepareReplacement(replacement);
    count = count === undefined ? 1 : count;

    return this.gsub(pattern, function(match) {
      if (--count < 0) return match[0];
      return replacement(match);
    });
  },

  scan: function(pattern, iterator) {
    this.gsub(pattern, iterator);
    return this;
  },

  truncate: function(length, truncation) {
    length = length || 30;
    truncation = truncation === undefined ? '...' : truncation;
    return this.length > length ?
      this.slice(0, length - truncation.length) + truncation : this;
  },

  strip: function() {
    return this.replace(/^\s+/, '').replace(/\s+$/, '');
  },

  stripTags: function() {
    return this.replace(/<\/?[^>]+>/gi, '');
  },

  stripScripts: function() {
    return this.replace(new RegExp(Prototype.ScriptFragment, 'img'), '');
  },

  extractScripts: function() {
    var matchAll = new RegExp(Prototype.ScriptFragment, 'img');
    var matchOne = new RegExp(Prototype.ScriptFragment, 'im');
    return (this.match(matchAll) || []).map(function(scriptTag) {
      return (scriptTag.match(matchOne) || ['', ''])[1];
    });
  },

  evalScripts: function() {
    return this.extractScripts().map(function(script) { return eval(script) });
  },

  escapeHTML: function() {
    var self = arguments.callee;
    self.text.data = this;
    return self.div.innerHTML;
  },

  unescapeHTML: function() {
    var div = document.createElement('div');
    div.innerHTML = this.stripTags();
    return div.childNodes[0] ? (div.childNodes.length > 1 ?
      $A(div.childNodes).inject('', function(memo, node) { return memo+node.nodeValue }) :
      div.childNodes[0].nodeValue) : '';
  },

  toQueryParams: function(separator) {
    var match = this.strip().match(/([^?#]*)(#.*)?$/);
    if (!match) return {};

    return match[1].split(separator || '&').inject({}, function(hash, pair) {
      if ((pair = pair.split('='))[0]) {
        var key = decodeURIComponent(pair.shift());
        var value = pair.length > 1 ? pair.join('=') : pair[0];
        if (value != undefined) value = decodeURIComponent(value);

        if (key in hash) {
          if (hash[key].constructor != Array) hash[key] = [hash[key]];
          hash[key].push(value);
        }
        else hash[key] = value;
      }
      return hash;
    });
  },

  toArray: function() {
    return this.split('');
  },

  succ: function() {
    return this.slice(0, this.length - 1) +
      String.fromCharCode(this.charCodeAt(this.length - 1) + 1);
  },

  times: function(count) {
    var result = '';
    for (var i = 0; i < count; i++) result += this;
    return result;
  },

  camelize: function() {
    var parts = this.split('-'), len = parts.length;
    if (len == 1) return parts[0];

    var camelized = this.charAt(0) == '-'
      ? parts[0].charAt(0).toUpperCase() + parts[0].substring(1)
      : parts[0];

    for (var i = 1; i < len; i++)
      camelized += parts[i].charAt(0).toUpperCase() + parts[i].substring(1);

    return camelized;
  },

  capitalize: function() {
    return this.charAt(0).toUpperCase() + this.substring(1).toLowerCase();
  },

  underscore: function() {
    return this.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'#{1}_#{2}').gsub(/([a-z\d])([A-Z])/,'#{1}_#{2}').gsub(/-/,'_').toLowerCase();
  },

  dasherize: function() {
    return this.gsub(/_/,'-');
  },

  inspect: function(useDoubleQuotes) {
    var escapedString = this.gsub(/[\x00-\x1f\\]/, function(match) {
      var character = String.specialChar[match[0]];
      return character ? character : '\\u00' + match[0].charCodeAt().toPaddedString(2, 16);
    });
    if (useDoubleQuotes) return '"' + escapedString.replace(/"/g, '\\"') + '"';
    return "'" + escapedString.replace(/'/g, '\\\'') + "'";
  },

  toJSON: function() {
    return this.inspect(true);
  },

  unfilterJSON: function(filter) {
    return this.sub(filter || Prototype.JSONFilter, '#{1}');
  },

  evalJSON: function(sanitize) {
    var json = this.unfilterJSON();
    try {
      if (!sanitize || (/^("(\\.|[^"\\\n\r])*?"|[,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t])+?$/.test(json)))
        return eval('(' + json + ')');
    } catch (e) { }
    throw new SyntaxError('Badly formed JSON string: ' + this.inspect());
  },

  include: function(pattern) {
    return this.indexOf(pattern) > -1;
  },

  startsWith: function(pattern) {
    return this.indexOf(pattern) === 0;
  },

  endsWith: function(pattern) {
    var d = this.length - pattern.length;
    return d >= 0 && this.lastIndexOf(pattern) === d;
  },

  empty: function() {
    return this == '';
  },

  blank: function() {
    return /^\s*$/.test(this);
  }
});

if (Prototype.Browser.WebKit || Prototype.Browser.IE) Object.extend(String.prototype, {
  escapeHTML: function() {
    return this.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
  },
  unescapeHTML: function() {
    return this.replace(/&amp;/g,'&').replace(/&lt;/g,'<').replace(/&gt;/g,'>');
  }
});

String.prototype.gsub.prepareReplacement = function(replacement) {
  if (typeof replacement == 'function') return replacement;
  var template = new Template(replacement);
  return function(match) { return template.evaluate(match) };
}

String.prototype.parseQuery = String.prototype.toQueryParams;

Object.extend(String.prototype.escapeHTML, {
  div:  document.createElement('div'),
  text: document.createTextNode('')
});

with (String.prototype.escapeHTML) div.appendChild(text);

var Template = Class.create();
Template.Pattern = /(^|.|\r|\n)(#\{(.*?)\})/;
Template.prototype = {
  initialize: function(template, pattern) {
    this.template = template.toString();
    this.pattern  = pattern || Template.Pattern;
  },

  evaluate: function(object) {
    return this.template.gsub(this.pattern, function(match) {
      var before = match[1];
      if (before == '\\') return match[2];
      return before + String.interpret(object[match[3]]);
    });
  }
}

var $break = {}, $continue = new Error('"throw $continue" is deprecated, use "return" instead');

var Enumerable = {
  each: function(iterator) {
    var index = 0;
    try {
      this._each(function(value) {
        iterator(value, index++);
      });
    } catch (e) {
      if (e != $break) throw e;
    }
    return this;
  },

  eachSlice: function(number, iterator) {
    var index = -number, slices = [], array = this.toArray();
    while ((index += number) < array.length)
      slices.push(array.slice(index, index+number));
    return slices.map(iterator);
  },

  all: function(iterator) {
    var result = true;
    this.each(function(value, index) {
      result = result && !!(iterator || Prototype.K)(value, index);
      if (!result) throw $break;
    });
    return result;
  },

  any: function(iterator) {
    var result = false;
    this.each(function(value, index) {
      if (result = !!(iterator || Prototype.K)(value, index))
        throw $break;
    });
    return result;
  },

  collect: function(iterator) {
    var results = [];
    this.each(function(value, index) {
      results.push((iterator || Prototype.K)(value, index));
    });
    return results;
  },

  detect: function(iterator) {
    var result;
    this.each(function(value, index) {
      if (iterator(value, index)) {
        result = value;
        throw $break;
      }
    });
    return result;
  },

  findAll: function(iterator) {
    var results = [];
    this.each(function(value, index) {
      if (iterator(value, index))
        results.push(value);
    });
    return results;
  },

  grep: function(pattern, iterator) {
    var results = [];
    this.each(function(value, index) {
      var stringValue = value.toString();
      if (stringValue.match(pattern))
        results.push((iterator || Prototype.K)(value, index));
    })
    return results;
  },

  include: function(object) {
    var found = false;
    this.each(function(value) {
      if (value == object) {
        found = true;
        throw $break;
      }
    });
    return found;
  },

  inGroupsOf: function(number, fillWith) {
    fillWith = fillWith === undefined ? null : fillWith;
    return this.eachSlice(number, function(slice) {
      while(slice.length < number) slice.push(fillWith);
      return slice;
    });
  },

  inject: function(memo, iterator) {
    this.each(function(value, index) {
      memo = iterator(memo, value, index);
    });
    return memo;
  },

  invoke: function(method) {
    var args = $A(arguments).slice(1);
    return this.map(function(value) {
      return value[method].apply(value, args);
    });
  },

  max: function(iterator) {
    var result;
    this.each(function(value, index) {
      value = (iterator || Prototype.K)(value, index);
      if (result == undefined || value >= result)
        result = value;
    });
    return result;
  },

  min: function(iterator) {
    var result;
    this.each(function(value, index) {
      value = (iterator || Prototype.K)(value, index);
      if (result == undefined || value < result)
        result = value;
    });
    return result;
  },

  partition: function(iterator) {
    var trues = [], falses = [];
    this.each(function(value, index) {
      ((iterator || Prototype.K)(value, index) ?
        trues : falses).push(value);
    });
    return [trues, falses];
  },

  pluck: function(property) {
    var results = [];
    this.each(function(value, index) {
      results.push(value[property]);
    });
    return results;
  },

  reject: function(iterator) {
    var results = [];
    this.each(function(value, index) {
      if (!iterator(value, index))
        results.push(value);
    });
    return results;
  },

  sortBy: function(iterator) {
    return this.map(function(value, index) {
      return {value: value, criteria: iterator(value, index)};
    }).sort(function(left, right) {
      var a = left.criteria, b = right.criteria;
      return a < b ? -1 : a > b ? 1 : 0;
    }).pluck('value');
  },

  toArray: function() {
    return this.map();
  },

  zip: function() {
    var iterator = Prototype.K, args = $A(arguments);
    if (typeof args.last() == 'function')
      iterator = args.pop();

    var collections = [this].concat(args).map($A);
    return this.map(function(value, index) {
      return iterator(collections.pluck(index));
    });
  },

  size: function() {
    return this.toArray().length;
  },

  inspect: function() {
    return '#<Enumerable:' + this.toArray().inspect() + '>';
  }
}

Object.extend(Enumerable, {
  map:     Enumerable.collect,
  find:    Enumerable.detect,
  select:  Enumerable.findAll,
  member:  Enumerable.include,
  entries: Enumerable.toArray
});
var $A = Array.from = function(iterable) {
  if (!iterable) return [];
  if (iterable.toArray) {
    return iterable.toArray();
  } else {
    var results = [];
    for (var i = 0, length = iterable.length; i < length; i++)
      results.push(iterable[i]);
    return results;
  }
}

if (Prototype.Browser.WebKit) {
  $A = Array.from = function(iterable) {
    if (!iterable) return [];
    if (!(typeof iterable == 'function' && iterable == '[object NodeList]') &&
      iterable.toArray) {
      return iterable.toArray();
    } else {
      var results = [];
      for (var i = 0, length = iterable.length; i < length; i++)
        results.push(iterable[i]);
      return results;
    }
  }
}

Object.extend(Array.prototype, Enumerable);

if (!Array.prototype._reverse)
  Array.prototype._reverse = Array.prototype.reverse;

Object.extend(Array.prototype, {
  _each: function(iterator) {
    for (var i = 0, length = this.length; i < length; i++)
      iterator(this[i]);
  },

  clear: function() {
    this.length = 0;
    return this;
  },

  first: function() {
    return this[0];
  },

  last: function() {
    return this[this.length - 1];
  },

  compact: function() {
    return this.select(function(value) {
      return value != null;
    });
  },

  flatten: function() {
    return this.inject([], function(array, value) {
      return array.concat(value && value.constructor == Array ?
        value.flatten() : [value]);
    });
  },

  without: function() {
    var values = $A(arguments);
    return this.select(function(value) {
      return !values.include(value);
    });
  },

  indexOf: function(object) {
    for (var i = 0, length = this.length; i < length; i++)
      if (this[i] == object) return i;
    return -1;
  },

  reverse: function(inline) {
    return (inline !== false ? this : this.toArray())._reverse();
  },

  reduce: function() {
    return this.length > 1 ? this : this[0];
  },

  uniq: function(sorted) {
    return this.inject([], function(array, value, index) {
      if (0 == index || (sorted ? array.last() != value : !array.include(value)))
        array.push(value);
      return array;
    });
  },

  clone: function() {
    return [].concat(this);
  },

  size: function() {
    return this.length;
  },

  inspect: function() {
    return '[' + this.map(Object.inspect).join(', ') + ']';
  },

  toJSON: function() {
    var results = [];
    this.each(function(object) {
      var value = Object.toJSON(object);
      if (value !== undefined) results.push(value);
    });
    return '[' + results.join(', ') + ']';
  }
});

Array.prototype.toArray = Array.prototype.clone;

function $w(string) {
  string = string.strip();
  return string ? string.split(/\s+/) : [];
}

if (Prototype.Browser.Opera){
  Array.prototype.concat = function() {
    var array = [];
    for (var i = 0, length = this.length; i < length; i++) array.push(this[i]);
    for (var i = 0, length = arguments.length; i < length; i++) {
      if (arguments[i].constructor == Array) {
        for (var j = 0, arrayLength = arguments[i].length; j < arrayLength; j++)
          array.push(arguments[i][j]);
      } else {
        array.push(arguments[i]);
      }
    }
    return array;
  }
}
var Hash = function(object) {
  if (object instanceof Hash) this.merge(object);
  else Object.extend(this, object || {});
};

Object.extend(Hash, {
  toQueryString: function(obj) {
    var parts = [];
    parts.add = arguments.callee.addPair;

    this.prototype._each.call(obj, function(pair) {
      if (!pair.key) return;
      var value = pair.value;

      if (value && typeof value == 'object') {
        if (value.constructor == Array) value.each(function(value) {
          parts.add(pair.key, value);
        });
        return;
      }
      parts.add(pair.key, value);
    });

    return parts.join('&');
  },

  toJSON: function(object) {
    var results = [];
    this.prototype._each.call(object, function(pair) {
      var value = Object.toJSON(pair.value);
      if (value !== undefined) results.push(pair.key.toJSON() + ': ' + value);
    });
    return '{' + results.join(', ') + '}';
  }
});

Hash.toQueryString.addPair = function(key, value, prefix) {
  key = encodeURIComponent(key);
  if (value === undefined) this.push(key);
  else this.push(key + '=' + (value == null ? '' : encodeURIComponent(value)));
}

Object.extend(Hash.prototype, Enumerable);
Object.extend(Hash.prototype, {
  _each: function(iterator) {
    for (var key in this) {
      var value = this[key];
      if (value && value == Hash.prototype[key]) continue;

      var pair = [key, value];
      pair.key = key;
      pair.value = value;
      iterator(pair);
    }
  },

  keys: function() {
    return this.pluck('key');
  },

  values: function() {
    return this.pluck('value');
  },

  merge: function(hash) {
    return $H(hash).inject(this, function(mergedHash, pair) {
      mergedHash[pair.key] = pair.value;
      return mergedHash;
    });
  },

  remove: function() {
    var result;
    for(var i = 0, length = arguments.length; i < length; i++) {
      var value = this[arguments[i]];
      if (value !== undefined){
        if (result === undefined) result = value;
        else {
          if (result.constructor != Array) result = [result];
          result.push(value)
        }
      }
      delete this[arguments[i]];
    }
    return result;
  },

  toQueryString: function() {
    return Hash.toQueryString(this);
  },

  inspect: function() {
    return '#<Hash:{' + this.map(function(pair) {
      return pair.map(Object.inspect).join(': ');
    }).join(', ') + '}>';
  },

  toJSON: function() {
    return Hash.toJSON(this);
  }
});

function $H(object) {
  if (object instanceof Hash) return object;
  return new Hash(object);
};

// Safari iterates over shadowed properties
if (function() {
  var i = 0, Test = function(value) { this.key = value };
  Test.prototype.key = 'foo';
  for (var property in new Test('bar')) i++;
  return i > 1;
}()) Hash.prototype._each = function(iterator) {
  var cache = [];
  for (var key in this) {
    var value = this[key];
    if ((value && value == Hash.prototype[key]) || cache.include(key)) continue;
    cache.push(key);
    var pair = [key, value];
    pair.key = key;
    pair.value = value;
    iterator(pair);
  }
};
ObjectRange = Class.create();
Object.extend(ObjectRange.prototype, Enumerable);
Object.extend(ObjectRange.prototype, {
  initialize: function(start, end, exclusive) {
    this.start = start;
    this.end = end;
    this.exclusive = exclusive;
  },

  _each: function(iterator) {
    var value = this.start;
    while (this.include(value)) {
      iterator(value);
      value = value.succ();
    }
  },

  include: function(value) {
    if (value < this.start)
      return false;
    if (this.exclusive)
      return value < this.end;
    return value <= this.end;
  }
});

var $R = function(start, end, exclusive) {
  return new ObjectRange(start, end, exclusive);
}

var Ajax = {
  getTransport: function() {
    return Try.these(
      function() {return new XMLHttpRequest()},
      function() {return new ActiveXObject('Msxml2.XMLHTTP')},
      function() {return new ActiveXObject('Microsoft.XMLHTTP')}
    ) || false;
  },

  activeRequestCount: 0
}

Ajax.Responders = {
  responders: [],

  _each: function(iterator) {
    this.responders._each(iterator);
  },

  register: function(responder) {
    if (!this.include(responder))
      this.responders.push(responder);
  },

  unregister: function(responder) {
    this.responders = this.responders.without(responder);
  },

  dispatch: function(callback, request, transport, json) {
    this.each(function(responder) {
      if (typeof responder[callback] == 'function') {
        try {
          responder[callback].apply(responder, [request, transport, json]);
        } catch (e) {}
      }
    });
  }
};

Object.extend(Ajax.Responders, Enumerable);

Ajax.Responders.register({
  onCreate: function() {
    Ajax.activeRequestCount++;
  },
  onComplete: function() {
    Ajax.activeRequestCount--;
  }
});

Ajax.Base = function() {};
Ajax.Base.prototype = {
  setOptions: function(options) {
    this.options = {
      method:       'post',
      asynchronous: true,
      contentType:  'application/x-www-form-urlencoded',
      encoding:     'UTF-8',
      parameters:   ''
    }
    Object.extend(this.options, options || {});

    this.options.method = this.options.method.toLowerCase();
    if (typeof this.options.parameters == 'string')
      this.options.parameters = this.options.parameters.toQueryParams();
  }
}

Ajax.Request = Class.create();
Ajax.Request.Events =
  ['Uninitialized', 'Loading', 'Loaded', 'Interactive', 'Complete'];

Ajax.Request.prototype = Object.extend(new Ajax.Base(), {
  _complete: false,

  initialize: function(url, options) {
    this.transport = Ajax.getTransport();
    this.setOptions(options);
    this.request(url);
  },

  request: function(url) {
    this.url = url;
    this.method = this.options.method;
    var params = Object.clone(this.options.parameters);

    if (!['get', 'post'].include(this.method)) {
      // simulate other verbs over post
      params['_method'] = this.method;
      this.method = 'post';
    }

    this.parameters = params;

    if (params = Hash.toQueryString(params)) {
      // when GET, append parameters to URL
      if (this.method == 'get')
        this.url += (this.url.include('?') ? '&' : '?') + params;
      else if (/Konqueror|Safari|KHTML/.test(navigator.userAgent))
        params += '&_=';
    }

    try {
      if (this.options.onCreate) this.options.onCreate(this.transport);
      Ajax.Responders.dispatch('onCreate', this, this.transport);

      this.transport.open(this.method.toUpperCase(), this.url,
        this.options.asynchronous);

      if (this.options.asynchronous)
        setTimeout(function() { this.respondToReadyState(1) }.bind(this), 10);

      this.transport.onreadystatechange = this.onStateChange.bind(this);
      this.setRequestHeaders();

      this.body = this.method == 'post' ? (this.options.postBody || params) : null;
      this.transport.send(this.body);

      /* Force Firefox to handle ready state 4 for synchronous requests */
      if (!this.options.asynchronous && this.transport.overrideMimeType)
        this.onStateChange();

    }
    catch (e) {
      this.dispatchException(e);
    }
  },

  onStateChange: function() {
    var readyState = this.transport.readyState;
    if (readyState > 1 && !((readyState == 4) && this._complete))
      this.respondToReadyState(this.transport.readyState);
  },

  setRequestHeaders: function() {
    var headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-Prototype-Version': Prototype.Version,
      'Accept': 'text/javascript, text/html, application/xml, text/xml, */*'
    };

    if (this.method == 'post') {
      headers['Content-type'] = this.options.contentType +
        (this.options.encoding ? '; charset=' + this.options.encoding : '');

      /* Force "Connection: close" for older Mozilla browsers to work
       * around a bug where XMLHttpRequest sends an incorrect
       * Content-length header. See Mozilla Bugzilla #246651.
       */
      if (this.transport.overrideMimeType &&
          (navigator.userAgent.match(/Gecko\/(\d{4})/) || [0,2005])[1] < 2005)
            headers['Connection'] = 'close';
    }

    // user-defined headers
    if (typeof this.options.requestHeaders == 'object') {
      var extras = this.options.requestHeaders;

      if (typeof extras.push == 'function')
        for (var i = 0, length = extras.length; i < length; i += 2)
          headers[extras[i]] = extras[i+1];
      else
        $H(extras).each(function(pair) { headers[pair.key] = pair.value });
    }

    for (var name in headers)
      this.transport.setRequestHeader(name, headers[name]);
  },

  success: function() {
    return !this.transport.status
        || (this.transport.status >= 200 && this.transport.status < 300);
  },

  respondToReadyState: function(readyState) {
    var state = Ajax.Request.Events[readyState];
    var transport = this.transport, json = this.evalJSON();

    if (state == 'Complete') {
      try {
        this._complete = true;
        (this.options['on' + this.transport.status]
         || this.options['on' + (this.success() ? 'Success' : 'Failure')]
         || Prototype.emptyFunction)(transport, json);
      } catch (e) {
        this.dispatchException(e);
      }

      var contentType = this.getHeader('Content-type');
      if (contentType && contentType.strip().
        match(/^(text|application)\/(x-)?(java|ecma)script(;.*)?$/i))
          this.evalResponse();
    }

    try {
      (this.options['on' + state] || Prototype.emptyFunction)(transport, json);
      Ajax.Responders.dispatch('on' + state, this, transport, json);
    } catch (e) {
      this.dispatchException(e);
    }

    if (state == 'Complete') {
      // avoid memory leak in MSIE: clean up
      this.transport.onreadystatechange = Prototype.emptyFunction;
    }
  },

  getHeader: function(name) {
    try {
      return this.transport.getResponseHeader(name);
    } catch (e) { return null }
  },

  evalJSON: function() {
    try {
      var json = this.getHeader('X-JSON');
      return json ? json.evalJSON() : null;
    } catch (e) { return null }
  },

  evalResponse: function() {
    try {
      return eval((this.transport.responseText || '').unfilterJSON());
    } catch (e) {
      this.dispatchException(e);
    }
  },

  dispatchException: function(exception) {
    (this.options.onException || Prototype.emptyFunction)(this, exception);
    Ajax.Responders.dispatch('onException', this, exception);
  }
});

Ajax.Updater = Class.create();

Object.extend(Object.extend(Ajax.Updater.prototype, Ajax.Request.prototype), {
  initialize: function(container, url, options) {
    this.container = {
      success: (container.success || container),
      failure: (container.failure || (container.success ? null : container))
    }

    this.transport = Ajax.getTransport();
    this.setOptions(options);

    var onComplete = this.options.onComplete || Prototype.emptyFunction;
    this.options.onComplete = (function(transport, param) {
      this.updateContent();
      onComplete(transport, param);
    }).bind(this);

    this.request(url);
  },

  updateContent: function() {
    var receiver = this.container[this.success() ? 'success' : 'failure'];
    var response = this.transport.responseText;

    if (!this.options.evalScripts) response = response.stripScripts();

    if (receiver = $(receiver)) {
      if (this.options.insertion)
        new this.options.insertion(receiver, response);
      else
        receiver.update(response);
    }

    if (this.success()) {
      if (this.onComplete)
        setTimeout(this.onComplete.bind(this), 10);
    }
  }
});

Ajax.PeriodicalUpdater = Class.create();
Ajax.PeriodicalUpdater.prototype = Object.extend(new Ajax.Base(), {
  initialize: function(container, url, options) {
    this.setOptions(options);
    this.onComplete = this.options.onComplete;

    this.frequency = (this.options.frequency || 2);
    this.decay = (this.options.decay || 1);

    this.updater = {};
    this.container = container;
    this.url = url;

    this.start();
  },

  start: function() {
    this.options.onComplete = this.updateComplete.bind(this);
    this.onTimerEvent();
  },

  stop: function() {
    this.updater.options.onComplete = undefined;
    clearTimeout(this.timer);
    (this.onComplete || Prototype.emptyFunction).apply(this, arguments);
  },

  updateComplete: function(request) {
    if (this.options.decay) {
      this.decay = (request.responseText == this.lastText ?
        this.decay * this.options.decay : 1);

      this.lastText = request.responseText;
    }
    this.timer = setTimeout(this.onTimerEvent.bind(this),
      this.decay * this.frequency * 1000);
  },

  onTimerEvent: function() {
    this.updater = new Ajax.Updater(this.container, this.url, this.options);
  }
});
function $(element) {
  if (arguments.length > 1) {
    for (var i = 0, elements = [], length = arguments.length; i < length; i++)
      elements.push($(arguments[i]));
    return elements;
  }
  if (typeof element == 'string')
    element = document.getElementById(element);
  return Element.extend(element);
}

if (Prototype.BrowserFeatures.XPath) {
  document._getElementsByXPath = function(expression, parentElement) {
    var results = [];
    var query = document.evaluate(expression, $(parentElement) || document,
      null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
    for (var i = 0, length = query.snapshotLength; i < length; i++)
      results.push(query.snapshotItem(i));
    return results;
  };

  document.getElementsByClassName = function(className, parentElement) {
    var q = ".//*[contains(concat(' ', @class, ' '), ' " + className + " ')]";
    return document._getElementsByXPath(q, parentElement);
  }

} else document.getElementsByClassName = function(className, parentElement) {
  var children = ($(parentElement) || document.body).getElementsByTagName('*');
  var elements = [], child;
  for (var i = 0, length = children.length; i < length; i++) {
    child = children[i];
    if (Element.hasClassName(child, className))
      elements.push(Element.extend(child));
  }
  return elements;
};

/*--------------------------------------------------------------------------*/

if (!window.Element) var Element = {};

Element.extend = function(element) {
  var F = Prototype.BrowserFeatures;
  if (!element || !element.tagName || element.nodeType == 3 ||
   element._extended || F.SpecificElementExtensions || element == window)
    return element;

  var methods = {}, tagName = element.tagName, cache = Element.extend.cache,
   T = Element.Methods.ByTag;

  // extend methods for all tags (Safari doesn't need this)
  if (!F.ElementExtensions) {
    Object.extend(methods, Element.Methods),
    Object.extend(methods, Element.Methods.Simulated);
  }

  // extend methods for specific tags
  if (T[tagName]) Object.extend(methods, T[tagName]);

  for (var property in methods) {
    var value = methods[property];
    if (typeof value == 'function' && !(property in element))
      element[property] = cache.findOrStore(value);
  }

  element._extended = Prototype.emptyFunction;
  return element;
};

Element.extend.cache = {
  findOrStore: function(value) {
    return this[value] = this[value] || function() {
      return value.apply(null, [this].concat($A(arguments)));
    }
  }
};

Element.Methods = {
  visible: function(element) {
    return $(element).style.display != 'none';
  },

  toggle: function(element) {
    element = $(element);
    Element[Element.visible(element) ? 'hide' : 'show'](element);
    return element;
  },

  hide: function(element) {
    $(element).style.display = 'none';
    return element;
  },

  show: function(element) {
    $(element).style.display = '';
    return element;
  },

  remove: function(element) {
    element = $(element);
    element.parentNode.removeChild(element);
    return element;
  },

  update: function(element, html) {
    html = typeof html == 'undefined' ? '' : html.toString();
    $(element).innerHTML = html.stripScripts();
    setTimeout(function() {html.evalScripts()}, 10);
    return element;
  },

  replace: function(element, html) {
    element = $(element);
    html = typeof html == 'undefined' ? '' : html.toString();
    if (element.outerHTML) {
      element.outerHTML = html.stripScripts();
    } else {
      var range = element.ownerDocument.createRange();
      range.selectNodeContents(element);
      element.parentNode.replaceChild(
        range.createContextualFragment(html.stripScripts()), element);
    }
    setTimeout(function() {html.evalScripts()}, 10);
    return element;
  },

  inspect: function(element) {
    element = $(element);
    var result = '<' + element.tagName.toLowerCase();
    $H({'id': 'id', 'className': 'class'}).each(function(pair) {
      var property = pair.first(), attribute = pair.last();
      var value = (element[property] || '').toString();
      if (value) result += ' ' + attribute + '=' + value.inspect(true);
    });
    return result + '>';
  },

  recursivelyCollect: function(element, property) {
    element = $(element);
    var elements = [];
    while (element = element[property])
      if (element.nodeType == 1)
        elements.push(Element.extend(element));
    return elements;
  },

  ancestors: function(element) {
    return $(element).recursivelyCollect('parentNode');
  },

  descendants: function(element) {
    return $A($(element).getElementsByTagName('*')).each(Element.extend);
  },

  firstDescendant: function(element) {
    element = $(element).firstChild;
    while (element && element.nodeType != 1) element = element.nextSibling;
    return $(element);
  },

  immediateDescendants: function(element) {
    if (!(element = $(element).firstChild)) return [];
    while (element && element.nodeType != 1) element = element.nextSibling;
    if (element) return [element].concat($(element).nextSiblings());
    return [];
  },

  previousSiblings: function(element) {
    return $(element).recursivelyCollect('previousSibling');
  },

  nextSiblings: function(element) {
    return $(element).recursivelyCollect('nextSibling');
  },

  siblings: function(element) {
    element = $(element);
    return element.previousSiblings().reverse().concat(element.nextSiblings());
  },

  match: function(element, selector) {
    if (typeof selector == 'string')
      selector = new Selector(selector);
    return selector.match($(element));
  },

  up: function(element, expression, index) {
    element = $(element);
    if (arguments.length == 1) return $(element.parentNode);
    var ancestors = element.ancestors();
    return expression ? Selector.findElement(ancestors, expression, index) :
      ancestors[index || 0];
  },

  down: function(element, expression, index) {
    element = $(element);
    if (arguments.length == 1) return element.firstDescendant();
    var descendants = element.descendants();
    return expression ? Selector.findElement(descendants, expression, index) :
      descendants[index || 0];
  },

  previous: function(element, expression, index) {
    element = $(element);
    if (arguments.length == 1) return $(Selector.handlers.previousElementSibling(element));
    var previousSiblings = element.previousSiblings();
    return expression ? Selector.findElement(previousSiblings, expression, index) :
      previousSiblings[index || 0];
  },

  next: function(element, expression, index) {
    element = $(element);
    if (arguments.length == 1) return $(Selector.handlers.nextElementSibling(element));
    var nextSiblings = element.nextSiblings();
    return expression ? Selector.findElement(nextSiblings, expression, index) :
      nextSiblings[index || 0];
  },

  getElementsBySelector: function() {
    var args = $A(arguments), element = $(args.shift());
    return Selector.findChildElements(element, args);
  },

  getElementsByClassName: function(element, className) {
    return document.getElementsByClassName(className, element);
  },

  readAttribute: function(element, name) {
    element = $(element);
    if (Prototype.Browser.IE) {
      if (!element.attributes) return null;
      var t = Element._attributeTranslations;
      if (t.values[name]) return t.values[name](element, name);
      if (t.names[name])  name = t.names[name];
      var attribute = element.attributes[name];
      return attribute ? attribute.nodeValue : null;
    }
    return element.getAttribute(name);
  },

  getHeight: function(element) {
    return $(element).getDimensions().height;
  },

  getWidth: function(element) {
    return $(element).getDimensions().width;
  },

  classNames: function(element) {
    return new Element.ClassNames(element);
  },

  hasClassName: function(element, className) {
    if (!(element = $(element))) return;
    var elementClassName = element.className;
    if (elementClassName.length == 0) return false;
    if (elementClassName == className ||
        elementClassName.match(new RegExp("(^|\\s)" + className + "(\\s|$)")))
      return true;
    return false;
  },

  addClassName: function(element, className) {
    if (!(element = $(element))) return;
    Element.classNames(element).add(className);
    return element;
  },

  removeClassName: function(element, className) {
    if (!(element = $(element))) return;
    Element.classNames(element).remove(className);
    return element;
  },

  toggleClassName: function(element, className) {
    if (!(element = $(element))) return;
    Element.classNames(element)[element.hasClassName(className) ? 'remove' : 'add'](className);
    return element;
  },

  observe: function() {
    Event.observe.apply(Event, arguments);
    return $A(arguments).first();
  },

  stopObserving: function() {
    Event.stopObserving.apply(Event, arguments);
    return $A(arguments).first();
  },

  // removes whitespace-only text node children
  cleanWhitespace: function(element) {
    element = $(element);
    var node = element.firstChild;
    while (node) {
      var nextNode = node.nextSibling;
      if (node.nodeType == 3 && !/\S/.test(node.nodeValue))
        element.removeChild(node);
      node = nextNode;
    }
    return element;
  },

  empty: function(element) {
    return $(element).innerHTML.blank();
  },

  descendantOf: function(element, ancestor) {
    element = $(element), ancestor = $(ancestor);
    while (element = element.parentNode)
      if (element == ancestor) return true;
    return false;
  },

  scrollTo: function(element) {
    element = $(element);
    var pos = Position.cumulativeOffset(element);
    window.scrollTo(pos[0], pos[1]);
    return element;
  },

  getStyle: function(element, style) {
    element = $(element);
    style = style == 'float' ? 'cssFloat' : style.camelize();
    var value = element.style[style];
    if (!value) {
      var css = document.defaultView.getComputedStyle(element, null);
      value = css ? css[style] : null;
    }
    if (style == 'opacity') return value ? parseFloat(value) : 1.0;
    return value == 'auto' ? null : value;
  },

  getOpacity: function(element) {
    return $(element).getStyle('opacity');
  },

  setStyle: function(element, styles, camelized) {
    element = $(element);
    var elementStyle = element.style;

    for (var property in styles)
      if (property == 'opacity') element.setOpacity(styles[property])
      else
        elementStyle[(property == 'float' || property == 'cssFloat') ?
          (elementStyle.styleFloat === undefined ? 'cssFloat' : 'styleFloat') :
          (camelized ? property : property.camelize())] = styles[property];

    return element;
  },

  setOpacity: function(element, value) {
    element = $(element);
    element.style.opacity = (value == 1 || value === '') ? '' :
      (value < 0.00001) ? 0 : value;
    return element;
  },

  getDimensions: function(element) {
    element = $(element);
    var display = $(element).getStyle('display');
    if (display != 'none' && display != null) // Safari bug
      return {width: element.offsetWidth, height: element.offsetHeight};

    // All *Width and *Height properties give 0 on elements with display none,
    // so enable the element temporarily
    var els = element.style;
    var originalVisibility = els.visibility;
    var originalPosition = els.position;
    var originalDisplay = els.display;
    els.visibility = 'hidden';
    els.position = 'absolute';
    els.display = 'block';
    var originalWidth = element.clientWidth;
    var originalHeight = element.clientHeight;
    els.display = originalDisplay;
    els.position = originalPosition;
    els.visibility = originalVisibility;
    return {width: originalWidth, height: originalHeight};
  },

  makePositioned: function(element) {
    element = $(element);
    var pos = Element.getStyle(element, 'position');
    if (pos == 'static' || !pos) {
      element._madePositioned = true;
      element.style.position = 'relative';
      // Opera returns the offset relative to the positioning context, when an
      // element is position relative but top and left have not been defined
      if (window.opera) {
        element.style.top = 0;
        element.style.left = 0;
      }
    }
    return element;
  },

  undoPositioned: function(element) {
    element = $(element);
    if (element._madePositioned) {
      element._madePositioned = undefined;
      element.style.position =
        element.style.top =
        element.style.left =
        element.style.bottom =
        element.style.right = '';
    }
    return element;
  },

  makeClipping: function(element) {
    element = $(element);
    if (element._overflow) return element;
    element._overflow = element.style.overflow || 'auto';
    if ((Element.getStyle(element, 'overflow') || 'visible') != 'hidden')
      element.style.overflow = 'hidden';
    return element;
  },

  undoClipping: function(element) {
    element = $(element);
    if (!element._overflow) return element;
    element.style.overflow = element._overflow == 'auto' ? '' : element._overflow;
    element._overflow = null;
    return element;
  }
};

Object.extend(Element.Methods, {
  childOf: Element.Methods.descendantOf,
  childElements: Element.Methods.immediateDescendants
});

if (Prototype.Browser.Opera) {
  Element.Methods._getStyle = Element.Methods.getStyle;
  Element.Methods.getStyle = function(element, style) {
    switch(style) {
      case 'left':
      case 'top':
      case 'right':
      case 'bottom':
        if (Element._getStyle(element, 'position') == 'static') return null;
      default: return Element._getStyle(element, style);
    }
  };
}
else if (Prototype.Browser.IE) {
  Element.Methods.getStyle = function(element, style) {
    element = $(element);
    style = (style == 'float' || style == 'cssFloat') ? 'styleFloat' : style.camelize();
    var value = element.style[style];
    if (!value && element.currentStyle) value = element.currentStyle[style];

    if (style == 'opacity') {
      if (value = (element.getStyle('filter') || '').match(/alpha\(opacity=(.*)\)/))
        if (value[1]) return parseFloat(value[1]) / 100;
      return 1.0;
    }

    if (value == 'auto') {
      if ((style == 'width' || style == 'height') && (element.getStyle('display') != 'none'))
        return element['offset'+style.capitalize()] + 'px';
      return null;
    }
    return value;
  };

  Element.Methods.setOpacity = function(element, value) {
    element = $(element);
    var filter = element.getStyle('filter'), style = element.style;
    if (value == 1 || value === '') {
      style.filter = filter.replace(/alpha\([^\)]*\)/gi,'');
      return element;
    } else if (value < 0.00001) value = 0;
    style.filter = filter.replace(/alpha\([^\)]*\)/gi, '') +
      'alpha(opacity=' + (value * 100) + ')';
    return element;
  };

  // IE is missing .innerHTML support for TABLE-related elements
  Element.Methods.update = function(element, html) {
    element = $(element);
    html = typeof html == 'undefined' ? '' : html.toString();
    var tagName = element.tagName.toUpperCase();
    if (['THEAD','TBODY','TR','TD'].include(tagName)) {
      var div = document.createElement('div');
      switch (tagName) {
        case 'THEAD':
        case 'TBODY':
          div.innerHTML = '<table><tbody>' +  html.stripScripts() + '</tbody></table>';
          depth = 2;
          break;
        case 'TR':
          div.innerHTML = '<table><tbody><tr>' +  html.stripScripts() + '</tr></tbody></table>';
          depth = 3;
          break;
        case 'TD':
          div.innerHTML = '<table><tbody><tr><td>' +  html.stripScripts() + '</td></tr></tbody></table>';
          depth = 4;
      }
      $A(element.childNodes).each(function(node) { element.removeChild(node) });
      depth.times(function() { div = div.firstChild });
      $A(div.childNodes).each(function(node) { element.appendChild(node) });
    } else {
      element.innerHTML = html.stripScripts();
    }
    setTimeout(function() { html.evalScripts() }, 10);
    return element;
  }
}
else if (Prototype.Browser.Gecko) {
  Element.Methods.setOpacity = function(element, value) {
    element = $(element);
    element.style.opacity = (value == 1) ? 0.999999 :
      (value === '') ? '' : (value < 0.00001) ? 0 : value;
    return element;
  };
}

Element._attributeTranslations = {
  names: {
    colspan:   "colSpan",
    rowspan:   "rowSpan",
    valign:    "vAlign",
    datetime:  "dateTime",
    accesskey: "accessKey",
    tabindex:  "tabIndex",
    enctype:   "encType",
    maxlength: "maxLength",
    readonly:  "readOnly",
    longdesc:  "longDesc"
  },
  values: {
    _getAttr: function(element, attribute) {
      return element.getAttribute(attribute, 2);
    },
    _flag: function(element, attribute) {
      return $(element).hasAttribute(attribute) ? attribute : null;
    },
    style: function(element) {
      return element.style.cssText.toLowerCase();
    },
    title: function(element) {
      var node = element.getAttributeNode('title');
      return node.specified ? node.nodeValue : null;
    }
  }
};

(function() {
  Object.extend(this, {
    href: this._getAttr,
    src:  this._getAttr,
    type: this._getAttr,
    disabled: this._flag,
    checked:  this._flag,
    readonly: this._flag,
    multiple: this._flag
  });
}).call(Element._attributeTranslations.values);

Element.Methods.Simulated = {
  hasAttribute: function(element, attribute) {
    var t = Element._attributeTranslations, node;
    attribute = t.names[attribute] || attribute;
    node = $(element).getAttributeNode(attribute);
    return node && node.specified;
  }
};

Element.Methods.ByTag = {};

Object.extend(Element, Element.Methods);

if (!Prototype.BrowserFeatures.ElementExtensions &&
 document.createElement('div').__proto__) {
  window.HTMLElement = {};
  window.HTMLElement.prototype = document.createElement('div').__proto__;
  Prototype.BrowserFeatures.ElementExtensions = true;
}

Element.hasAttribute = function(element, attribute) {
  if (element.hasAttribute) return element.hasAttribute(attribute);
  return Element.Methods.Simulated.hasAttribute(element, attribute);
};

Element.addMethods = function(methods) {
  var F = Prototype.BrowserFeatures, T = Element.Methods.ByTag;

  if (!methods) {
    Object.extend(Form, Form.Methods);
    Object.extend(Form.Element, Form.Element.Methods);
    Object.extend(Element.Methods.ByTag, {
      "FORM":     Object.clone(Form.Methods),
      "INPUT":    Object.clone(Form.Element.Methods),
      "SELECT":   Object.clone(Form.Element.Methods),
      "TEXTAREA": Object.clone(Form.Element.Methods)
    });
  }

  if (arguments.length == 2) {
    var tagName = methods;
    methods = arguments[1];
  }

  if (!tagName) Object.extend(Element.Methods, methods || {});
  else {
    if (tagName.constructor == Array) tagName.each(extend);
    else extend(tagName);
  }

  function extend(tagName) {
    tagName = tagName.toUpperCase();
    if (!Element.Methods.ByTag[tagName])
      Element.Methods.ByTag[tagName] = {};
    Object.extend(Element.Methods.ByTag[tagName], methods);
  }

  function copy(methods, destination, onlyIfAbsent) {
    onlyIfAbsent = onlyIfAbsent || false;
    var cache = Element.extend.cache;
    for (var property in methods) {
      var value = methods[property];
      if (!onlyIfAbsent || !(property in destination))
        destination[property] = cache.findOrStore(value);
    }
  }

  function findDOMClass(tagName) {
    var klass;
    var trans = {
      "OPTGROUP": "OptGroup", "TEXTAREA": "TextArea", "P": "Paragraph",
      "FIELDSET": "FieldSet", "UL": "UList", "OL": "OList", "DL": "DList",
      "DIR": "Directory", "H1": "Heading", "H2": "Heading", "H3": "Heading",
      "H4": "Heading", "H5": "Heading", "H6": "Heading", "Q": "Quote",
      "INS": "Mod", "DEL": "Mod", "A": "Anchor", "IMG": "Image", "CAPTION":
      "TableCaption", "COL": "TableCol", "COLGROUP": "TableCol", "THEAD":
      "TableSection", "TFOOT": "TableSection", "TBODY": "TableSection", "TR":
      "TableRow", "TH": "TableCell", "TD": "TableCell", "FRAMESET":
      "FrameSet", "IFRAME": "IFrame"
    };
    if (trans[tagName]) klass = 'HTML' + trans[tagName] + 'Element';
    if (window[klass]) return window[klass];
    klass = 'HTML' + tagName + 'Element';
    if (window[klass]) return window[klass];
    klass = 'HTML' + tagName.capitalize() + 'Element';
    if (window[klass]) return window[klass];

    window[klass] = {};
    window[klass].prototype = document.createElement(tagName).__proto__;
    return window[klass];
  }

  if (F.ElementExtensions) {
    copy(Element.Methods, HTMLElement.prototype);
    copy(Element.Methods.Simulated, HTMLElement.prototype, true);
  }

  if (F.SpecificElementExtensions) {
    for (var tag in Element.Methods.ByTag) {
      var klass = findDOMClass(tag);
      if (typeof klass == "undefined") continue;
      copy(T[tag], klass.prototype);
    }
  }

  Object.extend(Element, Element.Methods);
  delete Element.ByTag;
};

var Toggle = { display: Element.toggle };

/*--------------------------------------------------------------------------*/

Abstract.Insertion = function(adjacency) {
  this.adjacency = adjacency;
}

Abstract.Insertion.prototype = {
  initialize: function(element, content) {
    this.element = $(element);
    this.content = content.stripScripts();

    if (this.adjacency && this.element.insertAdjacentHTML) {
      try {
        this.element.insertAdjacentHTML(this.adjacency, this.content);
      } catch (e) {
        var tagName = this.element.tagName.toUpperCase();
        if (['TBODY', 'TR'].include(tagName)) {
          this.insertContent(this.contentFromAnonymousTable());
        } else {
          throw e;
        }
      }
    } else {
      this.range = this.element.ownerDocument.createRange();
      if (this.initializeRange) this.initializeRange();
      this.insertContent([this.range.createContextualFragment(this.content)]);
    }

    setTimeout(function() {content.evalScripts()}, 10);
  },

  contentFromAnonymousTable: function() {
    var div = document.createElement('div');
    div.innerHTML = '<table><tbody>' + this.content + '</tbody></table>';
    return $A(div.childNodes[0].childNodes[0].childNodes);
  }
}

var Insertion = new Object();

Insertion.Before = Class.create();
Insertion.Before.prototype = Object.extend(new Abstract.Insertion('beforeBegin'), {
  initializeRange: function() {
    this.range.setStartBefore(this.element);
  },

  insertContent: function(fragments) {
    fragments.each((function(fragment) {
      this.element.parentNode.insertBefore(fragment, this.element);
    }).bind(this));
  }
});

Insertion.Top = Class.create();
Insertion.Top.prototype = Object.extend(new Abstract.Insertion('afterBegin'), {
  initializeRange: function() {
    this.range.selectNodeContents(this.element);
    this.range.collapse(true);
  },

  insertContent: function(fragments) {
    fragments.reverse(false).each((function(fragment) {
      this.element.insertBefore(fragment, this.element.firstChild);
    }).bind(this));
  }
});

Insertion.Bottom = Class.create();
Insertion.Bottom.prototype = Object.extend(new Abstract.Insertion('beforeEnd'), {
  initializeRange: function() {
    this.range.selectNodeContents(this.element);
    this.range.collapse(this.element);
  },

  insertContent: function(fragments) {
    fragments.each((function(fragment) {
      this.element.appendChild(fragment);
    }).bind(this));
  }
});

Insertion.After = Class.create();
Insertion.After.prototype = Object.extend(new Abstract.Insertion('afterEnd'), {
  initializeRange: function() {
    this.range.setStartAfter(this.element);
  },

  insertContent: function(fragments) {
    fragments.each((function(fragment) {
      this.element.parentNode.insertBefore(fragment,
        this.element.nextSibling);
    }).bind(this));
  }
});

/*--------------------------------------------------------------------------*/

Element.ClassNames = Class.create();
Element.ClassNames.prototype = {
  initialize: function(element) {
    this.element = $(element);
  },

  _each: function(iterator) {
    this.element.className.split(/\s+/).select(function(name) {
      return name.length > 0;
    })._each(iterator);
  },

  set: function(className) {
    this.element.className = className;
  },

  add: function(classNameToAdd) {
    if (this.include(classNameToAdd)) return;
    this.set($A(this).concat(classNameToAdd).join(' '));
  },

  remove: function(classNameToRemove) {
    if (!this.include(classNameToRemove)) return;
    this.set($A(this).without(classNameToRemove).join(' '));
  },

  toString: function() {
    return $A(this).join(' ');
  }
};

Object.extend(Element.ClassNames.prototype, Enumerable);
/* Portions of the Selector class are derived from Jack Slocumâ€™s DomQuery,
 * part of YUI-Ext version 0.40, distributed under the terms of an MIT-style
 * license.  Please see http://www.yui-ext.com/ for more information. */

var Selector = Class.create();

Selector.prototype = {
  initialize: function(expression) {
    this.expression = expression.strip();
    this.compileMatcher();
  },

  compileMatcher: function() {
    // Selectors with namespaced attributes can't use the XPath version
    if (Prototype.BrowserFeatures.XPath && !(/\[[\w-]*?:/).test(this.expression))
      return this.compileXPathMatcher();

    var e = this.expression, ps = Selector.patterns, h = Selector.handlers,
        c = Selector.criteria, le, p, m;

    if (Selector._cache[e]) {
      this.matcher = Selector._cache[e]; return;
    }
    this.matcher = ["this.matcher = function(root) {",
                    "var r = root, h = Selector.handlers, c = false, n;"];

    while (e && le != e && (/\S/).test(e)) {
      le = e;
      for (var i in ps) {
        p = ps[i];
        if (m = e.match(p)) {
          this.matcher.push(typeof c[i] == 'function' ? c[i](m) :
    	      new Template(c[i]).evaluate(m));
          e = e.replace(m[0], '');
          break;
        }
      }
    }

    this.matcher.push("return h.unique(n);\n}");
    eval(this.matcher.join('\n'));
    Selector._cache[this.expression] = this.matcher;
  },

  compileXPathMatcher: function() {
    var e = this.expression, ps = Selector.patterns,
        x = Selector.xpath, le,  m;

    if (Selector._cache[e]) {
      this.xpath = Selector._cache[e]; return;
    }

    this.matcher = ['.//*'];
    while (e && le != e && (/\S/).test(e)) {
      le = e;
      for (var i in ps) {
        if (m = e.match(ps[i])) {
          this.matcher.push(typeof x[i] == 'function' ? x[i](m) :
            new Template(x[i]).evaluate(m));
          e = e.replace(m[0], '');
          break;
        }
      }
    }

    this.xpath = this.matcher.join('');
    Selector._cache[this.expression] = this.xpath;
  },

  findElements: function(root) {
    root = root || document;
    if (this.xpath) return document._getElementsByXPath(this.xpath, root);
    return this.matcher(root);
  },

  match: function(element) {
    return this.findElements(document).include(element);
  },

  toString: function() {
    return this.expression;
  },

  inspect: function() {
    return "#<Selector:" + this.expression.inspect() + ">";
  }
};

Object.extend(Selector, {
  _cache: {},

  xpath: {
    descendant:   "//*",
    child:        "/*",
    adjacent:     "/following-sibling::*[1]",
    laterSibling: '/following-sibling::*',
    tagName:      function(m) {
      if (m[1] == '*') return '';
      return "[local-name()='" + m[1].toLowerCase() +
             "' or local-name()='" + m[1].toUpperCase() + "']";
    },
    className:    "[contains(concat(' ', @class, ' '), ' #{1} ')]",
    id:           "[@id='#{1}']",
    attrPresence: "[@#{1}]",
    attr: function(m) {
      m[3] = m[5] || m[6];
      return new Template(Selector.xpath.operators[m[2]]).evaluate(m);
    },
    pseudo: function(m) {
      var h = Selector.xpath.pseudos[m[1]];
      if (!h) return '';
      if (typeof h === 'function') return h(m);
      return new Template(Selector.xpath.pseudos[m[1]]).evaluate(m);
    },
    operators: {
      '=':  "[@#{1}='#{3}']",
      '!=': "[@#{1}!='#{3}']",
      '^=': "[starts-with(@#{1}, '#{3}')]",
      '$=': "[substring(@#{1}, (string-length(@#{1}) - string-length('#{3}') + 1))='#{3}']",
      '*=': "[contains(@#{1}, '#{3}')]",
      '~=': "[contains(concat(' ', @#{1}, ' '), ' #{3} ')]",
      '|=': "[contains(concat('-', @#{1}, '-'), '-#{3}-')]"
    },
    pseudos: {
      'first-child': '[not(preceding-sibling::*)]',
      'last-child':  '[not(following-sibling::*)]',
      'only-child':  '[not(preceding-sibling::* or following-sibling::*)]',
      'empty':       "[count(*) = 0 and (count(text()) = 0 or translate(text(), ' \t\r\n', '') = '')]",
      'checked':     "[@checked]",
      'disabled':    "[@disabled]",
      'enabled':     "[not(@disabled)]",
      'not': function(m) {
        var e = m[6], p = Selector.patterns,
            x = Selector.xpath, le, m, v;

        var exclusion = [];
        while (e && le != e && (/\S/).test(e)) {
          le = e;
          for (var i in p) {
            if (m = e.match(p[i])) {
              v = typeof x[i] == 'function' ? x[i](m) : new Template(x[i]).evaluate(m);
              exclusion.push("(" + v.substring(1, v.length - 1) + ")");
              e = e.replace(m[0], '');
              break;
            }
          }
        }
        return "[not(" + exclusion.join(" and ") + ")]";
      },
      'nth-child':      function(m) {
        return Selector.xpath.pseudos.nth("(count(./preceding-sibling::*) + 1) ", m);
      },
      'nth-last-child': function(m) {
        return Selector.xpath.pseudos.nth("(count(./following-sibling::*) + 1) ", m);
      },
      'nth-of-type':    function(m) {
        return Selector.xpath.pseudos.nth("position() ", m);
      },
      'nth-last-of-type': function(m) {
        return Selector.xpath.pseudos.nth("(last() + 1 - position()) ", m);
      },
      'first-of-type':  function(m) {
        m[6] = "1"; return Selector.xpath.pseudos['nth-of-type'](m);
      },
      'last-of-type':   function(m) {
        m[6] = "1"; return Selector.xpath.pseudos['nth-last-of-type'](m);
      },
      'only-of-type':   function(m) {
        var p = Selector.xpath.pseudos; return p['first-of-type'](m) + p['last-of-type'](m);
      },
      nth: function(fragment, m) {
        var mm, formula = m[6], predicate;
        if (formula == 'even') formula = '2n+0';
        if (formula == 'odd')  formula = '2n+1';
        if (mm = formula.match(/^(\d+)$/)) // digit only
          return '[' + fragment + "= " + mm[1] + ']';
        if (mm = formula.match(/^(-?\d*)?n(([+-])(\d+))?/)) { // an+b
          if (mm[1] == "-") mm[1] = -1;
          var a = mm[1] ? Number(mm[1]) : 1;
          var b = mm[2] ? Number(mm[2]) : 0;
          predicate = "[((#{fragment} - #{b}) mod #{a} = 0) and " +
          "((#{fragment} - #{b}) div #{a} >= 0)]";
          return new Template(predicate).evaluate({
            fragment: fragment, a: a, b: b });
        }
      }
    }
  },

  criteria: {
    tagName:      'n = h.tagName(n, r, "#{1}", c);   c = false;',
    className:    'n = h.className(n, r, "#{1}", c); c = false;',
    id:           'n = h.id(n, r, "#{1}", c);        c = false;',
    attrPresence: 'n = h.attrPresence(n, r, "#{1}"); c = false;',
    attr: function(m) {
      m[3] = (m[5] || m[6]);
      return new Template('n = h.attr(n, r, "#{1}", "#{3}", "#{2}"); c = false;').evaluate(m);
    },
    pseudo:       function(m) {
      if (m[6]) m[6] = m[6].replace(/"/g, '\\"');
      return new Template('n = h.pseudo(n, "#{1}", "#{6}", r, c); c = false;').evaluate(m);
    },
    descendant:   'c = "descendant";',
    child:        'c = "child";',
    adjacent:     'c = "adjacent";',
    laterSibling: 'c = "laterSibling";'
  },

  patterns: {
    // combinators must be listed first
    // (and descendant needs to be last combinator)
    laterSibling: /^\s*~\s*/,
    child:        /^\s*>\s*/,
    adjacent:     /^\s*\+\s*/,
    descendant:   /^\s/,

    // selectors follow
    tagName:      /^\s*(\*|[\w\-]+)(\b|$)?/,
    id:           /^#([\w\-\*]+)(\b|$)/,
    className:    /^\.([\w\-\*]+)(\b|$)/,
    pseudo:       /^:((first|last|nth|nth-last|only)(-child|-of-type)|empty|checked|(en|dis)abled|not)(\((.*?)\))?(\b|$|\s|(?=:))/,
    attrPresence: /^\[([\w]+)\]/,
    attr:         /\[((?:[\w-]*:)?[\w-]+)\s*(?:([!^$*~|]?=)\s*((['"])([^\]]*?)\4|([^'"][^\]]*?)))?\]/
  },

  handlers: {
    // UTILITY FUNCTIONS
    // joins two collections
    concat: function(a, b) {
      for (var i = 0, node; node = b[i]; i++)
        a.push(node);
      return a;
    },

    // marks an array of nodes for counting
    mark: function(nodes) {
      for (var i = 0, node; node = nodes[i]; i++)
        node._counted = true;
      return nodes;
    },

    unmark: function(nodes) {
      for (var i = 0, node; node = nodes[i]; i++)
        node._counted = undefined;
      return nodes;
    },

    // mark each child node with its position (for nth calls)
    // "ofType" flag indicates whether we're indexing for nth-of-type
    // rather than nth-child
    index: function(parentNode, reverse, ofType) {
      parentNode._counted = true;
      if (reverse) {
        for (var nodes = parentNode.childNodes, i = nodes.length - 1, j = 1; i >= 0; i--) {
          node = nodes[i];
          if (node.nodeType == 1 && (!ofType || node._counted)) node.nodeIndex = j++;
        }
      } else {
        for (var i = 0, j = 1, nodes = parentNode.childNodes; node = nodes[i]; i++)
          if (node.nodeType == 1 && (!ofType || node._counted)) node.nodeIndex = j++;
      }
    },

    // filters out duplicates and extends all nodes
    unique: function(nodes) {
      if (nodes.length == 0) return nodes;
      var results = [], n;
      for (var i = 0, l = nodes.length; i < l; i++)
        if (!(n = nodes[i])._counted) {
          n._counted = true;
          results.push(Element.extend(n));
        }
      return Selector.handlers.unmark(results);
    },

    // COMBINATOR FUNCTIONS
    descendant: function(nodes) {
      var h = Selector.handlers;
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        h.concat(results, node.getElementsByTagName('*'));
      return results;
    },

    child: function(nodes) {
      var h = Selector.handlers;
      for (var i = 0, results = [], node; node = nodes[i]; i++) {
        for (var j = 0, children = [], child; child = node.childNodes[j]; j++)
          if (child.nodeType == 1 && child.tagName != '!') results.push(child);
      }
      return results;
    },

    adjacent: function(nodes) {
      for (var i = 0, results = [], node; node = nodes[i]; i++) {
        var next = this.nextElementSibling(node);
        if (next) results.push(next);
      }
      return results;
    },

    laterSibling: function(nodes) {
      var h = Selector.handlers;
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        h.concat(results, Element.nextSiblings(node));
      return results;
    },

    nextElementSibling: function(node) {
      while (node = node.nextSibling)
	      if (node.nodeType == 1) return node;
      return null;
    },

    previousElementSibling: function(node) {
      while (node = node.previousSibling)
        if (node.nodeType == 1) return node;
      return null;
    },

    // TOKEN FUNCTIONS
    tagName: function(nodes, root, tagName, combinator) {
      tagName = tagName.toUpperCase();
      var results = [], h = Selector.handlers;
      if (nodes) {
        if (combinator) {
          // fastlane for ordinary descendant combinators
          if (combinator == "descendant") {
            for (var i = 0, node; node = nodes[i]; i++)
              h.concat(results, node.getElementsByTagName(tagName));
            return results;
          } else nodes = this[combinator](nodes);
          if (tagName == "*") return nodes;
        }
        for (var i = 0, node; node = nodes[i]; i++)
          if (node.tagName.toUpperCase() == tagName) results.push(node);
        return results;
      } else return root.getElementsByTagName(tagName);
    },

    id: function(nodes, root, id, combinator) {
      var targetNode = $(id), h = Selector.handlers;
      if (!nodes && root == document) return targetNode ? [targetNode] : [];
      if (nodes) {
        if (combinator) {
          if (combinator == 'child') {
            for (var i = 0, node; node = nodes[i]; i++)
              if (targetNode.parentNode == node) return [targetNode];
          } else if (combinator == 'descendant') {
            for (var i = 0, node; node = nodes[i]; i++)
              if (Element.descendantOf(targetNode, node)) return [targetNode];
          } else if (combinator == 'adjacent') {
            for (var i = 0, node; node = nodes[i]; i++)
              if (Selector.handlers.previousElementSibling(targetNode) == node)
                return [targetNode];
          } else nodes = h[combinator](nodes);
        }
        for (var i = 0, node; node = nodes[i]; i++)
          if (node == targetNode) return [targetNode];
        return [];
      }
      return (targetNode && Element.descendantOf(targetNode, root)) ? [targetNode] : [];
    },

    className: function(nodes, root, className, combinator) {
      if (nodes && combinator) nodes = this[combinator](nodes);
      return Selector.handlers.byClassName(nodes, root, className);
    },

    byClassName: function(nodes, root, className) {
      if (!nodes) nodes = Selector.handlers.descendant([root]);
      var needle = ' ' + className + ' ';
      for (var i = 0, results = [], node, nodeClassName; node = nodes[i]; i++) {
        nodeClassName = node.className;
        if (nodeClassName.length == 0) continue;
        if (nodeClassName == className || (' ' + nodeClassName + ' ').include(needle))
          results.push(node);
      }
      return results;
    },

    attrPresence: function(nodes, root, attr) {
      var results = [];
      for (var i = 0, node; node = nodes[i]; i++)
        if (Element.hasAttribute(node, attr)) results.push(node);
      return results;
    },

    attr: function(nodes, root, attr, value, operator) {
      if (!nodes) nodes = root.getElementsByTagName("*");
      var handler = Selector.operators[operator], results = [];
      for (var i = 0, node; node = nodes[i]; i++) {
        var nodeValue = Element.readAttribute(node, attr);
        if (nodeValue === null) continue;
        if (handler(nodeValue, value)) results.push(node);
      }
      return results;
    },

    pseudo: function(nodes, name, value, root, combinator) {
      if (nodes && combinator) nodes = this[combinator](nodes);
      if (!nodes) nodes = root.getElementsByTagName("*");
      return Selector.pseudos[name](nodes, value, root);
    }
  },

  pseudos: {
    'first-child': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++) {
        if (Selector.handlers.previousElementSibling(node)) continue;
          results.push(node);
      }
      return results;
    },
    'last-child': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++) {
        if (Selector.handlers.nextElementSibling(node)) continue;
          results.push(node);
      }
      return results;
    },
    'only-child': function(nodes, value, root) {
      var h = Selector.handlers;
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        if (!h.previousElementSibling(node) && !h.nextElementSibling(node))
          results.push(node);
      return results;
    },
    'nth-child':        function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, formula, root);
    },
    'nth-last-child':   function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, formula, root, true);
    },
    'nth-of-type':      function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, formula, root, false, true);
    },
    'nth-last-of-type': function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, formula, root, true, true);
    },
    'first-of-type':    function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, "1", root, false, true);
    },
    'last-of-type':     function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, "1", root, true, true);
    },
    'only-of-type':     function(nodes, formula, root) {
      var p = Selector.pseudos;
      return p['last-of-type'](p['first-of-type'](nodes, formula, root), formula, root);
    },

    // handles the an+b logic
    getIndices: function(a, b, total) {
      if (a == 0) return b > 0 ? [b] : [];
      return $R(1, total).inject([], function(memo, i) {
        if (0 == (i - b) % a && (i - b) / a >= 0) memo.push(i);
        return memo;
      });
    },

    // handles nth(-last)-child, nth(-last)-of-type, and (first|last)-of-type
    nth: function(nodes, formula, root, reverse, ofType) {
      if (nodes.length == 0) return [];
      if (formula == 'even') formula = '2n+0';
      if (formula == 'odd')  formula = '2n+1';
      var h = Selector.handlers, results = [], indexed = [], m;
      h.mark(nodes);
      for (var i = 0, node; node = nodes[i]; i++) {
        if (!node.parentNode._counted) {
          h.index(node.parentNode, reverse, ofType);
          indexed.push(node.parentNode);
        }
      }
      if (formula.match(/^\d+$/)) { // just a number
        formula = Number(formula);
        for (var i = 0, node; node = nodes[i]; i++)
          if (node.nodeIndex == formula) results.push(node);
      } else if (m = formula.match(/^(-?\d*)?n(([+-])(\d+))?/)) { // an+b
        if (m[1] == "-") m[1] = -1;
        var a = m[1] ? Number(m[1]) : 1;
        var b = m[2] ? Number(m[2]) : 0;
        var indices = Selector.pseudos.getIndices(a, b, nodes.length);
        for (var i = 0, node, l = indices.length; node = nodes[i]; i++) {
          for (var j = 0; j < l; j++)
            if (node.nodeIndex == indices[j]) results.push(node);
        }
      }
      h.unmark(nodes);
      h.unmark(indexed);
      return results;
    },

    'empty': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++) {
        // IE treats comments as element nodes
        if (node.tagName == '!' || (node.firstChild && !node.innerHTML.match(/^\s*$/))) continue;
        results.push(node);
      }
      return results;
    },

    'not': function(nodes, selector, root) {
      var h = Selector.handlers, selectorType, m;
      var exclusions = new Selector(selector).findElements(root);
      h.mark(exclusions);
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        if (!node._counted) results.push(node);
      h.unmark(exclusions);
      return results;
    },

    'enabled': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        if (!node.disabled) results.push(node);
      return results;
    },

    'disabled': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        if (node.disabled) results.push(node);
      return results;
    },

    'checked': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        if (node.checked) results.push(node);
      return results;
    }
  },

  operators: {
    '=':  function(nv, v) { return nv == v; },
    '!=': function(nv, v) { return nv != v; },
    '^=': function(nv, v) { return nv.startsWith(v); },
    '$=': function(nv, v) { return nv.endsWith(v); },
    '*=': function(nv, v) { return nv.include(v); },
    '~=': function(nv, v) { return (' ' + nv + ' ').include(' ' + v + ' '); },
    '|=': function(nv, v) { return ('-' + nv.toUpperCase() + '-').include('-' + v.toUpperCase() + '-'); }
  },

  matchElements: function(elements, expression) {
    var matches = new Selector(expression).findElements(), h = Selector.handlers;
    h.mark(matches);
    for (var i = 0, results = [], element; element = elements[i]; i++)
      if (element._counted) results.push(element);
    h.unmark(matches);
    return results;
  },

  findElement: function(elements, expression, index) {
    if (typeof expression == 'number') {
      index = expression; expression = false;
    }
    return Selector.matchElements(elements, expression || '*')[index || 0];
  },

  findChildElements: function(element, expressions) {
    var exprs = expressions.join(','), expressions = [];
    exprs.scan(/(([\w#:.~>+()\s-]+|\*|\[.*?\])+)\s*(,|$)/, function(m) {
      expressions.push(m[1].strip());
    });
    var results = [], h = Selector.handlers;
    for (var i = 0, l = expressions.length, selector; i < l; i++) {
      selector = new Selector(expressions[i].strip());
      h.concat(results, selector.findElements(element));
    }
    return (l > 1) ? h.unique(results) : results;
  }
});

function $$() {
  return Selector.findChildElements(document, $A(arguments));
}
var Form = {
  reset: function(form) {
    $(form).reset();
    return form;
  },

  serializeElements: function(elements, getHash) {
    var data = elements.inject({}, function(result, element) {
      if (!element.disabled && element.name) {
        var key = element.name, value = $(element).getValue();
        if (value != null) {
         	if (key in result) {
            if (result[key].constructor != Array) result[key] = [result[key]];
            result[key].push(value);
          }
          else result[key] = value;
        }
      }
      return result;
    });

    return getHash ? data : Hash.toQueryString(data);
  }
};

Form.Methods = {
  serialize: function(form, getHash) {
    return Form.serializeElements(Form.getElements(form), getHash);
  },

  getElements: function(form) {
    return $A($(form).getElementsByTagName('*')).inject([],
      function(elements, child) {
        if (Form.Element.Serializers[child.tagName.toLowerCase()])
          elements.push(Element.extend(child));
        return elements;
      }
    );
  },

  getInputs: function(form, typeName, name) {
    form = $(form);
    var inputs = form.getElementsByTagName('input');

    if (!typeName && !name) return $A(inputs).map(Element.extend);

    for (var i = 0, matchingInputs = [], length = inputs.length; i < length; i++) {
      var input = inputs[i];
      if ((typeName && input.type != typeName) || (name && input.name != name))
        continue;
      matchingInputs.push(Element.extend(input));
    }

    return matchingInputs;
  },

  disable: function(form) {
    form = $(form);
    Form.getElements(form).invoke('disable');
    return form;
  },

  enable: function(form) {
    form = $(form);
    Form.getElements(form).invoke('enable');
    return form;
  },

  findFirstElement: function(form) {
    return $(form).getElements().find(function(element) {
      return element.type != 'hidden' && !element.disabled &&
        ['input', 'select', 'textarea'].include(element.tagName.toLowerCase());
    });
  },

  focusFirstElement: function(form) {
    form = $(form);
    form.findFirstElement().activate();
    return form;
  },

  request: function(form, options) {
    form = $(form), options = Object.clone(options || {});

    var params = options.parameters;
    options.parameters = form.serialize(true);

    if (params) {
      if (typeof params == 'string') params = params.toQueryParams();
      Object.extend(options.parameters, params);
    }

    if (form.hasAttribute('method') && !options.method)
      options.method = form.method;

    return new Ajax.Request(form.readAttribute('action'), options);
  }
}

/*--------------------------------------------------------------------------*/

Form.Element = {
  focus: function(element) {
    $(element).focus();
    return element;
  },

  select: function(element) {
    $(element).select();
    return element;
  }
}

Form.Element.Methods = {
  serialize: function(element) {
    element = $(element);
    if (!element.disabled && element.name) {
      var value = element.getValue();
      if (value != undefined) {
        var pair = {};
        pair[element.name] = value;
        return Hash.toQueryString(pair);
      }
    }
    return '';
  },

  getValue: function(element) {
    element = $(element);
    var method = element.tagName.toLowerCase();
    return Form.Element.Serializers[method](element);
  },

  clear: function(element) {
    $(element).value = '';
    return element;
  },

  present: function(element) {
    return $(element).value != '';
  },

  activate: function(element) {
    element = $(element);
    try {
      element.focus();
      if (element.select && (element.tagName.toLowerCase() != 'input' ||
        !['button', 'reset', 'submit'].include(element.type)))
        element.select();
    } catch (e) {}
    return element;
  },

  disable: function(element) {
    element = $(element);
    element.blur();
    element.disabled = true;
    return element;
  },

  enable: function(element) {
    element = $(element);
    element.disabled = false;
    return element;
  }
}

/*--------------------------------------------------------------------------*/

var Field = Form.Element;
var $F = Form.Element.Methods.getValue;

/*--------------------------------------------------------------------------*/

Form.Element.Serializers = {
  input: function(element) {
    switch (element.type.toLowerCase()) {
      case 'checkbox':
      case 'radio':
        return Form.Element.Serializers.inputSelector(element);
      default:
        return Form.Element.Serializers.textarea(element);
    }
  },

  inputSelector: function(element) {
    return element.checked ? element.value : null;
  },

  textarea: function(element) {
    return element.value;
  },

  select: function(element) {
    return this[element.type == 'select-one' ?
      'selectOne' : 'selectMany'](element);
  },

  selectOne: function(element) {
    var index = element.selectedIndex;
    return index >= 0 ? this.optionValue(element.options[index]) : null;
  },

  selectMany: function(element) {
    var values, length = element.length;
    if (!length) return null;

    for (var i = 0, values = []; i < length; i++) {
      var opt = element.options[i];
      if (opt.selected) values.push(this.optionValue(opt));
    }
    return values;
  },

  optionValue: function(opt) {
    // extend element because hasAttribute may not be native
    return Element.extend(opt).hasAttribute('value') ? opt.value : opt.text;
  }
}

/*--------------------------------------------------------------------------*/

Abstract.TimedObserver = function() {}
Abstract.TimedObserver.prototype = {
  initialize: function(element, frequency, callback) {
    this.frequency = frequency;
    this.element   = $(element);
    this.callback  = callback;

    this.lastValue = this.getValue();
    this.registerCallback();
  },

  registerCallback: function() {
    setInterval(this.onTimerEvent.bind(this), this.frequency * 1000);
  },

  onTimerEvent: function() {
    var value = this.getValue();
    var changed = ('string' == typeof this.lastValue && 'string' == typeof value
      ? this.lastValue != value : String(this.lastValue) != String(value));
    if (changed) {
      this.callback(this.element, value);
      this.lastValue = value;
    }
  }
}

Form.Element.Observer = Class.create();
Form.Element.Observer.prototype = Object.extend(new Abstract.TimedObserver(), {
  getValue: function() {
    return Form.Element.getValue(this.element);
  }
});

Form.Observer = Class.create();
Form.Observer.prototype = Object.extend(new Abstract.TimedObserver(), {
  getValue: function() {
    return Form.serialize(this.element);
  }
});

/*--------------------------------------------------------------------------*/

Abstract.EventObserver = function() {}
Abstract.EventObserver.prototype = {
  initialize: function(element, callback) {
    this.element  = $(element);
    this.callback = callback;

    this.lastValue = this.getValue();
    if (this.element.tagName.toLowerCase() == 'form')
      this.registerFormCallbacks();
    else
      this.registerCallback(this.element);
  },

  onElementEvent: function() {
    var value = this.getValue();
    if (this.lastValue != value) {
      this.callback(this.element, value);
      this.lastValue = value;
    }
  },

  registerFormCallbacks: function() {
    Form.getElements(this.element).each(this.registerCallback.bind(this));
  },

  registerCallback: function(element) {
    if (element.type) {
      switch (element.type.toLowerCase()) {
        case 'checkbox':
        case 'radio':
          Event.observe(element, 'click', this.onElementEvent.bind(this));
          break;
        default:
          Event.observe(element, 'change', this.onElementEvent.bind(this));
          break;
      }
    }
  }
}

Form.Element.EventObserver = Class.create();
Form.Element.EventObserver.prototype = Object.extend(new Abstract.EventObserver(), {
  getValue: function() {
    return Form.Element.getValue(this.element);
  }
});

Form.EventObserver = Class.create();
Form.EventObserver.prototype = Object.extend(new Abstract.EventObserver(), {
  getValue: function() {
    return Form.serialize(this.element);
  }
});
if (!window.Event) {
  var Event = new Object();
}

Object.extend(Event, {
  KEY_BACKSPACE: 8,
  KEY_TAB:       9,
  KEY_RETURN:   13,
  KEY_ESC:      27,
  KEY_LEFT:     37,
  KEY_UP:       38,
  KEY_RIGHT:    39,
  KEY_DOWN:     40,
  KEY_DELETE:   46,
  KEY_HOME:     36,
  KEY_END:      35,
  KEY_PAGEUP:   33,
  KEY_PAGEDOWN: 34,

  element: function(event) {
    return $(event.target || event.srcElement);
  },

  isLeftClick: function(event) {
    return (((event.which) && (event.which == 1)) ||
            ((event.button) && (event.button == 1)));
  },

  pointerX: function(event) {
    return event.pageX || (event.clientX +
      (document.documentElement.scrollLeft || document.body.scrollLeft));
  },

  pointerY: function(event) {
    return event.pageY || (event.clientY +
      (document.documentElement.scrollTop || document.body.scrollTop));
  },

  stop: function(event) {
    if (event.preventDefault) {
      event.preventDefault();
      event.stopPropagation();
    } else {
      event.returnValue = false;
      event.cancelBubble = true;
    }
  },

  // find the first node with the given tagName, starting from the
  // node the event was triggered on; traverses the DOM upwards
  findElement: function(event, tagName) {
    var element = Event.element(event);
    while (element.parentNode && (!element.tagName ||
        (element.tagName.toUpperCase() != tagName.toUpperCase())))
      element = element.parentNode;
    return element;
  },

  observers: false,

  _observeAndCache: function(element, name, observer, useCapture) {
    if (!this.observers) this.observers = [];
    if (element.addEventListener) {
      this.observers.push([element, name, observer, useCapture]);
      element.addEventListener(name, observer, useCapture);
    } else if (element.attachEvent) {
      this.observers.push([element, name, observer, useCapture]);
      element.attachEvent('on' + name, observer);
    }
  },

  unloadCache: function() {
    if (!Event.observers) return;
    for (var i = 0, length = Event.observers.length; i < length; i++) {
      Event.stopObserving.apply(this, Event.observers[i]);
      Event.observers[i][0] = null;
    }
    Event.observers = false;
  },

  observe: function(element, name, observer, useCapture) {
    element = $(element);
    useCapture = useCapture || false;

    if (name == 'keypress' &&
      (Prototype.Browser.WebKit || element.attachEvent))
      name = 'keydown';

    Event._observeAndCache(element, name, observer, useCapture);
  },

  stopObserving: function(element, name, observer, useCapture) {
    element = $(element);
    useCapture = useCapture || false;

    if (name == 'keypress' &&
        (Prototype.Browser.WebKit || element.attachEvent))
      name = 'keydown';

    if (element.removeEventListener) {
      element.removeEventListener(name, observer, useCapture);
    } else if (element.detachEvent) {
      try {
        element.detachEvent('on' + name, observer);
      } catch (e) {}
    }
  }
});

/* prevent memory leaks in IE */
if (Prototype.Browser.IE)
  Event.observe(window, 'unload', Event.unloadCache, false);
var Position = {
  // set to true if needed, warning: firefox performance problems
  // NOT neeeded for page scrolling, only if draggable contained in
  // scrollable elements
  includeScrollOffsets: false,

  // must be called before calling withinIncludingScrolloffset, every time the
  // page is scrolled
  prepare: function() {
    this.deltaX =  window.pageXOffset
                || document.documentElement.scrollLeft
                || document.body.scrollLeft
                || 0;
    this.deltaY =  window.pageYOffset
                || document.documentElement.scrollTop
                || document.body.scrollTop
                || 0;
  },

  realOffset: function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.scrollTop  || 0;
      valueL += element.scrollLeft || 0;
      element = element.parentNode;
    } while (element);
    return [valueL, valueT];
  },

  cumulativeOffset: function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;
      element = element.offsetParent;
    } while (element);
    return [valueL, valueT];
  },

  positionedOffset: function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;
      element = element.offsetParent;
      if (element) {
        if(element.tagName=='BODY') break;
        var p = Element.getStyle(element, 'position');
        if (p == 'relative' || p == 'absolute') break;
      }
    } while (element);
    return [valueL, valueT];
  },

  offsetParent: function(element) {
    if (element.offsetParent) return element.offsetParent;
    if (element == document.body) return element;

    while ((element = element.parentNode) && element != document.body)
      if (Element.getStyle(element, 'position') != 'static')
        return element;

    return document.body;
  },

  // caches x/y coordinate pair to use with overlap
  within: function(element, x, y) {
    if (this.includeScrollOffsets)
      return this.withinIncludingScrolloffsets(element, x, y);
    this.xcomp = x;
    this.ycomp = y;
    this.offset = this.cumulativeOffset(element);

    return (y >= this.offset[1] &&
            y <  this.offset[1] + element.offsetHeight &&
            x >= this.offset[0] &&
            x <  this.offset[0] + element.offsetWidth);
  },

  withinIncludingScrolloffsets: function(element, x, y) {
    var offsetcache = this.realOffset(element);

    this.xcomp = x + offsetcache[0] - this.deltaX;
    this.ycomp = y + offsetcache[1] - this.deltaY;
    this.offset = this.cumulativeOffset(element);

    return (this.ycomp >= this.offset[1] &&
            this.ycomp <  this.offset[1] + element.offsetHeight &&
            this.xcomp >= this.offset[0] &&
            this.xcomp <  this.offset[0] + element.offsetWidth);
  },

  // within must be called directly before
  overlap: function(mode, element) {
    if (!mode) return 0;
    if (mode == 'vertical')
      return ((this.offset[1] + element.offsetHeight) - this.ycomp) /
        element.offsetHeight;
    if (mode == 'horizontal')
      return ((this.offset[0] + element.offsetWidth) - this.xcomp) /
        element.offsetWidth;
  },

  page: function(forElement) {
    var valueT = 0, valueL = 0;

    var element = forElement;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;

      // Safari fix
      if (element.offsetParent == document.body)
        if (Element.getStyle(element,'position')=='absolute') break;

    } while (element = element.offsetParent);

    element = forElement;
    do {
      if (!window.opera || element.tagName=='BODY') {
        valueT -= element.scrollTop  || 0;
        valueL -= element.scrollLeft || 0;
      }
    } while (element = element.parentNode);

    return [valueL, valueT];
  },

  clone: function(source, target) {
    var options = Object.extend({
      setLeft:    true,
      setTop:     true,
      setWidth:   true,
      setHeight:  true,
      offsetTop:  0,
      offsetLeft: 0
    }, arguments[2] || {})

    // find page position of source
    source = $(source);
    var p = Position.page(source);

    // find coordinate system to use
    target = $(target);
    var delta = [0, 0];
    var parent = null;
    // delta [0,0] will do fine with position: fixed elements,
    // position:absolute needs offsetParent deltas
    if (Element.getStyle(target,'position') == 'absolute') {
      parent = Position.offsetParent(target);
      delta = Position.page(parent);
    }

    // correct by body offsets (fixes Safari)
    if (parent == document.body) {
      delta[0] -= document.body.offsetLeft;
      delta[1] -= document.body.offsetTop;
    }

    // set position
    if(options.setLeft)   target.style.left  = (p[0] - delta[0] + options.offsetLeft) + 'px';
    if(options.setTop)    target.style.top   = (p[1] - delta[1] + options.offsetTop) + 'px';
    if(options.setWidth)  target.style.width = source.offsetWidth + 'px';
    if(options.setHeight) target.style.height = source.offsetHeight + 'px';
  },

  absolutize: function(element) {
    element = $(element);
    if (element.style.position == 'absolute') return;
    Position.prepare();

    var offsets = Position.positionedOffset(element);
    var top     = offsets[1];
    var left    = offsets[0];
    var width   = element.clientWidth;
    var height  = element.clientHeight;

    element._originalLeft   = left - parseFloat(element.style.left  || 0);
    element._originalTop    = top  - parseFloat(element.style.top || 0);
    element._originalWidth  = element.style.width;
    element._originalHeight = element.style.height;

    element.style.position = 'absolute';
    element.style.top    = top + 'px';
    element.style.left   = left + 'px';
    element.style.width  = width + 'px';
    element.style.height = height + 'px';
  },

  relativize: function(element) {
    element = $(element);
    if (element.style.position == 'relative') return;
    Position.prepare();

    element.style.position = 'relative';
    var top  = parseFloat(element.style.top  || 0) - (element._originalTop || 0);
    var left = parseFloat(element.style.left || 0) - (element._originalLeft || 0);

    element.style.top    = top + 'px';
    element.style.left   = left + 'px';
    element.style.height = element._originalHeight;
    element.style.width  = element._originalWidth;
  }
}

// Safari returns margins on body which is incorrect if the child is absolutely
// positioned.  For performance reasons, redefine Position.cumulativeOffset for
// KHTML/WebKit only.
if (Prototype.Browser.WebKit) {
  Position.cumulativeOffset = function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;
      if (element.offsetParent == document.body)
        if (Element.getStyle(element, 'position') == 'absolute') break;

      element = element.offsetParent;
    } while (element);

    return [valueL, valueT];
  }
}

Element.addMethods();
/*
 * jQuery 1.2.3 - New Wave Javascript
 *
 * Copyright (c) 2008 John Resig (jquery.com)
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 * $Date: 2008-02-06 00:21:25 -0500 (Wed, 06 Feb 2008) $
 * $Rev: 4663 $
 */
(function(){if(window.jQuery)var _jQuery=window.jQuery;var jQuery=window.jQuery=function(selector,context){return new jQuery.prototype.init(selector,context);};if(window.$)var _$=window.$;window.$=jQuery;var quickExpr=/^[^<]*(<(.|\s)+>)[^>]*$|^#(\w+)$/;var isSimple=/^.[^:#\[\.]*$/;jQuery.fn=jQuery.prototype={init:function(selector,context){selector=selector||document;if(selector.nodeType){this[0]=selector;this.length=1;return this;}else if(typeof selector=="string"){var match=quickExpr.exec(selector);if(match&&(match[1]||!context)){if(match[1])selector=jQuery.clean([match[1]],context);else{var elem=document.getElementById(match[3]);if(elem)if(elem.id!=match[3])return jQuery().find(selector);else{this[0]=elem;this.length=1;return this;}else
selector=[];}}else
return new jQuery(context).find(selector);}else if(jQuery.isFunction(selector))return new jQuery(document)[jQuery.fn.ready?"ready":"load"](selector);return this.setArray(selector.constructor==Array&&selector||(selector.jquery||selector.length&&selector!=window&&!selector.nodeType&&selector[0]!=undefined&&selector[0].nodeType)&&jQuery.makeArray(selector)||[selector]);},jquery:"1.2.3",size:function(){return this.length;},length:0,get:function(num){return num==undefined?jQuery.makeArray(this):this[num];},pushStack:function(elems){var ret=jQuery(elems);ret.prevObject=this;return ret;},setArray:function(elems){this.length=0;Array.prototype.push.apply(this,elems);return this;},each:function(callback,args){return jQuery.each(this,callback,args);},index:function(elem){var ret=-1;this.each(function(i){if(this==elem)ret=i;});return ret;},attr:function(name,value,type){var options=name;if(name.constructor==String)if(value==undefined)return this.length&&jQuery[type||"attr"](this[0],name)||undefined;else{options={};options[name]=value;}return this.each(function(i){for(name in options)jQuery.attr(type?this.style:this,name,jQuery.prop(this,options[name],type,i,name));});},css:function(key,value){if((key=='width'||key=='height')&&parseFloat(value)<0)value=undefined;return this.attr(key,value,"curCSS");},text:function(text){if(typeof text!="object"&&text!=null)return this.empty().append((this[0]&&this[0].ownerDocument||document).createTextNode(text));var ret="";jQuery.each(text||this,function(){jQuery.each(this.childNodes,function(){if(this.nodeType!=8)ret+=this.nodeType!=1?this.nodeValue:jQuery.fn.text([this]);});});return ret;},wrapAll:function(html){if(this[0])jQuery(html,this[0].ownerDocument).clone().insertBefore(this[0]).map(function(){var elem=this;while(elem.firstChild)elem=elem.firstChild;return elem;}).append(this);return this;},wrapInner:function(html){return this.each(function(){jQuery(this).contents().wrapAll(html);});},wrap:function(html){return this.each(function(){jQuery(this).wrapAll(html);});},append:function(){return this.domManip(arguments,true,false,function(elem){if(this.nodeType==1)this.appendChild(elem);});},prepend:function(){return this.domManip(arguments,true,true,function(elem){if(this.nodeType==1)this.insertBefore(elem,this.firstChild);});},before:function(){return this.domManip(arguments,false,false,function(elem){this.parentNode.insertBefore(elem,this);});},after:function(){return this.domManip(arguments,false,true,function(elem){this.parentNode.insertBefore(elem,this.nextSibling);});},end:function(){return this.prevObject||jQuery([]);},find:function(selector){var elems=jQuery.map(this,function(elem){return jQuery.find(selector,elem);});return this.pushStack(/[^+>] [^+>]/.test(selector)||selector.indexOf("..")>-1?jQuery.unique(elems):elems);},clone:function(events){var ret=this.map(function(){if(jQuery.browser.msie&&!jQuery.isXMLDoc(this)){var clone=this.cloneNode(true),container=document.createElement("div");container.appendChild(clone);return jQuery.clean([container.innerHTML])[0];}else
return this.cloneNode(true);});var clone=ret.find("*").andSelf().each(function(){if(this[expando]!=undefined)this[expando]=null;});if(events===true)this.find("*").andSelf().each(function(i){if(this.nodeType==3)return;var events=jQuery.data(this,"events");for(var type in events)for(var handler in events[type])jQuery.event.add(clone[i],type,events[type][handler],events[type][handler].data);});return ret;},filter:function(selector){return this.pushStack(jQuery.isFunction(selector)&&jQuery.grep(this,function(elem,i){return selector.call(elem,i);})||jQuery.multiFilter(selector,this));},not:function(selector){if(selector.constructor==String)if(isSimple.test(selector))return this.pushStack(jQuery.multiFilter(selector,this,true));else
selector=jQuery.multiFilter(selector,this);var isArrayLike=selector.length&&selector[selector.length-1]!==undefined&&!selector.nodeType;return this.filter(function(){return isArrayLike?jQuery.inArray(this,selector)<0:this!=selector;});},add:function(selector){return!selector?this:this.pushStack(jQuery.merge(this.get(),selector.constructor==String?jQuery(selector).get():selector.length!=undefined&&(!selector.nodeName||jQuery.nodeName(selector,"form"))?selector:[selector]));},is:function(selector){return selector?jQuery.multiFilter(selector,this).length>0:false;},hasClass:function(selector){return this.is("."+selector);},val:function(value){if(value==undefined){if(this.length){var elem=this[0];if(jQuery.nodeName(elem,"select")){var index=elem.selectedIndex,values=[],options=elem.options,one=elem.type=="select-one";if(index<0)return null;for(var i=one?index:0,max=one?index+1:options.length;i<max;i++){var option=options[i];if(option.selected){value=jQuery.browser.msie&&!option.attributes.value.specified?option.text:option.value;if(one)return value;values.push(value);}}return values;}else
return(this[0].value||"").replace(/\r/g,"");}return undefined;}return this.each(function(){if(this.nodeType!=1)return;if(value.constructor==Array&&/radio|checkbox/.test(this.type))this.checked=(jQuery.inArray(this.value,value)>=0||jQuery.inArray(this.name,value)>=0);else if(jQuery.nodeName(this,"select")){var values=value.constructor==Array?value:[value];jQuery("option",this).each(function(){this.selected=(jQuery.inArray(this.value,values)>=0||jQuery.inArray(this.text,values)>=0);});if(!values.length)this.selectedIndex=-1;}else
this.value=value;});},html:function(value){return value==undefined?(this.length?this[0].innerHTML:null):this.empty().append(value);},replaceWith:function(value){return this.after(value).remove();},eq:function(i){return this.slice(i,i+1);},slice:function(){return this.pushStack(Array.prototype.slice.apply(this,arguments));},map:function(callback){return this.pushStack(jQuery.map(this,function(elem,i){return callback.call(elem,i,elem);}));},andSelf:function(){return this.add(this.prevObject);},data:function(key,value){var parts=key.split(".");parts[1]=parts[1]?"."+parts[1]:"";if(value==null){var data=this.triggerHandler("getData"+parts[1]+"!",[parts[0]]);if(data==undefined&&this.length)data=jQuery.data(this[0],key);return data==null&&parts[1]?this.data(parts[0]):data;}else
return this.trigger("setData"+parts[1]+"!",[parts[0],value]).each(function(){jQuery.data(this,key,value);});},removeData:function(key){return this.each(function(){jQuery.removeData(this,key);});},domManip:function(args,table,reverse,callback){var clone=this.length>1,elems;return this.each(function(){if(!elems){elems=jQuery.clean(args,this.ownerDocument);if(reverse)elems.reverse();}var obj=this;if(table&&jQuery.nodeName(this,"table")&&jQuery.nodeName(elems[0],"tr"))obj=this.getElementsByTagName("tbody")[0]||this.appendChild(this.ownerDocument.createElement("tbody"));var scripts=jQuery([]);jQuery.each(elems,function(){var elem=clone?jQuery(this).clone(true)[0]:this;if(jQuery.nodeName(elem,"script")){scripts=scripts.add(elem);}else{if(elem.nodeType==1)scripts=scripts.add(jQuery("script",elem).remove());callback.call(obj,elem);}});scripts.each(evalScript);});}};jQuery.prototype.init.prototype=jQuery.prototype;function evalScript(i,elem){if(elem.src)jQuery.ajax({url:elem.src,async:false,dataType:"script"});else
jQuery.globalEval(elem.text||elem.textContent||elem.innerHTML||"");if(elem.parentNode)elem.parentNode.removeChild(elem);}jQuery.extend=jQuery.fn.extend=function(){var target=arguments[0]||{},i=1,length=arguments.length,deep=false,options;if(target.constructor==Boolean){deep=target;target=arguments[1]||{};i=2;}if(typeof target!="object"&&typeof target!="function")target={};if(length==1){target=this;i=0;}for(;i<length;i++)if((options=arguments[i])!=null)for(var name in options){if(target===options[name])continue;if(deep&&options[name]&&typeof options[name]=="object"&&target[name]&&!options[name].nodeType)target[name]=jQuery.extend(target[name],options[name]);else if(options[name]!=undefined)target[name]=options[name];}return target;};var expando="jQuery"+(new Date()).getTime(),uuid=0,windowData={};var exclude=/z-?index|font-?weight|opacity|zoom|line-?height/i;jQuery.extend({noConflict:function(deep){window.$=_$;if(deep)window.jQuery=_jQuery;return jQuery;},isFunction:function(fn){return!!fn&&typeof fn!="string"&&!fn.nodeName&&fn.constructor!=Array&&/function/i.test(fn+"");},isXMLDoc:function(elem){return elem.documentElement&&!elem.body||elem.tagName&&elem.ownerDocument&&!elem.ownerDocument.body;},globalEval:function(data){data=jQuery.trim(data);if(data){var head=document.getElementsByTagName("head")[0]||document.documentElement,script=document.createElement("script");script.type="text/javascript";if(jQuery.browser.msie)script.text=data;else
script.appendChild(document.createTextNode(data));head.appendChild(script);head.removeChild(script);}},nodeName:function(elem,name){return elem.nodeName&&elem.nodeName.toUpperCase()==name.toUpperCase();},cache:{},data:function(elem,name,data){elem=elem==window?windowData:elem;var id=elem[expando];if(!id)id=elem[expando]=++uuid;if(name&&!jQuery.cache[id])jQuery.cache[id]={};if(data!=undefined)jQuery.cache[id][name]=data;return name?jQuery.cache[id][name]:id;},removeData:function(elem,name){elem=elem==window?windowData:elem;var id=elem[expando];if(name){if(jQuery.cache[id]){delete jQuery.cache[id][name];name="";for(name in jQuery.cache[id])break;if(!name)jQuery.removeData(elem);}}else{try{delete elem[expando];}catch(e){if(elem.removeAttribute)elem.removeAttribute(expando);}delete jQuery.cache[id];}},each:function(object,callback,args){if(args){if(object.length==undefined){for(var name in object)if(callback.apply(object[name],args)===false)break;}else
for(var i=0,length=object.length;i<length;i++)if(callback.apply(object[i],args)===false)break;}else{if(object.length==undefined){for(var name in object)if(callback.call(object[name],name,object[name])===false)break;}else
for(var i=0,length=object.length,value=object[0];i<length&&callback.call(value,i,value)!==false;value=object[++i]){}}return object;},prop:function(elem,value,type,i,name){if(jQuery.isFunction(value))value=value.call(elem,i);return value&&value.constructor==Number&&type=="curCSS"&&!exclude.test(name)?value+"px":value;},className:{add:function(elem,classNames){jQuery.each((classNames||"").split(/\s+/),function(i,className){if(elem.nodeType==1&&!jQuery.className.has(elem.className,className))elem.className+=(elem.className?" ":"")+className;});},remove:function(elem,classNames){if(elem.nodeType==1)elem.className=classNames!=undefined?jQuery.grep(elem.className.split(/\s+/),function(className){return!jQuery.className.has(classNames,className);}).join(" "):"";},has:function(elem,className){return jQuery.inArray(className,(elem.className||elem).toString().split(/\s+/))>-1;}},swap:function(elem,options,callback){var old={};for(var name in options){old[name]=elem.style[name];elem.style[name]=options[name];}callback.call(elem);for(var name in options)elem.style[name]=old[name];},css:function(elem,name,force){if(name=="width"||name=="height"){var val,props={position:"absolute",visibility:"hidden",display:"block"},which=name=="width"?["Left","Right"]:["Top","Bottom"];function getWH(){val=name=="width"?elem.offsetWidth:elem.offsetHeight;var padding=0,border=0;jQuery.each(which,function(){padding+=parseFloat(jQuery.curCSS(elem,"padding"+this,true))||0;border+=parseFloat(jQuery.curCSS(elem,"border"+this+"Width",true))||0;});val-=Math.round(padding+border);}if(jQuery(elem).is(":visible"))getWH();else
jQuery.swap(elem,props,getWH);return Math.max(0,val);}return jQuery.curCSS(elem,name,force);},curCSS:function(elem,name,force){var ret;function color(elem){if(!jQuery.browser.safari)return false;var ret=document.defaultView.getComputedStyle(elem,null);return!ret||ret.getPropertyValue("color")=="";}if(name=="opacity"&&jQuery.browser.msie){ret=jQuery.attr(elem.style,"opacity");return ret==""?"1":ret;}if(jQuery.browser.opera&&name=="display"){var save=elem.style.outline;elem.style.outline="0 solid black";elem.style.outline=save;}if(name.match(/float/i))name=styleFloat;if(!force&&elem.style&&elem.style[name])ret=elem.style[name];else if(document.defaultView&&document.defaultView.getComputedStyle){if(name.match(/float/i))name="float";name=name.replace(/([A-Z])/g,"-$1").toLowerCase();var getComputedStyle=document.defaultView.getComputedStyle(elem,null);if(getComputedStyle&&!color(elem))ret=getComputedStyle.getPropertyValue(name);else{var swap=[],stack=[];for(var a=elem;a&&color(a);a=a.parentNode)stack.unshift(a);for(var i=0;i<stack.length;i++)if(color(stack[i])){swap[i]=stack[i].style.display;stack[i].style.display="block";}ret=name=="display"&&swap[stack.length-1]!=null?"none":(getComputedStyle&&getComputedStyle.getPropertyValue(name))||"";for(var i=0;i<swap.length;i++)if(swap[i]!=null)stack[i].style.display=swap[i];}if(name=="opacity"&&ret=="")ret="1";}else if(elem.currentStyle){var camelCase=name.replace(/\-(\w)/g,function(all,letter){return letter.toUpperCase();});ret=elem.currentStyle[name]||elem.currentStyle[camelCase];if(!/^\d+(px)?$/i.test(ret)&&/^\d/.test(ret)){var style=elem.style.left,runtimeStyle=elem.runtimeStyle.left;elem.runtimeStyle.left=elem.currentStyle.left;elem.style.left=ret||0;ret=elem.style.pixelLeft+"px";elem.style.left=style;elem.runtimeStyle.left=runtimeStyle;}}return ret;},clean:function(elems,context){var ret=[];context=context||document;if(typeof context.createElement=='undefined')context=context.ownerDocument||context[0]&&context[0].ownerDocument||document;jQuery.each(elems,function(i,elem){if(!elem)return;if(elem.constructor==Number)elem=elem.toString();if(typeof elem=="string"){elem=elem.replace(/(<(\w+)[^>]*?)\/>/g,function(all,front,tag){return tag.match(/^(abbr|br|col|img|input|link|meta|param|hr|area|embed)$/i)?all:front+"></"+tag+">";});var tags=jQuery.trim(elem).toLowerCase(),div=context.createElement("div");var wrap=!tags.indexOf("<opt")&&[1,"<select multiple='multiple'>","</select>"]||!tags.indexOf("<leg")&&[1,"<fieldset>","</fieldset>"]||tags.match(/^<(thead|tbody|tfoot|colg|cap)/)&&[1,"<table>","</table>"]||!tags.indexOf("<tr")&&[2,"<table><tbody>","</tbody></table>"]||(!tags.indexOf("<td")||!tags.indexOf("<th"))&&[3,"<table><tbody><tr>","</tr></tbody></table>"]||!tags.indexOf("<col")&&[2,"<table><tbody></tbody><colgroup>","</colgroup></table>"]||jQuery.browser.msie&&[1,"div<div>","</div>"]||[0,"",""];div.innerHTML=wrap[1]+elem+wrap[2];while(wrap[0]--)div=div.lastChild;if(jQuery.browser.msie){var tbody=!tags.indexOf("<table")&&tags.indexOf("<tbody")<0?div.firstChild&&div.firstChild.childNodes:wrap[1]=="<table>"&&tags.indexOf("<tbody")<0?div.childNodes:[];for(var j=tbody.length-1;j>=0;--j)if(jQuery.nodeName(tbody[j],"tbody")&&!tbody[j].childNodes.length)tbody[j].parentNode.removeChild(tbody[j]);if(/^\s/.test(elem))div.insertBefore(context.createTextNode(elem.match(/^\s*/)[0]),div.firstChild);}elem=jQuery.makeArray(div.childNodes);}if(elem.length===0&&(!jQuery.nodeName(elem,"form")&&!jQuery.nodeName(elem,"select")))return;if(elem[0]==undefined||jQuery.nodeName(elem,"form")||elem.options)ret.push(elem);else
ret=jQuery.merge(ret,elem);});return ret;},attr:function(elem,name,value){if(!elem||elem.nodeType==3||elem.nodeType==8)return undefined;var fix=jQuery.isXMLDoc(elem)?{}:jQuery.props;if(name=="selected"&&jQuery.browser.safari)elem.parentNode.selectedIndex;if(fix[name]){if(value!=undefined)elem[fix[name]]=value;return elem[fix[name]];}else if(jQuery.browser.msie&&name=="style")return jQuery.attr(elem.style,"cssText",value);else if(value==undefined&&jQuery.browser.msie&&jQuery.nodeName(elem,"form")&&(name=="action"||name=="method"))return elem.getAttributeNode(name).nodeValue;else if(elem.tagName){if(value!=undefined){if(name=="type"&&jQuery.nodeName(elem,"input")&&elem.parentNode)throw"type property can't be changed";elem.setAttribute(name,""+value);}if(jQuery.browser.msie&&/href|src/.test(name)&&!jQuery.isXMLDoc(elem))return elem.getAttribute(name,2);return elem.getAttribute(name);}else{if(name=="opacity"&&jQuery.browser.msie){if(value!=undefined){elem.zoom=1;elem.filter=(elem.filter||"").replace(/alpha\([^)]*\)/,"")+(parseFloat(value).toString()=="NaN"?"":"alpha(opacity="+value*100+")");}return elem.filter&&elem.filter.indexOf("opacity=")>=0?(parseFloat(elem.filter.match(/opacity=([^)]*)/)[1])/100).toString():"";}name=name.replace(/-([a-z])/ig,function(all,letter){return letter.toUpperCase();});if(value!=undefined)elem[name]=value;return elem[name];}},trim:function(text){return(text||"").replace(/^\s+|\s+$/g,"");},makeArray:function(array){var ret=[];if(typeof array!="array")for(var i=0,length=array.length;i<length;i++)ret.push(array[i]);else
ret=array.slice(0);return ret;},inArray:function(elem,array){for(var i=0,length=array.length;i<length;i++)if(array[i]==elem)return i;return-1;},merge:function(first,second){if(jQuery.browser.msie){for(var i=0;second[i];i++)if(second[i].nodeType!=8)first.push(second[i]);}else
for(var i=0;second[i];i++)first.push(second[i]);return first;},unique:function(array){var ret=[],done={};try{for(var i=0,length=array.length;i<length;i++){var id=jQuery.data(array[i]);if(!done[id]){done[id]=true;ret.push(array[i]);}}}catch(e){ret=array;}return ret;},grep:function(elems,callback,inv){var ret=[];for(var i=0,length=elems.length;i<length;i++)if(!inv&&callback(elems[i],i)||inv&&!callback(elems[i],i))ret.push(elems[i]);return ret;},map:function(elems,callback){var ret=[];for(var i=0,length=elems.length;i<length;i++){var value=callback(elems[i],i);if(value!==null&&value!=undefined){if(value.constructor!=Array)value=[value];ret=ret.concat(value);}}return ret;}});var userAgent=navigator.userAgent.toLowerCase();jQuery.browser={version:(userAgent.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/)||[])[1],safari:/webkit/.test(userAgent),opera:/opera/.test(userAgent),msie:/msie/.test(userAgent)&&!/opera/.test(userAgent),mozilla:/mozilla/.test(userAgent)&&!/(compatible|webkit)/.test(userAgent)};var styleFloat=jQuery.browser.msie?"styleFloat":"cssFloat";jQuery.extend({boxModel:!jQuery.browser.msie||document.compatMode=="CSS1Compat",props:{"for":"htmlFor","class":"className","float":styleFloat,cssFloat:styleFloat,styleFloat:styleFloat,innerHTML:"innerHTML",className:"className",value:"value",disabled:"disabled",checked:"checked",readonly:"readOnly",selected:"selected",maxlength:"maxLength",selectedIndex:"selectedIndex",defaultValue:"defaultValue",tagName:"tagName",nodeName:"nodeName"}});jQuery.each({parent:function(elem){return elem.parentNode;},parents:function(elem){return jQuery.dir(elem,"parentNode");},next:function(elem){return jQuery.nth(elem,2,"nextSibling");},prev:function(elem){return jQuery.nth(elem,2,"previousSibling");},nextAll:function(elem){return jQuery.dir(elem,"nextSibling");},prevAll:function(elem){return jQuery.dir(elem,"previousSibling");},siblings:function(elem){return jQuery.sibling(elem.parentNode.firstChild,elem);},children:function(elem){return jQuery.sibling(elem.firstChild);},contents:function(elem){return jQuery.nodeName(elem,"iframe")?elem.contentDocument||elem.contentWindow.document:jQuery.makeArray(elem.childNodes);}},function(name,fn){jQuery.fn[name]=function(selector){var ret=jQuery.map(this,fn);if(selector&&typeof selector=="string")ret=jQuery.multiFilter(selector,ret);return this.pushStack(jQuery.unique(ret));};});jQuery.each({appendTo:"append",prependTo:"prepend",insertBefore:"before",insertAfter:"after",replaceAll:"replaceWith"},function(name,original){jQuery.fn[name]=function(){var args=arguments;return this.each(function(){for(var i=0,length=args.length;i<length;i++)jQuery(args[i])[original](this);});};});jQuery.each({removeAttr:function(name){jQuery.attr(this,name,"");if(this.nodeType==1)this.removeAttribute(name);},addClass:function(classNames){jQuery.className.add(this,classNames);},removeClass:function(classNames){jQuery.className.remove(this,classNames);},toggleClass:function(classNames){jQuery.className[jQuery.className.has(this,classNames)?"remove":"add"](this,classNames);},remove:function(selector){if(!selector||jQuery.filter(selector,[this]).r.length){jQuery("*",this).add(this).each(function(){jQuery.event.remove(this);jQuery.removeData(this);});if(this.parentNode)this.parentNode.removeChild(this);}},empty:function(){jQuery(">*",this).remove();while(this.firstChild)this.removeChild(this.firstChild);}},function(name,fn){jQuery.fn[name]=function(){return this.each(fn,arguments);};});jQuery.each(["Height","Width"],function(i,name){var type=name.toLowerCase();jQuery.fn[type]=function(size){return this[0]==window?jQuery.browser.opera&&document.body["client"+name]||jQuery.browser.safari&&window["inner"+name]||document.compatMode=="CSS1Compat"&&document.documentElement["client"+name]||document.body["client"+name]:this[0]==document?Math.max(Math.max(document.body["scroll"+name],document.documentElement["scroll"+name]),Math.max(document.body["offset"+name],document.documentElement["offset"+name])):size==undefined?(this.length?jQuery.css(this[0],type):null):this.css(type,size.constructor==String?size:size+"px");};});var chars=jQuery.browser.safari&&parseInt(jQuery.browser.version)<417?"(?:[\\w*_-]|\\\\.)":"(?:[\\w\u0128-\uFFFF*_-]|\\\\.)",quickChild=new RegExp("^>\\s*("+chars+"+)"),quickID=new RegExp("^("+chars+"+)(#)("+chars+"+)"),quickClass=new RegExp("^([#.]?)("+chars+"*)");jQuery.extend({expr:{"":function(a,i,m){return m[2]=="*"||jQuery.nodeName(a,m[2]);},"#":function(a,i,m){return a.getAttribute("id")==m[2];},":":{lt:function(a,i,m){return i<m[3]-0;},gt:function(a,i,m){return i>m[3]-0;},nth:function(a,i,m){return m[3]-0==i;},eq:function(a,i,m){return m[3]-0==i;},first:function(a,i){return i==0;},last:function(a,i,m,r){return i==r.length-1;},even:function(a,i){return i%2==0;},odd:function(a,i){return i%2;},"first-child":function(a){return a.parentNode.getElementsByTagName("*")[0]==a;},"last-child":function(a){return jQuery.nth(a.parentNode.lastChild,1,"previousSibling")==a;},"only-child":function(a){return!jQuery.nth(a.parentNode.lastChild,2,"previousSibling");},parent:function(a){return a.firstChild;},empty:function(a){return!a.firstChild;},contains:function(a,i,m){return(a.textContent||a.innerText||jQuery(a).text()||"").indexOf(m[3])>=0;},visible:function(a){return"hidden"!=a.type&&jQuery.css(a,"display")!="none"&&jQuery.css(a,"visibility")!="hidden";},hidden:function(a){return"hidden"==a.type||jQuery.css(a,"display")=="none"||jQuery.css(a,"visibility")=="hidden";},enabled:function(a){return!a.disabled;},disabled:function(a){return a.disabled;},checked:function(a){return a.checked;},selected:function(a){return a.selected||jQuery.attr(a,"selected");},text:function(a){return"text"==a.type;},radio:function(a){return"radio"==a.type;},checkbox:function(a){return"checkbox"==a.type;},file:function(a){return"file"==a.type;},password:function(a){return"password"==a.type;},submit:function(a){return"submit"==a.type;},image:function(a){return"image"==a.type;},reset:function(a){return"reset"==a.type;},button:function(a){return"button"==a.type||jQuery.nodeName(a,"button");},input:function(a){return/input|select|textarea|button/i.test(a.nodeName);},has:function(a,i,m){return jQuery.find(m[3],a).length;},header:function(a){return/h\d/i.test(a.nodeName);},animated:function(a){return jQuery.grep(jQuery.timers,function(fn){return a==fn.elem;}).length;}}},parse:[/^(\[) *@?([\w-]+) *([!*$^~=]*) *('?"?)(.*?)\4 *\]/,/^(:)([\w-]+)\("?'?(.*?(\(.*?\))?[^(]*?)"?'?\)/,new RegExp("^([:.#]*)("+chars+"+)")],multiFilter:function(expr,elems,not){var old,cur=[];while(expr&&expr!=old){old=expr;var f=jQuery.filter(expr,elems,not);expr=f.t.replace(/^\s*,\s*/,"");cur=not?elems=f.r:jQuery.merge(cur,f.r);}return cur;},find:function(t,context){if(typeof t!="string")return[t];if(context&&context.nodeType!=1&&context.nodeType!=9)return[];context=context||document;var ret=[context],done=[],last,nodeName;while(t&&last!=t){var r=[];last=t;t=jQuery.trim(t);var foundToken=false;var re=quickChild;var m=re.exec(t);if(m){nodeName=m[1].toUpperCase();for(var i=0;ret[i];i++)for(var c=ret[i].firstChild;c;c=c.nextSibling)if(c.nodeType==1&&(nodeName=="*"||c.nodeName.toUpperCase()==nodeName))r.push(c);ret=r;t=t.replace(re,"");if(t.indexOf(" ")==0)continue;foundToken=true;}else{re=/^([>+~])\s*(\w*)/i;if((m=re.exec(t))!=null){r=[];var merge={};nodeName=m[2].toUpperCase();m=m[1];for(var j=0,rl=ret.length;j<rl;j++){var n=m=="~"||m=="+"?ret[j].nextSibling:ret[j].firstChild;for(;n;n=n.nextSibling)if(n.nodeType==1){var id=jQuery.data(n);if(m=="~"&&merge[id])break;if(!nodeName||n.nodeName.toUpperCase()==nodeName){if(m=="~")merge[id]=true;r.push(n);}if(m=="+")break;}}ret=r;t=jQuery.trim(t.replace(re,""));foundToken=true;}}if(t&&!foundToken){if(!t.indexOf(",")){if(context==ret[0])ret.shift();done=jQuery.merge(done,ret);r=ret=[context];t=" "+t.substr(1,t.length);}else{var re2=quickID;var m=re2.exec(t);if(m){m=[0,m[2],m[3],m[1]];}else{re2=quickClass;m=re2.exec(t);}m[2]=m[2].replace(/\\/g,"");var elem=ret[ret.length-1];if(m[1]=="#"&&elem&&elem.getElementById&&!jQuery.isXMLDoc(elem)){var oid=elem.getElementById(m[2]);if((jQuery.browser.msie||jQuery.browser.opera)&&oid&&typeof oid.id=="string"&&oid.id!=m[2])oid=jQuery('[@id="'+m[2]+'"]',elem)[0];ret=r=oid&&(!m[3]||jQuery.nodeName(oid,m[3]))?[oid]:[];}else{for(var i=0;ret[i];i++){var tag=m[1]=="#"&&m[3]?m[3]:m[1]!=""||m[0]==""?"*":m[2];if(tag=="*"&&ret[i].nodeName.toLowerCase()=="object")tag="param";r=jQuery.merge(r,ret[i].getElementsByTagName(tag));}if(m[1]==".")r=jQuery.classFilter(r,m[2]);if(m[1]=="#"){var tmp=[];for(var i=0;r[i];i++)if(r[i].getAttribute("id")==m[2]){tmp=[r[i]];break;}r=tmp;}ret=r;}t=t.replace(re2,"");}}if(t){var val=jQuery.filter(t,r);ret=r=val.r;t=jQuery.trim(val.t);}}if(t)ret=[];if(ret&&context==ret[0])ret.shift();done=jQuery.merge(done,ret);return done;},classFilter:function(r,m,not){m=" "+m+" ";var tmp=[];for(var i=0;r[i];i++){var pass=(" "+r[i].className+" ").indexOf(m)>=0;if(!not&&pass||not&&!pass)tmp.push(r[i]);}return tmp;},filter:function(t,r,not){var last;while(t&&t!=last){last=t;var p=jQuery.parse,m;for(var i=0;p[i];i++){m=p[i].exec(t);if(m){t=t.substring(m[0].length);m[2]=m[2].replace(/\\/g,"");break;}}if(!m)break;if(m[1]==":"&&m[2]=="not")r=isSimple.test(m[3])?jQuery.filter(m[3],r,true).r:jQuery(r).not(m[3]);else if(m[1]==".")r=jQuery.classFilter(r,m[2],not);else if(m[1]=="["){var tmp=[],type=m[3];for(var i=0,rl=r.length;i<rl;i++){var a=r[i],z=a[jQuery.props[m[2]]||m[2]];if(z==null||/href|src|selected/.test(m[2]))z=jQuery.attr(a,m[2])||'';if((type==""&&!!z||type=="="&&z==m[5]||type=="!="&&z!=m[5]||type=="^="&&z&&!z.indexOf(m[5])||type=="$="&&z.substr(z.length-m[5].length)==m[5]||(type=="*="||type=="~=")&&z.indexOf(m[5])>=0)^not)tmp.push(a);}r=tmp;}else if(m[1]==":"&&m[2]=="nth-child"){var merge={},tmp=[],test=/(-?)(\d*)n((?:\+|-)?\d*)/.exec(m[3]=="even"&&"2n"||m[3]=="odd"&&"2n+1"||!/\D/.test(m[3])&&"0n+"+m[3]||m[3]),first=(test[1]+(test[2]||1))-0,last=test[3]-0;for(var i=0,rl=r.length;i<rl;i++){var node=r[i],parentNode=node.parentNode,id=jQuery.data(parentNode);if(!merge[id]){var c=1;for(var n=parentNode.firstChild;n;n=n.nextSibling)if(n.nodeType==1)n.nodeIndex=c++;merge[id]=true;}var add=false;if(first==0){if(node.nodeIndex==last)add=true;}else if((node.nodeIndex-last)%first==0&&(node.nodeIndex-last)/first>=0)add=true;if(add^not)tmp.push(node);}r=tmp;}else{var fn=jQuery.expr[m[1]];if(typeof fn=="object")fn=fn[m[2]];if(typeof fn=="string")fn=eval("false||function(a,i){return "+fn+";}");r=jQuery.grep(r,function(elem,i){return fn(elem,i,m,r);},not);}}return{r:r,t:t};},dir:function(elem,dir){var matched=[];var cur=elem[dir];while(cur&&cur!=document){if(cur.nodeType==1)matched.push(cur);cur=cur[dir];}return matched;},nth:function(cur,result,dir,elem){result=result||1;var num=0;for(;cur;cur=cur[dir])if(cur.nodeType==1&&++num==result)break;return cur;},sibling:function(n,elem){var r=[];for(;n;n=n.nextSibling){if(n.nodeType==1&&(!elem||n!=elem))r.push(n);}return r;}});jQuery.event={add:function(elem,types,handler,data){if(elem.nodeType==3||elem.nodeType==8)return;if(jQuery.browser.msie&&elem.setInterval!=undefined)elem=window;if(!handler.guid)handler.guid=this.guid++;if(data!=undefined){var fn=handler;handler=function(){return fn.apply(this,arguments);};handler.data=data;handler.guid=fn.guid;}var events=jQuery.data(elem,"events")||jQuery.data(elem,"events",{}),handle=jQuery.data(elem,"handle")||jQuery.data(elem,"handle",function(){var val;if(typeof jQuery=="undefined"||jQuery.event.triggered)return val;val=jQuery.event.handle.apply(arguments.callee.elem,arguments);return val;});handle.elem=elem;jQuery.each(types.split(/\s+/),function(index,type){var parts=type.split(".");type=parts[0];handler.type=parts[1];var handlers=events[type];if(!handlers){handlers=events[type]={};if(!jQuery.event.special[type]||jQuery.event.special[type].setup.call(elem)===false){if(elem.addEventListener)elem.addEventListener(type,handle,false);else if(elem.attachEvent)elem.attachEvent("on"+type,handle);}}handlers[handler.guid]=handler;jQuery.event.global[type]=true;});elem=null;},guid:1,global:{},remove:function(elem,types,handler){if(elem.nodeType==3||elem.nodeType==8)return;var events=jQuery.data(elem,"events"),ret,index;if(events){if(types==undefined||(typeof types=="string"&&types.charAt(0)=="."))for(var type in events)this.remove(elem,type+(types||""));else{if(types.type){handler=types.handler;types=types.type;}jQuery.each(types.split(/\s+/),function(index,type){var parts=type.split(".");type=parts[0];if(events[type]){if(handler)delete events[type][handler.guid];else
for(handler in events[type])if(!parts[1]||events[type][handler].type==parts[1])delete events[type][handler];for(ret in events[type])break;if(!ret){if(!jQuery.event.special[type]||jQuery.event.special[type].teardown.call(elem)===false){if(elem.removeEventListener)elem.removeEventListener(type,jQuery.data(elem,"handle"),false);else if(elem.detachEvent)elem.detachEvent("on"+type,jQuery.data(elem,"handle"));}ret=null;delete events[type];}}});}for(ret in events)break;if(!ret){var handle=jQuery.data(elem,"handle");if(handle)handle.elem=null;jQuery.removeData(elem,"events");jQuery.removeData(elem,"handle");}}},trigger:function(type,data,elem,donative,extra){data=jQuery.makeArray(data||[]);if(type.indexOf("!")>=0){type=type.slice(0,-1);var exclusive=true;}if(!elem){if(this.global[type])jQuery("*").add([window,document]).trigger(type,data);}else{if(elem.nodeType==3||elem.nodeType==8)return undefined;var val,ret,fn=jQuery.isFunction(elem[type]||null),event=!data[0]||!data[0].preventDefault;if(event)data.unshift(this.fix({type:type,target:elem}));data[0].type=type;if(exclusive)data[0].exclusive=true;if(jQuery.isFunction(jQuery.data(elem,"handle")))val=jQuery.data(elem,"handle").apply(elem,data);if(!fn&&elem["on"+type]&&elem["on"+type].apply(elem,data)===false)val=false;if(event)data.shift();if(extra&&jQuery.isFunction(extra)){ret=extra.apply(elem,val==null?data:data.concat(val));if(ret!==undefined)val=ret;}if(fn&&donative!==false&&val!==false&&!(jQuery.nodeName(elem,'a')&&type=="click")){this.triggered=true;try{elem[type]();}catch(e){}}this.triggered=false;}return val;},handle:function(event){var val;event=jQuery.event.fix(event||window.event||{});var parts=event.type.split(".");event.type=parts[0];var handlers=jQuery.data(this,"events")&&jQuery.data(this,"events")[event.type],args=Array.prototype.slice.call(arguments,1);args.unshift(event);for(var j in handlers){var handler=handlers[j];args[0].handler=handler;args[0].data=handler.data;if(!parts[1]&&!event.exclusive||handler.type==parts[1]){var ret=handler.apply(this,args);if(val!==false)val=ret;if(ret===false){event.preventDefault();event.stopPropagation();}}}if(jQuery.browser.msie)event.target=event.preventDefault=event.stopPropagation=event.handler=event.data=null;return val;},fix:function(event){var originalEvent=event;event=jQuery.extend({},originalEvent);event.preventDefault=function(){if(originalEvent.preventDefault)originalEvent.preventDefault();originalEvent.returnValue=false;};event.stopPropagation=function(){if(originalEvent.stopPropagation)originalEvent.stopPropagation();originalEvent.cancelBubble=true;};if(!event.target)event.target=event.srcElement||document;if(event.target.nodeType==3)event.target=originalEvent.target.parentNode;if(!event.relatedTarget&&event.fromElement)event.relatedTarget=event.fromElement==event.target?event.toElement:event.fromElement;if(event.pageX==null&&event.clientX!=null){var doc=document.documentElement,body=document.body;event.pageX=event.clientX+(doc&&doc.scrollLeft||body&&body.scrollLeft||0)-(doc.clientLeft||0);event.pageY=event.clientY+(doc&&doc.scrollTop||body&&body.scrollTop||0)-(doc.clientTop||0);}if(!event.which&&((event.charCode||event.charCode===0)?event.charCode:event.keyCode))event.which=event.charCode||event.keyCode;if(!event.metaKey&&event.ctrlKey)event.metaKey=event.ctrlKey;if(!event.which&&event.button)event.which=(event.button&1?1:(event.button&2?3:(event.button&4?2:0)));return event;},special:{ready:{setup:function(){bindReady();return;},teardown:function(){return;}},mouseenter:{setup:function(){if(jQuery.browser.msie)return false;jQuery(this).bind("mouseover",jQuery.event.special.mouseenter.handler);return true;},teardown:function(){if(jQuery.browser.msie)return false;jQuery(this).unbind("mouseover",jQuery.event.special.mouseenter.handler);return true;},handler:function(event){if(withinElement(event,this))return true;arguments[0].type="mouseenter";return jQuery.event.handle.apply(this,arguments);}},mouseleave:{setup:function(){if(jQuery.browser.msie)return false;jQuery(this).bind("mouseout",jQuery.event.special.mouseleave.handler);return true;},teardown:function(){if(jQuery.browser.msie)return false;jQuery(this).unbind("mouseout",jQuery.event.special.mouseleave.handler);return true;},handler:function(event){if(withinElement(event,this))return true;arguments[0].type="mouseleave";return jQuery.event.handle.apply(this,arguments);}}}};jQuery.fn.extend({bind:function(type,data,fn){return type=="unload"?this.one(type,data,fn):this.each(function(){jQuery.event.add(this,type,fn||data,fn&&data);});},one:function(type,data,fn){return this.each(function(){jQuery.event.add(this,type,function(event){jQuery(this).unbind(event);return(fn||data).apply(this,arguments);},fn&&data);});},unbind:function(type,fn){return this.each(function(){jQuery.event.remove(this,type,fn);});},trigger:function(type,data,fn){return this.each(function(){jQuery.event.trigger(type,data,this,true,fn);});},triggerHandler:function(type,data,fn){if(this[0])return jQuery.event.trigger(type,data,this[0],false,fn);return undefined;},toggle:function(){var args=arguments;return this.click(function(event){this.lastToggle=0==this.lastToggle?1:0;event.preventDefault();return args[this.lastToggle].apply(this,arguments)||false;});},hover:function(fnOver,fnOut){return this.bind('mouseenter',fnOver).bind('mouseleave',fnOut);},ready:function(fn){bindReady();if(jQuery.isReady)fn.call(document,jQuery);else
jQuery.readyList.push(function(){return fn.call(this,jQuery);});return this;}});jQuery.extend({isReady:false,readyList:[],ready:function(){if(!jQuery.isReady){jQuery.isReady=true;if(jQuery.readyList){jQuery.each(jQuery.readyList,function(){this.apply(document);});jQuery.readyList=null;}jQuery(document).triggerHandler("ready");}}});var readyBound=false;function bindReady(){if(readyBound)return;readyBound=true;if(document.addEventListener&&!jQuery.browser.opera)document.addEventListener("DOMContentLoaded",jQuery.ready,false);if(jQuery.browser.msie&&window==top)(function(){if(jQuery.isReady)return;try{document.documentElement.doScroll("left");}catch(error){setTimeout(arguments.callee,0);return;}jQuery.ready();})();if(jQuery.browser.opera)document.addEventListener("DOMContentLoaded",function(){if(jQuery.isReady)return;for(var i=0;i<document.styleSheets.length;i++)if(document.styleSheets[i].disabled){setTimeout(arguments.callee,0);return;}jQuery.ready();},false);if(jQuery.browser.safari){var numStyles;(function(){if(jQuery.isReady)return;if(document.readyState!="loaded"&&document.readyState!="complete"){setTimeout(arguments.callee,0);return;}if(numStyles===undefined)numStyles=jQuery("style, link[rel=stylesheet]").length;if(document.styleSheets.length!=numStyles){setTimeout(arguments.callee,0);return;}jQuery.ready();})();}jQuery.event.add(window,"load",jQuery.ready);}jQuery.each(("blur,focus,load,resize,scroll,unload,click,dblclick,"+"mousedown,mouseup,mousemove,mouseover,mouseout,change,select,"+"submit,keydown,keypress,keyup,error").split(","),function(i,name){jQuery.fn[name]=function(fn){return fn?this.bind(name,fn):this.trigger(name);};});var withinElement=function(event,elem){var parent=event.relatedTarget;while(parent&&parent!=elem)try{parent=parent.parentNode;}catch(error){parent=elem;}return parent==elem;};jQuery(window).bind("unload",function(){jQuery("*").add(document).unbind();});jQuery.fn.extend({load:function(url,params,callback){if(jQuery.isFunction(url))return this.bind("load",url);var off=url.indexOf(" ");if(off>=0){var selector=url.slice(off,url.length);url=url.slice(0,off);}callback=callback||function(){};var type="GET";if(params)if(jQuery.isFunction(params)){callback=params;params=null;}else{params=jQuery.param(params);type="POST";}var self=this;jQuery.ajax({url:url,type:type,dataType:"html",data:params,complete:function(res,status){if(status=="success"||status=="notmodified")self.html(selector?jQuery("<div/>").append(res.responseText.replace(/<script(.|\s)*?\/script>/g,"")).find(selector):res.responseText);self.each(callback,[res.responseText,status,res]);}});return this;},serialize:function(){return jQuery.param(this.serializeArray());},serializeArray:function(){return this.map(function(){return jQuery.nodeName(this,"form")?jQuery.makeArray(this.elements):this;}).filter(function(){return this.name&&!this.disabled&&(this.checked||/select|textarea/i.test(this.nodeName)||/text|hidden|password/i.test(this.type));}).map(function(i,elem){var val=jQuery(this).val();return val==null?null:val.constructor==Array?jQuery.map(val,function(val,i){return{name:elem.name,value:val};}):{name:elem.name,value:val};}).get();}});jQuery.each("ajaxStart,ajaxStop,ajaxComplete,ajaxError,ajaxSuccess,ajaxSend".split(","),function(i,o){jQuery.fn[o]=function(f){return this.bind(o,f);};});var jsc=(new Date).getTime();jQuery.extend({get:function(url,data,callback,type){if(jQuery.isFunction(data)){callback=data;data=null;}return jQuery.ajax({type:"GET",url:url,data:data,success:callback,dataType:type});},getScript:function(url,callback){return jQuery.get(url,null,callback,"script");},getJSON:function(url,data,callback){return jQuery.get(url,data,callback,"json");},post:function(url,data,callback,type){if(jQuery.isFunction(data)){callback=data;data={};}return jQuery.ajax({type:"POST",url:url,data:data,success:callback,dataType:type});},ajaxSetup:function(settings){jQuery.extend(jQuery.ajaxSettings,settings);},ajaxSettings:{global:true,type:"GET",timeout:0,contentType:"application/x-www-form-urlencoded",processData:true,async:true,data:null,username:null,password:null,accepts:{xml:"application/xml, text/xml",html:"text/html",script:"text/javascript, application/javascript",json:"application/json, text/javascript",text:"text/plain",_default:"*/*"}},lastModified:{},ajax:function(s){var jsonp,jsre=/=\?(&|$)/g,status,data;s=jQuery.extend(true,s,jQuery.extend(true,{},jQuery.ajaxSettings,s));if(s.data&&s.processData&&typeof s.data!="string")s.data=jQuery.param(s.data);if(s.dataType=="jsonp"){if(s.type.toLowerCase()=="get"){if(!s.url.match(jsre))s.url+=(s.url.match(/\?/)?"&":"?")+(s.jsonp||"callback")+"=?";}else if(!s.data||!s.data.match(jsre))s.data=(s.data?s.data+"&":"")+(s.jsonp||"callback")+"=?";s.dataType="json";}if(s.dataType=="json"&&(s.data&&s.data.match(jsre)||s.url.match(jsre))){jsonp="jsonp"+jsc++;if(s.data)s.data=(s.data+"").replace(jsre,"="+jsonp+"$1");s.url=s.url.replace(jsre,"="+jsonp+"$1");s.dataType="script";window[jsonp]=function(tmp){data=tmp;success();complete();window[jsonp]=undefined;try{delete window[jsonp];}catch(e){}if(head)head.removeChild(script);};}if(s.dataType=="script"&&s.cache==null)s.cache=false;if(s.cache===false&&s.type.toLowerCase()=="get"){var ts=(new Date()).getTime();var ret=s.url.replace(/(\?|&)_=.*?(&|$)/,"$1_="+ts+"$2");s.url=ret+((ret==s.url)?(s.url.match(/\?/)?"&":"?")+"_="+ts:"");}if(s.data&&s.type.toLowerCase()=="get"){s.url+=(s.url.match(/\?/)?"&":"?")+s.data;s.data=null;}if(s.global&&!jQuery.active++)jQuery.event.trigger("ajaxStart");if((!s.url.indexOf("http")||!s.url.indexOf("//"))&&s.dataType=="script"&&s.type.toLowerCase()=="get"){var head=document.getElementsByTagName("head")[0];var script=document.createElement("script");script.src=s.url;if(s.scriptCharset)script.charset=s.scriptCharset;if(!jsonp){var done=false;script.onload=script.onreadystatechange=function(){if(!done&&(!this.readyState||this.readyState=="loaded"||this.readyState=="complete")){done=true;success();complete();head.removeChild(script);}};}head.appendChild(script);return undefined;}var requestDone=false;var xml=window.ActiveXObject?new ActiveXObject("Microsoft.XMLHTTP"):new XMLHttpRequest();xml.open(s.type,s.url,s.async,s.username,s.password);try{if(s.data)xml.setRequestHeader("Content-Type",s.contentType);if(s.ifModified)xml.setRequestHeader("If-Modified-Since",jQuery.lastModified[s.url]||"Thu, 01 Jan 1970 00:00:00 GMT");xml.setRequestHeader("X-Requested-With","XMLHttpRequest");xml.setRequestHeader("Accept",s.dataType&&s.accepts[s.dataType]?s.accepts[s.dataType]+", */*":s.accepts._default);}catch(e){}if(s.beforeSend)s.beforeSend(xml);if(s.global)jQuery.event.trigger("ajaxSend",[xml,s]);var onreadystatechange=function(isTimeout){if(!requestDone&&xml&&(xml.readyState==4||isTimeout=="timeout")){requestDone=true;if(ival){clearInterval(ival);ival=null;}status=isTimeout=="timeout"&&"timeout"||!jQuery.httpSuccess(xml)&&"error"||s.ifModified&&jQuery.httpNotModified(xml,s.url)&&"notmodified"||"success";if(status=="success"){try{data=jQuery.httpData(xml,s.dataType);}catch(e){status="parsererror";}}if(status=="success"){var modRes;try{modRes=xml.getResponseHeader("Last-Modified");}catch(e){}if(s.ifModified&&modRes)jQuery.lastModified[s.url]=modRes;if(!jsonp)success();}else
jQuery.handleError(s,xml,status);complete();if(s.async)xml=null;}};if(s.async){var ival=setInterval(onreadystatechange,13);if(s.timeout>0)setTimeout(function(){if(xml){xml.abort();if(!requestDone)onreadystatechange("timeout");}},s.timeout);}try{xml.send(s.data);}catch(e){jQuery.handleError(s,xml,null,e);}if(!s.async)onreadystatechange();function success(){if(s.success)s.success(data,status);if(s.global)jQuery.event.trigger("ajaxSuccess",[xml,s]);}function complete(){if(s.complete)s.complete(xml,status);if(s.global)jQuery.event.trigger("ajaxComplete",[xml,s]);if(s.global&&!--jQuery.active)jQuery.event.trigger("ajaxStop");}return xml;},handleError:function(s,xml,status,e){if(s.error)s.error(xml,status,e);if(s.global)jQuery.event.trigger("ajaxError",[xml,s,e]);},active:0,httpSuccess:function(r){try{return!r.status&&location.protocol=="file:"||(r.status>=200&&r.status<300)||r.status==304||r.status==1223||jQuery.browser.safari&&r.status==undefined;}catch(e){}return false;},httpNotModified:function(xml,url){try{var xmlRes=xml.getResponseHeader("Last-Modified");return xml.status==304||xmlRes==jQuery.lastModified[url]||jQuery.browser.safari&&xml.status==undefined;}catch(e){}return false;},httpData:function(r,type){var ct=r.getResponseHeader("content-type");var xml=type=="xml"||!type&&ct&&ct.indexOf("xml")>=0;var data=xml?r.responseXML:r.responseText;if(xml&&data.documentElement.tagName=="parsererror")throw"parsererror";if(type=="script")jQuery.globalEval(data);if(type=="json")data=eval("("+data+")");return data;},param:function(a){var s=[];if(a.constructor==Array||a.jquery)jQuery.each(a,function(){s.push(encodeURIComponent(this.name)+"="+encodeURIComponent(this.value));});else
for(var j in a)if(a[j]&&a[j].constructor==Array)jQuery.each(a[j],function(){s.push(encodeURIComponent(j)+"="+encodeURIComponent(this));});else
s.push(encodeURIComponent(j)+"="+encodeURIComponent(a[j]));return s.join("&").replace(/%20/g,"+");}});jQuery.fn.extend({show:function(speed,callback){return speed?this.animate({height:"show",width:"show",opacity:"show"},speed,callback):this.filter(":hidden").each(function(){this.style.display=this.oldblock||"";if(jQuery.css(this,"display")=="none"){var elem=jQuery("<"+this.tagName+" />").appendTo("body");this.style.display=elem.css("display");if(this.style.display=="none")this.style.display="block";elem.remove();}}).end();},hide:function(speed,callback){return speed?this.animate({height:"hide",width:"hide",opacity:"hide"},speed,callback):this.filter(":visible").each(function(){this.oldblock=this.oldblock||jQuery.css(this,"display");this.style.display="none";}).end();},_toggle:jQuery.fn.toggle,toggle:function(fn,fn2){return jQuery.isFunction(fn)&&jQuery.isFunction(fn2)?this._toggle(fn,fn2):fn?this.animate({height:"toggle",width:"toggle",opacity:"toggle"},fn,fn2):this.each(function(){jQuery(this)[jQuery(this).is(":hidden")?"show":"hide"]();});},slideDown:function(speed,callback){return this.animate({height:"show"},speed,callback);},slideUp:function(speed,callback){return this.animate({height:"hide"},speed,callback);},slideToggle:function(speed,callback){return this.animate({height:"toggle"},speed,callback);},fadeIn:function(speed,callback){return this.animate({opacity:"show"},speed,callback);},fadeOut:function(speed,callback){return this.animate({opacity:"hide"},speed,callback);},fadeTo:function(speed,to,callback){return this.animate({opacity:to},speed,callback);},animate:function(prop,speed,easing,callback){var optall=jQuery.speed(speed,easing,callback);return this[optall.queue===false?"each":"queue"](function(){if(this.nodeType!=1)return false;var opt=jQuery.extend({},optall);var hidden=jQuery(this).is(":hidden"),self=this;for(var p in prop){if(prop[p]=="hide"&&hidden||prop[p]=="show"&&!hidden)return jQuery.isFunction(opt.complete)&&opt.complete.apply(this);if(p=="height"||p=="width"){opt.display=jQuery.css(this,"display");opt.overflow=this.style.overflow;}}if(opt.overflow!=null)this.style.overflow="hidden";opt.curAnim=jQuery.extend({},prop);jQuery.each(prop,function(name,val){var e=new jQuery.fx(self,opt,name);if(/toggle|show|hide/.test(val))e[val=="toggle"?hidden?"show":"hide":val](prop);else{var parts=val.toString().match(/^([+-]=)?([\d+-.]+)(.*)$/),start=e.cur(true)||0;if(parts){var end=parseFloat(parts[2]),unit=parts[3]||"px";if(unit!="px"){self.style[name]=(end||1)+unit;start=((end||1)/e.cur(true))*start;self.style[name]=start+unit;}if(parts[1])end=((parts[1]=="-="?-1:1)*end)+start;e.custom(start,end,unit);}else
e.custom(start,val,"");}});return true;});},queue:function(type,fn){if(jQuery.isFunction(type)||(type&&type.constructor==Array)){fn=type;type="fx";}if(!type||(typeof type=="string"&&!fn))return queue(this[0],type);return this.each(function(){if(fn.constructor==Array)queue(this,type,fn);else{queue(this,type).push(fn);if(queue(this,type).length==1)fn.apply(this);}});},stop:function(clearQueue,gotoEnd){var timers=jQuery.timers;if(clearQueue)this.queue([]);this.each(function(){for(var i=timers.length-1;i>=0;i--)if(timers[i].elem==this){if(gotoEnd)timers[i](true);timers.splice(i,1);}});if(!gotoEnd)this.dequeue();return this;}});var queue=function(elem,type,array){if(!elem)return undefined;type=type||"fx";var q=jQuery.data(elem,type+"queue");if(!q||array)q=jQuery.data(elem,type+"queue",array?jQuery.makeArray(array):[]);return q;};jQuery.fn.dequeue=function(type){type=type||"fx";return this.each(function(){var q=queue(this,type);q.shift();if(q.length)q[0].apply(this);});};jQuery.extend({speed:function(speed,easing,fn){var opt=speed&&speed.constructor==Object?speed:{complete:fn||!fn&&easing||jQuery.isFunction(speed)&&speed,duration:speed,easing:fn&&easing||easing&&easing.constructor!=Function&&easing};opt.duration=(opt.duration&&opt.duration.constructor==Number?opt.duration:{slow:600,fast:200}[opt.duration])||400;opt.old=opt.complete;opt.complete=function(){if(opt.queue!==false)jQuery(this).dequeue();if(jQuery.isFunction(opt.old))opt.old.apply(this);};return opt;},easing:{linear:function(p,n,firstNum,diff){return firstNum+diff*p;},swing:function(p,n,firstNum,diff){return((-Math.cos(p*Math.PI)/2)+0.5)*diff+firstNum;}},timers:[],timerId:null,fx:function(elem,options,prop){this.options=options;this.elem=elem;this.prop=prop;if(!options.orig)options.orig={};}});jQuery.fx.prototype={update:function(){if(this.options.step)this.options.step.apply(this.elem,[this.now,this]);(jQuery.fx.step[this.prop]||jQuery.fx.step._default)(this);if(this.prop=="height"||this.prop=="width")this.elem.style.display="block";},cur:function(force){if(this.elem[this.prop]!=null&&this.elem.style[this.prop]==null)return this.elem[this.prop];var r=parseFloat(jQuery.css(this.elem,this.prop,force));return r&&r>-10000?r:parseFloat(jQuery.curCSS(this.elem,this.prop))||0;},custom:function(from,to,unit){this.startTime=(new Date()).getTime();this.start=from;this.end=to;this.unit=unit||this.unit||"px";this.now=this.start;this.pos=this.state=0;this.update();var self=this;function t(gotoEnd){return self.step(gotoEnd);}t.elem=this.elem;jQuery.timers.push(t);if(jQuery.timerId==null){jQuery.timerId=setInterval(function(){var timers=jQuery.timers;for(var i=0;i<timers.length;i++)if(!timers[i]())timers.splice(i--,1);if(!timers.length){clearInterval(jQuery.timerId);jQuery.timerId=null;}},13);}},show:function(){this.options.orig[this.prop]=jQuery.attr(this.elem.style,this.prop);this.options.show=true;this.custom(0,this.cur());if(this.prop=="width"||this.prop=="height")this.elem.style[this.prop]="1px";jQuery(this.elem).show();},hide:function(){this.options.orig[this.prop]=jQuery.attr(this.elem.style,this.prop);this.options.hide=true;this.custom(this.cur(),0);},step:function(gotoEnd){var t=(new Date()).getTime();if(gotoEnd||t>this.options.duration+this.startTime){this.now=this.end;this.pos=this.state=1;this.update();this.options.curAnim[this.prop]=true;var done=true;for(var i in this.options.curAnim)if(this.options.curAnim[i]!==true)done=false;if(done){if(this.options.display!=null){this.elem.style.overflow=this.options.overflow;this.elem.style.display=this.options.display;if(jQuery.css(this.elem,"display")=="none")this.elem.style.display="block";}if(this.options.hide)this.elem.style.display="none";if(this.options.hide||this.options.show)for(var p in this.options.curAnim)jQuery.attr(this.elem.style,p,this.options.orig[p]);}if(done&&jQuery.isFunction(this.options.complete))this.options.complete.apply(this.elem);return false;}else{var n=t-this.startTime;this.state=n/this.options.duration;this.pos=jQuery.easing[this.options.easing||(jQuery.easing.swing?"swing":"linear")](this.state,n,0,1,this.options.duration);this.now=this.start+((this.end-this.start)*this.pos);this.update();}return true;}};jQuery.fx.step={scrollLeft:function(fx){fx.elem.scrollLeft=fx.now;},scrollTop:function(fx){fx.elem.scrollTop=fx.now;},opacity:function(fx){jQuery.attr(fx.elem.style,"opacity",fx.now);},_default:function(fx){fx.elem.style[fx.prop]=fx.now+fx.unit;}};jQuery.fn.offset=function(){var left=0,top=0,elem=this[0],results;if(elem)with(jQuery.browser){var parent=elem.parentNode,offsetChild=elem,offsetParent=elem.offsetParent,doc=elem.ownerDocument,safari2=safari&&parseInt(version)<522&&!/adobeair/i.test(userAgent),fixed=jQuery.css(elem,"position")=="fixed";if(elem.getBoundingClientRect){var box=elem.getBoundingClientRect();add(box.left+Math.max(doc.documentElement.scrollLeft,doc.body.scrollLeft),box.top+Math.max(doc.documentElement.scrollTop,doc.body.scrollTop));add(-doc.documentElement.clientLeft,-doc.documentElement.clientTop);}else{add(elem.offsetLeft,elem.offsetTop);while(offsetParent){add(offsetParent.offsetLeft,offsetParent.offsetTop);if(mozilla&&!/^t(able|d|h)$/i.test(offsetParent.tagName)||safari&&!safari2)border(offsetParent);if(!fixed&&jQuery.css(offsetParent,"position")=="fixed")fixed=true;offsetChild=/^body$/i.test(offsetParent.tagName)?offsetChild:offsetParent;offsetParent=offsetParent.offsetParent;}while(parent&&parent.tagName&&!/^body|html$/i.test(parent.tagName)){if(!/^inline|table.*$/i.test(jQuery.css(parent,"display")))add(-parent.scrollLeft,-parent.scrollTop);if(mozilla&&jQuery.css(parent,"overflow")!="visible")border(parent);parent=parent.parentNode;}if((safari2&&(fixed||jQuery.css(offsetChild,"position")=="absolute"))||(mozilla&&jQuery.css(offsetChild,"position")!="absolute"))add(-doc.body.offsetLeft,-doc.body.offsetTop);if(fixed)add(Math.max(doc.documentElement.scrollLeft,doc.body.scrollLeft),Math.max(doc.documentElement.scrollTop,doc.body.scrollTop));}results={top:top,left:left};}function border(elem){add(jQuery.curCSS(elem,"borderLeftWidth",true),jQuery.curCSS(elem,"borderTopWidth",true));}function add(l,t){left+=parseInt(l)||0;top+=parseInt(t)||0;}return results;};})();
/**
* hoverIntent is similar to jQuery's built-in "hover" function except that
* instead of firing the onMouseOver event immediately, hoverIntent checks
* to see if the user's mouse has slowed down (beneath the sensitivity
* threshold) before firing the onMouseOver event.
* 
* hoverIntent r5 // 2007.03.27 // jQuery 1.1.2
* <http://cherne.net/brian/resources/jquery.hoverIntent.html>
* 
* hoverIntent is currently available for use in all personal or commercial 
* projects under both MIT and GPL licenses. This means that you can choose 
* the license that best suits your project, and use it accordingly.
* 
* // basic usage (just like .hover) receives onMouseOver and onMouseOut functions
* $("ul li").hoverIntent( showNav , hideNav );
* 
* // advanced usage receives configuration object only
* $("ul li").hoverIntent({
*	sensitivity: 2, // number = sensitivity threshold (must be 1 or higher)
*	interval: 50,   // number = milliseconds of polling interval
*	over: showNav,  // function = onMouseOver callback (required)
*	timeout: 100,   // number = milliseconds delay before onMouseOut function call
*	out: hideNav    // function = onMouseOut callback (required)
* });
* 
* @param  f  onMouseOver function || An object with configuration options
* @param  g  onMouseOut function  || Nothing (use configuration options object)
* @return    The object (aka "this") that called hoverIntent, and the event object
* @author    Brian Cherne <brian@cherne.net>
*/
(function($) {
	$.fn.hoverIntent = function(f,g) {
		// default configuration options
		var cfg = {
			sensitivity: 7,
			interval: 100,
			timeout: 0
		};
		// override configuration options with user supplied object
		cfg = $.extend(cfg, g ? { over: f, out: g } : f );

		// instantiate variables
		// cX, cY = current X and Y position of mouse, updated by mousemove event
		// pX, pY = previous X and Y position of mouse, set by mouseover and polling interval
		var cX, cY, pX, pY;

		// A private function for getting mouse position
		var track = function(ev) {
			cX = ev.pageX;
			cY = ev.pageY;
		};

		// A private function for comparing current and previous mouse position
		var compare = function(ev,ob) {
			ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t);
			// compare mouse positions to see if they've crossed the threshold
			if ( ( Math.abs(pX-cX) + Math.abs(pY-cY) ) < cfg.sensitivity ) {
				$(ob).unbind("mousemove",track);
				// set hoverIntent state to true (so mouseOut can be called)
				ob.hoverIntent_s = 1;
				return cfg.over.apply(ob,[ev]);
			} else {
				// set previous coordinates for next time
				pX = cX; pY = cY;
				// use self-calling timeout, guarantees intervals are spaced out properly (avoids JavaScript timer bugs)
				ob.hoverIntent_t = setTimeout( function(){compare(ev, ob);} , cfg.interval );
			}
		};

		// A private function for delaying the mouseOut function
		var delay = function(ev,ob) {
			ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t);
			ob.hoverIntent_s = 0;
			return cfg.out.apply(ob,[ev]);
		};

		// A private function for handling mouse 'hovering'
		var handleHover = function(e) {
			// next three lines copied from jQuery.hover, ignore children onMouseOver/onMouseOut
			var p = (e.type == "mouseover" ? e.fromElement : e.toElement) || e.relatedTarget;
			while ( p && p != this ) { try { p = p.parentNode; } catch(e) { p = this; } }
			if ( p == this ) { return false; }

			// copy objects to be passed into t (required for event object to be passed in IE)
			var ev = jQuery.extend({},e);
			var ob = this;

			// cancel hoverIntent timer if it exists
			if (ob.hoverIntent_t) { ob.hoverIntent_t = clearTimeout(ob.hoverIntent_t); }

			// else e.type == "onmouseover"
			if (e.type == "mouseover") {
				// set "previous" X and Y position based on initial entry point
				pX = ev.pageX; pY = ev.pageY;
				// update "current" X and Y position based on mousemove
				$(ob).bind("mousemove",track);
				// start polling interval (self-calling timeout) to compare mouse coordinates over time
				if (ob.hoverIntent_s != 1) { ob.hoverIntent_t = setTimeout( function(){compare(ev,ob);} , cfg.interval );}

			// else e.type == "onmouseout"
			} else {
				// unbind expensive mousemove event
				$(ob).unbind("mousemove",track);
				// if hoverIntent state is true, then call the mouseOut function after the specified delay
				if (ob.hoverIntent_s == 1) { ob.hoverIntent_t = setTimeout( function(){delay(ev,ob);} , cfg.timeout );}
			}
		};

		// bind the function to the two event listeners
		return this.mouseover(handleHover).mouseout(handleHover);
	};
})(jQuery);
/*
 * Tabs 3 - New Wave Tabs
 *
 * Copyright (c) 2007 Klaus Hartl (stilbuero.de)
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 * http://docs.jquery.com/UI/Tabs
 */

(function($) {

    // if the UI scope is not availalable, add it
    $.ui = $.ui || {};

    // tabs API methods
    $.fn.tabs = function() {
        var method = typeof arguments[0] == 'string' && arguments[0];
        var args = method && Array.prototype.slice.call(arguments, 1) || arguments;

        return this.each(function() {
            if (method) {
                var tabs = $.data(this, 'ui-tabs');
                tabs[method].apply(tabs, args);
            } else
                new $.ui.tabs(this, args[0] || {});
        });
    };

    // tabs class
    $.ui.tabs = function(el, options) {
        var self = this;

        this.element = el;

        this.options = $.extend({

            // basic setup
            selected: 0,
            unselect: options.selected === null,
            event: 'click',
            disabled: [],
            cookie: null, // pass options object as expected by cookie plugin: { expires: 7, path: '/', domain: 'jquery.com', secure: true }
            // TODO bookmarkable: $.ajaxHistory ? true : false,

            // Ajax
            spinner: 'Loading&#8230;',
            cache: false,
            idPrefix: 'ui-tabs-',
            ajaxOptions: {},

            // animations
            fx: null, /* e.g. { height: 'toggle', opacity: 'toggle', duration: 200 } */

            // templates
            tabTemplate: '<li><a href="#{href}"><span>#{label}</span></a></li>',
            panelTemplate: '<div></div>',

            // CSS classes
            navClass: 'ui-tabs-nav',
            selectedClass: 'ui-tabs-selected',
            unselectClass: 'ui-tabs-unselect',
            disabledClass: 'ui-tabs-disabled',
            panelClass: 'ui-tabs-panel',
            hideClass: 'ui-tabs-hide',
            loadingClass: 'ui-tabs-loading'

        }, options);

        this.options.event += '.ui-tabs'; // namespace event
        this.options.cookie = $.cookie && $.cookie.constructor == Function && this.options.cookie;

        $(el).bind('setData.ui-tabs', function(event, key, value) {
            self.options[key] = value;
            this.tabify();
        }).bind('getData.ui-tabs', function(event, key) {
            return self.options[key];
        });

        // save instance for later
        $.data(el, 'ui-tabs', this);

        // create tabs
        this.tabify(true);
    };

    // instance methods
    $.extend($.ui.tabs.prototype, {
        tabId: function(a) {
            return a.title && a.title.replace(/\s/g, '_').replace(/[^A-Za-z0-9\-_:\.]/g, '')
                || this.options.idPrefix + $.data(a);
        },
        ui: function(tab, panel) {
            return {
                instance: this,
                options: this.options,
                tab: tab,
                panel: panel
            };
        },
        tabify: function(init) {

            this.$lis = $('li:has(a[href])', this.element);
            this.$tabs = this.$lis.map(function() { return $('a', this)[0]; });
            this.$panels = $([]);

            var self = this, o = this.options;

            this.$tabs.each(function(i, a) {
                // inline tab
                if (a.hash && a.hash.replace('#', '')) // Safari 2 reports '#' for an empty hash
                    self.$panels = self.$panels.add(a.hash);
                // remote tab
                else if ($(a).attr('href') != '#') { // prevent loading the page itself if href is just "#"
                    $.data(a, 'href.ui-tabs', a.href); // required for restore on destroy
                    $.data(a, 'load.ui-tabs', a.href); // mutable
                    var id = self.tabId(a);
                    a.href = '#' + id;
                    var $panel = $('#' + id);
                    if (!$panel.length) {
                        $panel = $(o.panelTemplate).attr('id', id).addClass(o.panelClass)
                            .insertAfter( self.$panels[i - 1] || self.element );
                        $panel.data('destroy.ui-tabs', true);
                    }
                    self.$panels = self.$panels.add( $panel );
                }
                // invalid tab href
                else
                    o.disabled.push(i + 1);
            });

            if (init) {

                // attach necessary classes for styling if not present
                $(this.element).hasClass(o.navClass) || $(this.element).addClass(o.navClass);
                this.$panels.each(function() {
                    var $this = $(this);
                    $this.hasClass(o.panelClass) || $this.addClass(o.panelClass);
                });

                // disabled tabs
                for (var i = 0, index; index = o.disabled[i]; i++)
                    this.disable(index);

                // Try to retrieve selected tab:
                // 1. from fragment identifier in url if present
                // 2. from cookie
                // 3. from selected class attribute on <li>
                // 4. otherwise use given "selected" option
                // 5. check if tab is disabled
                this.$tabs.each(function(i, a) {
                    if (location.hash) {
                        if (a.hash == location.hash) {
                            o.selected = i;
                            // prevent page scroll to fragment
                            //if (($.browser.msie || $.browser.opera) && !o.remote) {
                            if ($.browser.msie || $.browser.opera) {
                                var $toShow = $(location.hash), toShowId = $toShow.attr('id');
                                $toShow.attr('id', '');
                                setTimeout(function() {
                                    $toShow.attr('id', toShowId); // restore id
                                }, 500);
                            }
                            scrollTo(0, 0);
                            return false; // break
                        }
                    } else if (o.cookie) {
                        var index = parseInt($.cookie('ui-tabs' + $.data(self.element)),10);
                        if (index && self.$tabs[index]) {
                            o.selected = index;
                            return false; // break
                        }
                    } else if ( self.$lis.eq(i).hasClass(o.selectedClass) ) {
                        o.selected = i;
                        return false; // break
                    }
                });
                var n = this.$lis.length;
                while (this.$lis.eq(o.selected).hasClass(o.disabledClass) && n) {
                    o.selected = ++o.selected < this.$lis.length ? o.selected : 0;
                    n--;
                }
                if (!n) // all tabs disabled, set option unselect to true
                    o.unselect = true;

                // highlight selected tab
                this.$panels.addClass(o.hideClass);
                this.$lis.removeClass(o.selectedClass);
                if (!o.unselect) {
                    this.$panels.eq(o.selected).show().removeClass(o.hideClass); // use show and remove class to show in any case no matter how it has been hidden before
                    this.$lis.eq(o.selected).addClass(o.selectedClass);
                }

                // load if remote tab
                var href = !o.unselect && $.data(this.$tabs[o.selected], 'load.ui-tabs');
                if (href)
                    this.load(o.selected, href);

                // disable click if event is configured to something else
                if (!(/^click/).test(o.event))
                    this.$tabs.bind('click', function(e) { e.preventDefault(); });

            }

            var hideFx, showFx, baseFx = { 'min-width': 0, duration: 1 }, baseDuration = 'normal';
            if (o.fx && o.fx.constructor == Array)
                hideFx = o.fx[0] || baseFx, showFx = o.fx[1] ||baseFx;
            else
                hideFx = showFx = o.fx ||baseFx;

            // reset some styles to maintain print style sheets etc.
            var resetCSS = { display: '', overflow: '', height: '' };
            if (!$.browser.msie) // not in IE to prevent ClearType font issue
                resetCSS.opacity = '';

            // Hide a tab, animation prevents browser scrolling to fragment,
            // $show is optional.
            function hideTab(clicked, $hide, $show) {
                $hide.animate(hideFx, hideFx.duration || baseDuration, function() { //
                    $hide.addClass(o.hideClass).css(resetCSS); // maintain flexible height and accessibility in print etc.
                    if ($.browser.msie && hideFx.opacity)
                        $hide[0].style.filter = '';
                    if ($show)
                        showTab(clicked, $show, $hide);
                });
            }

            // Show a tab, animation prevents browser scrolling to fragment,
            // $hide is optional.
            function showTab(clicked, $show, $hide) {
                if (showFx === baseFx)
                    $show.css('display', 'block'); // prevent occasionally occuring flicker in Firefox cause by gap between showing and hiding the tab panels
                $show.animate(showFx, showFx.duration || baseDuration, function() {
                    $show.removeClass(o.hideClass).css(resetCSS); // maintain flexible height and accessibility in print etc.
                    if ($.browser.msie && showFx.opacity)
                        $show[0].style.filter = '';

                    // callback
                    $(self.element).triggerHandler("show.ui-tabs", [self.ui(clicked, $show[0])]);

                });
            }

            // switch a tab
            function switchTab(clicked, $li, $hide, $show) {
                /*if (o.bookmarkable && trueClick) { // add to history only if true click occured, not a triggered click
                    $.ajaxHistory.update(clicked.hash);
                }*/
                $li.addClass(o.selectedClass)
                    .siblings().removeClass(o.selectedClass);
                hideTab(clicked, $hide, $show);
            }

            // attach tab event handler, unbind to avoid duplicates from former tabifying...
            this.$tabs.unbind(o.event).bind(o.event, function() {

                //var trueClick = e.clientX; // add to history only if true click occured, not a triggered click
                var $li = $(this).parents('li:eq(0)'),
                    $hide = self.$panels.filter(':visible'),
                    $show = $(this.hash);

                // If tab is already selected and not unselectable or tab disabled or click callback returns false stop here.
                // Check if click handler returns false last so that it is not executed for a disabled tab!
                if (($li.hasClass(o.selectedClass) && !o.unselect) || $li.hasClass(o.disabledClass)
                    || $(self.element).triggerHandler("select.ui-tabs", [self.ui(this, $show[0])]) === false) {
                    this.blur();
                    return false;
                }

                self.options.selected = self.$tabs.index(this);

                // if tab may be closed
                if (o.unselect) {
                    if ($li.hasClass(o.selectedClass)) {
                        self.options.selected = null;
                        $li.removeClass(o.selectedClass);
                        self.$panels.stop();
                        hideTab(this, $hide);
                        this.blur();
                        return false;
                    } else if (!$hide.length) {
                        self.$panels.stop();
                        var a = this;
                        self.load(self.$tabs.index(this), function() {
                            $li.addClass(o.selectedClass).addClass(o.unselectClass);
                            showTab(a, $show);
                        });
                        this.blur();
                        return false;
                    }
                }

                if (o.cookie)
                    $.cookie('ui-tabs' + $.data(self.element), self.options.selected, o.cookie);

                // stop possibly running animations
                self.$panels.stop();

                // show new tab
                if ($show.length) {

                    // prevent scrollbar scrolling to 0 and than back in IE7, happens only if bookmarking/history is enabled
                    /*if ($.browser.msie && o.bookmarkable) {
                        var showId = this.hash.replace('#', '');
                        $show.attr('id', '');
                        setTimeout(function() {
                            $show.attr('id', showId); // restore id
                        }, 0);
                    }*/

                    var a = this;
                    self.load(self.$tabs.index(this), function() {
                        switchTab(a, $li, $hide, $show);
                    });

                    // Set scrollbar to saved position - need to use timeout with 0 to prevent browser scroll to target of hash
                    /*var scrollX = window.pageXOffset || document.documentElement && document.documentElement.scrollLeft || document.body.scrollLeft || 0;
                    var scrollY = window.pageYOffset || document.documentElement && document.documentElement.scrollTop || document.body.scrollTop || 0;
                    setTimeout(function() {
                        scrollTo(scrollX, scrollY);
                    }, 0);*/

                } else
                    throw 'jQuery UI Tabs: Mismatching fragment identifier.';

                // Prevent IE from keeping other link focussed when using the back button
                // and remove dotted border from clicked link. This is controlled in modern
                // browsers via CSS, also blur removes focus from address bar in Firefox
                // which can become a usability and annoying problem with tabsRotate.
                if ($.browser.msie)
                    this.blur();

                //return o.bookmarkable && !!trueClick; // convert trueClick == undefined to Boolean required in IE
                return false;

            });

        },
        add: function(url, label, index) {
            if (url && label) {
                index = index || this.$tabs.length; // append by default

                var o = this.options;
                var $li = $(o.tabTemplate.replace(/#\{href\}/, url).replace(/#\{label\}/, label));
                $li.data('destroy.ui-tabs', true);

                var id = url.indexOf('#') == 0 ? url.replace('#', '') : this.tabId( $('a:first-child', $li)[0] );

                // try to find an existing element before creating a new one
                var $panel = $('#' + id);
                if (!$panel.length) {
                    $panel = $(o.panelTemplate).attr('id', id)
                        .addClass(o.panelClass).addClass(o.hideClass);
                    $panel.data('destroy.ui-tabs', true);
                }
                if (index >= this.$lis.length) {
                    $li.appendTo(this.element);
                    $panel.appendTo(this.element.parentNode);
                } else {
                    $li.insertBefore(this.$lis[index]);
                    $panel.insertBefore(this.$panels[index]);
                }

                this.tabify();

                if (this.$tabs.length == 1) {
                     $li.addClass(o.selectedClass);
                     $panel.removeClass(o.hideClass);
                     var href = $.data(this.$tabs[0], 'load.ui-tabs');
                     if (href)
                         this.load(index, href);
                }

                // callback
                $(this.element).triggerHandler("add.ui-tabs",
                    [this.ui(this.$tabs[index], this.$panels[index])]
                );

            } else
                throw 'jQuery UI Tabs: Not enough arguments to add tab.';
        },
        remove: function(index) {
            if (index && index.constructor == Number) {
                var o = this.options, $li = this.$lis.eq(index).remove(),
                    $panel = this.$panels.eq(index).remove();

                // If selected tab was removed focus tab to the right or
                // tab to the left if last tab was removed.
                if ($li.hasClass(o.selectedClass) && this.$tabs.length > 1)
                    this.click(index + (index < this.$tabs.length ? 1 : -1));
                this.tabify();

                // callback
                $(this.element).triggerHandler("remove.ui-tabs",
                    [this.ui($li.find('a')[0], $panel[0])]
                );

            }
        },
        enable: function(index) {
            var self = this, o = this.options, $li = this.$lis.eq(index);
            $li.removeClass(o.disabledClass);
            if ($.browser.safari) { // fix disappearing tab (that used opacity indicating disabling) after enabling in Safari 2...
                $li.css('display', 'inline-block');
                setTimeout(function() {
                    $li.css('display', 'block');
                }, 0);
            }

            o.disabled = $.map(this.$lis.filter('.' + o.disabledClass),
                function(n, i) { return self.$lis.index(n); } );

            // callback
            $(this.element).triggerHandler("enable.ui-tabs",
                [this.ui(this.$tabs[index], this.$panels[index])]
            );

        },
        disable: function(index) {
            var self = this, o = this.options;
            this.$lis.eq(index).addClass(o.disabledClass);

            o.disabled = $.map(this.$lis.filter('.' + o.disabledClass),
                function(n, i) { return self.$lis.index(n); } );

            // callback
            $(this.element).triggerHandler("disable.ui-tabs",
                [this.ui(this.$tabs[index], this.$panels[index])]
            );

        },
        select: function(index) {
            if (typeof index == 'string')
                index = this.$tabs.index( this.$tabs.filter('[href$=' + index + ']')[0] );
            this.$tabs.eq(index).trigger(this.options.event);
        },
        load: function(index, callback) { // callback is for internal usage only
            var self = this, o = this.options,
                $a = this.$tabs.eq(index), a = $a[0];

            var url = $a.data('load.ui-tabs');

            // no remote - just finish with callback
            if (!url) {
                typeof callback == 'function' && callback();
                return;
            }

            // load remote from here on
            if (o.spinner) {
                var $span = $('span', a), label = $span.html();
                $span.html('<em>' + o.spinner + '</em>');
            }
            var finish = function() {
                self.$tabs.filter('.' + o.loadingClass).each(function() {
                    $(this).removeClass(o.loadingClass);
                    if (o.spinner)
                        $('span', this).html(label);
                });
                self.xhr = null;
            };
            var ajaxOptions = $.extend({}, o.ajaxOptions, {
                url: url,
                success: function(r, s) {
                    $(a.hash).html(r);
                    finish();
                    // This callback is required because the switch has to take
                    // place after loading has completed.
                    typeof callback == 'function' && callback();

                    if (o.cache)
                        $.removeData(a, 'load.ui-tabs'); // if loaded once do not load them again

                    // callback
                    $(self.element).triggerHandler("load.ui-tabs",
                        [self.ui(self.$tabs[index], self.$panels[index])]
                    );

                    o.ajaxOptions.success && o.ajaxOptions.success(r, s);
                }
            });
            if (this.xhr) {
                // terminate pending requests from other tabs and restore tab label
                this.xhr.abort();
                finish();
            }
            $a.addClass(o.loadingClass);
            setTimeout(function() { // timeout is again required in IE, "wait" for id being restored
                self.xhr = $.ajax(ajaxOptions);
            }, 0);

        },
        url: function(index, url) {
            this.$tabs.eq(index).data('load.ui-tabs', url);
        },
        destroy: function() {
            var o = this.options;
            $(this.element).unbind('.ui-tabs')
                .removeClass(o.navClass).removeData('ui-tabs');
            this.$tabs.each(function() {
                var href = $.data(this, 'href.ui-tabs');
                if (href)
                    this.href = href;
                $(this).unbind('.ui-tabs')
                    .removeData('href.ui-tabs').removeData('load.ui-tabs');
            });
            this.$lis.add(this.$panels).each(function() {
                if ($.data(this, 'destroy.ui-tabs'))
                    $(this).remove();
                else
                    $(this).removeClass([o.selectedClass, o.unselectClass,
                        o.disabledClass, o.panelClass, o.hideClass].join(' '));
            });
        }
    });

})(jQuery);

jQuery.noConflict();
/**
* oFrame - frame object
* oDim - "Width" or "Height"
*/ 
function getFrameSize(oFrame,oDim) {
 if(oFrame['inner'+oDim]) {
   return oFrame['inner'+oDim]; }
 oFrame = oFrame.document;
 if(oFrame.documentElement&&oFrame.documentElement['client'+oDim]) {
   return oFrame.documentElement['client'+oDim]; }
 if(oFrame.body&&oFrame.body['client'+oDim]) {
   return oFrame.body['client'+oDim]; }
 return 0;
}

function getSelectedItemIdx(){
      var selectedIdx=Array();
      var i=0,j;
      var itemIdObjs=document.getElementsByName("selectedItemIdx");
      if ( itemIdObjs !=null ){
      	 if (itemIdObjs.length!=null){
		      for(j=0;j< itemIdObjs.length;j++){
	          	if( itemIdObjs[j].checked==true){
	              	     selectedIdx[i++]= j;
	          	}
      	      }
      	 }else{
      	     // only one item
      	     if( itemIdObjs.checked==true){
              	 selectedIdx[0]= 0;
             }
      	 }
      }else{
      }
      
      return selectedIdx;
  }
function onResizeWindow(){
 /* handle resize window event 
 	Find in documents whose name is "resizableDiv", resize that div element to window size - 20
 */
 var control=document.getElementById("resizableDiv");
 
 if(control!=null){
	if(control.length!=null){
		//array
		for(i=0;i<control.length;i++){
			try{
				eval("resizeDiv_"+control[i].attributes("name").value+"(control[i]);");
			}catch(ex){
				//alert("Script error when resize div:"+ex.message);
			}
        }

	}else{
		//element one
		try{
			eval("resizeDiv_"+control.attributes("name").value+"(control);");
		}catch(ex){
			//alert("Script error when resize div:"+ex.message);
		}
	}
 }
 
 
}

function resize_img_by_wheel(o){
	/* param o - image object 
	sample:  <img name="imagedoc" src="inv003.jpg" onload="if(this.width>200)this.width=200;"  onmousewheel="resize_img_by_wheel(this);"> 	
	*/
    var zoom=parseInt(o.style.zoom, 10)||100;
    zoom+=event.wheelDelta/12;
    if (zoom>0) 
        o.style.zoom=zoom+'%';
        return false;
}
function isValidDate(strDate){
	strDate=String(strDate);
	var dteDate;
	var day, month, year;
	if (strDate.length==8 && !isNaN(parseInt(strDate,10))){
		year =parseInt(strDate.substr(0,4),10);
		month =parseInt(strDate.substr(4,2),10)-1;
		day=parseInt(strDate.substr(6,2),10);
	}else{
		var datePat = /^(\d{1,4})(\/)(\d{1,2})(\/)(\d{2})$/;
		var matchArray = strDate.match(datePat);
		
		if (matchArray == null)
		return false;
		
		year = matchArray[1]; // p@rse date into variables
		month = matchArray[3];
		day = matchArray[5];
		month--;
	}
	dteDate=new Date(year,month,day);
	return ((day==dteDate.getDate()) && (month==dteDate.getMonth()) && (year==dteDate.getFullYear()));
}
// Object type
function checkIsObject(o) {
  return (typeof(o)=="object");
}
function checkIsArray(o) {
  return (checkIsObject(o) && (o.length) &&(!checkIsString(o)));
}
function isSelectInputArray(o){
	// above has a bug on input type select, that also has property .length
	return (checkIsArray(o) && o[0].options!=undefined);
}
function isFunction(o) {
  return (typeof(o)=="function");
}
function checkIsString(o) {
  return (typeof(o)=="string");
}
function pop_up(url, window_name){
    var newWindow=window.open(url,window_name,'dependent=yes,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,status=yes,width=780,height=500,left=0,top=0' );
    newWindow.focus();
    //window.showModalDialog(url, window, "dialogHeight=500px;dialogWidth=770px;resizable=yes;center=no;help=no;status=yes;scroll=yes");
}
function toggleButtons(form, isDisable){
	for (var i = 0; i < form.length; i++){
		var e = form.elements[i];
		if (e.type.toLowerCase() == "button" || e.type.toLowerCase() == "reset" || e.type.toLowerCase() == "submit") {
			e.disabled=isDisable;
		}
	}
}
function executeLoadedScript(el) {
	var scripts = el.getElementsByTagName("script");

	for (var i = 0; i < scripts.length; i++) {
		if (scripts[i].src) {
			var head = document.getElementsByTagName("head")[0];
			var scriptObj = document.createElement("script");

			scriptObj.setAttribute("type", "text/javascript");
			scriptObj.setAttribute("src", scripts[i].src);

			head.appendChild(scriptObj);
		}
		else {
			try {
				if (is_safari) {
					eval(scripts[i].innerHTML);
				}
				else if (is_mozilla) {
					eval(scripts[i].textContent);
				}
				else {
					eval(scripts[i].text);
				}
			}
			catch (e) {
				//alert(e);
			}
		}
	}
}  
var Column={STRING:2,NUMBER:0,DATE:1, DATENUMBER:3};
/**
 datefrom can be retrieved from eleId+"_1",
 dateto can be retrieved from eleId+"_2"
*/
function dateRangeChanged(eleId){
	var df= document.getElementById(eleId+"_1");
	var dt= document.getElementById(eleId+"_2");
	var dr= document.getElementById(eleId);
	if(df==null || dt==null) alert("daterange input construction error");
	dr.value="";
	if(df.value.length==0){
		if(dt.value.length==0){
			dr.value="";
		}else{
			if(!isValidDate(dt.value)){
				alert( gMessageHolder==undefined? dt.value+ " is not a valid date type": dt.value+" "+gMessageHolder.MUST_BE_DATE_TYPE);
			}else
				dr.value="<="+ dt.value;	
		}
	}else{
		if(!isValidDate(df.value)){
			alert( gMessageHolder==undefined? df.value+ " is not a valid date type": df.value+" "+gMessageHolder.MUST_BE_DATE_TYPE);
		}else{
			if(dt.value.length==0){
				dr.value=">="+ df.value;
			}else{
				if(!isValidDate(dt.value)){
					alert( gMessageHolder==undefined? dt.value+ " is not a valid date type": dt.value+" "+ gMessageHolder.MUST_BE_DATE_TYPE);
				}else
					dr.value=df.value+"~"+ dt.value;
			}
		}
	}
}
  	
// The code by Captain <cerebrum@iname.com>
// Mead & Company, http://www.meadroid.com/wpm/
function showProgressWnd() {
	progressBar.showBar();
	progressBar.togglePause();
}
function hideProgressWnd(){
	progressBar.togglePause();
	progressBar.hideBar();
}
function printHidden(url) {
  showProgressWnd();
  document.body.insertAdjacentHTML("beforeEnd",
    "<iframe name=printHiddenFrame width=0 height=0></iframe>");
  var doc = printHiddenFrame.document;
  doc.open();
  doc.write("<body onload=\"setTimeout('parent.onprintHiddenFrame()', 0)\">");
  doc.write("<iframe name=printMe width=0 height=0 src=\"" + url + "\"></iframe>");
  doc.write("</body>");
  doc.close();
}

function onprintHiddenFrame() {
  function onfinish() {
    printHiddenFrame.outerHTML = "";
    if ( window.onprintcomplete ) window.onprintcomplete();
    hideProgressWnd();
  }
  printFrame(printHiddenFrame.printMe, onfinish);
}  
// fake print() for IE4.x
if ( !printIsNativeSupport() )
  window.print = printFrame;

// main stuff
function printFrame(frame, onfinish) {
  if ( !frame ) frame = window;

  if ( frame.document.readyState !== "complete" &&
       !confirm("The document to print is not downloaded yet! Continue with printing?") )
  {
    if ( onfinish ) onfinish();
    return;
  }

  if ( printIsNativeSupport() ) {
    /* focus handling for this scope is IE5Beta workaround,
       should be gone with IE5 RTM.
    */
    var focused = document.activeElement; 
    frame.focus();
    frame.self.print();
    if ( onfinish ) onfinish();
    if ( focused && !focused.disabled ) focused.focus();
    return;
  }

  var eventScope = printGetEventScope(frame);
  var focused = document.activeElement;

  window.printHelper = function() {
    execScript("on error resume next: printWB.ExecWB 6, 1", "VBScript");
    printFireEvent(frame, eventScope, "onafterprint");
    printWB.outerHTML = "";
    if ( onfinish ) onfinish();
    if ( focused && !focused.disabled ) focused.focus();
    window.printHelper = null;
  }

  document.body.insertAdjacentHTML("beforeEnd",
    "<object id=\"printWB\" width=0 height=0 \
    classid=\"clsid:8856F961-340A-11D0-A96B-00C04FD705A2\"></object>");

  printFireEvent(frame, eventScope, "onbeforeprint");
  frame.focus();
  window.printHelper = printHelper;
  setTimeout("window.printHelper()", 0);
}

// helpers
function printIsNativeSupport() {
  var agent = window.navigator.userAgent;
  var i = agent.indexOf("MSIE ")+5;
  return parseInt(agent.substr(i),10) >= 5 && agent.indexOf("5.0b1") < 0;
}

function printFireEvent(frame, obj, name) {
  var handler = obj[name];
  switch ( typeof(handler) ) {
    case "string": frame.execScript(handler); break;
    case "function": handler();
  }
}

function printGetEventScope(frame) {
  var frameset = frame.document.getElementsByTagName("FRAMESET");
  if ( frameset.length ) return frameset[0];
  return frame.document.body;
}


function AjaxRequest(url, options) {
	
	var xmlHttpReq;
	var opts = options;
	var returnArgs = opts.returnArgs;
	var method = opts.method;
	var ajaxId = opts.ajaxId;

	if (window.XMLHttpRequest) {
		xmlHttpReq = new XMLHttpRequest();

		if (xmlHttpReq.overrideMimeType) {
			xmlHttpReq.overrideMimeType("text/html");
		}
	}
	else if (window.ActiveXObject) {
		try {
			xmlHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) {
			try {
				xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch (e) {
				try {
					xmlHttpReq = new XMLHttpRequest();
				}
				catch (e) {
				}
			}
		}
	}
	
	var onComplete = opts.onComplete;
	var returnFunction = function() {
			if (xmlHttpReq.readyState == 4) {
				try {
					if (xmlHttpReq.status == 200) {
						var ajaxId;
						try {
							ajaxId = xmlHttpReq.getResponseHeader("Ajax-ID");
						}
						catch (e) {
							ajaxId = "";
						}

						if (onComplete) {
							onComplete(xmlHttpReq, returnArgs);
						}
		
						if (ajaxId && ajaxId != "") {
							AjaxUtil.remove(parseInt(ajaxId));
						}
					}
				}
				catch(e) {
				}
			}
		}

	var send = function(url) {
		var urlArray = url.split("?");
		var path = urlArray[0];
		var query = urlArray[1];
		
		try {
			if (method == "get") {
				xmlHttpReq.open("GET", url, true);
				xmlHttpReq.onreadystatechange = returnFunction;
				xmlHttpReq.send("");
			}
			else {
				xmlHttpReq.open("POST", path, true);
				xmlHttpReq.setRequestHeader("Method", "POST " + path + " HTTP/1.1");
				xmlHttpReq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				xmlHttpReq.setRequestHeader("Ajax-ID", ajaxId);
				xmlHttpReq.onreadystatechange = returnFunction;
				xmlHttpReq.send(query);
			}
		}
		catch (e) {
		}
	}
	
	send(url);

	this.resend = function(url, options) {
		opts = options;
		onComplete = opts.onComplete;
		
		send(url);
	};
	
	this.getId = function() {
		return ajaxId;
	};
	
	this.cleanUp = function() {
		xmlHttpReq.onreadystatechange = function() {};
		returnFunction = null;
		returnArgs = null;
		xmlHttpReq = null;
	};
}

var AjaxUtil = {
	counter : 1,
	requests : new Array(),
	
	request : function(url, options) {
		/*
		 * OPTIONS:
		 * onComplete (function) - function to call after response is received
		 * returnArgs (object) - object to pass to return function
		 * reverseAjax (boolean) - use reverse ajax. (only one at a time)
		 * method (string) - use "get" or "post". Default is post.
		 */
		var opts = (options == null) ? (new Object()) : options;
		var ajaxId = (opts.reverseAjax) ? 0 : AjaxUtil.getNextId();
		opts.ajaxId = ajaxId;
		
		var request;
		
		if (ajaxId == 0 && AjaxUtil.requests[0]) {
			request = AjaxUtil.requests[0];
			request.resend(url, opts);
		}
		else {
			request = new AjaxRequest(url, opts);
			AjaxUtil.requests[ajaxId] = request;
		}
		
		if (!opts.onComplete) {
			AjaxUtil.remove(ajaxId);
		}
	},
	
	update : function(url, id, options) {
		var element = $(id);

		if (element) {
			if (options == null) {
				options = new Object();
			}
			
			var origOnComplete = options.onComplete;

			options.onComplete = function(xmlHttpReq, returnArgs) {
				element.innerHTML = xmlHttpReq.responseText;
				executeLoadedScript(element);

				if (origOnComplete) {
					origOnComplete();
				}
			}
			
			AjaxUtil.request(url, options);
		}
	},
	
	getNextId : function() {
		var id = AjaxUtil.counter++;

		if (AjaxUtil.counter > 20) {
			/* Reset array in a round-robin fashion */
			/* Reserve index 0 for reverse ajax requests */
			AjaxUtil.counter = 1;
		}

		return id;
	},

	remove : function(id) {
		if (id) {
			var request = AjaxUtil.requests[id];
			
			if (request) {
				request.cleanUp();
				request = null;
			}
		}
	}
}

var ReverseAjax = {
	initialize: function() {
		Event.observe(window, "unload", function() {ReverseAjax.release();});
		ReverseAjax.request();
	},
	
	request: function() {
		AjaxUtil.request(themeDisplay.getPathMain() + "/portal/reverse_ajax",
			{
				onComplete: ReverseAjax.response,
				reverseAjax: true
			});
	},
	
	response: function(xmlHttpRequest) {
		var res =$J(xmlHttpRequest.responseText);
		var status = res.status;
		
		if (status && status != "failure") {
			if (status == "success") {
				if (res.chatMessages) {
					Messaging.getChatsReturn(res.chatMessages);
				}
				if (res.chatRoster) {
					MessagingRoster.getEntriesReturn(res.chatRoster);
				}
			}

			ReverseAjax.request();
		}
	},
	
	release : function() {
		AjaxUtil.request(themeDisplay.getPathMain() + "/portal/reverse_ajax?release=1", {reverseAjax:true});
	}
}

function $J(JSONText) {
	return eval("(" + JSONText + ")");
}

function executeLoadedScript(el) {
	//alert(el.innerHTML);
	var scripts = el.getElementsByTagName("script");
	for (var i = 0; i < scripts.length; i++) {
		if (scripts[i].src) {
			var head = document.getElementsByTagName("head")[0];
			var scriptObj = document.createElement("script");

			scriptObj.setAttribute("type", "text/javascript");
			scriptObj.setAttribute("src", scripts[i].src);

			head.appendChild(scriptObj);
		}
		else {
			try {
				if (is_safari) {
					eval(scripts[i].innerHTML);
				}
				else if (is_mozilla) {
					eval(scripts[i].textContent);
				}
				else {
					//eval(scripts[i].text);
					//http://ajaxian.com/archives/evaling-with-ies-windowexecscript
				 var dj_global = this; // global scope reference
				  if (window.execScript) {
				    window.execScript(scripts[i].text); // eval in global scope for IE
				  }else{
				    if(dj_global.eval) dj_global.eval(scripts[i].text);
				    else eval(scripts[i].text);					
				  }
				}				
			}
			catch (e) {
				alert("error executeLoadedScript:"+e);
			}
		}
	}
}

function loadForm(form, action, elId, returnFunction) {
	var pos = action.indexOf("?");

	var path = action;
	var queryString = "";

	if (pos != -1) {
		path = action.substring(0, pos);
		queryString = action.substring(pos + 1, action.length);
	}

	if (!endsWith(queryString, "&")) {
		queryString += "&";
	}

	for (var i = 0; i < form.elements.length; i++) {
		var e = form.elements[i];

		if ((e.name != null) && (e.value != null)) {
			queryString += e.name + "=" + encodeURIComponent(e.value) + "&";
		}
	}

	if (elId != null) {
		document.body.style.cursor = "wait";

		pos = path.indexOf("/portal/layout");
	
		path = path.substring(0, pos) + "/portal/render_portlet";

		returnFunction =
			function (xmlHttpReq) {
				document.getElementById(elId).innerHTML = xmlHttpReq.responseText;

				document.body.style.cursor = "default";
			};
	}

	loadPage(path, queryString, returnFunction);
}

/*
 * NOTE: loadPage() has been depricated.  Use AjaxUtil.request() instead
 */
function loadPage(path, queryString, returnFunction, returnArgs) {
	AjaxUtil.request(path + "?" + queryString, {
			onComplete: returnFunction,
			returnArgs: returnArgs
		});
}

function printJSON(data) {
	if (data && data.id) {
		var target = document.getElementById(data.id);

		if (target) {
			target.innerHTML = data.toString();
		}
	}
}
/**
 * Copyright (c) 2000-2006 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

var submitCountdown = 0;

function check(form, name, checked) {
	for (var i = 0; i < form.elements.length; i++) {
		var e = form.elements[i];

		if ((e.name == name) && (e.type == "checkbox")) {
			e.checked = checked;
		}
	}
}

function checkAll(form, name, allBox) {
	if (isArray(name)) {
		for (var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];

			if (e.type == "checkbox") {
				for (var j = 0; j < name.length; j++) {
					if (e.name == name[j]) {
						e.checked = allBox.checked;
					}
				}
			}
		}
	}
	else {
		for (var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];

			if ((e.name == name) && (e.type == "checkbox")) {
				e.checked = allBox.checked;
			}
		}
	}
}

function checkAllBox(form, name, allBox) {
	var totalBoxes = 0;
	var totalOn = 0;

	if (isArray(name)) {
		for (var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];

			if ((e.name != allBox.name) && (e.type == "checkbox")) {
				for (var j = 0; j < name.length; j++) {
					if (e.name == name[j]) {
						totalBoxes++;

						if (e.checked) {
							totalOn++;
						}
					}
				}
			}
		}
	}
	else {
		for (var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];

			if ((e.name != allBox.name) && (e.name == name) && (e.type == "checkbox")) {
				totalBoxes++;

				if (e.checked) {
					totalOn++;
				}
			}
		}
	}

	if (totalBoxes == totalOn) {
		allBox.checked = true;
	}
	else {
		allBox.checked = false;
	}
}

function checkMaxLength(box, maxLength) {
	if ((box.value.length) >= maxLength) {
		box.value = box.value.substring(0, maxLength - 1);
	}
}

function checkTab(box) {
	if ((document.all) && (event.keyCode == 9)) {
		box.selection = document.selection.createRange();
		setTimeout("processTab(\"" + box.id + "\")", 0);
	}
}

function cloneObject(obj, recurse) {
    for (i in obj) {
        if (typeof obj[i] == 'object' && recurse) {
            this[i] = new cloneObject(obj[i], true);
        }
        else
            this[i] = obj[i];
    }
}

var Cookie = {
	create : function(name, value, days) {
		if (days) {
			var date = new Date();

			date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));

			var expires = "; expires=" + date.toGMTString();
		}
		else {
			var expires = "";
		}

		document.cookie = name + "=" + value + expires + "; path=/";
	},

	read : function(name) {
		var nameEQ = name + "=";

		var ca = document.cookie.split(';');

		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];

			while (c.charAt(0) == ' ') {
				c = c.substring(1, c.length);
			}

			if (c.indexOf(nameEQ) == 0) {
				return c.substring(nameEQ.length, c.length);
			}
		}

		return null;
	},

	erase : function(name) {
		createCookie(name, "", -1);
	}
}

document.createInputElement = function(name) {
	if (is_ie) {
		var entry = document.createElement("<input name='" + name + "'></input>");
	}
	else {
		var entry = document.createElement("input");
		entry.name = name;
	}

	return entry;
}

function disableEsc() {
	if ((document.all) && (event.keyCode == 27)) {
		event.returnValue = false;
	}
}

if (!Element) Element = new Object();

Element.disable = function(element) {
	element = $(element);
	var items = element.getElementsByTagName("*");

	for (var i = 0; i < items.length; i++) {
		var item = items[i];
		var nodeName = item.nodeName.toLowerCase();

		item.onclick = function() {};
		item.onmouseover = function() {};
		item.onmouseout = function() {};

		if (is_ie) {
			item.onmouseenter = function() {};
			item.onmouseleave = function() {};
		}

		if (nodeName == "a") {
			item.href = "javascript: void(0)";
		}
		else if (nodeName == "input" || nodeName == "select" || nodeName == "script") {
			item.disabled = "true";
		}
		else if (nodeName == "form") {
			item.action = "";
			item.onsubmit = function() { return false; };
		}

		item.style.cursor = "default";
	}
}

Element.changeOpacity = function(object, opacity) {
	opacity = (opacity >= 100) ? 99.999 : opacity;
	opacity = (opacity < 0) ? 0 : opacity;

	object.style.opacity = (opacity / 100);
	object.style.MozOpacity = (opacity / 100);
	object.style.KhtmlOpacity = (opacity / 100);
	object.style.filter = "alpha(opacity=" + opacity + ")";
}


if (!Event) Event = new Object();

Event.addHandler = function(obj, type, func) {
	if (type.indexOf("on") != 0) {
		type = "on" + type;
	}

    var temp = obj[type];

	if (typeof obj[type] != "function") {
        obj[type] = func;
    }
	else {
        obj[type] = function() {
        	if (temp) {
	            temp();
        	}

			func();
        }
    }
}

Event.enterPressed = function(event) {
	if (!event) {
		event = window.event;
	}
	var keycode = event.keyCode;

	if (keycode == 13) {
		return true;
	}
	else {
		return false;
	}
}


function getSelectedIndex(col) {
	for (var i = 0; i < col.length; i++) {
		if (col[i].checked == true) {
			return i;
		}
	}

	return -1;
}

function getSelectedRadioName(col) {
	var i = getSelectedIndex(col);

	if (i == -1) {
		var radioName = col.name;

		if (radioName == null) {
			radioName = "";
		}

		return radioName;
	}
	else {
		return col[i].name;
	}
}

function getSelectedRadioValue(col) {
	var i = getSelectedIndex(col);

	if (i == -1) {
		var radioValue = col.value;

		if (radioValue == null) {
			radioValue = "";
		}

		return radioValue;
	}
	else {
		return col[i].value;
	}
}

function isArray(object) {
	if (!window.Array) {
		return false;
	}
	else {
		return object.constructor == window.Array;
	}
}

function LinkedList() {
	this.head = null;
	this.tail = null;
}

LinkedList.prototype.add = function(obj) {
	obj.listInfo = new Object();
	var tail = this.tail;
	var head = this.head;

	if (this.head == null) {
		this.head = obj;
		this.tail = obj;
	}
	else {
		this.tail.listInfo.next = obj;
		obj.listInfo.prev = this.tail;
		this.tail = obj;
	}
}

LinkedList.prototype.remove = function(obj) {
	if (this.head) {
		var next = obj.listInfo.next;
		var prev = obj.listInfo.prev;

		if (next) {
			next.listInfo.prev = prev;
		}
		if (prev) {
			prev.listInfo.next = next;
		}
		if (this.head = obj) {
			this.head = next;
		}
		if (this.tail = obj) {
			this.tail = prev;
		}
	}
}

LinkedList.prototype.each = function(func) {
	var cur = this.head;
	var count = 0;

	while (cur){
		count++;
		var next = cur.listInfo.next;

		if (func) {
			func(cur);
		}

		cur = next;
	}

	return count;
}

LinkedList.prototype.size = function() {
	return this.each();
}

function listChecked(form) {
	var s = "";

	for (var i = 0; i < form.elements.length; i++) {
		var e = form.elements[i];

		if ((e.type == "checkbox") && (e.checked == true) && (e.value > "")) {
			s += e.value + ",";
		}
	}

	return s;
}

function listCheckedExcept(form, except) {
	var s = "";

	for (var i = 0; i < form.elements.length; i++) {
		var e = form.elements[i];

		if ((e.type == "checkbox") && (e.checked == true) && (e.value > "") && (e.name.indexOf(except) != 0)) {
			s += e.value + ",";
		}
	}

	return s;
}

function listSelect(box, delimeter) {
	var s = "";

	if (delimeter == null) {
		delimeter = ",";
	}

	if (box == null) {
		return "";
	}

	for (var i = 0; i < box.length; i++) {
    	if (box.options[i].value > "") {
			s += box.options[i].value + delimeter;
		}
	}

	if (s == ".none,") {
		return "";
	}
	else {
		return s;
	}
}

function listUnchecked(form) {
	var s = "";

	for (var i = 0; i < form.elements.length; i++) {
		var e = form.elements[i];

		if ((e.type == "checkbox") && (e.checked == false) && (e.value > "")) {
			s += e.value + ",";
		}
	}

	return s;
}

function listUncheckedExcept(form, except) {
	var s = "";

	for (var i = 0; i < form.elements.length; i++) {
		var e = form.elements[i];

		if ((e.type == "checkbox") && (e.checked == false) && (e.value > "") && (e.name.indexOf(except) != 0)) {
			s += e.value + ",";
		}
	}

	return s;
}

function moveItem(fromBox, toBox, sort) {
	var newText = null;
	var newValue = null;
	var newOption = null;

	if (fromBox.selectedIndex >= 0) {
		for (var i = 0; i < fromBox.length; i++) {
			if (fromBox.options[i].selected) {
				newText = fromBox.options[i].text;
				newValue = fromBox.options[i].value;

				newOption = new Option(newText, newValue);

				toBox[toBox.length] = newOption;
			}
		}

		for (var i = 0; i < toBox.length; i++) {
			for (var j = 0; j < fromBox.length; j++) {
				if (fromBox[j].value == toBox[i].value) {
					fromBox[j] = null;

					break;
				}
			}
		}
	}

	if (newText != null) {
		if (sort == true) {
			sortBox(toBox);
		}
	}
}

function processTab(id) {
	document.all[id].selection.text = String.fromCharCode(9);
	document.all[id].focus();
}

function reelHome(id, startPosX, startPosY, duration, count, c) {
    if (isNaN(startPosX) || isNaN(startPosY)) {
        return;
	}

	var obj = document.getElementById(id);

	if (obj == null) {
		return;
	}

	var top = parseInt(obj.style.top);
	var left = parseInt(obj.style.left);

	if (count == null) {
	    count = 1;
	}

	if (duration == null) {
	    duration == 20;
	}

	if (c == null) {

		// Calculate this constant once to speed up next iteration

		c = Math.PI / (2 * duration);
		obj.style.zIndex = 10;
    }

	if (count < duration) {
	    var ratio = 1 - Math.sin(count * c);

	    // Shift cos by -PI/2 and up 1

		obj.style.left = (startPosX * ratio) + "px";
		obj.style.top = (startPosY * ratio) + "px";

		setTimeout("reelHome(\"" + id + "\"," + startPosX + "," + startPosY + "," + duration + "," + (++count) + "," + c + ")", 16);
	}
	else {
		obj.style.top = "0px";
		obj.style.left = "0px";
		obj.style.zIndex = 0;
	}
}

function removeItem(box, value) {
	if (value == null) {
		for (var i = box.length - 1; i >= 0; i--) {
			if (box.options[i].selected) {
				box[i] = null;
			}
		}
	}
	else {
		for (var i = box.length - 1; i >= 0; i--) {
			if (box.options[i].value == value) {
				box[i] = null;
			}
		}
	}
}

function reorder(box, down) {
	var si = box.selectedIndex;

	if (si == -1) {
		box.selectedIndex = 0;
	}
	else {
		sText = box.options[si].text;
		sValue = box.options[si].value;

		if ((box.options[si].value > "") && (si > 0) && (down == 0)) {
			box.options[si].text = box.options[si - 1].text;
			box.options[si].value = box.options[si - 1].value;
			box.options[si - 1].text = sText;
			box.options[si - 1].value = sValue;
			box.selectedIndex--;
		}
		else if ((si < box.length - 1) && (box.options[si + 1].value > "") && (down == 1)) {
			box.options[si].text = box.options[si + 1].text;
			box.options[si].value = box.options[si + 1].value;
			box.options[si + 1].text = sText;
			box.options[si + 1].value = sValue;
			box.selectedIndex++;
		}
		else if (si == 0) {
			for (var i = 0; i < (box.length - 1); i++) {
				box.options[i].text = box.options[i + 1].text;
				box.options[i].value = box.options[i + 1].value;
			}

			box.options[box.length - 1].text = sText;
			box.options[box.length - 1].value = sValue;

			box.selectedIndex = box.length - 1;
		}
		else if (si == (box.length - 1)) {
			for (var j = (box.length - 1); j > 0; j--) {
				box.options[j].text = box.options[j - 1].text;
				box.options[j].value = box.options[j - 1].value;
			}

			box.options[0].text = sText;
			box.options[0].value = sValue;

			box.selectedIndex = 0;
		}
	}
}

function resubmitCountdown(formName) {
	if (submitCountdown > 0) {
		submitCountdown--;

		setTimeout("resubmitCountdown('" + formName + "')", 1000);
	}
	else {
		submitCountdown = 0;

		if (!is_ns_4) {
			document.body.style.cursor = "auto";
		}

		var form = document.forms[formName];

		for (var i = 0; i < form.length; i++){
			var e = form.elements[i];

			if (e.type && (e.type.toLowerCase() == "button" || e.type.toLowerCase() == "reset" || e.type.toLowerCase() == "submit")) {
				e.disabled = false;
			}
		}
	}
}

function selectAndCopy(el) {
	el.focus();
	el.select();

	if (document.all) {
		var textRange = el.createTextRange();

		textRange.execCommand("copy");
	}
}

function setBox(oldBox, newBox) {
	for (var i = oldBox.length - 1; i > -1; i--) {
		oldBox.options[i] = null;
	}

	for (var i = 0; i < newBox.length; i++) {
		oldBox.options[i] = new Option(newBox[i].value, i);
	}

	oldBox.options[0].selected = true;
}

function setCursorPosition(oInput,oStart,oEnd) {
   if( oInput.setSelectionRange ) {
         oInput.setSelectionRange(oStart,oEnd);
     } 
     else if( oInput.createTextRange ) {
        var range = oInput.createTextRange();
        range.collapse(true);
        range.moveEnd('character',oEnd);
        range.moveStart('character',oStart);
        range.select();
     }
}

function setSelectedValue(col, value) {
	for (var i = 0; i < col.length; i++) {
		if ((col[i].value != "") && (col[i].value == value)) {
			col.selectedIndex = i;

			break;
		}
	}
}

function setSelectVisibility(mode, obj) {
	if (is_ie) {
		if (obj) {
			obj = $(obj);
		}
		else {
			obj = document.getElementsByTagName("body")[0];
		}

		selectList = obj.getElementsByTagName("select");
		for (var i = 0; i < selectList.length; i++) {
			selectList[i].style.visibility = mode;
		}
	}
}

function slideMaximize(id, height, speed) {
	var obj = document.getElementById(id);
	var reference = obj.getElementsByTagName("DIV")[0];

	height += speed;

	if (height < (reference.offsetHeight)) {
		obj.style.height = height + "px";

		setTimeout("slideMaximize(\"" + id + "\"," + height + "," + speed + ")", 10);
	}
	else {
		obj.style.overflow = "";
		obj.style.height = "";
	}
}

function slideMinimize(id, height, speed) {
	var obj = document.getElementById(id);

	height -= speed;

	if (height > 0) {
		obj.style.height = height + "px";
		setTimeout("slideMinimize(\"" + id + "\"," + height + "," + speed + ")", 10);
	}
	else {
		obj.style.display = "none";
	}
}

function sortBox(box) {
	var newBox = new Array();

	for (var i = 0; i < box.length; i++) {
		newBox[i] = new Array(box[i].value, box[i].text);
	}

	newBox.sort(sortByAscending);

	for (var i = box.length - 1; i > -1; i--) {
		box.options[i] = null;
	}

	for (var i = 0; i < newBox.length; i++) {
		box.options[box.length] = new Option(newBox[i][1], newBox[i][0]);
	}
}

function sortByAscending(a, b) {
	if (a[1].toLowerCase() > b[1].toLowerCase()) {
		return 1;
	}
	else if(a[1].toLowerCase() < b[1].toLowerCase()) {
		return -1;
	}
	else {
		return 0;
	}
}

function sortByDescending(a, b) {
	if (a[1].toLowerCase() > b[1].toLowerCase()) {
		return -1;
	}
	else if(a[1].toLowerCase() < b[1].toLowerCase()) {
		return 1;
	}
	else {
		return 0;
	}
}

function submitForm(form, action, singleSubmit) {
	if (submitCountdown == 0) {
		submitCountdown = 10;

		setTimeout("resubmitCountdown('" + form.name + "')", 1000);

		if (singleSubmit == null || singleSubmit) {
			submitCountdown++;

			for (var i = 0; i < form.length; i++){
				var e = form.elements[i];

				if (e.type && (e.type.toLowerCase() == "button" || e.type.toLowerCase() == "reset" || e.type.toLowerCase() == "submit")) {
					e.disabled = true;
				}
			}
		}

		if (action != null) {
			form.action = action;
		}

		if (!is_ns_4) {
			document.body.style.cursor = "wait";
		}

		form.submit();
	}
	else {
		if (this.submitFormAlert != null) {
  			submitFormAlert(submitCountdown);
		}
	}
}

// Netscape 4 functions

if (is_ns_4) {
	encodeURIComponent = new function(uri) {
		return escape(uri);
	};

	decodeURIComponent = new function(uri) {
		return unescape(uri);
	};
}

// String functions

function startsWith(str, x) {
	if (str.indexOf(x) == 0) {
		return true;
	}
	else {
		return false;
	}
}

function endsWith(str, x) {
	if (str.lastIndexOf(x) == str.length - x.length) {
		return true;
	}
	else {
		return false;
	}
}

function toHTML(s) {
	s = s.replace(/\&/g, "&amp;");
	s = s.replace(/</g, "&lt;");
	s = s.replace(/>/g, "&gt;");
	s = s.replace(/\n/g, "<br>");
	s = s.replace(/  /g, " &nbsp;");
	return s;
}

function toText(s) {
	s = s.replace(/\&nbsp;/gi, " ");
	s = s.replace(/<br>/gi,"\n");
	s = s.replace(/&gt;/gi,">");
	s = s.replace(/\&lt;/gi,"<");
	s = s.replace(/\&amp;/gi,"&");
	return s;
}

function toggleById(id, returnState, displayType) {
	var obj = document.getElementById(id);

	if (returnState) {
		return toggleByObject(obj, returnState, displayType);
	}
	else {
		toggleByObject(obj, null, displayType);
	}
}

function toggleByIdSpan(obj, id) {
	var hidden = toggleById(id, true);
	var spanText = obj.getElementsByTagName("span");

	if (hidden) {
		spanText[0].style.display = "none";
		spanText[1].style.display = "";
	}
	else {
		spanText[0].style.display = "";
		spanText[1].style.display = "none";
	}
}

function toggleByObject(obj, returnState, displayType) {
	var hidden = false;
	var display = "block";

	if (displayType != null) {
		display = displayType;
	}

	if (obj != null) {
		if (!obj.style.display || !obj.style.display.toLowerCase().match("none")) {
			obj.style.display = "none";
		}
		else {
			obj.style.display = display;
			hidden = true;
		}
	}

	if (returnState) {
		return hidden;
	}
}

function trimString(str) {
	str = str.replace(/^\s+/g, "").replace(/\s+$/g, "");

	var charCode = str.charCodeAt(0);

	while (charCode == 160) {
		str = str.substring(1, str.length);
		charCode = str.charCodeAt(0);
	}

	charCode = str.charCodeAt(str.length - 1);

	while (charCode == 160) {
		str = str.substring(0, str.length - 1);
		charCode = str.charCodeAt(str.length - 1);
	}

	return str;
}

String.prototype.trim = trimString;

var Viewport = {
	frame: function() {
		var x,y;
		if (self.innerHeight) // all except Explorer
		{
			x = self.innerWidth;
			y = self.innerHeight;
		}
		else if (document.documentElement && document.documentElement.clientHeight)
			// Explorer 6 Strict Mode
		{
			x = document.documentElement.clientWidth;
			y = document.documentElement.clientHeight;
		}
		else if (document.body) // other Explorers
		{
			x = document.body.clientWidth;
			y = document.body.clientHeight;
		}
		
		return (new Coordinate(x,y));
	},
	
	scroll: function() {
		var x,y;
		if (self.pageYOffset) // all except Explorer
		{
			x = self.pageXOffset;
			y = self.pageYOffset;
		}
		else if (document.documentElement && document.documentElement.scrollTop)
			// Explorer 6 Strict
		{
			x = document.documentElement.scrollLeft;
			y = document.documentElement.scrollTop;
		}
		else if (document.body) // all other Explorers
		{
			x = document.body.scrollLeft;
			y = document.body.scrollTop;
		}
		
		return (new Coordinate(x,y));
	},
	
	page: function() {
		var x,y;
		var test1 = document.body.scrollHeight;
		var test2 = document.body.offsetHeight
		if (test1 > test2) // all but Explorer Mac
		{
			x = document.body.scrollWidth;
			y = document.body.scrollHeight;
		}
		else // Explorer Mac;
		     //would also work in Explorer 6 Strict, Mozilla and Safari
		{
			x = document.body.offsetWidth;
			y = document.body.offsetHeight;
		}

		return (new Coordinate(x,y));
	}
}

var ZINDEX = {
	ALERT: 100,
	CHAT_BOX: 11,
	DRAG_ITEM: 10,
	DRAG_ARROW: 9
}

/*----------------------------------------------------------------------------\
|                          Selectable Elements 1.02                           |
|Modified to add clearSelection() method
|-----------------------------------------------------------------------------|
| Created 2002-09-04 | All changes are in the log above. | Updated 2003-02-11 |
\----------------------------------------------------------------------------*/

function SelectableElements(oElement, bMultiple) {
	if (oElement == null)
		return;

	this._htmlElement = oElement;
	this._multiple = Boolean(bMultiple);

	this._selectedItems = [];
	this._fireChange = true;

	var oThis = this;
	this._onclick = function (e) {
		if (e == null) e = oElement.ownerDocument.parentWindow.event;
		oThis.click(e);
	};
	this._ondblclick=function(ev){
		if (ev == null) ev = oElement.ownerDocument.parentWindow.event;
		oThis.dblclick(ev);
	}
	if (oElement.addEventListener){
		oElement.addEventListener("click", this._onclick, false);
		oElement.addEventListener("dblclick", this._ondblclick, false);
	}else if (oElement.attachEvent){
		oElement.attachEvent("onclick", this._onclick);
		oElement.attachEvent("ondblclick", this._ondblclick);
	}
}

SelectableElements.prototype.setItemSelected = function (oEl, bSelected) {
	if (!this._multiple) {
		if (bSelected) {
			var old = this._selectedItems[0]
			if (oEl == old)
				return;
			if (old != null)
				this.setItemSelectedUi(old, false);
			this.setItemSelectedUi(oEl, true);
			this._selectedItems = [oEl];
			this.fireChange();
		}
		else {
			if (this._selectedItems[0] == oEl) {
				this.setItemSelectedUi(oEl, false);
				this._selectedItems = [];
			}
		}
	}
	else {
		if (Boolean(oEl._selected) == Boolean(bSelected))
			return;

		this.setItemSelectedUi(oEl, bSelected);

		if (bSelected)
			this._selectedItems[this._selectedItems.length] = oEl;
		else {
			// remove
			var tmp = [];
			var j = 0;
			for (var i = 0; i < this._selectedItems.length; i++) {
				if (this._selectedItems[i] != oEl)
					tmp[j++] = this._selectedItems[i];
			}
			this._selectedItems = tmp;
		}
		this.fireChange();
	}
};

// This method updates the UI of the item
SelectableElements.prototype.setItemSelectedUi = function (oEl, bSelected) {
	if (bSelected)
		addClassName(oEl, "selected");
	else
		removeClassName(oEl, "selected");

	oEl._selected = bSelected;
};

SelectableElements.prototype.getItemSelected = function (oEl) {
	return Boolean(oEl._selected);
};

SelectableElements.prototype.fireChange = function () {
	if (!this._fireChange)
		return;
	if (typeof this.onchange == "string")
		this.onchange = new Function(this.onchange);
	if (typeof this.onchange == "function")
		this.onchange();
};

SelectableElements.prototype.dblclick = function (e) {
	// find row
	var el = e.target != null ? e.target : e.srcElement;
	while (el != null && !this.isItem(el))
		el = el.parentNode;

	if (el == null) {	// happens in IE when down and up occur on different items
		return;
	}
	if (typeof this.ondoubleclick == "function")
		this.ondoubleclick(el);
}

SelectableElements.prototype.clearSelection=function(){
		// deselect all
		var items = this._selectedItems;
		for (var i = items.length - 1; i >= 0; i--) {
			if (items[i]._selected)
				this.setItemSelectedUi(items[i], false);
		}
		this._selectedItems = [];
		if (this._fireChange)
			this.fireChange();
}
SelectableElements.prototype.click = function (e) {
	var oldFireChange = this._fireChange;
	this._fireChange = false;

	// create a copy to compare with after changes
	var selectedBefore = this.getSelectedItems();	// is a cloned array

	// find row
	var el = e.target != null ? e.target : e.srcElement;
	while (el != null && !this.isItem(el))
		el = el.parentNode;

	if (el == null) {	// happens in IE when down and up occur on different items
		this._fireChange = oldFireChange;
		return;
	}

	var rIndex = el;
	var aIndex = this._anchorIndex;

	// test whether the current row should be the anchor
	if (this._selectedItems.length == 0 || (e.ctrlKey && !e.shiftKey && this._multiple)) {
		aIndex = this._anchorIndex = rIndex;
	}

	if (!e.ctrlKey && !e.shiftKey || !this._multiple) {
		// deselect all
		var items = this._selectedItems;
		for (var i = items.length - 1; i >= 0; i--) {
			if (items[i]._selected && items[i] != el)
				this.setItemSelectedUi(items[i], false);
		}
		this._anchorIndex = rIndex;
		if (!el._selected) {
			this.setItemSelectedUi(el, true);
		}
		this._selectedItems = [el];
	}

	// ctrl
	else if (this._multiple && e.ctrlKey && !e.shiftKey) {
		this.setItemSelected(el, !el._selected);
		this._anchorIndex = rIndex;
	}

	// ctrl + shift
	else if (this._multiple && e.ctrlKey && e.shiftKey) {
		// up or down?
		var dirUp = this.isBefore(rIndex, aIndex);

		var item = aIndex;
		while (item != null && item != rIndex) {
			if (!item._selected && item != el)
				this.setItemSelected(item, true);
			item = dirUp ? this.getPrevious(item) : this.getNext(item);
		}

		if (!el._selected)
			this.setItemSelected(el, true);
	}

	// shift
	else if (this._multiple && !e.ctrlKey && e.shiftKey) {
		// up or down?
		var dirUp = this.isBefore(rIndex, aIndex);

		// deselect all
		var items = this._selectedItems;
		for (var i = items.length - 1; i >= 0; i--)
			this.setItemSelectedUi(items[i], false);
		this._selectedItems = [];

		// select items in range
		var item = aIndex;
		while (item != null) {
			this.setItemSelected(item, true);
			if (item == rIndex)
				break;
			item = dirUp ? this.getPrevious(item) : this.getNext(item);
		}
	}

	// find change!!!
	var found;
	var changed = selectedBefore.length != this._selectedItems.length;
	if (!changed) {
		for (var i = 0; i < selectedBefore.length; i++) {
			found = false;
			for (var j = 0; j < this._selectedItems.length; j++) {
				if (selectedBefore[i] == this._selectedItems[j]) {
					found = true;
					break;
				}
			}
			if (!found) {
				changed = true;
				break;
			}
		}
	}

	this._fireChange = oldFireChange;
	if (changed && this._fireChange)
		this.fireChange();
};

SelectableElements.prototype.getSelectedItems = function () {
	//clone
	var items = this._selectedItems;
	var l = items.length;
	var tmp = new Array(l);
	for (var i = 0; i < l; i++)
		tmp[i] = items[i];
	return tmp;
};

SelectableElements.prototype.isItem = function (node) {
	return node != null && node.nodeType == 1 && node.parentNode == this._htmlElement;
};

SelectableElements.prototype.destroy = function () {
	if (this._htmlElement.removeEventListener){
		this._htmlElement.removeEventListener("click", this._onclick, false);
		this._htmlElement.removeEventListener("dblclick", this._ondblclick, false);
	}else if (this._htmlElement.detachEvent){
		this._htmlElement.detachEvent("onclick", this._onclick);
		this._htmlElement.detachEvent("ondblclick", this._ondblclick);
	}

	this._htmlElement = null;
	this._onclick = null;
	this._ondblclick = null;
	this._selectedItems = null;
};

/* Traversable Collection Interface */

SelectableElements.prototype.getNext = function (el) {
	var n = el.nextSibling;
	if (n == null || this.isItem(n))
		return n;
	return this.getNext(n);
};

SelectableElements.prototype.getPrevious = function (el) {
	var p = el.previousSibling;
	if (p == null || this.isItem(p))
		return p;
	return this.getPrevious(p);
};

SelectableElements.prototype.isBefore = function (n1, n2) {
	var next = this.getNext(n1);
	while (next != null) {
		if (next == n2)
			return true;
		next = this.getNext(next);
	}
	return false;
};

/* End Traversable Collection Interface */

/* Indexable Collection Interface */

SelectableElements.prototype.getItems = function () {
	var tmp = [];
	var j = 0;
	var cs = this._htmlElement.childNodes;
	var l = cs.length;
	for (var i = 0; i < l; i++) {
		if (cs[i].nodeType == 1)
			tmp[j++] = cs[i]
	}
	return tmp;
};

SelectableElements.prototype.getItem = function (nIndex) {
	var j = 0;
	var cs = this._htmlElement.childNodes;
	var l = cs.length;
	for (var i = 0; i < l; i++) {
		if (cs[i].nodeType == 1) {
			if (j == nIndex)
				return cs[i];
			j++;
		}
	}
	return null;
};

SelectableElements.prototype.getSelectedIndexes = function () {
	var items = this.getSelectedItems();
	var l = items.length;
	var tmp = new Array(l);
	for (var i = 0; i < l; i++)
		tmp[i] = this.getItemIndex(items[i]);
	return tmp;
};


SelectableElements.prototype.getItemIndex = function (el) {
	var j = 0;
	var cs = this._htmlElement.childNodes;
	var l = cs.length;
	for (var i = 0; i < l; i++) {
		if (cs[i] == el)
			return j;
		if (cs[i].nodeType == 1)
			j++;
	}
	return -1;
};

/* End Indexable Collection Interface */



function addClassName(el, sClassName) {
	var s = el.className;
	var p = s.split(" ");
	if (p.length == 1 && p[0] == "")
		p = [];

	var l = p.length;
	for (var i = 0; i < l; i++) {
		if (p[i] == sClassName)
			return;
	}
	p[p.length] = sClassName;
	el.className = p.join(" ");
	
}

function removeClassName(el, sClassName) {
	var s = el.className;
	var p = s.split(" ");
	var np = [];
	var l = p.length;
	var j = 0;
	for (var i = 0; i < l; i++) {
		if (p[i] != sClassName)
			np[j++] = p[i];
	}
	el.className = np.join(" ");
	
}
/*Modified part in getItemIndex changed to sectionRowIndex
\----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------\
| This file requires that SelectableElements is first defined. This class can |
| be found in the file selectableelements.js at WebFX                         |
\----------------------------------------------------------------------------*/

function SelectableTableRows(oTableElement, bMultiple) {
	SelectableElements.call(this, oTableElement, bMultiple);
}
SelectableTableRows.prototype = new SelectableElements;

SelectableTableRows.prototype.isItem = function (node) {
	return node != null && node.tagName == "TR" &&
		node.parentNode.tagName == "TBODY" &&
		node.parentNode.parentNode == this._htmlElement;
};

/* Indexable Collection Interface */

SelectableTableRows.prototype.getItems = function () {
	return this._htmlElement.rows;
};

SelectableTableRows.prototype.getItemIndex = function (el) {
	return el.sectionRowIndex;
	//return el.rowIndex;
};

SelectableTableRows.prototype.getItem = function (i) {
	return this._htmlElement.rows[i];
};

/* End Indexable Collection Interface */
/**********************************************************
 Very minorly modified from the example by Tim Taylor
 http://tool-man.org/examples/sorting.html
 
 Added Coordinate.prototype.inside( northwest, southeast );
 
 **********************************************************/

var Coordinates = {
	ORIGIN : new Coordinate(0, 0),

	northwestPosition : function(element) {
		var x = parseInt(element.style.left);
		var y = parseInt(element.style.top);

		return new Coordinate(isNaN(x) ? 0 : x, isNaN(y) ? 0 : y);
	},

	southeastPosition : function(element) {
		return Coordinates.northwestPosition(element).plus(
				new Coordinate(element.offsetWidth, element.offsetHeight));
	},

	northwestOffset : function(element, isRecursive) {
		var offset = new Coordinate(element.offsetLeft, element.offsetTop);

		if (!isRecursive) return offset;

		var parent = element.offsetParent;
		while (parent) {
			offset = offset.plus(
					new Coordinate(parent.offsetLeft, parent.offsetTop));
			parent = parent.offsetParent;
		}
		return offset;
	},

	southeastOffset : function(element, isRecursive) {
		return Coordinates.northwestOffset(element, isRecursive).plus(
				new Coordinate(element.offsetWidth, element.offsetHeight));
	},

	fixEvent : function(event) {
		if (typeof event == 'undefined') {
    		event = window.event;
		}
    		
		event.windowCoordinate = new Coordinate(event.clientX, event.clientY);
		
		return event;
	}
};

function Coordinate(x, y) {
	this.x = x;
	this.y = y;
}

Coordinate.prototype.toString = function() {
	return "(" + this.x + "," + this.y + ")";
}

Coordinate.prototype.plus = function(that) {
	return new Coordinate(this.x + that.x, this.y + that.y);
}

Coordinate.prototype.minus = function(that) {
	return new Coordinate(this.x - that.x, this.y - that.y);
}

Coordinate.prototype.distance = function(that) {
	var deltaX = this.x - that.x;
	var deltaY = this.y - that.y;

	return Math.sqrt(Math.pow(deltaX, 2) + Math.pow(deltaY, 2));
}

Coordinate.prototype.max = function(that) {
	var x = Math.max(this.x, that.x);
	var y = Math.max(this.y, that.y);
	return new Coordinate(x, y);
}

Coordinate.prototype.constrain = function(min, max) {
	if (min.x > max.x || min.y > max.y) return this;

	var x = this.x;
	var y = this.y;

	if (min.x != null) x = Math.max(x, min.x);
	if (max.x != null) x = Math.min(x, max.x);
	if (min.y != null) y = Math.max(y, min.y);
	if (max.y != null) y = Math.min(y, max.y);

	return new Coordinate(x, y);
}

Coordinate.prototype.reposition = function(element) {
	element.style["top"] = this.y + "px";
	element.style["left"] = this.x + "px";
}

Coordinate.prototype.equals = function(that) {
	if (this == that) return true;
	if (!that || that == null) return false;

	return this.x == that.x && this.y == that.y;
}

// returns true of this point is inside specified box
Coordinate.prototype.inside = function(northwest, southeast) {
	if ((this.x >= northwest.x) && (this.x <= southeast.x) &&
		(this.y >= northwest.y) && (this.y <= southeast.y)) {
		
		return true;
	}
	else {
		return false;
	}
}

Coordinate.prototype.insideObject = function(obj, recurse) {
	var nwOffset = Coordinates.northwestOffset(obj, recurse);
	var seOffset = nwOffset.plus(new Coordinate(obj.offsetWidth, obj.offsetHeight));
	var rt = null
	
	if (this.inside(nwOffset, seOffset)) {
		rt = this.minus(nwOffset);
		rt.nwOffset = nwOffset;
		rt.seOffset = seOffset;
	}
	
	return rt;
}

// getMousePos(event) has been depricated.  Use mousePos.update(event) instead.
function getMousePos(event) {
    mousePos.update(event);
}

function MousePos () { };

// Extend the "Coordinate" class
MousePos.prototype = new Coordinate(0, 0);

MousePos.prototype.update = function(event) {
	event = Coordinates.fixEvent(event);
	var position = event.windowCoordinate;
	
	this.x = position.x;
	this.y = position.y;

	if (is_safari) {
		// do nothing
	}
	else  {
		this.x += document.body.scrollLeft;
		this.y += document.body.scrollTop;
	}

	if (this.x < 0)
		this.x = 0;

	if (this.y < 0)
		this.y = 0;

	return event;
}

// Track mouse's absolute position (counting scrollbars)
var mousePos = new MousePos(0,0);

/*
 * drag.js - click & drag DOM elements
 *
 * originally based on Youngpup's dom-drag.js, www.youngpup.net
 */

/**********************************************************
 Further modified from the example by Tim Taylor
 http://tool-man.org/examples/sorting.html
 
 Changed onMouseMove where it calls group.onDrag and then
 adjusts the offset for changes to the DOM.  If the item
 being moved changed parents it would be off so changed to
 get the absolute offset (recursive northwestOffset).
 
 Modified Liferay: http://www.liferay.com
 **********************************************************/

var Drag = {
	group : null,
	isDragging : false,
    /**
    * maxYPOS - if not null, only when mouse clicked on y pos below maxYPOS, will taken as beginDrag event
    *         this will be used for floating window dragging, only when clicked on title bar, will window
    *         be dragged
    *         (yfzhu added at 2006-05-24)
    */
	makeDraggable : function(group, handle, maxYPOS) {
		if(maxYPOS==null)
			group.maxYPOS=65535;
		else
			group.maxYPOS=maxYPOS;
	    if (handle == null)
    		group.handle = group;
    	else
    		group.handle = handle;
    		
		group.handle.group = group;

		group.minX = null;
		group.minY = null;
		group.maxX = null;
		group.maxY = null;
		group.threshold = 1;
		group.thresholdY = 0;
		group.thresholdX = 0;
		group.disableDrag = false;

		group.onDragStart = new Function();
		group.onDragEnd = new Function();
		group.onDrag = new Function();
		
		// TODO: use element.prototype.myFunc
		group.setAutoCorrect = function () { this.autoCorrect = true };
		group.setDragHandle = Drag.setDragHandle;
		group.setDragThreshold = Drag.setDragThreshold;
		group.setDragThresholdX = Drag.setDragThresholdX;
		group.setDragThresholdY = Drag.setDragThresholdY;
		group.constrain = Drag.constrain;
		group.constrainVertical = Drag.constrainVertical;
		group.constrainHorizontal = Drag.constrainHorizontal;

		group.handle.onmousedown = Drag.onMouseDown;
	},

	constrainVertical : function() {
		var nwOffset = Coordinates.northwestOffset(this, true);
		this.minX = nwOffset.x;
		this.maxX = nwOffset.x;
	},

	constrainHorizontal : function() {
		var nwOffset = Coordinates.northwestOffset(this, true);
		this.minY = nwOffset.y;
		this.maxY = nwOffset.y;
	},

	constrain : function(nwPosition, sePosition) {
	    // Constrain by recursive positions
		this.minX = nwPosition.x;
		this.minY = nwPosition.y;
		this.maxX = sePosition.x;
		this.maxY = sePosition.y;
	},

	setDragHandle : function(handle) {
		if (handle && handle != null) 
			this.handle = handle;
		else
			this.handle = this;

		this.handle.group = this;
		this.onmousedown = null;
		this.handle.onmousedown = Drag.onMouseDown;
	},

	setDragThreshold : function(threshold) {
		if (isNaN(parseInt(threshold))) return;

		this.threshold = threshold;
	},

	setDragThresholdX : function(threshold) {
		if (isNaN(parseInt(threshold))) return;

		this.thresholdX = threshold;
	},

	setDragThresholdY : function(threshold) {
		if (isNaN(parseInt(threshold))) return;

		this.thresholdY = threshold;
	},

	onMouseDown : function(event) {
		event = mousePos.update(event);
		//added by yfzhu to make sure clicked on draggable area
		if(mousePos.minus(Coordinates.northwestOffset(this.group, true)).y>this.group.maxYPOS) return;
		
		Drag.group = this.group;

		var group = this.group;
		
		if (group.disableDrag) {
			return;
		}
		
		var mouse = mousePos;
		var nwPosition = Coordinates.northwestPosition(group);
		var nwOffset = Coordinates.northwestOffset(group, true);
		var sePosition = Coordinates.southeastPosition(group);
		var seOffset = Coordinates.southeastOffset(group, true);

		group.originalZIndex = group.style.zIndex;
		
		//group.initialWindowCoordinate = mouse;
		
		// TODO: need a better name, but don't yet understand how it
		// participates in the magic while dragging 
		
		//group.dragCoordinate = mouse;
		
		// Offset of the mouse relative to the dragging group
		// This should remain constant.
		group.mouseNwOffset = mouse.minus(nwOffset);
		group.mouseSeOffset = mouse.minus(seOffset);
		group.mouseStart = new Coordinate(mousePos.x, mousePos.y);
		
		//Drag.showStatus(mouse, nwPosition, sePosition, nwOffset, seOffset);

		group.onDragStart(nwPosition, sePosition, nwOffset, seOffset);

		// Constraint coordinates are translated to mouse constraint coordinates.
		// The algorithm below will looks at the bounds of the dragging group and
		// makes sure that no part of it extends outside the constraint bounds.
		var minMouseX;
		var minMouseY;
		var maxMouseX;
		var maxMouseY;
		
		if (group.minX != null)
			minMouseX = group.minX + group.mouseNwOffset.x;
		if (group.minY != null)
			minMouseY = group.minY + group.mouseNwOffset.y;
		if (group.maxX != null) 
			maxMouseX = group.maxX + group.mouseSeOffset.x;
		if (group.maxY != null) 
			maxMouseY = group.maxY + group.mouseSeOffset.y;
			
		if (minMouseX && maxMouseX && minMouseX > maxMouseX)
			maxMouseX = minMouseX;
		if (minMouseY && maxMouseY && minMouseY > maxMouseY)
			maxMouseY = minMouseY;

		group.mouseMin = new Coordinate(minMouseX, minMouseY);
		group.mouseMax = new Coordinate(maxMouseX, maxMouseY);

		document.onmousemove = Drag.onMouseMove;
		document.onmouseup = Drag.onMouseUp;

		return false;
	},

	showStatus : function(mouse, nwPosition, sePosition, nwOffset, seOffset) {
		window.status = 
				"mouse: " + mouse.toString() + "	" + 
				"NW pos: " + nwPosition.toString() + "	" + 
				"SE pos: " + sePosition.toString() + "	" + 
				"NW offset: " + nwOffset.toString() + "	" +
				"SE offset: " + seOffset.toString();
	},

	onMouseMove : function(event) {
		event = mousePos.update(event);
		// Assigning "group" because event is associated with the document
		// and not the dragging obj.  This is for robustness during a drag
		var group = Drag.group;
		var mouse = mousePos;
		var nwOffset = Coordinates.northwestOffset(group, true);
		var nwPosition = Coordinates.northwestPosition(group);
		var sePosition = Coordinates.southeastPosition(group);
		var seOffset = Coordinates.southeastOffset(group, true);

		//Drag.showStatus(mouse, nwPosition, sePosition, nwOffset, seOffset);

		// Automatically scroll the page it drags near the top or bottom
		var scrollZone = 20;
		var scrollSpeed = 5;
		var scrollTop = Viewport.scroll().y;
		var pageHeight = Viewport.page().y;
		var clientHeight = Viewport.frame().y;

		if ((scrollTop + clientHeight + 2 * scrollZone) < pageHeight
				&& mousePos.y > (scrollTop + clientHeight - scrollZone)) {
				
			window.scroll(0, scrollTop + scrollSpeed);
			nwPosition.y += scrollSpeed;
		}
		if (scrollTop > 0 && mousePos.y < (scrollTop + scrollZone)) {
		
			window.scroll(0, scrollTop - scrollSpeed);
			nwPosition.y -= scrollSpeed;
		}
		
		var adjusted = mouse.constrain(group.mouseMin, group.mouseMax);
		
		// new-pos = cur-pos + (adj-mouse-pos - mouse-offset - screen-offset)
		//
		//	 new-pos: where we want to position the element using styles
		//	 cur-pos: current styled position of group
		//	 adj-mouse-pos: mouse position adjusted for constraints
		//	 mouse-offset: mouse position relative to the dragging group
		//	 screen-offset: screen position of the current element
		//
		nwPosition = nwPosition.plus(adjusted.minus(nwOffset).minus(group.mouseNwOffset));

		if (!Drag.isDragging) {
			if (group.threshold > 0) {
				var distance = group.mouseStart.distance(mouse);
				if (distance < group.threshold) return true;
			} else if (group.thresholdY > 0) {
				var deltaY = Math.abs(group.mouseStart.y - mouse.y);
				if (deltaY < group.thresholdY) return true;
			} else if (group.thresholdX > 0) {
				var deltaX = Math.abs(group.mouseStart.x - mouse.x);
				if (deltaX < group.thresholdX) return true;
			}

			Drag.isDragging = true;
		}

		nwPosition.reposition(group);
		//group.dragCoordinate = adjusted;

		// once dragging has started, the position of the group
		// relative to the mouse should stay fixed.  They can get out
		// of sync if the DOM is manipulated while dragging, so we
		// correct the error here
		//
		// changed to be recursive/use absolute offset for corrections

		if (group.autoCorrect) {
			var offsetBefore = Coordinates.northwestOffset(group, true);
			group.onDrag(nwPosition, sePosition, nwOffset, seOffset);
			var offsetAfter = Coordinates.northwestOffset(group, true);

			if (!offsetBefore.equals(offsetAfter)) {
				// Position of the group has changed after the onDrag call.
				// Move element to the current mouse position
				var errorDelta = offsetBefore.minus(offsetAfter);
				nwPosition = Coordinates.northwestPosition(group).plus(errorDelta);
				nwPosition.reposition(group);
			}
		}
		else {
			nwPosition.reposition(group);
			group.onDrag(nwPosition, sePosition, nwOffset, seOffset);
		}

		return false;
	},

	onMouseUp : function(event) {
		event = mousePos.update(event);
		var group = Drag.group;

		var mouse = event.windowCoordinate;
		var nwOffset = Coordinates.northwestOffset(group, true);
		var nwPosition = Coordinates.northwestPosition(group);
		var sePosition = Coordinates.southeastPosition(group);
		var seOffset = Coordinates.southeastOffset(group, true);

		document.onmousemove = null;
		document.onmouseup   = null;

		group.onDragEnd(nwPosition, sePosition, nwOffset, seOffset);
		Drag.group = null;
		Drag.isDragging = false;

		return false;
	}

};

// Provide a default path to dwr.engine
if (dwr == null) var dwr = {};
if (dwr.engine == null) dwr.engine = {};
if (DWREngine == null) var DWREngine = dwr.engine;
if (Controller == null) var Controller = {};
Controller._path = '/servlets/dwr';
Controller.handle = function(p0, callback) {
  dwr.engine._execute(Controller._path, 'Controller', 'handle', p0, 
   		{	timeout:25*1000,
			timeoutFunc:function(batch){
				if(batch && !batch.completed){
					var e=	$("timeoutBox");
					if(e!=null)e.style.visibility = 'visible';
				}else{
					if(batch)clearInterval(batch.interval);
				}
			},
			callback:callback
		}
	);
}
Controller.query = function(p0, callback) {
  dwr.engine._execute(Controller._path, 'Controller', 'query', p0, 
  		{	timeout:25*1000,
			timeoutFunc:function(batch){
				if(batch && !batch.completed){
					var e=	$("timeoutBox");
					if(e!=null)e.style.visibility = 'visible';
				}else{
					if(batch)clearInterval(batch.interval);
				}
			},
			callback:callback
		}
	);
}
/*
 * Copyright 2005 Joe Walker
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * Declare an object to which we can add real functions.
 */
if (dwr == null) var dwr = {};
if (dwr.engine == null) dwr.engine = {};
if (DWREngine == null) var DWREngine = dwr.engine;
/**
 * Set an alternative error handler from the default alert box.
 * @see getahead.org/dwr/browser/engine/errors
 */
dwr.engine.setErrorHandler = function(handler) {
  dwr.engine._errorHandler = handler;
};
/**
 * Set an alternative warning handler from the default alert box.
 * @see getahead.org/dwr/browser/engine/errors
 */
dwr.engine.setWarningHandler = function(handler) {
  dwr.engine._warningHandler = handler;
};
/**
 * Setter for the text/html handler - what happens if a DWR request gets an HTML
 * reply rather than the expected Javascript. Often due to login timeout
 */
dwr.engine.setTextHtmlHandler = function(handler) {
  dwr.engine._textHtmlHandler = handler;
}
/**
 * Set a default timeout value for all calls. 0 (the default) turns timeouts off.
 * @see getahead.org/dwr/browser/engine/errors
 */
dwr.engine.setTimeout = function(timeout) {
  dwr.engine._timeout = timeout;
};
/**
 * The Pre-Hook is called before any DWR remoting is done.
 * @see getahead.org/dwr/browser/engine/hooks
 */
dwr.engine.setPreHook = function(handler) {
  dwr.engine._preHook = handler;
};
/**
 * The Post-Hook is called after any DWR remoting is done.
 * @see getahead.org/dwr/browser/engine/hooks
 */
dwr.engine.setPostHook = function(handler) {
  dwr.engine._postHook = handler;
};
/**
 * Custom headers for all DWR calls
 * @see getahead.org/dwr/????
 */
dwr.engine.setHeaders = function(headers) {
  dwr.engine._headers = headers;
};
/**
 * Custom parameters for all DWR calls
 * @see getahead.org/dwr/????
 */
dwr.engine.setParameters = function(parameters) {
  dwr.engine._parameters = parameters;
};
/** XHR remoting type constant. See dwr.engine.set[Rpc|Poll]Type() */
dwr.engine.XMLHttpRequest = 1;
/** XHR remoting type constant. See dwr.engine.set[Rpc|Poll]Type() */
dwr.engine.IFrame = 2;
/** XHR remoting type constant. See dwr.engine.setRpcType() */
dwr.engine.ScriptTag = 3;
/**
 * Set the preferred remoting type.
 * @param newType One of dwr.engine.XMLHttpRequest or dwr.engine.IFrame or dwr.engine.ScriptTag
 * @see getahead.org/dwr/browser/engine/options
 */
dwr.engine.setRpcType = function(newType) {
  if (newType != dwr.engine.XMLHttpRequest && newType != dwr.engine.IFrame && newType != dwr.engine.ScriptTag) {
    dwr.engine._handleError(null, { name:"dwr.engine.invalidRpcType", message:"RpcType must be one of dwr.engine.XMLHttpRequest or dwr.engine.IFrame or dwr.engine.ScriptTag" });
    return;
  }
  dwr.engine._rpcType = newType;
};
/**
 * Which HTTP method do we use to send results? Must be one of "GET" or "POST".
 * @see getahead.org/dwr/browser/engine/options
 */
dwr.engine.setHttpMethod = function(httpMethod) {
  if (httpMethod != "GET" && httpMethod != "POST") {
    dwr.engine._handleError(null, { name:"dwr.engine.invalidHttpMethod", message:"Remoting method must be one of GET or POST" });
    return;
  }
  dwr.engine._httpMethod = httpMethod;
};
/**
 * Ensure that remote calls happen in the order in which they were sent? (Default: false)
 * @see getahead.org/dwr/browser/engine/ordering
 */
dwr.engine.setOrdered = function(ordered) {
  dwr.engine._ordered = ordered;
};
/**
 * Do we ask the XHR object to be asynchronous? (Default: true)
 * @see getahead.org/dwr/browser/engine/options
 */
dwr.engine.setAsync = function(async) {
  dwr.engine._async = async;
};
/**
 * Does DWR poll the server for updates? (Default: false)
 * @see getahead.org/dwr/browser/engine/options
 */
dwr.engine.setActiveReverseAjax = function(activeReverseAjax) {
  if (activeReverseAjax) {
    // Bail if we are already started
    if (dwr.engine._activeReverseAjax) return;
    dwr.engine._activeReverseAjax = true;
    dwr.engine._poll();
  }
  else {
    // Can we cancel an existing request?
    if (dwr.engine._activeReverseAjax && dwr.engine._pollReq) dwr.engine._pollReq.abort();
    dwr.engine._activeReverseAjax = false;
  }
  // TODO: in iframe mode, if we start, stop, start then the second start may
  // well kick off a second iframe while the first is still about to return
  // we should cope with this but we don't
};
/**
 * Set the preferred polling type.
 * @param newPollType One of dwr.engine.XMLHttpRequest or dwr.engine.IFrame
 * @see getahead.org/dwr/browser/engine/options
 */
dwr.engine.setPollType = function(newPollType) {
  if (newPollType != dwr.engine.XMLHttpRequest && newPollType != dwr.engine.IFrame) {
    dwr.engine._handleError(null, { name:"dwr.engine.invalidPollType", message:"PollType must be one of dwr.engine.XMLHttpRequest or dwr.engine.IFrame"  });
    return;
  }
  dwr.engine._pollType = newPollType;
};
/**
 * The default message handler.
 * @see getahead.org/dwr/browser/engine/errors
 */
dwr.engine.defaultErrorHandler = function(message, ex) {
  dwr.engine._debug("Error: " + ex.name + ", " + ex.message, true);
  if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
  // Ignore NS_ERROR_NOT_AVAILABLE if Mozilla is being narky
  else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
  else alert(message);
};
/**
 * The default warning handler.
 * @see getahead.org/dwr/browser/engine/errors
 */
dwr.engine.defaultWarningHandler = function(message, ex) {
  dwr.engine._debug(message);
};
/**
 * For reduced latency you can group several remote calls together using a batch.
 * @see getahead.org/dwr/browser/engine/batch
 */
dwr.engine.beginBatch = function() {
  if (dwr.engine._batch) {
    dwr.engine._handleError(null, { name:"dwr.engine.batchBegun", message:"Batch already begun" });
    return;
  }
  dwr.engine._batch = dwr.engine._createBatch();
};
/**
 * Finished grouping a set of remote calls together. Go and execute them all.
 * @see getahead.org/dwr/browser/engine/batch
 */
dwr.engine.endBatch = function(options) {
  var batch = dwr.engine._batch;
  if (batch == null) {
    dwr.engine._handleError(null, { name:"dwr.engine.batchNotBegun", message:"No batch in progress" });
    return;
  }
  dwr.engine._batch = null;
  if (batch.map.callCount == 0) return;
  // The hooks need to be merged carefully to preserve ordering
  if (options) dwr.engine._mergeBatch(batch, options);
  // In ordered mode, we don't send unless the list of sent items is empty
  if (dwr.engine._ordered && dwr.engine._batchesLength != 0) {
    dwr.engine._batchQueue[dwr.engine._batchQueue.length] = batch;
  }
  else {
    dwr.engine._sendData(batch);
  }
};
/** @deprecated */
dwr.engine.setPollMethod = function(type) { dwr.engine.setPollType(type); };
dwr.engine.setMethod = function(type) { dwr.engine.setRpcType(type); };
dwr.engine.setVerb = function(verb) { dwr.engine.setHttpMethod(verb); };
//==============================================================================
// Only private stuff below here
//==============================================================================
/** The original page id sent from the server */
dwr.engine._origScriptSessionId = "E8430AC41A13E616425835867C0BC9E0";
/** The session cookie name */
dwr.engine._sessionCookieName = "JSESSIONID"; // JSESSIONID
/** Is GET enabled for the benefit of Safari? */
dwr.engine._allowGetForSafariButMakeForgeryEasier = "false";
/** The script prefix to strip in the case of scriptTagProtection. */
dwr.engine._scriptTagProtection = "throw 'allowScriptTagRemoting is false.';";
/** The default path to the DWR servlet */
dwr.engine._defaultPath = "/servlets/dwr";
/** The read page id that we calculate */
dwr.engine._scriptSessionId = null;
/** The function that we use to fetch/calculate a session id */
dwr.engine._getScriptSessionId = function() {
  if (dwr.engine._scriptSessionId == null) {
    dwr.engine._scriptSessionId ="yfzhu"+Math.floor(Math.random() * 1000);// dwr.engine._origScriptSessionId + Math.floor(Math.random() * 1000);
  }
  return dwr.engine._scriptSessionId;
};
/** A function to call if something fails. */
dwr.engine._errorHandler = dwr.engine.defaultErrorHandler;
/** For debugging when something unexplained happens. */
dwr.engine._warningHandler = dwr.engine.defaultWarningHandler;
/** A function to be called before requests are marshalled. Can be null. */
dwr.engine._preHook = null;
/** A function to be called after replies are received. Can be null. */
dwr.engine._postHook = null;
/** An map of the batches that we have sent and are awaiting a reply on. */
dwr.engine._batches = {};
/** A count of the number of outstanding batches. Should be == to _batches.length unless prototype has messed things up */
dwr.engine._batchesLength = 0;
/** In ordered mode, the array of batches waiting to be sent */
dwr.engine._batchQueue = [];
/** What is the default rpc type */
dwr.engine._rpcType = dwr.engine.XMLHttpRequest;
/** What is the default remoting method (ie GET or POST) */
dwr.engine._httpMethod = "POST";
/** Do we attempt to ensure that calls happen in the order in which they were sent? */
dwr.engine._ordered = false;
/** Do we make the calls async? */
dwr.engine._async = true;
/** The current batch (if we are in batch mode) */
dwr.engine._batch = null;
/** The global timeout */
dwr.engine._timeout = 0;
dwr.engine._timeoutFunc = null;
/** ActiveX objects to use when we want to convert an xml string into a DOM object. */
dwr.engine._DOMDocument = ["Msxml2.DOMDocument.6.0", "Msxml2.DOMDocument.5.0", "Msxml2.DOMDocument.4.0", "Msxml2.DOMDocument.3.0", "MSXML2.DOMDocument", "MSXML.DOMDocument", "Microsoft.XMLDOM"];
/** The ActiveX objects to use when we want to do an XMLHttpRequest call. */
dwr.engine._XMLHTTP = ["Msxml2.XMLHTTP.6.0", "Msxml2.XMLHTTP.5.0", "Msxml2.XMLHTTP.4.0", "MSXML2.XMLHTTP.3.0", "MSXML2.XMLHTTP", "Microsoft.XMLHTTP"];
/** Are we doing comet or polling? */
dwr.engine._activeReverseAjax = false;
/** What is the default polling type */
dwr.engine._pollType = dwr.engine.XMLHttpRequest;
//dwr.engine._pollType = dwr.engine.IFrame;
/** The iframe that we are using to poll */
dwr.engine._outstandingIFrames = [];
/** The xhr object that we are using to poll */
dwr.engine._pollReq = null;
/** How many milliseconds between internal comet polls */
dwr.engine._pollCometInterval = 200;
/** How many times have we re-tried to poll? */
dwr.engine._pollRetries = 0;
dwr.engine._maxPollRetries = 0;
/** Do we do a document.reload if we get a text/html reply? */
dwr.engine._textHtmlHandler = null;
/** If you wish to send custom headers with every request */
dwr.engine._headers = null;
/** If you wish to send extra custom request parameters with each request */
dwr.engine._parameters = null;
/** Undocumented interceptors - do not use */
dwr.engine._postSeperator = "\n";
dwr.engine._defaultInterceptor = function(data) {return data;}
dwr.engine._urlRewriteHandler = dwr.engine._defaultInterceptor;
dwr.engine._contentRewriteHandler = dwr.engine._defaultInterceptor;
dwr.engine._replyRewriteHandler = dwr.engine._defaultInterceptor;
/** Batch ids allow us to know which batch the server is answering */
dwr.engine._nextBatchId = 0;
/** A list of the properties that need merging from calls to a batch */
dwr.engine._propnames = [ "rpcType", "httpMethod", "async", "timeout", "errorHandler", "warningHandler", "textHtmlHandler","timeoutFunc" ];
/** Do we stream, or can be hacked to do so? */
dwr.engine._partialResponseNo = 0;
dwr.engine._partialResponseYes = 1;
dwr.engine._partialResponseFlush = 2;
/**
yfzhu added 2008-8-8
*/
dwr.engine.abortAll=function(){
	for(i in dwr.engine._batches){
		try{
		  var batch=dwr.engine._batches[i];
		  if (batch && !batch.completed) {
		    clearInterval(batch.interval);
		    dwr.engine._clearUp(batch);
		    if (batch.req) batch.req.abort();
		  }
		}catch(e){}
	}
};
/**
 * @private Send a request. Called by the Javascript interface stub
 * @param path part of URL after the host and before the exec bit without leading or trailing /s
 * @param scriptName The class to execute
 * @param methodName The method on said class to execute
 * @param func The callback function to which any returned data should be passed
 *       if this is null, any returned data will be ignored
 * @param vararg_params The parameters to pass to the above class
 */
dwr.engine._execute = function(path, scriptName, methodName, vararg_params) {
  var singleShot = false;
  if (dwr.engine._batch == null) {
    dwr.engine.beginBatch();
    singleShot = true;
  }
  var batch = dwr.engine._batch;
  // To make them easy to manipulate we copy the arguments into an args array
  var args = [];
  for (var i = 0; i < arguments.length - 3; i++) {
    args[i] = arguments[i + 3];
  }
  // All the paths MUST be to the same servlet
  if (batch.path == null) {
    batch.path = path;
  }
  else {
    if (batch.path != path) {
      dwr.engine._handleError(batch, { name:"dwr.engine.multipleServlets", message:"Can't batch requests to multiple DWR Servlets." });
      return;
    }
  }
  // From the other params, work out which is the function (or object with
  // call meta-data) and which is the call parameters
  var callData;
  var lastArg = args[args.length - 1];
  if (typeof lastArg == "function" || lastArg == null) callData = { callback:args.pop() };
  else callData = args.pop();
  // Merge from the callData into the batch
  dwr.engine._mergeBatch(batch, callData);
  batch.handlers[batch.map.callCount] = {
    exceptionHandler:callData.exceptionHandler,
    callback:callData.callback
  };
  // Copy to the map the things that need serializing
  var prefix = "c" + batch.map.callCount + "-";
  batch.map[prefix + "scriptName"] = scriptName;
  batch.map[prefix + "methodName"] = methodName;
  batch.map[prefix + "id"] = batch.map.callCount;
  for (i = 0; i < args.length; i++) {
    dwr.engine._serializeAll(batch, [], args[i], prefix + "param" + i);
  }
  // Now we have finished remembering the call, we incr the call count
  batch.map.callCount++;
  if (singleShot) dwr.engine.endBatch();
};
/** @private Poll the server to see if there is any data waiting */
dwr.engine._poll = function(overridePath) {
  if (!dwr.engine._activeReverseAjax) return;
  var batch = dwr.engine._createBatch();
  batch.map.id = 0; // TODO: Do we need this??
  batch.map.callCount = 1;
  batch.isPoll = true;
  if (navigator.userAgent.indexOf("Gecko/") != -1) {
    batch.rpcType = dwr.engine._pollType;
    batch.map.partialResponse = dwr.engine._partialResponseYes;
  }
  else if (document.all) {
    batch.rpcType = dwr.engine.IFrame;
    batch.map.partialResponse = dwr.engine._partialResponseFlush;
  }
  else {
    batch.rpcType = dwr.engine._pollType;
    batch.map.partialResponse = dwr.engine._partialResponseNo;
  }
  batch.httpMethod = "POST";
  batch.async = true;
  batch.timeout = 0;
  batch.path = (overridePath) ? overridePath : dwr.engine._defaultPath;
  batch.preHooks = [];
  batch.postHooks = [];
  batch.errorHandler = dwr.engine._pollErrorHandler;
  batch.warningHandler = dwr.engine._pollErrorHandler;
  batch.handlers[0] = {
    callback:function(pause) {
      dwr.engine._pollRetries = 0;
      setTimeout("dwr.engine._poll()", pause);
    }
  };
  // Send the data
  dwr.engine._sendData(batch);
  if (batch.rpcType == dwr.engine.XMLHttpRequest) {
  // if (batch.map.partialResponse != dwr.engine._partialResponseNo) {
    dwr.engine._checkCometPoll();
  }
};
/** Try to recover from polling errors */
dwr.engine._pollErrorHandler = function(msg, ex) {
  // if anything goes wrong then just silently try again (up to 3x) after 10s
  dwr.engine._pollRetries++;
  dwr.engine._debug("Reverse Ajax poll failed (pollRetries=" + dwr.engine._pollRetries + "): " + ex.name + " : " + ex.message);
  if (dwr.engine._pollRetries < dwr.engine._maxPollRetries) {
    setTimeout("dwr.engine._poll()", 10000);
  }
  else {
    dwr.engine._debug("Giving up.");
  }
};
/** @private Generate a new standard batch */
dwr.engine._createBatch = function() {
  var batch = {
    map:{
      callCount:0,
      page:window.location.pathname + window.location.search,
      httpSessionId:dwr.engine._getJSessionId(),
      scriptSessionId:dwr.engine._getScriptSessionId()
    },
    charsProcessed:0, paramCount:0,
    headers:[], parameters:[],
    isPoll:false, headers:{}, handlers:{}, preHooks:[], postHooks:[],
    rpcType:dwr.engine._rpcType,
    httpMethod:dwr.engine._httpMethod,
    async:dwr.engine._async,
    timeout:dwr.engine._timeout,
    timeoutFunc:dwr.engine._timeoutFunc,
    errorHandler:dwr.engine._errorHandler,
    warningHandler:dwr.engine._warningHandler,
    textHtmlHandler:dwr.engine._textHtmlHandler
  };
  if (dwr.engine._preHook) batch.preHooks.push(dwr.engine._preHook);
  if (dwr.engine._postHook) batch.postHooks.push(dwr.engine._postHook);
  var propname, data;
  if (dwr.engine._headers) {
    for (propname in dwr.engine._headers) {
      data = dwr.engine._headers[propname];
      if (typeof data != "function") batch.headers[propname] = data;
    }
  }
  if (dwr.engine._parameters) {
    for (propname in dwr.engine._parameters) {
      data = dwr.engine._parameters[propname];
      if (typeof data != "function") batch.parameters[propname] = data;
    }
  }
  return batch;
}
/** @private Take further options and merge them into */
dwr.engine._mergeBatch = function(batch, overrides) {
  var propname, data;
  for (var i = 0; i < dwr.engine._propnames.length; i++) {
    propname = dwr.engine._propnames[i];
    if (overrides[propname] != null) batch[propname] = overrides[propname];
  }
  if (overrides.preHook != null) batch.preHooks.unshift(overrides.preHook);
  if (overrides.postHook != null) batch.postHooks.push(overrides.postHook);
  if (overrides.headers) {
    for (propname in overrides.headers) {
      data = overrides.headers[propname];
      if (typeof data != "function") batch.headers[propname] = data;
    }
  }
  if (overrides.parameters) {
    for (propname in overrides.parameters) {
      data = overrides.parameters[propname];
      if (typeof data != "function") batch.map["p-" + propname] = "" + data;
    }
  }
  
};
/** @private What is our session id? */
dwr.engine._getJSessionId =  function() {
  var cookies = document.cookie.split(';');
  for (var i = 0; i < cookies.length; i++) {
    var cookie = cookies[i];
    while (cookie.charAt(0) == ' ') cookie = cookie.substring(1, cookie.length);
    if (cookie.indexOf(dwr.engine._sessionCookieName + "=") == 0) {
      return cookie.substring(11, cookie.length);
    }
  }
  return "";
}
/** @private Check for reverse Ajax activity */
dwr.engine._checkCometPoll = function() {
  for (var i = 0; i < dwr.engine._outstandingIFrames.length; i++) {
    var text = "";
    var iframe = dwr.engine._outstandingIFrames[i];
    try {
      text = dwr.engine._getTextFromCometIFrame(iframe);
    }
    catch (ex) {
      dwr.engine._handleWarning(iframe.batch, ex);
    }
    if (text != "") dwr.engine._processCometResponse(text, iframe.batch);
  }
  if (dwr.engine._pollReq) {
    var req = dwr.engine._pollReq;
    var text = req.responseText;
    dwr.engine._processCometResponse(text, req.batch);
  }
  // If the poll resources are still there, come back again
  if (dwr.engine._outstandingIFrames.length > 0 || dwr.engine._pollReq) {
    setTimeout("dwr.engine._checkCometPoll()", dwr.engine._pollCometInterval);
  }
};
/** @private Extract the whole (executed an all) text from the current iframe */
dwr.engine._getTextFromCometIFrame = function(frameEle) {
  var body = frameEle.contentWindow.document.body;
  if (body == null) return "";
  var text = body.innerHTML;
  // We need to prevent IE from stripping line feeds
  if (text.indexOf("<PRE>") == 0 || text.indexOf("<pre>") == 0) {
    text = text.substring(5, text.length - 7);
  }
  return text;
};

/** @private Some more text might have come in, test and execute the new stuff */
dwr.engine._processCometResponse = function(response, batch) {
  if (batch.charsProcessed == response.length) return;
  if (response.length == 0) {
    batch.charsProcessed = 0;
    return;
  }

  var firstStartTag = response.indexOf("//#DWR-START#", batch.charsProcessed);
  if (firstStartTag == -1) {
    // dwr.engine._debug("No start tag (search from " + batch.charsProcessed + "). skipping '" + response.substring(batch.charsProcessed) + "'");
    batch.charsProcessed = response.length;
    return;
  }
  // if (firstStartTag > 0) {
  //   dwr.engine._debug("Start tag not at start (search from " + batch.charsProcessed + "). skipping '" + response.substring(batch.charsProcessed, firstStartTag) + "'");
  // }

  var lastEndTag = response.lastIndexOf("//#DWR-END#");
  if (lastEndTag == -1) {
    // dwr.engine._debug("No end tag. unchanged charsProcessed=" + batch.charsProcessed);
    return;
  }

  // Skip the end tag too for next time, remembering CR and LF
  if (response.charCodeAt(lastEndTag + 11) == 13 && response.charCodeAt(lastEndTag + 12) == 10) {
    batch.charsProcessed = lastEndTag + 13;
  }
  else {
    batch.charsProcessed = lastEndTag + 11;
  }

  var exec = response.substring(firstStartTag + 13, lastEndTag);

  dwr.engine._receivedBatch = batch;
  dwr.engine._eval(exec);
  dwr.engine._receivedBatch = null;
};

/** @private Actually send the block of data in the batch object. */
dwr.engine._sendData = function(batch) {
  batch.map.batchId = dwr.engine._nextBatchId++;
  dwr.engine._batches[batch.map.batchId] = batch;
  dwr.engine._batchesLength++;
  batch.completed = false;

  for (var i = 0; i < batch.preHooks.length; i++) {
    batch.preHooks[i]();
  }
  batch.preHooks = null;
  // Set a timeout
  if (batch.timeout && batch.timeout != 0) {
    //batch.interval = setInterval(function() { dwr.engine._abortRequest(batch); }, batch.timeout);
    //console.log(batch);
    if(batch.timeoutFunc){
    	batch.interval = setInterval(function(){batch.timeoutFunc(batch);} , batch.timeout);
    }else{
    	batch.interval = setInterval( function() { dwr.engine._abortRequest(batch); }, batch.timeout);
   	}
  }
  // Get setup for XMLHttpRequest if possible
  if (batch.rpcType == dwr.engine.XMLHttpRequest) {
    if (window.XMLHttpRequest) {
      batch.req = new XMLHttpRequest();
    }
    // IE5 for the mac claims to support window.ActiveXObject, but throws an error when it's used
    else if (window.ActiveXObject && !(navigator.userAgent.indexOf("Mac") >= 0 && navigator.userAgent.indexOf("MSIE") >= 0)) {
      batch.req = dwr.engine._newActiveXObject(dwr.engine._XMLHTTP);
    }
  }

  var prop, request;
  if (batch.req) {
    // Proceed using XMLHttpRequest
    if (batch.async) {
      batch.req.onreadystatechange = function() { dwr.engine._stateChange(batch); };
    }
    // If we're polling, record this for monitoring
    if (batch.isPoll) {
      dwr.engine._pollReq = batch.req;
      // In IE XHR is an ActiveX control so you can't augment it like this
      // however batch.isPoll uses IFrame on IE so were safe here
      batch.req.batch = batch;
    }
    // Workaround for Safari 1.x POST bug
    var indexSafari = navigator.userAgent.indexOf("Safari/");
    if (indexSafari >= 0) {
      var version = navigator.userAgent.substring(indexSafari + 7);
      if (parseInt(version, 10) < 400) {
        if (dwr.engine._allowGetForSafariButMakeForgeryEasier == "true") batch.httpMethod = "GET";
        else dwr.engine._handleWarning(batch, { name:"dwr.engine.oldSafari", message:"Safari GET support disabled. See getahead.org/dwr/server/servlet and allowGetForSafariButMakeForgeryEasier." });
      }
    }
    batch.mode = batch.isPoll ? dwr.engine._ModePlainPoll : dwr.engine._ModePlainCall;
    request = dwr.engine._constructRequest(batch);
    try {
      batch.req.open(batch.httpMethod, request.url, batch.async);
      try {
        for (prop in batch.headers) {
          var value = batch.headers[prop];
          if (typeof value == "string") batch.req.setRequestHeader(prop, value);
        }
        if (!batch.headers["Content-Type"]) batch.req.setRequestHeader("Content-Type", "text/plain");
      }
      catch (ex) {
        dwr.engine._handleWarning(batch, ex);
      }
      batch.req.send(request.body);
      if (!batch.async) dwr.engine._stateChange(batch);
    }
    catch (ex) {
      dwr.engine._handleError(batch, ex);
    }
  }
  else if (batch.rpcType != dwr.engine.ScriptTag) {
    // Proceed using iframe
    var idname = batch.isPoll ? "dwr-if-poll-" + batch.map.batchId : "dwr-if-" + batch.map["c0-id"];
    batch.div = document.createElement("div");
    batch.div.innerHTML = "<iframe src='javascript:void(0)' frameborder='0' style='width:0px;height:0px;border:0;' id='" + idname + "' name='" + idname + "'></iframe>";
    document.body.appendChild(batch.div);
    batch.iframe = document.getElementById(idname);
    batch.iframe.batch = batch;
    batch.mode = batch.isPoll ? dwr.engine._ModeHtmlPoll : dwr.engine._ModeHtmlCall;
    if (batch.isPoll) dwr.engine._outstandingIFrames.push(batch.iframe);
    request = dwr.engine._constructRequest(batch);
    if (batch.httpMethod == "GET") {
      batch.iframe.setAttribute("src", request.url);
      // document.body.appendChild(batch.iframe);
    }
    else {
      batch.form = document.createElement("form");
      batch.form.setAttribute("id", "dwr-form");
      batch.form.setAttribute("action", request.url);
      batch.form.setAttribute("target", idname);
      batch.form.target = idname;
      batch.form.setAttribute("method", batch.httpMethod);
      for (prop in batch.map) {
        var value = batch.map[prop];
        if (typeof value != "function") {
          var formInput = document.createElement("input");
          formInput.setAttribute("type", "hidden");
          formInput.setAttribute("name", prop);
          formInput.setAttribute("value", value);
          batch.form.appendChild(formInput);
        }
      }
      document.body.appendChild(batch.form);
      batch.form.submit();
    }
  }
  else {
    batch.httpMethod = "GET"; // There's no such thing as ScriptTag using POST
    batch.mode = batch.isPoll ? dwr.engine._ModePlainPoll : dwr.engine._ModePlainCall;
    request = dwr.engine._constructRequest(batch);
    batch.script = document.createElement("script");
    batch.script.id = "dwr-st-" + batch.map["c0-id"];
    batch.script.src = request.url;
    document.body.appendChild(batch.script);
  }
};

dwr.engine._ModePlainCall = "/call/plaincall/";
dwr.engine._ModeHtmlCall = "/call/htmlcall/";
dwr.engine._ModePlainPoll = "/call/plainpoll/";
dwr.engine._ModeHtmlPoll = "/call/htmlpoll/";

/** @private Work out what the URL should look like */
dwr.engine._constructRequest = function(batch) {
  // A quick string to help people that use web log analysers
  var request = { url:batch.path + batch.mode, body:null };
  if (batch.isPoll == true) {
    request.url += "ReverseAjax.dwr";
  }
  else if (batch.map.callCount == 1) {
    request.url += batch.map["c0-scriptName"] + "." + batch.map["c0-methodName"] + ".dwr";
  }
  else {
    request.url += "Multiple." + batch.map.callCount + ".dwr";
  }
  // Play nice with url re-writing
  var sessionMatch = location.href.match(/jsessionid=([^?]+)/);
  if (sessionMatch != null) {
    request.url += ";jsessionid=" + sessionMatch[1];
  }

  var prop;
  if (batch.httpMethod == "GET") {
    // Some browsers (Opera/Safari2) seem to fail to convert the callCount value
    // to a string in the loop below so we do it manually here.
    batch.map.callCount = "" + batch.map.callCount;
    request.url += "?";
    for (prop in batch.map) {
      if (typeof batch.map[prop] != "function") {
        request.url += encodeURIComponent(prop) + "=" + encodeURIComponent(batch.map[prop]) + "&";
      }
    }
    request.url = request.url.substring(0, request.url.length - 1);
  }
  else {
    // PERFORMANCE: for iframe mode this is thrown away.
    request.body = "";
    for (prop in batch.map) {
      if (typeof batch.map[prop] != "function") {
        request.body += prop + "=" + batch.map[prop] + dwr.engine._postSeperator;
      }
    }
    request.body = dwr.engine._contentRewriteHandler(request.body);
  }
  request.url = dwr.engine._urlRewriteHandler(request.url);
  return request;
};

/** @private Called by XMLHttpRequest to indicate that something has happened */
dwr.engine._stateChange = function(batch) {
  var toEval;

  if (batch.completed) {
    dwr.engine._debug("Error: _stateChange() with batch.completed");
    return;
  }

  var req = batch.req;
  try {
    if (req.readyState != 4) return;
  }
  catch (ex) {
    dwr.engine._handleWarning(batch, ex);
    // It's broken - clear up and forget this call
    dwr.engine._clearUp(batch);
    return;
  }

  try {
    var reply = req.responseText;
    reply = dwr.engine._replyRewriteHandler(reply);
    var status = req.status; // causes Mozilla to except on page moves

    if (reply == null || reply == "") {
      dwr.engine._handleWarning(batch, { name:"dwr.engine.missingData", message:"No data received from server" });
    }
    else if (status != 200) {
      dwr.engine._handleError(batch, { name:"dwr.engine.http." + status, message:req.statusText });
    }
    else {
      var contentType = req.getResponseHeader("Content-Type");
      if (!contentType.match(/^text\/plain/) && !contentType.match(/^text\/javascript/)) {
        if (contentType.match(/^text\/html/) && typeof batch.textHtmlHandler == "function") {
          batch.textHtmlHandler();
        }
        else {
          dwr.engine._handleWarning(batch, { name:"dwr.engine.invalidMimeType", message:"Invalid content type: '" + contentType + "'" });
        }
      }
      else {
        // Comet replies might have already partially executed
        if (batch.isPoll && batch.map.partialResponse == dwr.engine._partialResponseYes) {
          dwr.engine._processCometResponse(reply, batch);
        }
        else {
          if (reply.search("//#DWR") == -1) {
            dwr.engine._handleWarning(batch, { name:"dwr.engine.invalidReply", message:"Invalid reply from server" });
          }
          else {
            toEval = reply;
          }
        }
      }
    }
  }
  catch (ex) {
    dwr.engine._handleWarning(batch, ex);
  }

  dwr.engine._callPostHooks(batch);

  // Outside of the try/catch so errors propogate normally:
  dwr.engine._receivedBatch = batch;
  if (toEval != null) toEval = toEval.replace(dwr.engine._scriptTagProtection, "");
  dwr.engine._eval(toEval);
  dwr.engine._receivedBatch = null;

  dwr.engine._clearUp(batch);
};

/** @private Called by the server: Execute a callback */
dwr.engine._remoteHandleCallback = function(batchId, callId, reply) {
  var batch = dwr.engine._batches[batchId];
  if (batch == null) {
    dwr.engine._debug("Warning: batch == null in remoteHandleCallback for batchId=" + batchId, true);
    return;
  }
  // Error handlers inside here indicate an error that is nothing to do
  // with DWR so we handle them differently.
  try {
    var handlers = batch.handlers[callId];
    if (!handlers) {
      dwr.engine._debug("Warning: Missing handlers. callId=" + callId, true);
    }
    else if (typeof handlers.callback == "function") handlers.callback(reply);
  }
  catch (ex) {
    dwr.engine._handleError(batch, ex);
  }
};

/** @private Called by the server: Handle an exception for a call */
dwr.engine._remoteHandleException = function(batchId, callId, ex) {
  var batch = dwr.engine._batches[batchId];
  if (batch == null) { dwr.engine._debug("Warning: null batch in remoteHandleException", true); return; }
  var handlers = batch.handlers[callId];
  if (handlers == null) { dwr.engine._debug("Warning: null handlers in remoteHandleException", true); return; }
  if (ex.message == undefined) ex.message = "";
  if (typeof handlers.exceptionHandler == "function") handlers.exceptionHandler(ex.message, ex);
  else if (typeof batch.errorHandler == "function") batch.errorHandler(ex.message, ex);
};

/** @private Called by the server: The whole batch is broken */
dwr.engine._remoteHandleBatchException = function(ex, batchId) {
  var searchBatch = (dwr.engine._receivedBatch == null && batchId != null);
  if (searchBatch) {
    dwr.engine._receivedBatch = dwr.engine._batches[batchId];
  }
  if (ex.message == undefined) ex.message = "";
  dwr.engine._handleError(dwr.engine._receivedBatch, ex);
  if (searchBatch) {
    dwr.engine._receivedBatch = null;
    dwr.engine._clearUp(dwr.engine._batches[batchId]);
  }
};

/** @private Called by the server: Reverse ajax should not be used */
dwr.engine._remotePollCometDisabled = function(ex, batchId) {
  dwr.engine.setActiveReverseAjax(false);
  var searchBatch = (dwr.engine._receivedBatch == null && batchId != null);
  if (searchBatch) {
    dwr.engine._receivedBatch = dwr.engine._batches[batchId];
  }
  if (ex.message == undefined) ex.message = "";
  dwr.engine._handleError(dwr.engine._receivedBatch, ex);
  if (searchBatch) {
    dwr.engine._receivedBatch = null;
    dwr.engine._clearUp(dwr.engine._batches[batchId]);
  }
};

/** @private Called by the server: An IFrame reply is about to start */
dwr.engine._remoteBeginIFrameResponse = function(iframe, batchId) {
  if (iframe != null) dwr.engine._receivedBatch = iframe.batch;
  dwr.engine._callPostHooks(dwr.engine._receivedBatch);
};

/** @private Called by the server: An IFrame reply is just completing */
dwr.engine._remoteEndIFrameResponse = function(batchId) {
  dwr.engine._clearUp(dwr.engine._receivedBatch);
  dwr.engine._receivedBatch = null;
};

/** @private This is a hack to make the context be this window */
dwr.engine._eval = function(script) {
  if (script == null) return null;
  if (script == "") { dwr.engine._debug("Warning: blank script", true); return null; }
  // dwr.engine._debug("Exec: [" + script + "]", true);
  return eval(script);
};

/** @private Called as a result of a request timeout */
dwr.engine._abortRequest = function(batch) {
  if (batch && !batch.completed) {
    clearInterval(batch.interval);
    dwr.engine._clearUp(batch);
    if (batch.req) batch.req.abort();
    dwr.engine._handleError(batch, { name:"dwr.engine.timeout", message:"Timeout" });
  }
};

/** @private call all the post hooks for a batch */
dwr.engine._callPostHooks = function(batch) {
  if (batch.postHooks) {
    for (var i = 0; i < batch.postHooks.length; i++) {
      batch.postHooks[i]();
    }
    batch.postHooks = null;
  }
}

/** @private A call has finished by whatever means and we need to shut it all down. */
dwr.engine._clearUp = function(batch) {
  if (!batch) { dwr.engine._debug("Warning: null batch in dwr.engine._clearUp()", true); return; }
  if (batch.completed == "true") { dwr.engine._debug("Warning: Double complete", true); return; }

  // IFrame tidyup
  if (batch.div) batch.div.parentNode.removeChild(batch.div);
  if (batch.iframe) {
    // If this is a poll frame then stop comet polling
    for (var i = 0; i < dwr.engine._outstandingIFrames.length; i++) {
      if (dwr.engine._outstandingIFrames[i] == batch.iframe) {
        dwr.engine._outstandingIFrames.splice(i, 1);
      }
    }
    batch.iframe.parentNode.removeChild(batch.iframe);
  }
  if (batch.form) batch.form.parentNode.removeChild(batch.form);

  // XHR tidyup: avoid IE handles increase
  if (batch.req) {
    // If this is a poll frame then stop comet polling
    if (batch.req == dwr.engine._pollReq) dwr.engine._pollReq = null;
    delete batch.req;
  }

  if (batch.map && batch.map.batchId) {
    delete dwr.engine._batches[batch.map.batchId];
    dwr.engine._batchesLength--;
  }

  batch.completed = true;
  if (batch.timeout && batch.timeout != 0) {
  	clearInterval(batch.interval);
  	var tbxEle=document.getElementById("timeoutBox");
  	if( tbxEle!=null) tbxEle.style.visibility="hidden";
  }

  // If there is anything on the queue waiting to go out, then send it.
  // We don't need to check for ordered mode, here because when ordered mode
  // gets turned off, we still process *waiting* batches in an ordered way.
  if (dwr.engine._batchQueue.length != 0) {
    var sendbatch = dwr.engine._batchQueue.shift();
    dwr.engine._sendData(sendbatch);
  }
};

/** @private Generic error handling routing to save having null checks everywhere */
dwr.engine._handleError = function(batch, ex) {
  if (typeof ex == "string") ex = { name:"unknown", message:ex };
  if (ex.message == null) ex.message = "";
  if (ex.name == null) ex.name = "unknown";
  if (batch && typeof batch.errorHandler == "function") batch.errorHandler(ex.message, ex);
  else if (dwr.engine._errorHandler) dwr.engine._errorHandler(ex.message, ex);
  dwr.engine._clearUp(batch);
};

/** @private Generic error handling routing to save having null checks everywhere */
dwr.engine._handleWarning = function(batch, ex) {
  if (typeof ex == "string") ex = { name:"unknown", message:ex };
  if (ex.message == null) ex.message = "";
  if (ex.name == null) ex.name = "unknown";
  if (batch && typeof batch.warningHandler == "function") batch.warningHandler(ex.message, ex);
  else if (dwr.engine._warningHandler) dwr.engine._warningHandler(ex.message, ex);
  dwr.engine._clearUp(batch);
};

/**
 * @private Marshall a data item
 * @param batch A map of variables to how they have been marshalled
 * @param referto An array of already marshalled variables to prevent recurrsion
 * @param data The data to be marshalled
 * @param name The name of the data being marshalled
 */
dwr.engine._serializeAll = function(batch, referto, data, name) {
  if (data == null) {
    batch.map[name] = "null:null";
    return;
  }

  switch (typeof data) {
  case "boolean":
    batch.map[name] = "boolean:" + data;
    break;
  case "number":
    batch.map[name] = "number:" + data;
    break;
  case "string":
    batch.map[name] = "string:" + encodeURIComponent(data);
    break;
  case "object":
    if (data instanceof String) batch.map[name] = "String:" + encodeURIComponent(data);
    else if (data instanceof Boolean) batch.map[name] = "Boolean:" + data;
    else if (data instanceof Number) batch.map[name] = "Number:" + data;
    else if (data instanceof Date) batch.map[name] = "Date:" + data.getTime();
    else if (data && data.join) batch.map[name] = dwr.engine._serializeArray(batch, referto, data, name);
    else batch.map[name] = dwr.engine._serializeObject(batch, referto, data, name);
    break;
  case "function":
    // We just ignore functions.
    break;
  default:
    dwr.engine._handleWarning(null, { name:"dwr.engine.unexpectedType", message:"Unexpected type: " + typeof data + ", attempting default converter." });
    batch.map[name] = "default:" + data;
    break;
  }
};

/** @private Have we already converted this object? */
dwr.engine._lookup = function(referto, data, name) {
  var lookup;
  // Can't use a map: getahead.org/ajax/javascript-gotchas
  for (var i = 0; i < referto.length; i++) {
    if (referto[i].data == data) {
      lookup = referto[i];
      break;
    }
  }
  if (lookup) return "reference:" + lookup.name;
  referto.push({ data:data, name:name });
  return null;
};

/** @private Marshall an object */
dwr.engine._serializeObject = function(batch, referto, data, name) {
  var ref = dwr.engine._lookup(referto, data, name);
  if (ref) return ref;

  // This check for an HTML is not complete, but is there a better way?
  // Maybe we should add: data.hasChildNodes typeof "function" == true
  if (data.nodeName && data.nodeType) {
    return dwr.engine._serializeXml(batch, referto, data, name);
  }

  // treat objects as an associative arrays
  var reply = "Object_" + dwr.engine._getObjectClassName(data) + ":{";
  var element;
  for (element in data) {
    if (typeof data[element] != "function") {
      batch.paramCount++;
      var childName = "c" + dwr.engine._batch.map.callCount + "-e" + batch.paramCount;
      dwr.engine._serializeAll(batch, referto, data[element], childName);

      reply += encodeURIComponent(element) + ":reference:" + childName + ", ";
    }
  }

  if (reply.substring(reply.length - 2) == ", ") {
    reply = reply.substring(0, reply.length - 2);
  }
  reply += "}";

  return reply;
};

/** @private Returns the classname of supplied argument obj */
dwr.engine._errorClasses = { "Error":Error, "EvalError":EvalError, "RangeError":RangeError, "ReferenceError":ReferenceError, "SyntaxError":SyntaxError, "TypeError":TypeError, "URIError":URIError };
dwr.engine._getObjectClassName = function(obj) {
  // Try to find the classname by stringifying the object's constructor
  // and extract <class> from "function <class>".
  if (obj && obj.constructor && obj.constructor.toString)
  {
    var str = obj.constructor.toString();
    var regexpmatch = str.match(/function\s+(\w+)/);
    if (regexpmatch && regexpmatch.length == 2) {
      return regexpmatch[1];
    }
  }

  // Now manually test against the core Error classes, as these in some 
  // browsers successfully match to the wrong class in the 
  // Object.toString() test we will do later
  if (obj && obj.constructor) {
	for (var errorname in dwr.engine._errorClasses) {
      if (obj.constructor == dwr.engine._errorClasses[errorname]) return errorname;
    }
  }

  // Try to find the classname by calling Object.toString() on the object
  // and extracting <class> from "[object <class>]"
  if (obj) {
    var str = Object.prototype.toString.call(obj);
    var regexpmatch = str.match(/\[object\s+(\w+)/);
    if (regexpmatch && regexpmatch.length==2) {
      return regexpmatch[1];
    }
  }

  // Supplied argument was probably not an object, but what is better?
  return "Object";
};

/** @private Marshall an object */
dwr.engine._serializeXml = function(batch, referto, data, name) {
  var ref = dwr.engine._lookup(referto, data, name);
  if (ref) return ref;

  var output;
  if (window.XMLSerializer) output = new XMLSerializer().serializeToString(data);
  else if (data.toXml) output = data.toXml;
  else output = data.innerHTML;

  return "XML:" + encodeURIComponent(output);
};

/** @private Marshall an array */
dwr.engine._serializeArray = function(batch, referto, data, name) {
  var ref = dwr.engine._lookup(referto, data, name);
  if (ref) return ref;

  var reply = "Array:[";
  for (var i = 0; i < data.length; i++) {
    if (i != 0) reply += ",";
    batch.paramCount++;
    var childName = "c" + dwr.engine._batch.map.callCount + "-e" + batch.paramCount;
    dwr.engine._serializeAll(batch, referto, data[i], childName);
    reply += "reference:";
    reply += childName;
  }
  reply += "]";

  return reply;
};

/** @private Convert an XML string into a DOM object. */
dwr.engine._unserializeDocument = function(xml) {
  var dom;
  if (window.DOMParser) {
    var parser = new DOMParser();
    dom = parser.parseFromString(xml, "text/xml");
    if (!dom.documentElement || dom.documentElement.tagName == "parsererror") {
      var message = dom.documentElement.firstChild.data;
      message += "\n" + dom.documentElement.firstChild.nextSibling.firstChild.data;
      throw message;
    }
    return dom;
  }
  else if (window.ActiveXObject) {
    dom = dwr.engine._newActiveXObject(dwr.engine._DOMDocument);
    dom.loadXML(xml); // What happens on parse fail with IE?
    return dom;
  }
  else {
    var div = document.createElement("div");
    div.innerHTML = xml;
    return div;
  }
};

/** @param axarray An array of strings to attempt to create ActiveX objects from */
dwr.engine._newActiveXObject = function(axarray) {
  var returnValue;  
  for (var i = 0; i < axarray.length; i++) {
    try {
      returnValue = new ActiveXObject(axarray[i]);
      break;
    }
    catch (ex) { /* ignore */ }
  }
  return returnValue;
};

/** @private Used internally when some message needs to get to the programmer */
dwr.engine._debug = function(message, stacktrace) {
  var written = false;
  try {
    if (window.console) {
      if (stacktrace && window.console.trace) window.console.trace();
      window.console.log(message);
      written = true;
    }
    else if (window.opera && window.opera.postError) {
      window.opera.postError(message);
      written = true;
    }
  }
  catch (ex) { /* ignore */ }

  if (!written) {
    var debug = document.getElementById("dwr-debug");
    if (debug) {
      var contents = message + "<br/>" + debug.innerHTML;
      if (contents.length > 2048) contents = contents.substring(0, 2048);
      debug.innerHTML = contents;
    }
  }
};


/*
 * Copyright 2005 Joe Walker
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * Declare an object to which we can add real functions.
 */
if (dwr == null) var dwr = {};
if (dwr.util == null) dwr.util = {};
if (DWRUtil == null) var DWRUtil = dwr.util;
/** @private The flag we use to decide if we should escape html */
dwr.util._escapeHtml = true;
/**
 * Set the global escapeHtml flag
 */
dwr.util.setEscapeHtml = function(escapeHtml) {
  dwr.util._escapeHtml = escapeHtml;
}
/** @private Work out from an options list and global settings if we should be esccaping */
dwr.util._shouldEscapeHtml = function(options) {
  if (options && options.escapeHtml != null) {
    return options.escapeHtml;
  }
  return dwr.util._escapeHtml;
}
/**
 * Return a string with &, <, >, ' and " replaced with their entities
 * @see TODO
 */
dwr.util.escapeHtml = function(original) {
  var div = document.createElement('div');
  var text = document.createTextNode(original);
  div.appendChild(text);
  return div.innerHTML;
}
/**
 * Replace common XML entities with characters (see dwr.util.escapeHtml())
 * @see TODO
 */
dwr.util.unescapeHtml = function(original) {
  var div = document.createElement('div');
  div.innerHTML = original.replace(/<\/?[^>]+>/gi, '');
  return div.childNodes[0] ? div.childNodes[0].nodeValue : '';
}
/**
 * Replace characters dangerous for XSS reasons with visually similar characters
 * @see TODO
 */
dwr.util.replaceXmlCharacters = function(original) {
  original = original.replace("&", "+");
  original = original.replace("<", "\u2039");
  original = original.replace(">", "\u203A");
  original = original.replace("\'", "\u2018");
  original = original.replace("\"", "\u201C");
  return original;
}
/**
 * Return true iff the input string contains any XSS dangerous characters
 * @see TODO
 */
dwr.util.containsXssRiskyCharacters = function(original) {
  return (original.indexOf('&') != -1
    || original.indexOf('<') != -1
    || original.indexOf('>') != -1
    || original.indexOf('\'') != -1
    || original.indexOf('\"') != -1);
}
/**
 * Enables you to react to return being pressed in an input
 * @see http://getahead.org/dwr/browser/util/selectrange
 */
dwr.util.onReturn = function(event, action) {
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13) action();
};
/**
 * Select a specific range in a text box. Useful for 'google suggest' type functions.
 * @see http://getahead.org/dwr/browser/util/selectrange
 */
dwr.util.selectRange = function(ele, start, end) {
  ele = dwr.util._getElementById(ele, "selectRange()");
  if (ele == null) return;
  if (ele.setSelectionRange) {
    ele.setSelectionRange(start, end);
  }
  else if (ele.createTextRange) {
    var range = ele.createTextRange();
    range.moveStart("character", start);
    range.moveEnd("character", end - ele.value.length);
    range.select();
  }
  ele.focus();
};
/**
 * Find the element in the current HTML document with the given id or ids
 * @see http://getahead.org/dwr/browser/util/$
 */
if (document.getElementById) {
  dwr.util.byId = function() {
    var elements = new Array();
    for (var i = 0; i < arguments.length; i++) {
      var element = arguments[i];
      if (typeof element == 'string') {
        element = document.getElementById(element);
      }
      if (arguments.length == 1) {
        return element;
      }
      elements.push(element);
    }
    return elements;
  };
}
else if (document.all) {
  dwr.util.byId = function() {
    var elements = new Array();
    for (var i = 0; i < arguments.length; i++) {
      var element = arguments[i];
      if (typeof element == 'string') {
        element = document.all[element];
      }
      if (arguments.length == 1) {
        return element;
      }
      elements.push(element);
    }
    return elements;
  };
}
/**
 * Alias $ to dwr.util.byId
 * @see http://getahead.org/dwr/browser/util/$
 */
var $;
if (!$) {
  $ = dwr.util.byId;
}
/**
 * This function pretty-prints simple data or whole object graphs, f ex as an aid in debugging.
 * @see http://getahead.org/dwr/browser/util/todescriptivestring
 */
dwr.util.toDescriptiveString = function(data, showLevels, options) {
  if (showLevels === undefined) showLevels = 1;
  var opt = {};
  if (dwr.util._isObject(options)) opt = options;
  var defaultoptions = {
    escapeHtml:false,
    baseIndent: "",
    childIndent: "\u00A0\u00A0",
    lineTerminator: "\n",
    oneLineMaxItems: 5,
    shortStringMaxLength: 13,
    propertyNameMaxLength: 30 
  };
  for (var p in defaultoptions) if (!(p in opt)) opt[p] = defaultoptions[p];
  if (typeof options == "number") {
    var baseDepth = options;
    opt.baseIndent = dwr.util._indent2(baseDepth, opt);
  }
  var skipDomProperties = {
    document:true, ownerDocument:true,
    all:true,
    parentElement:true, parentNode:true, offsetParent:true,
    children:true, firstChild:true, lastChild:true,
    previousSibling:true, nextSibling:true,
    innerHTML:true, outerHTML:true,
    innerText:true, outerText:true, textContent:true,
    attributes:true,
    style:true, currentStyle:true, runtimeStyle:true,
    parentTextEdit:true
  };
  
  function recursive(data, showLevels, indentDepth, options) {
    var reply = "";
    try {
      // string
      if (typeof data == "string") {
        var str = data;
        if (showLevels == 0 && str.length > options.shortStringMaxLength)
          str = str.substring(0, options.shortStringMaxLength-3) + "...";
        if (options.escapeHtml) {
          // Do the escape separately for every line as escapeHtml() on some 
          // browsers (IE) will strip line breaks and we want to preserve them
          var lines = str.split("\n");
          for (var i = 0; i < lines.length; i++) lines[i] = dwr.util.escapeHtml(lines[i]);
          str = lines.join("\n");
        }
        if (showLevels == 0) { // Short format
          str = str.replace(/\n|\r|\t/g, function(ch) {
            switch (ch) {
              case "\n": return "\\n";
              case "\r": return "";
              case "\t": return "\\t";
            }
          });
        }
        else { // Long format
          str = str.replace(/\n|\r|\t/g, function(ch) {
            switch (ch) {
              case "\n": return options.lineTerminator + indent(indentDepth+1, options);
              case "\r": return "";
              case "\t": return "\\t";
            }
          });
        }
        reply = '"' + str + '"';
      }
      
      // function
      else if (typeof data == "function") {
        reply = "function";
      }
    
      // Array
      else if (dwr.util._isArray(data)) {
        if (showLevels == 0) { // Short format (don't show items)
          if (data.length > 0)
            reply = "[...]";
          else
            reply = "[]";
        }
        else { // Long format (show items)
          var strarr = [];
          strarr.push("[");
          var count = 0;
          for (var i = 0; i < data.length; i++) {
            if (! (i in data)) continue;
            var itemvalue = data[i];
            if (count > 0) strarr.push(", ");
            if (showLevels == 1) { // One-line format
              if (count == options.oneLineMaxItems) {
                strarr.push("...");
                break;
              }
            }
            else { // Multi-line format
              strarr.push(options.lineTerminator + indent(indentDepth+1, options));
            }
            if (i != count) {
              strarr.push(i);
              strarr.push(":");
            }
            strarr.push(recursive(itemvalue, showLevels-1, indentDepth+1, options));
            count++;
          }
          if (showLevels > 1) strarr.push(options.lineTerminator + indent(indentDepth, options));
          strarr.push("]");
          reply = strarr.join("");
        }
      }
      
      // Objects except Date
      else if (dwr.util._isObject(data) && !dwr.util._isDate(data)) {
        if (showLevels == 0) { // Short format (don't show properties)
          reply = dwr.util._detailedTypeOf(data);
        }
        else { // Long format (show properties)
          var strarr = [];
          if (dwr.util._detailedTypeOf(data) != "Object") {
            strarr.push(dwr.util._detailedTypeOf(data));
            if (typeof data.valueOf() != "object") {
              strarr.push(":");
              strarr.push(recursive(data.valueOf(), 1, indentDepth, options));
            }
            strarr.push(" ");
          }
          strarr.push("{");
          var isDomObject = dwr.util._isHTMLElement(data); 
          var count = 0;
          for (var prop in data) {
            var propvalue = data[prop];
            if (isDomObject) {
              if (!propvalue) continue;
              if (typeof propvalue == "function") continue;
              if (skipDomProperties[prop]) continue;
              if (prop.toUpperCase() == prop) continue;
            }
            if (count > 0) strarr.push(", ");
            if (showLevels == 1) { // One-line format
              if (count == options.oneLineMaxItems) {
                strarr.push("...");
                break;
              }
            }
            else { // Multi-line format
              strarr.push(options.lineTerminator + indent(indentDepth+1, options));
            }
            strarr.push(prop.length > options.propertyNameMaxLength ? prop.substring(0, options.propertyNameMaxLength-3) + "..." : prop);
            strarr.push(":");
            strarr.push(recursive(propvalue, showLevels-1, indentDepth+1, options));
            count++;
          }
          if (showLevels > 1 && count > 0) strarr.push(options.lineTerminator + indent(indentDepth, options));
          strarr.push("}");
          reply = strarr.join("");
        }
      }
  
      // undefined, null, number, boolean, Date
      else {
        reply = "" + data;
      }
  
      return reply;
    }
    catch(err) {
      return (err.message ? err.message : ""+err);
    }
  }
  function indent(count, options) {
    var strarr = [];
    strarr.push(options.baseIndent);
    for (var i=0; i<count; i++) {
      strarr.push(options.childIndent);
    }
    return strarr.join("");
  };
  
  return recursive(data, showLevels, 0, opt);
}
/**
 * Setup a GMail style loading message.
 * @see http://getahead.org/dwr/browser/util/useloadingmessage
 */
dwr.util.useLoadingMessage = function(message) {
  var loadingMessage;
  if (message) loadingMessage = message;
  else loadingMessage = "Loading";
  dwr.engine.setPreHook(function() {
    var disabledZone = dwr.util.byId('disabledZone');
    if (!disabledZone) {
      disabledZone = document.createElement('div');
      disabledZone.setAttribute('id', 'disabledZone');
      disabledZone.style.position = "absolute";
      disabledZone.style.zIndex = "1000";
      //disabledZone.style.left = "0px";
      disabledZone.style.top = "0px";
      disabledZone.style.right = "0px";
      //disabledZone.style.width = "100%";
      //disabledZone.style.height = "100%";
      document.body.appendChild(disabledZone);
      var messageZone = document.createElement('div');
      messageZone.setAttribute('id', 'messageZone');
      messageZone.style.position = "absolute";
      messageZone.style.top = "0px";
      messageZone.style.right = "0px";
      messageZone.style.width = "80px";
      messageZone.style.background = "red";
      messageZone.style.color = "white";
      messageZone.style.fontFamily = "Arial,Helvetica,sans-serif";
      messageZone.style.padding = "4px";
      disabledZone.appendChild(messageZone);
      var text = document.createTextNode(loadingMessage);
      messageZone.appendChild(text);
      dwr.util._disabledZoneUseCount = 1;
    }
    else {
      dwr.util.byId('messageZone').innerHTML = loadingMessage;
      disabledZone.style.visibility = 'visible';
      dwr.util._disabledZoneUseCount++;
    }
  });
  dwr.engine.setPostHook(function() {
    dwr.util._disabledZoneUseCount--;
    if (dwr.util._disabledZoneUseCount == 0) {
      dwr.util.byId('disabledZone').style.visibility = 'hidden';
    }else{
    	//always close 	disabledZone (yfzhu 2008-8-8)
    	dwr.util.byId('disabledZone').style.visibility = 'hidden';
    }
  });
};
/**
 * Set a global highlight handler
 */
dwr.util.setHighlightHandler = function(handler) {
  dwr.util._highlightHandler = handler;
};
/**
 * An example highlight handler
 */
dwr.util.yellowFadeHighlightHandler = function(ele) {
  dwr.util._yellowFadeProcess(ele, 0);
};
dwr.util._yellowFadeSteps = [ "d0", "b0", "a0", "90", "98", "a0", "a8", "b0", "b8", "c0", "c8", "d0", "d8", "e0", "e8", "f0", "f8" ];
dwr.util._yellowFadeProcess = function(ele, colorIndex) {
  ele = dwr.util.byId(ele);
  if (colorIndex < dwr.util._yellowFadeSteps.length) {
    ele.style.backgroundColor = "#ffff" + dwr.util._yellowFadeSteps[colorIndex];
    setTimeout("dwr.util._yellowFadeProcess('" + ele.id + "'," + (colorIndex + 1) + ")", 200);
  }
  else {
    ele.style.backgroundColor = "transparent";
  }
};
/**
 * An example highlight handler
 */
dwr.util.borderFadeHighlightHandler = function(ele) {
  ele.style.borderWidth = "2px";
  ele.style.borderStyle = "solid";
  dwr.util._borderFadeProcess(ele, 0);
};
dwr.util._borderFadeSteps = [ "d0", "b0", "a0", "90", "98", "a0", "a8", "b0", "b8", "c0", "c8", "d0", "d8", "e0", "e8", "f0", "f8" ];
dwr.util._borderFadeProcess = function(ele, colorIndex) {
  ele = dwr.util.byId(ele);
  if (colorIndex < dwr.util._borderFadeSteps.length) {
    ele.style.borderColor = "#ff" + dwr.util._borderFadeSteps[colorIndex] + dwr.util._borderFadeSteps[colorIndex];
    setTimeout("dwr.util._borderFadeProcess('" + ele.id + "'," + (colorIndex + 1) + ")", 200);
  }
  else {
    ele.style.backgroundColor = "transparent";
  }
};
/**
 * A focus highlight handler
 */
dwr.util.focusHighlightHandler = function(ele) {
  try {
    ele.focus();
  }
  catch (ex) { /* ignore */ }
};
/** @private the current global highlight style */
dwr.util._highlightHandler = null;
/**
 * Highlight that an element has changed
 */
dwr.util.highlight = function(ele, options) {
  if (options && options.highlightHandler) {
    options.highlightHandler(dwr.util.byId(ele));
  }
  else if (dwr.util._highlightHandler != null) {
    dwr.util._highlightHandler(dwr.util.byId(ele));
  }
};
/**
 * Set the value an HTML element to the specified value.
 * @see http://getahead.org/dwr/browser/util/setvalue
 */
dwr.util.setValue = function(ele, val, options) {
  if (val == null) val = "";
  if (options == null) options = {};
  if (dwr.util._shouldEscapeHtml(options) && typeof(val) == "string") {
    val = dwr.util.escapeHtml(val);
  }
  var orig = ele;
  if (typeof ele == "string") {
    ele = dwr.util.byId(ele);
    // We can work with names and need to sometimes for radio buttons, and IE has
    // an annoying bug where getElementById() returns an element based on name if
    // it doesn't find it by id. Here we don't want to do that, so:
    if (ele && ele.id != orig) ele = null;
  }
  var nodes = null;
  if (ele == null) {
    // Now it is time to look by name
    nodes = document.getElementsByName(orig);
    if (nodes.length >= 1) ele = nodes.item(0);
  }
  if (ele == null) {
    dwr.util._debug("setValue() can't find an element with id/name: " + orig + ".");
    return;
  }
  // All paths now lead to some update so we highlight a change
  dwr.util.highlight(ele, options);
  if (dwr.util._isHTMLElement(ele, "select")) {
    if (ele.type == "select-multiple" && dwr.util._isArray(val)) dwr.util._selectListItems(ele, val);
    else dwr.util._selectListItem(ele, val);
    return;
  }
  if (dwr.util._isHTMLElement(ele, "input")) {
    if (ele.type == "radio" || ele.type == "checkbox") {
      if (nodes && nodes.length >= 1) {
        for (var i = 0; i < nodes.length; i++) {
          var node = nodes.item(i);
          if (node.type != ele.type) continue;
          if (dwr.util._isArray(val)) {
            node.checked = false;
            for (var j = 0; j < val.length; j++)
              if (val[i] == node.value) node.checked = true;
          }
          else {
            node.checked = (node.value == val);
          }
        }
      }
      else ele.checked = (val == true);
    }
    else ele.value = val;
    return;
  }
  if (dwr.util._isHTMLElement(ele, "textarea")) {
    ele.value = val;
    return;
  }
  // If the value to be set is a DOM object then we try importing the node
  // rather than serializing it out
  if (val.nodeType) {
    if (val.nodeType == 9 /*Node.DOCUMENT_NODE*/) val = val.documentElement;
    val = dwr.util._importNode(ele.ownerDocument, val, true);
    ele.appendChild(val);
    return;
  }
  // Fall back to innerHTML
  ele.innerHTML = val;
};
/**
 * @private Find multiple items in a select list and select them. Used by setValue()
 * @param ele The select list item
 * @param val The array of values to select
 */
dwr.util._selectListItems = function(ele, val) {
  // We deal with select list elements by selecting the matching option
  // Begin by searching through the values
  var found  = false;
  var i;
  var j;
  for (i = 0; i < ele.options.length; i++) {
    ele.options[i].selected = false;
    for (j = 0; j < val.length; j++) {
      if (ele.options[i].value == val[j]) {
        ele.options[i].selected = true;
      }
    }
  }
  // If that fails then try searching through the visible text
  if (found) return;
  for (i = 0; i < ele.options.length; i++) {
    for (j = 0; j < val.length; j++) {
      if (ele.options[i].text == val[j]) {
        ele.options[i].selected = true;
      }
    }
  }
};
/**
 * @private Find an item in a select list and select it. Used by setValue()
 * @param ele The select list item
 * @param val The value to select
 */
dwr.util._selectListItem = function(ele, val) {
  // We deal with select list elements by selecting the matching option
  // Begin by searching through the values
  var found = false;
  var i;
  for (i = 0; i < ele.options.length; i++) {
    if (ele.options[i].value == val) {
      ele.options[i].selected = true;
      found = true;
    }
    else {
      ele.options[i].selected = false;
    }
  }
  // If that fails then try searching through the visible text
  if (found) return;
  for (i = 0; i < ele.options.length; i++) {
    if (ele.options[i].text == val) {
      ele.options[i].selected = true;
    }
    else {
      ele.options[i].selected = false;
    }
  }
};
/**
 * Read the current value for a given HTML element.
 * @see http://getahead.org/dwr/browser/util/getvalue
 */
dwr.util.getValue = function(ele, options) {
  if (options == null) options = {};
  var orig = ele;
  if (typeof ele == "string") {
    ele = dwr.util.byId(ele);
    // We can work with names and need to sometimes for radio buttons, and IE has
    // an annoying bug where getElementById() returns an element based on name if
    // it doesn't find it by id. Here we don't want to do that, so:
    if (ele && ele.id != orig) ele = null;
  }
  var nodes = null;
  if (ele == null) {
    // Now it is time to look by name
    nodes = document.getElementsByName(orig);
    if (nodes.length >= 1) ele = nodes.item(0);
  }
  if (ele == null) {
    dwr.util._debug("getValue() can't find an element with id/name: " + orig + ".");
    return "";
  }
  if (dwr.util._isHTMLElement(ele, "select")) {
    // Using "type" property instead of "multiple" as "type" is an official 
    // client-side property since JS 1.1
    if (ele.type == "select-multiple") {
      var reply = new Array();
      for (var i = 0; i < ele.options.length; i++) {
        var item = ele.options[i];
        if (item.selected) {
          var valueAttr = item.getAttributeNode("value");
          if (valueAttr && valueAttr.specified) {
            reply.push(item.value);
          }
          else {
            reply.push(item.text);
          }
        }
      }
      return reply;
    }
    else {
      var sel = ele.selectedIndex;
      if (sel != -1) {
        var item = ele.options[sel];
        var valueAttr = item.getAttributeNode("value");
        if (valueAttr && valueAttr.specified) {
          return item.value;
        }
        return item.text;
      }
      else {
        return "";
      }
    }
  }
  if (dwr.util._isHTMLElement(ele, "input")) {
    if (ele.type == "radio") {
      if (nodes && nodes.length >= 1) {
        for (var i = 0; i < nodes.length; i++) {
          var node = nodes.item(i);
          if (node.type == ele.type) {
            if (node.checked) return node.value;
          }
        }
      }
      return ele.checked;
    }
    if (ele.type == "checkbox") {
      if (nodes && nodes.length >= 1) {
        var reply = [];
        for (var i = 0; i < nodes.length; i++) {
          var node = nodes.item(i);
          if (node.type == ele.type) {
            if (node.checked) reply.push(node.value);
          }
        }
        return reply;
      }
      return ele.checked;
    }
    return ele.value;
  }
  if (dwr.util._isHTMLElement(ele, "textarea")) {
    return ele.value;
  }
  if (dwr.util._shouldEscapeHtml(options)) {
    if (ele.textContent) return ele.textContent;
    else if (ele.innerText) return ele.innerText;
  }
  return ele.innerHTML;
};
/**
 * getText() is like getValue() except that it reads the text (and not the value) from select elements
 * @see http://getahead.org/dwr/browser/util/gettext
 */
dwr.util.getText = function(ele) {
  ele = dwr.util._getElementById(ele, "getText()");
  if (ele == null) return null;
  if (!dwr.util._isHTMLElement(ele, "select")) {
    dwr.util._debug("getText() can only be used with select elements. Attempt to use: " + dwr.util._detailedTypeOf(ele) + " from  id: " + orig + ".");
    return "";
  }
  // This is a bit of a scam because it assumes single select
  // but I'm not sure how we should treat multi-select.
  var sel = ele.selectedIndex;
  if (sel != -1) {
    return ele.options[sel].text;
  }
  else {
    return "";
  }
};
/**
 * Given a map, or a recursive structure consisting of arrays and maps, call 
 * setValue() for all leaf entries and use intermediate levels to form nested
 * element ids.
 * @see http://getahead.org/dwr/browser/util/setvalues
 */
dwr.util.setValues = function(data, options) {
  var prefix = "";
  if (options && options.prefix) prefix = options.prefix;
  if (options && options.idPrefix) prefix = options.idPrefix;
  dwr.util._setValuesRecursive(data, prefix);
};
/**
 * @private Recursive helper for setValues()
 */
dwr.util._setValuesRecursive = function(data, idpath) {
  // Array containing objects -> add "[n]" to prefix and make recursive call
  // for each item object
  if (dwr.util._isArray(data) && data.length > 0 && dwr.util._isObject(data[0])) {
    for (var i = 0; i < data.length; i++) {
      dwr.util._setValuesRecursive(data[i], idpath+"["+i+"]");
    }
  }
  // Object (not array) -> handle nested object properties
  else if (dwr.util._isObject(data) && !dwr.util._isArray(data)) {
    for (var prop in data) {
      var subidpath = idpath ? idpath+"."+prop : prop;
      // Object (not array), or array containing objects -> call ourselves recursively
      if (dwr.util._isObject(data[prop]) && !dwr.util._isArray(data[prop]) 
          || dwr.util._isArray(data[prop]) && data[prop].length > 0 && dwr.util._isObject(data[prop][0])) {
        dwr.util._setValuesRecursive(data[prop], subidpath);
      }
      // Functions -> skip
      else if (typeof data[prop] == "function") {
        // NOP
      }
      // Only simple values left (or array of simple values, or empty array)
      // -> call setValue()
      else {
        // Are there any elements with that id or name
        if (dwr.util.byId(subidpath) != null || document.getElementsByName(subidpath).length >= 1) {
          dwr.util.setValue(subidpath, data[prop]);
        }
      }
    }
  }
};
/**
 * Given a map, or a recursive structure consisting of arrays and maps, call 
 * getValue() for all leaf entries and use intermediate levels to form nested
 * element ids.
 * Given a string or element that refers to a form, create an object from the 
 * elements of the form.
 * @see http://getahead.org/dwr/browser/util/getvalues
 */
dwr.util.getValues = function(data, options) {
  if (typeof data == "string" || dwr.util._isHTMLElement(data)) {
    return dwr.util.getFormValues(data);
  }
  else {
    var prefix = "";
    if (options != null && options.prefix) prefix = options.prefix;
    if (options != null && options.idPrefix) prefix = options.idPrefix;
    dwr.util._getValuesRecursive(data, prefix);
    return data;
  }
};
/**
 * Given a string or element that refers to a form, create an object from the 
 * elements of the form.
 * @see http://getahead.org/dwr/browser/util/getvalues
 */
dwr.util.getFormValues = function(eleOrNameOrId) {
  var ele = null;
  if (typeof eleOrNameOrId == "string") {
    ele = document.forms[eleOrNameOrId];
    if (ele == null) ele = dwr.util.byId(eleOrNameOrId);
  }
  else if (dwr.util._isHTMLElement(eleOrNameOrId)) {
    ele = eleOrNameOrId;
  }
  if (ele != null) {
    if (ele.elements == null) {
      alert("getFormValues() requires an object or reference to a form element.");
      return null;
    }
    var reply = {};
    var name;
    var value;
    for (var i = 0; i < ele.elements.length; i++) {
      if (ele[i].type in {button:0,submit:0,reset:0,image:0,file:0}) continue;
      if (ele[i].name) {
        name = ele[i].name;
        value = dwr.util.getValue(name);
      }
      else {
        if (ele[i].id) name = ele[i].id;
        else name = "element" + i;
        value = dwr.util.getValue(ele[i]);
      }
      reply[name] = value;
    }
    return reply;
  }
};
/**
 * @private Recursive helper for getValues().
 */
dwr.util._getValuesRecursive = function(data, idpath) {
  // Array containing objects -> add "[n]" to idpath and make recursive call
  // for each item object
  if (dwr.util._isArray(data) && data.length > 0 && dwr.util._isObject(data[0])) {
    for (var i = 0; i < data.length; i++) {
      dwr.util._getValuesRecursive(data[i], idpath+"["+i+"]");
    }
  }
  // Object (not array) -> handle nested object properties
  else if (dwr.util._isObject(data) && !dwr.util._isArray(data)) {
    for (var prop in data) {
      var subidpath = idpath ? idpath+"."+prop : prop;
      // Object, or array containing objects -> call ourselves recursively
      if (dwr.util._isObject(data[prop]) && !dwr.util._isArray(data[prop])
          || dwr.util._isArray(data[prop]) && data[prop].length > 0 && dwr.util._isObject(data[prop][0])) {
        dwr.util._getValuesRecursive(data[prop], subidpath);
      }
      // Functions -> skip
      else if (typeof data[prop] == "function") {
        // NOP
      }
      // Only simple values left (or array of simple values, or empty array)
      // -> call getValue()
      else {
        // Are there any elements with that id or name
        if (dwr.util.byId(subidpath) != null || document.getElementsByName(subidpath).length >= 1) {
          data[prop] = dwr.util.getValue(subidpath);
        }
      }
    }
  }
};
/**
 * Add options to a list from an array or map.
 * @see http://getahead.org/dwr/browser/lists
 */
dwr.util.addOptions = function(ele, data/*, options*/) {
  ele = dwr.util._getElementById(ele, "addOptions()");
  if (ele == null) return;
  var useOptions = dwr.util._isHTMLElement(ele, "select");
  var useLi = dwr.util._isHTMLElement(ele, ["ul", "ol"]);
  if (!useOptions && !useLi) {
    dwr.util._debug("addOptions() can only be used with select/ul/ol elements. Attempt to use: " + dwr.util._detailedTypeOf(ele));
    return;
  }
  if (data == null) return;
  
  var argcount = arguments.length;
  var options = {};
  var lastarg = arguments[argcount - 1]; 
  if (argcount > 2 && dwr.util._isObject(lastarg)) {
    options = lastarg;
    argcount--;
  }
  var arg3 = null; if (argcount >= 3) arg3 = arguments[2];
  var arg4 = null; if (argcount >= 4) arg4 = arguments[3];
  if (!options.optionCreator && useOptions) options.optionCreator = dwr.util._defaultOptionCreator;
  if (!options.optionCreator && useLi) options.optionCreator = dwr.util._defaultListItemCreator;
  var text, value, li;
  if (dwr.util._isArray(data)) {
    // Loop through the data that we do have
    for (var i = 0; i < data.length; i++) {
      options.data = data[i];
      options.text = null;
      options.value = null;
      if (useOptions) {
        if (arg3 != null) {
          if (arg4 != null) {
            options.text = dwr.util._getValueFrom(data[i], arg4);
            options.value = dwr.util._getValueFrom(data[i], arg3);
          }
          else options.text = options.value = dwr.util._getValueFrom(data[i], arg3);
        }
        else options.text = options.value = dwr.util._getValueFrom(data[i]);
        if (options.text != null || options.value) {
          var opt = options.optionCreator(options);
          opt.text = options.text;
          opt.value = options.value;
          ele.options[ele.options.length] = opt;
        }
      }
      else {
        options.value = dwr.util._getValueFrom(data[i], arg3);
        if (options.value != null) {
          li = options.optionCreator(options);
          if (dwr.util._shouldEscapeHtml(options)) {
            options.value = dwr.util.escapeHtml(options.value);
          }
          li.innerHTML = options.value;
          ele.appendChild(li);
        }
      }
    }
  }
  else if (arg4 != null) {
    if (!useOptions) {
      alert("dwr.util.addOptions can only create select lists from objects.");
      return;
    }
    for (var prop in data) {
      options.data = data[prop];
      options.value = dwr.util._getValueFrom(data[prop], arg3);
      options.text = dwr.util._getValueFrom(data[prop], arg4);
      if (options.text != null || options.value) {
        var opt = options.optionCreator(options);
        opt.text = options.text;
        opt.value = options.value;
        ele.options[ele.options.length] = opt;
      }
    }
  }
  else {
    if (!useOptions) {
      dwr.util._debug("dwr.util.addOptions can only create select lists from objects.");
      return;
    }
    for (var prop in data) {
      options.data = data[prop];
      if (!arg3) {
        options.value = prop;
        options.text = data[prop];
      }
      else {
        options.value = data[prop];
        options.text = prop;
      }
      if (options.text != null || options.value) {
        var opt = options.optionCreator(options);
        opt.text = options.text;
        opt.value = options.value;
        ele.options[ele.options.length] = opt;
      }
    }
  }
  // All error routes through this function result in a return, so highlight now
  dwr.util.highlight(ele, options); 
};
/**
 * @private Get the data from an array function for dwr.util.addOptions
 */
dwr.util._getValueFrom = function(data, method) {
  if (method == null) return data;
  else if (typeof method == 'function') return method(data);
  else return data[method];
};
/**
 * @private Default option creation function
 */
dwr.util._defaultOptionCreator = function(options) {
  return new Option();
};
/**
 * @private Default list item creation function
 */
dwr.util._defaultListItemCreator = function(options) {
  return document.createElement("li");
};
/**
 * Remove all the options from a select list (specified by id)
 * @see http://getahead.org/dwr/browser/lists
 */
dwr.util.removeAllOptions = function(ele) {
  ele = dwr.util._getElementById(ele, "removeAllOptions()");
  if (ele == null) return;
  var useOptions = dwr.util._isHTMLElement(ele, "select");
  var useLi = dwr.util._isHTMLElement(ele, ["ul", "ol"]);
  if (!useOptions && !useLi) {
    dwr.util._debug("removeAllOptions() can only be used with select, ol and ul elements. Attempt to use: " + dwr.util._detailedTypeOf(ele));
    return;
  }
  if (useOptions) {
    ele.options.length = 0;
  }
  else {
    while (ele.childNodes.length > 0) {
      ele.removeChild(ele.firstChild);
    }
  }
};
/**
 * Create rows inside a the table, tbody, thead or tfoot element (given by id).
 * @see http://getahead.org/dwr/browser/tables
 */
dwr.util.addRows = function(ele, data, cellFuncs, options) {
  ele = dwr.util._getElementById(ele, "addRows()");
  if (ele == null) return;
  if (!dwr.util._isHTMLElement(ele, ["table", "tbody", "thead", "tfoot"])) {
    dwr.util._debug("addRows() can only be used with table, tbody, thead and tfoot elements. Attempt to use: " + dwr.util._detailedTypeOf(ele));
    return;
  }
  if (!options) options = {};
  if (!options.rowCreator) options.rowCreator = dwr.util._defaultRowCreator;
  if (!options.cellCreator) options.cellCreator = dwr.util._defaultCellCreator;
  var tr, rowNum;
  if (dwr.util._isArray(data)) {
    for (rowNum = 0; rowNum < data.length; rowNum++) {
      options.rowData = data[rowNum];
      options.rowIndex = rowNum;
      options.rowNum = rowNum;
      options.data = null;
      options.cellNum = -1;
      tr = dwr.util._addRowInner(cellFuncs, options);
      if (tr != null) ele.appendChild(tr);
    }
  }
  else if (typeof data == "object") {
    rowNum = 0;
    for (var rowIndex in data) {
      options.rowData = data[rowIndex];
      options.rowIndex = rowIndex;
      options.rowNum = rowNum;
      options.data = null;
      options.cellNum = -1;
      tr = dwr.util._addRowInner(cellFuncs, options);
      if (tr != null) ele.appendChild(tr);
      rowNum++;
    }
  }
  dwr.util.highlight(ele, options);
};
/**
 * @private Internal function to draw a single row of a table.
 */
dwr.util._addRowInner = function(cellFuncs, options) {
  var tr = options.rowCreator(options);
  if (tr == null) return null;
  for (var cellNum = 0; cellNum < cellFuncs.length; cellNum++) {
    var func = cellFuncs[cellNum];
    if (typeof func == 'function') options.data = func(options.rowData, options);
    else options.data = func || "";
    options.cellNum = cellNum;
    var td = options.cellCreator(options);
    if (td != null) {
      if (options.data != null) {
        if (dwr.util._isHTMLElement(options.data)) td.appendChild(options.data);
        else {
          if (dwr.util._shouldEscapeHtml(options) && typeof(options.data) == "string") {
            td.innerHTML = dwr.util.escapeHtml(options.data);
          }
          else {
            td.innerHTML = options.data;
          }
        }
      }
      tr.appendChild(td);
    }
  }
  return tr;
};
/**
 * @private Default row creation function
 */
dwr.util._defaultRowCreator = function(options) {
  return document.createElement("tr");
};
/**
 * @private Default cell creation function
 */
dwr.util._defaultCellCreator = function(options) {
  return document.createElement("td");
};
/**
 * Remove all the children of a given node.
 * @see http://getahead.org/dwr/browser/tables
 */
dwr.util.removeAllRows = function(ele, options) {
  ele = dwr.util._getElementById(ele, "removeAllRows()");
  if (ele == null) return;
  if (!options) options = {};
  if (!options.filter) options.filter = function() { return true; };
  if (!dwr.util._isHTMLElement(ele, ["table", "tbody", "thead", "tfoot"])) {
    dwr.util._debug("removeAllRows() can only be used with table, tbody, thead and tfoot elements. Attempt to use: " + dwr.util._detailedTypeOf(ele));
    return;
  }
  var child = ele.firstChild;
  var next;
  while (child != null) {
    next = child.nextSibling;
    if (options.filter(child)) {
      ele.removeChild(child);
    }
    child = next;
  }
};
/**
 * dwr.util.byId(ele).className = "X", that we can call from Java easily.
 */
dwr.util.setClassName = function(ele, className) {
  ele = dwr.util._getElementById(ele, "setClassName()");
  if (ele == null) return;
  ele.className = className;
};
/**
 * dwr.util.byId(ele).className += "X", that we can call from Java easily.
 */
dwr.util.addClassName = function(ele, className) {
  ele = dwr.util._getElementById(ele, "addClassName()");
  if (ele == null) return;
  ele.className += " " + className;
};
/**
 * dwr.util.byId(ele).className -= "X", that we can call from Java easily
 * From code originally by Gavin Kistner
 */
dwr.util.removeClassName = function(ele, className) {
  ele = dwr.util._getElementById(ele, "removeClassName()");
  if (ele == null) return;
  var regex = new RegExp("(^|\\s)" + className + "(\\s|$)", 'g');
  ele.className = ele.className.replace(regex, '');
};
/**
 * dwr.util.byId(ele).className |= "X", that we can call from Java easily.
 */
dwr.util.toggleClassName = function(ele, className) {
  ele = dwr.util._getElementById(ele, "toggleClassName()");
  if (ele == null) return;
  var regex = new RegExp("(^|\\s)" + className + "(\\s|$)");
  if (regex.test(ele.className)) {
    ele.className = ele.className.replace(regex, '');
  }
  else {
    ele.className += " " + className;
  }
};
/**
 * Clone a node and insert it into the document just above the 'template' node
 * @see http://getahead.org/dwr/???
 */
dwr.util.cloneNode = function(ele, options) {
  ele = dwr.util._getElementById(ele, "cloneNode()");
  if (ele == null) return null;
  if (options == null) options = {};
  var clone = ele.cloneNode(true);
  if (options.idPrefix || options.idSuffix) {
    dwr.util._updateIds(clone, options);
  }
  else {
    dwr.util._removeIds(clone);
  }
  ele.parentNode.insertBefore(clone, ele);
  return clone;
};
/**
 * @private Update all of the ids in an element tree
 */
dwr.util._updateIds = function(ele, options) {
  if (options == null) options = {};
  if (ele.id) {
    ele.setAttribute("id", (options.idPrefix || "") + ele.id + (options.idSuffix || ""));
  }
  var children = ele.childNodes;
  for (var i = 0; i < children.length; i++) {
    var child = children.item(i);
    if (child.nodeType == 1 /*Node.ELEMENT_NODE*/) {
      dwr.util._updateIds(child, options);
    }
  }
};
/**
 * @private Remove all the Ids from an element
 */
dwr.util._removeIds = function(ele) {
  if (ele.id) ele.removeAttribute("id");
  var children = ele.childNodes;
  for (var i = 0; i < children.length; i++) {
    var child = children.item(i);
    if (child.nodeType == 1 /*Node.ELEMENT_NODE*/) {
      dwr.util._removeIds(child);
    }
  }
};
/**
 * Clone a template node and its embedded template child nodes according to
 * cardinalities (of arrays) in supplied data.  
 */
dwr.util.cloneNodeForValues = function(templateEle, data, options) {
  templateEle = dwr.util._getElementById(templateEle, "cloneNodeForValues()");
  if (templateEle == null) return null;
  if (options == null) options = {};
  var idpath;
  if (options.idPrefix != null)
    idpath = options.idPrefix;
  else
    idpath = templateEle.id || ""; 
  return dwr.util._cloneNodeForValuesRecursive(templateEle, data, idpath, options);
};
/**
 * @private Recursive helper for cloneNodeForValues(). 
 */
dwr.util._cloneNodeForValuesRecursive = function(templateEle, data, idpath, options) {
  // Incoming array -> make an id for each item and call clone of the template 
  // for each of them
  if (dwr.util._isArray(data)) {
    var clones = [];
    for (var i = 0; i < data.length; i++) {
      var item = data[i];
      var clone = dwr.util._cloneNodeForValuesRecursive(templateEle, item, idpath + "[" + i + "]", options);
      clones.push(clone);
    }
    return clones;
  }
  else
  // Incoming object (not array) -> clone the template, add id prefixes, add 
  // clone to DOM, and then recurse into any array properties if they contain 
  // objects and there is a suitable template
  if (dwr.util._isObject(data) && !dwr.util._isArray(data)) {
    var clone = templateEle.cloneNode(true);
    if (options.updateCloneStyle && clone.style) {
      for (var propname in options.updateCloneStyle) {
        clone.style[propname] = options.updateCloneStyle[propname];
      }
    }
    dwr.util._replaceIds(clone, templateEle.id, idpath);
    templateEle.parentNode.insertBefore(clone, templateEle);
    dwr.util._cloneSubArrays(data, idpath, options);
    return clone;
  }
  // It is an error to end up here so we return nothing
  return null;
};
/**
 * @private Substitute a leading idpath fragment with another idpath for all 
 * element ids tree, and remove ids that don't match the idpath. 
 */
dwr.util._replaceIds = function(ele, oldidpath, newidpath) {
  if (ele.id) {
    var newId = null;
    if (ele.id == oldidpath) {
      newId = newidpath;
    }
    else if (ele.id.length > oldidpath.length) {
      if (ele.id.substr(0, oldidpath.length) == oldidpath) {
        var trailingChar = ele.id.charAt(oldidpath.length);
        if (trailingChar == "." || trailingChar == "[") {
          newId = newidpath + ele.id.substr(oldidpath.length);
        }
      }
    }
    if (newId) {
      ele.setAttribute("id", newId);
    }
    else {
      ele.removeAttribute("id");
    }
  }
  var children = ele.childNodes;
  for (var i = 0; i < children.length; i++) {
    var child = children.item(i);
    if (child.nodeType == 1 /*Node.ELEMENT_NODE*/) {
      dwr.util._replaceIds(child, oldidpath, newidpath);
    }
  }
};
/**
 * @private Finds arrays in supplied data and uses any corresponding template 
 * node to make a clone for each item in the array. 
 */
dwr.util._cloneSubArrays = function(data, idpath, options) {
  for (prop in data) {
    var value = data[prop];
    // Look for potential recursive cloning in all array properties
    if (dwr.util._isArray(value)) {
      // Only arrays with objects are interesting for cloning
      if (value.length > 0 && dwr.util._isObject(value[0])) {
        var subTemplateId = idpath + "." + prop;
        var subTemplateEle = dwr.util.byId(subTemplateId);
        if (subTemplateEle != null) {
          dwr.util._cloneNodeForValuesRecursive(subTemplateEle, value, subTemplateId, options);
        }
      }
    }
    // Continue looking for arrays in object properties
    else if (dwr.util._isObject(value)) {
      dwr.util._cloneSubArrays(value, idpath + "." + prop, options);
    }
  }
}
/**
 * @private Helper to turn a string into an element with an error message
 */
dwr.util._getElementById = function(ele, source) {
  var orig = ele;
  ele = dwr.util.byId(ele);
  if (ele == null) {
    dwr.util._debug(source + " can't find an element with id: " + orig + ".");
  }
  return ele;
};
/**
 * @private Is the given node an HTML element (optionally of a given type)?
 * @param ele The element to test
 * @param nodeName eg "input", "textarea" - check for node name (optional)
 *         if nodeName is an array then check all for a match.
 */
dwr.util._isHTMLElement = function(ele, nodeName) {
  if (ele == null || typeof ele != "object" || ele.nodeName == null) {
    return false;
  }
  if (nodeName != null) {
    var test = ele.nodeName.toLowerCase();
    if (typeof nodeName == "string") {
      return test == nodeName.toLowerCase();
    }
    if (dwr.util._isArray(nodeName)) {
      var match = false;
      for (var i = 0; i < nodeName.length && !match; i++) {
        if (test == nodeName[i].toLowerCase()) {
          match =  true;
        }
      }
      return match;
    }
    dwr.util._debug("dwr.util._isHTMLElement was passed test node name that is neither a string or array of strings");
    return false;
  }
  return true;
};
/**
 * @private Like typeOf except that more information for an object is returned other than "object"
 */
dwr.util._detailedTypeOf = function(x) {
  var reply = typeof x;
  if (reply == "object") {
    reply = Object.prototype.toString.apply(x); // Returns "[object class]"
    reply = reply.substring(8, reply.length-1);  // Just get the class bit
  }
  return reply;
};
/**
 * @private Object detector. Excluding null from objects.
 */
dwr.util._isObject = function(data) {
  return (data && typeof data == "object");
};
/**
 * @private Array detector. Note: instanceof doesn't work with multiple frames.
 */
dwr.util._isArray = function(data) {
  return (data && data.join);
};
/**
 * @private Date detector. Note: instanceof doesn't work with multiple frames.
 */
dwr.util._isDate = function(data) {
  return (data && data.toUTCString) ? true : false;
};
/**
 * @private Used by setValue. Gets around the missing functionallity in IE.
 */
dwr.util._importNode = function(doc, importedNode, deep) {
  var newNode;
  if (importedNode.nodeType == 1 /*Node.ELEMENT_NODE*/) {
    newNode = doc.createElement(importedNode.nodeName);
    for (var i = 0; i < importedNode.attributes.length; i++) {
      var attr = importedNode.attributes[i];
      if (attr.nodeValue != null && attr.nodeValue != '') {
        newNode.setAttribute(attr.name, attr.nodeValue);
      }
    }
    if (typeof importedNode.style != "undefined") {
      newNode.style.cssText = importedNode.style.cssText;
    }
  }
  else if (importedNode.nodeType == 3 /*Node.TEXT_NODE*/) {
    newNode = doc.createTextNode(importedNode.nodeValue);
  }
  if (deep && importedNode.hasChildNodes()) {
    for (i = 0; i < importedNode.childNodes.length; i++) {
      newNode.appendChild(dwr.util._importNode(doc, importedNode.childNodes[i], true));
    }
  }
  return newNode;
};
/** @private Used internally when some message needs to get to the programmer */
dwr.util._debug = function(message, stacktrace) {
  var written = false;
  try {
    if (window.console) {
      if (stacktrace && window.console.trace) window.console.trace();
      window.console.log(message);
      written = true;
    }
    else if (window.opera && window.opera.postError) {
      window.opera.postError(message);
      written = true;
    }
  }
  catch (ex) { /* ignore */ }
  if (!written) {
    var debug = document.getElementById("dwr-debug");
    if (debug) {
      var contents = message + "<br/>" + debug.innerHTML;
      if (contents.length > 2048) contents = contents.substring(0, 2048);
      debug.innerHTML = contents;
    }
  }
};

/* * Part from Bindows 2.55, depends on Prototype for browser check
*/ 
var _biInPrototype=false;
function _biExtend(fConstr,fSuperConstr,sName)
{
	_biInPrototype=true;
	var p=fConstr.prototype=new fSuperConstr();
	if(sName)
	{
		p._className=sName;
	}
	p.constructor=fConstr;
	_biInPrototype=false;
	return p;
}
Function.READ=1;
Function.WRITE=2;
Function.READ_WRITE=3;
Function.EMPTY=function()
{
};

Function.prototype.addProperty=function(sName,nReadWrite)
{
	var p=this.prototype;
	nReadWrite=nReadWrite||Function.READ_WRITE;
	var capitalized=(sName.charAt(0).toUpperCase()+sName.substr(1));
	sName="_"+sName;
	if(nReadWrite&Function.READ)
	{
		p["get"+capitalized]=function()
		{
			return this[sName];
		};
	}
	if(nReadWrite&Function.WRITE)
	{
		p["set"+capitalized]=function(v)
		{
			this[sName]=v;
		};
	}
};
function BiObject()
{
}
_p=_biExtend(BiObject,Object,"BiObject");
_p._disposed=false;
_p._id=null;
BiObject.TYPE_FUNCTION="function";
BiObject.TYPE_OBJECT="object";
BiObject.TYPE_STRING="string";
BiObject._hashCodeCounter=1;
BiObject.isEmpty=function(o)
{
	for(var _ in o)return false;
	return true;
};
BiObject.toHashCode=function(o)
{
	if(o.hasOwnProperty("_hashCode"))return o._hashCode;
	return o._hashCode="_"+(BiObject._hashCodeCounter++ ).toString(32);
};
BiObject.addProperty("disposed",Function.READ);
BiObject.addProperty("id",Function.READ_WRITE);
BiObject.addProperty("userData",Function.READ_WRITE);
_p.toHashCode=function()
{
	return BiObject.toHashCode(this);
};
_p.dispose=function()
{
	this._disposed=true;
	delete this._userData;
	delete this._id;
	this.dispose=Function.EMPTY;
};
_p.disposeFields=function(fieldNames)
{
	var fields=fieldNames instanceof Array?fieldNames:arguments;
	var n,o,p;
	for(var i=0;i<fields.length;i++)
	{
		n=fields[i];
		if(this.hasOwnProperty(n))
		{
			o=this[n];
			if(o!=null)
			{
				if(typeof o.dispose==BiObject.TYPE_FUNCTION)
				{
					o.dispose();
				}
				else if(o instanceof Array)
				{
					for(var j=0;j<o.length;j++)
					{
						p=o[j];
						if(p&&typeof p.dispose==BiObject.TYPE_FUNCTION)
						{
							p.dispose();
						}
					}
				}
			}
			delete this[n];
		}
	}
};
_p.toString=function()
{
	if(this._className)return "[object "+this._className+"]";
	return "[object Object]";
};
_p.getProperty=function(sPropertyName)
{
	var getterName="get"+sPropertyName.capitalize();
	if(typeof this[getterName]==BiObject.TYPE_FUNCTION)return this[getterName]();
	throw new Error("No such property, "+sPropertyName);
};
_p.setProperty=function(sPropertyName,oValue)
{
	var setterName="set"+sPropertyName.capitalize();
	if(typeof this[setterName]==BiObject.TYPE_FUNCTION)this[setterName](oValue);
	else throw new Error("No such property, "+sPropertyName);
};
_p.setProperties=function(oProperties)
{
	for(var p in oProperties)this.setProperty(p,oProperties[p]);
};
_p.setAttribute=function(sName,sValue,oParser)
{
	var v,vv;
	if(sValue==String.BOOLEAN_TRUE)v=true;
	else if(sValue==String.BOOLEAN_FALSE)v=false;
	else if((vv=parseFloat(sValue))==sValue)v=vv;
	else v=sValue;
	this.setProperty(sName,v);
};
_p.getAttribute=function(sName)
{
	return String(this.getProperty(sName));
};
_p.addXmlNode=function(oNode,oParser)
{
	if(oNode.nodeType==1)oParser.fromNode(oNode);
};
if(typeof BiObject=="undefined")BiObject=new Function();

function BiEvent(sType)
{
	if(_biInPrototype)return;
	BiObject.call(this);
	this._type=sType;
}
_p=_biExtend(BiEvent,BiObject,"BiEvent");
_p._bubbles=false;
_p._propagationStopped=true;
_p._defaultPrevented=false;
BiEvent.addProperty("type",Function.READ);
BiEvent.addProperty("target",Function.READ);
BiEvent.addProperty("currentTarget",Function.READ);
BiEvent.addProperty("bubbles",Function.READ);
_p.stopPropagation=function()
{
	this._propagationStopped=true;
};
BiEvent.addProperty("propagationStopped",Function.READ);
_p.preventDefault=function()
{
	this._defaultPrevented=true;
};
BiEvent.addProperty("defaultPrevented",Function.READ);
_p.dispose=function()
{
	BiObject.prototype.dispose.call(this);
	delete this._target;
	delete this._currentTarget;
	delete this._bubbles;
	delete this._propagationStopped;
	delete this._defaultPrevented;
};
_p.getDefaultPrevented=function()
{
	return this._defaultPrevented;
};

function BiEventTarget()
{
	if(_biInPrototype)return;
	BiObject.call(this);
	this._listeners=
	{
	};
	this._listenersCount=0;
}
_p=_biExtend(BiEventTarget,BiObject,"BiEventTarget");
_p.addEventListener=function(sType,fHandler,oObject)
{
	if(typeof fHandler!=BiObject.TYPE_FUNCTION)throw new Error(this+" addEventListener: "+fHandler+" is not a function ("+ sType+")");
	var ls=this._listeners[sType];
	if(!ls)ls=this._listeners[sType]=
	{
	};
	var key=BiObject.toHashCode(fHandler)+(oObject?BiObject.toHashCode(oObject):String.EMPTY);
	if(!(key in ls))
	{
		this._listenersCount++;
	}
	ls[key]=
	{
		handler:fHandler,object:oObject||this
	};
};
_p.removeEventListener=function(sType,fHandler,oObject)
{
	if(this._disposed||!(sType in this._listeners))return;
	var key=BiObject.toHashCode(fHandler)+(oObject?BiObject.toHashCode(oObject):String.EMPTY);
	if(key in this._listeners[sType])
	{
		--this._listenersCount;
	}
	delete this._listeners[sType][key];
	if(BiObject.isEmpty(this._listeners[sType]))
	{
		delete this._listeners[sType];
	}
};
_p.dispatchEvent=function(e)
{
	if(this._disposed)return;
	if(typeof e==BiObject.TYPE_STRING)
	{
		e=new BiEvent(e);
	}
	e._target=this;
	this._dispatchEvent(e);
	delete e._target;
	return !e._defaultPrevented;
};
_p._dispatchEvent=function(e)
{
	e._currentTarget=this;
	if(this._listenersCount>0)
	{
		var fs=this._listeners[e.getType()];
		if(fs)
		{
			for(var hc in fs)
			{
				var ho=fs[hc];
				ho.handler.call(ho.object,e);
			}
		}
	}
	if(e._bubbles&&!e._propagationStopped&&this._parent&&!this._parent._disposed)
	{
		this._parent._dispatchEvent(e);
	}
	delete e._currentTarget;
};
_p.setAttribute=function(sName,sValue,oParser)
{
	if(sName.substring(0,2)=="on")
	{
		var type=sName.substring(2);
		this.addEventListener(type,new Function("event",sValue),oParser);
	}
	else BiObject.prototype.setAttribute.call(this,sName,sValue,oParser);
};
_p.dispose=function()
{
	if(this._disposed)return;
	BiObject.prototype.dispose.call(this);
	for(var t in this._listeners)delete this._listeners[t];
	delete this._listeners;
	delete this._listenersCount;
};
_p.hasListeners=function(sType)
{
	return this._listenersCount>0&&(sType==null||sType in this._listeners);
};

function BiApplication()
{
	if(_biInPrototype)return;
	if(typeof application=="object")return application;
	application=this;
	BiEventTarget.call(this);
}
var application;
_p=_biExtend(BiApplication,BiEventTarget,"BiApplication");
_p._version="2.55";
BiApplication.prototype.getVersion=function()
{
	return this._version;
};
_p.start=function()
{
	if(Prototype.Browser.IE)window.attachEvent("onunload",this._onunload);
	else window.addEventListener("unload",this._onunload,false);
};

_p._onunload=function()
{
	application.dispose();
};

_p.dispose=function()
{
	if(this._disposed)return;
	this.dispatchEvent("dispose");
	if(Prototype.Browser.IE)window.detachEvent("onunload",this._onunload);
	else window.removeEventListener("unload",this._onunload,false);
	//this.disposeFields("_adfPath","_systemRootPath","_themeManager","_window","_loadStatus","_resourceLoader","_adf","_inactivityTimeout","_uri","_uriParams");
	BiEventTarget.prototype.dispose.call(this);
	application=null;
};
_p.setAttribute=function(sName,sValue,oParser)
{
	switch(sName)
	{
		case "defaultPackages":
		{
			this.setProperty(sName,sValue.split(/\s*,\s*/));
			break;
		}
		default:BiEventTarget.prototype.setAttribute.apply(this,arguments);
	}
};

application=new BiApplication();

/**
  Add maxbutton in fireMessageBox() and fixed center() bugs.
  be assigned with id
*/
var Alerts = {
	
	background: null,
	message: null,
	messageArray: new Array(),
	fadeTimer: 0,
	OPACITY: 51,
	STEPS: 3,

	bgFadeIn: function(max, steps, opacity) {
		var background = Alerts.background;
		Element.changeOpacity(background, max);
		//no steps now, for fast feeling :-)
		/*var background = Alerts.background;
		var delta = max/steps
		
		if (opacity == null) {
			opacity = delta;
		}
		
		if (background && opacity <= max) {
			Element.changeOpacity(background, opacity);
			opacity += delta;
			setTimeout("Alerts.bgFadeIn(" + max + "," + steps + "," + opacity + ")", 0);
		}*/
	},

	bgFadeOut: function(max, steps, opacity) {
		var background = Alerts.background;
		if (background) {
			background.parentNode.removeChild(background);
			setSelectVisibility("visible", Alerts.message);
			Alerts.background = null;
		}
		//no steps now, for fast feeling :-)
		/*var background = Alerts.background;
		if (background) {
			var delta = max/steps
			
			if (opacity == null) {
				opacity = max - delta;
			}
			
			if (opacity >= 0) {
				Element.changeOpacity(background, opacity);
				opacity -= delta;
				setTimeout("Alerts.bgFadeOut(" + max + "," + steps + "," + opacity + ")", 0);
			}
			else {
				background.parentNode.removeChild(background);
				setSelectVisibility("visible", Alerts.message);
				Alerts.background = null;
			}
		}*/
	},
	
	createWrapper: function(message, title, options) {
		var outer = document.createElement("div");
		var inner = document.createElement("div");
		var heading = document.createElement("table");
		if (!options) options = new Object();
		
		var maxButton= options.maxButton;
		var maxURL= options.maxURL;
		
		outer.className = "pop-up-outer";
		outer.align = "center";
		inner.className = "pop-up-inner";
		
		heading.className = "pop-up-header";
		heading.border = 0;
		heading.width = "100%";
		heading.cellSpacing = 0;
		heading.cellPadding = 0;
		heading.insertRow(0);
		
		var row = heading.rows[0];
		row.insertCell(0);
		row.insertCell(1);
		
		var cell0 = row.cells[0];
		var cell1 = row.cells[1];
		cell0.className = "pop-up-title";
		cell0.id="pop-up-title-"+(Alerts.messageArray.length);
		cell0.width = "99%";
		
		if (title) {
			cell0.innerHTML = title;
		}
		
		var closeButton= options.closeButton;
		if(closeButton==null || closeButton==undefined) closeButton=true;
		//cell1.id = "pop-up-close-c";
		cell1.className = "pop-up-close";
		cell1.width = "1%";
		if(closeButton){
			cell1.innerHTML = "<a href=\"javascript:void(0)\" title='å…³é—­"+"' onclick=\"Alerts.killAlert(this)\"><img border=\"0\" src=\"/html/nds/images/close.gif\"/></a>"
		}
		if(maxButton){
			cell0.width = "98%";
			row.insertCell(1);
			var cell2 = row.cells[1];
			cell1.id = "pop-up-close-x";
			cell2.className = "pop-up-close";
			cell2.width = "1%";
			cell2.innerHTML = "<a href=\"javascript:void(0)\" title='ç‹¬ç«‹çª—å£"+"' onclick=\"Alerts.killAlert(this);popup_window('"+maxURL+"','_blank');\"><img border=\"0\" src=\"/html/nds/images/maxbutton.gif\"/></a>"
						
		}
		
		inner.appendChild(heading);
		inner.appendChild(message);
		outer.appendChild(inner);
		
		message.wrapper = outer;
		
		//Drag.makeDraggable(outer, cell0);
		
		return outer;
	},

	killAlert : function(oLink) {
		if (oLink) {
			var wrapper = oLink;
			
			while (wrapper.parentNode) {
				if (wrapper.className && wrapper.className.match("pop-up-outer")) {
					break;
				}
				wrapper = wrapper.parentNode;
			}
			
			var body = document.getElementsByTagName("body")[0];
			var options = wrapper.options;
			var background = null;
			var showSelects = false;
			
			Alerts.remove(wrapper);
			body.removeChild(wrapper);
			
			if (Alerts.messageArray.length > 0) {
				Alerts.message = Alerts.messageArray[Alerts.messageArray.length - 1];
				Alerts.message.style.zIndex = ZINDEX.ALERT + 1;
				setSelectVisibility("visible", Alerts.message);
				background = wrapper.background;
			}
			else {
				Alerts.message = null;
				//setSelectVisibility("visible");
				background = Alerts.background;
			}
			
			if (background) {
				//body.removeChild(background);
				//Alerts.background = null;
				Alerts.bgFadeOut(Alerts.OPACITY, Alerts.STEPS);
			}
			
			if (options && options.onClose) options.onClose();
		}
	},

	fireMessageBox : function (options) {
		/*
		 * OPTIONS:
		 * modal (boolean) - show shaded background
		 * message (string) - default HTML to display
		 * height (int) - starting height of message box
		 * width (int) - starting width of message box
		 * maxButton(boolean) - show max button on upper right corner(yfzhu)
		 * maxURL(string) - max url for button
		 * onClose (function) - executes after closing
		 * closeButton(boolean) default to true
		 */
		var body = document.body;
		
		if (!options){
			options = new Object();
		}
		
		var modal = options.modal;
		var myMessage = options.message;
		var msgHeight = options.height;
		var msgWidth = options.width;
		var noCenter = options.noCenter;
		var title = options.title;
		var maxButton = options.options;

		var message = document.createElement("div");
		message.align = "left";
		
		var wrapper = Alerts.createWrapper(message, title,options);
		wrapper.style.position = "absolute";
		wrapper.style.top = 0;
		wrapper.style.left = 0;
		wrapper.style.zIndex = ZINDEX.ALERT + 1;
		wrapper.options = options;
		
		if (myMessage) {
			message.innerHTML = myMessage;
		}
		else {
			message.innerHTML = "<div class=\"portlet-loading\"></div>";
		}
		if (msgHeight) {
			if (is_ie) {
				message.style.height = msgHeight + "px";
			}
			else {
				message.style.minHeight = msgHeight + "px";
			}
		}
		
		if (msgWidth) {
			wrapper.style.width = msgWidth + "px";
		}
		
		if (!Alerts.background && modal) {
			var background = document.createElement("div");
			background.id = "alert-message";
			background.style.position = "absolute";
			background.style.top = "0";
			background.style.left = "0";
			background.style.zIndex = ZINDEX.ALERT;
			
			Alerts.background = background;
			wrapper.background = background;
			
			background.style.backgroundColor = "#000000";
			Element.changeOpacity(background, 0);
			body.appendChild(background);
			Alerts.bgFadeIn(Alerts.OPACITY, Alerts.STEPS);
		}
		setSelectVisibility("hidden");
		
		if (Alerts.messageArray.length > 0) {
			var lastMsg = Alerts.messageArray[Alerts.messageArray.length - 1];
			lastMsg.style.zIndex = ZINDEX.ALERT - 1;
			setSelectVisibility("hidden", lastMsg);
		}

		setSelectVisibility("visibile", message);
		
		Alerts.message = message;
		Alerts.messageArray.push(wrapper);
		
		Alerts.resize();
		Event.observe(window, "resize", Alerts.resize);
		
		if (noCenter) {
			Alerts.center();
		}
		else {
			Alerts.center(msgHeight, msgWidth);
		}

		Event.observe(window, "resize", Alerts.center);
		
		body.appendChild(wrapper);
		window.focus();
		return message;
	},
	
	popupIframe : function(url, options) {
		if(options.maxButton)options.maxURL= url;
		var msgHeight = options.height;
		var msgWidth = options.width;
		var message = Alerts.fireMessageBox(options);
		var iframe = document.createElement("iframe");
		iframe.className="popup-iframe";
		iframe.id="popup-iframe-"+ (Alerts.messageArray.length-1);
		message.height = "";
		iframe.frameBorder = 0;
		if (msgWidth) iframe.style.width = "100%";
		
		message.appendChild(iframe);
		iframe.src = url;
		if (!options.noCenter) {
			Alerts.center(msgHeight, msgWidth);
		}
		
		return message;
	},
	
	center : function(height, width) {
		if (Alerts.message) {
	        var message = Alerts.message.wrapper;
            var body = document.getElementsByTagName("body")[0];
            var mode = message.options.centerMode;
            if (!mode) {
	            if (height && width) {
	            	mode = message.options.centerMode = "xy";
	            }
	            else if (height && !width) {
	            	mode = message.options.centerMode = "y";
	            }
	            else if (!height && width) {
	            	mode = message.options.centerMode = "x";
	            }
	            else {
	            	mode = message.options.centerMode = "none";
	            }
            }
            if(isNaN(width)) width=message.offsetWidth;
            if(isNaN(height)) height=message.offsetHeight;
            //width = width || message.offsetWidth;
            //height = height || message.offsetHeight;
            var centerLeft;
            var centerTop;

            if (!is_safari) {
                var centerLeft = (body.clientWidth - width) / 2;
                var centerTop = body.scrollTop + ((body.clientHeight - height) / 2);
            }
            else {
                var centerLeft = (body.offsetWidth - width) / 2;
                var centerTop = (body.offsetHeight - height) / 2;
            }

			if (mode == "xy" || mode == "y") {
	            message.style.top = centerTop + "px";
            }
            else {
	            message.style.top = (body.scrollTop + 10) + "px";
            }
            
            if (mode == "xy" || mode == "x") {
	            message.style.left = centerLeft + "px";
            }
            else {
	            message.style.left = "20px";
            }
        }       
        
	},
	
    resize: function() {
    	if (Alerts.background) {
	        var background = Alerts.background;
	        var body = document.getElementsByTagName("body")[0];
	
	        if (!is_safari) {
	        	var scrollHeight = body.scrollHeight;
	        	var clientHeight = body.clientHeight;
	        	
	            background.style.height = (scrollHeight > clientHeight ? scrollHeight : clientHeight) + "px";
	            //background.style.width = (body.offsetWidth > body.clientWidth ? body.offsetWidth : body.clientWidth) + "px";
	            background.style.width = "100%";
	        }
	        else {
	            background.style.height = body.offsetHeight + "px";
	            background.style.width = body.offsetWidth + "px";
	        }
    	}
    },
    
    resizeIframe: function(options) {
    	if (Alerts.message && options) {
    		var iframe = Alerts.message.getElementsByTagName("iframe")[0];
			var loading = document.getElementsByClassName("portlet-loading", Alerts.message);
			
			if (loading.length > 0) {
				loading[0].parentNode.removeChild(loading[0]);
			}
    		
    		if (iframe) {
	    		if (options.height) {
	    			iframe.height = options.height;
	    		}
    		
	    		if (options.width) {
	    			iframe.width = options.width;
	    		}
    		}
    	}
    	
    	Alerts.resize();
    },

    remove: function(obj) {
    	var msgArray = Alerts.messageArray;
    	
    	for (var i = 0; i < msgArray.length; i++) {
    		if (msgArray[i] == obj) {
    			msgArray.splice(i, 1);
    			break;
    		}
    	}
    }
};

/**
 * import application.js, alerts.js,dwr.js,prototype.js
 * 2008-12-21 updated
 */

var dqComboboxQueries=null;
var dqComboboxes=null;
var dq=null;
var oq=null;
var dcq=null;
var DynamicQuery = Class.create();
var DropdownQuery = Class.create();
var ObjectQuery = Class.create();
ObjectQuery.prototype = {
	initialize: function() {
		this._gridQuery=null; // QueryObject 
		this._accepter_id=null; //id of input control that accepts query result
		this._mainobjurl=null; // object url
		this._returnType="s"; // default to single, "m" for multiple, "f" for filter
		this._partialData=null; // partial columns of all rows, for single return type
		this.multi_result=[];
		this._xmlid=0;
		this.condition="IN";
		application.addEventListener( "QueryObject", this._onQueryObject, this);
		application.addEventListener( "ReturnSQL", this._onReturnSQL, this);	
		application.addEventListener( "ReturnSET", this._onReturnSET, this);	
		application.addEventListener( "Return_Result", this._onReturn_Result, this);	
	},
	
	/**
	 * Popup search form or clear input according to $(acceptor_id+"_link").name, if name is "popup", then do poup,
	 * else clear input. if $(acceptor_id+"_link") not exists, just show search form(single obj)
	 * accepter_id id of input control that accepts query result
	 */
	toggle: function(url, accepter_id, options) {
		var l= $(accepter_id+"_link");
		if( l==null || (l!=null &&l.title=="popup")){
			url=reconstructQueryURL(url, options);
			if(url==null) return; // find error
			this._gridQuery=null;
			this._accepter_id=accepter_id;
			var popup = Alerts.fireMessageBox({
					width: 610,modal:true,noCenter: true,title: gMessageHolder.SEARCH,
					onClose: function() {}
				});
			//AjaxUtil.update(url, popup, null);
			new Ajax.Request(url, {
			  method: 'get',
			  onSuccess: function(transport) {
			  	var pt=$(popup);
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
			  	  		var pt=$(popup);
			    		pt.innerHTML=transport.responseText;
			    		executeLoadedScript(pt);
			  	  	}
			  	//}catch(e){}
			  }
			});	
		}else{
				$(accepter_id+ "_link").title="popup"; // reset to popup
				$(accepter_id+ "_img").alt="";
		      	$(accepter_id).value="";
		      	$(accepter_id+ "_img").src="/html/nds/images/filterobj.gif";
				if($(accepter_id+ "_fd")!=null){
					$(accepter_id+ "_fd").value="";
					$(accepter_id+ "_fd").readOnly=false;
				}
				if($(accepter_id+ "_sql")!=null){
					$(accepter_id+ "_sql").value="";
					$(accepter_id).readOnly=false;
				}
				var obj=$(accepter_id+ "_expr");
				if( obj !=null){
			    	obj.value= "";
			    }
		}

	},
	toggle_m: function(url, accepter_id, options) {
			var l= $(accepter_id+"_link");
			if( l==null || (l!=null &&l.title=="popup")){
				url=reconstructQueryURL(url, options);
				if(url==null) return; // find error
	
				this._gridQuery=null;
				this._accepter_id=accepter_id;
				var popup = Alerts.fireMessageBox({
						width: 790,modal:true,noCenter: true,title: gMessageHolder.SEARCH,
						onClose: function() {oq.close();}
					});
				//AjaxUtil.update(url, popup, null);
				new Ajax.Request(url, {
				  method: 'get',
				  onSuccess: function(transport) {
				  	var pt=$(popup);
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
				  	  		var pt=$(popup);
				    		pt.innerHTML=transport.responseText;
				    		executeLoadedScript(pt);
				  	  	}
				  }
				});	
			}else{
				//clear data
				$(accepter_id+ "_link").title="popup"; // reset to popup
				$(accepter_id+ "_img").alt="";
		      	$(accepter_id).value="";
		      	$(accepter_id+ "_img").src="/html/nds/images/filterobj.gif";
				if($(accepter_id+ "_fd")!=null){
					$(accepter_id+ "_fd").value="";
					$(accepter_id+ "_fd").readOnly=false;
				}
				if($(accepter_id+ "_sql")!=null){
					$(accepter_id+ "_sql").value="";
					$(accepter_id).readOnly=false;
				}
				var obj=$(accepter_id+ "_expr");
				if( obj !=null){
			    	obj.value= "";
			    }
			}

	},
	/**
	 * @param queryObject properties: table (name), table_id,table_desc,
	 * column_masks,start,range,init_query,dir_perm
	 * @param objURL url for loading record
	 * @param returnType "m" (multiple) or "s" (single)
	 */
	setQueryObject:function(queryObject, objURL, rtnType){
		this._gridQuery=queryObject;
		this._gridQuery.callbackEvent="QueryObject";
		this._gridQuery.returnType= rtnType;
		this._returnType= rtnType;
		this._initGridSelectionControl();
		this._mainobjurl= objURL;
		var te=$("pop-up-title-0");
		if(te){
			te.innerHTML=gMessageHolder.SEARCH + " - " + queryObject.table_desc;
		}
		if(rtnType=="s"){
			var e=$("btn-rsql");
			if(e)e.hide();
			e=$("btn-sql");
			if(e)e.hide();
			e=$("qcsa");
			if(e)e.hide();
		}
	},
	search:	function(){
		this._partialData=null;
		if($("mulit-info")!=null){
			$("mulit-info").remove();
		}
		var fm=$("q_form");
	    this._gridQuery.param_str= fm.serialize();
	    this._gridQuery.start=0;
	    var qexp=$("q_form_param_expr");
	    if(qexp!=null){
	    	this._gridQuery.param_expr=qexp.value;
	    }
		this._executeQuery(this._gridQuery);
	},
	
	returnSQL:function(){
		var fm=$("q_form");
	    var queryObj= Object.clone(this._gridQuery);
	   	queryObj.param_str= fm.serialize();
	    queryObj.callbackEvent="ReturnSQL";
	    queryObj.noresult=true;
	    if(this._returnType=="f"){//filter
			queryObj.resulthandler="/html/nds/query/search_result_filter_dropdown.jsp";
		}else
		    queryObj.resulthandler="/html/nds/query/search_result_sql.jsp";
	    
		this._executeQuery(queryObj);
	},
	/**
	 * @return single row ak
	 */
	returnRow:function(ele){
		// get selected line
		var acpt=$(this._accepter_id);
      	acpt.value=ele.alt;
      	var fk_acpt=$("fk_"+ this._accepter_id);
      	if(fk_acpt!=null)fk_acpt.value=ele.id.replace(/chk_obj_/i, "") ;
      	
		if(this._partialData!=null && acpt.onaction){
			var rowIdx=Number(ele.title);
			if(rowIdx>=0&& rowIdx<this._partialData.length){
//				if (typeof acpt.onaction == "string")
//					acpt.onaction = new Function ("args", acpt.onaction);
				acpt.onaction(this._partialData[rowIdx]);
			}
		}
		this.close();
	},
	returnValue:function(){
		var selectedIds=Array();
		var selectedAKs=Array();
		var j;
		var cks=$("q_fm_list").getInputs('checkbox', 'itemid');
		for(var i=0;i<cks.length;i++){
			if( cks[i].checked){
			  	selectedIds.push(cks[i].value);
			  	selectedAKs.push(cks[i].id);
			}
		}
		if(selectedIds.length==0){
 			alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
            return;				
		}
		var sql= " IN ("+selectedIds.join(",")+")";
		var sqlDesc= gMessageHolder.CONTAINS+" ("+ selectedAKs.join(",")+")";
		var xml=null;
		if(this._returnType=="f"){//filter
			var j={"expr":{"desc":sqlDesc,"clink":this._gridQuery.table+".ID","condition":sql}};
			var jo={"filter":{"desc":sqlDesc,"sql":sql,"expr":j}};
			xml= json2xml(jo,false);
			this.returnFilterObj_dropdown(sqlDesc, xml);
		}else{
			this.returnQuery(sql, sqlDesc, xml);
		}
	},
	
	returnFilterObj_dropdown:function(desc,xml){
		if(desc=="")
		{
      		$(this._accepter_id+"_fd").value="(¿ÉÓÃ = Y)";
      	}else{
      		$(this._accepter_id+"_fd").value=desc;
      	}
      	$(this._accepter_id).value=xml;
      	$(this._accepter_id+"_fd").readOnly=true;
		$(this._accepter_id+ "_img").src="/html/nds/images/clear.gif";
		$(this._accepter_id+ "_link").title="clear";
		$(this._accepter_id+ "_img").alt=gMessageHolder.CLEAR_CONDITION;
		this.close();				
	},	
	/**
	 * Filter object is a xml format, inputs for filter:
	 * 
	 */
	returnFilterObj:function(desc,xml){
		var xmlvalue=this._xmlid+"_xml";
		var flag=true;
		//var content_row={"id":desc,"value":xmlvalue,"condition":$("condition").value,"set":xml};	
		var content_row={"id":desc,"condition":this.condition,"value":xmlvalue,"set":xml};	
		var mid=this.multi_result.length;
		for(var i=0;i<mid;i++){
			if(this.multi_result[i].id==content_row.id){
				flag=false;
				if(this.multi_result[i].condition!=this.condition){
					if(this.multi_result[i].condition=="IN"){
						alert(gMessageHolder.SET_ALREADY_CHOOSED);
					}else{
						alert(gMessageHolder.SET_ALREADY_EXCLUDE);
					}
				}
				break;
			}
		}
		if(flag){
			this.multi_result[mid]=content_row;
			dwr.util.cloneNode("m_multiple_row",{idPrefix:this.multi_result[mid].value+'_'});
			$(this.multi_result[mid].value+'_'+"m_multiple").innerHTML="<input type=\"checkbox\" name=\"m_multiple\"  value="+this.multi_result[mid].value+">";
			dwr.util.setValue(this.multi_result[mid].value+'_'+"m_multiple_value",this.multi_result[mid].id);
			$(this.multi_result[mid].value+'_'+"m_multiple_row").style.display="";
			this._xmlid++;
		}
	},	
	returnQuery:function(sql,sqlDesc,sqlExpr){
		$(this._accepter_id+ "_link").title="clear"; // reset to popup
      	$(this._accepter_id+ "_img").src="/html/nds/images/clear.gif";
	    $(this._accepter_id+ "_img").alt=gMessageHolder.CLEAR_CONDITION;
      	$(this._accepter_id).value=sqlDesc;
     	$(this._accepter_id).readOnly=true;
      	$(this._accepter_id+ "_sql").value=sql;
		var obj=$(this._accepter_id+ "_expr");
		if( obj !=null){
	    	obj.value= sqlExpr;
	    }
		this.close();				
	},
	/**@return when e is not an element or e.value is empty
	*/
	isEmpty:function(e){
		var v=$(e);
		return ((v!=null && dwr.util.getValue(v).empty()) || v==null);
		
	},
	close:function(){
		window.setTimeout("Alerts.killAlert(document.getElementById('pop-up-title-0'))",1);
		this.multi_result=[];
		this.condition="IN";
	},
	onSearchReturn :function(event) {
	  if (!event) event = window.event;
	  if (event && event.keyCode && event.keyCode == 13) this.search();
	},
	_onReturnSQL:function(e){
		var qr=e.getUserData().data; 
//		alert(qr.pagecontent);
		if(qr.pagecontent!=null){
			eval(qr.pagecontent);
			/*var div=$("q_eval");
			div.innerHTML=qr.pagecontent;
			executeLoadedScript(div);
			alert("executed");*/
		}
	},
	_toggleButtons:function(disable){
		if(disable){
			$("btn-search").disable();
			//$("btn-rsql").disable();
			$("btn-value").disable();
			$("btn-search").disable();
			$("btn-sql").disable();
		}else{
			$("btn-search").enable();
			//$("btn-rsql").enable();
			$("btn-value").enable();
			$("btn-search").enable();
			$("btn-sql").enable();
		}
	},
	/**
	*Reload grid data according to query result
	* @param qr QueryResult.toJSONObject()
	*/
	_onQueryObject:function(e){
		var qr=e.getUserData().data; 
		var rowCount=qr.rowCount;
		var i,s,a;
		var q=this._gridQuery;
		s=qr.start;
		q.start= s;
		// data insert by html
		if(qr.pagecontent!=null){
			if(Prototype.Browser.IE){
				// ie does not support setting innerHTML in tbody
				var div=$("q_embed_lines");
				var te=div.innerHTML;
				var p= te.indexOf("<!--$QGRIDTABLE_START-->");
				var pe= te.indexOf("<!--$QGRIDTABLE_END-->");
				var pstr=te.substring(0, p+ "<!--$QGRIDTABLE_START-->".length);
				var pestr=te.substr(pe);
				var newDiv=pstr.concat("<tbody id='q_grid_table'>",qr.pagecontent,"</tbody>",pestr);
				div.innerHTML=newDiv;
				executeLoadedScript(div);
				this._initGridSelectionControl();
				
			}else{
				var gridTableBody=$("q_grid_table");
				dwr.util.removeAllRows(gridTableBody);
				gridTableBody.innerHTML=qr.pagecontent;
				executeLoadedScript(gridTableBody);
			}
		}
		if(qr.rows!=null){
			// for partial result
			this._partialData=qr.rows;
			qr.rows=null; //release qr
		}else{
			this._partialData=null;
		}
		this._syncGridControl(qr);
		var desc=  qr.queryDesc;
		if(qr.message !=undefined && qr.message!=null) desc+= "<br><blink><span class='err'>***"+ qr.message+"</blink>";
		$("q_filter_setting").innerHTML= desc;
		dwr.util.setValue($("q_chk_select_all"),false);
		$("query-data").show();
	},
	_syncGridControl:function(qr){
		this._gridQuery.totalRowCount=qr.totalRowCount;
		this._gridQuery.start=qr.start;
		//this._gridQuery.range=qr.range;
		//dwr.util.setValue("range_select", qr.range);
		if( this._gridQuery.order_columns!=null){
			var ele=$("q_title_"+this._gridQuery.order_columns);
			if(ele!=null){
				ele.innerHTML="<img src='/html/nds/images/"+( this._gridQuery.order_asc?"up":"down")+"simple.png'>";
			}
		}
		if($("q_txtRange")!=null){
			$("q_txtRange").innerHTML=((qr.start+1)+"-"+ (qr.start+qr.rowCount)+"/"+ qr.totalRowCount);
			if(qr.start>0){
				 $("q_begin_btn").setEnabled(true);
				 $("q_prev_btn").setEnabled(true);
			}else{
				 $("q_begin_btn").setEnabled(false);
				 $("q_prev_btn").setEnabled(false);
			}
			if((qr.start+qr.rowCount)< qr.totalRowCount){
				 $("q_next_btn").setEnabled(true);
				 $("q_end_btn").setEnabled(true);
			}else{
				 $("q_next_btn").setEnabled(false);
				 $("q_end_btn").setEnabled(false);
			}
		}
	},		
	_executeQuery : function (queryObj) {
		$("q_progress").show();
	    this._toggleButtons(true);
		var s= Object.toJSON(queryObj);
		Controller.query(s, function(r){
				var result= r.evalJSON();
				if (result.code !=0 ){
					$("q_progress").hide();
				    oq._toggleButtons(false);
					msgbox(result.message);
				}else {
					var evt=new BiEvent(result.callbackEvent);
					evt.setUserData(result);
					application.dispatchEvent(evt);
					$("q_progress").hide();
				    oq._toggleButtons(false);
				}
		  	}		
		);
	},		
     /**
     * Init list table to handle selection action
     */
    _initGridSelectionControl:function(){
		var tb= new SelectableTableRows(document.getElementById("q_inc_table"), false);// set as global object
		if(this._returnType!="s"){//"m" or "f"
			tb.ondoubleclick=function(trElement){
				oq.mo(trElement.id.replace(/_qtemplaterow/i, ""));
			};
		}else{
			tb.ondoubleclick=function(trElement){
				//$(oq._accepter_id).value=$("chk_obj_"+trElement.id.replace(/_qtemplaterow/i, "") ).alt;
				var ele=$("chk_obj_"+trElement.id.replace(/_qtemplaterow/i, ""));
				var acpt=$(oq._accepter_id);
		      	acpt.value=ele.alt;
		      	var fk_acpt=$("fk_"+ oq._accepter_id);
		      	if(fk_acpt!=null)fk_acpt.value=ele.id.replace(/chk_obj_/i, "") ;
		      	
				if(oq._partialData!=null && acpt.onaction){
					var rowIdx=Number(ele.title);
					if(rowIdx>=0&& rowIdx<oq._partialData.length){
						//if (typeof acpt.onaction == "string")
						//	acpt.onaction = new Function ("args", acpt.onaction);
						acpt.onaction(oq._partialData[rowIdx]);
					}
				}				
				oq.close();
			};
		}
    },
	fk:function(tableId, objId){
		popup_window("/html/nds/object/object.jsp?table="+tableId+"&id="+objId);
	},
    mo:function(tid){
		popup_window(this._mainobjurl+tid);
	},
	/**
	* create query request and execute query
	*/
	refreshGrid : function () {
		this._executeQuery(this._gridQuery);
	},	
	/**
	 * Reorder grid query
	 * @param columnId the column id that will be ordered by, if the same as old
	 * order by column, will toggle asc and desc, else do asc 
	 */
	orderGrid: function(columnId){
		var oldOrderBy=this._gridQuery.order_columns;
		var oldAsc=this._gridQuery.order_asc;
		if(oldOrderBy==columnId ){
			this._gridQuery.order_asc=!oldAsc;
		}else{
			var ele=$("q_title_"+oldOrderBy);
			if(ele!=null)ele.innerHTML="";
			this._gridQuery.order_columns=columnId;
			this._gridQuery.order_asc=true;
		}		
		this._executeQuery(this._gridQuery);
	},
	/***
	* Invoke by buttons, include btn_begin,btn_next,btn_prev,btn_end
	@param t id of the button
	*/
	scrollPage: function (t) {
		//var t=event.target.id;
		var s;
		var qr=Object.clone(this._gridQuery);
		var qs=qr.start;
		var qrange=parseInt( $("q_range_select").value,10);
		var qtot=qr.totalRowCount;
        if(t=="q_begin_btn")s=0;
		else if(t=="q_prev_btn") s= qs-qrange;
		else if(t=="q_next_btn") s= qs+qrange;
		else if(t=="q_end_btn") s= qtot-qrange;
		else s= qs;
		
		qr.start=s;
		qr.range=qrange;
		this._gridQuery.range=qrange;
		this._executeQuery(qr);
	},	
	/**
	 * mark all check box checked
	 */
	selectAll:function(){
		var ca=$("q_chk_select_all");
		ca.checked = ca.checked|0;
		var ck= ca.checked;
		var cks=$("q_fm_list").getInputs('checkbox', 'itemid');
		for(var i=0;i<cks.length;i++){
			cks[i].checked= ck;
		}
	},
	
	return_content:function(akData){
		var content_row=null;
		var compare_len=this.multi_result.length;
		var len=this.multi_result.length;
		var flag=false;
		var flag_check=false;
		var jo=null;
		var sql=null;
		var sqlDesc=null;
		var cks=$("q_fm_list").getInputs('checkbox', 'itemid');
		for(var i=0;i<cks.length;i++){
			flag=false;
			if( cks[i].id==akData){
				sql=this.condition+"("+cks[i].value+")";
				content_row={"id":cks[i].id,"value":cks[i].value,"condition":this.condition,"clkstr":this._gridQuery.table+".ID"};
				for(var j=0;j<compare_len;j++){
					if(this.multi_result[j].value==cks[i].value){ 
						flag=true;	
						if(this.multi_result[j].condition!=this.condition){
							if(this.multi_result[j].condition=="IN"){
								alert(this.multi_result[j].id+gMessageHolder.ALREADY_CHOOSED);
							}else{
								alert(this.multi_result[j].id+gMessageHolder.ALREADY_EXCLUDE);
							}
							flag_check=true;
						}
						break;
					}
				}	
				if(!flag){
			  	this.multi_result[len]=content_row;
			  	len++;
			  }
			}
		}
	//	if(this.multi_result.length==compare_len&&!flag_check){
 	//		alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
    //        return;				
	//	}
    	for(var mid=compare_len;mid<this.multi_result.length;mid++){
    		dwr.util.cloneNode("m_multiple_row",{idPrefix:this.multi_result[mid].value+'_'});
    		$(this.multi_result[mid].value+'_'+"m_multiple").innerHTML="<input type=\"checkbox\" name=\"m_multiple\"  value="+this.multi_result[mid].id+">";
		  	if(this.multi_result[mid].condition!="IN"){
		  		dwr.util.setValue(this.multi_result[mid].value+'_'+"m_multiple_value",gMessageHolder.NOTCONTAINS+"("+this.multi_result[mid].id+")");
		  	}else{
		  		dwr.util.setValue(this.multi_result[mid].value+'_'+"m_multiple_value",gMessageHolder.CONTAINS+"("+this.multi_result[mid].id+")");
			}
		  	$(this.multi_result[mid].value+'_'+"m_multiple_row").style.display="";
		}
	},
	remove_choosed_rows:function(){
		var flag=false;
		 var obj=document.getElementsByName("m_multiple"); 
		 for(var i=obj.length-1;i>=0;i--){
	  	if(obj[i].checked){
	  		flag=true;
	  		var j=this.multi_result[i].value;
	  		 dwr.util.removeAllRows("content",{filter:function(tr){return (tr.id==j+'_'+"m_multiple_row");}});
	  		 this.multi_result.splice(i,1);	
	  	}
	  }
	  if(!flag){
	  	alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
	  }
	},
	remove_all:function(){
		dwr.util.removeAllRows("content",{filter:function(tr){return (tr.id!="m_multiple_row");}});
		this.multi_result =[];
		this.condition="IN";
	},
	
	return_set:function(){
		var fm=$("q_form");
	    var queryObj= Object.clone(this._gridQuery);
	   	queryObj.param_str= fm.serialize();
	    queryObj.callbackEvent="ReturnSET";
	    queryObj.noresult=true;
		//queryObj.resulthandler="/html/nds/query/search_result_filter.jsp?condition="+$("condition").value;
		queryObj.condition=this.condition;
		queryObj.returnType=this._returnType;
		queryObj.resulthandler="/html/nds/query/search_result_filter.jsp";
		this._executeQuery(queryObj);
	},
	
	return_result:function(){
		if(this.multi_result.length==0){
			alert(gMessageHolder.NO_DATA_TO_PROCESS);
		}else{
			var evt={};
			evt.command="Return_Result";
			evt.params=this.multi_result;
			evt.table=this._gridQuery.table;
			evt.returnType=this._returnType;
			evt.callbackEvent="Return_Result";
			this._executeCommandEvent(evt);	
		}
	},
	
	_onReturn_Result:function(e){
		var r=e.getUserData(); 
		var ret=r.data;
		if(this._returnType=="f"){
			$(this._accepter_id+"_fd").value=ret.desc;
			$(this._accepter_id).value=ret.filterxml;
			$(this._accepter_id+"_fd").readOnly=true;

		}else if(this._returnType=="a"){
			$(this._accepter_id).value=ret.desc;
			$(this._accepter_id+ "_expr").value=ret.filterxml;
			$(this._accepter_id+ "_sql").value=ret.sql;
			$(this._accepter_id).readOnly=true;
		}else{
			$(this._accepter_id).value=ret.desc;
			$(this._accepter_id+ "_filter").value=ret.filterxml;
			$(this._accepter_id+ "_sql").value=ret.sql;
			$(this._accepter_id).readOnly=true;
		}
		$(this._accepter_id+ "_img").src="/html/nds/images/clear.gif";
		$(this._accepter_id+ "_link").title="clear";
		$(this._accepter_id+ "_img").alt=gMessageHolder.CLEAR_CONDITION;
		this.close();
	},
	reverse_condition:function(){
		if($("condition").checked){
		//	$("btn-choose-content").value=gMessageHolder.EXCLUDE_CHOOSED_ROWS;
			$("btn-choose-set").value=gMessageHolder.EXCLUDE_ALL;
			this.condition="NOT IN";
		}else{
		//	$("btn-choose-content").value=gMessageHolder.ADD_CHOOSE_ROWS;
			$("btn-choose-set").value=gMessageHolder.ADD_ALL;
			this.condition="IN";
		}
	},
	_executeCommandEvent :function (evt) {
		Controller.handle( Object.toJSON(evt), function(r){

					var result= r.evalJSON();
					var evt=new BiEvent(result.callbackEvent);
					evt.setUserData(result);
					application.dispatchEvent(evt);
					}
	  );
	},
	_onReturnSET:function(e){
		var qr=e.getUserData().data; 
		if(qr.pagecontent!=null){
			eval(qr.pagecontent);
		}
	},
	dynamic_add:function(akData){
		if($("multi-list")!=null){
			if($(akData).checked){
				this.return_content(akData);
			}else{
				this.dyn_remove_choosed_rows(akData);
			}
		}
	},
	dyn_remove_choosed_rows:function(akData){
		 var obj=document.getElementsByName("m_multiple"); 
		 for(var i=obj.length-1;i>=0;i--){
	  	if(obj[i].value==akData){
	  		if(this.multi_result[i].condition==this.condition){
	  		var j=this.multi_result[i].value;
	  		 dwr.util.removeAllRows("content",{filter:function(tr){return (tr.id==j+'_'+"m_multiple_row");}});
	  		 this.multi_result.splice(i,1);	
	  		}else{
	  			if(this.multi_result[i].condition=="IN"){
					alert(this.multi_result[i].id+gMessageHolder.ALREADY_CHOOSED);
				}else{
					alert(this.multi_result[i].id+gMessageHolder.ALREADY_EXCLUDE);
				}
	  		}
	  		 break;
	  	}
	  }	
	},
	
	unselectall:function(){
	 	dwr.util.setValue($("q_chk_select_all"), false);
	}
}
ObjectQuery.main = function () {
	oq=new ObjectQuery();
};
jQuery(document).ready(ObjectQuery.main);
DropdownQuery.prototype = {
	initialize : function() {
	  this._selTb=null;
	  this._prevSelected=null;
	  this._accepter_id=null;
	  this._temp=null;
	  
   application.addEventListener( "DropdownQueryRefresh", this._refreshGrid, this);
	},
	
	/**
	 * If option is not null, will reload whole combobox page each time, no cache in browser
	 * @param options, if not empty, will has format like:
	 * {ta:true|false, rc:[<columnId>,<columnId>...], prc:[<columnId>,<columnId>...]}
	 * ta: signs for whether current searchOnColumn is in title area or not
	 * rc: reference columns in wildcard filter, which is in same table as searchOnColumn
	 * prc:reference columns in wildcard filter, which is in parent table of searchOnColumn
	*/
	toggle : function (query, accepter_id,options) {
		if(accepter_id)this._accepter_id =accepter_id;
		var pos, path,queryString, dropdownDivId;
		dropdownDivId= "div_"+accepter_id;
		var acceptorEle=  document.getElementById(accepter_id);
		var dropdownDiv = document.getElementById(dropdownDivId);
		var notLoadedDiv=document.getElementById("dwrloading_"+accepter_id); 
		
		if(options!=undefined && options!=null){
			query=reconstructQueryURL(query, options);
			if(query==null) return;// found error
			// load div every time
			if(dropdownDiv!=null){
				dropdownDiv.innerHTML ="<div id='content_"+ accepter_id+"' style='width:160;position: relative; z-index: 10;'><span id='dwrloading_"+ accepter_id+"' style='width:160;height:20;'>"+gMessageHolder.LOADING+"</span></div><iframe id='json_"+accepter_id+"' frameborder='0' style='width:160px; height:20; position: absolute; top: 0; left: 0; z-index: 9;'></iframe>";						
				notLoadedDiv=document.getElementById("dwrloading_"+accepter_id);
			}
		}
		if(dropdownDiv==null || notLoadedDiv!=null){
			//create and show div
			if(dropdownDiv==null){
				dropdownDiv=document.createElement("div");
				dropdownDiv.id=dropdownDivId;
				dropdownDiv.className = "comboBoxList";				
				//dropdownDiv.style.width = (acceptorEle.offsetWidth ? acceptorEle.offsetWidth : 100) + "px";
				dropdownDiv.innerHTML ="<div id='content_"+ accepter_id+"' style='width:160;position: relative; z-index: 10;'><span id='dwrloading_"+ accepter_id+"' style='width:160;height:20;'>"+gMessageHolder.LOADING+"</span></div><iframe id='json_"+accepter_id+"' frameborder='0' style='width:160px; height:20; position: absolute; top: 0; left: 0; z-index: 9;'></iframe>";
	
				document.body.appendChild(dropdownDiv);
			}
			this._resize(accepter_id);		
			pos = query.indexOf("?");
			path = query;
			queryString = "";
			if (pos != -1) {
				path = query.substring(0, pos);
				queryString = query.substring(pos + 1, query.length);
			}
		loadPage(path,queryString,this._returnQuery,accepter_id);
			if(dqComboboxes==null){
				dqComboboxes=new Array();
				dqComboboxQueries={};
				dqtemps={};				
				Event.observe(document.body, 'mousedown', function(event) {
					var elt = $(Event.element(event)).up('.comboBoxList');
					var i, ee;
					for(i=dqComboboxes.length-1;i>=0;i--){
						ee= $(dqComboboxes[i]);
						if(ee!=null && ee.style.display == 'block'){
							if(elt==null || elt.id!=ee.id){
								ee.style.display = 'none';
							}
						}
					}
				});
				
			}
			var j,f=false;
			for(j=0;j<dqComboboxes.length;j++ ){
				if(dqComboboxes[j]==dropdownDivId){
					f=true;break;
				}
			}
			if(f==false){
				dqComboboxes[dqComboboxes.length]=dropdownDivId;
			}
		}else{
			if (dropdownDiv.style.display == "none") {
				this._repos(accepter_id);
				//dropdownDiv.style.display = "block";
			}/*else {
				dropdownDiv.style.display = 'none';
				debug("hide "+ dropdownDivId);
			}*/			
		}
	},
	_repos : function(accepter_id) {
		
		var dropdownDiv = document.getElementById("div_"+accepter_id);
		var offsets = getOffsets(accepter_id);
		var acceptorEle=document.getElementById(accepter_id);
		dropdownDiv.style.top = offsets.y + (acceptorEle.offsetHeight ? acceptorEle.offsetHeight : 22) + "px";
		dropdownDiv.style.left = offsets.x + "px";
		dropdownDiv.style.display = "block";
		dropdownDiv.scrollIntoView();
	},
	_resize : function (accepter_id) {
		
		var dropdownDiv = document.getElementById("div_"+accepter_id);
		var contentDiv = document.getElementById("content_"+accepter_id);
		var tableWrapperDiv=document.getElementById("tdv_"+accepter_id);
		if(tableWrapperDiv!=null){
			contentDiv.style.width=tableWrapperDiv.style.width;
		}		
		dropdownDiv.style.width=contentDiv.style.width;		
		this._repos(accepter_id);
	},
	_returnQuery : function (xmlHttpReq, accepter_id) {
		var contentDiv = document.getElementById("content_"+accepter_id);
		contentDiv.innerHTML = xmlHttpReq.responseText;
		executeLoadedScript(contentDiv);
		this._resize(accepter_id);
	},
	
	_refreshGrid :function (e) {
		var accepter_id= e.getUserData().data.tag;
		var contentDiv = document.getElementById("content_"+accepter_id);
	    contentDiv.innerHTML = e.getUserData().data.pagecontent;
		executeLoadedScript(contentDiv);
		this.syncGridControl(this._accepter_id);
	},

  syncGridControl:function(accepterId){
		var qr=dqComboboxQueries[accepterId];
	    var accepter_id=qr.accepter_id;
	    var botton1=$("begin_btn_"+accepter_id);
		if(qr.start>1){				
			 $("begin_btn_"+accepter_id).setEnabled(true);				
			 $("prev_btn_"+accepter_id).setEnabled(true);	
		}else{
			 $("begin_btn_"+accepter_id).setEnabled(false);
			 $("prev_btn_"+accepter_id).setEnabled(false);
		}
		if((qr.start+qr.rowcount)< qr.totalCount){
			 $("next_btn_"+accepter_id).setEnabled(true);
			 $("end_btn_"+accepter_id).setEnabled(true);
		}else{
			 $("next_btn_"+accepter_id).setEnabled(false);
			 $("end_btn_"+accepter_id).setEnabled(false);
		}
	},
	  
scrollPage: function (t,accepterId) {
		var s;
		var queryObj=Object.clone(dqComboboxQueries[accepterId]);
		queryObj.tag=accepterId;
		var qs=queryObj.start;
		var qrange=queryObj.range;
		var qtot=queryObj.totalCount;
		if(t=="refresh_"+accepterId) s=0;
		else if(t=="begin_btn_"+accepterId)s=0;
	    else if(t=="prev_btn_"+accepterId)s=qs-qrange-1;
		else if(t=="next_btn_"+accepterId) s= qs+qrange-1;
		else if(t=="end_btn_"+accepterId) s= qtot-qrange-1;
		else s= qs;	
		queryObj.start=s;
		queryObj.range=qrange;
		this._executeQuery(queryObj);
	},
	  
	  
	_executeQuery : function (queryObj) {
		var s= Object.toJSON(queryObj);
		Controller.query(s, function(r){
				//try{
					var result= r.evalJSON();
					if (result.code !=0 ){
						msgbox(result.message);
					}else {
						var evt=new BiEvent(result.callbackEvent);
						evt.setUserData(result);
						application.dispatchEvent(evt);
                        
					}
				/*}catch(ex){
					msgbox(ex.message);
				}*/
		  	}		
		);
	},

 returnRow:function(chkBoxEle){
    // return_string is the ak, pkData is the pk id
    var ele=document.getElementById(this._accepter_id);
    if(ele){
    	ele.value=chkBoxEle.title;
		var fk_acpt=$("fk_"+ this._accepter_id);
      	if(fk_acpt!=null)fk_acpt.value=chkBoxEle.id.replace(/chk_obj_/i, "") ;    	
      	if(ele.onaction){
      		ele.onaction(chkBoxEle.id.replace(/chk_obj_/i, "")); 
      	}
    	// for multi line input, check the first checkbox
    	try{
    		var row=this._accepter_id.split('_')[1];
    		document.sheet_item_modify.selectedItemIdx[row].checked = true;
    	}catch(e){
    	}
    	try{// prototype method
    		if(ele.onchange)ele.onchange();
    	}catch(e){
    	}
    }
	this._hidePopupWindow();
},
 _init_result : function(tableId){
	this._selTb= new SelectableTableRows(document.getElementById(tableId), false);
	
	this._selTb.ondoubleclick=function(trElement){
		var ele=$("chk_obj_"+trElement.title);
		var acpt=$(dq._accepter_id);
	  	acpt.value=ele.title;
	  	var fk_acpt=$("fk_"+ dq._accepter_id);
	  	if(fk_acpt!=null)fk_acpt.value=trElement.title ;
		if(acpt.onaction){
			acpt.onaction(trElement.title);
		}				
		dq._hidePopupWindow();
	};
},
_hidePopupWindow:function(){
	var e= document.getElementById("div_"+this._accepter_id);
	if(e==null){
		e=document.getElementById("object_query_content");
	}
	if(e!=null)e.style.display = "none";
	
	var ele=document.getElementById(this._accepter_id);
	if(ele)ele.focus();
	
},	

 /**
  * @param dropdwon_json array, each element is array [id, data1, data2]
  * @param dropdown_query see nds/queyr/dropdown_result.jsp
  */
 drawTable : function (dropdwon_json,dropdown_query){
		var dataid,desc1,desc2,temp; 
		var accepterId=dropdown_query.accepter_id;
		dqComboboxQueries[accepterId]=dropdown_query;			
		var tableWrapperDiv=document.getElementById("tdv_"+accepterId);
		var contentDiv=document.getElementById("content_"+accepterId);
	    var dropdownDiv = document.getElementById("div_"+accepterId);
		if(dropdwon_json.length==0){
		  str="<iframe id='json_"+accepterId+"' frameborder='0' style='position: absolute; top: 0; left: 0; z-index: 9;'>";
		    str="<table id=\"table_"+accepterId+"\" style='width:140; overflow:hidden;'  border='0' cellspacing='0' cellpadding='0'  align='center'"+"onselectstart='if(window.event.ctrlKey || window.event.shiftKey) return false;else return true;'>";
		    str=str+"<tr>";
		    str=str+"<td align=\"center\">"+gMessageHolder.NO_DATA+"</td>";
		    str=str+"</tr></table>";		  
		}else{	
		var str="<iframe id='json_"+accepterId+"' frameborder='0' style='width:160; position: absolute; top: 0; left: 0; z-index: 9;'>";
		 str="<table id=\"table_"+accepterId+"\"   border='0' cellspacing='0' cellpadding='0' align='center'"+"onselectstart='if(window.event.ctrlKey || window.event.shiftKey) return false;else return true;'>";
		str=str+"<tbady>";
		var i=0;
		for(i=0;i<dropdwon_json.length;i++){
		dataid=dropdwon_json[i][0];
		desc1=dropdwon_json[i][1];
		desc2=dropdwon_json[i][2];
		str=str+"<tr height='20' class='"+ (i%2==1?"odd-row":"even-row")+"' title='"+ dataid +"'>";
		str=str+"<td id=\"td_obj_"+dataid+"\"  align=\"center\" width=\"1%\"  nowrap height=\"20\" title=\""+desc1+"\">";
		str=str+"<input type='hidden' name='itemid' value='" + dataid + "'>";
	    str=str+"<input class='cbx' type='radio' "+" id='chk_obj_"+  dataid +"' name='selectedItemIdx' value='"+i+"' onclick='dq.returnRow(this)' title='"+ desc1+"'>"+"</td>";
		str=str+"<td nowrap>"+desc1+"</td>";
        str=str+"<td nowrap>"+desc2+"</td>";
        str=str+"</tr>";
    	}
    	str=str+"</tbody></table>";	
       }
    	str=str+"<table class='dq-scroll'><tr>";
    	str=str+"<td id='refresh_"+accepterId+"' onaction=\"dq.scrollPage('refresh_"+accepterId+"','"+accepterId+"')\"><img src=\"/html/nds/images/tb_refresh.gif\" align='absmiddle' border=0></td>";
    	str=str+"<td id='pop_"+accepterId+"' onaction=\"popup_window('"+dropdown_query.poppath+"&action=input')\"><img src=\"/html/nds/images/tb_new.gif\" align='absmiddle' border=0></td>";
    	str=str+"<td >-</td>";
    	str=str+"<td id='begin_btn_"+accepterId+"' onaction=\"dq.scrollPage('begin_btn_"+accepterId+"','"+accepterId+"')\"><img src=\"/html/nds/images/begin.gif\" width='16' height='16'></td>";
        str=str+"<td id='prev_btn_"+accepterId+"' onaction=\"dq.scrollPage('prev_btn_"+accepterId+"','"+accepterId+"')\"><img src=\"/html/nds/images/back.gif\" width='16' height='16'></td>";
        str=str+"<td id='next_btn_"+accepterId+"' onaction=\"dq.scrollPage('next_btn_"+accepterId+"','"+accepterId+"')\"><img src=\"/html/nds/images/next.gif\" width='16' height='16'></td>";
        str=str+"<td id='end_btn_"+accepterId+"' onaction=\"dq.scrollPage('end_btn_"+accepterId+"','"+accepterId+"')\"><img src=\"/html/nds/images/end.gif\" width='16' height='16'></td>";
	   str=str+"</tr></table></iframe>";
	    tableWrapperDiv.innerHTML=str;
	    var tableDiv= document.getElementById("table_"+accepterId);
	    var json= document.getElementById("json_"+accepterId); 
	    if(tableDiv.offsetWidth!=0) {
	    	 contentDiv.style.width=tableDiv.offsetWidth+17;
	         dropdownDiv.style.width=contentDiv.style.width;
	         json.style.width=contentDiv.style.width;	  
	         contentDiv.style.height=tableDiv.offsetHeight+26;
             dropdownDiv.style.height=contentDiv.style.height;
	         json.style.height=contentDiv.style.height;
	         if(dropdwon_json.length==0){
	         contentDiv.style.width=160;	
	         dropdownDiv.style.width=contentDiv.style.width;
	         json.style.width=contentDiv.style.width;
	         contentDiv.style.height=40;
             dropdownDiv.style.height=contentDiv.style.height;
	         json.style.height=contentDiv.style.height;
	        }
	    }
		createButton($("refresh_"+accepterId));
		createButton($("pop_"+accepterId));
		createButton($("begin_btn_"+accepterId));
		createButton($("prev_btn_"+accepterId));
		createButton($("next_btn_"+accepterId));
		createButton($("end_btn_"+accepterId)); 
		dq.syncGridControl(accepterId);
		this._init_result("table_"+accepterId);
		dropdownDiv.scrollIntoView();
  }
}

DropdownQuery.main = function () {
	dq=new DropdownQuery();
};
jQuery(document).ready(DropdownQuery.main);

DynamicQuery.prototype = {
	initialize: function() {
		this._tr_cloosed_index=-1;
		this._dynshow_json=null;
		this._accepter_id=null;
		this._mouseOnSug=false;
		this._iskey=false;
		this._dynshowjson=null;
		this._dcqjsonlist=null;
	},
   
	toggle: function(text_focus_index) {
		var flag=false;
		var tableId=null;
		var columnId=null;
		var newvalue="";
		var oldvalue="";
		if(this._dcqjsonlist!=null){
  	 		this._accepter_id=this._dcqjsonlist[text_focus_index].column_acc_Id;
  	 		tableId=this._dcqjsonlist[text_focus_index].tableId;
  	 		columnId=this._dcqjsonlist[text_focus_index].columnId;
  	 		newvalue=this._dcqjsonlist[text_focus_index].newvalue;
  	 		oldvalue=this._dcqjsonlist[text_focus_index].oldvalue;

		}
		if(this._dynshowjson!=null){
			for(var i=0;i<this._dynshowjson.length;i++){
				if(this._dynshowjson[i][0]==$(this._accepter_id).value){	
					flag=true;break;
				}
			}
		}
		if(this._dynshow_json!=null){
			if(this._dynshow_json.qdata==$(this._accepter_id).value&&oldvalue!=""){
				flag=true;
			} 
		}
		if(newvalue==""&&$("div_dyn")!=null){
			$("div_dyn").style.display="none"; 
		}
 		if(newvalue!=""&&newvalue!=oldvalue&&!flag){
			var query="/html/nds/query/dynamicshow_result.jsp?table="+tableId+"&column="+columnId+"&accepter_id="+this._accepter_id+"&qdata="+newvalue;
			var pos, path,queryString,dynqueryDiv; 	
			if($("div_dyn")!=null){
				$("div_dyn").style.display="";
				$("div_dyn").innerHTML ="<div id='divcontent_dyn' style='z-index: 10;'></div>";
			}else{
				var	dynqueryDiv=document.createElement("div");
				dynqueryDiv.id="div_dyn";
				dynqueryDiv.style.display="";
				dynqueryDiv.innerHTML ="<div id='divcontent_dyn' style='z-index:10;'></div>";
				document.body.appendChild(dynqueryDiv);
			}
			$("div_dyn").style.border="1px solid #ffffff";
			var offsets = getOffsets(this._accepter_id);
			pos = query.indexOf("?");
			path = query;
			queryString ="";
			if (pos != -1) {
				path = query.substring(0, pos);
				queryString = query.substring(pos + 1, query.length);
			}
			loadPage(path,queryString,this._returnQuery,this._accepter_id);
		}
	},
 
 /*
  *close div
 */
	closediv:function(){
		if(Prototype.Browser.IE){
			if($("sug_ie")!=null){
				$("sug_ie").style.display="none";
			}
		}
		$("div_dyn").style.display="none";
	},
		
		/*
		 * init  table tr.className
		*/
	creattable:function(){
		var trs=$("tb_"+dcq._accepter_id).rows;  
		for(var i=0;i<trs.length;i++){
			trs[i].className="odd-row";   
		}
	},
	 /*
	  * evaluate and close div
	 */
	 
	clktr:function(j){
		return function(){
			$(dcq._accepter_id).blur();
			dcq.closediv();
			$(dcq._accepter_id).value=this.cells[0].innerHTML;
		};
	}, 
	   
	   /*
	    * initialize text and tr ,add  basic property
	   */
	setdynamicdata:function(){
		$(this._accepter_id).onkeydown=this.keyboard;
		var isClkSug=false;
		$(this._accepter_id).onblur=function(e){
		if(!isClkSug){
			dcq.closediv();  
		}
		isClkSug=false;
		time=0;
		}
	 	if(typeof (this._dynshow_json.dynshowjson)!="object"||typeof (this._dynshow_json.qdata)=="undefined"||this._dynshow_json.qdata==""){
			return ;
	 	} 
		var tab=document.createElement("table");
		with(tab){id="tb_"+this._accepter_id; style.width="100%";style.backgroundColor="#fff"; cellspacing=0; cellpadding=0;style.cursor="default";}
		var tb=document.createElement("tbody");
		tab.appendChild(tb);
		for(var i=0;i<this._dynshow_json.dynshowjson.length;i++){
			var tr=tb.insertRow(-1);
			tr.onmouseover=function(){
	  		dcq.creattable;    
	  		this.className="selected";
	  		this._mouseOnSug=true;
	  		};
	  		tr.onmouseout=dcq.creattable;
	  		tr.onmousedown=function(e){
				$(dcq._accepter_id).blur();
				$(dcq._accepter_id).value=this.cells[0].innerHTML;
			};
			tr.onclick=this.clktr(i);
			var td=tr.insertCell(-1);
			td.innerHTML=this._dynshow_json.dynshowjson[i][0];
			td=tr.insertCell(-1);
			td.innerHTML=this._dynshow_json.dynshowjson[i][1];
		}
		var th=tb.insertRow(-1);
		var td=th.insertCell(-1);
		td.innerHTML ="";
		td=th.insertCell(-1);
		td.style.textAlign="right";
		td.innerHTML="<a href='javascript:void(0)'onclick='dcq.closediv();'>"+gMessageHolder.CLOSE_DIALOG+"</a>";
		var offsets = getOffsets(this._accepter_id);
		var div_top=offsets.y+(Prototype.Browser.Gecko?$(this._accepter_id).offsetHeight-3:$(this._accepter_id).offsetHeight);
		var dataheight=(this._dynshow_json.dynshowjson.length+1)*20;
		if(document.body.clientHeight-offsets.y-15<dataheight){
			div_top=div_top-dataheight-20;
		}
		$("div_dyn").style.width=(Prototype.Browser.IE?$(this._accepter_id).offsetWidth+20:$(this._accepter_id).offsetWidth+20);
		$("div_dyn").style.top=div_top+"px";
		$("div_dyn").style.left=offsets.x;
		$("div_dyn").style.padding=0; 
		$("div_dyn").style.position="relative";
		$("div_dyn").style.zIndex=10;
		$("divcontent_dyn").style.width=(Prototype.Browser.IE?$(this._accepter_id).offsetWidth+20:$(this._accepter_id).offsetWidth+20);
		$("divcontent_dyn").style.top=div_top+"px";
		$("divcontent_dyn").style.left=offsets.x;   
		$("tdiv_"+this._accepter_id).innerHTML="";
		$("tdiv_"+this._accepter_id).appendChild(tab);
		$("tdiv_"+this._accepter_id).style.width=(Prototype.Browser.IE?$(this._accepter_id).offsetWidth+20:$(this._accepter_id).offsetWidth+20);
		$("tdiv_"+this._accepter_id).style.top=div_top+"px";
		$("tdiv_"+this._accepter_id).style.left=offsets.x;
		$("tdiv_"+this._accepter_id).style.display="";
		if(Prototype.Browser.IE){
	 		var sug_ie=$("sug_ie");
	  		if(sug_ie==null){
	  			sug_ie=document.createElement("div");
	  			sug_ie.id="sug_ie";
	  			document.body.appendChild(sug_ie);
	  		}
	  		div_top=$(this._accepter_id).offsetHeight-14;
			if(document.body.clientHeight-div_top<dataheight){
				div_top=div_top-dataheight;
			}
	  		with(sug_ie.style){
	  			display="";
	  			position="absolute";
	  			top=div_top+"px";
	  			left="0px";
	  			width=$("div_dyn").offsetWidth+"px";
	  			height=tab.offsetHeight+"px";
			}
	  		sug_ie.appendChild($("div_dyn"));
		}
		this._tr_cloosed_index=-1;
	},
	
	/*
	 * keyboard operate
	 */
	keyboard:function(e){
		e=e||window.event;
		this._iskey=false;
		var ctr;
		if(e.keyCode==13){
			if(dcq._tr_cloosed_index>=0){
				dcq.closediv();
			}
		}
		if(e.keyCode==38||e.keyCode==40){
			this._mouseOnSug=false;
			if($("div_dyn").style.display!="none"){
				var trs=$("tb_"+dcq._accepter_id).rows;
				var l=trs.length-1;
				for(var i=0;i<l;i++){
					if(trs[i].className=="selected"){
						dcq._tr_cloosed_index=i;break;
					}
				}
				dcq.creattable();
				if(e.keyCode==38){
					if(dcq._tr_cloosed_index==0){
						$(dcq._accepter_id).value=dcq._dynshow_json.qdata;
						dcq._tr_cloosed_index=-1;
						this._iskey=true;
					}else{
						if(dcq._tr_cloosed_index==-1){
							dcq._tr_cloosed_index=l;
						}
						ctr=trs[--dcq._tr_cloosed_index];
						ctr.className="selected";
						$(dcq._accepter_id).value=ctr.cells[0].innerHTML;
					}
				}
				if(e.keyCode==40){
					if(dcq._tr_cloosed_index==l-1){
						$(dcq._accepter_id).value=dcq._dynshow_json.qdata;
			 			dcq._tr_cloosed_index=-1;
			 			this._iskey=true;
					}else{
						ctr=trs[++dcq._tr_cloosed_index];
						ctr.className="selected";
						$(dcq._accepter_id).value=ctr.cells[0].innerHTML;
					}
				}
			}
		}
	},
  
	_returnQuery:function(xmlHttpReq,accepter_id){
		var contentDiv = document.getElementById("divcontent_dyn");
		var divtext=xmlHttpReq.responseText;
		contentDiv.innerHTML = xmlHttpReq.responseText;
		executeLoadedScript(contentDiv);
		if(contentDiv.innerHTML!=""){
			$("div_dyn").style.border="1px solid #000000";
		}
	},
	/*
	   add text(auto) column
	*/
	createdynlist:function(dcqjsonlist1){
		if(this._dcqjsonlist==null){
			this._dcqjsonlist=dcqjsonlist1;
		}else{ 
			var len=this._dcqjsonlist.length;
			var flag=true;
         	for(var i=0;i<dcqjsonlist1.length;i++){
         		flag=true;
         		for(var j=0;j<len;j++){
         			if(this._dcqjsonlist[j].column_acc_Id==dcqjsonlist1[i].column_acc_Id){
         				flag=false;break;
         			}
         		}
         		if(flag){
	          		this._dcqjsonlist[len]=dcqjsonlist1[i];
	          		len++;
	          	}
        	}	
		}
	},
	
	/*
	  time dynamic query
	*/
	
	dynquery:function(){
		if(this._dcqjsonlist!=null){
			for(var i=0;i<this._dcqjsonlist.length;i++){
				if (this._dcqjsonlist[i].column_acc_Id== document.activeElement.id) {
					if($(this._dcqjsonlist[i].column_acc_Id).value!=this._dcqjsonlist[i].newvalue){
						this._dcqjsonlist[i].oldvalue=this._dcqjsonlist[i].newvalue;
						this._dcqjsonlist[i].newvalue=$(this._dcqjsonlist[i].column_acc_Id).value;
						this.toggle(i);
						break;
					}
				}
			}
		}
  },
	
	dynjson:function(dynshow_json){
		this._dynshow_json=dynshow_json; 
		if(this._dynshow_json.dynshowjson.length>0){
			this._tr_cloosed_index=-1;
   			this._dynshowjson=this._dynshow_json.dynshowjson;
  			this.setdynamicdata();
		} 
	}
}
DynamicQuery.main = function(){
	dcq=new DynamicQuery();
};
jQuery(document).ready(DynamicQuery.main);

/**
	 * Get updated url containing options value
	 * @param options, if not empty, will has format like:
	 * {ta:true|false, rc:[<columnId>,<columnId>...], prc:[<columnId>,<columnId>...]}
	 * ta: signs for whether current searchOnColumn is in title area or not
	 * rc: reference columns in wildcard filter, which is in same table as searchOnColumn
	 * prc:reference columns in wildcard filter, which is in parent table of searchOnColumn
	 * 
	 * @return null if find error
	 */
function reconstructQueryURL(orgURL, options){
		var url=orgURL;
		if(options !=undefined && options !=null){
			// check every colum input in rc and prc
			var i, str,ele,v, column;
			var ocArray= (options.ta? options.rc: options.prc);
			var gridArray= options.ta?[]:options.rc;
			// columns in objcontrol
			for(i=0;i< ocArray.length;i++){
				ele=$("column_"+ ocArray[i]);
				column = oc.getColumnById(ocArray[i]);
				//console.log("ele="+ ele+",ccolumn="+ column+", v="+ dwr.util.getValue(ele));
				if(ele!=null){
					v=dwr.util.getValue(ele);
					if(v==null || v.blank()){
						// if column is not nullable, alert user to input first
						if(column!=null && !column.isNullable){
							alert(gMessageHolder.INPUT_FIELD.replace("0", column.description));
							ele.focus();
							return;
						}
					}else{
						url+="&wfc_"+ ocArray[i]+"="+ encodeURIComponent(v);
					}
				}
			}
			// columns in gridcontrol
			for(i=0;i< gridArray.length;i++){
				column = gc.getColumnById(gridArray[i]);
				if(column ==null)continue;
				ele=$("eo_"+ column.name);
				if(ele!=null){
					v=dwr.util.getValue(ele);
					if(v==null){
						// if column is not nullable, alert user to input first
						if(!column.isNullable){
							alert(gMessageHolder.INPUT_FIELD.replace("0", column.description));
							ele.focus();
							return;
						}
					}else{
						url+="&wfc_"+ column.id+"="+ encodeURIComponent(v);
					}
				}
			}
		}
		return url;		
	} 
	
function handleObjectInputKey(event, objectSearchURL){
 	if (!event) {
    		event = window.event;
  	}
  	if ( event.altKey && event.keyCode == 191) {
  		//alert(objectSearchURL);
  		oq.toggle(	objectSearchURL, event.srcElement.id);
  	}
 } 
  
  
function handleDropdownInputKey(event, objectSearchURL){
 	if (!event) {
    		event = window.event;
  	}
  	if ( event.altKey && event.keyCode == 191) {
  		//alert(objectSearchURL);
  		dq.toggle(	objectSearchURL, event.srcElement.id);
  	}
 }





/**
 * I return an object with an x and y fields, indicating the object's
 * offset from the top left corner of the document.  The 'offsets'
 * argument is optional; if not provided, one will be initialized and
 * used.  It is exposed as a parameter because it can be useful for
 * computing deltas.  The 'object' parameter can be either an actual
 * document element, or the ID of one.
 *
 * @param object The object to compute the offset of.  May be an object
 *		or the ID of one.
 * @param offsets The starting offsets to calculate from.  In almost
 *		all cases, this should be omitted.
 * @return An offsets object with x and y fields, indicating the
 *		computed offsets for the object.  If an offsets object is
 *		passed, that will be the object returned, though the values
 *		will have been changed.
 */
function getOffsets(object, offsets) {
	if (! offsets) {
		offsets = new Object();
		offsets.x = offsets.y = 0;
	}
	if (typeof object == "string")
		object = document.getElementById(object);
	offsets.x += object.offsetLeft-object.scrollLeft;
	offsets.y += object.offsetTop-object.scrollTop;
	do {
		object = object.offsetParent;
		if (! object)
			break;
		if(object.tagName.toUpperCase() != "BODY"){
		offsets.x += object.offsetLeft-object.scrollLeft;
		offsets.y += object.offsetTop-object.scrollTop;
		}else{
		offsets.x += object.offsetLeft;
		offsets.y += object.offsetTop;
		}
	} while(object.tagName.toUpperCase() != "BODY");
	return offsets;
}
/*	This work is licensed under Creative Commons GNU LGPL License.

	License: http://creativecommons.org/licenses/LGPL/2.1/
   Version: 0.9
	Author:  Stefan Goessner/2006
	Web:     http://goessner.net/ 
	@param o json object
	@param tab convert tab to this string
*/
function json2xml(o, tab) {
   var toXml = function(v, name, ind) {
      var xml = "";
      if (v instanceof Array) {
         for (var i=0, n=v.length; i<n; i++)
            xml += ind + toXml(v[i], name, ind+"\t") + "\n";
      }
      else if (typeof(v) == "object") {
         var hasChild = false;
         xml += ind + "<" + name;
         for (var m in v) {
            if (m.charAt(0) == "@")
               xml += " " + m.substr(1) + "=\"" + v[m].toString() + "\"";
            else
               hasChild = true;
         }
         xml += hasChild ? ">" : "/>";
         if (hasChild) {
            for (var m in v) {
               if (m == "#text")
                  xml += v[m];
               else if (m == "#cdata")
                  xml += "<![CDATA[" + v[m] + "]]>";
               else if (m.charAt(0) != "@")
                  xml += toXml(v[m], m, ind+"\t");
            }
            xml += (xml.charAt(xml.length-1)=="\n"?ind:"") + "</" + name + ">";
         }
      }
      else {
         xml += ind + "<" + name + ">" + v.toString() +  "</" + name + ">";
      }
      return xml;
   }, xml="";
   for (var m in o)
      xml += toXml(o[m], m, "");
   return tab ? xml.replace(/\t/g, tab) : xml.replace(/\t|\n/g, "");
}


//document.write('<iframe id=CalFrame name=CalFrame frameborder=0 src=calendar.htm style=display:none;position:absolute;z-index:100></iframe>');
document.onclick=hideCalendar;

function showCalendar(sImg,bOpenBound,sFld1,sFld2,sCallback,bIsDateNumber)
{
	var fld1,fld2;
	var cf=document.getElementById("CalFrame");
	if(cf==null) return;
	var wcf=window.frames.CalFrame;
	var oImg=document.getElementById(sImg);
	if(!oImg){alert(sImg+" does not exists");return;}
	if(!sFld1){alert("Not set input object");return;}
	fld1=document.getElementById(sFld1);
	if(!fld1){alert("Input object does not exists");return;}
	if(fld1.tagName!="INPUT"||fld1.type!="text"){alert("Wrong input object");return;}
	if(sFld2)
	{
		fld2=document.getElementById(sFld2);
		if(!fld2){alert("Ref input object does not exists");return;}
		if(fld2.tagName!="INPUT"||fld2.type!="text"){alert("Ref object type error");return;}
	}
	if(!wcf.bCalLoaded){alert("Calendar control not loaded, please refresh page");return;}
	if(cf.style.display=="block"){cf.style.display="none";return;}
	
	var eT=0,eL=0,p=fld1;//oImg;
	var sT=document.body.scrollTop,sL=document.body.scrollLeft;
	var eH=oImg.height,eW=oImg.width;
	while(p&&p.tagName!="BODY"){eT+=p.offsetTop;eL+=p.offsetLeft;p=p.offsetParent;}
	cf.style.top=(document.body.clientHeight-(eT-sT)-eH>=cf.height)?eT+eH:eT-cf.height;
	cf.style.left=(document.body.clientWidth-(eL-sL)>=cf.width)?eL:eL+eW-cf.width;
	cf.style.display="block";
	
	wcf.openbound=bOpenBound;
	wcf.fld1=fld1;
	wcf.fld2=fld2;
	wcf.callback=sCallback;
	wcf.initCalendar(bIsDateNumber);
}
function hideCalendar()
{
	var cf=document.getElementById("CalFrame");
	if(cf==null) return;
	cf.style.display="none";
}
