//<script>
/*
 * This script was created by Erik Arvidsson (erik@eae.net)
 * for  (http://.eae.net)
 * Copyright 2001
 * 
 * For usage see license at http://.eae.net/license.html	
 *
 * Created:		2001-01-12
 * Updates:		2001-11-20	Added hover mode support and removed Opera focus hacks
 *				2001-12-20	Added auto positioning and some properties to support this
 *				2002-08-13	toString used ' for attributes. Changed to " to allow in args
 */
 
// check browsers
var ua = navigator.userAgent;
var opera = /opera [56789]|opera\/[56789]/i.test(ua);
var ie = !opera && /MSIE/.test(ua);
var ie50 = ie && /MSIE 5\.[01234]/.test(ua);
var ie6 = ie && /MSIE [6789]/.test(ua);
var ieBox = ie && (document.compatMode == null || document.compatMode != "CSS1Compat");
var moz = !opera && /gecko/i.test(ua);
var nn6 = !opera && /netscape.*6\./i.test(ua);
// define the default values
MenuDefaultWidth			= 130;

MenuDefaultBorderLeft		= 2;
MenuDefaultBorderRight		= 2;
MenuDefaultBorderTop		= 2;
MenuDefaultBorderBottom	    = 2;
MenuDefaultPaddingLeft		= 1;
MenuDefaultPaddingRight	    = 1;
MenuDefaultPaddingTop		= 1;
MenuDefaultPaddingBottom	= 1;

MenuDefaultShadowLeft		= 0;
MenuDefaultShadowRight		= ie && !ie50 && /win32/i.test(navigator.platform) ? 4 :0;
MenuDefaultShadowTop		= 0;
MenuDefaultShadowBottom	= ie && !ie50 && /win32/i.test(navigator.platform) ? 4 : 0;

MenuItemDefaultHeight		= 18;
MenuItemDefaultText		= "Untitled";
MenuItemDefaultHref		= "javascript:void(0)";

MenuSeparatorDefaultHeight	= 6;

MenuDefaultEmptyText		= "Empty";

MenuDefaultUseAutoPosition	= nn6 ? false : true;

// other global constants
MenuImagePath				= "/html/nds/images/";

MenuUseHover				= true;
MenuHideTime				= 200;
MenuShowTime				= 200;

var menuHandler = {
	idCounter		:	0,
	idPrefix		:	"webfx-menu-object-",
	all				:	{},
	getId			:	function () { return this.idPrefix + this.idCounter++; },
	overMenuItem	:	function (oItem) {
		if (this.showTimeout != null)
			window.clearTimeout(this.showTimeout);
		if (this.hideTimeout != null)
			window.clearTimeout(this.hideTimeout);
		var jsItem = this.all[oItem.id];
		if (MenuShowTime <= 0)
			this._over(jsItem);
		else
			//this.showTimeout = window.setTimeout(function () { menuHandler._over(jsItem) ; }, MenuShowTime);
			// I hate IE5.0 because the piece of shit crashes when using setTimeout with a function object
			this.showTimeout = window.setTimeout("menuHandler._over(menuHandler.all['" + jsItem.id + "'])", MenuShowTime);
	},
	outMenuItem	:	function (oItem) {
		if (this.showTimeout != null)
			window.clearTimeout(this.showTimeout);
		if (this.hideTimeout != null)
			window.clearTimeout(this.hideTimeout);
		var jsItem = this.all[oItem.id];
		if (MenuHideTime <= 0)
			this._out(jsItem);
		else
			//this.hideTimeout = window.setTimeout(function () { menuHandler._out(jsItem) ; }, MenuHideTime);
			this.hideTimeout = window.setTimeout("menuHandler._out(menuHandler.all['" + jsItem.id + "'])", MenuHideTime);
	},
	blurMenu		:	function (oMenuItem) {
		window.setTimeout("menuHandler.all[\"" + oMenuItem.id + "\"].subMenu.hide();", MenuHideTime);
	},
	dispatchItemAction:function(oItem){
		var jsItem = this.all[oItem.id];
		if(jsItem.parentMenu && jsItem.subMenu==null){
			
			this._out(jsItem);
			if ( typeof jsItem.action == "function" ) {
				jsItem.action();
			}else if ( typeof jsItem.action == "string" ) {	// href
				if ( jsItem.target != null )
					window.open( jsItem.action, jsItem.target );
				else
					document.location.href = jsItem.action;
			}	
		}
	},
	_over	:	function (jsItem) {
		if (jsItem.subMenu) {
			jsItem.parentMenu.hideAllSubs();
			jsItem.subMenu.show();
		}
		else
			jsItem.parentMenu.hideAllSubs();
	},
	_out	:	function (jsItem) {
		// find top most menu
		var root = jsItem;
		var m;
		if (root instanceof MenuButton)
			m = root.subMenu;
		else {
			m = jsItem.parentMenu;
			while (m.parentMenu != null && !(m.parentMenu instanceof MenuBar))
				m = m.parentMenu;
		}
		if (m != null)	
			m.hide();	
	},
	hideMenu	:	function (menu) {
		if (this.showTimeout != null)
			window.clearTimeout(this.showTimeout);
		if (this.hideTimeout != null)
			window.clearTimeout(this.hideTimeout);

		this.hideTimeout = window.setTimeout("menuHandler.all['" + menu.id + "'].hide()", MenuHideTime);
	},
	showMenu	:	function (menu, src, dir) {
		if (this.showTimeout != null)
			window.clearTimeout(this.showTimeout);
		if (this.hideTimeout != null)
			window.clearTimeout(this.hideTimeout);
		if (arguments.length < 3)
			dir = "vertical";
		
		menu.show(src, dir);
	}
};

