var commonCommands={buttons:{}, menuItems:{}};
/**
@param sCommand - like 'Add','Modify'
@param sDesc    - Description show as button text
@param sImgSrc  - relative to /html/nds/images
@param sAccessKey     - single character for key
*/
function TableCommand(sCommand,sDesc,sImgSrc,sAccessKey,sAction) {
	this.cmd=sCommand;
	this.desc=sDesc;
	this.img=sImgSrc;
	this.shortkey= sAccessKey;
	if(sAction ==undefined) this.act="pc.do"+sCommand;
	else this.act=sAction;
}
TableCommand.prototype.toMenuItemString= function() {
	var str="<li class='"+this.cmd+"'><a href='javascript:"+ this.act+"()'>"+ this.desc +"</a></li>";
	return str;
};
TableCommand.prototype.toButtonString= function() {
	/*var str="<input type='button' class='cbutton' "+((this.shortkey==null|| this.shortkey==undefined)?"":"accesskey='"+this.shortkey+"'")+
		" onclick='"+this.act+"()' value='"+ this.desc+"'>";*/
	var str="<a "+((this.shortkey==null|| this.shortkey==undefined)?"":"accesskey='"+this.shortkey+"'")+" href='javascript:"+this.act+"()'>";
	if(this.img!=null) str+="<img src='/html/nds/images/"+ this.img+"'>";
	str+=this.desc+"</a>";
	return str;
};
TableCommand.prototype.makeTemplate=function(){
	commonCommands.buttons[this.cmd]= this.toButtonString();
	commonCommands.menuItems[this.cmd]= this.toMenuItemString();
};
(new TableCommand("Add", gMessageHolder.CMD_ADD,"tb_new.gif","N")).makeTemplate();
(new TableCommand("Modify", gMessageHolder.CMD_MODIFY,"tb_modify.gif","S")).makeTemplate();
(new TableCommand("Delete", gMessageHolder.CMD_DELETE,"tb_delete.gif","X")).makeTemplate();
(new TableCommand("Submit", gMessageHolder.CMD_SUBMIT,"tb_submit.gif","G")).makeTemplate();
(new TableCommand("Report", gMessageHolder.CMD_CXTAB,"tb_cxtab.gif",null)).makeTemplate();
(new TableCommand("ListAdd", gMessageHolder.CMD_LISTADD,"tb_listadd.gif",null)).makeTemplate();
(new TableCommand("Import", gMessageHolder.CMD_IMPORT,"tb_import.gif.gif",null)).makeTemplate();
(new TableCommand("ListCopyTo", gMessageHolder.CMD_LISTCOPYTO,"tb_listcopy.gif",null)).makeTemplate();
(new TableCommand("UpdateSelection", gMessageHolder.CMD_UPDATE_SELECTION,"tb_update_selection.gif",null)).makeTemplate();
(new TableCommand("UpdateResultSet", gMessageHolder.CMD_UPDATE_RESULTSET,"tb_update_resultset",null)).makeTemplate();
/*
废弃列表打印按钮
(new TableCommand("PrintList", gMessageHolder.CMD_PRINT_LIST,"tb_print.gif",null)).makeTemplate();
*/
(new TableCommand("ExportList", gMessageHolder.CMD_EXPORT_LIST,"tb_export.gif",null)).makeTemplate();
(new TableCommand("SmsList", gMessageHolder.CMD_SMS_LIST,"tb_sms.gif",null)).makeTemplate();
(new TableCommand("Refresh", gMessageHolder.CMD_REFRESH,"tb_refresh.gif","J")).makeTemplate();
(new TableCommand("Void", gMessageHolder.CMD_VOID,"tb_void.gif",null)).makeTemplate();
(new TableCommand("Unvoid", gMessageHolder.CMD_UNVOID,"tb_unvoid.gif",null)).makeTemplate();
(new TableCommand("PrintSelect", gMessageHolder.CMD_PRINT_SELECT,"tb_print.gif",null)).makeTemplate();

function TableCommands(oTable) {
	this.id= oTable.id;
	var i,c,t,tb;
	this._buttons=[];
	this._menuItems=[];
	var a1=[],a2=[];
	a2[a2.length]="Refresh";
	if(oTable.actionEXPORT){
		//a2[a2.length]="Report";
		a2[a2.length]="ExportList";
		a2[a2.length]="PrintList";
		a2[a2.length]="PrintSelect";
		
	}
	if(oTable.actionADD){
		a1[a1.length]="Add";
		a2[a2.length]="Import";
		//a2[a2.length]="ListAdd";
	}
	if(oTable.actionMODIFY){
		a1[a1.length]="Modify";
		if(!oTable.actionADD)a2[a2.length]="Import";
	}
	if(oTable.actionDELETE){
		a1[a1.length]="Delete";
	}
	if(oTable.actionVOID){
		a1[a1.length]="Void";
		//a2[a2.length]="Unvoid"; always not show unvoid in list
	}
	if(oTable.actionSUBMIT){
		a1[a1.length]="Submit";
	}
	a2[a2.length]="ListCopyTo";
	/*if(oTable.actionEXPORT){
		a2[a2.length]="SmsList";
	}*/
	
	for(i=0;i<a1.length &&i<4;i++){
		this._buttons[this._buttons.length]=a1[i];
	}
	if(a1.length>=4){
		for(i=4;i<a1.length;i++) this._menuItems[this._menuItems.length]=a1[i];
		for(i=0;i<a2.length;i++)this._menuItems[this._menuItems.length]=a2[i];
	}else{
		for(i=0;i<a2.length && i<(4-a1.length);i++)this._buttons[this._buttons.length]=a2[i];
		for(i=i;i<a2.length;i++)this._menuItems[this._menuItems.length]=a2[i];
	}
	if(oTable.actionMODIFY){
		this._menuItems[this._menuItems.length]="UpdateSelection";
		this._menuItems[this._menuItems.length]="UpdateResultSet";
	}
	
}
TableCommands.prototype.initButtons=function(){
	DockMenu.init();
}
TableCommands.prototype.toString= function() {
	var sb = [];
	for (var i = 0; i < this._buttons.length; i++) {
		sb[i] =commonCommands.buttons[this._buttons[i]];
	}
	var str="";
	str+="<div class='table-buttons'>";
	str+=sb.join("");
	if(this._menuItems.length==1){
		str+=commonCommands.buttons[this._menuItems[0]];
	}
	str+="</div>";
	if(this._menuItems.length>1){
			
		str+="<div class='portal-dock interactive-mode'><div class='table-buttons btn-more'><a href='#'><img src='/html/nds/images/button_more.png'>"+
			gMessageHolder.MORE_COMMANDS+"</a></div>"+
			"<ul class='portal-dock-list' id='portal-dock-list-"+ this.id +"'>";
		sb = [];
		for (var i = 0; i < this._menuItems.length; i++) {
			sb[i] =commonCommands.menuItems[this._menuItems[i]];
		}
		str+=sb.join("");
		str+="</ul></div>";
	}
	//debug(str);
	return str;
};

