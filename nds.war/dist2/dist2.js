var dist=null;
var DIST=Class.create();
DIST.prototype={
    initialize: function() {
        this.itemStr="";
        this.manuStr="";
        this.allot_id=null;
        this.manu=null;
        this.item=null;
        this.product=new Array();
        this.status=0;
        this.data=new Array();//向数据库获得数据组成单元数组
        this.barcode_data=new Array();//条码数据数组
        this.store_count=0;
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        dwr.util.setEscapeHtml(false);

        dwr.engine._errorHandler =  function(message, ex) {
            while(ex!=null && ex.cause!=null) ex=ex.cause;
            if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + "," + ex.message+","+ ex.cause.message, true);
            if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
            else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
            else alert(message);
        };
        application.addEventListener( "DO_QUERY", this._onLoadMetrix, this);
        application.addEventListener("DO_SAVE",this._onsaveDate,this);
        application.addEventListener("RELOAD",this._onreShow,this);
        application.addEventListener("FUND_BALANCE",this._onfundQuery,this);
    },
    getCustomId:function(){
        var orderId=$("fk_column_40252").value||-1;
        if(orderId==-1){
            alert("订单号未选择或操作错误！");
            return;
        }
        jQuery.get("_getCustomId.jsp",{"orderid":orderId},function(data){
            oq.toggle_m('/html/nds/query/search.jsp?table=C_V_STORE2&return_type=f&accepter_id=column_26993&fixedcolumns=C_V_STORE2.C_CUSTOMER_ID%3D'+data, 'column_26993');
        });
    },
    queryObject: function(style){
        this.itemStr="";
        this.manuStr="";
        this.allot_id=null;
        this.manu=null;
        this.item=null;
        this.product=new Array();
        this.status=0;
        this.data=new Array();//向数据库获得数据组成单元数组
        this.barcode_data=new Array();//条码数据数组
        this.store_count=0;    	
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="DO_QUERY";
        var load_type=$("load_type").value;
        var m_allot_id=$("fund_balance").value||"-1";
        if(!$('fk_column_40252').value){
            alert("单据号不能为空！");
            return;
        }
        if(!$("column_26993").value){
            alert("收货店仓不能为空！");
            return;
        }
        var orig_in_sql=$("column_26993").value;
        var searchord=$('fk_column_40252').value;
        var param={"or_type":-1,"c_dest":orig_in_sql,"c_orig":-1,"m_product":-1,"porder":1,
            "datest":-1,"datend":-1,"load_type":load_type,"m_allot_id":m_allot_id,"searchord":searchord};
        evt.param=Object.toJSON(param);
        evt.table="m_allot";
        evt.action="distribution";
        evt.permission="r";
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
        var reg=/^\d{8}$/;
        var distdate=jQuery("#distdate").val();
        distdate=distdate.strip();
        var year2=distdate.substring(0,4);
        var month2=distdate.substring(4,6);
        var date2=distdate.substring(6,8);
        var dist=month2+"/"+date2+"/"+year2;
        if(!this.checkIsDate(month2,date2,year2)||!reg.test(distdate)){
            alert("配货时间日期格式不对！请输入8位有效数字。");
            return;
        }
        var m_allot_id=$("fund_balance").value||-1;
        var m_item=new Array();
        for(var i=0;i<this.data.length;i++){
        	var ii={};
      		ii.qty_ady=this.data[i].qtyAl;
      		ii.m_product_alias_id=this.data[i].barcode;
      		ii.store_id=this.data[i].store;
      		m_item.push(ii);
        }
        var docno=$("column_40252").value;
        var param={};
        param.type=type;
        param.m_allot_id=m_allot_id;
        param.notes=jQuery("#notes").val()||"";
        param.m_item=(m_item.length==0?"null":m_item);
        param.docno=docno;
        param.distdate = distdate;
        evt.param=Object.toJSON(param);
        evt.table="m_allot";
        evt.action="save";
        evt.permission="r";
        evt.isClob=true;
        this._executeCommandEvent(evt);
    },
    reShow:function(){
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="RELOAD";
        var m_allot_id=$("fund_balance").value||"-1";
        var param={"or_type":"-1","c_dest":"-1","c_orig":"-1","m_product":"-1",
            "datest":"-1","datend":"-1","load_type":"reload","m_allot_id":m_allot_id,"porder":1};
        evt.param =Object.toJSON(param);
        evt.table="m_allot";
        evt.action="distribution";
        evt.permission="r";
        this._executeCommandEvent(evt);
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
        evt.action = "cus";
        evt.permission="r";
        this._executeCommandEvent(evt);
    },
    _onfundQuery:function(e){
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        var fundStr= "<table  width=\"700\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#8db6d9\" bordercolorlight=\"#FFFFFF\" bordercolordark=\"#FFFFFF\" bgcolor=\"#8db6d9\" class=\"modify_table\" align=\"center\">"+
                     "<tr><td width=\"70\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">序号</div></td>"+
                     "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">经销商</div></td>"+
                     "<td width=\"80\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">资金余额</div></td>"+
                     "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">已占用金额</div></td>"+
                     "<td width=\"100\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">配货信用下限</div></td>"+
                     "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">可用金额</div></td>"+
                     "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">本次配货金额</div></td>"+
                     "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">剩余金额</div></td>"+
                     "</tr>";
        if(ret.data=="null"){
            fundStr="<div style='font-size:20px;color:red;text-align:center;font-weight:bold;vertical-align:middle'>您没有选择经销商！</div>";
        }else{
            var funditem=ret.data;
            if(this.checkIsArray(funditem)){
                for(var i=0;i<funditem.length;i++){
                    fundStr+="<tr>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(i+1)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.NAME||""+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEEREMAIN||0+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEECHECKED||0+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEELTAKE||0+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEECANTAKE||0+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEEALLOT||0+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEEREM||0+"</div></td>"+
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
                         " </tr>";
            }
            fundStr+="</table>";
        }
        $("fund_table1").innerHTML=fundStr;
    },
    _onreShow:function(e){
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        $("column_40252").value=ret.searchord;
        $("column_26993_fd").value=ret.DEST_FILTER||"(可用 = Y)";
        jQuery("#distdate").val(ret.distdate);
        jQuery("#ph-serach>div[class='djh-table']>table input[class!='notes'][name!='canModify']").attr("disabled","true");
        jQuery("#ph-serach>div[class='djh-table']>table td>span[name!='canShow']").hide();
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
            jQuery("#orderSearch>table input[type='image']").hide();
            alert("保存成功！");
            $("isChanged").value="false";
        }else if(ret.data=="YES"){
            this.status=0;
            alert("提交成功！");
            $("isChanged").value="false";
            window.self.close();
        }else{
            alert("出现错误！可能原因："+ret.data);
        }
    },
    /*
     ×让自动配货界面隐藏
     */     
    closeAuto:function(){
    	jQuery("#alert-auto-dist").hide();
    },
    exec_dist:function(dist_type){
      if($("orderStatus").value=="2"){
          return;
      }     	
     	if(!confirm("自动配货会清空已编辑内容，确认继续？")){
          return;
      }
    	var expr;
    	var expr0;
    	if(dist_type=='all'){
    		expr="#ph-from-right-table>table input[sty][store]";
    		expr0="#ph-from-right-table>table input[sty][store][value!=''][value!='0']";
    	}else{
    		expr="#ph-from-right-table>table:visible input[sty][store]";
    		expr0="#ph-from-right-table>table:visible input[sty][store][value!=''][value!='0']"
    	}
    	jQuery(expr0).each(function(){
    		dist.autoDistForCell(0,this);
    	});
      this.auto_dist_for_specNumber(expr);
    },
    auto_dist_for_specNumber:function(expr){
    	jQuery(expr).each(function(){
    		var barcode_cell=dist.get_barcode_qty(jQuery(this).attr("barcode"));
    		var qtyCan=parseInt(barcode_cell.qtyCan,10);
  			var dist_param=Math.ceil(parseInt(barcode_cell.qtyRem,10)/dist.store_count);
	  		var qtyRem=parseInt(barcode_cell.qtyRem,10)-parseInt(barcode_cell.qtyAl,10);
				var qty=Math.min(dist_param,qtyCan,qtyRem);
				qty=qty<0?0:qty;
				dist.autoDistForCell(qty,this);

    	});
    },
    get_order_tot_can:function(){
    	var tot_can=0;
    	for(var i=0;i<this.barcode_data.length;i++){
    		tot_can+=parseInt(this.barcode_data[i].qtyCan,10);
    	}
    	return tot_can;
    },        
    /*
     ×@param qty 自动要编辑的数量
     *@param e 所要编辑的单元
     * 返回实际配货数量
     */     
    autoDistForCell:function(qty,e){
    	var cellData1={};
      cellData1.barcode=jQuery(e).attr("barcode");
      cellData1.store=jQuery(e).attr("store");
      
      var dataCell1=dist.v2m_get_ret(cellData1)[0];
      var oldQtyAl=parseInt(dataCell1.qtyAl,10);//未编辑前的单元的已配量
      var nowQty=qty;
      
      var qtyAlChange=nowQty-oldQtyAl;//改变的数量
      
      var barcode_qty=dist.get_barcode_qty(jQuery(e).attr("barcode"));
      var barCodeCanDist=barcode_qty.qtyCan<0?0:barcode_qty.qtyCan;
     	var qtyRem=parseInt(barcode_qty.qtyRem,10);
     	var barcodeQtyAl=parseInt(barcode_qty.qtyAl,10);
      if(qtyAlChange>barCodeCanDist||(barcodeQtyAl+qtyAlChange)>qtyRem){
      	return 0;
      }else{
      	jQuery(e).val(qty);
       	var real_qty_change=qty-oldQtyAl;
       	var cellData1={};
       	cellData1.sty=jQuery(e).attr("sty");
       	cellData1.barcode=jQuery(e).attr("barcode");
       	cellData1.size=jQuery(e).attr("size");
       	cellData1.color=jQuery(e).attr("color");
       	cellData1.store=jQuery(e).attr("store");
       	cellData1.qtyAl=qty;
       	dist.update_for_cell_change(cellData1,real_qty_change);      	
       	return qty;
      }
    },  
    _onLoadMetrix:function(e){
        window.self.onunload=function(){
               var e=window.opener||window.parent;
               e.setTimeout("pc.doRefresh()",1);
         }
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        if(ret.data&&ret.data=="null"){
            $("ph-from-right-table").innerHTML="<div style='font-size:20px;color:red;text-align:center;font-weight:bold;vertical-align:middle'>没有数据！</div>";
            return;
        }
        var pdts=this.pdtToJson(ret.data.m_product);
        //alert(Object.toJSON(pdts));
        $("isChanged").value='false';
        this.manuStr="";
        this.itemStr="";
        if(!pdts[0].color){
            alert("此单据已失效！");
            return;
        }
        $("notes").value=ret.notes||"";
        for(var i=0;i<pdts.length;i++){
            this.manuStr+="<li><div class='txt-on' name='"+pdts[i].dis+"' title='"+pdts[i].id+"'>"+pdts[i].pdtStyle+"</div></li>";
            this.itemStr+="<table title='"+this.getStyTotRem(pdts[i])+"' name='"+this.getStyTotCan(pdts[i])+"' id='"+pdts[i].id+"' style='display:none' cellspacing=\"1\" cellpadding=\"0\" border=\"0\" bgcolor=\"#8db6d9\">"
            var colors=pdts[i].color;
            this.itemStr+="<tr><td bgcolor=\"#ffffff\" width=\"55\" class=\"td-left-title\">色号</td>"+
                          "<td bgcolor=\"#ffffff\" width=\"132\" class=\"td-left-title\">店仓\\尺寸</td>";
            for(var c=0;c<colors[0].sizes.length;c++){
                this.itemStr+="<td bgcolor=\"#b6d0e7\" width=\"65\" class=\"td-right-title\">"+colors[0].sizes[c]+"</td>";
            }
            this.itemStr+="<td bgcolor=\"#b6d0e7\" width=\"65\" class=\"td-right-title\">合计</td>";
            this.itemStr+="</tr>";
						this.store_count=parseInt(colors[0].rowSpan,10)-3;
            for(var j=0;j<colors.length;j++){
                var stors=colors[j].stors;
                for(var jj=0;jj<colors[j].rowSpan;jj++){
                    if(jj==0){
                        this.itemStr+="<tr>"+
                                      "<td bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-left-txt\" rowspan='"+colors[j].rowSpan+"'>"+colors[j].colorName+"</td>"+
                                      "<td bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txt\">可用库存</td>";
                        var tot_can_row=0;
                        for(var s=0;s<colors[j].qtycan.length;s++){
                        	/*
                        	Edit by Robin 2010.5.16 保存条码数据
                        	*/
                        	if(colors[j].barcode[s]!='no'){
                        		var barcode_cell={};
                        		barcode_cell.barcode=colors[j].barcode[s];
                        		barcode_cell.qtyAl=0;//已配量
                        		barcode_cell.qtyRem=colors[j].qtyrem[s];//未配量
                        		barcode_cell.qtyCan=parseInt(colors[j].qtycan[s],10);//可配量
                        		barcode_cell.qtyDest=colors[j].qtyorder[s];//订单量
                        		this.barcode_data.push(barcode_cell);
                        	}
                        		//end
                            if(colors[j].qtycan[s]!='no'){
                            		tot_can_row+=parseInt(colors[j].qtycan[s],10);
                                this.itemStr+="<td id='"+colors[j].barcode[s]+"-can' bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtK\">"+colors[j].qtycan[s]+"</td>";
                            }else{
                                this.itemStr+="<td bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtK\" style=\"background-color:#eeeeee\"></td>";
                            }
                        }
                        this.itemStr+="<td bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtK\">"+tot_can_row+"</td>";
                        this.itemStr+="</tr>";
                    }else if(jj==1){
                        this.itemStr+="<tr>"+
                                      "<td bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txt\">订单余量</td>";
												var tot_rem_row=0;                                      
                        for(var s1=0;s1<colors[j].qtyrem.length;s1++){
                            if(colors[j].qtyrem[s1]!='no'){
                            		tot_rem_row+=parseInt(colors[j].qtyrem[s1],10);
                                this.itemStr+="<td id='"+colors[j].barcode[s1]+"-rem' bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtW\">"+colors[j].qtyrem[s1]+"</td>";
                            }else{
                                this.itemStr+="<td bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtW\" style=\"background-color:#eeeeee\"></td>";
                            }
                        }
                        this.itemStr+="<td  bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtW\">"+tot_rem_row+"</td>";
                        this.itemStr+="</tr>";
                    }else if(jj==2){
                        this.itemStr+="<tr>"+
                                      "<td bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txt\">订单数量</td>";
												var tot_order_row=0;                                      
                        for(var s2=0;s2<colors[j].qtyorder.length;s2++){
                            if(colors[j].qtyorder[s2]!='no'){
                            		tot_order_row+=parseInt(colors[j].qtyorder[s2],10);
                                this.itemStr+="<td id='"+colors[j].barcode[s2]+"-order' bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtD\">"+colors[j].qtyorder[s2]+"</td>";
                            }else{
                                this.itemStr+="<td bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtD\" style=\"background-color:#eeeeee\"></td>";
                            }
                        }
                        this.itemStr+="<td bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtD\">"+tot_order_row+"</td>";
                        this.itemStr+="</tr>";
                    }else{
                        var v=jj-3;
                       
                        this.itemStr+="<tr><td title='"+colors[j].stors[v].id+"' bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txt\">"+colors[j].stors[v].name+"</td>";
                        for(var g=0;g<colors[j].qtyrem.length;g++){
                            if(colors[j].qtyrem[g]!='no'){
                         
                            var cellData={};//每个单元的数据，即配货编辑的单元
                            cellData.sty = pdts[i].pdtStyle;//款号
                            cellData.color = colors[j].colorName;//色号
                            cellData.size =  colors[j].sizes[g];//尺寸
                            cellData.store = colors[j].stors[v].id;//店仓ID
                            cellData.barcode =colors[j].barcode[g];//所属条码
                            cellData.qtyAl=0;
                            this.data.push(cellData);
                            /* end */
                                                       	
                                this.itemStr+="<td bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-bg\"><input type=\"text\" sty='"+pdts[i].pdtStyle+"' store='"+colors[j].stors[v].id+"' color='"+colors[j].colorName+"' size='"+colors[j].sizes[g]+"'  barcode='"+colors[j].barcode[g]+"' id='"+(colors[j].barcode[g]+colors[j].stors[v].id)+"'  name='"+colors[j].sizes[g]+"' class=\"td-txt-input\" title='"+colors[j].barcode[g]+"'/></td>";
                            }else{
                                this.itemStr+="<td bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-bg\" style=\"background-color:#eeeeee\"></td>";
                            }
                        }
                        this.itemStr+="<td id='"+(pdts[i].pdtStyle+colors[j].colorName+colors[j].stors[v].id)+"' bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtD\"></td>";
                        this.itemStr+="</tr>";
                    }
                }

            }
           this.itemStr+="<tr><td colspan='2' bgcolor=\"#ffffff\" width=\"55\" class=\"td-left-title\">已配合计</td>";
           for(var n=0;n<colors[0].sizes.length;n++){
            	this.itemStr+="<td id='"+(pdts[i].pdtStyle+colors[0].sizes[n])+"' bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtD\"></td>";
           }
           this.itemStr+="<td id='"+pdts[i].pdtStyle+"-tot' bgcolor=\"#8db6d9\" valign=\"top\" class=\"td-right-txtD\"></td>";
           this.itemStr+="</tr>"
           this.itemStr+="</table>";
        }
        jQuery("#styleManu").html(this.manuStr);
        jQuery("#ph-from-right-table").html(this.itemStr);
        $("fund_balance").value=ret.m_allot_id;
        this.autoShowManuAndItem();
        this.listener();
        this.manuStr=null;
        this.itemStr=null;
        if(ret.status=="2"){
            jQuery("#ph-from-right-table td input").attr("disabled","true");
        }
        if($("load_type").value=="reload"){
            if(ret.c_storeitem){
                this.fillItem(ret.c_storeitem);
                /*
                当为reLoad时更新行列合计
                */
                this.init_row_col_tot(pdts);
            }
        }
        window.onbeforeunload=function(){
            if($("isChanged").value=='true'){
                return "页面数据已改动，还未保存！";
            }else{
                return;
            }
        }
        if(!window.document.addEventListener){
            window.document.attachEvent("onkeydown",hand11);
            function hand11()
            {
                if(window.event.keyCode==13){
                    return false;
                }
            }
        }
          //alert(Object.toJSON(this.data));
          //alert(Object.toJSON(this.barcode_data));
    },
     /*
     当为reLoad时初始化行列合计
     */
    init_row_col_tot:function(pdts){
      for(var y=0;y<pdts.length;y++){
      	var tot_style=0;
      	for(var m=0;m<pdts[y].color.length;m++){
      		if(m==0){
          	for(var u=0;u<pdts[y].color[m].sizes.length;u++){
          		var count=this.update_col_tot(pdts[y].pdtStyle,pdts[y].color[m].sizes[u]);
          		tot_style+=count;
          	}
        	}
        	for(var l=0;l<pdts[y].color[m].stors.length;l++){
        		this.update_row_tot(pdts[y].pdtStyle,pdts[y].color[m].colorName,pdts[y].color[m].stors[l].id);
        	}
      	}
      	jQuery("#"+pdts[y].pdtStyle+"-tot").html(tot_style);
      }    	
    },
    /**
     *Edit by Robin 2010.5.16
     *页面初始化时更新行合计显示数
     */     
    update_row_tot:function(style,color,store){
    	var tot_row=0;
    	for(var i=0;i<this.data.length;i++){
    		if(this.data[i].sty==style&&this.data[i].color==color&&this.data[i].store==store){
    			tot_row+=parseInt(this.data[i].qtyAl,10);
    		}
    	}
    	jQuery("#"+style+color+store).html(tot_row);	    	
    },
    /**
     *Edit by Robin 2010.5.16
     *页面初始化时更新列合计显示数
     *并返回合计数
     */    
    update_col_tot:function(style,size){
    	var tot_col=0;
    	for(var i=0;i<this.data.length;i++){
    		if(this.data[i].sty==style&&this.data[i].size==size){
    			tot_col+=parseInt(this.data[i].qtyAl,10);
    		}
    	}
    	jQuery("#"+style+size).html(tot_col);	
    	return tot_col;		
    },
    /**
     *Edit by Robin 2010.5.16
     *当装载已配明细时，更新this.barcode_data（条码数据明细）
     *只有已配过的配货单
     */
    update_barcode_cell:function(store){
    	for(var i=0;i<this.barcode_data.length;i++){
    		if(store.m_product_alias==this.barcode_data[i].barcode){
    			this.barcode_data[i].qtyAl+=parseInt(store.QTY_ALLOT,10);
    			this.barcode_data[i].qtyCan-=parseInt(store.QTY_ALLOT,10);
    			return;
    		}
    	}
    },
    /**
     *Edit by Robin 2010.5.16
     *当装载已配明细时，更新this.data（单元数据明细）
     *只有已配过的配货单
     */    
    update_data_cell:function(store){
    	for(var i=0;i<this.data.length;i++){
    		if(store.m_product_alias==this.data[i].barcode&&store.content==this.data[i].store){
    			this.data[i].qtyAl+=parseInt(store.QTY_ALLOT,10);
    			return;
    		}
    	}    	
    },
    fillItem:function(storeItem){
        var stores=new Array();
        if(this.checkIsArray(storeItem)){
            for(var i=0;i<storeItem.length;i++){
                stores[i]=storeItem[i];
            }
        }else{
            stores[0]=storeItem;
        }
        for(var j=0;j<stores.length;j++){
        		this.update_barcode_cell(stores[j]);
        		this.update_data_cell(stores[j]);  		
            $(stores[j].m_product_alias+stores[j].content).value=stores[j].QTY_ALLOT;
        }
    },
    v2m_get_ret:function(cellData){
        return this.v2m_get_ret_any(cellData,this.data);
    },    
    v2m_get_ret_any:function(cellData,data){
        var result=new Array();
        for(var i=0;i<data.length;i++){
            if((cellData.sty?data[i].sty==cellData.sty:true)&&(cellData.color?data[i].color==cellData.color:true)&&(cellData.size?data[i].size==cellData.size:true)&&(cellData.store?cellData.store==data[i].store:true)&&(cellData.barcode?cellData.barcode==data[i].barcode:true)){
                result.push(data[i]);
            }
        }
        return result;			
		},
    //根据条码得到可配量,未配量。。。
    get_barcode_qty:function(barcode){
    	for(var i=0;i<this.barcode_data.length;i++){
    		if(this.barcode_data[i].barcode==barcode){
    			return this.barcode_data[i];
    		}
    	}
    },
    update_cell_for_change:function(cellData){
    	for(var i=0;i<this.data.length;i++){
    		if(this.data[i].barcode==cellData.barcode&&this.data[i].store==cellData.store){
    			this.data[i].qtyAl=cellData.qtyAl;
    			return;
    		}
    	}
    },
    update_barcode_qty_for_change:function(cellData,real_qty_change){
    	for(var i=0;i<this.barcode_data.length;i++){
    		if(this.barcode_data[i].barcode==cellData.barcode){
    			this.barcode_data[i].qtyAl+=real_qty_change;
    			this.barcode_data[i].qtyCan-=real_qty_change;
    			return;
    		}
    	}
    },
    update_row_tot_for_change:function(cellData,real_qty_change){
    	var old_qty=parseInt(jQuery("#"+cellData.sty+cellData.color+cellData.store).html(),10);
    	old_qty=isNaN(old_qty)?0:old_qty;
    	jQuery("#"+cellData.sty+cellData.color+cellData.store).html((old_qty+real_qty_change));
    },
    update_col_tot_for_change:function(cellData,real_qty_change){
    	var old_qty=parseInt(jQuery("#"+cellData.sty+cellData.size).html(),10);
    	var old_qty_tot=parseInt(jQuery("#"+cellData.sty+"-tot").html(),10);
    	old_qty=isNaN(old_qty)?0:old_qty;
    	old_qty_tot=isNaN(old_qty_tot)?0:old_qty_tot;
    	jQuery("#"+cellData.sty+cellData.size).html((old_qty+real_qty_change));    	
    	jQuery("#"+cellData.sty+"-tot").html((old_qty_tot+real_qty_change));
    },
    //当单元格变动时，更新相关数据
    update_for_cell_change:function(cellData,real_qty_change){
    	this.update_cell_for_change(cellData);
    	this.update_barcode_qty_for_change(cellData,real_qty_change);
    	this.update_row_tot_for_change(cellData,real_qty_change);
    	this.update_col_tot_for_change(cellData,real_qty_change);
    },
    /*
    当未点击产品类别时调用，如页面载入，模糊查询
    */
    autoShowManuAndItem:function(){
        var divs=jQuery("#styleManu>li:visible>div");
        if(divs[0]){
            this.autoViewForStyle(divs[0]);
        }else{
            jQuery("#ph-from-right-table>table").css("display","none");
        }
    },
    autoViewForStyle:function(div){
        jQuery("#styleManu>li:visible>div").css("backgroundColor","").css("color","");
        jQuery("#ph-from-right-table>table").css("display","none");
        jQuery(div).css("backgroundColor","#8db6d9").css("color","white");
        var styleId=jQuery(div).attr("title").strip();
        var styName=jQuery(div).attr("name").strip();
        var status=$("orderStatus").value.strip();
        jQuery("#"+styleId).show();
        jQuery("#ph-pic-img-border>img").attr("src","/pdt/"+styleId+"_1_2.jpg");
        jQuery("#ph-pic-img-txt").html(jQuery(div).text()+"<br/>"+styName);
        if(status!='2')
        jQuery("#"+styleId+" td>input:first").focus();
        jQuery("#totStyleCan").html(jQuery("#"+styleId).attr("name"));
        jQuery("#totStyleRem").html(jQuery("#"+styleId).attr("title"));
        var inputs=jQuery("#"+styleId+" td>input");
        var totStyleAlready=0;
        for(var i=0;i<inputs.length;i++){
            if(i==0&&status!='2'){
                inputs[i].focus();
            }
            var coun=parseInt(inputs[i].value,10);
            totStyleAlready+=isNaN(coun)?0:coun;
        }
        jQuery("#totStyleAlready").html(totStyleAlready);
    },
    listener:function(){
        jQuery(document).bind("keyup",function(event){
            if(event.ctrlKey==true&&event.which==38){
                var divs=jQuery("#styleManu>li>div");
                var len=divs.length;
                if(len>1){
                    var tar;
                    divs.each(function(i){
                        if(this.style.color=='white'){
                            tar=i;
                        }
                    });
                    if(tar>0){
                        jQuery(divs[tar-1]).click();
                    }else{
                        jQuery(divs[len-1]).click();
                    }
                }
            }
            else if(event.ctrlKey==true&&event.which==40){
                var divs=jQuery("#styleManu>li>div");
                var len=divs.length;
                if(len>1){
                    var tar;
                    divs.each(function(i){
                        if(this.style.color=='white'){
                            tar=i;
                        }
                    });
                    if(tar<len-1){
                        jQuery(divs[tar+1]).click();
                    }else{
                        jQuery(divs[0]).click();
                    }
                }
            }
        });
        jQuery("#styleManu>li>div").bind("click",function(){
            dist.autoViewForStyle(this);
        });
        jQuery("#ph-from-right-table>table td>input").bind("focus",function(){

            var barcode_data=dist.get_barcode_qty(jQuery(this).attr("barcode"));
            var totBarcodeAlready=barcode_data.qtyAl;

            jQuery("#barcodeAlready").html(totBarcodeAlready);
            jQuery("#barcodeRem").html(barcode_data.qtyRem);
            dwr.util.selectRange(this,0,100);
            jQuery("#totStyleAlready").html(jQuery("#"+jQuery(this).attr("sty")+"-tot").html());
        });
        jQuery("#quickSearch").bind("keyup",function(){
            var sty=this.value.strip();
            var reg=new RegExp(sty,"i");
            jQuery("#styleManu>li").hide();
            jQuery("#styleManu>li>div").each(function(){
                if(reg.test(this.innerHTML)){
                    jQuery(this).parent("li").show();
                }
            });
            dist.autoShowManuAndItem();
        });
        jQuery("#ph-from-right-table>table td>input").bind("keyup",function(event){
            if(event.target==this){
                
                if((event.which>=48&&event.which<=57)||(event.which>=96&&event.which<=105)){
                    $("isChanged").value='true';
                    if(this.value.strip()!=""){
                        var count=parseInt(this.value.strip(),10);
                        this.value=count;
                        if(isNaN(count)||count<0){
                            alert("请输入非负的整数！");
                            this.value=0;
                            dwr.util.selectRange(this,0,20);
                        }
                    }
                    var now_qty=parseInt(this.value,10);
                    
                    var cellData={};
                    cellData.store=jQuery(this).attr("store");
                    cellData.barcode=jQuery(this).attr("barcode");
                    var cell=dist.v2m_get_ret(cellData)[0];
                    
                    var old_qty=cell.qtyAl;
                    
                    var barcode_data=dist.get_barcode_qty(cellData.barcode);
                    var qty_can=barcode_data.qtyCan;
                    var qty_rem=parseInt(barcode_data.qtyRem,10);
                    var qty_al=parseInt(barcode_data.qtyAl,10);
                    var qty_change=now_qty-old_qty;
                    if(qty_change>qty_can||(qty_change+qty_al)>qty_rem){
                    	alert("已配量不得大于可配量和未配量！");
                    	this.value = 0;
                    	dwr.util.selectRange(this,0,100);
                    }
                   	var new_qty=parseInt(this.value,10);
                   	var real_qty_change=new_qty-old_qty;
                   	var cellData1={};
                   	cellData1.sty=jQuery(this).attr("sty");
                   	cellData1.barcode=jQuery(this).attr("barcode");
                   	cellData1.size=jQuery(this).attr("size");
                   	cellData1.color=jQuery(this).attr("color");
                   	cellData1.store=jQuery(this).attr("store");
                   	cellData1.qtyAl=new_qty;
                   	
                   	dist.update_for_cell_change(cellData1,real_qty_change);
                   	jQuery("#barcodeAlready").html(dist.get_barcode_qty(cellData.barcode).qtyAl);
                   	jQuery("#totStyleAlready").html(jQuery("#"+jQuery(this).attr("sty")+"-tot").html());
                }else if(event.which==37||event.which==39||event.which==38||event.which==40){
                	var row=jQuery(jQuery(this).parents("tr")[0]).find("input");
                	var indexOfRow=row.index(this);
                	var col=jQuery("#ph-from-right-table>table:visible td>input[name="+this.name+"]");
                	var indexOfCol=col.index(this);
                	if(event.which==37){
                    if(indexOfRow>0){
                        row[indexOfRow-1].focus();
                    }else{
                        row[row.length-1].focus();
                    }
                	}else if(event.which==39){
                    if(indexOfRow<(row.length-1)){
                        row[indexOfRow+1].focus();
                    }else{
                        row[0].focus();
                    }
               		}else if(event.which==38){
                    if(indexOfCol>0){
                        col[indexOfCol-1].focus();
                    }else{
                        col[col.length-1].focus();
                    }
                	}else if(event.which==40){
                    if(indexOfCol<col.length-1){
                        col[indexOfCol+1].focus();
                    }else{
                        col[0].focus();
                    }
                	}
              	}
            }
        });
        jQuery("#ph-from-right-table>table td>input").bind("keydown",function(event){
            if(event.which==13){
                if(jQuery("#ph-from-right-table>table:visible input")[jQuery("#ph-from-right-table>table:visible input").index(this)+1]){
                    jQuery("#ph-from-right-table>table:visible input")[jQuery("#ph-from-right-table>table:visible input").index(this)+1].focus();
                }else{
                    jQuery("#ph-from-right-table>table:visible input")[0].focus();
                }
            }
        });
    },
    getStyTotRem:function(style){
        var colors=style.color;
        var rem=0;
        for(var i=0;i<colors.length;i++){
            for(var j=0;j<colors[i].qtyrem.length;j++){
                rem+=isNaN(parseInt(colors[i].qtyrem[j],10))?0:parseInt(colors[i].qtyrem[j],10);
            }
        }
        return rem;
    },
    getStyTotCan:function(style){
        var colors=style.color;
        var can=0;
        for(var i=0;i<colors.length;i++){
            for(var j=0;j<colors[i].qtycan.length;j++){
                can+=isNaN(parseInt(colors[i].qtycan[j],10))?0:parseInt(colors[i].qtycan[j],10);
            }
        }
        return can;
    },
    pdtToJson:function(pdt){
        var pdts=new Array();
        if(this.checkIsArray(pdt)){
            for(var i=0;i<pdt.length;i++){
                pdts[i]={};
                pdts[i].pdtStyle=pdt[i].xmlns;
                pdts[i].dis=pdt[i].value;
                pdts[i].id=pdt[i].M_PRODUCT_LIST;
                pdts[i].color=this.colorToJson(pdt[i].color);
            }
        }else{
            pdts[0]={};
            pdts[0].pdtStyle=pdt.xmlns;
            pdts[0].dis=pdt.value;
            pdts[0].id=pdt.M_PRODUCT_LIST;
            pdts[0].color=this.colorToJson(pdt.color);
        }
        return pdts;
    },
    colorToJson:function(color){
        var colors=new Array();
        if(this.checkIsArray(color)){
            for(var i=0;i<color.length;i++){
                colors[i]={};
                colors[i].colorName=color[i].xmlns;
                colors[i].rowSpan=this.getColorSpan(color[i]);
                colors[i].stors=this.storToJson(color[i].array.c_store);
                colors[i].sizes=this.getSizes(color[i].array.tag_c);
                colors[i].qtyrem=this.getQtyrem(color[i].array.tag_c);
                colors[i].barcode=this.getBarcode(color[i].array.tag_c);
                colors[i].qtycan=this.getQtycan(color[i].array.tag_c);
                colors[i].qtyorder=this.getOrder(color[i].array.tag_c);
                colors[i].qtyallot=this.getAllot(color[i].array.tag_c);
                colors[i].qtyso=this.getSo(color[i].array.tag_c);
            }
        }else{
            colors[0]={};
            colors[0].colorName=color.xmlns;
            colors[0].rowSpan=this.getColorSpan(color);
            colors[0].stors=this.storToJson(color.array.c_store);
            colors[0].sizes=this.getSizes(color.array.tag_c);
            colors[0].qtyrem=this.getQtyrem(color.array.tag_c);
            colors[0].barcode=this.getBarcode(color.array.tag_c);
            colors[0].qtycan=this.getQtycan(color.array.tag_c);
            colors[0].qtyorder=this.getOrder(color.array.tag_c);
            colors[0].qtyallot=this.getAllot(color.array.tag_c);
            colors[0].qtyso=this.getSo(color.array.tag_c);
        }
        return colors;
    },
    getSo:function(tags){
        var so=new Array();
        if(this.checkIsArray(tags)){
            for(var i=0;i<tags.length;i++){
                so[i]=tags[i].content?tags[i].QTY_SO:"no";
            }
        }else{
            so[0]=tags.content?tags.QTY_SO:"no";
        }
        return so;
    },
    getAllot:function(tags){
        var allot=new Array();
        if(this.checkIsArray(tags)){
            for(var i=0;i<tags.length;i++){
                allot[i]=tags[i].content?tags[i].QTY_ALLOT:"no";
            }
        }else{
            allot[0]=tags.content?tags.QTY_ALLOT:"no";
        }
        return allot;
    },
    getOrder:function(tags){
        var order=new Array();
        if(this.checkIsArray(tags)){
            for(var i=0;i<tags.length;i++){
                order[i]=tags[i].content?tags[i].DESTQTY:"no";
            }
        }else{
            order[0]=tags.content?tags.DESTQTY:"no";
        }
        return order;
    },
    getQtycan:function(tags){
        var qtycan=new Array();
        if(this.checkIsArray(tags)){
            for(var i=0;i<tags.length;i++){
                qtycan[i]=tags[i].content?tags[i].QTYCAN:"no";
            }
        }else{
            qtycan[0]=tags.content?tags.QTYCAN:"no";
        }
        return qtycan;
    },
    getBarcode:function(tags){
        var barcode=new Array();
        if(this.checkIsArray(tags)){
            for(var i=0;i<tags.length;i++){
                barcode[i]=tags[i].content?tags[i].m_product_alias_id:"no";
            }
        }else{
            barcode[0]=tags.content?tags.m_product_alias_id:"no";
        }
        return barcode;
    },
    getQtyrem:function(tags){
        var rems=new Array();
        if(this.checkIsArray(tags)){
            for(var i=0;i<tags.length;i++){
                rems[i]=tags[i].content?tags[i].QTYREM:"no";
            }
        }else{
            rems[0]=tags.content?tags.QTYREM:"no";
        }
        return rems;
    },
    getSizes:function(tags){
        var sizes=new Array();
        if(this.checkIsArray(tags)){
            for(var i=0;i<tags.length;i++){
                sizes[i]=tags[i].content?tags[i].content:tags[i];
            }
        }else{
            sizes[0]=tags.content?tags.content:tags;
        }
        return sizes;
    },
    storToJson:function(stor){
        var stors=new Array();
        if(this.checkIsArray(stor)){
            for(var i=0;i<stor.length;i++){
                stors[i]={};
                stors[i].name=stor[i].c_sname;
                stors[i].id=stor[i].content;
            }
        }else{
            stors[0]={};
            stors[0].name=stor.c_sname;
            stors[0].id=stor.content;
        }
        return stors;
    },
    getColorSpan:function(colorDetail){
        var det=colorDetail.array.c_store;
        var count=4;
        if(this.checkIsArray(det)){
            count=3+det.length;
        }
        return count;
    },
    checkIsObject:function(o) {
        return (typeof(o)=="object");
    },
    checkIsArray: function(o) {
        return (this.checkIsObject(o) && (o.length) &&(!this.checkIsString(o)));
    },
    checkIsString:function (o) {
        return (typeof(o)=="string");
    },
    checkIsDate:function(month,date,year){
        if(parseInt(month,10)>12||parseInt(month,10)<1||parseInt(date,10)>31||parseInt(date,10)<1||parseInt(year,10)<1980||parseInt(year,10)>3000) {
            return false;
        }
        return true;
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
    _executeCommandEvent :function(evt){
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
    }
}
DIST.main = function () {
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