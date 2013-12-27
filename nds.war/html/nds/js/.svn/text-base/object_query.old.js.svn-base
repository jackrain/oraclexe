/**
 * import application.js, alerts.js,dwr.js,prototype.js
 * t
 */

var selTb;
var prevSelected;
var isMultiSelectEnabled=false;
var result_accepter_id;
var oq;
var ObjectQuery = Class.create();
var dqComboboxes=null;
ObjectQuery.prototype = {
	initialize: function() {
		this._gridQuery=null; // QueryObject 
		this._accepter_id=null; //id of input control that accepts query result
		this._mainobjurl=null; // object url
		this._returnType="s"; // default to single
		application.addEventListener( "QueryObject", this._onQueryObject, this);
		application.addEventListener( "ReturnSQL", this._onReturnSQL, this);
		
	},
	/**
	 * Popup search form or clear input according to $(acceptor_id+"_link").name, if name is "popup", then do poup,
	 * else clear input. if $(acceptor_id+"_link") not exists, just show search form(single obj)
	 * accepter_id id of input control that accepts query result
	 */
	toggle: function(url, accepter_id) {
		var l= $(accepter_id+"_link");
		if( l==null || (l!=null &&l.title=="popup")){
			this._gridQuery=null;
			this._accepter_id=accepter_id;
			var popup = Alerts.fireMessageBox({
					width: 620,modal:true,noCenter: true,title: gMessageHolder.SEARCH,
					onClose: function() {}
				});
			//AjaxUtil.update(url, popup, null);
			new Ajax.Request(url, {
			  method: 'get',
			  onSuccess: function(transport) {
			  	var pt=$(popup);
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
			  	  		var pt=$(popup);
			    		pt.innerHTML=transport.responseText;
			    		executeLoadedScript(pt);
			  	  	}
			  	//}catch(e){}
			  }
			});	
		}else{
			$(accepter_id+ "_link").title="popup"; // reset to popup
	      	$(accepter_id+ "_img").src="/html/nds/images/find.gif";
		    $(accepter_id+ "_img").alt="";
	      	$(accepter_id).value="";
	      	$(accepter_id).readOnly=false;
	      	$(accepter_id+ "_sql").value="";
			var obj=$(accepter_id+ "_expr");
			if( obj !=null){
		    	obj.value= "";
		    }
		}

	},
	/**
	 * @param queryObject properties: table (name), table_id,table_desc,
	 * column_masks,start,range,init_query,dir_perm
	 * @param objURL url for loading record
	 * @param returnType "m" (multiple) or "s" (single)
	 */
	setQueryObject:function(queryObject, objURL, rtnType){
		this._gridQuery=queryObject;
		this._gridQuery.callbackEvent="QueryObject";
		this._gridQuery.returnType= rtnType;
		this._returnType= rtnType;
		this._initGridSelectionControl();
		this._mainobjurl= objURL;
		var te=$("pop-up-title-0");
		if(te){
			te.innerHTML=gMessageHolder.SEARCH + " - " + queryObject.table_desc;
		}
		if(rtnType=="s"){
			var e=$("btn-rsql");
			if(e)e.hide();
			e=$("btn-sql");
			if(e)e.hide();
			e=$("qcsa");
			if(e)e.hide();
		}
	},
	search:	function(){
		var fm=$("q_form");
	    this._gridQuery.param_str= fm.serialize();
		this._executeQuery(this._gridQuery);
	},
	returnSQL:function(){
		var fm=$("q_form");
	    var queryObj= Object.clone(this._gridQuery);
	   	queryObj.param_str= fm.serialize();
	    queryObj.callbackEvent="ReturnSQL";
	    queryObj.noresult=true;
	    queryObj.resulthandler="/html/nds/query/search_result_sql.jsp";
	    
		this._executeQuery(queryObj);
	},
	/**
	 * @return single row ak
	 */
	returnRow:function(ele){
      	$(this._accepter_id).value=ele.alt;
		this.close();
	},
	returnValue:function(){
		var selectedIds=Array();
		var selectedAKs=Array();
		var j;
		var cks=$("q_fm_list").getInputs('checkbox', 'itemid');
		for(var i=0;i<cks.length;i++){
			if( cks[i].checked){
			  	selectedIds.push(cks[i].value);
			  	selectedAKs.push(cks[i].id);
			}
		}
		if(selectedIds.length==0){
 			alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
            return;				
		}
		var sql= " IN ("+selectedIds.join(",")+")";
		var sqlDesc= gMessageHolder.CONTAINS+" ("+ selectedAKs.join(",")+")";
		this.returnQuery(sql, sqlDesc, null);
	},
	returnQuery:function(sql,sqlDesc,sqlExpr){
		$(this._accepter_id+ "_link").title="clear"; // reset to popup
      	$(this._accepter_id+ "_img").src="/html/nds/images/clear.gif";
	    $(this._accepter_id+ "_img").alt=gMessageHolder.CLEAR_CONDITION;
      	$(this._accepter_id).value=sqlDesc;
     	$(this._accepter_id).readOnly=true;
      	$(this._accepter_id+ "_sql").value=sql;
		var obj=$(this._accepter_id+ "_expr");
		if( obj !=null){
	    	obj.value= sqlExpr;
	    }
		this.close();				
	},
	close:function(){
		window.setTimeout("Alerts.killAlert(document.getElementById('pop-up-title-0'))",1);
	},
	onSearchReturn :function(event) {
	  if (!event) event = window.event;
	  if (event && event.keyCode && event.keyCode == 13) this.search();
	},
	_onReturnSQL:function(e){
		var qr=e.getUserData().data; 
//		alert(qr.pagecontent);
		if(qr.pagecontent!=null){
			eval(qr.pagecontent);
			/*var div=$("q_eval");
			div.innerHTML=qr.pagecontent;
			executeLoadedScript(div);
			alert("executed");*/
		}
	},
	_toggleButtons:function(disable){
		if(disable){
			$("btn-search").disable();
			//$("btn-rsql").disable();
			$("btn-value").disable();
			$("btn-search").disable();
			$("btn-sql").disable();
		}else{
			$("btn-search").enable();
			//$("btn-rsql").enable();
			$("btn-value").enable();
			$("btn-search").enable();
			$("btn-sql").enable();
		}
	},
	/**
	*Reload grid data according to query result
	* @param qr QueryResult.toJSONObject()
	*/
	_onQueryObject:function(e){
		var qr=e.getUserData().data; 
		var rowCount=qr.rowCount;
		var i,s,a;
		var q=this._gridQuery;
		s=qr.start;
		q.start= s;
			// data insert by html
		if(qr.pagecontent!=null){
			this._data=null;
			if(Prototype.Browser.IE){
				// ie does not support setting innerHTML in tbody
				var div=$("q_embed_lines");
				var te=div.innerHTML;
				var p= te.indexOf("<!--$QGRIDTABLE_START-->");
				var pe= te.indexOf("<!--$QGRIDTABLE_END-->");
				var pstr=te.substring(0, p+ "<!--$QGRIDTABLE_START-->".length);
				var pestr=te.substr(pe);
				var newDiv=pstr.concat("<tbody id='q_grid_table'>",qr.pagecontent,"</tbody>",pestr);
				div.innerHTML=newDiv;
				executeLoadedScript(div);
				this._initGridSelectionControl();
				
			}else{
				var gridTableBody=$("q_grid_table");
				dwr.util.removeAllRows(gridTableBody);
				gridTableBody.innerHTML=qr.pagecontent;
				executeLoadedScript(gridTableBody);
			}
		}
		this._syncGridControl(qr);
		var desc=  qr.queryDesc;
		if(qr.message !=undefined && qr.message!=null) desc+= "<br><blink><span class='err'>***"+ qr.message+"</blink>";
		$("q_filter_setting").innerHTML= desc;
		dwr.util.setValue($("q_chk_select_all"),false);
		$("query-data").show();
	},
	_syncGridControl:function(qr){
		this._gridQuery.totalRowCount=qr.totalRowCount;
		this._gridQuery.start=qr.start;
		//this._gridQuery.range=qr.range;
		//dwr.util.setValue("range_select", qr.range);
		if( this._gridQuery.order_columns!=null){
			var ele=$("q_title_"+this._gridQuery.order_columns);
			if(ele!=null){
				ele.innerHTML="<img src='/html/nds/images/"+( this._gridQuery.order_asc?"up":"down")+"simple.png'>";
			}
		}
		if($("q_txtRange")!=null){
			$("q_txtRange").innerHTML=((qr.start+1)+"-"+ (qr.start+qr.rowCount)+"/"+ qr.totalRowCount);
			if(qr.start>0){
				 $("q_begin_btn").setEnabled(true);
				 $("q_prev_btn").setEnabled(true);
			}else{
				 $("q_begin_btn").setEnabled(false);
				 $("q_prev_btn").setEnabled(false);
			}
			if((qr.start+qr.rowCount)< qr.totalRowCount){
				 $("q_next_btn").setEnabled(true);
				 $("q_end_btn").setEnabled(true);
			}else{
				 $("q_next_btn").setEnabled(false);
				 $("q_end_btn").setEnabled(false);
			}
		}
	},		
	_executeQuery : function (queryObj) {
		$("q_progress").show();
	    this._toggleButtons(true);
		var s= Object.toJSON(queryObj);
		Controller.query(s, function(r){
				var result= r.evalJSON();
				if (result.code !=0 ){
					$("q_progress").hide();
				    oq._toggleButtons(false);
					msgbox(result.message);
				}else {
					var evt=new BiEvent(result.callbackEvent);
					evt.setUserData(result);
					application.dispatchEvent(evt);
					$("q_progress").hide();
				    oq._toggleButtons(false);
				}
		  	}		
		);
	},		
     /**
     * Init list table to handle selection action
     */
    _initGridSelectionControl:function(){
		var tb= new SelectableTableRows(document.getElementById("q_inc_table"), false);// set as global object
		if(this._returnType=="m"){
			tb.ondoubleclick=function(trElement){
				oq.mo(trElement.id.replace(/_qtemplaterow/i, ""));
			};
		}else{
			tb.ondoubleclick=function(trElement){
				$(oq._accepter_id).value=$("chk_obj_"+trElement.id.replace(/_qtemplaterow/i, "") ).alt;
				oq.close();
			};
		}
    },
	fk:function(tableId, objId){
		popup_window("/html/nds/object/object.jsp?table="+tableId+"&id="+objId);
	},
    mo:function(tid){
		popup_window(this._mainobjurl+tid);
	},
	/**
	* create query request and execute query
	*/
	refreshGrid : function () {
		this._executeQuery(this._gridQuery);
	},	
	/**
	 * Reorder grid query
	 * @param columnId the column id that will be ordered by, if the same as old
	 * order by column, will toggle asc and desc, else do asc 
	 */
	orderGrid: function(columnId){
		var oldOrderBy=this._gridQuery.order_columns;
		var oldAsc=this._gridQuery.order_asc;
		if(oldOrderBy==columnId ){
			this._gridQuery.order_asc=!oldAsc;
		}else{
			var ele=$("q_title_"+oldOrderBy);
			if(ele!=null)ele.innerHTML="";
			this._gridQuery.order_columns=columnId;
			this._gridQuery.order_asc=true;
		}		
		this._executeQuery(this._gridQuery);
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
		var qrange=parseInt( $("q_range_select").value,10);
		var qtot=qr.totalRowCount;
		if(t=="q_begin_btn")s=0;
		else if(t=="q_prev_btn") s= qs-qrange;
		else if(t=="q_next_btn") s= qs+qrange;
		else if(t=="q_end_btn") s= qtot-qrange;
		else s= qs;
		
		qr.start=s;
		qr.range=qrange;
		this._gridQuery.range=qrange;
		this._executeQuery(qr);
	},	
	/**
	 * mark all check box checked
	 */
	selectAll:function(){
		var ca=$("q_chk_select_all");
		ca.checked = ca.checked|0;
		var ck= ca.checked;
		var cks=$("q_fm_list").getInputs('checkbox', 'itemid');
		for(var i=0;i<cks.length;i++){
			cks[i].checked= ck;
		}
	},
	unselectall:function(){
	 	dwr.util.setValue($("q_chk_select_all"), false);
	}
	
	
}
ObjectQuery.main = function () {
	oq=new ObjectQuery();
};
jQuery(document).ready(ObjectQuery.main);