var categoryTabHandler = {
	all       : {},
	selected  : null,
	select    : function (oItem) { 
		this.all["C"+oItem.id.replace("page-tab-","")].select();
	 },
	init:function(){
		this.all={};
		this.selected=null;	
	}	 
};
function CategoryTabItem(oTableCategory) {
	this.id=oTableCategory.id;
	//增加当前是否存在子系统ID
	this.ssid=oTableCategory.ssid;
	this.oTableCategory=oTableCategory;
	categoryTabHandler.all["C"+this.id] = this;
}
CategoryTabItem.prototype.select = function() {
	if ((categoryTabHandler.selected) && (categoryTabHandler.selected != this)) { 
		if(categoryTabHandler.selected.id!=0&&this.oTableCategory.id==0){
			window.location="/html/nds/portal/portal.jsp";
		};
		categoryTabHandler.selected.deSelect(); 
	}
	categoryTabHandler.selected = this;
	document.getElementById("page-tab-"+this.id).className="page-tab-selected";
	//alert(this.oTableCategory.url);
	if(dwr.engine._preHook) dwr.engine._preHook();
	new Ajax.Request(this.oTableCategory.url, {
	  method: 'get',
	  onSuccess: function(transport) {
	  	if(dwr.engine._postHook) dwr.engine._postHook();	
	  	var pt=$("portal-content");
	    pt.innerHTML=transport.responseText;
	    executeLoadedScript(pt);
	  },
	  onFailure:function(transport){
	  	//try{
  		if(dwr.engine._postHook) dwr.engine._postHook();
  	  	if(transport.getResponseHeader("nds.code")=="1"){
  	  		window.location="/c/portal/login";
  	  		return;
  	  	}
  	  	var exc=transport.getResponseHeader("nds.exception");
  	  	if(exc!=null && exc.length>0){
  	  		alert(decodeURIComponent(exc));	
  	  	}else{
  	  		var pt=$("portal-content");
    		pt.innerHTML=transport.responseText;
    		executeLoadedScript(pt);
  	  	}
	  	//}catch(e){}
	  	
	  }

	});
	
};
CategoryTabItem.prototype.deSelect = function() {
	document.getElementById("page-tab-"+this.id).className = 'page-tab';
	categoryTabHandler.selected = null;
};

CategoryTabItem.prototype.toString= function() {
	//var str = "<div id=\"page-tab-" + this.id + "\" onclick=\"categoryTabHandler.select(this);\" class=\"page-tab\"><div class=\"page-tab-text\">" +
		//			this.oTableCategory.desc+"</div></div>";
	//alert(this.id);
	if(this.id==0){
		var str = "<li id=\"page-tab-" + this.id + "\" onclick=\"categoryTabHandler.select(this);\" class=\"page-tab\"><a class=\"page-tab-text\">" +
	"<img src=\"/html/nds/themes/classic/01/images/bos-logo.png\" alt=\"BOS Logo\"></a></li>";
	}else{
	var str = "<li id=\"page-tab-" + this.id + "\" onclick=\"categoryTabHandler.select(this);\" class=\"page-tab\"><a class=\"page-tab-text\">" +
	this.oTableCategory.desc+"</a></li>";
  }
	return str;			
		
};
function CategoryTabs(oCategories) {
	var i,c,t,tb;
	this.childNodes=[];
	for(i=0;i<oCategories.length;i++){
		t=new CategoryTabItem(oCategories[i]);
		this.childNodes[this.childNodes.length]=t;
	}
}

CategoryTabs.prototype.toString= function() {
	var sb = [];
	for (var i = 0; i < this.childNodes.length; i++) {
		sb[i] = this.childNodes[i].toString();
	}
	return sb.join("");
};
/*
function subsystem(u) {
	new Ajax.Request(u, {
	  method: 'get',
	  onSuccess: function(transport) {
	  	var pt=$("portal-content");
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
	  	  		var pt=$("portal-content");
	    		pt.innerHTML=transport.responseText;
	    		executeLoadedScript(pt);
	  	  	}
	  	//}catch(e){}
	  	
	  }
	});
};*/