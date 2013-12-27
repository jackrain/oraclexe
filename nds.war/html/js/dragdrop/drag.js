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