var DropdownQuery = {
	
	toggle : function (query, accepter_id) {
		
		if(accepter_id)result_accepter_id =accepter_id;
		var pos, path,queryString, dropdownDivId;
		dropdownDivId= "div_"+accepter_id;
		var acceptorEle=  document.getElementById(accepter_id);
		var dropdownDiv = document.getElementById(dropdownDivId);
		var notLoadedDiv=document.getElementById("dwrloading_"+accepter_id); 
		if(dropdownDiv==null || notLoadedDiv!=null){
			//create and show div
			if(dropdownDiv==null){
				//debug("into creating "+ dropdownDivId);
				dropdownDiv=document.createElement("div");
				dropdownDiv.id=dropdownDivId;
				dropdownDiv.className = "comboBoxList";
				//dropdownDiv.style.width = (acceptorEle.offsetWidth ? acceptorEle.offsetWidth : 100) + "px";
				dropdownDiv.innerHTML ="<div id='content_"+ accepter_id+"' style='width:150px;position: relative; z-index: 10;'><span id='dwrloading_"+ accepter_id+"' style='width:150;height:20;'>Loading...</span></div>"+ 
				(is_ie?"<iframe id='frm_"+accepter_id+"' frameborder='0' style='position: absolute; top: 0; left: 0; z-index: 9;'></iframe>":"");
	
				document.body.appendChild(dropdownDiv);
			}
			DropdownQuery.resize(accepter_id);
			
			pos = query.indexOf("?");
			path = query;
			queryString = "";

			if (pos != -1) {
				path = query.substring(0, pos);
				queryString = query.substring(pos + 1, query.length);
			}
			loadPage(path,queryString, DropdownQuery.returnQuery, accepter_id);
			
			if(dqComboboxes==null){
				dqComboboxes=new Array();
				Event.observe(document.body, 'mousedown', function(event) {
					var elt = $(Event.element(event)).up('.comboBoxList');
					var i, ee;
					for(i=0;i<dqComboboxes.length;i++){
						ee= $(dqComboboxes[i]);
						if(ee!=null && ee.style.display == 'block'){
							if(elt==null || elt.id!=ee.id){
								//debug("mousedown hide "+ ee.id);
								ee.style.display = 'none';
							}
						}
					}
				});
				/*document.OldHandlers=new Array();
				document.OldHandlers.onmousedown=document.onmousedown;
				document.onmousedown=function(e){
					var x,y,b=0,x;
					if(e==null)e=event;
					y=GetEventTarget(e);
					for(x=0;x<comboboxes.length;x++){
						if(comboboxes[x].style.display == 'block'){
							//while( typeof(y.parentElement)!="undefined" && y.id!=comboboxes[x].id)  y=y.parentElement;
							while( y.parentElement!=null && y.id!=comboboxes[x].id)  y=y.parentElement;
							//if(y.id!=comboboxes[x].id) comboboxes[x].style.display = 'none';
						}
					}
					ExecuteIfExists(this,document.OldHandlers.onmousedown,e);
				 
				}*/
			}
			var j,f=false;
			for(j=0;j<dqComboboxes.length;j++ ){
				if(dqComboboxes[j]==dropdownDivId){
					f=true;break;
				}
			}
			if(f==false)dqComboboxes[dqComboboxes.length]=dropdownDivId;
		}else{
			if (dropdownDiv.style.display == "none") {
				DropdownQuery.repos(accepter_id);
				//dropdownDiv.style.display = "block";
			}/*else {
				dropdownDiv.style.display = 'none';
				debug("hide "+ dropdownDivId);
			}*/			
		}
	},
	repos : function(accepter_id) {
		var dropdownDiv = document.getElementById("div_"+accepter_id);
		var offsets = getOffsets(accepter_id);
		var acceptorEle=document.getElementById(accepter_id);
		dropdownDiv.style.top = offsets.y + (acceptorEle.offsetHeight ? acceptorEle.offsetHeight : 22) + "px";
		dropdownDiv.style.left = offsets.x + "px";
		dropdownDiv.style.display = "block";
	},
	resize : function (accepter_id) {
		var dropdownDiv = document.getElementById("div_"+accepter_id);
		var contentDiv = document.getElementById("content_"+accepter_id);
		var tableWrapperDiv=document.getElementById("tdv_"+accepter_id);
		if(tableWrapperDiv!=null){
			contentDiv.style.width=tableWrapperDiv.style.width;
		}
		dropdownDiv.style.width=contentDiv.style.width;
		var frm=  document.getElementById("frm_"+ accepter_id);
		if (frm!= null) {
			frm.height =contentDiv.offsetHeight;
			frm.width = contentDiv.style.width;
		}
		DropdownQuery.repos(accepter_id);
	},
	returnQuery : function (xmlHttpReq, accepter_id) {
		
		var contentDiv = document.getElementById("content_"+accepter_id);
		contentDiv.innerHTML = xmlHttpReq.responseText;
		
		init_result("table_"+accepter_id);
		var tableDiv= document.getElementById("table_"+accepter_id);
		var tableWrapperDiv=document.getElementById("tdv_"+accepter_id);
		
		tableWrapperDiv.style.width=((tableDiv.offsetWidth<150?150:tableDiv.offsetWidth)+20)+"px";
		//tableWrapperDiv.style.height=(tableDiv.offsetHeight>100?100:tableDiv.offsetHeight)+"px";
		
		DropdownQuery.resize(accepter_id);
	},
	reloadForm  : function(fm, accepter_id, idx){
		if(idx!=null){
			fm.start.value=idx;
		}
		var action=fm.action;
		var pos = action.indexOf("?");
		var path = action;
		var queryString = "";
		if (pos != -1) {
			path = action.substring(0, pos);
			queryString = action.substring(pos + 1, action.length);
		}
		if (!endsWith(queryString, "&")) {
			queryString += "&";
		}
		for (var i = 0; i < fm.elements.length; i++) {
			var e = fm.elements[i];
			if ((e.name != null) && (e.value != null)) {
				queryString += e.name + "=" + encodeURIComponent(e.value) + "&";
			}
		}
		loadPage(path,queryString, DropdownQuery.returnQuery, accepter_id);	
	}
	
};//end DropdownQuery

