var bxl=null;
var BXL=Class.create();
//document.write("<scri"+"pt src='bpos.js'></scr"+"ipt>"); 
BXL.prototype={
     initialize: function() {
	   dwr.util.useLoadingMessage(gMessageHolder.LOADING);
	   dwr.util.setEscapeHtml(false);
	    /** A function to call if something fails. */
	   dwr.engine._errorHandler =  function(message, ex) {
	  	while(ex!=null && ex.cause!=null) ex=ex.cause;
	  	if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + ", " + ex.message+","+ ex.cause.message, true);
		 if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
	  	else if (message.indexOf("0x80040111")!= -1) dwr.engine._debug(message);
	  	else alert(message);
	   };
		application.addEventListener("BPOS_SEARCH",this._onsearch,this);
		application.addEventListener("U_Note_Read",this._noteread,this);
		application.addEventListener("BPOS_PWD",this._onpwd,this);
		this.lisense();
		this.init();
		this.checkServerTime();
	},
	init:function(){
				this.mutilines=new Array();//批量录入		  
				this.items=new Array(); 
				this.employee="";
				this.pwd="";//当前营业员的pwd
				this.id="";//当前营业员的id
				this.name="";
				this.t="";
				this.type=1;//当前状态
				this.button="";//当前的焦点
				this.docdata="";
				this.d="";
				this.date="";//查询返回的json
 },
 //校验本地时间与服务器时间是否一致
 checkServerTime:function(){
 	  window.setInterval(function(){bxl.getServerTime();}, 900000);
 	},
 	getServerTime:function(){
 		var timeverify="F|D|1";
 		try{
 			timeverify=bpos.master_data.params.timeVerify;
 	 	}catch(e){
 	 	}
 	  var verify=timeverify.split('|');
 	  var verifytype=verify[0];
 	  var timetype=verify[1];
 	  var timevalue=verify[2];
 		jQuery.ajax({
				type:"POST",
				cache:false,
				url:bpos.URL+"getServerTime.jsp",
				timeout:10000,
				error:function(){
					//alert('查询服务器时间失败！');
				},
				success:function(data){
			 	 var d1=new Date(data);
			   var d2=new Date();
			   var diff = d2.getTime() - d1.getTime();
			   if(diff<0){diff=0-diff;}
				 if(jQuery("#timeAlert").length>0){
				 	if(diff<2000*60)bpos.killAlert('timeAlert');
				 	return;
				 }
				 	if(timetype=='D'){
				     var day=Math.round(diff/(1000*3600*24));
				     if(verifytype=='P'){
				     	 (day>parseInt(timevalue,10))?jQuery("#dateIsNotCorrect").css("display","block"):jQuery("#dateIsNotCorrect").css("display","none");
				     	}else{
				     		jQuery("#dateIsNotCorrect").css("display","none");
				     		if(bpos.noAlert&&day>parseInt(timevalue,10)){
				     	    	bxl.timeAlert();
				        	}
				        	if(day<=parseInt(timevalue,10)){
				        		try{
				        				bpos.killAlert('timeAlert');
				        	   }catch(e){}
				        		} 
				     		}
				     
				 		}
				 		else if(timetype=='H'){
				     var hours=Math.round(diff/(1000*3600));
				     if(verifytype=='P'){
				     	 hours>parseInt(timevalue,10)?jQuery("#dateIsNotCorrect").css("display","block"):jQuery("#dateIsNotCorrect").css("display","none");
				     	}else{
				     		jQuery("#dateIsNotCorrect").css("display","none");
				     			if(bpos.noAlert&&hours>parseInt(timevalue,10)){
				     	    	 bxl.timeAlert();
				        	}
				        	if(hours<=parseInt(timevalue,10)){
				        		try{
				        		bpos.killAlert('timeAlert');
				        	   }catch(e){}
				        		} 
				     		}
				     
				 		}
				 	else	if(timetype=='M'){
				     var mins=Math.round(diff/(1000*60));
				     if(verifytype=='P'){
				     	mins>parseInt(timevalue,10)?jQuery("#dateIsNotCorrect").css("display","block"):jQuery("#dateIsNotCorrect").css("display","none");
				     	}else{
				     		jQuery("#dateIsNotCorrect").css("display","none");
				     			if(bpos.noAlert&&mins>parseInt(timevalue,10)){
				     	     	bxl.timeAlert();
				        	}
				        	if(mins<=parseInt(timevalue,10)){
				        		try{
				        		bpos.killAlert('timeAlert');
				        	   }catch(e){}
				        		} 
				     		}
				     
				 		}
				 	
				
				 
				}
		}); 
 		},
