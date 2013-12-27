var gridInitObject=null;
var pc;
var PortalControl = Class.create();
// define constructor
PortalControl.prototype = {
	initialize: function() {
		// init dwr
		dwr.util.useLoadingMessage(gMessageHolder.LOADING);
		dwr.util.setEscapeHtml(false);
		/** A function to call if something fails. */
		dwr.engine._errorHandler =  function(message, ex) {
			if($("timeoutBox")!=null){
				$("timeoutBox").style.visibility = 'hidden';
			}
	  		while(ex!=null && ex.cause!=null) ex=ex.cause;
	  		if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + ", " + ex.message+","+ ex.cause.message, true);
			if (message == null || message == "") msgbox("A server error has occured. More information may be available in the console.");
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else msgbox(message);
			if($("list_query_form")!=null)toggleButtons($("list_query_form"),false);
		};
		try{
		var tabs=new CategoryTabs(gMenuObjects);
		$("page-nav-container").innerHTML=tabs.toString();
		if(tabs.childNodes.length>0)tabs.childNodes[0].select();
		gMenuObjects=null;
		}catch(ex){}
		this._isListPageLoaded=false;
		this._listPageLoadTime=0; 
		this._defaultListMode=1;// default to read
		this._resizable=true; //allow resize
		this._tableObj=null;
		this._data=null;// hold grid infor
		this._gridMetadata=null; 
		this.MAX_INPUT_LENGTH=1000;// this is used for selection range
		this._cxtabInputId=null;
		this._cxtabId=null; // current cxtab id
		this._lastAccessTime= (new Date()).getTime();
		// marquee.js
		var scr1 = new dw_scroller('bottom-adv-content', 300, 20, 5, 'v', true);
		
		application.addEventListener( "RefreshGrid", this._refreshGrid, this);
		application.addEventListener( "UpdateGrid", this._updateGrid, this);
		application.addEventListener( "ListSubmit", this._onListSubmit, this);
		application.addEventListener( "ListDelete", this._onListDelete, this);
		application.addEventListener( "ExecuteCxtab", this._onExecuteCxtab, this);
		application.addEventListener( "DeleteFile", this._onDeleteFile, this);
		application.addEventListener( "ExecuteAudit", this._onExecuteAudit, this);
		application.addEventListener( "LoadCxtabSearchForm", this._onLoadCxtabSearchForm, this);
		application.addEventListener( "DeleteCxtabFiles", this._onDeleteCxtabFiles, this);
		application.addEventListener( "ExecuteWebAction", this._onExecuteWebAction, this);
		// init tree.js, this is for report center
		/// XP Look
		webFXTreeConfig.rootIcon		= "/html/nds/js/xloadtree111/images/xp/folder.png";
		webFXTreeConfig.openRootIcon	= "/html/nds/js/xloadtree111/images/xp/openfolder.png";
		webFXTreeConfig.folderIcon		= "/html/nds/js/xloadtree111/images/xp/folder.png";
		webFXTreeConfig.openFolderIcon	= "/html/nds/js/xloadtree111/images/xp/openfolder.png";
		webFXTreeConfig.fileIcon		= "/html/nds/js/xloadtree111/images/xp/folder.png";
		webFXTreeConfig.lMinusIcon		= "/html/nds/js/xloadtree111/images/xp/Lminus.png";
		webFXTreeConfig.lPlusIcon		= "/html/nds/js/xloadtree111/images/xp/Lplus.png";
		webFXTreeConfig.tMinusIcon		= "/html/nds/js/xloadtree111/images/xp/Tminus.png";
		webFXTreeConfig.tPlusIcon		= "/html/nds/js/xloadtree111/images/xp/Tplus.png";
		webFXTreeConfig.iIcon			= "/html/nds/js/xloadtree111/images/xp/I.png";
		webFXTreeConfig.lIcon			= "/html/nds/js/xloadtree111/images/xp/L.png";
		webFXTreeConfig.tIcon			= "/html/nds/js/xloadtree111/images/xp/T.png";
		webFXTreeConfig.blankIcon		= "/html/nds/js/xloadtree111/images/xp/blank.png";
		webFXTreeConfig.usePersistence  = false;
		
		if(document.getElementById("objdropbtn")!=null)ObjDropMenu.init(true);//hover

	},
	ssv:function(sid){
		window.location="/html/nds/portal/portal.jsp?ss="+sid;
	},
	reloadCxtabHistory:function(){
		this.refreshCxtabHistoryFiles(parseInt(dwr.util.getValue($("rep_templet"))));
	},
	/*
	   @param cxtabId ad_cxtab.id, if undefined, will retrieve from internval value
	*/
	refreshCxtabHistoryFiles:function(cxtabId){
		//load history
		if(cxtabId==null) cxtabId=this._cxtabId;
		else this._cxtabId=cxtabId;
		var url="/html/nds/cxtab/history_files.jsp?id="+cxtabId;
		new Ajax.Request(url, {
		  method: 'get',
		  onSuccess: function(transport) {
		  	var pt=$("history_files");
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
		  	  	}
		  	//}catch(e){}
		  }
		});			
	},	
	/**
	 Update last access time
	*/
	updateLAT:function(){
		this._lastAccessTime= (new Date()).getTime();
	},
	setWarningOnSubmit:function(b){
		this._warningOnSubmit=b;	
	},
	setResizable:function(b){
		this._resizable=b;	
	},
	setDialogOption:function(opt){
		this._dialogOption=opt;
	},
	/**
	  Refresh grid when dialog window close, this will slow down client
	*/
	setRefreshOnDialogClose:function(b){
		if(b){
			this._dialogOption={onClose:refreshPortalGrid};
		}else{
			this._dialogOption={};
		}
	},
	/**
	@param perm 1 for read, 3 for write
	*/
	setDefaultListMode:function(perm){
		this._defaultListMode=perm;
	},
	/**
	 in firefox 3, embed-lines should be resized
	*/
	resize:function(){
		//if(is_ie) return;//modified by ken to set table div in ie avoid overflow of table
		var limitWidth;
		//limitWidth=(jQuery("#portal-menu").css("display")=="block")?jQuery("#portal-menu").width()+jQuery("#portal-separator").width():jQuery("#portal-separator").width();		
		limitWidth=230;//limitWidth+40;
		
		var e=$("embed-lines");
		
		if(e==null)return;
		//e.style.width=760;
		if (!is_safari) {
				e.style.width= (document.body.clientWidth - limitWidth)+"px";
	    }else {
	        e.style.width= (document.body.offsetWidth - limitWidth)+"px";
	    }
	},
	/**
	 * Create query input form for selected cxtab obj
	 * @param cxtabId ad_cxtab.id
	 */
	qrpt:function(cxtabId){
		/**
		 screen layout may not be as expected
		*/
		/*if($("rpt-search")==null){
			this.navigate("/html/nds/cxtab/rpthome.jsp?cxtab="+encodeURIComponent(cxtabId));
			//alert(gMessageHolder.PLEASE_REFRESH_CXTAB_PAGE);
			return;
		}*/
		var evt={};
		evt.command="LoadPage";
		evt.callbackEvent="LoadCxtabSearchForm";
		var params={cxtab:cxtabId};
		evt.url="/html/nds/cxtab/search.jsp";
		evt.queryParams=params;
		this.executeCommandEvent(evt);
	},
	/**
	 * Create WebFXLoadTree and return 
	 */
	createTree:function(desc,src,sAction,bExpandAll){
		var tree = new WebFXLoadTree(desc, src, sAction);
		tree.setBehavior("classic");
		$("tree-list").innerHTML=tree.toString();
		if(bExpandAll ==undefined || bExpandAll==true)
			tree.expandAll();
		return tree;
	},
	_onLoadCxtabSearchForm:function(e){
		var div=$("portal-content");
		div.innerHTML=e.getUserData().data.pagecontent;
		executeLoadedScript(div);
	},
	
	_onExecuteAudit:function(e){
		var r=e.getUserData(); 
		if(r.message){
			msgbox(r.message.replace(/<br>/g,"\n"));
		}
		this.navigate("/html/nds/audit/view.jsp");
	},
    _onListOperation:function(e, bRefreshList){
    	var chkResult=e.getUserData(); // data
		if(chkResult.message){
			msgbox(chkResult.message.replace(/<br>/g,"\n"));
		}
		if(bRefreshList){
			this.refreshGrid();
		}
    },
    _onListSubmit:function(e){
    	this._onListOperation(e,true);
    },
	onSearchReturn :function(event) {
	  if (!event) event = window.event;
	  if (event && event.keyCode && event.keyCode == 13){
		  var elt = Event.element(event);
		  try{
		  	elt.blur();
		  	elt.focus();
		  }catch(e){}
	  	  this.queryList();
	  }
	},
    /**
     * @param e e.getUserData().data contains url where export file exists
     */
    _onExecuteCxtab:function(e){
    	
	    var r=e.getUserData().data;
		if(r.message){
			msgbox(r.message.replace(/<br>/g,"\n"));
		}
		if(r.url){
			var option={onClose:function(){pc.refreshCxtabHistoryFiles(null);}};			
			if(!r.url.endsWith(".htm")){
				//download only, not shown
				showObject( r.url, 400, 200,option);
			}else{
				showObject( r.url,null,null,option);
			}
		}
		
		toggleButtons($("list_query_form"),false);
    },
    _onDeleteCxtabFiles:function(e){
    	this.refreshCxtabHistoryFiles(null);
    },
    _onDeleteFile:function(e){
	    var r=e.getUserData().data; 
		if(r.message){
			msgbox(r.message.replace(/<br>/g,"\n"));
		}
		this.doRefreshMyFolder();
    },
	/**
	 Refresh Grid according to data result from server
	*@param r data set by nds.control.ejb.command.UpdateGridData,contains results for each row handling result
	 and qresult for new data for successful rows
	*/
	_updateGrid: function (e) {
		var r=e.getUserData().data; //@see nds.control.ejb.command.UpdateGridData
		if(r.message){
			msgbox(r.message.replace(/<br>/g,"\n"));
		}
		if( r.refresh==true){
			this.refreshGrid();
			return;
		}
		var rs=r.results; //[] elements like: {rowIdx: 12, id:11, msg:null,action:"A"}
		var qr=r.qresult;// QueryResultImpl.toJSONObject
		var i, rsOne, oId,row,a,y, rowIdx,line,j;
		var bSplitted=false;
		var errFound=false;
		var rowsToDelete=new Array();
		var bToDelete;
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
					}else{
						// not found,out of where clause
						a=[rowIdx,"N",null,line[3]];
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
			}
			for(j=0;j<a.length;j++) line[j]= a[j];
			if(!bToDelete)this._updateGridLine(y);
		}
		if(rowsToDelete.length>0){
			rowsToDelete.sort(function cmp(a, b) {return b - a;});
			for(i=0;i< rowsToDelete.length;i++) this._updateGridLine(rowsToDelete[i]);
		}
		this._isDirty=false;
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
			case 40://DOWN
			case 13:{//Enter
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
		var v= dwr.util.getValue( ele,options);
		if($(ele).type == "checkbox"){
			if(v==true) v="Y";
			else if(v==false) v="N";
		}
		
		return v;
	},	
	/**
	 * This is modified one of dwr.2.0.1 for checkbox value setting.
		Old one only let "true" for checked, now "Y" will also be checked one
	 */
	_setValue: function(ele, val, options) {
		try{
		if($(ele).type == "checkbox"){
			if(val=="Y") val=true;
			else if(val=="N") val=false;
		}
		dwr.util.setValue(ele,val,options);
		}catch(e){
			debug("_setValue Error::::"+e+",ele="+ele+", $ele="+$(ele)+"");
		}
	},
	_syncGridControl:function(qr){
		this._gridQuery.totalRowCount=qr.totalRowCount;
		this._gridQuery.start=qr.start;
		//this._gridQuery.range=qr.range;
		//dwr.util.setValue("range_select", qr.range);
		if( this._gridQuery.order_columns!=null){
			var ele=$("title_"+this._gridQuery.order_columns);
			if(ele!=null){
				ele.innerHTML="<img src='/html/nds/images/"+( this._gridQuery.order_asc?"up":"down")+"simple.png'>";
			}
		}
		if($("txtRange")!=null){
			$("txtRange").innerHTML=((qr.start+1)+"-"+ (qr.start+qr.rowCount)+"/"+ qr.totalRowCount);
			//debug("_syncGridControl: qr:start="+ qr.start+",qr.rowCount:"+ qr.rowCount+",qr.totalRowCount"+qr.totalRowCount);
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
	*Reload grid data according to query result
	* @param qr QueryResult.toJSONObject()
	*/
	_refreshGrid :function (e) {
		var qr=e.getUserData().data; 
		var rowCount=qr.rowCount;
		var i,s,a;
		var q=this._gridQuery;
		s=qr.start;
		q.start= s;
	
		if(qr.rows==null || qr.rows==undefined){
			// data insert by html
			if(qr.pagecontent!=null){
				this._data=null;
				if(Prototype.Browser.IE){
					// ie does not support setting innerHTML in tbody
					var div=$("embed-lines");
					var te=div.innerHTML;
					var p= te.indexOf("<!--$GRIDTABLE_START-->");
					var pe= te.indexOf("<!--$GRIDTABLE_END-->");
					var pstr=te.substring(0, p+ "<!--$GRIDTABLE_START-->".length);
					var pestr=te.substr(pe);
					var newDiv=pstr.concat("<tbody id='grid_table'>",qr.pagecontent,"</tbody>",pestr);
					div.innerHTML=newDiv;
					executeLoadedScript(div);
					this._initGridSelectionControl();
				}else{
					var gridTableBody=$("grid_table");
					dwr.util.removeAllRows(gridTableBody);
					gridTableBody.innerHTML=qr.pagecontent;
					executeLoadedScript(gridTableBody);
				}
			}
		}else{
			dwr.util.removeAllRows($("grid_table"));
			
			//data insert by lines
			var alerts= qr.alerts;
			this._data=new Array();
			var state= "S";//(this._gridQuery.dir_perm==1?"N":"S");//N for not modifiable, S for standard state
			for(i=0;i< rowCount;i++){
				a=["M"+qr.rows[i][0] ,state,null,null];
				this._data.push(a.concat(qr.rows[i]));
				this._insertGridLine(i,false, alerts==null?null:alerts["tr_"+(i+1)]);
			}
		}
		this._updateSubtotal(qr);
		
		this._syncGridControl(qr);
		toggleButtons($("list_query_form"),false);
		var desc=  qr.queryDesc;
		if(qr.message !=undefined && qr.message!=null) desc+= "<br><blink><span class='err'>***"+ qr.message+"</blink>";
		$("filter_setting").innerHTML= desc;
		dwr.util.setValue($("chk_select_all"),false);
	},
	/**
	 * Update subtotal 
	 * @param qr QueryResult
	 */
	_updateSubtotal:function(qr){
		var sr=qr.subtotalRow;
		if($("tr_pagesum")==null || sr==null) return;
		var i;
		var cols=this._gridMetadata.columns;
		for(i=0;i< cols.length;i++){
			if(cols[i].summethod!=null){
				//debug(i+"="+ sr[i-4]+", "+ cols[i].columnId+", "+ cols[i].name);
				dwr.util.setValue($("psum_"+cols[i].columnId), sr[i-4]);// first 4 column is not from query
			}
		}
		var fr= qr.fullRangeSubTotalRow;
		if(fr==null){
			$("tr_totalsum").hide();	
		}else{
			//debug("fr="+ fr);
			$("tr_totalsum").show();
			for(i=0;i< cols.length;i++){
				if(cols[i].summethod!=null){
					dwr.util.setValue($("tsum_"+cols[i].columnId), fr[i-4]);
				}
			}
		}
	},
	
	/** 
	 * Insert a line into grid
	 * @param row, which row in data array, start from 0
	   @param bScrollToView if true, will try to scroll the row to view
	   @param rowCss css for row, may be null
	 */
	_insertGridLine:function(row, bScrollToView, rowCss){
		var line= this._data[row];
		//debug(line);
		if(this._gridQuery.dir_perm==1){
			//will remove "$" in ids
			this._cloneNode("$templaterow",{ idPrefix:line[0]+"_" });
		}else{
			this._dwrcloneNode("templaterow",{ idPrefix:line[0]+"_" });
		}
		
		this._updateGridLineCss(row, rowCss);
		this._updateGridLine(row);
		
		if(bScrollToView)ele.scrollIntoView(false);
	},	
	/**
	 * Update both tr css and input/select in it
	 */
	_updateGridLineCss:function(row, rowCss){
		var line= this._data[row];
		var ele=$( line[0]+"_"+"templaterow" );
		ele.toggle();
		if(row%2==0) ele.className='odd-row';
		else ele.className="even-row";
		if(rowCss!=null) ele.className= ele.className + " "+ rowCss;
		ele.getElementsBySelector('input[type="text"]', 'select').each(function(e){
			e.addClassName(rowCss);
		});
		
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
		$( line[0]+"_row" ).innerHTML="<input type='checkbox' id='"+ line[0] +"_chk' value='Y' class='cbx' onchange='pc.chk(\""+line[0]+"\")' /><a href='javascript:pc.editLine(\""+line[0]+"\")'>"+ (row+1+this._gridQuery.start)+"</a>";
		$( line[0]+"_state__" ).innerHTML="";
		$( line[0]+"_errmsg" ).innerHTML=(line[2]==null?"":"<a class='helpLink' onclick='showHelpTip(event, pc._data["+row+"][2], false); return false' href='javascript:void(0);'><img src='/html/nds/images/alert.gif' border='0'/></a>");
		var e, v;
		for(i=4;i< cols.length;i++){
			col= cols[i];
			if(col.isVisible){
				e=$(line[0]+"_"+ col.name);
				if(col.rTableId!=-1 && line[col.objIdPos]!=null && line[i]!=null){
					if(e.tagName.toLowerCase() =="span"){
						v="<a href='javascript:pc.fk("+ col.rTableId+","+ line[col.objIdPos] +")'>"+ line[i]+"</a>";
						this._setValue(e,v );
					}else{
						this._setValue(e,line[i] );
						v="<a href='javascript:pc.fk("+ col.rTableId+","+ line[col.objIdPos] +")'><img src='/html/nds/images/out.png' border='0'></a>";
						this._setValue(line[0]+"_fk"+ col.name,v );
					}
				}else{
					this._setValue(e,line[i] );
				}
			}
		}
		this._updateGridLineState(line);
	},
	/**
	 * change line css
	 */	
	chk:function(line0Value){
		var checked= $(line0Value+"_chk").checked==1;
		var re=$(line0Value+"_templaterow");
		if(checked) re.addClassName("checked");
		else re.removeClassName("checked");
	},
/**
	 * Copy from dwr.util.cloneNode, elimiate first "$" in ids when clone
	 */	
	_cloneNode:function(ele,options){
		ele = dwr.util._getElementById(ele, "cloneNode()");
		if (ele == null) return null;
		if (options == null) options = {};
	  	var clone = ele.cloneNode(true);
	  	if (options.idPrefix || otions.idSuffix) {
	    	this._updateIds(clone, options);
	  	}
	  	else {
	    	dwr.util._removeIds(clone);
	  	}
	  	$("grid_table").appendChild(clone);
	  	return clone;
	},
	_dwrcloneNode:function(ele,options){
	  ele = dwr.util._getElementById(ele, "cloneNode()");
	  if (ele == null) return null;
	  if (options == null) options = {};
	  var clone = ele.cloneNode(true);
	  if (options.idPrefix || options.idSuffix) {
	    dwr.util._updateIds(clone, options);
	  }
	  else {
	    dwr.util._removeIds(clone);
	  }
     	$("grid_table").appendChild(clone);
	  return clone;
	},	
	_updateIds :function(ele, options) {
	  if (options == null) options = {};
	  if (ele.id) {
	    ele.setAttribute("id", (options.idPrefix || "") + ele.id.replace(/\$/i,"") + (options.idSuffix || ""));
	  }
	  var children = ele.childNodes;
	  for (var i = 0; i < children.length; i++) {
	    var child = children.item(i);
	    if (child.nodeType == 1 /*Node.ELEMENT_NODE*/) {
	      this._updateIds(child, options);
	    }
	  }
	},	
	fk:function(tableId, objId){
		dlgo(tableId, objId);
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
			}
			$( line[0]+"_state__" ).innerHTML="<img src='/html/nds/images/line_"+line[1]+".gif' width='16' height='16'/>";
			dwr.util.setValue($(line[0]+"_chk" ),true);
		}
	},	
	deleteCxtabFiles:function(cxtabId){
		var evt={};
		evt.cxtabid=cxtabId;
		evt.command="DeleteCxtabFiles";
		evt.callbackEvent="DeleteCxtabFiles";
		this.executeCommandEvent(evt);    	
	},
	doDeleteFile:function(){
		var fm=$("myfolderfm");
		var v = fm.getInputs('checkbox', 'itemid');
		var i;
		var selectedFiles=Array();
		for(i=0;i< v.length;i++ ){
			if(v[i].checked)selectedFiles.push(v[i].value);
		}
		if(selectedFiles.length==0){
			alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
            return;	
		}
		var evt={};
		evt.files= selectedFiles;
		evt.command="DeleteFile";
		evt.callbackEvent="DeleteFile";
		this.executeCommandEvent(evt);    	
		
	},
	doRefreshMyFolder:function(){
		this.navigate("/html/nds/portal/myfolder.jsp");
	},
	/**
	for StoredProcedure,BeanShell,OSShell
	*/
	webaction:function(actionId, warn,target){
		if( (warn!=null && confirm(warn)) || warn==null){
			var evt={};
			evt.webaction= actionId;
			if(warn!=undefined && target!=null)evt.target=target;
			evt.command="ExecuteWebAction";
			evt.query=this.getQuery();
			evt.callbackEvent="ExecuteWebAction";
			this.executeCommandEvent(evt); 	
		}
	},
	/**
	Get current selection from ui, structure: data/selection(1,2,3), data/query(sql),data/id(for obj table),data/table(table id)
	*/
	getQuery:function(){
		var q={};
		q.selection=this._getSelectedItemIds();	
		q.query=Object.clone(this._gridQuery);
		q.table=this._tableObj.id;
		q.id=-1;
		return q;
	},
	/**
	 Add menu items from web action definition
	*/
	addListMenuItems:function(html){
		new Insertion.Bottom($("portal-dock-list-"+this._tableObj.id), html);
	},
	_onExecuteWebAction:function(e){
		var r=e.getUserData().data; 
		if(r.message && r.code !=3 && r.code!=4){
			msgbox(r.message.replace(/<br>/g,"\n"));
		}
		switch(r.code){
			case 1://refresh list
				this.refreshGrid();				
				break;
			case 2://refresh page
				//window.location.reload();	
				window.location.reload();	
				break;
			case 3://using message as url, and load target from user data
				var tgt=r.target;
				if(tgt==undefined || tgt==null) tgt="_blank";
				if( tgt.startsWith("_")){
					popup_window(r.message, tgt);
				}else{
					this.navigate(r.message, tgt);	
				}
				break;
			case 4:// message as javascript
				eval(r.message);
				break;
			case 99://close current page
				window.close();
				break;
		}
	},	
	/**
	* @param tn  table name or real url
	  @param tg, target of div to insert into, default to "portal-content"
	*/
	navigate:function(tn,tgt){
		if(tgt==undefined || tgt==null || tgt=='null') tgt="portal-content";
		if($(tgt)==null){
			alert( "div id="+ tgt+" not found");
			return;	
		}
		this._lastAccessTime= (new Date()).getTime();
		var url;
		if(tn.indexOf(".")<0){
			url= "/html/nds/portal/table.jsp?table="+tn;
		}else{
			url= tn;	
		}
		new Ajax.Request(url, {
		  method: 'get',
		  onSuccess: function(transport) {
		  	var pt=$(tgt);
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
		  	  		var pt=$(tgt);
		    		pt.innerHTML=transport.responseText;
		    		executeLoadedScript(pt);
		  	  	}
		  	//}catch(e){}
		  }
		});	
	},
	/**
	 * @param t 
	 * 	mainobjurl - record url,
		metadata: contains columns for table construction,
		query: gridQuery 
	 */
	setTableObj:function(t){
		this._lastAccessTime= (new Date()).getTime();
		this._tableObj=t;
		if(!t.actionMODIFY) this._defaultListMode=1;
		document.title= t.desc;
		var commands=new TableCommands(t);
		$("page-nav-commands").innerHTML=commands.toString();
		commands.initButtons();
		this._initGridSelectionControl();
		//load list
		this._initList();
		this.resize();
	},
	switchConfig:function(){
		showObject('/html/nds/query/qlc.jsp?table='+this._tableObj.id,null,null,{maxButton:false,closeButton:false})
	},
	/*
	   @param cxtabId ad_cxtab.id, if undefined, will retrieve from internval value
	*/
	refreshCxtabHistoryFiles:function(cxtabId){
		//load history
		if(cxtabId==null) cxtabId=this._cxtabId;
		else this._cxtabId=cxtabId;
		var url="/html/nds/cxtab/history_files.jsp?id="+cxtabId;
		new Ajax.Request(url, {
		  method: 'get',
		  onSuccess: function(transport) {
		  	var pt=$("history_files");
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
		  	  	}
		  	//}catch(e){}
		  }
		});			
	},
	/**
	 * @param q gridQuery only for cxtab
	 */
	initCxtabQuery:function(q){
		this._gridQuery= q;
	},
	/**
	 * Init list with GridInitObject defined
	 */
	_initList:function(){
		// prepare table body only for IE, see #_refreshGrid
		this._gridQuery= gridInitObject.query;
		this._gridQuery.dir_perm=this._defaultListMode;
		if($("switch-view-txt")!=null){
			$("switch-view-txt").innerHTML= (this._defaultListMode==1?gMessageHolder.MODIFY_VIEW:gMessageHolder.READ_ONLY_VIEW);
		}
		this._gridMetadata=gridInitObject.metadata;
		/*var q=Object.clone(this._gridQuery);
		q.callbackEvent="RefreshGrid";
		this._executeQuery(q);*/
		this.queryList();
		
	},
	getTableObj:function(){
		return this._tableObj;
	},
	setCxtabInput:function(cxtabInputId){
		this._cxtabInputId=cxtabInputId;
	},
	_isMultipleRowSelected:function(){
		var selectedIdx = this._getSelectedItemIdx();
		return !( (selectedIdx==null || selectedIdx.length < 2));
	},
	timeoutRefresh:function(){
		if($("timeoutBox")!=null){
			$("timeoutBox").style.visibility = 'hidden';
		}
		dwr.engine.abortAll();
		if($("list_query_form")!=null)toggleButtons($("list_query_form"),false);
	  	try{
			this.refreshGrid();
	  	}catch(e){}
	},
	timeoutWait:function(){
		if($("timeoutBox")!=null){
			$("timeoutBox").style.visibility = 'hidden';
		}
	},
	_executeQuery : function (queryObj) {
		this._lastAccessTime= (new Date()).getTime();
		if(queryObj.dir_perm==1){
			queryObj.resulthandler="/html/nds/portal/table_result.jsp";
		}else{
			queryObj.resulthandler=null;	
		}
//		queryObj.tryrecent=$("chk_tryrecent").checked?true:false;
		var s= Object.toJSON(queryObj);
		Controller.query(s, function(r){
				//try{
					if($("timeoutBox")!=null){
						$("timeoutBox").style.visibility = 'hidden';
					}
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
	executeCmdList:function(cmd){
		this._lastAccessTime= (new Date()).getTime();
	    if (cmd.indexOf("Delete")>=0 ){
	        if (!confirm(gMessageHolder.DO_YOU_CONFIRM_DELETE)) {
	            return false;
	        }
	    }
	    if (this._warningOnSubmit && cmd.indexOf("Submit")>=0 ){
	        if (!confirm(gMessageHolder.DO_YOU_CONFIRM_SUBMIT)) {
	            return false;
	        }
	    }
	    
	    if(this._tableObj.actionGROUPSUBMIT==true){
	    	if(cmd.indexOf("Submit")>=0 && this._isMultipleRowSelected() ){
		    	if (!confirm(gMessageHolder.DO_YOU_CONFIRM_GROUPSUBMIT)) {
		            return false;
		        }
	    	}
	    }
	    
	    $("list_form").command.value=cmd;
	    
	    toggleButtons($("list_query_form"),true);
		progressBar.showBar();
		progressBar.togglePause();
		this._isListPageLoaded=false;
		this._listPageLoadTime=0;
		setTimeout("pc.checkListPageLoaded();",2 * 1000);
		this._loadForm($("list_form"),"/control/command",null, function (xmlHttpReq) {
			var e=$("page-table-content");
			e.innerHTML = xmlHttpReq.responseText;
			executeLoadedScript(e);
			pc._isListPageLoaded=true;
			pc._stopListPageLoadingState();
		});
	    
	},
	/**
	 @return main table record ids selected in array
	*/
	_getSelectedItemIds:function(){
		var selectedIds=Array();
		var j;
		if(this._data==null){
			var cks=$("fm_list").getInputs('checkbox', 'itemid');
			for(var i=0;i<cks.length;i++){
				if( cks[i].checked){
				  	selectedIds.push(cks[i].value);
				}
			}	
		}else{
			for(j=0;j< this._data.length;j++){
				if( $(this._data[j][0]+"_chk").checked){
				  	selectedIds.push(this._data[j][4]);
				}
			}
		}
		return selectedIds;
	},
	/**
	* Replacement of /home/nds/js/common.js#getSelectedItemIdx, limit search within "list_data_form"
	* @return item ids of checkbox named "selectedItemIdx" if it is checked
	*/
	_getSelectedItemIdx:function(){
		var selectedIdx=Array();
		var j,i=0;
		if(this._data==null){
			var cks=$("fm_list").getInputs('checkbox', 'itemid');
			for(var i=0;i<cks.length;i++){
				if( cks[i].checked){
				  	selectedIdx[i++]= j;
				}
			}						
		}else{
			for(j=0;j< this._data.length;j++){
				if( $(this._data[j][0]+"_chk").checked){
				  	selectedIdx[i++]= j;
				}
			}
		}
		return selectedIdx;		
	},

	toggleSubTotal:function(){
		//var b= dwr.util.getValue($("chk_select_all_fullrange"));
		$("chk_select_all_fullrange").checked=0;
		var q=Object.clone(this._gridQuery);
		q.subtotal=true;
		q.callbackEvent="RefreshGrid";
		this._executeQuery(q);
		
	},
/**
	 * copy row information to object
	 * @line0 just the main object id,will search for row whose first element equals line0
	 */
	editLine:function(line0){
		var i,row=-1;
		if(this._data==null){
			showObject2(gridInitObject.mainobjurl+line0, this._dialogOption);
		}else{
			for(i=0;i< this._data.length;i++){
				if(this._data[i][0]==line0){
					row=i;
					break;
				}
			}
			if(row==-1) return;
			this.editRow(row);
		}
	},	
	/**
	 * copy row information to object
	 * @row index in data
	 */
	editRow:function(row){
		var line= this._data[row];
		if(["D","E","N"].indexOf(line[1])>-1) return;
		 (gridInitObject.mainobjurl+line[4],this._dialogOption);
	},
	mo:function(tid){
		if($(tid+"_p_step")!=null){
			var p_step=$(tid+"_p_step").value;
			if($(tid+"_iscomplete").value=="Y"){
				showObject2(gridInitObject.mainobjurl+tid+"&nextstep="+p_step+"&p_nextstep=-2",this._dialogOption);
			}else{
				showObject2(gridInitObject.mainobjurl+tid+"&p_nextstep="+p_step,this._dialogOption);
			}
		}else{
		showObject2(gridInitObject.mainobjurl+tid,this._dialogOption);
		}
	},
	auditObj:function(urlaudit){
		showObject2(urlaudit,{onClose:new Function('pc.navigate("/html/nds/audit/view.jsp");')});
  },
	/**
	 * mark all check box checked
	 */
	selectAll:function(){
		var i;
		var b= dwr.util.getValue($("chk_select_all"));
		if(this._data==null){
			this.checkAll("fm_list");
		}else{
			for(i=0;i< this._data.length;i++){
				if(["D","E","N"].indexOf(this._data[i][1])>-1) continue;
				 dwr.util.setValue($(this._data[i][0]+"_chk"), b);
				var re=$(this._data[i][0]+"_templaterow");
				if(b) re.addClassName("checked");
				else re.removeClassName("checked");
			}
		}
	},
	checkAll:function(fm){
		var ca=$("chk_select_all");
		ca.checked = ca.checked|0;
		var ck= ca.checked;
		var cks=$(fm).getInputs('checkbox', 'itemid');
		for(var i=0;i<cks.length;i++){
			cks[i].checked= ck;
		}
	},
	unselectall:function(){
	 	dwr.util.setValue($("chk_select_all"), false);
	},
	/**
	 * In audit/view.jsp
	 */
	submitAuditForm:function(act){
		var evt={};
		if(act=='assign' || act=='setout'){
		 	var v=$("assignee").value;
	 		if (v==null || v.length==0){
	 		 	alert(gMessageHolder.PLEASE_SETUP_ASSIGNEE);
	 		 	return false;
	 		 }
	 		 evt.assignee=v;
	 	}
	 	if($("auditActionType").value=="auditAction")
			evt.auditAction= act;
		else{
			evt.auditSetupAction= act;
		}
		evt.command=$("command").value;
		evt.callbackEvent="ExecuteAudit";
		evt.parsejson="Y"; // to normal event 
		if($("comments")!=null)evt.comments=$("comments").value;
		var itemids= $("form1").getInputs("checkbox","itemid");
		var iids=new Array();
		for(var i=0;i<itemids.length;i++ )
			if(itemids[i].checked) iids.push(itemids[i].value);
		evt.itemid= iids;
		this.executeCommandEvent(evt);    	
	 	
	},
	/***
	* Invoke by buttons, include btn_begin,btn_next,btn_prev,btn_end
	@param t id of the button
	*/
	scrollPage: function (t) {
		//var t=event.target.id;
		var s;
		var qr=Object.clone(this._gridQuery);
		var qs=qr.start;
		var qrange=parseInt( $("range_select").value,10);
		var qtot=qr.totalRowCount;
		if(t=="begin_btn")s=0;
		else if(t=="prev_btn") s= qs-qrange;
		else if(t=="next_btn") s= qs+qrange;
		else if(t=="end_btn") s= qtot-qrange;
		else s= qs;
		
		qr.start=s;
		qr.range=qrange;
		this._gridQuery.range=qrange;
		this._executeQuery(qr);
	},
	/**
	 * Switch view for modification and read-only
	 */
	switchView:function(){
		if(this._gridQuery.dir_perm==3){
			this._gridQuery.dir_perm=1;
			$("switch-view-txt").innerHTML= gMessageHolder.MODIFY_VIEW;
		}else{
			this._gridQuery.dir_perm=3;
			$("switch-view-txt").innerHTML= gMessageHolder.READ_ONLY_VIEW;
		}
		this.refreshGrid();
	},
	/**
	 * Reorder grid query
	 * @param columnId the column id that will be ordered by, if the same as old
	 * order by column, will toggle asc and desc, else do asc 
	 */
	orderGrid: function(columnId){
		if(this._checkDirty()==false){
			var oldOrderBy=this._gridQuery.order_columns;
			var oldAsc=this._gridQuery.order_asc;
			if(oldOrderBy==columnId ){
				this._gridQuery.order_asc=!oldAsc;
			}else{
				var ele=$("title_"+oldOrderBy);
				if(ele!=null)ele.innerHTML="";
				this._gridQuery.order_columns=columnId;
				this._gridQuery.order_asc=true;
			}		
			this._executeQuery(this._gridQuery);
		}
	},
	/**
	* export 
	*/
	exportGrid:function(){
		this._submitToNewWindow("/html/nds/reports/create_report.jsp");
		
	},
	analyzeGrid:function(){
		this._submitToNewWindow("/html/nds/cxtab/quickview.jsp");
	},
	/**
	* create query request and execute query
	*/
	refreshGrid: function () {
		if(this._checkDirty()==false)
			this._executeQuery(this._gridQuery);
	},
	/**
	 * @return false if discard modification or not dirty
	 */
	_checkDirty: function(){
		if(this._isDirty){
        	return !confirm(gMessageHolder.CONFIRM_DISCARD_CHANGE) ;
		}
		return false;
	},
    _submitToNewWindow:function(resulthandler){
		var fm= $("export_form");
		$("exp_resulthandler").value=resulthandler; 
		$("query_json").value=Object.toJSON(this._gridQuery);
		fm.submit();
		/*var url=fm.readAttribute('action')+"?"+fm.serialize();
		//http://support.microsoft.com/kb/q208427/, Maximum URL length is 2,083 characters in Internet Explorer
		if(url.length>2080 && Prototype.Browser.IE)
			fm.submit();
		else{
			showObject(url);
		}*/
    },
    unselecListAll:function(){
    	var e=$("chk_select_all");
    	if(e!=null && e.checked){
    		dwr.util.setValue(e,false);
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
    /* On event returned from server
    */
    _onListDelete:function(e){
		this._onListOperation(e,true);
    },
	/**
	Note this function will be called by objcontrol.js
	@param evt the evt object to fill
	@return boolean whether there's data to handle or not
	*/
	fillProcessEvent:function(evt){
		var meta=this._gridMetadata;
		var i; 
		evt.parsejson="N";
		evt.column_masks=meta.column_masks;
		evt.table=meta.table;
		evt.fixedColumns= this._fixedColumnsStr;
		evt.bestEffort=true;//each line will have a seperate transaction
		evt.addList=[];
		evt.modifyList=[];
		evt.deleteList=[];
		//evt.submitList=this._getSelectedItemIds();
		var hasData=false;
		for(i=0;i< this._data.length;i++){
			var line= this._data[i];
			if(line[1]=="M"){
				// modify
				evt.modifyList.push(this._getArrayOfRow(i,line, meta.columnsWhenModify));
				hasData=true;
			}
		}
		evt.queryRequest=this._gridQuery;
		/**
		 for ahyy project, will do encryption for table named B_V2_PRJ_TOKEN
		*/
		if(hasData && meta.table=='B_V2_PRJ_TOKEN'){
			usbkey.ahyyEncryptPrice(evt);	
		}
		return hasData;	
	},    
    doModify:function(){
    	if(this._gridQuery.dir_perm==1){
    		alert(gMessageHolder.PLEASE_SWITCH_TO_MODIFY_VIEW);
    		return;
    	}
		if(this._checkInputs()==false) return;
		var evt={};
		evt.command="UpdateGridData";
		evt.callbackEvent="UpdateGrid";
		try{
			var hasData=this.fillProcessEvent(evt);
			if(!hasData){
				msgbox(gMessageHolder.NO_DATA_TO_PROCESS);
				return;
			}
			this.executeCommandEvent(evt);    
		}catch(e){
			alert(e.message);	
		}
    },
	
	/**
	 * @return false if object panel contains invalid data
	 */
	_checkInputs: function(){
		var cols=this._gridMetadata.columns,i,col, j;
		var blank,ele,d,line;
		for(j=0;j< this._data.length;j++){
			line=this._data[j];
			if(line[1]=="M"){
				for(i=4;i< cols.length;i++){
					col= cols[i];
					if(col.isVisible&& col.isUploadWhenModify){
						ele= this._data[j][0]+"_"+ col.name;
						d= line[i];
						if(this._checkInput(col,d,ele)==false) return false;
					}
				}
			}
		}
		return true;	
	},
	/**
	 * @param col GridColumn
	 * @param ele Element for input
	 * @return false if contains invalid data
	 */
	_checkInput: function(col,d,ele){
		//var d=String(dwr.util.getValue( ele)); (String(d))=="" ||(
		var blank= (d==null || d=="" ||(String(d)).blank());
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
    _submitWithoutUpdate:function(){
		var evt={};
		evt.command="ListSubmit";
		evt.callbackEvent="ListSubmit";
		evt.table=this._tableObj.id;
		evt.itemid=this._getSelectedItemIds();
		if(evt.itemid.length==0){
 			alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
            return;				
		}
		this.executeCommandEvent(evt);    	
    },
    /**
     * Do submit when at least has one line checked. Will confirm all rows update successfully
     * before submit. Any row that failed to update will stop all rows from submiting
     */
    doSubmit:function(){
    	if(this._warningOnSubmit){
    		if (!confirm(gMessageHolder.DO_YOU_CONFIRM_SUBMIT)) {
            	return;
        	}	
    	}
		if(this._gridQuery.dir_perm==1){
			this._submitWithoutUpdate();
    	}else{
    		try{
				var evt={};
				var hasData=this.fillProcessEvent(evt);
				if(!hasData){
					this._submitWithoutUpdate();
				}else{
					evt.command="UpdateGridData";
					evt.callbackEvent="UpdateGrid";
					evt.submitList=this._getSelectedItemIds();
					if(evt.submitList.length==0){
						alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES_FOR_SUBMIT);
			            return;	
					}else{
						this.executeCommandEvent(evt);    
					}
				}
			}catch(e){
				alert(e.message);	
			}
    	}
			
    },
	doAdd:function(){
    	showObject2(gridInitObject.mainobjurl+"-1",this._dialogOption);
    },
    doDelete:function(){
		var evt={};
		evt.command="ListDelete";
		evt.callbackEvent="ListDelete";
		evt.table=this._tableObj.id;
		evt.itemid=this._getSelectedItemIds();
		if(evt.itemid.length==0){
 			alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
            return;				
		}
        if (!confirm(gMessageHolder.DO_YOU_CONFIRM_DELETE)) {
            return;
        }
		this.executeCommandEvent(evt);    	
    },    
    doListAdd:function(){
    	popup_window("/html/nds/objext/object_batchadd.jsp?table="+this._tableObj.id);
    },
    doSmsList:function(){
    	this._submitToNewWindow("/html/nds/reports/create_sms_report.jsp");
    },
    doUpdate:function(){
    	this._submitToNewWindow("/html/nds/objext/batchupdate.jsp");
    },
    doExportList:function(){
    	this._submitToNewWindow("/html/nds/reports/create_report.jsp");
    },
	/**
     * @param filetype html (default) or xls
     */
    doJReportOnSelection:function(tableId, filetype){
		//do query according to search form
		var fm=$("list_query_form");
	    toggleButtons($("list_query_form"),true);
	    this._gridQuery.param_str= fm.serialize();
		var evt={};
		evt.command="ExecuteJReport";
		evt.callbackEvent="ExecuteCxtab";
		evt.table=tableId;
		evt.query=Object.toJSON(this._gridQuery);
		evt.cxtab= $("rep_templet").value;
		evt.filetype= filetype;
		this.executeCommandEvent(evt);
    },    
    modifyrep:function(){
    	var	cxtabId=$("rep_templet").value;
    	showObject2("/html/nds/cxtab/cxtabdef.jsp?id="+cxtabId,{onClose:function(){pc.qrpt(cxtabId);}});
    },
    /**
     * @param filetype html (default) or xls
     */
    doReportOnSelection:function(bIsOnSelection,tableId, filetype){
    	var	cxtabValue=$("rep_templet").value;
    	var tableValue =null;
    	if(tableId==undefined || tableId ==null || isNaN(tableId)){
    		tableValue=this._tableObj.id;
    	}else{
    		tableValue=tableId;
    	}
		//do query according to search form
		var fm=$("list_query_form");
	    toggleButtons($("list_query_form"),true);
	    if(bIsOnSelection)
		    this._gridQuery.param_str= fm.serialize();

		var evt={};
		evt.command="ExecuteCxtab";
		evt.callbackEvent="ExecuteCxtab";
		evt.table=tableValue;
		evt.query=Object.toJSON(this._gridQuery);
		evt.cxtab= cxtabValue;
		//if(filetype!="xls") filetype="htm";
		evt.filetype= filetype;
		this.executeCommandEvent(evt);
    	
    },
	queryList:function(){
		
		var fm=$("list_query_form");
	    toggleButtons($("list_query_form"),true);
	    if(this.hasValueInput(fm))
	    	this._gridQuery.param_str2= fm.serialize();
	    else
	    	this._gridQuery.param_str2= "";
	    this._gridQuery.start=0;
		this._executeQuery(this._gridQuery);
	},
	/**
	check is there any input has value set from ui
	*/
	hasValueInput:function(fm){
		var inputs = fm.getInputs('text');
		for (var i = 0, length = inputs.length; i < length; i++) {
      		var input = inputs[i];
      		if(!input.value.blank()) return true;
    	}
    	inputs=fm.getElementsByTagName('select');
    	for (var i = 0, length = inputs.length; i < length; i++) {
      		var input = inputs[i];
      		if(dwr.util.getValue(input)!="0") return true;
    	}
    	return false;
	},
	doRefresh:function(){
		this.refreshGrid();
	},
    doReport:function(){
		this.doReportOnSelection(false);
	},
    doPrintList:function(){
    	this._submitToNewWindow("/html/nds/print/options.jsp");
    },
    doImport:function(){
    	showObject2("/html/nds/objext/import_excel.jsp?table="+this._tableObj.id,pc._dialogOption);
		/*if(Prototype.Browser.IE)
			showObject2("/html/nds/objext/import_excel.jsp?table="+this._tableObj.id,pc._dialogOption);
		else
			popup_window("/html/nds/objext/import_excel.jsp?table="+this._tableObj.id);
		*/	

    },
	doListCopyTo:function(){
		this._doActionOnSelectedItems("/html/nds/objext/copyto.jsp?src_table="+this._tableObj.id);
	},
	doUpdateSelection:function(){
		this._doActionOnSelectedItems("/html/nds/objext/selectedupdate.jsp?table="+this._tableObj.id);
	}, 
	doUpdateResultSet:function(){
		this._submitToNewWindow("/html/nds/objext/batchupdate.jsp");
	},
	/**
	 * Show url as in popup dialog, this is called when portal page first loaded
	 */
	welcome:function(url){
		showObject(url,null,null,{maxButton:false,closeButton:true});
	},
	_doActionOnSelectedItems:function(uri){
        var selectedIds = this._getSelectedItemIds();
        if (selectedIds==null || selectedIds.length ==0) {
            alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
            return false;
        }
		if(selectedIds.length>20){
			alert(gMessageHolder.PLEASE_SELECT_LINES_LESS_THAN);
			return false;
		}
	    var objectIds=selectedIds.join(",");	        
		showObject2(uri+ "&objectids="+encodeURIComponent(objectIds),this._dialogOption);

	},
    printDocument:function(){
    	this._submitToNewWindow("/html/nds/print/options.jsp");
    },
	_stopListPageLoadingState:function(){
		progressBar.togglePause(); 
		progressBar.hideBar();
		toggleButtons($("list_query_form"),false);
	},
	checkListPageLoaded:function(){
  		if(this._isListPageLoaded==true || this._listPageLoadTime>15){
  			if(this._listPageLoadTime>15){
  				alert(gMessageHolder.TIME_OUT);
  			}
  			this._stopListPageLoadingState();
  		}else{
  			this._listPageLoadTime=this._listPageLoadTime+1;
  			setTimeout("pc.checkListPageLoaded();",2 * 1000);
  		}
     },
     /**
     * Init list table to handle selection action
     */
    _initGridSelectionControl:function(){
    	var isMultiSelectEnabled=false;
		selTb= new SelectableTableRows(document.getElementById("inc_table"), isMultiSelectEnabled);// set as global object
		/*if(isMultiSelectEnabled ){
			prevSelected=selTb.getSelectedItems(); // set as global object
    		selTb.onchange = function () {
	        	// remove previous selected on
	        	var i,j,bUnSelected,bSelected, idx;
	        	var curSelected=  selTb.getSelectedItems();
	        	
	        	for(i=0;i<prevSelected.length;i++){
	        		bUnSelected=true;
	        		for(j=0;j<curSelected.length;j++){
	        			if(prevSelected[i]==curSelected[j]){
	        				bUnSelected=false;
	        				break;
	        			}
	        		}
	        		if(bUnSelected){
	        			// if multiple choice, find first column's checkbox and unset
	        			//try{
		        			$(prevSelected[i].id.replace(/templaterow/g,"chk")).checked=0;
	        			//}catch(ex){}
	        		}
	        	}
	        	for(i=0;i<curSelected.length;i++){
	        		bSelected = false;
	        		for(j=0;j<prevSelected.length;j++){
	        			if(prevSelected[j]==curSelected[i]){
	        				bSelected=true;
	        				break;
	        			}
	        		}
	        		if(!bSelected){
	        			//try{
	        				$(curSelected[i].id.replace(/templaterow/g,"chk")).checked=1;
	        			//}catch(ex){}
	        		}
	        	}
	        	pc.unselecListAll();
	        	prevSelected=curSelected;
       		};
       	}// end if(isMultiSelectEnabled
       	*/
		selTb.ondoubleclick=function(trElement){
			pc.editLine(trElement.id.replace(/_templaterow/i, ""));
		};
    },
	_loadForm:function(fm, fmAction, elId, returnFunction) {
		this._lastAccessTime= (new Date()).getTime();
		fm.request({
			onComplete:returnFunction }
		);
	},
	
     
	/**
	* Request server handle command event
	* @param evt CommandEvent
	*/
	executeCommandEvent :function (evt) {
		this._lastAccessTime= (new Date()).getTime();
		showProgressWindow(true);
		Controller.handle( Object.toJSON(evt), function(r){
				//try{
					var result= r.evalJSON();
					if (result.code !=0 ){
						msgbox(result.message);
				    	if($("list_query_form")!=null)toggleButtons($("list_query_form"),false);
					}else {
						var evt=new BiEvent(result.callbackEvent);
						evt.setUserData(result); // result.data
						application.dispatchEvent(evt);
					}
				/*}catch(ex){
					msgbox(ex.message);
				}*/
			
		});
	},
	/*function control show hide navigation menu on the left hand side
	  a modified version of resize is used to control the resize of right hand side table
	*/
	menu_hl:function(state){
   if(state==1){
	   	//jQuery("#leftToggler").css("background-color","#678FC2");
	   	jQuery("#leftToggler").attr("class",(jQuery("#portal-menu").css("display")=="block" )?"leftToggler1":"leftToggler3");
	} else {
	   	//jQuery("#leftToggler").css("background-color","#C3D9FF");
	   	jQuery("#leftToggler").attr("class",(jQuery("#portal-menu").css("display")=="block" )?"leftToggler":"leftToggler2");
	}
	},
	menu_toggle:function(e){
   e.blur();
   if(jQuery("#portal-menu").css("display")=="block" ){
		jQuery("#leftToggler").height(jQuery("#leftToggler").height()-5);
		jQuery("#portal-menu").css("display","none"); 
		//jQuery("#separator-icon").attr("src","/html/nds/themes/classic/01/images/arrow-right.gif");
		jQuery("#leftToggler").attr("class","leftToggler2");
		pc.resize();
	}else{
		jQuery("#portal-menu").css("display","block");
		jQuery("#leftToggler").height("100%");
		//jQuery("#separator-icon").attr("src","/html/nds/themes/classic/01/images/arrow-left.gif");
		jQuery("#leftToggler").attr("class","leftToggler");
		pc.resize();
	}
   	$('portal-bottom').focus();
 }
};
// define static main method
PortalControl.main = function () {
	pc=new PortalControl();
	// handling resize table in firefox3
	//if(Prototype.Browser.Gecko){
		Event.observe(window, "resize", pc.resize);
	//}
	webFXTreeConfig.autoExpandAll=true;
 	var tree=pc.createTree("在线店务","/pos/menu.xml.jsp", null);

};

/**
* Init
*/
/*if (window.addEventListener) {
  window.addEventListener("load", PortalControl.main, false);
}
else if (window.attachEvent) {
  window.attachEvent("onload", PortalControl.main);
}
else {
  window.onload = PortalControl.main;
}*/
jQuery(document).ready(PortalControl.main);

function msgbox(msg, title, boxType ) {
	showProgressWindow(false);
	alert(msg);
}
/**
* Show table object info
*/
function dlgo(tableId, objId){
	showObject2("/html/nds/object/object.jsp?table="+tableId+"&id="+objId,pc._dialogOption);
}
function refreshPortalGrid(){
	var gridTableBody=$("grid_table"); //for audit form, there's no grid table
	if(gridTableBody!=null)pc.refreshGrid();
}
function showProgressWindow(bShow){
	
}
function debug(message, stacktrace){
	dwr.engine._debug(message, stacktrace);
}

function pop_up_or_clear(src, url, window_name, sObjectID){
	var oWorkItem = src;
	if ( oWorkItem.name=="popup"){
	  popup_window(url,window_name);
	}else{
	  document.getElementById(sObjectID + "_link").name="popup"; // reset to popup
	  try{document.getElementById(sObjectID+"_expr").value="";}catch(ex){}
	  try{document.getElementById(sObjectID+"_sql").value="";}catch(ex){}
	  document.getElementById(sObjectID+"_img").src=NDS_PATH+"/images/find.gif";
	  document.getElementById(sObjectID+"_img").alt=gMessageHolder.OPEN_NEW_WINDOW_TO_SEARCH;
	  document.getElementById(sObjectID).value="";
	}
}
function showObject2(url,option, theWidth, theHeight,option){
	if( theWidth==undefined) theWidth=956;
    if( theHeight==undefined) theHeight=570;
    if(theWidth==-1){
    	//full screen
    	theWidth=screen.availWidth;
    	theHeight=screen.availHeight;
    }
	var options=$H({width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE, modal:true,centerMode:"x",noCenter:true,maxButton:true});
	if(option!=undefined) options.merge(option);
	else option={};
	if(option.iswindow==true){
		popup_window(url,options.target, options.width,options.height);
	}else{
		Alerts.popupIframe(url,options);
		Alerts.resizeIframe(options);
		Alerts.center();
	}
}
function showObject(url, theWidth, theHeight,option){
	if( theWidth==undefined || theWidth==null) theWidth=956;
    if( theHeight==undefined|| theHeight==null) theHeight=570;
	var options={width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE, modal:true,centerMode:"x",noCenter:true,maxButton:true};
    if(option!=undefined) 
    	Object.extend(options, option);
	Alerts.popupIframe(url,options);
	Alerts.resizeIframe(options);
	Alerts.center();
}
var selTb;
var prevSelected;

/**
  Each time this function called, will compare last access time with current one, if greater than minutesForInactive, will logout forcefully
*/
function checkTimeoutForPortal(secondsForInactive){
	var d=(new Date()).getTime();
	if( (pc._lastAccessTime + secondsForInactive * 1000) < d){
		//logout without notification
		//refresh page forcefully
		window.location="/c/portal/logout";
	}
}