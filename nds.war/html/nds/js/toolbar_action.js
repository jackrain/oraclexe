/**
  Used for toolbar action creation
*/
var moduleFrameset=parent.module;
var listFrame=parent.listFrame;
var mainFrame=parent.mainFrame;
var tableName, tableId, searchAllLink,baseURL;
var NDS_PATH;
function checkMainFrame(){
	try{
       if(window.parent.module.cols== "*,1"){
       		window.parent.module.cols="*,780";
       }
    }catch(ex){}	
}

function importList(){
	mainFrame.location=NDS_PATH+"/objext/import_excel.jsp?table="+tableId;
	checkMainFrame();
}
function listCreate(){
	mainFrame.location=NDS_PATH+"/objext/object_batchadd.jsp?table="+tableId;
	checkMainFrame();
}
function listCopyTo(){
	listFrame.doCopyTo();
	checkMainFrame();
}
function updateSelected(){
	listFrame.doUpdateSelected();
	checkMainFrame();
}
function showWorkFlow(){
	mainFrame.location=NDS_PATH+"/objext/wfmy.jsp";
	checkMainFrame();
}
function showExportFolder(){
	mainFrame.location=NDS_PATH+"/reports/index.jsp";
	checkMainFrame();
}
function deleteList(){
	listFrame.doCommand('ListDelete');
}
function submitList(){
	listFrame.doCommand('ListSubmit');
}
function auditList(){
	listFrame.doCommand('ListAudit');
}
function smsList(){
	/*var fm=listFrame.document.form1;
	var oldTarget=fm.target;
   	fm.target="top.mainFrame";//mainFrame;
	listFrame.createReport(fm);
	fm.target=oldTarget;*/
	listFrame.doExportSMS();
	checkMainFrame();
}
function exportList(){
	listFrame.doExport();
	checkMainFrame();
}
function cxtabList(){
	listFrame.doCxtabReport();
	checkMainFrame();
}
function updateList(){
	listFrame.doUpdate();
	checkMainFrame();
}
function calendarView(){
	mainFrame.location=NDS_PATH+"/calendar/index.jsp?table="+tableId;
	checkMainFrame();
}

function returnHomepage(){
	parent.location="/";
}
function logout(){
	parent.location="/c/portal/logout?referer=/c";
}
function loadSystemCommand(){
    mainFrame.location=NDS_PATH+"/objext/syscommand.jsp";
	checkMainFrame();
}
function loadCubes(param){
    mainFrame.location=NDS_PATH+"/olap/cubes.jsp?"+param;
	checkMainFrame();
}
function showObjectPortal(){
	mainFrame.location=NDS_PATH+"/objext/object_portal.jsp";	
	checkMainFrame();
}
function printList(){
	listFrame.printDocument(listFrame.document.form1);
	checkMainFrame();
}