function Menu() {
	this._menuItems	= [];
	this._subMenus	= [];
	this.id			= menuHandler.getId();
	this.top		= 0;
	this.left		= 0;
	this.shown		= false;
	this.parentMenu	= null;
	menuHandler.all[this.id] = this;
}

Menu.prototype.width			= MenuDefaultWidth;
Menu.prototype.emptyText		= MenuDefaultEmptyText;
Menu.prototype.useAutoPosition	= MenuDefaultUseAutoPosition;

Menu.prototype.borderLeft		= MenuDefaultBorderLeft;
Menu.prototype.borderRight		= MenuDefaultBorderRight;
Menu.prototype.borderTop		= MenuDefaultBorderTop;
Menu.prototype.borderBottom	= MenuDefaultBorderBottom;

Menu.prototype.paddingLeft		= MenuDefaultPaddingLeft;
Menu.prototype.paddingRight	= MenuDefaultPaddingRight;
Menu.prototype.paddingTop		= MenuDefaultPaddingTop;
Menu.prototype.paddingBottom	= MenuDefaultPaddingBottom;

Menu.prototype.shadowLeft		= MenuDefaultShadowLeft;
Menu.prototype.shadowRight		= MenuDefaultShadowRight;
Menu.prototype.shadowTop		= MenuDefaultShadowTop;
Menu.prototype.shadowBottom	= MenuDefaultShadowBottom;

Menu.prototype.add = function (menuItem) {
	this._menuItems[this._menuItems.length] = menuItem;
	if (menuItem.subMenu) {
		this._subMenus[this._subMenus.length] = menuItem.subMenu;
		menuItem.subMenu.parentMenu = this;
	}
	
	menuItem.parentMenu = this;
};

Menu.prototype.show = function (relObj, sDir) {
	if (this.useAutoPosition)
		this.position(relObj, sDir);
	
	var divElement = document.getElementById(this.id);
	divElement.style.left = opera ? this.left : this.left + "px";
	divElement.style.top = opera ? this.top : this.top + "px";
	divElement.style.visibility = "visible";
	this.shown = true;
	if (this.parentMenu)
		this.parentMenu.show();
};

Menu.prototype.hide = function () {
	this.hideAllSubs();
	var divElement = document.getElementById(this.id);
	divElement.style.visibility = "hidden";
	this.shown = false;
};

Menu.prototype.hideAllSubs = function () {
	for (var i = 0; i < this._subMenus.length; i++) {
		if (this._subMenus[i].shown)
			this._subMenus[i].hide();
	}
};
Menu.prototype.toString = function () {
	var top = this.top + this.borderTop + this.paddingTop;
	var str = "<div id='" + this.id + "' class='webfx-menu' style='" + 
	"width:" + (!ieBox  ?
		this.width - this.borderLeft - this.paddingLeft - this.borderRight - this.paddingRight  : 
		this.width) + "px;" +
	(this.useAutoPosition ?
		"left:" + this.left + "px;" + "top:" + this.top + "px;" :
		"") +
	(ie50 ? "filter: none;" : "") +
	"'>";
	
	if (this._menuItems.length == 0) {
		str +=	"<span class='webfx-menu-empty'>" + this.emptyText + "</span>";
	}
	else {	
		// loop through all menuItems
		for (var i = 0; i < this._menuItems.length; i++) {
			var mi = this._menuItems[i];
			str += mi;
			if (!this.useAutoPosition) {
				if (mi.subMenu && !mi.subMenu.useAutoPosition)
					mi.subMenu.top = top - mi.subMenu.borderTop - mi.subMenu.paddingTop;
				top += mi.height;
			}
		}

	}
	
	str += "</div>";

	for (var i = 0; i < this._subMenus.length; i++) {
		this._subMenus[i].left = this.left + this.width - this._subMenus[i].borderLeft;
		str += this._subMenus[i];
	}
	
	return str;
};
// Menu.prototype.position defined later
function MenuItem(sText, fAction, sIconSrc, oSubMenu) {
	this.text = sText || MenuItemDefaultText;
	this.action=fAction;
	this.subMenu = oSubMenu;
	if (oSubMenu)
		oSubMenu.parentMenuItem = this;
	// sIconSrc is useless currently
	this.id = menuHandler.getId();
	menuHandler.all[this.id] = this;
};
MenuItem.prototype.height = MenuItemDefaultHeight;