//本地时间与服务器时间不等蒙层
	timeAlert:function(){
		
		var ele = Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
			var str="<div id=\"timeAlert\" style=\"height:50px;padding-top:20px;padding-left:20px;\"><font style=\"font-size:20px;color:red;padding-top:50px;\" >本地时间与服务器时间不一致，请修改！</font></div>";
			ele.innerHTML=str;
			bpos.executeLoadedScript(ele);
			bpos.noAlert=false;
	}, 
 //跑马灯通知
 	newsQuery:function(){
 	// jQuery("#dialog").dialog("destroy");
    mc.load(false);

 	/*	var lastId=10;
 		
		new Ajax.Request("/servlets/binserv/Messages", {
			
		  method: 'get',
		  onSuccess: function(transport) {
		  
		    	var newmsgs=transport.responseText.evalJSON();
		   // 	alert(Object.toJSON(newmsgs));
		  		if(newmsgs==null || newmsgs.length==0) {
		  			jQuery("#posNews").html("无最新系统消息！");
		  			return;
		  			}
		  		var msgs='';
		  		for(idx=0;idx<newmsgs.length;idx++){
		  			obj= newmsgs[idx];	
		      	var showMessLength=obj.msg.indexOf("<p")!=-1?obj.msg.indexOf("<p"):(obj.msg.indexOf("<h")!=-1?obj.msg.indexOf("<h"):obj.msg.indexOf("<div"));
							msgs+="	 <a href='#' onclick='javascript:bxl.dlgo2("+obj.noteid+")'>"+obj.msg.substring(0,showMessLength)+"</a>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  ";	      
		  			}
		  		jQuery("#posNews").html(msgs);     
		   
		  },  		
		  onFailure:function(transport){
		     
		     	jQuery("#posNews").html("无最新系统消息！");
		       
		  
		   }
		});*/
	/*jQuery.ajax({
    		type: "POST",
    	  url:"queryNews.jsp",
    	 success:function(myresult){
    	      	jQuery("#posNews").html(myresult);
     	}
    	});*/
		
	},
	//系统消息cmdmsg赋值
	dlgo4:function(tempobj){
		
		 jQuery("#dialog").parent().css("z-index","90");
	   if(mc.modal)jQuery("#dialog").parent().prev(".ui-widget-overlay ").css("z-index","1");
		
		 jQuery("#cmdmsguname").html(tempobj.tempuname+":");
		 jQuery("#cmdmsgtime").html(tempobj.tempcretime.substr(0,tempobj.tempcretime.length-2));
		 jQuery("#cmdmsgcontent").html(tempobj.temptitle+"<p>"+tempobj.tempdescription+"</p>");
		  jQuery("#cmdhref").html("<a href=\"#\"  onclick=javascript:bxl.dlgo3("+tempobj.tempid+") >查看通知明细</a>");
		// jQuery("#cmdhref").attr("onclick","javascript:bxl.dlgo3('"+tempobj.tempid+"')");
		 jQuery("#cmdbtns").html("<input type=\"button\" onClick=\"javascript:bxl.makesurereadmsg('"+tempobj.tempid+"')\"  value=\"&nbsp;&nbsp;确认已读&nbsp;&nbsp;\">");
		 jQuery("#cmdmsg").css("display","block");
		// jQuery("#cmdread").bind("onClick","javascript:bxl.makesurereadmsg('"+tempobj.tempid+"')");
		},
	makesurereadmsg:function(msgid){
		if(msgid!=null && !isNaN(msgid)){
			/*var evt={};
			evt.command="U_Note_Read";
			evt["nds.control.ejb.UserTransaction"]="Y";
			evt.callbackEvent="U_Note_Read";
			evt.noteid=msgid;
			bxl.executeCommandEvent(evt);*/
			
			 var evt={};
        evt.command="DBJSON";
        evt.callbackEvent="U_Note_Read";
        var param={"unoteid":parseInt(msgid,10)};
        evt.param=Object.toJSON(param);
        evt.table="U_NOTE";
        evt.action="CONFIRMREAD";
        evt.permission="W";
        this._executeCommandEvent(evt);
		
		}
		},
	_noteread:function(e){
			mc.refresh();
			jQuery("#cmdmsg").css("display","none");
				},
	executeCommandEvent :function (evt) {
		this._lastAccessTime= (new Date()).getTime();
		//showProgressWindow(true);
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

	dlgo3:function(targetId,Option){
		 bxl.showObject2("/html/nds/object/object.jsp?table=U_NOTE&&fixedcolumns=&id="+targetId,956,570,Option);
		},
	dlgo2:function(objId){
		bxl.showObject2("/html/nds/object/object.jsp?table=U_NOTE"+"&id="+objId);
		},
 showObject2:function (url, theWidth, theHeight,option){
	if( theWidth==undefined) theWidth=956;
    if( theHeight==undefined) theHeight=570;
    if(theWidth==-1){
    	//full screen
    	theWidth=screen.availWidth;
    	theHeight=screen.availHeight;
    }
	var options=$H({width:theWidth,height:theHeight,title:"", modal:true,centerMode:"x",noCenter:true,maxButton:true,style:"z-index:9999"});
	if(options!=undefined) options.merge(option);
	if(options.iswindow==true){
		popup_window(url,options.target, options.width,options.height);
		jQuery("#MainApp").hide();	
	}else{
		Alerts.popupIframe(url,options);
		Alerts.resizeIframe(options);
		Alerts.center();
		jQuery("#MainApp").hide();
	}
  bxl.closeDialog();
 //document.body.appendChild(iframe);
},
closeDialog:function(){
	if(!jQuery("#alert-message"))return;
  if(jQuery("#alert-message").attr("id")==undefined){
  	bpos.noAlert=true;
  	jQuery("#MainApp").show();
  	clearInterval(closeDialog);
  	//this.lisense();
  	}
	
	 var closeDialog= setTimeout("bxl.closeDialog()", 1000);
	},

	stopDefault:function ( e ) { 
		if(document.all){
			window.event.keyCode=0;
			window.event.cancelBubble = true;
		}
 }, 
	lisense:function(){
		jQuery(document).bind("keydown",function(event){
			if(!bpos.noAlert)return;
			if(event.which==112){
				bxl.stopDefault();
				return false;
				}
			//按F2开新单 
			if(event.which==113){		
			  bpos._editvip("f2newretail");
			  bxl.stopDefault();
				return false;
				
				}
				//F3营业员
				if(event.which==114){
				//	alert(Object.toJSON(bpos.master_data.salers));
				    if(bpos.checkButtonShowPer("SALER"))bxl.sales();
						bxl.stopDefault();
						return false;
					}
				     //F4挂单 处理挂单
					 if(event.which==115){
						 if(bpos.checkButtonShowPer("PENDING"))zody.guaDanOrChuli();
						 bxl.stopDefault();	
						 return false;
					}
					//F5付款
					if(event.which==116){
						   	bpos.payprice();
							  bxl.stopDefault();
							  return false;
						}
						//F6 更改状态
						   if(event.which==117){
						   	if(bpos.checkButtonShowPer("CHANGESTATE"))bpos.changeretailtype();
						   	bxl.stopDefault();
						   	return false;
						   	}
					   //F7改数量
					        if(event.which==118){
					        	if(bpos.checkButtonShowPer("CHANGENUM"))bpos.changnumber();
					        	bxl.stopDefault();
						        return false;
					  	}
				
							//F8改金额
							   if(event.which==119){
						   //  	bxl.isValidate("price");
								    if(bpos.checkButtonShowPer("CHANGEAMT"))bpos.changprice();
								   	bxl.stopDefault();
								    return false;
							    }
							    //F9 总额折扣
							   if(event.which==120){
							   	//	bxl.isValidate("discount");
								    if(bpos.checkButtonShowPer("CHANGETOTAMT"))zody.discount();
								    bxl.stopDefault();
								    return false;
							    }
							    //F10 备注
							    if(event.which==121){
								    zody.ope(); 
								    bxl.stopDefault();
								    return false;
							    }
							   //F11 批量录入
						    if(event.which==122){
						    	if(bpos.checkButtonShowPer("BATCH"))bxl.insertnum();
						    	bxl.stopDefault();
						    	return false;
						    	}
						    	//F12
						    if(event.which==123){
						    		bxl.stopDefault();
						    	 return false;
						    }
						    //ctrl+u上传
						    	if(event.ctrlKey==true&&event.which==85){
						    		if(bpos.checkButtonShowPer("UPLOAD"))bpos.uploadOrder();	
						    		bxl.stopDefault();
						    		return false;
						    	}	
						    	//ctrl+f查询
						    	if(event.ctrlKey==true&&event.which==70){
						    		if(bpos.checkButtonShowPer("SEARCH"))bxl.searchdocNo();
						    		bxl.stopDefault();
						    		return false;	
						    	}
						    	//ctrl+p录入VIP
						    	if(event.ctrlKey==true&&event.which==80){
						    		if(bpos.master_data.params.showVIPAlertOnNewOrder=="false")
						    			bpos.showvip();	
						    		bxl.stopDefault();
						    		return false;	
						    	}
	    
			});
		},
		//fukuan
	pay:function(){
		if(jQuery("#VIP").is(":visible")){
			jQuery("#VIP").hide();
			jQuery("#qtab1").show();
			jQuery("#query-search-tab .ui-tabs-nav li").toggleClass("ui-tabs-selected");
			dwr.util.selectRange($("currpay"),0,25);
		}
	},
	vip:function(){
		if(jQuery("#qtab1").is(":visible")){
			 jQuery("#qtab1").hide();
			 jQuery("#VIP").show();	
			 jQuery("#query-search-tab .ui-tabs-nav li").toggleClass("ui-tabs-selected");	
			 dwr.util.selectRange($("vip_currpay"),0,25);
		}	
 },
		 //批量录入：查询   
 searchnum:function(){
 	var evt={};
 	evt.command="DBJSON";
 	evt.callbackEvent="BPOS_SEARCH";
 	var styles=jQuery.trim($("styles").value);
 	var colors=jQuery.trim($("color").value);
 	var size=jQuery.trim($("size").value);
 	var param={"m_pdt":styles,"m_col":colors,"m_size":size};
	//Edit by Robin 20100807 
	if(bpos.offline==true&&isIE()){
		var info={};
		info.param=param;
	//alert(Object.toJSON(info));
	
		var ret=bpos.getskus(Object.toJSON(info));
		ret=ret.evalJSON();
		ret=ret.NewDataSet.Table;
		
		if(ret==null){
			alert("没有您要查询的内容");
			return;
		}
		this.searchaction(ret);
		return;
	}
	//end
	
	evt.param=Object.toJSON(param);
	//alert(evt.param);
	evt.table="m_retail";
	evt.action="bulk_insert";
	evt.permission="w";
	evt.isclob=true;
	this._executeCommandEvent(evt);	
 	}, 
	_appSecret:function(pstr){
		return hex_md5(pstr);
	},
 	//获取服务器时间
 	gettime:function(){
 		jQuery.post("time.jsp",function(date){
 			bxl.t=jQuery.trim(date);
 		//	alert(bxl.t);			
 		  bxl.getpassword();
 		});
 		},
 	
 	getpassword:function(){
 	var evt={};
 	evt.command="DBJSON";
 	evt.callbackEvent="BPOS_PWD";
 	var ename=this.employee;
	var edata=this.t+".111";		
 	var pwd=jQuery("#empwd").val();
  var sip_sign=hex_md5(ename+edata+this._appSecret(pwd));
 	var param={"user_name":ename,"pwd":sip_sign,"c_store_id":bpos.master_data.c_store_id};
  evt.param=Object.toJSON(param);
	evt.table="m_retail";
  evt.action="check_pwd";
	evt.permission="w";
	bpos._executeCommandEvent(evt);	
 },
 		//验证密码是否正确
 _onpwd:function(e){
 		var data=e.getUserData(); // data
		var ret=data.jsonResult.evalJSON();
		if(ret.rest=="ok"){
			bxl.getEm(); 	
	 		bxl.closeEmp();
		}else{
			document.getElementById("empwd").value="";
			document.getElementById("empwd").focus();			
			alert("密码错误，请重新输入");
		}
 	},
 	_executeCommandEvent :function (evt){
		Controller.handle( Object.toJSON(evt), function(r){
	
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

	getIndexByValue:function(vals,val) {
		for(var i=0;i<vals.length;i++) {
			if(vals[i]==val) {
				return i;
			}
		}
		return -1;
	},
	matrixStyle:function(ret,color,size,single) {
		var sy=bxl.searchByPropety(ret,["NAME"])[0]["NAME"];
		var str="",syret,sret;
		for(var i=0;i<sy.length;i++) {
			str+="<option value='"+sy[i]+"'>"+sy[i]+"</option>";
		}
		var rets=bxl.splictRetByPropety(ret,"NAME",sy);
		bxl.sortSizeGroup(rets[sy[0]],color,size,single,sy[0]);
		
		jQuery("#color-size-show").html(sy[0]);	
		jQuery("#styleM").html(str).bind("change",function() {
			syret=jQuery("#styleM").find("option:selected").text();
			bxl.sortSizeGroup(rets[syret],color,size,single,syret);
			//bxl.matrixSearchaction(rets[syret],color,size,single);	
			jQuery("#color-size-show").html(jQuery("#styleM option:selected").text());
		});
	},
	//根据propety拆分ret,propety拆分属性，p_value是属性的值(数组)
	splictRetByPropety:function(ret,propety,p_value) {
		var rets={};
		var rett=bpos.change2array(ret);
		for(var i=0;i<p_value.length;i++) {
			var s_ret=[];
			for(var j=0;j<rett.length;j++) {
				if(p_value[i]==rett[j][propety]) {
					s_ret.push(rett[j]);
				}
			}
			rets[p_value[i]]=s_ret;
		}
		return rets;
	},
	//根据NAME找到所有的ret
	searchretByName:function(ret,name) {
		var sret=[];
		var rett=bpos.change2array(ret);
		for(var i=0;i<rett.length;i++) {
			if(rett[i].NAME==name) {
				sret.push(rett[i]);
			}
		}
		return sret;
	},
	browserType:function(){
		if (navigator.userAgent.indexOf("Android") > -1) {
        return 'AD';
    } else if (navigator.userAgent.indexOf("MSIE") > 0) {
        return 'IE';
    } else if (navigator.userAgent.indexOf("Firefox") > 0) {
        return 'FF';
    } else if (navigator.userAgent.indexOf("Safari") > 0 && navigator.userAgent.indexOf("Chrome") < 0) {
        return 'SF';
    } else if (navigator.userAgent.indexOf("Chrome") > -1) {
        return 'CR';
    }
	},
	matrixSearchaction:function(ret,color,size,single,qc,qtycan) {
		this.single=single;
		this.mutilines=new Array();
		//默认是MSIZE,COL
		var cols=bxl.searchByPropety(ret,["MSIZE","SIZE_CODE"]);
		var rows=bxl.searchByPropety(ret,["COL","COL_CODE"]);
		var col,row,colt,rowt,colTitle,rowTitle;
		var isC=false;
		var isR=false;
		switch(color) {
			case "NAME":rowt=rows[0]["COL"];rowTitle="COL";break;
			case "VALUE":rowt=rows[1]["COL_CODE"];rowTitle="COL_CODE";break;
			case "VALUENAME":rowt=rows[0]["COL"];isR=true;rowTitle="COL";break;
			default:rowt=rows[0]["COL"];rowTitle="COL";
		}
		switch(size) {
			case "NAME":colt=cols[0]["MSIZE"];colTitle="MSIZE";break;
			case "VALUE":colt=cols[1]["SIZE_CODE"];colTitle="SIZE_CODE";break;
			case "VALUENAME":colt=cols[0]["MSIZE"];isC=true;colTitle="MSIZE";break;
			default:colt=cols[0]["MSIZE"];colTitle="MSIZE";
		}	
		row=rowt.concat().sort();
		col=colt.concat().sort();
		var mt="";
		var rowt="";
		var colt="";
		var idx=-1;
		
		if(col.length&&row.length) {
		bpos.gh_rows=row.length;
		var t_ret=-1;
		mt+="<table id='matrix' width=\""+(col.length*50+100-200)+"px\" height=\""+(row.length*28.5)+"px\" border='0' cellpadding='0' cellspacing='1' style='table-layout:fixed;'>";
		rowt+="<table id='rowtable' width=\""+(col.length*50+100-200)+"px\" border='0' cellpadding='0' cellspacing='1' style='table-layout:fixed;top:" + (-28.5-bpos.gh_rows*28.5) +"px;'>"; 
		colt+="<table id='coltable' width=\"90px\" height=\""+(row.length*28.5+bpos.gh_rows-1)+"px\" border='0' cellpadding='0' cellspacing='1' style='table-layout:fixed;'><tr>";
		mt+="<tr><td class='td_bg_center' width=\"90px\"style=\"text-align:center;\" height=\"28.5px\"><div id=\"color-size-show\">颜色\尺寸</div></td>";		
		rowt+="<tr><td width=\"90px\" height=\"28.5px\">&nbsp;</td>";		
		var tempcol=new Array();
		//alert(Object.toJSON(col));
		tempcol.length=0;
		if(qc!=undefined){
			//先按尺寸组排序，若不在组里，直接显示不排序
			for(var i=0;i<qc.length;i++)	 {
					for(var j=0;j<col.length;j++){
							if(qc[i][1]==col[j]){
								tempcol.push(qc[i][1]);
								}
							}
					}
				if(tempcol.length!=col.length){
						for(var n=0;n<col.length;n++){
							if(!tempcol.contains(col[n])){
								tempcol.push(col[n]);
								}
							}
						
					}	
			 col=tempcol;
			}
				//alert(Object.toJSON(col));
		for(var i=0;i<col.length;i++) {
			if(isC)idx=this.getIndexByValue(cols[0]["MSIZE"],col[i]);
			//整表第一行，显示尺寸——值
			mt+="<td class='td_bg' width=\"60px\" height=\"28.5px\">"+col[i]+(isC?(idx==-1?"":"("+cols[1]["SIZE_CODE"][idx]+")"):"")+"</td>";			
			rowt+="<td class='td_bg' width=\"60px\" height=\"28.5px\">"+col[i]+(isC?(idx==-1?"":"("+cols[1]["SIZE_CODE"][idx]+")"):"")+"</td>";			
			
		}
		mt+="</tr>";
		rowt+="</tr></table>";
		var k=0;
		for(var i=0;i<row.length;i++) {
			if(isR)idx=this.getIndexByValue(rows[0]["COL"],row[i]);
			//整表每行的第一列，显示颜色——值
			mt+="<tr><td class='td_bg' width=\"90px\" height=\"28.5px\">"+row[i]+(isR?(idx==-1?"":"("+rows[1]["COL_CODE"][idx]+")"):"")+"</td>";
			colt+=(i==0)?"":"</tr><tr>";
			colt+="<td class='td_bg' width=\"90px\" height=\"28.5px\">"+row[i]+(isR?(idx==-1?"":"("+rows[1]["COL_CODE"][idx]+")"):"")+"</td>";
			for(var j=0;j<col.length;j++) {
				//t_ret=this.searchIdByXY(j,i,p,ret,["COL","SIZE_CODE"]);
				t_ret=this.searchretBySC(col[j],row[i],ret,colTitle,rowTitle);
				mt+="<td class='td_bg_center' width=\"60px\" height=\"28.5px\" "+(single?"":"align='center'")+">"+(t_ret==-1?"</td>":"<input   "+(single?"type='radio' onkeydown='return false'":"")+" x="+j+" y="+i+" size='5' style='text-align:center;display:inline;' id=TMPnum"+(k++)+" name='TMPnum'>"+(single?"<div style=\"display:inline;\" class='aqty' id="+t_ret.ID+">"+0+"</div><span id=\"barcode\" style=\"display:none;\">"+t_ret.NO+"</span>":"<div style=\"display:inline;\" class='aqty' id="+t_ret.ID+">0</div>")+"</td>");
			//	mt+="<td class='td_bg_center' width=\"130px\" height=\"38.5px\" "+(single?"":"align='center'")+">"+(t_ret==-1?"</td>":"<input "+(single?"type='radio' onkeydown='return false'":"")+" x="+j+" y="+i+" size='5' style='text-align:center;' id=TMPnum"+(k++)+" name='TMPnum'>"+(single?"<div class='aqty' id="+t_ret.ID+">0</div><span id=\"barcode\" style=\"display:none;\">"+t_ret.NO+"</span>":"<div class='aqty' id="+t_ret.ID+">0</div>")+"</td>");
			}
			mt+="</tr>";
		}
		mt+="</table>";
		colt+="</tr></table>";
		mt = mt + "<div id='divTitle' style='z-index:101;position:relative;top:" + (-28.5-bpos.gh_rows*31) +"px;'>" + rowt + "</div>";
    mt = mt + "<div id='divLabel' style='z-index:101;position:relative;top:" + (-(this.browserType()=="IE"?(34.5+bpos.gh_rows-1):35.5)-bpos.gh_rows*30) +"px;'></div>";
   
   

   
    jQuery("#style-body").html(mt);
		jQuery("#divLabel").html(colt);
		//document.getElementById("divTitle").style.display='none';
		//document.getElementById("divLabel").style.display='none';
		
		if(!single){
			jQuery("#style-title").html("数量批量设置<span id=\"TMPstyle\"></span>:<input class=\"q_input_80\" id=\"unite\">&nbsp;<input class=\"qinput\" type=\"button\" value=\"修改\" onclick=\"bxl.unite();\"><input class=\"qinput\" type=\"button\" value=\"清空所有输入\" onclick=\"bxl.rewrite();\">");
			jQuery("#sumnum").html(" 输入总合计：<span id=\"TMPsum\"></span>");
			jQuery("#TMPstyle").html(bpos.change2array(ret)[0].NAME);
		}
		
		single?jQuery("#TMPnum0").attr("checked",true):dwr.util.selectRange(jQuery("#TMPnum0"),0,10); 
		jQuery("#TMPnum0").focus();
		
		this.queryQtycan(qtycan);
			 //失去焦点时，检查输入格式
		if(!single)	{jQuery("#style-body input").bind("blur",function(event){
	      	if(this.value&&event.target==this){
	      	//	alert(this.value);
		    		  if(!(this.value==parseInt(this.value)&&parseInt(this.value)>0)){			 						      
					      alert("数量输入有误!");
					      dwr.util.selectRange(this,0,100);
					      //this.focus();		
					      //bxl.button=this;		 
					      return; 			
			 				}
			 		}
			 		bxl.sumNum();
			 }); 
			}
			jQuery("#avaqty").click(function(){
				bxl.queryQtycan(qtycan);
			});
	 }else {
	 	this.tryCancleM();
	 	alert("没有您要查的内容，请重新输入条件...");
	 }
		
	/*if(col.length&&row.length) {
		bpos.gh_rows=row.length;
		var t_ret=-1;
		mt+="<table id='matrix' width=\""+(col.length*100+100)+"px\" height=\""+(row.length*38.5)+"px\" border='0' cellpadding='0' cellspacing='1' style='table-layout:fixed;'>";
		rowt+="<table id='rowtable' width=\""+(col.length*100+100)+"px\" border='0' cellpadding='0' cellspacing='1' style='table-layout:fixed;'>"; 
		colt+="<table id='coltable' width=\"130px\" height=\""+(row.length*38.5+bpos.gh_rows-1)+"px\" border='0' cellpadding='0' cellspacing='1' style='table-layout:fixed;'><tr>";
		mt+="<tr><td class='td_bg_center' width=\"130px\" height=\"38.5px\">&nbsp;</td>";		
		rowt+="<tr><td width=\"130px\" height=\"38.5px\">&nbsp;</td>";		
		for(var i=0;i<col.length;i++) {
			if(isC)idx=this.getIndexByValue(cols[0]["MSIZE"],col[i]);
			//整表第一行，显示尺寸——值
			mt+="<td class='td_bg' width=\"130px\" height=\"38.5px\">"+col[i]+(isC?(idx==-1?"":"("+cols[1]["SIZE_CODE"][idx]+")"):"")+"</td>";			
			rowt+="<td class='td_bg' width=\"130px\" height=\"38.5px\">"+col[i]+(isC?(idx==-1?"":"("+cols[1]["SIZE_CODE"][idx]+")"):"")+"</td>";			
			
		}
		mt+="</tr>";
		rowt+="</tr></table>";
		var k=0;
		for(var i=0;i<row.length;i++) {
			if(isR)idx=this.getIndexByValue(rows[0]["COL"],row[i]);
			//整表每行的第一列，显示颜色——值
			mt+="<tr><td class='td_bg' width=\"130px\" height=\"38.5px\">"+row[i]+(isR?(idx==-1?"":"("+rows[1]["COL_CODE"][idx]+")"):"")+"</td>";
			colt+=(i==0)?"":"</tr><tr>";
			colt+="<td class='td_bg' width=\"130px\" height=\"38.5px\">"+row[i]+(isR?(idx==-1?"":"("+rows[1]["COL_CODE"][idx]+")"):"")+"</td>";
			for(var j=0;j<col.length;j++) {
				//t_ret=this.searchIdByXY(j,i,p,ret,["COL","SIZE_CODE"]);
				t_ret=this.searchretBySC(col[j],row[i],ret,colTitle,rowTitle);
				mt+="<td class='td_bg_center' width=\"130px\" height=\"38.5px\" "+(single?"":"align='center'")+">"+(t_ret==-1?"</td>":"<input "+(single?"type='radio' onkeydown='return false'":"")+" x="+j+" y="+i+" size='5' style='text-align:center;' id=TMPnum"+(k++)+" name='TMPnum'>"+(single?"<span id=\"barcode\">"+t_ret.NO+"</span>":"")+"<div class='aqty' id="+t_ret.ID+">0</div></td>");
				
			}
			mt+="</tr>";
		}
		mt+="</table>";
		colt+="</tr></table>";
		mt = mt + "<div id='divTitle' style='z-index:101;position:relative;top:" + (-38.5-bpos.gh_rows*38.5) +"px;'>" + rowt + "</div>";
    mt = mt + "<div id='divLabel' style='z-index:101;position:relative;top:" + (-(this.browserType()=="IE"?(38.5+bpos.gh_rows-1):35.5)-bpos.gh_rows*38.5) +"px;'></div>";
   
    jQuery("#style-body").html(mt);
		jQuery("#divLabel").html(colt);
		//document.getElementById("divTitle").style.display='none';
		//document.getElementById("divLabel").style.display='none';
		
		if(!single){
			jQuery("#style-title").html("数量批量设置<span id=\"TMPstyle\"></span>:<input class=\"q_input_80\" id=\"unite\">&nbsp;<input class=\"qinput\" type=\"button\" value=\"修改\" onclick=\"bxl.unite();\"><input class=\"qinput\" type=\"button\" value=\"清空所有输入\" onclick=\"bxl.rewrite();\">");
			jQuery("#sumnum").html(" 输入总合计：<span id=\"TMPsum\"></span>");
			jQuery("#TMPstyle").html(bpos.change2array(ret)[0].NAME);
		}
		
		single?jQuery("#TMPnum0").attr("checked",true):dwr.util.selectRange(jQuery("#TMPnum0"),0,10); 
		jQuery("#TMPnum0").focus();
		
		this.queryQtycan(ret);
			 //失去焦点时，检查输入格式
		if(!single)	{jQuery("#style-body input").bind("blur",function(event){
	      	if(this.value&&event.target==this){
	      	//	alert(this.value);
		    		  if(!(this.value==parseInt(this.value)&&parseInt(this.value)>0)){			 						      
					      alert("数量输入有误!");
					      dwr.util.selectRange(this,0,100);
					      //this.focus();		
					      //bxl.button=this;		 
					      return; 			
			 				}
			 		}
			 		bxl.sumNum();
			 }); 
			}
			jQuery("#avaqty").click(function(){
				bxl.queryQtycan(ret);
			});
	 }else {
	 	this.tryCancleM();
	 	alert("没有您要查的内容，请重新输入条件...");
	 }*/
	 function x_next(x,y) {
  		var xx=++x;
  		var cell;
  		do{
  			cell=jQuery("#style-body input[x="+xx+"][y="+y+"]");
	  		if(!cell.length)xx++;
  		}while(!cell.length&&xx<col.length);  		
  		if(bxl.single){
  		  cell.attr("checked",true);
  			cell.focus();
  		}else {
  			dwr.util.selectRange(cell[0],0,100);
  		}
  	}
  	function x_pre(x,y) {
  		var xx=--x;
  		var cell;
  		do{
  			cell=jQuery("#style-body input[x="+xx+"][=y="+y+"]");
	  		if(!cell.length)xx--;
  		}while(!cell.length&&xx>=0);  		
  		if(bxl.single){
  		  cell.attr("checked",true);
  			cell.focus();
  		}else {
  			dwr.util.selectRange(cell[0],0,100);
  		}
  	}
  	function y_next(x,y) {
  		var yy=++y;
  		var cell;
  		do{
  			cell=jQuery("#style-body input[x="+x+"][y="+yy+"]");
  			if(!cell.length)yy++;
  		}while(!cell.length&&yy<row.length);
  		if(bxl.single){
  		  cell.attr("checked",true);
  			cell.focus();
  		}else {
  			dwr.util.selectRange(cell[0],0,100);
  		}
  	}
  	function y_pre(x,y) {
  		var yy=--y;
  		var cell;
  		do{
  			cell=jQuery("#style-body input[x="+x+"][y="+yy+"]");
  			if(!cell.length)yy--;
  		}while(!cell.length&&yy>=0);
  		if(bxl.single){
  		  cell.attr("checked",true);
  			cell.focus();
  		}else {
  			dwr.util.selectRange(cell[0],0,100);
  		}
  	}
  	var inputs=jQuery("#save,#cancel",$("styleMatrix-content"));
  	var startInput=$("save");
  	jQuery("#styleMatrix-content").bind("keydown",function(event){
  		var ele=Event.element(event);
  		var x=parseInt(jQuery(ele).attr("x"));
  		var y=parseInt(jQuery(ele).attr("y"));		
  		if(event.which==13) {
  			if((bxl.isnum()||bxl.single)&&(ele.id.indexOf("TMPnum")!=-1))jQuery("#save").click();
  		}else if(event.which==37) {
  			x_pre(x,y);
  		}else if(event.which==38) {			
  			y_pre(x,y);
  		}else if(event.which==39) {
  			x_next(x,y);
  		}else if(event.which==40) {
  			y_next(x,y);
  		}else if(event.which==9) {
				event.stopPropagation();
		    event.preventDefault();
				startInput=bpos.tabKeydown(inputs,startInput);
  		}
  	});				
	},
	//尺寸组排序
	sortSizeGroup:function(ret,color,size,single,tempstyle) {
		
		jQuery.ajax({
				type:"POST",
				cache:false,
				url:bpos.URL+"getBarcodeQtyCanByUserId.jsp?styles="+encodeURI(bpos.change2array(ret)[0].NAME)+(bpos.URL?("&storeid="+bpos.master_data.c_store_id):""),
				timeout:60000,
				error:function(){
					bxl.matrixSearchaction(ret,color,size,single);
					//alert("网络不畅，请稍后重试...");
				},
				success:function(data){
				//	alert('11');
					//var rets=data.jsonResult.evalJSON();
					eval("var qc="+bpos.change2array(data));
				/*	var qc=bpos.change2array(data);
					for(var i=0;i<qc.length;i++) {
						alert(qc[i]);
						alert(qc[i][0]);
					}*/
					bxl.matrixSearchaction(ret,color,size,single,qc[0],qc[1]);
				}
		}); 
	},
	//查询所有可用库存
	queryQtycan:function(qc) {
		//jQuery("#avaqty").attr("disabled",true);
		
	/*	jQuery.ajax({
				type:"POST",
				cache:false,
				url:bpos.URL+"getBarcodeQtyCanByUserId.jsp?styles="+encodeURI(bpos.change2array(ret)[0].NAME)+(bpos.URL?("&storeid="+bpos.master_data.c_store_id):""),
				timeout:60000,
				error:function(){
					jQuery("#avaqty").removeAttr("disabled");
					//alert("网络不畅，请稍后重试...");
				},
				success:function(data){
					jQuery("#avaqty").removeAttr("disabled");
				//	var data="[['102sdfds', '102sdf'], ['1afdsf', '2ds'], [33, 223], [45, 3], [343, 4], [343, 21], [34, 34], [34, 2], [2, 34], [9, 9]]";
					eval("var qc="+bpos.change2array(data));
					
					
				}
		}); */
		if(qc==undefined){
			return;
			}
		for(var i=0;i<qc.length;i++) {
						//alert(qc[i][0]);
						jQuery("#"+qc[i][0]).html(qc[i][1]);
		}
	},

	//根据尺寸和颜色在ret中搜索相应的对象
	searchretBySC:function(size,color,ret,col,row) {
		var rett=bpos.change2array(ret);
		for(var i=0;i<rett.length;i++) {
			if(rett[i][col]==size&&rett[i][row]==color) {
				this.mutilines.push(rett[i]);
				return rett[i];
			}
		}
		return -1;
	},

	//搜索指定属性全部不重复的值
	searchByPropety:function(ret,propety) {
		var propetys=[];
		var m=1;
		var rett=bpos.change2array(ret);
		for(var i=0;i<propety.length;i++) {
			var p={};
			p[propety[i]]=[];
			for(var j=0;j<rett.length;j++) {
				m=1;
				for(var k=0;k<p[propety[i]].length;k++) {
					if(rett[j][propety[i]]==p[propety[i]][k]){m=0;break;}
				}
				if(m)p[propety[i]].push(rett[j][propety[i]]);
			}
			//p[propety[i]].sort();
			propetys.push(p);
		}
		return propetys;
	},
	
	//Edit by Robin 20100807
	searchaction:function(ret){
	 	var str=""; 	
	 	var arr=bpos.change2array(ret);  
	//alert(Object.toJSON(ret));
	 	this.mutilines=arr; 
		if(ret==null){
				alert("没有您要查询的内容");
			}else{	
					 for(var i=0;i<arr.length;i++){	 
					 var tempvalue=arr[i].VALUE?arr[i].VALUE:"";
					 var m_dim5=arr[i].m_dim5?arr[i].m_dim5:"";
	       	 var m_dim9=arr[i].m_dim9?arr[i].m_dim9:"";
				 	
					if(i%2==1){
						 	if(bpos.master_data.params.pageStyle=="redearth") {
					        str+="<div class=\"treatment-row\"><div class=\"treatment-row-line\"><div class=\"treatment-span-10\">"+arr[i].NAME+"</div><div class=\"treatment-span-10\" >"+tempvalue+"</div><div class=\"treatment-span-7\">"+arr[i].NO+"</div><div class=\"treatment-span-8\">"+arr[i].PRICELIST+"</div><div class=\"treatment-span-6\">"+arr[i].COL+"</div><div class=\"treatment-span-6\">"+arr[i].MSIZE+"</div><div class=\"treatment-span-6\">"+arr[i].COL_CODE+"</div><div class=\"treatment-span-6\">"+arr[i].SIZE_CODE+"</div><div class=\"treatment-span-9\"><input id=\"TMPnum"+i+"\" name=\"TMPnum\" type=\"text\" class=\"bluk-input\"></div></div></div>";
						  }else if(bpos.master_data.params.pageStyle=="tommy"){
						      str+="<div class=\"treatment-row\"><div class=\"treatment-row-line\"><div class=\"treatment-span-7\">"+arr[i].NO+"</div><div class=\"treatment-span-10\">"+arr[i].NAME+"</div><div class=\"treatment-span-10\" >"+tempvalue+"</div><div class=\"treatment-span-6\">"+arr[i].COL+"</div><div class=\"treatment-span-6\">"+arr[i].MSIZE+"</div><div class=\"treatment-span-6\">"+m_dim5+"</div><div class=\"treatment-span-6\">"+m_dim9+"</div><div class=\"treatment-span-8\">"+arr[i].PRICELIST+"</div><div class=\"treatment-span-9\"><input id=\"TMPnum"+i+"\" name=\"TMPnum\" type=\"text\" class=\"bluk-input\"></div></div></div>";
						 	}else{
						      str+="<div class=\"treatment-row\"><div class=\"treatment-row-line\"><div class=\"treatment-span-7\">"+arr[i].NO+"</div><div class=\"treatment-span-10\">"+arr[i].NAME+"</div><div class=\"treatment-span-10\" >"+tempvalue+"</div><div class=\"treatment-span-6\">"+arr[i].COL+"</div><div class=\"treatment-span-6\">"+arr[i].MSIZE+"</div><div class=\"treatment-span-6\">"+arr[i].COL_CODE+"</div><div class=\"treatment-span-6\">"+arr[i].SIZE_CODE+"</div><div class=\"treatment-span-8\">"+arr[i].PRICELIST+"</div><div class=\"treatment-span-9\"><input id=\"TMPnum"+i+"\" name=\"TMPnum\" type=\"text\" class=\"bluk-input\"></div></div></div>";
						  }
					}else{
						 if(bpos.master_data.params.pageStyle=="redearth") {
						      str+="<div class=\"treatment-conduct\"><div class=\"treatment-conduct-line\"><div class=\"treatment-span-10\">"+arr[i].NAME+"</div><div class=\"treatment-span-10\" >"+tempvalue+"</div><div class=\"treatment-span-7\">"+arr[i].NO+"</div><div class=\"treatment-span-8\">"+arr[i].PRICELIST+"</div><div class=\"treatment-span-6\">"+arr[i].COL+"</div><div class=\"treatment-span-6\">"+arr[i].MSIZE+"</div><div class=\"treatment-span-6\">"+arr[i].COL_CODE+"</div><div class=\"treatment-span-6\">"+arr[i].SIZE_CODE+"</div><div class=\"treatment-span-9\"><input id=\"TMPnum"+i+"\" name=\"TMPnum\" type=\"text\" class=\"bluk-input\"></div></div></div>";
						  }else if(bpos.master_data.params.pageStyle=="tommy"){
						     	str+="<div class=\"treatment-conduct\"><div class=\"treatment-conduct-line\"><div class=\"treatment-span-7\">"+arr[i].NO+"</div><div class=\"treatment-span-10\">"+arr[i].NAME+"</div><div class=\"treatment-span-10\" >"+tempvalue+"</div><div class=\"treatment-span-6\">"+arr[i].COL+"</div><div class=\"treatment-span-6\">"+arr[i].MSIZE+"</div><div class=\"treatment-span-6\">"+m_dim5+"</div><div class=\"treatment-span-6\">"+m_dim9+"</div><div class=\"treatment-span-8\">"+arr[i].PRICELIST+"</div><div class=\"treatment-span-9\"><input id=\"TMPnum"+i+"\" name=\"TMPnum\" type=\"text\" class=\"bluk-input\"></div></div></div>";
						  }else{
						      str+="<div class=\"treatment-conduct\"><div class=\"treatment-conduct-line\"><div class=\"treatment-span-7\">"+arr[i].NO+"</div><div class=\"treatment-span-10\">"+arr[i].NAME+"</div><div class=\"treatment-span-10\" >"+tempvalue+"</div><div class=\"treatment-span-6\">"+arr[i].COL+"</div><div class=\"treatment-span-6\">"+arr[i].MSIZE+"</div><div class=\"treatment-span-6\">"+arr[i].COL_CODE+"</div><div class=\"treatment-span-6\">"+arr[i].SIZE_CODE+"</div><div class=\"treatment-span-8\">"+arr[i].PRICELIST+"</div><div class=\"treatment-span-9\"><input id=\"TMPnum"+i+"\" name=\"TMPnum\" type=\"text\" class=\"bluk-input\"></div></div></div>";
           			}  
						}
					 		
				    				      
				   }
	       /*else if(bpos.master_data.params.pageStyle=="tommy"){
	       	 for(var i=0;i<arr.length;i++){	 
	       	 	var m_dim5=arr[i].m_dim5?arr[i].m_dim5:"";
	       	 	var m_dim9=arr[i].m_dim9?arr[i].m_dim9:"";
	       	 	var tempvalue=arr[i].VALUE||"";
				    if(i%2==1){
				      str+="<div class=\"treatment-row\"><div class=\"treatment-row-line\"><div class=\"treatment-span-7\">"+arr[i].NO+"</div><div class=\"treatment-span-10\">"+arr[i].NAME+"</div><div class=\"treatment-span-10\" >"+tempvalue+"</div><div class=\"treatment-span-6\">"+arr[i].COL+"</div><div class=\"treatment-span-6\">"+arr[i].MSIZE+"</div><div class=\"treatment-span-6\">"+m_dim5+"</div><div class=\"treatment-span-6\">"+m_dim9+"</div><div class=\"treatment-span-8\">"+arr[i].PRICELIST+"</div><div class=\"treatment-span-9\"><input id=\"TMPnum"+i+"\" name=\"TMPnum\" type=\"text\" class=\"bluk-input\"></div></div></div>";
					       }else{
					       	str+="<div class=\"treatment-conduct\"><div class=\"treatment-conduct-line\"><div class=\"treatment-span-7\">"+arr[i].NO+"</div><div class=\"treatment-span-10\">"+arr[i].NAME+"</div><div class=\"treatment-span-10\" >"+tempvalue+"</div><div class=\"treatment-span-6\">"+arr[i].COL+"</div><div class=\"treatment-span-6\">"+arr[i].MSIZE+"</div><div class=\"treatment-span-6\">"+m_dim5+"</div><div class=\"treatment-span-6\">"+m_dim9+"</div><div class=\"treatment-span-8\">"+arr[i].PRICELIST+"</div><div class=\"treatment-span-9\"><input id=\"TMPnum"+i+"\" name=\"TMPnum\" type=\"text\" class=\"bluk-input\"></div></div></div>";
					      	
					      	}	   				      
				   }
	       	}
	       else{
				   for(var i=0;i<arr.length;i++){
				    if(i%2==1){
				    	var tempvalue=arr[i].VALUE||"";
				      str+="<div class=\"treatment-row\"><div class=\"treatment-row-line\"><div class=\"treatment-span-7\">"+arr[i].NO+"</div><div class=\"treatment-span-10\">"+arr[i].NAME+"</div><div class=\"treatment-span-10\" >"+tempvalue+"</div><div class=\"treatment-span-6\">"+arr[i].COL+"</div><div class=\"treatment-span-6\">"+arr[i].MSIZE+"</div><div class=\"treatment-span-6\">"+arr[i].COL_CODE+"</div><div class=\"treatment-span-6\">"+arr[i].SIZE_CODE+"</div><div class=\"treatment-span-8\">"+arr[i].PRICELIST+"</div><div class=\"treatment-span-9\"><input id=\"TMPnum"+i+"\" name=\"TMPnum\" type=\"text\" class=\"bluk-input\"></div></div></div>";
					       }else{
					       	str+="<div class=\"treatment-conduct\"><div class=\"treatment-conduct-line\"><div class=\"treatment-span-7\">"+arr[i].NO+"</div><div class=\"treatment-span-10\">"+arr[i].NAME+"</div><div class=\"treatment-span-10\" >"+tempvalue+"</div><div class=\"treatment-span-6\">"+arr[i].COL+"</div><div class=\"treatment-span-6\">"+arr[i].MSIZE+"</div><div class=\"treatment-span-6\">"+arr[i].COL_CODE+"</div><div class=\"treatment-span-6\">"+arr[i].SIZE_CODE+"</div><div class=\"treatment-span-8\">"+arr[i].PRICELIST+"</div><div class=\"treatment-span-9\"><input id=\"TMPnum"+i+"\" name=\"TMPnum\" type=\"text\" class=\"bluk-input\"></div></div></div>";
					      }  				      
				   }
				   	}*/
		   }
		    jQuery("#treatment-main").html(str);	
		    jQuery("#TMPnum0").focus();
		    $("s").disabled=false;  
			 //失去焦点时，检查输入格式
			 jQuery("#treatment-main input").bind("blur",function(event){
	      	if(this.value&&event.target==this){
	      	//	alert(this.value);
		    		  if(!(this.value==parseInt(this.value)&&parseInt(this.value)>0)){			 						      
					      alert("数量输入有误!");
					      this.focus();		
					      bxl.button=this;		 
					      return; 			
			 				}
			 			}
			 }); 
	},
	//批量录入的查询
 	_onsearch:function(e){
 		var data=e.getUserData(); // data
		var ret=data.jsonResult.evalJSON(); 
   	this.searchaction(ret);
 	}, 	
 		
 		//批量录入的取消
	tryCancle:function(){
		  bpos.killAlert("insert_num_content");	
	},

	tryCancleM:function(noResetRetailType) {
		bpos.killAlert("styleMatrix-content",noResetRetailType);
	},
	
	//批量录入（矩阵）
	matrixInsertnum:function() {
		if((bpos.MODEL&bpos.INSERTLINE)!=bpos.INSERTLINE){
			alert("该单据不可新增");
			return;
		}
		if(bpos.nosalererror()){
			return;
		}
		/*
		if(bpos.itemtype==2&&bpos.master_data.params.needorgno){
		 	alert("错误：退货不能使用批量录入功能！");
		 	return;
		}*/
	  var ele=Alerts.fireMessageBox({
	    width:610,
	    modal:true,
	    title:gMessageHolder.EDIT_MEASURE
		});
		ele.innerHTML= "<div id=\"styleMatrix-content\" class=\"txt-white\">"+
		"<div id=\"style-head\">店仓：<span id=\"store\"></span> &nbsp;&nbsp;&nbsp;款号：<select id=\"styleM\" style=\"width:atuo;min-width:100px;\"></select>  &nbsp;&nbsp;&nbsp; <input type=\"button\" class=\"qinput\" id=\"avaqty\" value=\"可用量\"><div id=\"style-title\"></div>"+
		"</div><div class=\"style-body\" id=\"style-body\" onscroll=\"javascript:bxl.scrollData();\"></div><div>"+
		"<table width=\"580\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
		"<tr><td><div class=\"txt-white\" id=\"sumnum\"></div></td><td align=\"right\">"+
		"<input type=\"button\" id=\"save\" class=\"qinput\" value=\"保存\" onclick=\"javascript:bxl.handlesingledisM();\"> &nbsp;"+
		"<input type=\"button\" id=\"cancel\" class=\"qinput\" value=\"取消\" onclick=\"javascript:bxl.tryCancleM();\"></td></tr></table></div></div>";
    bpos.executeLoadedScript(ele);	    
    bpos.noAlert=false;	
		jQuery("#store").html(bpos.master_data.c_store_name);
		
	},
	//款号模式，页面滚动控制
	scrollData:function(){
		//alert(bpos.gh_rows);
		document.getElementById("divTitle").style.display='';
		document.getElementById("divLabel").style.display='';
		/*
		if(document.getElementById("style-body").scrollTop>document.getElementById("divLabel").offsetHeight){
			document.getElementById("style-body").scrollHeight=document.getElementById("matrix").offsetHeight;
		}
		*/
			//alert(document.getElementById("matrix").offsetHeight+" ? "+document.getElementById("style-body").scrollHeight);
		document.getElementById("divTitle").style.top = ((-38.5-bpos.gh_rows*30.5)+document.getElementById("style-body").scrollTop) + "px";
		document.getElementById("divLabel").style.left = (document.getElementById("style-body").scrollLeft) + "px";
	},

			//批量录入
	insertnum:function(){
		//	if(!bpos.canmodify())return;
		if((bpos.MODEL&bpos.INSERTLINE)!=bpos.INSERTLINE){
			alert("该单据不可新增");
			return;
		}
		  if(bpos.nosalererror()){
			    return
		   }
		  if(bpos.itemtype==2&&bpos.master_data.params.needorgno){
		  	alert("错误：退货不能使用批量录入功能！");
		  	return;
		  }
	      var ele=Alerts.fireMessageBox({
	    	width:728,
	     	modal:true,
	     	title:gMessageHolder.EDIT_MEASURE
		   });	 
			  ele.innerHTML= $("insert_num").innerHTML.replace(/TMP/g,"");
        bpos.executeLoadedScript(ele);	 
        bpos.noAlert=false;
        jQuery("#styles").focus();
        //条件输入框，支持左右键
      //var button;
      var inputs=jQuery("#search_num,#unite,#united,#re,#s,#cancle",$("insert_num_content"));
      var startInput=$("unite");
      var input=jQuery("#styles,#color,#size");
      jQuery("#insert_num_content").bind("keydown",function(event){	   
				
      	var eles=jQuery("#treatment-main input");
      		 if(event.which==9){   //tab键
							event.stopPropagation();
						  event.preventDefault(); 
				      startInput=bpos.tabKeydown(inputs,startInput);
      		 }else if(event.which==13){ //执行匹配的事件	
		 	        if(input.index(event.target)!=-1){
		 	          	bxl.styles(); 	      		 	          
		 		       }else if(eles.index(event.target)!=-1){   
		 		       	// alert(bxl.isnum());  		 		      
                	if(bxl.isnum()){
                		//alert("adfadfads");
                		jQuery("#s").click();                    
	                }else{
	                	jQuery("#s").focus();
	                }
		 		       }else{
  		 		       	var s=inputs[index];
  		 		       	jQuery(s).click();
		 		       	}
      		 }else if(event.which==39){   //右键	      	    	       			   
  			        var index=0;	
  			        if(!bxl.button){
  			        	 index=input.index(bxl.button)+2;	 
  			        }else{	      			                   			 
  			   	   		index=input.index(bxl.button)+1;}	      			   	     			   
               if(!input[index]){
		               index=0;
	              }
	              bxl.button=input[index];
	            	dwr.util.selectRange(input[index],0,100);			
			     }else if(event.which==37){  //左键					   
          	        var len=input.length;
                  	var index=0;			      	   
		      		          index=input.index(bxl.button)-1;			      		       
		                if(index<0){
				              index=len-1;
					           }	
			              bxl.button=input[index];
			              dwr.util.selectRange(input[index],0,100);
			    }else if(event.which==40){ //down		 
			   	         var index=0;
			   	          if(!bxl.button){
      			        	 index=eles.index(bxl.button)+2;	 
      			        	}else{
			   		         index=eles.index(bxl.button)+1;	
			   		         }if(!eles[index]){
					                 index=0;
				              }
				          bxl.button=eles[index];
				         // bxl.button.focus();
				     dwr.util.selectRange(eles[index],0,100);
				  }else if(event.which==38){ //up
              var len=eles.length;
            	var index=0;			     
			   		   index=eles.index(bxl.button)-1;		 
			      if(index<0){
					      index=len-1;
						 }
					bxl.button=eles[index];
				  dwr.util.selectRange(eles[index],0,100); 
				}
    });
 },
	    //检查查询条件
styles:function (){
	var str="";
	 jQuery("#treatment-main").html(str);	
	  var styles=jQuery.trim($("styles").value);
	  /*
	  if(styles.length<4){
	  	alert("条件");
	  }*/
	   bxl.searchnum();
	},
	    //判断是否位数字
	isnum:function(){
		var a;
    var nums=document.getElementsByName("TMPnum");	
		for(var i=0;i<nums.length;i++){ 			  	
      if(!(nums[i].value==parseInt(nums[i].value)&&parseInt(nums[i].value)>0)){
      	if(nums[i].value!=null&&nums[i].value!=""){
      		a=nums[i].value;
      	}	 				 		  			
    	}
    }
	  if(a!=null&&a!=""){
	    	return false;
	  }else{
	    	return true;
	  }    
	},
	  //单品策略
	Singledis:function(param){
		return (MainApp.SingleDis(param)).evalJSON();
	},
	  //显示到页面
 	doSingledis:function(m){
 		var para=new Array();
 		var p={};
 		var nums=[];
 		if(m){
 			nums=jQuery("#style-body input[value!='']");
 		}else {
 			nums=jQuery("#treatment-main input[value!='']");
 		}
 		if(nums.length==0){
 			alert("录入信息为空");
 		}else{
 				var inputs=document.getElementsByName("TMPnum");
       for(var i=0;i<inputs.length;i++){  
        	if(inputs[i].value!=""){   
            var line={};
            line.cardno=bpos.vip.cardno||"1";
            line.c_store_id=bpos.master_data.c_store_id;
            line.billdate=$("sys_date").value;
				    line.m_retail_productno=bxl.mutilines[i].NO;     //条码
				    line.m_retail_qty=isNaN(parseInt(inputs[i].value,10))?0:parseInt(inputs[i].value,10);    //数量
				    line.m_retail_type=bpos.itemtype+"";   
				    //line.m_retail_type="1"; 
				    line.m_retail_orgdocno="-1"; 
				    line.m_retail_priceactual=isNaN(parseFloat(bxl.mutilines[i].PRICELIST*line.discount))?0.00:parseFloat(bxl.mutilines[i].PRICELIST*line.discount);                      //退货单号     
				    line.discount=isNaN(parseFloat(1))?0.00:parseFloat(1);			  					  					  
		        line.vipexp=bpos.vip.vipexp||"1";
		        line.vipbir=bpos.vip.birthday||"";
				    para.push(line);   					                      
 				}	   	  
  		}
       p.Table=para;
       var j={};
       j.param=p;
       return bxl.Singledis(Object.toJSON(j));
     
 		}
 
	 },
	 //矩阵确定输入
	 handlesingledisM:function(){
	 	
	 	if(this.single) {
	 		$("m_retail_idx").value=jQuery("#style-body input[checked] ~ span").text();
	 		this.tryCancleM(true);
	 		bpos.insertLine();
	 	}else {
	 		this.handlesingledis('m');
	 		this.tryCancleM();
	 	}
	 	
	 },
	 
	 handlesingledis:function(m){
	 	var data=this.doSingledis(m);
	 	if(data.NewDataSet&&data.NewDataSet.Table){
	    	var arr=bpos.change2array(data.NewDataSet.Table);
	 	    if(arr.length>0){
	 	for(var i=0;i<arr.length;i++){ 		
	 		var line={};				  
 					   line.productno=arr[i].m_retail_productno;     //条码
 					   line.productname=arr[i].m_retail_productname;   //品名 			
 					   line.colorname=arr[i].	m_retail_colorname;      //颜色名
 					   line.sizename=arr[i].m_retail_sizename;     //尺寸名
 					   line.color=arr[i].m_retail_color; //颜色
 					   line.size=arr[i].m_retail_size;     //尺寸
 					   line.mdim11=arr[i].m_retail_mdim11;//国标码
 					   line.productvalue=arr[i].m_retail_productvalue;//款号 					   
 					   line.pricelist=parseFloat(arr[i].m_retail_pricelist); //原价					  
 					   line.discount=parseFloat(arr[i].m_retail_discount);//折扣					 
 					   line.discription=arr[i].m_retail_discription;  //描述				                    
 					   line.priceactual=parseFloat(arr[i].m_retail_priceactual);  //成交价
 					   line.priceactual=bpos.alg(line.priceactual);
 					   line.qty=parseInt(arr[i].m_retail_qty);    //数量  				   
 					   line.price=parseFloat(arr[i].m_retail_price);         //应付价    
 					   line.price=bpos.alg(line.price);
 					   line.salerid=bpos.master_data.saler.id;                    //营业员ID
 					   line.saler=bpos.master_data.saler.name;         //营业员
 					   line.multisalers=bpos.master_data.multisalers||[];//支持多选营业员
 					   line.type=arr[i].m_retail_type;                          //状态
 					   line.orgdocno=arr[i].m_retail_orgdocno;                       //退货单号
 					   //line.lineno=arr[i].lineid;   //行号
 					   line.lineno=-1;   //行号
 					   line.pda_id=arr[i].m_pda_id;//条码ID
 					   line.locked=arr[i].locked||0;
						 line.lowest_discount=arr[i].lowest_discount||0;
						 line.sin_disid=parseInt(arr[i].sin_disid,10)||-1;		
						 line.sin_disname=arr[i].sin_disname||-1;	
						 line.com_disid=parseInt(arr[i].com_disid,10)||-1;
						 line.com_disname=arr[i].com_disname||-1;
						 line.add_disid=parseInt(arr[i].add_disid,10)||-1;
						 line.add_disname=arr[i].add_disname||-1;		
						 for(var p=1;p<=20;p++){
							eval("line.m_dim"+p+"=arr["+i+"].m_dim"+p+"?arr["+i+"].m_dim"+p+":\"\";");
					   }
 					   //alert(Object.toJSON(line));  					                      
 					   bpos.updateitems_data2(line);
	 		} 
	 		} 
	 		this.tryCancle();
	 		$("m_retail_idx").value="";
			var m_retail_idx=$("m_retail_idx");
			m_retail_idx.focus();
	 	}
	 	},

//权限控制,才可进行该金额等相关操作
	 validateEmployee:function(d,isBillDate){
	 	var ele =Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});			 
			 ele.innerHTML="<div id=\"login_content\"><table width=\"400\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
       "<tr><td><div id=\"treatment_td\"><div id=\"treatment_text\">校验权限：</div></div></td></tr><tr>"+
       "<td><div id=\"user_botder\">"+
	     "<ul><li><div class=\"user-left\">用户名：</div><div class=\"user-right\"><input value=\"当前用户\" id=\"emname\" name=\"emname\" type=\"text\" class=\"user-input\"></div></li>"+
	     "<li><div class=\"user-left\">密&nbsp;&nbsp;&nbsp;&nbsp;码：</div><div class=\"user-right\"><input id=\"empwd\" name=\"empwd\" type=\"password\" class=\"user-input\" /></div></li>"+
	     "</ul></div></div></td></tr> <tr><td><div id=\"treatment_td\" align=\"center\"><div id=\"treatment_text\">&nbsp;"+ 
       "<input type=\"button\" value=\"确定\" class=\"qinput\" id=\"btn-oks\" onclick=\"bxl.validate('"+d+"',"+isBillDate+")\"/>"+
       "&nbsp;<input name=\"cancle\" id=\"btn-c\" type=\"button\" class=\"qinput\" value=\"取消\" onclick=\"javascript:bxl.closeEmp('Q')\" /></div></td></tr></table></div>";  
     bpos.executeLoadedScript(ele);
     bpos.noAlert=false;
     jQuery("#empwd").focus();
     //alert(bpos.master_data.Operator.email);
     var emailOfOperator=bpos.master_data.operator.email||"";
     if(emailOfOperator&&emailOfOperator!="")
       {
       	  jQuery("#emname").val(bpos.master_data.operator.email);
       }
     var inputs=jQuery("#emname,#empwd,#btn-oks,#btn-c");
     jQuery("#login_content").bind("keydown",function(event){
     		event.stopPropagation();
     		var tagt=event.target;
   			var idx=inputs.index(tagt);
   	    if(event.which==13){
   	     	switch(idx){
   	     		case 1:if(tagt.value)jQuery(inputs[2]).click();break;
   	     		case 0:if(tagt.value)jQuery(inputs[1]).focus();break;
   	     		default:if(inputs[0].value&&inputs[1].value){
   	     			jQuery(inputs[2]).click();
   	     		}else{
   	     			jQuery(inputs[0]).focus();
   	     		}
   	     	}
   	    }else if(event.which==40){
   	    	switch(idx){
   	     		case 0:jQuery(inputs[1]).focus();break;
   	     		case 1:jQuery(inputs[0]).focus();break;
   	     		default:jQuery(inputs[1]).focus();
   	     	}	 		
   	    }else if(event.which==38){
   	    	switch(idx){
   	     		case 0:jQuery(inputs[1]).focus();break;
   	     		case 1:jQuery(inputs[0]).focus();break;
   	     		default:jQuery(inputs[0]).focus();
   	     	}	 		 			
   	    }else if(event.which==9){
				  event.preventDefault();
				  if(inputs[idx+1]){
				  	jQuery(inputs[idx+1]).focus();
				  }else{
				  	jQuery(inputs[0]).focus();
				  }
			 }    	     		
     });
	},
validate:function(d,isBillDate){	
		//jQuery("#btn-oks input[type='button']").attr("disabled","true");
		$("btn-oks").disabled=true;
		var urlAddress=isBillDate?"validateUserWebposPer.jsp":"validateLogin.jsp";
		jQuery.ajax({
			type:"POST",
			url:bpos.URL+urlAddress,
			timeout:30000,
			data:{email:document.getElementById("emname").value,pwd:document.getElementById("empwd").value,storeid:bpos.offlineUserinfo?bpos.offlineUserinfo.storeid:""},
			error:function(){
				$("btn-oks").disabled=false;
				alert("网络不畅,请稍后再试！");
			},
			success:function(data) {
				$("btn-oks").disabled=false;
				if(jQuery.trim(data)!="error"){
				  var discountlimit=data.substring(0,data.indexOf("+"));
				  var	isret=data.substring(data.indexOf("+")+1).toString();		
				  var ret=jQuery.trim(isret);  
					bpos.master_data.discountlimit=parseFloat(discountlimit);
					bxl.closeEmp();
				  if(d=="price"){
						setTimeout('bpos.updateprice()',100);	
					}else if(d=="discount"){
						setTimeout('zody.amount()',100);
					}else if(d=="Q"){
						if(ret=="N"){
							alert("您没有退货权限");
							return;
						}
						setTimeout('bpos._editretailno()',100);	
					}else if(d=="V"){
						if(ret=="N"){
							alert("您没有退货权限");
							return;
						}
						//进入无需输入原单编号流程
						bxl.closeEmp(d);
						setTimeout('bpos.checkretailno("")',100);	
					}else if(d=="changeTime") {
						var id=data.substring(0,data.indexOf("+"));
						var webpos_per=data.substring(data.indexOf("+")+1).toString();
						if((parseInt(webpos_per,2)&bpos.CHANGEBILLDATE)==bpos.CHANGEBILLDATE) {
							bpos.changeTimeValidate(bpos.selectDate,id);
							return;
						}else {
							bpos.changeTimeValidate(new Date());
							alert("无权限");
						}					
					}
				}else{
					alert("用户名或密码错误！");
				}
				
			}	
		});		
},
	closeEmp:function(d){
	 		bpos.killAlert("login_content",true);	
	 		if(d&&d=="V"){
	 			bpos.killAlert("r_retail_no_content",true);
			}else if(d&&d=="Q"){
				bpos.changeTimeValidate(new Date());
				bpos.killAlert("r_retail_no_content",true);
				bpos.selectFirstType();
				$("m_retail_idx").value="";
			}
	},
//F2营业员
	sales:function(){
		
		this.linenoes=bpos.getcheckedlinenoes();
		var len=this.linenoes.length||-1;
		if(len>0){
			if(!confirm("您选择了序号"+this.linenoes+"，确认更改营业员？")){	
				return;
			}		
		}	
		
		var ele = Alerts.fireMessageBox(
				{
					width: 400,
					modal: true,
					title: gMessageHolder.EDIT_MEASURE
				});
			var str="";
			if(bpos.master_data.params.pageStyle=="redearth"){
					 str="<div id=\"sales_content\" class=\"salesperson_content\"><div id=\"treatment_td\"><div id=\"treatment_text\">"+(len>0?"请选择更改员工：":"请选择当前员工：")+"<input type=\"text\"  id=\"search\" name=\"search\"/></div></div><div id=\"salesperson_botder\"><ul style=\"height: 150px; visibility: visible; opacity: 1;\">";
			}else{
						    str="<div id=\"sales_content\" class=\"salesperson_content\"><div id=\"treatment_td\"><div id=\"treatment_text\">"+(len>0?"请选择更改营业员":"请选择当前营业员：")+"<input type=\"text\"  id=\"search\" name=\"search\"/></div></div><div id=\"salesperson_botder\"><ul style=\"height: 150px; visibility: visible; opacity: 1;\">";
			}
			var multi=false;
			if(bpos.master_data.params.multiSalers=="true")multi=true;
			if(bpos.master_data.salers.length<=1){
			   str+="<tr><td height=\"30\"><div class=\"desc-txt\">当前店铺没有营业员</div></td></tr>";
			 }else{
			 	
			   for(var i=0;i<bpos.master_data.salers.length;i++){					
					 if(bpos.master_data.salers[i].id!=-1)
					 
				   str+="<li><input name=\"employee\" id='employee-"+i+"' "+(multi?"type=\"checkbox\"":"onclick=\"javascript:bxl.getEmployee();\" type=\"radio\"")+" value=\"\" class=\"salesperson_input\" />"+bpos.master_data.salers[i].name+"("+bpos.master_data.salers[i].truename+")"+"</li>";
			   }
			 }			
			str+="</ul></div><div id=\"treatment_td\" align=\"center\"><div id=\"treatment_text\">"+(multi?"<input type=\"button\" class=\"qinput\" id=\"identify\" onclick=\"bxl.getEmployee()\" value=\"确定\">":"")+"<input type=\"button\" class=\"qinput\" id=\"close\" onclick=\"bxl.closeEmployee()\" value=\"取消\"></div></div></div>"
			ele.innerHTML=str;
			bpos.executeLoadedScript(ele);
			bpos.noAlert=false;
			jQuery("#search").focus();
				//营业员的模糊查询
		jQuery("#search").bind("keyup",function(event){
        var li=jQuery("#salesperson_botder li");
        var st=jQuery("#search").val();
        var n=st.toLowerCase();
        li.each(function(){
        	var t=jQuery(this).text();  
        	var u=t.toLowerCase(); 
        	if(u.indexOf(n)==-1){
        	   jQuery(this).hide();
        	}else{
        		 jQuery(this).show();
        	}
        });
        if(event.which==13&&jQuery.trim(st)!=""){
        	jQuery("#salesperson_botder li:visible:first input[type='radio']").attr("checked", true);
        	if(multi)bxl.getEmployee();
        	dwr.util.selectRange($("search"),0,50);
      	}
        
    });
    var currentradio;
   	var buts=jQuery("#identify,#close");
    jQuery("#sales_content").bind("keydown",function(event){
    	var todown=jQuery("#sales_content li:visible input:radio,#sales_content li:visible input:checkbox"); 
	      	    if(event.which==40){  
	      			   var index=0;
	      			   if(currentradio){
	      			   	index=todown.index(currentradio)+1;
	      			   } 	
				      	if(!todown[index]){
					        index=0;
				     		}
				     		if(multi)jQuery(todown[index]).focus();
				     		else jQuery(todown[index]).attr("checked", true);
				     		currentradio=todown[index];
				    }else if(event.which==9){
				    	  event.stopPropagation();
					      event.preventDefault();
					      if(!currentradio||buts.index(currentradio)!=0)
				     		currentradio=buts[0];
				     		else
				     		currentradio=buts[1]||buts[0];
				     		jQuery(currentradio).focus();
				    }else if(event.which==38){
					    var len=todown.length;
					    var index=0;
					    if(currentradio){
					    		index=todown.index(currentradio)-1;
					    }
			        if(index<0){
					      index=len-1;
						 	}	
						 	if(multi)jQuery(todown[index]).focus();
						 	else jQuery(todown[index]).attr("checked", true);
				     	currentradio=todown[index];
					 }else if(event.which==13){
					  	var s=currentradio;
					  	jQuery(s).attr("checked", true);
					  	bxl.getEmployee();
					}
	  });
	},
	//取消
	closeEmployee:function(){
	  bpos.killAlert("sales_content");
	},
	
	getEmployee:function(){   
	 var obj;
	 obj=document.getElementsByName("employee"); 
	
	 if(bpos.master_data.params.multiSalers=="true"){
	 	var multisalers=new Array();
	 }
	 var changeSale=false;
	 for(var i=0;i<obj.length;i++){
	  	if(obj[i].checked){
	  		var j= parseInt(obj[i].id.replace("employee-",""),10);
	  		if(bpos.master_data.params.multiSalers=="true"){
	  			multisalers.push(bpos.master_data.salers[j]);
	  		}else{
		  		bpos.master_data.saler.id=bpos.master_data.salers[j].id;
		  	  bpos.master_data.saler.name=bpos.master_data.salers[j].name;
		  		bpos.master_data.saler.truename=bpos.master_data.salers[j].truename;
		  		bpos.master_data.saler.dicountlmt=bpos.master_data.salers[j].discountlmt;
	  		}
	  		changeSale=true;
	  	}
 	  }
 	  bpos.master_data.multisalers=multisalers;
 	  if(this.linenoes.length>0) {
	  	for(var k=0;k<this.linenoes.length;k++) {
				var item=bpos.getitembylinenofromitems_data(this.linenoes[k]);
				if(bpos.master_data.params.multiSalers=="true"){
					item.multisalers=multisalers;
				}else{
					item.salerid=bpos.master_data.salers[j].id;
					item.saler=bpos.master_data.salers[j].name;
				}
				$("saler-"+this.linenoes[k]).innerHTML=bpos.getSalerTrueName(item.saler,item);
				bpos.clearchecked("from-main");
			}  			
	  }else {
  		//bpos.master_data.discountlimit=bpos.master_data.salers[i].discountlmt;
  		//跟新ACTIVEX中当前营业员Edit by Robin 2010-08-19
  		//bpos.exportaxtivexparams();
	    $("emp_name").innerHTML=bpos.master_data.saler.name+"("+bpos.master_data.saler.truename+")";  	
	    bpos.updateheaderhtml();	 
  	}
		bxl.closeEmployee();
		if(changeSale&&$("m_retail_idx").value)bpos.insertLine();
	},
		//设置成统一数量 
	unite:function(){
		var unite=document.getElementById("unite").value;	
		if(unite==""||unite==null){
			alert("数量为空");
			return;
		}
		//如果是数字，则设置为统一的数量
		else if(!isNaN(unite)&&unite==parseInt(unite)&&parseInt(unite)>0){
	   	var num=document.getElementsByName("TMPnum");
			for(var i=0;i<num.length;i++ ){
			  num[i].value=unite;	
			}
		}else{
				alert("填写格式不正确！");
		}
		this.sumNum();
	},
	//累计输入总和
	sumNum:function() {
		var num=document.getElementsByName("TMPnum");
		var sum=0,t;
		for(var i=0;i<num.length;i++ ){
			t=parseInt(num[i].value);
			if(t==num[i].value&&t>0)sum+=t;	
		}
		jQuery("#TMPsum").html(sum);
	},
	
	//批量录入的重置按钮
	rewrite:function(){
		 var num=document.getElementsByName("TMPnum");
		 document.getElementById("unite").value="";
		 for(var i=0;i<num.length;i++ ){
		 	num[i].value="";
		 }	
		 this.sumNum();
	},

  //单据查询
searchdocNo:function(){
	if(bpos.items_data.length>0){
		alert("尚有单据未处理，无法查询！");
		return;
	}
	var ele=Alerts.fireMessageBox({
	    width:800,
	    modal:true,
	    title:gMessageHolder.EDIT_MEASURE
	});
	ele.innerHTML="<div id=\"searchdoc_content\"><table width=\"800\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"> <tr><td><div id=\"treatment_td\">"+
    "<div id=\"treatment_text\">单据查询：</div></div></td></tr><tr><td bgcolor=\"#2d476a\" height=\"50\"><table width=\"760\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\"><tr>"+
    "<td width=\"80\"><div class=\"desc-txt\">单据号：</div></td><td width=\"135\"><input name=\"text\" id=\"docno\" type=\"text\" class=\"q_input_80\" /></td><td width=\"80\"><div class=\"desc-txt\">开始时间：</div></td>"+
    "<td width=\"135\"><input  name=\"text2\" id=\"datebeg\" type=\"text\" class=\"q_input_80\" value=\"\" onfocus=\"WdatePicker()\"/></td><td width=\"80\"><div class=\"desc-txt\">结束时间：</div></td>"+
    "<td width=\"135\"><input name=\"text3\" type=\"text\" id=\"dateend\" class=\"q_input_80\" value=\"\" onfocus=\"WdatePicker()\"/></td>"+
    "<td width=\"80\"><div class=\"desc-txt\">上传状态：</div></td><td width=\"100\"><select style=\"display:block\" id=\"upload\"><option value=\"1\" selected=\"selected\">上传</option><option value=\"0\">未上传</option>"+
    "&nbsp;</select></td><td width=\"50\"><input name=\"button\" type=\"button\" class=\"qinput\" id=\"searchdoc\" onclick=\"bxl.docNO()\" value=\"查询\"/></td>"+  
  	"</tr></table></td></tr><tr bgcolor=\"#2d476a\"><td><div bgcolor=\"#2d476a\"  class=\"search-table\"><table id=\"retaildoc\" border=\"0\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" style=\"background-color:#A3BAD4;visibility:visible;margin:0 auto; opacity: 1; overflow:auto; table-layout: fixed; width:1000px;\">"+
  	"<tr class=\"search-table-head\"><td width=\"50\" class=\"search-title\">序号</td><td width=\"150\" class=\"search-title\">单据号</td> <td width=\"65\" class=\"search-title\">日期</td><td width=\"65\" class=\"search-title\">总数量</td> <td width=\"65\" class=\"search-title\">总金额</td>"+
  	"<td width=\"50\" class=\"search-title\">VIP</td><td width=\"65\" class=\"search-title\">操作员</td> <td width=\"80\" class=\"search-title\">上传标记</td>"+
  	"<td width=\"210\" class=\"search-title\">备注</td> <td width=\"200\" class=\"search-title\">失败原因</td> </tr>"+
  	"</table></div></td></tr><tr bgcolor=\"#2d476a\"><td bgcolor=\"#2d476a\"><div bgcolor=\"#2d476a\" id=\"treatment_td_class\" align=\"center\"><div bgcolor=\"#2d476a\" id=\"treatment_text\"><input type=\"button\" value=\"打印\" id=\"printdoc\" onclick=\"javascript:bxl.print()\" class=\"qinput\" id=\"btn-search\"/>&nbsp;"+
  	"<input type=\"button\" id=\"showdoc\" value=\"查看\" onclick=\"javascript:bxl.showOrder()\" class=\"qinput\" id=\"btn-cancel\"/>&nbsp;<input id=\"closeSearch\" type=\"button\" class=\"qinput\" value=\"取消\" onclick=\"bxl.closeSearch()\"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span  width=\"150\" class=\"desc-txt\">金额合计:</span><span id=\"amt_total\">0</span>元&nbsp;,&nbsp;<span  width=\"150\" class=\"desc-txt\">数量合计:</span><span id=\"qty_total\">0</span>件</div></div></td></tr></td></tr></table></div>";    
        bpos.executeLoadedScript(ele);
        bpos.noAlert=false;
        jQuery("#docno").focus(); 	
        var input;	
        var inputs=jQuery("#docno,#datebeg,#dateend,#upload,#searchdoc,#printdoc,#showdoc,#closeSearch");
        jQuery("#searchdoc_content").bind("keydown",function(event){                
        if(event.which==13){
         	if(inputs.index(input)<4){	
         		 bxl.docNO();
         		 jQuery("#docno").focus();
         	
         		 //jQuery("#retaildoc  input").eq(0).attr("checked",true); 
         	}else{
         		 jQuery(input).dblclick();
         	}
        }else	if(event.which==39){//右
         		var index=0;
         		if(inputs.index(input)==-1){
         				index=inputs.index(input)+2;
         		}else{
         			index=inputs.index(input)+1;
         		}
         	 if(!inputs[index]){
         				index=0;
         	 }
         	 input=inputs[index];
         	 jQuery(input).focus();
       }else if(event.which==37){//左
         	 if(input){
         			index=inputs.index(input)-1;
         	 }
         	 if(!inputs[index]){
         			index=inputs.length-1;
         	 }
         	 input=inputs[index];
         	 jQuery(input).focus();
       }else if(event.which==9){//TAB
         	 event.stopPropagation();
				   event.preventDefault();
         	 var index=0;
         	 if(inputs.index(input)==-1){
         			index=inputs.index(input)+2;
         	 }else{
         			index=inputs.index(input)+1;
         	 }
         	 if(!inputs[index]){
         				index=0;
         	 }
         	 input=inputs[index];
         	 jQuery(input).focus();
       }
       
       
    }); 
	},
	//单据查询 取消
	closeSearch:function(){
		bpos.killAlert("searchdoc_content");	
	},
	
 checkIsDate:function(month,date,year){
   if(parseInt(month,10)>12||parseInt(month,10)<1||parseInt(date,10)>31||parseInt(date,10)<1||parseInt(year,10)<1980||parseInt(year,10)>3000) {
       return false;
   }
   return true;
 },
		//单据查询 查询
 docNO:function(){
   var orderno=jQuery.trim($("docno").value);
   var datebeg=jQuery.trim($("datebeg").value);
   var dateend=jQuery.trim($("dateend").value);
   var upload_state=jQuery.trim($("upload").value);
   jQuery("#searchdoc_content .search-table").html("");
   var param={};
      param.refno=orderno;
      param.datebeg=datebeg;
      param.dateend=dateend;
      param.upload_status=upload_state;
   var params={};
      params.param=param; 
   var ret=bpos.searchOrder(Object.toJSON(params));
   ret=ret.evalJSON();
   this.d=ret.NewDataSet;
   ret=ret.NewDataSet.Table;
   bxl.resultdoc(ret);
   
   //jQuery("#retaildoc input").find(":radio").eq(0).attr("checked")=true;
   //jQuery(this).find(":radio").attr("checked",true);
 },
  resultdoc:function(ret){ 
  	var amt_total=0; //金额合计
	  var qty_total=0;  //数量合计
		var str="<table id=\"retaildoc\"  border=\"0\" cellpadding=\"1\" cellspacing=\"1\" style=\"margin:auto;table-layout:fixed;visibility: visible; opacity: 1; overflow:auto; width:1100;\"><tr class=\"search-table-head\">"+
          "<td width=\"53\" class=\"search-title\">序号</td><td width=\"152\" class=\"search-title\">单据号</td> <td width=\"71\" class=\"search-title\">日期</td> <td width=\"50\" class=\"search-title\">总数量</td><td width=\"54\" class=\"search-title\">总金额</td>"+
          " <td width=\"48\" class=\"search-title\">VIP</td><td width=\"60\" class=\"search-title\">操作员</td><td width=\"67\" class=\"search-title\">上传标记</td><td width=\"80\" class=\"search-title\">备注</td><td width=\"148\" class=\"search-title\">失败原因</td></tr>"; 	
	 	    
		if(this.d.toString()==''){
			alert("没有您要查询的内容");
		}else{
			
			var arr=bpos.change2array(ret);
			this.docdata=arr;
			for(var i=0;i<arr.length;i++){	 
		     var upstatus="";//上传状态
				 var error_info="";//失败原因
				 var	vipid="";//vip信息
				 var record="";
				 if(arr[i].ERROR_INFO){
				  	error_info=arr[i].ERROR_INFO;
				 }else{
				  	error_info="无记录";
				 }
				 if(arr[i].UPLOAD_STATUS==0){
				  	upstatus="未上传";
				 }else if(arr[i].UPLOAD_STATUS==1){
				  	upstatus="已上传";
				 }
				 if(arr[i].VIPID==-1){
				  	vipid="无";
				 }else{
				  	vipid=(arr[i].JSON).evalJSON().param.vip_cardno;
				 } 						
				 if(arr[i].RECORD==""){
				  	record="无记录";
				 }else{
				  	record=arr[i].RECORD;
				 }
				 var j=i+1;
				 amt_total=amt_total.add(parseFloat(arr[i].TOTAMT));
				 qty_total+=parseInt(arr[i].TOTQTY,0);
				 str+="<tr "+(i%2==1?"class=\"search-conduct\"":"class=\"search-row\"")+"><td class=\"search-text\"><input   type=\"radio\" name=\"doc\"  id="+i+" />"+j+"</td><td class=\"search-text\">"+arr[i].ORDERNO+"</td><td class=\"search-text\">"+arr[i].BILLDATE+"</td><td class=\"search-textR\">"+arr[i].TOTQTY+"</td>"+
			  		  "<td class=\"search-textR\">"+bpos.alg(parseFloat(arr[i].TOTAMT),false)+"</td><td class=\"search-text\">"+vipid+"</td><td class=\"search-text\">"+arr[i].operatorname+"</td><td class=\"search-text\">"+upstatus+"</td><td class=\"search-text\">"+record+"</td><td class=\"search-text\">"+error_info+"</td></tr>";
			 
			}
		}
		str+="</table>";		
   
		jQuery("#searchdoc_content .search-table").html(str);	
		jQuery("#amt_total").html(amt_total==0?"0":amt_total);	
		jQuery("#qty_total").html(qty_total==0?"0":qty_total);
		jQuery("#searchdoc_content .search-table tr input:radio:visible").eq(0).attr("checked",true);
		jQuery("#searchdoc_content  .search-table tr").eq(1).addClass("search_c");
		
	
		jQuery("#searchdoc_content .search-table tr").click(function(){
			jQuery("#searchdoc_content .search-table tr").removeClass("search_c");
			jQuery(this).addClass("search_c");
			jQuery(this).find(":radio").attr("checked",true);
		
		});
		jQuery("#searchdoc_content .search-table tr").dblclick(function(){
			 bxl.showOrder();
		});	

		var radioes=jQuery("#searchdoc_content .search-table tr input:radio:visible");
		var radio_trs=jQuery("#searchdoc_content  .search-table tr");
		jQuery("#searchdoc_content").bind("keyup",function(event){
	
			bxl.stopDefault();
		  if(event.target==$("datebeg")||event.target==$("dateend")){
		  	 //alert("测试在开始时间和结束时间框内 不执行！");
		  	return;
		  }
		  
		  
			if(event.which==38){//上
				for(var jj=0;jj<radioes.length;jj++){
					if(radioes[jj].checked==true){						
						jQuery(radio_trs[jj+1]).removeClass("search_c");
						if(jj==0){
							radioes[radioes.length-1].checked=true;
             jQuery(radio_trs[radioes.length]).addClass("search_c");
						}else{
							radioes[jj-1].checked=true;
						 jQuery(radio_trs[jj]).addClass("search_c");
						}
						return;
					}
			  }				
			}else if(event.which==40){//下
				for(var jj=0;jj<radioes.length;jj++){
					if(radioes[jj].checked==true){
						//alert(radioes[jj]);
						jQuery(radio_trs[jj+1]).removeClass("search_c");
						if(jj==radioes.length-1){
							radioes[0].checked=true;
             jQuery(radio_trs[1]).addClass("search_c");
						}else{
							radioes[jj+1].checked=true;
						 jQuery(radio_trs[jj+2]).addClass("search_c");
						}
						return;
					}
			  } 
			}
			
		});
		
		
	},
	changeDetail:function(detail){
		//jQuery("#"+detail).parent().toggleClass("ui-tabs-selected");
		if(detail=="retailDetail"){
			jQuery("#retailDetail").parent().addClass("ui-tabs-selected");
			jQuery("#payDetail").parent().removeClass();
			jQuery("#id_showOrder").show();
			jQuery("#id_payDetail").hide();
			
		}else if(detail=="payDetail"){
			jQuery("#payDetail").parent().addClass("ui-tabs-selected");
			jQuery("#retailDetail").parent().removeClass();
			jQuery("#id_payDetail").show();
			jQuery("#id_showOrder").hide();
			}		
		
	},
	showOrder:function(){
		jQuery("#MainApp").hide();
		  var indx=0;
			var len=jQuery("#searchdoc_content .search-table input:checked");
			var drawDataHtml="<div id=\"whole_div\">";//零售和付款明细整体层			
			var payDetailHtml="";//付款明细
			if(len.length==0){
				alert("请选择需要查看的单据");
			}else{				
				bpos.init();
				drawDataHtml+="<ul class=\"ui-tabs-nav\">"+
														"<li onclick=\"bxl.changeDetail('retailDetail')\" class=\"ui-tabs-selected\"><a  style=\"cursor:pointer\" id=\"retailDetail\"><span>零售明细</span></a></li>"+
														"<li onclick=\"bxl.changeDetail('payDetail')\" class=\"\"><a  id=\"payDetail\" style=\"display:block;cursor:pointer\"><span>付款明细</span></a></li>"+
											"</ul>"
				//零售明细头界面
				drawDataHtml+="<div id=\"id_showOrder\" style=\"display:block\"><div class=\"from-table\"><div id=\"from-table\" class=\"from-table-head\">"   //零售头前
			              +bpos.initItemHeaderFirst()
			              +"</div></div><div id=\"from-main\" class=\"from-sidebar\" style=\"height: 292px; visibility: visible; opacity: 1;\"\>";	//零售头尾
				//付款明细头界面
				payDetailHtml+="<div id=\"id_payDetail\" style=\"display:none\"><div class=\"from-table\"><div id=\"from-table\" class=\"from-table-head\">"    //付款头前;
                     +"<div class=\"from-span-13\" style=\"align:center\">序号</div><div class=\"from-span-4\" style=\"align:center\">  付款方式</div><div class=\"from-span-4\" style=\"align:center\">付款金额</div><div class=\"from-span-4\" style=\"align:center\">实际付款</div><div class=\"from-span-41\" style=\"align:center\">备注</div>" 
                     +"</div></div><div id=\"from-main\" class=\"from-sidebar\" style=\"height: 292px; opacity: 1;\"\>";	//付款头尾
				var id=parseInt(len[0].id,10);
				//var id=parseInt(len[0].id.replace("/",""));
				var obj=this.docdata[id].JSON.evalJSON();
				var p=obj.param;				
			  for(var i=0;i<p.productno.length;i++){
					var lines={};			
					lines.productno=p.productno[i].toString();//条码
			  	lines.productvalue=p.productvalue[i]?p.productvalue[i]:"-";   //品名
					lines.colorname=p.colorname[i]?p.colorname[i].toString():"-";
					lines.sizename=p.sizename[i]?p.sizename[i].toString():"-";
					lines.color=p.color[i]?p.color[i].toString():"-";
					lines.size=p.size[i]?p.size[i].toString():"-";
					lines.mdim11=p.mdim11[i]?p.mdim11[i].toString():"-";
					lines.productname=p.productname[i]?p.productname[i].toString():"-";    
					lines.pricelist=parseFloat(p.pricelist[i]);
					lines.discount=parseFloat(p.discount[i]); //折扣
					lines.discription=p.description1[i].toString();//描述
					lines.priceactual=parseFloat(p.priceactual[i]);   
					lines.qty=parseInt(p.qty[i]);
			    lines.price=parseFloat(p.price[i]);  //应付价
					lines.salerid=(p.salerid1[i])?p.salerid1[i].toString():"";
					lines.saler=(p.saler[i])?p.saler[i].toString():"";
					lines.type=p.type[i].toString();
					lines.orgdocno=p.orgdocno[i].toString();
					lines.lineno=-1;
					lines.locked=p.locked?p.locked[i]:0;
					lines.lowest_discount=p.lowest_discount?p.lowest_discount[i]:0;
					lines.pda_id=p.m_pda_id[i].toString();//条码ID
					for(var j=1;j<=20;j++){
							eval("lines.m_dim"+j+"=p.m_dim"+j+"?p.m_dim"+j+":\"\";");
					}
					//bpos.updateitems_data2(lines);//原来逻辑
					indx+=1;
					var cn=indx%2==0?"conduct":"row";
					var type="";
					switch(parseInt(lines.type,10)){
						case 1:type="正常";break;
						case 2:type="退货";break;
						case 3:type="赠品";break;
						case 4:type="全额";break;
					}
					drawDataHtml+=bpos.ret_insertitem(indx,lines,type,cn,"showOrder");					
        }
      
			var pp=obj.param;
			var index2=0;
      for(var w=0;w<pp.paywayid.length;w++){
      	 //alert(this.get_payDetail(pp.paywayid[w]));
      	 var cnn=w%2==1?"conduct":"row";
      	 index2++;
       payDetailHtml+=this.get_payDetail(pp.paywayid[w],cnn,index2)+     
                      "<div class=\"from-span-4\">"+bpos.changenumber2yuan(pp.paymount[w])+"</div>"+
                          "<div class=\"from-span-4\">"+bpos.changenumber2yuan(pp.realpaymount[w]) +"</div>"+
                          "<div class=\"from-span-41\">"+(pp.discription2[w].strip()==-1?"":pp.discription2[w])+"</div></div></div>";
      }  
    var ele=Alerts.fireMessageBox({
	    width:1014, 
	    modal:true,
	    title:gMessageHolder.EDIT_MEASURE
		});
		drawDataHtml+="</div></div>";//零售明细
	  payDetailHtml+="</div></div>";//付款明细
		
	 	drawDataHtml+=payDetailHtml
		            +"</br><div align=\"center\"><input type=\"button\" id=\"btn_back\" class=\"showOrder_back\" value=\"返回\" onclick=\"javascript:bpos.killAlert2('id_showOrder')\"/></br></br></div>"
  
   ele.innerHTML=drawDataHtml;
    bpos.executeLoadedScript(ele);	    
    bpos.noAlert=false;	
    jQuery("#btn_back").focus();   
    var input;	
     var inputs=jQuery("#retailDetail,#payDetail");//0、1、2
    jQuery("#whole_div").bind("keydown",function(event){
        if(event.which==13){
	         		 bpos.killAlert2("id_showOrder");
	         	
        }else if(event.which==9){
           event.stopPropagation();
    	     event.preventDefault();
        	var idx=0;
        	//alert(event.which);
        	if(inputs.index(input)==-1){
         				idx=inputs.index(input)+2;
         		}else{
         			  idx=inputs.index(input)+1;
         		}
         	 if(!inputs[idx]){
         				idx=0;
         	 }
         	 input=inputs[idx];
         	 jQuery(input).focus();
        	
        	idx==0?bxl.changeDetail("retailDetail"):(idx==1?bxl.changeDetail("payDetail"):"");
        }else{
        		return false;
        }       
       });
    
    //jQuery("#id_showOrder input").hide();    
     //bpos.maxlineno=0;//全局变量        
      /**  jQuery("#column_23983").html(this.docdata[id].ORDERNO);  
				bpos.changeModel("SHOWMODEL");
        bpos.master_data.docno=this.docdata[id].ORDERNO;
        bpos.master_data.createTime=this.docdata[id].BILLDATE;
        jQuery("#sys_date").val(this.docdata[id].BILLDATE);
        var vip={};
        vip.vip_id=this.docdata[id].VIPID;
        vip.cardno=this.docdata[id].vip_cardno;
        bpos.vip=vip;
        bpos.updateheaderhtml();
				bxl.closeSearch();		**/			
		}
	},
	get_payDetail:function(pwid,cnn,index2){
		var payways=bpos.master_data.payways;
		var pDetail="<div class=\"from-"+cnn+"\"><div class=\"from-"+cnn+"-line\"><div class=\"from-span-13\">"+index2+"</div><div class=\"from-span-4\">  ";
		for(var k=0;k<payways.length;k++)
		{
			  if(pwid==payways[k].id) 
			   {
			   	pDetail+=payways[k].name;
			   	break;
			   }
		}		
		return pDetail+="</div>";
	},
			//打印
	print:function(){
		var len=jQuery("#searchdoc_content .search-table input:checked");
		if(len.length<1){
			alert("请选择需要打印的数据");
		}else{			
			var id=parseInt(len[0].id);
			//var id=parseInt(len[0].id.replace("/",""));
			var j=this.docdata[id].JSON.evalJSON();					
			var docno=j.param.refno;
			var param={"refno":docno};
			var info={};
			info.param=param;
			bpos.posprint(Object.toJSON(info));
		  bxl.closeSearch();
	 }		
  }
}	
BXL.main=function(){
	bxl=new BXL();	
}

jQuery(document).ready(BXL.main);

Array.prototype.contains = function(obj) {
    var i = this.length;
    while (i--) {
        if (this[i] === obj) {
            return true;
        }
    }
    return false;
}