function myFilters(param){
	mainFrame.location=NDS_PATH+"/objext/myfilters.jsp?"+param;	
	checkMainFrame();
}
function searchAll(){
	// for all records
	mainFrame.location=searchAllLink;
	checkMainFrame();
}
function changeRange(rng){
	listFrame.changeRange(rng);
}
function changeStatus(st){
	listFrame.location= NDS_PATH+"/objext/list.jsp?table="+tableId+"&status="+st;
}
function closeTree(){
	mainFrame.location=NDS_PATH+"/objext/closetree.jsp?table="+tableId;
	checkMainFrame();
}
function loadPage(tb){
	parent.location=baseURL+tb;
}
function largeLeftWindow(){
	try{
	moduleFrameset.cols = "*,240";
	}catch(ex){}
}
function minimizeWindow(){
	try{
	moduleFrameset.cols = "1,*";
	mainFrame.document.getElementById("showtoc").style.display = "block";
	}
	catch(ex){}
}
function maxmizeWindow(){
	try{moduleFrameset.cols = "*,1";}
	catch(ex){}
}
function normalizeWindow(){
	try{moduleFrameset.cols = "240,441*";}
	catch(ex){}
}
function helpTOC(wikiRootPath){
	popup_window(wikiRootPath+"/Wiki.jsp?page=Help","ndshelp");	
}
function helpCurrentTable(tableId,wikiRootPath){
	popup_window(NDS_PATH+"/help/index.jsp?table="+tableId,"ndshelp");	
}
Menu.prototype.cssText=".menu-body {color:Black;margin:0;padding:0;overflow:hidden;border:0;cursor:default;}"+
".menu-body .outer-border {border:1px solid #666666;margin:0;padding:0;}"+
".menu-body .inner-border {width:100%;border:1px solid #f9f8f7;border-width:1px 0 1px 0;padding:0 1px 0 1px;margin:0;background:#f9f8f7 url('../menu4/skins/officexp/background.gif') repeat-y;}"+
".menu-body td {font:Menu;color:Black;}.menu-body .hover td {background-color:#b6bdd2;}"+
".menu-body .disabled-hover td {background-color:white;}"+
".menu-body td.empty-icon-cell {padding:2px;border:0;}"+
".menu-body td.empty-icon-cell span {width:16px;}"+
".menu-body td.icon-cell {padding:2px;border:0;}"+
".menu-body td.icon-cell img {width:16px;height:16px;margin:0;filter:Alpha(Opacity=70);}"+
".menu-body .hover td.icon-cell img {filter:none;position:relative;left:-1px;top:-1px;}"+
".menu-body .disabled-hover td.icon-cell img,.menu-body .disabled td.icon-cell img {display:static;filter:Gray() Alpha(Opacity=40);}"+
".menu-body .disabled-hover td.empty-icon-cell,.menu-body .hover td.empty-icon-cell,.menu-body .disabled-hover td.icon-cell,.menu-body .hover td.icon-cell {border:1px solid #0A246A;border-right:0;padding:1px 2px 1px 1px;}"+
".menu-body td.label-cell {width:100%;padding:2px 5px 2px 5px;border:0;}.menu-body .disabled-hover td.label-cell,.menu-body .hover td.label-cell,.menu-body .disabled-hover td.shortcut-cell,.menu-body .hover td.shortcut-cell {padding:1px 5px 1px 5px;border:1px solid #0A246A;border-left:0;border-right:0;}"+
".menu-body td.shortcut-cell {padding:2px 5px 2px 5px;}.menu-body td.arrow-cell {width:20px;padding:2px 2px 2px 0px;font-family:Webdings;}"+
".menu-body .disabled-hover td.arrow-cell,.menu-body .hover td.arrow-cell {padding:1px 1px 1px 0px;border:1px solid #0A246A;border-left:0;}.menu-body #scroll-up-item td,.menu-body #scroll-down-item td {font-family:Webdings !important;text-align:center;padding:10px;}.menu-body .disabled td {color:#cccccc;}"+
".menu-body .disabled-hover td {"+"background-color:white;color:#cccccc;"+"}"+
".menu-body .separator td {font-size:0.001mm;padding:1px 0px 1px 27px;}"+
".menu-body .separator-line {overflow:hidden;border-top:1px solid #dbd8d1;height:1px;}"+
".menu-body #scroll-up-item,.menu-body #scroll-down-item {width:100%;}"+
".menu-body #scroll-up-item td,.menu-body #scroll-down-item td {font-family:Webdings;text-align:center;padding:1px 5px 1px 5px;}"+
".menu-body #scroll-up-item .disabled-hover td,.menu-body #scroll-up-item .hover td,.menu-body #scroll-down-item .disabled-hover td,.menu-body #scroll-down-item .hover td {border:1px solid #0A246A;padding:0px 4px 0px 4px;}"+
".menu-body .checked {padding:0px;}.menu-body .checked.hover {padding:0px;}"+
".menu-body .checked .check-box,.menu-body .checked .radio-button {display:inline-block;font-family:Webdings;overflow:hidden;color:MenuText;text-align:center;vertical-align:center;background-color:#b6bdd2;border:1px solid #0A246A;}"+
".menu-body .check-box {width:19px;height:19px;font-size:133%;padding-bottom:5px;padding-left:1px;}.menu-body .radio-button {width:19px;height:19px;font-size:50%;padding:5px;}"+
".menu-bar {background:ButtonFace;cursor:default;padding:1px;}.menu-bar .menu-button {background:ButtonFace;color:ButtonText;font:Menu;padding:3px 7px 3px 7px;border:0;margin:0;display:inline-block;white-space:nowrap;cursor:default;}"+
".menu-bar .menu-button.active {background:#dbd8d1;padding:2px 6px 3px 6px;border:1px solid #666666;border-bottom:0;}.menu-bar .menu-button.hover {background:#b6bdd2;padding:2px 6px 2px 6px;border-width:1px;border-style:solid;border-color:#0A246A;}";

var ie55 = /MSIE ((5\.[56789])|([6789]))/.test( navigator.userAgent ) &&
			navigator.platform == "Win32";
if ( !ie55 ) {
	window.onerror = function () {
		return true;
	};
}
function writeNotSupported() {
	if ( !ie55 ) {
		document.write( "<p class=\"warning\">" +
			"This script only works in Internet Explorer 5.5" +
			" or greater for Windows</p>" );
	}
}
