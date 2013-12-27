var bpos=null;
var BPOS=Class.create();
BPOS.prototype={
	initialize: function() {
		
//	this._masterObject={
		this.c_store_id=null;//店铺id
		this.c_store_name=null;//店铺名
		this.c_store_sname=null;//
		this.emp_id=null;//当前营业员id
		this.emp_name=null;//当前营业员名称
		this.emp_truename=null;//当前营业员的真实姓名
		this.calculation=null;//计算金额的方式
		this.emps={};//当前店铺的营业列表
		this.payby={}; //付款方式
		this.discountlimit=1.0 //当前用户的折扣率
		this.line_num=0;
//	};
//	this._orderObject={
		this.no=null;//单据号
		this.vip_id=null;//vip卡号
		this.c_viptype=null;//vip卡号类型	
		this.menbdiscount=1.0;//会员折扣率
		this.tot_num=0; //总数量
		this.tot_payable=0; //总应付
		this.tot_amt=0; //原价金额
		this.line=[]; //存放单据明细
		this.payment=[];  //付款方式
		this.tempno=null;//临时退款单号
		this.tempprice=0;//临时退款价格 
		this.temppayment=0;//临时应付价格	
		this.tempcash=0;//支付现金数
		this.cardcash=0;//刷卡金额
		this.certificate=0;	//券值
		this._bpostable=null;
	//};	
	dwr.util.useLoadingMessage(gMessageHolder.LOADING);
	dwr.util.setEscapeHtml(false);
	/** A function to call if something fails. */
	dwr.engine._errorHandler =  function(message, ex) {
	  	while(ex!=null && ex.cause!=null) ex=ex.cause;
	  	if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + ", " + ex.message+","+ ex.cause.message, true);
		if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
	  	else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  	else alert(message);
	};
	application.addEventListener( "BPOS_LOAD_MASTER", this._onloadMasterObject, this);
	application.addEventListener( "BPOS_INSERT_LINE", this._onInsertLine, this);
	application.addEventListener( "BPOS_SUBMIT", this._onSubmit, this);
	application.addEventListener( "BPOS_SAVE", this._onSave, this);
	application.addEventListener( "BPOS_CHECKVIP", this._oncheck, this);
	application.addEventListener( "BPOS_CHECKVIPENTER", this._oncheckenter, this);
	application.addEventListener( "BPOS_SAVE_PRINT", this._onsave_print, this);
	this._initTable()
	this.loadMasterObject();
	this._editvip();
  },
  
   _initTable: function(){
    	this._bpostable =new SelectableTableRows($("modify_table"), false);    
    },
    
 loadMasterObject: function(){
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_LOAD_MASTER";
		var param={};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="load_master";
		evt.permission="w";		
		this._executeCommandEvent(evt);				
	},
   _onloadMasterObject:function(e){
	//	var data=e.getUserData(); // data
	   var data="{ 'docno' : '系统维护', 'c_store_id' : 308, 'sname' : '', 'c_store_name' : '公司成品仓', 'calculation' : 1, 'discountlimit' : 1, 'emps' : [{ 'id' : 754, 'name' : 'wmj', 'truename' : '温明洁' }], 'payby' : [{ 'id' : 7, 'name' : '信用卡', 'iscash' : 'N', 'ischarge' : 'N' },{ 'id' : 5, 'name' : '现金', 'iscash' : 'Y', 'ischarge' : 'Y' },{ 'id' : 27, 'name' : '购物券', 'iscash' : 'Y', 'ischarge' : 'N' }], 'emp_id' : 754, 'emp_name' : 'wmj', 'emp_truename' : '温明洁' }" ;
	//	console.log(data);
	//	var ret=data.jsonResult.evalJSON();
	//	var data="{\"c_store_id\":111,\"c_store_name\":\"上海汇金店\",\"discountlimit\":0.6,\"emp_id\":0,\"emp_name\":\"DBAA\",\"emp_truename\":\"KKK\",\"docno\":\"TRA0707071235\",\"calculation\":1,\"emps\": [{\"id\":21,\"name\":\"hhh\",\"truename\":\"yyc\"},{\"id\":22,\"name\":\"kkk\",\"truename\":\"zyf\"},{\"id\":23,\"name\":\"jjj\",\"truename\":\"zjf\"}],\"payby\":[{\"id\":101,\"name\":\"现金\",\"ischarge\":\"Y\",\"iscash\":\"Y\"},{\"id\":102,\"name\":\"信用卡\",\"ischarge\":\"N\",\"iscash\":\"N\"},{\"id\":103,\"name\":\"购物券\",\"ischarge\":\"N\",\"iscash\":\"Y\"}]}";
		var ret=data.evalJSON();
		this.c_store_name=ret.c_store_name;
		this.c_store_sname =ret.c_store_sname;
		$("c_store_name").innerHTML=this.c_store_name;
		$("no").innerHTML=ret.docno;
		this.c_store_id=ret.c_store_id;
		this.calculation=ret.calculation;
		this.discountlimit =parseFloat(ret.discountlimit);
		this.emps=ret.emps;
	  //  this.emps =[];
		this.payby=ret.payby;
	  //  this.payby =[{"id":101,"name":"现金","ischarge":"Y","iscash":"Y"},{"id":102,"name":"信用卡","ischarge":"N","iscash":"N"},{"id":103,"name":"购物券","ischarge":"N","iscash":"Y"}];	 
		this.emp_name=ret.emp_name;
		this.emp_truename =ret.emp_truename ;
		$("emp_name").innerHTML=this.emp_name+"("+this.emp_truename+")"; 	
	//	alert(this.emps.length);	  
	},
	
	new_order:function(){
	//	var num=this.line.length;	
	//	this.line=[];
	//	dwr.util.removeAllRows("content",{filter:function(tr){return (tr.id!="m_retailrow");}});
	//	this.tot_num=0;
    //    $("tot_num").innerHTML=0;  
    //    this.tot_payable=0;
    //    $("tot_payable").innerHTML="￥0.00";	
    //    this.tot_amt=0;
   //     $("tot_amt").innerHTML="￥0.00";
    if(this.line.length!=0){
     	if(window.confirm("零售数据尚未保存，是否还继续？"))
         {
 	       window.location="/html/nds/bpos/index.jsp";	
 	     }
     }else{
      	window.location="/html/nds/bpos/index.jsp";	
    }
        
    },	
	insertLine:function(){//验证输入商品
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_INSERT_LINE";
		var m_retail_productno=$("m_retail_idx").value;
		$("m_retail_idx").value="";
		var m_retail_type=document.getElementById("m_retailtype").options[document.getElementById("m_retailtype").selectedIndex].value;
		if(m_retail_type=="2"){	
			this._editretailno();
		}	
		var sys_date=$("sys_date").value;			
		var param={"cardno":this.vip_id,"c_store_id":this.c_store_id,"billdate":sys_date,"m_retail_productno":m_retail_productno,"m_retail_type":m_retail_type,"m_retail_orgdocno":this.tempno,"m_retail_priceactual":this.tempprice};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="insertline";
		evt.permission="w";
		this._executeCommandEvent(evt);		
	},
	
	_onInsertLine:function(e){
		var data=e.getUserData(); // data
		console.log(data);
		var ret=data.jsonResult.evalJSON();
	//	var ret={"m_retail_productno":"070707123","m_retail_productvalue":"aaa","m_retail_qty":1,"m_retail_pricelist":250,"m_retail_discount\":\"100%","m_retail_priceactual":250,"m_retail_price":250,"m_retail_type":"N","m_retail_productname":"070707","m_retail_color":"02","m_retail_colorname":"红色","m_retail_size":38,"m_retail_sizename":38,"m_retail_mdim11":"255454"};
	//	var data="{\"lineid\":1,\"m_retail_productno\":\"070707123\",\"m_retail_productvalue\":\"aaa\",\"m_retail_qty\":1,\"m_retail_pricelist\":250,\"m_retail_discount\":\"100%\",\"m_retail_saler\":\"sss\",\"m_retail_salerid\":12,\"m_retail_priceactual\":250,\"m_retail_price\":250,\"m_retail_type\":\"1\",\"m_retail_productname\":\"070707\",\"m_retail_color\":\"02\",\"m_retail_colorname\":\"红色\",\"m_retail_size\":38,\"m_retail_sizename\":38,\"m_retail_mdim11\":\"255454\"}";
	//	var ret=data.evalJSON();
		if(!this._checkproduct(ret)) {
	//	  if(ret.m_retail_type=="Q"){ 
	//	     ret.m_retail_discount=Math.round(parseFloat(this.tempprice)/ret.m_retail_pricelist*1000)/1000;
	//	     ret.m_retail_price=0-this.tempprice;
	//	     if(this.tempno!=null) {
	//	     } 	
	//	  }
	      var mid=this.line_num;
          var len=this.line.length;
		  this.line[len]=ret;
		  this.line[len].m_retail_salerid=this.emp_id;	
		   this.line[len].m_retail_saler=this.emp_name;		  
		  this.line[len].lineid=mid;		 
		  if(mid>9){		 
		  dwr.util.cloneNode("m_retailrow",{idPrefix:mid+'_'});
		  dwr.util.setValue(mid+'_'+"m_retail","<input type=\"checkbox\" name=\"m_retail\"/>");
		  dwr.util.setValue(mid+'_'+"m_retail_productno",ret.m_retail_productno);
	      dwr.util.setValue(mid+'_'+"m_retail_productvalue",ret.m_retail_productvalue);  
	      dwr.util.setValue(mid+'_'+"m_retail_qty",ret.m_retail_qty); 
	      dwr.util.setValue(mid+'_'+"m_retail_pricelist","￥"+ret.m_retail_pricelist); 
	      dwr.util.setValue(mid+'_'+"m_retail_discount",ret.m_retail_discount);       
	      dwr.util.setValue(mid+'_'+"m_retail_priceactual","￥"+ret.m_retail_priceactual); 
	      dwr.util.setValue(mid+'_'+"m_retail_price","￥"+ret.m_retail_price); 
	      dwr.util.setValue(mid+'_'+"m_retail_saler",ret.m_retail_saler); 
	      if(ret.m_retail_type=="1"){
	      dwr.util.setValue(mid+'_'+"m_retail_type","正常"); 
	      }else if(ret.m_retail_type=="2"){
	       	dwr.util.setValue(mid+'_'+"m_retail_type","退货"); 
	      }else if(ret.m_retail_type=="3"){
	       	dwr.util.setValue(mid+'_'+"m_retail_type","赠品"); 	
	      }else{
	       	dwr.util.setValue(mid+'_'+"m_retail_type","全额"); 
	      }		      
	      dwr.util.setValue(mid+'_'+"m_retail_productname",ret.m_retail_productname); 
	      dwr.util.setValue(mid+'_'+"m_retail_color",ret.m_retail_color); 
	      dwr.util.setValue(mid+'_'+"m_retail_colorname",ret.m_retail_colorname); 
	      dwr.util.setValue(mid+'_'+"m_retail_size",ret.m_retail_size); 
	      dwr.util.setValue(mid+'_'+"m_retail_sizename",ret.m_retail_sizename); 
	      dwr.util.setValue(mid+'_'+"m_retail_mdim11",ret.m_retail_mdim11); 
	      $(mid+'_'+"m_retailrow").style.display="";
        }else{
         	$(mid+'_'+"m_retail").innerHTML="<input type=\"checkbox\" name=\"m_retail\" />" ;
         	$(mid+'_'+"m_retail_productno").innerHTML=ret.m_retail_productno; 
         	$(mid+'_'+"m_retail_productvalue").innerHTML=ret.m_retail_productvalue;
         	$(mid+'_'+"m_retail_qty").innerHTML=ret.m_retail_qty; 
         	$(mid+'_'+"m_retail_pricelist").innerHTML="￥"+ret.m_retail_pricelist; 
         	$(mid+'_'+"m_retail_discount").innerHTML=ret.m_retail_discount;
         	$(mid+'_'+"m_retail_priceactual").innerHTML="￥"+ret.m_retail_priceactual;
         	$(mid+'_'+"m_retail_price").innerHTML="￥"+ret.m_retail_price; 
         	$(mid+'_'+"m_retail_saler").innerHTML =ret.m_retail_saler;
         	 if(ret.m_retail_type=="1"){
	          $(mid+'_'+"m_retail_type").innerHTML="正常"; 
	         }else if(ret.m_retail_type=="2"){
	        $(mid+'_'+"m_retail_type").innerHTML="退货"; 
	        }else if(ret.m_retail_type=="3"){
	       $(mid+'_'+"m_retail_type").innerHTML="赠品"; 	
	        }else{
	       	$(mid+'_'+"m_retail_type").innerHTML="全额"; 
	        }	
         	$(mid+'_'+"m_retail_productname").innerHTML=ret.m_retail_productname;
         	$(mid+'_'+"m_retail_color").innerHTML=ret.m_retail_color;
         	$(mid+'_'+"m_retail_colorname").innerHTML=ret.m_retail_colorname;
         	$(mid+'_'+"m_retail_size").innerHTML=ret.m_retail_size;
         	$(mid+'_'+"m_retail_sizename").innerHTML=ret.m_retail_sizename; 
         	$(mid+'_'+"m_retail_mdim11").innerHTML=ret.m_retail_mdim11; 
         	
        }
          //(mid+'_'+"m_retailrow").onclick="alert(\"sdfh\")";
          this.tot_num=ret.m_retail_qty+this.tot_num;
          $("tot_num").innerHTML=this.tot_num;  
          this.tot_payable=this.tot_payable+ret.m_retail_price*ret.m_retail_qty;
          $("tot_payable").innerHTML="￥"+this.tot_payable;	
          this.tot_amt=this.tot_amt+ret.m_retail_pricelist*ret.m_retail_qty;
          $("tot_amt").innerHTML="￥"+this.tot_amt;
          this.line_num =this.line_num +1;
        }        
    },

	_checkproduct : function(ret){
		if(this.line.length==0||ret.m_retail_type=="2"){
		return false;
		}else{
			for(var i=0;i<this.line.length;i++){
				if(this.line[i].m_retail_productno==ret.m_retail_productno&&ret.m_retail_type==this.line[i].m_retail_type&&this.emp_name==this.line[i].m_retail_saler){
					this.line[i].m_retail_qty=this.line[i].m_retail_qty+ret.m_retail_qty;
					this.line[i].m_retail_price=this.line[i].m_retail_qty*this.line[i].m_retail_priceactual;
					$(i+"_m_retail_qty").innerHTML=this.line[i].m_retail_qty;
					$(i+"_m_retail_price").innerHTML="￥"+this.line[i].m_retail_price;
					this.tot_num=ret.m_retail_qty+this.tot_num;
                    $("tot_num").innerHTML=this.tot_num;  
                    this.tot_payable=this.tot_payable+ret.m_retail_price*ret.m_retail_qty;
                    $("tot_payable").innerHTML="￥"+this.tot_payable;	
                    this.tot_amt=this.tot_amt+ret.m_retail_pricelist*ret.m_retail_qty;
                    $("tot_amt").innerHTML="￥"+this.tot_amt;	
					return true;
				}				
			}
			return false;
		}
	},	   	
	
	_executeCommandEvent :function (evt) {
		Controller.handle( Object.toJSON(evt), function(r){
				//try{
					var result= r.evalJSON();
					if (result.code !=0 ){
						alert(result.message);
					}else {
						var evt=new BiEvent(result.callbackEvent);
						evt.setUserData(result.data);
						application.dispatchEvent(evt);
					}
				/*}catch(ex){
					msgbox(ex.message);
				}*/			
		});
	},
	checkvip:function(){
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_CHECKVIP";
		var cardno =$("vip").value;
		var param={"cardno":cardno};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="load_vip";
		evt.permission="w";		
		this._executeCommandEvent(evt);
	},
	_oncheck:function(e)
	{   
	//	var data=e.getUserData(); // data
		//console.log(data);
	//	var ret=data.jsonResult.evalJSON();
	    var data="{\"vip_id\":119,\"vipname\":\"testaaa\",\"vipename\":\"testAAA\",\"c_viptype\":\"金卡\",\"discount\":.8,\"idno\":3303,\"sex\":\"W\",\"birthday\":'',\"validdate\":''}";	    
		var ret=data.evalJSON();
		this.vip_id =ret.cardno;
		$("vip").value=this.vip_id;
        this.c_viptype=ret.c_viptype;
        this.menbdiscount=ret.menbdiscount;
		$("c_viptype").innerHTML=this.c_viptype; 
		$("vipname").innerHTML=ret.vipname;
		$("birthday").innerHTML=ret.birthday;
		$("vipename").innerHTML=ret.vipename;	
		$("sex").innerHTML=ret.sex;	
		$("idno").innerHTML=ret.idno;	
		$("validdate").innerHTML=ret.validdate;						
	},
	checkvip2:function(){
		$("vipnum").innerHTML=this.vip_id; 
		$("viptype1").innerHTML=this.c_viptype;
        Alerts.killAlert($("dlg_vip_content"));
	},	
	checkvipenter:function(){
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_CHECKVIPENTER";
		var cardno=$("vip").value;
		var param={"cardno":cardno};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="load_vip";
		evt.permission="w";		
		this._executeCommandEvent(evt);	
		Alerts.killAlert($("dlg_vip_content"));		
		},
	
	_oncheckenter:function(){
	//	var data=e.getUserData(); // data
	   //console.log(data);
	//	var ret=data.jsonResult.evalJSON();	
      var data="{\"vip_id\":119,\"vipname\":\"testaaa\",\"vipename\":\"testAAA\",\"c_viptype\":\"金卡\",\"menbdiscount\":.8,\"idno\":3303,\"sex\":\"W\",\"birthday\":'',\"validdate\":''}";	    
	//   var data="{\"cardno\":\"SJ00025\",\"c_viptype\":\"金卡\",\"vipname\":\"yyy\",\"birthday\":\"1981-04-19\",\"vipename\":\"jeery\",\"sex\":\"男\",\"idno\":\"515151\",\"validdate\":\"2008-10-7\",\"menbdiscount\":0.6}";	    
		var ret=data.evalJSON();
		this.vip_id =ret.cardno;
        this.c_viptype=ret.c_viptype;
        this.menbdiscount=ret.menbdiscount;
        $("vipnum").innerHTML=this.vip_id; 
		$("viptype1").innerHTML=this.c_viptype;

	},
	
	sales:function(){
		var ele = Alerts.fireMessageBox(
				{
					width: 365,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML="<div id=\"employee_content\"><form id=\"form5\" name=\"form5\" method=\"post\"><table width=\"395\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td><div id=\"treatment_td_inc\"><div id=\"treatment_text\">选择当前营业员:</div></div></td></tr><tr><td><table width=\"350\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">";
				for(var i=0;i<this.emps.length;i++){					
				ele.innerHTML=ele.innerHTML+"<tr><td height=\"30\"><div class=\"desc-txt\"><input type=\"radio\" id="+i+" name=\"employee\"/>"+this.emps[i].name+"("+this.emps[i].truename +")"+"</div></td></tr>"; 
			    }
				ele.innerHTML=ele.innerHTML+"</table></td></tr><tr><td><div id=\"treatment_td_inc\" align=\"center\"><div id=\"treatment_text\"><input type=\"button\" value=\"确定\" class=\"qinput\" onclick=\"javascript:bpos.getEmployee();\"><input type=\"button\" value=\"取消\" class=\"qinput\" onclick=\"javascript:bpos.closeEmployee();\"></div></div></td></tr></table></form></div>";
				executeLoadedScript(ele);
	},	
	
	closeEmployee:function(){
		Alerts.killAlert($("employee_content"));
	},
	
	getEmployee:function(){   
	 var obj;
	 obj=document.getElementsByName("employee"); 
	 for(var i=0;i<obj.length;i++){
	  	if(obj[i].checked){
	  		this.emp_id=this.emps[i].id;
	  		this.emp_name=this.emps[i].name;
	  		this.emp_truename =this.emps[i].truename;
		    $("emp_name").innerHTML=this.emp_name+"("+this.emp_truename+")"; 
	  		break;
	  	}
 	  }	  
 	Alerts.killAlert($("employee_content"));		
	},
	doSubmit:function(){
	},
	_onSubmit:function(){
	},
	_onSave:function(){
	},
	tryClose:function(){	
	    Alerts.killAlert($("dlg_vip_content"));
	},
	_editvip:function(){
		var ele = Alerts.fireMessageBox(
				{
					width: 610,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML= $("dlg_vip").innerHTML.replace(/TMP/g,"");
		executeLoadedScript(ele);
		//$("vip_div").style.visibility="visible";
	},	
  
   _editretailno:function(){
		var ele = Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML= $("r_retail_no").innerHTML.replace(/TMP/g,"");
		executeLoadedScript(ele);
		//$("vip_div").style.visibility="visible";
	},	
	
	   _editretailprice:function(){
		var ele = Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML= $("r_retail_price").innerHTML.replace(/TMP/g,"");
		executeLoadedScript(ele);
		//$("vip_div").style.visibility="visible";
	},	
	tryClose1:function(){	
	    Alerts.killAlert($("r_retail_no_content"));
	},
	
	checkretailno:function(){
		this.tempno=$("retailno").value;
		this._editretailprice();	
	},
	
	neglect :function(){
		this._editretailprice();
	},
		
	checkretailprice:function(){
		this.tempprice=$("retailprice").value ;
		Alerts.killAlert($("r_retail_price_content"));
		Alerts.killAlert($("r_retail_no_content"));
		
	},	
	   _editvip:function(){
		var ele = Alerts.fireMessageBox(
				{
					width: 610,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML= $("dlg_vip").innerHTML.replace(/TMP/g,"");
		executeLoadedScript(ele);
	},
	changnumber:function(){
     var obj,j=0;
	 obj=document.getElementsByName("m_retail");
     for(var i=0;i<obj.length;i++){
      	if(obj[i].checked){
      		j=j+1;
     	}
     }
     	if(j==0){
     		alert("您还没有选中零售单！"); 
     	}else if(j>1){
     		alert("您选了多个选项");
     	}else{	 
	 for(var i=0;i<obj.length;i++){
	  	if(obj[i].checked){
	  	var ele = Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML= $("num").innerHTML.replace(/TMP/g,"");
		executeLoadedScript(ele);
		$("retail_num").value=this.line[i].m_retail_qty;
		$("retail_id").value=i;
		return;
	  	}
 	  }
 	}
	},
	
    changnum:function(){
     	var i=$("retail_id").value;
     	var num=$("retail_num").value;
     	if(num!=this.line[i].m_retail_qty){    		
     	this.line[i].m_retail_price =this.line[i].m_retail_price +(num-this.line[i].m_retail_qty)*this.line[i].m_retail_priceactual;
     	this.tot_num =num-this.line[i].m_retail_qty+this.tot_num;
     	this.tot_payable=this.tot_payable+(num-this.line[i].m_retail_qty)*this.line[i].m_retail_priceactual;
     	this.tot_amt=this.tot_amt+this.line[i].m_retail_pricelist*(num-this.line[i].m_retail_qty);
     	this.line[i].m_retail_qty =num;
     	$(i+"_m_retail_qty").innerHTML=this.line[i].m_retail_qty;
     	$(i+"_m_retail_price").innerHTML="￥"+this.line[i].m_retail_price;	
     	$("tot_num").innerHTML=this.tot_num; 
     	$("tot_payable").innerHTML="￥"+this.tot_payable;
     	$("tot_amt").innerHTML="￥"+this.tot_amt; 
     	}     	
     Alerts.killAlert($("num_content"));	
    },
    
	cancelnum:function(){ 
		Alerts.killAlert($("num_content"));
	},
	
	changprice :function(){
	//	this.discountlimit =0.51168454555;
   //	alert(this.discountlimit);
	var obj,j=0;
	 obj=document.getElementsByName("m_retail");
     for(var i=0;i<obj.length;i++){
      	if(obj[i].checked){
      		j=j+1;
     	}
     }
     	if(j==0){
     		alert("您还没有选中零售单！"); 
     	}else if(j>1){
     		alert("您选了多个选项");
     	}else{	
	 for(var i=0;i<obj.length;i++){
	  	if(obj[i].checked){
		var ele = Alerts.fireMessageBox(
				{
					width: 595,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML= $("amt").innerHTML.replace(/TMP/g,"");
		executeLoadedScript(ele);
		$("minrate").innerHTML=this.discountlimit;
    	$("minprice").innerHTML="￥"+Math.round(parseFloat(this.discountlimit*(this.line[i].m_retail_priceactual-0.05)*100))/100;
		$("maxprice").innerHTML="￥"+Math.round(parseFloat(this.line[i].m_retail_priceactual-this.discountlimit*this.line[i].m_retail_priceactual-0.05)*100)/100;
	  	}
 	  }
    }
 },
	
	changamt:function(){
		var obj3,obj2;
		var retailid;
		var k;
        var flag=1;
   		var temp1;
		this.calculation =6;
	    obj3=document.getElementsByName("radio_amt"); 
	    obj2=document.getElementsByName("m_retail");
	    for(var j=0;j<obj2.length;i++){
	     if(obj2[j].checked){	
	      	 retailid=j;
	      	  break;
	      	}
	    }
		for(var i=3;i<obj3.length;i++){
	     	if(obj3[i].checked){
	     		k=i-3;
	     		if($("discount_"+k).value==""){
	     			alert("请输入相关数据！");
	     			 flag=0;
	     		}else{
	     			 if(k==0){
	     			if($("discount_0").value<this.discountlimit){
	     				$("discount_0").value="";
	     				alert("你输入的折扣率过小！");
	     			  	flag=0;		
	     				}
	     		     }
	     		if(k==1){
	     			if($("discount_1").value< Math.round(parseFloat(this.discountlimit*(this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty-0.05)*100))/100){
	     				$("discount_1").value="";	     				
	     				alert("你输入的特价金额过小！");
	     				flag=0;	     			
	     				}
	     		    }
	     		if(k==2){
	     				if($("discount_2").value> Math.round(parseFloat(this.line[retailid].m_retail_priceactual-this.discountlimit*this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty-0.05)*100)/100){
	     				$("discount_2").value="";	     				
	     				alert("你输入的优惠金额过大！");	
	     				flag=0;     				
	     				}
	     		  }
	     	  }
	     	}	
	    } 
 	     if(this.calculation==1){
	       if(k==0){
	        	temp1 =Math.round(parseFloat($("discount_"+k).value*this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty)*100)/100;
	        	
	        	//temp1 =Math.round(parseFloat(this.discountlimit*(this.line[retailid].m_retail_priceactual-0.05)*100))/100;
	        }else if(k==1){
	            temp1=Math.round(parseFloat($("discount_"+k).value*100))/100;  	
	        }else if(k==2){
	            temp1=Math.round(parseFloat(this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty-$("discount_"+k).value)*100)/100;   	
	        }	      	
	     }else if(this.calculation==2){
	       if(k==0){
	        	temp1 =parseInt($("discount_"+k).value*this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty+parseFloat(0.5));
	        }else if(k==1){
	            temp1=parseInt($("discount_"+k).value+parseFloat(0.5));
	        }else if(k==2){
	            temp1=parseInt(this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty-$("discount_"+k).value+parseFloat(0.5));   	
	        }
	    		
	     }else if(this.calculation==3){	
	       if(k==0){
	        	temp1 =parseInt($("discount_"+k).value*this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty);
	        }else if(k==1){
	            temp1=parseInt($("discount_"+k).value);  	
	        }else if(k==2){
	            temp1=parseInt(this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty-$("discount_"+k).value);   	
	        }	
	     }else if(this.calculation==4){	
	       if(k==0){
	        	temp1 =parseInt($("discount_"+k).value*this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty+parseFloat(0.99));
	        }else if(k==1){
	            temp1=parseInt($("discount_"+k).value+parseFloat(0.99));  	
	        }else if(k==2){
	            temp1=parseInt(this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty-$("discount_"+k).value+parseFloat(0.99));   	
	        }
	     }else if(this.calculation==5){
	        if(k==0){
	        	temp1 =Math.round(parseFloat($("discount_"+k).value*this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty+parseFloat(0.5))*10)/10;
	        }else if(k==1){
	            temp1=Math.round(parseFloat($("discount_"+k).value+parseFloat(0.5))*100)/100;  	
	        }else if(k==2){
	            temp1=Math.round(parseFloat(this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty-$("discount_"+k).value+parseFloat(0.5))*100)/100;   	
	        }
	     
	     }else if(this.calculation==6){	
	        if(k==0){
	        	temp1 =Math.round(parseFloat($("discount_"+k).value*this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty)*10)/10;
	        }else if(k==1){
	            temp1=Math.round(parseFloat($("discount_"+k).value)*10)/10;  	
	        }else if(k==2){
	            temp1=Math.round(parseFloat(this.line[retailid].m_retail_priceactual*this.line[retailid].m_retail_qty-$("discount_"+k).value)*10)/10;   	
	        }
	     }	
	   this.tot_payable=Math.round(parseFloat(this.tot_payable-this.line[retailid].m_retail_price +parseFloat(temp1))*100)/100;
	  
	   this.line[retailid].m_retail_price =temp1 ;
	   $("tot_payable").innerHTML="￥"+this.tot_payable;
	   $(retailid+"_m_retail_price").innerHTML="￥"+this.line[retailid].m_retail_price;
	   Alerts.killAlert($("amt_content"));		  	 		    
	 },
	
	payprice:function(){ 
	  if(this.tot_payable==0){
            alert("没有零售纪录！");
      }else{   
 		var ele = Alerts.fireMessageBox(
				{
					width: 610,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML= $("pay").innerHTML.replace(/TMP/g,"");
		executeLoadedScript(ele);
	    $("paynum").value="￥"+this.tot_payable;
	    $("paynum").disabled="disabled";
	    $("paidnum").value="￥0.00";
	    $("paidnum").disabled="disabled";	    
	    $("unpaidnum").value="￥"+this.tot_payable;
	    $("currpay").value =this.tot_payable;
	    $("unpaidnum").disabled="disabled";
	    $("change").disabled="disabled";
	    $("discription").disabled="disabled";
	     for(var i=0;i<this.payby.length;i++){
	    var option_node=document.createElement("OPTION");
	    option_node.innerHTML=this.payby[i].name;
	    option_node.value=this.payby[i].id;
	    $("payselect").appendChild(option_node);
	    }
	    $("payselect").appendChild(option_node);
	    this.temppayment =this.tot_payable;
	    this.tempcash=0;
		this.cardcash=0;
		this.certificate=0;
	   }	        	    
	},
	
	cancelamt:function(){ 
	Alerts.killAlert($("amt_content"));	 
	},
	
	deleteline:function(){  
	 var obj;
	 obj=document.getElementsByName("m_retail"); 
	 for(var i=obj.length-1;i>=0;i--){
	  	if(obj[i].checked){ 	
	  		var j=this.line[i].lineid;	
	  	  this.tot_num=this.tot_num-this.line[i].m_retail_qty; 
		  this.tot_payable=this.tot_payable-this.line[i].m_retail_price; 
		  this.tot_amt=this.tot_amt-this.line[i].m_retail_pricelist*this.line[i].m_retail_qty; 
	  	    dwr.util.removeAllRows("content",{filter:function(tr){return (tr.id==j+"_m_retailrow");}});
	  	     this.line.splice(i,1);	 
	  	     $("tot_num").innerHTML=this.tot_num; 
     	     $("tot_payable").innerHTML="￥"+this.tot_payable;
     	     $("tot_amt").innerHTML="￥"+this.tot_amt;  	     	
	  	    }
	   }
 	},

	payclose:function(){
	   Alerts.killAlert($("payment_content"));	  
	},
	
	insertpayment:function(){ 
		var i=0;
		var num=0;
		num =$("currpay").value;				
		for(var j=0;j<this.payby.length;j++){
          	if($("payselect").options[$("payselect").selectedIndex].value==this.payby[j].id){
          	    if(this.payby[j].ischarge=="Y"&&this.payby[j].iscash=="Y"){
          	       this.tempcash=this.tempcash+parseFloat(num);      
          	     }else if(this.payby[j].ischarge=="N"&&this.payby[j].iscash=="N"){
          	       this.cardcash=this.cardcash+parseFloat(num);      
          	      }else if(this.payby[j].ischarge=="N"&&this.payby[j].iscash=="N"){
          	       this.certificate=this.certificate+parseFloat(num);      
          	      }          	       
          	 }
         }
		this.temppayment =this.temppayment -num;
		$("paidnum").value="￥"+(this.tot_payable-this.temppayment);
		$("currpay").value =this.temppayment;	
        if(this.temppayment<=0){
		  $("unpaidnum").value="￥0.00"
		  $("currpay").value =0;
		  $("currpay").disabled ="disabled";
          this.temppayment =-this.temppayment;
		    if(this.temppayment>=100&&this.tempcash>=100){
		    $("discription").innerHTML="找零已大于100元，请重新支付!";
		    }else if(this.cardcash>this.tot_payable ){
		      $("discription").innerHTML="信用卡支付过多，请重新支付!";
		    }else if(this.certificate>=this.tot_payable){
		       $("change").value="￥0.00";
         //   }else if(this.temppayment>this.tempcash&&this.certificate<this.temppayment-this.tempcash){
          //    	 $("discription").innerHTML="信用卡支付过多，请重新支付!";
            }else if(this.tempcash==0&&this.cardcash<=this.temppayment){
             	$("change").value="￥0.00";
            }else if(this.certificate>=this.tot_payable&&this.cardcash!=0){
             	$("change").value="￥"+this.cardcash;
            }if(this.temppayment<100&&this.tempcash>=this.temppayment){
            	 $("change").value="￥"+this.temppayment;
            }                         			       
	    }else{
	     $("unpaidnum").value="￥"+(this.temppayment);
	    }
	  //   alert($("payselect").options[$("payselect").selectedIndex].value);		
	    i=this.payment.length ;
		this.payment[i]={"id":$("payselect").options[$("payselect").selectedIndex].value,"name":$("payselect").options[$("payselect").selectedIndex].innerHTML,"num":num};
	   dwr.util.cloneNode("r_payment",{idPrefix:i+'_'});
	   dwr.util.setValue(i+'_'+"payway",this.payment[i].name);  
	   dwr.util.setValue(i+'_'+"paycount",this.payment[i].num); 	
	   $(i+'_'+"r_payment").style.display="";	
	},
	
	repay:function(){  
		dwr.util.removeAllRows("paymentcontent",{filter:function(tr){return (tr.id!="r_payment");}});
		this.payment =[];
		this.temppayment =this.tot_payable;
		$("paynum").value="￥"+this.tot_payable;
		$("paidnum").value="￥0.00";
		$("unpaidnum").value="￥"+this.tot_payable;
		$("currpay").value =this.temppayment;
		if($("currpay").disabled){
			$("currpay").disabled =!$("currpay").disabled;
		}
		this.tempcash=0;
		this.cardcash=0;
		this.certificate=0;
		$("discription").innerHTML ="";
	},
	
	save_print :function() {
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_SAVE_PRINT";
		var comment=$(comment).value;
		var m_retail="["; 
		for(var i=0;i<this.line.length-1;i++){
			m_retail=m_retail +this.line[i];
			m_retail =m_retail +','; 	
		}
		 m_retail=m_retail +this.line[i];
         m_retail =m_retail+"]";  
         
          var pay_ment="["; 
		for(var i=0;i<this.payment.length-1;i++){
			pay_ment=pay_ment +this.payment[i];
			pay_ment =pay_ment +','; 	
		}
		 pay_ment=pay_ment +this.payment[i];
         pay_ment =pay_ment+"]";           			
         var param={"c_store_id":this.c_store_id,"print":"Y","comment":comment,"c_store_name":this.c_store_name,"m_retailitems":m_retail,"payments":pay_ment};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="save_print";
		evt.permission="w";		
		this._executeCommandEvent(evt);			
	},
	_onsave_print:function(){
		
		
	}, 
	
	save:function(){
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_SAVE_PRINT";
		var m_retail="["; 
		for(var i=0;i<this.line.length-1;i++){
			m_retail=m_retail +this.line[i];
			m_retail =m_retail +','; 	
		}
		 m_retail=m_retail +this.line[i];
         m_retail =m_retail+"]";  
         
          var pay_ment="["; 
		for(var i=0;i<this.payment.length-1;i++){
			pay_ment=pay_ment +this.payment[i];
			pay_ment =pay_ment +','; 	
		}
		 pay_ment=pay_ment +this.payment[i];
         pay_ment =pay_ment+"]";           			
         var param={"c_store_id":this.c_store_id,"print":"N","c_store_name":this.c_store_name,"m_retailitems":m_retail,"payments":pay_ment};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="save_print";
		evt.permission="w";		
		this._executeCommandEvent(evt);	
	}

	
};
BPOS.main = function () {
	bpos=new BPOS();
};

/**
* Init
*/
if (window.addEventListener) {
  window.addEventListener("load", BPOS.main, false);
}
else if (window.attachEvent) {
  window.attachEvent("onload", BPOS.main);
}
else {
  window.onload = BPOS.main;
}