function loadForm2(form, action, elId) {
	var progressbar=document.getElementById("submit_progress");
	if(progressbar!=null) progressbar.style.display = "block";
	if (is_ie_5_up) {
		var pos = action.indexOf("?");

		var path = action;
		var queryString = "";

		if (pos != -1) {
			path = action.substring(0, pos);
			queryString = action.substring(pos + 1, action.length);
		}

		if (!endsWith(queryString, "&")) {
			queryString += "&";
		}

		for (var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];

			if ((e.name != null) && (e.value != null)) {
				queryString += e.name + "=" + encodeURIComponent(e.value) + "&";
			}
		}

		document.body.style.cursor = "wait";


		var returnFunction =
			function (xmlHttpReq) {
				if (is_ie) {
					document.getElementById(elId).innerHTML = xmlHttpReq.responseText;
					init_result("query_result_table");
				}
				else {
					//var html = document.createTextNode(xmlHttpReq.responseText);

					//document.getElementById(elId).innerHTML = "";
					//document.getElementById(elId).appendChild(html);
				}

				document.body.style.cursor = "default";
				var progressbar=document.getElementById("submit_progress");
				if(progressbar!=null) progressbar.style.display = "none";
				var menuIframe = document.getElementById("menuframe");
				if (menuIframe != null) {
					menuIframe.height =  document.getElementById("menudiv").offsetHeight;
					menuIframe.width =  document.getElementById("menudiv").offsetWidth;
				}				
				var ele=document.getElementById("search_content");
				if(ele!=null){
					ele.focus();
					ele.select();
				}
			};

		loadPage(path, queryString, returnFunction);
	}
	else {
		submitForm(form, action);
	}
}

	function advancedSearchItem(url){
		hidePopupWindow();
		popup_window(url);
	}
	function ajax_searchItem(){
		var tForm =form1;
		tForm.start.value="1";
		tForm.quick_search.value="true";
		var ele=document.getElementById("search_content");
		if(ele!=null){
			tForm.quick_search_data.value=document.getElementById("search_content").value;
			tForm.quick_search_column.value=document.getElementById("quick_search_column").value;
			if(tForm.param_expr!=null && !document.getElementById("search_sqlcondition").checked){
				tForm.param_expr.value=form2.fixed_param_expr.value;
			}
		}
		loadForm2(tForm,"/servlets/QueryInputHandler","search_result");
		return false;
	}

  function handleSearchKey(event){
		if (!event) {
    		event = window.event;
  		}
  		if (event.keyCode == 13) { ajax_searchItem(); return false;}
  		if(event.keyCode==27){hidePopupWindow();}
  }
 
