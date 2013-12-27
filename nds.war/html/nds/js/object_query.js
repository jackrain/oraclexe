/**
 * import application.js, alerts.js,dwr.js,prototype.js
 * 2008-12-21 updated
 */

var dqComboboxQueries=null;
var dqComboboxes=null;
var dq=null;
var oq=null;
var dcq=null;
var DynamicQuery = Class.create();
var DropdownQuery = Class.create();
var ObjectQuery = Class.create();
ObjectQuery.prototype = {
	initialize: function() {
		this._gridQuery=[]; // QueryObject
		this._accepter_id=[]; //id of input control that accepts query result
		this._mainobjurl=[]; // object url
		this._returnType=[]; // default to single, "m" for multiple, "f" for filter
		this._partialData=null; // partial columns of all rows, for single return type
		this.multi_result=[];
		this._queryindex=-1;
		this._xmlid=[];
		this.condition="IN";
		application.addEventListener( "QueryObject", this._onQueryObject, this);
		application.addEventListener( "ReturnSQL", this._onReturnSQL, this);
		application.addEventListener( "ReturnSET", this._onReturnSET, this);
		application.addEventListener( "Return_Result", this._onReturn_Result, this);
	},
	 /**
	 	 *Edit by Robin 20100810
     *用户需要在字段条件查询时（非日期，单对象及多对象查询）可以多选；
     *复制(如：EXCEL表格)类容即可达到效果。
     *此方法实现：弹出文本输入框；用户输入类容（复制）点击确定
     *将类容转换（回车转换为“,”）填入字段条件input框、
     *关闭文本输入框
     *@param clniptid 字段条件 input 框ID
     */
		tog:function(clniptid){
			/*
					var ele = Alerts.fireMessageBox(
				{
					"width": 410,
					"innerAlign":"center",
					"modal": true,
					title: gMessageHolder.EDIT_MEASURE
				});*/


				var str="<div id='"+clniptid+"-dlg' style=\"width:400px; height:250px; font-size:12px;\">"+
								"<div style=\"font-size:14px; font-weight:bold; color:#000; height:24px; line-height:24px;\">输入内容</div>"+
								"<div><textarea id=\""+clniptid+"-ta\" cols=\"54\" rows=\"10\" style=\"font-size:12px; color:#000;\"></textarea>"+
								"</div><div style=\"height:24px; line-height:24px; text-align:center\">"+
								"<input type=\"button\" value=\"确定\" onclick=\"var val=$('"+clniptid+"-ta').value;val=jQuery.trim(val);var vs=val.split('\\n');for(var i=0;i\<vs.length;i++){	vs[i]=jQuery.trim(vs[i]);}  $('"+clniptid+"').value=vs.join('~~');Alerts.killAlert($('"+clniptid+"-dlg'));\"  style=\"width:46px; height:20px; font-size:12px;\"/>&nbsp;&nbsp;"+
								"<input type=\"button\" onclick=\"Alerts.killAlert($('"+clniptid+"-dlg'));\" name=\"Submit\" value=\"取消\"  style=\"width:46px; height:20px; font-size:12px;\" /></div></div>";

        ele.innerHTML=str;
				executeLoadedScript(ele);
				$(clniptid+"-ta").focus();
		},
	/**
	 * Popup search form or clear input according to $(acceptor_id+"_link").name, if name is "popup", then do poup,
	 * else clear input. if $(acceptor_id+"_link") not exists, just show search form(single obj)
	 * accepter_id id of input control that accepts query result
	 */
	toggle: function(url, accepter_id, options) {
		//alert(accepter_id);
		//alert(options);
		try{
			/*
			var list = art.dialog.list;
			for (var i in list) {
   			 list[i].close();
			};
    */

			//art.dialog.get("artDialog1").close();
	}
	catch(ex){};
		var l= $(accepter_id+"_link");
		if( l==null || (l!=null &&l.title=="popup")){
			url=reconstructQueryURL(url, options,accepter_id);
			//alert(url);
			if(url==null) return; // find error
			this._queryindex=this._queryindex+1;
			this.multi_result[this._queryindex]=new Array();
			this._accepter_id[this._queryindex]=accepter_id;
			/*
			var popup = Alerts.fireMessageBox({
					width: 610,modal:true,noCenter: true,title: gMessageHolder.SEARCH,queryindex:this._queryindex,
					onClose: function() {oq.close_query();}
				});
			 */
			var options=$H({queryindex:this._queryindex,padding: 0,width:'auto',height:'auto',top:'7%',title:gMessageHolder.SEARCH,skin:'chrome',drag:true,lock:true,esc:true,effect:false,close:function(){oq.close_query();}});
	    //
			//AjaxUtil.update(url, popup, null);

			new Ajax.Request(url, {
			  method: 'get',
			  onSuccess: function(transport) {
			  	 //var pt=$(popup);
			     //pt.innerHTML=transport.responseText;
			     //executeLoadedScript(pt);
			    //alert(transport.responseText);
			   // par.content(transport.responseText);
			    //var par=art.dialog(options);

			    //var pt=$(par);
			    options.content=transport.responseText;
			    var par=art.dialog(options);
			    //par.content(transport.responseText);
			    //alert(transport.getResponseHeader("nds.code"));

			    //alert(par.data.id);
			   // par.content(transport.responseText);
			    //par.content=transport.responseText;
			    //executeLoadedScript(par);

			    //4.6 转载时自动运行SCRIPT脚本
			    //var pdiv=$(par.data.id);
			    //alert(pdiv);
			    //executeLoadedScript(pdiv);
			    //alert(par.data.content);
			  },
			  onFailure:function(transport){
			  	//try{
			  	//alert(transport.getResponseHeader("nds.code"));
			  	  	if(transport.getResponseHeader("nds.code")=="1"){
			  	  		window.location="/c/portal/login";
			  	  		return;
			  	  	}
			  	  	var exc=transport.getResponseHeader("nds.exception");
			  	  	if(exc!=null && exc.length>0){
			  	  		alert(decodeURIComponent(exc));
			  	  	}else{
			  	  		options.content=transport.responseText;
			  	  		var par=art.dialog(options);
			  	  		 //4.6 转载时自动运行SCRIPT脚本
			  	  		//var pdiv=$(par.data.id);
			  	  		//executeLoadedScript(pdiv);
			  	  		//var pt=$(popup);
			    		//pt.innerHTML=transport.responseText;
			    		//executeLoadedScript(pt);
			  	  	}
			  	//}catch(e){}
			  }
			});
		//	$("queryindex_"+this._queryindex).value=this._queryindex;
		}else{
				$(accepter_id+ "_link").title="popup"; // reset to popup
				$(accepter_id+ "_img").alt="";
		      	$(accepter_id).value="";
		      	$(accepter_id+ "_img").src="/html/nds/images/filterobj.gif";
				if($(accepter_id+ "_fd")!=null){
					$(accepter_id+ "_fd").value="";
					$(accepter_id+ "_fd").readOnly=false;
				}
				if($(accepter_id+ "_sql")!=null){
					$(accepter_id+ "_sql").value="";
					$(accepter_id).readOnly=false;
				}
				var obj=$(accepter_id+ "_expr");
				if( obj !=null){
			    	obj.value= "";
			    }
		}
	},
	toggle_m: function(url, accepter_id, options) {
			var l= $(accepter_id+"_link");
			if( l==null || (l!=null &&l.title=="popup")){
				url=reconstructQueryURL(url, options,accepter_id);
				if(url==null) return; // find error
				this._queryindex=this._queryindex+1;
				this.multi_result[this._queryindex]=new Array();
				this._accepter_id[this._queryindex]=accepter_id;
				 /*
				var popup = Alerts.fireMessageBox({
						width: 790,modal:true,noCenter: true,title: gMessageHolder.SEARCH,queryindex:this._queryindex,
						onClose: function() {oq.close_query();}
					});
					*/
				//AjaxUtil.update(url, popup, null);
				var options=$H({queryindex:this._queryindex,padding: 0,width:610,height:427,top:'7%',border: true,resize:true,title:gMessageHolder.SEARCH,skin:'chrome',drag:true,lock:true,esc:true,close:function(){oq.close_query();}});

				new Ajax.Request(url, {
				  method: 'get',
				  onSuccess: function(transport) {
				 /*
				  	var pt=$(popup);
				    pt.innerHTML=transport.responseText;
				    executeLoadedScript(pt);
				*/
					options.content=transport.responseText;
			    var par=art.dialog(options);
			    //4.6 转载时自动运行SCRIPT脚本
			    //var pdiv=$(par.data.id);
			    //executeLoadedScript(pdiv);

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
				  	  		/*
				  	  		var pt=$(popup);
				    		pt.innerHTML=transport.responseText;
				    		executeLoadedScript(pt);*/
							options.content=transport.responseText;
				    		var par=art.dialog(options);
				    		//4.6 转载时自动运行SCRIPT脚本
			  	  		//var pdiv=$(par.data.id);
			  	  		//executeLoadedScript(pdiv);
				  	  	}
				  }
				});
				//$("queryindex_"+this._queryindex).value=this._queryindex;
			}else{
				//clear data
				$(accepter_id+ "_link").title="popup"; // reset to popup
				$(accepter_id+ "_img").alt="";
		      	$(accepter_id).value="";
		      	if(this._returnType[this._queryindex]=="a"){
		      		$(accepter_id+ "_img").src="/html/nds/images/add_filter.gif";
		      			if($("tab_"+accepter_id)!=null){
							$("tab_"+accepter_id).innerHTML="";
						}
		      	}else{
		      		$(accepter_id+ "_img").src="/html/nds/images/filterobj.gif";
		    	}
				if($(accepter_id+ "_fd")!=null){
					$(accepter_id+ "_fd").value="";
					$(accepter_id+ "_fd").readOnly=false;
				}
				if($(accepter_id+ "_sql")!=null){
					$(accepter_id+ "_sql").value="";
					$(accepter_id).readOnly=false;
				}
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
		this._gridQuery[this._queryindex]=queryObject;
		this._gridQuery[this._queryindex].callbackEvent="QueryObject";
		this._gridQuery[this._queryindex].returnType= rtnType;
		this._returnType[this._queryindex]= rtnType;
		this._xmlid[this._queryindex]=0;
		this._initGridSelectionControl();
		this._mainobjurl[this._queryindex]= objURL;
		var te=$("pop-up-title-"+this._queryindex);
		if(te){
			te.innerHTML=gMessageHolder.SEARCH + " - " + queryObject.table_desc;
		}
		if(rtnType=="s"){
			var e=$("btn-rsql");
			if(e)e.hide();
			e=$("btn-sql");
			if(e)e.hide();
			//single 单选模式隐藏确定
			e=$("btn-value");
			if(e)e.hide();
			e=$("qcsa");
			if(e)e.hide();
		}
	},
	search:	function(){
		this._partialData=null;
		if($("mulit-info_"+this._queryindex)!=null){
			$("mulit-info_"+this._queryindex).remove();
		}
		var fm=$("q_form_"+this._queryindex);
	    this._gridQuery[this._queryindex].param_str= fm.serialize();
	  //  alert(Object.toJSON(this._gridQuery.param_str));
	    this._gridQuery[this._queryindex].start=0;
	    var qexp=$("q_form_param_expr_"+this._queryindex);
	    if(qexp!=null){
	    	this._gridQuery[this._queryindex].param_expr=qexp.value;
	    }
		this._executeQuery(this._gridQuery[this._queryindex]);
	},

	returnSQL:function(){
		var fm=$("q_form_"+this._queryindex);
	    var queryObj= Object.clone(this._gridQuery[this._queryindex]);
	   	queryObj.param_str= fm.serialize();
	    queryObj.callbackEvent="ReturnSQL";
	    queryObj.noresult=true;
	    if(this._returnType[this._queryindex]=="f"){//filter
			queryObj.resulthandler="/html/nds/query/search_result_filter_dropdown.jsp";
		}else
		    queryObj.resulthandler="/html/nds/query/search_result_sql.jsp";

		this._executeQuery(queryObj);
	},
	/**
	 * @return single row ak
	 */
	returnRow:function(ele){
		// get selected line
		var acpt=$(this._accepter_id[this._queryindex]);
		if(acpt==null){
			if(typeof window[this._accepter_id[this._queryindex]]=="function"){
				var objSelected={id:ele.id.replace(/chk_obj_/i, ""),ak:String(ele.alt)};
				var func=window[this._accepter_id[this._queryindex]];
				this.close();
				func(objSelected);
				return;
			}
			this.close();
			return;
		}
      	acpt.value=ele.alt;
      	fireEvent(acpt,"change");
      	var fk_acpt=$("fk_"+ this._accepter_id[this._queryindex]);
      	if(fk_acpt!=null){
      		fk_acpt.value=ele.id.replace(/chk_obj_/i, "") ;

      	}
      	try{acpt.focus();}catch(ex){}
		if(this._partialData!=null && acpt.onaction){
			var rowIdx=Number(ele.title);
			if(rowIdx>=0&& rowIdx<this._partialData.length){
//				if (typeof acpt.onaction == "string")
//					acpt.onaction = new Function ("args", acpt.onaction);
				acpt.onaction(this._partialData[rowIdx]);
			}
		}
		this.close();
	},
	returnValue:function(){
		var selectedIds=Array();
		var selectedAKs=Array();
		var j;
		var cks=$("q_fm_list_"+this._queryindex).getInputs('checkbox', 'itemid');
		if(cks==null || cks.length==0){
			this.close();
			return;
		}
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
		var xml=null;
		if(this._returnType[this._queryindex]=="f"){//filter
			var j={"expr":{"desc":sqlDesc,"clink":this._gridQuery[this._queryindex].table+".ID","condition":sql}};
			var jo={"filter":{"desc":sqlDesc,"sql":sql,"expr":j}};
			xml= json2xml(jo,false);
			this.returnFilterObj_dropdown(sqlDesc, xml);
		}else{
			this.returnQuery(sql, sqlDesc, xml);
		}
	},

	returnFilterObj_dropdown:function(desc,xml){
		if(desc=="")
		{
      		$(this._accepter_id[this._queryindex]+"_fd").value=gMessageHolder.AVAILABLE;
      	}else{
      		$(this._accepter_id[this._queryindex]+"_fd").value=desc;
      	}
      	fireEvent($(this._accepter_id[this._queryindex]+"_fd"),"change");
      	$(this._accepter_id[this._queryindex]).value=xml;
      	$(this._accepter_id[this._queryindex]+"_fd").readOnly=true;
		$(this._accepter_id[this._queryindex]+ "_img").src="/html/nds/images/clear.gif";
		$(this._accepter_id[this._queryindex]+ "_link").title="clear";
		$(this._accepter_id[this._queryindex]+ "_img").alt=gMessageHolder.CLEAR_CONDITION;
		this.close();
	},
	/**
	 * Filter object is a xml format, inputs for filter:
	 *
	 */
	returnFilterObj:function(desc,xml){
		var xmlvalue=this._xmlid[this._queryindex]+"_xml";
		var flag=true;
		if(desc==""){
			desc=gMessageHolder.AVAILABLE;
		}
		//var content_row={"id":desc,"value":xmlvalue,"condition":$("condition").value,"set":xml};
		var content_row={"id":desc,"condition":this.condition,"value":xmlvalue,"set":xml};
		var mid=this.multi_result[this._queryindex].length;
		for(var i=0;i<mid;i++){
			if(this.multi_result[this._queryindex][i].id==content_row.id){
				flag=false;
				if(this.multi_result[this._queryindex][i].condition!=this.condition){
					if(this.multi_result[this._queryindex][i].condition=="IN"){
						alert(gMessageHolder.SET_ALREADY_CHOOSED);
					}else{
						alert(gMessageHolder.SET_ALREADY_EXCLUDE);
					}
				}
				break;
			}
		}
		if(flag){
			this.multi_result[this._queryindex][mid]=content_row;
			dwr.util.cloneNode("m_multiple_row_"+this._queryindex,{idPrefix:this.multi_result[this._queryindex][mid].value+'_'});
			$(this.multi_result[this._queryindex][mid].value+'_'+"m_multiple_"+this._queryindex).innerHTML="<input type=\"checkbox\" name=\"m_multiple_"+this._queryindex+"\"  value="+this.multi_result[this._queryindex][mid].value+">";
			dwr.util.setValue(this.multi_result[this._queryindex][mid].value+'_'+"m_multiple_value_"+this._queryindex,this.multi_result[this._queryindex][mid].id);
			$(this.multi_result[this._queryindex][mid].value+'_'+"m_multiple_row_"+this._queryindex).style.display="";
			this._xmlid[this._queryindex]++;
		}
	},
	returnQuery:function(sql,sqlDesc,sqlExpr){
		$(this._accepter_id[this._queryindex]+ "_link").title="clear"; // reset to popup
      	$(this._accepter_id[this._queryindex]+ "_img").src="/html/nds/images/clear.gif";
	    $(this._accepter_id[this._queryindex]+ "_img").alt=gMessageHolder.CLEAR_CONDITION;
      	$(this._accepter_id[this._queryindex]).value=sqlDesc;
     	$(this._accepter_id[this._queryindex]).readOnly=true;

      	fireEvent($(this._accepter_id[this._queryindex]),"change");


      	$(this._accepter_id[this._queryindex]+ "_sql").value=sql;
		var obj=$(this._accepter_id[this._queryindex]+ "_expr");
		if( obj !=null){
	    	obj.value= sqlExpr;
	    }
		this.close();
	},
	/**@return when e is not an element or e.value is empty
	*/
	isEmpty:function(e){
		var v=$(e);
		return ((v!=null && dwr.util.getValue(v).empty()) || v==null);

	},
	close:function(){
		//window.setTimeout("Alerts.killAlert(document.getElementById('pop-up-title-"+this._queryindex+"'))",1);
		//var pid=jQuery("#pop-up-title-"+this._queryindex).parents(".aui_dialog_wrap").attr("id");
		//art.dialog.close();
		//alert(pid)
		//art.dialog.get(pid).close();
		//window.setTimeout("art.dialog.get('"+pid+"').close()",1);
		//alert(pid);
		//获取当前正在打开的dialog窗口
		 var now_popw=jQuery(".aui_state_focus .aui_title")[0].id;
	   var list = art.dialog.list;
			for (var i in list) {
   				var title_id=list[i].DOM.title[0].id;
   				if(now_popw==title_id&&list[i].config.id!='turboscan_div'){
   					 list[i].close();
   					}
			};
	},
	close_query:function(){
		this.multi_result[this._queryindex]=null;
		this.condition="IN";
		this._xmlid[this._queryindex]=0;
		this._queryindex=this._queryindex-1;
		if(this._queryindex==-1){
			this._gridQuery=[];
		}
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
			try{
			$("btn-search").disable();
			}catch (e) {}
			if($("btn-value")!=null)$("btn-value").disable();
			if($("btn-search")!=null)$("btn-search").disable();
			if($("btn-sql")!=null)$("btn-sql").disable();
		}else{
			try{
			$("btn-search").enable();
		  }catch (e) {}
			if($("btn-value")!=null)$("btn-value").enable();
			if($("btn-search")!=null)$("btn-search").enable();
			if($("btn-sql")!=null)$("btn-sql").enable();
		}
	},
	/**
	*Reload grid data according to query result
	* @param qr QueryResult.toJSONObject()
	*/
	_onQueryObject:function(e){
		var qr=e.getUserData().data;
		if(qr.pagecontent!=null){
			if(Prototype.Browser.IE){
				// ie does not support setting innerHTML in tbody
				var div=$("q_embed_lines_"+this._queryindex);
				var te=div.innerHTML;
				var p= te.indexOf("<!--$QGRIDTABLE_START-->");
				var pe= te.indexOf("<!--$QGRIDTABLE_END-->");
				var pstr=te.substring(0, p+ "<!--$QGRIDTABLE_START-->".length);
				var pestr=te.substr(pe);
				var newDiv=pstr.concat("<tbody id='q_grid_table_"+this._queryindex+"'>",qr.pagecontent,"</tbody>",pestr);
				div.innerHTML=newDiv;
				executeLoadedScript(div);
				this._initGridSelectionControl();
			}else{
				var gridTableBody=$("q_grid_table_"+this._queryindex);
				dwr.util.removeAllRows(gridTableBody);
				gridTableBody.innerHTML=qr.pagecontent;
				executeLoadedScript(gridTableBody);
			}
		}
		if(qr.rows!=null){
			// for partial result
			this._partialData=qr.rows;
			qr.rows=null; //release qr
		}else{
			this._partialData=null;
		}
		this._syncGridControl(qr);
		var desc=  qr.queryDesc;
		if(qr.message !=undefined && qr.message!=null) desc+= "<br><blink><span class='err'>***"+ qr.message+"</blink>";
		$("q_filter_setting_"+this._queryindex).innerHTML= desc;
		dwr.util.setValue($("q_chk_select_all_"+this._queryindex),false);
		$("query-data_"+this._queryindex).show();
	},
	_syncGridControl:function(qr){
		this._gridQuery[this._queryindex].totalRowCount=qr.totalRowCount;
		this._gridQuery[this._queryindex].start=qr.start;
		//this._gridQuery.range=qr.range;
		//dwr.util.setValue("range_select", qr.range);
		if( this._gridQuery[this._queryindex].order_columns!=null){
			var ele=$("q_title_"+this._gridQuery[this._queryindex].order_columns);
			if(ele!=null){
				ele.innerHTML="<img src='/html/nds/images/"+( this._gridQuery[this._queryindex].order_asc?"up":"down")+"simple.png'>";
			}
		}
		if($("q_txtRange_"+this._queryindex)!=null){
			$("q_txtRange_"+this._queryindex).innerHTML=((qr.start+1)+"-"+ (qr.start+qr.rowCount)+"/"+ qr.totalRowCount);
			if(qr.start>0){
				 $("q_begin_btn_"+this._queryindex).setEnabled(true);
				 $("q_prev_btn_"+this._queryindex).setEnabled(true);
			}else{
				 $("q_begin_btn_"+this._queryindex).setEnabled(false);
				 $("q_prev_btn_"+this._queryindex).setEnabled(false);
			}
			if((qr.start+qr.rowCount)< qr.totalRowCount){
				 $("q_next_btn_"+this._queryindex).setEnabled(true);
				 $("q_end_btn_"+this._queryindex).setEnabled(true);
			}else{
				 $("q_next_btn_"+this._queryindex).setEnabled(false);
				 $("q_end_btn_"+this._queryindex).setEnabled(false);
			}
		}
	},
	_executeQuery : function (queryObj) {
		$("q_progress_"+this._queryindex).show();
	    this._toggleButtons(true);
		var s= Object.toJSON(queryObj);
		//alert(s);
		Controller.query(s, function(r){
				var result= r.evalJSON();
				if (result.code !=0 ){
				    oq._toggleButtons(false);
					msgbox(result.message);
				}else {
					var evt=new BiEvent(result.callbackEvent);
					evt.setUserData(result);
					application.dispatchEvent(evt);
				    oq._toggleButtons(false);
				}
		  	}
		);
		$("q_progress_"+this._queryindex).hide();
	},
     /**
     * Init list table to handle selection action
     */
    _initGridSelectionControl:function(){
		//var tb= new SelectableTableRows(document.getElementById("q_inc_table"), false);// set as global object
		    var tb=jQuery('#q_grid_table_'+this._queryindex).selectable({filter:'tr',tolerance:"touch",cancel:"input,:input,a,.ui-selected",
        stop: function(event, ui) {

        	if(jQuery(".ui-selected").length>1){
      		jQuery( ".ui-selected", this ).each(function() {
					     //var index = $( "#selectable li" ).index( this );
					     //alert(this);
					      //var index = jQuery( "#grid_table tr" ).index( this );
					      this.children[0].children[0].checked=true;
					      this.children[0].children[0].focus=true;
					      oq.dynamic_add(this.children[0].children[0].id);
					      //alert(index);
					     //result.append( " #" + ( index + 1 ) );

				   });

				  // jQuery("input:checkbox").attr("checked",true);
				  }
        },
        unselected:function(event, ui){
        	//alert(jQuery(".ui-selected").length);
          //alert(ui);
          ui.unselected.children[0].children[0].checked=false;
        	}
        //selected: function(event, ui) {}
		    	});
		if(this._returnType[this._queryindex]!="s"){//"m" or "f"
			/*
			tb.ondoubleclick=function(trElement){
				oq.mo(trElement.id.replace(/_qtemplaterow/i, ""));
			};
			*/
			tb.dblclick(
 		   function(trElement){
		   if(trElement.srcElement.type=="checkbox"){
		   	return;
		   	}
		   if(trElement.target.nodeName=="SPAN"){
		   		var pid=trElement.target.parentElement.parentElement.id.replace(/_qtemplaterow/i, "");
		   	}else{
		   	var pid=trElement.target.parentElement.id.replace(/_qtemplaterow/i, "");
		   	}
		    oq.mo(pid);
		   }
		   );
		}else{
			tb.dblclick(function(trElement){
				//$(oq._accepter_id).value=$("chk_obj_"+trElement.id.replace(/_qtemplaterow/i, "") ).alt;
		   if(trElement.target.nodeName=="SPAN"){
		   		var pid=trElement.target.parentElement.parentElement.id.replace(/_qtemplaterow/i, "");
		   	}else{
		   	var pid=trElement.target.parentElement.id.replace(/_qtemplaterow/i, "");
		   	}
		   	this._queryindex=0;
		   	//获取PID
				//var ele=$("chk_obj_"+trElement.id.replace(/_qtemplaterow/i, ""));
				var ele=$("chk_obj_"+pid);
				var acpt=$(oq._accepter_id[this._queryindex]);
		      	acpt.value=ele.alt;
		      	var fk_acpt=$("fk_"+ oq._accepter_id[this._queryindex]);
		      	if(fk_acpt!=null)fk_acpt.value=ele.id.replace(/chk_obj_/i, "") ;
				if(oq._partialData!=null && acpt.onaction){
					var rowIdx=Number(ele.title);
					if(rowIdx>=0&& rowIdx<oq._partialData.length){
						//if (typeof acpt.onaction == "string")
						//	acpt.onaction = new Function ("args", acpt.onaction);
						acpt.onaction(oq._partialData[rowIdx]);
					}
				}
				oq.close();
			});
		}
    },
	fk:function(tableId, objId){
		popup_window("/html/nds/object/object.jsp?table="+tableId+"&id="+objId);
	},
    mo:function(tid){
		popup_window(this._mainobjurl[this._queryindex]+tid);
	},
	/**
	* create query request and execute query
	*/
	refreshGrid : function () {
		this._executeQuery(this._gridQuery[this._queryindex]);
	},
	/**
	 * Reorder grid query
	 * @param columnId the column id that will be ordered by, if the same as old
	 * order by column, will toggle asc and desc, else do asc
	 */
	orderGrid: function(columnId){
		var oldOrderBy=this._gridQuery[this._queryindex].order_columns;
		var oldAsc=this._gridQuery[this._queryindex].order_asc;
		if(oldOrderBy==columnId ){
			this._gridQuery[this._queryindex].order_asc=!oldAsc;
		}else{
			var ele=$("q_title_"+oldOrderBy+"_"+this._queryindex);
			if(ele!=null)ele.innerHTML="";
			this._gridQuery[this._queryindex].order_columns=columnId;
			this._gridQuery[this._queryindex].order_asc=true;
		}
		this._executeQuery(this._gridQuery[this._queryindex]);
	},
	/***
	* Invoke by buttons, include btn_begin,btn_next,btn_prev,btn_end
	@param t id of the button
	*/
	scrollPage: function (t) {
		//var t=event.target.id;
		var s;
		var qr=Object.clone(this._gridQuery[this._queryindex]);
		var qs=qr.start;
		var qrange=parseInt( $("q_range_select_"+this._queryindex).value,10);
		var qtot=qr.totalRowCount;
        if(t=="q_begin_btn_"+this._queryindex)s=0;
		else if(t=="q_prev_btn_"+this._queryindex) { if (qs-qrange<0){s=0;}else{s=qs-qrange;}}
		else if(t=="q_next_btn_"+this._queryindex) { if (qs+qrange>qtot){return;}else{s=qs+qrange;}}
		else if(t=="q_end_btn_"+this._queryindex) s= qtot-qrange;
		else s= qs;

		qr.start=s;
		qr.range=qrange;
		this._gridQuery[this._queryindex].range=qrange;
		this._executeQuery(qr);
	},
	/**
	 * mark all check box checked
	 */
	selectAll:function(){
		var ca=$("q_chk_select_all_"+this._queryindex);
		ca.checked = ca.checked|0;
		var ck= ca.checked;
		var cks=$("q_fm_list_"+this._queryindex).getInputs('checkbox', 'itemid');
		for(var i=0;i<cks.length;i++){
			cks[i].checked= ck;
			this.dynamic_add(cks[i].id);
		}
	},

	return_content:function(akData){
		var content_row=null;
		var compare_len=this.multi_result[this._queryindex].length;
		var len=this.multi_result[this._queryindex].length;
		var flag=false;
		var flag_check=false;
		var jo=null;
		var sql=null;
		var sqlDesc=null;
		var cks=$("q_fm_list_"+this._queryindex).getInputs('checkbox', 'itemid');
		for(var i=0;i<cks.length;i++){
			flag=false;
			if( cks[i].id==akData){
				sql=this.condition+"("+cks[i].value+")";
				content_row={"id":cks[i].id,"value":cks[i].value,"condition":this.condition,"clkstr":this._gridQuery[this._queryindex].table+".ID"};
				for(var j=0;j<compare_len;j++){
					if(this.multi_result[this._queryindex][j].value==cks[i].value){
						flag=true;
						if(this.multi_result[this._queryindex][j].condition!=this.condition){
							if(this.multi_result[this._queryindex][j].condition=="IN"){
								alert(this.multi_result[this._queryindex][j].id+gMessageHolder.ALREADY_CHOOSED);
							}else{
								alert(this.multi_result[this._queryindex][j].id+gMessageHolder.ALREADY_EXCLUDE);
							}
							flag_check=true;
						}
						break;
					}
				}
				if(!flag){
			  	this.multi_result[this._queryindex][len]=content_row;
			  	len++;
			  }
			}
		}
	//	if(this.multi_result.length==compare_len&&!flag_check){
 	//		alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
    //        return;
	//	}
    	for(var mid=compare_len;mid<this.multi_result[this._queryindex].length;mid++){
    		dwr.util.cloneNode("m_multiple_row_"+this._queryindex,{idPrefix:this.multi_result[this._queryindex][mid].value+'_'});
    		$(this.multi_result[this._queryindex][mid].value+'_'+"m_multiple_"+this._queryindex).innerHTML="<input type=\"checkbox\" name=\"m_multiple_"+this._queryindex+"\"  value="+this.multi_result[this._queryindex][mid].id+">";
		  	if(this.multi_result[this._queryindex][mid].condition!="IN"){
		  		dwr.util.setValue(this.multi_result[this._queryindex][mid].value+'_'+"m_multiple_value_"+this._queryindex,gMessageHolder.NOTCONTAINS+"("+this.multi_result[this._queryindex][mid].id+")");
		  	}else{
		  		dwr.util.setValue(this.multi_result[this._queryindex][mid].value+'_'+"m_multiple_value_"+this._queryindex,gMessageHolder.CONTAINS+"("+this.multi_result[this._queryindex][mid].id+")");
			}
		  	$(this.multi_result[this._queryindex][mid].value+'_'+"m_multiple_row_"+this._queryindex).style.display="";
		}
	},
	remove_choosed_rows:function(){
		var flag=false;
		var value=this._queryindex;
		 var obj=document.getElementsByName("m_multiple_"+value);
		 for(var i=obj.length-1;i>=0;i--){
	  	if(obj[i].checked){
	  		flag=true;
	  		var j=this.multi_result[this._queryindex][i].value;
	  		 dwr.util.removeAllRows("content_"+this._queryindex,{filter:function(tr){return (tr.id==j+'_'+"m_multiple_row_"+value);}});
	  		 this.multi_result[this._queryindex].splice(i,1);
	  	}
	  }
	  if(!flag){
	  	alert(gMessageHolder.PLEASE_CHECK_SELECTED_LINES);
	  }
	},
	remove_all:function(){
		var value=this._queryindex;
		dwr.util.removeAllRows("content_"+this._queryindex,{filter:function(tr){return (tr.id!="m_multiple_row_"+value);}});
		//dwr.util.removeAllRows("content_"+this._queryindex,{this.filter(tr);});
		this.multi_result[this._queryindex]=null;
		this.multi_result[this._queryindex]=new Array();
		this.condition="IN";
	},

	return_set:function(){
		var fm=$("q_form_"+this._queryindex);
	    var queryObj= Object.clone(this._gridQuery[this._queryindex]);
	   	queryObj.param_str= fm.serialize();
	    queryObj.callbackEvent="ReturnSET";
	    queryObj.noresult=true;
		//queryObj.resulthandler="/html/nds/query/search_result_filter.jsp?condition="+$("condition").value;
		queryObj.condition=this.condition;
		queryObj.returnType=this._returnType[this._queryindex];
		queryObj.resulthandler="/html/nds/query/search_result_filter.jsp";
		this._executeQuery(queryObj);
	},

	return_result:function(){
		if(this.multi_result[this._queryindex].length==0){
			alert(gMessageHolder.NO_DATA_TO_PROCESS);
		}else{
			var evt={};
			evt.command="Return_Result";
			evt.params=this.multi_result[this._queryindex];
			evt.table=this._gridQuery[this._queryindex].table;
			evt.returnType=this._returnType[this._queryindex];
			evt.callbackEvent="Return_Result";
			this._executeCommandEvent(evt);
		}
	},

	_onReturn_Result:function(e){
		var r=e.getUserData();
		var ret=r.data;
		//alert(ret.desc);
		if(this._returnType[this._queryindex]=="f"){
			if(ret.desc==""){
				$(this._accepter_id[this._queryindex]+"_fd").value=gMessageHolder.AVAILABLE;
			}else{
				$(this._accepter_id[this._queryindex]+"_fd").value=ret.desc;
			}
			$(this._accepter_id[this._queryindex]).value=ret.filterxml;
			$(this._accepter_id[this._queryindex]+"_fd").readOnly=true;
			$(this._accepter_id[this._queryindex]+"_fd").title=$(this._accepter_id[this._queryindex]+"_fd").value;

		}else if(this._returnType[this._queryindex]=="a"){
			// support accepter_id as function name instead of element, 2010-8-5 yfzhu
			if($(this._accepter_id[this._queryindex])!=null){
				$(this._accepter_id[this._queryindex]).value=ret.desc;
				if($("tab_"+this._accepter_id[this._queryindex])!=null){
					$("tab_"+this._accepter_id[this._queryindex]).innerHTML=ret.desc;
				}
				$(this._accepter_id[this._queryindex]+ "_expr").value=ret.filterxml;
				$(this._accepter_id[this._queryindex]+ "_sql").value=ret.sql;
				$(this._accepter_id[this._queryindex]).readOnly=true;
				$(this._accepter_id[this._queryindex]).title=ret.desc;
			}else{
				if(typeof window[this._accepter_id[this._queryindex]]=="function"){
					window[this._accepter_id[this._queryindex]]({sql:ret.sql,description:ret.desc,expression:ret.filterxml});
				}else{
					alert("Unexpected accepter found:"+(typeof window[this._accepter_id[this._queryindex]]));
				}
			}
		}else{
			$(this._accepter_id[this._queryindex]).value=ret.desc;
			$(this._accepter_id[this._queryindex]+ "_filter").value=ret.filterxml;
			$(this._accepter_id[this._queryindex]+ "_sql").value=ret.sql;
			$(this._accepter_id[this._queryindex]).readOnly=true;
			$(this._accepter_id[this._queryindex]).title=ret.desc;
		}
		try{
		$(this._accepter_id[this._queryindex]+ "_img").src="/html/nds/images/clear.gif";
		$(this._accepter_id[this._queryindex]+ "_link").title="clear";
		$(this._accepter_id[this._queryindex]+ "_img").alt=gMessageHolder.CLEAR_CONDITION;
		}catch(ex){}

		this.close();
	},
	reverse_condition:function(){
		if($("condition_"+this._queryindex).checked){
		//	$("btn-choose-content").value=gMessageHolder.EXCLUDE_CHOOSED_ROWS;
			$("btn-choose-set_"+this._queryindex).value=gMessageHolder.EXCLUDE_ALL;
			this.condition="NOT IN";
		}else{
		//	$("btn-choose-content").value=gMessageHolder.ADD_CHOOSE_ROWS;
			$("btn-choose-set_"+this._queryindex).value=gMessageHolder.ADD_ALL;
			this.condition="IN";
		}
	},
	_executeCommandEvent :function (evt) {
		Controller.handle( Object.toJSON(evt), function(r){

					var result= r.evalJSON();
					var evt=new BiEvent(result.callbackEvent);
					evt.setUserData(result);
					application.dispatchEvent(evt);
					}
	  );
	},
	_onReturnSET:function(e){
		var qr=e.getUserData().data;
		if(qr.pagecontent!=null){
			var pagecontent=qr.pagecontent.replace(/[\u0000-\u001f\u007f\u0080-\u009f]/,'');
			eval(pagecontent);
		}
	},
	dynamic_add:function(akData){
		if($("multi-list_"+this._queryindex)!=null){
			if($(akData).checked){
				this.return_content(akData);
			}else{
				this.dyn_remove_choosed_rows(akData);
			}
		}
	},
	dyn_remove_choosed_rows:function(akData){
		var value=this._queryindex;
		 var obj=document.getElementsByName("m_multiple_"+value);
		 for(var i=obj.length-1;i>=0;i--){
	  	if(obj[i].value==akData){
	  		if(this.multi_result[this._queryindex][i].condition==this.condition){
	  		var j=this.multi_result[this._queryindex][i].value;
	  		 dwr.util.removeAllRows("content_"+this._queryindex,{filter:function(tr){return (tr.id==j+'_'+"m_multiple_row_"+value);}});
	  		 this.multi_result[this._queryindex].splice(i,1);
	  		}else{
	  			if(this.multi_result[this._queryindex][i].condition=="IN"){
					alert(this.multi_result[this._queryindex][i].id+gMessageHolder.ALREADY_CHOOSED);
				}else{
					alert(this.multi_result[this._queryindex][i].id+gMessageHolder.ALREADY_EXCLUDE);
				}
	  		}
	  		 break;
	  	}
	  }
	},

	unselectall:function(ck){
		var tr_id=ck.value+"_qtemplaterow";
		if(ck.checked==true){
			jQuery("#"+tr_id).addClass("ui-selected");
			}else{
			jQuery("#"+tr_id).removeClass("ui-selected");
				}
	 	dwr.util.setValue($("q_chk_select_all_"+this._queryindex), false);
	}
}
ObjectQuery.main = function () {
	oq=new ObjectQuery();
};
jQuery(document).ready(ObjectQuery.main);
DropdownQuery.prototype = {
	initialize : function() {
	  this._selTb=null;
	  this._prevSelected=null;
	  this._accepter_id=null;
	  this._temp=null;

   application.addEventListener( "DropdownQueryRefresh", this._refreshGrid, this);
	},

	/**
	 * If option is not null, will reload whole combobox page each time, no cache in browser
	 * @param options, if not empty, will has format like:
	 * {ta:true|false, rc:[<columnId>,<columnId>...], prc:[<columnId>,<columnId>...]}
	 * ta: signs for whether current searchOnColumn is in title area or not
	 * rc: reference columns in wildcard filter, which is in same table as searchOnColumn
	 * prc:reference columns in wildcard filter, which is in parent table of searchOnColumn
	*/
	toggle : function (query, accepter_id,options) {
		if(accepter_id)this._accepter_id =accepter_id;
		var pos, path,queryString, dropdownDivId;
		dropdownDivId= "div_"+accepter_id;
		var acceptorEle=  document.getElementById(accepter_id);
		var dropdownDiv = document.getElementById(dropdownDivId);
		var notLoadedDiv=document.getElementById("dwrloading_"+accepter_id);

		if(options!=undefined && options!=null){
			query=reconstructQueryURL(query, options,accepter_id);
			if(query==null) return;// found error
			// load div every time
			if(dropdownDiv!=null){
				//position: relative; z-index: 10;
				dropdownDiv.innerHTML ="<div id='content_"+ accepter_id+"' style='width:160px;'><span id='dwrloading_"+ accepter_id+"' style='width:160;height:20;'>"+gMessageHolder.LOADING+"</span></div><iframe id='json_"+accepter_id+"' frameborder='0' style='display:none;width:160px; height:20; position: absolute; top: 0; left: 0; z-index: 9;'></iframe>";
				notLoadedDiv=document.getElementById("dwrloading_"+accepter_id);
			}
		}
		if(dropdownDiv==null || notLoadedDiv!=null){
			//create and show div
			//alert(123);
			if(dropdownDiv==null){
				dropdownDiv=document.createElement("div");
				dropdownDiv.id=dropdownDivId;
				dropdownDiv.className = "comboBoxList";
				dropdownDiv.style.position="absolute";
				dropdownDiv.style.zIndex="101";
				dropdownDiv.style.width = (acceptorEle.offsetWidth ? acceptorEle.offsetWidth : 100) + "px";
				//position: relative; z-index: 10;
				dropdownDiv.innerHTML ="<div id='content_"+ accepter_id+"' style='width:160px;'><span id='dwrloading_"+ accepter_id+"' style='width:160;height:20;'>"+gMessageHolder.LOADING+"</span></div><iframe id='json_"+accepter_id+"' frameborder='0' style='display:none;width:160px; height:20; position: absolute; top: 0; left: 0; z-index: 9;'></iframe>";

				document.body.appendChild(dropdownDiv);
			}
			this._resize(accepter_id);
			pos = query.indexOf("?");
			path = query;
			queryString = "";
			if (pos != -1) {
				path = query.substring(0, pos);
				queryString = query.substring(pos + 1, query.length);
			}

		loadPage(path,queryString,this._returnQuery,accepter_id);
		//alert(123);
			if(dqComboboxes==null){
				dqComboboxes=new Array();
				dqComboboxQueries={};
				dqtemps={};


				Event.observe(document.body, 'mousedown', function(event) {
				  var b=$(Event.element(event));
				  //alert(b.id + " " + b.type + " " + b.value);
					var elt = $(Event.element(event)).up('.comboBoxList');
					var i, ee;
					//alert(elt);
					for(i=dqComboboxes.length-1;i>=0;i--){
						ee= $(dqComboboxes[i]);
						if(ee!=null && ee.style.display == 'block'){
							if(elt==null || elt.id!=ee.id){
								ee.style.display = 'none';

							}
						}
					}
				});

			}

			var j,f=false;
			for(j=0;j<dqComboboxes.length;j++ ){
				if(dqComboboxes[j]==dropdownDivId){
					f=true;break;
				}
			}

			if(f==false){
				dqComboboxes[dqComboboxes.length]=dropdownDivId;
			}
			 //修改下拉
			var tab_span=accepter_id.replace("column","cbt");
			//alert(tab_span);
			jQuery("#div_"+accepter_id).position({of:jQuery("#"+accepter_id),my:"left top",at:"left bottom",collision:"flip flipfit"});
		}else{
			if (dropdownDiv.style.display == "none") {
				this._repos(accepter_id);
				//dropdownDiv.style.display = "block";
			}/*else {
				dropdownDiv.style.display = 'none';
				debug("hide "+ dropdownDivId);
			}*/
		}
	},
	_repos : function(accepter_id) {

		var dropdownDiv = document.getElementById("div_"+accepter_id);
		//var offsets = getOffsets(accepter_id);
		//var acceptorEle=document.getElementById(accepter_id);
		//dropdownDiv.style.top = offsets.y + (acceptorEle.offsetHeight ? acceptorEle.offsetHeight : 22) + "px";
		//dropdownDiv.style.left = offsets.x + "px";
		//dropdownDiv.style.display = "block";
		//--dropdownDiv.scrollIntoView();
		//修改下拉
		//alert(333);
		dropdownDiv.style.display = "block";
		var offset=jQuery("#"+accepter_id).offset();

		//alert(jQuery("#obj-top").offset().top);
		//alert(jQuery("#"+accepter_id).scrollTop());
		//alert(offset.top);
		//alert(jQuery(window).height()); //浏览器时下窗口可视区域高度
		//alert(jQuery(document).height());
		//alert(jQuery(window).height()-offset.top);

		//如果高度小于DROPlist高度下拉上翻
		//dorphight=jQuery("#div_"+accepter_id).height();

		//alert(dorphight);
		//if(((jQuery(window).height()-offset.top))>dorphight){
		//jQuery("#div_"+accepter_id).position({of:jQuery("#"+accepter_id),my:"left bottom",at:"left top",collision:"flip flipfit"});
		//}else{
		jQuery("#div_"+accepter_id).position({of:jQuery("#"+accepter_id),my:"left top",at:"left bottom",collision:"flip flipfit"});
			//}
		//jQuery("#div_"+accepter_id).focusout(function(){jQuery("#div_"+accepter_id).remove();});
	},
	_resize : function (accepter_id) {

		var dropdownDiv = document.getElementById("div_"+accepter_id);
		var contentDiv = document.getElementById("content_"+accepter_id);
		var tableWrapperDiv=document.getElementById("tdv_"+accepter_id);
		if(tableWrapperDiv!=null){
			contentDiv.style.width=tableWrapperDiv.style.width;
		}
		dropdownDiv.style.width=contentDiv.style.width;
		this._repos(accepter_id);
	},
	_returnQuery : function (xmlHttpReq, accepter_id) {
		var contentDiv = document.getElementById("content_"+accepter_id);
		contentDiv.innerHTML = xmlHttpReq.responseText;
		executeLoadedScript(contentDiv);
		this._resize(accepter_id);
	},

	_refreshGrid :function (e) {
		var accepter_id= e.getUserData().data.tag;
		var contentDiv = document.getElementById("content_"+accepter_id);
	    contentDiv.innerHTML = e.getUserData().data.pagecontent;
		executeLoadedScript(contentDiv);
		this.syncGridControl(this._accepter_id);
	},

  syncGridControl:function(accepterId){
		var qr=dqComboboxQueries[accepterId];
	    var accepter_id=qr.accepter_id;
	    var botton1=$("begin_btn_"+accepter_id);
		if(qr.start>1){
			 $("begin_btn_"+accepter_id).setEnabled(true);
			 $("prev_btn_"+accepter_id).setEnabled(true);
		}else{
			 $("begin_btn_"+accepter_id).setEnabled(false);
			 $("prev_btn_"+accepter_id).setEnabled(false);
		}
		if((qr.start+qr.rowcount)< qr.totalCount){
			 $("next_btn_"+accepter_id).setEnabled(true);
			 $("end_btn_"+accepter_id).setEnabled(true);
		}else{
			 $("next_btn_"+accepter_id).setEnabled(false);
			 $("end_btn_"+accepter_id).setEnabled(false);
		}
	},

scrollPage: function (t,accepterId) {
		var s;
		var queryObj=Object.clone(dqComboboxQueries[accepterId]);
		queryObj.tag=accepterId;
		var qs=queryObj.start;
		var qrange=queryObj.range;
		var qtot=queryObj.totalCount;
		if(t=="refresh_"+accepterId) s=0;
		else if(t=="begin_btn_"+accepterId)s=0;
	    else if(t=="prev_btn_"+accepterId)s=qs-qrange-1;
		else if(t=="next_btn_"+accepterId) s= qs+qrange-1;
		else if(t=="end_btn_"+accepterId) s= qtot-qrange-1;
		else s= qs;
		queryObj.start=s;
		queryObj.range=qrange;
		queryObj.drop_flash='y';
		this._executeQuery(queryObj);
	},


	_executeQuery : function (queryObj) {
		var s= Object.toJSON(queryObj);
		Controller.query(s, function(r){
				//try{
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

 returnRow:function(chkBoxEle){
    // return_string is the ak, pkData is the pk id
    var ele=document.getElementById(this._accepter_id);
    if(ele){
    	ele.value=chkBoxEle.title;
		var fk_acpt=$("fk_"+ this._accepter_id);
      	if(fk_acpt!=null)fk_acpt.value=chkBoxEle.id.replace(/chk_obj_/i, "") ;
      	if(ele.onaction){
      		ele.onaction(chkBoxEle.id.replace(/chk_obj_/i, ""));
      	}
    	// for multi line input, check the first checkbox
    	try{
    		var row=this._accepter_id.split('_')[1];
    		document.sheet_item_modify.selectedItemIdx[row].checked = true;
    	}catch(e){
    	}
    	fireEvent(ele,"change");
    	/*try{// prototype method
    		if(ele.onchange)ele.onchange();
    	}catch(e){
    	}*/
    }
	this._hidePopupWindow();
},
 _init_result : function(tableId){
 	/*
	this._selTb= new SelectableTableRows(document.getElementById(tableId), false);

	this._selTb.ondoubleclick=function(trElement){
		var ele=$("chk_obj_"+trElement.title);
		var acpt=$(dq._accepter_id);
	  	acpt.value=ele.title;
	  	var fk_acpt=$("fk_"+ dq._accepter_id);
	  	if(fk_acpt!=null)fk_acpt.value=trElement.title ;
		if(acpt.onaction){
			acpt.onaction(trElement.title);
		}
		dq._hidePopupWindow();
	};
	*/

	var tb=jQuery('#'+tableId).selectable({filter:'tr',tolerance:"fit",cancel:":input,a,.ui-selected"});

		tb.dblclick(function(trElement){
		   if(trElement.srcElement.type=="checkbox"){
		   	return;
		   	}
			//alert(trElement);
		//alert("123")
		//var ele=$("chk_obj_"+trElement.target.parentElement.title);
		ele=trElement.target;
		var acpt=$(dq._accepter_id);
		//alert(ele);
	  acpt.value=ele.textContent;
	  var fk_acpt=$("fk_"+ dq._accepter_id);
	  if(fk_acpt!=null)fk_acpt.value=trElement.target.parentElement.title ;
		if(acpt.onaction){
			acpt.onaction(trElement.target.parentElement.title);
		}
		dq._hidePopupWindow();
	});

},
_hidePopupWindow:function(){
	var e= document.getElementById("div_"+this._accepter_id);
	if(e==null){
		e=document.getElementById("object_query_content");
	}
	if(e!=null)e.style.display = "none";

	var ele=document.getElementById(this._accepter_id);
	if(ele)ele.focus();

},

 /**
  * @param dropdwon_json array, each element is array [id, data1, data2]
  * @param dropdown_query see nds/queyr/dropdown_result.jsp
  */
 drawTable : function (dropdwon_json,dropdown_query){
		var dataid,desc1,desc2,temp;
		var accepterId=dropdown_query.accepter_id;
		dqComboboxQueries[accepterId]=dropdown_query;
		var tableWrapperDiv=document.getElementById("tdv_"+accepterId);
		var contentDiv=document.getElementById("content_"+accepterId);
	    var dropdownDiv = document.getElementById("div_"+accepterId);
		if(dropdwon_json.length==0){
		  str="<iframe id='json_"+accepterId+"' frameborder='0' style='position: absolute; top: 0; left: 0; z-index: 9;'>";
		    str="<table id=\"table_"+accepterId+"\" style='width:140px; overflow:hidden;'  border='0' cellspacing='0' cellpadding='0'  align='center'"+"onselectstart='if(window.event.ctrlKey || window.event.shiftKey) return false;else return true;'>";
		    str=str+"<tr>";
		    str=str+"<td align=\"center\">"+gMessageHolder.NO_DATA+"</td>";
		    str=str+"</tr></table>";
		}else{
		var str="<iframe id='json_"+accepterId+"' frameborder='0' style='width:160; position: absolute; top: 0; left: 0; z-index: 9;'>";
		 str="<table id=\"table_"+accepterId+"\" style='width:140px;' border='0' cellspacing='0' cellpadding='0' align='center'"+"onselectstart='if(window.event.ctrlKey || window.event.shiftKey) return false;else return true;'>";
		str=str+"<tbody>";
		var i=0;
		for(i=0;i<dropdwon_json.length;i++){
		dataid=dropdwon_json[i][0];
		desc1=dropdwon_json[i][1];
		desc2=dropdwon_json[i][2];
		str=str+"<tr height='20' class='"+ (i%2==1?"odd-row":"even-row")+"' title='"+ dataid +"'>";
		str=str+"<td id=\"td_obj_"+dataid+"\"  align=\"center\" width=\"1%\"  nowrap height=\"20\" title=\""+desc1+"\">";
		str=str+"<input type='hidden' name='itemid' value='" + dataid + "'>";
	    str=str+"<input class='cbx' type='radio' "+" id='chk_obj_"+  dataid +"' name='selectedItemIdx' value='"+i+"' onclick='dq.returnRow(this)' title='"+ desc1+"'>"+"</td>";
		str=str+"<td nowrap>"+desc1+"</td>";
        str=str+"<td nowrap>"+desc2+"</td>";
        str=str+"</tr>";
    	}
    	str=str+"</tbody></table>";
       }
    	str=str+"<table class='dq-scroll'><tr>";
    	str=str+"<td id='refresh_"+accepterId+"' onaction=\"dq.scrollPage('refresh_"+accepterId+"','"+accepterId+"')\"><img src=\"/html/nds/images/tb_refresh.gif\" align='absmiddle' border=0></td>";
    	str=str+"<td id='pop_"+accepterId+"' onaction=\"popup_window('"+dropdown_query.poppath+"&action=input')\"><img src=\"/html/nds/images/tb_new.gif\" align='absmiddle' border=0></td>";
    	str=str+"<td >-</td>";
    	str=str+"<td id='begin_btn_"+accepterId+"' onaction=\"dq.scrollPage('begin_btn_"+accepterId+"','"+accepterId+"')\"><img src=\"/html/nds/images/begin.gif\" width='16' height='16'></td>";
        str=str+"<td id='prev_btn_"+accepterId+"' onaction=\"dq.scrollPage('prev_btn_"+accepterId+"','"+accepterId+"')\"><img src=\"/html/nds/images/back.gif\" width='16' height='16'></td>";
        str=str+"<td id='next_btn_"+accepterId+"' onaction=\"dq.scrollPage('next_btn_"+accepterId+"','"+accepterId+"')\"><img src=\"/html/nds/images/next.gif\" width='16' height='16'></td>";
        str=str+"<td id='end_btn_"+accepterId+"' onaction=\"dq.scrollPage('end_btn_"+accepterId+"','"+accepterId+"')\"><img src=\"/html/nds/images/end.gif\" width='16' height='16'></td>";
	   str=str+"</tr></table></iframe>";
	    tableWrapperDiv.innerHTML=str;
	    var tableDiv= document.getElementById("table_"+accepterId);
	    var json= document.getElementById("json_"+accepterId);
	    if(tableDiv.offsetWidth!=0) {
	    	 contentDiv.style.width=tableWrapperDiv.offsetWidth;//+17;
	         dropdownDiv.style.width=contentDiv.style.width;
	         json.style.width=contentDiv.style.width;
	         contentDiv.style.height=tableWrapperDiv.offsetHeight;//+26;
             dropdownDiv.style.height=contentDiv.style.height;
	         json.style.height=contentDiv.style.height;
	         if(dropdwon_json.length==0){
	         contentDiv.style.width=160;
	         dropdownDiv.style.width=contentDiv.style.width;
	         json.style.width=contentDiv.style.width;
	         contentDiv.style.height=40;
             dropdownDiv.style.height=contentDiv.style.height;
	         json.style.height=contentDiv.style.height;
	        }
	    }
		createButton($("refresh_"+accepterId));
		createButton($("pop_"+accepterId));
		createButton($("begin_btn_"+accepterId));
		createButton($("prev_btn_"+accepterId));
		createButton($("next_btn_"+accepterId));
		createButton($("end_btn_"+accepterId));
		dq.syncGridControl(accepterId);
		this._init_result("table_"+accepterId);
		//dropdownDiv.scrollIntoView();
  }
}

DropdownQuery.main = function () {
	dq=new DropdownQuery();
};
jQuery(document).ready(DropdownQuery.main);

DynamicQuery.prototype = {
	initialize: function() {
		this._tr_cloosed_index=-1;
		this._dynshow_json=null;
		this._accepter_id=null;
		this._mouseOnSug=false;
		this._iskey=false;
		this._dynshowjson=null;
		this._dcqjsonlist=null;
	},

	toggle: function(text_focus_index) {
		var flag=false;
		var tableId=null;
		var columnId=null;
		var newvalue="";
		var oldvalue="";
		if(this._dcqjsonlist!=null){
  	 		this._accepter_id=this._dcqjsonlist[text_focus_index].column_acc_Id;
  	 		tableId=this._dcqjsonlist[text_focus_index].tableId;
  	 		columnId=this._dcqjsonlist[text_focus_index].columnId;
  	 		newvalue=this._dcqjsonlist[text_focus_index].newvalue;
  	 		oldvalue=this._dcqjsonlist[text_focus_index].oldvalue;

		}
		if(this._dynshowjson!=null){
			for(var i=0;i<this._dynshowjson.length;i++){
				if(this._dynshowjson[i][0]==$(this._accepter_id).value){
					flag=true;break;
				}
			}
		}
		if(this._dynshow_json!=null){
			if(this._dynshow_json.qdata==$(this._accepter_id).value&&oldvalue!=""){
				flag=true;
			}
		}
		if(newvalue==""&&$("div_dyn")!=null){
			$("div_dyn").style.display="none";
		}
 		if(newvalue!=""&&newvalue!=oldvalue&&!flag){
			var query="/html/nds/query/dynamicshow_result.jsp?table="+tableId+"&column="+columnId+"&accepter_id="+this._accepter_id+"&qdata="+newvalue;
			var pos, path,queryString,dynqueryDiv;
			if($("div_dyn")!=null){
				$("div_dyn").style.display="";
				$("div_dyn").innerHTML ="<div id='divcontent_dyn' style='z-index: 10;'></div>";
			}else{
				var	dynqueryDiv=document.createElement("div");
				dynqueryDiv.id="div_dyn";
				dynqueryDiv.style.display="";
				dynqueryDiv.innerHTML ="<div id='divcontent_dyn' style='z-index:10;'></div>";
				document.body.appendChild(dynqueryDiv);
			}
			$("div_dyn").style.border="1px solid #ffffff";
			var offsets = getOffsets(this._accepter_id);
			pos = query.indexOf("?");
			path = query;
			queryString ="";
			if (pos != -1) {
				path = query.substring(0, pos);
				queryString = query.substring(pos + 1, query.length);
			}
			loadPage(path,queryString,this._returnQuery,this._accepter_id);
		}
	},

 /*
  *close div
 */
	closediv:function(){
		if(Prototype.Browser.IE){
			if($("sug_ie")!=null){
				$("sug_ie").style.display="none";
			}
		}
		$("div_dyn").style.display="none";
	},

		/*
		 * init  table tr.className
		*/
	creattable:function(){
		var trs=$("tb_"+dcq._accepter_id).rows;
		for(var i=0;i<trs.length;i++){
			trs[i].className="odd-row";
		}
	},
	 /*
	  * evaluate and close div
	 */

	clktr:function(j){
		return function(){
			$(dcq._accepter_id).blur();
			dcq.closediv();
			$(dcq._accepter_id).value=this.cells[0].innerHTML;
		};
	},

	   /*
	    * initialize text and tr ,add  basic property
	   */
	setdynamicdata:function(){
		$(this._accepter_id).onkeydown=this.keyboard;
			var isClkSug=false;

		$(this._accepter_id).onblur=function(e){
		//var val=$(this._accepter_id).value;
		if(!isClkSug){
			dcq.closediv();
		}
		isClkSug=false;
		//time=0;
		}

	 	if(typeof (this._dynshow_json.dynshowjson)!="object"||typeof (this._dynshow_json.qdata)=="undefined"||this._dynshow_json.qdata==""){
			return ;
	 	}
		var tab=document.createElement("table");
		with(tab){id="tb_"+this._accepter_id; style.width="100%";style.backgroundColor="#fff"; cellspacing=0; cellpadding=0;style.cursor="default";}
		var tb=document.createElement("tbody");
		tab.appendChild(tb);
		for(var i=0;i<this._dynshow_json.dynshowjson.length;i++){
			var tr=tb.insertRow(-1);
			tr.onmouseover=function(){
	  		dcq.creattable;
	  		this.className="selected";
	  		this._mouseOnSug=true;
	  		};
	  		tr.onmouseout=dcq.creattable;
	  		tr.onmousedown=function(e){
				$(dcq._accepter_id).blur();
				$(dcq._accepter_id).value=this.cells[0].innerHTML;
			};
			tr.onclick=this.clktr(i);
			var td=tr.insertCell(-1);
			td.innerHTML=this._dynshow_json.dynshowjson[i][0];
			td=tr.insertCell(-1);
			td.innerHTML=this._dynshow_json.dynshowjson[i][1];
		}
		var th=tb.insertRow(-1);
		var td=th.insertCell(-1);
		td.innerHTML ="";
		td=th.insertCell(-1);
		td.style.textAlign="right";
		td.innerHTML="<a href='javascript:void(0)'onclick='dcq.closediv();'>"+gMessageHolder.CLOSE_DIALOG+"</a>";
		var offsets = getOffsets(this._accepter_id);
		var div_top=offsets.y+(Prototype.Browser.Gecko?$(this._accepter_id).offsetHeight-3:$(this._accepter_id).offsetHeight);
		var dataheight=(this._dynshow_json.dynshowjson.length+1)*20;
		if(document.body.clientHeight-offsets.y-15<dataheight){
			div_top=div_top-dataheight-20;
		}
		//alert(Prototype.Browser.IE?$(this._accepter_id).offsetWidth+20:$(this._accepter_id).offsetWidth+20);
		$("div_dyn").style.width=(Prototype.Browser.IE?$(this._accepter_id).offsetWidth+20:$(this._accepter_id).offsetWidth+20);
		$("div_dyn").style.top=div_top+"px";
		$("div_dyn").style.left=offsets.x;
		$("div_dyn").style.padding=0;
		$("div_dyn").style.position="absolute";
		$("div_dyn").style.zIndex=10;
		$("divcontent_dyn").style.width=(Prototype.Browser.IE?$(this._accepter_id).offsetWidth+20:$(this._accepter_id).offsetWidth+20);
		$("divcontent_dyn").style.top=div_top+"px";
		$("divcontent_dyn").style.left=offsets.x;
		$("tdiv_"+this._accepter_id).innerHTML="";
		$("tdiv_"+this._accepter_id).appendChild(tab);
		$("tdiv_"+this._accepter_id).style.width=(Prototype.Browser.IE?$(this._accepter_id).offsetWidth+20:$(this._accepter_id).offsetWidth+20);
		$("tdiv_"+this._accepter_id).style.top=div_top+"px";
		$("tdiv_"+this._accepter_id).style.left=offsets.x;
		$("tdiv_"+this._accepter_id).style.display="";
		/*
		if(Prototype.Browser.IE){
			//alert(123);
	 		var sug_ie=$("sug_ie");
	  		if(sug_ie==null){
	  			sug_ie=document.createElement("div");
	  			sug_ie.id="sug_ie";
	  			document.body.appendChild(sug_ie);
	  		}
	  		div_top=$(this._accepter_id).offsetHeight-14;
			if(document.body.clientHeight-div_top<dataheight){
				div_top=div_top-dataheight;
			}
	  		with(sug_ie.style){
	  			display="";
	  			position="absolute";
	  			top=div_top+"px";
	  			left="0px";
	  			width=$("div_dyn").offsetWidth+"px";
	  			height=tab.offsetHeight+"px";
			}
	  		sug_ie.appendChild($("div_dyn"));
		}
		修改定位坐标POSTION
		*/
		jQuery("#div_dyn").position({of:jQuery("#"+this._accepter_id),my:"left top",at:"left bottom",collision:"flip flip"});
		this._tr_cloosed_index=-1;
	},

	/*
	 * keyboard operate
	 */
	keyboard:function(e){
		e=e||window.event;
		this._iskey=false;
		var ctr;
		if(e.keyCode==13){
			if(dcq._tr_cloosed_index>=0){
				dcq.closediv();
				oc.moveTableFocus(e);
			}
		}
		if(e.keyCode==38||e.keyCode==40){
			this._mouseOnSug=false;
			if($("div_dyn").style.display!="none"){
				var trs=$("tb_"+dcq._accepter_id).rows;
				var l=trs.length-1;
				for(var i=0;i<l;i++){
					if(trs[i].className=="selected"){
						dcq._tr_cloosed_index=i;break;
					}
				}
				dcq.creattable();
				if(e.keyCode==38){
					if(dcq._tr_cloosed_index==0){
						$(dcq._accepter_id).value=dcq._dynshow_json.qdata;
						dcq._tr_cloosed_index=-1;
						this._iskey=true;
					}else{
						if(dcq._tr_cloosed_index==-1){
							dcq._tr_cloosed_index=l;
						}
						ctr=trs[--dcq._tr_cloosed_index];
						ctr.className="selected";
						$(dcq._accepter_id).value=ctr.cells[0].innerHTML;
					}
				}
				if(e.keyCode==40){
					if(dcq._tr_cloosed_index==l-1){
						$(dcq._accepter_id).value=dcq._dynshow_json.qdata;
			 			dcq._tr_cloosed_index=-1;
			 			this._iskey=true;
					}else{
						ctr=trs[++dcq._tr_cloosed_index];
						ctr.className="selected";
						$(dcq._accepter_id).value=ctr.cells[0].innerHTML;
					}
				}
			}
		}
	},

	_returnQuery:function(xmlHttpReq,accepter_id){
		var contentDiv = document.getElementById("divcontent_dyn");
		var divtext=xmlHttpReq.responseText;
		contentDiv.innerHTML = xmlHttpReq.responseText;
		executeLoadedScript(contentDiv);
		if(contentDiv.innerHTML!=""){
			$("div_dyn").style.border="1px solid #000000";
		}
	},
	/*
	   add text(auto) column
	*/
	createdynlist:function(dcqjsonlist1){
		if(this._dcqjsonlist==null){
			this._dcqjsonlist=dcqjsonlist1;
		}else{
			var len=this._dcqjsonlist.length;
			var flag=true;
         	for(var i=0;i<dcqjsonlist1.length;i++){
         		flag=true;
         		for(var j=0;j<len;j++){
         			if(this._dcqjsonlist[j].column_acc_Id==dcqjsonlist1[i].column_acc_Id){
         				flag=false;break;
         			}
         		}
         		if(flag){
	          		this._dcqjsonlist[len]=dcqjsonlist1[i];
	          		len++;
	          	}
        	}
		}
	},

	/*
	  time dynamic query
	*/

	dynquery:function(){
		if(this._dcqjsonlist!=null){
			for(var i=0;i<this._dcqjsonlist.length;i++){
				if (this._dcqjsonlist[i].column_acc_Id== document.activeElement.id) {
					if($(this._dcqjsonlist[i].column_acc_Id).value!=this._dcqjsonlist[i].newvalue){
						this._dcqjsonlist[i].oldvalue=this._dcqjsonlist[i].newvalue;
						this._dcqjsonlist[i].newvalue=$(this._dcqjsonlist[i].column_acc_Id).value;
						this.toggle(i);
						break;
					}
				}
			}
		}
  },

	dynjson:function(dynshow_json){
		this._dynshow_json=dynshow_json;
		if(this._dynshow_json.dynshowjson.length>0){
			this._tr_cloosed_index=-1;
   			this._dynshowjson=this._dynshow_json.dynshowjson;
  			this.setdynamicdata();
		}
	}
}
DynamicQuery.main = function(){
	dcq=new DynamicQuery();
};
jQuery(document).ready(DynamicQuery.main);

/**
	 * Get updated url containing options value
	 * @param options, if not empty, will has format like:
	 * {ta:true|false, rc:[<columnId>,<columnId>...], prc:[<columnId>,<columnId>...]}
	 * ta: signs for whether current searchOnColumn is in title area or not
	 * rc: reference columns in wildcard filter, which is in same table as searchOnColumn
	 * prc:reference columns in wildcard filter, which is in parent table of searchOnColumn
	 * @param accepter_id will use this one to confirm position in grid(list or embed object)
	 *  if accepter_id starts from eo_, then is in embed object panel, format like eo_Y_SPEC_ID__NAME
	 *  else is in list, format like M2308_Y_SPEC_ID__NAME
	 * @return null if find error
	 */
function reconstructQueryURL(orgURL, options,accepter_id){
		var url=orgURL;
		if(options !=undefined && options !=null){
			// check every colum input in rc and prc
			var i, str,ele,v, column;
			var ocArray= (options.ta? options.rc: options.prc);
			var gridArray= options.ta?[]:options.rc;
			// columns in objcontrol
			for(i=0;i< ocArray.length;i++){
				ele=$("column_"+ ocArray[i]);
				column = oc.getColumnById(ocArray[i]);
				//console.log("ele="+ ele+",ccolumn="+ column+", v="+ dwr.util.getValue(ele));
				if(ele!=null){
					v=dwr.util.getValue(ele);
					if(v==null || v.blank()){
						// if column is not nullable, alert user to input first
						if(column!=null && !column.isNullable){
							alert(gMessageHolder.INPUT_FIELD.replace("0", column.description));
							ele.focus();
							return;
						}
					}else{
						url+="&wfc_"+ ocArray[i]+"="+ encodeURIComponent(v);
					}
				}
			}
			// columns in gridcontrol
			for(i=0;i< gridArray.length;i++){
				column = gc.getColumnById(gridArray[i]);
				if(column ==null)continue;
				if(accepter_id.startsWith("eo_")){
					//load from embed object panel, accepter_id format:eo_Y_SPEC_ID__NAME
					ele=$("eo_"+ column.name);
				}else{
					//load from grid table, accepter_id format:M2308_Y_SPEC_ID__NAME,
					//will replace Y_SPEC_ID__NAME with column
					ele=$(accepter_id.split("_",1)+"_"+column.name);
				}
				if(ele!=null){
					v=dwr.util.getValue(ele);
					if(v==null || v.blank()){
						// if column is not nullable, alert user to input first
						if(!column.isNullable){
							alert(gMessageHolder.INPUT_FIELD.replace("0", column.description));
							ele.focus();
							return;
						}
					}else{
						url+="&wfc_"+ gridArray[i]+"="+ encodeURIComponent(v);
					}
				}
			}
		}
		return url;
	}

function handleObjectInputKey(event, objectSearchURL){
 	if (!event) {
    		event = window.event;
  	}
  	if ( event.altKey && event.keyCode == 191) {
  		//alert(objectSearchURL);
  		oq.toggle(	objectSearchURL, event.srcElement.id);
  	}
 }


function handleDropdownInputKey(event, objectSearchURL){
 	if (!event) {
    		event = window.event;
  	}
  	if ( event.altKey && event.keyCode == 191) {
  		//alert(objectSearchURL);
  		dq.toggle(	objectSearchURL, event.srcElement.id);
  	}
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
/*	This work is licensed under Creative Commons GNU LGPL License.

	License: http://creativecommons.org/licenses/LGPL/2.1/
   Version: 0.9
	Author:  Stefan Goessner/2006
	Web:     http://goessner.net/
	@param o json object
	@param tab convert tab to this string
*/
function json2xml(o, tab) {
   var toXml = function(v, name, ind) {
      var xml = "";
      if (v instanceof Array) {
         for (var i=0, n=v.length; i<n; i++)
            xml += ind + toXml(v[i], name, ind+"\t") + "\n";
      }
      else if (typeof(v) == "object") {
         var hasChild = false;
         xml += ind + "<" + name;
         for (var m in v) {
            if (m.charAt(0) == "@")
               xml += " " + m.substr(1) + "=\"" + v[m].toString() + "\"";
            else
               hasChild = true;
         }
         xml += hasChild ? ">" : "/>";
         if (hasChild) {
            for (var m in v) {
               if (m == "#text")
                  xml += v[m];
               else if (m == "#cdata")
                  xml += "<![CDATA[" + v[m] + "]]>";
               else if (m.charAt(0) != "@")
                  xml += toXml(v[m], m, ind+"\t");
            }
            xml += (xml.charAt(xml.length-1)=="\n"?ind:"") + "</" + name + ">";
         }
      }
      else {
         xml += ind + "<" + name + ">" + v.toString() +  "</" + name + ">";
      }
      return xml;
   }, xml="";
   for (var m in o)
      xml += toXml(o[m], m, "");
   return tab ? xml.replace(/\t/g, tab) : xml.replace(/\t|\n/g, "");
}

function fireEvent(element,event){
    if (document.createEventObject){
        // dispatch for IE
        var evt = document.createEventObject();
        return element.fireEvent('on'+event,evt)
    }
    else{
        // dispatch for firefox + others
        var evt = document.createEvent("HTMLEvents");
        evt.initEvent(event, true, true ); // event type,bubbling,cancelable
        return !element.dispatchEvent(evt);
    }
}
