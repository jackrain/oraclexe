Menu.prototype.cssFile ="/html/nds/js/menu4/skins/officexp/officexp.css";

var tmp;

// Build context menu
var cMenu = new Menu();

var openItem, openNewWinItem;

cMenu.add( openItem = new MenuItem( "Open" ) );
openItem.mnemonic = "o";
cMenu.add( openNewWinItem = new MenuItem( "Open in New Window") );
openNewWinItem.mnemonic = "n";
var favoriteItem;
cMenu.add( favoriteItem = new MenuItem( "Add to Favorite..." ) );
favoriteItem.mnemonic = "f";

var backItem, forwardItem, refreshItem;

cMenu.add( backItem = new MenuItem( "Back", function () { window.history.go(-1); }) );
backItem.mnemonic = "b";
cMenu.add( forwardItem = new MenuItem( "Forward", function () { window.history.go(1); } ) );
forwardItem.mnemonic = "o";
cMenu.add( refreshItem = new MenuItem( "Refresh", function () { document.location.reload(); } ) );
refreshItem.mnemonic = "r";

/*var sourceItem;
cMenu.add( sourceItem = new MenuItem( "View Source", function () { location='view-source:'+location } ) );
sourceItem.mnemonic = "s";
*/
// edit menu
var eMenu = new Menu()

var undoItem, cutItem, copyItem, pasteItem, deleteItem, selectAllItem;

// undo is broken in IE
// eMenu.add( undoItem = new MenuItem( "Undo", function () { document.execCommand( "Undo" ); }, "images/undo.small.png" ) );
// undoItem.mnemonic = "u";
//
//
// eMenu.add( new MenuSeparator() );


eMenu.add( cutItem = new MenuItem( "Cut", function () { document.execCommand( "Cut" ); } ) );
cutItem.mnemonic = "t";

eMenu.add( copyItem = new MenuItem( "Copy", function () { document.execCommand( "Copy" ); }) );
copyItem.mnemonic = "c";

eMenu.add( pasteItem = new MenuItem( "Paste", function () { document.execCommand( "Paste" ); } ) );
pasteItem.mnemonic = "p";

eMenu.add( deleteItem = new MenuItem( "Delete", function () { document.execCommand( "Delete" ); } ) );
deleteItem.mnemonic = "d";


eMenu.add( new MenuSeparator() );


eMenu.add( selectAllItem = new MenuItem( "Select All", function () { document.execCommand( "SelectAll" ); } ) );
selectAllItem.mnemonic = "a";




var oldOpenState = null;	// used to only change when needed
var lastKeyCode = 0;

function rememberKeyCode() {
	lastKeyCode = window.event.keyCode;
}
function getURL(l){
	if(l.indexOf(":")>0) return l;
	var loc= window.location;
	return "http://"+ loc.host+":"+loc.port+l;
}
function showContextMenu() {

	var el = window.event.srcElement;

	// check for edit
	var showEditMenu = el != null &&
						(el.tagName == "INPUT" || el.tagName == "TEXTAREA");

	// check for anchor
	while ( el != null && el.tagName != "A" )
		el = el.parentNode;

	var showOpenItems = el != null && el.tagName == "A";

	if ( showOpenItems != oldOpenState ) {
		openItem.visible		= showOpenItems;
		openNewWinItem.visible	= showOpenItems && (el.href.indexOf("(")==-1);
		favoriteItem.visible	= openNewWinItem.visible;
		backItem.visible		= !showOpenItems;
		forwardItem.visible		= !showOpenItems;
		refreshItem.visible		= !showOpenItems;
		oldOpenState = showOpenItems;
	}

	if ( showOpenItems ) {
		openItem.action =  el.href;
		openNewWinItem.action ="javascript:popup_window('"+ el.href+"','_blank')";
		favoriteItem.action ="javascript:window.external.AddFavorite('"+ getURL(el.href)+"',el.innerText)";
	}

	// find left and top
	var left, top;

	if ( showEditMenu )
		el = window.event.srcElement;
	else if ( !showOpenItems )
		el = document.documentElement;

	if ( lastKeyCode == 93 ) {	// context menu key
		left = posLib.getScreenLeft( el );
		top = posLib.getScreenTop( el );
	}
	else {
		left = window.event.screenX;
		top = window.event.screenY;
	}

	if ( showEditMenu ) {

		// undo is broken in IE
		// undoItem.disabled =			!document.queryCommandEnabled( "Undo" );
		cutItem.disabled =			!document.queryCommandEnabled( "Cut" );
		copyItem.disabled =			!document.queryCommandEnabled( "Copy" );
		pasteItem.disabled =		!document.queryCommandEnabled( "Paste" );
		deleteItem.disabled =		!document.queryCommandEnabled( "Delete" );
		selectAllItem.disabled =	!document.queryCommandEnabled( "SelectAll" );

		eMenu.invalidate();
		eMenu.show( left, top );
	}
	else {
		cMenu.invalidate();
		cMenu.show( left, top );
	}

	event.returnValue = false;
	lastKeyCode = 0
};
function noContextMenu() {
	event.returnValue = false;
	return false;
}
if(/MSIE/.test(navigator.userAgent))document.attachEvent( "oncontextmenu",noContextMenu );

