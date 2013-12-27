var mm;
var MonitorManager = Class.create();
// define constructor
MonitorManager.prototype = {
	initialize: function() {
		// init dwr
		dwr.util.useLoadingMessage(gMessageHolder.LOADING);
		dwr.util.setEscapeHtml(false);
		/** A function to call if something fails. */
		dwr.engine._errorHandler =  function(message, ex) {
	  		while(ex!=null && ex.cause!=null) ex=ex.cause;
	  		if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + ", " + ex.message+","+ ex.cause.message, true);
			if (message == null || message == "") msgbox("A server error has occured. More information may be available in the console.");
	  		else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
	  		else msgbox(message);
		};
		application.addEventListener( "Monitor_Delete", this._deleteMonitor, this);
		application.addEventListener( "LoadCxtabSearchForm", this._onLoadCxtabSearchForm, this);
		application.addEventListener( "ExecuteWebAction", this._onExecuteWebAction, this);
		
		this._tryUpdateTitle();
		this._tryAddCloseButton();
		this._monitor={};
		this._isActionCheck=false;// will reload listeners if true
		this._ATTACHTYPES={"csv":"CSV(逗号分隔文本)","pdf":"PDF","xls":"Excel", "cub":"Cube Viewer", "htm":"HTML网页","null":"无附件"};
		this._allowedAttachTypes=["csv","null"];
		if($("monitor_type")!=null)	this._monitorType=$("monitor_type").value;
		portalClient=new PortalClient();
		portalClient.init(null,null,"/servlets/binserv/Rest");
		portalClient.setLoadingDiv("loadingZone");
	},
	load_artjs:function(){
	  var oHead = document.getElementsByTagName('HEAD').item(0); 
    var oScript= document.createElement("script"); 
    oScript.type = "text/javascript"; 
    oScript.src="/html/nds/js/artDialog4/jquery.artDialog.js?skin=chrome"; 
    oHead.appendChild( oScript); 
    var oScript= document.createElement("script");  
    oScript.type = "text/javascript"; 
    oScript.src="/html/nds/js/artDialog4/plugins/iframeTools.js"; 
    oHead.appendChild( oScript); 
	},
	_onExecuteWebAction:function(e){
		var r=e.getUserData(); 
		if(r.message && r.code !=3 && r.code!=4 && r.code!=5){
			msgbox(r.message.replace(/<br>/g,"\n"));
		}
		//reload _isActionCheck information
		if(this._monitor.props.checkActions!=null)
			this._isActionCheck=this._monitor.props.checkActions[0]|| this._monitor.props.checkActions[1]||this._monitor.props.checkActions[2]||this._monitor.props.checkActions[3]||this._monitor.props.checkActions[6]|| this._monitor.props.checkActions[7];
		else this._isActionCheck=false;
	},	
	_tryAddCloseButton:function(){
		
		var w = window.opener;
		if(w==undefined)w= window.parent;
		var bCloseBtn=false;
		if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
				$("closebtn").innerHTML="<input class='cbutton' type='button' value='关闭"+
					"(C)' accessKey='C' onclick='mm.tryClose()' name='Close'>";
				bCloseBtn=true;	
			}
		}
		if(!bCloseBtn){
			if(self==top){
				$("closebtn").innerHTML="<input type='button' class='cbutton' value='关闭"+
					"(C)' accessKey='C' onclick='window.close()' name='Close'>";
			}
		}
	},
	loadMonitor:function(objId,props){
		this._monitor={id:objId,props:props};
		if(this._monitor.props==null)this._monitor.props={};
		if(this._monitor.props.msg==null) this._monitor.props.msg={};
		var op={escapeHtml:false};
		for (var property in this._monitor.props) {
			var e=$(property);
			if(e!=null)
			    dwr.util.setValue(e, this._monitor.props[property],op);
			//else console.log("property "+ property+" not found as element");
		}
		for (var property in this._monitor.props.msg) {
			var e=$(property);
			if(e!=null)
			    dwr.util.setValue(e, this._monitor.props.msg[property],op);
			//else console.log("property "+ property+" not found as element");
		}
		if(this._monitorType=="obj"){
			$("actionchk").checked=this._monitor.props.action!=null;
			
			if(this._monitor.props.checkActions!=null){
				//AC("ac",1), AM("am",2), BD("bd",3), BC("bc",4), BM("bm",5), 
		    	//SUBMIT("submit",6), UNSUBMIT("unsubmit",7), TASK("task",8), WEBACTION("action",0) 
				$("ac").checked= this._monitor.props.checkActions[1];
				$("am").checked= this._monitor.props.checkActions[2];
				$("bd").checked= this._monitor.props.checkActions[3];
				$("submit").checked= this._monitor.props.checkActions[6];
				$("unsubmit").checked= this._monitor.props.checkActions[7];
				$("auditing").checked= this._monitor.props.checkActions[9];
				$("reject").checked= this._monitor.props.checkActions[10];
				
				this._isActionCheck=this._monitor.props.checkActions[0]|| this._monitor.props.checkActions[1]||
				this._monitor.props.checkActions[2]||this._monitor.props.checkActions[3]||
				this._monitor.props.checkActions[6]|| this._monitor.props.checkActions[7]||
				this._monitor.props.checkActions[9]|| this._monitor.props.checkActions[10];
			}
			if(this._monitor.props.checkWebActionIds!=null && this._monitor.props.checkWebActionIds.length>0){
				for(var i=0;i< this._monitor.props.checkWebActionIds.length;i++){
					$("wa"+ this._monitor.props.checkWebActionIds[i]).checked=true;
				}
				this._isActionCheck=true;
			}
			$("byaction").checked=(this._monitor.props.ad_queue_id==null);
			$("byperiod").checked=(this._monitor.props.ad_queue_id!=null);
			this.checktypeChanged();
			
		}else{
			$("listType_cxtab").checked=(this._monitor.props.listType=="cxtab" || this._monitor.props.listType==null);
			$("listType_sql").checked=(this._monitor.props.listType=="sql");
			this.listTypeChanged();
			this.cxtabRunAsChanged();
			if(this._monitor.props.attachTypes!=null && this._monitor.props.attachTypes.length>0){
				this._allowedAttachTypes=this._monitor.props.attachTypes;
				this.updateAttachTypes();
			}
		}
		$("exectimeType_wait").checked=( this._monitor.props.exectimeType=="wait" || this._monitor.props.exectimeType==null);
		$("exectimeType_spec").checked=( this._monitor.props.exectimeType=="spec");
		$("isactive").checked= (this._monitor.props.isactive=="Y" ||this._monitor.props.isactive==null);
		$("fk_ad_queue_name").value= (this._monitor.props.ad_queue_id==null?"":""+this._monitor.props.ad_queue_id);
		this.initRecipients();
		
	},
	initRecipients:function(){
		var i,clz;var s="";
		var rto= this._monitor.props.msg.recipient_to;
		if(rto!=null && rto.length>0)for(i=0;i<rto.length;i++){
			clz=(i%2)==0?"even":"odd";
			s+="<li class='"+clz+"' onclick='mm.chkRecItem(event)' onmouseover='mm.chkRecOver(event)' onmouseout='mm.chkRecOut(event)'><input type='checkbox'/>"+ (rto[i].description==null?"":rto[i].description)
			+"</li>";
		}
		$("recul_to").innerHTML=s;
		rto= this._monitor.props.msg.recipient_cc;
		s="";
		if(rto!=null && rto.length>0)for(i=0;i<rto.length;i++){
			clz=(i%2)==0?"even":"odd";
			s+="<li class='"+clz+"' onclick='mm.chkRecItem(event)' onmouseover='mm.chkRecOver(event)' onmouseout='mm.chkRecOut(event)'><input type='checkbox'/>"+ (rto[i].description==null?"":rto[i].description)
			+"</li>";
		}
		$("recul_cc").innerHTML=s;
		
	},
	toggleNote:function(nid){
		$(nid).toggle();
	},
	_tryUpdateTitle:function(){
		var w = window.opener;
		if(w==undefined)w= window.parent;
		if (w ){
			var te=w.document.getElementById("pop-up-title-0");
			if(te){
				te.innerHTML=document.title;
			}
		}
	},
	newMontior:function(){
		window.location="/html/nds/monitor/new.jsp?table="+$("table").value;
	},
	newtype:function(t){
		var tid=$("fk_column_42866").value;
		if(tid.blank()){
			alert("请选择好要监控的表再确定监控类型");
			eval($("cbt_42866").getAttribute("onaction"));
			return;
		}
		window.location="/html/nds/monitor/"+t+".jsp?table="+tid;
	},
	/**
	@param mid ad_monitor.id
	*/
	modify:function(mid){
		window.location="/html/nds/monitor/monitor.jsp?id="+ mid;
	},
	/**Reload current page
	*/
	_deleteMonitor:function(e){
		var chkResult=e.getUserData(); // data
		if(chkResult.message!=null)msgbox(chkResult.message);
		if(chkResult.code==0){
			window.location="/html/nds/monitor/monitors.jsp?table="+$("table").value;
		}
	},
	del:function(mid){
		if(confirm("你确认要删除此监控器吗？")){
			var evt={};
			evt.command="nds.monitor.ext.DeleteMonitor";
			evt.callbackEvent="Monitor_Delete";
			evt.monitorId=mid;
			this._executeCommandEvent(evt);	
		}
	},
	checktypeChanged:function(){
		if($("byaction").checked){
			$("div_byaction").style.visibility ="visible";
			$("div_bypeirod").style.visibility ="hidden";
			$("ad_queue_name").value="";
		}else{
			$("div_byaction").style.visibility ="hidden";
			$("div_bypeirod").style.visibility ="visible";
		}
	},
	listTypeChanged:function(){
		if($("listType_cxtab").checked){
			$("div_cxtab").show();
			$("div_sql").hide();
			this.updateAttachTypes();
		}else{
			$("div_cxtab").hide();
			$("div_sql").show();
			$("attachType").options.length=0;
			$("attachType").options[0]=new Option(this._ATTACHTYPES["csv"],"csv");
			$("attachType").options[1]=new Option(this._ATTACHTYPES["null"],"null");
		}	
	},
	cxtabRunAsChanged:function(){
		if($("cxtabRunAsType")==null){
			return;
		}
		if($("cxtabRunAsType").value=="user"){
			$("runasuser").show();
		}else
			$("runasuser").hide();
	},
	/**
	 Only for reports
	*/
	setAttachTypes:function(arr){
		this._allowedAttachTypes=arr;
	},
	updateAttachTypes:function(){
		$("attachType").options.length=0;
		for(var i=0;i<this._allowedAttachTypes.length;i++){
			$("attachType").options[i]=new Option(this._ATTACHTYPES[this._allowedAttachTypes[i]],
				this._allowedAttachTypes[i]);
			if(this._monitor.props.attachType!=null && this._monitor.props.attachType==this._allowedAttachTypes[i])
				$("attachType").options[i].selected=true;
		}
	},
	selectBodyTemplate:function(){
		
	},
	switchBody:function(){
		$("div_body_text").toggle();
		$("div_body_html").toggle();
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
	runNow:function(){
		if(this._monitor.id>0){
			if(this._monitor.props.ad_queue_id==null){
				alert("仅支持周期运行的监控器");
				return;
			}
			var params={id:this._monitor.id,"nds.control.ejb.UserTransaction":"N",parsejson:"N"};
	    	var trans={id:1, command:"nds.monitor.ext.ExecuteMonitor",params:params};
    		var a=new Array(1);
			a[0]=trans;
			portalClient.sendRequest(a, function(response){
					if(!mm.checkResponse(response,0))return;
					alert(response.data[0].message);
				}
			);
		}else{
			alert("请先保存");
			return;
		}
	},
	_onLoadCxtabSearchForm:function(e){
		//var div=$("cxtab_content");
		/*
		var div = Alerts.fireMessageBox({
						width: 790,modal:true,noCenter: true,title: "设置报表条件",
						maxButton:false,closeButton:false
					});*/	
		//div.innerHTML=e.getUserData().pagecontent;
		//executeLoadedScript(div);
		var options=$H({id:"cxtab_content",padding: 0,width:790,height:'auto',left: '25%',top:'top',title:"设置报表条件",skin:'chrome',drag:true,lock:true,esc:true,effect:false,queryindex:1});
	  options.content=e.getUserData().pagecontent;
	  var par=art.dialog(options);
		var op={escapeHtml:false};
		var div=$("rpt-search");
		for (var property in this._monitor.props.cxtabConditionInput) {
			var ex=div.getElementsBySelector('input[name="'+ property +'"]');
			if(ex==null|| ex.length==0)ex=div.getElementsBySelector('select[name="'+ property +'"]');
			if(ex!=null && ex.length>0){
				var v= this._monitor.props.cxtabConditionInput[property];
				if(v==null) v="";
			    dwr.util.setValue(ex[0],v,op);
			    //fix fk input
			    if(!v.blank()){
			    	if( $(ex[0].id+"_sql")!=null && $(ex[0].id+"_filter")!=null){
			    		var vsql=this._monitor.props.cxtabConditionInput[property+"/sql"];
			    		if(vsql!=null && !vsql.blank()){
			    		try{
			    			ex[0].readOnly=true;
							$(ex[0].id+ "_img").src="/html/nds/images/clear.gif";
							$(ex[0].id+ "_link").title="clear";
							$(ex[0].id+ "_img").alt="clear";
						}catch(ex){}	
						}
			    	}
			    }
			}
		}
		if($("listType_cxtab").checked){
			this.updateAttachTypes();
		}
	},

	cxtabFormConfirmed:function(){
		var cxtabId;
		if($("cxtabId")!=null) cxtabId=parseInt($("cxtabId").value);
		
		var params={cxtab:cxtabId, cxtabInput:$("list_query_form").serialize(true),
			"nds.control.ejb.UserTransaction":"N",parsejson:"N"};
	    var trans={id:1, command:"nds.monitor.ext.ReturnCxtabCondition",params:params};
    	var a=new Array(1);
		a[0]=trans;
		portalClient.sendRequest(a, function(response){
			if(!mm.checkResponse(response,0))return;
			$("cxtabConditionDesc").value=response.data[0].cxtabConditionDesc;
			mm._monitor.props.cxtabConditionInput=params.cxtabInput;
			art.dialog.list["cxtab_content"].close();
			//Alerts.killAlert();
		});
	},
	cxtabFormCanceled:function(){
		//Alerts.killAlert();
		art.dialog.list["cxtab_content"].close();
	},
	/**
	User changed cxtab selection
	*/
	setCxtabCondition:function(){
		var cxtabId;
		if($("cxtabId")!=null) cxtabId=parseInt($("cxtabId").value);
		if(isNaN(cxtabId)|| cxtabId<=0){
			alert("请首先选择报表模板");
			return;
		}
		//$("cxtab_content").innerHTML="正在加载，请等待...";
		var evt={};
		evt.command="LoadPage";
		evt["nds.control.ejb.UserTransaction"]="N";
		evt.callbackEvent="LoadCxtabSearchForm";
		var params={cxtab:cxtabId};
		evt.url="/html/nds/monitor/cxtab_search.jsp";
		evt.queryParams=params;
		this._executeCommandEvent(evt);
	},
	clearCondition:function(){
		var m= this._monitor.props;
		$("condition").value="";
		$("condition_desc").value="";
		$("condition_sql").value="";
		m.condition=null;
		m.condition_desc=null;
		m.condition_sql=null;
		
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
	monitor object to save
	isSaveAs boolean true means monitor is different with this._monitor
	*/
	_save:function(monitor,isSaveAs){
		if(monitor.id>0){
			//modify
			portalClient.modifyObject("ad_monitor",monitor, function(response){
					if(!mm.checkResponse(response,0))return;
					alert("保存成功");
					mm.checkReload();
				}
			);
		}else{
			portalClient.createObject("ad_monitor",monitor, function(response){
					if(!mm.checkResponse(response,0))return;
					alert("保存成功");
					if(!isSaveAs) mm._monitor.id=response.data[0].objectid;
					mm.checkReload();
				}
			);		
		}
	},
	/**
	 check reload listners or not
	*/
	checkReload:function(){
		if(this._monitor.check_type=='action' || this._isActionCheck){
			if(confirm("是否立刻重载当前监控器?(即时监控器需驻留内存，此动作也会在重载元数据定义时自动进行)")){
				var evt={};
				evt.webaction= "ad_monitor_reload";
				evt.objectid= this._monitor.id;
				evt.command="ExecuteWebAction";
				evt.query={};
				evt.callbackEvent="ExecuteWebAction";
				this._executeCommandEvent(evt);	
			}
		}
	},
	doSave:function(){
		if(this._updateMonitor()) this._save(this._monitor, false);
	},
	/**
	save ui input to inner data model
	 @return true for ok, false for error found
	*/
	_updateMonitor:function(){
		var m=this._monitor.props;
		m.ad_table_id=parseInt($("table").value);
		m.name=$("name").value;
		if(m.name.blank()){
			alert("必须输入名称");
			return false;	
		}
		if($("chkEmptyAttach")!=null)m.chkEmptyAttach=$("chkEmptyAttach").checked;
		m.priorityRule=$("priorityRule").value;
		m.send_sms=$("send_sms").checked;
		m.send_sms2=$("send_sms2").checked;
		m.send_mail=$("send_mail").checked;
		m.send_notice=$("send_notice").checked;
		m.send_chat=$("send_chat").checked;
		m.msg.subject=$("subject").value;
		m.msg.body_text=$("body_text").value;
		m.msg.body_html=FCKeditorAPI.GetInstance("body_html").GetHTML();

		if(m.send_sms|| m.send_sms2||m.send_mail||m.send_notice||m.send_chat){
			if( m.msg.recipient_to==null || m.msg.recipient_to.length==0){
				alert("发送信息时需至少配置一个接收人");
				return false;
			}
			if( (m.send_sms|| m.send_sms2) && ( m.msg.body_text==null||m.msg.body_text.blank())){
				alert("发送短信时需配置文本内容");
				return false;
			}
			if( (m.send_mail||m.send_notice) && ( (m.msg.subject==null||m.msg.subject.blank()) 
					|| ( ( m.msg.body_text==null||m.msg.body_text.blank()) 
					&& (m.msg.body_html==null||m.msg.body_html.blank()) ))){
				alert("发送邮件或系统通知时需配置主题和文本内容或HMTL内容");
				return false;
			}
		}
		if(this._monitorType=="obj"){
			if($("actionchk").checked) m.action=$("action").getValue();
			else m.action=null;
			if($("condition").value=="" && $("byperiod").checked ){
				alert("周期性检查时必须设置监控条件，匹配的记录数越多，每次处理时间必定越长");
				return false;
			}
			if($("byaction").checked){
				//AC("ac",1), AM("am",2), BD("bd",3), BC("bc",4), BM("bm",5), 
		    	//SUBMIT("submit",6), UNSUBMIT("unsubmit",7), TASK("task",8), WEBACTION("action",0) 
				m.checkActions=[false, $("ac").checked, $("am").checked,$("bd").checked,
					false,false,$("submit").checked,$("unsubmit").checked,false,$("auditing").checked,$("reject").checked];
		    	var eles=$("div_byaction").getElementsBySelector("input[title='webaction']");
		    	if(eles!=null&&eles.length>0){
		    		m.checkWebActionIds=[];
		    		for(var i=0;i<eles.length;i++) if(eles[i].checked) m.checkWebActionIds.push(parseInt(eles[i].name));
		    		if(m.checkWebActionIds.length>0)m.checkActions[0]=true;
		    	}
		    	
		    	if(!(this._monitor.props.checkActions[0]|| this._monitor.props.checkActions[1]||
		    	this._monitor.props.checkActions[2]||this._monitor.props.checkActions[3]||
		    	this._monitor.props.checkActions[4]||this._monitor.props.checkActions[5]|| 
		    	this._monitor.props.checkActions[6]||this._monitor.props.checkActions[7]|| 
		    	this._monitor.props.checkActions[9]||this._monitor.props.checkActions[10])){
		    		alert("至少选择一个即时触发动作");
		    		return false;	
		    	}
			}else{
				 m.checkActions=null;
				 m.checkWebActionIds=null;
			}
			
			if($("byperiod").checked){
				if($("ad_queue_name").value.blank() || $("fk_ad_queue_name").value.blank()){
					alert("请设置周期性检查对应的任务队列");
					return false;
				}
				m.ad_queue_name=$("ad_queue_name").value;
				m.ad_queue_id= parseInt($("fk_ad_queue_name").value);//parseInt($("div_bypeirod").getElementsBySelector('input[name="ad_queue_id"]')[0].value);
				
			}else{
				m.ad_queue_name=null;
				m.ad_queue_id=null;
			}
			m.preTrigger=$("preTrigger").value;
			m.postTrigger=$("postTrigger").value;
			m.ctrlDuplicate=parseInt($("ctrlDuplicate").value);
			if(m.ctrlDuplicate==NaN){
				alert("请用数字填写重复控制小时数,填0表示不做控制");
				$("ctrlDuplicate").value="0";
				return false;
			}
			m.printTemplate=$("printTemplate").getValue();
			m.printFileType=$("printFileType").getValue();
		}else{
			m.ad_queue_name=$("ad_queue_name").value;
			if($("ad_queue_name").value.blank() || $("fk_ad_queue_name").value.blank()){
				alert("请设置检查周期");
				return false;
			}
			m.ad_queue_id=parseInt($("queutd").getElementsBySelector('input[name="ad_queue_id"]')[0].value);
			
			m.listSQL= $("listSQL").value;
			m.listType=($("listType_cxtab").checked?"cxtab":"sql");
			if(m.listType=="sql" && m.listSQL.blank()){
				alert("请输入SQL 语句内容");
				return false;
			}
			m.attachTypes=this._allowedAttachTypes;
			m.attachType= $("attachType").value;
			if(m.listType=="cxtab"){
				//var cxo={param_str:$("list_query_form").serialize(), table:m.ad_table_id,qlcid:-1};
				//m.cxtabCondition=cxo;
				//m.cxtabConditionInput=$("list_query_form").serialize(true);
				m.cxtabRunAsType= $("cxtabRunAsType").value;
				m.cxtabRunAsUser= $("cxtabRunAsUser").value;
				m.cxtabId=parseInt($("cxtabId").value);
				m.cxtabName=$("cxtabName").value;
				if(m.cxtabId==NaN){
					alert("请选择报表");
					return false;
				}
				if(m.cxtabRunAsType=="user" && m.cxtabRunAsUser.blank()){
					alert("请设置报表运行身份的用户名");
					return false;
				}
				m.cxtabConditionDesc=$("cxtabConditionDesc").value;
				if(m.cxtabConditionInput==null){
					if(!confirm("未设置任何报表查询条件，你确认仍然保存吗？")) return false;
				}
			}else{
				m.cxtabConditionDesc=null;
				//m.cxtabCondition=null;
				m.cxtabConditionInput=null;
				m.cxtabRunAsType= null;
				m.cxtabRunAsUser=null;
				m.cxtabId=-1;
				m.cxtabName=null; 
				if(m.attachType!="csv" && m.attachType!="null"){
					alert("SQL语句不支持附件格式:"+m.attachType);
					$("attachType").value="csv";
					return false;
				}
			}
		}
		m.condition=$("condition").value;
		m.condition_desc=$("condition_desc").value;
		m.condition_sql=$("condition_sql").value;
		if($("exectimeType_wait").checked) m.exectimeType="wait";
		else m.exectimeType="spec";
		m.waitTime=parseInt($("waitTime").value);
		if(m.waitTime==NaN || m.waitTime<0){
			alert("发送时间的等待分钟数必须为正数, 请重新输入");
			$("waitTime").value="0";
			$("waitTime").focus();
			return false;
		}
		m.specHour=parseInt($("specHour").value);
		if(m.specHour==NaN || m.specHour>23 || m.specHour<0){
			alert("发送时间的小时数必须在0~23之间, 请重新输入");
			$("specHour").value="0";
			$("specHour").focus();
			return false;
		}
		m.specMinute=parseInt($("specMinute").value);
		if(m.specMinute==NaN || m.specMinute>59 || m.specMinute<0){
			alert("发送时间的分钟数必须在0~59之间, 请重新输入");
			$("specMinute").value="0";
			$("specMinute").focus();
			return false;
		}
		m.isactive=($("isactive").checked?"Y":"N");
		
		this._monitor.ad_table_id= m.ad_table_id;
		this._monitor.name=m.name;
		this._monitor.monitor_type=this._monitorType;
		this._monitor.check_type=(m.ad_queue_id==null?"action":"period");
		this._monitor.ad_queue_id= m.ad_queue_id;
		this._monitor.ad_queue_id__name= m.ad_queue_name;
		this._monitor.isactive=m.isactive;
		
		return true;
		
	},
	saveAsNow:function(){
		if(!this._updateMonitor()) return;
		var saveAsName=$("saveasname").value;
		if(saveAsName.blank()){
			alert("请输入另存为的名称");
			return;
		}
		//Alerts.killAlert($("dlg_saveas_content"));
		//save as a new monitor
		art.dialog.list["SaveAsDlg"].close();
		var m=Object.clone( this._monitor);
		m.id=-1;
		m.name=saveAsName;
		m.props.name=saveAsName;
		this._save(m, true);
	},
	saveNameKeyDown:function(event){
		if (!event) event = window.event;
		if (!(event && event.keyCode && event.keyCode == 13)) {
			return true;
		}
		this.saveAsNow();
	},
	showSaveAsDlg:function(){
		/*
		var ele = Alerts.fireMessageBox({
					width: 550,modal: true,title: "另存为"
				});
		ele.innerHTML= $("dlg_saveas").innerHTML.replace(/TMPL/g,"");
		*/
		var options=$H({id:"SaveAsDlg",padding: 0,width:417,height:'auto',left: '25%',top:'top',title:"设置报表条件",skin:'chrome',drag:true,lock:true,esc:true,effect:false});
	  options.content=$("dlg_saveas").innerHTML.replace(/TMPL/g,"");
	  var par=art.dialog(options);		
		$("saveasname").value=$("name").value+"#1";
		$("saveasname").focus();
		dwr.util.selectRange($("saveasname"), 0, 255);
		//executeLoadedScript(ele);
	},
	setCondition:function(){
		//updateCondition is global function
		var toggle_url="/html/nds/query/search.jsp?table="+$("table").value+"&return_type=a&accepter_id=updateCondition";
		oq.toggle_m(toggle_url,"updateCondition");
	},
	updateCondition:function(filter){
		$("condition_desc").value=filter.description;
		$("condition").value=filter.expression;
		$("condition_sql").value=filter.sql;
	},
	/**
	@param filter: {id:xx, ak:xx}
	*/
	updateCxtabId:function(filter){
		var isChanged= ($("cxtabId").value!=filter.id);
		$("cxtabId").value=filter.id;
		$("cxtabName").value=filter.ak;
		if(isChanged){
			$("cxtabConditionDesc").value="";
			this._monitor.props.cxtabConditionInput=null;
			this.setCxtabCondition();
		}
	},
	/**
	@param type "cc" or "to"
	*/
	addRecipient:function(t){
		//appendRec_cc/appendRec_to is global function
		var toggle_url="/html/nds/query/search.jsp?table=u_recipient&return_type=a&accepter_id=appendRec_"+t;
		oq.toggle_m(toggle_url,"appendRec_"+t);
	},
	appendRec:function(t,filter){
		var ul= $("recul_"+ t);
		var recArray=this._monitor.props.msg["recipient_"+t];
		if(recArray==null){
			recArray=new Array(filter);
			this._monitor.props.msg["recipient_"+t]=recArray;
		}else{
			recArray.push(filter);
		}
		var li = document.createElement('li');
		li.setAttribute('class',(recArray.length-1)%2==0?"even":"odd");
		li.setAttribute('onclick',"mm.chkRecItem(event)");
		li.setAttribute('onmouseover',"mm.chkRecOver(event)");
		li.setAttribute('onmouseout',"mm.chkRecOut(event)");
		var chk= document.createElement('input');
		//chk.setAttribute('id',t+"_"+(recArray.length-1));
		chk.setAttribute('type',"checkbox");
		li.appendChild(chk);
		li.appendChild(document.createTextNode(filter.description));
		ul.appendChild(li); 
	},
	chkRecOver:function(event){
		var elt = Event.element(event);
		if(elt!=null){
			if(!elt.hasClassName("udline"))elt.toggleClassName("udline");
		}
	},
	chkRecOut:function(event){
		var elt = Event.element(event);
		if(elt!=null){
			if(elt.hasClassName("udline"))elt.toggleClassName("udline");
		}
	},
	chkRecItem:function(event){
		var elt = Event.element(event);
		if(elt!=null){
			var chk=elt.down("input[type='checkbox']");
			if(chk!=null) chk.checked=!chk.checked;
		}
	},
	/**
	@param type "cc" or "to"
	*/
	delRecipient:function(t){
		var i,ele;
		var ul= $("recul_"+ t);
		var recArray=this._monitor.props.msg["recipient_"+t];
		if(recArray==null) return;
		var lis=ul.immediateDescendants();
		for(i=lis.length-1;i>=0;i--){
			if(lis[i].down("input[type='checkbox']").checked){
				lis[i].remove();
				recArray.splice(i,1);	
			}
		}
	},
	/**
	* Request server handle command event
	* @param evt CommandEvent
	*/
	_executeCommandEvent :function (evt) {
		Controller.handle( Object.toJSON(evt), function(r){
				//try{
					var result= r.evalJSON();
					if (result.code !=0 ){
						msgbox(result.message);
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
	tryClose:function(){
    	var w = window.opener;
    	if(w==undefined)w= window.parent;
    	if (w ){
			var iframe=w.document.getElementById("popup-iframe-0");
			if(iframe){
				   
	    		//w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'));",1);
			   var list = w.art.dialog.list;
					for (var i in list) {
		   			 list[i].close();
					};
	    		return;
    		}
    	}
    	window.close();
    }	
};
MonitorManager.main = function () {
	mm=new MonitorManager();
};
function appendRec_cc(filter){
	mm.appendRec("cc",filter);		
}
function appendRec_to(filter){
	mm.appendRec("to",filter);		
}
function updateCondition(filter){
	mm.updateCondition(filter);
}
function updateCxtabId(filter){
	mm.updateCxtabId(filter);	
}

function showObject(url, theWidth, theHeight,option){
	if( theWidth==undefined || theWidth==null) theWidth=956;
    if( theHeight==undefined|| theHeight==null) theHeight=570;
	//var options={width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE, modal:true,centerMode:"x",noCenter:true,maxButton:true};
    /*
    if(option!=undefined) 
    	Object.extend(options, option);
	Alerts.popupIframe(url,options);
	Alerts.resizeIframe(options);
	Alerts.center();*/
   var options=$H({width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE,skin:'aero',ifrid:'popup-iframe-0',drag:true,resize:true,lock:true,esc:true,skin:'chrome',ispop:true});
    if(option!=undefined)Object.extend(options, option);
    art.dialog.open(url,options);
}
function msgbox(msg, title, boxType ) {
	alert(msg);
}
/**
* Show table object info
*/
function dlgo(tableId, objId){
	popup_window("/html/nds/object/object.jsp?table="+tableId+"&id="+objId);
}

function executeLoadedScript(el) {
	var scripts = el.getElementsByTagName("script"); // to enable all scripts, el must be set in table
	for (var i = 0; i < scripts.length; i++) {
		if (scripts[i].src) {
			var head = document.getElementsByTagName("head")[0];
			var scriptObj = document.createElement("script");

			scriptObj.setAttribute("type", "text/javascript");
			scriptObj.setAttribute("src", scripts[i].src);

			head.appendChild(scriptObj);
		}
		else {
			//try {
				if (is_safari) {
					eval(scripts[i].innerHTML);
				}
				else if (is_mozilla) {
					eval(scripts[i].textContent);
				}
				else {
					eval(scripts[i].text);
				}
			/*}
			catch (e) {
				alert(e);
			}*/
		}
	}
}