function object_hotkey(event){
	if (!event) {
    		event = window.event;
  	}
  	if ( event.altKey && event.keyCode >= 49 && event.keyCode<=57 ) {
  		var ele=document.getElementById("ctrl_"+ (event.keyCode-48));
  		if(ele!=null && !(ele.href==null || ele.href.length==0)){
  			window.location=ele.href;
  		}
  		
  	}
  	
}

 function handleObjectInputKey(event, objectSearchURL){
 	if (!event) {
    		event = window.event;
  	}
  	if ( event.altKey && event.keyCode == 191) {
  		//alert(objectSearchURL);
  		ObjectQuery.toggle(	objectSearchURL, event.srcElement.id);
  	}
 }
 
 function handleDropdownInputKey(event, objectSearchURL){
 	if (!event) {
    		event = window.event;
  	}
  	if ( event.altKey && event.keyCode == 191) {
  		//alert(objectSearchURL);
  		DropdownQuery.toggle(	objectSearchURL, event.srcElement.id);
  	}
 }

function hidePopupWindow(){
	var e= document.getElementById("div_"+result_accepter_id);
	if(e==null){
		e=document.getElementById("object_query_content");
	}
	if(e!=null)e.style.display = "none";
	
	var ele=document.getElementById(result_accepter_id);
	if(ele)ele.focus();
	
}	
function ajax_unselectall()
{
    if(document.getElementById("ajax_myCheckBoxAll")==null ) return;
    if( document.getElementById("ajax_myCheckBoxAll").checked){
		document.getElementById("ajax_myCheckBoxAll").checked = document.getElementById("ajax_myCheckBoxAll").checked&0;
    }
}