MenuItem.prototype.toString = function () {
	return	"<a" +
			" id='" + this.id + "'" +
			" href=\"" + MenuItemDefaultHref + "\"" +
			" onmouseup='menuHandler.dispatchItemAction(this)'" +
			" onmouseover='menuHandler.overMenuItem(this)'" +
			(MenuUseHover ? " onmouseout='menuHandler.outMenuItem(this)'" : "") +
			(this.subMenu ? " unselectable='on' tabindex='-1'" : "") +
			">" +
			(this.subMenu ? "<img class='arrow' src=\"" + MenuImagePath + "arrow.right.png\">" : "") +
			this.text + 
			"</a>";
};


function MenuSeparator() {
	this.id = menuHandler.getId();
	menuHandler.all[this.id] = this;
};
MenuSeparator.prototype.height = MenuSeparatorDefaultHeight;
MenuSeparator.prototype.toString = function () {
	return	"<div" +
			" id='" + this.id + "'" +
			(MenuUseHover ? 
			" onmouseover='menuHandler.overMenuItem(this)'" +
			" onmouseout='menuHandler.outMenuItem(this)'"
			:
			"") +
			"></div>"
};

function MenuBar() {
	this._parentConstructor = Menu;
	this._parentConstructor();
}
MenuBar.prototype = new Menu;
MenuBar.prototype.write=function(){
	document.write(this.toString());	
}
MenuBar.prototype.toString = function () {
	var str = "<div id='" + this.id + "' class='webfx-menu-bar'>";
	
	// loop through all menuButtons
	for (var i = 0; i < this._menuItems.length; i++)
		str += this._menuItems[i];
	
	str += "</div>";

	for (var i = 0; i < this._subMenus.length; i++)
		str += this._subMenus[i];
	
	return str;
};

function MenuButton(sText, oSubMenu) {
	this._parentConstructor = MenuItem;
	this._parentConstructor(sText, null, null, oSubMenu);
}
MenuButton.prototype = new MenuItem;
MenuButton.prototype.toString = function () {
	return	"<a" +
			" id='" + this.id + "'" +
			" href='" + MenuItemDefaultHref + "'" +
			(MenuUseHover ?
				(" onmouseover='menuHandler.overMenuItem(this)'" +
				" onmouseout='menuHandler.outMenuItem(this)'") :
				(
					" onfocus='menuHandler.overMenuItem(this)'" +
					(this.subMenu ?
						" onblur='menuHandler.blurMenu(this)'" :
						""
					)
				)) +">" +this.text + "</a>";
};


/* Position functions */

function getInnerLeft(el) {
	if (el == null) return 0;
	if (ieBox && el == document.body || !ieBox && el == document.documentElement) return 0;
	return getLeft(el) + getBorderLeft(el);
}

function getLeft(el) {
	if (el == null) return 0;
	return el.offsetLeft + getInnerLeft(el.offsetParent);
}

function getInnerTop(el) {
	if (el == null) return 0;
	if (ieBox && el == document.body || !ieBox && el == document.documentElement) return 0;
	return getTop(el) + getBorderTop(el);
}

function getTop(el) {
	if (el == null) return 0;
	return el.offsetTop + getInnerTop(el.offsetParent);
}

function getBorderLeft(el) {
	return ie ?
		el.clientLeft :
		parseInt(window.getComputedStyle(el, null).getPropertyValue("border-left-width"),10);
}

function getBorderTop(el) {
	return ie ?
		el.clientTop :
		parseInt(window.getComputedStyle(el, null).getPropertyValue("border-top-width"),10);
}

