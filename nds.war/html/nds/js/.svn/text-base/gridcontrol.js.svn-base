/*var log = log4javascript.getLogger("main"); 
var popUpAppender = new log4javascript.PopUpAppender();
log.addAppender(popUpAppender);
var lastDebugTime=(new Date()).getTime();
* 
function logdebug(s){
	var d=new Date();
	log.debug("["+d.getSeconds()+":"+ d.getMilliseconds()+"] "+ s + "("+ (d.getTime()-lastDebugTime)+")");
	lastDebugTime=d.getTime();
}*/
 
var gc=null;
var GridControl = Class.create();
// define
GridControl.prototype = {
	isDestroied:function(){
		return this._isDestroied;
	},
	destroy:function(){
		application.removeEventListener("TurboScan", this._onTurboScan, this);
		application.removeEventListener("RefreshGrid", this._refreshGrid, this);
		application.removeEventListener( "UpdateGrid", this.updateGrid, this);
		application.removeEventListener( "CheckProductAttribute", this._checkProductAttribute, this);
		application.removeEventListener( "ShowProductAttribute", this._showProductAttribute, this);
		application.removeEventListener( "CheckMaterialAttribut",this._checkMaterialAttribute,this);
		this._isDestroied=true;
	},
	initialize: function() {
		this._regexp_integer=new RegExp(/^[+|-]?\d+$/);
		this._isDestroied=false;
		this._isDirty=false;
		this._objpage="/html/nds/object/object.jsp";
		this._currentNewRowId=1;
		this._currentRow= -1;// which row index is editing, start from 0, -1 means a new line
		this._data=null; // table data, first column is rowIdx
		var initObj=new GridInitObject();
		this._fixedColumns= initObj.getFixedColumns();// key: column id, value: fixed data
		this._fixedColumnsStr= initObj.getFixedColumnsStr(); // string for upload to server
		this._tableActions= initObj.getTableActions();// table actions AMDS
		this._supportAttributeDetail = initObj.supportAttributeDetail();// table support 
		this._gridQuery= initObj.getGridQueryObj();
		this._orig_startidx= this._gridQuery.start;
		this._inlineMode= initObj.getInlineMode();
		var metaObj=new EditableGridMetadata(initObj.getGridMetadata());
		this._gridMetadata= metaObj;
		this._tmpData=null;
		this._wrow=null;
		this.MAX_INPUT_LENGTH=1000;// this is used for selection range
		this._gridTable= null;// @see _initTable
		// init dwr
		dwr.util.useLoadingMessage(gMessageHolder.LOADING);
		dwr.util.setEscapeHtml(false);
		/** A function to call if something fails. */
		/*dwr.engine._errorHandler =  function(message, ex) {
	  		while(ex!=null && ex.cause!=null) ex=ex.cause;
	  		if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + ", " + ex.message+","+ ex.cause.message, true);
			if (message == null || message == "") msgbox("A server error has occured. More information may be available in the console.");
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else msgbox(message);
		};*/
		application.addEventListener( "RefreshGrid", this._refreshGrid, this);
		application.addEventListener( "UpdateGrid", this.updateGrid, this);
		application.addEventListener( "CheckProductAttribute", this._checkProductAttribute, this);
		application.addEventListener( "ShowProductAttribute", this._showProductAttribute, this);
		application.addEventListener( "TurboScan", this._onTurboScan, this);
		//add by robin 20121009 
		application.addEventListener( "CheckMaterialAttribut",this._checkMaterialAttribute,this);
		//end
		// call _initGrid when recieved data
		var q=Object.clone(this._gridQuery);
		q.callbackEvent="RefreshGrid";
		this._executeQuery(q);
		 
		this.newLine(false);
		
		if(this._inlineMode=="Y"){
			this._toggleEditableFields(true);
		}
		//this._initTable();
	},
	/**
	@param idx - 's' stock qty, 'c' qty_consign, 'v' qty valid
	*/
	showQty:function(sign){
		if( $(sign+"qty").checked){
			$$('#modify_table_product .'+sign).each(Element.show);
		}else{
			$$('#modify_table_product .'+sign).each(Element.hide);
		}

	},
	/**
	 When in table with single child, the child (grid) will be loaded the same time with parent
	 yet fixed columns must be updated when parent gets id from server.
	*/
	updateFixedColumns:function(fcStr, fcObj){
		this._fixedColumns=fcObj;// key: column id, value: fixed data
		this._fixedColumnsStr= fcStr;
		this._gridQuery.fixedcolumns=fcStr;
	},
	/**
	 * Get column by id in _gridMetadata object, return null if not found
	 * column properties:
	 * 	@see nds.control.util.GridColumn.toJSONObject()
	 */
	getColumnById:function(id){
		var i;
		for(i=0;i<this._gridMetadata.columns.length;i++){
			if( this._gridMetadata.columns[i].columnId==id) return this._gridMetadata.columns[i];
		}
		return null;
	},
	setObjectPage:function(url){
		this._objpage=url;
	},
	_syncGridControl:function(qr){
		this._gridQuery.totalRowCount=qr.totalRowCount;
		this._gridQuery.start=qr.start;
		if( this._gridQuery.orders==null)this._gridQuery.orders=[];
		var torders= $('titletr').getElementsByClassName('odr');
		var j,i,ele,s;
		for(j=0;j<torders.length;j++){
			ele=torders[j];
			ele.innerHTML="";
		}
		for(i=0;i<this._gridQuery.orders.length;i++){
			ele=$("title_"+this._gridQuery.orders[i].c);
			if(ele!=null){
				s="<img src='/html/nds/images/"+( this._gridQuery.orders[i].t==false?"down":"up")+"simple.png'>";
				if(i<4) s+="<img src='/html/nds/images/m"+(i+1)+".png'>";
				ele.innerHTML=s;
			}
		}
		if($("txtRange")!=null){
			$("txtRange").innerHTML=((qr.start+1)+"-"+ (qr.start+qr.rowCount)+"/"+ qr.totalRowCount);
			if(qr.start>0){
				 $("begin_btn").setEnabled(true);
				 $("prev_btn").setEnabled(true);
			}else{
				 $("begin_btn").setEnabled(false);
				 $("prev_btn").setEnabled(false);
			}
			if((qr.start+qr.rowCount)< qr.totalRowCount){
				 $("next_btn").setEnabled(true);
				 $("end_btn").setEnabled(true);
			}else{
				 $("next_btn").setEnabled(false);
				 $("end_btn").setEnabled(false);
			}
		}
	},
	/**
	 * mark all check box checked
	 */
	selectAll:function(){
		var i;
		var b= dwr.util.getValue($("chk_select_all"));
		for(i=0;i< this._data.length;i++){
			if(["D","E","N"].indexOf(this._data[i][1])>-1) continue;
			 dwr.util.setValue($(this._data[i][0]+"_chk"), b);
		}
	},
	/**
	 * do quick search according to input
	 */
	quickSearch: function(){
		if(this.checkNew()) return;
		if(this.checkDirty()==false){
			this._gridQuery.quick_search_data= dwr.util.getValue("quick_search_data");
			this._gridQuery.quick_search_column= dwr.util.getValue("quick_search_column");
			this._gridQuery.start=0;
			this._executeQuery(this._gridQuery);
		}
	},	
	fk:function(tableId, objId){
		var url="/html/nds/object/object.jsp?table="+tableId+"&id="+objId;
		popup_window(url,"_blank", 956,570);
	},
	/**
	 * Open current row in new window
	 */
	openLineInNewWindow :function(bCheckSelected){
		if(!this._gridMetadata.popupitem){
			msgbox(gMessageHolder.NOT_ALLOW_TO_POPUP_AS_NOT_MENUOBJ);
			return; // FOR AU_PHASE TYPE
		}
		if(bCheckSelected==undefined)bCheckSelected=false;
		if(bCheckSelected){
			this._currentRow=this._getSelectedRow();
			if(this._currentRow==-1){
				msgbox(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
				return;
			}
		}
		if(this._currentRow==-1){
			popup_window(this._objpage+"?"+ (new GridInitObject()).getLineCreationLink());
		}else{
			popup_window((new GridInitObject()).getLinePage()+this._data[this._currentRow][4]);
		}
	},
	/**
	Note this function will be called by objcontrol.js
	@param evt the evt object to fill
	@return boolean whether there's data to handle or not
	*/
	fillProcessEvent:function(evt){
		var meta=this._gridMetadata;
		var i; 
		evt.column_masks=meta.column_masks;
		evt.table=meta.table;
		evt.fixedColumns= this._fixedColumnsStr;
		evt.bestEffort=true;//each line will have a seperate transaction
		evt.addList=[];
		evt.modifyList=[];
		evt.deleteList=[];
		var hasData=false;
		for(i=0;i< this._data.length;i++){
			var line= this._data[i];
			//if( dwr.util.getValue($(line[0] +"_chk"))==true ){
				switch(line[1]){
					case "A": 
						// add
						evt.addList.push(this._getArrayOfRow(i, line, meta.columnsWhenCreate));
						hasData=true;
						break;
					case "M":
						// modify
						evt.modifyList.push(this._getArrayOfRow(i,line, meta.columnsWhenModify));
						hasData=true;
						break;
					case "D":
						evt.deleteList.push(this._getArrayOfRow(i,line, meta.columnsWhenDelete));
						hasData=true;
						break;
					default:
				}
			//}
		}
		
		evt.queryRequest=this._gridQuery;	
		return hasData;	
	},
	/**
	* Save objects,  create update command and execute
	* only checked lines will be saved
	*/
	saveAll : function () {
		var evt={};
		evt.command="UpdateGridData";
		evt.callbackEvent="UpdateGrid";
		var hasData=this.fillProcessEvent(evt);
		if(!hasData){
			msgbox(gMessageHolder.NO_DATA_TO_PROCESS);
			return;
		}
		this._executeCommandEvent(evt);
	},
	/**
	 * @return -1 or first selected line
	 */
	_getSelectedRow:function(){
		var i,d=-1;
		for(i=0; i<this._data.length;i++){
			var line= this._data[i];
			if( dwr.util.getValue($(line[0]+"_chk"))==true){
				d=i;
				break;
			}
		}
		return d;
	},
	/**
	load an inline edit dialog for input only, without more interaction
	*/
	turboScan:function(){
		var url = '/html/nds/object/turboscan.jsp?table='+gc._gridMetadata.tableId;
		/*
		new Ajax.Request(url, {
		  method: 'get',
		  onSuccess: function(transport) {
		  	/*
		  	var ele = Alerts.fireMessageBox(
			{
				width: 800,
				Height:360,
				modal: true,
				closeButton:false,
				title: gMessageHolder.TURBO_SCAN
			});*/
			//ele.innerHTML=transport.responseText;
			//executeLoadedScript(ele);
			/*
			var options=$H({id:"turboscan_div",width:"auto",height:"auto",title:gMessageHolder.gMessageHolder.TURBO_SCAN,padding:0,resize:true,drag:true,lock:true,esc:true,skin:'chrome'});
			//options.content=chkResult.pagecontent;
			art.dialog(options);
			$("so_M_PRODUCT_ID__NAME").focus();
		  }
		});
		*/
		new Ajax.Request(url, {
		  method: 'get',
		  onSuccess: function(transport) {
		  	//var pt=$(tgt);
		    //pt.innerHTML=transport.responseText;
		    //executeLoadedScript(pt);
		    //alert(123);
		    var options=$H({id:"turboscan_div",width:800,height:"auto",title:gMessageHolder.TURBO_SCAN,padding:0,resize:true,drag:true,lock:true,esc:true,skin:'chrome',close:function(){gc.refreshGrid(true);}});
		    options.content=transport.responseText;
		    art.dialog(options);

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
		  	  		var pt=$(tgt);
		    		pt.innerHTML=transport.responseText;
		    		executeLoadedScript(pt);
		  	  	}
		  	//}catch(e){}
		  }
		});
		this._scanCount=0;
		this._okCount=0;
		this._scanError=false;
	},
	/**
	 scan return pressed
	*/
	onScanReturn:function(event){
		if (!event) event = window.event;
		if (!(event && event.keyCode && event.keyCode == 13)) {
			return true;
		}
		var cv= event.target != null ? event.target : event.srcElement;
		if(cv!=null)dwr.util.selectRange(cv, 0, this.MAX_INPUT_LENGTH);
		
		var pdt=$("so_M_PRODUCT_ID__NAME").value;
		if(pdt==""){
			$("so_M_PRODUCT_ID__NAME").focus();
			return false;
		}
		if(!isNaN(pdt)&&parseInt(pdt,10)==0){
			//confirm error
			jQuery("#turboscan_div").css("background-color","white");
			//$("turboscan_div").removeClassName("ts_error");
			this._scanError=false;
			$("so_M_PRODUCT_ID__NAME").value="";
			$("so_M_PRODUCT_ID__NAME").focus();
			return true;
		}
		if(!isNaN(pdt)&&parseInt(pdt,10)==1){
			//add boxno
			try{
				$("so_SHELFNO").value= parseInt($("so_SHELFNO").value,10)+1;
				$("so_M_PRODUCT_ID__NAME").value="";
				$("so_M_PRODUCT_ID__NAME").focus();
				return true;
			}catch(ex){}
		}
		if(this._scanError){
			playAlert();
			return false;
		}
		if(this._isWaitScanResult==true){
			alertScan(gMessageHolder.PROCESS_ING);
			return false;
		}
		this._isWaitScanResult==true;
		var evt={};
		evt.command="TurboScan";
		evt.callbackEvent="TurboScan";
		evt.table= this._gridMetadata.tableId;
		evt.masterTableId=oc._masterObj.table.id;
		evt.masterObjId=oc._masterObj.hiddenInputs.id;
		
		evt["nds.control.ejb.UserTransaction"]="N";//transaction managed by self
		var cols=this._gridMetadata.columns,i,col,v;
		for(i=5;i<cols.length;i++){
			col=cols[i];
			if(col.isUploadWhenCreate){
				v= this._getValue("so_"+ col.name);
				evt[col.name]=v;
			}
		}
		this._executeCommandEvent(evt);		
	},
	_onTurboScan:function(e){
		var chkResult=e.getUserData().data; //data
		this._scanCount++;
		if(chkResult.isok){
			this._okCount++;
			$("ts_qty").innerHTML=String(this._okCount);
			playScan();
		}else{
			this._scanError=true;
			jQuery("#turboscan_div").css("background-color","yellow");
			//$("turboscan_div").addClassName("ts_error");
			playAlert();
		}
		var clsname;
		var sp1 = document.createElement("span");
		sp1.setAttribute("id", "tsrow_"+this._scanCount);
		if(this._scanError){
			clsname="ts_row_err";
		}else{
			if(this._scanCount%5==0) clsname="ts_row5"; 
			else clsname= "ts_row";
		}
		sp1.setAttribute("class",clsname);
		var sp1_content = document.createTextNode((this._scanCount)+": "+chkResult.row);
		sp1.appendChild(sp1_content);
		
		var sp2 = document.getElementById("tsrow_"+(this._scanCount>0?this._scanCount-1:0));
		var parentDiv = sp2.parentNode;
		parentDiv.insertBefore(sp1, sp2);
		if(this._scanCount>30){
			parentDiv.removeChild(document.getElementById("tsrow_"+(this._scanCount-30)));
		}
		this._isWaitScanResult=false;
	},
	/**
	Update main table AM
	*/
	closeTurboScan:function(){
		art.dialog.get("turboscan_div").close();
		//Alerts.killAlert($("turboscan_div"));
		if(this._okCount>0)oc.saveAll();
	},
	/**
	array of selected rows' record id
	*/
	getSelectedRows:function(){
		var i,d=-1;
		var a=new Array();
		var a=[];
		for(i=0; i<this._data.length;i++){
			var line= this._data[i];
			if( dwr.util.getValue($(line[0]+"_chk"))==true){
				a.push(line[4]);
			}
		}
		return a;
	},
	/**
	* Mark selected rows in grid as delete, will save when SaveAll
	*/
	deleteSelected:function(){
		var i,d;
		for(i=this._data.length-1;i>-1 ;i--){
			var line= this._data[i];
			if( dwr.util.getValue($(line[0]+"_chk"))==true){
				d=line[1];
				if("A"==d){
					$( line[0]+"_templaterow" ).remove();
					this._data.splice(i,1);
					/*line[1]="E";
					this._updateGridLineState(line);*/
				}else if(["M","S"].indexOf(d)>-1 ){
					line[1]="D";
					this._updateGridLineState(line);
					this._isDirty=true;
					if(this._currentRow==i){
						this.newLine(false);	
					}
				}
			}
		}
		//
		if( dwr.util.getValue("quick_save")==true)oc.saveAll();
	},
	/**
	 * @return false if discard modification or not dirty
	 */
	checkDirty: function(){
		if(this._isDirty){
        	return !confirm(gMessageHolder.CONFIRM_DISCARD_CHANGE) ;
		}
		return false;
	},
	/**
	 * @return false if current page is new master object
	 */
	checkNew:function(){
		if(oc!=undefined && oc.getObjectId()==-1){
        	alert(gMessageHolder.DENY_AS_NEW_OBJ);
        	return true;
		}
		return false;
	},
	/**
	* export 
	*/
	exportGrid:function(){
		if(this.checkDirty()) return;
		if(this.checkNew()) return;
		showProgressWindow(true);
		var s= Object.toJSON(this._gridQuery);
		var fm= $("export_form");
		$("resulthandler").value=NDS_PATH+"/reports/create_report.jsp";
		$("query_json").value=s;
		fm.submit();
	},
	importGrid:function(){
		if(this.checkDirty()) return;
		if(this.checkNew()) return;
		var l;
		if(this._tableActions.include("A")) l="import_excel.jsp";
		else if( this._tableActions.include("M")) l="update_excel.jsp";
		else{
			alert("Not supported action");
			return;
		}
		var l="/html/nds/objext/"+l+"?objectid="+oc.getObjectId()+"&table="+this._gridMetadata.table+"&fixedcolumns="+encodeURIComponent(this._fixedColumnsStr);
		showDialog(l,800,550,true);
		/*if(Prototype.Browser.IE)
			showDialog(l,800,550,true);
		else
			popup_window(l);*/
		//showDialog("/html/nds/objext/import_excel.jsp?objectid="+oc.getObjectId()+"&table="+this._gridMetadata.table+"&fixedcolumns="+encodeURIComponent(this._fixedColumnsStr),800,550,true);
		//window.location=("/html/nds/objext/import_excel.jsp?objectid="+oc.getObjectId()+"&table="+this._gridMetadata.table+"&fixedcolumns="+encodeURIComponent(this._fixedColumnsStr));
	},
	analyzeGrid:function(){
		showProgressWindow(true);
		var s= Object.toJSON(this._gridQuery);
		var fm= $("export_form");
		$("resulthandler").value=NDS_PATH+"/cxtab/quickview.jsp"; 
		$("query_json").value=s;
		fm.submit();
	},
	/**
	* create query request and execute query
	@param bSkipDirtyCheck if true, do not check dirty, default to false
	*/
	refreshGrid : function (bSkipDirtyCheck) {
		//if(this.checkNew()) return;
		if(arguments.length==1 && arguments[0]==true){
			this._executeQuery(this._gridQuery);
		}else{
			if(this.checkDirty()==false)
				this._executeQuery(this._gridQuery);
		}
	},


	/**
	* Construct an array which contains only part of array cells, the
	  part is specified by indices
	  @param dataRow row of data
	* @param line one row in this._data
	* @param indices int[] meta.getCreationColumns() or meta.getModifyColumns()
	* @return Array object, which elements from columns of grid
	*  specified by indices
	*/
	_getArrayOfRow: function (dataRow , line, indices) {
		var i,v;
		var obj=new Array();
		obj.push(dataRow);
		for(i=0;i<indices.length;i++){
			v=line[indices[i]];
			if(v==undefined) v=null;
			obj.push(v);
		}
		//debug(obj);
		return obj;
	},
	/***
	* Invoke by buttons, include btn_begin,btn_next,btn_prev,btn_end
	@param t id of the button
	*/
	scrollPage: function (t) {
		//var t=event.target.id;
		if(this.checkDirty()) return;
		if(this.checkNew()) return;
		
		var s;
		var qr=Object.clone(this._gridQuery);
		var qs=qr.start;
		var qrange=parseInt( $("range_select").value,10);
		var qtot=qr.totalRowCount;
		if(t=="begin_btn")s=0;
		else if(t=="prev_btn"){ if (qs-qrange<0){s=0;}else{s=qs-qrange;}}
		else if(t=="next_btn") { if (qs+qrange>qtot){return;}else{s=qs+qrange;}}
		else if(t=="end_btn") s= qtot-qrange;
		else s= qs;
		
		qr.start=s;
		qr.range=qrange;
		this._gridQuery.range=qrange;
		this._executeQuery(qr);
	},
	/**
	 * Reorder grid query
	 * @param columnId the column id that will be ordered by, if the same as old
	 * order by column, will toggle asc and desc, else do asc 
	 */
	orderGrid2: function(clinkid,event){
		if(this.checkNew()) return;
		if(this.checkDirty()==false){
			if (!event) event = window.event;
			if(this._gridQuery.orders==null)this._gridQuery.orders=[];
			var orders=this._gridQuery.orders;
			var i,bFound=false;
			if(event.ctrlKey||event.altKey || event.shiftKey){
				//more orders
				for(i=0;i<orders.length;i++){
					if(	orders[i].c==clinkid){
						//reverse it
						orders[i].t=(orders[i].t==false?true:false);
						bFound=true;
						break;
					}
				}
				if(!bFound){
					orders.push({c:clinkid,t:true});
				}				
			}else{
				//single order
				var od;
				for(i=0;i<orders.length;i++){
					if(	orders[i].c==clinkid){
						//reverse it
						od= Object.clone(orders[i]);
						od.t=(od.t==false?true:false);
						bFound=true;
						break;
					}
				}
				if(!bFound){
					od=({c:clinkid,t:true});
				}
				this._gridQuery.orders=new Array(od);	
			}
			this._executeQuery(this._gridQuery);
		}
	},
	_executeQuery: function (queryObj) {
		if(this._orig_startidx==-1 && queryObj.start>=0 && (queryObj.start+queryObj.range>=queryObj.totalRowCount)){
			//always move to last page if reach end
			this._gridQuery.start=-1;
		}
		var s= Object.toJSON(queryObj);
		Controller.query(s, function(r){
				//try{
					$("timeoutBox").style.visibility = 'hidden';
					var result= r.evalJSON();
					if (result.code !=0 ){
						msgbox(result.message);
					}else {
						var evt=new BiEvent(result.callbackEvent);
						evt.setUserData(result);
						application.dispatchEvent(evt);
					}
				/*}catch(ex){
					msgbox(ex.message);
				}*/
		  	}		
		);
	},
	/**
	* Request server handle command event
	* @param evt CommandEvent
	*/
	_executeCommandEvent :function (evt) {
		showProgressWindow(true);
		Controller.handle( Object.toJSON(evt), function(r){
				//try{
					$("timeoutBox").style.visibility = 'hidden';
					var result= r.evalJSON();
					if (result.code !=0 ){
						msgbox(result.message);
					}else {
						var evt=new BiEvent(result.callbackEvent);
						evt.setUserData(result);
						application.dispatchEvent(evt);
					}
				/*}catch(ex){
					msgbox(ex.message);
				}*/
			
		});
	},
	
	/**
	 * @return false if inline object panel contains invalid data
	 */
	_checkObjectInput: function(){
		var cols=this._gridMetadata.columns,i,col, d;
		var blank,ele,d;
		for(i=4;i< cols.length;i++){
			col= cols[i];
			if(col.isVisible && ( this._currentRow==-1? col.isUploadWhenCreate:col.isUploadWhenModify )){
				ele=$("eo_"+ col.name);
				if(ele==null )continue;
				if(!ele.disabled && this._checkInput(col,ele)==false) return false;
			}
		}
		return true;
	},
	/**
	 * @return false if grid panel contains invalid data
	 */
	checkInputs:function(){
		var cols=this._gridMetadata.columns,i,col, d;
		for(i=4;i< cols.length;i++){
			col= cols[i];
			if(col.isVisible &&  col.isUploadWhenCreate && col.isUploadWhenModify ){
				//columns that modified in list will be checked
				for(l=0;l< this._data.length;l++){
					var line= this._data[l];	
					//if(!this._checkInputData(col, line[i], l+1)) return false;
					if(line[1]=="D")continue;
					if(!this._checkInputData(col, line[i], l+1)) {
						//alert(Object.toJSON(line));
						return false;
					}
				}
			}
		}
		return true;
	},
	/**
	 * @param col GridColumn
	 * @param d data of input
	 * @param lineNo line no start from 1
	 * @return false if contains invalid data
	 */
	_checkInputData: function(col,d,lineNo){
		var blank=(d==null || (String(d)).blank());
		if(!col.isNullable &&  (blank || (col.isValueLimited && d=="0") )){
			msgbox( gMessageHolder.EXCEPTION+"("+gMessageHolder.LINE+":"+lineNo+"):"+col.description+ gMessageHolder.CAN_NOT_BE_NULL);
			return false;
		}
		if(!col.isValueLimited && !blank ){
			if(col.type==Column.NUMBER && isNaN(d,10)){
				msgbox( gMessageHolder.EXCEPTION+"("+gMessageHolder.LINE+":"+lineNo+"):"+col.description+ gMessageHolder.MUST_BE_NUMBER_TYPE);
				return false;
			}else if((col.type==Column.DATE || col.type==Column.DATENUMBER) && !isValidDate(d) ){
				msgbox( gMessageHolder.EXCEPTION+"("+gMessageHolder.LINE+":"+lineNo+"):"+col.description+ gMessageHolder.MUST_BE_DATE_TYPE);
				return false;
			}
		}
		return true;
	},
	/**
	 * @param col GridColumn
	 * @param ele Element for input
	 * @return false if contains invalid data
	 */
	_checkInput: function(col,ele){
		var d=String(dwr.util.getValue( ele));
		var blank=(String(d)).blank();
		if(!col.isNullable &&  (blank || (col.isValueLimited && d=="0") )){
			msgbox( col.description+ gMessageHolder.CAN_NOT_BE_NULL);
			dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
			return false;
		}
		if(!col.isValueLimited && !blank ){
			if(col.type==Column.NUMBER && isNaN(d,10)){
				msgbox( col.description+ gMessageHolder.MUST_BE_NUMBER_TYPE);
				dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
				return false;
			}else if((col.type==Column.DATE || col.type==Column.DATENUMBER) && !isValidDate(d) ){
				msgbox( col.description+ gMessageHolder.MUST_BE_DATE_TYPE);
				dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
				return false;
			}
		}
		return true;
	},
	/**
	 * Check line validity, call product attribute form if nessisary and store to grid
	 * @param can has one argument for current event
	 */
	saveLine:function(){
		if( this._tableActions.indexOf("A")<0 && this._currentRow==-1 ){
			msgbox(gMessageHolder.NO_PERMISSION);
			return;
		}
		if( this._tableActions.indexOf("M")<0 && this._currentRow>-1 ){
			msgbox(gMessageHolder.NO_PERMISSION);
			return;
		}
		var e=null;
		if( arguments.length==0 ) e=window.event;
		else e= arguments[0];
		if(e!=null) e = e.target != null ? e.target : e.srcElement;
		
		// check input validity
		if(this._checkObjectInput()==false) return;
		var chkProductAttribute=$("check_product_attribute");
		var chkMaterialAttribute=$("check_material_attribute");
		
		//add by robin 20121009 物料 判断
		if(chkMaterialAttribute&&-1!=this._getPositionInData("Y_MATERIALALIAS_ID__NO")){
			
			var mtlValue=String($("eo_"+chkMaterialAttribute.value).value);
			if(chkMaterialAttribute!=null&&chkMaterialAttribute.checked&&!mtlValue.blank()){
				var evt={};
				evt.command="cn.com.burgeon.command.CheckMaterialAttribute";
				evt.callbackEvent="CheckMaterialAttribut";
				evt["nds.control.ejb.UserTransaction"]="N";
				evt.material=mtlValue;
				evt.fixedColumns=this._fixedColumns;
				if(typeof(oc)!="undefined" && oc!=null){
					evt.masterObjId=oc._masterObj.hiddenInputs.id;
					var storeInfo=oc.getStoreInfo2();
					evt.store_colId=storeInfo.c_store_meterialId;
					evt.storedata=storeInfo.c_store_meterial_data;
				}
				var qtyCol=jQuery.trim(this._getValue("bind_alias_qty_col"));
				
				evt.aliasQtyColumn=qtyCol?qtyCol:"QTY";
				evt.tableId=this._gridMetadata.tableId;
				if(this._currentRow!=-1 && this._data[this._currentRow][1]!="A") evt.trymatrix=false;
				this._executeCommandEvent(evt);
			}else{
				this._saveLineToGrid(null,e);
			}
		}else 
		if(chkProductAttribute){ 
			var pdtValue=String($("eo_"+chkProductAttribute.value).value);
			if(chkProductAttribute!=null && chkProductAttribute.checked && !pdtValue.blank() 
					&& ( $("eo_"+chkProductAttribute.name)==null || 
					( $("eo_"+chkProductAttribute.name)!=null&& String($("eo_"+chkProductAttribute.name).value).blank() ) )
				){
				// check matrix first
				var evt={};
				evt.command="CheckProductAttribute";
				evt.callbackEvent="CheckProductAttribute";
				evt["nds.control.ejb.UserTransaction"]="N";
				evt.product=pdtValue;
				evt.fixedColumns=this._fixedColumns;
				evt.tableId=this._gridMetadata.tableId;
				if(typeof(oc)!="undefined" && oc!=null){
					var storeInfo=oc.getStoreInfo();
					if(storeInfo!=null){
						evt.store_colId=storeInfo.c_store_product_id;
						evt.storedata=storeInfo.c_store_product_data;
						evt.dest_colId=storeInfo.c_dest_product_id;
						evt.destdata=storeInfo.c_dest_product_data;
					}
				}
				if(this._currentRow!=-1 && this._data[this._currentRow][1]!="A") evt.trymatrix=false;
				this._executeCommandEvent(evt);
			}else{
				this._saveLineToGrid(null,e);
			}	
		}else{
			this._saveLineToGrid(null,e);
		}
	},
	/**Copied from dwr.util.onReturn, I need event be transfered 
	 * Enables you to react to return being pressed in an input
	 */
	onLineReturn : function(event, action) {
	  if (!event) event = window.event;
	  if (event && event.keyCode && event.keyCode == 13) {
	  	// is the src in div of inc-edit-line
	  	if(!(event.ctrlKey||event.altKey || event.shiftKey)){
		  	var sc=(Prototype.Browser.IE?event.srcElement:event.target);
	  		if(sc!=null && $(sc).descendantOf("inc-edit-line"))
		  		action(event);
	  	}
	  }
	},
	/**
	 * Convert enter to tab key, attached to onKeyDown event
	 * @param event key event
	 * @param nextInputId next input id, so when enter pressed, go to next input
	 * @return false to cancel that key
	 */
	onMatrixKey: function(event,row,cell){
		 //var r=/^[0-9]*[1-9][0-9]*$/;
		 var val=$("modify_table_product").rows[row+1].cells[cell+1].getElementsByTagName("input");
		 if(event.keyCode==37||event.keyCode==38||event.keyCode==39||event.keyCode==40||event.keyCode==13){
		 	var inputvale=val[0].value;
		 	inputvale=inputvale.replace(/^\s+/,'').replace(/\s+$/,'');
			if(inputvale!=""&&!this._regexp_integer.test(inputvale)){
				//alert(gMessageHolder.NOT_INTEGER);
				dwr.util.selectRange(val[0],0,this.MAX_INPUT_LENGTH);
				return false;
			}
		}
		/*var temp=null;
		var temp_input=null;
		var sum=0;
		temp_input=$("modify_table_product").rows[row+1].getElementsByTagName("input");
		for(var j=0;j<temp_input.length;j++){
			if(temp_input[j].value!="")
			sum+=parseInt(temp_input[j].value);
		}
	    $("tot_"+row).innerHTML=sum;
	    sum=0;
	    var temp_value;
	    for(j=1;j<$("modify_table_product").rows.length;j++){
	    	temp_value=$("modify_table_product").rows[j].cells[$("modify_table_product").rows[row].cells.length-1].innerHTML;
	    	if(temp_value==""){
	    		temp_value=0;
	    	}
	    	sum+=parseInt(temp_value);
	    }
	    $("tot_product").innerHTML=sum;*/
		if(event.keyCode==37){ //left
			for(var i=cell;i>=1;i--){
				var temp=$("modify_table_product").rows[row+1].cells[i].innerHTML;
				if(temp!=""){
					temp_input=$("modify_table_product").rows[row+1].cells[i].getElementsByTagName("input");
					var input_ele=temp_input[0].id;
					dwr.util.selectRange(input_ele,0,this.MAX_INPUT_LENGTH);
					break;
				}
			}	
		}else if(event.keyCode==38){ //up
			for(var i=row;i>=1;i--){
				var temp=$("modify_table_product").rows[i].cells[cell+1].innerHTML;
				if(temp!=""){
					temp_input=$("modify_table_product").rows[i].cells[cell+1].getElementsByTagName("input");
					var input_ele=temp_input[0].id;
					temp_input[0].focus();
					dwr.util.selectRange(input_ele,0,this.MAX_INPUT_LENGTH);
					break;
				}
			}	
		}else if(event.keyCode==39){//right	
		  for(var i=cell+2;i<$("modify_table_product").rows[row].cells.length-1;i++){
				var temp=$("modify_table_product").rows[row+1].cells[i].innerHTML;
				if(temp!=""){
					temp_input=$("modify_table_product").rows[row+1].cells[i].getElementsByTagName("input");
					var input_ele=temp_input[0].id;
					dwr.util.selectRange(input_ele,0,this.MAX_INPUT_LENGTH);
					break;
				}
			}
		}else if(event.keyCode==40){//down
			for(var i=row+2;i<$("modify_table_product").rows.length;i++){
				var temp=$("modify_table_product").rows[i].cells[cell+1].innerHTML;
				if(temp!=""){
					temp_input=$("modify_table_product").rows[i].cells[cell+1].getElementsByTagName("input");
					var input_ele=temp_input[0].id;
					temp_input[0].focus();
					dwr.util.selectRange(input_ele,0,this.MAX_INPUT_LENGTH);
					break;
				}
			}
		}else if(event.keyCode==13){//enter
			if(Prototype.Browser.IE){	
				event.cancelBubble = true;
				event.returnValue = false;
			}else{
				event.stopPropagation();
				event.preventDefault();
			}
			if(event.ctrlKey||event.altKey || event.shiftKey){
				return gc.saveItemDetail();
			}else{
				var nTabIdx=val[0].tabIndex+1;
				var ne=$("modify_table_product").getElementsBySelector("input[tabindex='"+nTabIdx+"']");
				if(ne==null || ne.length==0){
					return gc.saveItemDetail();
				}else{
					ne[0].focus();
					dwr.util.selectRange(ne[0], 0, this.MAX_INPUT_LENGTH);	
				}
			}
		}else if( event.keyCode==27){//escape
			//Alerts.killAlert($("itemdetail_div"));
			art.dialog.get("art_itemdetail_div").close();
			var chkProductAttribute=$("check_product_attribute");
			if(chkProductAttribute!=null && $("eo_"+chkProductAttribute.value)!=null){
				dwr.util.selectRange($("eo_"+chkProductAttribute.value),0,this.MAX_INPUT_LENGTH);
			}
			 
		}	
		return true;
		
	},
	
	oncellchange: function(row,cell){
		var flag=false;
		var val=$("modify_table_product").rows[row+1].cells[cell+1].getElementsByTagName("input");
		var inputvale=val[0].value;
		inputvale=inputvale.replace(/^\s+/,'').replace(/\s+$/,'');
		if(inputvale!=""&&!this._regexp_integer.test(inputvale)){
			alert(gMessageHolder.NOT_INTEGER);
			val[0].value="";
			/*var inputele=val[0].id;
			dwr.util.selectRange(val[0],0,this.MAX_INPUT_LENGTH);
			if(Prototype.Browser.IE){	
				event.cancelBubble = true;
				event.returnValue = false;
			}else{
				event.returnValue = false;
				event.stopPropagation();
				event.preventDefault();
			}*/
			
		}else{
			flag=true;
		}
		if(flag){
			var temp=null;
			var temp_input=null;
			var sum=0;
			temp_input=$("modify_table_product").rows[row+1].getElementsByTagName("input");
			for(var j=0;j<temp_input.length;j++){
				if(temp_input[j].value!="")
				sum+=parseInt(temp_input[j].value);
			}
		    $("tot_"+row).innerHTML=sum;
		    sum=0;
		    var temp_value;
		    for(j=1;j<$("modify_table_product").rows.length;j++){
		    	temp_value=$("modify_table_product").rows[j].cells[$("modify_table_product").rows[row].cells.length-1].innerHTML;
		    	if(temp_value==""||temp_value=="&nbsp;"){
		    		temp_value=0;
		    	}
		    	sum+=parseInt(temp_value);
		    }
		    $("tot_product").innerHTML=sum;
		 }
		 return flag;
	},
	/**
	* Clear item detail inputs 
	*
	*/
	clearItemDetailInputs:function(){
		var eles=$("itemdetail_form").getInputs("text");
		for(i=0;i<eles.length;i++){
			ele=eles[i];
			dwr.util.setValue(ele, "");
		}
		for(j=1;j<$("modify_table_product").rows.length;j++){
			$("modify_table_product").rows[j].cells[$("modify_table_product").rows[0].cells.length-1].innerHTML="";
		}	
		$("tot_product").innerHTML="";
	},
	/**Save itemdetail_form inputs, this is matrix
	*  json format [[attribute1, value1],[attribute2, value2],..], array of array of 2 elements pair
	   attribute set instance id will have id as "A"+id, value should be number for all
	   return false if error found
	*/
	saveItemDetail:function(){
		var a=new Array(),i,ele,v,d;
		v=dwr.util.getValue("itemdetail_defaultvalue");
		var dfValue=0;
		//var r=/^[0-9]*[1-9][0-9]*$/;
		var bNotCreateForNull= dwr.util.getValue("itemdetail_notnull");
		if(!v.blank() && !bNotCreateForNull){
			dfValue=parseInt(v,10);
			if(isNaN(dfValue)){
				msgbox(gMessageHolder.MUST_BE_NUMBER_TYPE);
				dwr.util.selectRange("itemdetail_defaultvalue", 0, this.MAX_INPUT_LENGTH);
				return false;
			}
		}
		var asum=0;
		var eles=$("itemdetail_form").getInputs("text");
		for(i=0;i<eles.length;i++){
			ele=eles[i];
			if(String(ele.value).blank()) v= dfValue;
			else{
				if(ele.value!=""&&!this._regexp_integer.test(ele.value)){
					msgbox(gMessageHolder.NOT_INTEGER);
					dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
					return false;
				}
				v=parseInt(ele.value,10);
			}
			if(v!=0){
				a.push([ ele.id, v]); 
				asum+=v;
			}
		}
		//if(a.length==0) a="";
		//Alerts.killAlert($("itemdetail_div"));
		art.dialog.get("art_itemdetail_div").close();
		var chkResult = this._tmpData;
		if(chkResult==null) chkResult={};
		chkResult.asi_objs=a;
		chkResult.asi_sum=asum;
		var chkProductAttribute=$("check_product_attribute");
		var pdt=$("eo_"+chkProductAttribute.value);
		this._saveLineToGrid(chkResult,pdt);
		this._tmpData=null;
		ScrollableTable._matchFixedHead();
		return true;
	},
	getLastFocusElement:function(){
		return this._lastFocusElement;
	},
	/**
	 * Update line to grid, and wait for upload to server, if currentRow is -1, then a new row created
	 * else update data and grid line of that row
	 * 	 * 
	 *edit by robin 20121022 :add check_material_attribute 
	 *
	 * @param chkResult if not null will contain attributes:
		 * 		product_id: id of the product, set when code!=0
		 * 		product_name: name of the product, set when code!=0
		 * 		product_value: value of the product
		 * 		product_asi_id: attribute set instance id of the product
		 * 		product_asi_name: attribute set instance name of the product
		 * 		asi_objs: json object that contains attributeset instance selection and qty
		 *                like: [["A133",12],["A134",1]] first element is asi_id, second is qty
		 * 		asi_sum: total qty of asi selection, will replace input one
		 @param focusInput if not null, will set focus and select that input element
	 */
	_saveLineToGrid : function (chkResult, focusInput) {
		if(focusInput!=null){
			dwr.util.selectRange(focusInput,0,this.MAX_INPUT_LENGTH);
			this._lastFocusElement= focusInput;
		}
		var line; // array
		var cols=this._gridMetadata.columns,i,col,v;
		// update asi_sum to first column that contains name "QTY"
		if(chkResult!=null && chkResult.asi_sum!=undefined){
			if(chkResult.asi_sum==0){
				alert(gMessageHolder.PRODUCT_NMNER_ZORE);
				return;
			}						
			for(i=5;i<cols.length;i++){
				col=cols[i];
				if((col.isUploadWhenCreate || col.isUploadWhenModify) && col.name.indexOf("QTY")>=0 ){
					 dwr.util.setValue("eo_"+ col.name, chkResult.asi_sum);
					 break;
				}
			}
		}
		// add from line input
		if(this._currentRow==-1){
			line=["A"+this._getNextRowId(), "A",null,null,-1];
			for(i=5;i<cols.length;i++){
				col=cols[i];
				if(col.isUploadWhenCreate) v= this._getValue("eo_"+ col.name);
				else v=null;
				line.push(v);
			}
		}else{// existing row in grid, can also be a new line
			line= this._data[this._currentRow];
			if(line[4]!=-1) line[1]="M";
			line[2]=line[3]=null;
			for(i=5;i<cols.length;i++){
				col=cols[i];
				if( (line[4]==-1?col.isUploadWhenCreate:col.isUploadWhenModify)) line[i]= this._getValue("eo_"+ col.name);
				//else line[i]=null; remain unchanged
			}
		}
		if(chkResult!=null ){
			line[3]=chkResult.asi_objs;
			var ele=$("check_product_attribute");
			var ele2=$("check_material_attribute");
			if(ele2!=null&&dwr.util.getValue(ele2)==true){
				if(chkResult.aliasId!=null){
					i=this._getPositionInData("Y_MATERIALALIAS_ID__ID");
					if(i!=-1)line[i]=chkResult.aliasId;
					i=this._getPositionInData("Y_MATERIALALIAS_ID__NO");
					if(i!=-1)line[i]=chkResult.aliasNo;
					i=this._getPositionInData("Y_MATERIAL_ID__ID");
					if(i!=-1)line[i]=chkResult.materialId;
					i=this._getPositionInData("Y_MATERIAL_ID__CODE");
					if(i!=-1)line[i]=chkResult.materialCode;
					i=this._getPositionInData("Y_MATERIAL_ID;CODE");
					if(i!=-1)line[i]=chkResult.materialCode;
					i=this._getPositionInData("Y_MATERIAL_ID;NAME");
					if(i!=-1)line[i]=chkResult.materialName;
					i=this._getPositionInData("Y_MATERIAL_ID;KEY_WORD");
					if(i!=-1)line[i]=chkResult.materialName;
					i=this._getPositionInData("Y_COLOR_ID__CODE");
					if(i!=-1)line[i]=chkResult.colorCode;
					i=this._getPositionInData("Y_SPEC_ID__CODE");
					if(i!=-1)line[i]=chkResult.specCode;
					i=this._getPositionInData("Y_COLOR_ID;CODE");
					if(i!=-1)line[i]=chkResult.colorCode;
					i=this._getPositionInData("Y_SPEC_ID;CODE");
					if(i!=-1)line[i]=chkResult.specCode;
					
				}
			}
			if (ele!=null && dwr.util.getValue(ele)==true){
			/*
				 * 		product_id: id of the product, set when code!=0
				 * 		product_name: name of the product, set when code!=0
				 * 		product_value: value of the product
				 * 		product_asi_id: attribute set instance id of the product
				 * 		product_asi_name: attribute set instance name of the product
			 */		
		 		if(chkResult.product_id!=null){
			 		i= this._getPositionInData("M_PRODUCT_ID__ID");
			 		if(i!=-1) line[i]= chkResult.product_id;
			 		i= this._getPositionInData("M_PRODUCT_ID__NAME");
			 		if(i!=-1) line[i]= chkResult.product_name;
			 		i= this._getPositionInData("M_PRODUCT_ID;VALUE");
			 		if(i!=-1) line[i]= chkResult.product_value;
			 		i= this._getPositionInData("M_ATTRIBUTESETINSTANCE_ID__ID");
			 		if(i!=-1) line[i]= chkResult.product_asi_id;
			 		i= this._getPositionInData("M_ATTRIBUTESETINSTANCE_ID__DESCRIPTION");
			 		if(i!=-1) line[i]= chkResult.product_asi_name;
			 		i= this._getPositionInData("M_PRODUCT_ID;PRICELIST");
			 		if(i!=-1) line[i]= chkResult.product_pricelist;
			 		i= this._getPositionInData("M_ATTRIBUTESETINSTANCE_ID;VALUE1");
			 		if(i!=-1) line[i]= chkResult.product_value1; 
			 		i= this._getPositionInData("M_ATTRIBUTESETINSTANCE_ID;VALUE2");
			 		if(i!=-1) line[i]= chkResult.product_value2;
			 		i= this._getPositionInData("M_ATTRIBUTESETINSTANCE_ID;VALUE1_CODE");
			 		if(i!=-1) line[i]= chkResult.product_value1_code; 
			 		i= this._getPositionInData("M_ATTRIBUTESETINSTANCE_ID;VALUE2_CODE");
			 		if(i!=-1) line[i]= chkResult.product_value2_code;
		 		}
			}
		}
		// check line no for add/update action
		if(this._currentRow==-1){
			this._data.push(line);
	//		this._currentRow= this._data.length-1;
			this._insertGridLine(this._data.length-1,true);
			if( dwr.util.getValue("clear_after_insert")==true) this.newLine(false);
		}else{
			this._updateGridLine(this._currentRow);
		}
		// following line is to sync selection, but will lower down speed 
		//this._gridTable.clearSelection();
		//this._gridTable.setItemSelected($(line[0]+"_templaterow"), true);
		this._isDirty=true;
		if( dwr.util.getValue("quick_save")==true)oc.saveAll();
	} ,
	/**
	  @param colName column name in this._gridMetadata
	* @return column index in this._data, -1 if not found
	*/
	_getPositionInData : function(colName){
		var cols=this._gridMetadata.columns,i;
		for(i=0;i<cols.length;i++){
			if(cols[i].name==colName) return i;
		}
		return -1;
	},
	/**
	 @param colId - column id
	 @param inputId - input text id
	*/
	showUploadDlg:function(colId,inputId){
		if(this._currentRow==-1 ){
			alert(gMessageHolder.PLS_INPUT_URL);
			return;
		}
		var objectId= this._data[this._currentRow][4];
		if(objectId==-1){
			alert(gMessageHolder.PLS_INPUT_URL);
			return;
		}	
		var tableId=this._gridMetadata.tableId;
		showDialog("/html/nds/objext/upload.jsp?table="+tableId+"&column="+
			colId+"&objectid="+objectId+"&input="+inputId,940, 400,false,true);
	},
	_updateGridLine: function(row){
		var cols=this._gridMetadata.columns,i,col;
		var line= this._data[row];
		if(line[1]=="E"){
			$( line[0]+"_templaterow" ).remove();
			this._data.splice(row,1);
			return;
		}
		//update grid line
		$( line[0]+"_row" ).innerHTML="<input type='checkbox' id='"+ line[0] +"_chk' value='Y' class='cbx' /><a href='javascript:gc.editLine(\""+line[0]+"\")'>"+ (row+1+this._gridQuery.start)+"</a>";
		$( line[0]+"_state__" ).innerHTML="";
		$( line[0]+"_errmsg" ).innerHTML=(line[2]==null?"":"<a class='helpLink' onclick='showHelpTip(event, gc._data["+row+"][2], false); return false' href='javascript:void(0);'><img src='/html/nds/images/alert.gif' border='0'/></a>");
		var jsonhtml="";
		if(line[3]==null){
			if(this._supportAttributeDetail && this._data[row][1]=="A")
				jsonhtml="<a href='javascript:gc.loadJsonObj("+row+")'><img src='/html/nds/images/detail.gif' border='0'/></a>";
		}else if(line[3]!=""){
			jsonhtml="<a href='javascript:gc.showJsonObj("+row+")'><img src='/html/nds/images/detail.gif' border='0'/></a>";
		}
		$( line[0]+"_jsonobj" ).innerHTML=jsonhtml;
		var canModify=(this._tableActions.indexOf("M")>=0);
		var ele; var escapeHTMLOption={escapeHtml:true}; var opt;
		for(i=4;i< cols.length;i++){
			col= cols[i];
			if(col.isVisible){
				if(col.dsptype > 5 && col.dsptype<12){
					//allow html for these one	
					opt={};
				}else{
					opt=escapeHTMLOption;//escape html, so no html can be written to html
				}
				// for image and url, convert to href
				if( (col.dsptype==8 || col.dsptype==9) && line[i]!=null && !line[i].blank()){
					this._setValue(line[0]+"_"+ col.name,"<a href='"+line[i]+"'>"+gMessageHolder.VIEW_ATTACH+"</a>",opt );
				}else
					if(this._wrow!=undefined&&this._wrow[row]!==undefined&&this._wrow[row]!==null&&this._wrow[row].type=="readrow"){
					this._setValue(line[0]+"_"+ col.name,line[i],opt,true);
					}else if (this._wrow!=undefined&&this._wrow[row]!==undefined&&this._wrow[row]!==null&&this._wrow[row].type=="readcol") {
						var rcol=this._wrow[row].col;
						if(rcol.indexOf(col.columnId)>=0){
						this._setValue(line[0]+"_"+ col.name,line[i],opt,true);
						}else{
						this._setValue(line[0]+"_"+ col.name,line[i],opt);
						}
					}else{
					this._setValue(line[0]+"_"+ col.name,line[i],opt);
					}

				//this._setValue(line[0]+"_"+ col.name,line[i],opt );
				if(col.objIdPos!=-1 && col.rTableId!=-1){
					if(line[col.objIdPos]!=null){
						ele=$(line[0]+"_"+ col.name+"_url");
						if(ele!=null)ele.innerHTML='<a href="javascript:gc.fk('+
							col.rTableId+','+line[col.objIdPos]+
							')"><img border="0" src="/html/nds/images/out.png"/></a>';
					}
					if(canModify && col.fkQueryURL!=null){
						ele=$(line[0]+"_"+ col.name+"_find");
						if(ele!=null)ele.innerHTML='<a href="javascript:'+
							col.fkQueryURL.replace(/@ACCEPTER@/gi,line[0]+"_"+ col.name)+
							'"><img border="0" src="/html/nds/images/find.gif"/></a>';
					}
				}
			}
		}
		this._updateGridLineState(line);
	},
	/**
	 show find button
	*/
	fkfocus:function(e){
		var r= this._getCurrentPositionInData(e);
		var line=this._data[r.row];
		var col=this._gridMetadata.columns[r.column];
		
		if(this._lastFocusedFKElement!=null){
			//hide last focused fk element
			if(!this._lastFocusedFKElement.hasClassName("hide"));	
				this._lastFocusedFKElement.addClassName("hide");
		}
		var ele=$(line[0]+"_"+ col.name+"_find");
		ele.removeClassName("hide");
		this._lastFocusedFKElement=ele;
		
	},
	/**
	hide find button
	*/
	fkblur:function(e){
	},
	/**
	 * Show json object, will request server send back screen
	 * @param row the row in this._data
	 */
	showJsonObj: function(row){
		this.editRow(row);
		var line= this._data[row];
		if(["D","E","N"].indexOf(line[1])>-1) return;
		var pdtValue, pdtColIndex;
		pdtColIndex = this._findColumnByName("M_PRODUCT_ID__NAME");
		if(pdtColIndex <0) return;
		pdtValue= this._data[row][pdtColIndex];
		var evt={};
		if(typeof(oc)!="undefined" && oc!=null){
			var storeInfo=oc.getStoreInfo();
			if(storeInfo!=null){
				evt.store_colId=storeInfo.c_store_product_id;
				evt.storedata=storeInfo.c_store_product_data;
				evt.dest_colId=storeInfo.c_dest_product_id;
				evt.destdata=storeInfo.c_dest_product_data;
			}
		}
		evt.command="CheckProductAttribute";
		evt.callbackEvent="ShowProductAttribute";
		evt["nds.control.ejb.UserTransaction"]="N";
		evt.product=pdtValue;
		evt.tableId=this._gridMetadata.tableId;
		evt.tag= row; // will return unchanged
		this._executeCommandEvent(evt);
	},
	/**
	 * Try load json obj from server for specified row
	 */
	loadJsonObj: function(row){
		var evt={};
		evt.command="LoadProductAttribute";
		evt.callbackEvent="ShowProductAttribute";
		evt.tableId=this._gridMetadata.tableId;
		evt.recordId= this._data[row][4];
		evt.tag= row; // will return unchanged
		this._executeCommandEvent(evt);
	},
	/**
	 * handle product attribute information.
	 * returned data should contained 3 segments:1 is script, 2 is dom, 3 is other scripts
	 */
	_checkProductAttribute:function(e){
		var chkResult=e.getUserData().data; // data
		var chkProductAttribute=$("check_product_attribute");
		var pdt=$("eo_"+chkProductAttribute.value);
		if(chkResult.code!=0){
			alertScan(chkResult.message);
			pdt.focus();
			dwr.util.selectRange(pdt, 0, this.MAX_INPUT_LENGTH);			
		}else{
			if(chkResult.showDialog){
				/*
				var ele = Alerts.fireMessageBox(
				{
					width: 800,
					Height:360,
					modal: true,
					title: gMessageHolder.SET_PRODUCT_ATTRIBUTE
				});
				ele.innerHTML=chkResult.pagecontent;
				executeLoadedScript(ele);
				*/
				var options=$H({id:"art_itemdetail_div",title:gMessageHolder.SET_PRODUCT_ATTRIBUTE,padding:0,resize:true,drag:true,lock:true,esc:true,skin:'chrome'});
				options.content=chkResult.pagecontent;
				//var throughBox = art.dialog.through;
				//options.init=function(){try{$("itemdetail_form").focusFirstElement();}catch(e){}};
				//throughBox(options);
				art.dialog(options);
				if(this._currentRow!=-1){
					var jo= this._data[this._currentRow][3]; // array, each elements is array of eleId and value
					var i;
					if(jo!=null)for(i=0;i< jo.length;i++){
						this._setValue( jo[i][0], jo[i][1]);
					}				
				}
				try{$("itemdetail_form").focusFirstElement();}catch(e){}
				this._tmpData=chkResult;
			}else{
				this._saveLineToGrid(chkResult,pdt);
			}
		}
	},	
	_checkMaterialAttribute:function(e){
		var chkResult=e.getUserData().data; // data
		var chkMtlAttribute=$("check_material_attribute");
		var mtl=$("eo_"+chkMtlAttribute.value);
		if(chkResult.code!=0){
			alertScan(chkResult.message);
			mtl.focus();
			dwr.util.selectRange(mtl, 0, this.MAX_INPUT_LENGTH);			
		}else{
			if(chkResult.showDialog){
				/*
				var ele = Alerts.fireMessageBox(
				{
					width: 800,
					Height:360,
					modal: true,
					title: gMessageHolder.SET_PRODUCT_ATTRIBUTE
				});
				ele.innerHTML=chkResult.pagecontent;
				executeLoadedScript(ele);
				*/
				/*
				var ele = Alerts.fireMessageBox(
				{
					width: 800,
					Height:360,
					modal: true,
					title: gMessageHolder.SET_PRODUCT_ATTRIBUTE
				});
				ele.innerHTML=chkResult.pagecontent;
				executeLoadedScript(ele);
				*/
				var options=$H({id:"art_itemdetail_div",width:"auto",height:"auto",title:gMessageHolder.SET_PRODUCT_ATTRIBUTE,padding:0,resize:true,drag:true,lock:true,esc:true,skin:'chrome'});
				options.content=chkResult.pagecontent;
				art.dialog(options);				
				if(this._currentRow!=-1){
					var jo= this._data[this._currentRow][3]; // array, each elements is array of eleId and value
					var i;
					if(jo!=null)for(i=0;i< jo.length;i++){
						this._setValue( jo[i][0], jo[i][1]);
					}				
				}
				try{$("itemdetail_form").focusFirstElement();}catch(e){}
				this._tmpData=chkResult;
			}else{
				this._saveLineToGrid(chkResult,mtl);
			}
		}
	},
	/**
	 * set product attribute information with locale json 
	 * returned data should contained 3 segments:1 is script, 2 is dom, 3 is other scripts
	 */
	_showProductAttribute:function(e){
		var chkResult=e.getUserData().data; // data
		if(chkResult.code!=0){
			msgbox(chkResult.message);
		}else{
			var row=chkResult.tag; 
			if(chkResult.jsondetail!=null){
				if(chkResult.jsondetail=="")$( this._data[row][0]+"_jsonobj" ).innerHTML="";
				else{
					this._data[row][3]=	chkResult.jsondetail;
					$( this._data[row][0]+"_jsonobj" ).innerHTML="<a href='javascript:gc.showJsonObj("+row+")'>"+gMessageHolder.SHOW_ATTRIBUTE+"</a>";
				}
			}
			if(chkResult.showDialog){
				var row= chkResult.tag;// @see showJsonObj
				this.editLine(row);
				/*
				界面错误showerro
				var ele = Alerts.fireMessageBox(
				{
					width: 800,
					Height:360,
					modal: true,
					title: gMessageHolder.SET_PRODUCT_ATTRIBUTE
				});
				ele.innerHTML=chkResult.pagecontent;
				executeLoadedScript(ele);
				*/
				var options=$H({id:"art_itemdetail_div",width:"auto",height:"auto",title:gMessageHolder.SET_PRODUCT_ATTRIBUTE,padding:0,resize:true,drag:true,lock:true,esc:true,skin:'chrome'});
				options.content=chkResult.pagecontent;
				art.dialog(options);
				this._tmpData=chkResult;
				var jo= this._data[row][3]; // array, each elements is array of eleId and value
				var i;
				if(jo!=null)for(i=0;i< jo.length;i++){
					dwr.util.setValue( jo[i][0], jo[i][1]);
				}
				try{$("itemdetail_form").focusFirstElement();}catch(e){}
			}
			
		}
	},	
	/**
	 * Find column in this._data by column name
	 * @param cn column name
	 * @return index of that column, start from 0, -1 if not found
	 */
	_findColumnByName: function(cn){
		var i, cols=this._gridMetadata.columns, col;
		for(i=0;i<cols.length;i++){
			if(cols[i].name == cn) return i;
		}
		return -1;
	},
	/**
	 * update grid line state
	 * @param line the row in this._data
	 */
	_updateGridLineState: function(line){
		if( line[1]!="S"){
			var ele=$( line[0]+"_templaterow" );
			var s={};
			switch(line[1]){
				//case "S":break;// Starndard
				case "A": ele.addClassName("row-A");break;//Add (not saved)
				case "M": ele.addClassName("row-M");break;//Modify(not saved)
				case "N": ele.addClassName("row-N");break;//Not Available
				case "D": ele.addClassName("row-D");break;//Delete (not saved)
				case "E": ele.addClassName("row-E");break;//dEleted
			}
			ele.setStyle(s);
			// some state will not allow any action further
			if(line[1]=="E" || line[1]=="N" || line[1]=="D"){
				ele=$( line[0]+"_chk" );
				dwr.util.setValue(ele, false);
				ele.disabled=true;
				var cols=this._gridMetadata.columns,i,col;
				for(i=4;i< cols.length;i++){
					col= cols[i];
					if(col.isVisible){
						$(line[0]+"_"+ col.name).disabled=true;
					}
				}
				$( line[0]+"_jsonobj" ).innerHTML="";
			}
			$( line[0]+"_state__" ).innerHTML="<img src='/html/nds/images/line_"+line[1]+".gif' width='16' height='16'/>";
			this._isDirty=true;			
		}
	},
	
	/** 
	 * Insert a line into grid
	 * @param row, which row in data array, start from 0
	   @param bScrollToView if true, will try to scroll the row to view
	 */
	_insertGridLine:function(row, bScrollToView){
		var line= this._data[row];
		//debug(line);
		dwr.util.cloneNode("templaterow",{ idPrefix:line[0]+"_" });
		var ele=$( line[0]+"_"+"templaterow" );
		ele.toggle();
		if(row%10>4) ele.toggleClassName('odd-row');
		this._updateGridLine(row);
		if(bScrollToView)ele.scrollIntoView(false);
	},
	/**
	 * copy row information to object
	 * @row index in data
	 */
	editRow:function(row){
		var line= this._data[row];
		if(["D","E","N"].indexOf(line[1])>-1) return;
		if(this._inlineMode=="N"){
			this._currentRow= row;
			this.openLineInNewWindow();
		}else if(this._inlineMode=="Y"){
			this._prepareEditableFields(row);
			this._currentRow= row;
			var cols=this._gridMetadata.columns,i,col;
			for(i=4;i< cols.length;i++){
				col= cols[i];
				if($("eo_"+ col.name) && (col.isVisible)){// when fk=table.id, both columns have the same name, but only one is visible
					this._setValue("eo_"+ col.name,line[i]);
				}
			}
			$("legend_line").innerHTML= gMessageHolder.EDIT_LINE +"("+ (row+1)+")";
			var e=$("btn_copyline");
			if(e!=null)e.setEnabled(true);
			if( this._tableActions.indexOf("M")<0){
				if($("btn_saveline")!=null)$("btn_saveline").hide();
			}else{
				if($("btn_saveline")!=null)$("btn_saveline").show();
			}
		}else if(this._inlineMode=="B"){
			
		}
	},
	/**
	 * copy row information to object
	 * @line0 will search for row whose first element equals line0
	 */
	editLine:function(line0){
		var i,row=-1;
		for(i=0;i< this._data.length;i++){
			if(this._data[i][0]==line0){
				row=i;
				break;
			}
		}
		if(row==-1) return;
		this.editRow(row);

	},
	/**
	 * Copy current line to create a new line,will not save immediately
	 */
	copyLine:function(){
		this._prepareEditableFields(-1);
		$("legend_line").innerHTML= gMessageHolder.NEW_LINE ;
		this._currentRow=-1;
	},
	_toggleEditableFields:function(nextFormStateIsAdd){
		//clear and disable those columns that change
		
		var cols=this._gridMetadata.columns,i,col,e,el,isEnabled;
		for(i=4;i< cols.length;i++){
			col= cols[i];
			if(col.isVisible && (col.isUploadWhenModify!=col.isUploadWhenCreate)){
				//change
				e=$("tf_eo_"+ col.name);
				el=$("lb_eo_"+ col.name);
				//nextFormStateIsAdd=true and isUploadWhenCreate=true, or nextFormStateIsAdd=false and isUploadWhenModify=true
				isEnabled=(nextFormStateIsAdd == col.isUploadWhenCreate) && !col.hideInEditMode ;// enable
				if(isEnabled){
					 e.show();
					 el.show();
				}else{
					e.hide();
					el.hide();
				}
			}
			
		}
	},
	/**
	 * When edit row is changing between Add form and Modify form, some fields should be disabled
	 */
	_prepareEditableFields:function(row){
		var currentFormStateIsAdd=true; // true for Add, false for Modify
		var nextFormStateIsAdd=true;
		if(this._currentRow!=-1 ){
			if (this._data.length>this._currentRow){
				currentFormStateIsAdd = (this._data[this._currentRow][4]==-1);
			}else{
				currentFormStateIsAdd=false;
			}
		}
		if(row!=-1){
			nextFormStateIsAdd= (this._data[row][4]==-1);
		}
		if(currentFormStateIsAdd==nextFormStateIsAdd)return;
		this._toggleEditableFields(nextFormStateIsAdd);
	},
	/**
	* New line for edit, all columns in metaData will initiate in new object form
	* @param b if true, will bring up new window if not isInlineMode, else will do
	* nothing if not is inline mode
	*/
	newLine:function(bForceNewWindow){
		if(this._inlineMode=="N"){
			this._currentRow=-1;
			if(bForceNewWindow)this.openLineInNewWindow();
		}else{
			this._prepareEditableFields(-1);
			this._currentRow=-1;
			$("legend_line").innerHTML= gMessageHolder.NEW_LINE ;
			//added by yfzhu, if clear_after_insert is clear, will not clear current input
			if( dwr.util.getValue("clear_after_insert")==true){
				var cols=this._gridMetadata.columns,i,col;
				for(i=4;i< cols.length;i++){
					col= cols[i];
					if(col.isVisible && $("eo_"+ col.name)!=null){
						//check fixed columns
						if( this._fixedColumns[col.columnId]!=undefined){
							dwr.util.setValue("eo_"+ col.name,gMessageHolder.MAINTAIN_BY_SYS);				
						}else{
							this._setValue("eo_"+ col.name,col.defaultValue);
						}
					}
				}
			}
			var e=$("btn_copyline");
			if(e!=null)e.setEnabled(false);
			if( this._tableActions.indexOf("A")<0){
				if($("btn_saveline")!=null)$("btn_saveline").hide();
			}else{
				if($("btn_saveline")!=null)$("btn_saveline").show();
			}
		}
	},
		/**
	 * new row index
	 */
	_getNextRowId:function(){
		return this._currentNewRowId++;
	},
	
	/**
	 Refresh Grid according to data result from server
	*@param r data set by nds.control.ejb.command.UpdateGridData,contains results for each row handling result
	 and qresult for new data for successful rows
	 	 @return true if error found, false if no error
	*/
	updateGrid: function (e) {
		var r=e.getUserData().data; //@see nds.control.ejb.command.UpdateGridData
		var ele2=$("check_material_attribute");
		if(r.refresh||(ele2!=null&&dwr.util.getValue(ele2)==true)){
			this._isDirty=false;
			this.newLine(false);
			this.refreshGrid();
			playScan();
			return;	
		}
		var rs=r.results; //[] elements like: {rowIdx: 12, id:11, msg:null,action:"A"}
		var qr=r.qresult;// QueryResultImpl.toJSONObject
		var i, rsOne, oId,row,a,y, rowIdx,line,j;
		var bRefresh=false;
		var errFound=false;
		var rowsToDelete=new Array();
		var bToDelete;
		var sMsg="";
		for(i=0;i<rs.length;i++){
			rsOne=rs[i];
			y= rsOne.row ;//
			line= this._data[y];
			rowIdx=line[0];
			bToDelete=false;
			if(rsOne.msg==null){
				// success, 3 condition:add/modify/delete
				oId= rsOne.objId;
				if(rsOne.action=="A" ||rsOne.action=="M"){
					row=this._getQueryResultRowForId(qr,oId);
					if(row!=null){
						a=[rowIdx,"S",null,line[3]].concat(row);
						if(rsOne.jsoncreated=="T"){
							a[2]="*"+gMessageHolder.ATTRIBUTE_MATRIX_SPLITTED;
							bRefresh=true;
						}
					}else{
						// not found,out of where clause, move it out(delete)
						//a=[rowIdx,"N",null,line[3]];
						a=[rowIdx,"E",null,null];
						bToDelete=true;
						rowsToDelete.push(y);
						bRefresh=true;
					}
				}else if(rsOne.action=="D"){
					a=[rowIdx,"E",null,null];
					bToDelete=true;
					rowsToDelete.push(y);
				}
			}else{
				//error found
				a=[rowIdx,rsOne.action,rsOne.msg,line[3]];			
				errFound=true;
				sMsg+= gMessageHolder.LINE+" "+(y+1)+":"+ rsOne.msg+"\n";
			}
			for(j=0;j<a.length;j++) line[j]= a[j];
			if(!bToDelete)this._updateGridLine(y);
		}
		if(rowsToDelete.length>0){
			rowsToDelete.sort(function cmp(a, b) {return b - a;});
			for(i=0;i< rowsToDelete.length;i++) this._updateGridLine(rowsToDelete[i]);
		}
		this._isDirty=false;
		this.newLine(false);
		if(errFound==false && bRefresh==true){
			//if(confirm(gMessageHolder.RELOAD_SINCE_ATTRIBUTE_MATRIX_SPLITTED)) #MANTIS0000026
			this.refreshGrid();
			playScan();
		}else{
			if(errFound){
				alert( gMessageHolder.EXCEPTION+":\n"+ sMsg);
				playAlert();
			}
		}
	},
	
	/**
	* Return row of QueryResult which has the ID equals to oId
	  @param qr QueryResultImpl.toJSONObject, which has ID column in the first column of qr.rows
	  @param oId object id to be searched for
	  @return row (array) of QueryResult.data, null if not found
	*/
	_getQueryResultRowForId:function(qr, oId){
		var rows= qr.rows;
		var i,row;
		for(i=0;i< rows.length;i++){
			row=rows[i];
			if(row[0]==oId) return row;
		}
		return null;
	},

	/**
	*Reload grid data according to query result
	* @param qr QueryResult.toJSONObject()
	*/
	_refreshGrid:function (e) {
		var qr=e.getUserData().data; 
		var rowCount=qr.rowCount;
		var i,s,a;
		var q=this._gridQuery;
		this._wrow=qr.wrow;
		s=qr.start;
		q.start= s;
		//fth.refreshGrid();
		dwr.util.removeAllRows("grid_table", { filter:function(tr) {
		      return (tr.id != "templaterow");
	    }});
		
		this._data=new Array();
		for(i=0;i< rowCount;i++){
			a=["M"+qr.rows[i][0] ,"S",null,null];
			this._data.push(a.concat(qr.rows[i]));
			this._insertGridLine(i,false);
		}
		this._syncGridControl(qr);
		if(this._currentRow!=-1)this.newLine(false);
		this._isDirty=false;
		//focus on pdt if found 2010-1-9
		try{
			var chkProductAttribute=$("check_product_attribute");
			var chkMaterialAttr=$("check_material_attribute");
			if(chkMaterialAttr!=null&&$("eo_"+chkMaterialAttr.value)!=null){
			$("eo_"+chkMaterialAttr.value).focus();
			}else if(chkProductAttribute!=null){
				var pdt=$("eo_"+chkProductAttribute.value);
				if(pdt!=null)pdt.focus();
			}
		}catch(ex){}		
		//try{$("itemdetail_form").focusFirstElement();}catch(e){}
		//if(typeof(fth)=="object") fth.drawTable("embed-items");
		//ScrollableTable.set('modify_table','100%',260,false);
		
		
		/*
		var widths=[];
		var masterTable=$("modify_table");
		if($(masterTable.id+"_scroll")){return;}
		
		var masterTableHeader =jQuery("#modify_table").find("thead tr:first td");
		masterTableHeader.each(function(index){
			widths[index]=jQuery(this).width();
		});

		masterTable.tHead.style.position="absolute";
		masterTable.tHead.style.width=masterTable.getWidth()+"px";
		masterTable.tHead.style.left="0px";
		masterTable.tHead.style.top="0px";
		
		var parentDiv= $("embed-items");
		parentDiv.style.paddingTop=masterTable.tHead.getHeight()+"px";
		parentDiv.style.position="relative";
		parentDiv.style.overflowY="auto";
		parentDiv.style.overflowX="auto";
		
		var tableBodyDiv=document.createElement("div");
		tableBodyDiv.id=masterTable.id+"_scroll";
		parentDiv.appendChild(tableBodyDiv);
		$(masterTable.id+"_scroll").appendChild($("modify_table"));
		
		var tableHeader=jQuery("#modify_table").find("thead tr:first td");
		var tableBody=jQuery("#modify_table").find("tbody tr:first td");
		tableHeader.each(function(index){
			this.style.minWidth=widths[index]+"px";
			//jQuery(this).width(widths[index]);
		});
		tableBody.each(function(index){
			this.style.minWidth=widths[index]+"px";
			//jQuery(this).width(widths[index]);
		});
		*/
		
		
		var parentDiv= $("embed-items");
		parentDiv.style.overflowY="auto";
		parentDiv.style.overflowX="auto";
		gc._initTable();
		parentDiv.onscroll=function(){
			//alert("a");
			//this.scrollTop="0px";
			if(this.scrollTop>0){
				//AddScrollTableHeader(this);
				
				this.style.overflowY="hidden";
		ScrollableTable.set('modify_table','100%',260,false);
			}
			return true;
		}
		
	},
	/**
	* Setup line template for input
	*/
	openLineTemplate: function(){
		popup_window("/html/nds/objext/template.jsp?table="+ this._gridMetadata.tableId);
	},
	/**
	 * Init modify table, support mouse selection
	 */
	_initTable: function(){
		 /*
		this._gridTable= new SelectableTableRows($("modify_table"), false);
		this._gridTable.ondoubleclick = function (trRow) {
			gc.editRow(trRow.sectionRowIndex);
		}; */	 
		/*this._gridTable.onchange = function () {
			var i,s,v;
			var curSelected=  gc._gridTable.getSelectedIndexes();
			for(i=0;i< gc._data.length;i++){
				if(["D","E","N"].indexOf(gc._data[i][1])>-1)continue;
				v=(curSelected.indexOf(i)>-1);
				s=dwr.util.getValue(gc._data[i][0]+"_chk");
				if(v!=s) dwr.util.setValue(gc._data[i][0]+"_chk", !s);
			}
			dwr.util.setValue("chk_select_all", false); 
			cyl 10 16
			更新SelectableTableRows to  selectable
		};	
		*/
		var tb=jQuery('#modify_table').selectable({filter:'tr',tolerance:"fit",cancel:"input,:input,a,.ui-selected"});
		 tb.dblclick(function(trElement){
		   if(trElement.srcElement.type=="checkbox"){
		   	return;
		   	}
		 	    //alert(trElement);
		 	    var selc_index=trElement.target.parentElement.sectionRowIndex;
		 	    if(selc_index==undefined){
		 	    var selc_index=trElement.target.parentElement.parentElement.sectionRowIndex;
		 	    	}
		 			gc.editRow(selc_index);
		 			
		});
			
	},
	
	/**
	 * When key pressed in table, move focus
	 */
	moveTableFocus: function(e){
		var r,ele;
		switch(e.keyCode){
			case 38:{//UP
				r= this._getCurrentPositionInData(e);
				if(r!=null)while(r.row>0){
					r.row = r.row-1;
					if(["M","A","S"].indexOf( this._data[r.row][1])>-1){
						ele= this._data[r.row][0]+"_"+  this._gridMetadata.columns[r.column].name;
						dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
						break;
					}
				}
				break;
			}
			case 13:{//enter
				var pos,mol;
				var cur_scroll=jQuery("#embed-items").scrollLeft();
				r= this._getCurrentPositionInData(e);
				molist=this._gridMetadata.columnsWhenModify;
				mol=molist.length-1;
				if(r!=null){
				if(["M","A","S"].indexOf( this._data[r.row][1])>-1){
					jQuery.each(molist, function(index,value){
						if(pos>0)return false;
						if(index==mol){pos=index; return false;}
						if(value==r.column&&gc._gridMetadata.columns[molist[index+1]].dsptype!=5){
						//ele= this._data[r.row][0]+"_"+  this._gridMetadata.columns[molist[index+1]].name;
						//dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
						
						pos=index;
						return false;
						//break;
						}
						else if(value==r.column&&gc._gridMetadata.columns[molist[index+1]].dsptype==5){
						pos=index+1;
						r.column=molist[pos];
						//return true;
						}
					});
					if(pos==mol){
						pos=2;r.row=r.row+1;
					for (var i=pos;i<molist.length;i++){
						if(this._gridMetadata.columns[molist[i+1]].dsptype!=5){pos=i;cur_scroll=0;break;}
						}
					}
					try{
					ele= this._data[r.row][0]+"_"+  this._gridMetadata.columns[molist[pos+1]].name;
					var pwidth=cur_scroll+jQuery("#"+ele).width();
					jQuery("#embed-items").animate({scrollLeft: pwidth+50}, 300);
					dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
					}catch(e){}
					break;
				}
				}
				break;
			}
			case 40:{//DOWN
				r= this._getCurrentPositionInData(e);
				if(r!=null)while(r.row<this._data.length-1){
					r.row = r.row+1;
					if(["M","A","S"].indexOf( this._data[r.row][1])>-1){
						ele= this._data[r.row][0]+"_"+  this._gridMetadata.columns[r.column].name;
						dwr.util.selectRange(ele, 0, this.MAX_INPUT_LENGTH);
						break;
					}
				}
				break;
			}
		}		
	},
/**
	 * When cell value changed in table, this method will be called
	 */
	cellChanged: function(e){
		var r=this._getCurrentPositionInData(e);
		if(r==null)return;
		//debug("r="+ r.row+","+ r.column+";ele="+(e.target != null ? e.target.id : e.srcElement.id));
		var line=this._data[r.row];
		line[r.column]=this._getValue( e.target != null ? e.target : e.srcElement) ;
		if(line[1]!="A"){
			line[1]="M";
		}
		this._updateGridLineState(line);
	},
	/**
	 * Wrapper dwr.util.getValue for checkbox value conversion "true" to "Y", "false" to "N"
	 */
	_getValue :function(ele, options) {
		var e=$(ele);
		if(e==null) return "";
		var v= dwr.util.getValue( e,options);
		if(e.type == "checkbox"){
			if(v==true) v="Y";
			else if(v==false) v="N";
		}
		return v;
	},
	/**
	 * This is modified one of dwr.2.0.1 for checkbox value setting.
		Old one only let "true" for checked, now "Y" will also be checked one
	 */
	_setValue: function(ele, val, options,readyonly) {
		var e=$(ele);
		if(e==null) return;
		try{
		if(e.type == "checkbox"){
			if(val=="Y") val=true;
			else if(val=="N") val=false;
		}
		if(readyonly){
			jQuery("#"+ele).attr("class","input_only");
			$(ele).disabled=true;
		}
		dwr.util.setValue(e,val,options);
		}catch(ex){
			debug("_setValue Error::::"+ex+",ele="+ele+", $ele="+e+"");
		}
	},
	
	/**
	 * Get row and column in this._data of current focus in table
	 * @param e event object
	 * @return {row:int, column:int},null if not found or reach the boundary of grid
	 */
	_getCurrentPositionInData:function(e){
		if(e!=null) e = e.target != null ? e.target : e.srcElement;
		if(e==null) return null;
		var p= e.id.indexOf("_",0);
		var d0= e.id.substr(0,p);
		var d1= e.id.substr(p+1);
		var i, r={row:-1, column:-1};
		var cols=this._gridMetadata.columns;
		for(i=0;i< this._data.length;i++){
			if(this._data[i][0]==d0){
				r.row=i;
				break;
			}
		}
		for(i=0;i<cols.length;i++ ){
			if(cols[i].name== d1){
				r.column= i;
				break;
			}
		}
		if(r.row==-1 || r.column==-1){
			//debug("found position error:row="+ r.row+",col="+ r.column);
			return null;
		}		
		return r;
	}
	
};
// define static main method
GridControl.main = function () {

	gc=new GridControl();
};


