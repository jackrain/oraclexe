var bpos=null;
var BPOS=Class.create();
BPOS.prototype={
	initialize: function() {
		
//	this._masterObject={
		this.c_store_id=null;//店铺id
		this.c_store_name=null;//店铺名
		this.c_store_sname=null;//
		this.m_retail_type=null;//类型
		this.emp_id=null;//当前营业员id
		this.emp_name=null;//当前营业员名称
		this.emp_truename=null;//当前营业员的真实姓名
		this.calculation=null;//计算金额的方式
		this.emps={};//当前店铺的营业列表
	//	this.payby={}; //付款方式
	  this.printRes=-1;//打印结果
	  this.v_retailid=null;//未处理的收银单id
		this.discountlimit=1.0 //当前用户的折扣率
		this.line_num=0;
		this.emp_ids=[];   //当前店铺营业员的ids
		this.emp_names=[]; //当前店铺营业员的names
		this.emp_truenames=[]; //当前店铺营业员的truenames
		this.pids=[];    //付款方式的id
		this.pnames=[];  //付款方式的名称
		this.iscashs=[];  //是否是现金
		this.ischarges=[]; //是否找零
		this.strategyId=[];  //策略id
		this.strId=null;//选中的整单策略Id
		this.strategyName=[];  //策略名称
		this.pressB=null;     //按钮（重复打印/提交打印）
		this.xobj = -1;
		this.disp = 0;
		this.posno=null;
		this.flag=0;
		this.price1=0;
		this.totdiacount=0;
		this.deletelines=0;
		this.dline =0;//动态生成的行 
		this.lines=9; 
		this.templine=[];
		this.tot_payable_origin=0;//原始总应付
		//	};
//	this._orderObject={
		this.no="";//单据号
		this.vip_id="";//vip卡号
		this.c_viptype="";//vip卡号类型	
		this.cardno ="";//vip卡号
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
		this.change=0;
		this.tempretailid =0; //修给金额时的选种的retailid
		this.flagprice=0;
		this.pos_machine=-1;
		this.posdocno="";
		this.isdiscount='0';
		this.isscore='0';
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
	application.addEventListener( "BPOS_CHECKVIP", this._oncheck, this);
	application.addEventListener( "BPOS_CHECKVIPENTER", this._oncheckenter, this);
	application.addEventListener( "BPOS_SAVE_PRINT", this._onsave_print, this);
	application.addEventListener( "BPOS_CHANGAMT", this._changamt, this);
	application.addEventListener( "BPOS_INSERT_LINE_Q", this._onInsertLine_q, this);
	application.addEventListener( "BPOS_CHECK_POSNO", this._oncheckposno, this);
	application.addEventListener( "BPOS_DISCOUNT", this._ondiscount, this);
	application.addEventListener( "BPOS_DISCOUNTCHOICE", this._ondiscountchoice, this);
	application.addEventListener( "PrintJasper", this._onPrintJasper, this);
  application.addEventListener( "SavePrintSetting", this._onSavePrintSetting, this);
	this._initTable()
	this.loadMasterObject();
	this._editvip();
	//this.keepfalse();
  },
  
   _initTable: function(){
    //	this._bpostable =new SelectableTableRows($("modify_table"), false);    
    },
 
 stopDefault:function ( e ) { 
		if(document.all){
			window.event.keyCode=0;
			window.event.cancelBubble = true;
		}
 },
 keepfalse:function(){
     jQuery("#objtb22").bind("keydown",function(event){
     		event.stopPropagation();
     		
   	   if(event.which==112){
						   	bpos.payprice();
						   	bpos.stopDefault();
						   	return false;
   	    }else if(event.which==113){		
			  				bpos.new_order();
			  				bpos.stopDefault();
								return false;
				}else if(event.which==114){
				   			bpos.changnumber();
				    		bpos.stopDefault();	
						return false;
				}if(event.which==115){
								bpos.changeretailtype();
						 		bpos.stopDefault();	
						 		return false;
				}if(event.which==116){
						   	bpos.deleteline();
							  bpos.stopDefault();
							  return false;
				}if(event.which==117){
						   	bpos.repeatPrint();
							  bpos.stopDefault();
							  return false;
				}   	     			
     });
  	},
 
 
 
 checkposno:function(posno){
 		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_CHECK_POSNO";
		var param={"posno":posno};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="checkpos";
		evt.permission="w";		
		this._executeCommandEvent(evt);			
 	},  
 	
 _oncheckposno:function(e){
		var data=e.getUserData();
		var ret=data.jsonResult.evalJSON();
		if(ret!='wr'){
			alert("所输入的POS机号不存在！");
			return;
		}
 },
 
 _ondiscount:function(e){
 	 
		var data=e.getUserData();
		var ret=data.jsonResult.evalJSON();
		this.strategyId=ret.pids;
		this.strategyName=ret.pnames;
		if(this.strategyId.length == 0){
			this.payprice();
		}else{
			this.drawstra();
		}
 },
 discount:function(){
 	  if(this.line.length==0){
      alert("没有零售纪录！");
      return;
    }
 		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_DISCOUNT";
		
		var param={"c_store_name":this.c_store_name,"productno":this.line[0].m_retail_productno,"cardno":this.cardno};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="discount";
		evt.permission="r";		
		this._executeCommandEvent(evt);
 	},  
 
 _ondiscountchoice:function(e){
		var data=e.getUserData();
		var ret=data.jsonResult.evalJSON();
		this.tot_payable=ret.p_discount_num;
		art.dialog.get('art_strategy').close();
		this.payprice();
 },
 discountchoice:function(){
 		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_DISCOUNTCHOICE";
		var param={"strategyId":this.strId,"tot_payable":this.tot_payable_origin};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="discount";
		evt.permission="w";		
		this._executeCommandEvent(evt);
 	},
 
 	
 	drawstra:function(){
 		
    	  var dialogDiscount = window.confirm("是否使用整单策略?");
    	  if(dialogDiscount==false){
    	  	this.payprice();
    	  }else{
		    var options=$H({id:"art_strategy",width:600,height:300,title:'整单策略',padding:0,resize:false,drag:true,lock:true,skin:'chrome',esc:true});
		    options.content=$("strategy").innerHTML.replace(/TMP/g,"");
		    art.dialog(options);
		    this.insertdiscount();
		  }    	    
	},
 loadMasterObject: function(){
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_LOAD_MASTER";
		var posno=jQuery("#pos_no").val();
		//alert(posno);
		var param={"posno":posno};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="load_master";
		evt.permission="w";		
		this._executeCommandEvent(evt);				
	},
   _onloadMasterObject:function(e){
		var data=e.getUserData(); // data
	//	console.log(data);
		var ret=data.jsonResult.evalJSON();
	//	var data="{\"c_store_id\":111,\"c_store_name\":\"上海汇金店\",\"discountlimit\":0.6,\"emp_id\":0,\"emp_name\":\"DBAA\",\"emp_truename\":\"KKK\",\"docno\":\"TRA0707071235\",\"calculation\":1,\"emps\": [{\"id\":21,\"name\":\"hhh\",\"truename\":\"yyc\"},{\"id\":22,\"name\":\"kkk\",\"truename\":\"zyf\"},{\"id\":23,\"name\":\"jjj\",\"truename\":\"zjf\"}],\"payby\":[{\"id\":101,\"name\":\"现金\",\"ischarge\":\"Y\",\"iscash\":\"Y\"},{\"id\":102,\"name\":\"信用卡\",\"ischarge\":\"N\",\"iscash\":\"N\"},{\"id\":103,\"name\":\"购物券\",\"ischarge\":\"N\",\"iscash\":\"Y\"}]}";
	//	var ret=data.evalJSON();
		this.c_store_name=ret.c_store_name;
		this.c_store_sname =ret.c_store_sname;
		this.posdocno=ret.docno;
		$("c_store_name").innerHTML=this.c_store_name;
		$("ticketNo").innerHTML=ret.docno;
		$("dealNum").innerHTML=ret.day_currect;
		$("sys_date").innerHTML=ret.sys_date;
		this.c_store_id=ret.c_store_id;
		this.calculation=1;
		//this.discountlimit =parseFloat(ret.discountlimit);
		//this.emp_ids=ret.emp_ids;
		//this.emp_names=ret.emp_names;
		//this.emp_truenames=ret.emp_truenames;
		this.pids=ret.pids;
		this.pnames=ret.pnames;
		this.iscashs=ret.iscashs;
		this.ischarges=ret.ischarges;
		//this.emp_id=ret.emp_id;
	//	this.emps=ret.emps;
	  //  this.emps =[];
	//	this.payby=ret.payby;
	  //  this.payby =[{"id":101,"name":"现金","ischarge":"Y","iscash":"Y"},{"id":102,"name":"信用卡","ischarge":"N","iscash":"N"},{"id":103,"name":"购物券","ischarge":"N","iscash":"Y"}];	 
		//this.emp_name=ret.emp_name;
		//this.emp_truename =ret.emp_truename ;
		//$("emp_name").innerHTML=this.emp_name+"("+this.emp_truename+")";
	//	alert(this.emps.length);	  
	},
    
	insertLine:function(){
		var m_retail_type=document.getElementById("m_retailtype").options[document.getElementById("m_retailtype").selectedIndex].value;
	
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_INSERT_LINE";
		var m_retail_productno=$("m_retail_idx").value;
		// $("m_retail_idx").value="";
		var m_retail_type=document.getElementById("m_retailtype").options[document.getElementById("m_retailtype").selectedIndex].value;
		var m_retail_qty =jQuery("#number").val();

		var sys_date=jQuery("#sys_date").html();		
		var priceactual=jQuery("#price").val();	
		
		var emper=jQuery("#emp_name").val();
		this.emp_new_name = emper;
		var param={"cardno":this.cardno,"c_store_id":this.c_store_id,"billdate":sys_date,"m_retail_productno":m_retail_productno,"m_retail_qty":m_retail_qty,"m_retail_type":m_retail_type,"m_retail_orgdocno":this.tempno,"m_retail_priceactual":priceactual,"m_empid":emper,"isdiscount":this.isdiscount};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="insertline";
		evt.permission="w";
		this._executeCommandEvent(evt);
	   
	},
	
	_onInsertLine:function(e){
		var data=e.getUserData(); // data
		var ret=data.jsonResult.evalJSON();
	//	var ret={"m_retail_productno":"070707123","m_retail_productvalue":"aaa","m_retail_qty":1,"m_retail_pricelist":250,"m_retail_discount\":\"100%","m_retail_priceactual":250,"m_retail_price":250,"m_retail_type":"N","m_retail_productname":"070707","m_retail_color":"02","m_retail_colorname":"红色","m_retail_size":38,"m_retail_sizename":38,"m_retail_mdim11":"255454"};
	//	var data="{\"lineid\":1,\"m_retail_productno\":\"070707123\",\"m_retail_productvalue\":\"aaa\",\"m_retail_qty\":1,\"m_retail_pricelist\":250,\"m_retail_discount\":\"100%\",\"m_retail_saler\":\"sss\",\"m_retail_salerid\":12,\"m_retail_priceactual\":250,\"m_retail_price\":250,\"m_retail_type\":\"1\",\"m_retail_productname\":\"070707\",\"m_retail_color\":\"02\",\"m_retail_colorname\":\"红色\",\"m_retail_size\":38,\"m_retail_sizename\":38,\"m_retail_mdim11\":\"255454\"}";
	//	var ret=data.evalJSON();
	if(!this._checkproduct(ret))
   {
	//	  if(ret.m_retail_type=="Q"){ 
	//	     ret.m_retail_discount=Math.round(parseFloat(this.tempprice)/ret.m_retail_pricelist*1000)/1000;
	//	     ret.m_retail_price=0-this.tempprice;
	//	     if(this.tempno!=null) {
	//	     } 	
	//	  }
	     
	    //  var mid=this.line_num;
          var len=this.line.length;
		  this.line[len]=ret;
		  //this.line[len].m_retail_salerid=this.emp_id;	
		  // this.line[len].m_retail_saler=this.emp_name;		   
		  this.insertlineifo();  
		}
		this.emp_id=ret.m_retail_salerid;
		this.emp_name=ret.m_retail_saler;
		this.m_retail_type=ret.m_retail_type;
		this.tot_payable_origin=this.tot_payable;
		  var numb=$("number");
		  numb.focus();
		  $("number").value="";
		 $("price").value="";
	},

	new_order:function(){
    if(this.line.length!=0){
     	if(window.confirm("零售数据尚未保存，是否放弃当前买单？"))
         {
 	        var posno=jQuery("#pos_no").val();
 	        var emp_id=jQuery("#emp_name").val();
	   			window.location="/html/nds/bpos/index.jsp?posno="+posno+"&&empid="+emp_id;	
 	     }
     }else{
      	 var posno=jQuery("#pos_no").val();
      	 var emp_id=jQuery("#emp_name").val();
	  		  window.location="/html/nds/bpos/index.jsp?posno="+posno+"&&empid="+emp_id;
	  		// $("emp_name").innerHTML=this.emp_name+"("+this.emp_truename+")";
    }
        
    },	
	_checkproduct:function(ret){
		if(this.line.length==0){
		return false;
		}else{
			var prono = this.line[0].m_retail_productno;
			var retailtype = this.line[0].m_retail_type;
			var i=this.line.length;
			var m_retail_productno=$("m_retail_idx").value;
			var retailtype_val = jQuery("#m_retailtype").val();
			var numb = jQuery("input#number").val();
			if(numb==""){
				alert('数量为空！！');
				return true;
			}
			if(retailtype_val != retailtype){
				alert('请状态一致！');
				return true;
			}
			return false;
		}
	},	   	
	
	_executeCommandEvent:function (evt) {
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
		});
	},
	checkvip:function(ptype){
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_CHECKVIP";
		if(ptype=="vip"){
		var cardno =$("vip").value;
		var param={"ptype":["vip"],"pvalue":[cardno]};
		}else if(ptype=="in_phone"){
		var tele =$("in_phone").value;
		var param={"ptype":["tele"],"pvalue":[tele]};
		}
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="load_vip";
		evt.permission="w";		
		this._executeCommandEvent(evt);
	},
	_oncheck:function(e)
	{   
		var data=e.getUserData(); // data
		var ret=data.jsonResult.evalJSON()[0];
	 //   var data="{\"cardno\":\"SJ00025\",\"c_viptype\":\"金卡\",\"vipname\":\"yyy\",\"birthday\":\"1981-04-19\",\"vipename\":\"jeery\",\"sex\":\"男\",\"idno\":\"515151\",\"validdate\":\"2008-10-7\",\"menbdiscount\":0.6}";	    
	//	 var ret=data.evalJSON();
		this.vip_id =ret.VIP_ID;
		this.cardno =ret.CARDNO;
		$("vip").value=this.cardno;
        this.c_viptype=ret.R_VIPTYPE;
        this.menbdiscount=ret.DISCOUNT;
    $("carno").innerHTML= ret.CARDNO;
		$("c_viptype").innerHTML=this.c_viptype; 
		$("vipname").innerHTML=ret.VIPNAME;
		$("birthday").innerHTML=ret.BIRTHDAY;
		$("v_phone").innerHTML=ret.MOBIL;	
		$("sex").innerHTML=ret.SEX;	
		$("v_c_store_name").innerHTML=ret.MARKNAME;
		$("v_purchMoney").innerHTML=ret.TOT_AMT_ACTUAL;
		$("v_useScore").innerHTML=ret.INTEGRAL;
		//$("idno").innerHTML=ret.IDNO;	
		$("v_date").innerHTML=ret.VALIDDATE;						
	},
	checkvip2:function(){
		$("vipnum").innerHTML=this.cardno; 
		$("viptype1").innerHTML=this.c_viptype;
		if (jQuery("#v_isDiscount").is(':checked')) {
			this.isdiscount = '1';
		}
		if (jQuery("#v_isornotScore").is(':checked')) {
			this.isscore = '1';
		}
		
		
       // Alerts.killAlert($("dlg_vip_content"));
       art.dialog.get('art_dlg_vip').close();
        var m_retail_idx=$("m_retail_idx");
		    m_retail_idx.focus();
	},	
	checkvipenter:function(){
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_CHECKVIPENTER";
	//	var cardno=$("vip").value;
	//	var param={"cardno":cardno};
		var cardno =$("vip").value;
		var param={"ptype":["vip"],"pvalue":[cardno]};		
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="load_vip";
		evt.permission="w";		
		this._executeCommandEvent(evt);	
		//Alerts.killAlert($("dlg_vip_content"));		
		},
	
	_oncheckenter:function(e){
		var data=e.getUserData(); // data
		var ret=data.jsonResult.evalJSON();	
	//  var data="{\"cardno\":\"SJ00025\",\"c_viptype\":\"金卡\",\"vipname\":\"yyy\",\"birthday\":\"1981-04-19\",\"vipename\":\"jeery\",\"sex\":\"男\",\"idno\":\"515151\",\"validdate\":\"2008-10-7\",\"menbdiscount\":0.6}";	    
	//	var ret=data.evalJSON();
		this.vip_id =ret.vip_id;
		this.cardno =ret.cardno;
        this.c_viptype=ret.c_viptype;
        this.menbdiscount=ret.menbdiscount;
        $("vipnum").innerHTML=this.cardno; 
		$("viptype1").innerHTML=this.c_viptype;
		var m_retail_idx=$("m_retail_idx");
	    m_retail_idx.focus();

	},
	
	sales:function(){
		var ele = Alerts.fireMessageBox(
				{
					width: 365,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				
				ele.innerHTML="<div class=\"center01\"><div id=\"employee_content\"><table width=\"395\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr><td><div id=\"treatment_td_inc\"><div id=\"treatment_text\">选择当前营业员:</div></div></td></tr><tr><td><table  class=\"center01\" width=\"350\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">";
			    if(this.emp_names.length==0){
			     	ele.innerHTML=ele.innerHTML+"<tr><td height=\"30\"><div class=\"desc-txt\">当前店铺没有营业员</div></td></tr>";
			     }else{
			        for(var i=0;i<this.emp_names.length;i++){					
				    ele.innerHTML=ele.innerHTML+"<tr><td height=\"30\"><div class=\"center02\"><input type=\"radio\" id="+i+" name=\"employee\"/>"+this.emp_names[i]+"("+this.emp_truenames[i]+")"+"</div></td></tr>"; 
			          }
			     }
				ele.innerHTML=ele.innerHTML+"</table></td></tr><tr><td><div id=\"treatment_td_inc\" align=\"center\"><div id=\"treatment_text\" class=\"center01\"><input type=\"button\" value=\"确定\" class=\"qinput\" onclick=\"javascript:bpos.getEmployee();\">&nbsp;&nbsp;&nbsp;<input type=\"button\" value=\"取消\" class=\"qinput\" onclick=\"javascript:bpos.closeEmployee();\"></div></div></td></tr></table></div></div>";
				executeLoadedScript(ele);
	},	
	
	closeEmployee:function(){
		Alerts.killAlert($("employee_content"));
		var m_retail_idx=$("m_retail_idx");
	    m_retail_idx.focus();
	},
	
	getEmployee:function(){   
	 var obj;
	 obj=document.getElementsByName("employee"); 
	 for(var i=0;i<obj.length;i++){
	  	if(obj[i].checked){
	  		this.emp_id=this.emp_ids[i];
	  		this.emp_name=this.emp_names[i];
	  		this.emp_truename =this.emp_truenames[i];
		    $("emp_name").innerHTML=this.emp_name+"("+this.emp_truename+")"; 
	  		break;
	  	}
 	  }	  
 	Alerts.killAlert($("employee_content"));
 	var m_retail_idx=$("m_retail_idx");
	m_retail_idx.focus();		
	},
	tryClose:function(){	
	   // Alerts.killAlert($("dlg_vip_content")); 
	    art.dialog.get('art_dlg_vip').close();
	    var m_retail_idx=$("m_retail_idx");
	    m_retail_idx.focus();
	},
	payOff:function(){
	    art.dialog.get('art_payment').close();
	    var m_retail_idx=$("m_retail_idx");
	    m_retail_idx.focus();
	},
	strategyclose:function(){
	    art.dialog.get('art_strategy').close();
	    var m_retail_idx=$("m_retail_idx");
	    m_retail_idx.focus();
	},
	_editvip:function(){	
		/*
		var ele = Alerts.fireMessageBox(
				{
					width: 646,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML= $("dlg_vip").innerHTML.replace(/TMP/g,"");
				
		executeLoadedScript(ele); 
		*/
		    var options=$H({id:"art_dlg_vip",width:500,height:400,title:'vip录入',padding:0,resize:false,drag:true,lock:true,skin:'chrome',esc:true});
		    options.content=$("dlg_vip").innerHTML.replace(/TMP/g,"");
		    art.dialog(options);
		    
		    
	      var vipss=$("vip");
		    vipss.focus();
		    jQuery("#v_isornotScore").click();
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
		var retailnox=$("retailno");
        retailnox.focus();
	},	
	
	   _onInsertLine_q:function(e){
	    var data=e.getUserData(); // data
		var ret=data.jsonResult.evalJSON();
		this.templine[0]=ret;
		ret.m_retail_price =0-ret.m_retail_price;
		var ele = Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
		ele.innerHTML= $("r_retail_price").innerHTML.replace(/TMP/g,"");
		executeLoadedScript(ele);
		$("info_text").innerHTML="     退货的价格在0~"+ret.m_retail_price;	
		$("tempx").value=this.templine[0].m_retail_price;	
		var retailpricex=$("retailprice");
        retailpricex.focus();
	},	
	
	tryClose1:function(){	
	    Alerts.killAlert($("r_retail_no_content"));
	    var m_retail_idx=$("m_retail_idx");
	    m_retail_idx.value="";
        m_retail_idx.focus();
        document.getElementById("m_retailtype").selectedIndex=0; 
	},
	
	checkretailno:function(){		
		this.tempno=$("retailno").value;
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_INSERT_LINE_Q";
		var m_retail_productno=$("m_retail_idx").value;
		var m_retail_type=document.getElementById("m_retailtype").options[document.getElementById("m_retailtype").selectedIndex].value;
		var m_retail_qty =-1;	
		var sys_date=$("sys_date").value;			
		var param={"cardno":this.vip_id,"c_store_id":this.c_store_id,"billdate":sys_date,"m_retail_productno":m_retail_productno,"m_retail_qty":m_retail_qty,"m_retail_type":m_retail_type,"m_retail_orgdocno":this.tempno,"m_retail_priceactual":""};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="insertline";
		evt.permission="w";
		this._executeCommandEvent(evt);			
	},
	
	neglect :function(){
		this._editretailprice();
	},
		
	checkretailprice:function(){
		this.tempprice=$("retailprice").value;
		var mid=this.line_num;
        var len=this.line.length;
		this.line[len]=this.templine[0];
		this.line[len].m_retail_salerid=this.emp_id;	
		this.line[len].m_retail_saler=this.emp_name;		  
		this.line[len].lineid=mid;
   	    this.line[len].m_retail_price=0-this.tempprice; 
   	    this.line[len].m_retail_priceactual=this.tempprice; 
   	    this.line[len].m_retail_discount=Math.round(parseFloat(this.tempprice/this.line[len].m_retail_pricelist*1000))/1000;  	     
   	    this.insertlineifo();
		Alerts.killAlert($("r_retail_price_content"));
		Alerts.killAlert($("r_retail_no_content")); 
		var m_retail_idx=$("m_retail_idx");
		m_retail_idx.value="";
	    m_retail_idx.focus();
	    document.getElementById("m_retailtype").selectedIndex=0;
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
	  		/*
	  	var ele = Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML= $("num").innerHTML.replace(/TMP/g,"");
		executeLoadedScript(ele);
		*/
		var options=$H({id:"art_changnumber",width:400,height:'auto',title:'修改数量',padding:0,resize:false,drag:true,lock:true,skin:'chrome',esc:true});
		options.content=$("num").innerHTML.replace(/TMP/g,"");
		art.dialog(options);
		$("retail_num").value=this.line[i].m_retail_qty;
		$("retail_id").value=i;
	    var retail_numx=$("retail_num");
	    dwr.util.selectRange(retail_numx, 0,15);
	  	}
 	  }
 	}
	},
	
    changnum:function(){
     	var i=$("retail_id").value;
     	var num=$("retail_num").value;
     	var mid=0;
     	var price=0;
     	var flg;
     	var m_retail_type = this.line[i].m_retail_type;
     	if(!isNaN(num)){
	     	if(m_retail_type=='1'){
	     		flg = 0;
	     	} else if(m_retail_type=='2'){
	     		flg = 1;
	     	}
      }else{
      	  flg = -1;
      }
      if(flg == -1){
      	alert('输入必须为数字类型');
     		return false;
      }
     	if(flg==1 && num>=0){
     		alert('当前修改数量与退货状态不匹配！');
     		return false;
     	} else if(flg==0 && num<0){
     		alert('当前修改数量与正常状态不匹配！');
     		return false;
     	}
     	if(num!=this.line[i].m_retail_qty){
     	
     	price=this.line[i].m_retail_price;   		
     	this.line[i].m_retail_price =num*this.line[i].m_retail_priceactual;
     	this.tot_num =num-this.line[i].m_retail_qty+this.tot_num;
     	this.tot_payable=this.tot_payable+num*this.line[i].m_retail_priceactual-price;
     	this.tot_amt=this.tot_amt+this.line[i].m_retail_pricelist*(num-this.line[i].m_retail_qty);
     	this.line[i].m_retail_qty =Number(num);
     	mid =this.line[i].lineid;
     	$(mid+"_m_retail_qty").innerHTML=this.line[i].m_retail_qty;
     	$(mid+"_m_retail_price").innerHTML=this.line[i].m_retail_price;	
     	//$("tot_num").innerHTML=this.tot_num; 
     	$("tot_payable").innerHTML=this.tot_payable;
     	//$("tot_amt").innerHTML=this.tot_amt; 
     	}     	
        //Alerts.killAlert($("num_content"));	
        art.dialog.get("art_changnumber").close();
        var m_retail_idx=$("m_retail_idx");
		    m_retail_idx.focus();
    },
    
	cancelnum:function(){ 
		//Alerts.killAlert($("num_content"));
		art.dialog.get("art_changnumber").close();
	    var m_retail_idx=$("m_retail_idx");
	    m_retail_idx.focus();
	},
	
	changprice :function(){
	var obj,j=0;
	var k=0;
	 obj=document.getElementsByName("m_retail");
     for(var i=0;i<obj.length;i++){
      	if(obj[i].checked){
      		j=j+1;
      		k=i;
     	}
     }
     	if(j==0){
     		alert("您还没有选中零售单！"); 
     	}else if(j>1){
     		alert("您选了多个选项");
     	}else if(this.line[k].m_retail_type==2){
     		alert("退货单不能改金额！")
     }else{	
	 for(var i=0;i<obj.length;i++){
	  	if(obj[i].checked){
	  		this.tempretailid =i;
		var ele = Alerts.fireMessageBox(
				{
					width: 398,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML= $("amt").innerHTML.replace(/TMP/g,"");
		executeLoadedScript(ele);
		$("minrate").innerHTML=this.discountlimit;
    	$("minprice").innerHTML=Math.round(parseFloat(this.line[i].m_retail_pricelist*this.discountlimit)*100)/100;
    	$("maxprice").innerHTML=Math.round(parseFloat(this.line[i].m_retail_pricelist*(1-this.discountlimit))*100)/100;
    	var discount_0x=$("discount_0");
		discount_0x.focus();
    	     break ;
	  	}
       
 	  }
    }
 },
	
	changamt:function(){
		var obj3,obj2;
		var retailid=this.tempretailid;
		var k;
        var flag=1;
   		var temp1;
	    obj3=document.getElementsByName("radio_amt"); 
	    obj2=document.getElementsByName("m_retail");
	   
	 //   for(var j=0;j<obj2.length;i++){
	 //    if(obj2[j].checked){	
	 //     	 retailid=j;
	//      	  break;
	//      	}
	//    }
	 //       retailid=0;
	//      alert(obj3.length);
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
	     			if($("discount_1").value< Math.round(parseFloat(this.discountlimit*(this.line[retailid].m_retail_pricelist-0.05)*100))/100){
	     				$("discount_1").value="";	     				
	     				alert("你输入的特价金额过小！");
	     				flag=0;	     			
	     				}
	     		    }
	     		if(k==2){
	     				if($("discount_2").value> Math.round(parseFloat(this.line[retailid].m_retail_pricelist-this.discountlimit*this.line[retailid].m_retail_pricelist+0.05)*100)/100){
	     				$("discount_2").value="";	     				
	     				alert("你输入的优惠金额过大！");	
	     				flag=0;     				
	     				}
	     		  }
	     	  }
	     	}	
	    } 
	    if(flag==1){
	       	if(k==0){
	        	temp1 =$("discount_"+k).value*this.line[retailid].m_retail_pricelist;	        		        	
	        }else if(k==1){
	            temp1=$("discount_"+k).value;
	        }else if(k==2){
	            temp1=this.line[retailid].m_retail_pricelist-$("discount_"+k).value;   	
	        }	
	         this.price1=this.line[retailid].m_retail_price; 	       	
	       	  var evt={};
		      evt.command="DBJSON";
		      evt.callbackEvent="BPOS_CHANGAMT";
		      var m_retail_productno=$("m_retail_idx").value;
		      $("m_retail_idx").value="";
		      var sys_date=$("sys_date").value;
		      var emp_name=$("emp_name").value;
		      var param={"cardno":this.cardno,"c_store_id":this.c_store_id,"billdate":sys_date,"m_retail_productno":this.line[retailid].m_retail_productno,"m_retail_qty":this.line[retailid].m_retail_qty,"m_retail_type":this.line[retailid].m_retail_type,"m_retail_orgdocno":"","m_retail_priceactual":temp1};
		      evt.param=Object.toJSON(param);
		      evt.table="m_retail";
		      evt.action="insertline";
		      evt.permission="w";
		      this._executeCommandEvent(evt);	
	       	Alerts.killAlert($("amt_content"));
	       	var m_retail_idx=$("m_retail_idx");
		      m_retail_idx.focus();
	   }
	},	
	   	     	 		    
   _changamt :function(e){
		var data=e.getUserData(); // data
		var ret=data.jsonResult.evalJSON();
	//	var ret={"m_retail_productno":"070707123","m_retail_productvalue":"aaa","m_retail_qty":1,"m_retail_pricelist":250,"m_retail_discount\":\"100%","m_retail_priceactual":250,"m_retail_price":250,"m_retail_type":"N","m_retail_productname":"070707","m_retail_color":"02","m_retail_colorname":"红色","m_retail_size":38,"m_retail_sizename":38,"m_retail_mdim11":"255454"};
	//    var data="{\"lineid\":1,\"m_retail_productno\":\"070707123\",\"m_retail_productvalue\":\"aaa\",\"m_retail_qty\":1,\"m_retail_pricelist\":250,\"m_retail_discount\":\"100%\",\"m_retail_saler\":\"sss\",\"m_retail_salerid\":12,\"m_retail_priceactual\":250,\"m_retail_price\":250,\"m_retail_type\":\"1\",\"m_retail_productname\":\"070707\",\"m_retail_color\":\"02\",\"m_retail_colorname\":\"红色\",\"m_retail_size\":38,\"m_retail_sizename\":38,\"m_retail_mdim11\":\"255454\"}";
	 //  var ret=data.evalJSON();
	  	var retailid =0;
	  	var obj2=document.getElementsByName("m_retail");
	    for(var j=0;j<obj2.length;j++){
	     if(obj2[j].checked){	
	      	 retailid=this.line[j].lineid;
	      	  break;
	      	}
	    }
	    this.line[j].m_retail_priceactual=ret.m_retail_priceactual;
	    this.line[j].m_retail_price=ret.m_retail_price;
	    this.line[j].m_retail_discount=ret.m_retail_discount;
	    this.tot_payable=Math.round(parseFloat(this.tot_payable-this.price1 +parseFloat(this.line[j].m_retail_price))*100)/100;
	   $("tot_payable").innerHTML=this.tot_payable;
	   $(retailid+"_m_retail_price").innerHTML=this.line[j].m_retail_price;
	   $(retailid+"_m_retail_priceactual").innerHTML=this.line[j].m_retail_priceactual;
	   $(retailid+"_m_retail_discount").innerHTML=this.line[j].m_retail_discount;
	 },	     
	confirmStr:function(){
		this.discountchoice();
	},
	payprice:function(){ 
	  if(this.line.length==0){
            alert("没有零售纪录！");
      }else{
     /*   
 		var ele = Alerts.fireMessageBox(
				{
					width: 620,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
		*/
		    var options=$H({id:"art_payment",width:620,height:'auto',title:'付款',padding:0,resize:false,drag:true,lock:true,skin:'chrome',esc:true});
		    options.content=$("pay").innerHTML.replace(/TMP/g,"");
		    art.dialog(options);
		//executeLoadedScript(ele);
	    $("paynum").value=this.tot_payable;
	    $("paynum").disabled="disabled";
	    $("paidnum").value="0.00";
	    $("paidnum").disabled="disabled";	    
	    $("unpaidnum").value=this.tot_payable;
	    $("currpay").value =this.tot_payable;
	    $("unpaidnum").disabled="disabled";
	    $("change").disabled="disabled";
	    $("discription").disabled="disabled";
	    $("empname").value=this.emp_name;
	    $("empname").disabled="disabled";
	     for(var i=0;i<this.pids.length;i++){
	    var option_node=document.createElement("OPTION");
	    option_node.innerHTML=this.pnames[i];
	    option_node.value=this.pids[i];
	    $("payselect").appendChild(option_node);
	    }
	    $("payselect").appendChild(option_node);
	    this.temppayment =this.tot_payable;
	    this.flagprice=this.tot_payable;
	    this.tempcash=0;
		this.cardcash=0;
		this.certificate=0; 
		$("payselect").style.visibility="visible";
		var currpayx=$("currpay");
	    dwr.util.selectRange(currpayx, 0,15);
	   }	        	    
	},
	
	cancelamt:function(){ 
	Alerts.killAlert($("amt_content"));	 
    var m_retail_idx=$("m_retail_idx");
    m_retail_idx.focus();
	},
	
	deleteline:function(){  
	 var obj;
	 var flag=0;
  	 obj=document.getElementsByName("m_retail"); 
	 for(var i=obj.length-1;i>=0;i--){
	  	if(obj[i].checked){ 
	  		flag=1;	
	  		var j=this.line[i].lineid;	
	  	  this.tot_num=this.tot_num-this.line[i].m_retail_qty; 
		  this.tot_payable=this.tot_payable-this.line[i].m_retail_price; 
		  this.tot_amt=this.tot_amt-this.line[i].m_retail_pricelist*this.line[i].m_retail_qty; 
	  	    dwr.util.removeAllRows("content",{filter:function(tr){return (tr.id==j+"_m_retailrow");}});
	  	     this.line.splice(i,1);	 
	  	    // $("tot_num").innerHTML=this.tot_num; 
     	     $("tot_payable").innerHTML=this.tot_payable;
     	    // $("tot_amt").innerHTML=this.tot_amt;  	
     	     this.deletelines=this.deletelines+1;
     	      this.lines =this.lines +1;
     	      var mid =this.lines;
     	      if(this.dline<this.deletelines&&this.line_num-this.deletelines< 10){
     	     dwr.util.cloneNode("m_retailrow",{idPrefix:mid+'_'});
		     dwr.util.setValue(mid+'_'+"m_retail","");
		     dwr.util.setValue(mid+'_'+"m_retail_productno","");
	         dwr.util.setValue(mid+'_'+"m_retail_productvalue","");  
	         dwr.util.setValue(mid+'_'+"m_retail_qty",""); 
	         dwr.util.setValue(mid+'_'+"m_retail_pricelist",""); 
	         dwr.util.setValue(mid+'_'+"m_retail_discount","");       
	         dwr.util.setValue(mid+'_'+"m_retail_priceactual",""); 
	         dwr.util.setValue(mid+'_'+"m_retail_price",""); 
	         dwr.util.setValue(mid+'_'+"m_retail_saler",""); 
	         dwr.util.setValue(mid+'_'+"m_retail_type","");
	         $(mid+'_'+"m_retailrow").style.display="";     	
	  	    } 
	  	  }
	   }
	    if(flag==0){
	     	alert("你还没有选种要删除的行！"); 	 
	    }	
	  },

	payclose:function(){
	  // Alerts.killAlert($("payment_content"));	 
	   art.dialog.get('art_payment').close();
	   var m_retail_idx=$("m_retail_idx");
	   m_retail_idx.focus(); 
	},
	//检查字符串是否在给定的数组中
	
	inarray:function(obj, arr){
		this.xobj = -1;
	 if(arr.length<2){
	 	return false;
	 }
	   for(var i=0;i<arr.length-1;i++) {
	    if(arr[i].name == obj.name) {
	    	this.xobj = i;
	      return true;
	    }
	   }
		return false;
	},
	
	insertpayment:function(){ 
		var i=0;
		var flag=0;
		var k=0;
		var num =this.alg(Number($("currpay").value));
		if(isNaN(num)){
		 alert('输入必须为数字！');
		 return false;
		}
		if(this.flagprice>0){				
		for(var j=0;j<this.pids.length;j++){
          	if($("payselect").options[$("payselect").selectedIndex].value==this.pids[j]){
          	    //if(this.ischarges[j]=="Y"&&this.iscashs[j]=="Y"){
          	    if(true){
          	       this.tempcash=this.tempcash+parseFloat(num);      
          	     }/*else if(this.ischarges[j]=="N"&&this.iscashs[j]=="N"){
          	       this.cardcash=this.cardcash+parseFloat(num);      
          	      }else if(this.ischarges[j]=="N"&&this.iscashs[j]=="N"){
          	       this.certificate=this.certificate+parseFloat(num);      
          	      } */         	       
          	 }
         }
		this.temppayment = this.alg(this.temppayment-num);
		$("paidnum").value=this.alg(this.tot_payable-this.temppayment);
		$("currpay").value =this.temppayment;
        if(this.temppayment<=0){
		  $("unpaidnum").value="0.00"
		  $("currpay").value =0;
		  $("currpay").disabled ="disabled";
          this.temppayment =-this.temppayment;
		    if(this.temppayment>=100&&this.tempcash>=100){
		    $("discription").innerHTML="找零已大于100元，请重新支付!";
		      flag =1;
		  //   $("currpay").disabled =!$("currpay").disabled ;
		    }else if(this.cardcash>this.tot_payable ){
		      $("discription").innerHTML="信用卡支付过多，请重新支付!";
		       flag =1;
		   //   $("currpay").disabled =!$("currpay").disabled;
		    }else if(this.certificate>=this.tot_payable){
		       $("change").value="0.00";
         //   }else if(this.temppayment>this.tempcash&&this.certificate<this.temppayment-this.tempcash){
          //    	 $("discription").innerHTML="信用卡支付过多，请重新支付!";
            }else if(this.tempcash==0&&this.cardcash<=this.temppayment){
             	$("change").value="0.00";
            }else if(this.certificate>=this.tot_payable&&this.cardcash!=0){
             	$("change").value=this.cardcash;
             	this.change =this.cardcash;
            }else if(this.temppayment<100&&this.tempcash>=this.temppayment){
            	 $("change").value=this.temppayment;
            	 this.change =this.temppayment;   
            }                     			       
	    }else{
	     $("unpaidnum").value=this.temppayment;
	      this.change =this.temppayment;
	   }
	   
	  //   alert($("payselect").options[$("payselect").selectedIndex].value);
	 
	  if(flag==0){	
	     i=this.payment.length ;
		 this.payment[i]={"payid":$("payselect").options[$("payselect").selectedIndex].value,"name":$("payselect").options[$("payselect").selectedIndex].innerHTML,"num":num};
	   var xobj = this.inarray(this.payment[i],this.payment);
	     if(xobj==false){
	     	 dwr.util.cloneNode("r_payment",{idPrefix:i+'_'});
		     dwr.util.setValue(i+'_'+"payway",this.payment[i].name);  
		     dwr.util.setValue(i+'_'+"paycount",this.payment[i].num);
		     $(i+'_'+"r_payment").style.display="";
	     }else{
	     	 var pcount = Number(this.payment[this.xobj].num);
	     	 this.payment[this.xobj]={"payid":$("payselect").options[$("payselect").selectedIndex].value,"name":$("payselect").options[$("payselect").selectedIndex].innerHTML,"num":String(bpos.alg(pcount+Number(num)))};
	     	 jQuery("td#"+this.xobj+"_paycount").html(this.payment[this.xobj].num);
	     	 this.payment.pop();
	     }
	     	
	      
	     if($("change").value >0){
	     i=this.payment.length;
	     var numx=0-this.change;
	      for(k=0;k< this.iscashs.length;k++){
	        	if(this.iscashs[k]=='Y'&& this.ischarges[k]=='Y'){
	        		break;
	        	}
	        }
	     if(k>=0 && k<this.iscashs.length){       	
			   this.payment[i]={"payid":this.pids[k],"name":this.pnames[k],"num":numx};
		     dwr.util.cloneNode("r_payment",{idPrefix:i+'_'});
		     dwr.util.setValue(i+'_'+"payway",this.payment[i].name);  
		     dwr.util.setValue(i+'_'+"paycount",this.payment[i].num); 	
		     $(i+'_'+"r_payment").style.display="";
	    	}
	    }
	    if($("change").value!=""){
	     	if($("currpay").disabled){
	     		$("currpay").disabled ="disabled";
	     	}
	    }	    	
	   }  
    }else{
     	this.temppayment =this.temppayment -parseFloat(num);
		$("paidnum").value=this.tot_payable-this.temppayment;
		$("currpay").value =this.temppayment;	
		$("unpaidnum").value=this.temppayment;
     	 i=this.payment.length ;
     	  if(this.temppayment<=0){
		 this.payment[i]={"payid":$("payselect").options[$("payselect").selectedIndex].value,"name":$("payselect").options[$("payselect").selectedIndex].innerHTML,"num":num};
	     dwr.util.cloneNode("r_payment",{idPrefix:i+'_'});
	     dwr.util.setValue(i+'_'+"payway",this.payment[i].name);  
	     dwr.util.setValue(i+'_'+"paycount",this.payment[i].num); 	
	     $(i+'_'+"r_payment").style.display="";
	    }else{
     	  $("discription").innerHTML="退款额已过多!";
        }
         if(this.temppayment==0){
	           if(!$("currpay").disabled){
	     		$("currpay").disabled ="disabled";
	     	 }
	     }     	
     }
 },
	
	repay:function(){  
		dwr.util.removeAllRows("paymentcontent",{filter:function(tr){return (tr.id!="r_payment");}});
		this.payment =[];
		this.temppayment =this.tot_payable;
		$("paynum").value=this.tot_payable;
		$("paidnum").value="0.00";
		$("unpaidnum").value=this.tot_payable;
		$("currpay").value =this.temppayment;
		if($("currpay").disabled){
			$("currpay").disabled =!$("currpay").disabled;
		}
		this.tempcash=0;
		this.cardcash=0;
		this.certificate=0;
		$("discription").innerHTML ="";
		$("change").value="";	
		var currpayx=$("currpay");
	    dwr.util.selectRange(currpayx, 0,15);
	},
	
	save_print :function() {
		if(this.payment.length==0){	
			alert("零售单还没有付款");
		}else{
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_SAVE_PRINT";
		var comment=$("comment").value;
		var sys_date=parseFloat($("sys_date").value);	
        var m_retail_productno =new Array();
        var m_retail_productvalue =new Array();  
	    var m_retail_qty =new Array(); 
        var m_retail_pricelist =new Array(); 
        var m_retail_discount =new Array();       
        var m_retail_priceactual =new Array(); 
        var m_retail_price =new Array(); 
        var m_retail_salerid =new Array(); 
        var m_retail_type =new Array()
	    var m_retail_productname =new Array(); 
        var m_retail_color =new Array(); 
        var m_retail_colorname=new Array(); 
        var  m_retail_size=new Array(); 
        var m_retail_sizename=new Array(); 
        var m_retail_mdim11=new Array(); 
        var attributesetinstanceid=new Array();  
        var description1 =new Array();
        var totamtlist=new Array();   
        var orgdocno=new Array(); 
        var productid=new Array();
        var discription2=new Array();
        var i=0;     
        for(i=0;i<this.line.length;i++){ 
         	productid[i]=this.line[i].productid; 
         	m_retail_productno[i] =this.line[i].m_retail_productno;//m_retail_productno+"'"+this.line[i].m_retail_productno+"'"+",";
 		    m_retail_productvalue[i]=this.line[i].m_retail_productvalue; 
 		   	m_retail_qty[i] =this.line[i].m_retail_qty;
 		    m_retail_pricelist[i]=this.line[i].m_retail_pricelist;
 		   	m_retail_discount[i]=this.line[i].m_retail_discount;
 		   	this.totdiacount=this.totdiacount+this.line[i].m_retail_discount*this.line[i].m_retail_qty;
 		   	m_retail_priceactual[i] =this.line[i].m_retail_priceactual;
 		   	m_retail_price[i] =this.line[i].m_retail_price;
 		   	m_retail_salerid[i] =this.line[i].m_retail_salerid;
 		   	m_retail_type[i] =this.line[i].m_retail_type;
 		   	m_retail_productname[i] =this.line[i].m_retail_productname; 
 		   	m_retail_color[i] =this.line[i].m_retail_color; 
 		   	m_retail_colorname[i] =this.line[i].m_retail_colorname; 
 		   	m_retail_size[i]=this.line[i].m_retail_size; 
 		   	m_retail_sizename[i]=this.line[i].m_retail_sizename;
 		   	m_retail_mdim11[i]=this.line[i].m_retail_mdim11; 
 		   	if(this.line[i].m_retail_discription==""||this.line[i].m_retail_discription=="null"){
 		   		description1[i] ="";
 		   	}else{
 		     	description1[i]=this.line[i].m_retail_discription;
 		    }
 		   	totamtlist[i]=this.line[i].m_retail_pricelist*this.line[i].m_retail_qty;
 		   if(this.line[i].m_retail_orgdocno==""||this.line[i].m_retail_orgdocno=="null"){
 		   		orgdocno[i] ="";
 		   	}else{
 		   	orgdocno[i]=this.line[i].m_retail_orgdocno;	
 		    }		   	
 		   	//attributesetinstanceid[i]=this.line[i].attributesetinstanceid; 		   	
 		 }       		     
 		    var paywayid=new Array();
 		    var paymount=new Array();
 		   
 		    var j=0;
 		     for(j=0;j<this.payment.length;j++){
 		    paywayid[j]=parseFloat(this.payment[j].payid);
   	          paymount[j]=this.alg(parseFloat(this.payment[j].num));
   	          discription2[j]="";
   	       }	
 		      if(this.change!=0){ 	
 		       	discription2[j-1]="找零"; 		
 		     }	      	        			
       var param={"storeid":this.c_store_id,"printmetrail":"Y","billdate":sys_date,"description":comment,
       	"vipid":this.vip_id,"amtchange":this.change,"totlines":this.line.length,"totqty":this.tot_num,
       	"avgdiscount":this.totdiacount/this.tot_num, "salerid":this.emp_id,"totamtlist":this.tot_amt,
       	"totamtactual":this.tot_payable,"c_store_name":this.c_store_name,"salerid1":m_retail_salerid,
       	"productid":productid,"m_retail_productno":m_retail_productno,"m_retail_productvalue":m_retail_productvalue,
       	"attributesetinstanceid":attributesetinstanceid,"qty":m_retail_qty,"pricelist":m_retail_pricelist,
       	"priceactual":m_retail_priceactual,"orgdocno":orgdocno,"discount":m_retail_discount,
       	"totamtlist1":totamtlist,"totamtactual1":m_retail_price,"description1":description1,"type":m_retail_type,
       "paywayid":paywayid,"paymount":paymount,"discription2":discription2};
       	
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="insert_save";
		evt.permission="w";		
		this._executeCommandEvent(evt);	
	}		
	},
	_onsave_print:function(e){
	   var data=e.getUserData(); // data
	   var ret=data.jsonResult.evalJSON();
	//	var ret={"m_retail_productno":"070707123","m_retail_productvalue":"aaa","m_retail_qty":1,"m_retail_pricelist":250,"m_retail_discount\":\"100%","m_retail_priceactual":250,"m_retail_price":250,"m_retail_type":"N","m_retail_productname":"070707","m_retail_color":"02","m_retail_colorname":"红色","m_retail_size":38,"m_retail_sizename":38,"m_retail_mdim11":"255454"};
	   var printmetrail=ret.printmetrail;
	   var retailid =ret.retailid;
	   this.v_retailid = ret.v_retailid;
	   var docnoinfo ="提交已成功！零售单的单据号:"+ret.docno;
	    if(printmetrail=="Y"){
	     	
	    }
	   alert(docnoinfo);
	   var posno=jQuery("#pos_no").val();
	   this.posno=posno;
	   art.dialog.get('art_payment').close();
	   if(this.disp==1){
	   		this.doSaveSettings();
	   }else{
	   	  window.location="/html/nds/bpos/index.jsp?posno="+this.posno+"&&empid="+this.emp_id;
	   }
			this.disp=0;
	}, 
	
	save:function(){
	if(this.payment.length==0){	
			alert("零售单还没有付款");
		}else{
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_SAVE_PRINT";
		//var comment=$("comment").value;
		var sys_date=parseFloat(jQuery("#sys_date").html());	
        var m_retail_productno =new Array();
        var m_retail_productvalue =new Array();  
	    var m_retail_qty =new Array(); 
        var m_retail_pricelist =new Array(); 
        var m_retail_discount =new Array();       
        var m_retail_priceactual =new Array(); 
        var m_retail_price =new Array(); 
        var m_retail_salerid =new Array(); 
        var m_retail_saler =new Array(); 
        var m_retail_type =new Array()
	    var m_retail_productname =new Array();   
        var description1 =new Array();
        var totamtlist=new Array();   
        var orgdocno=new Array(); 
        var productid=new Array();
        var discription2=new Array();
        var i=0;     
        for(i=0;i<this.line.length;i++){ 
         	productid[i]=this.line[i].productid; 
         	m_retail_productno[i] =this.line[i].m_retail_productno;//m_retail_productno+"'"+this.line[i].m_retail_productno+"'"+",";
 		    m_retail_productvalue[i]=this.line[i].m_retail_productvalue; 
 		   	m_retail_qty[i] =this.line[i].m_retail_qty;
 		    m_retail_pricelist[i]=this.line[i].m_retail_pricelist;
 		   	m_retail_discount[i]=this.line[i].m_retail_discount;
 		   	this.totdiacount=this.totdiacount+this.line[i].m_retail_discount*this.line[i].m_retail_qty;
 		   	m_retail_priceactual[i] =this.alg(this.line[i].m_retail_priceactual);
 		   	m_retail_price[i] =this.line[i].m_retail_price;
 		   	m_retail_salerid[i] =this.line[i].m_retail_salerid;
 		   	m_retail_saler[i] =this.line[i].m_retail_saler;
 		   	m_retail_type[i] =this.line[i].m_retail_type;
 		   	m_retail_productname[i] =this.line[i].m_retail_productname; 
 		   	totamtlist[i]=this.line[i].m_retail_pricelist*this.line[i].m_retail_qty;
 		   if(this.line[i].m_retail_orgdocno==""||this.line[i].m_retail_orgdocno=="null"){
 		   		orgdocno[i] ="";
 		   	}else{
 		   	orgdocno[i]=this.line[i].m_retail_orgdocno;	
 		    }		   	
 		 }       		     
 		    var paywayid=new Array();
 		    var paymount=new Array();
 		   
 		    var j=0;
 		     for(j=0;j<this.payment.length;j++){
 		    paywayid[j]=parseFloat(this.payment[j].payid);
   	          paymount[j]=parseFloat(this.payment[j].num);
   	          discription2[j]="";
   	       }	
 		      if(this.change!=0){ 	
 		       	discription2[j-1]="找零";		
 		     }	      	        			
       var param={"storeid":this.c_store_id,"printmetrail":"N","billdate":sys_date,
       	"vipid":this.vip_id,"amtchange":this.change,"totlines":this.line.length,"totqty":this.tot_num,
        "salerid":this.emp_id,"totamtlist":this.tot_amt,
       	"totamtactual":this.tot_payable,"c_store_name":this.c_store_name,"salerid1":m_retail_salerid,"salerlist":m_retail_saler,
       	"productid":productid,"m_retail_productno":m_retail_productno,"m_retail_productvalue":m_retail_productvalue,"qty":m_retail_qty,"pricelist":m_retail_pricelist,
       	"priceactual":m_retail_priceactual,"orgdocno":orgdocno,"discount":m_retail_discount,
       	"totamtlist1":totamtlist,"totamtactual1":m_retail_price,"type":m_retail_type,
        "paywayid":paywayid,"paymount":paymount,"refno":this.posdocno,"money":this.tot_payable,"strategyId":this.strId};
       	
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="insert_save";
		evt.permission="w";		
		this._executeCommandEvent(evt);
	}		
	},	
	alg:function(value1){ 
		var temp1=0;
 	     if(this.calculation==1){
	            temp1=Math.round(parseFloat(value1*100))/100;  		      	
	     }else if(this.calculation==2){
	            temp1=parseInt(value1+parseFloat(0.5));	    		
	     }else if(this.calculation==3){	
	            temp1=parseInt(value1);  		
	     }else if(this.calculation==4){	
	            temp1=parseInt(value1+parseFloat(0.99));  	
	     }else if(this.calculation==5){
	            temp1=Math.round(parseFloat(value1+parseFloat(0.5))*100)/100;  		     
	     }else if(this.calculation==6){	
	            temp1=Math.round(parseFloat(value1)*10)/10;  	
	     }else{
	     	temp1=value1;
	     	}
	      return temp1;
  },
  	_setValue:function(ele, v){
		if(v==null || v==undefined) v="";
		dwr.util.setValue(ele, v);
	},
	
  changeretailtype:function(){
	var select_inx=jQuery("#m_retailtype").get(0).selectedIndex;
	if (select_inx==0)jQuery("#m_retailtype")[0].selectedIndex = 1;
	if (select_inx==1)jQuery("#m_retailtype")[0].selectedIndex = 0;
	
	},
	setFocus:function(){
		var numb=$("number");
		numb.focus();
	},
  insertlineifo:function(){
  	var numb = jQuery("input#number").val();
			if(numb==""){
				alert('数量为空！！');
				return true;
			}
   	      var mid=0;	
          var len=this.line.length-1;	 
		  if(len>9){
		   	this.lines =this.lines +1;
            mid=this.lines;
		  this.dline=this.dline+1;	
		  dwr.util.cloneNode("m_retailrow",{idPrefix:mid+'_'});
		  dwr.util.setValue(mid+'_'+"m_retail","<input type=\"checkbox\" onclick=\"bpos.setFocus()\" name=\"m_retail\"/>");
		  dwr.util.setValue(mid+'_'+"m_retail_productno",this.line[len].m_retail_productno);
	      dwr.util.setValue(mid+'_'+"m_retail_productvalue",this.line[len].m_retail_productvalue);  
	      dwr.util.setValue(mid+'_'+"m_retail_qty",this.line[len].m_retail_qty); 
	      dwr.util.setValue(mid+'_'+"m_retail_pricelist",this.line[len].m_retail_pricelist); 
	      dwr.util.setValue(mid+'_'+"m_retail_discount",this.line[len].m_retail_discount);       
	      dwr.util.setValue(mid+'_'+"m_retail_priceactual",this.line[len].m_retail_priceactual); 
	      dwr.util.setValue(mid+'_'+"m_retail_price",this.line[len].m_retail_price); 
	      dwr.util.setValue(mid+'_'+"m_retail_saler",this.line[len].m_retail_saler); 
	      if(this.line[len].m_retail_type=="1"){
	      dwr.util.setValue(mid+'_'+"m_retail_type","正常"); 
	      }else if(this.line[len].m_retail_type=="2"){
	       	dwr.util.setValue(mid+'_'+"m_retail_type","退货"); 
	      }
	      /*		      
	      dwr.util.setValue(mid+'_'+"m_retail_productname",this.line[len].m_retail_productname); 
	      dwr.util.setValue(mid+'_'+"m_retail_color",this.line[len].m_retail_color); 
	      dwr.util.setValue(mid+'_'+"m_retail_colorname",this.line[len].m_retail_colorname); 
	      dwr.util.setValue(mid+'_'+"m_retail_size",this.line[len].m_retail_size); 
	      dwr.util.setValue(mid+'_'+"m_retail_sizename",this.line[len].m_retail_sizename); 
	      dwr.util.setValue(mid+'_'+"m_retail_mdim11",this.line[len].m_retail_mdim11); 
	         */
	      $(mid+'_'+"m_retailrow").style.display="";
	   
        }else{
           	mid=this.line_num+this.dline;
         	$(mid+'_'+"m_retail").innerHTML="<input type=\"checkbox\" onclick=\"bpos.setFocus()\" name=\"m_retail\" />" ;
         	$(mid+'_'+"m_retail_productno").innerHTML=this.line[len].m_retail_productno; 
         	$(mid+'_'+"m_retail_productvalue").innerHTML=this.line[len].m_retail_productvalue;
         	$(mid+'_'+"m_retail_qty").innerHTML=this.line[len].m_retail_qty; 
         	$(mid+'_'+"m_retail_pricelist").innerHTML=this.line[len].m_retail_pricelist; 
         	$(mid+'_'+"m_retail_discount").innerHTML=this.line[len].m_retail_discount;
         	$(mid+'_'+"m_retail_priceactual").innerHTML=this.line[len].m_retail_priceactual;
         	$(mid+'_'+"m_retail_price").innerHTML=this.line[len].m_retail_price; 
         	$(mid+'_'+"m_retail_saler").innerHTML =this.line[len].m_retail_saler;
         	 if(this.line[len].m_retail_type=="1"){
	          $(mid+'_'+"m_retail_type").innerHTML="正常"; 
	         }else if(this.line[len].m_retail_type=="2"){
	        $(mid+'_'+"m_retail_type").innerHTML="退货"; 
	        }else if(this.line[len].m_retail_type=="3"){
	       $(mid+'_'+"m_retail_type").innerHTML="赠品"; 	
	        }else{
	       	$(mid+'_'+"m_retail_type").innerHTML="全额"; 
	        }	
	        /*
         	$(mid+'_'+"m_retail_productname").innerHTML=this.line[len].m_retail_productname;
         	$(mid+'_'+"m_retail_color").innerHTML=this.line[len].m_retail_color;
         	$(mid+'_'+"m_retail_colorname").innerHTML=this.line[len].m_retail_colorname;
         	$(mid+'_'+"m_retail_size").innerHTML=this.line[len].m_retail_size;
         	$(mid+'_'+"m_retail_sizename").innerHTML=this.line[len].m_retail_sizename; 
         	$(mid+'_'+"m_retail_mdim11").innerHTML=this.line[len].m_retail_mdim11;         	
         	*/
        }
          //(mid+'_'+"m_retailrow").onclick="alert(\"sdfh\")";
          this.line[len].lineid=mid;	
          this.tot_num=this.line[len].m_retail_qty+this.tot_num;
          //$("tot_num").innerHTML=this.tot_num;  
          this.tot_payable=this.tot_payable+this.line[len].m_retail_price;
          $("tot_payable").innerHTML=this.tot_payable;	
          this.tot_amt=this.tot_amt+this.line[len].m_retail_pricelist*this.line[len].m_retail_qty;
          //$("tot_amt").innerHTML=this.tot_amt;
          document.getElementById("m_retailtype").selectedIndex=0;    
          this.line_num =this.line_num +1; 	  	
},
insertdiscount:function(){

   	  var i;
   	  var strHtml="";
   	  if(this.strategyId.length==0){jQuery('#radiorow').html("");return false;}
   	   for(i=0;i<this.strategyId.length;i++){
   	   	  if(i==0){
   	   	    strHtml = "<input type=\"radio\" value=\"0\" onclick=\"bpos.strategy("+this.strategyId[0]+");\" id=\"0_m_retail\" name=\"m_retail\" checked>"+this.strategyName[0]+"</input>";
   	   	  } else{
   	   	    strHtml = strHtml + "<br/><input type=\"radio\" value=\""+i+"\" onclick=\"bpos.strategy("+this.strategyId[i]+");\" id=\""+i+"_m_retail\" name=\"m_retail\">"+this.strategyName[i]+"</input>";
   	   	  }
	      }	
	      jQuery('#radiorow').html(strHtml);
	      jQuery("#0_m_retail").click();
	      jQuery("#0_m_retail").focus();
},
strategy:function(strId){
	    this.strId = strId;
},
repeatPrint:function(){
	this.pressB="repeat";
	this.doSaveSettings();
},
doSubmitPrint:function(){
	  this.disp=1;
	  this.save();
},
doSaveSettings:function(){
        var evt={};
        evt.command="SavePrintSetting";
        evt.callbackEvent="SavePrintSetting";
        evt.tableid= "21765";
        evt.template="cx2510";
        evt.format="pdf";
        this._executeCommandEvent(evt);
},
_onSavePrintSetting:function(e){
	
	       var retail_id=null;
	       if(this.pressB=="repeat"){
	       	retail_id = this.getCookie("retail_id");
	       	if(retail_id==false ||retail_id==null ||retail_id==""){
	       		alert("无重复打印数据");
	       		return;
		      }else{
		      	this.doRepeatPrint(retail_id);
		      }
	       }else{
	       	this.doPrint();
	       }
	      
},
doPrint:function(){
        var evt={};
        evt.tag="Print";
        evt.command="PrintJasper";
        evt.callbackEvent="PrintJasper";
        evt.params={"table":"21765","id":this.v_retailid};
        this._executeCommandEvent(evt);
},
doRepeatPrint:function(retail_id){
        var evt={};
        evt.tag="Print";
        evt.command="PrintJasper";
        evt.callbackEvent="PrintJasper";
        evt.params={"table":"21765","id":retail_id};
        this._executeCommandEvent(evt);
},
_onPrintJasper:function(e){
	      this.printRes=0;
        var pf;
        if(typeof(e)=="string") pf=e;
        else
            pf=e.getUserData().printfile;
        var f="/servlets/binserv/GetFile?filename="+encodeURIComponent(pf)+"&del=Y";
        var ifm=window.print_iframe;
        var disabledZone=$('disabledZone');
        if(disabledZone)disabledZone.style.visibility = 'visible';
        if(Prototype.Browser.IE){
            if(disabledZone)disabledZone.style.visibility = 'hidden';
            if(oc._closeWindow){
                window.location.href=f;
            }else{
                popup_window(f);
            }
        }else{
            $("print_iframe").onload=function (){
                setTimeout('bpos.waitOneMomentToPrint()', 1000);
            };
            ifm.location.href= f;
             this.printRes=1;
        }
        if(this.pressB!="repeat"){
			 		this.setCookie("retail_id", this.v_retailid, 7);
	   		}
	   		   
},
waitOneMomentToPrint:function(){
        if($('disabledZone'))$('disabledZone').style.visibility = 'hidden';
        window.print_iframe.focus();
        window.print_iframe.print();
        //if(this.pressB=="repeat"){
	   		//	this.clearCookie("retail_id");
	   		//}
         var posno=jQuery("#pos_no").val();
 	       var emp_id=jQuery("#emp_name").val();
	   		 window.location="/html/nds/bpos/index.jsp?posno="+posno+"&&empid="+emp_id;
},
//取得cookie    
getCookie:function(name){   
 var nameEQ = name + "=";    
 var ca = document.cookie.split(';');    //把cookie分割成组
 for(var i=0;i < ca.length;i++) {    
 var c = ca[i];                     //取得字符串    
 while (c.charAt(0)==' ') {          //判断一下字符串有没有前导空格    
 c = c.substring(1,c.length);      //有的话，从第二位开始取    
 }    
 if (c.indexOf(nameEQ) == 0) {       //如果含有我们要的name    
 return unescape(c.substring(nameEQ.length,c.length));    //解码并截取我们要值    
 }    
 }    
 return false;    
},    
    
//清除cookie    
clearCookie:function(name){    
 this.setCookie(name, "", -1);    
},   
    
//设置cookie    
 setCookie:function(name, value, days){    
 days = days || 0;   //days有值就直接赋值，没有为0
 var expires = "";    
 if (days != 0 ) {      //设置cookie生存时间    
 var date = new Date();    
 date.setTime(date.getTime()+(days*1000*3600*24));    
 expires = "; expires="+date.toGMTString();    
 }    
 document.cookie = name+"="+escape(value)+expires+"; path=/";   //转码并赋值    
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