function opera_getLeft(el) {
	if (el == null) return 0;
	return el.offsetLeft + opera_getLeft(el.offsetParent);
}

function opera_getTop(el) {
	if (el == null) return 0;
	return el.offsetTop + opera_getTop(el.offsetParent);
}

function getOuterRect(el) {
	return {
		left:	(opera ? opera_getLeft(el) : getLeft(el)),
		top:	(opera ? opera_getTop(el) : getTop(el)),
		width:	el.offsetWidth,
		height:	el.offsetHeight
	};
}

// mozilla bug! scrollbars not included in innerWidth/height
function getDocumentRect(el) {
	return {
		left:	0,
		top:	0,
		width:	(ie ?
					(ieBox ? document.body.clientWidth : document.documentElement.clientWidth) :
					window.innerWidth
				),
		height:	(ie ?
					(ieBox ? document.body.clientHeight : document.documentElement.clientHeight) :
					window.innerHeight
				)
	};
}

function getScrollPos(el) {
	return {
		left:	(ie ?
					(ieBox ? document.body.scrollLeft : document.documentElement.scrollLeft) :
					window.pageXOffset
				),
		top:	(ie ?
					(ieBox ? document.body.scrollTop : document.documentElement.scrollTop) :
					window.pageYOffset
				)
	};
}

/* end position functions */

Menu.prototype.position = function (relEl, sDir) {
	var dir = sDir;
	// find parent item rectangle, piRect
	var piRect;
	if (!relEl) {
		var pi = this.parentMenuItem;
		if (!this.parentMenuItem)
			return;
		
		relEl = document.getElementById(pi.id);
		if (dir == null)
			dir = pi instanceof MenuButton ? "vertical" : "horizontal";
		
		piRect = getOuterRect(relEl);
	}
	else if (relEl.left != null && relEl.top != null && relEl.width != null && relEl.height != null) {	// got a rect
		piRect = relEl;
	}
	else
		piRect = getOuterRect(relEl);
	
	var menuEl = document.getElementById(this.id);
	var menuRect = getOuterRect(menuEl);
	var docRect = getDocumentRect();
	var scrollPos = getScrollPos();
	var pMenu = this.parentMenu;
	
	if (dir == "vertical") {
		if (piRect.left + menuRect.width - scrollPos.left <= docRect.width)
			this.left = piRect.left;
		else if (docRect.width >= menuRect.width)
			this.left = docRect.width + scrollPos.left - menuRect.width;
		else
			this.left = scrollPos.left;
			
		if (piRect.top + piRect.height + menuRect.height <= docRect.height + scrollPos.top)
			this.top = piRect.top + piRect.height;
		else if (piRect.top - menuRect.height >= scrollPos.top)
			this.top = piRect.top - menuRect.height;
		else if (docRect.height >= menuRect.height)
			this.top = docRect.height + scrollPos.top - menuRect.height;
		else
			this.top = scrollPos.top;
	}
	else {
		if (piRect.top + menuRect.height - this.borderTop - this.paddingTop <= docRect.height + scrollPos.top)
			this.top = piRect.top - this.borderTop - this.paddingTop;
		else if (piRect.top + piRect.height - menuRect.height + this.borderTop + this.paddingTop >= 0)
			this.top = piRect.top + piRect.height - menuRect.height + this.borderBottom + this.paddingBottom + this.shadowBottom;
		else if (docRect.height >= menuRect.height)
			this.top = docRect.height + scrollPos.top - menuRect.height;
		else
			this.top = scrollPos.top;

		var pMenuPaddingLeft = pMenu ? pMenu.paddingLeft : 0;
		var pMenuBorderLeft = pMenu ? pMenu.borderLeft : 0;
		var pMenuPaddingRight = pMenu ? pMenu.paddingRight : 0;
		var pMenuBorderRight = pMenu ? pMenu.borderRight : 0;
		
		if (piRect.left + piRect.width + menuRect.width + pMenuPaddingRight +
			pMenuBorderRight - this.borderLeft + this.shadowRight <= docRect.width + scrollPos.left)
			this.left = piRect.left + piRect.width + pMenuPaddingRight + pMenuBorderRight - this.borderLeft;
		else if (piRect.left - menuRect.width - pMenuPaddingLeft - pMenuBorderLeft + this.borderRight + this.shadowRight >= 0)
			this.left = piRect.left - menuRect.width - pMenuPaddingLeft - pMenuBorderLeft + this.borderRight + this.shadowRight;
		else if (docRect.width >= menuRect.width)
			this.left = docRect.width  + scrollPos.left - menuRect.width;
		else
			this.left = scrollPos.left;
	}
};