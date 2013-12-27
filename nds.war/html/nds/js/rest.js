/**
 This is javascript REST API for Portal, those js files should be included:
 /html/nds/js/prototype_min.js
 /html/nds/js/md5.js
 
*/
var portalClient;
var PortalClient = Class.create();
// define constructor
PortalClient.prototype = {
	initialize: function() {
		this._appKey=null;
		this._appSecret=null;
		this._serverURL=null;
		this._sipStatusMsg={"0000":"\u670d\u52a1\u8bf7\u6c42\u5931\u8d25","9999":"\u670d\u52a1\u8bf7\u6c42\u6210\u529f","1001":"\u7b7e\u540d\u65e0\u6548","1002":"\u8bf7\u6c42\u8fc7\u671f","1003":"\u7528\u6237\u7ed1\u5b9a\u5931\u8d25","1004":"\u9700\u8981\u7ed1\u5b9a\u7528\u6237","1005":"/\u9700\u8981\u63d0\u4f9bAppKey","1006":"\u9700\u8981\u63d0\u4f9b\u670d\u52a1\u540d","1007":"\u9700\u8981\u63d0\u4f9b\u7b7e\u540d","1008":"\u9700\u8981\u63d0\u4f9b\u65f6\u95f4\u6233","1009":"\u7528\u6237\u8ba4\u8bc1\u5931\u8d25","1010":"\u65e0\u6743\u8bbf\u95ee\u670d\u52a1","1011":"\u670d\u52a1\u4e0d\u5b58\u5728","1012":"\u9700\u8981\u63d0\u4f9bSessionId","1013":"\u9700\u8981\u63d0\u4f9b\u7528\u6237\u540d"};
		this._loadingDiv=null;
	},
	/**
	 set loading div, will show this div when connecting server, and hide after response
	 by default, this div should be hidden
	 @param divId id of the loading div
	*/
	setLoadingDiv:function(divId){
		this._loadingDiv=$(divId);
	},
	/**
	 There's two kinds usage, local and remote. For local call, set serverURL without http
	 @param appKey can be null when local
	 @param appSecret can be null when local
	 @param serverURL, if not starts with http, will take as local rest call(reuse session)
	*/
	init:function(appKey,appSecret,serverURL){
		this._appKey=appKey;
		this._appSecret=appSecret;
		this._serverURL=serverURL;
	},
	clear:function(){
		this._appKey=null;
		this._appSecret=null;
		this._serverURL=null;
	},
	/**
	If n is less then 10, will prefixed with "0" 
	@param n 1-99 integer
	@return 2 chars
	*/
	_digit2:function(n){
		if(n<10) return "0"+n;
		return String(n);
	},
	/**
	Create a new object
	*/
	exesql:function(name,values,callback){
    	var params={name:name,values:values, parsejson:"N"};
    	var trans={id:1, command:"ExecuteSQL",params:params};
    	var a=new Array(1);
		a[0]=trans;
		return this.sendRequest(a, callback);
	},
	/**
	Create a new object
	ret=createObject("fi_v_asset", {C_COMPANY_ID__NAME:"ddf", FITYPE_ID__NAME:"ccc"})
	console.log(ret)
	*/
	createObject:function(table,params,callback){
    	params.table=table;
    	var trans={id:1, command:"ObjectCreate",params:params};
    	var a=new Array(1);
		a[0]=trans;
		return this.sendRequest(a, callback);
	},
	modifyObject:function(table,params, callback){
    	params.table=table;
    	params.partial_update=true;
    	var trans={id:1, command:"ObjectModify",params:params};
    	var a=new Array(1);
		a[0]=trans;
		return this.sendRequest(a, callback);
	},
	
	_exeObj:function(cmd,table,value,valueType,callback){
		if(valueType==undefined) valueType="ak";
		var params={table:table};
		params[valueType]=value;
    	var trans={id:1, command:cmd,params:params};
    	var a=new Array(1);
		a[0]=trans;
		return this.sendRequest(a, callback);
	},
	/**
	@param table can be table id/name/alias
	@param value can be id/ak/id_find value
	@param valueType "id"|"ak"|"id_find", default is "ak"
	*/
	submitObject:function(table,value,valueType,callback){
		return this._exeObj("ObjectSubmit",table,value,valueType, callback);
	},
	unsubmitObject:function(table,value,valueType,callback){
		return this._exeObj("ObjectUnsubmit",table,value,valueType, callback);
	},
	/**
	@param table can be table id/name/alias
	@param value can be id/ak/id_find value
	@param valueType "id"|"ak"|"id_find", default is "ak"
	*/
	deleteObject:function(table,value,valueType,callback){
		return this._exeObj("ObjectDelete",table,value,valueType, callback);
	},
	/**
	@param webaction id/name of ad_action
	*/
	execWebAction:function(webaction,value,valueType,callback){
		if(valueType==undefined) valueType="ak";
		var params={webaction:webaction};
		params[valueType]=value;
    	var trans={id:1, command:"ExecuteWebAction",params:params};
    	var a=new Array(1);
		a[0]=trans;
		return this.sendRequest(a, callback);
	},
	/**
	@param table
	@param qlcid id of QueryListConfig table
	@param expr filter expression
	@param maxCount max count of returned records, not bigger than server max value
	@param callback function, omit for synchronous call, function should have one argument for RestResponse object{code,message,data}
	*/
	query:function(table,qlcid,expr,maxCount, callback){
		var params={table:table, qlcid:qlcid,params: (expr==null?null:Object.toJSON(expr)), range:maxCount};
		var trans={id:1, command:"Query",params:params};
		var a=new Array(1);
		a[0]=trans;
		return this.sendRequest(a, callback);
	},
	/**
	Send request and return Array of TransactionResponse, or raise error
	@param transactions should be array of Object, each contains a Transaction defined in API doc
	@param callback function, omit for synchronous call, function should have one argument for RestResponse object{code,message,data}
	*/ 
	sendRequest:function(transactions, callback){
		var req={};
		if(this._appKey!=null){
			var d = new Date();
			req.sip_appkey=this._appKey;
			req.sip_timestamp=d.getFullYear()+"-"+this._digit2(d.getMonth()+1)+"-"+ this._digit2(d.getDate())+" "+
				this._digit2(d.getHours())+":"+this._digit2(d.getMinutes())+":"+this._digit2(d.getSeconds())+".111";
			req.sip_sign=hex_md5(req.sip_appkey+req.sip_timestamp+this._appSecret);
		}
		req.transactions=Object.toJSON(transactions);
		return this._sendRest($H(req).toQueryString(),callback);
	},
	/**
	Create object for server rest response
	@param sipStatus string of error code
	@param content
	*/
	_createResponse:function(sipStatus,content){
		var ret={isok:false};
		try{
			ret.code=parseInt(sipStatus);
			if(sipStatus=="9999"){
				ret.data=content.evalJSON();
				ret.isok=true;
			}else if(sipStatus=="0000"){
				ret.message=content;
			}else{
				ret.message=this._sipStatusMsg[sipStatus];
			}
			if(ret.message==null) ret.message="unknown";
		}catch(ex){
			ret.code=0;
			ret.message=ex;
			ret.data=null;
		}
		return ret;
	},
	/**
	 Open a web connection to server and parse response, if not a valid REST request, error will be thrown
	 @param content body string containing request info
	 @param callback, callback function, who should have one argument for RestResponse object
	*/
	_sendRest:function(content,callback){
		var url=this._serverURL;
	  	if(callback!=undefined){
			new Ajax.Request(url, {
				  postBody:	content,
				  method: 'post',
				  onCreate:function(){
				  	if(portalClient._loadingDiv!=null)portalClient._loadingDiv.show();
				  },
				  onSuccess: function(transport) {
				  	if(portalClient._loadingDiv!=null)portalClient._loadingDiv.hide();
				  	var res= portalClient._createResponse(transport.getResponseHeader("sip_status"), transport.responseText);
				  	callback(res);
				  },
				  onFailure:function(transport){
				  	if(portalClient._loadingDiv!=null)portalClient._loadingDiv.hide();
				  	var res= portalClient._createResponse("0000", null);
				  	callback(res);
				  }
				}
			);
			return true;
		}else{
			if(portalClient._loadingDiv!=null)portalClient._loadingDiv.show();
			var transport = Ajax.getTransport();
			transport.open("POST", url, false);//synchronous
			transport.setRequestHeader("Content-type", "application/x-www-form-urlencoded ; charset=UTF-8");
	   		try{
	   			transport.send();
	   			return this._createResponse(transport.getResponseHeader("sip_status"), transport.responseText);
	   		}catch(ex){
	   			return this._createResponse("0000",ex);
	   		}finally{
	   			if(portalClient._loadingDiv!=null)portalClient._loadingDiv.hide();
	   		}
			
		}
	}
	
};