function ajax_selectall(theForm, length)
{
    document.getElementById("ajax_myCheckBoxAll").checked = document.getElementById("ajax_myCheckBoxAll").checked|0;

    if (length == 0 ){
          return;
    }
    if (length ==1 )
    {
       theForm.selectedItemIdx.checked=document.getElementById("ajax_myCheckBoxAll").checked ;
    }

    if (length>1)
    {
      for (var i = 0; i < length; i++)
       {
        theForm.selectedItemIdx[i].checked=document.getElementById("ajax_myCheckBoxAll").checked;
       }
    }

}
  function ajax_changeRange(range){
  	 ajax_doSubmit(document.form1, document.form1.start.value,range);
  }
  function ajax_doSubmit(form, start,range){
   form.range.value=range;
   form.start.value=start;
   loadForm2(form,"/servlets/QueryInputHandler","search_result");
  }
  function ajax_setIndex(form,index){
    form.start.value=index;
    loadForm2(form,"/servlets/QueryInputHandler","search_result");

  }
  function ajax_refresh(form){
    loadForm2(form,"/servlets/QueryInputHandler","search_result");
  }
  function ajax_showFullSubTotal(form, ck){
  	if( ck | 0 == true){
  		form.fullrange_subtotal.value='true';
  	}else{
  		form.fullrange_subtotal.value='false';
  	}
  	loadForm2(form,"/servlets/QueryInputHandler","search_result");
  }
  function ajax_refreshPage(){
    loadForm2(form1,"/servlets/QueryInputHandler","search_result");
  }


	function ajax_reOrder(form,columnValue){
	    if(form.elements["order/columns"].value == columnValue){
	        if(form.elements["order/asc"].value == 'true')
	            form.elements["order/asc"].value = 'false';
	        else
	            form.elements["order/asc"].value = 'true';
	    }else{
	        form.elements["order/columns"].value = columnValue;
	        form.elements["order/asc"].value = 'true';
	    }
	    ajax_setIndex(form,1);
	}
    

  function ajax_get_acceptor(accepter_id){
  	return accepter_id.substring(accepter_id.indexOf(".")+1);	
  }
  function ajax_close_popup(return_string){
    // return_string is the ak, pkData is the pk id
    var ele=document.getElementById(result_accepter_id);
    if(ele){
    	ele.value=return_string;
    	// for multi line input, check the first checkbox
    	try{
    		var row=result_accepter_id.split('_')[1];
    		document.sheet_item_modify.selectedItemIdx[row].checked = true;
    	}catch(e){
    	}
    	try{// prototype method
    		if(ele.onchange)ele.onchange();
    	}catch(e){
    	}
    }
	hidePopupWindow();    
  }
  function ajax_close_multiSelect(form, accepter_id,msg_contain, msg_check_lines){
    var sql,sqlDesc;
    sql = "" ;
    sqlDesc = msg_contain+"(";
    
    if(typeof(window.opener.name)!='unknown'){
    	
        var selectedIdx = getSelectedItemIdx();
        if (selectedIdx==null || selectedIdx.length ==0) {
            alert(msg_check_lines);
            return false;
        }
        var itemIdObjs=document.all.item("itemid");
        var itemIdObj;
        if (itemIdObjs.length ==null){
            // only one item found, and selected
            itemIdObj=itemIdObjs;
            sql= sql +  itemIdObj.value;
            sqlDesc=sqlDesc +itemIdObj.id;
        }else{
            for(i=0;i< selectedIdx.length;i++){
            	itemIdObj= itemIdObjs[selectedIdx[i]];
            	if(i!=0){ sql =sql + ","; sqlDesc =sqlDesc+",";}
            	sql = sql + itemIdObj.value;
            	sqlDesc=sqlDesc + itemIdObj.id;
            }
	}
        sqlDesc =  sqlDesc + ")";
        ajax_setOpenerParam(sql, sqlDesc,null,accepter_id);
        
    }else{
        hidePopupWindow(); 
    }
    
    return true;
  }
  function ajax_close_sql(sql,sqlDesc,accepter_id){
      var sqlExpr;
      if(document.form1.param_expr==null) sqlExpr="";
      else sqlExpr=document.form1.param_expr.value;
      ajax_setOpenerParam(sql, sqlDesc,sqlExpr,accepter_id);
      return true;
  }
  function ajax_setOpenerParam(sql, sqlDesc, sqlExpr,accepter_id){
 	  var accepter_id_object= accepter_id.substring(accepter_id.indexOf(".")+1);	
      document.getElementById(accepter_id_object+ "_link").name="clear"; // reset to popup
      document.getElementById(accepter_id_object+"_img").src="/html/nds/images/clear.gif";
      document.getElementById(accepter_id_object).value=sqlDesc;
      document.getElementById(accepter_id_object).readOnly =true;
      document.getElementById(accepter_id_object).style.borderWidth="0px 0px 0px";
      document.getElementById(accepter_id_object).style.backgroundColor='beige';
      var obj=document.getElementById(accepter_id_object+"_expr") ;
      if( obj !=null){
      	  obj.value= sqlExpr;
      }
      obj=document.getElementById(accepter_id_object+"_sql");
      if( obj !=null){
      	  obj.value=" IN ("+sql+ ")";
      }

      hidePopupWindow();    
  }

