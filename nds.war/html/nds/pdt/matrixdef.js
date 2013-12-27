var mx;

var MatrixDef = Class.create();
// define constructor
MatrixDef.prototype = {
	initialize:function() {
		$("inscolor").focus();
		portalClient=new PortalClient();
		portalClient.init(null,null,"/servlets/binserv/Rest");
		var query=parseQueryString();
		this._pdtId=query.pdtid[0];

		var brandid=0;
		isbrand="false";
		this._loadInfo();
		this._isbrand();
		//this._brandid="";
	},
	_isbrand:function(){
		var expr={column:"NAME",condition:"=portal.4134"};
	  	var params={table:"ad_param", columns:["VALUE"],params:expr, range:1};
		var trans={id:1, command:"Query",params:params};
		var a=new Array(1);
		a[0]=trans;
		portalClient.sendRequest(a, function(response){
			if(!mx.checkResponse(response,0))return;
			var rows=response.data[0].rows;
			isbrand=rows[0][0];
			//alert(isbrand);
		});
		
	},
	
	_loadInfo:function(){
		var expr={column:"id",condition:"="+this._pdtId};
	  	var params={table:"m_product", columns:["colors","sizes","M_SIZEGROUP_ID","M_DIM1_ID"],params:expr, range:1};
		var trans={id:1, command:"Query",params:params};
		var a=new Array(1);
		a[0]=trans;
		portalClient.sendRequest(a, function(response){
			if(!mx.checkResponse(response,0))return;
			var rows=response.data[0].rows;
			var colors= rows[0][0];
			brandid=rows[0][3];
			//alert(this._brandid);
			//var colorExpr={combine:"and",expr1:{column:"M_DIM1_ID",condition:brandid},expr2:{column:"id",condition:"in("+colors+") and isactive=\'Y\'"}};
			var colorExpr={column:"id",condition:"in("+colors+") and isactive=\'Y\'"};
			mx.listColors(colorExpr,"sel_colors");
			
			var sizes= rows[0][1];
			var expr={column:"id",condition:"in("+sizes+")"};
			mx.listSizes(expr,"sel_sizes");
			
			mx.listSizes({column:"M_ATTRIBUTE_ID",condition:"="+rows[0][2]},"all_sizes");
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
		  	if(brandid!=null&&isbrand!="false"){
		  	var expr={combine:"or",expr1:{column:"",condition:"exists(select 1 from dual WHERE M_COLOR.NAME='"+v+"' and M_COLOR.M_DIM1_ID="+brandid+")"},
		  	expr2:{column:"",condition:"exists(select 1 from dual WHERE M_COLOR.VALUE='"+v+"' and M_COLOR.M_DIM1_ID="+brandid+")"}};
		  	}else{
		  	var expr={combine:"or",expr1:{column:"name",condition:"="+v},expr2:{column:"value",condition:"="+v}};
		  	}
		  	var params={table:"m_color", columns:["id","value","name"],params:expr, range:5000};
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
	/**
	 add select row of all_colors to sel_colors
	*/
	addColor:function(){
		var element= $("all_colors");
		var tgt=$("sel_colors");
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
	@param ele default to "all_colors"
	*/
	listColors:function(expr,ele){
		//alert(expr);
		//alert(ele);
		//alert(brandid);
		
		if(brandid!=null&&isbrand!="false"){
				if(ele==undefined){expr={"combine":"and","expr1":{"column":"isactive","condition":"Y"},"expr2":{"column":"M_DIM1_ID","condition":brandid}}}
			}else{
				if(ele==undefined){expr={"column":"isactive","condition":"Y"}}
		}
		var params={table:"m_color", columns:["id","value","name"],params:(expr==undefined?null:expr),
			orderby:[{column:"name",asc:true}], range:5000};
		//alert(expr["combine"]);		
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
	/**
	 
	*/
	addSize:function(){
		var element= $("all_sizes");
		var tgt=$("sel_sizes");
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
	removeSizes:function(){
		var element=$("sel_sizes");
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
	listSizes:function(expr,ele){
		var params={table:"m_size", columns:["id","value","name"],params:(expr==undefined?"isactive='Y'":expr),
			orderby:[{column:"martixcol",asc:true}], range:5000};
		var trans={id:1, command:"Query",params:params};
		var a=new Array(1);
		a[0]=trans;
		portalClient.sendRequest(a, function(response){
			if(!mx.checkResponse(response,0))return;
			var rows=response.data[0].rows;
			var i,opt;
			if(ele==undefined)ele="all_sizes";
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
		var colors=[],sizes=[],i;
		var ele=$("sel_colors");
		for(i =0; i<ele.options.length; i++) {
	    	colors.push(ele.options[i].value);
	    }
	    var ele=$("sel_sizes");
		for(i =0; i<ele.options.length; i++) {
	    	sizes.push(ele.options[i].value);
	    }
	    if(colors.length==0){
	    	alert("请选中至少一款颜色");
	    	return;
	    }
	    if(sizes.length==0){
	    	alert("请选中至少一款尺寸");
	    	return;
	    }
		portalClient.modifyObject("m_product",{id:this._pdtId,colors:colors.join(","),sizes:sizes.join(",")}, function(response){
			if(!mx.checkResponse(response,0))return;
			portalClient.execWebAction("pdt_addalias",mx._pdtId,"id",function(rs){
				if(!mx.checkResponse(rs,0))return;
			});
			alert("保存成功");
			//mx.cancel();
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
