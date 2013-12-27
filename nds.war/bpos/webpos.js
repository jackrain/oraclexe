/**
 *Edit by Robin 20100720
 *处理WEBPOS主要逻辑。
 *
 *主要动作：
 *1.页面装载（BPOS_LOAD_MASTER）；后台根据的用户的ID返回JSON
 *{
 * "docno": "系统维护", //订单号，打开页面时后台自动生成
 * "c_store_id": 4005, //店仓ID
 * "sname": "", //
 * "c_store_name": "BURGEON", //店仓名称
 * "calculation": 1,// 进位方式，如四舍五入 之类
 * "discountlimit": -1, //最低折扣
 * "emp_ids": [], //店员ID
 * "emp_names": [], //店员编号
 * "emp_truenames": [], //店员真实名称
 * "emp_discountlmts": [-1],//店员的最低折扣率
 * "emp_passwordhash": ["c8c9f8916b113ec0c03832c3d5137de8"],//店员MD5码
 * "pids": [26, 27, 82, 101, 85, 86, 91, 96, 80, 81, 84], //付款方式的ID
 * "pnames": ["自动费用", "现金", "农业银行", "银行收款", "货到付款", "MKL001", "其他付款方式", "帐户余额", "工商银行", "现金券", "转帐"], //付款方式名称
 * "iscashs": ["N", "Y", "N", "N", "Y", "Y", "Y", "Y", "N", "Y", "N"], //是否现金
 * "ischarges": ["N", "Y", "N", "N", "Y", "Y", "Y", "Y", "N", "N", "N"], //是否找零
 * "emp_id": -1, //当前操作员ID
 * "emp_name": "", //当前营操作名称
 * "emp_truename": ""//当前操作员真实名称
 *}
 * 将转化为新的JSON对象：this.master_data:{
 *																					"docno": "系统维护",
 *																					"c_store_id": 4005,
 *																					"c_store_name": "BURGEON",
 *																					"calculation": 1,
 																						//20120719 增加商场，大部分客户门店都没有这个字段。默认为空。
 																					  "market":"",
 																						"url":url,//20120507 add by robin 
 *																					"discountlimit": -1,
 *																					"salers":[{id:2232,name:"dsfds",truename:"",passwordhash:"dsfdsfdsf",discountlmt:-1},{id:2323,name:"fief",turename:"fesefd",passwordhash:"dsfdsfdsf",discountlmt:-1},...],
 																						//2010-8-31新增iscashcard 判断是否VIP卡消费之类的
 *																					
 																						"payways":[{id:26,name:"自动费用",iscash:"N",ischarge:"N",iscashcard:"Y"},.....],
 *																					"saler":{id:-1,name:"dsfs",truename:"zhangsan",dicountlmt:-1},//当前营业员
 																						"operator":{id:-1,name:"dsfs",
 																												truename:"zhangsan",
 																												email:"nea@burgeon.com.cn",//新增email和ph 。方便 控件使用登陆portal
 																												passwordhash:"90kaifa",
 																												//20110212新增字段： 是否允许退货
 																												isret:"Y"|"N"
 																												}//当前操作员
 																						//新增系统参数20100807
 																						"params":{"vipcontroltype":VIP查询条件控制方式,"needorgno":退货时是否必输原单号,"barcodediscart":条
 																						码扫描舍弃位数,"billdaterange":单据日期允许修改范围,"loadcontrol":登录用户控制方式
 																						//新增VIP补录
 																						"additionalvip":true(or false),
 																						//新增登陆强制更新
 																						"compelupdate":true(or false),
 																						//新增 打印模板下载参数20101119
 																						"PrintTemplates":"aokang.rdlc|jiuzi.rdlc,aokang",
 																						//新增 是否必选营业员
 																						"requiredSaler":true|false,
 																						//20110112 新增 是否开启款号模式
 																						"pdtStyleModel":true|false
 																						//20110120 新增系统参数 品牌 对应字段
 																						"brandColumn":"DIM1"|"DIM2"....
 																						//20110211 新增 改金额 是否验证权限 参数
 																						"verifyPermission":"true"|"false",
 																						//20110301 新增 是否显示选择折扣积分
 																						"isIntlDis":"true"|"false",
 																						//20110310 新增 是否离线付款
 																						"offline":"true"|"false",
 																						//20110315 新增 自动上传时间间隔，默认30
 																						"uploadTimeInterval":30,
 																						//20110328 新增 使用消费券可否打折
 																						"ticketnodis":"true"|"false",
 																						//状态配置 20110411 配置切换状态 是否显示
												 										statusConf:1111|0000,
												 										//20110412是否显示 编辑结算类型功能
												 										needmarketbillway:true|false,
												 										//20110420所属公司，主要为了特殊定制功能如：奥康 VIP查询只可使用刷卡
												 										company:aokang|...,
												 										//20110525 折扣可大于1
												 										disCanLgOne:true|false,
												 										//20110610 离线下载VIP区域 0 不下载，1 店仓，2 同城，3全部
												 										vipAreaRange:0|1|2|3,
												 										//20111027 是否启用款号最低折扣限制
												 										lowest_discount:true|false
 																						},
 																						//新增创建时间createTime 20100902
 																						createTime:"2010-09-01 12:23:00",
 																						//新增单据可修改字段:标识该单据是否可修改，包括 改数量、金额、开新单……等。只能付款或挂单。默认为1（可修改）,0为不可修改
																						canModify:1,
																						//Add by Robin 20110222店仓执行语句,零售单保存时限(默认为2)
																						execSql:ret.c_store_sql||"null",
												 										orderLimitDate:ret.orderlimitdate||7;
												 										//add 20110405 刷卡方式  0 表示 无刷卡机，1表示通联
												 										comptype:0|1,
												 										
 *																				}
 * 2. 新增或更新一行明细（BPOS_INSERT_LINE，BPOS_INSERT_LINE_Q，BPOS_CHANGAMT）
 *    传入server JSON：{  "cardno":this.vip_id,//VIP卡号
 *												"c_store_id":this.master_data.c_store_id,//门店ID
 *												"billdate":sys_date,//单据时间
 *												"m_retail_productno":m_retail_productno,//条码
 *												"m_retail_qty":m_retail_qty,//数量
 *												"m_retail_type":m_retail_type,//单据明细类型（退货，正常。。）
 *												"m_retail_orgdocno":m_retail_orgdocno,//原单编号(退货时)
 *												"m_retail_priceactual":m_retail_priceactual,//应付
 *												"discount":discount//折扣
 *											}
 *		server返回JSON：{"m_retail_productno": "108310B921262", //条码
											 "m_retail_productname": "PLILYY083鞋0", //品名
											 "m_retail_colorname": "26", //颜色名
											 "m_retail_sizename": "M", //尺寸名
											 "m_retail_color": "26", //颜色
											 "m_retail_size": "2", //尺寸
											 "m_retail_mdim11": "", //国标码
											 "m_retail_productvalue": "108310B921", //款号
											 "m_retail_pricelist": 399, //标准价
											 "m_retail_discount": 1, //折扣
											 "m_retail_discription": "", //描述
											 "m_retail_priceactual": 399, //成交价
											 "m_retail_qty": 1, //数量
											 "m_retail_price": 399, //应付价
											 "m_retail_salerid": -1, //营业员ID
											 "m_retail_saler": "", //营业员
											 "m_retail_type": "1", //单据明细类型（退货，正常。。）
											 "m_retail_orgdocno": "", //原单编号(退货时)
											 "lineid": 1, 
											 "m_pda_id": 133306//条码ID
											}
		转化为对象：{
									"productno":"108310B921262", //条码
									"productname": "PLILYY083鞋0", //品名
									"colorname": "26", //颜色名 
									"sizename": "M", //尺寸名
									"color": "26", //颜色
									"size": "2", //尺寸
									"mdim11": "", //国标码
									"productvalue": "108310B921", //款号
									"pricelist": 399, //标准价
									"discount": 1, //折扣
									"discription": "", //描述
									"priceactual": 399, //成交价
									"qty": 1, //数量
									"price": 399, //应付价
									"salerid": -1, //营业员ID*****需要更新成当前营业员
									"saler": "", //营业员****需要更新成当前营业员
									"type": "1", //单据明细类型（退货，正常。。）
									"orgdocno": "", //原单编号(退货时)
									"lineno":1,//行号****需要更新当前行号
									"pda_id": 133306//条码ID
									"markbaltype":-1//20110413新增 商场结算类型
									"org_payways":[]//
									"org_qty":0//20110414增加 原单的付款方式 和 数量 列为了控制退货数量不能大于原单数量 和 付款方式 （控制付款方式的前提是金额为负）
									"multisalers":[] //add by robin  20120419 开启多选营业员时启用
									
								}
	然后保存或更新到 this.items_data 数组中
 *判断是否已存在此数组中的唯一条件是：productno+saler+type
 *
 **设置变量this.maxlineno（最大行号）当是新增时this.maxlineno++
 *
 *
 *3. VIP(BPOS_CHECKVIP,BPOS_CHECKVIPENTER)
 * 传入server的JSON：{"cardno":cardno}
 * server返回JSON: {"vip_id": 340, //VIP ID
 *									 "vipname": "234", //VIP用户名
 *								   "vipename": "", //英文名
 *									 "c_viptype": "临时卡", //VIP类型
 *									 "discount": 0.9, //折扣
 *									 "idno": "", //身份证
 *								   "sex": "W", //性别
 *									 "birthday": 20081101, //生日
 *									 "validdate": 20110312, //失效日期
 *									 "cardno": "L100002"//卡号
 *									}
 *保存到this.vip对象中
 *
 *
 *
 */

var bpos=null;
var BPOS=Class.create();
BPOS.prototype={
	initialize: function(){

	dwr.util.useLoadingMessage(gMessageHolder.LOADING);
	dwr.util.setEscapeHtml(false);
	//类型
	this.types=[{value:1,type:"正常",color:"blue",active:1},{value:3,type:"赠品",color:"#ffff00",active:1},{value:2,type:"退货",color:"#ff0000",active:1},{value:4,type:"全额",color:"#000000",active:1}];
	//没有弹出窗口和对话框
	this.noAlert=true;
	//是否装载页面状态
	this.isOnLoad=true;
	//本地配置文件参数；
	this.locationConfig={};
	//Add by Robin 20110223新增（1111111111） 分别为：挂单、VIP补录、开新单、删除、改金额、改数量、总额折扣、付款、总单策略、新增行（可以或不可以，类似权限，以后可能要扩展到 VIP付款等。。）
	this.MODEL=1023;
	this.HOOKORDER=512;
	this.CHANGEBILLDATE =512;
	this.ADDITIONVIP=256;
	this.NEWODER=128;
	this.DELETE=64;
	this.CHANGEAMOUNT=32;
	this.CHANGENUM=16;
	this.DISTOTAMOUNT=8;
	this.PAYPRICE=4;
	this.WHOLEDIS=2;
	this.INSERTLINE=1;
	this.flag_num=0;//0为条码查询。1为款号查询可用库存
	this.SHOWMODEL=128;
	this.NOMODIFY=518;
	this.ALL=1023;
	
	//离线登陆时个别查询操作需要服务器地址，如查询库存
	this.URL="";
	//是否在上传
	this.isUploading=false;
	//当执行了总单策略时是否能用贵宾券消费20101021
	this.canUseTicketWhenWholeDis=false;
	//折扣是否可大于1
	this.discountCanLgOne=false;
	this.windowLocation=window.location;
	//是否在线状态20101203
	this.isOnline=true;
	//是否已经刷过银行卡了 20110406
	this.hasCreditBankCard=false;
	//成交的单据数
	this.orders=0;
	this.org_payitems=new Array();//20110901原单付款明细，包括 单据日期、付款方式、付款金额。。。
	this.orgdocnos=new Array();
	this.hy_cardno=0;//新增零售单vip卡号
	this.gh_rows=0;//新增款号量
	this.q_data=null;//退货查询结果
	this.search_end=1;//判别通过查询进行退货,1未查询0已查询
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
	application.addEventListener( "BPOS_CHECKADDVIP", this._oncheckaddvip, this);
	application.addEventListener( "BPOS_SAVE_PRINT", this._onsave_print, this);
	application.addEventListener( "BPOS_CHANGAMT", this._changamt, this);
	application.addEventListener( "BPOS_RET_FUZZYQUERY", this._onInsertLine_q, this);
	application.addEventListener( "BPOS_INSERT_LINE_Q", this._onInsertLine_q, this);
	application.addEventListener( "BPOS_CHECKTICKET",this._ondealticket,this);
	application.addEventListener( "BPOS_VIPACM", this._dovipacm, this);
	application.addEventListener( "BPOS_VIP_BIRTHDAYDIS", this._onbirthdaymonthdis, this);
	application.addEventListener( "VIP_SMS", this._onSmsVip, this);
	//this.updatedb();
	//打印信息，提供用户可以打印前一张单据的功能
	this.printInfo={};
	this.init();
	this.master_data={};
	this.initparams($("params").value.evalJSON());
	this.doSomeThingWhenInitparams();
	this.loadMasterObject();
	this._editvip();
	this.getServerUrl();
	window.onbeforeunload=function(){
		if(jQuery("#MainApp").css("display")=="none") {
			jQuery("#MainApp").show();
			return;
		}
		var str="";
		var ret = bpos.actionsWhenUnload();
		if(ret>0)str+="有"+ret+"张单据未成功上传！";
		if(bpos.items_data.length>0&&bpos.master_data.canModify==0)str+="该单据属于挂单零售,请先处理！";
		if(bpos.items_data.length>0)str+="单据明细未保存！";
		if(str=="")return;
		return str;
	}

	
	
	
 }, 
 /**
 * 修改主菜单的指示图标by zxz 120523
 */
changeIcon:function(mainNode) {alert("122");
	if (mainNode) {
		if (mainNode.css("background-image").indexOf("collapsed.gif") >= 0) {
			mainNode.css("background-image","url('images/expanded.gif')");
		} else {
			mainNode.css("background-image","url('images/collapsed.gif')");
		}
	}
},
 //Activex接口缓存数据
 CacheData:function(storeId){
 	MainApp.GetGroupDiscount(""+storeId);
 }, 
 //获取服务器地址
 getServerUrl:function(){
	 if(!this.checkIsOnline()){
		 this.URL=MainApp.GetHiddenConfigFile("URL")+"bpos/";
	 }
 },
  //在线店务
  //add by robin 20120423 增加报表查询逻辑
 lineShop:function(id,title,qrpt) {
 	var rp="";
 	if(qrpt)rp="&qrpt="+qrpt;
 	var options = {width:1000,height:660,title:title, modal:true,centerMode:"x",maxButton:false,onCenter:true};
	Alerts.popupIframe("/bpos/portal-min.jsp?ss=0&mm="+id+rp,options);
	Alerts.resizeIframe(options);
	jQuery("#MainApp").hide();
 }, //初始化头
 initItemHeaderFirst:function(){
 	var innHtmlHead="";
 	if(this.checkNeedMarketBillWay()){
 		if(this.master_data.params.pageStyle=='redearth'){
 			innHtmlHead="<div class=\"from-span-2\">序号</div><div class=\"from-span-4\">型号</div><div class=\"from-span-7\">结算类型</div><div class=\"from-span-4\">品名</div><div class=\"from-span-4\">条码</div><div class=\"from-span-16\">零售价</div><div class=\"from-span-17\">数量</div><div class=\"from-span-17\">折扣</div><div class=\"from-span-16\">实价</div><div class=\"from-span-16\">金额</div><div class=\"from-span-18\">员工</div>";
 		}else if(this.master_data.params.pageStyle=='tommy') {
 			innHtmlHead="<div class=\"from-span-13\">序号</div><div class=\"from-span-4\">条码</div><div class=\"from-span-04\">款号</div><div class=\"from-span-7\">结算类型</div><div class=\"from-span-19\">系列1</div><div class=\"from-span-19\">小类</div><div class=\"from-span-13\">颜色</div><div class=\"from-span-13\">尺码</div><div class=\"from-span-2\">数量</div><div class=\"from-span-16\">原价</div><div class=\"from-span-13\">折扣</div><div class=\"from-span-16\">实价</div><div class=\"from-span-16\">金额</div><div class=\"from-span-15\">营业员</div>";
		}else if(this.master_data.params.pageStyle=='busen'){
			innHtmlHead="<div class=\"from-span-13\">序号</div><div class=\"from-span-4\">条码</div><div class=\"from-span-5\">结算类型</div><div class=\"from-span-12\">品名</div><div class=\"from-span-2\">数量</div><div class=\"from-span-14\">原价</div><div class=\"from-span-13\">折扣</div><div class=\"from-span-14\">实价</div><div class=\"from-span-14\">金额</div><div class=\"from-span-9\">营业员</div><div class=\"from-span-13\">状态</div><div class=\"from-span-014\">款号</div><div class=\"from-span-13\">颜色</div><div class=\"from-span-13\">色名</div><div class=\"from-span-13\">尺寸</div><div class=\"from-span-9\">尺寸名</div>";
		}else {
 			innHtmlHead="<div class=\"from-span-13\">序号</div><div class=\"from-span-4\">条码</div><div class=\"from-span-5\">结算类型</div><div class=\"from-span-12\">品名</div><div class=\"from-span-2\">数量</div><div class=\"from-span-14\">原价</div><div class=\"from-span-13\">折扣</div><div class=\"from-span-14\">实价</div><div class=\"from-span-14\">金额</div><div class=\"from-span-9\">营业员</div><div class=\"from-span-13\">状态</div><div class=\"from-span-14\">款号</div><div class=\"from-span-13\">颜色</div><div class=\"from-span-13\">色名</div><div class=\"from-span-13\">尺寸</div><div class=\"from-span-9\">尺寸名</div><div class=\"from-span-15\">原厂编码</div>";
 		}
 	}else{
 		if(this.master_data.params.pageStyle=='redearth'){
 			innHtmlHead="<div class=\"from-span-6\">序号</div><div class=\"from-span-4\">型号</div><div class=\"from-span-4\">品名</div><div class=\"from-span-4\">条码</div><div class=\"from-span-5\">零售价</div><div class=\"from-span-5\">数量</div><div class=\"from-span-5\">折扣</div><div class=\"from-span-16\">实价</div><div class=\"from-span-16\">金额</div><div class=\"from-span-6\">员工</di>";
 		}else if(this.master_data.params.pageStyle=='tommy') {
 			innHtmlHead="<div class=\"from-span-13\">序号</div><div class=\"from-span-4\">条码</div><div class=\"from-span-04\">款号</div><div class=\"from-span-19\">系列1</div><div class=\"from-span-19\">小类</div><div class=\"from-span-14\">颜色</div><div class=\"from-span-14\">尺码</div><div class=\"from-span-2\">数量</div><div class=\"from-span-16\">原价</div><div class=\"from-span-13\">折扣</div><div class=\"from-span-16\">实价</div><div class=\"from-span-16\">金额</div><div class=\"from-span-14\">营业员</div>";
 		}else if(this.master_data.params.pageStyle=='busen'){
			innHtmlHead="<div class=\"from-span-13\">序号</div><div class=\"from-span-4\">条码</div><div class=\"from-span-012\">款号</div><div class=\"from-span-2\">数量</div><div class=\"from-span-014\">原价</div><div class=\"from-span-13\">折扣</div><div class=\"from-span-014\">实价</div><div class=\"from-span-014\">金额</div><div class=\"from-span-15\">营业员</div><div class=\"from-span-13\">状态</div><div class=\"from-span-014\">品名</div><div class=\"from-span-13\">颜色</div><div class=\"from-span-13\">色名</div><div class=\"from-span-13\">尺寸</div><div class=\"from-span-9\">尺寸名</div>";
		}else{
 			innHtmlHead="<div class=\"from-span-1\">序号</div><div class=\"from-span-4\">条码</div><div class=\"from-span-12\">品名</div><div class=\"from-span-2\">数量</div><div class=\"from-span-5\">原价</div><div class=\"from-span-1\">折扣</div><div class=\"from-span-5\">实价</div><div class=\"from-span-5\">金额</div><div class=\"from-span-9\">营业员</div><div class=\"from-span-1\">状态</div><div class=\"from-span-6\">款号</div><div class=\"from-span-3\">颜色</div><div class=\"from-span-1\">色名</div><div class=\"from-span-1\">尺寸</div><div class=\"from-span-9\">尺寸名</div><div class=\"from-span-18\">原厂编码</div>";
 		}
 	}
 	 return innHtmlHead;
 	},
 
 //20110414 根据系统参数 控制零售界面 显示样式 
 initItemsHeaderHtmlByParam:function(){
 	var innHtml=this.initItemHeaderFirst();//获取头的样式
 
 	jQuery("#from-table").html(innHtml);
 	var innHtml2="";
 	if(this.master_data.params.pageStyle=='redearth'){
 		jQuery("#f3button").val("F3：员工");
 		jQuery("#currSaler").val("当前员工");
 		jQuery("#mulbarcodescape").html("<div class=\"treatment-span-10\">型号</div><div class=\"treatment-span-10\">品名</div><div class=\"treatment-span-7\">条码</div><div class=\"treatment-span-8\">零售价</div><div class=\"treatment-span-6\">颜色</div><div class=\"treatment-span-6\">尺寸</div><div class=\"treatment-span-6\">颜色号</div><div class=\"treatment-span-6\">尺寸号</div><div class=\"treatment-span-8\">数量</div>");
 	}
 	 //tommy定制系列1与小类
   if(this.master_data.params.pageStyle=="tommy") {
			  jQuery("#mulbarcodescape").html("	<div class=\"treatment-span-7\">条码</div><div class=\"treatment-span-10\">款号</div><div class=\"treatment-span-10\" >品名</div><div class=\"treatment-span-6\">颜色</div><div class=\"treatment-span-6\">尺寸</div><div class=\"treatment-span-6\">系列1</div><div class=\"treatment-span-6\">小类</div><div class=\"treatment-span-8\">标准价</div><div class=\"treatment-span-8\">数量</div>");
	  }
 },
 //20110414 获得系统参数后的动作；有：画界面布局样式(redearth、通用、是否显示结算方式)
 doSomeThingWhenInitparams:function(){
 	this.vipTicketName=this.master_data.params.vipTicketName||"贵宾券";
 	this.vipPayTypeName=this.master_data.params.vipPayTypeName||"VIP付款";
 },
 /**
 	* 修改模式；目前有 ：SHOWMODEL(只读模式)、NOMODIFY（不可修改模式）,ALL(无限制模式)
 	*/
 	changeModel:function(model){
 		switch(model){
 			case "SHOWMODEL":this.MODEL=this.SHOWMODEL;break;
 			case "NOMODIFY":this.MODEL=this.NOMODIFY;break;
 			case "ALL":this.MODEL=this.ALL;break;
 		}
	},
	closeWindow:function(){
		var ret = this.actionsWhenUnload();
		if(ret>0) {
			if(!confirm("有"+ret+"张单据未成功上传！确认关闭页面？")){
		   		return;
		  }
		}
		if(bpos.items_data.length>0&&bpos.master_data.canModify==0){
			alert("该单据属于挂单零售,请先处理！");
		}else if(bpos.items_data.length>0){
			if(confirm("单据明细未保存！确认关闭页面？"))window.close();
		}else{
			window.close();
		}
	},
	exportaxtivexparams:function(online){
  	if(this.offline==true&&isIE()){
			var info={};
			info.param=this.master_data;
			if(!online)online=false;
			this.setparm(Object.toJSON(info),online);
		}
	},
  init:function(newretail){
  	this.tdefposdis_id=-1;
  	this.tdefposdis_name=-1;
  	this.delLineindex=new Array();
  	this.linenos=new Array();
  	this.selectid=-1;
  	this.items_data=new Array();
  	this.maxlineno=0;
		this.vip={};
		this.vipret=new Array();
		//add by Robin 20101221 积分消费活动促销数据
		this.vipdisinfo=new Array();
		//add by robin 20120116 修复VIP积分消费缓存未清除问题
		this.tempvipdis=null;
		this.consumecards=new Array();//已用消费卡
		if(this.master_data)this.master_data.docno="系统维护";
		this.org_payitems=new Array();
		this.orgdocnos=new Array();
		this.offline=true;//是否离线模式，暂时设为true
		var findex=this.getFirstIndexActiveType();
		if(!findex&&findex!=0){
			alert("零售状态全不可用，配置错误！请联系系统管理员");
			window.close();
			return;
		}
		this.itemtype=this.types[findex].value;//销售类型 （1:正常，2：退货，3： 赠品，4： 全额）
		this.tempvip;//保存VIP查询并选中结果
		if(newretail&&newretail=="f2newretail"){
			//alert(Object.toJSON(this.master_data.saler));
		}else{
			if(this.master_data){
				this.master_data.saler={};//初始化当前营业员
				this.master_data.saler.id=-1;
				this.master_data.saler.name="-";
				this.master_data.saler.truename="-";
				this.master_data.canModify=1;
				this.master_data.multisalers=new Array();
			}
		}
		try{
			if(!this.isOnLoad)this.setvip("-1");
		}catch(e){}
		jQuery("#m_retailtype").attr("val",this.types[findex].value);
		jQuery("#m_retailtype").val(this.types[findex].type);
		jQuery("#from-main").html("");//初始化单据明细（清空）Edit by Robin 2010.7.15
		this.updatehtml();
		this.updateheaderhtml(newretail);
		this.temp_items_data=new Array();
		//this.totdata={"totqty":0,"totpricelist":0.00,"totprice":0.00};//总数据对象
		this.initpayitem();
		this.temppayitem={};
		//记录提交零售单的明细，为了本地打印
		this.submititems={};
		//单据是否执行了总单策略2010.10.21
		this.hasWholeDis=false;
		this.hasCreditBankCard=false;
		if(this.master_data&&this.master_data.refno)this.initrefno();
		//this.totdiacount=0;
		this.vipaccount={};
		if(zody)zody.turnTime();
		this.ticketnos=new Array();
		this.temppayitem={};
		this.payment=[];  //付款方式
		//alert(3);
		//新增创建时间createTime &&!newretail
		if(this.master_data)this.master_data.createTime=this.getformatcurrenttime();
		this.change=0;
		this.tempretailid =0; //修给金额时的选种的retailid\
		this.viprecharge=0.00;
		//记录要付款时的总金额，方便重付时得到正确的总金额（如：VIP补录后再重付）
		this.tempAmount=0.00;
		this.changeModel("ALL");
		if(this.master_data&&this.master_data.c_store_id)this.updateBusinessIndicator();
		this.tempvou={};
		this.vouinfo={};//重置购物券信息
		
		
  },
  updateBusinessIndicator:function(){
  	jQuery.ajax({
				type:"POST",
				url:this.URL+"updateBusinessIndicator.jsp",
				data:"si="+this.master_data.c_store_id,
				error:function(){},
				success:function(data){
					data=jQuery.trim(data);
					if(data.indexOf("data:")!=-1){
						var a=data.replace("data:","").split(",");
						jQuery("#daycurrent").html(a[0]);
						jQuery("#monthcurrent").html(a[1]);
						jQuery("#numcurrent").html(a[2]);
					}
				}
			});
  },
  getformatcurrenttime:function(){
  	var t=new Date();
  	var year=t.getYear();
  	var m=t.getMonth()+1;
  	if(m<10)m="0"+m;
  	var d=t.getDate();
  	if(d<10)d="0"+d;
  	var h=t.getHours();
  	if(h<10)h="0"+h;
  	var mi=t.getMinutes();
  	if(mi<10)mi="0"+mi;
  	var s=t.getSeconds();
  	if(s<10)s="0"+s;
  	return year+"-"+m+"-"+d+" "+h+":"+mi+":"+s;
	},
  initpayitem:function(){
  	this.payitem={"TotalAmount":0.00,//应付金额
									"_totalNoCashNoCharge":0.00,//卡
									"_totalCashNoCharge":0.00,//券
									"_totalVipCharge":0.00,//VIP付款
									"_totalCashCharge":0.00//现金
								 }; 
  	this.change=0.00;
  },
  checkPayWayExists:function(payway){
  	if(!payway||jQuery.trim(payway)==="")return false;
  /*for(var i=0;i<this.master_data.payways.length;i++){
  		if(payway==this.master_data.payways[i].name) return true;
  	}*/
  	return true;
  },
 initparams:function(jo){
 	if(jo){
 		var params={};
 		for(var i=0;i<jo.webpos.length;i++){
 			switch(jo.webpos[i].NAME){
 				case "webpos.2005":params.vipcontroltype=jo.webpos[i].VALUE;break;
 				case "webpos.2004":params.needorgno=jo.webpos[i].VALUE;break;
 				case "webpos.2003":params.barcodediscart=jo.webpos[i].VALUE;break;
 				case "webpos.2002":params.billdaterange=jo.webpos[i].VALUE;break;
 				case "webpos.2001":params.loadcontrol=jo.webpos[i].VALUE;break;
 				case "webpos.6055":params.additionalvip=jo.webpos[i].VALUE;break;
 				case "webpos.2006":params.compelupdate=jo.webpos[i].VALUE;break;
 				case "webpos.PrintTemplates":if(jQuery.trim(jo.webpos[i].VALUE)!="-1")params.PrintTemplates=jo.webpos[i].VALUE;break;
 				case "webpos.limitBrand":params.limitBrand=jo.webpos[i].VALUE;break;
 				case "webpos.requiredSaler":params.requiredSaler=jo.webpos[i].VALUE;break;
 				case "webpos.pdtStyleModel":params.pdtStyleModel=jo.webpos[i].VALUE;break;
 				case "webpos.pageStyle": params.pageStyle=jo.webpos[i].VALUE;break;
 				case "webpos.3001": params.brandColumn=jo.webpos[i].VALUE;break;
 				case "webpos.verifyPermission":params.verifyPermission=jo.webpos[i].VALUE;break;
 				case "webpos.isIntlDis":params.isIntlDis=jo.webpos[i].VALUE;break;
 				case "webpos.offline":params.offline=jo.webpos[i].VALUE;break;
 				case "webpos.uploadTimeInterval":params.uploadTimeInterval=jo.webpos[i].VALUE;break;
 				case "webpos.ticketnodis":params.ticketnodis=jo.webpos[i].VALUE;break;
 				case "webpos.statusConf":params.statusConf=jo.webpos[i].VALUE;break;
 				case "webpos.needmarketbillway":params.needmarketbillway=jo.webpos[i].VALUE;break;
 				case "webpos.company":params.company=jo.webpos[i].VALUE;break;
 				case "webpos.disCanLgOne":params.disCanLgOne=jo.webpos[i].VALUE;break;
 				case "webpos.vipAreaRange":params.vipAreaRange=parseInt(jo.webpos[i].VALUE,10);break;
				case "webpos.printCount":params.printCount=parseInt(jo.webpos[i].VALUE,10);break;
 				case "webpos.showVIPAlertOnNewOrder":params.showVIPAlertOnNewOrder=jQuery.trim(jo.webpos[i].VALUE);break;
 				case "webpos.noOrderNOnoPass":params.noOrderNOnoPass=jo.webpos[i].VALUE;break;
 				case "webpos.m_product.lowest_discount":params.lowest_discount=jo.webpos[i].VALUE;break;
 				case "webpos.vip.aum":params.vip_aum=jo.webpos[i].VALUE;break;
 				case "webpos.showLowestDisprice":params.showLowestDisprice=jo.webpos[i].VALUE;break;
 				case "webpos.buttonShowList":params.buttonShowList=jo.webpos[i].VALUE;break;
 				case "webpos.multiSalers": params.multiSalers=jo.webpos[i].VALUE;break;
 				case "webpos.vip.addRequiredCondition": params.vipAddRequiredCondition=jo.webpos[i].VALUE;break;
 				case "webpos.vipTicketName" :params.vipTicketName=jo.webpos[i].VALUE;break;
 				case "webpos.vipPayTypeName" :params.vipPayTypeName=jo.webpos[i].VALUE;break;
 				case "webpos.vip.integralDisBasePrice" :params.integralDisBasePrice=isNaN(parseInt(jo.webpos[i].VALUE,10))?1:parseInt(jo.webpos[i].VALUE,10);break;
 			  case "webpos.returnPriceLimit":params.returnPriceLimit=jo.webpos[i].VALUE;break;//退货最低折扣限制by add zxz at 120520
 			  case "webpos.defaultSaler":params.defaultSaler=jo.webpos[i].VALUE;break;//是否默认营业员by add zxz at 120612
 			  case "webpos.showFinishedTarget":params.showFinishedTarget=jo.webpos[i].VALUE;break;//是否显示当前完成量by add zxz at 120612
 			  case "webpos.defaultPayway":params.defaultPayway=jo.webpos[i].VALUE;break;//默认付款方式by add zy at 120716
 			  case "webpos.defaultVipType":params.defaultVipType=jo.webpos[i].VALUE;break;
 			  case "webpos.orgModifyPer":params.orgModifyPer=jo.webpos[i].VALUE;break;
 			  case "webpos.canUseTicketWhenWholeDis":params.canUseTicketWhenWholeDis=jo.webpos[i].VALUE;break;
 			  case "webpos.canImportInventory":params.canImportInventory=jo.webpos[i].VALUE;break;
 			  case "webpos.useVipSms":params.useVipSms=jo.webpos[i].VALUE;break;
 			  case "webpos.validateVipPw":params.validateVipPw=jo.webpos[i].VALUE;break;
 			  case "webpos.QXAbsPath":params.QXAbsPath=jo.webpos[i].VALUE;break;
 			  //校验时间参数
 			  case "webpos.timeVerify":params.timeVerify=jo.webpos[i].VALUE;break;
 			  case "webpos.onLineSkuMatche":params.onLineSkuMatche=jo.webpos[i].VALUE;break;
 			  case "webpos.enableOffInventory":params.enableOffInventory=jo.webpos[i].VALUE;break;
 			}
 		}
 		if(params.enableOffInventory==undefined)params.enableOffInventory="true";
 		if(params.onLineSkuMatche==undefined)params.onLineSkuMatche="false";
 		if(params.validateVipPw==undefined)params.validateVipPw="false";
 		if(params.useVipSms==undefined)params.useVipSms="false";
 		if(params.canImportInventory==undefined)params.canImportInventory="false";
 		if(params.canUseTicketWhenWholeDis==undefined)params.canUseTicketWhenWholeDis="false";
 		if(params.integralDisBasePrice==undefined)params.integralDisBasePrice=1;
 		if(!params.vipAddRequiredCondition)params.vipAddRequiredCondition="111100";
 		if(!params.multiSalers)params.multiSalers="false";
 		if(!params.lowest_discount)params.lowest_discount="true";
 		if(!params.noOrderNOnoPass)params.noOrderNOnoPass="true";
 		if(!params.orgModifyPer)params.orgModifyPer="true";
		if(!params.printCount)params.printCount=1;
 		if(!params.showVIPAlertOnNewOrder)params.showVIPAlertOnNewOrder="true";
 		if(!params.vipAreaRange)params.vipAreaRange=0;
 		if(!params.statusConf)params.statusConf="1111";
 		if(!params.vip_aum)params.vip_aum="111";
 		if(!params.showLowestDisprice)params.showLowestDisprice="true";
 		if(!params.buttonShowList)params.buttonShowList="1111111";
 		if(params.disCanLgOne&&jQuery.trim(params.disCanLgOne)=="true") this.discountCanLgOne=true;
 		if(jo.brand&&jo.brand!=-1)params.brand=jo.brand;
 		if(jo.m_dim1_id&&jo.m_dim1_id!=-1)params.m_dim1_id=jo.m_dim1_id;
 		if(!this.checkPayWayExists(params.defaultPayway))params.defaultPayway="现金";
 		if(!params.defaultVipType)params.defaultVipType="NON";
 		//校验时间参数
 		if(!params.timeVerify)params.timeVerify="P|M|5";
 		
 		this.master_data.params=params;
 	}
 },
 //20120326 新增 按钮是否显示检验
 checkButtonShowPer:function(btn){
 	var per=parseInt(this.master_data.params.buttonShowList,2);
 	switch(btn){
 		case "UPLOAD": return ((256&per)==256);
 		case "SEARCH": return ((128&per)==128);
 		case "SALER": return ((64&per)==64);
 		case "PENDING": return ((32&per)==32);
 		case "CHANGESTATE": return ((16&per)==16);
 		case "CHANGENUM": return ((8&per)==8);
 		case "CHANGEAMT": return ((4&per)==4);
 		case "CHANGETOTAMT": return ((2&per)==2);
 		case "BATCH": return ((1&per)==1);
 		default : return true;
 	}
 },
 //20110513 检测是否在线状态
 checkIsOnline:function(){
 	if(window.location.host)return true;
 	return false;
 },
 //20110413检查是否需要 显示 商场结算方式
 checkNeedMarketBillWay:function(){
 	if(this.master_data.params.needmarketbillway&&this.master_data.params.needmarketbillway=='true'&&this.locationConfig.PosConfig&&this.locationConfig.PosConfig.StorePayType=='True')return true;
 	return false;
 },
 loadMasterObject: function(){
 		if(!this.checkIsOnline()){
 			this._onLoadMasterObjectForOffline();
 			return;
 		}
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_LOAD_MASTER";
		var param={"store":$("store_id").value};
		//alert(Object.toJSON(param));
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="load_master";
		evt.permission="r";		
		
		this._executeCommandEvent(evt);				
	},
	checkMultiSalers:function(multisalers,toMultisalers){
		if(multisalers.length!=toMultisalers.length){
			return false;
		}
		for(var i=0;i<multisalers.length;i++){
			if(multisalers[i].id!=toMultisalers[i].id)return false;
		}
		return true;
	},
	/**
	 *Edit by Robin 20100721
	 *判断item是否已存在this.items_data中。
	 *判断的条件是productno+saler+type
	 *@param ：item 需要判断的对象
	 *@return:如果存在则返回该匹配对象。否则返回-1
	 */
	checkisexistinitemsdata:function(item){
		for(var i=0;i<this.items_data.length;i++){
			if(item.productno==this.items_data[i].productno&&item.type==this.items_data[i].type&&item.discount==this.items_data[i].discount&&item.markbaltype==this.items_data[i].markbaltype){
				if(this.value2type(item.type)=="退货"&&item.org_docno!=this.items_data[i].org_docno) {
						continue;
					}
				if((item.saler==this.items_data[i].saler&&this.master_data.params.multiSalers=="false")||(this.master_data.params.multiSalers=="true"&&this.checkMultiSalers(item.multisalers,this.items_data[i].multisalers))){
					return this.items_data[i];
				}
			}
		}
		return -1;
	},
	/**
	 *根据lineno从this.items_data中得到item
	 *@param :lineno 行号
	 *@return : item
	 */
	getitembylinenofromitems_data:function(lineno){
		for(var i=0;i<this.items_data.length;i++){
			if(lineno==this.items_data[i].lineno){
				return this.items_data[i];
			}
		}
	},
	
	/**
	 *修改一行的明细
	 *@param :item 需修改的内容明细
	 *@param ：index 源明细所在this.items_data中的索引，可不填，当不填时，根据item查找源明细
	 */
	modifyitem:function(item,index){
		//if(!orgitem) orgitem=this.checkisexistinitemsdata(item);
		if(parseInt(index,10)==index){
			var orgitem=this.items_data[index];
			//alert(Object.toJSON(orgitem));
			this.modifyitem2items_data(orgitem,item);
			this.updatehtml();		
		}
	},
	//根据lineno得到item在this.items_data中的索引
	getitemindexbylineno:function(lineno){
		for(var i=0;i<this.items_data.length;i++){
			var item=this.items_data[i];
			if(item.lineno==lineno){
				return i;
			}
		}
		return -1;
	},
	/**
	 *处理手动更新
	 *@param :lineno 行号
	 *@param :item 手动跟新的item 必须包含discount,pricelist,qty其中的一个或多个，如果没有则必须转化
	 *注意：当为改价格时qty一定不能有
	 */
	manualupdateitem:function(lineno,item){
		var index=this.getitemindexbylineno(lineno);
		//var orgitem=this.getitembylinenofromitems_data(lineno);
		this.modifyitem(item,index);
	},
	
	/**
	 *Edit by Robin 20100721
	 *将orgitem中值修改为item中的值
	 *更新页面显示类容
	 *@param ：orgitem 已存在items_data中的item
	 *@param :item 新增需要更新的item
	 */
	modifyitem2items_data:function(orgitem,item){
		if(item.discount||item.discount==0){
			orgitem.discount=item.discount;
		}
		if(item.qty||item.qty==0){
			var type=this.value2type(orgitem.type);
			if(type=="退货"){
				orgitem.qty=-item.qty;
			}else{
				orgitem.qty=item.qty;
			}
		}
		if(item.priceactual||item.priceactual==0){
			orgitem.priceactual=item.priceactual; 
		}else{
			orgitem.priceactual=this.alg(orgitem.discount.mul(orgitem.pricelist));
		}
		if(item.price||item.price==0){
			orgitem.price=item.price;
		}else{
			orgitem.price=this.alg(orgitem.qty.mul(orgitem.priceactual));
		}
		//这里为了提高效率可以重组JSON对象而非把总个orgitem传入
		this.updateline(orgitem.lineno,orgitem);
	},
	/**
	 *Edit by Robin 20100721
	 *将item更新到orgitem中，主要用于当item已在items_data中存在时更新
	 *更新页面显示类容
	 *@param ：orgitem 已存在items_data中的item
	 *@param :item 新增需要更新的item
	 *注意：discount取的是最小值
	 */
	updateitem2items_data:function(orgitem,item){
		var discount=1;
		if(item.discount||item.discount==0){
		 	discount=orgitem.discount>item.discount?item.discount:orgitem.discount;
		 	orgitem.discount=discount;
		}else{
			discount=orgitem.discount;
		}
		if(item.pricelist||item.pricelist==0){
			orgitem.pricelist=item.pricelist;	
		}
		orgitem.priceactual=this.alg(discount.mul(orgitem.pricelist));
		if(item.qty||item.qty==0){
			orgitem.qty+=item.qty;
		}
		if(item.price||item.price==0){
			orgitem.price=item.price.add(orgitem.price);
		}else{
			orgitem.price=this.alg(orgitem.qty.mul(orgitem.priceactual));
		}
		//这里为了提高效率可以重组JSON对象而非把总个orgitem传入
		this.updateline(orgitem.lineno,orgitem);
	},
	//Edit by Robin 20100824将单个明细增加到items中
	items_datapushitem:function(item,items){
		if(!items)items=this.items_data;
		if(item.lineno==-1){
			this.maxlineno++;
			item.lineno=this.maxlineno;
		}
		/*
		item.saler=this.master_data.saler.name;
		item.salerid=this.master_data.saler.id;
		*/
		items.push(item);		
	},
	/**
	 *Edit by Robin 20100721
	 *this.items_data中新增一行记录，需要更新lineno,saler,salerid
	 *@param ：item 新增的item
	 */
	additem2items_data:function(item){
		//alert("asdfad");
		//if(item_type&&item_type=="showOrder")
	//	item_type=="showOrder"?"":this.items_datapushitem(item);//如果是查询就阻止加入it
	this.items_datapushitem(item);
		//alert(Object.toJSON(item));
			
	  	this.insertitem(this.maxlineno,item);
	  	
	},
	/**
	 *add by robin 20121121 增加拆分明细的流程；目前针对VIP当日当月消费活动，一旦明细中的数量大于活动可以是使用的数量就需要对该明细进行拆分。
	 *@param item ：需要拆分的明细
	 *@param qty :需要保留的数量
	 *return  返回拆分出去的item
	 */
	splitItem:function(item,qty){
		if(item.qty<qty||qty<=0)return null;
		var oitem=Object.toJSON(item);
		oitem=oitem.evalJSON();
		oitem.qty=item.qty-qty;
		oitem.lineno=-1;
		oitem.price=(oitem.priceactual).mul(oitem.qty);
		item.qty=qty;
		item.price=(item.priceactual).mul(item.qty);
		return oitem;
	},
	/**
	 *add by robin 20121122 合计明细中已经使用的VIP当日当月消费活动的商品数量
	 *只有在活动为 “限制件数的条件下”明细中才会 保留 VIP当日当月活动的ID
	 */
	countVipBirDis:function(){
		var count=0;
		for(var i=0;i<this.items_data.length;i++){
			if(this.items_data[i].vipbirdisid&&this.items_data[i].vipbirdisid>0)count+=this.items_data[i].qty;
		}
		return count;
	},
	/**
	 *add by robin 20121122 刷新VIP当日当月消费本单中剩余优惠件数。只针对于“限制件数”的条件
	 *
	 */
	refreshVipDisUseQty:function(){
		if(this.vip&&this.vip.vipdis){
			this.vip.vipdis.USEQTY=this.countVipBirDis();
			return this.vip.vipdis.USEQTY;
		}
		return 0;
	},
	
	/**
	 * add by robin 20121122 获取VIP生日当日当月“按件数”情况下剩余使用数量
	 */
	getVipDisRemQty:function(){
		if(this.vip&&this.vip.vipdis)
		return this.vip.vipdis.REMQTY-this.refreshVipDisUseQty();
		return 0;
	},
	/**
	 *add by robin 20121121 针对VIP当日当月活动的 限制 件数的情况（包括 正价前提 和非正价前提）处理
	 */
	handleVipBirDis:function(item){
		var content=this.vip.vipdis.EXECONTENT;
		if(item.type==1&&item.priceactual>content&&item.qty>0&&this.vip.vipdis.LIMITTYPE==1){		
			var remqty=this.getVipDisRemQty();
			if(remqty<item.qty){
					this.updateitems_data2(this.splitItem(item,remqty));
			}
			if(this.vip.vipdis.DISTYPE==1){//打折
				item.priceactual=this.alg((item.priceactual).mul(content));
			}else if(this.vip.vipdis.DISTYPE==3){//优惠
				item.priceactual=this.alg((item.priceactual).sub(content));
			}
			item.discount=this.alg((item.priceactual).div(item.pricelist));
			item.price=this.alg((item.qty).mul(item.priceactual));
			this.vip.vipdis.USEQTY=this.vip.vipdis.USEQTY+item.qty;
			item.vipbirdisid=this.vip.vipdis.ID;
			//alert(Object.toJSON(this.vip.vipdis));
			//alert(Object.toJSON(item));
		}
	},
	
	/**
	 *edit by robin 20121121 增加对VIP生日当日和当月活动执行的流程
	 *Edit by Robin 20100721
	 *转化server返回的商品信息的JSON为特定结构的JSON对象item
	 *@param :ret server返回JSON
	 *@param :haslineno 是否返回时就带有Lineno 这个在如总单策略返回值时很重要，
	 *因为一般都是自增lineno，而总单策略之类返回的一定要是原有的lineno不能自增
	 * 注意：item.lineno（行号）需要更新
	 */
	changeret2item:function(ret,haslineno){
		var item={};
		item.productno=ret.m_retail_productno;
		item.productname=ret.m_retail_productname;
		item.colorname=ret.m_retail_colorname;
		item.sizename=ret.m_retail_sizename;
		item.color=ret.m_retail_color;
		item.size=ret.m_retail_size;
		item.mdim11=ret.m_retail_mdim11;
		item.productvalue=ret.m_retail_productvalue;
		item.pricelist=isNaN(parseFloat(ret.m_retail_pricelist))?0.00:parseFloat(ret.m_retail_pricelist);
		item.discount=isNaN(parseFloat(ret.m_retail_discount))?0.00:parseFloat(ret.m_retail_discount);
		item.discription=ret.m_retail_discription;
		item.priceactual=isNaN(parseFloat(ret.m_retail_priceactual))?0.00:parseFloat(ret.m_retail_priceactual);
		item.priceactual=this.alg(item.priceactual);
		item.qty=isNaN(parseInt(ret.m_retail_qty,10))?0:parseInt(ret.m_retail_qty,10);
		item.price=isNaN(parseFloat(ret.m_retail_price))?0.00:parseFloat(ret.m_retail_price);
		item.price=this.alg(item.price);
		item.salerid=this.master_data.saler.id;
		item.saler=this.master_data.saler.name;
		item.multisalers=this.master_data.multisalers||[];
		item.type=ret.m_retail_type;
		item.orgdocno=ret.m_retail_orgdocno;
		item.pda_id=parseInt(ret.m_pda_id,10);
		//20110414增加 原单的付款方式 和 数量 列为了控制退货数量不能大于原单数量 和 付款方式 （控制付款方式的前提是金额为负）
		item.org_payways=ret.org_payways||-1;
		item.org_qty=ret.org_qty?parseInt(ret.org_qty,10):0;
		//20110831 add by robin 新增
		item.org_payamounts=ret.org_payamounts||-1;
		item.org_billdate=ret.org_billdate||-1;
		item.sysdate=ret.sysdate||-1;
		item.org_docno=ret.orgdocno||-1;
		item.lowest_discount=(ret.lowest_discount)?parseFloat(ret.lowest_discount):0;
		item.m_dim1=ret.m_dim1?ret.m_dim1:"";
		item.m_dim2=ret.m_dim2?ret.m_dim2:"";
		item.m_dim3=ret.m_dim3?ret.m_dim3:"";
		item.m_dim4=ret.m_dim4?ret.m_dim4:"";
		item.m_dim5=ret.m_dim5?ret.m_dim5:"";
		item.m_dim6=ret.m_dim6?ret.m_dim6:"";
		item.m_dim7=ret.m_dim7?ret.m_dim7:"";
		item.m_dim8=ret.m_dim8?ret.m_dim8:"";
		item.m_dim9=ret.m_dim9?ret.m_dim9:"";
		item.m_dim10=ret.m_dim10?ret.m_dim10:"";
		item.m_dim11=ret.m_dim11?ret.m_dim11:"";
		item.m_dim12=ret.m_dim12?ret.m_dim12:"";
		item.m_dim13=ret.m_dim13?ret.m_dim13:"";
		item.m_dim14=ret.m_dim14?ret.m_dim14:"";
		item.m_dim15=ret.m_dim15?ret.m_dim15:"";
		item.m_dim16=ret.m_dim16?ret.m_dim16:"";
		item.m_dim17=ret.m_dim17?ret.m_dim17:"";
		item.m_dim18=ret.m_dim18?ret.m_dim18:"";
		item.m_dim19=ret.m_dim19?ret.m_dim19:"";
		item.m_dim20=ret.m_dim20?ret.m_dim20:"";
		
		item.vipbirdis=ret.vipbirdis||false;
		//????
		var canDoVipBirDis=true;
		if(haslineno&&ret.lineid!=-1){		
			item.lineno=ret.lineid;
			var item2=this.getitembylinenofromitems_data(item.lineno);
			item.saler=item2.saler;
			item.salerid=item2.salerid;
			item.markbaltype=item2.markbaltype;
			item.sin_disid=item2.sin_disid;
			item.sin_disname=item2.sin_disname;
			item.com_disid=item2.com_disid;
			item.com_disname=item2.com_disname;
			item.add_disid=item2.add_disid;
			item.add_disname=item2.add_disname;
			item.multisalers=item2.multisalers;
			item.vipbirdis=item2.vipbirdis;
			item.vipbirdisid=item2.vipbirdisid;
			canDoVipBirDis=false;
		}else{
			item.lineno=-1;
			//20110413新增 明细中增加 商场结算类型
			item.markbaltype=-1;
			//20110719元素中增加节点sin_disid,sin_disname(单品策略ID，NAME)、com_disid,com_disname(组合策略ID，NAME)、add_disid,add_disname(补充策略ID，NAME)
			item.sin_disid=parseInt(ret.sin_disid,10)||-1;
			item.sin_disname=ret.sin_disname||-1;
			item.com_disid=parseInt(ret.com_disid,10)||-1;
			item.com_disname=ret.com_disname||-1;
			item.add_disid=parseInt(ret.add_disid,10)||-1;
			item.add_disname=ret.add_disname||-1;
		}
		item.locked=ret.locked?parseInt(ret.locked,10):0;
		if(item.vipbirdis&&canDoVipBirDis){
			this.handleVipBirDis(item);
		}
		//alert(Object.toJSON(item));
		return item;
		
	},
	/**
	 *提供字段，得到items_data中改字段最小值的item
	 *@param ：colname 字段名（注意：必须为数字类型的）
	 *@return 字段最小值item
	 */
	getminvalueitem:function(colname){
		var minitem={};
		var min;
		for(var i=0;i<this.items_data.length;i++){
			if(i==0){
				minitem=this.items_data[i];
			  min=this.items_data[i][colname];
			}else{
				if(min>=this.items_data[i][colname]){
					 min=this.items_data[i][colname];
					 minitem=this.items_data[i];
				}
			}
		}
		return minitem;
	},
	getDateRangeStrArray:function(st,end){
		var td=new Date();
		this.nowDate=this.formatDate(td);
		this.selectDate=this.nowDate;
		var str="";
		for(var k=st;k<=end;k++){
			var td1=new Date();
			td1.setDate(td.getDate()+k);
  		var tds1=this.formatDate(td1);
  		str+="<option "+((tds1==this.nowDate)?"selected=\"selected\"":"")+" value=\""+tds1+"\">"+tds1+"</option>"
		}
		return str;
	},
	formatDate:function(t){
		var y=t.getYear();
		var m=this.change2TwoD(t.getMonth()+1);
		var d=this.change2TwoD(t.getDate());
		return y+""+m+d;
	},
	change2TwoD:function(num){
		var r=num;
		if(num<10){
			r="0"+num;
		}
		return r;
	},
	/**
	 * edit by robin 20120504 增加店仓的 经销商name ,城市name,是否 直营 Y|N
	 * Edit by Robin 20100720
	 * 初始化this.master_data
	 *@param: ret server返回的JSON
	 */
	updatemasterdata:function(ret){
		//alert(Object.toJSON(ret));
		this.master_data.docno=ret.docno;
		this.master_data.c_store_id=ret.c_store_id;
		this.master_data.c_store_name=ret.c_store_name;
		this.master_data.storecode=ret.c_store_code;
		this.master_data.market=ret.market||"";
		this.master_data.customer=ret.customer||"";
		this.master_data.city=ret.city||"";
		this.master_data.directstore=ret.directstore||"YN";
		this.master_data.c_pricearea_id=ret.c_store_priceareaid||-1;
		this.master_data.calculation=ret.calculation;
		this.master_data.discountlimit=ret.discountlimit;
		//Add by Robin 20110222店仓执行语句,零售单保存时限(默认为2)
		this.master_data.execSql=ret.c_store_sql||"";
		this.master_data.orderLimitDate=(ret.orderlimitdate||ret.orderlimitdate==0)?ret.orderlimitdate:7;
		this.master_data.comptype=parseInt(ret.comptype,10)||0;
		//Add  by zxz 20120528增加零售单类型和值
	  this.master_data.retail_value=ret.RETAIL_VALUE||"";
		this.master_data.retail_type=ret.RETAIL_TYPE||"";
		
		var salers=new Array();
		var ss={};
		ss.id=-1;
		ss.name="-";
		ss.truename="-";
		ss.passwordhash="-";
		salers.push(ss);
		for(var i=0;i<ret.emp_ids.length;i++){
			var s={};
			s.id=ret.emp_ids[i];
			s.name=ret.emp_names[i];
			s.truename=ret.emp_truenames[i];
			//s.discountlmt=ret.discountlimit;
			s.passwordhash="";
			salers.push(s);
		}
		this.master_data.salers=salers;
		var payways=new Array();
		for(var j=0;j<ret.pids.length;j++){
			var p={};
			p.id=ret.pids[j];
			p.name=ret.pnames[j];
			p.iscash=ret.iscashs[j];
			p.ischarge=ret.ischarges[j];
			p.iscashcard=ret.iscashcards[j];
			p.isticket=ret.istickets[j];
			p.is_vou=ret.is_vou[j];//是否购物券
			//Add by robin 20110531是否消费卡
			p.isconsumecard=ret.isconsumecards[j]||'N';
			payways.push(p);
		}
		var markbaltypes=new Array();
		if(ret.markdis_ids&&ret.markdis_ids.length>0){
			for(var k=0;k<ret.markdis_ids.length;k++){
				var markbaltype={};
				markbaltype.markdis_id=ret.markdis_ids[k];
				markbaltype.markbaltype_id=ret.markbaltype_ids[k];
				markbaltype.markbaltype_name=ret.markbaltype_names[k];
				markbaltype.markbaltype_description=ret.markbaltype_descriptions[k];
				markbaltypes.push(markbaltype);
			}
		}
		this.master_data.markbaltypes=markbaltypes;
		this.master_data.payways=payways;
		var operator={};
		operator.id=ret.emp_id;
		operator.name=ret.emp_name;
		operator.truename=ret.emp_truename;
		operator.discountlmt=ret.discountlimit;
		operator.email=ret.emp_email||"";
		operator.passwordhash=ret.emp_passwordhash||"";
		operator.isret=ret.isret||'Y';
		//新增webpos权限
		operator.webpos_per=ret.webpos_per!=0?(parseInt(ret.webpos_per,2)||this.CHANGEBILLDATE):0;
		this.master_data.saler={};	
		this.master_data.saler.id=-1;	
		this.master_data.saler.name="-";
		this.master_data.saler.truename="-";
		this.master_data.operator=operator;
		this.master_data.multisalers=new Array();
		//20100730新增 指标
		var target={};
		//lert(Object.toJSON(ret))
		target.daytarget=ret.day_range;//日指标
		target.monthtarget=ret.month_range;//月指标
		
		target.daycurrent=ret.day_currect;//日完成量
		target.monthcurrent=ret.month_currect;//月完成
		target.numcurrent=ret.num_current;//当天门店提交零售单数
		//alert(ret.vip_range+":"+ret.vip_current);//开卡指标
		target.vip_range=ret.vip_range;
		target.vip_current=ret.vip_current;
		this.master_data.target=target;
		
		
		//this.master_data.createTime=this.getformatcurrenttime();
		//this.master_data.canModify=1;
	//alert(Object.toJSON(this.master_data));
	},
	//20110609 add by robin WEBPOS登陆 绑定 离线查询VIP的库
	bindVipDB:function(){
		if(this.master_data.params.vipAreaRange>0&&!this.checkIsOnline())
		MainApp.bindVipDB();
	},
	//20110415 获取本地配置文件参数
	getConfig:function(){
		var param=MainApp.GetConfig();
		param=param.evalJSON();
		return param;
	}, 
	updateBilldateRange:function(){
		var ar=this.master_data.params.billdaterange.split(",");
		if(ar.length>1){
			jQuery("#sys_date").html(this.getDateRangeStrArray(parseInt(ar[0],10),parseInt(ar[1],10))).bind("change",function() {bpos.changeTimeValidate();});
		}else{
			var td=new Date();
			td=this.formatDate(td);
			jQuery("#sys_date").html("<option selected='true' value='"+td+"' >"+td+"</option>");
		}
	},
	//验证改变时间权限
	changeTimeValidate:function(nowTime,backid) {
		if((bpos.master_data.operator.webpos_per&bpos.CHANGEBILLDATE)==bpos.CHANGEBILLDATE&&!nowTime) {
			return;
		}else {
			if(nowTime){
				if(nowTime!=this.selectDate) {					
					jQuery("#sys_date option[text='"+this.selectDate+"']").attr("selected","true");
				}else {
					this.selectDate=jQuery("#sys_date").find("option:selected").text();
					if(backid&&this.offlineUserinfo&&backid==this.offlineUserinfo.ID)this.master_data.operator.webpos_per=bpos.CHANGEBILLDATE;
				}
			}else {
				bxl.validateEmployee("changeTime",true);
			}
		}	
	},
	loadMasterAction:function(){		
		this.updateBilldateRange();		
		this.initrefno();
		this.gethookcount();
		this.compelupdate();
		this.deleteOrders();
		this.executeSql();
		this.bindVipDB();//增加绑定VIP数据DB
		this.locationConfig=this.getConfig();
		if(this.master_data.params.canUseTicketWhenWholeDis=="true")
			this.canUseTicketWhenWholeDis=true;
		var ti=parseFloat(this.master_data.params.uploadTimeInterval);
		if(!isNaN(ti)&&ti>0){
			this.uploadOrderInterval(ti);
		}
		var statusConf=parseInt(this.master_data.params.statusConf,2);
		if((statusConf&8)!=8){
			this.types[0].active=0;
		}else{
			this.types[0].active=1;
		}
		if((statusConf&4)!=4){
			this.types[1].active=0;
		}else{
			this.types[1].active=1;
		}
		if((statusConf&2)!=2){
			this.types[2].active=0;
		}else{
			this.types[2].active=1;
		}
		if((statusConf&1)!=1){
			this.types[3].active=0;
		}else{
			this.types[3].active=1;
		}
		this.initItemsHeaderHtmlByParam();
		
		this.updateheaderhtml();
		this.ticketpayways=this.getticketpayway();
		this.cashcardpayways=this.getvipcardpayway();
		this.voupayways=this.getvoupayway();
		if(!this.voupayways)this.voupayways=[];
		this.consumecardpayways=this.getconsumecardpayway();
		
		this.isOnLoad=false;
		this.CacheData(this.master_data.c_store_id);
	},
	initMasterHtml:function(){
		
		//增加参数判断要不要显示当前指标完成量by add zxz at 120612
		if(this.master_data.params.showFinishedTarget&&this.master_data.params.showFinishedTarget.strip().toLowerCase()=="false"){			 
			 jQuery(".idTarget").hide();
			 jQuery("#daycurrent").hide();
			 jQuery("#monthcurrent").hide();
			 jQuery("#numcurrent").hide();
			 jQuery("#openVipCurrent").hide();
			 //alert(new Date().getYear()+"-"+(new Date().getMonth()+1)+"-"+new Date().getDate());			 
		}
		
		$("from_top_text").innerHTML=this.master_data.c_store_name+"";
		$("daycurrent").innerHTML=this.master_data.target.daycurrent+"";
		$("daytarget").innerHTML=this.master_data.target.daytarget+"";
		$("monthtarget").innerHTML=this.master_data.target.monthtarget+"";
		$("monthcurrent").innerHTML=this.master_data.target.monthcurrent+"";
		$("numcurrent").innerHTML=this.master_data.target.numcurrent+"";
		$("openVipCurrent").innerHTML=this.master_data.target.vip_current+"";
		$("openViptarget").innerHTML=this.master_data.target.vip_range+"";
		
		$("currentoperator").innerHTML=this.master_data.operator.name+"("+this.master_data.operator.truename+")";
		
		//写入零售单类型
		for(var kk=0;kk<this.master_data.retail_type.length;kk++ ){
			
      var opt = document.createElement('option');  
          opt.appendChild(document.createTextNode(this.master_data.retail_type[kk]));  
          opt.setAttribute("value",this.master_data.retail_value[kk]);
          if(this.master_data.retail_type[kk].strip()=="正常零售"){ 
          	opt.setAttribute("selected","true");
          }
            
          $("retailType").appendChild(opt);  
			this.rememberSelectedValue();
		}
		if(!this.checkButtonShowPer("UPLOAD"))$("uploadbutton").disabled=true;
		if(!this.checkButtonShowPer("SEARCH"))$("searchbutton").disabled=true;
		if(!this.checkButtonShowPer("SALER"))$("f3button").disabled=true;
		if(!this.checkButtonShowPer("PENDING"))$("f4button").disabled=true;
		if(!this.checkButtonShowPer("CHANGESTATE"))$("f6button").disabled=true;
		if(!this.checkButtonShowPer("CHANGENUM"))$("f7button").disabled=true;
		if(!this.checkButtonShowPer("CHANGEAMT"))$("f8button").disabled=true;
		if(!this.checkButtonShowPer("CHANGETOTAMT"))$("f9button").disabled=true;
		if(!this.checkButtonShowPer("BATCH"))$("f11button").disabled=true;
	},
	//add by 20120507 获取登陆服务器的URL地址。如果是离线登陆则取配置文件中的
	getServiceUrl:function(){
		return this.URL?this.URL.replace("bpos/",""):"http://"+window.location.host+"/";
	},
	//Add by Robin 20110222 当打开单据后的自动处理动作如：调用接口获得 单据号
	doSomeThingWhenLoadMaster:function(online){
		this.repairOfflineMaster(online);
		this.initMasterHtml();
		this.master_data.url=this.getServiceUrl();
		//alert(this.master_data.url);
		this.exportaxtivexparams(online);
		this.loadMasterAction();
		if(online){
			  this.queryNotice();
		}
		//setTimeout('bxl.checkServerTime();',10000);
	},
	queryNotice:function(){
	   	//第一次无论是否有紧急消息都显示
		    mc.load();
				bxl.newsQuery();
		    setInterval('bxl.newsQuery()',900000);
		},
	//修复离线时登录用户和记录用户不一致
	repairOfflineMaster:function(online) {
		if(!online){
			var operator={};
			operator.id=this.offlineUserinfo.ID;
			operator.name=this.offlineUserinfo.NAME;
			operator.truename=this.offlineUserinfo.TRUENAME;
			operator.email=this.offlineUserinfo.email;
			operator.passwordhash=this.offlineUserinfo.PASSWORD;
			operator.isret=this.offlineUserinfo.ISRET||'Y';
			operator.discountlmt=1;
			operator.webpos_per=0;
			this.master_data.operator=operator;
		}
		this.master_data.createTime=this.getformatcurrenttime();
		this.master_data.canModify=1;
	},
	/**
	 *自动上传程序
	 *param mins 上传间隔（单位 分钟）
	 */
	uploadOrderInterval:function(mins){
		//Edit by robin 20110906 修改上传流程。现新开进程自动上传
		this.AUTOUploadRetailProcess(mins,this.master_data.c_store_id,this.master_data.operator.id,"\""+this.getServiceUrl()+"\"");
		//this.objInterval=window.setInterval(function(){bpos.autoUploadOrder(mins)},mins*60*1000);
	},
	//ACTIVEX接口，自动上传进程,传入分钟
	AUTOUploadRetailProcess:function(mins,storeId,userId,surl){
		/*
		var param={};
		param.uploadTimeInterval=mins*60;
		param.storeId=storeId;
		param.userId=userId;
		param.url=surl;     
		var info={};                              
		info.param=param;
		*/
		var info="{\"param\":{\"uploadTimeInterval\":"+mins*60+",\"storeId\":"+storeId+",\"userId\":"+userId+",\"url\":'"+surl+"'}}";
		//alert(Object.toJSON(info));
		MainApp.UploadOrdersByFile(info);
	},
	checkHasUploadOrder:function(){
		var ret=this.queryOrderStateCount();
		ret=ret?(ret["0"]+ret["2"]):0;
		if(this.isUploading||ret<=0)return false;
		return true;
	},
	//ACTIVEX接口查询单据状态的统计情况,0未上传，1上传成功，2上传失败
	queryOrderStateCount:function(){
		var ret=MainApp.searchOrderNo();
		if(ret){
			ret=ret.evalJSON();
			ret["0"]=(ret["0"])?parseInt(ret["0"],10):0;
			ret["1"]=(ret["1"])?parseInt(ret["1"],10):0;
			ret["2"]=(ret["2"])?parseInt(ret["2"],10):0;
		}
		return ret;
	},
	actionsWhenUnload:function() {
		var ret = this.queryOrderStateCount();
		return ret?(ret["0"]+ret["2"]):0;
	},
	//单据未保存，提示是否注销
	sava:function(){
		var ret = this.actionsWhenUnload();
		if(ret>0) {
			if(!confirm("您还有"+ret+"张单据未成功上传，确认要注销吗？")){
		   		return;
		  }
		} 
		if(bpos.items_data.length>0){
		   if(!confirm("您还有单据未保存，确定要注销吗？")){
		   		return;
		  	}
		}
		location.href="/bpos/login.jsp";	
	},
	autoUploadOrder:function(mins){
		$("uploadbutton").disabled=true;
		if(this.checkHasUploadOrder()){
			this.isUploading=true;
			jc.popUpEffectLikeMsn($('eMeng'));
			jQuery("#tipMsgHead").html("正在上传数据....");
			jQuery("#tipMsgBody").html("上传间隔&nbsp;&nbsp;<font color=#FF0000>"+mins+"</font>&nbsp;&nbsp;分钟");
			var ret={};
			try{
				ret=MainApp.AutoUploadOrder2(this.getServiceUrl());
				ret=ret.evalJSON();
			}catch(e){}
			if(ret){
				jQuery("#tipMsgHead").html("上传完成！");
				jQuery("#tipMsgBody").html("成功：<font color=#FF0000>"+(ret.isSuccess||0)+"</font>条；失败：<font color=#FF0000>"+(ret.isLosing||0)+"</font>条");
			}
			this.isUploading=false;
			//window.clearInterval(this.objInterval);
			window.setTimeout(function(){jc.hideElementAndClearInterval($('eMeng'));},6000);
		}
		jQuery("#uploadbutton").removeAttr("disabled");
	},
	
	//ACTIVEX接口 删除dataCount天前的所有已上传单据
	deleteOrders:function(dateCount){

			var info={};
			var param={};
			param.orderLimitDate=this.master_data.orderLimitDate;
			info.param=param;
			MainApp.deleteOrders(Object.toJSON(info));

	},
	//ACTIVEX接口 执行 服务器返回的SQL语句
	executeSql:function(sql){
		if(jQuery.trim(this.master_data.execSql)!=""){
			var info={};
			var param={};
			param.sql=this.master_data.execSql;
			info.param=param;
			MainApp.ExecuteSql(Object.toJSON(info));
		}
	},
	//20110514获取登陆信息 如：店仓、用户、密码等
	getLoadInfo:function(){
		var lc=(window.location).toString();
		lc=lc.substr((lc.indexOf("?")+1));
		var ina=lc.split("&");
		var info={};
		for(var i=0;i<ina.length;i++){
			if(ina[i].indexOf("storeid=")!=-1){
				info.storeId=ina[i].replace("storeid=","");
			}
			if(ina[i].indexOf("storename=")!=-1){
				info.storeName=ina[i].replace("storename=","");
			}
			if(ina[i].indexOf("storecode=")!=-1){
				info.storeCode=ina[i].replace("storecode=","");
			}
			if(ina[i].indexOf("email=")!=-1){
				info.email=ina[i].replace("email=","");
			}
			if(ina[i].indexOf("md5=")!=-1){
				info.MD5=ina[i].replace("md5=","");
			}
			if(ina[i].indexOf("mins=")!=-1){
				info.mins=ina[i].replace("mins=","");
			}
		}
		return info;
	},
	
	//验证用户权限
	validateUser:function(storeid,mins,email,md5){
		var d=new Date();
		var mins2=getMins(d);
		if((mins2>mins)||mins2<mins-3){
			alert("会话过期!");
			return false;
		}
		//离线用户信息
		this.offlineUserinfo=getUserInfoByStoreIdAndEmail(storeid,email);
		this.offlineUserinfo.storeid=storeid;
		this.offlineUserinfo.email=email;
		var pw=this.offlineUserinfo.PASSWORD;
		if(!pw){
			alert("没有选择店仓或登陆用户!");
			return false;
		}
		var md52=generateMd5(d.getDate(),mins,storeid,email,pw);
		if(md52==md5)return true;
		alert("错误：验证失败！请确认店仓、用户、密码是否正确");
		return false;
	},
	getLocalMasterObjectOnOffline:function(storeId){

		try{
			var info=MainApp.GetHiddenConfigFile(storeId);
			info=info.evalJSON();
			this.master_data=info.param;
			return true;
		}catch(e){
			alert("错误：获取店仓信息失败，使用离线前必须在线登陆一次！");
			return false;
		}
	},
	//20110514离线登陆时 调用loadMaster
	_onLoadMasterObjectForOffline:function(){
		var loadInfo=this.getLoadInfo();
		var storeId=loadInfo.storeId;
		var storeName=loadInfo.storeName;
		if(!this.validateUser(storeId,loadInfo.mins,loadInfo.email,loadInfo.MD5))return;
		if(!this.getLocalMasterObjectOnOffline("storeId"+storeId))return;
		this.doSomeThingWhenLoadMaster(false);
	},
   _onloadMasterObject:function(e){
		var data=e.getUserData();
		var ret=data.jsonResult.evalJSON();
		//alert(Object.toJSON(ret));
		
		this.updatemasterdata(ret);
		
		if(this.offline==true&&isIE()){
			this.doSomeThingWhenLoadMaster(true);
		}
		//alert(Object.toJSON(this.master_data));
	},
	//根据参数 compelupdate 判断是否在登陆时更新
	compelupdate:function(){
		try{
			if(this.offline==true&&isIE()){
				if(this.master_data.params.PrintTemplates){
					var info={};
					var a=this.master_data.params.PrintTemplates.split(",");
					info.params={"files":a[0],"pos":a[1]};
					MainApp.DownFile(Object.toJSON(info));
				}
				if(this.master_data.params.compelupdate=="true"){
					MainApp.Login();
				}
			}
		}catch(e){
			alert("系统参数 webpos.PrintTemplates设置不正确，请联系管理员！");
		}
	},
	uploadOrder:function(){
		if(this.offline==true&&isIE()){
			MainApp.uploadOrder("http://"+window.location.host+"/");
		}
	},
  nosalererror:function(){
  	//alert(this.master_data.params.requiredSaler+"-1");
   //	alert(this.master_data.params.requiredSaler+"-2");
   //	alert(this.master_data.saler.id+"-3");
  	//alert(Object.toJSON(this.master_data.multisalers));  
  	if(!this.master_data.multisalers) this.master_data.multisalers=[];
  	//alert(Object.toJSON(this.master_data.saler));
  	//alert(this.master_data.params.requiredSaler&&this.master_data.params.requiredSaler=="true"&&this.master_data.saler.id==-1&&this.master_data.multisalers.length==0);
  	
  	if(this.master_data.params.requiredSaler&&this.master_data.params.requiredSaler=="true"&&this.master_data.saler.id==-1&&this.master_data.multisalers.length==0){
  		
  		bxl.sales();
  		
  		return true;
  	}
  	return false;
  },
	insertLine:function(){
		if((this.MODEL&this.INSERTLINE)!=this.INSERTLINE){
			alert("该单据不可新增行！");
			return;
		};
		if(this.nosalererror()){
			return;
		}
		if(this.itemtype==2){	
		//	alert(bpos. master_data.operator.isret+",,,,,");
			//alert(bpos. master_data.operator.isret);
			if(bpos.master_data.operator.isret=="N"){
				bxl.validateEmployee("Q");
			}else{
				this._editretailno();
			}
		}else{
			var m_retail_productno=$("m_retail_idx").value.strip().toUpperCase();
			if(!m_retail_productno){
				this.selectFirstType();
				return;
			}
			
			var m_retail_type=this.itemtype+"";
			var m_retail_qty =1;	
			var sys_date=$("sys_date").value;	
			//alert(Object.toJSON(this.vip));
			this.insertline_action("BPOS_INSERT_LINE",m_retail_productno,m_retail_qty,m_retail_type,"","","");		
	  }
	},
	//20110411 获得切换类型的第一个可用的类型，一般情况下第一个应该是现金
	getFirstIndexActiveType:function(){
		for(var i=0;i<this.types.length;i++){
			if(this.types[i].active==1)return i;
		}
	},
	/**
	 *Edit by Robin 20100727
	 *格式化数字，保留两位小数
	 *@param ：v 传入的数字，必须全是数字字符
	 *@return：保留两位数的浮点数 的字符串
	 */
	formatint2float:function(v){
		//v=this.alg(v);
		var nums=new String(v);
		if(nums.lastIndexOf (".")>0)
			nums+="00";
		else
			nums+=".00";
		return nums.substring(0,nums.lastIndexOf (".")+3);
	},
	/**
	 *Add by Robin 20110218
	 *合并相同的行，防止相同商品过多导致明细太长(主要给打印小票造成麻烦)
	 *orgitem :原 明细
	 *item:新明细
	 */
	mergeSameItem:function(orgitem,item){
		//alert("asfdgadsgfgagggggg");
		orgitem.qty=orgitem.qty.add(item.qty);
		orgitem.price=orgitem.price.add(item.price);
		this.updateline(orgitem.lineno,orgitem);
	},
	/**
	 *将item更新到this.items_data中
	 *2010-8-19修改：扫描条码只做增加，不做修改
	 *@param :item 传入item，结构必须正确
	 */
	updateitems_data2:function(item){
		if(null==item)return;
		var orgitem=this.checkisexistinitemsdata(item);
		if(orgitem!=-1){
			this.mergeSameItem(orgitem,item);
		}else{
			this.additem2items_data(item);
		}
	  this.updatehtml();
	},
	//Edit by Robin 20100824 只更新数据不画页面
	updateretdata2items_data:function(ret,items){
		if(!items)items=this.items_data;
		var item =this.changeret2item(ret,true);
		this.items_datapushitem(item,items);
	},
	/**
	 * 与server交互得到数据后更新this.items_data；
	 * @param ：ret SERVER返回的JSON
	 */
	updateitems_data:function(ret){
		//alert(Object.toJSON(ret));
		var item =this.changeret2item(ret);		
		this.updateitems_data2(item);
		//this.updatehtml();
		//this.playscanSound();
	},
	/**
	 *合计明细；包括数量，原价合计，销售价合计
	 *@注意：计算金额的时候 总金额price不一定等于单价乘以数量 如 总单策略时 优惠 情况会遇到 除不尽。。
	 *这里的处理办法是 取 单价乘数量的总和 和 没行商品的 price总和做比较  取较大值 20110413
	 *20110414 修改 取最大值 会出错误 改成 合计price
	 *@param column 新增参数，用于计算特定的字段（items） 的合计。 包含： 'commonqty' 正常零售类型数量,'qty' 所有类型数量,'commonprice' 正常零售类型价格,'price'全部零售价格,'commonpricelist','pricelist'
	 *@return :JSON对象如{totqty:12,totprice:123.22,totpricelist:222.22}
	 */
	gettotdata:function(items,column){
		if(!items)items=this.items_data;
		var tot={};		
		var totcommonqty=0;
		var totqty=0;
		var totcommonpricelist=0;
		var totpricelist=0;
		var totcommonprice=0;
		var totprice=0;
		//var totprice1=0;
		for(var i=0;i<items.length;i++){
			if(column){
				switch(column){
					case 'commonqty':if(this.value2type(items[i].type)=='正常')totcommonqty+=items[i].qty; break;
					case 'qty':totqty+=items[i].qty; break;
					case 'commonprice':if(this.value2type(items[i].type)=='正常')totcommonprice=totcommonprice.add(items[i].price);break;
					case 'price':totprice=totprice.add(items[i].price);break;
					case 'commonpricelist':if(this.value2type(items[i].type)=='正常')totcommonpricelist=totcommonpricelist.add((items[i].qty).mul(items[i].pricelist));break;
					case 'pricelist':totpricelist=totpricelist.add((items[i].qty).mul(items[i].pricelist));break;
				}	
			}else{
				totqty+=items[i].qty;
			
				totprice=totprice.add(items[i].price);
			
				totpricelist=totpricelist.add((items[i].qty).mul(items[i].pricelist));
				if(this.value2type(items[i].type)=='正常'){
					totcommonqty+=items[i].qty;
					totcommonprice=totcommonprice.add(items[i].price);
					totcommonpricelist=totcommonpricelist.add((items[i].qty).mul(items[i].pricelist));
				}
			}
		}
		tot.totqty=totqty;
		//tot.totprice=totprice>totprice1?totprice:totprice1;
		tot.totprice=totprice;
		tot.totpricelist=totpricelist;
		tot.totcommonqty=totcommonqty;
		tot.totcommonprice=totcommonprice;
		tot.totcommonpricelist=totcommonpricelist;
		return tot;
	},
	//2011 01 12 add by Robin支持款号 模式
	pdtStyleModel:function(style){
			var s1=jQuery.trim(style).split(" ");
			var s2=[];
			for(var i=0;i<s1.length;i++) {
				if(jQuery.trim(s1[i])!="")s2.push(s1[i].toUpperCase());
			}	
			//if(s2[0].length<5){alert("款号至少输入5位");return;}		
			if(s2[1]=='*')s2[1]=0;
			if(s2[2]=='*')s2[2]=0;	
			var param={"m_pdt":s2[0],"m_col":s2[1]?s2[1]:"","m_size":s2[2]?s2[2]:""};
			var info={};
			info.param=param;
			var ret=this.getskus(Object.toJSON(info));
			ret=ret.evalJSON();
			if(ret!=null&&ret.NewDataSet&&ret.NewDataSet.Table){
					ret=ret.NewDataSet.Table;
				//bxl.insertnum();//画界面
				//bxl.searchaction(ret);//插入数据
					bxl.matrixInsertnum();
					bxl.matrixStyle(ret,$("colorShow").value,$("sizeShow").value,true);
			}else{
				var m_retail_idx=$("m_retail_idx");
				
				if(this.master_data.params.onLineSkuMatche=='true'&&this.checkIsOnline()){
					jQuery.ajax({
						type:"POST",
						url:this.URL+"getMatchedSku.jsp",
						data:"si="+m_retail_idx.value,
						async:false,
						error:function(){
							alert("网络不畅,请稍后再试！");
						},
						success:function(data){
							data=jQuery.trim(data);
							var jn=data.evalJSON();
							if(jn.code<0){
								alert(jn.msg);
							}else if(jn.code==0){
								m_retail_idx.value=jn.msg;
								bpos.insertLine();
							}else if(jn.code==1){
								m_retail_idx.value="";
								bpos.selectFirstType();
							}
						}
					});
				}else{
					m_retail_idx.value="";
					this.selectFirstType();
				}
				m_retail_idx.focus();
			}
	},
	//选择第一个可用 切换状态
	selectFirstType:function(){
		var findex=this.getFirstIndexActiveType();
		if(findex||findex==0)
		this.changeretailtypeforspec(this.types[findex].value);
	},
	/*
	 *add by robin 20121121 对VIP生日当月 当日活动针对正价前提、是限制件数的情况下所做的特殊处理
	 *此为步骤1：还原类型，标志本行需要执行活动优惠
	 *@param recodeType:原类型
	 *@param ret:返回的单个行明细
	 */
	vipBirDisChain1:function(ret,recodeType){
		if(recodeType&&ret.m_retail_type==4)
		ret.m_retail_type=recodeType;
	  ret.vipbirdis=true;
	},
	/**
	 *add by robin 20121121 对VIP当日当月活动中的非正价前提且限制购买"件数"的
	 *需要在执行策略后需要提示是否执行优惠活动
	 */
	checkNeedDoVipBirDisWithNotFullPrice:function(ret){
		var cci=false;
		//alert(Object.toJSON(ret));
		if(ret.NewDataSet&&ret.NewDataSet.Table){
			for(var i=0;i<ret.NewDataSet.Table.length;i++){
				var d=ret.NewDataSet.Table[i];
				if(d.m_retail_type==1&&d.m_retail_price>0)cci=true;
			}
		}else{
			if(ret.m_retail_type==1&&ret.m_retail_price>0)cci=true;
		}
		if(!cci)return false;
		var remqty=this.getVipDisRemQty();
		if(this.vip&&this.vip.vipdis&&this.vip.vipdis.ISFULLPRICE=='N'&&this.vip.vipdis.LIMITTYPE==1&&remqty>0){
			if(confirm("您还剩余"+remqty+"件商品使用["+this.vip.vipdis.NAME+"]活动机会,是否使用？")) return true;
		}
		return false;
	},
	/*
	 *edit by robin 20121119 增加参数 recodeType
	 *为了满足VIP当日当月消费活动的特殊情况：当活动需要正价前提且控制单件的而不是整单的时候，需要用“全额”方式传到activex控件执行
	 *目的是为了不让执行其他的策略；这种情况必须在获得结果后把 类型“返回”到原来的类型。
	 */
	insertlineaction:function(ret,recodeType){
		
		if(ret.code&&ret.code==-1){
			if(this.master_data.params.pdtStyleModel&&this.master_data.params.pdtStyleModel=="true"){
				this.pdtStyleModel(jQuery.trim($("m_retail_idx").value));
			}else{
				$("m_retail_idx").value="";
				var m_retail_idx=$("m_retail_idx");
				m_retail_idx.focus();
				this.selectFirstType();
			}
			return;
		}
		var needVipBirDis=this.checkNeedDoVipBirDisWithNotFullPrice(ret);
		if(ret.NewDataSet&&ret.NewDataSet.Table){
			for(var i=0;i<ret.NewDataSet.Table.length;i++){
				var d=ret.NewDataSet.Table[i];
				if(recodeType||needVipBirDis){
					this.vipBirDisChain1(d,recodeType);
				}
				this.updateitems_data(d);
			}
		}else if(ret){
			if(recodeType||needVipBirDis){
					this.vipBirDisChain1(ret,recodeType);
				}
			this.updateitems_data(ret);
		}
		this.selectFirstType();
		$("m_retail_idx").value="";
		var m_retail_idx=$("m_retail_idx");
		m_retail_idx.focus();
	},
	_onInsertLine:function(e){
		var data=e.getUserData();
		var ret=data.jsonResult.evalJSON();
		//alert(Object.toJSON(ret));
		this.insertlineaction(ret);
	},	
	//监听修被修改的零售单类型
	rememberSelectedValue:function(){
		//alert($("retailType").value);
		this.master_data.remember_retail_value=$("retailType").value.strip();
		//alert(this.master_data.remember_retail_value);
	},
	
	_executeCommandEvent :function (evt){
		Controller.handle( Object.toJSON(evt), function(r){
				//try{
					var result= r.evalJSON();
					if (result.code !=0 ){
						alert(result.message);
						if($("next")&&$("next").disabled==true){
							jQuery("#next,#re,#cancle").removeAttr("disabled");
						}
						if(result.message=='无权限'){
							window.close();
						}
					}else {
						var evt=new BiEvent(result.callbackEvent);						 
						evt.setUserData(result.data);
						application.dispatchEvent(evt);
				  }
		});
	},
	loadVip:function(json){
		return MainApp.loadVip(json);
	},
//查询VIP 问题
	checkvip:function(type,pvalue){
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_CHECKVIP";
		var param={"ptype":type,"pvalue":pvalue,"storeid":this.master_data.c_store_id};
		if(!this.checkIsOnline()){
			if(this.master_data.params.vipAreaRange>0){
				if(type.length>1){
					var pa=new Array();
					for(var i=0;i<type.length;i++){
						var a={};
						a.ptype=type[i];
						a.pvalue=pvalue[i];
						a.storeid=this.master_data.c_store_id;
						pa.push(a);
					}
					param=pa;
				}
				var info={};
				var tparam={};
				tparam.Table=param;
				info.param=tparam;
				var ret=this.loadVip(Object.toJSON(info));
				ret=ret.evalJSON();
				if(ret.NewDataSet&&ret.NewDataSet.Table){
					ret=ret.NewDataSet.Table;
					ret=this.change2array(ret);
					this._oncheck(ret,true);
				}else{
					alert("未查询到符合的VIP！");
				}
			}else{
				alert("离线状态，无法使用VIP！");
			}
			return;
		}
		evt.param=Object.toJSON(param);
		//alert(evt.param);
		evt.table="m_retail";
		evt.action="load_vip";
		evt.permission="r";
		this._executeCommandEvent(evt);
	},
	/**
	 * Edit by Robin 20100722
	 * VIP查询界面的数据更新显示
	 */
	updatevipinfohtml:function(tempvip){//alert(Object.toJSON(tempvip));
		//if($("vip"))$("vip").value=tempvip.cardno;
		if($("c_viptype"))$("c_viptype").innerHTML=tempvip.c_viptype; 
		if($("vipname"))$("vipname").innerHTML=tempvip.vipname;
		if($("birthday"))$("birthday").innerHTML=(tempvip.birthday==null?"":tempvip.birthday);
		if($("vipename"))$("vipename").innerHTML=tempvip.vipename;	
		if($("sex"))$("sex").innerHTML=tempvip.sex;	
		if($("idno"))$("idno").innerHTML=hidePartOfWord(tempvip.idno,5,14);	
		if($("validdate"))$("validdate").innerHTML=tempvip.validdate;
		if($("lastconsumption"))$("lastconsumption").innerHTML=tempvip.lastconsumption;
		if($("integral"))$("integral").innerHTML=tempvip.integrals;
		if($("tot_amt_actual"))$("tot_amt_actual").innerHTML=tempvip.tot_amt_actuals;
		if($("telephone"))$("telephone").innerHTML=hidePartOfWord(tempvip.mobil,4,3)||"";
		if($("toDealer")) $("toDealer").innerHTML=tempvip.customer||"";
		if($("toStore")) $("toStore").innerHTML=tempvip.store||"";
		
		//this.updateheaderhtml();
	},
	//当临时选着某一个VIP信息时
	docheckvip:function(ret){
		this.tempvip=this.changeret2vip(ret);
		//alert(Object.toJSON(this.tempvip));
		//alert(this.tempvip.cardno);
	  this.hy_cardno=this.tempvip.cardno;
		this.updatevipinfohtml(this.tempvip);
	  //$("retailadd").disabled=false;
	  /*
	  if(ret.V_CHANGING&&ret.V_CHANGING==1){
		  $("retailupdate").disabled=true;
		}else{
			$("retailupdate").disabled=false;
		}
		*/
		if(ret.V_CHANGING&&ret.V_CHANGING==1){
		  alert("该会员已升级请换卡");
		  $("ok").disabled=true;
		}else{
			$("ok").disabled=false;
		}
		if($("retailupdate"))
		$("retailupdate").disabled=false;
		if($("retailchange"))
	  $("retailchange").disabled=false;
	},
	//当正式选着VIP信息时
	doselectvip:function(){
		this.vip=this.tempvip;
		this.refreshVipDisIntl(this.vip);
		this.tempvip=null;
		this.updateheaderhtml();
		var info={};
		this.vip.insertSql="insert into C_VIPTYPE(ID,AD_CLIENT_ID,ISACTIVE) values("+this.vip.c_viptype_id+", 37, 'Y');"+
											"insert into c_vip(id, ad_client_id, ISACTIVE, cardno, c_viptype_id, idno, vipname, vipename, sex, birthday, validdate, mobil, c_store_id, c_customer_id, c_customerup_id,"+
											"C_CITY_ID,C_OPENCARDTYPE_ID,ENTERDATE,STORECARDNO,DESCRIPTION,DESCRIPTION2,C_SERVICEAREA_ID,AGE,OPENCARDDATE)"+
											"  values("+this.vip.vip_id+", 37, 'Y', '"+this.vip.cardno+"', "+this.vip.c_viptype_id+", "
											+(this.vip.idno?"'"+this.vip.idno+"'":"null")+","
											+(this.vip.vipname?"'"+this.vip.vipname+"'":"null")+","
											+(this.vip.vipename?"'"+this.vip.vipename+"'":"null")+","
											+(this.vip.sex?"'"+this.vip.sex+"'":"null")+", "
											+(this.vip.birthday||"null")+", "
											+(this.vip.validdate||"null")+", "
											+(this.vip.mobil?"'"+this.vip.mobil+"'":"null")+", "
											+this.master_data.c_store_id+", "
											+(this.vip.c_customer_id||"null")+", "
											+(this.vip.c_customerup_id||"null")+","
											+(this.vip.c_city_id||"null")+","
											+(this.vip.c_opencardtype_id||"null")+","
											+(this.vip.enterdate||"null")+","
											+(this.vip.storecardno?"'"+this.vip.storecardno+"'":"null")+","
											+(this.vip.description?"'"+this.vip.description+"'":"null")+","
											+(this.vip.description2?"'"+this.vip.description2+"'":"null")+","
											+(this.vip.c_servicearea_id||"null")+","
											+(this.vip.age||"null")+","
											+(this.vip.opencarddate?this.vip.opencarddate:0)+");";
		this.vip.createTableSql="create table c_vip(ID int, AD_CLIENT_ID int, ISACTIVE text, CARDNO text,C_VIPTYPE_ID int, IDNO text,VIPNAME text, VIPENAME text, SEX text, BIRTHDAY int,VALIDDATE int,CREDITREMAIN text,COUNTRY text,C_CITY_ID int, C_OPENCARDTYPE_ID int,ADDRESS text,POST text, PHONE text,MOBIL text,EMAIL text, C_STORE_ID int,C_CUSTOMER_ID INT,"+
														" C_CUSTOMERUP_ID INT, INTEGRAL INT, PASS_WORD TEXT,ENTERDATE INT, VIPSTATE TEXT, BEST_TIME TEXT, BUILDING TEXT, SALER TEXT,STORECARDNO TEXT, OPENCARD_STATUS INT, OPENCARDERID INT, OPENCARDTIME INT,DESCRIPTION text,DESCRIPTION2 text,C_SERVICEAREA_ID int,AGE int,OPENCARDDATE int,HR_EMPLOYEE_ID int)";
		info.param=this.vip;
		this.setvip(Object.toJSON(info));
	},
	/**
	 *处理当多个VIP符合条件是情况
	 */
	handlermultivip:function(ret){
		//alert(Object.toJSON(ret));
		if(ret.length>1){
			jQuery("#showmultivip").css("display","");
			var str="";
			for(var i=0;i<ret.length;i++){
				str+="<div class=\"VIP-row\" id=\"VIP-row-"+i+"\">"+
							"<div class=\"VIP-row-line\">"+
							"<div class=\"VIP-span-1\">"+ret[i].VIPNAME+"</div><div class=\"VIP-span-2\">"+(ret[i].MOBIL||"无")+"</div><div class=\"VIP-span-4\">"+ret[i].CARDNO+"</div></div></div>";
			}
			jQuery("#VIP-main").html(str);
			jQuery("#VIP-main>div").bind("click",function(event){
				jQuery("#VIP-main>div").css("background-color","");
				jQuery(this).css("background-color","#75A9D6");
			});
			jQuery("#VIP-main>div").bind("dblclick",function(event){
					var index=parseInt(this.id.replace("VIP-row-",""));
					bpos.docheckvip(ret[index])
					//this.tempvip=bpos.changeret2vip(ret[index]);
					//bpos.updatevipinfohtml();
					event.stopPropagation();
			});
		}else{
			this.docheckvip(ret[0]);
			jQuery("#ok").focus();
		}
	},
	refreshVipDisIntl:function(vip){
		vip.isIntl=$("isIntl")?$("isIntl").value:'Y';
		vip.isDis=$("isDis")?$("isDis").value:'Y';
		if(vip.isDis=='N'){
			vip.discount=1;
			vip.vipexp=1;
		}
	},
	//ACTIVEX接口下载VIP数据包文件
	downloadVipDB:function(URL,fname){
		MainApp.downloadVipDB(URL,fname);
	},
	//20110609 add by robin 下载VIP数据，根据系统参数webpos.vipAreaRange
	downLoadVipDb:function(){
		jQuery("#downloadvip").attr("disabled","true");
		jQuery.ajax({
				type:"POST",
				url:this.URL+"generateVipDB.jsp",
				data:"si="+this.master_data.c_store_id,
				error:function(){
					alert("网络不畅,请稍后再试！");
					jQuery("#downloadvip").removeAttr("disabled");
				},
				success:function(data){
					jQuery("#downloadvip").removeAttr("disabled");
					data=jQuery.trim(data);
					if(data.indexOf("filename:")!=-1){
						var URL=bpos.getServiceUrl();
						var fname=data.replace("filename:","");
						bpos.downloadVipDB(URL,fname);
					}else{
						alert(data);
					}
				}
			});
	},
	/**
	 *服务器返回VIP信息转化为this.vip的固定格式
	 * 新增 mobil（手机号）
	 */
	changeret2vip:function(ret){
		var vip={};
		vip.vip_id=parseInt(ret.VIP_ID,10);
		vip.vipname=ret.VIPNAME||"";
		vip.vipename=ret.VIPENAME||"";
		vip.c_viptype=ret.R_VIPTYPE||"";
		vip.c_viptype_id=parseInt(ret.C_VIPTYPE_ID,10)||-1;
		vip.discount=ret.DISCOUNT||1;
		vip.idno=ret.IDNO||"";
		if(ret.SEX=='W'||ret.SEX=='M'){
			vip.sex=ret.SEX=='W'?'女':'男';
		}else{
			vip.sex=ret.SEX||"";
		}
		vip.mobil=ret.MOBIL||"";
		vip.birthday=ret.BIRTHDAY||"";
		vip.validdate=ret.VALIDDATE||"";
		vip.cardno=ret.CARDNO||"";
		vip.vipexp=ret.REDISCOUNT||1;
		vip.lastconsumption=ret.BILLDATE||"";
		vip.integral=ret.INTEGRAL||0;
		vip.integrals=isNaN(ret.INTEGRAL)?'-':ret.INTEGRAL;
		vip.tot_amt_actual=ret.TOT_AMT_ACTUAL||0;
		vip.tot_amt_actuals=isNaN(ret.TOT_AMT_ACTUAL)?'-':ret.TOT_AMT_ACTUAL;
		//Add by Robin 20110301 是否打折和积分 如果不可打折则将折扣置为1;是否充值卡
		vip.ifcharge=ret.IFCHARGE||'Y';
		// add by robin 20120505 增加 VIP开卡店仓 经销商 城市 是否直营店信息 补充。 注意这个在离线VIP中没有
		vip.city=ret.CITY||"";
		vip.customer=ret.CUSTOMER||"";
		vip.store=ret.STORE||"";
		vip.directstore=ret.DIRECTSTORE||"YN";
		vip.c_city_id=parseInt(ret.C_CITY_ID)||-1;
		vip.c_opencardtype_id=parseInt(ret.C_OPENCARDTYPE_ID,10)||-1;
		vip.enterdate=ret.ENTERDATE||-1;
		vip.storecardno=ret.STORECARDNO||" ";
		vip.description=ret.description||" ";
		vip.description2=ret.DESCRIPTION2||" ";
		vip.c_servicearea_id=parseInt(ret.C_SERVICEAREA_ID)||-1;
		vip.age=ret.AGE||-1;
		vip.opencarddate=ret.OPENCARDDATE||"";
		vip.c_customer_id=parseInt(ret.C_CUSTOMER_ID)||-1;
		vip.c_customerup_id=parseInt(ret.C_CUSTMOERUP_ID)||-1;
		vip.vipdis=ret.vipdis||{};
		vip.pass_word=ret.PASS_WORD||"";
		//alert($("isDis").value);
		this.refreshVipDisIntl(vip);
		return vip;
	},
	_oncheck:function(e,offline){   
		if(!offline){
			var data=e.getUserData(); // data
			var ret=data.jsonResult.evalJSON();
		}else{
			ret=e;
		}
		if(ret.length==0){
			alert("没有VIP符合条件！");
		}else{
			if(jQuery("#VIP-main:visible").length>0)jQuery("#VIP-main").html("");
			this.tempvip=null;
			this.handlermultivip(ret);
		}
	},
	/**
	 * 关闭弹出窗口，并使输入条码框得到焦点
	 *@param ：alertid 弹出框的ID
	 *@param : noResetRetailType 是否不重置零售类型
	 */
	killAlert:function(alertid,noResetRetailType){
		if(jQuery("#"+alertid).length==0)return;
		Alerts.killAlert($(alertid));
		this.noAlert=true;
		if(!noResetRetailType) this.selectFirstType();
	},
	killAlert2:function(alertid){
		jQuery("#MainApp").show();
		Alerts.killAlert($(alertid));
		this.noAlert=false;
		
	},
	/**
	 *add by robin 20130306 用于查询VIP，只需要获取cardno
	 */
	checkvip3:function(){
		if(!this.tempvip){
			return;
		}
		jQuery("#vipno").val(this.tempvip.cardno);
		this.tempvip=null;
		this.killAlert2("query-search-content");
	},
	checkvip2:function(){
		if(!this.tempvip){
			alert("没有VIP符合条件");
			return;
		}
		this.doselectvip();
		this.killAlert("query-search-content");
	},	
	closeEmployee:function(){
		this.killAlert("employee_content");
	},
	getEm:function(){
		this.master_data.saler.id=bxl.id;
	  this.master_data.saler.name=bxl.name;
	  //this.master_data.saler.truename=bxl.truename;
		this.updateheaderhtml();
		alert("切换营业员成功!");
	},
	tryClose:function(){
		this.killAlert("query-search-content");
	},
	tryClose_add:function(){
		this.killAlert("query-add-content");
		jQuery("#query-search-content").hidden=false;
		this.noAlert=false;
	},
	tryClose_update:function(){
		this.killAlert("query-update-content");
		jQuery("#query-search-content").hidden=false;
		this.noAlert=false;
	},
	tryClose_change:function(){
		this.killAlert("query-change-content");
		jQuery("#query-search-content").hidden=false;
		this.noAlert=false;
	},
	/**
	 *判断一个2进制数中某一位是否为1
	 *@param bin 2进制数
	 *@param bit 第几位。注意 bit 比实际位少1。从0开始的
	 */
	getbitinbinary:function(bin,bit){
		return (bin&(1<<bit))==(1<<bit); 
	},
	//VIP刷卡
	handleReadVip:function(){
		$("vip").value=bpos.readvip();
		this.combineConditionAndsearchVip();
	},
	//博士蛙定制VIP刷卡
	/*getVIPCardNoByTL:function(){
		$("vip").value=bpos.readvip();
		this.combineConditionAndsearchVip();
	},*/
	//奥康定制消费卡付款方式
	aokangSwipeConsumeCard:function(){
		$("ticketno").value=bpos.readvip();
		//....
	},
	executeLoadedScript:function(ele){
		executeLoadedScript(ele);
		jQuery("td.pop-up-close>a").remove();
	},

	combineConditionAndsearchVip:function(){
		var ptype=new Array();
		var pvalue=new Array();
		jQuery("#vip,#tele,#name,#vipidno").each(function(){	
			
			if(this.value&&jQuery.trim(this.value)!=""){
					var tp=this.id=='vipidno'?'idno':this.id;
					ptype.push(tp);
					pvalue.push(jQuery.trim(this.value));							

			}						
		});		
		if(ptype.length>0&&pvalue.length>0){
				bpos.checkvip(ptype,pvalue);
		}else{
				alert("请输入查询条件！");
		}
	},
	showvip:function(){
		if(this.items_data.length>0){}else{
			this.showvip_alert();	
		}
	},
	getVipType:function(tp){
		var viptypes=document.getElementById("vip_type").value;	
		var ret=viptypes.evalJSON();
		var types_sql="";
		if(tp=="add"){
			types_sql+="<select id=\"add_type\">";
		}else{
			types_sql+="<select id=\"update_type\">";
		}
		for(var i=0;i<ret.length;i++){
			types_sql+="<option value=\""+ret[i].typeid+"\">"+ret[i].typename+"</option>";
		}
		types_sql+="</select>";
		return types_sql;
	},
	//ADD BY Grace 20120129 增加VIP
	retail_add:function(){
		var vip_types=this.getVipType("add");
		var addVipno=document.getElementById("addvipNo").value;
		//alert(vip_types);
		if(this.master_data.params.company=='tommy'){
			vip_types="<select id=\"add_type\"><option value=\"0\">会员</option></select>";
		}
		var ele=Alerts.fireMessageBox(
			{
				width: 600,
				modal: true,
				title: gMessageHolder.EDIT_MEASURE
			});
			ele.innerHTML="<div id=\"query-add-content\">"+
					"<table width=\"600\" align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
  				"<tr><td><div id=\"add_td\"><div id=\"add_text\">请输入VIP信息</div></div></td></tr>"+
  				"<tr><td><div class=\"VIP_table\">"+
  				 "<table width=\"600\" border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" bgcolor=\"#486489\" id=\"modify_table\">"+
  				 ((addVipno&&addVipno=="NOR")?"<tr><td width=\"210\" height=\"25\" align=\"right\"><div >新增卡号：</div></td><td colspan=\"2\" ><input name=\"text\" id=\"add_vipNo\" type=\"text\" size=\"30\"/></td></tr>":"")+
  				 						"<tr><td width=\"210\" height=\"25\" align=\"right\"><div >类型：</div></td>"+
				"<td colspan=\"2\">"+vip_types+"</td></tr>"+
				"<tr><td width=\"210\" height=\"25\" align=\"right\"><div>性别：</div></td>"+
				"<td colspan=\"2\" ><select id=\"add_sex\"><option value=\"M\" selected>男</option><option value=\"W\">女</option></select></td></tr>"+
				"<tr><td width=\"210\" height=\"25\" align=\"right\"><div >开卡店仓：</div></td>"+
				"<td colspan=\"2\" ><input name=\"text\" size=\"30\" id=\"add_diancang\" type=\"text\" value=\""+this.master_data.c_store_name+"\"/></td></tr>"+
				"<tr><td width=\"210\" height=\"25\" align=\"right\"><div >姓名：</div></td>"+
				"<td colspan=\"2\" ><input name=\"text\" size=\"30\" id=\"add_vipname\" type=\"text\" /></td></tr>"+
				"<tr><td width=\"210\" height=\"25\" align=\"right\"><div >生日：</div></td>"+
				"<td ><input name=\"text\"size=\"30\" id=\"add_vipbirth\" type=\"text\" onkeypress=\"var k=event.keyCode; return k>=48&&k<=57||k==45\" onpaste=\"return !clipboardData.getData('text').match(//D/)\" ondragenter=\"return false\" style=\"ime-mode:Disabled\"/><font color=\"red\" size=\"2\">格式(1901-11-11)</font></td></tr>"+
				"<tr><td width=\"210\" height=\"25\" align=\"right\"><div >身份证号：</div></td>"+
				"<td colspan=\"2\" ><input name=\"text\" size=\"30\" id=\"add_IDnum\" type=\"text\" /></td></tr>"+
				"<tr><td width=\"210\" height=\"25\" align=\"right\"><div >邮件：</div></td>"+
				"<td colspan=\"2\" ><input name=\"text\" size=\"30\" id=\"add_email\" type=\"text\" /></td></tr>"+
				"<tr><td width=\"210\" height=\"25\" align=\"right\"><div >手机号：</div></td>"+
				"<td colspan=\"2\" ><input name=\"text\" size=\"30\" id=\"add_tele\" type=\"text\" onkeypress=\"var k=event.keyCode; return k>=48&&k<=57\" onpaste=\"return !clipboardData.getData('text').match(//D/)\" ondragenter=\"return false\" style=\"ime-mode:Disabled\" /></td></tr>"+
    									"</table></div></td></tr><tr><td align=\"center\"><div id=\"treatment_td\" align=\"center\">"+
    									"<div id=\"addok_text\">&nbsp;<input type=\"button\" value=\"确定\" id=\"add_ok\" onclick=\"bpos.add_func();\" class=\"qinput\"/>&nbsp;"+
    									"<input name=\"cancle\" id=\"add_nok\" type=\"button\" class=\"qinput\" value=\"取消\"  onclick=\"javascript:bpos.tryClose_add();\"/></div></div></td></tr></table></div>";
    						
    	  this.executeLoadedScript(ele);
    	  jQuery("#query-search-content").hidden=true;
    	  if(addVipno&&addVipno=="NOR"){
    	  	$("add_vipNo").focus();
    	  }else{
	    	  $("add_vipname").focus();
	    	}
	    	if(this.master_data.params.defaultVipType!="NON")
	    	jQuery("#add_type option[text="+this.master_data.params.defaultVipType+"]").attr("selected","true");
    	  //$("add_ok").disabled=true;
    	  			
	},
	//ADD BY Grace 20120129 升级VIP
	retail_update:function(){
		var vip_types=this.getVipType("update");
		
		if(this.master_data.params.company=='tommy'){
			vip_types="<select id=\"update_type\"><option value=\"1\">VIP</option></select>";
		}
		var ele=Alerts.fireMessageBox(
			{
				width: 600,
				modal: true,
				title: gMessageHolder.EDIT_MEASURE
			});
			ele.innerHTML="<div id=\"query-update-content\">"+
					"<table width=\"600\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
  				"<tr><td><div id=\"update_td\"><div id=\"update_text\">请输入VIP信息</div></div></td></tr>"+
  				"<tr><td><div class=\"VIP_table\">"+
  				 "<table width=\"585\" border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" bgcolor=\"#486489\" id=\"modify_table\">"+
				"<tr><td width=\"200\" height=\"25\" align=\"right\"><div>卡号：</div></td>"+
				"<td width=\"120\"><input name=\"text\" id=\"update_cardno\" type=\"text\" value=\""+this.hy_cardno+"\" /></td></tr>"+
  				 						"<tr><td width=\"200\" height=\"25\" align=\"right\"><div >类型：</div></td>"+
				"<td width=\"120\">"+vip_types+"</td></tr>"+
				"<tr><td width=\"200\" height=\"25\" align=\"right\"><div >邮编：</div></td>"+
				"<td width=\"120\"><input name=\"text\" id=\"update_post\" type=\"text\" /></td></tr>"+
				"<tr><td width=\"200\" height=\"25\" align=\"right\"><div >地址：</div></td>"+
				"<td width=\"120\"><input name=\"text\" id=\"update_address\" type=\"text\" /></td></tr>"+
    									"</table></div></td></tr><tr><td align=\"center\"><div id=\"update_td\" align=\"center\">"+
    									"<div id=\"updateok_text\">&nbsp;<input type=\"button\" value=\"确定\" id=\"update_ok\" onclick=\"bpos.update_func();\" class=\"qinput\"/>&nbsp;"+
    									"<input name=\"cancle\" id=\"update_nok\" type=\"button\" class=\"qinput\" value=\"取消\"  onclick=\"javascript:bpos.tryClose_update();\"/></div></div></td></tr></table></div>";
    						
    	  this.executeLoadedScript(ele);
    	  jQuery("#query-search-content").hidden=true;
    	  $("update_cardno").focus();
    	  if(this.master_data.params.defaultVipType!="NON")
	    	jQuery("#update_type option[text="+this.master_data.params.defaultVipType+"]").attr("selected","true");
    	  //$("update_ok").disabled=true;
	},
	//ADD BY Grace 20120129 替换VIP
	retail_change:function(){
		var ele=Alerts.fireMessageBox(
			{
				width: 600,
				modal: true,
				title: gMessageHolder.EDIT_MEASURE
			});
			ele.innerHTML="<div id=\"query-change-content\">"+
					"<table width=\"600\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
  				"<tr><td><div id=\"update_td\"><div id=\"change_text\">请输入VIP信息</div></div></td></tr>"+
  				"<tr><td><div class=\"VIP_table\">"+
  				 "<table width=\"585\" border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" bgcolor=\"#486489\" id=\"modify_table\">"+
				"<tr><td width=\"200\" height=\"25\" align=\"right\"><div>卡号：</div></td>"+
				"<td width=\"120\"><input name=\"text\" id=\"change_cardno\" type=\"text\" /></td></tr>"+
				"<tr><td width=\"200\" height=\"25\" align=\"right\"><div >邮编：</div></td>"+
				"<td width=\"120\"><input name=\"text\" id=\"change_post\" type=\"text\" /></td></tr>"+
				"<tr><td width=\"200\" height=\"25\" align=\"right\"><div >地址：</div></td>"+
				"<td width=\"120\"><input name=\"text\" id=\"change_address\" type=\"text\" /></td></tr>"+
    									"</table></div></td></tr><tr><td align=\"center\"><div id=\"treatment_td\" align=\"center\">"+
    									"<div id=\"changeok_text\">&nbsp;<input type=\"button\" value=\"确定\" id=\"change_ok\" onclick=\"bpos.change_func()\" class=\"qinput\"/>&nbsp;"+
    									"<input name=\"cancle\" id=\"changenok\" type=\"button\" class=\"qinput\" value=\"取消\"  onclick=\"bpos.tryClose_change()\"/></div></div></td></tr></table></div>";
    						
    	  this.executeLoadedScript(ele);
    	  jQuery("#query-search-content").hidden=true;
    	  $("change_cardno").focus();
    	  //$("change_ok").disabled=true;
	},
	//ADD BY Grace 20120129 增加VIP时条件判断
	add_func:function(){
		var addVipno=jQuery.trim($("addvipNo").value);
		var h="";
		var per=parseInt(this.master_data.params.vipAddRequiredCondition,2);
		if(addVipno&&addVipno=="NOR")h=jQuery.trim($("add_vipNo").value);
		var a=jQuery.trim(jQuery("#add_sex").val());
		var b=jQuery.trim($("add_diancang").value);
		if((per&32)==32){
			if(!b&&b!==0){
				alert("请输入开卡店仓...");
				$("add_diancang").focus();
				return;
			}
		}
		var c=jQuery.trim($("add_vipname").value);
		if((per&16)==16){
			if(!c&&c!==0){
				alert("请输入姓名...");
				$("add_vipname").focus();
				return;
			}
		}
		var d=jQuery.trim($("add_tele").value);
		if((per&1)==1){
			if(!d&&d!==0){
				alert("请输入手机号码！");
				$("add_tele").focus();
				return;
			}
		}
		var e=jQuery.trim($("add_email").value);
		if((per&2)==2){
			if(!e&&e!==0){
				alert("请输入邮箱！");
				$("add_email").focus();
				return;
			}
		}
		var idnum=jQuery.trim($("add_IDnum").value);
		if((per&4)==4){
			if(!idnum&&idnum!==0){
				alert("请输入身份证号码！");
				$("add_IDnum").focus();
				return;
			}
		}
		var f=jQuery.trim($("add_vipbirth").value);
		if((per&8)==8){
			if(!f&&f!==0){
				alert("请输入生日!");
				$("add_vipbirth").focus();
				return;
			}
		}
		
		var g=jQuery("#add_type").val();
		if(addVipno&&addVipno=="NOR"){
			if(!h&&h!==0){
				alert("请输入VIP卡号...");
				$("add_vipNo").focus();
				return;
			}
		}
		//判断姓名输入字符串长度
		var name_length=0;
		for(var i=0;i<c.length;i++){
			var intCode=c.charCodeAt(i);
			if(intCode>=0&&intCode<=128){
				name_length++;
			}else{
				name_length+=2;
			}
		}
		if(name_length>50){
			alert("姓名超长（请输入20以内字符）");	
			$("add_vipname").focus();
			return;
		}
		if(f||f===0){
			var reg=/^(\d{4})-(\d{2})-(\d{2})$/; 
			if(reg.test(f)){
				var array=f.split("-");
				var date=new Date(array[0],parseInt(array[1],10)-1,array[2]);
				if(!((date.getFullYear()==parseInt(array[0],10))&&((date.getMonth()+1)==parseInt(array[1],10))&&(date.getDate()==parseInt(array[2],10)))){
					alert("请输入生日!");
					$("add_vipbirth").focus();
					return;
				}
			}else{
				alert("请输入生日");
				$("add_vipbirth").focus();
				return;
			}
		}
		
		if(e||e===0){
			var remail=/\w@\w*\.\w/;
			if(remail.test(e)){
			}else{
				alert("邮件格式错误（例：email@126.com）");
				$("add_email").focus();
				return;
			}
		}
		//    /^(13[0-9]{9})|(15[89][0-9]{8})&/
		if(d||d===0){
			var re= /^[1,5,6,8,9][0-9]{7,10}$/;
			if(re.test(d)){
			}else{
				alert("请输入正确的手机号");
				$("add_tele").focus();
				return;
			}
		}
		this.checkadd_func("1","","",g,"",""+b+"",c,d,e,a,"",f,this.master_data.c_store_id,h,idnum);
	},
	//ADD BY Grace 20120129 升级VIP时条件判断
	update_func:function(){
		var a=jQuery.trim($("update_cardno").value);
		var b=jQuery.trim($("update_post").value);
		var c=jQuery.trim($("update_address").value);
		var d=jQuery.trim(jQuery("#update_type").val());
		if(!a&&a!=0){
			alert("请输入卡号...");
			$("update_cardno").focus();
			return;
		}
		/*
		var rpost=/^[0-9]{6}$/;
		if(rpost.test(b)){
		}else{
			alert("请输入6位邮编");
			$("update_post").focus();
			return;
		}
		*/
		if(!c&&c!=0){
			alert("请输入地址...");
			$("update_address").focus();
			return;
		}
		this.checkadd_func("2","",a,d,c,"","","","","",b,"",this.master_data.c_store_id,"","");
	},
	//ADD BY Grace 20120129 替换VIP时条件判断
	change_func:function(){
		var a=jQuery.trim($("change_cardno").value);
		var b=jQuery.trim($("change_address").value);
		var c=jQuery.trim($("change_post").value);
		if(!a&&a!=0){
			alert("请输入卡号...");
			$("change_cardno").focus();
			return;
		}
		if(!b&&b!=0){
			alert("请输入地址...");
			$("change_address").focus();
			return;
		}
		/*
		var rpost=/^[0-9]{6}$/;
		if(rpost.test(c)){
		}else{
			alert("请输入6位邮编");
			$("change_post").focus();
			return;
		}
		*/
		this.checkadd_func("3","",a,"",b,"","","","","",c,"",this.master_data.c_store_id,"","");
	},
	//动作类型，VIP_ID，升级/换卡卡号，VIP类型ID，升级/换卡地址，店仓名，VIP姓名，手机号，邮箱，性别，升级/换卡邮编，生日，店仓ID，新增VIP卡号，身份证号
  checkadd_func:function(action_type,vip_id,vip_cardno,vip_type,vip_address,c_store_name,c,d,e,a_sex,post,birthday,c_store_id,addVipNo,IDnum){
  	//alert(bpos.master_data.operator.id);
  	//alert(this.master_data.saler.id);
  	//alert(action_type+" ;vipid "+vip_id+" ;vipcardno "+vip_cardno+" ;viptype "+vip_type+" ;address "+vip_address+" ;cstroename "+c_store_name+" ; "+c+" ; "+d+" ; "+e+" ; "+a_sex+" ; "+post+" ; "+birthday);
  	var evt={};
  	evt.command="DBJSON";
		evt.callbackEvent="BPOS_VIPACM";
		
		var p_addvalue={};
		p_addvalue.p_userid=bpos.master_data.operator.id;
		p_addvalue.type=action_type;
		p_addvalue.vip_id=vip_id;
		p_addvalue.hy_cardno=this.hy_cardno;
		p_addvalue.vip_cardno=vip_cardno;
		p_addvalue.vip_type=vip_type;
		p_addvalue.vip_address=vip_address;
		p_addvalue.c_store_id=c_store_name;
		p_addvalue.vip_name=c;
		p_addvalue.vip_mobil=d;
		p_addvalue.vip_email=e;
    p_addvalue.vip_sex=a_sex;
    p_addvalue.vip_post=post;
    p_addvalue.vip_birth=birthday;
    p_addvalue.IDnum=""+IDnum+"";
    p_addvalue.cur_salerid=this.master_data.saler.id;
    p_addvalue.cur_c_store_id=c_store_id+"";
    p_addvalue.vip_addno=addVipNo;
		//var param={"p_userid":bpos.master_data.operator.id,"p_param":p_addvalue};
		var param=p_addvalue;
		evt.param=Object.toJSON(param);
		//alert(evt.param);
		evt.table="m_retail";
		evt.action="vip_acm";
		evt.permission="r";		
		this._executeCommandEvent(evt);	
	},
	/**
	 *add by robin 20121224 判断是否使用短信找回密码功能
	 */
	checkUseSms:function(){
		if(this.master_data.params.useVipSms=='true')return true;
		return false;
	},
	/**
	 *add by robin 20121224 增加发生短信方法
	 */
	smsVip:function(){
		if(!(this.vip&&this.vip.vip_id)){
			alert("未录入VIP！");
			return;
		}
		var evt={};
    evt.command="cn.com.burgeon.command.webpos.SmsSend";
    evt.callbackEvent="VIP_SMS";
    var param={"cardno":this.vip.cardno,"mobile":this.vip.mobil};
    evt.param=Object.toJSON(param);
    this._executeCommandEvent(evt);
	},
	_onSmsVip:function(e){
		var data=e.getUserData();
		var reg=/<.+?>/g;
		data=data.replace(reg,"");
		if(typeof(data)=='string'){
			ret=data.evalJSON();
		}else{
			ret=data.jsonResult.evalJSON();
		}
		if(ret.Code!=0){
			alert("无法发送短信，请确认该VIP手机号码是否维护正确！");
		}else{
			alert("短信已发送！请查收！");
		}
	},
	getConds:function(){
		var conds=new Array();
		var cardnoUpperCase=false;
		var companyIsAokang=false;
		if(this.master_data.params.company&&jQuery.trim(this.master_data.params.company)=='aokang')companyIsAokang=true;
		if(this.master_data.params.company&&jQuery.trim(this.master_data.params.company)=='jnby')cardnoUpperCase=true;
		var vsc=parseInt(this.master_data.params.vipcontroltype,2);
		for(var i=3;i>=0;i--){
			 var c;
			switch(i){
				case 3:if(companyIsAokang||(this.master_data.comptype==1&&(this.master_data.params.company&&jQuery.trim(this.master_data.params.company)=='bsw'))) {
									
									c={name:"VIP&nbsp;卡号",key:"vip",upperCase:cardnoUpperCase,btn:{name:"刷卡",key:"swingCard"},disabled:true};
							 }else c={name:"VIP&nbsp;卡号",key:"vip",upperCase:cardnoUpperCase};break;
				case 2:c={name:"手&nbsp;机&nbsp;号",key:"tele"};break;
				case 1:c={name:"VIP&nbsp;姓名",key:"name"};break;
				case 0:c={name:"身份证号",key:"vipidno"};break;
			}
			conds.push(c);
		}
		return conds;
	},
	/**
	 *add by robin 20130306
	 *画查询店仓界面
	 */
	drawQueryStore:function(){
		var title="查询店仓信息";
		var conds=[{name:"编号",key:"qstoreCode"},{name:"名称描述",key:"qstoreDes"},{name:"城市",key:"qstoreCity"},{name:"地址",key:"qstoreDre"}];
		var itemC=[{name:"编号",key:"storeCodeI"},{name:"名称",key:"storeNameI"},{name:"地址",key:"storeDreI"},{name:"城市",key:"storeCityI"},{name:"省份",key:"storeProvinceI"},{name:"分公司",key:"storeBranchI"}];
		var btns=[{name:"确定",key:"determineq"},{name:"取消",key:"cancelq"}];
		var result=["编号","名称","地址"];
		du.multiQuery(conds,itemC,btns,title,"",result);
		this.noAlert=false;
		var vipss=$("qstoreCode");
		if(vipss&&vipss.disabled!=true)vipss.focus();
		jQuery("#qstoreCode,#qstoreDes,#qstoreCity,#qstoreDre").bind("keyup",function(event){
				if(event.target==this&&event.which==13){
					bpos.combineConditionAndsearchStore();
				}
			});
		jQuery("#cancelq").bind("click",function(event){
					bpos.tempStore=null;
					bpos.killAlert2("query-search-content");
					$("search_condition").focus();
		});
		jQuery("#determineq").bind("click",function(event){
				if(bpos.tempStore&&bpos.tempStore.name){
					jQuery("#storenamer").val(bpos.tempStore.name);
					bpos.tempStore=null;
					bpos.killAlert2("query-search-content");
					$("search_condition").focus();
				}
		});
	},
	/**
	 *add by robin 20130306 合并条件然后查询店仓
	 */
	combineConditionAndsearchStore:function(){
		var con={};
		jQuery("#qstoreCode,#qstoreDes,#qstoreCity,#qstoreDre").each(function(){
				if(this.value&&jQuery.trim(this.value)!=""){
					con[this.id]=this.value;
				}		
			});
		jQuery.ajax({
				type:"POST",
				url:this.URL+"getStoreInfo.jsp",
				timeout:3000,
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				data:"cn="+Object.toJSON(con),
				error:function(){
					alert("网络不畅,请稍后再试！");
				},
				success:function(data){
					var jo=data.evalJSON();
					if(jo.code==0){alert(jo.msg);return;}
					bpos.handlermultistore(jo.msg);
				}
			});
	},
	/**
	 *add by robin 20130306
	 *查询多个店仓信息后处理动作
	 */
	handlermultistore:function(ret){
		if(ret.length>1){
			jQuery("#showmultivip").css("display","");
			var str="";
			for(var i=0;i<ret.length;i++){
				str+="<div class=\"VIP-row\" id=\"VIP-row-"+i+"\">"+
							"<div class=\"VIP-row-line\">"+
							"<div class=\"VIP-span-1\">"+ret[i].code+"</div><div class=\"VIP-span-2\">"+(ret[i].name=="null"?"":ret[i].name)+"</div><div class=\"VIP-span-4\">"+(ret[i].address=="null"?"":ret[i].address)+"</div></div></div>";
			}
			jQuery("#VIP-main").html(str);
			jQuery("#VIP-main>div").bind("click",function(event){
				jQuery("#VIP-main>div").css("background-color","");
				jQuery(this).css("background-color","#75A9D6");
			});
			jQuery("#VIP-main>div").bind("dblclick",function(event){
					var index=parseInt(this.id.replace("VIP-row-",""));
					bpos.docheckstore(ret[index])
					//this.tempvip=bpos.changeret2vip(ret[index]);
					//bpos.updatevipinfohtml();
					event.stopPropagation();
			});
		}else{
			this.docheckstore(ret[0]);
			jQuery("#ok").focus();
		}
	},
	docheckstore:function(store){
		this.tempStore=store;
		$("storeCodeI").innerHTML=this.tempStore.code;
		$("storeNameI").innerHTML=this.tempStore.name;
		$("storeDreI").innerHTML=this.tempStore.address=="null"?"":this.tempStore.address;
		$("storeCityI").innerHTML=this.tempStore.city=="null"?"":this.tempStore.city;
		$("storeProvinceI").innerHTML=this.tempStore.province=="null"?"":this.tempStore.province;
		$("storeBranchI").innerHTML=this.tempStore.block=="null"?"":this.tempStore.block;
	},
	/**
	 *add by robin 20130306
	 *画VIP查询界面
	 */
	drawvip_alert:function(title){
		var conds=this.getConds();
		var itemC=[{name:"VIP&nbsp;姓名",key:"vipname"},{name:"VIP&nbsp;类型",key:"c_viptype"},{name:"英&nbsp;文&nbsp;&nbsp;名",key:"vipename"},{name:"出生日期",key:"birthday"},
							 {name:"性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别",key:"sex"},{name:"身份证号",key:"idno"},{name:"失效日期",key:"validdate"},{name:"上次消费日期",key:"lastconsumption"},
							 {name:"可用积分",key:"integral"},{name:"累计消费金额",key:"tot_amt_actual"},{name:"经销商",key:"toDealer"},{name:"开卡店仓",key:"toStore"},
							 {name:"手机号码",key:"telephone"}];
		
		if(!title)var title="新零售单据：请输入VIP查询信息";
		var btns=new Array();
		if(this.master_data.params.vip_aum!='000'){
			 	var per=parseInt(this.master_data.params.vip_aum,2);
			 	if((4&per)==4)btns.push({name:"新增",key:"retailadd"});
			 	if((2&per)==2)btns.push({name:"升级",key:"retailupdate"});
			 	if((1&per)==1)btns.push({name:"换卡",key:"retailchange"});
		}
		btns.push({name:"确定",key:"ok"});
		btns.push({name:"取消",key:"nok"});
		
		var extraStr="<tr "+(this.master_data.params.isIntlDis=='true'?"":"style=\"display:none;\"")+" class=\"emtbts\"><td align=\"right\">是否积分：</td> <td><select id='isIntl'><option value=\"Y\">----是----</option><option value=\"N\">----否----</option></select></td>"+
                      "<td align=\"right\">是否打折：</td><td><select id='isDis'><option value=\"Y\">----是----</option> <option value=\"N\">----否----</option></select></td></tr>";
		var result=["姓名","手机号","卡号"];
		
		
		du.multiQuery(conds,itemC,btns,title,extraStr,result);
		this.noAlert=false;
		
		var vipss=$("vip");
			if(vipss&&vipss.disabled!=true)vipss.focus();
			jQuery("#vip,#tele,#name,#vipidno").bind("keyup",function(event){
				if(event.target==this&&event.which==13){
					if(!this.value&&this.id=='vip'){
						this.value=bpos.readvip();
					}
					bpos.combineConditionAndsearchVip();
				}
			});	
			var vipdiv;
			var ipt=vipss;
			jQuery("#query-search-content").bind("keydown",function(event){
				var vipeles=jQuery("#VIP-main>div");
				var tab=jQuery("#vip,#tele,#name,#vipidno,#retailadd,#ok,#nok");
				if(event.which==40){
					if(vipeles.length>0){
						var index=0;
						if(vipdiv){
							index=vipeles.index(vipdiv)+1;
						}
						if(!vipeles[index]){
							index=0;
						}
						vipdiv=vipeles[index];
						var ele=jQuery(vipdiv);
						
						ele.click();
						vipdiv.tabIndex=-1;
						vipdiv.focus();
						//getfocus(vipdiv);
					}
				}else if(event.which==38){
					if(vipeles.length>0){
						var index=vipeles.length-1;
						if(vipdiv){
							index=vipeles.index(vipdiv)-1;
						}
						if(!vipeles[index]){
							index=vipeles.length-1;
						}
						vipdiv=vipeles[index];
						var ele=jQuery(vipdiv);
						ele.click();
						
						vipdiv.tabIndex=-1;
						vipdiv.focus();
						//getfocus(vipdiv);
					}
				}else if(event.which==13){
					if(vipeles.index(vipdiv)!=-1){
						jQuery(vipdiv).dblclick();
						//jQuery("#ok").focus();
					}
				}else if(event.which==9){
				  tab=jQuery("#vip,#tele,#name,#vipidno,#retailadd,#retailupdate,#retailchange,#ok,#nok");
					event.stopPropagation();
					event.preventDefault();
					var index1=0;
					if(ipt){
						index1=tab.index(ipt)+1;
					}
					if(tab[index1]&&tab[index1].disabled==true||jQuery(tab[index1]).is(":hidden"))index1++;
					if(!tab[index1])index1=0;
					ipt=tab[index1];
					ipt.focus();
				}
			});		
		
	},
	showvip_alert:function(){
		
		this.drawvip_alert();
		
		jQuery("#swingCard").bind("click",function(event){bpos.handleReadVip();});
		jQuery("#retailupdate").bind("click",function(event){bpos.retail_update();});
		jQuery("#retailadd").bind("click",function(event){bpos.retail_add();});
		jQuery("#retailchange").bind("click",function(event){bpos.retail_change();});
		jQuery("#ok").bind("click",function(event){bpos.checkvip2();});
		jQuery("#nok").bind("click",function(event){bpos.tryClose();});

	  	
			
			/*
			jQuery.ajax({
				type:"POST",
				url:this.URL+"getviptypeid.jsp",
				timeout:3000,
				data:"",
				error:function(){
					alert("网络不畅,请稍后再试！");
					
				},
				success:function(data){
					data=jQuery.trim(data);
					var ret=data.evalJSON();
					//alert(Object.toJSON(ret));
					//alert(ret[2].typename);
				}
			});
			*/
	},
	//add by robin 20121225 activex 接口 执行CMD命令，目前用于钱箱弹出
	commandExt:function(cmdStr){
		try{
			MainApp.commandExt(cmdStr);
		}catch(e){
			//alert(e.message);
		}
	},
	_editvip:function(newretail){		
		if((this.MODEL&this.NEWODER)!=this.NEWODER){
			alert("请先付款或挂单！");
			return;
		}
		if(this.items_data.length>0&&this.MODEL!=this.SHOWMODEL){
			if(!confirm("单据明细未保存，确认放弃此单据？"))return;
		}
		this.init(newretail);
		jQuery("#m_retail_idx").val("");
		jQuery("#comment").val("按下F10键输入商品备注...");
		if(this.master_data.params.showVIPAlertOnNewOrder!="false"){
			jQuery("#uploadvip").css("display","none");
		}
		this.updateheaderhtml(newretail);
		//this.readvip();
		if(this.master_data.params.showVIPAlertOnNewOrder&&this.master_data.params.showVIPAlertOnNewOrder=="false"){}else{
			this.showvip_alert();
		}
	},	
   _editretailno:function(){
   	//alert(this.master_data.params.needorgno);
   	if(this.master_data.params.needorgno&&this.master_data.params.needorgno=="true"){
   		if(this.master_data.params.pdtStyleModel&&this.master_data.params.pdtStyleModel=="true"){
   			var barcode=$("m_retail_idx").value.strip().toUpperCase();
   			var sql="select count(1) as c from m_pdtalias_webpos where no='"+barcode+"' or INTSCODE='"+barcode+"'";
				var ret=this.queryDateFromDB(sql);
				
				if(!(ret.length&&ret[0].c==1)){
					this.killAlert("r_retail_no_content",true);
					this.pdtStyleModel(jQuery.trim($("m_retail_idx").value));
					return;
				}
			}
			var ele = Alerts.fireMessageBox(
					{
						width: 400,
						modal: true,
						title: gMessageHolder.EDIT_MEASURE
					});
			ele.innerHTML= $("r_retail_no").innerHTML.replace(/TMP/g,"");
			this.executeLoadedScript(ele);
			this.noAlert=false;
			jQuery("#retaildata").tipInput("格式：20130304");
			$("search_condition").style.visibility="visible";
			jQuery("#queryvip").bind("click",function(event){
					bpos.drawvip_alert();
					jQuery("#swingCard").bind("click",function(event){bpos.handleReadVip();});
					jQuery("#ok").bind("click",function(event){bpos.checkvip3();$("search_condition").focus();});
					jQuery("#nok").bind("click",function(event){bpos.killAlert2("query-search-content");});
				});
			jQuery("#querystore").bind("click",function(event){
					bpos.drawQueryStore();
					
				});
			
	    window.setTimeout('$("search_condition").focus();',500);
	
			this.search_control();
    }else{
    	this.checkretailno("");
    }
	},
	//add by Grace 20120223根据查询条件显示退货状态页面
	search_condition:function(snd){
		//alert(document.getElementById("search_condition").value);
		jQuery("#retail_no").toggle();
		jQuery("#store_name").toggle();
		jQuery("#vip_no").toggle();
		jQuery("#saler_name").toggle();
		jQuery("#retail_data").toggle();
		//storename默认店仓名
		if(document.getElementById("search_condition").value=="2"){
			jQuery("#storenamer").val(this.master_data.c_store_name+"");
		}
		if(!snd)
			this.search_control();
	},
	search_control:function(){
		//控制tab键
			//alert(Object.toJSON(tab));
			var tab;
			var vipss=$("search_condition");
			var ipt=vipss;
			jQuery("#r_retail_no_content").bind("keydown",function(event){
				if(event.which==9){
					if(document.getElementById("search_condition").value=="2"){
						tab=jQuery("#search_condition,#storenamer,#vipno,#saler,#retaildata,#search_ok,#search_nok");
					}else{
						tab=jQuery("#search_condition,#retailno,#search_ok,#search_nok");
					}
					event.stopPropagation();
					event.preventDefault();
					var index1=0;
					if(ipt){
						index1=tab.index(ipt)+1;
					}
					if(tab[index1]&&tab[index1].disabled==true)index1++;
					if(!tab[index1])index1=0;
					ipt=tab[index1];
					ipt.focus();
				}else{
					//alert(document.getElementById("search_condition").value);
					if(event.which==38&&document.getElementById("search_condition").value=="2"){
						jQuery("#search_condition option[text='原单查询']").attr("selected","true");
					}else if(event.which==40&&document.getElementById("search_condition").value=="1"){
						jQuery("#search_condition option[text='条件查询']").attr("selected","true");
					}else{
						return;	
					}
					bpos.search_condition("snd");
				}
			});	
	},
	insertlineqaction:function(ret){
		if(ret.code&&ret.code==-1){
			bpos.killAlert("login_content",true);	
			if(this.master_data.params.pdtStyleModel&&this.master_data.params.pdtStyleModel=="true"){
				this.pdtStyleModel(jQuery.trim($("m_retail_idx").value));
				return;
			}else{
				this.selectFirstType();
				$("m_retail_idx").value="";
				return;
			}
		}
		if(jQuery.trim(this.master_data.params.orgModifyPer)=='false'){
			//ret.m_retail_price=bpos.alg(-p);
			//ret.m_retail_priceactual=bpos.alg(p);
			//ret.m_retail_discount=p.div(ret.m_retail_pricelist);
			bpos.updateitems_data(ret);
			bpos.killAlert("r_retail_no_content");
		 	$("m_retail_idx").value="";
		 	return; 
		}
		var ele = Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
		ele.innerHTML= $("r_retail_price").innerHTML.replace(/TMP/g,"");
		this.executeLoadedScript(ele);
		this.noAlert=false;
	  //alert(Object.toJSON(ret));
		//当前用户的最低折扣this.master_data.discountlimit
	  
	  var  flagLowprice=0;

		//原单退货根据参数returnPriceLimit来判断
		 if(this.master_data.params.returnPriceLimit.strip().toLowerCase()=="true"){
		 	
	  	var priceOfLowestDiscount=(ret.m_retail_pricelist||0)*this.master_data.discountlimit;
	  	 var p=parseFloat(priceOfLowestDiscount);
	  	if(p>=parseFloat(ret.m_retail_priceactual)){
	  		  ret.m_retail_price=bpos.alg(-p);
    			ret.m_retail_priceactual=bpos.alg(p);
    			ret.m_retail_discount=ret.m_retail_pricelist==0?0:p.div(ret.m_retail_pricelist);

    			bpos.updateitems_data(ret);
	  		  bpos.killAlert("r_retail_price_content");
    		  bpos.killAlert("r_retail_no_content");
    		  $("m_retail_idx").value="";
    		  	 return; 		
	  	}else{
	  	
	  	   flagLowprice=p;	
	  	
	  		
	  	}	  	
	  	
	   }
	  
	  $("info_text").innerHTML="<span style='color:red'>     退货的价格在"+flagLowprice+"~"+(-ret.m_retail_price)+"</span>";	
		
		$("tempx").value=-ret.m_retail_price;	
		window.setTimeout('$("retailprice").focus();',500);
   
    jQuery("#retailprice").keypress(function(event){
    	if(event.target==this&&event.which==13){
    		var p=parseFloat(this.value);
    		if(isNaN(p)||p<flagLowprice||p>-ret.m_retail_price){
    			alert("请输入正确的价格！");
    			$("retailprice").value="";
    		}else{
    			ret.m_retail_price=bpos.alg(-p);
    			ret.m_retail_priceactual=bpos.alg(p);
    			ret.m_retail_discount=ret.m_retail_pricelist==0?0:p.div(ret.m_retail_pricelist);

    			bpos.updateitems_data(ret);
    			bpos.killAlert("r_retail_price_content");
    		  bpos.killAlert("r_retail_no_content");
    			$("m_retail_idx").value="";
    		}
    	}
    });
    jQuery("#returnpricebutton").click(function(){
    		var p=parseFloat($("retailprice").value);
    		if(isNaN(p)||p<flagLowprice||p>-ret.m_retail_price){
    			alert("请输入正确的价格！");
    			$("retailprice").value="";
    		}else{
    			ret.m_retail_price=bpos.alg(-p);
    			ret.m_retail_priceactual=bpos.alg(p);
    			ret.m_retail_discount=ret.m_retail_pricelist==0?0:p.div(ret.m_retail_pricelist);
    	
    			bpos.updateitems_data(ret);
    			bpos.killAlert("r_retail_price_content");
    		  bpos.killAlert("r_retail_no_content");
    			$("m_retail_idx").value="";
    		}
    });
     jQuery("#canclebutton").click(function(){
     		bpos.killAlert("r_retail_price_content");
     	 	bpos.killAlert("r_retail_no_content");
     	});
    
	},
	 _onInsertLine_q:function(e){
	  var data=e.getUserData(); // data
	  var ret;
		//var ret=data.jsonResult.evalJSON();
		//alert(document.getElementById("search_condition").value);
		if(typeof(data)=='string'){
			ret=data.evalJSON();
		}else{
			ret=data.jsonResult.evalJSON();
		}
		//alert(Object.toJSON(ret));
		//alert(this.search_end);
		if(document.getElementById("search_condition").value=="2"&&this.search_end=="1"){
			this.q_data=ret;
			this.show_search(ret);
		}else{
			this.insertlineqaction(ret);
		}
	},
	
	selectitem:function(lineno) {
		//alert(jQuery("#row-"+lineno).find(":checkbox").size());
		for(var i=0;i<this.linenos.length;i++) {
			if(this.linenos[i]==lineno) {
				this.selectid=i;
				this.clearSelectcolor();
				this.nextretail("s");
			 //建立双击选中事件:
			
			 //方法一：jQuery("#row-"+lineno).find(":checkbox").attr("checked",true);
			 var checkInput=jQuery("#row-"+lineno).find(":checkbox");	
			 //方法二：jQuery("input[name='m_retail']:checkbox").eq(lineno-1).attr("checked",true);			
			/** var  checkInput=jQuery("input[name='m_retail']:checkbox").eq(lineno-1);**/
			
		checkInput.attr("checked")?checkInput.attr("checked",false):checkInput.attr("checked",true);
			  
			  /**if(checkInput.attr("checked"))
				    checkInput.attr("checked",false);
			  else 
			  	  checkInput.attr("checked",true);
			 **/
				break;
			}
		}	
	},
	
	//clear selectcolor
	clearSelectcolor:function() {
		for(var i=0;i<this.linenos.length;i++) {
			var bgcolor=document.getElementById("row-"+this.linenos[i]).style.backgroundColor;
			if(bgcolor=="dodgerblue") {
				var orgcolor=this.linenos[i]%2==0?"#A3BAD4":"#DAE3EA";	
				jQuery("#row-"+this.linenos[i]).css("background-color",orgcolor);
				break;
			}
		}
	},
	
	/**
	*切换下一条明细
	*
	*/
	nextretail:function(flag) {
		if(!this.items_data.length>0) return;
		$("from-main").focus();
		if(!flag)this.selectid++;
		if(this.selectid==this.linenos.length) {
			this.selectid=0;		
		}
		this.clearSelectcolor();	
		if(this.linenos[this.selectid]==this.linenos[Math.round(document.getElementById("from-main").scrollTop/25)+12]) {
			document.getElementById("from-main").scrollTop+=300;
		}
		if(this.selectid==0) {
			document.getElementById("from-main").scrollTop=0;
		}
		jQuery("#row-"+this.linenos[this.selectid]).css("background-color","dodgerblue");	

	},
	/*切换上一条明细*/
	preretail:function() {
		if(!this.items_data.length>0) return;
		if(this.selectid==-1) {this.nextretail();return;}
		$("from-main").focus();
		this.selectid--;
		if(this.selectid==-1) {
			this.selectid=this.linenos.length-1;
		}
		this.clearSelectcolor();
		if(this.linenos[this.selectid]==this.linenos[Math.round(document.getElementById("from-main").scrollTop/25)-1]) {			
			document.getElementById("from-main").scrollTop-=300;
		}	
		if(this.selectid==this.linenos.length-1) {
			document.getElementById("from-main").scrollTop=Math.ceil(this.linenos.length/12)*300;
		}
		jQuery("#row-"+this.linenos[this.selectid]).css("background-color","dodgerblue");	
		
	},
	enterSelect:function() {
		if(!this.items_data.length>0) return;
		var selectrow=jQuery("#from-main input[value="+this.linenos[this.selectid]+"]");
		selectrow.attr("checked")?selectrow.attr("checked",false):selectrow.attr("checked",true);
	},
	
	/**
	 *切换下一个零售类型
	 */
	changeretailtype:function(){
		if(this.nosalererror()){
			return;
		}
		var value=jQuery("#m_retailtype").attr("val");
		value=parseInt(value,10);
		var index=this.getFirstIndexActiveType();
		for(var i=0;i<this.types.length;i++){
				if(this.types[i].value==value){
					while(true){
						i++;
						if(!this.types[i])break;
						if(this.types[i].active==1){
							index=i;
							break;
						}
					}
					break;
				}
			}
		if(index||index==0)this.changeretailtypeforspec(this.types[index].value,index);
	},
	/**
	 *指定类型，刷新页面
	 *@param :value 类型值，参见：this.types
	 */
	changeretailtypeforspec:function(value,index){
		var type=this.value2type(value);
		var e=jQuery("#m_retailtype");
		e.attr("val",value);
		e.val(type);
		//alert(this.types[index].color);
		if(!index)index=0;
		e.css("color",this.types[index].color);
		this.itemtype=value;
	},	
	/**
	 *Edit by Robin 20100728
	 *转化零售类型值为描述
	 *@param : value 零售类型值，目前为1,2,3,4
	 *@return :描述
	 */
	value2type:function(value){
			for(var i=0;i<this.types.length;i++){
				if(value==this.types[i].value){
					return this.types[i].type;
				}
			}
			return -1;
	},
	tryClose1:function(){
		if(bpos.master_data.operator.isret=="N"){
			// 根据系统参数webpos.noOrderNOnoPass进行判断(需要原单号的前提下，退货无原单号不能通过)
			if(this.master_data.params.noOrderNOnoPass=="false"){
				bxl.validateEmployee("V");
			}else{
				bxl.closeEmp("Q");
			}
		}else if(bpos.master_data.operator.isret=="Y"){
			if(this.master_data.params.noOrderNOnoPass=="false"){
				bxl.closeEmp("V");
				this.checkretailno("");	
			}else{
				bxl.closeEmp("Q");
			}
		}
	},
	/**
	 * add by robin 20121119 在某些情况下，你需要商品没有经过任何的优惠（执行策略）然后执行系统定制的活动优惠（优惠或打折）
	 * 此方法就是用于判断此情况
	 */
	checkNeedFullPrice:function(param){
		if(param.m_retail_type==1&&this.vip&&this.vip.vipdis&&this.vip.vipdis.ID){
			var remqty=this.getVipDisRemQty();
			if(this.vip.vipdis.ISFULLPRICE=='Y'&&this.vip.vipdis.LIMITTYPE==1&&remqty>0){
				if(confirm("您还剩余"+remqty+"件商品使用["+this.vip.vipdis.NAME+"]活动机会,是否使用？"))
				return true;
			}
		}
		return false;
	},
	/*
	*Edit by Robin 20100719
	*@param :action 动作现在有（BPOS_INSERT_LINE_Q，BPOS_INSERT_LINE，BPOS_CHANGAMT）
	*@param :m_retail_productno
	*@param :m_retail_qty 
	*@param :m_retail_type 
	*@param :m_retail_orgdocno 原单号
	*@param :m_retail_priceactual
	*@param :discount 折扣 
	*/
	insertline_action:function(action,m_retail_productno,m_retail_qty,m_retail_type,m_retail_orgdocno,m_retail_priceactual,discount,needorgno){

		if(this.offline==true&&isIE()){
			if(action=="BPOS_CHANGAMT"){
				var info={};
				var param={};
				var productno=new Array();
				productno.push(m_retail_productno);
				param.m_retail_productno=productno;
				var qty=new Array();
				qty.push(m_retail_qty);
				/*
				var m_retail_priceactual1=new Array();
				m_retail_priceactual1.push(m_retail_priceactual);
				param.m_retail_priceactual=m_retail_priceactual1;
				*/
				param.m_retail_qty=qty;
				param.m_retail_price=(parseInt(m_retail_qty,10)).mul(parseFloat(m_retail_priceactual));
				param.billdate=$("sys_date").value;
				info.param=param;
				var ret=this.checkdis(Object.toJSON(info));
				ret=ret.evalJSON();
				if(ret.code==1){
					this.changamtaction(ret,parseFloat(discount));
				}else if(ret.code==-1){
					alert(ret.meg);
				}
				return;
			}
		}
		var evt={};
		evt.callbackEvent=action;
		if(action=="BPOS_RET_FUZZYQUERY"){
			evt.command="cn.com.burgeon.command.webpos.RetFuzzyQuery";
			evt.permission="r";
			var vip_cardno=jQuery.trim($("vipno").value);
			var store_name=jQuery.trim($("storenamer").value);
			var saler_name=jQuery.trim($("saler").value);
			var sale_date=jQuery.trim($("retaildata").value);
			var param={"vip_cardno":vip_cardno,"store_name":store_name,"saler_name":saler_name,"saleDate":sale_date,"productno":m_retail_productno};
			evt.param=Object.toJSON(param);
			//alert(evt.param);
		}else{
			var sys_date=$("sys_date").value;
			var param={"cardno":this.vip.vip_id||"-1","c_store_id":this.master_data.c_store_id,"billdate":sys_date,"m_retail_productno":m_retail_productno,"m_retail_qty":m_retail_qty,"m_retail_type":m_retail_type,"m_retail_orgdocno":m_retail_orgdocno,"m_retail_priceactual":m_retail_priceactual,"discount":discount};
			evt.param=Object.toJSON(param);
			if(this.offline==true&&isIE()&&!needorgno){
				var info={};
				param.cardno=this.vip.cardno||"1";
				param.vipexp=this.vip.vipexp||"1";
				param.vipbir=this.vip.birthday||"";
				param.isDis=this.vip.isDis||'Y';
				info.param=param;
				//alert(Object.toJSON(info));
				var recodeType=false;
				var needFullPrice=this.checkNeedFullPrice(param);
				if(needFullPrice){
					recodeType=param.m_retail_type;
					info.param.m_retail_type=4;//全额
				}
				var ret=this.getsku(Object.toJSON(info));
				//alert("222"+ret);
				try{
					ret=ret.evalJSON();
				}catch(e){
					alert(e.message);
					return;
				}
				if(action=="BPOS_INSERT_LINE"){
					this.insertlineaction(ret,recodeType);
				}else if(action=="BPOS_INSERT_LINE_Q"){
					//$("m_retail_idx").value="";
					this.insertlineqaction(ret,recodeType);
				}
				return;
			}else if(needorgno&&this.master_data.params.pdtStyleModel&&action=="BPOS_INSERT_LINE_Q"){
   			var sql="select count(1) as c from m_pdtalias_webpos where no='"+m_retail_productno+"' or INTSCODE='"+m_retail_productno+"'";

				var ret=this.queryDateFromDB(sql);

				if(!(ret.length&&ret[0].c==1)){
					this.killAlert("r_retail_no_content",true);
					this.pdtStyleModel(jQuery.trim($("m_retail_idx").value));
					return;
				}
			}
			evt.command="DBJSON";
			evt.action="insertline";
			evt.permission="r";
		}
		//alert(evt.param);
		evt.table="m_retail";
		this._executeCommandEvent(evt);
	},
	//Activex接口，给定DB名，SQL语句查询结果集
	queryDateFromDB:function(sql,dbName){
		if(!dbName)dbName='POSBase';
		var param={};
		param.dataBaseName=dbName;
		param.sql=sql;
		var info={};
		info.param=param;
		var ret=MainApp.getSearchData(Object.toJSON(info));
		if(ret)ret=ret.evalJSON();
		if(ret.NewDataSet&&ret.NewDataSet.Table){
			return this.change2array(ret.NewDataSet.Table);
		}
		return null;
	},
	getposhook:function(param){
		return MainApp.GetPosHook(param);
	},
	initrefno:function(){
		this.master_data.refno=this.createrefno();
	},
	//ACTVIEX查询本地单据
	searchOrder:function(param){
		if(this.offline==true&&isIE()){
		return	MainApp.searchOrder(param);
		}
	},
	//ACTIVEX 根据参数设置 选择更新或者不更新
	updatedb:function(){
		if(this.offline==true&&isIE()){
			MainApp.Login();
		}
	},
	//ACTIVEX 打开读卡器（奥康）
	readvip:function(){ 
		var cardno="";
		if(this.offline==true&&isIE()&&this.master_data.params.company){
				switch(jQuery.trim(this.master_data.params.company)) {
					case "aokang":
						try{
							cardno=MainApp.ReadVip();
							if(!cardno||cardno=="")cardno=MainApp.ReadVIP_MW();
						}catch(e){
							cardno=MainApp.ReadVIP_MW();
						}
						break;
					case "bsw":
						var ret = MainApp.GetVipCardNo().evalJSON();
						if(ret.code==1) cardno=ret.CardNo;break;
				}				
		}
		return cardno;
	},
	//ACTIVEX 挂单打印
	posprint:function(param){
		MainApp.PosPrint(param);
	},
	//ACTIVEX设置参数
	config:function(){
		if(this.offline==true&&isIE()){
			MainApp.Config();
		}
	},
	//ACTIVEX更新数据
	download:function(){
		if(this.offline==true&&isIE()){
			if(this.items_data.length>0){
				alert("本单已有明细，不可更新！");
			}else{
				MainApp.Download();
				//this.CacheData();
			}
		}
	},
	//add by robin 20110815 ACTVIEX接口 更新流水号，这个只有在零售付款后和挂单成功后才调用
	updateSerialNumber:function(){
		var info={};
		var param={};
		param.billdate=$("sys_date").value;
		param.c_store_id=this.master_data.c_store_id;
		info.param=param;
		MainApp.UpdateDocno(Object.toJSON(info));
	},
	//调用ACTIVEX，生成refno
	createrefno:function(){
		var info={};
		var param={};
		param.c_store_id=this.master_data.c_store_id;
		var d=new Date();
		param.billdate=d.getFullYear()+zeroize(d.getMonth()+1)+zeroize(d.getDate());
		param.refcode=(d.getHours()*3600+d.getMinutes()*60+d.getSeconds()).toString(32);
		info.param=param;
		//alert(Object.toJSON(info));
		var a;
		try{
			a=MainApp.GetRefno(Object.toJSON(info));
		}catch(e){
			alert(e.message);
		}
		//alert(2);
		return a;
	},
	setvip:function(param){
		//alert(param);
		MainApp.Call2("SetVip",param);
	},
	//ACTIVEX 获得挂单数 跟新到页面
	gethookcount:function(){
			var info={};
			var param1={};
			param1.storeid=this.master_data.c_store_id;
			param1.billdate=$("sys_date").value;
			info.param=param1;
			var r=MainApp.GetHookCount(Object.toJSON(info));
			$("restordernum").innerHTML=r||"0";
	},
	//打印前一张单据
	printpreorder:function(){
		if(!this.printInfo.param){
			alert("没有单据可以打印！");
			return;
		}
		this.printInfo.param.reprint=true;
		this.printorder(Object.toJSON(this.printInfo));
	},
	//ACTIVEX 传入参数this.master_data
	setparm:function(param,online){
		MainApp.SetParm(param);
		if(online)
		MainApp.SetHiddenConfigFile("storeId"+this.master_data.c_store_id,param);
	},
	//ACTIVEX 验证总额折扣
	checkdis:function(param){
		return MainApp.CheckDis(param);
	},
	//ACTIVEX 本地打印小票 根据 JSON打印
	printorder:function(param){
		//alert(param);
		var count=parseInt(this.locationConfig.PosConfig.小票联打次数,10);
		if(isNaN(count)||count<1)count=this.master_data.params.printCount;
		MainApp.printOrder(param);
		if(count>1){
			for(var i=0;i<count-1;i++){		
				MainApp.printOrder(param);			
			}
		}	
	},
	//调用ACTIVEX控件，处理挂单,显示挂单列表
	getposhooks:function(param){
		return MainApp.GetPosHooks(param);
	},
	//调用ACTIVEX控件，挂单
	poshook:function(param){
		return MainApp.PosHook(param);
	},
	//调用ACTIVEX控件，获得条码信息
	getsku:function(param){
		//alert(param);
		return MainApp.GetSku(param);
	},
	//调用ACTIVEX控件，获得批量录入条码信息
	getskus:function(param){
		//alert(param);
		return MainApp.GetSkus(param);
	},
	getBarcode:function(){
		return $("m_retail_idx").value.strip().toUpperCase();
	},
	//输入原单号和条码 调用退货ACTION 20100807
	checkretailno:function(orgno,search_ret){	
		var m_retail_productno=$("m_retail_idx").value.strip().toUpperCase();
		var m_retail_type=this.itemtype+"";
		var m_retail_qty =-1;	
		var needorgno=orgno==""?false:true;
		//alert(orgno);
		//alert(Object.toJSON(search_ret));
		if($("search_condition")&&$("search_condition").value=="2"&&!search_ret){
			this.search_end=1;
			this.insertline_action("BPOS_RET_FUZZYQUERY",m_retail_productno,m_retail_qty,m_retail_type,orgno,"","",needorgno);
			return;
		}
		//alert(m_retail_productno+" : "+m_retail_qty+" : "+m_retail_type+" : "+orgno+" : "+needorgno);
		this.insertline_action("BPOS_INSERT_LINE_Q",m_retail_productno,m_retail_qty,m_retail_type,orgno,"","",needorgno);
	},
	show_search:function(ret){
		var retailno="";
		var storename="";
		var vipno="";
		var saler="";
		var retaildata="";
		if(jQuery.trim($("retailno").value)){
			retailno=jQuery.trim($("retailno").value);
		}
		if(jQuery.trim($("storenamer").value)){
			storename=jQuery.trim($("storenamer").value);
		}
		if(jQuery.trim($("vipno").value)){
			vipno=jQuery.trim($("vipno").value);
		}
		if(jQuery.trim($("saler").value)){
			saler=jQuery.trim($("saler").value);
		}
		if(jQuery.trim($("retaildata").value)){
			retaildata=jQuery.trim($("retaildata").value);
		}
		//ret.org_billdate单据日期，retailno单据编号
		//（this.master_data.c_store_name当前店仓名称）应是获取的，（this.vip.cardnoVIP当前卡号）获取VIP卡号，ret.m_retail_saler姓名，ret.org_qty数量，(ret.m_retail_pricelist*ret.org_qty)总金额
		//alert(retailno+" : "+storename+" : "+vipno+" : "+saler+" : "+retaildata+";"+ret.org_qty+";"+ret.m_retail_pricelist+";"+(ret.m_retail_pricelist*ret.org_qty));
		//根据条件查询时，弹出显示信息框
		//alert("grac:"+Object.toJSON(ret)+":length:"+ret.length);
		var ele=Alerts.fireMessageBox({
    	width:858,
     	modal:true,
     	title:gMessageHolder.EDIT_MEASURE
	   });
	  var strTemp ="";
		var count =0;
		if(ret.length)count=ret.length;
		var b=0;
		var sStrp="";
		var salername="";
		var totmt=0.0;
		if(count==0){
			strTemp=strTemp+"<div id=\"quit-search\" class=\"desc-txt\"><font color=\"red\"><center>当前店铺没有退货记录!</center></font></div>";
			strTemp = strTemp+ "<div id=\"qsearch_text\" align=\"center\">"+
				"<input type=\"button\" tabindex=1 value=\"确定\" onclick=\"javascript:bpos.qsearch_ok();\" class=\"qinput\" id=\"qsearch_ok\"/></div>";
		}else{
			strTemp = strTemp+"<div id=\"quit-search\" class=\"desc-txt\">"+
					"<div id=\"qsearch_td\"><div id=\"qsearch_text\">原单退货：查询结果信息</div>"+
					"<div class=\"treatmentLL-table\">"+
					"<div class=\"treatmentLL-table-head\">"+
					"<div class=\"treatmentLL-span-1\">序号</div>"+
					"<div style=\"display:none;\"></div>"+
					"<div class=\"treatmentLL-span-4\">单据日期</div>"+
					"<div class=\"treatmentLL-span-11\">单据编号</div>"+
					"<div class=\"treatmentLL-span-4\">店仓</div>"+
					"<div class=\"treatmentLL-span-4\">VIP卡号</div>"+
					"<div class=\"treatmentLL-span-5\">VIP姓名</div>"+
					"<div class=\"treatmentLL-span-8\">总数量</div>"+
					"<div class=\"treatmentLL-span-5\">总成交金额</div>"+
					"<div class=\"treatmentLL-span-11\">备注</div></div></div>"+
					"<div id=\"qsearch-main\" class=\"treatmentLL-sidebar\" style=\"font-size: 14px;color:#000000; height: 130px; width: 854px; visibility: visible; opacity: 1;\">";
					
				for(var a=0;a<count;a++){		
					b = a+1;
				  strTemp = strTemp+"<div class=\"treatmentLL-row\">"+
						"<div id=\"divrowline"+b+"\" class=\"treatmentLL-row-line\">"+
						"<div id=\"divinputrowline"+b+"\" class=\"treatmentLL-span-1\"><input id=\"q_search_radio"+b+"\" value=\""+b+"\" name=\"q_ret_radio\" type=\"radio\" />"+b+"</div>"+
						"<div style=\"display:none;\"></div>"+
						"<div class=\"treatmentLL-span-4\">"+(ret[a].billdate?ret[a].billdate:"-")+"</div>"+
						"<div class=\"treatmentLL-span-11\">"+(ret[a].refno?ret[a].refno:"-")+"</div>"+
						"<div class=\"treatmentLL-span-4\">"+(ret[a].storename?ret[a].storename:"-")+"</div>"+
						"<div class=\"treatmentLL-span-4\">"+(ret[a].vip_no?ret[a].vip_no:"-")+"</div>"+
						"<div class=\"treatmentLL-span-5\">"+(ret[a].vip_name?ret[a].vip_name:"-")+"</div>"+
						"<div class=\"treatmentLL-span-8\">"+(ret[a].tot_qty?ret[a].tot_qty:"-")+"</div>"+
						"<div class=\"treatmentLL-span-5\">"+(ret[a].tot_amt?ret[a].tot_amt:"-")+"</div>"+
						"<div class=\"treatmentLL-span-11\"></div></div></div>";								
				}
				
			strTemp = strTemp+ "</div></div><div id=\"qsearch_td\" align=\"center\"><div id=\"qsearch_text\">"+
				"<input type=\"button\" tabindex=1 value=\"确定\" onclick=\"javascript:bpos.qsearch_ok(1);\" class=\"qinput\" id=\"qsearch_ok\"/>&nbsp;"+
				"<input type=\"button\" tabindex=3 value=\"取消\" onclick=\"javascript:bpos.qsearch_ok(2);\" class=\"qinput\" id=\"qsearch_nok\" /></div>"+
				"</div></div></div>";
			}
			//alert(strTemp);
			ele.innerHTML = strTemp;
			bpos.executeLoadedScript(ele);
			bpos.noAlert=false;
			jQuery("#q_search_radio1").attr("checked",true);
			if(count==0){
				jQuery("#qsearch_ok").focus();
			}else{
				jQuery("#q_search_radio1").focus();
			}
			//控制div内tab上下左右键
			var ipt1;
			var radi;
			jQuery("#quit-search").bind("keydown",function(event){
				var ins = jQuery("#quit-search input[type='radio']");
				var aInp = jQuery("#quit-search input[type='button']");			
				if(event.which==40){
					var index=0;
					if(radi){
						index=ins.index(radi)+1;
					}
					if(!ins[index])index=0;
					radi=ins[index];
					radi.focus();
				}else if(event.which==9){		
					event.stopPropagation();
					event.preventDefault();
					var index=0;
					if(ipt1){
						index=aInp.index(ipt1)+1;
					}
					if(!aInp[index])index=0;
					ipt1=aInp[index];
					ipt1.focus();					
				}else if(event.which==13){
					if(event.target!=$("qsearch_nok")){
						bpos.qsearch_ok(1);
					}else{
						bpos.qsearch_ok(2);
					}
				}
			});
			
	},
	qsearch_ok:function(qdata){
		//alert(qdata);
		if(qdata&&qdata=="1"){
			var a2=jQuery("#quit-search input[name='q_ret_radio']:checked").attr("id");	
			var a3=jQuery("#"+a2).val();	
			//alert(jQuery("#quit-search input:radio").length+";"+a2+":"+a3);
			this.search_end=0;
			this.checkretailno(this.q_data[a3-1].refno,this.q_data[a3-1]);
		}
		this.killAlert("quit-search","noResetType");
		if(qdata&&qdata=="2"){
			bpos.noAlert=false;
			jQuery("#search_condition").focus();
			this.search_end=0;
		}
		if(!qdata)bpos.killAlert("r_retail_no_content");
	},
	neglect :function(){
		this._editretailprice();
	},   
	changnumber:function(){
		if((this.MODEL&this.CHANGENUM)!=this.CHANGENUM){
			alert("该单不可修改数量！");
			return;
		}
		if(this.nosalererror()){
			return
		}
		var obj=jQuery("#from-main input:checked");
		var j=obj.length;
		if(j!=1){
			alert("没有选择或多选了！");
		}else{
			var k=parseInt(obj.val(),10);
			var item=this.getitembylinenofromitems_data(k);
			//var itemtype=this.value2type(item.type);
			/**20110414修改 退货可以改数量 有没问题？
     	if(itemtype=="退货"){
     		alert("退货不能改数量！");
     		return;
     	}*/
     	if(item.locked==1){
     		alert("该明细不可修改！");
     		return;
     	}
	  	var ele = Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML= $("num").innerHTML.replace(/TMP/g,"");
						this.executeLoadedScript(ele);
				
				this.noAlert=false;
				$("retail_num").value=Math.abs(item.qty);
				$("retail_id").value=k;
	    	var retail_numx=$("retail_num");
	    	dwr.util.selectRange(retail_numx, 0,15);
	    	var a;
	    	jQuery("#num_content").bind("keydown",function(event){
	    		var inputs=jQuery("#retail_num,#ok,#cancle");
	    		if(event.which==9){
	    	    	event.stopPropagation();
					    event.preventDefault();
	    			  var index=0;
		    			if(a){
		    		   index=inputs.index(a)+1;
		    			}
		    			if(inputs[index]&&inputs[index].disabled==true)index++;
		    			if(!inputs[index]){
		    				 index=0; 
		    			}
		    		  a=inputs[index];
						  a.focus();
					}else if(event.which==13){
					      var d=inputs[index];
	      		 	  jQuery(d).click();
					 }
	    		});
 	  }
	},
  changnum:function(){
   	var i=$("retail_id").value;
   	i=parseInt(i);
   	var item=this.getitembylinenofromitems_data(i);
   	var num=$("retail_num").value;
   	num=parseInt(num,10);
 		if(num<1){
 			alert("请输入大于0的数！");
 			return;
 		}
 		if(item.org_qty>0&&num>item.org_qty){
 			alert("退货的数量不可大于原单的数量："+item.org_qty);
 			return;
 		}
   	if(!isNaN(num)&&item&&num!=item.qty){
   		var item1={};
   		item1.qty=num;
   		this.manualupdateitem(i,item1);
   	}     	
		this.cancelnum();
		this.clearchecked("from-main");
  },
	cancelnum:function(){ 
		$("m_retail_idx").value="";
		this.killAlert("num_content");
	},
	changprice :function(){
		if((this.MODEL&this.CHANGEAMOUNT)!=this.CHANGEAMOUNT){
			alert("该单不可修改金额！");
			return;
		}
		if(this.nosalererror()){
			return;
		}
		var obj=jQuery("#from-main input:checked");
		var j=obj.length;
		if(j!=1){
			alert("没有选择或多选了！");
		}else{
		//	alert(bpos.master_data.params.verifyPermission);
	    if(bpos.master_data.params.verifyPermission=="true"){
	        bxl.validateEmployee("price");
	        return;
	    }else{
	    	 bpos.updateprice();
	    }
 }},
 updateprice:function(){
 		var obj=jQuery("#from-main input:checked");
		var j=obj.length;
 		var k=parseInt(obj.val(),10);
			var item=this.getitembylinenofromitems_data(k);
			var itemtype=this.value2type(item.type);
			if(itemtype=="退货"||itemtype=="全额"||itemtype=="赠品"){
		   		alert("促销、退货、全额及赠品不能改金额！");
		  }else{	
				  this.tempretailid =k;  
					var ele = Alerts.fireMessageBox(
							{
								width: 398,
								modal: true,
								title: gMessageHolder.EDIT_MEASURE
							});
					ele.innerHTML= $("amt").innerHTML.replace(/TMP/g,"");
					this.executeLoadedScript(ele);
					//alert(Object.toJSON(this.items_data));
					this.noAlert=false;
					var discountlimit=this.master_data.discountlimit;
					//alert(Object.toJSON(item));
					discountlimit=discountlimit>item.lowest_discount?discountlimit:item.lowest_discount;
					$("minrate").innerHTML=discountlimit;
			    $("minprice").innerHTML=this.alg(item.pricelist.mul(discountlimit),true);
			    $("maxprice").innerHTML=this.alg(item.pricelist.mul(1-discountlimit),true);
			    this.master_data.discountlimit=discountlimit;
			  var discount_0x=$("discount_0");
				discount_0x.focus();
				var s;
				var many=jQuery("#treatment_table input[type='radio']");
				var radio=many[0];
				jQuery(radio).click();
				if(this.master_data.params.showLowestDisprice=="true"){
					jQuery("#discount0,#discount1,#discount2").show();
					jQuery("#zody_btn_sOh").hide();
				}
				var inputs=jQuery("#btn-ok,#cancle");
      	jQuery("#amt_content").bind("keydown",function(event){
      		 if(event.which==9){
    		 		event.stopPropagation();
						event.preventDefault();
			     	var index=0;				   
			      if(s){
			    	  index=inputs.index(s)+1;
			    	  }	
			    	if(inputs[index]&&inputs[index].disabled==true)index++;			    	
	    		  if(!inputs[index]){					    		
	    		    index=0;
	    		   }
	           s=inputs[index];
	           s.focus();
        }else if(event.which==13){
        	if(event.target!=$("btn-ok")&&event.target!=$("cancle"))
	 	       	bpos.changamt();
        }else if(event.which==40){
      		 		
      		 	var index=0;
      			if(radio){
    			   index=many.index(radio)+1;
    			  } 	    
		      	if(!many[index]){
			        index=0;
    		 		}
    		 		jQuery(many[index]).attr("checked", true);
			     	radio=many[index];
      		  jQuery(radio).click();
       }else if(event.which==38){	
				    var len=many.length;
				    var index=0;
				    if(radio){
				    		index=many.index(radio)-1;
				    }
		        if(index<0){
				      index=len-1;
					 	}	
			 		jQuery(many[index]).attr("checked", true);
			    radio=many[index];
			    jQuery(radio).click();
      }else if(event.ctrlKey==true&&event.which==39){
      	if(!this.master_data.params.showLowestDisprice=="true"){
					bpos.show2_Model();
				}
			}
     });
			}	  
		
	
 	},
 	show2_Model:function(){
		jQuery("#discount0").toggle();
		jQuery("#discount1").toggle();
		jQuery("#discount2").toggle();
	},
	changamt:function(){
		var obj3,obj2;
		var item=this.getitembylinenofromitems_data(this.tempretailid);
		var k;
    var flag=1;
 		var temp1="";
    obj3=document.getElementsByName("radio_amt"); 
    obj2=document.getElementsByName("m_retail");
    var discountlimit=this.master_data.discountlimit;
		for(var i=3;i<obj3.length;i++){
	     	if(obj3[i].checked){
	     		k=i-3;
	     		if($("discount_"+k).value==""){
	     			 alert("请输入相关数据！");
	     			 flag=0;
	     		}else{
	     			 if(k==0){
	     			 	var disa=parseFloat($("discount_0").value);
	     			//alert("disa0:"+disa+"  "+discountlimit);
	     			 	if(isNaN(disa)||disa<discountlimit){
	     			 		$("discount_0").value="";
		     				alert("你输入的折扣率不正确！");
		     			  flag=0;		
	     			 	}else if(disa>1&&!this.discountCanLgOne){
	     			 		$("discount_0").value="";
		     				alert("折扣率不允许大于1！");
		     			  flag=0;		
	     			 	}
	     		   }
	     			if(k==1){
	     				var amounta=parseFloat($("discount_1").value);
	     			//alert("amounta1:"+amounta+"  :"+this.alg(discountlimit.mul(item.pricelist)));
	     				if(isNaN(amounta)||amounta<this.alg(discountlimit.mul(item.pricelist))){
	     						$("discount_1").value="";	     				
			     				alert("你输入的特价金额不正确！");
			     				flag=0;	     			
	     				}else if(amounta>item.pricelist&&!this.discountCanLgOne){
	     						$("discount_1").value="";	     				
			     				alert("特价金额不容许大于零售价！");
			     				flag=0;	     			
	     				}
	     		  }
		     		if(k==2){
		     			var disamounta=parseFloat($("discount_2").value);
	     			//alert("disamounta2:"+disamounta+"　　"+this.alg(item.pricelist.sub(discountlimit.mul(item.pricelist))));
		     			if(isNaN(disamounta)||disamounta<0||disamounta>this.alg(item.pricelist.sub(discountlimit.mul(item.pricelist)))){
	     						$("discount_2").value="";	     				
			     				alert("你输入的优惠金额不正确！");
			     				flag=0;	     			
	     				}
		     		}
	     	  }
	     	}	
	    } 
	    if(flag==1){
	    	//Edit by Robin 20100719
	    	var temp2="";
       	if(k==0){
        	temp2 =$("discount_0").value;	     		        	
        	temp2=isNaN(parseFloat(temp2))?0.00:parseFloat(temp2);
          temp1=temp2.mul(item.pricelist);
        }else if(k==1){
            temp1=$("discount_1").value;
            temp2=isNaN(parseFloat(temp1))?0.00:parseFloat(temp1);
            temp2=item.pricelist==0?0:temp2.div(item.pricelist);
        }else if(k==2){
        		var preferential=parseFloat($("discount_2").value);
        		preferential=isNaN(preferential)?0:preferential;
            temp1=(item.pricelist-preferential).toString();
            temp2=isNaN(parseFloat(temp1))?0.00:parseFloat(temp1);
            temp2=item.pricelist==0?0:temp2.div(item.pricelist);
        }		       	
	      var m_retail_productno=$("m_retail_idx").value;
	      $("m_retail_idx").value="";	
	      //20100917折扣 ACTIVEX 不能用 临时增加
	      if(this.offline==true&&isIE()){
	      	var item1={};
	      	item1.discount=temp2;
	      	this.manualupdateitem(this.tempretailid,item1);
					this.clearchecked("from-main");
	      }else{
	     	 	this.insertline_action("BPOS_CHANGAMT",item.productno,item.qty,item.type,"",temp1,temp2);	
	    	}
	    	//end
	      this.killAlert("amt_content");
	   }
	},
	/**
	*Edit by Robin 2010.7.15
	*验证价格格式
	*/
	checkamount:function(v){
	 	var count=jQuery("#discount_"+v).val();
		if(count){	
			count=parseFloat(count);
		 	if(isNaN(count)){
		 		alert("数字格式不正确！");
		 		jQuery("#discount_"+v).val("");
		 		jQuery("#discount_"+v).focus();
		 	}else{
		 		jQuery("#discount_"+v).val(count);
		 	}
	 }
	},
	/**
	*Edit by Robin 2010.7.15
	*验证折扣率
	*/	
	 checkdiscount:function(){
	 	var count=jQuery("#discount_0").val();
		if(count){
		 	count=parseFloat(count);
	 		if(count<0||isNaN(count)){
		 		alert("折扣率不正确！");
		 		jQuery("#discount_0").val("");
		 		jQuery("#discount_0").focus();
		 	}else if(count>0){
		 		if(1<count&&!this.discountCanLgOne){
		 			alert("折扣率不可大于1");
		 			jQuery("#discount_0").val("");
		 			jQuery("#discount_0").focus();
		 		}else{
		 			jQuery("#discount_0").val(count);	
		 		}
		 		
		 	}
	 }
	},
	changamtaction:function(ret,discount){
		var item={};
		if(discount){
			item.discount=discount;
		}else{
			item.discount=parseFloat(ret.m_retail_discount);
		}
		//alert(Object.toJSON(ret));
		this.manualupdateitem(this.tempretailid,item);
		this.clearchecked("from-main");
	},
	//Edit by Robin 20100721 	     	 		    
  _changamt :function(e){
		var data=e.getUserData(); // data
		var ret=data.jsonResult.evalJSON();
		this.changamtaction(ret);
	},
	//ACTIVEX 总单策略方法
	wholedis:function(param){
		return (MainApp.WholeDis(param)).evalJSON();
	},	     
	//activex总单策略执行
	//edit by robin 20101224 增加参数 items 总单策略 不一定针对 this.items_data 如：积分消费
	dowholedis:function(items){
		if((this.MODEL&this.WHOLEDIS)!=this.WHOLEDIS)return;
	if(!items)items=this.items_data;	
		var param={};
		var Table=new Array();
		for(i=0;i<items.length;i++){ 
			var item=items[i];
			var itm={};
			itm.cardno=this.vip.cardno||"1";
			itm.c_store_id=this.master_data.c_store_id;
			itm.billdate=$("sys_date").value;
			itm.m_retail_productno=item.productno;
			itm.m_retail_qty=item.qty;
			itm.m_retail_type=item.type;
			itm.m_retail_orgdocno=item.orgdocno;
			itm.m_retail_priceactual=item.priceactual;
			itm.m_retail_price=item.price;
			itm.discount=item.discount;
			itm.vipexp=this.vip.vipexp||"1";
			itm.vipbir=this.vip.birthday||"";
			//20100917 新增唯一标识lineid
			itm.lineid=item.lineno;			
			Table.push(itm);
		}
		param.Table=Table;
		var data={};
		data.param=param;
		return this.wholedis(Object.toJSON(data));
	},
	//清除所有的明细
	clearitems:function(){

		this.items_data=new Array();
		
		jQuery("#from-main").html("");
	},
	
	
	
	
	
	//处理ACTIVEX总单策略
	handlewholedis:function(items){
		if(!this.checkCanDoWholeDis())return;
		var ret;
		if(items){
			ret=this.dowholedis(items);
			this.temp_items_data=new Array();
		}else{
			ret=this.dowholedis();
		}
		
		if(ret.NewDataSet) {
			this.tdefposdis_id=parseInt(ret.NewDataSet.tdefposdis_id,10)||-1;
			this.tdefposdis_name=ret.NewDataSet.tdefposdis_name||-1;		
		}

		if(ret.NewDataSet&&ret.NewDataSet.Table){
			var items=this.change2array(ret.NewDataSet.Table);
			if(items.length>0){
				//this.clearitems();
				for(var i=0;i<items.length;i++){
					this.updateretdata2items_data(items[i],this.temp_items_data);
				}
			}
		}
	},
	getvoupayway:function(){
		var voupayways=new Array();
		for(var i=0;i<this.master_data.payways.length;i++){
			var payway=this.master_data.payways[i];
			if(payway.is_vou=='Y')voupayways.push(payway);
		}
		return voupayways;
	},
	//获取消费卡付款方式
	getconsumecardpayway:function(){
		var consumecardpayways=new Array();
		for(var i=0;i<this.master_data.payways.length;i++){
			var payway=this.master_data.payways[i];
			if(payway.isconsumecard=='Y')consumecardpayways.push(payway);
		}
		return consumecardpayways;
	},
	//得到VIP付款的payway
	getvipcardpayway:function(){
		var cashcardpayways=new Array();
		for(var i=0;i<this.master_data.payways.length;i++){
			var payway=this.master_data.payways[i];
			if(payway.iscashcard=="Y") cashcardpayways.push(payway);
		}
		return cashcardpayways;
	},
	//得到贵宾卷的payway
	getticketpayway:function(){
		var ticketpayways=new Array();
		for(var i=0;i<this.master_data.payways.length;i++){
			var payway=this.master_data.payways[i];
			if(payway.isticket=="Y") ticketpayways.push(payway);
		}
		return ticketpayways;
	},
	alertvisitantticketpage:function(isconsumecard){
		var ele = Alerts.fireMessageBox(
				{
					width: 401,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
		var payway=this.vipTicketName;
		if(isconsumecard)payway="消费卡";
		var needconsumecard=false;
		if(jQuery.trim(this.master_data.params.company)=='aokang')needconsumecard=true;
		//if(payway=="贵宾券")needconsumecard=true;
		ele.innerHTML="<div class=\"xiao_content\" id=\"xiao_content\">"+
									"<table width=\"400\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
  								"<tr><td><div class=\"xiao_td\"><div id=\"treatment_text\">请输入"+payway+"信息：</div>"+
    							"</div></td</tr><tr><td><div class=\"xiao_botder\"><ul><li><div class=\"xiaoLeft\">"+payway+"号：</div>"+
									"<div class=\"xiaoRight\"><input"+(isconsumecard&&needconsumecard?" readonly":"")+" color='red' id=\"ticketno\" name=\"\" type=\"text\"  class=\"payment-vipTxt\" /></div>"+
									"</li>"+(isconsumecard&&needconsumecard?"<li><input name=\"刷卡\" type=\"button\" class=\"btn-ka\" value=\"刷卡\" onclick=\"bpos.aokangSwipeConsumeCard();\" /></li>":(!isconsumecard?"<li><div class=\"xiaoLeft\">验&nbsp;证&nbsp;码：</div><div class=\"xiaoRight\"><input name=\"\" id=\"ticketpw\" type=\"text\"  class=\"payment-vipTxt\" /></div></li>":""))+"</ul></div></td></tr>"+
  								"<tr><td><div id=\"treatment_td\" align=\"center\"><div id=\"treatment_text\">&nbsp;"+
									"<input type=\"button\" value=\"确定\" onclick=\"bpos.dealticket("+isconsumecard+");\" class=\"qinput\" id=\"xiao_ok\"/>&nbsp;"+
									"<input name=\"Submit\" type=\"button\" onclick=\"Alerts.killAlert($('xiao_content'));\" class=\"qinput\" id=\"xiao_cancel\" value=\"取消\" /></div></div></td></tr></table></div>";
		this.executeLoadedScript(ele);
		var xiaoele=$("ticketpw");
		if(!xiaoele)xiaoele=$("ticketno");
		xiaoele.focus();
		var xiaoeles=jQuery("#ticketpw,#xiao_ok,#xiao_cancel",$("xiao_content"));
		if(!needconsumecard){
			jQuery("#ticketno").bind("keyup",function(event){
				if(event.which==13){
					bpos.dealticket(isconsumecard);
				}
			});
		}
		jQuery("#xiao_content").bind("keyup",function(event){
			if(event.which==9){
				event.stopPropagation();
				event.preventDefault();
				var index=xiaoeles.index(xiaoele);
				index++;
				if(!xiaoeles[index])index=0;
				//alert(xiaoeles[index].attr("id"));
				xiaoele=xiaoeles[index];
				xiaoele.focus();
			}else if(event.which==13){
				var ele=event.target;
				if(ele.value&&ele!=$("xiao_cancel")){
					if($("ticketpw")&&!$("ticketpw").value)$("ticketpw").focus();
					else
					$("xiao_ok").focus();
				}
			}
		});
	},
	dealticket:function(isconsumecard){
		jQuery("#xiao_content input[type='button']").attr("disabled","true");
		if(isconsumecard){
			var ticketno=jQuery.trim($("ticketno").value);	
			var store_id=$("store_id")?$("store_id").value:-1;
			if(ticketno==""){
				alert("错误：请输入卡信息！");
				jQuery("#xiao_content input[type='button']").removeAttr("disabled");
				return;
			}
			jQuery.ajax({
				type:"POST",
				url:this.URL+"getConsumeCardInfo.jsp",
				timeout:3000,
				data:"cn="+ticketno+"&storeid="+store_id,
				error:function(){
					alert("网络不畅,请稍后再试！");
					jQuery("#xiao_content input[type='button']").removeAttr("disabled");
				},
				success:function(data){
					jQuery("#xiao_content input[type='button']").removeAttr("disabled");
					data=jQuery.trim(data);
					if(data.indexOf("cardinfo")!=-1){
						var remCash=data.replace("cardinfo:","");
						remCash=parseFloat(remCash);
						if(isNaN(remCash)||remCash<=0){
							alert("余额不足");
						}else{
							bpos._ondealconsumecard(ticketno,remCash);
						}
					}else{
						alert(data);
					}
				}
			});
			return;
		}
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_CHECKTICKET";
		var ticketno="-1";
		var ticketpw=jQuery.trim($("ticketpw").value);
		if(ticketpw==""){
			alert("错误：信息不能为空！");
			jQuery("#xiao_content input[type='button']").removeAttr("disabled");
			return;
		}
		var param={"ticketno":ticketno,"ticketpw":ticketpw,"c_store_id":this.master_data.c_store_id};
		evt.param=Object.toJSON(param);
		//alert(evt.param);
		evt.table="m_retail";
		evt.action="check_ticket";
		evt.permission="r";		
		this._executeCommandEvent(evt);		
	},
	//更新this.consumecards 消费卡信息数组
	updateConsumeCardsArray:function(ticketno,remCash){
		for(var i=0;i<this.consumecards.length;i++){
			if(this.consumecards[i].cardno==ticketno) return;
		}
		var card={};
		card.cardno=ticketno;
		card.remCash=remCash;
		this.consumecards.push(card);
	},
	//根据消费卡号获取可用剩余金额
	getConsumeCardRemCashByCardNo:function(cardno){
		for(var i=0;i<this.consumecards.length;i++){
			if(this.consumecards[i].cardno==cardno)return this.consumecards[i].remCash;
		}
		return 0;
	},
	//给定卡号 获取消费卡付款总金额
	getPayAmountByConsumeCardno:function(cardno){
		var rem=0.00;
		for(var i=0;i<this.payment.length;i++){
			if(jQuery.trim(this.payment[i].remark)==cardno){
				rem=rem.add(this.payment[i].num);
			}
		}
		return rem;
	},
	//从付款明细中获取 消费卡的可用剩余金额
	getRemAmountByConsumeCardno:function(cardno){
		var rem=this.getPayAmountByConsumeCardno(cardno);
		var remCash=this.getConsumeCardRemCashByCardNo(cardno);
		return remCash.sub(rem);
	},
	showPayConsumeCardHtml:function(ticketno,remCash,payable,isvou){
		var ticketType="消费卡";
		var ticketName="卡号";
		
		var rem=this.getRemAmountByConsumeCardno(ticketno);
		var canCancle=true;
		if(isvou){
			ticketType="购物券";
			ticketName="券号";
			rem=remCash;
			if(this.vouinfo.changeItemsPrice)canCancle=false;
		}
		var remmin=rem>payable?payable:rem;
		var ele = Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: ticketType
				});
				
		ele.innerHTML="<div id=\"consumecardalert\"><div class=\"sumfooter\"><table width=\"400\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
									"<tr><td><div>"+ticketName+"：<span style='color=red'>"+ticketno+"</span> 可用余额：<span style='color=red'>"+rem+"</span></div></td></tr>"+
  								"<tr><td><div><div>请输入金额:<input id=\"consumeprice\" type=\"text\" size=\"50\" class=\"q_input\" /></div>"+
     						 	"<div id=\"consume-info\"> 应付："+payable+"</div>"+
      						"<input id=\"consumetempx\" type=\"hidden\" size=\"50\" /></div></td>"+
  								"</tr><tr><td><div align=\"center\"><div>&nbsp;<input type=\"button\" value=\"确定\" class=\"qinput\" onclick=\"bpos.dealconsumepay("+remmin+",'"+ticketno+"',"+isvou+");\"  id=\"returnconsume\"/>"+
     							(canCancle?"<input type=\"button\" value=\"取消\" class=\"qinput\" onclick=\"bpos.cancleconsume();\"  id=\"cancleconsume\"/>":"")+
									"</div></td></tr></table></div></div>";
	 this.executeLoadedScript(ele);
	 this.noAlert=false;
	 $("consumeprice").value=remmin;
	 dwr.util.selectRange($("consumeprice"),0,30);
	 jQuery("#consumeprice").bind("keyup",function(event){
	 	if(event.target==this&&event.which==13){
	 		jQuery("#returnconsume").click();
	 	}	
	 });
	 jQuery("#consumeprice").bind("blur",function(event){
	 		jQuery("#consumeprice").val(bpos.alg(jQuery("#consumeprice").val(),true,2));
	 });
	},
	killconsumepopup:function(){
		this.killAlert("consumecardalert");
		this.killAlert("xiao_content");
		this.killAlert("vouPayType");
		this.noAlert=false;
		dwr.util.selectRange($("currpay"),0,20);
	},
	//取消消费卡弹出框
	cancleconsume:function(){
		this.tempvou={};
		this.vouinfo={};
		this.killconsumepopup();
	},
	//处理消费卡付款 
	//20120709 增加 购物券付款 isvou
	dealconsumepay:function(remmin,cardno,isvou){
		
		var amount=this.alg(parseFloat($("consumeprice").value),true,2);
		if(isNaN(amount)||amount<=0||amount>remmin){
			alert("错误：价格无法解析或超出范围");
			return;
		}
		this.evaluatepayitem(this.payitem,this.temppayitem);
		var payway;
		var paywayid;
		var pyindex=0;
		if(isvou){
			 paywayid=this.voupayways[0].id;
			for(var i=0;i<this.voupayways.length;i++){
				if(this.voupayways[i].id==jQuery("#payselect").val()){
					paywayid=jQuery("#payselect").val();
					pyindex=i;
					break;
				}
			}
		}else{
			 paywayid=this.consumecardpayways[0].id;
			for(var i=0;i<this.consumecardpayways.length;i++){
				if(this.consumecardpayways[i].id==jQuery("#payselect").val()){
					paywayid=jQuery("#payselect").val();
					pyindex=i;
					break;
				}
			}
		}
		payway=this.checkpayway(paywayid);
		this.updatepayitem(payway,amount);
		if(this.CheckIsOK(this.payitem)){
			bxl.pay();
		  var payable= this.getpayableprice();
		  var paytypename;
		  if(isvou){
		  	paytypename=this.voupayways[pyindex].name;
		  	this.vouinfo.payAl=amount;
		  }else{
		  	paytypename=this.consumecardpayways[pyindex].name;
		  }
		  this.handlepaypricewhencheckisok(paytypename,amount,cardno);
		  $("payselect").selectedIndex=0;
		  this.killconsumepopup();
		}else{
			this.evaluatepayitem(this.temppayitem,this.payitem);
			dwr.util.selectRange($("consumeprice"),0,30);
			$("discription").value ="";
		}
	},
	_ondealconsumecard:function(ticketno,remCash){
		if(this.consumecardpayways.length==0){
			alert("错误：未定义消费卡付款方式");
			return;
		}
		this.updateConsumeCardsArray(ticketno,remCash);
		var payable= this.getpayableprice();
		this.showPayConsumeCardHtml(ticketno,remCash,payable);
		//this.evaluatepayitem(this.payitem,this.temppayitem);
		//this.updatepayitem(payway,remCash);
	},
	//20110602获取可付金额
	getpayableprice:function(){
		return (this.payitem.TotalAmount).sub(this.gettotpayamount());
	},
	_ondealticket:function(e){
		var data=e.getUserData();
		var ret=data.jsonResult.evalJSON();
		//alert(Object.toJSON(ret));
		jQuery("#xiao_content input[type='button']").removeAttr("disabled");
		if(ret.code&&ret.code=="-1"){
			alert(ret.msg);
			dwr.util.selectRange($("ticketpw"),0,30);
		}else{
			for(var i=0;i<bpos.ticketnos.length;i++){
				if(bpos.ticketnos[i]==ret.code){
					alert("同一"+this.vipTicketName+"只能使用一次！");
					return;
				}
			}	
			if(this.ticketpayways.length==0){
				alert("未定义"+this.vipTicketName+"付款方式！");
				return;
			}
			var isviponly=jQuery.trim(ret.isviponly);
			var isvip=jQuery.trim(ret.isvip);
			var v_vipid=parseInt(ret.vipid,10);
			if(isviponly=='Y'&&!(this.vip&&this.vip.vip_id)){
				alert("该"+this.vipTicketName+"只能用于VIP用户！");
				return;
			}
		  
			if(isvip=='Y'&&!(this.vip&&this.vip.vip_id==v_vipid)){
				alert("该"+this.vipTicketName+"为专属VIP使用!");
				return;
			}
			
			var ticketprice=parseFloat(ret.data);
			jQuery("#ticketno").val(ret.code);
			var paywayid=this.ticketpayways[0].id;
			var pyindex=0;
			for(var j=0;j<this.ticketpayways.length;j++){
				//alert(jQuery("#payselect").val()+"--"+this.ticketpayways[j].id);
				if(this.ticketpayways[j].id==jQuery("#payselect").val()){
					paywayid=jQuery("#payselect").val();
					pyindex=j;
					break;
				}
			}
			
			
			var payway=this.checkpayway(paywayid);
			this.evaluatepayitem(this.payitem,this.temppayitem);
			this.updatepayitem(payway,ticketprice);
			if(this.CheckIsOK(this.payitem)){
				bxl.pay();
				var payable= this.getpayableprice();
				//isticket 可不可以有多个？
				//alert(this.ticketpayways[pyindex].name);
				this.handlepaypricewhencheckisok(this.ticketpayways[pyindex].name,ticketprice,ret.code);
				$("payselect").selectedIndex=0;
				bpos.ticketnos.push(ret.code);
				Alerts.killAlert($('xiao_content'));
			}else{
				this.evaluatepayitem(this.temppayitem,this.payitem);
				dwr.util.selectRange($("ticketno"),0,30);
				$("discription").value ="";
			}
		}
	},
	//检验 单据中是否有打折商品，折扣大于1 不算
	checkOrderHasDis:function(){
		if(this.hasWholeDis){
			return true;
		}
		var tot=this.gettotdata();
		if(tot.totprice<tot.totpricelist){
			return true;
		}
		return false;
	},
	handlevou:function(){
		if(this.payitem.TotalAmount<this.getpaymentamount()){
			alert("已付金额大于应付金额，不可再付！");
			return;
		}
		if(this.vouinfo&&this.vouinfo.isListLimit){
			alert("同笔单据只能使用一次购物券！");
			return;
		}
		if(this.gettotpayamount()>0){
			alert("使用购物券前不能使用其他付款方式！");
			return;
		}
		this.alertvoupage();
	},
	//20120703弹购物券验证界面
	alertvoupage:function(){
		var payway="购物券";
		var ele = Alerts.fireMessageBox(
				{
					width: 401,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML="<div class=\"xiao_content2\" id=\"xiao_content\">"+
									"<table width=\"400\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
  								"<tr><td colspan=4><div class=\"xiao_td2\"><div id=\"treatment_text\">请输入"+payway+"信息：</div>"+
    							"</div></td></tr><tr><td colspan=4><div class=\"xiao_botder2\"><ul><li><div class=\"xiaoLeft\">"+payway+"号：</div>"+
									"<div class=\"xiaoRight\"><input color='red' id=\"ticketno\" name=\"\" type=\"text\"  class=\"payment-vipTxt\" /></div>"+
									"</li></ul></div></td></tr>"+
									"<tr class=\"emtb\"><td width=\"80\" align=\"right\">类型:</td><td width=\"110\"><span id=\"vouType\"></span></td><td width=\"90\" align=\"right\">姓名:</td><td width=\"110\"><span id=\"epeName\"></span></td></tr>"+
									"<tr class=\"emtb\"><td width=\"80\" align=\"right\">折后限额:</td><td width=\"110\"><span id=\"accountLimit\"></span></td><td width=\"90\" align=\"right\">有效期:</td><td width=\"110\"><span id=\"validDate\"></span></td></tr>"+
									"<tr class=\"emtb\"><td width=\"80\" align=\"right\">工号:</td><td width=\"110\"><span id=\"epeNo\"></span></td><td width=\"90\"  align=\"right\"><span style=\"display:none\">账户金额:</span></td><td  width=\"110\"><span style=\"display:none\" id=\"amtAcount\"></span></td></tr>"+
									
  								"<tr><td colspan=4><div id=\"treatment_td\" align=\"center\"><div id=\"treatment_text\">&nbsp;"+
									"<input type=\"button\" value=\"确定\" onclick=\"bpos.confirmedVou();\" class=\"qinput\" id=\"xiao_ok\"/>&nbsp;"+
									"<input name=\"Submit\" type=\"button\" onclick=\"Alerts.killAlert($('xiao_content'));\" class=\"qinput\" id=\"xiao_cancel\" value=\"取消\" /></div></div></td></tr></table></div>";
		this.executeLoadedScript(ele);
		var xiaoele=$("ticketpw");
		if(!xiaoele)xiaoele=$("ticketno");
		xiaoele.focus();
		var xiaoeles=jQuery("#ticketpw,#xiao_ok,#xiao_cancel",$("xiao_content"));
		jQuery("#ticketno").bind("keyup",function(event){
			if(event.which==13){
				bpos.dealvou();
			}
		});
		jQuery("#xiao_content").bind("keyup",function(event){
			if(event.which==9){
				event.stopPropagation();
				event.preventDefault();
				var index=xiaoeles.index(xiaoele);
				index++;
				if(!xiaoeles[index])index=0;
				//alert(xiaoeles[index].attr("id"));
				xiaoele=xiaoeles[index];
				xiaoele.focus();
			}else if(event.which==13){
				var ele=event.target;
				if(ele.value&&ele!=$("xiao_cancel")){
					$("xiao_ok").focus();
				}
			}
		});
	},
	//20120703处理购物券
	dealvou:function(){
		jQuery("#xiao_content input[type='button']").attr("disabled","true");
		var ticketno=jQuery.trim($("ticketno").value);	
		var store_id=$("store_id")?$("store_id").value:-1;
		if(ticketno==""){
			alert("错误：请输入卡信息！");
			jQuery("#xiao_content input[type='button']").removeAttr("disabled");
			return;
		}
		jQuery.ajax({
			type:"POST",
			url:this.URL+"getConsumeCardInfo.jsp",
			timeout:3000,
			data:"cn="+ticketno+"&storeid="+store_id+"&isvou=true",
			error:function(){
				alert("网络不畅,请稍后再试！");
				jQuery("#xiao_content input[type='button']").removeAttr("disabled");
			},
			success:function(data){
				jQuery("#xiao_content input[type='button']").removeAttr("disabled");
				data=jQuery.trim(data);
				var ro=data.evalJSON();
				if(ro.code&&ro.code==200){
					bpos._ondealvou(ro.meg);
				}else{
					alert(ro.meg);
				}
			}
		});
	},
	/**
	 *add by robin 20120705
	 *判断是否可使用购物券打折。
	 *1.判断是否符合折后限额。即当 是否正价为 是的时候 取标准价之和 * 购物券折扣 < 折后限额，当是否正价为 否是 同理
	 *2.折扣是否<1；若等于1 表示 该购物券不是使用折扣的类型
	 *3.增加数量限制，即折扣不能超过规定件数 add 20121109
	 */
	checkvoucandis:function(tot){
		if(!tot)tot=this.gettotdata();
		var disamt;
		if(this.vouinfo.qtyLimit>0&&tot.totqty>this.vouinfo.qtyLimit){
			//alert("超过最高数量限制，不能打折！");
			return false;
		}
		if(this.vouinfo.isListLimit=='Y'){
			disamt=(tot.totpricelist).mul(parseFloat(this.vouinfo.vouDis));
		}else{
			disamt=(tot.totprice).mul(parseFloat(this.vouinfo.vouDis));
		}
		if(parseFloat(this.vouinfo.accountLimit)>=disamt&&this.vouinfo.vouDis<1&&this.gettotpayamount()==0){
			return true;
		}else{
			 //alert("超过最高折扣限额或不符合条件！");
			 return false
		};
	},
	/**
	 *add by robin 20130121
	 *显示购物券信息
	 *
	 */
	showVouInfo:function(vou){
		jQuery("#vouType").html(vou.vouType||"");
		jQuery("#epeNo").html(vou.epeNo||"");
		jQuery("#epeName").html(vou.epeName||"");
		jQuery("#amtAcount").html(vou.amtAcount||"");
		jQuery("#validDate").html(vou.validDate||"");
		jQuery("#accountLimit").html(vou.accountLimit||"");
	},
	checkvoucanpayprice:function(){
		if(this.vouinfo.amtAcount>0&&this.gettotpayamount()==0)return true;
		//alert("余额不足或不满足条件！");
		return false;
	},
	/**
	 *add by robin 20130123 当可以购物券可以打折也可以使用账户余额时，需要用户选择使用哪个方式，或者全部使用
	 */
	checkVouPayType:function(){
		var multi=this.vouinfo.isAccayAfterDis=='N'?false:true;
		var inpt=multi?"checkbox":"radio";
		var htmlStr="<div id=\"vouPayType\" class=\"xiao_content\">"+
						"<table width=\"300\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
						  "<tr>"+
							"<td><div class=\"xiao_td\">"+
							  "<div id=\"treatment_text\">请选择使用方式：</div>"+
							"</div></td>"+
						  "</tr>"+
						  "<tr>"+
							"<td><div class=\"xiao_botder\">"+
							"<ul>"+
							"<li>"+
							"<div class=\"xiaoLeft\"><input id=\"vouCanPay\" checked=\"true\" value=\"canPay\" name=\"vouPayType\" type=\""+inpt+"\"/>"+
							"</div>"+
							"<div class=\"xiaoRight\">使用账户金额</div>"+
							"</li>"+
							"<li>"+
							"<div class=\"xiaoLeft\"><input name=\"vouPayType\" value=\"canDis\" id=\"vouCanDis\" type=\""+inpt+"\" /></div>"+
							"<div class=\"xiaoRight\">使用折后限额</div>"+
							"</li>"+
							"</ul>"+
							"</div>"+
							"</td>"+
						  "</tr>"+
						  "<tr>"+
							"<td><div  class=\"VIP-td\" align=\"center\">&nbsp;"+
						"<input type=\"button\" value=\"确定\"  class=\"qinput\" id=\"vouPayTypeOk\"/>"+
						"&nbsp;"+
						"<input name=\"Submit\" type=\"button\" id=\"vouPayTypeCancel\"  class=\"qinput\" value=\"取消\" />"+
							"</div></td>"+
						  "</tr>"+
						"</table>"+
						"</div>";
			var ele = Alerts.fireMessageBox({
							width: 300,
							modal: true,
							title: gMessageHolder.EDIT_MEASURE
						});
			ele.innerHTML = htmlStr;
			this.executeLoadedScript(ele);
			this.noAlert=false;
			$("vouCanPay").focus();
			jQuery("#vouPayTypeOk").bind("click",function(){
				bpos.vouinfo.canDis=jQuery("#vouCanDis").is(":checked");
				bpos.vouinfo.canPay=jQuery("#vouCanPay").is(":checked");
				if(!bpos.vouinfo.canDis&&!bpos.vouinfo.canPay){
					alert("必须选择一种方式！");
					return;
				}
				bpos.doVouPay();
			});
			jQuery("#vouPayTypeCancel").bind("click",function(){
				bpos.killAlert2("vouPayType");
			});	
		  	
	},
	doVouPay:function(){
		var disamt;
		var discount=this.vouinfo.vouDis;
		var tot=this.gettotdata(this.temp_items_data);
		if(this.vouinfo.isListLimit=='Y'){
			disamt=(tot.totpricelist).mul(parseFloat(this.vouinfo.vouDis));
		}else{
			disamt=(tot.totprice).mul(parseFloat(this.vouinfo.vouDis));
		}
		this.vouinfo.changeItemsPrice=false;
		/**
		if(candis&&canpay){
			if(this.vouinfo.isAccayAfterDis=='N'){
				if(!confirm("账户余额与折扣不能同时使用，是否购物券折扣？"))candis=false;
				else canpay=false;
			}
		}*/
		if(this.vouinfo.canDis||(this.vouinfo.isListLimit=='Y'&&tot.totpricelist!=tot.totprice)){
			if(!this.vouinfo.canDis){
				disamt=tot.totpricelist;
				discount=1;
			}else{
				
				this.vouinfo.useDis=true;
			}
			if(this.vouinfo.isListLimit=='Y')
				this.handlewholediscount(this.temp_items_data,discount,disamt,tot.totprice);
			else
				this.dodiscountwithamount(this.temp_items_data,discount,disamt,tot.totprice);
			this.initpaypriceAmount(this.temp_items_data);
			this.initpaypricehtml(disamt);
			this.vouinfo.changeItemsPrice=true;
		}
		if(!this.vouinfo.canPay){
			$("payselect").selectedIndex=0;
		  this.killconsumepopup();
		  return;
		}
		var payable= this.getpayableprice();
		this.showPayConsumeCardHtml(this.vouinfo.vouNo,this.vouinfo.amtAcount,payable,true);
	},
	/**
	 *add by robin 20130121
	 *增加用户确认购物券无误确定后，实际处理购物券的方法
	 */
	confirmedVou:function(){
		this.vouinfo=this.tempvou;
		this.vouinfo.payAl=0.00;
		this.vouinfo.useDis=false;
		
		
		this.vouinfo.qtyLimit=isNaN(parseInt(this.vouinfo.qtyLimit,10))?0:parseInt(this.vouinfo.qtyLimit,10);
		var tot=this.gettotdata(this.temp_items_data);
		var candis=this.checkvoucandis(tot);
		var canpay=this.checkvoucanpayprice();
		if(!candis&&!canpay){
			alert("不能使用！");
			return;
		}
		this.vouinfo.canDis=candis;
		this.vouinfo.canPay=canpay;
		if(candis&&canpay)
			this.checkVouPayType();
		else
			this.doVouPay();
	},
	_ondealvou:function(vou){
		if(vou.isValid=='N'){
			alert("该购物券已被使用！");
			return;
		}
		if(parseInt(vou.sysDate)>parseInt(vou.validDate)){
			alert("购物券已过期，使用截止时间："+vou.validDate);
			return;
		}
		
		this.showVouInfo(vou);
		jQuery("#xiao_ok").focus();
		this.tempvou=vou;
	},
	//Edit by Robin 20110531增加是否为消费卡的判断。 将贵宾券和消费卡合并在一起
	handlevisitantticket:function(isconsumecard){
		if(this.payitem.TotalAmount<this.getpaymentamount()){
			alert("已付金额大于应付金额，不可再付！");
			return;
		}
		if(!isconsumecard&&this.hasWholeDis&&!this.canUseTicketWhenWholeDis){
	  	alert("整单策略不可使用"+this.vipTicketName+"！");
	  	return;
	  }
	  if(!isconsumecard&&this.master_data.params.ticketnodis=="true"&&this.checkOrderHasDis()){
	  	alert("打折商品不可使用"+this.vipTicketName+"！");
	  	return;
	  }
		this.alertvisitantticketpage(isconsumecard);
	},
	//获得所有原单（退货）付款方式
	getAllOrgPayWays:function(){
		var paywayids=new Array();
		for(var i=0;i<this.items_data.length;i++){
			var item=this.items_data[i];
			var type=this.value2type(item.type);
			if(type=="退货"){
				if(item.org_payways!=-1&&item.org_payways.length>0){
					paywayids=paywayids.concat(item.org_payways);
				}
			}
		}
		if(paywayids.length>0){
			var payways=new Array();
		 a:for(var j=0;j<paywayids.length;j++){
				for(var k=0;k<payways.length;k++){
					if(payways[k].id==paywayids[j])continue a;
				}
				for(var n=0;n<this.master_data.payways.length;n++){
					if(paywayids[j]==this.master_data.payways[n].id){
						payways.push(this.master_data.payways[n]);
						break;
					}
				}
			}
			return payways;	
		}else{
			return this.master_data.payways;
		}
	},
	//获取付款时可以使用的付款方式集；主要用于退货时控制必须为原单付款方式
	getPayWays:function(totprice){
		if(totprice>0){
		
			return this.master_data.payways;
		}else{
			return this.getAllOrgPayWays();
		}
	},
	  //Edit by Robin 20100823 导入付款方式
	importpayways:function(totprice){
		
		var payways=this.getPayWays(totprice);
	
	  b:for(var i=0;i<payways.length;i++){
			 var payway=payways[i];
			//if(payway.name=="自动费用")continue;
			 if(this.master_data.params.company&&jQuery.trim(this.master_data.params.company)=='bsw'){
				 if(payway.name.search(/OK卡/i)!=-1){
					 for(var s=0;s<this.items_data.length;s++){
						 if(this.items_data[s].m_dim1&&this.items_data[s].m_dim1.search(/OK卡/i)!=-1)
						 continue b;
					 }
				 }
			 }
	    var option_node=document.createElement("OPTION");
	    option_node.innerHTML=payway.name;
	    option_node.value=payway.id;
	   
	    $("payselect").appendChild(option_node);
	  }
		
	  $("payselect").style.visibility="visible";	
	  var defaultPayway;
	  jQuery("#payselect option[text="+this.master_data.params.defaultPayway+"]").attr("selected","true");
	  //alert(Object.toJSON(this.master_data.params.defaultPayway));
	  jQuery("#payselect").bind("change",function(event){
	  	if(event.target==this){
	  		for(var s=0;s<bpos.voupayways.length;s++){
	  			if(this.value==bpos.voupayways[s].id){
	  				bpos.handlevou();
	  				return;
	  			}
	  		}
	  		for(var l=0;l<bpos.ticketpayways.length;l++){
	  			if(this.value==bpos.ticketpayways[l].id){
	  				bpos.handlevisitantticket();
	  				return;
	  			}
	  		}
	  		for(var j=0;j<bpos.consumecardpayways.length;j++){
	  			if(this.value==bpos.consumecardpayways[j].id){
	  				bpos.handlevisitantticket(true);
	  				return;
	  			}
	  		}
	  	}
	  });
	  
	},
	initvipcosume:function(vipdata){
		if(!vipdata)vipdata=this.vipaccount;
		jQuery("#vip_cardno").html(this.vip.cardno);
		jQuery("#vip_money").html(this.changenumber2yuan(vipdata.amount));
		jQuery("#vip_paymoney").html(this.changenumber2yuan(this.payitem.TotalAmount));
		jQuery("#vip_pay").html(this.changenumber2yuan(this.payitem.TotalAmount.sub(this.gettotpayamount())));
		jQuery("#vip_currpay").val(this.formatint2float(this.payitem.TotalAmount.sub(this.gettotpayamount())));
	},
	//Edit by Robin 20100823 画付款界面
	loadpaypricepage:function(){
		var ele = Alerts.fireMessageBox(
				{
					width: 620,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
		ele.innerHTML= $("pay").innerHTML.replace(/TMP/g,"").replace("VIP付款",this.vipPayTypeName);
		this.executeLoadedScript(ele);
		var sms="";
		$("next").disabled=true;
		if(this.checkUseSms())sms="<input type=\"button\" value=\"找回密码\" id=\"retailSms\" onclick=\"bpos.smsVip();\" class=\"qinput\"/>";
		if(sms)jQuery("#vip_psw").after(sms);
		if(this.vip.vip_id&&this.vip.ifcharge=='Y'&&this.checkIsOnline()){
				jQuery("#v").show();
				jQuery.post(this.URL+"getvipinfo.jsp",{"vipno":bpos.vip.cardno},function(data){
					if(jQuery.trim(data)!="error"){
						//alert(data);
						var vipdata=data.evalJSON();
						vipdata.cardno=bpos.vip.cardno;
						bpos.vipaccount=vipdata;
						bpos.initvipcosume(vipdata);
					}else{
						alert("该VIP账户不可用！");
					}
				});		
		}
		jQuery("#v").bind("click",function(){
				bpos.initvipcosume();
		});
		
		jQuery("#vip_currpay,#vip_psw").bind("keydown",function(event){
			var vippay=parseFloat(jQuery.trim(this.value));
			if(event.which==13&&event.target==this){
				if(this.id=="vip_currpay"){
					if(bpos.checkvipaccount(vippay)){
						dwr.util.selectRange($("vip_psw"),0,30);
					}
				}else if(this.id=="vip_psw"){
					$("vip_btn-search").focus();
				}
			}
		});
		jQuery("#vip_btn-search").bind("click",function(){
			var vippay=parseFloat(jQuery.trim($("vip_currpay").value));
			var vippw=jQuery.trim($("vip_psw").value);
			jQuery.post(bpos.URL+"checkvippw.jsp",{"cardno":bpos.vipaccount.cardno,"pw":vippw},function(data){
				if(jQuery.trim(data)=="true"){
					bpos.handlevippayway(vippay);
				}else{
					alert("密码错误或当前操作员无权限！");
				}
			});
		});
		jQuery("#m").bind("click",function(){
			if(!jQuery("#m").is(":visible")){
				bpos.initpaypricehtml(bpos.payitem.TotalAmount)
			}
		});
		
		this.noAlert=false;
	},
	evaluatepayitem:function(orgpayitem,destpayitem){
		destpayitem.TotalAmount=orgpayitem.TotalAmount;
		destpayitem._totalNoCashNoCharge=orgpayitem._totalNoCashNoCharge;
		destpayitem._totalCashNoCharge=orgpayitem._totalCashNoCharge;
		destpayitem._totalVipCharge=orgpayitem._totalVipCharge;
		destpayitem._totalCashCharge=orgpayitem._totalCashCharge;
	},
	
	handlevippayway:function(vippay){
		//alert(typeof(vippay));
		if(isNaN(vippay)){
			alert("请输入正确价格！");
			return;
		}
		if(!this.checkvipaccount(vippay))return;
		if(this.cashcardpayways.length==0){
			alert("未定义"+this.vipPayTypeName+"方式");
			return;
		}
		var paywayid=this.cashcardpayways[0].id;
		var pyindex=0;
		for(var i=0;i<this.cashcardpayways.length;i++){
			if(this.cashcardpayways[i].id==jQuery("#payselect").val()){
				paywayid=jQuery("#payselect").val();
				pyindex=i;
				break;
			}
		}	
		var way=this.checkpayway(paywayid);
		this.evaluatepayitem(this.payitem,this.temppayitem);
		this.updatepayitem(way,vippay);
		if(this.CheckIsOK(this.payitem)){
			bxl.pay();
			this.handlepaypricewhencheckisok(this.cashcardpayways[pyindex].name,vippay);
			this.vipaccount.amount-=vippay;
		}else{
			this.evaluatepayitem(this.temppayitem,this.payitem);
			dwr.util.selectRange($("vip_currpay"),0,30);
			$("discription").value ="";
		}
	},
	checkvipaccount:function(vippay){
		if(this.vipaccount.amount&&this.vipaccount.amount>=0){
			if(isNaN(vippay)){
				alert("请输入正确的金额！");
				return false;
			}
			if(vippay>this.vipaccount.amount){
				alert("余额不足！");
				$("vip_currpay").value=this.vipaccount.amount;
				return false;
			}
			return true;
		}else if(this.vipaccount.amount<=0){
			alert("VIP账户无余额！");
			return false;
		}else {
			alert("VIP账户不可用");
			return false;
		}
	},
	killcomfirmvipdis:function(){
		this.killAlert("comfirmvipdis");
		this.tempvipdis=null;
	},
	initconfirmvipdishtml:function(vipdis){
		//alert(Object.toJSON(vipdis));
		var tot=this.gettotdata();
		var oldtotprice
		//计算基价。即是 零售价（明细中的成交价）还是 标准价
		var basePriceList=false;
		if((vipdis.distype=='CON'&&(this.master_data.params.integralDisBasePrice&2)==2)||(vipdis.distype=='DIS'&&(this.master_data.params.integralDisBasePrice&1)==1)){
			oldtotprice=tot.totpricelist;
			basePriceList=true;
		}else{
			oldtotprice=tot.totprice;
		}

		var oldtotpricelist=tot.totpricelist;
		var totpricelimit=oldtotpricelist.mul(vipdis.discountlimit);
		var dispricelimit=oldtotprice.sub(totpricelimit)<0?0:oldtotprice.sub(totpricelimit);

		var tempvipdis={};
		tempvipdis.distype=vipdis.distype;
		tempvipdis.c_integralmin_id=vipdis.id;
		tempvipdis.isclear=vipdis.isclear;
		tempvipdis.discountlimit=vipdis.discountlimit;
		tempvipdis.integral=vipdis.integral;
		tempvipdis.basePriceList=basePriceList;
		
		var integralStr;
		var contentStr;
		var count;
		var count2;
		if(vipdis.isclear=='N'){
			tempvipdis.totintegral=0;
		}
		if(tempvipdis.distype=='CON'){
			count=Math.floor(this.vip.integral.div(vipdis.integral));
			count2=dispricelimit.div(vipdis.content);
			count=Math.min(count,count2);			
			//alert(count);
			//alert(dispricelimit);
		 if(vipdis.ismused=='N'){
				tempvipdis.content=vipdis.content;
			}
		 if(vipdis.isclear=='Y'&&vipdis.ismused=='N'){
					tempvipdis.totintegral=vipdis.integral;
		  }
		}else if(tempvipdis.distype=='DIS'){
			tempvipdis.content=oldtotprice.sub(oldtotprice.mul(vipdis.content>vipdis.discountlimit?vipdis.content:vipdis.discountlimit));
			if(vipdis.isclear=='Y'){
				tempvipdis.totintegral=vipdis.integral;
			}
		}
		var disitems=new Array();
		var multiItem=true;
		if(tempvipdis.distype=='CON'&&vipdis.isclear=='Y'&&vipdis.ismused=='Y'){
			count=Math.ceil(count);
			integralStr="<input id=\"vipdisintegral\" style=\"width:80px;border-color: #002f55 #6986a0 #6986a0 #002f55;border-style: solid;border-width: 1px;background-color: #DAE3EA;height: 18px;\"/>";
			contentStr="<span id=\"vipdiscountent\"></span>";
			for(var i=1;i<=count;i++){
				var vipdiscontent=vipdis.content.mul(i)>dispricelimit?dispricelimit:vipdis.content.mul(i);
				var disitem={};
				disitem.intl=vipdis.integral.mul(i)+"";
				disitem.cont=vipdiscontent;
				disitems.push(disitem);
			}
		}else{
			if(tempvipdis.content>dispricelimit){
				if(!confirm("积分抵扣金额为："+tempvipdis.content+"，本单可抵扣金额为："+dispricelimit+"。是否继续执行？")){
					return;
				}
				tempvipdis.content=dispricelimit;
			}
			integralStr=tempvipdis.totintegral;
			contentStr="<span id=\"vipdiscountent\">"+tempvipdis.content+"</span>";
			multiItem=false;
		}
		
		//end
		var htmlstr="<div id='comfirmvipdis' class=\"vip-back\">"+
								"<div class=\"vip-detail\">&nbsp;&nbsp;共消费积分"+integralStr+"，抵扣"+contentStr+"元。<br />&nbsp;&nbsp;是否执行？</div>"+
								"<div class=\"vip-input\">&nbsp;<input type=\"button\" value=\"确定\" class=\"qinput\" id=\"vipdisyes\"/>"+
								"&nbsp;<input name=\"Submit\" onclick=\"bpos.killcomfirmvipdis();\" type=\"button\" class=\"qinput\" value=\"取消\" id=\"vipdisno\"/></div></div>";
		var ele = Alerts.fireMessageBox(
				{
					width: 447,
					modal: true,
					title: "请确认！"
				});
		ele.innerHTML= htmlstr;
		this.executeLoadedScript(ele);
		this.noAlert=false;		
		tempvipdis.disitems=disitems;
		this.tempvipdis=tempvipdis;
		if(multiItem){
			jQuery("#vipdisintegral").focus();
			jQuery("#vipdisintegral").bind("keyup",function(event){
				if(event.which==13&&jQuery.trim(jQuery("#vipdisintegral").val())){
					jQuery("#vipdisyes").focus();
				}
			});
		}else
			jQuery("#vipdisyes").focus();
		var buttons=jQuery("#vipdisyes,#vipdisno");
		var cb=jQuery("#vipdisyes")[0];
		jQuery("#vipdisyes").bind("click",function(event){
			if($("vipdisintegral")){
				var intli=$("vipdisintegral").value;
				var con=jQuery("#vipdiscountent").html();
				var its=bpos.tempvipdis.disitems;
				var can=false;
				for(var o=0;o<its.length;o++){
					if(its[o].intl==intli&&its[o].cont==con){
						can=true;
						break;
					}
				}
				if(!can){
					alert("请填写正确的值！");
					return;
				}
			}
			bpos.executevipdis();
		});
		jQuery("#comfirmvipdis").bind("keydown",function(event){
			if(event.which==9){
					event.stopPropagation();
					event.preventDefault();
					if(cb){
						var index=0;
						if(buttons.index(cb)==0){
							index=1;
						}
						cb=buttons[index];
						jQuery(cb).focus();
					}
			}else if(event.which==37){
				jQuery(buttons[0]).focus();
			}else if(event.which==39){
				jQuery(buttons[1]).focus();
			}
		});
		/**
		if($("vipdisintegral")){
			jQuery("#vipdisintegral").bind("change",function(event){
				//alert(jQuery("#vipdisintegral").val());
				//alert(jQuery("#vipdiscountent").html());
				jQuery("#vipdiscountent").html(jQuery("#vipdisintegral").val());
			});
		}*/
		if(multiItem)
			jQuery(function() {
					jQuery('#vipdisintegral').autocomplete(disitems, {
					max: 12, //列表里的条目数
					minChars: 0, //自动完成激活之前填入的最小字符
					width: 150, //提示的宽度，溢出隐藏
					scrollHeight: 300, //提示的高度，溢出显示滚动条
					matchContains: true, //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示
					mustMatch:true,
					autoFill: true, //自动填充
					formatItem: function(row, i, max) {
					return '积分:'+row.intl + ';抵扣：' + row.cont ;
					},
					formatMatch: function(row, i, max) {
					return row.intl;
					},
					formatResult: function(row) {
					return row.intl;
					}
					}).result(function(event, row, formatted) {
						bpos.tempvipdis.content=parseFloat(row.cont);
						bpos.tempvipdis.totintegral=parseFloat(row.intl);
						jQuery("#vipdiscountent").html(row.cont);
					});
				});		
	},
	//拷贝JSON对象。不能对JSON直接赋值计算。JSON对象可能指向的是同一个内存
	copyJsonObject:function(orgObject){
		var jsonstr=Object.toJSON(orgObject);
		return jsonstr.evalJSON();
	},
	//add by robin 20101224 复制 this.items_data
	copyitems_data2temp_items_data:function(){
		this.temp_items_data=this.copyJsonObject(this.items_data);
	},
	//add by robin 20101224 执行vip促销活动，将 抵扣金额 算为 总额折扣
	executevipdis:function(){
		if(!(this.tempvipdis&&(this.tempvipdis.content||this.tempvipdis.content==0)&&(this.tempvipdis.totintegral||this.tempvipdis.totintegral==0)&&jQuery("#vipdiscountent").html())){
			alert("输入内容错误，未找到匹配项！");
			return;
		}
		this.copyitems_data2temp_items_data();
		var tot=this.gettotdata();
		var oldprice=tot.totprice;
		if(this.tempvipdis&&this.tempvipdis.basePriceList){
			oldprice=tot.totpricelist;
		}
		//alert(Object.toJSON(this.tempvipdis));
		if(this.tempvipdis){
				var discount=(1.0).sub(oldprice==0?0:(this.tempvipdis.content.div(oldprice)));
				if(!this.tempvipdis.basePriceList)
					this.dodiscountwithamount(this.temp_items_data,discount,oldprice.sub(this.tempvipdis.content),oldprice);
				else
					this.handlewholediscount(this.temp_items_data,discount,oldprice.sub(this.tempvipdis.content),oldprice);
				this.killAlert("comfirmvipdis");
				this.killAlert("VIPDISINFO");
				this.payprice(this.temp_items_data);
		 }
	},
	validateVipPw:function(){
		if(jQuery("#vippwd").val()){
			var pw=jQuery("#vippwd").val();
			if(jQuery.trim(pw)==this.vip.pass_word){
				this.killAlert("vip_validate");
				this.initconfirmvipdishtml(this.t_vipdis);
			}else{
				alert("密码不正确");
			}
		}
	},
  validateVipPwHtml:function(){
  	var sms="";
		if(this.checkUseSms())sms="<input type=\"button\" value=\"找回密码\" id=\"retailSms\" onclick=\"bpos.smsVip();\" class=\"qinput\"/>";
  		var ele =Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});			 
			 ele.innerHTML="<div id=\"vip_validate\"><table width=\"400\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
       "<tr>"+
       "<td><div id=\"user_botder\">"+
	     "<ul>"+
	     "<li><div class=\"user-left\">请输入密码：</div><div class=\"user-right\"><input id=\"vippwd\" name=\"vippwd\" type=\"password\" class=\"user-input\" /></div></li>"+
	     "</ul></div></div></td></tr> <tr><td><div id=\"treatment_td\" align=\"center\"><div id=\"treatment_text\">&nbsp;"+ 
	     sms+"&nbsp;"+
       "<input type=\"button\" value=\"确定\" class=\"qinput\" id=\"btn-oks\" onclick=\"bpos.validateVipPw()\"/>"+
       "&nbsp;<input name=\"cancle\" id=\"btn-c\" type=\"button\" class=\"qinput\" value=\"取消\" onclick=\"javascript:bpos.killAlert('vip_validate')\" /></div></td></tr></table></div>";  
     this.executeLoadedScript(ele);
     this.noAlert=false;
     jQuery("#vippwd").focus();
     jQuery("#vippwd").bind("keydown",function(event){
     		if(event.which==13)
     		bpos.validateVipPw();
    	});
  },
	//add by Robin 20101224 处理VIP积分活动,计算共消费积分，弹出窗口 用户确认
	dealvipdis:function(vipdis){
		this.t_vipdis={};
		if(vipdis){
			this.t_vipdis=vipdis;
			if(this.master_data.params.validateVipPw=="false")
				this.initconfirmvipdishtml(vipdis);
			else
				this.validateVipPwHtml();
		}
	},
	//add by Robin 20101224 触发VIP积分活动
	dovipdis:function(){
		var cell=jQuery("#VIPDISINFO input:checked[type='radio']")[0];
		//alert(cell.id);
		//jQuery("#VIPPRO").attr("disabled","true");
		if(cell){
			var vipdisid=parseInt(cell.id.replace("vipdis-",""),10);
			var vipdis;
			for(var i=0;i<this.vipdisinfo.length;i++){
				if(this.vipdisinfo[i].id==vipdisid){
					vipdis=this.vipdisinfo[i];
				}
			}
			this.dealvipdis(vipdis);
		}
	},
	killvipdisinfo:function(){
		this.killAlert("VIPDISINFO");
		this.tempvipdis=null;
	},
	//Edit by Robin 20100823 初始化付款页面显示
	initpaypricehtml:function(totprice){
		var s=this.changenumber2yuan(this.alg(totprice,true));
		jQuery("#payable").html(s);
		jQuery("#unpaidamount").html(s);
		jQuery("#currpay").val(this.formatint2float(this.alg(totprice,true)));
		jQuery("#paidamount").html(this.changenumber2yuan(this.gettotpayamount()));
		jQuery("#charge").html(this.changenumber2yuan(this.change));
	  dwr.util.selectRange($("currpay"), 0,20);
	  if(this.alg(totprice,true)==0)jQuery("#next").removeAttr("disabled");
	},
	//Add by Robin 20101216 初始化积分付款界面，选择积分活动
	initintegralpayhtml:function(){
		var htmlstr="<div id=\"VIPDISINFO\" class=\"VIPpromotion\">"+
								"<div class=\"VIPpromtion-title\">VIP卡号："+this.vip.cardno+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VIP可用积分："+this.vip.integral+"</div>"+
								"<div class=\"VIPpromtion-table\"><div class=\"VIPpromtion-table-head\">"+
								"<div class=\"VIPpromtion-span-1\">&nbsp;</div><div class=\"VIPpromtion-span-2\">活动名称</div><div class=\"VIPpromtion-span-3\">积分</div><div class=\"VIPpromtion-span-3\">是否重复</div>"+
								"</div></div>"+
								"<div id=\"VIPpromtion-main\" class=\"VIPpromtion-sidebar\" style=\"height: 202px; width: 600px; visibility: visible; opacity: 1;\">";
		for(var i=0;i<this.vipdisinfo.length;i++){
			htmlstr+="<div class="+(i%2==0?"\"VIPpromtion-row\"":"\"VIPpromtion-conduct\"")+">"+
							 "<div class=\"VIPpromtion-"+(i%2==0?"row":"conduct")+"-line\">"+
							 "<div class=\"VIPpromtion-span-1\"><input type=\"radio\" id=\"vipdis-"+this.vipdisinfo[i].id+"\" value=\"\" name=\"checkvipdis\" "+(i==0?"checked=\"checked\"":"")+" />"+
							 "</div><div class=\"VIPpromtion-span-2\">"+this.vipdisinfo[i].name+"</div><div class=\"VIPpromtion-span-3\">"+this.vipdisinfo[i].integral+"</div><div class=\"VIPpromtion-span-4\">"+(this.vipdisinfo[i].ismused=='Y'?"是":"否")+"</div></div></div>";
		}								
		htmlstr+="</div><div  class=\"VIPpromtion-Input\">&nbsp;"+
						"<input type=\"button\" value=\"确定\" onclick=\"bpos.dovipdis();\" class=\"qinput\" id=\"VIPPRO\"/>"+
						"&nbsp;<input type=\"button\" onclick=\"bpos.killvipdisinfo()\" class=\"qinput\" value=\"取消\" id=\"VIPCANC\" /></div></div>";
		var ele = Alerts.fireMessageBox(
				{
					width: 600,
					modal: true,
					title: "可参加积分活动"
				});
		ele.innerHTML= htmlstr;
		this.executeLoadedScript(ele);
		this.noAlert=false;
		var inputs=jQuery("#VIPDISINFO input[type='radio'][id^='vipdis-']");
		var vipinput=inputs[0];
		var ipt=$("VIPPRO");
		ipt.focus();
		var tab=jQuery("#VIPPRO,#VIPCANC");
		jQuery("#VIPDISINFO").bind("keyup",function(event){
				if(event.which==40){
					if(vipinput){
						var index=0;
						index=inputs.index(vipinput)+1;
						if(!inputs[index]){
							index=0;
						}
						vipinput=inputs[index];
						jQuery(vipinput).attr("checked","true");
					}
				}else if(event.which==38){
					if(vipinput){
						var index=inputs.length-1;
						index=inputs.index(vipinput)-1;
						if(!inputs[index]){
							index=inputs.length-1;
						}
						vipinput=inputs[index];
						jQuery(vipinput).attr("checked","true");
					}
				}else if(event.which==13){
					if(inputs.index(vipinput)!=-1){
						jQuery("#VIPPRO").click();
					}
				}else if(event.which==9){
					event.stopPropagation();
					event.preventDefault();
					var index1=0;
					if(ipt){
						index1=tab.index(ipt)+1;
					}
					if(tab[index1]&&tab[index1].disabled==true)index1++;
					if(!tab[index1])index1=0;
					ipt=tab[index1];
					ipt.focus();
				}
			});		
	},
	//Add by Robin 20101216 新增积分付款。
	integralpay:function(){
		//alert("getvipdisinfo.jsp?storeid="+bpos.master_data.c_store_id+"&viptypeid="+bpos.vip.c_viptype_id);
		if(!this.vip.cardno){
			alert("未录入VIP，不可使用积分付款！");
			return;
		}
		if(this.items_data.length===0){
			alert("没有零售商品，不可使用积分付款");
			return;
		}
		if(!this.checkCanDo("integralpay")){
			alert("VIP或其他未达到积分付款条件！");
			return;
		}
		var totcommonqty=this.gettotdata().totcommonqty;
		jQuery.ajax({
			type:"POST",
			url:this.URL+"getvipdisinfo.jsp?storeid="+bpos.master_data.c_store_id+"&viptypeid="+bpos.vip.c_viptype_id+"&integral="+bpos.vip.integral+"&qty="+totcommonqty,
			timeout:3000,
			error:function(){
				alert("网络不畅,请稍后再试！");
			},
			success:function(data){
				data=jQuery.trim(data);
				if(data!="error"&&data!="none"){
					bpos.vipdisinfo=data.evalJSON();
					bpos.vipdisinfo.pop();
					//alert(Object.toJSON(bpos.vipdisinfo));
					bpos.initintegralpayhtml();
				}else if(data=="error"){
					alert("长时间未操作，信息已失效；请重新登录！");
				}else if(data=="none"){
					alert("没有适合的积分消费活动！");
				}else if(data=="error2"){
					alert("无法获取活动信息！");
				}
			}
		});
	},
	//准备付款
	readypay:function(){
	 
 		this.loadpaypricepage();//画出页面
 	
 		this.importpayways(this.payitem.TotalAmount);//导入付款方式
     //下面是填入数据
		//alert(Object.toJSON(this.payitem));
		this.initpaypricehtml(this.payitem.TotalAmount);	
		var selectedIndex=0;
		var maxindex=$("payselect").options.length-1;
		var tabtarget=$("currpay");
		var tgs=jQuery("#currpay,#next,#re,#cancle",$("payment_content"));
		jQuery("#payment_content").bind("keydown",function(event){
			//alert(event.which);
	  	if(event.which==38||event.which==40){
	  		event.stopPropagation();
	  		event.preventDefault();
	  		if(event.which==38){
	  			selectedIndex--;
	  			/*
	  			for(var i=0;i<bpos.ticketpayways.length;i++){
	  				if(bpos.ticketpayways[i].id==jQuery("#payment_content option[index='"+selectedIndex+"']").val())selectedIndex--;
	  			}*/
	  			if(selectedIndex<0)selectedIndex=maxindex;
	  		}else if(event.which==40){
	  			selectedIndex++;
	  			/*
	  			for(var j=0;j<bpos.ticketpayways.length;j++){
	  				if(bpos.ticketpayways[j].id==jQuery("#payment_content option[index='"+selectedIndex+"']").val())selectedIndex++;
	  			}*/
	  			if(selectedIndex>maxindex)selectedIndex=0;
	  		}
	  		$("payselect").selectedIndex=selectedIndex;
	  	}
	  	if(event.which==9){
	  		event.stopPropagation();
		    event.preventDefault();
	  		tabtarget=bpos.tabKeydown(tgs,tabtarget);
	  	}
	  });
	  jQuery("#currpay").bind("keydown",function(event){
	  	if(event.target==this&&event.which==13){
	  		event.stopPropagation();
	  		event.preventDefault();
	  		var num =parseFloat($("currpay").value);
	  		if(num!=bpos.alg(num,true,2)){
	  			$("discription").innerHTML  = "付款金额不符合进位要求，系统自动进位！";
	  			num=bpos.alg(num,true,2);
	  		}
	  		var unnum=parseFloat(jQuery("#unpaidamount").html().replace("￥",""));
				var pnum=parseFloat(jQuery("#paidamount").html().replace("￥",""));
				pnum=isNaN(pnum)?0:pnum;
				unnum=isNaN(unnum)?0:unnum;
				num=isNaN(num)?0:num;
				if(num!=0)
	  			bpos.insertpayment();
	  		else if(num==0&&unnum==0&&pnum==bpos.payitem.TotalAmount){
					$("currpay").disabled=true;
					$("next").focus();
				}else
					dwr.util.selectRange($("currpay"),0,30);
	  	}
	  });
	},

	//TAB键在控件数组中循环遍历,inputs需要遍历的数组，startInput开始的input对象
	tabKeydown:function(inputs,startInput) {
		for(var i=0;i<inputs.length;i++) {
			var index=inputs.index(startInput);
		  index++;
		  if(!inputs[index]){
		  	index=0;
		  }	
		  if(inputs[index]&&inputs[index].disabled==true)index++;
		  startInput=inputs[index];
		  if(startInput.disabled!=true) {	
		  	startInput.focus();
		  	return startInput;
		  }
	  }
	},

	//20100916 校验补录VIP 并返回VIP相关信息
	checkaddvip:function(){
		var vipcardno=$("zody_vip_input").value;
		if(!vipcardno||jQuery.trim(vipcardno)==""){
			alert("请输入VIP卡号！");
			return;
		}
		var evt={};
		evt.command="DBJSON";
		evt.callbackEvent="BPOS_CHECKADDVIP";
		var ptype=new Array();
		var pvalue=new Array();
		ptype.push("vip");
		pvalue.push(jQuery.trim(vipcardno));		
		var param={"ptype":ptype,"pvalue":pvalue,"storeid":this.master_data.c_store_id};
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="load_vip";
		evt.permission="r";		
		this._executeCommandEvent(evt);
	},
	//item  exist in this.tempmaxitems ?
	existintempmaxitems:function(item){
		for(var i=0;i<this.tempmaxitems.length;i++){
			if(item.lineno==this.tempmaxitems[i].lineno)return true;
		}
		return false;
	},
	//获得 目前 最大单品价格的明细 （除去已经取过的）
	getmaxpriceactualitem:function(items_data){
		var item;
		for(var i=0;i<items_data.length;i++){
			if(!this.existintempmaxitems(items_data[i])){
				if(!item){
					item=items_data[i];
				}else	if(item.priceactual<=items_data[i].priceactual){
					item=items_data[i];
				}
			}
		}
		this.tempmaxitems.push(item);
		return item;
	},
	//处理 总额折扣后 还有剩余的价格分摊
	handlediffwhendodiscountforitems:function(items_data,difference){
		var item=this.getmaxpriceactualitem(items_data);
		if(!item){
			item=this.tempmaxitems[0];
			item.priceactual=this.alg(item.priceactual.add(difference.div(item.qty)));
			item.price=item.priceactual.mul(item.qty);
			item.discount=item.pricelist==0?0:(item.priceactual.div(item.pricelist));
			return 0;
		}
		//如果 容许 折扣大于1 则将剩余值放在最大单价明细上
		if(this.discountCanLgOne){
			item.priceactual=this.alg(item.priceactual.add(difference.div(item.qty)));
			//item.price=item.priceactual.mul(item.qty);
			item.price=item.price.add(difference);
			//item.priceactual=item.price.div(item.qty);
			item.discount=item.pricelist==0?0:(item.priceactual.div(item.pricelist));
			return 0;
		}
		//alert(Object.toJSON(item));
		var orgitem=this.getitembylinenofromitems_data(item.lineno);
		//alert(Object.toJSON(orgitem));
		var diffprice=(orgitem.priceactual).sub(item.priceactual);
		diffprice=diffprice.mul(item.qty);
		if(diffprice>0){
			if(difference>diffprice){
				item.priceactual=orgitem.priceactual;
				item.discount=orgitem.discount;
				item.price=orgitem.price;
				difference=difference.sub(diffprice);
			}else{
				item.priceactual=this.alg(item.priceactual.add(difference.div(item.qty)));
				//item.price=item.priceactual.mul(item.qty);
				item.price=item.price.add(difference);
				//item.priceactual=item.price.div(item.qty);
				item.discount=item.pricelist==0?0:item.priceactual.div(item.pricelist);
				difference=0;
			}
		}
		return difference;
	},
	//获得指定零售类型的零售总金额
	gettotpriceforitemtype:function(items_data,type){
		var totprice=0.00;
		for(var i=0;i<items_data.length;i++){
			if(items_data[i].type==type){
				totprice=totprice.add(items_data[i].price);
			}
		}
		return totprice;
	},
	gettotpricelistforitemtype:function(items_data,type){
		var totpricelist=0.00;
		for(var i=0;i<items_data.length;i++){
			if(items_data[i].type==type){
				totpricelist=totpricelist.add(items_data[i].pricelist.mul(items_data[i].qty));
			}
		}
		return totpricelist;
	},
	/**
	 *Edit by Robin 20101022 总额折扣 用户可能输入的是折扣也可能是价格 可根据一个计算出另外一个，
	 但是计算的可能是约等于的值。我们以价格为标准。故参数需要传入 折扣 和 折扣后价格
	 注意：计算方式 标准价格*折扣
	 *param:items_data 总额折扣的对象
	 *param:discount 折扣
	 *param:nowtotprice 折扣后的总价格
	 *param:oldtotprice 原价
	*/	
	handlewholediscount:function(items_data,discount,nowtotprice,oldtotprice){
		if(this.gettotpricelistforitemtype(items_data,1)<(oldtotprice.sub(nowtotprice))){
			alert("优惠金额不得大于正常零售总金额！");
			return false;
		}
		for(var i=0;i<items_data.length;i++){
			if(items_data[i].type==1){
				discount=discount>items_data[i].lowest_discount?discount:items_data[i].lowest_discount;
				items_data[i].discount=discount;
				items_data[i].priceactual=this.alg(items_data[i].pricelist.mul(discount));
				items_data[i].price=items_data[i].priceactual.mul(items_data[i].qty);
			}
		}
		var newtot=this.gettotdata(items_data);
		//alert(Object.toJSON(nowtotprice));
		//alert(Object.toJSON(newtot.totprice));
		var difference=nowtotprice.sub(newtot.totprice);
		if(difference>0){
			this.tempmaxitems=new Array();
			while(difference>0){
				difference=this.handlediffwhendodiscountforitems(items_data,difference);
			}
		}
		return true;
	},
	/**
	 *Edit by Robin 20101022 总额折扣 用户可能输入的是折扣也可能是价格 可根据一个计算出另外一个，
	 但是计算的可能是约等于的值。我们以价格为标准。故参数需要传入 折扣 和 折扣后价格
	 注意：此方法是 拿原应付价格* 折扣 （而非标准价格*折扣）
	 *param:items_data 总额折扣的对象
	 *param:discount 折扣
	 *param:nowtotprice 折扣后的总价格
	 *param:oldtotprice 原价
	*/
	dodiscountwithamount:function(items_data,discount,nowtotprice,oldtotprice){
		//alert(this.gettotpriceforitemtype(items_data,1)+"\t"+(oldtotprice.sub(nowtotprice)));
		if(this.gettotpriceforitemtype(items_data,1)<(oldtotprice.sub(nowtotprice))){
			alert("优惠金额不得大于正常零售总金额！");
			return false;
		}
		var totnewprice=0.0;
		for(var i=0;i<items_data.length;i++){
			if(items_data[i].type==1){
				discount=discount>items_data[i].lowest_discount?discount:items_data[i].lowest_discount;
				items_data[i].priceactual=this.alg(items_data[i].priceactual.mul(discount));
				items_data[i].price=items_data[i].priceactual.mul(items_data[i].qty);
				if(nowtotprice.sub(totnewprice)<items_data[i].price){
					items_data[i].price=nowtotprice.sub(totnewprice);
					items_data[i].priceactual=this.alg(items_data[i].price.div(items_data[i].qty));
				}
				items_data[i].discount=this.discountalg(items_data[i].pricelist==0?0:items_data[i].priceactual.div(items_data[i].pricelist));
				totnewprice=totnewprice.add(items_data[i].price);
				
			}
		}
		var newtot=this.gettotdata(items_data);
		//alert(Object.toJSON(nowtotprice));
		//alert(Object.toJSON(newtot.totprice));
		var difference=nowtotprice.sub(newtot.totprice);
		if(difference>0){
			this.tempmaxitems=new Array();
			while(difference>0){
				difference=this.handlediffwhendodiscountforitems(items_data,difference);
			}
		}
		return true;
	},
	//总额 折扣计算
	dodiscountforitems:function(items_data,discount){
		var orgtot=this.gettotdata(items_data);
		var nowtotprice=this.alg(orgtot.totprice.mul(discount));
		var lowestprice=zody.getTotLowestPrice();
		if(nowtotprice<lowestprice){
			nowtotprice=lowestprice;
			discount=orgtot.totprice==0?0:(Math.floor((nowtotprice.div(orgtot.totprice)).mul(100))).div(100);
		}
		if(this.dodiscountwithamount(items_data,discount,nowtotprice,orgtot.totprice))this.viprecharge=orgtot.totprice.sub(nowtotprice);
	},
	//处理总额折扣
	dealwholeorderdiscount:function(discount){
		this.dodiscountforitems(this.temp_items_data,discount);
	},
	dealpaypriceforselectvipdiscount:function(){		
		var discount=jQuery("#zody_xo input:radio:checked").val();
		//alert(jQuery("#zody_xo input[@checked][@type=radio]").val());
		discount=parseFloat(discount);
		this.dealwholeorderdiscount(discount);
		zody.killDiscountType();
		$("recharge").innerHTML=this.changenumber2yuan(this.viprecharge);
	},
	//
	_dovipacm:function(e){
		var data=e.getUserData();
		var ret=data.jsonResult.evalJSON();
		if(ret.length==0){
			alert("未添加成功");	
			return;
		}
		//alert(Object.toJSON(ret));
		if(ret.rest=="true"&&ret.msg=="VIP新增成功!"){
			alert("添加成功");
	    this.killAlert("query-add-content");	
			this.killAlert("query-search-content");			
		}else	if(ret.rest=="true"&&ret.msg=="VIP升级成功!"){
			alert("VIP升级成功!");
	    this.killAlert("query-update-content");	
			this.killAlert("query-search-content");	
			this._editvip("f2newretail");		
		}else	if(ret.rest=="true"&&ret.msg=="VIP换卡成功!"){
			alert("VIP换卡成功!");
	    this.killAlert("query-change-content");	
			this.killAlert("query-search-content");			
			//this.noAlert=false;
			this._editvip("f2newretail");
		}
	},
	//20100916处理补录VIP信息返回值
	_oncheckaddvip:function(e){
		var data=e.getUserData(); // data
		
		var ret=data.jsonResult.evalJSON();
		//alert(Object.toJSON(ret));
		if(ret.length==0){
			alert("未找到VIP或VIP不可用！");
			return;
		}
		this.tempvip=this.changeret2vip(ret[0]);
		if(this.tempvip.ifcharge=='N'){
			alert("非充值卡账户不可使用VIP补录功能！");
			return;
		}
		//画选择折扣方式页面
		zody.discountType();
		$("zody-discount").innerHTML=this.tempvip.discount;
		$("zody-rediscount").innerHTML=this.tempvip.vipexp;
		$("input90").value=this.tempvip.vipexp;
		$("input99").value=this.tempvip.discount;
		var aInp = jQuery("#zody_xo input[type='button']");	
		var ins = jQuery("#zody_xo input[type='radio']");
		var ipt1=aInp[0];
		var radi=ins[0];
		jQuery("#zody_xo").bind("keydown",function(event){
				if(event.which==9){		
						event.stopPropagation();
						event.preventDefault();
						var index=0;
						if(ipt1){
							index=aInp.index(ipt1)+1;
						}
						if(!aInp[index])index=0;
							ipt1=aInp[index];
							ipt1.focus();					
				}else if(event.which==13){
					if(event.target!=$("zody_btn-search_0")&&event.target!=$("zody_btn-cancel_0")){
						bpos.dealpaypriceforselectvipdiscount();
					}
				}else if(event.which==38){
					var index=0;
					if(radi){
						index=ins.index(radi)+1;
					}
					if(!ins[index])index=0;
					radi=ins[index];
					if(index==1){
						jQuery("#input90").attr("checked",true);
						jQuery("#input90").focus();
					}else{
						jQuery("#input99").attr("checked",true);
						jQuery("#input99").focus();
					}
				}else if(event.which==40){
					var index=0;
					if(radi){
						index=ins.index(radi)+1;
					}
					if(!ins[index])index=0;
					radi=ins[index];
						if(index==1){
						jQuery("#input90").attr("checked",true);
						jQuery("#input90").focus();
					}else{
						jQuery("#input99").attr("checked",true);
						jQuery("#input99").focus();
					}
				}
		});		
	},
	//处理VIP补录功能
	handlepayforadditionalvip:function(tot){
	
		if((this.MODEL&this.ADDITIONVIP)!=this.ADDITIONVIP)return;
		zody.buLuVIP();
		var ipt1;
	
		jQuery("#xiao_content_88").bind("keydown",function(event){
					var aInp = jQuery("#xiao_content_88 input[type='button']");			
					if(event.which==9){		
							event.stopPropagation();
							event.preventDefault();
							var index=0;
							if(ipt1){
								index=aInp.index(ipt1)+1;
							}
							if(!aInp[index])index=0;
								ipt1=aInp[index];
								ipt1.focus();					
				}else if(event.which==13){
						if(event.target!=$("zody_btn-search")&&event.target!=$("zody_btn-cancel"))
						bpos.checkaddvip();
				}
		});
	},
	//合计多少明细 没有选择商场结算类型
	countNoSelectMarketBillWayItem:function(){
		var count=0;
		if(this.master_data.markbaltypes.length>0){
			for(var i=0;i<this.items_data.length;i++){
				if(this.items_data[i].markbaltype==-1){
					count++;
				}
			}
		}
		return count;
	},
	//检查是否含有退货数量大于原单数量的明细
	checkHasQtyGTOrgQty:function(items){
		if(!items)items=this.items_data;
		var orgitems=new Array();
		a:for(var i=0;i<items.length;i++){
				if(items[i].orgdocno!=""&&items[i].org_qty){
					for(var j=0;j<orgitems.length;j++){
						if(orgitems[j].orgdocno==items[i].orgdocno&&orgitems[j].productno==items[i].productno){
							orgitems[j].qty+=items[i].qty;
							continue a;
						}
					}
					var iem=this.copyJsonObject(items[i]);
					orgitems.push(iem);
				}
			}
		var errorlinenos=new Array();
		for(var k=0;k<orgitems.length;k++){
			if(Math.abs(orgitems[k].qty)>orgitems[k].org_qty){
				errorlinenos.push(orgitems[k].lineno);
			}
		}
		if(errorlinenos.length>0){
			alert("错误：行 "+errorlinenos.toString()+" 退货数量大于原单数量！");
			return true;
		}
		return false;
	},
	//add by robin 20110901 合并本单中所有退货的原单的单据日期、付款方式ID、付款金额 保存到 this.org_payitems中
	//明细根据原单编号付款方式分离出付款明细
	mergeOrgOrderPayItem:function(){
		this.mark=0;//多次退货区别不同单据号
		this.org_payitems=new Array();
		this.orgdocnos=new Array();
		var items=this.items_data;
		for(var i=0;i<items.length;i++){
			if(items[i].org_billdate!=-1&&items[i].org_payways!=-1){
				if(!this.isSameOrgOrder(items[i].org_docno)) {
					for(var j=0;j<items[i].org_payways.length;j++){
						var payitem={};
						payitem.payway=items[i].org_payways[j];//付款方式
						payitem.payamount=items[i].org_payamounts[j];//付款金额
						payitem.billdate=items[i].org_billdate;//单据日期
						payitem.sysdate=items[i].sysdate;//日期
						payitem.org_orderno=items[i].org_docno;//原单编号
						payitem.status=0;
						this.org_payitems.push(payitem);
					}
				}
			}
		}
	},
	//yymmdd-->yy-mm-dd
	string2Date:function(strDate) {
		return "20"+strDate.substr(0,2)+"-"+strDate.substr(2,2)+"-"+strDate.substr(4,2);
	},
	//yy-mm-dd-->mmdd
	date2String:function(date) {
		return date.substr(5,2)+date.substr(8,2);
	},
	//退货时判断是否是同一笔单据
	isSameOrgOrder:function(org_docno) {
		for(var i=0;i<this.orgdocnos.length;i++){
			if(org_docno==this.orgdocnos[i])return true;
		}
		this.orgdocnos.push(org_docno);
		return false;
	},
	//通过原单号找到对应的所有明细
	findByOrgOrder:function(org_docno,items) {
		var mx = new Array();
		for(var i=0;i<items.length;i++) {
			if(org_docno==items[i].org_docno) {
				mx.push(items[i]);
			}
		}
		return mx;
	},
	payprice:function(items){ 
		if((this.MODEL&this.PAYPRICE)!=this.PAYPRICE){
			alert("该单不可付款！");
			return;
		}
		if(this.checkNeedMarketBillWay()){
			var c=this.countNoSelectMarketBillWayItem();
			if(c>0){
				alert("错误：您有 "+c+" 条明细未选择商场结算类型！请选择！");
				return;
			}
		}
		
		if(this.checkHasQtyGTOrgQty(items))return;
	//20100824新增初始化总单策略时保存的temp_items_data
	//Edit by robin 20101224 增加参数 items判断如果存在 则不初始化 this.temp_items_data 针对--> 积分消费
		if(!items)this.temp_items_data=new Array();
		this.tempvou={};
		this.vouinfo={};
		this.consumecards=new Array();
		this.viprecharge=0.00;
		this.tempAmount=0.00;
		this.execVipBirthdayMonthDis=false;
		this.tempvip={};
		this.initpayitem();
		this.hasWholeDis=false;
		//this.change=0;
	  if(bpos.items_data.length==0){
       alert("没有零售纪录！");
    }else{
			    	//Edit by robin 20101224 增加参数 items判断如果存在 则调用this.handlewholedis(items) 针对--> 积分消费
					if(items){
			   		this.handlewholedis(items);
			   	}else{
			   		this.handlewholedis();
			   	}
			    var tot,orgtot;
			    //alert(Object.toJSON(this.temp_items_data));
			 		if(this.temp_items_data.length>0){
			 			//alert(Object.toJSON(this.temp_items_data));
						tot=this.gettotdata(this.temp_items_data);
					}else{
						tot=this.gettotdata();
					}
					orgtot=this.gettotdata();
					//alert(Object.toJSON(tot));
					//alert(Object.toJSON(orgtot));
					if(Math.abs(tot.totprice-orgtot.totprice)>=0.01)
					this.hasWholeDis=true;
					this.initpaypriceAmount(false,tot.totprice);
					//this.tempAmount=tot.totprice;
					//alert(Object.toJSON(tot));
					//付款明细中应付款
					//this.payitem.TotalAmount=this.tempAmount;
					//add by robin 20110831 当付款金额为负数时 合并退货原单付款明细，包括 付款方式以及对应的金额、单据日期（注意：单据日期可能不是付款日期，目前此种做法需要改进）
					if(this.payitem.TotalAmount<0){
						this.mergeOrgOrderPayItem();
					}
					if(this.checkCanDo("vipbirthdaymonthdiscount")){
						this.vipbirthdaymonthdiscount();;
						return;
					}
					if(this.checkCanDo("handlepayforadditionalvip")){
						this.handlepayforadditionalvip();			
						return;
					}
					if(this.checkCanDo("vipbirdis")){
						this.handleVipBirDisForOrder();
						return;
					}
						this.readypay();
    }
	},
	/**
	 *add by robin 20120503 增加合并 可执行某些动作检测 的方法；便于维护
	 *@param : action 动作 如 jnby环境付款时 需要执行VIP生日当月折扣
	 */
	checkCanDo:function(action){
		switch(action){
			case "vipbirthdaymonthdiscount": 
				return 	this.master_data.params.company=='jnby'&&this.vip&&this.vip.vip_id&&this.tempvipdis==null&&((this.vip.directstore=='Y'&&this.vip.city==this.master_data.city)||(this.vip.directstore=='N'&&this.vip.customer==this.master_data.customer));break;
			case "handlepayforadditionalvip":
				return this.master_data.params.additionalvip=="true"&&this.payitem.TotalAmount>0&&!(this.vip&&this.vip.vip_id);break;
			case "integralpay":
				if(this.master_data.params.company=='jnby'){
					return !this.execVipBirthdayMonthDis&&((this.vip.directstore=='Y'&&this.vip.city==this.master_data.city)||(this.vip.directstore=='N'&&this.vip.customer==this.master_data.customer));
				}else{
					return !this.execVipBirthdayMonthDis;
				}
				break;
			case "vipbirdis":
				return this.vip&&this.vip.vipdis&&this.vip.vipdis.LIMITTYPE==2&&confirm("您还有"+this.vip.vipdis.REMQTY+"笔可享受["+this.vip.vipdis.NAME+"]的活动，是否执行？");
				break;
		}
	},
	
	//add by robin 20120331 VIP是否可执行当月优惠检测
	vipbirthdaymonthdiscount:function(){
		var evt={};
		evt.command="cn.com.burgeon.command.webpos.VipBirthdayMonthDis";
		evt.callbackEvent="BPOS_VIP_BIRTHDAYDIS";
		var param={};
		param.vip_id=this.vip.vip_id;
		evt.param=param;
		evt.table="C_VIPTYPE";
		evt.permission="r";
		this._executeCommandEvent(evt);
	},
	//初始化付款金额
	initpaypriceAmount:function(items_data,totprice){
		if(totprice||totprice==0){
			this.tempAmount=this.alg(totprice,true);
		}else{
			var items=items_data?items_data:this.items_data;
			var tot=this.gettotdata(items);
			this.tempAmount=this.alg(tot.totprice,true);
		}
		this.payitem.TotalAmount=this.tempAmount;
	},
	/**
	 *add by robin 20121122增加VIP当日当月优惠活动中“限制笔数”（即 整单折扣或优惠）的处理
	 */
	handleVipBirDisForOrder:function(){
		var tot=this.gettotdata(this.temp_items_data);
		var disamt=tot.totprice;
		if(this.vip.vipdis.ISFULLPRICE=='Y')disamt=tot.totpricelist;
			var content=parseFloat(this.vip.vipdis.EXECONTENT);
		if(this.vip.vipdis.DISTYPE==1){//折扣
			disamt=this.alg(disamt.mul(content));
		}else if(this.vip.vipdis.DISTYPE==3){//优惠
			disamt=this.alg(disamt.sub(content));
		}
		var discount=disamt.div(tot.totpricelist);
		this.handlewholediscount(this.temp_items_data,discount,disamt,tot.totprice);
		this.initpaypriceAmount(this.temp_items_data);
		this.temp_items_data.vipbirdisid=this.vip.vipdis.ID;
		this.readypay();
	},
	
	_onbirthdaymonthdis:function(e){
		var data=e.getUserData(); 
		if(typeof(data)=='string'){
			ret=data.evalJSON();
		}else{
			ret=data.jsonResult.evalJSON();
		}
		if(ret.code==200){
			if(confirm('是否执行VIP当月优惠？')){
				var vipdisamt=parseFloat(ret.vipdisatm);
				var vipbirdis=parseFloat(ret.birdis);
				vipdisamt=isNaN(vipdisamt)?0:vipdisamt;
				vipbirdis=isNaN(vipbirdis)?0:vipbirdis;
				var tot=this.gettotdata();
				var oldtotprice=tot.totpricelist;
				var newprice=this.alg(vipbirdis.mul(oldtotprice));
				if(newprice>vipdisamt&&tot.totqty>1){
					alert("付款金额大于VIP生日当月折扣限额！");
				}else{
					this.handlewholediscount(this.temp_items_data,vipbirdis,newprice,oldtotprice);
					this.execVipBirthdayMonthDis=true;
					this.initpaypriceAmount(this.temp_items_data);
				}
			}
		}
		this.readypay();
	},
	cancelamt:function(){ 
		this.killAlert("amt_content");
	},
	payclose:function(){
		this.initpayitem();
		this.payment=[];//alert(1);
		this.ticketnos=new Array();
		this.tempvipdis=null;
		this.tdefposdis_id=-1;
  	this.tdefposdis_name=-1;
  	this.tempvou={};
  	this.vouinfo={};
  	this.consumecards=new Array();
		this.killAlert("payment_content");
	},
	//判断当前付款金额是否违背了找零原则和付款限制
	CheckIsOK:function(payitem){
			if(payitem.TotalAmount < 0 )	//如果是退货，则不作控制
			{
				return true;
			}
			if((payitem._totalNoCashNoCharge - payitem.TotalAmount) > 0)	//只要有卡消费，就不允许卡付金额大于应付
			{
				$("discription").innerHTML  = "卡类支付不能超过应付总额！\n请按重付按钮！";
				alert("卡类支付不能超过应付总额！");
				return false;
			}

			if(payitem._totalNoCashNoCharge > 0 && (payitem._totalNoCashNoCharge + payitem._totalCashNoCharge - payitem.TotalAmount) > 0)	//使用 信用卡＋券，不允许出现找零。
			{
				$("discription").innerHTML = "卡类支付不允许找零！\n请按重付按钮！";
				alert("卡类支付不允许找零！");
				return false;
			}

			if( payitem._totalVipCharge > 0 && (payitem._totalCashNoCharge - payitem.TotalAmount) > 0)	//使用vip充值卡付款，再使用券，不允许出现找零。
			{
				$("discription").innerHTML = "券类(含VIP卡消费)支付\n不允许找零！请按重付按钮！";
				alert("券类(含VIP卡消费)支付不允许找零！");
				return false;
			}


			if((payitem._totalCashCharge - payitem.TotalAmount) >= 100)	//只要有付现金的行为，就不允许找零金额大于等于100
			{
				$("discription").innerHTML  = "找零金额不能大于100元！\n请按重付按钮！";
				alert("找零金额不能大于100元！");
				return false;
			}
			if(payitem._totalCashCharge > 0)	//已支付现金
			{
				if(payitem._totalCashNoCharge > 0)	//现金 ＋ 券
				{
					if((payitem._totalCashNoCharge - payitem.TotalAmount) > 0)
					{
						$("discription").innerHTML  = "在已付现金的情况下券类支付\n不允许大于应付总额！\n请重付！";
						alert("在已付现金的情况下券类支付不允许大于应付总额！");
						return false;
					}
					else
					{
						if((payitem._totalCashCharge + payitem._totalCashNoCharge - payitem.TotalAmount) >=100)
						{
							$("discription").innerHTML  = "找零金额不能大于100元！\n请重付！";
							alert("找零金额不能大于100元！");
							return false;
						}
					}

					if(payitem._totalNoCashNoCharge > 0) //现金＋券＋卡
					{
						if((payitem._totalCashNoCharge + payitem._totalNoCashNoCharge - payitem.TotalAmount) > 0)
						{
							$("discription").innerHTML  = "在已付现金的情况下券类\n和卡类支付总和不允许大于\n应付总额！请重付！";
							alert("在已付现金的情况下券类和卡类支付总和不允许大于应付总额！");
							return false;
						}
						else
						{
							if((payitem._totalCashCharge + payitem._totalCashNoCharge + payitem._totalNoCashNoCharge - payitem.TotalAmount) >=100)
							{
								$("discription").innerHTML  = "找零金额不能大于100元！\n请重付！";
								alert("找零金额不能大于100元！");
								return false;
							}

						}
					}
				}
				else	
				{
					if(payitem._totalNoCashNoCharge > 0 ) //现金＋卡
					{
						if((payitem._totalCashCharge + payitem._totalNoCashNoCharge - payitem.TotalAmount) >= 100)
						{
							$("discription").innerHTML  = "找零金额不能大于100元！\n请重付！";
							alert("找零金额不能大于100元！");
							return false;
						
						}
					}
				}
			}	
			return true;
		},
	/**
	 *判断付款方式，是现金，卡，还是现金卷
	 *@param :paywayid 付款方式ID
	 *@return : 'cash' or 'card' or 'certificate' or 'consumecard'
	 */
	checkpayway:function(paywayid){
			var payways=this.master_data.payways;
			for(var j=0;j<payways.length;j++){
      	if(paywayid==payways[j].id){
      		if(payways[j].is_vou=='Y'){
      			return "vou";
      		}
      		if(payways[j].isconsumecard=='Y'){
      			return "consumecard";
      		}
      		if(payways[j].iscashcard=="Y"){
    	     	return "cashcard";
    	    }
    	    if(payways[j].isticket=="Y"){
    	    	return "ticket";
    	    } 
    	    if(payways[j].ischarge=="Y"&&payways[j].iscash=="Y"){
    	       return "cash";   
    	     }else if(payways[j].ischarge=="N"&&payways[j].iscash=="N"){
    	       return "card";
    	     }else if(payways[j].ischarge=="N"&&payways[j].iscash=="Y"){
    	       return "certificate";
    	     }
      	 }
      }
	},
	//界面插入付款明细
	insertpayitemhtml:function(paytype,payamount){
		var str="<div class=\"payment-row\"><div class=\"payment-row-line\">"+
				"<div class=\"payment-span-1\">"+paytype+"</div><div class=\"payment-span-3\">"+this.changenumber2yuan(payamount)+"</div></div></div>";
		jQuery("#payment-main").append(str);
		jQuery("#next").removeAttr("disabled");
	},
	//更新 付款明细this.payitem
	updatepayitem:function(payway,num){
		switch(payway){
			case "vou":this.payitem._totalNoCashNoCharge=(this.payitem._totalNoCashNoCharge).add(num);break;
			case "consumecard":this.payitem._totalNoCashNoCharge=(this.payitem._totalNoCashNoCharge).add(num);break;
			case "cash":this.payitem._totalCashCharge=(this.payitem._totalCashCharge).add(num);break;
			case "card":this.payitem._totalNoCashNoCharge=(this.payitem._totalNoCashNoCharge).add(num);break;
			case "certificate":this.payitem._totalCashNoCharge=(this.payitem._totalCashNoCharge).add(num);break;
			case "cashcard":this.payitem._totalVipCharge=(this.payitem._totalVipCharge).add(num);this.payitem._totalNoCashNoCharge=(this.payitem._totalNoCashNoCharge).add(num);break;
			case "ticket" :this.payitem._totalCashNoCharge=(this.payitem._totalCashNoCharge).add(num);break;
		}
	},
	getpaywaybypayname:function(payname){
		var payways=this.master_data.payways;
		for(var i=0;i<payways.length;i++){
			if(payname==payways[i].name){
				return payways[i];
			}
		}
	},
	/**
	 *Add by Robin 20110405 检查付款方式是否为银行卡付款
	 */
	checkIsBankCardPayWay:function(payway){
		if(payway.iscash=='N'&&payway.ischarge=='N'&&payway.payid!=this.ticketpayways[0].id&&payway.payid!=this.cashcardpayways[0].id){
			return true;
		}
		return false;
	},
	handlepaypricewhencheckisok:function(paytype,num,ticketno){
		var payway=this.getpaywaybypayname(paytype);
		
		var paidamount=parseFloat(jQuery("#paidamount").html().replace("￥","")).add(num);
		//alert(this.payitem.TotalAmount);
		var unpaidamount=this.payitem.TotalAmount.sub(paidamount);
		
		jQuery("#paidamount").html(this.changenumber2yuan(paidamount));
		jQuery("#unpaidamount").html(this.changenumber2yuan(unpaidamount<0?0.00:unpaidamount));
		var currShouldPay=unpaidamount;
		if(this.payitem.TotalAmount>0&&unpaidamount<0){
			currShouldPay=0.00;
		}
		jQuery("#currpay").val(this.formatint2float(currShouldPay));
		//alert("1112");
		
		//alert(paytype+"-----"+num);
		this.insertpayitemhtml(paytype,num);
		i=this.payment.length;
		var payid=payway.id;
		var remark="-1";
		if(ticketno)remark=ticketno;
	 	this.payment[i]={"payid":payid,"name":paytype,"num":num,"remark":remark+""};
	 
	 	//alert(this.payment[i].remark);
	 	//alert(unpaidamount);
		if(unpaidamount<=0&&this.payitem.TotalAmount>0){
			i=this.payment.length ;	
    	//alert(k);
    	//alert(Object.toJSON(this.master_data.payways));
    	var hascash=false;
    	   a:for(var j=0;j<i;j++){
	    		 for(k=0;k< this.master_data.payways.length;k++){
	    		 	if(this.payment[j].payid==this.master_data.payways[k].id&&this.payment[j].name==this.master_data.payways[k].name&&this.payment[j].num>0){
	    		 	 	if(this.master_data.payways[k].iscash=='Y'&& this.master_data.payways[k].ischarge=='Y'){
	    	 		 		hascash=true;
	      				break a;
	       			}
	     			}
	     	 }
    	 }
    	if(unpaidamount<0&&hascash==true){
    		this.change=unpaidamount;
    		jQuery("#charge").html(this.change==0.00?"":this.changenumber2yuan(-this.change));
    		this.insertpayitemhtml(this.master_data.payways[k].name,unpaidamount);	        	
 				this.payment[i]={"payid":this.master_data.payways[k].id,"name":this.master_data.payways[k].name,"num":unpaidamount,"remark":remark+""};
			}
			$("currpay").disabled=true;
			$("vip_currpay").disabled=true;
		}
			//alert($("currpay").disabled);
			if($("currpay").disabled!=true&&jQuery("#m").is(":visible"))dwr.util.selectRange($("currpay"),0,30);
			if($("currpay").disabled)$("next").focus();
			//alert(Object.toJSON(this.payment));
	},
	/*add by robin 20121212 银行卡POS刷卡接口，目前支持 通联 块钱
	 *@param transType 刷卡类型;通联为 : 2-刷卡、4-退款、3-撤销。 块钱为：1-消费、2-退款、3-撤销
	 *@param amount 金额
	 *@param orderno 单据号，这里统一为 refno
	 *@param oldTraceNumber 原交易号，这里PORTAL中不记录，由客户从原小票上获取
	 *@param hostSerialNumber 
	 *@param transDate 交易日期； 通联为: 年月日就OK，块钱：精确到时分秒，这个需要在刷卡的时候记录到系统，目前不做，所以由用户手动输入
	 *@param posType 通联: TL; 块钱: KQ
	 */
	bankPayActivexAccess:function(transType,amount,orderno,oldTraceNumber,hostSerialNumber,transDate,posType){
		var param={};
		param.TransType=transType;
		param.Amount=amount;
		param.orderno=orderno;
		param.OldTraceNumber=oldTraceNumber;
		param.HostSerialNumber=hostSerialNumber;
		param.TransDate=transDate;
		param.PosType=posType;
		var info={};
		info.param=param;
		var ret=MainApp.BankCardPay(Object.toJSON(info));
		ret=ret.evalJSON();
		return ret;
	},
	//通联刷卡接口
	TNActivexAccess:function(transType,amount,orderno,oldTraceNumber,hostSerialNumber,transDate){
		return this.bankPayActivexAccess(transType,amount,orderno,oldTraceNumber,hostSerialNumber,transDate,"TL");
	},
	KQActivexAccess:function(transType,amount,orderno,oldTraceNumber,hostSerialNumber,transDate){
		var  ret=this.bankPayActivexAccess(transType,amount,orderno,oldTraceNumber,hostSerialNumber,transDate,"KQ");
		if(ret.responsecode=="00")ret.code="1";
		if(ret.code&&ret.code=="-1"&&ret.meg)alert("错误："+ret.meg);
		return ret;
	},
	//ACTIVEX 接口 银行卡付款 add 20110405
	bankCardPay:function(price,docno){
		if(this.master_data.comptype==1)
		return this.TNActivexAccess("2",price,docno,"","","");
		if(this.master_data.comptype==2)
		return this.KQActivexAccess("1",price,docno,"","","");
	},
	/**通联退款接口
	 *@param transDate 交易日期 及退货时返回原单付款明细中的billdate 注意返回的格式是yymmdd
	 *@param amount 退款金额 
	 *@param docno 单据号 可传入 this.master_data.refno
	 */
	TNRefund:function(transDate,amount,docno){
		if(this.master_data.comptype==1)
		return this.TNActivexAccess("4",amount,docno,"","",transDate);
		if(this.master_data.comptype==2)
		return this.KQActivexAccess("2",amount,docno,"","",transDate);
	},
	/*通联撤销接口,只能撤销当天的刷卡
	 *@param amount 撤销的金额 必须和原单付款明细一致
	 *@param docno单据号 可传入 this.master_data.refno
	 */
	TNChargebacks:function(amount,docno){
		if(this.master_data.comptype==1)
		return this.TNActivexAccess("3",amount,docno,"","","");
		if(this.master_data.comptype==2)
		return this.KQActivexAccess("3",amount,docno,"","","");
	},
	insertpayment:function(tot){  
		var paywayid=jQuery("#payselect").val();
		for(var s=0;s<bpos.voupayways.length;s++){
	  			if(paywayid==bpos.voupayways[s].id){
	  				bpos.handlevou();
	  				return;
	  			}
	  		}
		for(var i=0;i<this.ticketpayways.length;i++){
			if(paywayid==this.ticketpayways[i].id){
	  		bpos.handlevisitantticket();
				return;
			}
		}
		for(var o=0;o<this.consumecardpayways.length;o++){
			if(paywayid==this.consumecardpayways[o].id){
	  		bpos.handlevisitantticket(true);
				return;
			}
		}
		for(var j=0;j<this.cashcardpayways.length;j++){

			if(paywayid==this.cashcardpayways[j].id){
				if(this.vip.vip_id){
					if(this.vip.ifcharge!='Y'){
						alert("非VIP充值卡用户不可使用"+this.vipPayTypeName+"!");
						return;
					}
					bxl.vip();
					this.initvipcosume();
					return;
				}else{
					alert("非VIP客户不能使用"+this.vipPayTypeName+"！");
					return;
				}
			}
		}
		
		var i=0;
		var num =parseFloat($("currpay").value);
		num=this.alg(num,true,2);
		if(this.payitem.TotalAmount<0&&num>0){
			dwr.util.selectRange($("currpay"),0,20);
			return;
		}
		var unnum=parseFloat(jQuery("#unpaidamount").html().replace("￥",""));
		var pnum=parseFloat(jQuery("#paidamount").html().replace("￥",""));
		pnum=isNaN(pnum)?0:pnum;
		unnum=isNaN(unnum)?0:unnum;
		num=isNaN(num)?0:num;
		if(unnum>0&&num<0){
			alert("错误：当未付金额大于零时，付款金额不可小于零！");
			return;
		}
		if(num==0&&unnum==0&&pnum==this.payitem.TotalAmount){
			$("currpay").disabled=true;
			$("next").focus();
			return;
		}
		var payway=this.checkpayway(paywayid);
		
		if(this.payitem.TotalAmount<0&&num<0&&this.master_data.comptype!=0&&payway=='card') {
			if(this.payitem.TotalAmount>num){
				$("discription").innerHTML  = "退货输入金额不能超过应退总额！\n请按重付按钮！";
				alert("退货输入金额不能超过应退总额！");
				return;
			}else {
				this.bankCardReturn(num,paywayid);
				return;
			}		
		}
		
		this.evaluatepayitem(this.payitem,this.temppayitem);
	
		this.updatepayitem(payway,num);
		if(this.CheckIsOK(this.payitem)){
			if(this.master_data.comptype!=0&&payway=='card'){
				if(num>0){
					var ret={};
					try{
						ret=this.bankCardPay(num,this.master_data.refno);
					}catch(e){
						alert(e.message);
						ret.code="0";
					}
					//alert(Object.toJSON(ret));
					if(ret.code=='1'){
						this.hasCreditBankCard=true;
						jQuery("#re,#cancle").attr("disabled","true");
					}else{
						this.evaluatepayitem(this.temppayitem,this.payitem);
						if($("currpay").disabled!=true)dwr.util.selectRange($("currpay"),0,20);
						$("discription").value ="";
						return;
					}
				}else{
					//alert("请手动使用通联刷卡机退款!");
				}
			}
			var paytype=jQuery("#payselect").find("option:selected").text();
			this.handlepaypricewhencheckisok(paytype,num);//记录到this.payment
		}else{
			this.evaluatepayitem(this.temppayitem,this.payitem);
			if($("currpay").disabled!=true)dwr.util.selectRange($("currpay"),0,20);
			$("discription").value ="";
		}
 },
	
	//判断退货时是否可以撤销单据
	revOrgOrder:function(price,item) {
		return item.billdate==item.sysdate&&Math.abs(price)>=item.payamount;
	},

	//通联接口退货操作
	bankCardReturn:function(price,paywayid) {		
		//当天且退货金额大于付款明细金额
		var cx_org=new Array();
		var isSameCardOrg=0;
		for(var i=0;i<this.org_payitems.length;i++) {
			var ret=this.org_payitems[i];
			if(!ret.status&&ret.payway==paywayid) {
				isSameCardOrg++;
			}
			if(!ret.status&&this.revOrgOrder(price,ret)&&ret.payway==paywayid) {
				cx_org.push(ret);
			}
		}		
		var doSameOrgR=false;
		if(!isSameCardOrg){
			if(!confirm("原单中的"+jQuery("#payselect").find("option:selected").text()+"付款方式已退！是否继续使用？"))return;
			else doSameOrgR=true;
		}
			zody.TNReturnFace(this.org_payitems,cx_org.length?"TNCX":"TNTH",paywayid,price,doSameOrgR);

	},
	
	
	repay:function(){
		jQuery("#payselect option[text="+this.master_data.params.defaultPayway+"]").attr("selected","true");
		if(this.vouinfo&&(this.vouinfo.useDis||this.vouinfo.changeItemsPrice)){
			alert("已使用购物券折算了价格，不能重付！若要重付，请取消付款！");
			return;
		}
		bxl.pay();
		jQuery("#payment-main").html("");		
		$("next").disabled=true;
		//这些重置的变量是不是应该整合到一个方法中？
		this.payment=[];//alert(2);
		this.ticketnos=new Array();
		this.consumecards=new Array();
		this.tempvou={};
		this.vouinfo={};
		this.initpayitem();
		
		//付款明细中应付款
		this.payitem.TotalAmount=this.tempAmount;
		this.initpaypricehtml(this.tempAmount);
		if($("currpay").disabled){
			$("currpay").disabled =!$("currpay").disabled;
		}
		if($("vip_currpay").disabled){
			$("vip_currpay").disabled =!$("vip_currpay").disabled;
		}
		jQuery("#m").click();
		$("discription").value ="";
		$("charge").value="";	
		var currpayx=$("currpay");
		
	  dwr.util.selectRange(currpayx, 0,15);
	},
	_onsave_print:function(e){
	   var data=e.getUserData(); // data
	   var ret=data.jsonResult.evalJSON();
	   var retailid =ret.retailid;
	   if($("next").disabled==true)jQuery("#next,#re,#cancle").removeAttr("disabled");
	   //alert(ret.vipdocno);
	   
    if(ret.docno){ 
			this.doSomeThingWhenSaveOrderSucc(ret);
		}
	}, 
	gettotpayamount:function(){
		var totamount=0.00;
		for(var i=0;i<this.payment.length;i++){
			var num=parseFloat(this.payment[i].num);
			num=isNaN(num)?0:num;
			totamount=totamount.add(num);
		}
		return totamount;
	},
	getpaymentamount:function(){
		var totamount=0.00;
		for(var i=0;i<this.payment.length;i++){
			totamount=this.payment[i].num.add(totamount);
		}
		return totamount;
	},
	
	//测试 是否 在线状态
	testIsOnline:function(){
			jQuery.ajax({
				type:"POST",
				cache:false,
				url:this.URL+"testonline.jsp?r='+(new Date()).getTime()+'",
				timeout:3000,
				error:function(){
					alert("网络不畅。请稍后继续...");
					if($("next").disabled==true)jQuery("#next,#re,#cancle").removeAttr("disabled");
				},
				success:function(data){
					bpos.doSave();
				}
			}); 
	},
	/*
	 * add by robin 20120419
	 *给定一个json数组，需要将数组中的json元素的某个属性值合并为一个字符串。
	 *@param arrayobj
	 *@param col json 元素的属性
	 *@param separator 分割付
	*/
	columnOfArrayJson2String:function(arrayObj,col,separator){
		var ret="";
		if(!arrayObj||arrayObj.length===0)return ret;
		for(var i=0;i<arrayObj.length;i++){
			var obj=arrayObj[i];
			for(var c in obj){
				if(c==col){
					ret+=i==0?obj[c]:(separator+obj[c]);
				}
			}
		}
		return ret;
	},
	//add by robin 20120419 将multisalers中的trueName合并以String 的方式展示
	salersTrueName2String:function(multisalers){
		return this.columnOfArrayJson2String(multisalers,"truename",",");
	},
	salersCode2String:function(multisalers){
		return this.columnOfArrayJson2String(multisalers,"name",",");
	},
	//根据营业员name获取truename
	//edit by robin 20120419 新增传入参数 item 以便扩展
	getSalerTrueName:function(salername,item){		
		if(item&&item.multisalers&&item.multisalers.length>0){		
			return this.salersTrueName2String(item.multisalers);
		}
		for(var i=0;i<this.master_data.salers.length;i++){
			if(this.master_data.salers[i].name==salername){
				return this.master_data.salers[i].truename;
			}
		}
		return "-";
	},
	getSalerCode:function(salername,item){		
		if(item&&item.multisalers&&item.multisalers.length>0){		
			return this.salersCode2String(item.multisalers);
		}
		for(var i=0;i<this.master_data.salers.length;i++){
			if(this.master_data.salers[i].name==salername){
				return this.master_data.salers[i].name;
			}
		}
		return "-";
	},
	//add by robin 20111229 获取消费卡信息 [{cardno:卡号, remCash:原余额,pay:本单已用金额}]
	getConsumecardsinfo:function(){
		var consumecardsinfo=new Array();
		for(var i=0;i<this.consumecards.length;i++){
			var info={};
			info.cardno=this.consumecards[i].cardno;
			info.remCash=this.consumecards[i].remCash;
			info.pay=this.getPayAmountByConsumeCardno(this.consumecards[i].cardno);
			consumecardsinfo.push(info);
		}
		return consumecardsinfo;
	},
	/*
	 *add by robin 20130115
	 *获取给定数的最小单位
	 *@param d 
	 *@return 最小单位数
	 */
	getSmallestUnit:function(d){
		d=parseFloat(d);
		if(d==parseInt(d,10)){
			if(d<0)return -1;
			return 1;
		}else{
			d=d+"";
			var len=(d.substr(d.indexOf(".")+1)).length;
			var ret=1;
			for(var i=1;i<=len;i++){
				ret=ret.mul(0.1);
			}
			if(d<0)ret=-ret;
			return ret;
		}
	},
	/**
	 *add by robin 20130115对明细每行做进位，包含单价和最后合计金额
	 *@param items 明细数据
	 */
	algItemsPrice:function(items){
		for(var i=0;i<items.length;i++){
			var item=items[i];
			item.priceactual=this.alg(item.priceactual,true);
			item.price=(item.priceactual).mul(item.qty);
		}
	},
	/**
	 *add by robin 20130115对 splitItem方法的补充，拆分item后再更新到items数组中
	 *@param item 需要拆分的item
	 *@param items 需要更新的数据数组
	 *@param qty 拆分出去的数量
	 *@return oitem 返回拆分出去的item。由于item是个json对象，在内存中是唯一的，所以返回给其他需要对其操作的函数
	 */
	splitItemAndRefreshItems:function(item,items,qty){
		var oitem=this.splitItem(item,qty);
		this.items_datapushitem(oitem,items);
		return oitem;
	},
	/**
	 *add by robin 20130115 在付款之前 明细里面的金额和单价是没有使用进位方式的，这会导致退货时出现误差等情况。
	 *此方法的作用是使用付款的最后实际金额反算到每个明细中，并且对每行明细进行店仓进位方式进位。
	 *@param items 给定数据数组
	 */
	refrectItems:function(items){
		this.algItemsPrice(items);
		var itemstotprice=this.gettotdata(items,"price").totprice;
		var realprice=(this.payitem.TotalAmount).sub(this.viprecharge);
		var diff=realprice.sub(itemstotprice);
		if(Math.abs(diff)==0)return;
		var cellUnit=this.getSmallestUnit(diff);
		var count=diff.div(cellUnit);
		var cc=0
		var c=0;//cc和c的作用是避免死循环，如果一个零售单里面没有正常的零售全部是 赠品 退货之类的 而且也产生了进位之后的误差，那么只能对 这些明细进行"多退少补"
		while(count>0){
			cc++;
			for(var i=0;i<items.length;i++){
				var item=items[i];
				if((cc==1||c>0)&&this.value2type(item.type)!="正常")continue;
				if(count>=item.qty){
					item.priceactual=(item.priceactual).add(cellUnit);
					item.price=(cellUnit.mul(item.qty)).add(item.price);
					count=count.sub(item.qty);
					c++;
				}else if(count>0){
					var oitem=this.splitItemAndRefreshItems(item,items,(item.qty).sub(count));
					oitem.priceactual=(oitem.priceactual).add(cellUnit);
					oitem.price=(cellUnit.mul(oitem.qty)).add(oitem.price);
					c++;
					count=count.sub(oitem.qty);
				}else{
					break;
				}
			}
		}
	
	},
	/**
	Add by Robin 20110219初始化报错单据的数据
	如果初始化成功则返回true,否则返回false
	*/
	initInsertSaveDate:function(){
			 var totpayamount=this.getpaymentamount();
	     
			if(this.payitem.TotalAmount-totpayamount>0){
				alert("付款金额小于应付金额！");
				return false;
			}else{
			
			var comment=$("comment").value.replace("按下F10键输入商品备注...","");
			var sys_date=parseFloat($("sys_date").value);	
	    var m_retail_productno =new Array();
	    var m_retail_productvalue =new Array();  
	    var m_retail_qty =new Array(); 
	    var m_retail_pricelist =new Array(); 
	    var m_retail_discount =new Array();       
	    var m_retail_priceactual =new Array(); 
	    var m_retail_price =new Array(); 
	    var m_retail_salerid =new Array(); 
	    var m_retail_saler =new Array(); 
	    var multisalerids=new Array();
	    var multisalerTrueNames=new Array();
	    var m_retail_type =new Array();
	    var m_retail_productname =new Array(); 
	    var m_retail_color =new Array(); 
	    var m_retail_colorname=new Array(); 
	    var m_retail_size=new Array(); 
	    var m_retail_sizename=new Array(); 
	    var m_retail_mdim11=new Array(); 
	    var description1 =new Array();
	    var totamtlist=new Array();   
	    var orgdocno=new Array(); 
	    var discription2=new Array();
	    var m_pda_id = new Array();
	    var paywayid=new Array();
	    var paymount=new Array();
	    //20110413新增 商场结算类型
	    var m_retail_markbaltype_id=new Array();
	    //20101025 新增实际付款金额，有时付款明细中金额不等于实际付款金额，如贵宾券 不找零
	    var realpaymount=new Array();
				
			//20110719 新增策略数组，记录name、id，			
			var m_retail_sin_disname=new Array();
			var m_retail_sin_disid=new Array();
			var m_retail_com_disname=new Array();
			var m_retail_com_disid=new Array();
			var m_retail_add_disname=new Array();
			var m_retail_add_disid=new Array();
			
			
			
			//20121122新增VIP当日当月消费记录到明细
			var m_retail_vipbirdis_id=new Array();
				
			//排序付款方式，将现金付款置后		  
			this.sortToEndByName(this.payment,"现金");
			
	    var j=0;
	    if(this.payment.length==0){
	    	paywayid[0]=this.getpaywaybypayname("现金").id;
	    	paymount[0]=0.00;
	    	realpaymount[0]=0.00;
	    	discription2[0]="-1";
	    }else{
 		    for(j=0;j<this.payment.length;j++){
 		    			paywayid[j]=parseFloat(this.payment[j].payid);
   	          paymount[j]=parseFloat(this.payment[j].num);
   	          realpaymount[j]=parseFloat(this.payment[j].num);
   	          discription2[j]=this.payment[j].remark;
   	     }
 	     }
 	     if(totpayamount>this.payitem.TotalAmount){
	     		for(var o=0;o<this.payment.length;o++){
	     			if(this.checkIsTicketPayWay(this.payment[o])){
	     				paymount[o]=paymount[o].sub(totpayamount.sub(this.payitem.TotalAmount));
	     				totpayamount=this.payitem.TotalAmount;
	     				this.change=0;
	     				break;
	     			}
	     		}
	     		if(totpayamount!=this.payitem.TotalAmount){
	     			alert("付款金额与商品金额不相等，请重付！");
	     			return;
	     		}
	    	}
	    $("next").disabled=true;
			$("re").disabled=true;
			$("cancle").disabled=true;
    	if(this.change!=0){ 	
       	discription2[j-1]="找零"; 		
     	}
	    var i=0;     
	    var items;
	    
	    if(this.temp_items_data.length>0){
	    	items=this.temp_items_data;
	    }else{
	    	items=this.items_data;
	    }
	    
	    this.refrectItems(items);
	    //20110626新增营业员实名
	    var salertruename =new Array();
	    var salercode = new Array();
	    //alert(Object.toJSON(items));
	    for(i=0;i<items.length;i++){ 
	    	var item=items[i];
	     	m_retail_productno[i] =item.productno;//m_retail_productno+"'"+this.line[i].m_retail_productno+"'"+",";
		    m_retail_productvalue[i]=item.productvalue; 
		   	m_retail_qty[i] =item.qty; 
		    m_retail_pricelist[i]=item.pricelist;
		   	m_retail_discount[i]=this.dalg(item.discount);
		   	//this.totdiacount=(this.totdiacount).add((item.discount).mul(item.qty));
		   	m_retail_priceactual[i] =item.priceactual;
		   	m_retail_price[i] =item.price;
		   	m_retail_salerid[i] =item.salerid;
		   	m_retail_saler[i]=item.saler;
		   	salertruename[i]=this.getSalerTrueName(item.saler,item);
		   	salercode[i]=this.getSalerCode(item.saler,item);
		   	multisalerids[i]=this.columnOfArrayJson2String(item.multisalers,"id",",");
		   	multisalerTrueNames[i]=this.columnOfArrayJson2String(item.multisalers,"truename",",");
		   	m_retail_type[i] =item.type;
		   	m_retail_productname[i] =item.productname; 
		   	m_retail_color[i] =item.color; 
		   	m_retail_colorname[i] =item.colorname; 
		   	m_retail_size[i]=item.size; 
		   	m_retail_sizename[i]=item.sizename;
		   	m_retail_mdim11[i]=item.mdim11; 
				m_pda_id[i]=parseInt(item.pda_id,10); 
				m_retail_markbaltype_id[i]=item.markbaltype;
		   	if(item.discription==""||item.discription=="null"||!(item.discription)){
		   		//edit by robin 20100719
		   		description1[i] ="-1";
		   	}else{
		     	description1[i]=item.discription;
		    }
		   	totamtlist[i]=item.pricelist*item.qty;
		    if(item.orgdocno==""||item.orgdocno=="null"){
		   	//edit by robin 20100719
		   		orgdocno[i] ="-1";
		   	}else{
		   		orgdocno[i]=item.orgdocno;	
		    }
				m_retail_sin_disname[i]=item.sin_disname;
				m_retail_sin_disid[i]=item.sin_disid;
				m_retail_com_disname[i]=item.com_disname;
				m_retail_com_disid[i]=item.com_disid;
				m_retail_add_disname[i]=item.add_disname;
				m_retail_add_disid[i]=item.add_disid;	
				m_retail_vipbirdis_id[i]=item.vipbirdisid||-1;
	 		 }       		      
		  var c_integralmin_id=-1;
		  var integral=-1;
		  //add by robin 20111229 是否参加VIP积分抵扣活动
		  var vipIntegralDis='N';
		  var vipDisContent=0;
		  if(this.tempvipdis){
		  	vipIntegralDis='Y';
		  	c_integralmin_id=this.tempvipdis.c_integralmin_id;
		  	integral=this.tempvipdis.totintegral;
		  	vipDisContent=this.tempvipdis.content;
		  }
		  //add by robin 20111229 消费卡信息 [{cardno:卡号, remCash:原余额,pay:本单已用金额}]
			var consumecardsinfo=new Array();
			if(this.consumecards&&this.consumecards.length>0){
				consumecardsinfo=this.getConsumecardsinfo();
			}			
			//add by robin 20121121 存在明细合计金额不等于 付款金额的情况，需要差价反算到明细的金额（price）中
			
			
			// add by robin 20121122 新增 VIP当日当月“按笔数”的活动的记录ID，没有就默认为-1
			var vipbirdisid=items.vipbirdisid||-1;
			
			
			
		  //Add by Robin 20110301 增加字段isIntl值等于webpos.vip.isIntl 是否积分
		  var isIntl='N';
		  if(this.vip&&this.vip.isIntl=='Y')isIntl='Y';
		  //注意 salerid1保存的是 salers 的 name,saler 保存的 是salers 的 id
			this.submititems={"storename":this.master_data.c_store_name,"storeid":this.master_data.c_store_id,"printmetrail":"Y","billdate":sys_date,"description":comment,"storecode":this.master_data.storecode,
				"vipid":this.tempvip.vip_id||this.vip.vip_id||-1,"amtchange":this.change,"salerid":this.master_data.saler.id,"salerid1":m_retail_salerid,
				"saler":m_retail_saler,"saler_truename":salertruename,"salercode":salercode,"qty":m_retail_qty,"priceactual":m_retail_priceactual,"pricelist":m_retail_pricelist,"price":m_retail_price,"productno":m_retail_productno,
				"productname":m_retail_productname,"color":m_retail_color,"colorname":m_retail_colorname,"size":m_retail_size,"sizename":m_retail_sizename,
				"productvalue":m_retail_productvalue,"mdim11":m_retail_mdim11,"orgdocno":orgdocno,"description1":description1,"type":m_retail_type,"m_retail_markbaltype_id":m_retail_markbaltype_id,
				"paywayid":paywayid,"paymount":paymount,"discount":m_retail_discount,"discription2":discription2,"realpaymount":realpaymount,
				"m_pda_id":m_pda_id,"ptype":"save","refno":this.master_data.refno,"cardno":this.tempvip.cardno||this.vip.cardno,
				"createtime":this.master_data.createTime,"isaddvip":this.tempvip.vip_id?"Y":"N","operatorname":this.master_data.operator.name,"operatorid":this.master_data.operator.id,
				"vip_amt":this.viprecharge,"isPendingOrder":this.master_data.canModify==0?'Y':'N',"vip_cardno":this.vip.cardno,"bpos_vip":this.vip,
				"c_integralmin_id":c_integralmin_id,"integral":integral,"vipIntegralDis":vipIntegralDis,"vipDisContent":vipDisContent,"isintl":isIntl,"sin_disid":m_retail_sin_disid,"consumecardsinfo":consumecardsinfo,
				"sin_disname":m_retail_sin_disname,"com_disid":m_retail_com_disid,"com_disname":m_retail_com_disname,"add_disid":m_retail_add_disid,"m_retail_vipbirdis_id":m_retail_vipbirdis_id,"add_disname":m_retail_add_disname,"vouinfo":this.vouinfo,
				"tdefposdis_id":this.tdefposdis_id,"tdefposdis_name":this.tdefposdis_name,"execVipBirthdayMonthDis":this.execVipBirthdayMonthDis?1:0
				,"multisalerids":multisalerids,"multisalerTrueNames":multisalerTrueNames,"rememberSelectedRetailValue":this.master_data.remember_retail_value,"market":this.master_data.market,"vipbirdisid":vipbirdisid};
				//alert(Object.toJSON(this.submititems));
			return true;
		}		
	},
	//根据name将对应的数组元素排序到后面
	sortToEndByName:function(array,name) {
		  if(array.length!=0) {
		  	var payment_length=array.length;
		  	for(var i=0;i<payment_length;i++) {
		  		if(array[i].name==name) {
		  			for(var j=1;j<payment_length&&i<payment_length-j;j++) {
		  				if(array[payment_length-j].name!=name) {
				  			this.exchangeItemByIndex(array,i,payment_length-j);
								payment_length-=j;
				  			break;
			  			}			
		  			}  			
		  		}
		  	}
		  } 
	},
	//交换数组内的两个item
	exchangeItemByIndex:function(items,orgindex,tarindex) {
		if(items.length!=0) {
			var temp=items[orgindex];
			items[orgindex]=items[tarindex];
			items[tarindex]=temp;
		}
	},
	doSave:function(){
			var evt={};
			evt.command="DBJSON";
			evt.callbackEvent="BPOS_SAVE_PRINT";
			evt.table="m_retail";
			evt.action="insert_save";
			evt.permission="r";		
			evt.isclob=true;
			evt.param=Object.toJSON(this.submititems);
			//alert(evt.param);
			this._executeCommandEvent(evt);
	},
	//Add by Robin20110219 检查是否含有VIP付款
	checkHasVipPayWay:function(){
		if(this.payitem._totalVipCharge!=0)return true;
		return false;
	},
	//Add by Robin 20110228 检查是否为消费券付款方式
	checkIsTicketPayWay:function(payway){
		if(this.ticketpayways.length>0&&payway.payid==this.ticketpayways[0].id){	
 			return true;
 		}
		for(var i=0;i<this.master_data.payways.length;i++){
			var pw=this.master_data.payways[i];
			if(payway.payid==pw.id){
				if(pw.isticket=="Y"||(pw.ischarge=="N"&&pw.iscash=="Y")){
					return true;
				}
			}
		}
		return false;
	},
	//20110602 robin 检查时候有消费卡的付款
	checkHasConsumeCardPayWay:function(){
		for(var o=0;o<this.payment.length;o++){
			for(var i=0;i<this.consumecardpayways.length;i++){
				if(this.payment[o].payid==this.consumecardpayways[i].id)return true;
			}
	 	}
	 	return false;
	},
	//检测是否含有购物券付款方式
	checkHasVouPayWay:function(){
		if(this.vouinfo&&this.vouinfo.amtAcount)return true;
		for(var o=0;o<this.payment.length;o++){
			for(var i=0;i<this.voupayways.length;i++){
				if(this.payment[o].payid==this.voupayways[i].id)return true;
			}
	 	}
	 	return false;
	},
	//Add by Robin20110219 检查是否含有消费卷付款
	checkHasTicketPayWay:function(){
		for(var o=0;o<this.payment.length;o++){
			if(this.checkIsTicketPayWay(this.payment[o]))return true;
	 	}
	 	return false;
	},
	/**
	 *add by robin 20121122 检测是否含有VIP当日当月活动执行
	 */
	checkHasVipBirDis:function(){
		if(this.refreshVipDisUseQty()>0)return true;//1.含有限制件数的打折
		if(this.temp_items_data.vipbirdisid&&this.temp_items_data.vipbirdisid>0)return true;//2.已经执行 “单笔” 的VIP当日当月优惠活动
		return false;
	},
	
	
	//Add by Robin20110219 检查是否符合离线保存，无法离线：1.VIP付款、2.VIP积分付款、3.消费券、4.消费卡、5.VIP当日当月活动、6.使用购物券
	//新增 VIP当日当月活动时不能 离线 20121122
	//edit by robin 20130321 除掉 会普通消费券 的在线控制。即 普通消费券也可以 保存本地
	checkCanSaveOnOffLine:function(){
		if((this.checkIsOnline()&&this.master_data.params.offline=="false")||this.tempvipdis||this.checkHasVouPayWay()||this.checkHasVipPayWay()||this.checkHasConsumeCardPayWay()||this.checkHasVipBirDis()){
			return false;
		}
		return true;
	},
	/**
	 *add by robin 20121122 检测是否可以执行整单策略，一般情况下整单都是可以执行的。
	 *但是特别情况下。例如 VIP生日当日或当月的活动需要正价前提的，而且明细中已经执行了的。那么
	 * 就不应该执行整单策略了。否则就破坏了正价前提的规则
	 */
	checkCanDoWholeDis:function(){
		if(this.vip&&this.vip.vipdis&&this.vip.vipdis.ISFULLPRICE=='Y'&&this.checkHasVipBirDis())return false;
		return true;
	},
	/**
	 *add by robin 20121122 检测 是否可以挂单
	 */
	checkCanPendingOrder:function(){
		if((this.MODEL&this.HOOKORDER)!=this.HOOKORDER) return false;
		if(this.checkHasVipBirDis()) return false;
		return true;
	},
	//Add by Robin20110219 当保存单据成功后，执行其他动作如：打印。。。
	doSomeThingWhenSaveOrderSucc:function(ret){
		if(++this.orders%3==0){
			this.checkSession();
		}
		this.clearitems();
		//by add zxz at120611为了控制是不是默认营业员
	 if(this.master_data.params.defaultSaler.strip().toLowerCase()=="false"){
			this.master_data.saler={};//初始化当前营业员
			this.master_data.multisalers=new Array();
			jQuery("#emp_name").html("");	
			this.master_data.saler.id=-1;//1385行判断为true加上的
		}
		
		
  	this.killAlert("payment_content");
  	if(isIE()){
			var info={};
			this.submititems.operatorname=this.master_data.operator.name;
			if(ret&&ret.vipdocno)this.submititems.b_vipmoney_docno=ret.vipdocno;
			if(!ret){
				this.submititems.vip_integral="-";
				this.submititems.useIntegral="-";
				this.submititems.cur_vip_integral="-";
				this.submititems.integral_up='-';
				this.submititems.viplevel="-";
			}else if(ret&&ret.integral){
				this.submititems.vip_integral=ret.integral;
				this.submititems.cur_vip_integral=ret.cur_vip_integral||"0";
				this.submititems.viplevel=ret.viplevel||"-";
				this.submititems.integral_up=ret.integral_up||"-";
				this.submititems.useIntegral=ret.useIntegral||"-";
			}
			info.param=this.submititems;
			//记录打印信息,方便下次打印20101122
			this.printInfo=info;
			//add by robin 20110915
			this.updateSerialNumber();
			this.printorder(Object.toJSON(info));
			if(this.master_data.params.QXAbsPath)
			this.commandExt("echo off \n copy "+this.master_data.params.QXAbsPath+" com1 \n exit");
		}
		this.master_data.canModify=1;
		this._editvip("f2newretail");
	},
	//判断session是否失效
	checkSession:function(){
		jQuery.ajax({
			type:"POST",
			url:"/bpos/toindex.jsp?redirect&checkSession",
			timeout:120000,
			success:function(data){
				if(data=="noSession"){
					alert("由于长时间未操作，用户信息丢失，\n影响在线业务，请重新登录...");
					//window.location.href="/bpos/login.jsp";
				}
			}
		});
	},	

	//Add by Robin20110219 ACTIVEX 接口：报错零售单到本地
	saveOrder:function(param){
		if(this.offline==true&&isIE()){
			var ret= MainApp.saveOrder(param);
			ret=ret.evalJSON();
			if($("next").disabled==true)jQuery("#next,#re,#cancle").removeAttr("disabled");
			if(ret.code&&ret.code==-1){
				alert(ret.msg);
			}else{
				this.doSomeThingWhenSaveOrderSucc();
			}
		}
	},
	save:function(){
		if(this.initInsertSaveDate()){
			if(this.checkCanSaveOnOffLine()){
				var info={};
				info.param=this.submititems;
				this.saveOrder(Object.toJSON(info));
			}else{
				if(this.checkIsOnline()){
					this.testIsOnline();
				}else{
					alert("错误：离线模式无法上传！");
					if($("next").disabled==true)jQuery("#next,#re,#cancle").removeAttr("disabled");
				}
			}
		}
	},

	//根据进位方式计算	
	/**
	 *add by  robin 20121113增加是否可以进位的控制，因为计算单价的时候不应该去截取或进位，
	 *因为进位了可能导致最终的付款金额错误,
	 *@canAlg 为 true时 使用进位 否则使用保留5为小数的
	 *@precision 进位精度，即保留小数位多少位。
	 */
	alg:function(value1,canAlg,precision){ 
		if(typeof(value1)=="string")value1=parseFloat(value1);
		if(!canAlg) return (Math.round(parseFloat(value1.mul(100000)))).div(100000); 
		if(canAlg&&precision)return (Math.round(parseFloat(value1.mul(Math.pow(10,precision)))).div(Math.pow(10,precision))); 
		var temp1=0;   	
	 var calculation;
	 if(this.master_data&&this.master_data.calculation)
	 	calculation=this.master_data.calculation;
	 else calculation=1;
   if(calculation==1){
          temp1=(Math.round(parseFloat(value1.mul(100)))).div(100);  		      	
   }else if(calculation==2){
          temp1=Math.round(value1);	    		
   }else if(calculation==3){	
          temp1=parseInt(value1);  		
   }else if(calculation==4){	
   				if(value1<0){
   					value1=-value1;
          	temp1=-parseInt(value1.add(0.99));  
        	}else{
        		temp1=parseInt(value1.add(0.99));
        	}
   }else if(calculation==5){
          temp1=(Math.round(value1.mul(10))).div(10);  		     
   }else if(calculation==6){	
          temp1=parseInt(value1.mul(10)).div(10);  	
   } 
    return temp1;
  },
  //折扣进位方式
  dalg:function(value1){
  	if(typeof(value1)=="string")value1=parseFloat(value1);
  	return (Math.round(parseFloat(value1.mul(10000)))).div(10000);
  },
  discountalg:function(value1){
  	if(typeof(value1)==="string")value1=parseFloat(value1);
  	return (Math.round(parseFloat(value1.mul(100)))).div(100);
  },
  //20110415当结算类型选择改变时 更新到item中
  handleMarketBillWayWhenSelectChanged:function(lineno){
  	var item=this.getitembylinenofromitems_data(lineno);
  	var id=parseInt(jQuery("#markbaltype-"+lineno).val(),10);
  	item.markbaltype=isNaN(id)?-1:id;
  },
  //20110414 开启结算类型 画select
  initItemMarketBillWay:function(mid,markbaltype){
  	var html="<select id=\"markbaltype-"+mid+"\" onchange=\"bpos.handleMarketBillWayWhenSelectChanged("+mid+")\">"+
  	"<option value='-1' "+((-1==markbaltype)?"selected='true'":"")+">---无---</option>";
  	for(var i=0;i<this.master_data.markbaltypes.length;i++){
  		var mbtid=this.master_data.markbaltypes[i].markbaltype_id;
  		html+="<option value='"+mbtid+"' "+((mbtid==markbaltype)?"selected='true'":"")+" >"+this.master_data.markbaltypes[i].markbaltype_name+"</option>";
  	}
  	html+="</select>";
  	return html;
  },
  drawLine:function(mid,item,cssarry,columnarray,columnvaluearray,needMarketBillWay,marketBillWayIndex,cn,item_type){
  	var flagShowOrder=false;
  	item_type=="showOrder"?flagShowOrder=true:flagShowOrder=false;
  	var	str="<div class=\"from-"+cn+"\" "+(flagShowOrder?"":"id='row-"+mid+"' ondblclick='bpos.selectitem("+mid+")'")+">"+
  					"<div class=\"from-"+cn+"-line\">"+
						"<div class=\"from-span-"+cssarry[0]+"\">"+(flagShowOrder?"":"<input type=\"checkbox\" value=\""+mid+"\" name=\"m_retail\">")+mid+"</div>";
  	for(var i=1;i<cssarry.length;i++){
  		if(needMarketBillWay&&marketBillWayIndex==i){
  			str+="<div class=\"from-span-"+cssarry[i]+"\">"+this.initItemMarketBillWay(mid,item.markbaltype)+"</div>";
  		}else{
  			str+="<div class=\"from-span-"+cssarry[i]+"\" "+(flagShowOrder?"":"id=\""+columnarray[i]+"-"+mid+"\"")+((columnarray[i]=="colorname"||columnarray[i]=="sizename")?"style=\"text-align:left;\"":"")+
  					">"+this.getColumnHtmlValueByColumn(columnarray[i],item,mid,columnvaluearray[i],flagShowOrder)+
  					"</div>";
  		}
  	}
  	str+="</div></div>";
  	return str;
  },
  
  getColumnHtmlValueByColumn:function(column,item,mid,columnvalue,flagShowOrder){
  	var str;
  	switch(column){
  		case "productno":str=flagShowOrder?columnvalue:"<a style=\"color='red';cursor:pointer\" onclick=\"bpos.showAlert1('"+columnvalue+"',event,"+mid+")\">"+columnvalue+"</a>";break;
  	  case "productname":str=flagShowOrder?columnvalue:"<a style=\"color='red';cursor:pointer\" onclick=\"bpos.showAlert2('"+columnvalue+"',event)\" >"+columnvalue+"</a>";break;
  	  case "productvalue": str=(columnvalue||"-");break;
  	  case "pricelist":str=this.changenumber2yuan(columnvalue);break;
  	  case "discount":str=""+this.discountalg(columnvalue);break;
  	  case "priceactual":str=this.changenumber2yuan(columnvalue);break;
  	  case "price":str=this.changenumber2yuan(columnvalue);break;
  	  case "saler": str=this.getSalerTrueName(columnvalue,item);break;
  	  default:str=columnvalue;
  	}
  	return str;
  },
  ret_insertitem:function(mid,item,type,cn,item_type){
  	var retStr="";
  	var pageStyle=this.master_data.params.pageStyle;	
		var cssarray=new Array();
		var columnarray=new Array();
		var columnvaluearray=new Array();
		var needMarketBillWay=false;
		var marketBillWayIndex=-1;
		if(pageStyle=="redearth"){
				if(this.checkNeedMarketBillWay()){		
					 cssarray=["2","4","7","4","4","16","17","17","16","16","18"];
					 columnarray=["","productname","MarketBillWay","productvalue","productno","pricelist","qty","discount","priceactual","price","saler"];
					 columnvaluearray=[mid,item.productname,item.markbaltype,item.productvalue,item.productno,item.pricelist,item.qty,item.discount,item.priceactual,item.price,item.saler];
					 needMarketBillWay=true;
					 marketBillWayIndex=2;
				}else{
					 cssarray=["6","4","4","4","5","5","5","16","16","19"];
					 columnarray=["","productname","productvalue","productno","pricelist","qty","discount","priceactual","price","saler"];
					 columnvaluearray=[mid,item.productname,item.productvalue,item.productno,item.pricelist,item.qty,item.discount,item.priceactual,item.price,item.saler];
				}
		}else if(pageStyle=="tommy") {
			//序号 条码 款号 结算类型 系列1 小类 颜色 尺码 数量 原价 折扣 实价 金额  营业员
			if(this.checkNeedMarketBillWay()){
				cssarray=["13","4","04","7","19","19","13","13","2","16","13","16","16","9"];
				columnarray=["","productno","productname","MarketBillWay","productvalue","colorname","color","size","qty","pricelist","discount","priceactual","price","saler"];
				columnvaluearray=[mid,item.productno,item.productname,item.markbaltype,item.m_dim5,item.m_dim9,item.color,item.size,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler];
				needMarketBillWay=true;
				marketBillWayIndex=3;
			}else{
				cssarray=["13","4","04","19","19","14","14","2","16","13","16","16","14"];
				columnarray=["","productno","productname","productvalue","colorname","color","size","qty","pricelist","discount","priceactual","price","saler"];
				columnvaluearray=[mid,item.productno,item.productname,item.m_dim5,item.m_dim9,item.color,item.size,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler];
			}		
		}else if(pageStyle=="busen") {
			if(this.checkNeedMarketBillWay()){
				cssarray=["13","4","5","12","2","14","13","14","14","9","13","014","13","13","13","9"];
				columnarray=["","productno","MarketBillWay","productname","qty","pricelist","discount","priceactual","price","saler","type","productvalue","color","colorname","size","sizename"];
				columnvaluearray=[mid,item.productno,item.markbaltype,item.productname,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler,type,item.m_dim20,item.color,item.colorname,item.size,item.sizename];
				needMarketBillWay=true;
				marketBillWayIndex=2;
			}else{
				cssarray=["1","4","012","2","5","1","5","5","15","1","6","3","1","1","9"];
				columnarray=["","productno","productname","qty","pricelist","discount","priceactual","price","saler","type","productvalue","color","colorname","size","sizename"];
				columnvaluearray=[mid,item.productno,item.productname,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler,type,item.m_dim20,item.color,item.colorname,item.size,item.sizename];
			}
		}else if(pageStyle=="dunnu"){
			if(this.checkNeedMarketBillWay()){
				cssarray=["13","4","5","12","2","14","13","14","14","9","13","14","13","13","13","9","15"];
				columnarray=["","productno","MarketBillWay","productvalue","qty","pricelist","discount","priceactual","price","saler","type","productname","color","colorname","size","sizename","mdim11"];
				columnvaluearray=[mid,item.productno,item.markbaltype,item.m_dim7,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler,type,item.productname,item.color,item.m_dim8,item.size,item.sizename,item.mdim11];
				needMarketBillWay=true;
				marketBillWayIndex=2;
			}else{
				cssarray=["1","4","12","2","5","1","5","5","9","1","6","3","1","1","9","18","9","18"];
				columnarray=["","productno","productvalue","qty","pricelist","discount","priceactual","price","saler","type","productname","color","colorname","size","sizename","mdim11"];
				columnvaluearray=[mid,item.productno,item.m_dim7,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler,type,item.productname,item.color,item.m_dim8,item.size,item.sizename,item.mdim11];
			}
		}else{
			if(this.checkNeedMarketBillWay()){
				cssarray=["13","4","5","12","2","14","13","14","14","9","13","14","13","13","13","9","15"];
				columnarray=["","productno","MarketBillWay","productvalue","qty","pricelist","discount","priceactual","price","saler","type","productname","color","colorname","size","sizename","mdim11"];
				columnvaluearray=[mid,item.productno,item.markbaltype,item.productvalue,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler,type,item.productname,item.color,item.colorname,item.size,item.sizename,item.mdim11];
				needMarketBillWay=true;
				marketBillWayIndex=2;
			}else{
				cssarray=["1","4","12","2","5","1","5","5","9","1","6","3","1","1","9","18","9","18"];
				columnarray=["","productno","productvalue","qty","pricelist","discount","priceactual","price","saler","type","productname","color","colorname","size","sizename","mdim11"];
				columnvaluearray=[mid,item.productno,item.productvalue,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler,type,item.productname,item.color,item.colorname,item.size,item.sizename,item.mdim11];
			}
		}
	    retStr+=this.drawLine(mid,item,cssarray,columnarray,columnvaluearray,needMarketBillWay,marketBillWayIndex,cn,item_type);	
  	return retStr;
  	},
  
	/*
	*Edit by Robin 2010.7.13
	*@param :mid 行号
	*@param :item 产品明细的JSON对象 结构如：item{productno:"100112",
	*																							productvalue:"",
	*																							qty:2,
	*																							pricelist:123.20,//原价
	*																							discount:0.8,//折扣
	*																							priceactual:123.20,//实价
	*																							price:123.20,
	*																							saler:"张三",//营业员
	*																							type:1,//类型，1：正常；2：退货；3：赠品；4：全额
	*																							productname："AS001",//款号
	*																							color:"01",//颜色
	*																							colorname:"红",//颜色名
	*																							size:"002",//尺寸
	*																							sizename:"XL",//尺寸名
	*																							mdim11："070709"//原厂编码
	*																							}
	*/
	insertitem:function(mid,item){
		var str="";		
		this.linenos.push(mid);
		var cn=mid%2==0?"conduct":"row";
		var type="";
		
		switch(parseInt(item.type,10)){
			case 1:type="正常";break;
			case 2:type="退货";break;
			case 3:type="赠品";break;
			case 4:type="全额";break;
		}
		str=this.ret_insertitem(mid,item,type,cn);
		/**
		var pageStyle=this.master_data.params.pageStyle;	
		var cssarray=new Array();
		var columnarray=new Array();
		var columnvaluearray=new Array();
		var needMarketBillWay=false;
		var marketBillWayIndex=-1;
		if(pageStyle=="redearth"){
				if(this.checkNeedMarketBillWay()){		
					 cssarray=["2","4","7","4","4","16","17","17","16","16","18"];
					 columnarray=["","productname","MarketBillWay","productvalue","productno","pricelist","qty","discount","priceactual","price","saler"];
					 columnvaluearray=[mid,item.productname,item.markbaltype,item.productvalue,item.productno,item.pricelist,item.qty,item.discount,item.priceactual,item.price,item.saler];
					 needMarketBillWay=true;
					 marketBillWayIndex=2;
				}else{
					 cssarray=["6","4","4","4","5","5","5","16","16","19"];
					 columnarray=["","productname","productvalue","productno","pricelist","qty","discount","priceactual","price","saler"];
					 columnvaluearray=[mid,item.productname,item.productvalue,item.productno,item.pricelist,item.qty,item.discount,item.priceactual,item.price,item.saler];
				}
		}else if(pageStyle=="tommy") {
			//序号 条码 款号 结算类型 系列1 小类 颜色 尺码 数量 原价 折扣 实价 金额  营业员
			if(this.checkNeedMarketBillWay()){
				cssarray=["13","4","04","7","19","19","13","13","2","16","13","16","16","9"];
				columnarray=["","productno","productname","MarketBillWay","productvalue","colorname","color","size","qty","pricelist","discount","priceactual","price","saler"];
				columnvaluearray=[mid,item.productno,item.productname,item.markbaltype,item.m_dim5,item.m_dim9,item.color,item.size,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler];
				needMarketBillWay=true;
				marketBillWayIndex=3;
			}else{
				cssarray=["13","4","04","19","19","14","14","2","16","13","16","16","14"];
				columnarray=["","productno","productname","productvalue","colorname","color","size","qty","pricelist","discount","priceactual","price","saler"];
				columnvaluearray=[mid,item.productno,item.productname,item.m_dim5,item.m_dim9,item.color,item.size,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler];
			}		
		}else if(pageStyle=="busen") {
			if(this.checkNeedMarketBillWay()){
				cssarray=["13","4","5","12","2","14","13","14","14","15","13","014","13","13","13","9"];
				columnarray=["","productno","MarketBillWay","productname","qty","pricelist","discount","priceactual","price","saler","type","productvalue","color","colorname","size","sizename"];
				columnvaluearray=[mid,item.productno,item.markbaltype,item.productname,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler,type,item.m_dim20,item.color,item.colorname,item.size,item.sizename];
				needMarketBillWay=true;
				marketBillWayIndex=2;
			}else{
				cssarray=["1","4","012","2","5","1","5","5","15","1","6","3","1","1","9"];
				columnarray=["","productno","productname","qty","pricelist","discount","priceactual","price","saler","type","productvalue","color","colorname","size","sizename"];
				columnvaluearray=[mid,item.productno,item.productname,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler,type,item.m_dim20,item.color,item.colorname,item.size,item.sizename];
			}
		}else{
			if(this.checkNeedMarketBillWay()){
				cssarray=["13","4","5","12","2","14","13","14","14","9","13","14","13","13","13","9","15"];
				columnarray=["","productno","MarketBillWay","productvalue","qty","pricelist","discount","priceactual","price","saler","type","productname","color","colorname","size","sizename","mdim11"];
				columnvaluearray=[mid,item.productno,item.markbaltype,item.productvalue,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler,type,item.productname,item.color,item.colorname,item.size,item.sizename,item.mdim11];
				needMarketBillWay=true;
				marketBillWayIndex=2;
			}else{
				cssarray=["1","4","12","2","5","1","5","5","9","1","6","3","1","1","9","18","9","18"];
				columnarray=["","productno","productvalue","qty","pricelist","discount","priceactual","price","saler","type","productname","color","colorname","size","sizename","mdim11"];
				columnvaluearray=[mid,item.productno,item.productvalue,item.qty,item.pricelist,item.discount,item.priceactual,item.price,item.saler,type,item.productname,item.color,item.colorname,item.size,item.sizename,item.mdim11];
			}
		}
	str+=this.drawLine(mid,item,cssarray,columnarray,columnvaluearray,needMarketBillWay,marketBillWayIndex,cn);	
	**/
	
	/**if(item_type=="showOrder"){
	  var ele=Alerts.fireMessageBox({
	    width:1014,	   
	    modal:true,
	    title:gMessageHolder.EDIT_MEASURE
		});
		 str+="</div></div></br><div align=\"center\"><input type=\"button\" class=\"showOrder_back\" value=\"返回\" onclick=\"javascript:bpos.killAlert2('id_showOrder')\"/></br></br>"
		ele.innerHTML=str;
    bpos.executeLoadedScript(ele);	    
    bpos.noAlert=false;	
    jQuery("#id_showOrder input").hide();
    
     this.maxlineno=0;//全局变量 初始化0
			return;
			}**/
		jQuery("#from-main").append(str);		
	},
	//弹出窗口，显示库存20110419
	showAlert:function(barcode,event,lineno){
		var ele=Event.element(event);
		this.canPopAlert=true;
		var y=jQuery(ele).offset().top+jQuery(ele).height();
		var x=jQuery(ele).offset().left+jQuery(ele).width();
		jQuery("#alertMsgContent").html("查询中...");
		jQuery("#alertMsg").css("top",y).css("left",x);
		jQuery("#alertMsg").fadeIn("normal");
		if((lineno||lineno==0)&&this.flag_num==0){
			var item=this.getitembylinenofromitems_data(lineno);
			if(item.org_qty!=undefined&&item.org_qty!=0){
				jQuery("#tipContent").html("原单数量：");
				jQuery("#alertMsgContent").html(item.org_qty);
				window.setTimeout("jQuery(\"#alertMsg\").fadeOut(\"slow\");",3000);
				return;
			}else{
				barcode=item.productno;
			}
		}
		jQuery("#tipContent").html("可用库存：");
		barcode=encodeURI(barcode);
		//var x=event.clientX + document.body.scrollLeft - document.body.clientLeft;
		//var y=event.clientY + document.body.scrollTop - document.body.clientTop;
		
		 //alert("this.flag_num2:"+this.flag_num);
		jQuery.ajax({
				type:"POST",
				cache:false,
				url:this.URL+"getBarcodeQtyCanByUserId.jsp?flag_num="+this.flag_num+"&barcode="+barcode+(this.URL?("&storeid="+bpos.master_data.c_store_id):""),
				//url:this.URL+"getBarcodeQtyCanByUserId.jsp?barcode="+barcode+(this.URL?("&storeid="+bpos.master_data.c_store_id):""),
				timeout:3000,
						
				error:function(){
					jQuery("#alertMsgContent").html("网络不畅！");
					window.setTimeout("jQuery(\"#alertMsg\").fadeOut(\"slow\");",3000);
				},
				success:function(data){
					var qty=parseInt(data);
					if(qty==-99999||isNaN(qty)){
						jQuery("#alertMsgContent").html("无库存！");
					}else{
						jQuery("#alertMsgContent").html(qty);
					}
					window.setTimeout("jQuery(\"#alertMsg\").fadeOut(\"slow\");",3000);
				}
			}); 
	},
	showAlert1:function(barcode,event,lineno){
		
		
	   this.flag_num=0;
	   //alert("this.flag_num1:"+this.flag_num);
	   this.showAlert(barcode,event,lineno);
	},
	showAlert2:function(barcode,event){
		
		
	   this.flag_num=1;
	   
	   this.showAlert(barcode,event);
	
	},
	hiddenAlert:function(){
		jQuery("#alertMsg").hide();
	},
	deletelines:function(){
		if((this.MODEL&this.DELETE)!=this.DELETE){
			alert("该单不可删除！");
			return;
		}
		var linenoes=this.getcheckedlinenoes();
		var len=linenoes.length;
		if(len==0){
			alert("请选择明细！");
			return;
		}
		var selectrow=this.linenos[this.selectid];
		if(confirm("您选择了"+len+"行，确认删除！？")){		
			for(var i=0;i<len;i++){
				this.deleline(linenoes[i]);
				if(linenoes[i]<selectrow) {
					this.selectid--;
				}
			}
		}
		//获得存在的行号
		for(var i=0;i<this.delLineindex.length;i++) {	
			this.linenos.splice(this.delLineindex[i],1);
		}
		this.delLineindex=new Array();	
		this.updatehtml();
		if(!this.linenos[this.selectid]) {
			this.preretail();
		}else {
			this.nextretail("d");
		}
	},
	/**
	 *给定元素的ID，清空此元素下所有被选的checkbox
	 *@param ：元素的ID
	 */
	clearchecked:function(id){
		jQuery("#"+id+" input:checked").each(function(){
			this.checked=false;
		});
	},
	/**
	*Edit by Robin 2010.7.15
	*获得所有已选择的行号
	*@return :返回一个被选择的行号的数组
	*/
	getcheckedlinenoes:function(){
		var linenoes=new Array();
		jQuery("#from-main input:checked").each(function(){
			var v=parseInt(jQuery(this).val(),10);
			linenoes.push(v);
		});
		return linenoes;
	},
	/**
	 *Edit by Robin 20100724
	 *更新单据头信息，单号，VIP,营业员
	 */
	updateheaderhtml:function(newretail){
		//单据号写入
		if(this.master_data){
				jQuery("#column_23983").html(this.master_data.refno||this.master_data.docno);
		}
		jQuery("#vipnum").html(this.vip.cardno||"");
		jQuery("#viptype1").html(this.vip.c_viptype||"");
		//jQuery("#sys_date option[text='"+this.nowDate+"']").attr("selected","true");
		this.selectDate=this.nowDate;
		if(newretail&&newretail=="f2newretail"){
			//alert(window.document.getElementById("emp_name").value);
		}else{
			if(this.master_data&&this.master_data.params&&this.master_data.params.multiSalers=="true"){
				jQuery("#emp_name").html(this.salersTrueName2String(this.master_data.multisalers));
			}else if(this.master_data&&this.master_data.saler&&this.master_data.saler.id){
				jQuery("#emp_name").html(this.master_data.saler.name+"("+this.master_data.saler.truename+")"||"");
			}
		}
	
		
		
	},
	/**
	*Edit by Robin 2010.7.13
	*更新显示数据：总数，原价金额，应付金额
	*/
	updatehtml:function(){
		var tot=this.gettotdata();
		$("tot_num").innerHTML=tot.totqty;
		$("tot_payable").innerHTML=this.formatint2float(this.alg(tot.totprice,true));
		$("tot_amt").innerHTML=this.formatint2float(this.alg(tot.totpricelist));
	},
	/**
	 *根据lineno得到this.items_data所在元素的index
	 *@param:lineno 行号
	 */
	getindexbylinenofromitems_data:function(lineno){
		for(var i=0;i<this.items_data.length;i++){
			if(this.items_data[i].lineno==lineno){
				return i;
			}
		}
	},
	/**
	*Edit by Robin 2010.7.15
	*传入行号，删除一行
	*@param:lineno 行号
	*/
	deleline:function(lineno){
		var index=this.getindexbylinenofromitems_data(lineno);
		if(this.items_data[index].locked==1){
			alert("该行不可删除！");
			return;
		}
		this.items_data.splice(index,1);
		this.delLineindex.push(index);
		jQuery("#row-"+lineno).remove();
	},
	/**
	*Edit by Robin 2010.7.15
	*传入行号和ITEM的JSON对象，更新一行内容
	*@param：lineno 行号
	*@param:item 明细JSON对象，你可以更新一个属性如productno则JSON为 item:{productno:"dsfds"}
	*            也可以更新多个属性 如item:{qty:3,price:300.00,pricelist:200.00}
	*
	*/
	updateline:function(lineno,item){
		if(item.productno){
			jQuery("#productno-"+lineno).html("<a style=\"color='red';cursor:pointer\" onclick=\"bpos.showAlert1('"+item.productno+"',event,"+lineno+")\">"+item.productno+"</a>");
		}
		if(item.markbaltype){
			jQuery("#markbaltype-"+lineno).val(item.markbaltype);
		}
		if(item.qty||item.qty==0){
			jQuery("#qty-"+lineno).html(item.qty+"");
		}
		if(item.pricelist||item.pricelist==0){
			jQuery("#pricelist-"+lineno).html(this.changenumber2yuan(item.pricelist));
		}
		if(item.discount||item.discount==0){
			jQuery("#discount-"+lineno).html(this.discountalg(item.discount)+"");
		}
		if(item.priceactual||item.priceactual==0){
			jQuery("#priceactual-"+lineno).html(this.changenumber2yuan(item.priceactual));
		}
		if(item.price||item.price==0){
			jQuery("#price-"+lineno).html(this.changenumber2yuan(item.price));
		}
		if(item.saler){
			jQuery("#saler-"+lineno).html(this.getSalerTrueName(item.saler,item));
		}
		if(item.type){
			var type=this.value2type(item.type);
			jQuery("#type-"+lineno).html(type);
		}
		
	},
	//Edit by Robin 20100809 转换为数组
	change2array:function(obj){
		var objs=new Array();
		if(obj.length){
			objs=obj;
		}else{
			objs.push(obj);
		}
		return objs;
	},
	
	//Edit by Robin 2010-08-23
	//转化数字为人民币的显示字串格式：“￥530.39”
	changenumber2yuan:function(num){
		var s=this.formatint2float(num);
		return "￥"+s;
	},
	/**
	 * add by robin 20121115 增加考勤接口调用
	 * 调用ACTIVEX控件接口
	 */
	checkWorkAttendance:function(){
		try{
			MainApp.checkWorkAttendance();
	  }catch(e){
	  	alert(e.message);
	  }
	}
	
	
};
BPOS.main = function () {
	bpos=new BPOS();
};
jQuery(document).ready(BPOS.main);
jQuery(document).ready(function(){
		jQuery("#from-main").bind("keydown",function(event) {
			if(event.which==32) {
				bpos.enterSelect();
	  		event.stopPropagation();
				event.preventDefault();
			}
		});		
	jQuery("body").bind("keydown",function(event){
		
		if(bpos.noAlert){
			if(event.which==46){
	  			bpos.deletelines();
	  	}else if(event.which==38) {
	  		bpos.preretail();
	 	  	event.stopPropagation();
				event.preventDefault();	  	
			}else if(event.which==40) {
	  		bpos.nextretail();
				event.stopPropagation();
				event.preventDefault();
				
	  	}else if(event.target!=$("m_retail_idx")&&event.target!=$("comment")&&bpos.noAlert){
				$("m_retail_idx").focus();
			}
  	}
  	if($("payselect")){
  		var id = event.srcElement.id;
	  	if(event.which==13&&$("currpay").disabled!=true&&(id=="payselect"||id=="pos-body"||id==""||id=="payment_content"||id=="payment-main"||id=="alert-message")) {
	  		dwr.util.selectRange($("currpay"), 0,15);
	  	}
  		if(event.ctrlKey==true&&event.which==81){
  			bpos.handlevisitantticket();
  		}
  		if($("ticketno")&&event.ctrlKey==true&&event.which==84){
  			jQuery("#ticketno").removeAttr("readonly");
  		}
  	}
	});
	//在线店务
	/***jQuery("#lineshop").hover(function(){$("onshop").show();},function(){$("onshop").hide();});
	jQuery("#report").hover(function(){$("onlinereport").show();},function(){$("onlinereport").hide();});
	jQuery("login_user").hover(function(){jQuery(this).css("color","#f00");},function(){jQuery(this).css("color","#fff");});
	jQuery(".input").hover(function(){jQuery(this).css("color","#f00")},function(){jQuery(this).css("color","#333")});
	**/
	//阻止a触发onbeforeunload事件
	//	jQuery("a").each(function() {if(jQuery(this).attr("href")==-1)jQuery(this).removeAttr("href");});

//add by zxz 120524优化了首页菜单下拉框
jQuery(".hmain").hover(function(){
		jQuery(this).children("ul").fadeIn();		
		//this.changeIcon(jQuery(this));
		//jQuery(this).find("a").eq(0).css("background-image","url('images/expanded.gif')");
	},function(){
		jQuery(this).children("ul").fadeOut();		
		//this.changeIcon(jQuery(this));
		//jQuery(this).find("a").eq(0).css("background-image","url('images/collapsed.gif')");
	});
	
	


});





