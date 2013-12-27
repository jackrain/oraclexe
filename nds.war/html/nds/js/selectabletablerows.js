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