function init_result(tableId){
	try{
	
	selTb= new SelectableTableRows(document.getElementById(tableId), isMultiSelectEnabled);
	if(isMultiSelectEnabled ){
		prevSelected=selTb.getSelectedItems();
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
	        			try{
	        			idx=prevSelected[i].cells[0].id;
	        			prevSelected[i].all("chk_obj_"+idx.replace(/td_obj_/g, "")).checked=0;
	        			}catch(ex){}
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
	        			try{
		        			idx=curSelected[i].cells[0].id;
		        			curSelected[i].all("chk_obj_"+idx.replace(/td_obj_/g, "")).checked=1;
	        			}catch(ex){}
	        		}
	        	}
	        	ajax_unselectall();
	        	prevSelected=curSelected;
	        };
	}// end if(isMultiSelectEnabled )
	else{
		selTb.ondoubleclick=function(trElement){
			var idx;
			try{
				if(is_ie)idx=trElement.cells(0).title;
				else idx=$(trElement).down("td").title;
				if(idx!="")ajax_close_popup(idx);
			}catch(ex){
				alert("internal error"+ ex);
			}
		};
	}  
	}catch(ee){alert(ee);}
}


/**
 * I return an object with an x and y fields, indicating the object's
 * offset from the top left corner of the document.  The 'offsets'
 * argument is optional; if not provided, one will be initialized and
 * used.  It is exposed as a parameter because it can be useful for
 * computing deltas.  The 'object' parameter can be either an actual
 * document element, or the ID of one.
 *
 * @param object The object to compute the offset of.  May be an object
 *		or the ID of one.
 * @param offsets The starting offsets to calculate from.  In almost
 *		all cases, this should be omitted.
 * @return An offsets object with x and y fields, indicating the
 *		computed offsets for the object.  If an offsets object is
 *		passed, that will be the object returned, though the values
 *		will have been changed.
 */
