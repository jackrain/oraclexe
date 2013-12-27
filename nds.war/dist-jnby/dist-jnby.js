var dist=null;
var DIST=Class.create();
DIST.prototype={
    initialize: function() {
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        dwr.util.setEscapeHtml(false);
        this.allot_id=null;
        this.range=20;//分页显示行数，初始为20
        
        this.refresh_param();

        /** A function to call if something fails. */
        dwr.engine._errorHandler =  function(message, ex) {
            while(ex!=null && ex.cause!=null) ex=ex.cause;
            if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + "," + ex.message+","+ ex.cause.message, true);
            if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
            else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
            else alert(message);
        };
        application.addEventListener( "DO_QUERY", this._onLoadMetrix, this);
        application.addEventListener("FUND_BALANCE",this._onfundQuery,this);
        application.addEventListener("DO_SAVE",this._onsaveDate,this);
        application.addEventListener("RELOAD",this._onreShow,this);
        application.addEventListener("SHOW_ITEM",this._showitem,this);
    },
    showitem:function(){
    	var evt={};   	
      evt.command="DBJSONXML";
     	evt.callbackEvent="SHOW_ITEM";
      var w=window.parent;
      if(!w)w=window.opener;
      var m_allot_id=w.document.getElementById("fund_balance").value||"-1";
      var param={"m_allot_id":m_allot_id};
      evt.param=Object.toJSON(param);
      evt.table="m_allot";
      evt.action = "STOREJNBY";
      evt.permission="r";
      this._executeCommandEvent(evt);
    },
    _showitem:function(e){
  	  dwr.util.useLoadingMessage(gMessageHolder.LOADING);
      var data=e.getUserData();
      var ret=data.jsonResult.evalJSON();
      //alert(Object.toJSON(ret));
      /*
      var items=new Array();
      if(ret.data.length&&ret.data.length>1){
      	items=ret.data;
      }else{
      	items[0]=ret.data;
      }*/
      var str="";
      if(this.checkIsArray(ret.NAME)){
	      for(var i=0;i<ret.NAME.length;i++){
	      	var dtydoc=parseInt(ret.QTYDOC[i],10);
	      	dtydoc=isNaN(dtydoc)?0:dtydoc;
	      	var dtyrem=parseInt(ret.QTYREM[i],10);
	      	dtyrem=isNaN(dtyrem)?0:dtyrem;
	      	str+="<div class=\"mingxi-sidebar row\"><div class=\"row-line\">"+
							 "<div class=\"span-20\">"+(ret.C_STORE[i]||"无")+"</div>"+
							 "<div class=\"span-21\">"+dtydoc+"</div>"+
							 "<div class=\"span-21\">"+(dtydoc-dtyrem)+"</div>"+
							 "<div class=\"span-21\">"+dtyrem+"</div>"+
							 "<div class=\"span-22\">"+(ret.QTYALLOT[i]||0)+"</div></div></div>";
	      }
	    }else{
	    	var dtydoc=parseInt(ret.QTYDOC,10);
      	dtydoc=isNaN(dtydoc)?0:dtydoc;
      	var dtyrem=parseInt(ret.QTYREM,10);
      	dtyrem=isNaN(dtyrem)?0:dtyrem;
      	str+="<div class=\"mingxi-sidebar row\"><div class=\"row-line\">"+
						 "<div class=\"span-20\">"+(ret.C_STORE||"无")+"</div>"+
						 "<div class=\"span-21\">"+dtydoc+"</div>"+
						 "<div class=\"span-21\">"+(dtydoc-dtyrem)+"</div>"+
						 "<div class=\"span-21\">"+dtyrem+"</div>"+
						 "<div class=\"span-22\">"+(ret.QTYALLOT||0)+"</div></div></div>";
	    }
      jQuery("#mingxi-main").html(str);
      //this.sum_dist_item(items);
    },
    refresh_param:function(){
    	this.cell_data=new Array();
      this.status=0;
      //this.loadStatus="load";
      this.ylen=0;
  	  this.data=new Array();//按店仓排序数据
			
			this.cell_data_index={};//为“单元数量”专门建立的索引JSON
      this.dataForQtyCan=new Array();//所有可配量数组
      this.dataForQtyCan_index={};//为“所有可配量数组”专门建立的索引JSON
      this.barcodeQtyAl={};
      this.docNoes=new Array();
      this.totQtyRem=0;//总订单量
      this.totQtyAl=0;//总配货量
      this.start=0;
      this.end=this.range-1;
      this.qtyaddnows={};//当前放量可配
      this.totremarea={};
    },
    queryObject: function(style){ 
    		this.refresh_param();
    	  var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="DO_QUERY";
        var load_type=$("load_type").value;
        var reg=/^\d{8}$/;
        var m_allot_id=$("fund_balance").value||"-1";
        //var isstore=jQuery("#model").is(":checked")?;
       
        var doctype=$("column_26991").value;
        if(!doctype){
            alert("订单类型不能为空！");
            return;
        }
        var orig_out_fk=$("fk_column_26992").value;
        if(!orig_out_fk){
            alert("发货店仓不能为空！");
            return;
        }
        if(!$("column_26993").value){
            alert("收货店仓不能为空！");
            return;
        }
        var orig_in_sql=$("column_26993").value;

        if(!$("column_26994").value){
            alert("款号不能为空！");
            return;
        }
        var product_filter=$("column_26994").value;
        var billdatebeg=$("column_26995").value.strip();
        var year=billdatebeg.substring(0,4);
        var month=billdatebeg.substring(4,6);
   
        var date=billdatebeg.substring(6,8);
        var beg=month+"/"+date+"/"+year;
        if(!this.checkIsDate(month,date,year)||!reg.test(billdatebeg)){
            alert("开始日期格式不对！请输入8位有效数字。");
            return;
        }
        var billdateend=$("column_269966").value.strip();
        var year1=billdateend.substring(0,4);
        var month1=billdateend.substring(4,6);
        var date1=billdateend.substring(6,8);
        var end=month1+"/"+date1+"/"+year1;
        if(!this.checkIsDate(month1,date1,year1)||!reg.test(billdateend)){
            alert("结束日期格式不对！请输入8位有效数字。");
            return;
        }
        var isprepack="N";
        if(jQuery("#isprepack").is(":checked")){
        	isprepack="Y";
        }
        var param={"or_type":doctype,"c_dest":orig_in_sql,"c_orig":orig_out_fk,"m_product":product_filter,
            "datest":billdatebeg,"datend":billdateend,"load_type":load_type,
            "m_allot_id":m_allot_id,"searchord":"","porder":-1,"isprepack":isprepack,"isstore":'N'};
        evt.param=Object.toJSON(param);
        //alert(evt.param);
        evt.table="m_allot";
        evt.action="distribution_jnby";
        evt.permission="r";
        jQuery("#ph-from-right-table").html("");
        //jQuery("#query-dist").css("display","none");
        this._executeCommandEvent(evt);
    },
    saveDate:function(type){
        if($("orderStatus").value=="2"){
            alert("该单据已提交，不可再进行操作！");
            return;
        }
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="DO_SAVE";
        if(type=='ord'){
            if(!confirm("单据提交不可修改！确认提交？")){
                return;
            }
        }
        /**
         * 2010-4-28 edit by Robin
         */
        var reg=/^\d{8}$/;
        var distdate=jQuery("#distdate").val();
        distdate=distdate.strip();
        var year2=distdate.substring(0,4);
        var month2=distdate.substring(4,6);
        var date2=distdate.substring(6,8);
        var dist=month2+"/"+date2+"/"+year2;
        if(!this.checkIsDate(month2,date2,year2)||!reg.test(distdate)){
            alert("配货日期格式不对！请输入8位有效数字。");
            return;
        }
        /*end*/
        var m_allot_id=$("fund_balance").value||-1;
        var m_item=new Array();
        var celllen=this.cell_data.length;
        if(0==celllen){
        	alert("没有数据！");
        	return;
        }
        for(var i=0;i<this.cell_data.length;i++){
        		var ii={};
        		ii.qty_ady=this.cell_data[i].qtyal;
        		ii.m_product_alias_id=this.cell_data[i].barcode;
        		ii.docno=this.cell_data[i].docno;
        		m_item.push(ii);
        }
       
        //end
        var param={};
        var isprepack="N";
        if(jQuery("#isprepack").is(":checked")){
        	isprepack="Y";
        }
        param.isprepack=isprepack;
        param.type=type;
        param.m_allot_id=m_allot_id;
        param.notes=$("notes").value.strip()||"";
        param.m_item=(m_item.length==0?"null":m_item);
        //Edit by Robin 2010-4-28
        param.distdate=distdate;
        //end

        evt.param=Object.toJSON(param);
        //alert(Object.toJSON(param));
        evt.table="m_allot";
        evt.action="save_jnby";
        evt.permission="r";
        evt.isclob=true;
        this._executeCommandEvent(evt);
    },
    //单据已存在，reload
    reShow:function(){
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="RELOAD";
        var m_allot_id=$("fund_balance").value||"-1";
        var param={"or_type":"-1","c_dest":"-1","c_orig":"-1","m_product":"-1","datest":"-1","datend":"-1","load_type":"reload","m_allot_id":m_allot_id,"porder":-1,"isstore":0};
        evt.param=Object.toJSON(param);
        evt.table="m_allot";
        evt.action="distribution_jnby";
        evt.permission="r";
        this._executeCommandEvent(evt);
    },
    _onreShow:function(e){
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        $("column_26992").value=ret.C_ORIG||"";
        $("column_26993_fd").value=ret.DEST_FILTER||"(可用 = Y)";
        $("column_26994_fd").value=ret.Product_Filter||"(可用 = Y)";
        $("column_26995").value=ret.Billdatebeg||"";
        $("column_269966").value=ret.Billdateend||"";
        //alert(ret.distdate);
        jQuery("#distdate").val(ret.distdate||"");
        var status=ret.status;
        $("orderStatus").value=status;
        if(status=="2"){
           $("submitImge").style.display=""; 
        }
        this._onLoadMetrix(e);
    },
    _onsaveDate:function(e){
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        if(ret.data=="OK"){
            this.status=0;
            jQuery("#jnby-serach-bg>div input[type='image']").hide();
						jQuery("#amount").html(ret.feeallot);
            alert("保存成功！");
            
            $("isChanged").value="false";
        }else if(ret.data=="YES"){
            this.status=0;
            jQuery("#amount").html(ret.feeallot);
            alert("提交成功！");
            $("isChanged").value="false";
            window.self.close();
        }else{
            alert("出现错误！可能原因："+ret.data);
        }
    },
    //经销商资金余额
    fundQuery:function(){
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="FUND_BALANCE";
        var w=window.parent;
        if(!w)w=window.opener;
        var m_allot_id=w.document.getElementById("fund_balance").value||"-1";
        var param={"m_allot_id":m_allot_id};
        evt.param=Object.toJSON(param);
        evt.table="m_allot";
        evt.action = "CUSJNBY";
        evt.permission="r";
        this._executeCommandEvent(evt);
    },
    _onfundQuery:function(e){
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        var fundStr= "<table  width=\"700\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#8db6d9\" bordercolorlight=\"#FFFFFF\" bordercolordark=\"#FFFFFF\" bgcolor=\"#8db6d9\" class=\"modify_table\" align=\"center\">"+
                     "<tr><td width=\"30\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">序号</div></td>"+
                     "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">经销商</div></td>"+
                     "<td width=\"80\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">资金余额</div></td>"+
                     "<td width=\"80\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">已占金额</div></td>"+
                     "<td width=\"80\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">信用下限</div></td>"+
                     "<td width=\"80\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">可用金额</div></td>"+
                     "<td width=\"80\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">已配金额</div></td>"+
                     "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">剩余金额</div></td>"+
                     "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">预检资金</div></td>"+
                     "</tr>";
        if(ret.data=="null"){
            fundStr="<div style='font-size:20px;color:red;text-align:center;font-weight:bold;vertical-align:middle'>您没有选择经销商！</div>";
        }else{
            var funditem=ret.data;
            if(this.checkIsArray(funditem)){
                for(var i=0;i<funditem.length;i++){
                    fundStr+="<tr>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(i+1)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.NAME||"")+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEEREMAIN||0)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEECHECKED||0)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEELTAKE||0)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEECANTAKE||0)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEEALLOT||0)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEEREM||0)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.TOT_AMT_WMS||0)+"</div></td>"+
                             " </tr>";
                }
            }
            else{
                fundStr+="<tr>"+
                         "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+1+"</div></td>"+
                         "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem.facusitem.NAME||"")+"</div></td>"+
                         "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem.facusitem.FEEREMAIN||0)+"</div></td>"+
                         "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem.facusitem.FEECHECKED||0)+"</div></td>"+
                         "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem.facusitem.FEELTAKE||0)+"</div></td>"+
                         "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem.facusitem.FEECANTAKE||0)+"</div></td>"+
                         "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem.facusitem.FEEALLOT||0)+"</div></td>"+
                         "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem.facusitem.FEEREM||0)+"</div></td>"+
                         "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem.facusitem.TOT_AMT_WMS||0)+"</div></td>"+
                         " </tr>";
            }
            fundStr+="</table>";
        }
        $("fund_table1").innerHTML=fundStr;
    },
    //处理数据，初始化页面
    _onLoadMetrix:function(e){
    	var datastart=new Date();  
        window.self.onunload=function(){
               var e=window.opener||window.parent;
               e.setTimeout("pc.doRefresh()",1);
         }
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        if(!(ret.data)||(ret.data&&ret.data=="null")){
            $("table-main").innerHTML="<div style='font-size:20px;color:red;text-align:center;font-weight:bold;vertical-align:middle'>没有数据！</div>";
            return;
        }
        var orderAmount=ret.feeallot||0;
        jQuery("#amount").html(orderAmount).css("display","");
        jQuery("#fund_balance").val(ret.m_allot_id);
        if(jQuery("#load_type").val()=="reload"){
        	jQuery("#notes").val(ret.notes);
      	}
        if(ret.isprepack&&ret.isprepack=='Y'){
        	jQuery("#isprepack").attr("checked","checked");
        }
        if(this.checkIsArray(ret.data)){
        	this.data=ret.data;
        }else{
        	this.data[0]=ret.data;
        }
        var str="";
        var str1="";
        this.ylen=this.data.length;
        for(var i=0;i<this.ylen;i++){
        	var cell={};
        	cell.docno=this.data[i].m_allotitem.DOCNO;
        	cell.store=this.data[i].m_allotitem.C_STORE;
        	cell.area=this.data[i].m_allotitem.C_AREA_ID;
        	cell.barcode=this.data[i].m_allotitem.M_PRODUCT_ALIAS_ID;
        	cell.qtyal=isNaN(parseInt(this.data[i].m_allotitem.QTY_ALLOT,10))?0:parseInt(this.data[i].m_allotitem.QTY_ALLOT,10);
        	cell.stylename=this.data[i].m_allotitem.NAME;
        	cell.stylevalue=this.data[i].m_allotitem.VALUE;
        	cell.color=this.data[i].m_allotitem.VALUE1;
        	cell.size=this.data[i].m_allotitem.VALUE2;
        	cell.qtyrem=isNaN(parseInt(this.data[i].m_allotitem.QTYREM,10))?0:parseInt(this.data[i].m_allotitem.QTYREM,10);
        	cell.qtyconsign=isNaN(parseInt(this.data[i].m_allotitem.QTYCONSIGN,10))?0:parseInt(this.data[i].m_allotitem.QTYCONSIGN,10);
        	cell.qtycan=isNaN(parseInt(this.data[i].m_allotitem.QTYCAN,10))?0:parseInt(this.data[i].m_allotitem.QTYCAN,10);
        	cell.qtyaddnow=isNaN(parseInt(this.data[i].m_allotitem.QTYADDNOW,10))?0:parseInt(this.data[i].m_allotitem.QTYADDNOW,10);
        	cell.qtyadd=isNaN(parseInt(this.data[i].m_allotitem.QTYADD,10))?0:parseInt(this.data[i].m_allotitem.QTYADD,10);
        	cell.destqty=isNaN(parseInt(this.data[i].m_allotitem.DESTQTY,10))?0:parseInt(this.data[i].m_allotitem.DESTQTY,10);
        	cell.doctype=this.data[i].m_allotitem.DOCTYPE;
        	cell.qty=isNaN(parseInt(this.data[i].m_allotitem.QTY,10))?0:parseInt(this.data[i].m_allotitem.QTY,10);//订单量
        	cell.qtyaldist=cell.qty-cell.qtyrem;//已配量，指已配过提交的
        	cell.origqty=isNaN(parseInt(this.data[i].m_allotitem.ORIGQTY,10))?0:parseInt(this.data[i].m_allotitem.ORIGQTY,10);
        	cell.allotstate=parseInt(this.data[i].m_allotitem.ALLOTSTATE,10);
        	this.cell_data_index[cell.barcode+cell.docno]=this.cell_data.length;
        	this.cell_data.push(cell);
        	this.UpdateDataForQtyCan(cell);
        	if(this.barcodeQtyAl[cell.barcode]){
        		this.barcodeQtyAl[cell.barcode]+=cell.qtyal;
        	}else{
        		this.barcodeQtyAl[cell.barcode]=cell.qtyal;
        	}
        	//初始化当前放量可配量
        	if(this.qtyaddnows[cell.barcode+cell.doctype+cell.area]){
        		this.qtyaddnows[cell.barcode+cell.doctype+cell.area]-=cell.qtyal;
        	}else{
        		this.qtyaddnows[cell.barcode+cell.doctype+cell.area]=cell.qtyaddnow-cell.qtyal;
        	}
        	
        	this.totQtyRem+=cell.qtyrem;
        	this.totQtyAl+=cell.qtyal;
        }
        this.end=this.end>(this.ylen-1)?(this.ylen-1):this.end;
        this.create_html(this.start,this.end);
        if($("load_type").value=="reload"){
        		
            $('column_26991').disabled="true";
            jQuery("#queryDetail>table td input"+(($("orderStatus").value!="2")?"[name!=canModify]":"")).attr("disabled","true");
            jQuery("#queryDetail>table td span"+(($("orderStatus").value!="2")?"[name!=canShow]":"")).css("display","none");
        }
        jQuery("#jnby-main>div:visible input[y='1']")[0].focus(); 
        $("jnby-tot-qty").innerHTML=this.totQtyRem;
        $("jnby-tot-qty-al").innerHTML=this.totQtyAl+"";
        //alert(Object.toJSON(this.qtyconsigns));
    },
    change_range:function(){
    	this.range=parseInt(jQuery("#range_select").val(),10);
    	this.start_page();
    },
    start_page:function(){
    	this.start=0;
    	this.end=(this.range>this.ylen?this.ylen:this.range)-1;
    	
    	this.create_html(this.start,this.end);   	
  	},
  	end_page:function(){
  		this.end=this.ylen-1;
  		var r=this.ylen%this.range;
  		if(r==0)r=this.range;
  		this.start=this.end-r+1;
  		
    	this.create_html(this.start,this.end);    		
  	},
    pre_page:function(){
    	if(this.start>0){
    		this.start-=this.range;
    	
    		this.start=this.start<0?0:this.start;
    		var r=this.range;
    		if(this.end==(this.ylen-1)){
    			r=this.ylen%this.range;
    		}
    		
    		this.end-=r;
    
    		this.create_html(this.start,this.end);   	
    	}
    },
    next_page:function(){
    	if(this.end<this.ylen-1){
    		this.end+=this.range;
    		this.end=this.end > (this.ylen-1)?(this.ylen-1):this.end;
    		this.start+=this.range;
    		this.create_html(this.start,this.end);
    	}
    },
    show_txtRange:function(){
    	$("txtRange").innerHTML=(this.start+1)+"-"+(this.end+1)+"/"+this.ylen;
    },
    //画页面
    create_html:function(start,end){
    	var str1="";
    	for(var i=start;i<=end;i++){
    			var cell=this.cell_data[i];
    			var disabled=($("orderStatus").value=="2")?"disabled='true'":"";
        	var allotstate="正常";
        	if(cell.allotstate!=1){
        		switch(cell.allotstate){
        			case 2: allotstate="全可发"; break;
        			case 3: allotstate="全不可发";break;
        		}
        	}
    	    str1+=this.data[i].m_allotitem.DOCTYPE=="FWD"?"<div class=\"table-sidebar row\">":"<div class=\"table-sidebar row highlight-xian\">";
        	str1+="<div class=\"row-line\">"+
								"<div class=\"span-18\">"+(i+1)+"</div>"+
                "<div class=\"span-15\">"+(this.data[i].m_allotitem.NAME||"无")+"</div>"+
								"<div class=\"span-15\">"+(this.data[i].m_allotitem.VALUE||"无")+"</div>"+
							  "<div class=\"span-12\">"+(this.data[i].m_allotitem.VALUE1||"无")+"</div>"+
							  "<div class=\"span-12\">"+(this.data[i].m_allotitem.VALUE2||"无")+"</div>"+
							  "<div class=\"span-15\">"+(this.data[i].m_allotitem.C_STORE||"无")+"</div>"+
							  "<div class=\"span-15\">"+(this.data[i].m_allotitem.DOCNO||"无")+"</div>"+
							  "<div class=\"span-12\">"+(cell.qty||0)+"</div>"+
							  "<div class=\"span-12\">"+(cell.qtyaldist||0)+"</div>"+
							  "<div class=\"span-16\">"+(cell.origqty||0)+"</div>"+
							  "<div class=\"span-12\">"+(this.data[i].m_allotitem.QTYREM||0)+"</div>"+
							  "<div class=\"span-12\"><input "+disabled+" id='"+cell.barcode+"-"+cell.docno+"' y='"+(i+1)+"' area='"+cell.area+"'"+
							  " docno='"+cell.docno+"' style=\"color:red\" doctype='"+cell.doctype+"' store='"+cell.store+"' barcode='"+cell.barcode+"' qtycan='"+cell.qtycan+"' qtyrem='"+cell.qtyrem+"' value='"+cell.qtyal+"' type=\"text\" class=\"ipt-25\" onfocus=\" var e=jQuery(this);dist.updatecell(e,false);dist.updatetitle(e);dwr.util.selectRange(this,0,100);\""+
							   " onkeydown=\"var code=event.which?event.which:event.keyCode; if(code==13){	dist.next_cell(this);}\""+
							   " onkeyup=\"dist.keyuplistener(event);\"/></div>"+
							  "<div class=\"span-12\">"+(this.data[i].m_allotitem.QTYCAN||0)+"</div>"+
							  "<div class=\"span-13\">"+(this.data[i].m_allotitem.QTYCONSIGN||0)+"</div>"+
							  "<div class=\"span-14\">"+(this.data[i].m_allotitem.QTYADDNOW||0)+"</div>"+
							  "<div class=\"span-13\">"+(this.data[i].m_allotitem.QTYADD||0)+"</div>"+
							  "<div class=\"span-13\">"+allotstate+"</div>"+
							  "<div class=\"span-17\">"+(this.data[i].m_allotitem.PREDATEOUT||"无")+"</div></div></div>";
			}
			jQuery("#table-main1").html(str1);
			this.show_txtRange();
    },       
    //是否在this.dataForQtyCan
    existInDataForQtyCan:function(cell){
    	var i=this.dataForQtyCan_index[cell.barcode+cell.doctype];
    	if(i)return i;
    	return -1;
    },
    //更新条码可配量，注意 doctype
    UpdateDataForQtyCan:function(cell){
    	var i=this.existInDataForQtyCan(cell);
    	if(i!=-1){
    		this.dataForQtyCan[i].qtycan-=cell.qtyal;
    		//this.dataForQtyCan[i].qtyaddnow-=cell.qtyal;
    		this.dataForQtyCan[i].qtyconsign-=cell.qtyal;
    		this.dataForQtyCan[i].totrem+=cell.qtyrem;
    	}else{
    		var cellForQtyCan={};
    		cellForQtyCan.barcode=cell.barcode;
    		cellForQtyCan.doctype=cell.doctype;
    		cellForQtyCan.qtycan=isNaN(parseInt(cell.qtycan))?0:parseInt(cell.qtycan);
    		cellForQtyCan.qtycan-=cell.qtyal;
    		//cellForQtyCan.qtyaddnow=isNaN(parseInt(cell.qtyaddnow,10))?0:parseInt(cell.qtyaddnow,10);
    		//cellForQtyCan.qtyaddnow-=cell.qtyal;
    		cellForQtyCan.qtyconsign=isNaN(parseInt(cell.qtyconsign,10))?0:parseInt(cell.qtyconsign,10);
    		cellForQtyCan.qtyconsign-=cell.qtyal;
    		cellForQtyCan.totrem=cell.qtyrem;  
    		this.dataForQtyCan_index[cellForQtyCan.barcode+cellForQtyCan.doctype]=	this.dataForQtyCan.length;	
    		this.dataForQtyCan.push(cellForQtyCan);
    	}
    },
    analysis:function(){
        var solist="";
        for(var i=0;i<this.docNoes.length;i++){
            if(i==0){
                solist+="'"+this.docNoes[i]+"'";
            }else{
                solist+=",'"+this.docNoes[i]+"'";
            }
        }
        this.execCxtab(solist);
    },
    execCxtab:function(solist){
        var q={table:"RP_CUSTOMER_SORETSALE",column_masks:4,params:{column:"B_SO_ID;DOCNO", condition:"in ("+solist+")"}};
        var evt={};
        evt.command="ExecuteCxtab";
        evt.callbackEvent="ExecuteCxtab";
        evt.query=Object.toJSON(q);
        evt.cxtab= "806";
        evt.filetype="cub";
        evt.isrest=true;
        Controller.handle( Object.toJSON(evt), function(r){
            var result= r.evalJSON();
            if (result.code !=0 ){
                alert(result.message);
            }else {
                var r=result.data;
                if(r.message){
                    alert(r.message.replace(/<br>/g,"\n"));
                }
                if(r.url){
                    dist.showObject( r.url, 400, 200,null);
                }
            }
        });
    },
    _executeCommandEvent :function (evt){
        Controller.handle( Object.toJSON(evt),function(r){
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
    checkIsObject:function(o){
        return (typeof(o)=="object");
    },
    checkIsArray: function(o){
        return (this.checkIsObject(o) && (o.length) &&(!this.checkIsString(o)));
    },
    checkIsString:function (o){
        return (typeof(o)=="string");
    },
    checkIsDate:function(month,date,year){
        if(parseInt(month,10)>12||parseInt(month,10)<1||parseInt(date,10)>31||parseInt(date,10)<1||parseInt(year,10)<1980||parseInt(year,10)>3000) {
            return false;
        }
        return true;
    },
    auto_dist:function(){
    	var height=document.body.clientHeight;
    	var width=document.body.clientWidth;
			
    	jQuery("#auto_dist").css("top",height/2-200).css("left",width/2-300).show();
    	
    },
    closeAuto:function(){
    	jQuery("#auto_dist").hide();
    	jQuery.post("writecookie.jsp",{"disttype":jQuery("#dist_type").val(),"distvalue":jQuery("#"+jQuery("#dist_type").val()).val()});
    },
    set_inputes_zero:function(){
			for(var i=0;i<this.cell_data.length;i++){
				var cell=this.cell_data[i];
				cell.qtyal=0;
				this.barcodeQtyAl[cell.barcode]=0;
				var cell1=this.dataForQtyCan[this.dataForQtyCan_index[cell.barcode+cell.doctype]];
				cell1.qtycan=cell.qtycan;
				cell1.qtyconsign=cell.qtyconsign;
				this.qtyaddnows[cell.barcode+cell.doctype+cell.area]=cell.qtyaddnow;
			}
			this.totQtyAl=0;
    },
    exec_dist:function(){
     	if(!confirm("自动配货会清空已编辑内容，确认继续？")){
          return;
      }
      this.set_inputes_zero();
    	var dist_type=jQuery("#dist_type").val();
    	if(jQuery("#"+dist_type)[0]){
    		var dist_param=jQuery("#"+dist_type).val();
    	}
    	if(dist_type=="specNumber"){
    		this.auto_dist_for_specNumber(dist_param);
    	}else if(dist_type=="fowNotOrderPercent"){
    		this.auto_dist_for_fowNotOrderPercent(dist_param);
    	}else if(dist_type=="fowOrderPercent"){
    		this.auto_dist_for_fowOrderPercent();
    	}
    	this.closeAuto();
    	this.refresh_data();
    },
    auto_dist_for_specNumber:function(dist_param){
    	dist_param=parseInt(dist_param,10);
    	dist_param=isNaN(dist_param)?0:dist_param;
    	for(var i=0;i<this.cell_data.length;i++){
    		var cell=this.cell_data[i];
    		var cell1=this.dataForQtyCan[this.dataForQtyCan_index[cell.barcode+cell.doctype]];
    		//var ele=$(cell.barcode+"-"+cell.docno);
				this.updatecellforauto(cell,cell1,dist_param);
    	}   	
    },
    auto_dist_for_fowNotOrderPercent:function(dist_param){
    	dist_param=parseFloat(dist_param);
    	dist_param=isNaN(dist_param)?0:dist_param;
    	for(var i=0;i<this.cell_data.length;i++){
    		var cell=this.cell_data[i];
    		var cell1=this.dataForQtyCan[this.dataForQtyCan_index[cell.barcode+cell.doctype]];
    		//var ele=$(cell.barcode+"-"+cell.docno);
    		var qtyrem=cell.qtyrem;
	    	var qty=Math.ceil(dist_param*qtyrem);
	    	qty=qty<0?0:qty;    		
    		this.updatecellforauto(cell,cell1,qty);
    	}    	
    },
    /**
     * edit by Robin 2010.5.7
     * 传入一个JSON对象在this.data中查找符合的结果集数组并返回
     * @param cellData JSON对象可能含有color、size、docNo、store、barCode中多个或1个用此对象和this.data数组中的JSON对象比较
     */
    v2m_get_ret:function(cellData){
    		
        return this.v2m_get_ret_any(cellData,this.cell_data);
    },
    /**
     * edit by Robin 2010.5.11
     * 传入一个JSON对象在data中查找符合的结果集数组并返回
     * @param cellData JSON对象可能含有color、size、docNo、store、barCode中多个或1个用此对象和data数组中的JSON对象比较
     * @param data 包含color、size、docNo、store、barCode属性元素的数组
     */    
		v2m_get_ret_any:function(cellData,data){
        var result=new Array();
        for(var i=0;i<data.length;i++){
            if((cellData.doctype?data[i].doctype==cellData.doctype:true)&&(cellData.sty?data[i].sty==cellData.sty:true)&&(cellData.color?data[i].color==cellData.color:true)&&(cellData.size?data[i].size==cellData.size:true)&&(cellData.docno?cellData.docno==data[i].docno:true)&&(cellData.store?cellData.store==data[i].store:true)&&(cellData.barcode?cellData.barcode==data[i].barcode:true)){
                result.push(data[i]);
            }
        }
        return result;			
		},
		get_totrem_for_param:function(barcode,doctype){
			return this.dataForQtyCan[this.dataForQtyCan_index[barcode+doctype]].totrem;
		},
    auto_dist_for_fowOrderPercent:function(expr){
    	for(var i=0;i<this.cell_data.length;i++){
    		var cell=this.cell_data[i];
    		var cell1=this.dataForQtyCan[this.dataForQtyCan_index[cell.barcode+cell.doctype]];
    		var totrem=cell1.totrem;
    		var qtyrem=cell.qtyrem;
    		var qtycan=cell.qtycan;
    		/*
    		var qtyaddnow=this.qtyaddnows[cell.barcode+cell.doctype+cell.area];
				if(cell.doctype!="FWD"){
	    		qtycan=Math.min(qtycan,cell1.qtyconsign,qtyaddnow);
	    	}*/
		  	var percent=0;
		  	if(totrem!=0){
		  		percent=qtyrem/totrem;
		  	}
		  	percent=parseFloat(percent);
		  	percent=isNaN(percent)?0:percent;
		  	
		  	var qty=Math.ceil(percent*qtycan);
		  	qty=qty<0?0:qty;    	
    		this.updatecellforauto(cell,cell1,qty);		
    	}    	
    	    
    },        
    /**
    *传入元素聚焦下个编辑
    */
    next_cell:function(e){
    	 var y=parseInt(jQuery(e).attr("y"),10);
       var cell=jQuery("#jnby-main>div:visible input[y='"+(y+1)+"']")[0];
       if(cell){
           cell.focus();
        }else{
           var cell=jQuery("#jnby-main>div:visible input[y='1']")[0].focus();
        }
    },
    /**
    *传入元素聚焦上个编辑
    */
    next_cell_up:function(e){
    	 var y=parseInt(jQuery(e).attr("y"),10);
       var cell=jQuery("#jnby-main>div:visible input[y='"+(y-1)+"']")[0];
       if(cell){
           cell.focus();
        }else{
           var cell=jQuery("#jnby-main>div:visible input[y='"+this.ylen+"']")[0].focus();
        }
    },
    /**
    给定元素节点查询在this.dataForQtyCan的单元
    */
    get_qty_cell:function(e){
    	var barcode=jQuery(e).attr("barcode");
    	var doctype=jQuery(e).attr("doctype");
    	var cell=this.dataForQtyCan[this.dataForQtyCan_index[barcode+doctype]];
    	if(cell){
    		return cell;
    	}
    	return -1;
    },
    get_qty_al_for_all_can_dist:function(cell){
    	return this.barcodeQtyAl[cell.barcode];   	
    },
    /**
    给定元素节点返回对应数据单元
    */
   get_data_cell:function(e){
    	var barcode=jQuery(e).attr("barcode");
    	var docno=jQuery(e).attr("docno");	
    	var cell=this.cell_data[this.cell_data_index[barcode+docno]];
    	if(cell)return cell;		   	
    	return -1;
   }, 
    /**
    根据节点更新头可配量。。。信息
    */
    updatetitle:function(e){
    	var cell1=this.get_qty_cell(e);
    	var cell=this.get_data_cell(e);
    	if(cell1!=-1){
    		jQuery("#qty-can").html(cell1.qtycan+"");
    		jQuery("#qty-consign").html(cell1.qtyconsign+"");
    		jQuery("#qty-addnow").html(this.qtyaddnows[cell.barcode+cell.doctype+cell.area]+"");
    		jQuery("#jnby-tot-qty-al").html(this.totQtyAl);
    	}
    },
    update_m_data:function(cell,cell1,newqty,newdiffqty){
    			
	    		cell1.qtycan-=newdiffqty;
	    		this.qtyaddnows[cell.barcode+cell.doctype+cell.area]-=newdiffqty;
	    		cell1.qtyconsign-=newdiffqty;
	    		//cell1.qtyaddnow-=newdiffqty;
	    		cell.qtyal+=newdiffqty;
	    		this.totQtyAl+=newdiffqty;
	    		this.barcodeQtyAl[cell.barcode]+=newdiffqty;
    },
    //当编辑配货数可配时，更新数据层和编辑单元的数据
    updatedata:function(cell,cell1,newqty,newdiffqty){
	    	this.update_m_data(cell,cell1,newqty,newdiffqty);
	    		var barcode=cell.barcode;
	    		var docno=cell.docno;
	    		$("jnby-tot-qty-al").innerHTML=this.totQtyAl;
	    		
	    		$(barcode+"-"+docno).value=newqty;
    },
    get_qtycan:function(cell,cell1){
    	var qtycan=0;
    	if(cell.allotstate==1){
    		if(cell.doctype=="FWD"){
	    		qtycan=Math.min((cell.qtyrem-cell.qtyal),cell1.qtycan);
	    	}else{
	    		qtycan=Math.min((cell.qtyrem-cell.qtyal),cell1.qtyconsign,this.qtyaddnows[cell.barcode+cell.doctype+cell.area]);
	    	}
    	}else if(cell.allotstate==2){
    		
    		
    		var qtycanforalldoc=cell.qtycan-this.get_qty_al_for_all_can_dist(cell);
    		
    		qtycan=Math.min((cell.qtyrem-cell.qtyal),qtycanforalldoc);
    		
    	}else{
    		qtycan=0;
    	}
    	return qtycan;
    },
    updatecellforauto:function(cell,cell1,qty){
    	var qtycan=this.get_qtycan(cell,cell1);
    	var qtynow=(qty>qtycan)?qtycan:qty;
    	qtynow=qtynow<0?0:qtynow;
    	this.update_m_data(cell,cell1,qtynow,qtynow);
    },
    //传入在编辑的单元，更新数据
    updatecell:function(e,aler){
    	var nowqty=jQuery(e).val();
    	nowqty=isNaN(parseInt(nowqty,10))?0:parseInt(nowqty,10);
    	var cell=this.get_data_cell(e);
    	//alert(this.qtyconsigns[cell.barcode+cell.doctype+cell.area]);
    	var cell1=this.get_qty_cell(e);
    	//alert(Object.toJSON(cell1));
    	if(cell!=-1&&cell1!=-1){
    		if(nowqty<0){
    			jQuery(e).val(cell.qtyal);
    			alert("不可输入负数");
    			return;
    		}
	    	var diffqty=nowqty-cell.qtyal;
	    	var qtycan=this.get_qtycan(cell,cell1);
	    	//alert(qtycan+"--------"+diffqty);
	    	if(diffqty>qtycan){
	    		var newqty=qtycan+cell.qtyal;
	    		var newdiffqty;
	    		if(!(newqty<0)){
	    			newdiffqty=qtycan;
	    		}else{
	    			newqty=0;
	    			newdiffqty=0-cell.qtyal;
	    		}
   				this.updatedata(cell,cell1,newqty,newdiffqty);
   				if(aler==true)alert("配货量不得大于实际可配发量！");
	    		return;
	    	}else{
	    		this.updatedata(cell,cell1,nowqty,diffqty);
	    		return;
	    	}
    	}else{
    		alert("错误！");
    		return;
    	}
    },
    refresh_data:function(){
    	for(var i=this.start;i<=this.end;i++){
    			var cell=this.cell_data[i];
    			var barcode=cell.barcode;
	    		var docno=cell.docno;
	    		var qtyal=cell.qtyal;
	    		jQuery("#"+barcode+"-"+docno).val(qtyal);
    	}
    	$("jnby-tot-qty-al").innerHTML=this.totQtyAl;
    	
    },
    keyuplistener:function(event){
    	var code=event.which?event.which:event.keyCode;
    	var ele=event.target?event.target:event.srcElement;
    	dist.status=1;
      if((code>=48&&code<=57)||(code>=96&&code<=105)){
  				dist.updatecell(ele,true);
 				  dist.updatetitle(ele);
      }else if(code==38){//上
					dist.next_cell_up(ele);
      }else if(code==40){//下
      		dist.next_cell(ele);
      }else if(code==8||code==46){
          if(ele.value==""||ele.value.strip()==""){
            ele.value=0;
          }
      }
    },
    
    showObject:function(url, theWidth, theHeight,option){
        if( theWidth==undefined || theWidth==null) theWidth=956;
        if( theHeight==undefined|| theHeight==null) theHeight=570;
        var options={width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE, modal:true,centerMode:"x",maxButton:true,onCenter:true};
        if(option!=undefined){
            Object.extend(options, option);
        }
        Alerts.popupIframe(url,options);
        Alerts.resizeIframe(options);
    },
    sum_dist_item:function(datas){
    	var items=datas.slice(0);
    	var i=0;
    	while(items[i]){
    		this.del_same_items(items[i],i,items);
    		i++;
    	}
			alert(Object.toJSON(items));
    },
    /**
    *从数组中移除相同的元素
    *@param:item 数组中的一个元素
    *@param:index 参数1元素在数组中的索引
    *@param:items 数组
    */
    del_same_items:function(item,index,items){
    	var sames=new Array();
    	for(var i=index+1;i<items.length;i++){
    		if(items[i].m_allotitem.NAME==item.m_allotitem.NAME&&items[i].m_allotitem.C_STORE==item.m_allotitem.C_STORE){
    			sames.unshift(i);
    		}
    	}
    	for(var j=0;j<sames.length;j++){
    		items.splice(sames[j],1);
    	}
    }
    
}
DIST.main = function(){
    dist=new DIST();
};
jQuery(document).ready(DIST.main);
jQuery(document).ready(function(){
   jQuery("body").bind("keyup",function(event){
       if(event.which==13){
           event.stopPropagation();
       }
   });
});