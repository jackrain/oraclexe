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