function getOffsets(object, offsets) {
	if (! offsets) {
		offsets = new Object();
		offsets.x = offsets.y = 0;
	}
	if (typeof object == "string")
		object = document.getElementById(object);
	offsets.x += object.offsetLeft-object.scrollLeft;
	offsets.y += object.offsetTop-object.scrollTop;
	do {
		object = object.offsetParent;
		if (! object)
			break;
		if(object.tagName.toUpperCase() != "BODY"){
		offsets.x += object.offsetLeft-object.scrollLeft;
		offsets.y += object.offsetTop-object.scrollTop;
		}else{
		offsets.x += object.offsetLeft;
		offsets.y += object.offsetTop;
		}
	} while(object.tagName.toUpperCase() != "BODY");
	return offsets;
}

//Takes variable number of args.  Executes if exists, converting string code to a function and calling it, if necessary.  The first arg is the scope (eg this) with the second argument the function or code and the remaining are passed the the function/code as parameters.  (eg ExecuteIfExists(this,alert,"test"))
function ExecuteIfExists(){
	var w,x=1,y,z=arguments,s,u;
	if(z.length>1){
		s=z[0];
		switch(w=(typeof(y=z[1])).toLowerCase()){
			case"function":
				w=new Array();
				while(++x<z.length)w[x-1]=z[x];
				y=y.apply(s,w);
				break;
			case"object"://This only works for special universal native functions.
				if(y!=null){
					w="y=s.y(";
					while(++x<z.length){if(x>1)w+=',';w+="z["+x+"]"}
					eval(w+')')
					//The above was previously the following.
					/*w="y=s.y(";
					while(x<z.length){if(x++>1)w+=',';w+="z["+x+"]"}
					eval(w+')')*/
				}
				break;
			default:
				if(w!=u){
					x=2;w=new Array();
					while(x<z.length)w[x-1]=z[x++];
					eval("var x=function(){"+y+"}; y=x.apply(s,w);")
				}
		}
		return y
	}
}
function GetEventTarget(e){
	if(typeof(e.srcElement)!="undefined")return e.srcElement;
	return e.originalTarget;
}
function CancelEvent(e){if(typeof(e)=="undefined"){event.cancelBubble=true;return event.returnValue=false} e.cancelBubble=true;return false}