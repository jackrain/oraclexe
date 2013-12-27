/*************************************************************************
  This code is from Dynamic Web Coding at www.dyn-web.com
  Copyright 2001-5 by Sharon Paine 
  See Terms of Use at www.dyn-web.com/bus/terms.html
  regarding conditions under which you may use this code.
  This notice must be retained in the code as is!
*************************************************************************/

/*
    pausing scroller - vertical or horizontal 
    version date: March 2005 (revised GeckoTableFix)
*/

// Arguments: id of content layer (inside wn), width and height of scroller (of wn, that is), 
// number of items (repeat 1st one at end!), axis ("v" or "h"),
// set up mouse events? (boolean)
function dw_scroller(id, w, h, num, axis, bMouse) {
    this.id=id; this.el = document.getElementById? document.getElementById(id): null; 
    if (!this.el) return; this.css = this.el.style; 
    this.css.left = this.x = 0; this.css.top = this.y = 0;
    this.w=w; this.h=h; this.num=num; this.axis=axis||"v"; 
    this.ctr=0; // pause onload (for large doc's, may want to set this to 1)
    this.pause=5000; this.speed=60; // defaults
    if (bMouse) dw_scrollers.setMouseEvents(this.el);
    this.lastTime = new Date().getTime(); this.check = 0;
    this.index = dw_scrollers.ar.length;  dw_scrollers.ar[this.index] = this;
    this.active = true;
}

dw_scroller.prototype.setTiming = function(speed, pause) {
    this.speed = speed; this.pause = pause;
}

dw_scroller.prototype.controlScroll = function() {
    if (this.ctr > this.num-1) {
        this.shiftTo(0, 0); this.ctr = 1;
    } else {
        switch (this.axis) {
            case "v" :
                if (this.y > -this.h * this.ctr) { 
                    var ny = this.y + -1 * this.elapsed/1000 * this.speed;
                    ny = Math.max(ny, -this.h * this.ctr);
                    this.shiftTo(0, ny);	
                } else this.doPause();
                break;
            case "h" :
                if (this.x > -this.w * this.ctr) { 
                    var nx = this.x + -1 * this.elapsed/1000 * this.speed;
                    nx = Math.max(nx, -this.w * this.ctr);
                    this.shiftTo(nx, 0);	
                } else this.doPause();
            break;
        }
    }
}

dw_scroller.prototype.doPause = function() {
    this.check += this.elapsed;
    if (this.check >= this.pause) { this.ctr++; this.check = 0; }
}

dw_scroller.prototype.shiftTo = function(x, y) {
    this.css.left = (this.x = x) + "px";
    this.css.top = (this.y = y) + "px";
}

////////////////////////////////////////////////////////////////////////////
// common to all scrollers (pausing or continuous, vertical or horizontal)
dw_scrollers = {};  
dw_scrollers.ar = []; // global access to all scroller instances

dw_scrollers.setMouseEvents = function(obj) {
    obj.onmouseover = dw_scrollers.halt;
    obj.onmouseout = dw_scrollers.resume;
}

dw_scrollers.halt = function() {
    var curObj;
    for (var i=0; curObj = dw_scrollers.ar[i]; i++) 
        if ( curObj.id == this.id ) { curObj.active = false; return; }
}

dw_scrollers.resume = function(e) {
    var curObj;
    for (var i=0; curObj = dw_scrollers.ar[i]; i++) {
        if ( curObj.id == this.id ) {
            e = e? e: window.event;
            var toEl = e.relatedTarget? e.relatedTarget: e.toElement;
            if ( this != toEl && !dw_contained(toEl, this) ) { 
                var now = new Date().getTime();
                curObj.elapsed = now - curObj.lastTime;
                curObj.lastTime = now; curObj.active = true; return; 
            }
        }
    }
}

// Handle all instances with one timer - idea from youngpup.net
dw_scrollers.timer = window.setInterval("dw_scrollers.control()", 10);
dw_scrollers.control = function() {
    var curObj;
    for (var i=0; curObj = dw_scrollers.ar[i]; i++) {
        if ( curObj.active ) {
            var now = new Date().getTime();
            curObj.elapsed = now - curObj.lastTime;
            curObj.lastTime = now; curObj.controlScroll();
        }
    }
}

// remove layers from table for ns6+/mozilla (needed for scrollers inside tables)
// pass id's of scrollers (i.e., div's that contain content that scrolls, usually wn, or wn1, ...)
dw_scrollers.GeckoTableFix = function() {
    var ua = navigator.userAgent;
    if ( ua.indexOf("Gecko") > -1 && ua.indexOf("Firefox") == -1 
        && ua.toLowerCase().indexOf("like gecko") == -1 ) {
        dw_scrollers.hold = []; // holds id's of wndo (i.e., 'the scroller') and its container
        for (var i=0; arguments[i]; i++) {
            var wndo = document.getElementById( arguments[i] );
            var holderId = wndo.parentNode.id;
            var holder = document.getElementById(holderId);
            document.body.appendChild( holder.removeChild(wndo) );
            wndo.style.zIndex = 1000;
            var pos = getPageOffsets(holder);
            wndo.style.left = pos.x + "px"; wndo.style.top = pos.y + "px";
            dw_scrollers.hold[i] = [ arguments[i], holderId ];
        }
        window.addEventListener("resize", dw_scrollers.rePosition, true);
    }
}

// ns6+/mozilla need to reposition layers onresize when scrollers inside tables.
dw_scrollers.rePosition = function() {
    if (dw_scrollers.hold) {
        for (var i=0; dw_scrollers.hold[i]; i++) {
            var wndo = document.getElementById( dw_scrollers.hold[i][0] );
            var holder = document.getElementById( dw_scrollers.hold[i][1] );
            var pos = getPageOffsets(holder);
            wndo.style.left = pos.x + "px"; wndo.style.top = pos.y + "px";
        }
    }
}

function getPageOffsets(el) {
    var left = el.offsetLeft;
    var top = el.offsetTop;
    if ( el.offsetParent && el.offsetParent.clientLeft || el.offsetParent.clientTop ) {
        left += el.offsetParent.clientLeft;
        top += el.offsetParent.clientTop;
    }
    while ( el = el.offsetParent ) {
        left += el.offsetLeft;
        top += el.offsetTop;
    }
    return { x:left, y:top };
}

// returns true if oNode is contained by oCont (container)
function dw_contained(oNode, oCont) {
  if (!oNode) return; // in case alt-tab away while hovering (prevent error)
  while ( oNode = oNode.parentNode ) if ( oNode == oCont ) return true;
  return false;
}

// avoid memory leak in ie
dw_scrollers.unHook = function() {
  var i, curObj;
  for (i=0; curObj = dw_scrollers.ar[i]; i++) {
    if ( curObj.el ) { 
      curObj.el.onmouseover = null;
      curObj.el.onmouseout = null;
      curObj.el = null;
    }
  }
}

if ( window.addEventListener ) window.addEventListener( "unload", dw_scrollers.unHook, true);
else if ( window.attachEvent ) window.attachEvent( "onunload", dw_scrollers.unHook );