var EditableGridMetadata = Class.create();
// define constructor
EditableGridMetadata.prototype = {
	/**
	* Load data from object from server
	*/
	initialize: function(o){
		this.columns=o.columns;
		this.table=o.table;	
		this.tableId=o.tableId;
		this.column_masks=o.column_masks; //elements are GridColumn
		this.ismenuobj= o.ismenuobj;
		this.popupitem=o.popupitem;
		this.columnsWhenCreate=this._getColumnsWhenCreate();
		this.columnsWhenModify=this._getColumnsWhenModify();
		this.columnsWhenDelete=this._getColumnsWhenDelete();
	},
	/**
	* Columns that will be uploaded to server for ObjectCreate
	*@return int[] for column index in Grid columns
	*/
	_getColumnsWhenCreate :function () {
		var rt=new Array();
		var col;
		for(var i=0;i< this.columns.length;i++){
			col= this.columns[i];
			if (col.isUploadWhenCreate)	rt.push(i);
		}
		return rt;
	},
	/**
	* Columns that will be uploaded to server for ObjectCreate
	*@return int[] for column index in Grid columns
	*/
	_getColumnsWhenModify :function () {
		var rt=new Array();
		var col;
		for(var i=0;i< this.columns.length;i++){
			col= this.columns[i];
			if (col.isUploadWhenModify)	rt.push(i);
		}
		return rt;
	},
	/**
	* Columns that will be uploaded to server for ObjectCreate
	*@return int[] for column index in Grid columns
	*/
	_getColumnsWhenDelete :function () {
		return [4];//ID
	}
	
};

