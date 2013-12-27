/*
 * resize.js - click & resize DOM elements
 *
 * originally based on Youngpup's dom-resize.js, www.youngpup.net
 */

/**********************************************************
 Further modified from the example by Tim Taylor
 http://tool-man.org/examples/sorting.html
 
 Changed onMouseMove where it calls group.onResize and then
 adjusts the offset for changes to the DOM.  If the item
 being moved changed parents it would be off so changed to
 get the absolute offset (recursive northwestOffset).
 
 Modified Liferay: http://www.liferay.com
 **********************************************************/

function ResizeRule (element, direction, mode) {
	this.element = element;
	this.direction = direction;
	this.next = null;
	this.origWidth = null;
	this.origHeight = null;
	this.mode = mode;
}

var Resize = {
	BIG_Z_INDEX : 100,
	group : null,
	isResizeing : false,
	
	/* Resize direction */
	
	HORIZONTAL : 0,
	VERTICAL : 1,
	
	/* Resize modes */
	
	ADD : 0,
	SUBTRACT : 1,

	addRule : function(resizeRule) {
		var group = this;
		
		if (group.listHead == null) {
			group.listHead = resizeRule;
			group.listTail = group.listHead;
		}
		else {
			group.listTail.next = resizeRule;
			group.listTail = resizeRule;
		}
		
	},
	
	createHandle : function(group, disableStop, func) {
		group.onmousedown = Resize.onMouseDown;
		group.addRule = Resize.addRule;
		group.listHead = null;
		group.listTail = null;
		group.disableStop = disableStop == null ? false : true;
		
		group.onResizeStart = new Function();
		group.onResize = new Function();
		group.onResizeEnd = new Function();

		group.func = func;

		return group;
	},
	
	getHeight : function(obj) {
		var debugDiv = document.getElementById("debug_div");
		if (obj.style && obj.style.height && obj.style.height != "") {
			//debugDiv.innerHTML += "parse<br/>";
			return parseInt(obj.style.height);
		}
		else {
			//debugDiv.innerHTML += "offset<br/>"
			return obj.offsetHeight;
		}
	},
	
	getWidth : function(obj) {
		if (obj.style && obj.style.width && obj.style.width != "") {
			return parseInt(obj.style.width);
		}
		else {
			return obj.offsetWidth;
		}
	},

	onMouseDown : function(event) {
		event = mousePos.update(event);

		Resize.group = this;
		var group = Resize.group;
		var mouse = mousePos;
		
		group.mouseStart = new Coordinate(mousePos.x, mousePos.y);
		
		var resizeRule = group.listHead;
		
		while (resizeRule) {
			resizeRule.origWidth = Resize.getWidth(resizeRule.element);
			resizeRule.origHeight = Resize.getHeight(resizeRule.element);
			resizeRule = resizeRule.next;
		}
		
		document.onmousemove = Resize.onMouseMove;
		document.onmouseup = Resize.onMouseUp;
		document.getElementsByTagName("body")[0].style.cursor = group.style.cursor;
		
		group.onResizeStart();

		return false;
	},

	onMouseMove : function(event) {
		event = mousePos.update(event);
		
		var group = Resize.group;
		var mouse = mousePos;
		var mouseDelta = mousePos.minus(group.mouseStart);
		
		var resizeRule = group.listHead;
		var newLength;
		var lengthCorrection = 0;
		var noChange = false;
		
		while (resizeRule) {
			if (resizeRule.direction == Resize.HORIZONTAL) {
				resizeRule.prevLength = Resize.getWidth(resizeRule.element);
				
				if (resizeRule.mode == Resize.ADD) {
					newLength = resizeRule.origWidth + mouseDelta.x;
				}
				else {
					newLength = resizeRule.origWidth - mouseDelta.x
				}
			}
			else if (resizeRule.direction == Resize.VERTICAL) {
				resizeRule.prevLength = Resize.getHeight(resizeRule.element);
				
				if (resizeRule.mode == Resize.ADD) {
					newLength = resizeRule.origHeight + mouseDelta.y;
				}
				else {
					newLength = resizeRule.origHeight - mouseDelta.y;
				}
			}
			
			resizeRule.newLength = newLength;
			
			if (newLength < 1) {
				lengthCorrection = Math.max(-newLength + 1, lengthCorrection);
				newLength = 1;
			}
			
			
			if (newLength == resizeRule.prevLength) {
				noChange = true;
			}
			
			resizeRule = resizeRule.next;
		}
		
		resizeRule = group.listHead;
		
		//var debugDiv = document.getElementById("debug_div");
		//debugDiv.innerHTML += lengthCorrection + " " + noChange + "<br/>";
		
		while (resizeRule) {
			if (!group.disableStop && noChange) {
				newLength = resizeRule.prevLength;
			}
			else if (resizeRule.newLength < 1) {
				newLength = resizeRule.newLength + lengthCorrection;
			}
			else {
				newLength = resizeRule.newLength - lengthCorrection;
			}
			
			if (resizeRule.direction == Resize.HORIZONTAL) {
					resizeRule.element.style.width = newLength + "px";
			}
			else if (resizeRule.direction == Resize.VERTICAL) {
					resizeRule.element.style.height = newLength + "px";
			}
			
			resizeRule = resizeRule.next;
		}
		
		group.onResize();
		
		return false;
	},

	onMouseUp : function(event) {
		event = mousePos.update(event);
		var group = Resize.group;

		var mouse = event.windowCoordinate;
		
		group.mouseEnd = new Coordinate(mousePos.x, mousePos.y);
		
		group.onResizeEnd();
		
		document.onmousemove = null;
		document.onmouseup   = null;
		document.getElementsByTagName("body")[0].style.cursor = "auto";
		Resize.group = null;

		if (group.func != null) {
			group.func();
		}

		return false;
	}

};