var mx;
var MatrixDef = Class.create();
// define constructor
MatrixDef.prototype = {
	initialize:function() {
		$("insspec").focus();
		portalClient=new PortalClient();
		portalClient.init(null,null,"/servlets/binserv/Rest");
		var query=parseQueryString();
		this._pdtId=query.pdtid[0];
		this._loadInfo();
	},
	_loadInfo:function(){
		var expr={column:"id",condition:"="+this._pdtId};
	  	var params={table:"Y_MATERIAL", columns:["specs","colors"],params:expr, range:1};
		var trans={id:1, command:"Query",params:params};
		var a=new Array(1);
		a[0]=trans;
		portalClient.sendRequest(a, function(response){
			if(!mx.checkResponse(response,0))return;
			var rows=response.data[0].rows;
			//var colors= rows[0][0];
			//var colorExpr={column:"id",condition:"in("+colors+")"};
			
			//mx.listColors(colorExpr,"sel_colors");
		
			var specs=rows[0][0];
			var specExpr={column:"id",condition:"in("+specs+")"};
			mx.listSpecs(specExpr,"sel_specs");
			
			/*
			var sizes= rows[0][1];
			var expr={column:"id",condition:"in("+sizes+")"};
			mx.listSizes(expr,"sel_sizes");
			*/
			var colors= rows[0][1];
			var colorExpr={column:"id",condition:"in("+colors+")"};
			mx.listColors(colorExpr,"sel_colors");
			
			//mx.listSizes({column:"M_ATTRIBUTE_ID",condition:"="+rows[0][2]},"all_sizes");
		});
		
		
	},
	/**
	 Check response created via _createResponse is ok
	 @param response created by _createResponse
	 @param transIdx if whole is ok, check if transaction of specified index is ok, if not ok, show alert and return false
	 @return true if all is good,else false
	*/
	checkResponse:function(response, transIdx){
		if(response==null){alert("服务器处理异常，请重试");return false;}
		if(response.isok!=true){alert("服务器处理异常:"+ response.message+"("+response.code+")");return false;}
		if(transIdx!=undefined && response.data[transIdx].code!=0){
			alert("处理异常:"+ response.data[transIdx].message+"("+response.data[transIdx].code+")");
			return false;
		}
		return true;
	},
	/**
	 Check if there's option have samae value of v in selection list
	 @param element select element
	 @param v value of option
	 @return -1 if not exists, else idx
	*/
	findInList:function(element,v){
		for(i = (element.options.length - 1); i >= 0; i--) {
			if(	element.options[i].value==v) return i;
		}
		return -1;
	},
	checkColor:function(event){
		if (!event) event = window.event;
	  	if (event && event.keyCode && event.keyCode == 13) {
		  	var v=$("inscolor").value;
		  	var expr={combine:"or",expr1:{column:"name",condition:"="+v},expr2:{column:"code",condition:"="+v}};
		  	var params={table:"Y_color", columns:["id","code","name"],params:expr, range:5000};
			var trans={id:1, command:"Query",params:params};
			var a=new Array(1);
			a[0]=trans;
			$("sel_colors").selectedIndex=-1;
			portalClient.sendRequest(a, function(response){
				if(!mx.checkResponse(response,0)){
					dwr.util.selectRange($("inscolor"),0,255);
					return;
				}
				var rows=response.data[0].rows;
				var i,opt;
				var s=$("sel_colors");
				if(rows.length==0){
					$("colormsg").innerHTML="<font color='red'>"+$("inscolor").value+"未找到</font>";
				}else{
					var cnt=0;
					for(i=0;i<rows.length;i++ ){
						 var idx=mx.findInList(s, rows[i][0]);
						 if(idx==-1){
						 	opt= new Option(rows[i][2]+"("+rows[i][1]+")" , rows[i][0]);
						 	s.options[s.options.length] =opt;
						 	s.options[s.options.length-1].selected=true;
						 	cnt++;
						 }else{
						 	s.options[idx].selected=true;	
						}
					}
					$("colormsg").innerHTML="添加"+cnt+"款颜色";
				}
				dwr.util.selectRange($("inscolor"),0,255);
				
			});
		}
	},
	checkSpec:function(event){
		if (!event) event = window.event;
	  	if (event && event.keyCode && event.keyCode == 13) {
		  	var v=$("insspec").value;
		  	var expr={combine:"or",expr1:{column:"name",condition:"="+v},expr2:{column:"code",condition:"="+v}};
		  	var params={table:"Y_spec", columns:["id","code","name"],params:expr, range:5000};
			var trans={id:1, command:"Query",params:params};
			var a=new Array(1);
			a[0]=trans;
			$("sel_specs").selectedIndex=-1;
			portalClient.sendRequest(a, function(response){
				if(!mx.checkResponse(response,0)){
					dwr.util.selectRange($("insspec"),0,255);
					return;
				}
				var rows=response.data[0].rows;
				var i,opt;
				var s=$("sel_specs");
				if(rows.length==0){
					$("specmsg").innerHTML="<font color='red'>"+$("insspec").value+"未找到</font>";
				}else{
					var cnt=0;
					for(i=0;i<rows.length;i++ ){
						 var idx=mx.findInList(s, rows[i][0]);
						 if(idx==-1){
						 	opt= new Option(rows[i][2]+"("+rows[i][1]+")" , rows[i][0]);
						 	s.options[s.options.length] =opt;
						 	s.options[s.options.length-1].selected=true;
						 	cnt++;
						 }else{
						 	s.options[idx].selected=true;	
						}
					}
					$("specmsg").innerHTML="添加"+cnt+"款规格";
				}
				dwr.util.selectRange($("insspec"),0,255);
				
			});
		}
	},
	/**
	 add select row of all_colors to sel_colors
	*/
	addSpec:function(){
		var element= $("all_specs");
		var tgt=$("sel_specs");
		var i;
		tgt.selectedIndex=-1;
		for(i =0;i<element.options.length;i++) {
	    	if(element.options[i].selected == true ) {
	    		var idx=this.findInList(tgt,element.options[i].value);
	    		if( idx==-1){
		    		var temp = new Option(element.options[i].text,element.options[i].value);
		    		tgt.options[tgt.length] =temp;
		    		tgt.options[tgt.length-1].selected=true;
	    		}else{
	    			tgt.options[idx].selected=true;
	    		}
	    	}
	    }
	},
	/**
	Remove colors select in sel_colors
	*/
	removeSpecs:function(){
		var element=$("sel_specs");
		var i;
		for(i = (element.options.length - 1); i >= 0; i--) {
	    	if(element.options[i].selected == true) {
	    		element.options[i]=null;
	    	}
	    }
	},
	/**
	List all specs
	@param expr is defined, will set as query condition
	@param ele default to "all_specs"
	*/
	listSpecs:function(expr,ele){
		var params={table:"Y_SPEC", columns:["id","code","name"],params:(expr==undefined?null:expr),
			orderby:[{column:"name",asc:true}], range:5000};
		var trans={id:1, command:"Query",params:params};
		var a=new Array(1);
		a[0]=trans;
		portalClient.sendRequest(a, function(response){
			if(!mx.checkResponse(response,0))return;
			var rows=response.data[0].rows;
			var i,opt;
			if(ele==undefined)ele="all_specs";
			var s=$(ele).options;
			dwr.util.removeAllOptions($(ele));
			for(i=0;i<rows.length;i++ ){
				 opt= new Option(rows[i][2]+"("+rows[i][1]+")" , rows[i][0]);
				 s[s.length] =opt;
			}
			if(s.length>0) $(ele).selectedIndex=(s.length-1);
		});
	},
	/**
	 
	*/
	addColor:function(){
		var element= $("all_colors");
		var tgt=$("sel_colors");
		var i;
		tgt.selectedIndex=-1;
		for(i =0;i<element.options.length;i++) {
	    	if(element.options[i].selected == true) {
	    		var idx= this.findInList(tgt,element.options[i].value);
	    		if(idx==-1){
	    			var temp = new Option(element.options[i].text,element.options[i].value);
	    			tgt.options[tgt.length] =temp;
	    			tgt.options[tgt.length-1].selected=true;
	    		}else{
	    			 tgt.options[idx].selected=true;
	    		}
	    	}
	    }
	},
	/**
	Remove colors select in sel_colors
	*/
	removeColors:function(){
		var element=$("sel_colors");
		var i;
		for(i = (element.options.length - 1); i >= 0; i--) {
	    	if(element.options[i].selected == true) {
	    		element.options[i]=null;
	    	}
	    }
	},
	/**
	List all colors
	@param expr is defined, will set as query condition
	@param ele default to "all_sizes"
	*/
	listColors:function(expr,ele){
		var params={table:"Y_COLOR", columns:["id","code","name"],params:(expr==undefined?null:expr),
			orderby:[{column:"name",asc:true}], range:5000};
		var trans={id:1, command:"Query",params:params};
		var a=new Array(1);
		a[0]=trans;
		portalClient.sendRequest(a, function(response){
			if(!mx.checkResponse(response,0))return;
			var rows=response.data[0].rows;
			var i,opt;
			if(ele==undefined)ele="all_colors";
			var s=$(ele).options;
			dwr.util.removeAllOptions($(ele));
			for(i=0;i<rows.length;i++ ){
				 opt= new Option(rows[i][2]+"("+rows[i][1]+")" , rows[i][0]);
				 s[s.length] =opt;
			}
			if(s.length>0) $(ele).selectedIndex=(s.length-1);
		});
	},
	save:function(){
		var specs=[],colors=[],i;
		var ele=$("sel_specs");
		for(i =0; i<ele.options.length; i++) {
	    	specs.push(ele.options[i].value);
	    }
	    var ele=$("sel_colors");
		for(i =0; i<ele.options.length; i++) {
	    	colors.push(ele.options[i].value);
	    }
	    if(specs.length==0){
	    	alert("请选中至少一款规格");
	    	return;
	    }
	    if(colors.length==0){
	    	alert("请选中至少一款颜色");
	    	return;
	    }
	    /*
	    var params={table:"y_material", id:this._pdtId,specs:specs.join(","),colors:colors.join(","),partial_update:true};
	    var trans={id:1, command:"Modify",params:params};
	    var a=new Array(1);
			a[0]=trans;
	    portalClient.sendRequest(a, function(response){
	    	//alert(Object.toJSON(response));
				if(!mx.checkResponse(response,0))return;
				portalClient.execWebAction("mtl_addalias",mx._pdtId,"id",function(rs){
					if(!mx.checkResponse(rs,0))return;
				});
				alert("保存成功");
		 });*/
	    	
		portalClient.modifyObject("y_material",{id:this._pdtId,specs:specs.join(","),colors:colors.join(",")}, function(response){
			if(!mx.checkResponse(response,0))return;
				portalClient.execWebAction("mtl_addalias",mx._pdtId,"id",function(rs){
					if(!mx.checkResponse(rs,0))return;
				});
			alert("保存成功");
		});
	},
	cancel:function(){
		var w = window.opener;
		if(w==undefined)w= window.parent;
		if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
	    		//w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'));",1);
	    		art.dialog.close();
	    		return true;
			}
		}
		window.close();
		
	}	
};
MatrixDef.main = function () {
	mx=new MatrixDef();
};
jQuery(document).ready(MatrixDef.main); 
/* 
http://safalra.com/web-design/javascript/parsing-query-strings
 */
function parseQueryString(queryString){
  var result = {};
  if (queryString == undefined){
    queryString = location.search ? location.search : '';
  }
  if (queryString.charAt(0) == '?') queryString = queryString.substring(1);
  queryString = queryString.replace(/\+/g, ' ');
  var queryComponents = queryString.split(/[&;]/g);
  for (var i = 0; i < queryComponents.length; i++){
    var keyValuePair = queryComponents[i].split('=');
    var key = decodeURIComponent(keyValuePair[0]);
    var value = decodeURIComponent(keyValuePair[1]);
    if (!result[key]) result[key] = [];
    result[key].push((keyValuePair.length == 1) ? '' : value);
  }
  return result;
}