function msgbox(msg, title, boxType ) {
	showProgressWindow(false);
	alert(msg);
}
function playAlert(){
		if($("jpId")&&!is_ie_8){
			/*
        	if(!app1){
            	var app1=FABridge.b_playErrorSound.root();
                app1.setStr($("sound").value.strip());
			}*/
						jQuery("#jpId").jPlayer("stop");
            jQuery("#jpId").jPlayer("play");
            return;
      }
}

function playScan(){
		if($("jpsId")&&!is_ie_8){
			/*
        	if(!app1){
            	var app1=FABridge.b_playErrorSound.root();
                app1.setStr($("sound").value.strip());
			}*/
						jQuery("#jpsId").jPlayer("stop");
            jQuery("#jpsId").jPlayer("play");
            return;
      }
}

function alertScan(msg){
	 var _isIE7=(navigator.userAgent.indexOf('MSIE 7')>0);
	if(_isIE7){
		alert(msg);
		return;
	}
	if(is_ie_8){
		alert(msg);
		return;
	}
	var errcnt=0;
	while(true){
		playAlert();
		if(parseInt(prompt(gMessageHolder.SCAN_ERROR.replace(/x/i,msg).replace(/y/i,errcnt),"0"))==0)break;
		errcnt++;
	}
}
/**
* Show table object info

function dlgo(tableId, objId){
	popup_window("/html/nds/object/object.jsp?table="+tableId+"&id="+objId);
}
*/

