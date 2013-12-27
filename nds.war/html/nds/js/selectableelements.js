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