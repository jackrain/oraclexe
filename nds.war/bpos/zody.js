var zody=null;
var ZODY=Class.create();

ZODY.prototype={       
	initialize: function() { 
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
		
		application.addEventListener( "BPOS_GUADAN", this._guaDan, this);
		application.addEventListener( "BPOS_DOGUADAN", this._doGuaDan, this);
		application.addEventListener( "BPOS_GETGUADAN", this._callGetGuaDan, this);
		application.addEventListener( "BPOS_CLOSEGUADAN", this._callCloseGuaDan, this);

		//初始化备注框状态为不可编辑状态
		jQuery("#comment").attr("disabled",true);
		jQuery("#comment").val("按下F10键输入商品备注...");
		jQuery("#comment").blur(function(){		
			if(jQuery("#comment").val()==""){
				jQuery("#comment").val("按下F10键输入商品备注...");
				jQuery("#comment").attr("disabled",true);
			}else{
				jQuery("#comment").attr("disabled",true);
			}
	    });

		//method:监听F10键备注得到焦点，扫条码框失去焦点 
		//param:e  event对象
		jQuery(document).keydown(function(e){
			if(e.which==121 ){
				if(bpos.nosalererror()){
					return;
				}
				zody.ope();
			}
		});
},
	
	//method:按下F10键备注得到焦点，扫条码框失去焦点 ope
	//param:	
	ope:function(){
		var sSt="按下F10键输入商品备注...";
		jQuery("#comment").removeAttr("disabled");
		if(jQuery("#comment").val()==sSt){
			jQuery("#comment").val("");
			jQuery("#comment").focus();
		}else{
			jQuery("#comment").select();
		}		
	},
	//method:按下回车备注失去焦点，扫条码框得到焦点 udone
	//param: evt    event对象
	udone:function(evt){
		var evt=evt?evt:(window.event?window.event:null);
		if(evt.keyCode==13){
			jQuery("#comment").attr("disabled",true);
			if(jQuery("#comment").val()==""){
				jQuery("#comment").val("按下F10键输入商品备注...");
			}
			jQuery("#m_retail_idx").focus();
		}
	},

	//method:清除条码框和初始化备注框
	//param:	
	clear:function(){
		jQuery("#m_retail_idx").val("");
		jQuery("#comment").val("按下F10键输入商品备注...");
	},
	
	//method:挂单或处理挂单 guaDanOrChuli
	//param:
	guaDanOrChuli:function(){
		 if(!bpos.checkCanPendingOrder()){
		 		alert("该单据不可挂单！")	;
		 		return;
		 }
		 /*
		 if(bpos.master_data.saler.id==-1&&bpos.nosalererror()){
				 return;
		 }*/
		 
		 /*Edit by Robin 20100828
			if(jQuery("#column_23983").text()!="系统维护"){
				alert("此单据为挂单处理单据，不能进行挂单操作!");
				return false;
			}*/
		if(bpos.items_data.length<=0){	
			if(window.confirm("确认执行处理挂单操作？")){
				zody.doGuaDan();
				zody.clear();
				return false;
			}
		}else{
			zody.guaDanTi();				
			jQuery("#zody_textarea").focus();
		}

	},

	//method:挂单并打印 guaDan
	//param:	print 为空则不打印,反之打印
	guaDan:function(print){	
		//alert(Object.toJSON(bpos.items_data));
			var billdate1=0;
			billdate1 = jQuery("#sys_date").val();
			var billdate = parseInt(billdate1);
			var evt = {};
			var printed="N";
			//alert(bpos.master_data.canModify);
			var canModify=bpos.master_data.canModify;
			if(print!=""){
				printed="Y";
				canModify=0;
			}
			//if(bpos.master_data.canModify==0)canModify==0;
			//alert(canModify);
			evt.command = "DBJSON";
			evt.callbackEvent = "BPOS_GUADAN";
			var comment="";
			comment=$("comment").value
			if(comment=="按下F10键输入商品备注..."){
				comment="";
			}
			var orgdocno = new Array();
			var m_pda_id = new Array();
			var m_retail_qty = new Array();
			var m_retail_priceactual=new Array();
			var description1=new Array();
			var m_retail_type=new Array();
			var productno = new Array();
			var productname = new Array();
			var pricelist = new Array();
			var discount = new Array();
			var priceactual = new Array();
			var price=new Array();
			var m_retail_salerid =new Array();
			var productvalue = new Array();
			var color=new Array();
			var colorname=new Array();
			var size = new Array();
			var sizename=new Array();
			var mdim11 = new Array();
			var locked=new Array();
			var lowest_discount=new Array();
			var m_retail_saler=new Array();
			var multisalers=new Array();
			var m_retail_markbaltype_id=new Array();
			var m_retail_sin_disname=new Array();
			var m_retail_sin_disid=new Array();
			var m_retail_com_disname=new Array();
			var m_retail_com_disid=new Array();
			var m_retail_add_disname=new Array();
			var m_retail_add_disid=new Array();
			var m_retail_org_payways=new Array();
			var m_retail_org_payamounts=new Array();
			var m_retail_org_billdate=new Array();
			var m_retail_sysdate=new Array();
			for(var r=1;r<=20;r++){
				eval("var m_dim"+r+"=new Array();");
			}
			var vip=0;
			var record = jQuery.trim(jQuery("#zody_textarea").text());
			for(var i=0;i<bpos.items_data.length;i++){
				orgdocno[i]=bpos.items_data[i].orgdocno;
				m_retail_org_payways[i]=bpos.items_data[i].org_payways;
				m_retail_org_payamounts[i]=bpos.items_data[i].org_payamounts;
				m_retail_org_billdate[i]=bpos.items_data[i].org_billdate;
				m_retail_sysdate[i]=bpos.items_data[i].sysdate;
	
				m_pda_id[i]=bpos.items_data[i].pda_id;
				m_retail_qty[i]=bpos.items_data[i].qty;
				m_retail_priceactual[i]=bpos.items_data[i].priceactual;
				description1[i]=bpos.items_data[i].discription;
				productno[i]=bpos.items_data[i].productno;
				productname[i]=bpos.items_data[i].productname;
				pricelist[i]=bpos.items_data[i].pricelist;
				discount[i]=bpos.items_data[i].discount;
				priceactual[i]=bpos.items_data[i].priceactual;
				price[i]=bpos.items_data[i].price;
				m_retail_salerid[i] =bpos.items_data[i].salerid;
				//add by robin 20101214 add saler name
				m_retail_saler[i]=bpos.items_data[i].saler;
				
				//add by robin20120420
				multisalers[i]=bpos.items_data[i].multisalers;
				productvalue[i]=bpos.items_data[i].productvalue;
				color[i]=bpos.items_data[i].color;
				colorname[i]=bpos.items_data[i].colorname;
				size[i]=bpos.items_data[i].size;
				sizename[i]=bpos.items_data[i].sizename;
				mdim11[i]=bpos.items_data[i].mdim11;
				m_retail_type[i]=bpos.items_data[i].type;	
				m_retail_markbaltype_id[i]=bpos.items_data[i].markbaltype;	
				locked[i]=bpos.items_data[i].locked||0;
				lowest_discount[i]=bpos.items_data[i].lowest_discount||0;
				//新增策略name、id
				m_retail_sin_disname[i]=bpos.items_data[i].sin_disname;
				m_retail_sin_disid[i]=bpos.items_data[i].sin_disid;
				m_retail_com_disname[i]=bpos.items_data[i].com_disname;
				m_retail_com_disid[i]=bpos.items_data[i].com_disid;
				m_retail_add_disname[i]=bpos.items_data[i].add_disname;
				m_retail_add_disid[i]=bpos.items_data[i].add_disid;
				for(var rr=1;rr<=20;rr++){
					for(var p in bpos.items_data[i]){
						if(typeof(p)!="function"&&p=="m_dim"+rr){
							eval("m_dim"+rr+"["+i+"]=bpos.items_data["+i+"]."+p+";");
						}
					}
				}				
			}
			
			var operatorname= bpos.master_data.saler.id;
			var vipdd=bpos.vip.vip_id||-1;
			var param =	{"createtime":bpos.master_data.createTime,"storeid": bpos.master_data.c_store_id, "billdate": billdate, "description": comment,"vipid": vipdd, "salerid": operatorname,"salerid1":m_retail_salerid,"saler":m_retail_saler,
										"m_pda_id": m_pda_id,"qty": m_retail_qty, "priceactual": m_retail_priceactual, "orgdocno": orgdocno||"-1", "description1":description1, "type": m_retail_type, "ptype": "hook", 
										"amtchange": "", "printmetrail": "", "discription2": "", "paymount": "", "paywayid": "","productno":productno,"productname":productname,"m_retail_markbaltype_id":m_retail_markbaltype_id,
										"pricelist":pricelist,"discount":discount,"priceactual":priceactual,"price":price,"productvalue":productvalue,"color":color,"colorname":colorname,
										"size":size,"sizename":sizename,"mdim11":mdim11,"record":record,"operatorname":bpos.master_data.operator.name,"refno":bpos.master_data.refno,"vip_cardno":bpos.vip.cardno||"-1","bpos_vip":bpos.vip,"locked":locked,"lowest_discount":lowest_discount,
										"canModify":canModify,"printed":printed,"sin_disid":m_retail_sin_disid,"sin_disname":m_retail_sin_disname,"com_disid":m_retail_com_disid,"com_disname":m_retail_com_disname,"add_disid":m_retail_add_disid,"add_disname":m_retail_add_disname,
										"multisalers":Object.toJSON(multisalers),"m_retail_org_payways":Object.toJSON(m_retail_org_payways),"m_retail_org_payamounts":Object.toJSON(m_retail_org_payamounts),
										"m_retail_sysdate":m_retail_sysdate,"m_retail_org_billdate":m_retail_org_billdate
										};
			for(var y=1;y<=20;y++){
				eval("param.m_dim"+y+"=m_dim"+y+";");
			}
			evt.param=Object.toJSON(param);
			if(bpos.offline==true&&isIE()){
				var info={};
				info.param=param;
				//bpos.poshook(Object.toJSON(info));
				var ret=bpos.poshook(Object.toJSON(info));
				ret=ret.evalJSON();
				this.guadanaction(ret,print);
				return false;
			}else{
				evt.table="m_retail";
				evt.action="insert_save";
				evt.permission="w";	
				bpos._executeCommandEvent(evt);
			}
			jQuery("#comment").val("按下F10键输入商品备注...");
	},
	
	//method: 提示输入挂单原因  guaDanTi
	//param:
	guaDanTi:function(){
		var ele = Alerts.fireMessageBox({
				width: 400,
				modal: true,
				title: gMessageHolder.EDIT_MEASURE
			});
		var strTemp ="";
		strTemp=strTemp+"<div id=\"zody_div\"><div class=\"treatment_text\"><font color=\"red\">挂单原因:</font><center><textarea "+
				" id=\"zody_textarea\" class=\"zody_chatboxtextarea\"></textarea></center></div>";
		strTemp = strTemp+ "</div></div><div id=\"treatment_td\" align=\"center\"><div id=\"zody_treatment_text\">"+
					"<input type=\"button\" value=\"确定\" onclick=\"javascript:zody.doGuaDanTi()\" class=\"qinput\" id=\"btn-search\"/>&nbsp;"+
					"<input type=\"button\" value=\"挂单并打印\" onclick=\"javascript:zody.posPrint()\" class=\"qinput\" id=\"btn-search\"/>&nbsp;"+
					"<input name=\"Submit\" type=\"button\" class=\"qinput\" value=\"取消\" onclick=\"javascript:zody.killGuaDanTi()\" /></div>"+
					"</div></div>";
		ele.innerHTML = strTemp;
		bpos.executeLoadedScript(ele);
		bpos.noAlert=false;
		var ipt1;
		jQuery("#zody_div").bind("keydown",function(event){
			var aInp = jQuery("#zody_treatment_text input[type='button']");			
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
					zody.preGuaDanTi();
			}
		});
	},

	//method:验证 checkGuaDanTiShi
	//param: 
	checkGuaDanTiShi:function(){
		var ac="";
		if(jQuery.trim(jQuery("#zody_textarea").text())==""){	
			alert("挂单提示不能为空!");
			jQuery("#zody_textarea").focus();			
			return ac;			
		}else{
			ac="has";
			return ac;
		}
	},
	
	//method:挂单并打印  posPrint
	//param:	
	posPrint:function(){
		var aa=this.checkGuaDanTiShi();
		if(aa!=""){
			/**
			 *在网络畅通状态下不能做挂单打印操作
			 *反之执行打印操作
			 */
			jQuery.ajax({
				type:"POST",
				cache:false,
				url:"testonline.jsp?r='+(new Date()).getTime()+'",
				timeout:3000,
				error:function(){
					zody.guaDan("print");
					zody.killGuaDanTi();
				},
				success:function(data){
					alert("在线状态不能进行打印操作!");
					return false;
				}
			}); 
		}
	},

	//method:按回车确定挂单提示 preGuaDanTi
	//param: evt    event对象
	preGuaDanTi:function(){
		var aa=this.checkGuaDanTiShi();
		if(aa!=""){
			var print="";
			zody.guaDan(print);
		}
	},
	
	//method:确定挂单提示 doGuaDanTi
	//param:
	doGuaDanTi:function(){
		var aa=this.checkGuaDanTiShi();
		if(aa!=""){
			var print="";
			zody.guaDan(print);
			zody.killGuaDanTi();
		}
	},
	
	//method:关闭挂单提示 killGuaDanTi
	//param:
	killGuaDanTi:function(){
		bpos.killAlert("zody_div");
	},
	
	//method:挂单打印  guadanaction
	//param: ret   Server返回参数   print 为空则挂单,反之挂单并打印
	//Edit by Robin 20100809处理挂单返回值
	guadanaction:function(ret,print){		
		var docno=ret.refno||ref.docno;	
		if(docno!=""){
			zody.clear();
			zody.turnTime();
			if(print!=""){
				var param={"refno":docno};
				var info={};
				info.param=param;
				//alert(Object.toJSON(info));
				bpos.posprint(Object.toJSON(info));
				bpos.gethookcount();
			}else{
				bpos.gethookcount();
			}
			bpos.init();
			zody.killGuaDanTi();
			alert("挂单成功,挂单号为:"+docno);
			//add by robin 20110915
			bpos.updateSerialNumber();
			bpos._editvip();
			//alert(bpos.noAlert);
		}else{			
			alert("操作失败!");
			return false;
		}
	},

	//method:挂单回调函数   _guaDan
	//param: e    Server返回参数
	_guaDan:function(e){             // 
		var data=e.getUserData();
		var ret=data.jsonResult.evalJSON();		
		this.guadanaction(ret);
	},
	
	//method:处理挂单 doGuaDan
	//param:
	doGuaDan:function(){
		var billdate1=0;
		billdate1 = jQuery("#sys_date").val();
		var billdate = parseInt(billdate1);
		var evt = {};
		evt.command = "DBJSON";
		evt.callbackEvent = "BPOS_DOGUADAN";
		var param={"storeid": bpos.master_data.c_store_id,"datebeg":"20100101","dateend": billdate};
		if(bpos.offline==true&&isIE()){
				var info={};
				info.param=param;				
				param.datebeg=20100101;
				param.dateend=billdate;
				var ret=bpos.getposhooks(Object.toJSON(info));
				ret=ret.evalJSON();
				if(ret.NewDataSet.Table){
					ret=ret.NewDataSet.Table;
					ret=bpos.change2array(ret);
					this.doguadanaction(ret);
				}else{
					alert("无记录！");
				}
				return false;
		}
		evt.param=Object.toJSON(param);
		evt.table="m_retail";
		evt.action="hook_load";
		evt.permission="w";							
		bpos._executeCommandEvent(evt);		
	},


	//通联退货界面
	//edit by robin 20121213 增加参数 doSameOrgR 是否可以再次退已退过的原单，情况是：客户开始想部分退少数，然后又要求部分退多数，这样原来的方法不能满足，也不能后退了
	TNReturnFace:function(ret,opertation,paywayid,price,doSameOrgR){
		this.doguadanaction(ret,opertation,paywayid,price,doSameOrgR);
	},

	//method:挂单处理操作 doguadanaction
	//param:ret     Server返回参数
	//Edit by Robin 20100809 处理 ‘处理挂单’返回值
	doguadanaction:function(ret,TN,paywayid,price,doSameOrgR){
		//	alert(Object.toJSON(ret));
			var ele = Alerts.fireMessageBox({
				width: TN?500:854,
				modal: true,
				title: gMessageHolder.EDIT_MEASURE
			});
			if(!doSameOrgR)doSameOrgR=false;		
			var strTemp ="";
			var count = ret.length;
			var b=0;
			var sStrp="";
			var salername="";
			var totmt=0.0;
			if(count==0){
				strTemp=strTemp+"<div class=\"desc-txt\"><font color=\"red\"><center>当前店铺没有挂单记录!</center></font></div>";
			}else{
				if(TN){
					strTemp = strTemp+"<div id=\"query-search-content\">"+
						"<div id=\"treatment_td\"><div id=\"treatment_text\">处理"+(TN=="TNCX"?"撤销":"退货")+" ：</div>"+
						"<div class=\"treatmentLL-table\">"+
						"<div class=\"treatmentLL-table-head\">"+
						"<div class=\"treatmentLL-span-1\">序号</div>"+
						"<div style=\"display:none;\"></div>"+
						"<div class=\"treatmentLL-span-2\">原单编号</div>"+
						"<div class=\"treatmentLL-span-5\">单据时间</div>"+
						"<div class=\"treatmentLL-span-1\">金额</div>"+
						"<div class=\"treatmentLL-span-11\">条码明细</div>"+				
						"</div></div><div id=\"treatmentLL-main\" class=\"treatmentLL-sidebar\" style=\"height: 130px; width: 500px; visibility: visible; opacity: 1;\">";
				}else {
				strTemp = strTemp+"<div id=\"query-search-content\">"+
						"<div id=\"treatment_td\"><div id=\"treatment_text\">处理挂单（H）：</div>"+
						"<div class=\"treatmentLL-table\">"+
						"<div class=\"treatmentLL-table-head\">"+
						"<div class=\"treatmentLL-span-1\">序号</div>"+
						"<div style=\"display:none;\"></div>"+
						"<div class=\"treatmentLL-span-2\">单据号</div>"+
						"<div class=\"treatmentLL-span-7\">单据时间</div>"+
						"<div class=\"treatmentLL-span-3\">总数量</div>"+
						"<div class=\"treatmentLL-span-3\">总金额</div>"+
						"<div class=\"treatmentLL-span-4\">VIP卡号</div>"+
						"<div class=\"treatmentLL-span-5\">操作员</div>"+
						"<div class=\"treatmentLL-span-5\">打印标记</div>"+
						"<div class=\"treatmentLL-span-10\">备注</div></div></div>"+
						"<div id=\"treatmentLL-main\" class=\"treatmentLL-sidebar\" style=\"height: 130px; width: 854px; visibility: visible; opacity: 1;\">";
				}
				var k=0;
				for(var a=0;a<count;a++){		
					/*var aArr = new Array();
					var ss=ret[a].BILLDATE+"";
					aArr.push(ss.substring(0,4));
					aArr.push(ss.substring(4,6));
					aArr.push(ss.substring(6,8));*/
					b = a+1;
					if(TN&&(!ret[a].status||doSameOrgR)&&ret[a].payway==paywayid&&(TN!="TNCX"?true:bpos.revOrgOrder(price,ret[a]))){
						b=++k;
						//找到同一个原单的所有条码
						var items=bpos.findByOrgOrder(ret[a].org_orderno,bpos.items_data);
						var prono="";
						for(var p=0;p<items.length;p++) {
							prono+=items[p].productno+" | "
						}
						strTemp = strTemp+"<div class=\"treatmentLL-row\">"+
							"<div id=\"divrowline"+b+"\" class=\"treatmentLL-row-line\">"+
							"<div id=\"divinputrowline"+b+"\" class=\"treatmentLL-span-1\"><input id=\"input"+b+"\" h=\""+count+"\" value=\""+b+"\" name=\"zd\" type=\"radio\" />"+b+"</div>"+
							"<div id=\"id"+b+"\" style=\"display:none;\">"+a+"</div>"+
							"<div id=\"orderno"+b+"\" class=\"treatmentLL-span-2\">"+ret[a].org_orderno+"</div>"+
							"<div id=\"billdate"+b+"\" class=\"treatmentLL-span-5\">"+bpos.string2Date(ret[a].billdate)+"</div>"+
							"<div id=\"payamount"+b+"\" class=\"treatmentLL-span-1\">"+ret[a].payamount+"</div>"+
							"<div class=\"treatmentLL-span-11\">"+prono+"</div>"+
							"</div></div>";
					}else if(!TN) {
					//20101014修改 由于ACTIVEX判断相反 故修改打印状态
					if(ret[a].PRINTED=="N"){
						//sStrp="未打印";
						sStrp="<font color=\"red\">已打印</font>";
					}else{
						//sStrp="<font color=\"red\">已打印</font>";
						sStrp="未打印";
					}
					//end
					//var sDate = aArr.join("-");
					strTemp = strTemp+"<div class=\"treatmentLL-row\">"+
							"<div id=\"divrowline"+b+"\" class=\"treatmentLL-row-line\">"+
							"<div id=\"divinputrowline"+b+"\" class=\"treatmentLL-span-1\"><input id=\"input"+b+"\" j=\""+ret[a].RETAIL_ID+"\" canmodify=\""+ret[a].PRINTED+"\" h=\""+count+"\" value=\""+b+"\" name=\"zd\" type=\"radio\" />"+b+"</div>"+
							"<div style=\"display:none;\">"+ret[a].RETAIL_ID+"</div>"+
							"<div id=\"orderno"+b+"\" class=\"treatmentLL-span-2\">"+ret[a].ORDERNO+"</div>"+
							"<div class=\"treatmentLL-span-7\" id=\"zody_di\">"+ret[a].createtime+"</div>"+
							"<div class=\"treatmentLL-span-3\">"+ret[a].TOTQTY+"</div>"+
							"<div class=\"treatmentLL-span-3\">"+ret[a].TOTAMT+"</div>"+
							"<div class=\"treatmentLL-span-4\">"+((ret[a].vip_cardno==-1||ret[a].vip_cardno==undefined)?"":ret[a].vip_cardno)+"</div>"+
							"<div class=\"treatmentLL-span-5\">"+(ret[a].operatorname==""?"无":ret[a].operatorname)+"</div>"+
							"<div class=\"treatmentLL-span-5\">"+sStrp+"</div>"+
							"<div class=\"treatmentLL-span-11\">"+(ret[a].RECORD==""?"无挂单原因":(ret[a].RECORD+""))+"</div></div></div>";							
					}
				}
				strTemp = strTemp+ "</div></div><div id=\"treatment_td\" align=\"center\"><div id=\"zody_treatment_text\">"+
						"<input type=\"button\" tabindex=1 value=\"处理\" onclick=\""+(TN?"javascript:zody.TNBank('"+TN+"','"+paywayid+"','"+price+"')":"javascript:zody.getGuaDan()")+"\" class=\"qinput\" id=\"zody_btn-search\"/>&nbsp;"+
						(TN?"":"<input type=\"button\" tabindex=2 value=\"作废\" onclick=\"javascript:zody.closeGuaDan()\" class=\"qinput\" id=\"zody_btn-cancel\"/>&nbsp;")+
						"<input type=\"button\" tabindex=3 id=\"zody_reset\" type=\"reset\" class=\"qinput\" value=\"取消\" onclick=\""+(TN?"javascript:zody.cancelTN('"+TN+"','"+paywayid+"','"+price+"')":"javascript:zody.killGuaDan()")+"\" /></div>"+
						"</div></div>";
			}
			ele.innerHTML = strTemp;
			bpos.executeLoadedScript(ele);
			bpos.noAlert=false;
			jQuery(".treatmentLL-row:odd").css("background","#A3BAD4");
			jQuery("#input1").attr("checked",true);
			jQuery("#input1").focus();
			var ipt1;
			var radi;
			jQuery("#query-search-content").bind("keydown",function(event){
				var ins = jQuery("#query-search-content input[type='radio']");
				var aInp = jQuery("#zody_treatment_text input[type='button']");				
				if(event.which==38){
					var index=0;
					if(radi){
						index=ins.index(radi)+1;
					}
					if(!ins[index])index=0;
					radi=ins[index];
					radi.focus();
				}else if(event.which==40){
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
					if(event.target!=$("zody_btn-search")&&event.target!=$("zody_btn-cancel")&&event.target!=$("zody_reset"))
					TN?zody.TNBank(TN,paywayid,price):zody.getGuaDan();
				}
			});		
		/*	jQuery("#treatment-main").bind("keydown",function(event){
				if(event.which==13){
					TN?zody.TNBank(TN):zody.getGuaDan();
				}
			});*/
	},
	
	//通联接口退货操作
	TNBank:function(TN,paywayid,price){
		jQuery("#re,#cancle").attr("disabled",true);
		if(jQuery("input[name='zd']:checked").length==0){
			alert("无可用原单项！");
			return;
		}
		var a2=jQuery("input[name='zd']:checked").attr("value");
		var orderno=jQuery("#orderno"+a2).text();
		var num=-jQuery("#payamount"+a2).text();
		num=parseFloat(num);
		price=parseFloat(price);
		var payway=bpos.checkpayway(paywayid);
		var paytype=jQuery("#payselect").find("option:selected").text();
		bpos.evaluatepayitem(bpos.payitem,bpos.temppayitem);
		
		var num2=price<num?num:price;
		bpos.updatepayitem(payway,num2);
		if((TN=="TNCX"&&bpos.TNChargebacks(-num2,bpos.master_data.refno.substr(0,15)+"0"+bpos.mark).code=='1')||(TN=="TNTH"&&bpos.TNRefund(bpos.date2String(jQuery("#billdate"+a2).text()),-num2,bpos.master_data.refno.substr(0,15)+"0"+bpos.mark).code=='1')) {
			bpos.org_payitems[jQuery("#id"+a2).text()].status=1;
			bpos.handlepaypricewhencheckisok(paytype,num2);
			alert("单据"+orderno+"操作成功！");
			bpos.mark++;
			//jQuery("#divrowline"+a2).remove();
		}else {
			if(bpos.mark==0){
				jQuery("#re,#cancle").removeAttr("disabled");
			}
			//alert("单据"+orderno+"撤销失败！");
			bpos.evaluatepayitem(bpos.temppayitem,bpos.payitem);
			$("discription").value ="";
		}
		Alerts.killAlert($("query-search-content"));
		$("payment_content").focus();
		if($("currpay").disabled!=true)dwr.util.selectRange($("currpay"),0,20);
	},
	
	cancelTN:function(TN,paywayid,price) {
		if(TN=="TNTH") {
			Alerts.killAlert($("query-search-content"));
			$("payment_content").focus();
			if($("currpay").disabled!=true)dwr.util.selectRange($("currpay"),0,20);
			return;
		}
		this.killGuaDan();
		this.TNReturnFace(bpos.org_payitems,"TNTH",paywayid,price);
	},
	
	//method:处理挂单回调函数   _doGuaDan
	//param: e    Server返回参数
	_doGuaDan:function(e){
		var data=e.getUserData();
		var ret=data.jsonResult.evalJSON();
		this.doguadanaction(ret);
	},
	
	//method:取消处理操作 killGuaDan
	//param:
	killGuaDan:function(){
		bpos.killAlert("query-search-content");
	},

	//method:系统时间改为初始化   turnTime
	//param:
	turnTime:function(){
		jQuery("#zody_td").show();
		jQuery("#temp_sys_date").attr("id","sys_date");
		jQuery("#zody_td1").remove();
	},

	//method:将系统时间转为挂单时间  changeTime
	//param: sysdate 挂单时间
	changeTime:function(sysdate){
		jQuery("#zody_td").hide();
		jQuery("#sys_date").attr("id","temp_sys_date");
		var sStr="<td class=\"value\" id=\"zody_td1\" width=\"152\" nowrap=\"nowrap\" align=\"left\" valign='top' >"+
			"<input type=\"text\" id=\"zody_sys\" class=\"q_input01\" value=\""+sysdate+"\" readonly=\"fdsa\" /></td>";
		jQuery("#zody_t1").after(sStr);
		jQuery("#zody_sys").attr("id","sys_date");
	},

	//method:处理操作 getGuaDan
	//param:
	getGuaDan:function(){		
		var a2=jQuery("input[name='zd']:checked").attr("id");	
		var a3=jQuery("#"+a2).val();	
		var orderno=jQuery("#orderno"+a3).text();	
		var j=jQuery("#input"+a3).attr("j");
		var evt = {};
		evt.command = "DBJSON";
		evt.callbackEvent = "BPOS_GETGUADAN";
		var a=0;
		if(j>0){
			a=parseInt(j);
			var param = {"retail_id": a, "action":"do"};
			if(bpos.offline==true&&isIE()){
					var info={};
					info.param=param;				
					var ret=bpos.getposhook(Object.toJSON(info));
					ret=ret.evalJSON();
					bpos.vip=ret.param.bpos_vip;
					var infov={};
			    infov.param=bpos.vip;
					bpos.setvip(Object.toJSON(infov));
				//	alert(Object.toJSON(ret.param.bpos_vip));
					if(ret.param.salerid&&ret.param.salerid!=-1){
						for(var o=0;o<bpos.master_data.salers.length;o++){
							if(ret.param.salerid==bpos.master_data.salers[o].id){
								bpos.master_data.saler=bpos.copyJsonObject(bpos.master_data.salers[o]);
							}
						}
					}
					bpos.master_data.docno=ret.param.docno;
					bpos.master_data.createTime=ret.param.createtime;
					bpos.master_data.canModify=ret.param.canModify;
					if(ret.param.canModify==0){
						bpos.changeModel("NOMODIFY");
					}
					zody.changeTime(ret.param.billdate);
					this.getguadanaction(ret,"offline");
					bpos.updateheaderhtml();
					return;
			}
			evt.param=Object.toJSON(param);
			evt.table="m_retail";
			evt.action="hook_action";
			evt.permission="w";	
			evt.isclob=true;
			//jQuery("#divrowline"+a3).remove();	//remove 处理行
			bpos._executeCommandEvent(evt);			
		}else{
			alert("没有选中任何单据,不能执行该操作!");
			return false;
		}		
    },
     
	//method:getguadanaction
	//param: ret  Server返回参数.  offline    网络判断
	//Edit by Robin20100809挂单明细，复写到页面 
    getguadanaction:function(ret,offline){
		//alert(Object.toJSON(ret));
    	if(offline=="offline"){
    		var items=ret.param;    		
    		//alert(Object.toJSON(items));
			//alert(items.description);
			if(items.description!=""){
				jQuery("#comment").val(items.description+";"+items.record);
			}else{
				jQuery("#comment").val(items.record);
			}
    		for(var i=0;i<items.qty.length;i++){
    			var item={};
    		
				item.productno=items.productno[i];
				item.productname=items.productname[i];
				item.qty=isNaN(parseInt(items.qty[i],10))?0:parseInt(items.qty[i],10);
				item.pricelist=isNaN(parseFloat(items.pricelist[i]))?0.00:parseFloat(items.pricelist[i]);
				item.discount=isNaN(parseFloat(items.discount[i]))?0.00:parseFloat(items.discount[i]);
				item.priceactual=isNaN(parseFloat(items.priceactual[i]))?0.00:parseFloat(items.priceactual[i]);
				item.priceactual=bpos.alg(item.priceactual);
				item.price=isNaN(parseFloat(items.price[i]))?0.00:parseFloat(items.price[i]);
				item.price=bpos.alg(item.price);
				item.saler=items.saler[i];
				
				item.type=items.type[i];
				item.productvalue=items.productvalue[i];
				item.color=items.color[i];
				item.colorname=items.colorname[i];
				item.size=items.size[i];			
				item.sizename=items.sizename[i];
				item.salerid=items.salerid1[i];	
				item.multisalers=((items.multisalers).evalJSON())[i];
				item.mdim11=items.mdim11[i];	
				item.discription=items.description1[i];
				
				item.orgdocno=items.orgdocno[i];
				item.pda_id=items.m_pda_id[i];
				item.markbaltype=items.m_retail_markbaltype_id[i]?items.m_retail_markbaltype_id[i]:-1;
				item.lineno=-1;
				item.locked=items.locked[i];
				item.lowest_discount=items.lowest_discount[i];
				item.sin_disid=items.sin_disid[i];
				item.sin_disname=items.sin_disname[i];
				item.com_disid=items.com_disid[i];
				item.com_disname=items.com_disname[i];
				item.add_disid=items.add_disid[i];
				item.add_disname=items.add_disname[i];
				for(var p=1;p<=20;p++){
					eval("item.m_dim"+p+"=items.m_dim"+p+"["+i+"]?items.m_dim"+p+"["+i+"]:\"\";");
				}
				item.org_payways=((items.m_retail_org_payways).evalJSON())[i];
				item.org_payamounts=((items.m_retail_org_payamounts).evalJSON())[i];
				item.sysdate=items.m_retail_sysdate[i];
				item.org_billdate=items.m_retail_org_billdate[i];
				bpos.updateitems_data2(item);
			}
    	}else{
	    	var le=ret.length;		
				for(var i=0;i<le;i++){
					var item={};
					item.productno=ret[i].NO;
					item.productname=ret[i].VALUE;
					item.qty=isNaN(parseInt(ret[i].QTY,10))?0:parseInt(ret[i].QTY,10);
					item.pricelist=isNaN(parseFloat(ret[i].PRICELIST))?0.00:parseFloat(ret[i].PRICELIST);
					item.discount=isNaN(parseFloat(ret[i].DISCOUNT))?0.00:parseFloat(ret[i].DISCOUNT);
					item.priceactual=isNaN(parseFloat(ret[i].PRICEACTUAL))?0.00:parseFloat(ret[i].PRICEACTUAL);
					item.priceactual=bpos.alg(item.priceactual);
					item.price=isNaN(parseFloat(ret[i].TOT_AMT_ACTUAL))?0.00:parseFloat(ret[i].TOT_AMT_ACTUAL);
					item.price=bpos.alg(item.price);
					item.saler=bpos.master_data.saler.name;
					item.type=ret[i].TYPE;
					item.productvalue=ret[i].NAME;
					item.color=ret[i].VALUE1;
					item.colorname=ret[i].VALUE1_CODE;
					item.size=ret[i].VALUE2;			
					item.sizename=ret[i].VALUE2_CODE;	
					item.salerid=bpos.master_data.saler.id;	
					item.mdim11=ret[i].FORCODE;	
					item.discription=ret[i].DESCRIPTION;
					item.orgdocno=ret[i].ORGDOCNO;
					item.pda_id=ret[i].M_PDA_ID;
					item.multisalers=ret[i].multisalers;
					item.lineno=-1;
					item.locked=ret[i].locked;
					item.lowest_discount=ret[i].lowest_discount;
					bpos.updateitems_data2(item);
				}
				bpos.master_data.docno=orderno;
				bpos.vip=ret.param.bpos_vip;
				var infov={};
			  infov.param=bpos.vip;
				bpos.setvip(Object.toJSON(infov));
				
				bpos.master_data.docno=ret.param.docno;
				zody.changeTime(ret.param.billdate);
				bpos.updateheaderhtml();
			jQuery("#comment").val(ret.DESCRIPTION+";"+ret.RECORD);
			}
			zody.killGuaDan();
			bpos.gethookcount();
    },

	//method:处理挂单回调函数,复写挂单数据   _callGetGuaDan
	//param: e    Server返回参数
	_callGetGuaDan:function(e){
		var data=e.getUserData();
		var ret=data.jsonResult.evalJSON();
		this.getguadanaction(ret);
	},

	//method:作废操作 closeGuaDan
	//param:
	closeGuaDan:function(){	
		var a2=jQuery("input[name='zd']:checked").attr("id");	
		var a3=jQuery("#"+a2).val();	
		//20101014新增已打印的挂单 不可作废 注意 判断条件是ret[a].PRINT==“N”
		var canmodify=jQuery("#input"+a3).attr("canmodify");
		if(canmodify=="N"){
			alert("已打印单据不可作废！");
			return;
		}
		var j=jQuery("#input"+a3).attr("j");
		
		var a=0;
		if(j>0){
			a=parseInt(j);
			if(window.confirm("确认作废此单据？")){		
				var evt = {};		
				evt.command = "DBJSON";
				evt.callbackEvent = "BPOS_CLOSEGUADAN";
				var param = {"retail_id": a, "action":"del"};
				evt.param=Object.toJSON(param);
				if(bpos.offline==true&&isIE()){
					var info={};
					info.param=param;				
					var ret=bpos.getposhook(Object.toJSON(info));
					ret=ret.evalJSON();
					this.closeGuaDanaction(ret);
					return false;
				}
				evt.table="m_retail";
				evt.action="hook_action";
				evt.permission="w";
				evt.isclob=true;				
				bpos._executeCommandEvent(evt);				
			}
		}else{
			alert("没有选中任何单据,不能执行该操作!");
			return false;
		}
	},
	
	//method:挂单作废操作  closeGuaDanaction
	//param: ret  Server返回参数
	closeGuaDanaction:function(ret){
		//alert(Object.toJSON(ret));
		var docno=ret.ORDERNO;
		if(docno!=null){
			alert("作废的单据号为:"+docno);
			var a2=jQuery("input[name='zd']:checked").attr("id");	
			var a3=jQuery("#"+a2).val();	
			jQuery("#divrowline"+a3).remove();	
			bpos.gethookcount();
		}else{
			alert("删除单据失败!");
			return false;
		}
	},

	//method:返回挂单号 _callCloseGuaDan
	//param: e  Server返回参数
	_callCloseGuaDan:function(e){
		var data=e.getUserData();
		var ret=data.jsonResult.evalJSON();
		this.closeGuaDanaction(ret);
	},
	getTotLowestPrice:function(items_data){
		if(!items_data)items_data=bpos.items_data;
		var tot=0;
		for(var i=0;i<items_data.length;i++){
			if(items_data[i].type!=1) tot=tot.add(items_data[i].price);
			else if(items_data[i].lowest_discount>0)tot=tot.add(((items_data[i].pricelist).mul(items_data[i].lowest_discount)).mul(items_data[i].qty));
			
		}
		return bpos.alg(tot);
	},

	//method:总额折扣 amount
	//param:
	amount:function(){
		var totLowest=this.getTotLowestPrice();
		var totz=zody.getTotal();
		var oldtot=totz.add(this.getTotalByType(false,false,1,'price'));
		var discountlimit=bpos.master_data.discountlimit;
		//alert(discountlimit);
		var total = oldtot.sub(totz.mul(1-discountlimit)); 
		if(total<totLowest){
			discountlimit=totLowest.div(totz);
			discountlimit=(Math.round(discountlimit.mul(100))).div(100);
			total=totLowest;
		}
		//alert(discountlimit);
		//var ddd=zody.getTotal().mul(bpos.master_data.discountlimit);
		var yhui=oldtot.sub(total);
		var ele = Alerts.fireMessageBox({
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
				ele.innerHTML = "<div id=\"amount_content\">"+
								"<table width=\"400\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
								"<tr><td>"+
								"<div id=\"treatment_td\">"+
								"<div id=\"treatment_text\">总额折扣（S）：</div>"+
								"</div>"+
								"</td></tr>"+
								"<tr><td>"+
								"<div id=\"treatment_table\">"+
								"<div id=\"amount_botder\">"+
								"<table id=\"categoryTable\" width=\"350\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"+
								"<tr id=\"tr1\"><td width=\"69\" height=\"20\" align=\"right\">"+
								"<div class=\"desc-txt\">"+
								"<input id=\"r1\" onclick=\"zody.r1r()\" name=\"radiobutton\" type=\"radio\" value=\"1\" />"+
								"</div>"+
								"</td>"+
								"<td width=\"63\" align=\"left\">"+
								"<span class=\"desc-txt\">折&nbsp;&nbsp;&nbsp;扣&nbsp;&nbsp;&nbsp;率：</span>"+
								"</td>"+
								"<td width=\"218\">"+
								"<input onclick=\"zody.i1i()\" id=\"in1\" type=\"text\" class=\"q_input\" />"+
								"</td>"+
								"</tr>"+
								"<tr id=\"discz1\"style=\"display:none\"><td height=\"30\" colspan=\"2\" align=\"right\">"+
								"<div class=\"desc-txt\">最低折扣限制：</div>"+
								"</td><td>"+
								"<div class=\"desc-txt\" id=\"discz\">"+discountlimit+"</div>"+
								"</td></tr>"+
								"<tr id=\"tr2\"><td height=\"20\" align=\"right\">"+
								"<span class=\"desc-txt\">"+
								"<input id=\"r2\" onclick=\"zody.r2r()\" name=\"radiobutton\" type=\"radio\" value=\"2\" />"+
								"</span></td>"+
								"<td height=\"20\" align=\"left\"><span class=\"desc-txt\">特&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：</span>"+
								"</td><td>"+
								"<input onclick=\"zody.i2i()\" id=\"in2\" type=\"text\" class=\"q_input\" />"+
								"</td></tr>"+
								"<tr id=\"lowestpricez1\"style=\"display:none\"><td height=\"20\" colspan=\"2\" align=\"right\">"+
								"<div class=\"desc-txt\">最低特价限制：</div>"+
								"</td>"+
								"<td><span class=\"desc-txt\" id=\"lowestpricez\">"+zody.changeTwoDecimal(total)+" 元</span></td>"+
								"</tr>"+
								"<tr id=\"tr3\"><td height=\"20\" align=\"right\">"+
								"<div class=\"desc-txt\">"+
								"<input id=\"r3\" onclick=\"zody.r3r()\" name=\"radiobutton\" type=\"radio\" value=\"3\" />"+
								"</div></td>"+
								"<td height=\"20\" align=\"left\">"+
								"<div class=\"desc-txt\">优&nbsp;惠&nbsp;金&nbsp;额：</div>"+
								"</td><td>"+
								"<span class=\"desc-txt\">"+
								"<input onclick=\"zody.i3i()\" id=\"in3\" type=\"text\" class=\"q_input\" />"+
								"</span></td></tr>"+
								"<tr id=\"discountpricez1\"style=\"display:none\"><td height=\"20\" colspan=\"2\" align=\"right\">"+
								"<div class=\"desc-txt\" >最高优惠金额限制：</div>"+
								"</td>"+
								"<td id=\"discountpricez\">"+zody.changeTwoDecimal(yhui)+" 元</td>"+
								"</tr>"+
								"</table></div></div></td></tr>"+
								"<tr><td>"+
								"<div id=\"treatment_td\" align=\"center\">"+
								"<div id=\"treatment_text\">&nbsp;"+
								"<input type=\"button\" value=\"确定\" onclick=\"javascript:zody.subAmount()\" class=\"qinput\" id=\"zody_btn_submit\"/>&nbsp;"+
								"<input name=\"Submit\" type=\"button\" class=\"qinput\" value=\"取消\" id=\"zody_btn_cancel\" onclick=\"javascript:zody.closeAmount();\" />"+
								"<input name=\"showhidd\" type=\"button\" class=\"qinput\" value=\"显示/隐藏\" id=\"zody_btn_sOh\" onclick=\"javascript:zody.show_Model();\" />"+
								"</div></div></td></tr></table></div>";
				bpos.executeLoadedScript(ele);	
				bpos.noAlert=false;
			
			jQuery("#r1").attr("checked", true);
			var ipt1;
			var radi=$("in1");
			radi.focus();
			if(bpos.master_data.params.showLowestDisprice=="true"){
					jQuery("#discz1,#lowestpricez1,#discountpricez1").show();
					jQuery("#zody_btn_sOh").hide();
			}
			//	bxl.closeEmp();
  		 //alert("asd");
			jQuery("#amount_content").bind("keydown",function(event){
				var ins = jQuery("#in1,#in2,#in3");
				var aInp = jQuery("#amount_content input[type='button']");				
				if(event.which==38){
					var index=ins.length-1;
					if(radi){
						index=ins.index(radi)-1;
					}
					if(!ins[index])index=ins.length-1;
					radi=ins[index];
					radi.focus();
					if(index==0){						
						jQuery("#r1").attr("checked", true);
						jQuery("#in2").val("");
						jQuery("#in3").val("");	
					}else if(index==1){
						jQuery("#r2").attr("checked", true);
						jQuery("#in1").val("");
						jQuery("#in3").val("");	
					}else if(index==2){
						jQuery("#r3").attr("checked", true);
						jQuery("#in2").val("");
						jQuery("#in1").val("");	
					}
				}else if(event.which==40){
					var index=0;
					if(radi){
						index=ins.index(radi)+1;
					}
					if(!ins[index])index=0;
					radi=ins[index];
					radi.focus();
					if(index==0){						
						jQuery("#r1").attr("checked", true);
						jQuery("#in2").val("");
						jQuery("#in3").val("");	
					}else if(index==1){
						jQuery("#r2").attr("checked", true);
						jQuery("#in1").val("");
						jQuery("#in3").val("");	
					}else if(index==2){
						jQuery("#r3").attr("checked", true);
						jQuery("#in2").val("");
						jQuery("#in1").val("");	
					}
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
					if(event.target!=$("zody_btn_submit")&&event.target!=$("zody_btn_cancel")&&event.target!=$("zody_btn_sOh"))
					zody.subAmount();
				}else if(event.ctrlKey==true&&event.which==39){
					if(!bpos.master_data.params.showLowestDisprice=="true"){
						bpos.show_Model();
					}
				}
			});
			
	},
	show_Model:function(){
		jQuery("#discz1").toggle();
		jQuery("#lowestpricez1").toggle();
		jQuery("#discountpricez1").toggle();
	},
	discount:function(){
		if((bpos.MODEL&bpos.DISTOTAMOUNT)!=bpos.DISTOTAMOUNT){
			alert("该单不可总额折扣！");
			return;
		}
		if(jQuery("#from-main >div").text()==""){			
			alert("没有选择任何单据不能进行该操作!");
			return false;
		}
	if(bpos.master_data.params.verifyPermission=="true"){
		bxl.validateEmployee("discount");
		return;
		}else{
			this.amount();
			}
		},
	getTotalByType:function(items_data,type,notype,column){
		if(!column)column='pricelist';
		var total=0.0;
		if(!items_data)items_data=bpos.items_data;
		for(var i=0;i<items_data.length;i++){	
			if(type&&items_data[i].type==type){
				switch(column){
					case 'pricelist':total= total.add(items_data[i].pricelist.mul(items_data[i].qty));break;
					case 'price':total=total.add(items_data[i].price);break;
				}
			}else if(notype&&items_data[i].type!=notype){
				switch(column){
					case 'pricelist':total= total.add(items_data[i].pricelist.mul(items_data[i].qty));break;
					case 'price':total=total.add(items_data[i].price);break;
				}
			}
		}
		return total;
	},
	//method:得到type为1的总金额     getTotal
	//param:
	//return: total type为1的总金额
	getTotal:function(items_data){
		return this.getTotalByType(items_data,1);
	},
	//复制 items_data
	copyitems_data:function(items_data){
		var tempitems_data=new Array();
		for(var v=0;v<items_data.length;v++){
			var temp={};
			temp.productno=items_data[v].productno;
			temp.productname=items_data[v].productname;
			temp.colorname=items_data[v].colorname;
			temp.sizename=items_data[v].sizename;
			temp.color=items_data[v].color;
			temp.size=items_data[v].size;
			temp.mdim11=items_data[v].mdim11;
			temp.productvalue=items_data[v].productvalue;
			temp.pricelist=items_data[v].pricelist;
			temp.discount=items_data[v].discount;
			temp.discription=items_data[v].discription;
			temp.priceactual=items_data[v].priceactual;
			temp.qty=items_data[v].qty;
			temp.price=items_data[v].price;
			temp.salerid=items_data[v].salerid;
			temp.saler=items_data[v].saler;
			temp.type=items_data[v].type;
			temp.orgdocno=items_data[v].orgdocno;
			temp.pda_id=items_data[v].pda_id;
			temp.lineno=items_data[v].lineno;
			temp.locked=items_data[v].locked;
			temp.lowest_discount=items_data[v].lowest_discount;
			tempitems_data.push(temp);
		}
		return tempitems_data;
	},
	//method:总额折扣的确定操作 subAmount
	//param:
	subAmount:function(){	
		var ii=jQuery("input[name='radiobutton']:checked").val();
		var ii1=parseInt(ii);
		var tatal_Z=parseFloat(jQuery("#tot_amt").text());
		var billdate = parseInt(jQuery("#sys_date").val());
		var discount;
		var newtotprice;
		var oldtot=bpos.gettotdata(bpos.items_data);
		switch(ii1){
			case 1:
				var i1=jQuery.trim(jQuery("#in1").val());
				var i2i=parseFloat(i1);
				var discountlimit=parseFloat(jQuery("#discz").html());
				if(i1==""||isNaN(i1)||i2i<discountlimit){
					alert("折扣不合法!");
					jQuery("#in1").val("");
					return false;
				}
				if(i2i>1.0&&!bpos.discountCanLgOne){
					alert("折扣不得大于1");
					jQuery("#in1").val("");
					return false;
				}
				discount=bpos.discountalg(i2i);
				break;
			case 2:
				var i2=parseFloat(jQuery.trim(jQuery("#in2").val()));
				//var tt=parseFloat(jQuery.trim(jQuery("#lowestpricez").html().replace("元","")));
				var tt;
				if(jQuery.trim(jQuery("#lowestpricez").html())){
					tt=parseFloat(jQuery.trim(jQuery("#lowestpricez").html().replace("元","")));
				}else{
					tt=0;	
				}
				if(i2==""||isNaN(i2)||i2<tt){
					alert("特价不合法!");
					jQuery("#in2").val("");
					return false;
				}
				if(i2>oldtot&&!bpos.discountCanLgOne){
					alert("总额折扣不可大于1");
					jQuery("#in2").val("");
					return false;
				}
				newtotprice=bpos.alg(i2);	
				break;			
			case 3:
				var i3=parseFloat(jQuery.trim(jQuery("#in3").val()));
				if(i3==""){
					alert("最高优惠金额不能为空!");
					return false;
				}
				if(isNaN(i3)){
					alert("最高优惠金额必须为数字!");
					jQuery("#in3").val("");
					return false;
				}
			
				var yhuie=parseFloat(jQuery.trim(jQuery("#discountpricez").html().replace("元","")));
				if(i3>yhuie){
					alert("优惠金额过大！");
					jQuery("#in3").val("");
					return false;
				}
				newtotprice=oldtot.totpricelist.sub(bpos.alg(i3));
				break;
		}
		if(!(!discount&&!newtotprice&&discount!=0&&newtotprice!=0)){
			/**
			 *原方法中需要和数据库交互一次来确认折扣是否合理
			 *现在由于ACTIVEX计算时报错故放弃此操作，由页面判断
			 *同时也除掉了在线状态下 和服务器 确认的操作
			 *将来可能会用到 服务器验证和 ACTIVEX验证 
			 *Edit by Robin 20101022
			 */
			if(!discount&&discount!=0){
				discount=Math.floor(newtotprice.div(oldtot.totpricelist).mul(100)).div(100);
			}
			if(!newtotprice&&newtotprice!=0){
				newtotprice=bpos.alg(oldtot.totpricelist.mul(discount));
			}
			//bpos.copyJsonObject(this.tempitems_data,bpos.items_data);
			this.tempitems_data=this.copyitems_data(bpos.items_data);
			//copyJsonObject
			if(bpos.handlewholediscount(this.tempitems_data,discount,newtotprice,oldtot.totprice)){
				for(var j=0;j<this.tempitems_data.length;j++){
					var type=bpos.value2type(this.tempitems_data[j].type);
					if(type!="退货")
					bpos.modifyitem(this.tempitems_data[j],j);
				}
				zody.closeAmount();
			}
		}
		
	},
	
	//method:总额折扣框焦点控制 r1r
	//param:
	r1r:function(){
		jQuery("#in1").focus();
		jQuery("#in2").val("");
		jQuery("#in3").val("");
	},
	
	//method:总额折扣框焦点控制 r2r
	//param:
	r2r:function(){
		jQuery("#in2").focus();
		jQuery("#in1").val("");
		jQuery("#in3").val("");
	},
	
	//method:总额折扣框焦点控制 r3r
	//param:
	r3r:function(){
		jQuery("#in3").focus();
		jQuery("#in1").val("");
		jQuery("#in2").val("");
	},
	
	//method:总额折扣框焦点控制 i1i
	//param:
	i1i:function(){		
		jQuery("#r1").attr("checked", true);
		jQuery("#in2").val("");
		jQuery("#in3").val("");		
	},
	
	//method:总额折扣框焦点控制 i2i
	//param:
	i2i:function(){		
		jQuery("#r2").attr("checked", true);
		jQuery("#in1").val("");
		jQuery("#in3").val("");	
	},
	
	//method:总额折扣框焦点控制 i3i
	//param:
	i3i:function(){		
		jQuery("#r3").attr("checked", true);
		jQuery("#in1").val("");
		jQuery("#in2").val("");	
	},

	//method:取消总额折扣操作 closeAmount
	//param:
	closeAmount:function(){
		bpos.killAlert("amount_content");
	},

	//method:检查总额折扣操作次数 checkAmonut
	//param:
	checkAmonut:function(){
		if(jQuery("#treatment_td").attr("done")=="done"){
			alert("你已经做过总额折扣了！");
			return false;
		}
	},
	
	//method:初始化总额折扣操作次数 resetAmonut
	//param:
	resetAmonut:function(){
		jQuery("#treatment_td").removeAttr("done");
	},

	//method:取小数点后面两位小数 changeTwoDecimal
	//param: x    float类型
	//return:f_x   四舍五入的float数
	changeTwoDecimal:function(x){
		var f_x = parseFloat(x);
		if (isNaN(f_x)){
			alert("参数异常!");
			return false;
		}
		var f_x = Math.round(x*100)/100;
		return f_x;
	},
	
	//method:舍去小数点后面两位小数 非四舍五入   changeDecimal 
	//param: x   float类型
	//return:f_x  非四舍五入的float数
	changeDecimal:function(x){
		var f_x = parseFloat(x);
		if (isNaN(f_x)){
			alert("参数异常!");
			return false;
		}
		var f_x = Math.round(x*100)/100;
		return f_x;
	},

	//method:补录VIP   buLuVIP 
	//param: novip不为空则弹出补录VIP,反之return false
	//return:
	buLuVIP:function(){
			var ele = Alerts.fireMessageBox({
				width: 300,
				modal: true,
				title: gMessageHolder.EDIT_MEASURE
			});
			var strTemp ="";
			strTemp=strTemp+"<div id=\"xiao_content_88\" class=\"xiao_content\">"+
						"<table width=\"300\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
						  "<tr>"+
							"<td><div class=\"xiao_td\">"+
							  "<div class=\"vip-text\">补录VIP</div>"+
							"</div></td>"+
						  "</tr>"+
						  "<tr>"+
							"<td><div class=\"xiao_td\">"+
							  "<div id=\"treatment_text\">请输入VIP卡号：</div>"+
							"</div></td>"+
						  "</tr>"+
						  "<tr>"+
							"<td><div class=\"xiao_botder\">"+
							"<input name=\"vip_input\" id=\"zody_vip_input\"  type=\"text\" class=\"VIP_input\" />"+
							"</div>"+
							"</td>"+
						  "</tr>"+
						  "<tr>"+
							"<td><div class=\"VIP-td\" align=\"center\">&nbsp;"+
						"<input type=\"button\" value=\"确定\" onclick=\"bpos.checkaddvip()\" class=\"qinput\" id=\"zody_btn-search\"/>"+
						"&nbsp;"+
						"<input name=\"Submit\" onclick=\"zody.killBuLuVIP()\" type=\"button\" class=\"qinput\" id=\"zody_btn-cancel\" value=\"取消\" />"+
							"</div></td>"+
						  "</tr>"+
						"</table>"+
						"</div>";
			ele.innerHTML = strTemp;
			bpos.executeLoadedScript(ele);
			bpos.noAlert=false;
			jQuery("#zody_vip_input").focus();
	},

	//method:关闭补录VIP窗口   killBuLuVIP 
	//param: 
	//return:
	killBuLuVIP:function(){
		bpos.killAlert("xiao_content_88");
		bpos.readypay();
	},

	//method:执行补录VIP确定操作   doBuLuVIP 
	//param: 
	//return:
	doBuLuVIP:function(){
		if(jQuery("#zody_vip_input").val()!=""){
			this.discountType();
		}else{
			alert("VIP卡号不能为空!");
			return false;
		}
		//this.killBuLuVIP();
	},

	//method:折扣方式   discountType 
	//param: 
	//return:
	discountType:function(){
		var ele = Alerts.fireMessageBox({
			width: 300,
			modal: true,
			title: gMessageHolder.EDIT_MEASURE
		});
		var strTemp ="";
		strTemp=strTemp+"<div id=\"zody_xo\" class=\"xiao_content\">"+
						"<table width=\"300\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
						  "<tr>"+
							"<td><div class=\"xiao_td\">"+
							  "<div id=\"treatment_text\">请选择折扣方式：</div>"+
							"</div></td>"+
						  "</tr>"+
						  "<tr>"+
							"<td><div class=\"xiao_botder\">"+
							"<ul>"+
							"<li>"+
							"<div class=\"xiaoLeft\"><input id=\"input90\" name=\"zd\" type=\"radio\"/>"+
							"</div>"+
							"<div class=\"xiaoRight\">折上折：<span class=\"vip-text-red\" id=\"zody-rediscount\"></span></div>"+
							"</li>"+
							"<li>"+
							"<div class=\"xiaoLeft\"><input name=\"zd\" id=\"input99\" type=\"radio\" /></div>"+
							"<div class=\"xiaoRight\">折&nbsp;&nbsp;&nbsp;扣：<span class=\"vip-text-red\" id=\"zody-discount\"></span></div>"+
							"</li>"+
							"</ul>"+
							"</div>"+
							"</td>"+
						  "</tr>"+
						  "<tr>"+
							"<td><div  class=\"VIP-td\" align=\"center\">&nbsp;"+
						"<input type=\"button\" value=\"确定\" onclick=\"javascript:bpos.dealpaypriceforselectvipdiscount()\" class=\"qinput\" id=\"zody_btn-search_0\"/>"+
						"&nbsp;"+
						"<input name=\"Submit\" type=\"button\" id=\"zody_btn-cancel_0\" onclick=\"javascript:zody.killDiscountType()\" class=\"qinput\" value=\"取消\" />"+
							"</div></td>"+
						  "</tr>"+
						"</table>"+
						"</div>";
		ele.innerHTML = strTemp;
		bpos.executeLoadedScript(ele);
		bpos.noAlert=false;
		jQuery("#input90").attr("checked",true);
		jQuery("#input90").focus();

	},

	//method:关闭折扣方式窗口   killDiscountType 
	//param: 
	//return:
	killDiscountType:function(){
		bpos.killAlert("zody_xo");
		this.killBuLuVIP();
	}
};
ZODY.main = function () {
	zody=new ZODY();
};

/**
* Init
*/
if (window.addEventListener) {
  window.addEventListener("load", ZODY.main, false);
}
else if (window.attachEvent) {
  window.attachEvent("onload", ZODY.main);
}
else {
  window.onload = ZODY.main;
} 