function showProgressWindow(bShow){
	
}
function debug(message, stacktrace){
	dwr.engine._debug(message, stacktrace);
}
function doSaveLine(){
	gc.saveLine();
}	
function doAdd(){
	gc.newLine(true);
}
function doDeleteLine(){
	gc.deleteSelected();	
}
function doListDelete(){
	if (!confirm(gMessageHolder.CONFIRM_DELETE_CHECKED)) {
         return false;
    }
    gc.deleteSelected();
}
function doProcess(){
	gc.saveAll();
}
function doTemplate(){
	gc.openLineTemplate();
}

function doQuickSearch(){
	gc.quickSearch();
}


	var scrollbarWidth = 0;
	// http://jdsharp.us/jQuery/minute/calculate-scrollbar-width.php
	function getScrollbarWidth() 
	{
		if (scrollbarWidth) return scrollbarWidth;
		var div = jQuery('<div style="width:50px;height:50px;overflow:hidden;position:absolute;top:-200px;left:-200px;"><div style="height:400px;"></div></div>'); 
		jQuery('body').append(div); 
		var w1 = jQuery('div', div).innerWidth(); 
		div.css('overflow-y', 'auto'); 
		var w2 = jQuery('div', div).innerWidth(); 
		jQuery(div).remove(); 
		scrollbarWidth = (w1 - w2);
		return scrollbarWidth;
	}

	var ScrollableTable = {


	init: false,

	_scrollBarWidth : 18,

	set: function(id,width,height, overflowX, center) {

		if (jQuery("#D_modify_table").length>0) {
			var itemlen=document.getElementById("grid_table").rows.length;
		if(itemlen>1){
			ScrollableTable._matchFixedHead();
			return;
			}else{
				return;
			}
		}
		if (overflowX == null) {
			overflowX = false;
		}

		if (center == null) {
			center = false;
		}

		var masterTable = document.getElementById(id); 
		//masterTable.style.tableLayout="fixed";
		//var masterWidth=masterTable.getWidth(); //paco 2013-7-3

		if (masterTable == null) {
			alert("Err \n no table ");
			return;
		}
		if (masterTable.tHead == null) {
			alert("err\n no <THEAD>");
			return;
		}

		if (masterTable.caption != null) {
			masterTable.caption.innerHTML = ""; 
		}

		var thHeight = masterTable.tHead.offsetHeight;

		var tableHeader = masterTable.cloneNode(true);

    var ptableid=tableHeader.id;
		tableHeader.id = ptableid + "_H";
		
		while (tableHeader.tBodies[0].rows.length) {
			tableHeader.tBodies[0].deleteRow(0);
		}
		tableHeader.tBodies[0].id='h_grid_table';
		
		tableHeader.cellSpacing="0";
		
	  tableHeader.style.position = "relative";
		tableHeader.style.left = "0";
		tableHeader.style.top = "0";
		//tableHeader.style.tableLayout="fixed";
		 
	 var tableOrg = jQuery("#" + id);
		
		//width=tableOrg.outerWidth()<jQuery("#embed-items").width()?jQuery("#embed-items").width():tableOrg.outerWidth();
		
	  //tableHeader.style.width = width+"px";
	 
		
		
		var colsWidths = jQuery(tableOrg).find("thead tr:first td").map(function() {
			return jQuery(this).width();
		});
		
		var allWidths=0;
		colsWidths.each(function(index){
			allWidths+=colsWidths[index];
		});
	
		
		if (tableHeader.rows.length > 0) {
			//获取每一行TR数据
			  for (v = 0; v < tableHeader.rows.length; v++) {
			  	var  trbody=tableHeader.rows[v];
			    if (colsWidths.size() > 0) {
			    	  //更新每行TD宽度
			    	
			        for (i = 0; i < trbody.children.length; i++) {
			        	//alert(colsWidths[i]);
			        	var tdbody=trbody.children[i]
						tdbody.width=colsWidths[i]+'px';
			            if (i == tdbody.length - 1) {
			                // if (browserVersion == 8.0)
			                    // tdbody.width=colsWidths[i] + scrollWidth+'px';
			                // else
			                    tdbody.width=colsWidths[i]+'px';
			            } else {
			                //tdbody.width=colsWidths[i]+1+'px'; //paco 2013-7-3
							tdbody.width=colsWidths[i]+'px'; //paco 2013-7-3
							//tdbody.width=(colsWidths[i]/allWidths)+"%";
			            }
			        }
			    }
			    
			  }
 		}
		
		var divHeader = document.createElement("div");
		divHeader.id = "D_" + ptableid;
		//divHeader.style.width =masterWidth + "px"; //paco 2013-7-3
		divHeader.style.height = thHeight + "px";
		divHeader.style.overflow = "hidden";
		divHeader.style.position = "relative";//"absolute";
		divHeader.style.zIndex=12;
		divHeader.appendChild(tableHeader);

		masterTable.parentNode.insertBefore(divHeader, masterTable);
		//masterTable.tHead.style.display="none";
		masterTable.deleteTHead();
		
		/*
		tableOrg = jQuery(ptableid + "_H");
	 
		colsWidths = jQuery(tableOrg).find("thead tr:first td").map(function() {
			return jQuery(this).width();
		});
		*/
		//var tableBody = masterTable.cloneNode(true);
		//tableBody.id = tableBody.id + "_B";
		//tableBody.deleteTHead();
		
		
		if (masterTable.rows.length > 0) {
			//获取每一行TR数据
			  for (v = 0; v < masterTable.rows.length; v++) {
			  	var  trbody=masterTable.rows[v];
			    if (colsWidths.size() > 0) {
			    	  //更新每行TD宽度
			    	
			        for (i = 0; i < trbody.children.length; i++) {
			        	//alert(colsWidths[i]);
			        	var tdbody=trbody.children[i];
			            if (i == tdbody.length - 1) {
			                // if (browserVersion == 8.0)
			                    // tdbody.width=colsWidths[i] + scrollWidth+'px';
			                // else
			                    tdbody.width=colsWidths[i]+'px';
			            } else {
			                tdbody.width=colsWidths[i]+'px';
							//tdbody.width=(colsWidths[i]/allWidths)+"%";
			            }
			        }
			    }
			    
			  }
 		}
		
 		
 	  //masterTable.style.width = width+ "px";//(width + getScrollbarWidth()) + "px";
		
		var divBody = document.createElement("div");
		divBody.id = "D_" + masterTable.id+"_B";
		//divBody.style.width = (width + getScrollbarWidth()) + "px";
		//divBody.style.width=(masterWidth + getScrollbarWidth()) + "px"; //paco 2013-7-3
		divBody.style.maxHeight = height + "px";
		divBody.style.minHeight ="100px";
		if (overflowX) {
			divBody.style.overflow  = "auto";
		} else {
			divBody.style.overflowY = "auto";
			divBody.style.overflowX = "hidden";
			divBody.style.zIndex=11;
		}
		if (center) {
			divBody.style.marginLeft  = getScrollbarWidth() + "px";
		}
		
		
			var bodyWrap = jQuery("#"+masterTable.id).wrap('<div></div>')
									.parent()
									.attr('id',divBody.id)
									.css({
										//width: (width + getScrollbarWidth()),
										//width: (masterWidth + getScrollbarWidth()) + "px",//paco 2013-7-3
										maxHeight: height,
										minHeight:100,
										overflowY:'auto',
										overflowX:'hidden',
										zIndex:11
									});
									
		//masterTable.parentNode.insertBefore(divBody,masterTable);
 			//masterTable.prependTo(divBody);
 			//jQuery("#"+masterTable.id).prependTo(divBody);
		//masterTable.parentNode.insertBefore(divBody, masterTable);
		//masterTable.parentNode.removeChild(masterTable);
   // jQuery('#modify_table_B thead').hide();
		divBody.onscroll = function() {
			ScrollableTable._onscroll(divHeader.id, divBody.id)
		};

		//this.init = true;
		//ScrollableTable._matchFixedHead();
		gc._initTable();
		ScrollableTable._matchFixedHead();
	},

	
	_onscroll: function(divHeaderId, divBodyId) {
		var divHeader = document.getElementById(divHeaderId);
		var divBody = document.getElementById(divBodyId);

		divHeader.firstChild.style.left =  "-" + divBody.scrollLeft + "px";
	},
	
		_matchFixedHead : function() {
		/* 3 times change to match */
		var thWidth = [];

		var theadTD = jQuery("#modify_table_H").find("thead tr:first td");
		var tbodyTD = jQuery("#modify_table").find("tbody tr:first td");
		var diff=0;
		theadTD.each(function(index) {
			var tObj = jQuery(this);
			var temp = tObj.width();
			thWidth[index] = temp<24?26:temp;/*before +24px,now 26px for forbidding table's no wider.*/
		});
		tbodyTD.each(function(index) {
			var temp = jQuery(this).width();
			var arrayTemp = thWidth[index];
			thWidth[index] = arrayTemp>temp?arrayTemp:temp;
			diff=diff+(arrayTemp<temp?temp-arrayTemp:arrayTemp-temp);
		});
		
		if (Prototype.Browser.IE) {
			tbodyTD.each(function(index) {
				//thWidth[index] += 4;
				jQuery(this).width(thWidth[index]);
			});
	
		} else{
			//tbodyTD.each(function(index) {jQuery(this).css("min-width",thWidth[index]);});
			tbodyTD.each(function(index) {jQuery(this).width(thWidth[index]);});
		}
		//theadTD.each(function(index) {jQuery(this).css("min-width",thWidth[index]);});
		theadTD.each(function(index) {jQuery(this).width(thWidth[index]);});

     //alert(theadTD[0].offsetWidth);
     //alert(tbodyTD[0].offsetWidth);
     //修复明细刷新不能宽度放大问题
	 
	 
      //if(theadTD[0].offsetWidth!=tbodyTD[0].offsetWidth&&tbodyTD[0].offsetWidth!=0){
	if(diff>0){ 
		jQuery("#modify_table_H").width((jQuery("#modify_table_H").width()+diff));
		//jQuery("#modify_table_H").width(diff);
		jQuery("#modify_table").width(jQuery("#modify_table_H").width());
		jQuery("#D_modify_table").width(jQuery("#modify_table_H").width());
		jQuery("#D_modify_table_B").width((jQuery("#D_modify_table").width()+getScrollbarWidth()));
	}
	}
}


