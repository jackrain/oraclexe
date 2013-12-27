var dist=null;
var DIST=Class.create();
DIST.prototype={
    initialize: function() {
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        dwr.util.setEscapeHtml(false);
        this.windowLocation=window.location;
    	  this.itemStr="";
        this.manuStr="";
        this.allot_id=null;
        this.manu=null;
        this.item=null;

        this.totCan=0;
        this.status=0;
        this.loadStatus="load";
    	  this.product=new Array();
    	  this.totCan=0;
    	  this.data=new Array();//向数据库获得数据组成单元数组
        this.dataForQtyCan={};//库存可用量JSON对象
        this.dataForStyleQtyAl={};//所有款已配量的json对象
        this.allQtyAl=0;//总已配量
        this.tot_can_dist=0;//自动配货总可配量
        this.bodyWidth=0;
        this.docNoes=new Array();
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
    },
    queryObject: function(style){
    	  this.itemStr="";
        this.manuStr="";
        this.allot_id=null;
        this.manu=null;
        this.item=null;

        this.totCan=0;
        this.status=0;
        this.loadStatus="load";
    	  this.product=new Array();
    	  this.totCan=0;
    	  this.data=new Array();//向数据库获得数据组成单元数组
        this.dataForQtyCan={};//库存可用量JSON对象
        this.dataForStyleQtyAl={};//所有款已配量的json对象
        this.allQtyAl=0;//总已配量
        this.tot_can_dist=0;//自动配货总可配量
        this.bodyWidth=0;
        this.docNoes=new Array();
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="DO_QUERY";
        var load_type=$("load_type").value;
        var reg=/^\d{8}$/;
        var m_allot_id=$("fund_balance").value||"-1";
        if(style&&style=='doc'){
            if(!$('column_41520').value){
                alert("单据号不能为空！");
                return;
            }
           var searchord=$('column_41520').value;
           var param={"or_type":"","c_dest":"","c_orig":"","m_product":"",
                "datest":"","datend":"","load_type":load_type,"m_allot_id":m_allot_id,"searchord":searchord,"porder":-1};
        }else{
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
            var param={"or_type":doctype,"c_dest":orig_in_sql,"c_orig":orig_out_fk,"m_product":product_filter,
                "datest":billdatebeg,"datend":billdateend,"load_type":load_type,
                "m_allot_id":m_allot_id,"searchord":"","porder":-1};
        }
        evt.param=Object.toJSON(param);
        evt.table="m_allot";
        evt.action="distribution";
        evt.permission="r";
        jQuery("#ph-from-right-table").html("");
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
        var distdate=jQuery("#Documents").is(":hidden")?jQuery("#distdate").val():jQuery("#distdate1").val();
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
        //Edit by Robin 2010.5.10 内存中取数据保存
        if(this.data.length<1){
            alert("没有数据可以保存！");
            return;
        }
        for(var i=0;i<this.data.length;i++){
        	if(parseInt(this.data[i].qtyAl,10)>=0){
        		var ii={};
        		ii.qty_ady=this.data[i].qtyAl;
        		ii.m_product_alias_id=this.data[i].barCode;
        		ii.docno=this.data[i].docNo;
        		m_item.push(ii);
        	}
        }
        //end
        var param={};
        param.type=type;
        param.m_allot_id=m_allot_id;
        param.notes=$("orderNotes").value.strip()||$("notes").value.strip()||"";
        param.m_item=(m_item.length==0?"null":m_item);
        param.saletypeid=(jQuery("#Details:visible")[0])?jQuery("#saletype").val():jQuery("#docsaletype").val();
        
        //Edit by Robin 2010-4-28
        param.distdate=distdate;
        //end

        evt.param=Object.toJSON(param);
        //alert(Object.toJSON(param));
        evt.table="m_allot";
        evt.action="save";
        evt.permission="r";
        evt.isclob=true;
        this._executeCommandEvent(evt);
    },
    reShow:function(){
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="RELOAD";
        var m_allot_id=$("fund_balance").value||"-1";
        var param={"or_type":"-1","c_dest":"-1","c_orig":"-1","m_product":"-1","datest":"-1","datend":"-1","load_type":"reload","m_allot_id":m_allot_id,"porder":-1};
        evt.param=Object.toJSON(param);
        evt.table="m_allot";
        evt.action="distribution";
        evt.permission="r";
        this._executeCommandEvent(evt);
    },
    _onreShow:function(e){
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        $("column_26992").value=ret.C_ORIG||"";
        $("column_26993_fd").value=ret.DEST_FILTER||"(可用 = Y)";
        $("column_26994_fd").value=ret.Product_Filter||"";
        $("column_26995").value=ret.Billdatebeg||"";
        $("column_269966").value=ret.Billdateend||"";
        //alert(ret.distdate);
        jQuery("#distdate1").val(ret.distdate||"");
        jQuery("#distdate").val(ret.distdate||"");
        var isArray=ret.isarray;
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
            jQuery("#ph-serach-bg>div input[type='image']").hide();

            alert("保存成功！");
            $("isChanged").value="false";
            jQuery("#amount").html(ret.feeallot||0).css("display","");
            jQuery("#amount1").html(ret.feeallot||0).css("display","");
        }else if(ret.data=="YES"){
            this.status=0;
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
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.NAME||"")+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEEREMAIN||0)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEECHECKED||0)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEELTAKE||0)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEECANTAKE||0)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEEALLOT||0)+"</div></td>"+
                             "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(funditem[i].facusitem.FEEREM||0)+"</div></td>"+
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
    showDetail:function(){
        $('Details').style.display='';$('Documents').style.display='none';
        $("tot-can").innerHTML="";
        $("tot-rem").innerHTML="";
        $("tot-ready").innerHTML="";
        $("input-5").innerHTML="";
        $("input-4").innerHTML="";
        $("input-2").innerHTML="";
        $("rs").innerHTML="";
        $("input-1").innerHTML="";
        jQuery("#ph-serach-bg table td span[id$='_link']").attr("title","popup");
        jQuery("#ph-serach-bg table td span[id$='_link']>img[id$='_img']").attr("src","/html/nds/images/filterobj.gif");
        jQuery("#Documents input[id!='distdate1']").val("");
        jQuery("#category_manu").html("");
        jQuery("#ph-from-right-table").html("");
    },
    showDocuments:function(){
        $('Details').style.display='none';$('Documents').style.display='';
        $("tot-can").innerHTML="";
        $("tot-rem").innerHTML="";
        $("tot-ready").innerHTML="";
        $("input-5").innerHTML="";
        $("input-4").innerHTML="";
        $("input-2").innerHTML="";
        $("rs").innerHTML="";
        $("input-1").innerHTML="";
        jQuery("#ph-serach-bg table td span[id$='_link']").attr("title","popup");
        jQuery("#ph-serach-bg table td span[id$='_link']>img[id$='_img']").attr("src","/html/nds/images/filterobj.gif");
        jQuery("#Details input[name!='billdatebeg'][name!='billdateend'][id!='distdate']").val("");
        jQuery("#category_manu").html("");
        jQuery("#ph-from-right-table").html("");
    },
    _onLoadMetrix:function(e){
    	var datastart=new Date();
        window.self.onunload=function(){
               var e=window.opener||window.parent;
               e.setTimeout("pc.doRefresh()",1);
         }
        dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        this.manuStr="";
        this.itemStr="";
        if(ret.data&&ret.data=="null"){
            $("ph-from-right-table").innerHTML="<div style='font-size:20px;color:red;text-align:center;font-weight:bold;vertical-align:middle'>没有数据！</div>";
            return;
        }
         $("isChanged").value='false';
         if(ret.saletypeid){
        		jQuery("#saletype option[value='"+ret.saletypeid+"']").attr("selected","true");
        		jQuery("#docsaletype option[value='"+ret.saletypeid+"']").attr("selected","true");
       	 	}
        if(ret.searchord){
            $('Details').style.display='none';$('Documents').style.display='';
            $("commonNotes").value=ret.description||"";

            $("orderNotes").value=ret.notes||"";
            $("column_41520_fd").value=ret.searchord;
        }else{
            $("notes").value=ret.notes||"";
            $('Details').style.display='';$('Documents').style.display='none';
        }
        var orderAmount=ret.feeallot||0;
        jQuery("#amount").html(orderAmount).css("display","");
        jQuery("#amount1").html(orderAmount).css("display","");
        if(ret.p_display==1){
            jQuery("#docnoType").show();
            jQuery("#idocnoType").show();
        }
        //alert(Object.toJSON(ret));
        var pdt=new Array();
        var totCan=0;
        var totRem=0;
        if(this.checkIsArray(ret.data.m_product)){
            pdt=ret.data.m_product;
        }else{
            pdt[0]=ret.data.m_product;
        }
        for(var ii=0;ii<pdt.length;ii++) {
            var ptotRem=0;
            var ptotCan=0;
            
            if(ii==0){
                $("ph-pic-img-txt").innerHTML=pdt[ii].xmlns+" <br/>"+pdt[ii].value;
                $("pdt-img").src = "/pdt/"+pdt[ii].M_PRODUCT_LIST+"_1_2.jpg";
            }
            this.manuStr+="\n<li><div class=\"txt-on\"  onclick='javascript:$(\"pdt-img\").src = \"/pdt/"+pdt[ii].M_PRODUCT_LIST+"_1_2.jpg\";" +
                          "$(\"ph-pic-img-txt\").innerHTML=\""+pdt[ii].xmlns+"<br/>"+pdt[ii].value+"\";" +
                          "dist.showContent1(\""+pdt[ii].xmlns+"\");" +
                          "this.style.backgroundColor=\"#8db6d9\"; this.style.color=\"white\";'"+
                          (ii==0?"  style='background:#8db6d9;color:white'":"")+">"+pdt[ii].xmlns+"</div></li>\n";
            var itemColor=pdt[ii].color;
            if(!itemColor){
                alert("此单据已失效！");
                return;
            }
            var colorArr=new Array();
            colorArr=this.forMetrixChangeToArr(itemColor);
            var sizeArr=colorArr[0].stores[0].docnos[0].tag.size;
            var tagLen=sizeArr.length;
            var item="";
						var style_y_length=0;
						var style_x_length=colorArr[0].stores[0].docnos[0].tag.size.length;
            for(var p=0;p<colorArr.length;p++){
                for(var pp=0;pp<colorArr[p].stores.length;pp++){
                    for(var ppp=0;ppp<colorArr[p].stores[pp].docnos.length;ppp++){
                    	  style_y_length++;
                        for(var w=0;w<colorArr[p].stores[pp].docnos[ppp].tag.size.length;w++){
                            
                            /**
                             * edit by Robin 2010.5.6
                             * 增加以配货编辑单元格为单元
                             */
                             var qtyAl=colorArr[p].stores[pp].docnos[ppp].tag.qtyAl[w]!='non'?parseInt(colorArr[p].stores[pp].docnos[ppp].tag.qtyAl[w],10):0;//已配量
                             var qtyCan = colorArr[p].stores[pp].docnos[ppp].tag.can[w]!='non'?parseInt(colorArr[p].stores[pp].docnos[ppp].tag.can[w],10):0;//可用库存
                             var qtyRem = colorArr[p].stores[pp].docnos[ppp].tag.rem[w]!='non'?parseInt(colorArr[p].stores[pp].docnos[ppp].tag.rem[w],10):0;//订单余量
                             var qtyDest= colorArr[p].stores[pp].docnos[ppp].tag.dest[w]!='non'?parseInt(colorArr[p].stores[pp].docnos[ppp].tag.dest[w],10):0;//订单量
                          if(colorArr[p].stores[pp].docnos[ppp].tag.barCode[w]!='non'){
                            var cellData={};//每个单元的数据，即配货编辑的单元
                            cellData.sty = pdt[ii].xmlns;//款号
                            cellData.color = colorArr[p].name;//色号
                            cellData.size =  colorArr[p].stores[pp].docnos[ppp].tag.size[w] ;//尺寸
                            cellData.docNo  =colorArr[p].stores[pp].docnos[ppp].no;//所需订单号
                            cellData.billData =colorArr[p].stores[pp].docnos[ppp].date; //订单日期（不重要）
                            cellData.docType =colorArr[p].stores[pp].docnos[ppp].type;//订单类型
                            cellData.store = colorArr[p].stores[pp].name;//店仓
                            cellData.barCode =colorArr[p].stores[pp].docnos[ppp].tag.barCode[w];//所属条码
                            cellData.qtyAl = isNaN(parseInt(qtyAl))?0:parseInt(qtyAl);

                            cellData.qtyCan = isNaN(parseInt(qtyCan))?0:parseInt(qtyCan);
                            cellData.qtyRem = isNaN(parseInt(qtyRem))?0:parseInt(qtyRem);//订单余量
                            cellData.qtyDest= isNaN(parseInt(qtyDest))?0:parseInt(qtyDest);//订单量
                            this.data.push(cellData);
                            /* end */
                          }
                            totCan+=qtyCan;
                            totRem+=qtyRem;
                            ptotCan+=qtyCan;
                            ptotRem+=qtyRem;
                        }
                        var ss=colorArr[p].stores[pp].docnos[ppp].type;
                        for(var con=0;con<4;con++){
                            item+="<tr>";
                            if(pp==0&&ppp==0&&con==0){
                                item+= "<td rowspan=\""+this.forColorSpan(colorArr[p])+"\" valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-left-txt\">"+colorArr[p].name+"</td>";
                            }
                            if(ppp==0&&con==0){
                                item+="<td rowspan=\""+this.forStorSpan(colorArr[p].stores[pp])+"\" valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-left-txt01\">"+colorArr[p].stores[pp].name+"</td>"
                            }
                            if(con==0){
                                var v0=0;
                                this.docNoes.push(colorArr[p].stores[pp].docnos[ppp].no);
                                item+="<td rowspan=\"4\" valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-bg\""+(ss=='FWD'?" style='color:blue;'":"")+">"+colorArr[p].stores[pp].docnos[ppp].no+"</td>"+
                                      "<td rowspan=\"4\" valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-bg\""+(ss=='FWD'?" style='color:blue;'":"")+">"+this.forChangeType(colorArr[p].stores[pp].docnos[ppp].type)+"</td>"+
                                      "<td rowspan=\"4\" valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-bg\""+(ss=='FWD'?" style='color:blue;'":"")+">"+this.forChangeDate(colorArr[p].stores[pp].docnos[ppp].date)+"</td>"+
                                      "<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txt\""+(ss=='FWD'?" style='color:blue;'":"")+">配货</td>";
                                for(var w=0;w<colorArr[p].stores[pp].docnos[ppp].tag.size.length;w++){
                                    var itemMetrixTr=colorArr[p].stores[pp].docnos[ppp].tag.can[w];
                                    var barCode=colorArr[p].stores[pp].docnos[ppp].tag.barCode[w];
                                    var qtyAl=parseInt(colorArr[p].stores[pp].docnos[ppp].tag.qtyAl[w],10);
                                    var qtyRem=parseInt(colorArr[p].stores[pp].docnos[ppp].tag.rem[w],10);
                                    var qtyDest= colorArr[p].stores[pp].docnos[ppp].tag.dest[w]!='non'?parseInt(colorArr[p].stores[pp].docnos[ppp].tag.dest[w],10):0;
                                    var qtyCan = colorArr[p].stores[pp].docnos[ppp].tag.can[w]!='non'?parseInt(colorArr[p].stores[pp].docnos[ppp].tag.can[w],10):0;
                                    var docno=colorArr[p].stores[pp].docnos[ppp].no;
                                    qtyAl=isNaN(qtyAl)?0:qtyAl;
                                    qtyRem=isNaN(qtyRem)?0:qtyRem;
                                    v0+=qtyAl;
                                    //edit by Robin 2010.5.7 在配货的input中增加属性：barCode,sty,docNo,store。。。
                                    item+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-bg\""+(itemMetrixTr=='non'?" style=\"background-color:#eeeeee\"":"")+">"+(itemMetrixTr!='non'?"<input id='"+pdt[ii].xmlns+"-"+this.get_cell_x_index(w)+"-"+(style_y_length-1)+"' x-index='"+this.get_cell_x_index(w)+"' y-index='"+(style_y_length-1)+"' qtyCan='"+qtyCan+"' qtyRem='"+qtyRem+"' qtyDest='"+qtyDest+"' title='"+barCode+"' barCode='"+barCode+"' color=\""+colorArr[p].name+"\"  size=\""+colorArr[p].stores[pp].docnos[ppp].tag.size[w]+"\" docNo=\""+docno+"\" store=\""+colorArr[p].stores[pp].name+"\" sty=\""+pdt[ii].xmlns+"\" name=\""+docno+"\" type=\"text\" docType='"+ss+"' class=\"td-txt-input\" value=\""+(qtyAl==0?'':qtyAl)+"\"/>":"")+"</td>";
                                }
                                item+="<td id='"+(colorArr[p].name+docno+colorArr[p].stores[pp].name)+"' valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txtW\">"+v0+"</td>";
                            }
                            if(con==1){
                                var v1=0;
                                item+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txt\""+(ss=='FWD'?" style='color:blue;'":"")+">可用库存</td>";
                                for(var w=0;w<colorArr[p].stores[pp].docnos[ppp].tag.size.length;w++){
                                    var itemMetrixTr=colorArr[p].stores[pp].docnos[ppp].tag.can[w];
                                    var barCode=colorArr[p].stores[pp].docnos[ppp].tag.barCode[w];
                                    v1+=isNaN(parseInt(itemMetrixTr,10))?0:parseInt(itemMetrixTr,10);
                                    item+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txtK\""+(itemMetrixTr=='non'?" style=\"background-color:#eeeeee\"":" name='"+barCode+"' title='"+itemMetrixTr+"' docType='"+ss+"'")+">"+(itemMetrixTr!='non'?itemMetrixTr:"")+"</td>";
                                }
                                item+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txtW\">"+v1+"</td>";
                            }
                            if(con==2){
                                var v2=0;
                                item+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txt\""+(ss=='FWD'?" style='color:blue;'":"")+">订单余量</td>";
                                for(var w=0;w<colorArr[p].stores[pp].docnos[ppp].tag.size.length;w++){
                                    var itemMetrixTr=colorArr[p].stores[pp].docnos[ppp].tag.rem[w];
                                    var docno=colorArr[p].stores[pp].docnos[ppp].no;
                                    var barCode=colorArr[p].stores[pp].docnos[ppp].tag.barCode[w];
                                    v2+=isNaN(parseInt(itemMetrixTr,10))?0:parseInt(itemMetrixTr,10);
                                    item+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txtW\""+(itemMetrixTr=='non'?" style=\"background-color:#eeeeee\"":" id='"+(docno+barCode)+"-rem' docType='"+ss+"'")+">"+(itemMetrixTr!='non'?itemMetrixTr:"")+"</td>";
                                }
                                item+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txtW\">"+v2+"</td>";
                            }
                            if(con==3){
                                var v3=0;
                                item+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txt\""+(ss=='FWD'?" style='color:blue;'":"")+">订单数量</td>";
                                for(var w=0;w<colorArr[p].stores[pp].docnos[ppp].tag.size.length;w++){
                                    var        	
 itemMetrixTr=colorArr[p].stores[pp].docnos[ppp].tag.dest[w];
                                    v3+=isNaN(parseInt(itemMetrixTr,10))?0:parseInt(itemMetrixTr,10);
                                    item+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txtD\""+(itemMetrixTr=='non'?" style=\"background-color:#eeeeee\"":" docType='"+ss+"'")+">"+(itemMetrixTr!='non'?itemMetrixTr:"")+"</td>";
                                }
                                item+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txtW\">"+v3+"</td>";
                            }
                            item+="</tr>";
                        }
                    }
                }
            }
            this.itemStr+="<table id='"+pdt[ii].xmlns+ "' x-length='"+style_x_length+"' y-length='"+style_y_length+"' title=\""+ptotCan+":"+ptotRem+"\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\"  bgcolor=\"#8db6d9\""+(ii!=0?" style='display:none;table-layout:fixed'":" style='table-layout:fixed'")+">\n";
            this.itemStr+=this.forTableShowStyle(tagLen)+"<tr>"+
                          "<td bgcolor=\"#FFFFFF\" class=\"td-left-title\">色号</td>"+
                          "<td bgcolor=\"#FFFFFF\" class=\"td-left-title\">店仓</td>" +
                          "<td bgcolor=\"#FFFFFF\" class=\"td-left-title\">订单号</td>" +
                          "<td bgcolor=\"#FFFFFF\" class=\"td-left-title\">订单类型</td>" +
                          "<td bgcolor=\"#FFFFFF\" class=\"td-left-title\">发货日期</td>"+
                          "<td bgcolor=\"#FFFFFF\" class=\"td-left-title\">尺寸</td>";
            /*
            Edit by Robin 2010.5.10 新增列合计及总款合计
            */
            var tot_qty_al_for_col="<tr>"+
                    "<td bgcolor=\"#FFFFFA\" class=\"td-left-title\" colspan=\"6\">款已配量合计</td>";
            var tot_for_style=0;
            for(var e=0;e<sizeArr.length;e++){
                this.itemStr+="<td width='65' bgcolor=\"#B6D0E7\" class=\"td-right-title\">"+sizeArr[e]+"</td>";
                var col_tot= this.getTotQtyAlCol(sizeArr[e],pdt[ii].xmlns);
                tot_qty_al_for_col+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txtW\" ID='"+pdt[ii].xmlns+sizeArr[e]+"'>"+col_tot+"</td>";
                tot_for_style+=col_tot;                
            }
            tot_qty_al_for_col+="<td valign=\"top\" bgcolor=\"#8db6d9\" class=\"td-right-txtW\" ID='style-"+pdt[ii].xmlns+"'>"+tot_for_style+"</td>"+
                                "</tr>";
            this.itemStr+="<td bgcolor=\"#B6D0E7\" class=\"td-right-title\">合计</td>";
            this.itemStr+="</tr>";
            this.itemStr+=item;
            this.itemStr+=tot_qty_al_for_col;
            /*end*/
            this.itemStr+="</table>"
            if(ii==0){
                $("input-5").innerHTML=ptotCan;
                $("input-4").innerHTML=ptotRem;
            }
            this.product[ii]={};
            this.product[ii].name=pdt[ii].xmlns;
            this.product[ii].value=pdt[ii].value;
            this.product[ii].colors=colorArr;
            this.dataForStyleQtyAl[pdt[ii].xmlns]=this.get_style_qty_aly(pdt[ii].xmlns);
        }
        
        this.init_data_for_qtycan();
        this.allQtyAl=this.get_all_qty_aly();
        
        $("category_manu").innerHTML=this.manuStr;
        $("ph-from-right-table").innerHTML=this.itemStr;
        $("tot-can").innerHTML=totCan;
        $("tot-rem").innerHTML=totRem;
        $("fund_balance").value=ret.m_allot_id;
        $("showStyle").value="metrix";
        if($("load_type").value=="reload"){
            $('column_26991').disabled="true";
            jQuery("#Details table td input[name!=canModify]").attr("disabled","true");
            jQuery("#Details table td span[name!=canShow]").css("display","none");
            $("menu").style.display = "none";
            jQuery("#Documents>table input[name!=canModify]").attr("disabled","true");
            jQuery("#Documents>table td span[name!=canShow]").css("display","none");
        }
        if($("orderStatus").value=="2"){
            jQuery("#ph-from-right-table td input").attr("disabled","true");
        }
        this.autoView1();
        //alert(Object.toJSON(this.data));
        this.itemStr=null;
        this.docNoes=this.docNoes.uniq();
        var dataend=new Date();
        try{
            console.log("create page time:"+(dataend.getSeconds()-datastart.getSeconds()));
        }catch(e){
        }

    },

    /**
     * 得到单元格的x坐标
     * 此方法便于以后修改
    */
    get_cell_x_index:function(w){
    	return w;
    },
    /**
     * 得到单元格的y坐标
     * 此方法便于以后修改
    */    
    get_cell_y_index:function(p,pp,ppp){
    	return (p+1)*(pp+1)*(ppp+1)-1;
    },
    /**
     * 初始化this.dataForQtyCan
     * 此json对象中以条码为索引，保存库存可用量
     */     
    init_data_for_qtycan:function(){
    	var dataForTemp=this.data.slice(0);
    	while(dataForTemp.length>0){
    		var totAlForBarCode=0;
    		var barcode=dataForTemp[0].barCode;
    		var docType=dataForTemp[0].docType;
    		var qtyCan=parseInt(dataForTemp[0].qtyCan,10);
    		/*
    		数组逐渐减少，循环遍历，index递减
    		*/
    		var i=dataForTemp.length-1;
    		while(i>=0){
    			if(dataForTemp[i].barCode==barcode&&docType==dataForTemp[i].docType){
    				totAlForBarCode+=parseInt(dataForTemp[i].qtyAl,10);
    				dataForTemp.splice(i,1);
    			}
    			i--;
    		}
    		/*end*/
    		this.dataForQtyCan[barcode+docType]=qtyCan-totAlForBarCode;
    	}
    },
    /**
     * 当编辑一个单元格已配数据时，列已配数合计跟着改变。并更新总款合计数
     * 注意：此方法为同步实现(realQtyAlChange)以提高效率
     * @param size  尺寸
     * @param style  款号
     * @param realQtyAlChange 实际配货改变量
     */    
    update_style_tot_al_for_col:function(size,style,realQtyAlChange){
        var oldcoltot=parseInt(jQuery("#"+style+size).html(),10);
        jQuery("#"+style+size).html((oldcoltot+realQtyAlChange)+"");
        var oldstyletot=parseInt(jQuery("#style-"+style).html(),10);
        oldstyletot=isNaN(oldstyletot)?0:oldstyletot;
        jQuery("#style-"+style).html((oldstyletot+realQtyAlChange)+"");
    },
    /**
     * 根据款号的尺寸，得到该尺寸已配量的合计
     * @param size  尺寸
     * @param style  款号
     */
    getTotQtyAlCol:function(size,style){
        var cellData={};
        cellData.size=size;
        cellData.sty=style;
        var datas=this.v2m_get_ret(cellData);
        var tot=0;
        for(var i=0;i<datas.length;i++){
            tot+=parseInt(datas[i].qtyAl,10);
        }
        return tot;
    },
    /**
     * edit by Robin 2010.5.7
     * 传入一个JSON对象在this.data中查找符合的结果集数组并返回
     * @param cellData JSON对象可能含有color、size、docNo、store、barCode中多个或1个用此对象和this.data数组中的JSON对象比较
     */
    v2m_get_ret:function(cellData){
    		//alert(Object.toJSON(this.v2m_get_ret_any(cellData,this.data)));
        return this.v2m_get_ret_any(cellData,this.data);
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
            if((cellData.docType?data[i].docType==cellData.docType:true)&&(cellData.sty?data[i].sty==cellData.sty:true)&&(cellData.color?data[i].color==cellData.color:true)&&(cellData.size?data[i].size==cellData.size:true)&&(cellData.docNo?cellData.docNo==data[i].docNo:true)&&(cellData.store?cellData.store==data[i].store:true)&&(cellData.barCode?cellData.barCode==data[i].barCode:true)){
                result.push(data[i]);
            }
        }
        return result;			
		},
    /**
     * edit by Robin 2010.5.7
     * 根据cellData中的docNo、store、barCode定位this.data数组中的元素，并更新其中的qtyAl
     * @param cellData 含有docNo、store、barCode和qtyAl的JSON对象
     */
    update_v2mdata_celldata:function(cellData){
        if(cellData.docNo&&cellData.store&&cellData.barCode){
        		for(var i=0;i<this.data.length;i++){
        			if(cellData.docNo==this.data[i].docNo&&cellData.store==this.data[i].store&&cellData.barCode==this.data[i].barCode){
        				this.data[i].qtyAl=cellData.qtyAl||0;
        			}
        		}
        }
    },
    /**
     * edit by Robin 2010.5.7
     * 提供款号，算出该款总已配量
     * @param style 款号
     */
    get_style_qty_aly:function(style){
        if(style){
            var cellData={};
            cellData.sty=style;
            var datas=this.v2m_get_ret(cellData);
            var ret=0;
            for(var i=0;i<datas.length;i++){
                ret+=parseInt(datas[i].qtyAl,10);
            }
            return ret;
        }else{
            return 0;
        }
    },
    /**
     * edit by Robin 2010.5.11
     * 提供款号和实际配货改变量，更新该款总已配量
     * @param style 款号
     * @param realQtyAlChange 实际配货改变量
     */    
    update_style_qty_al:function(style,realQtyAlChange){
    	var old=parseInt(this.dataForStyleQtyAl[style],10);
    	this.dataForStyleQtyAl[style]=old+realQtyAlChange;
    },
    /**
     * edit by Robin 2010.5.7
     * 提供条码和订单类型，算出该码总的可配量
     * @param barCode 条码
     * @param docType 订单类型
     */
    get_barcode_can_dist:function(barCode,docType){
      if(barCode){
      	return parseInt(this.dataForQtyCan[barCode+docType],10);
      }else{
      	return 0;
      }
    },
    /**
     * edit by Robin 2010.5.12
     * 提供条码和订单类型，算出该码总的订单余量
     * @param barCode 条码
     * @param docType 订单类型
     */    
    get_qty_rem_for_all_order:function(barCode,docType){
    	var cellData={};
    	cellData.barCode=barCode;
    	cellData.docType=docType;
    	var datas=this.v2m_get_ret(cellData);
    	var sumQtyRem=0;
    	for(var i=0;i<datas.length;i++){
    		sumQtyRem+=parseInt(datas[i].qtyRem,10);
    	}
    	return sumQtyRem;
    },
    /**
     * edit by Robin 2010.5.11
     * 提供条码和实际配货改变量及订单类型，更新该条码总的可配量
     * @param barCode 条码
     * @param realQtyAlChange 实际配货改变量
     * @param docType 订单类型
     */    
    update_barcode_can_dist:function(barCode,docType,realQtyAlChange){
    	this.dataForQtyCan[barCode+docType]=parseInt(this.dataForQtyCan[barCode+docType],10)-realQtyAlChange;
    },
    /**
     * edit by Robin 2010.5.7
     * 计算总单已配量
     */
    get_all_qty_aly:function(){
        var ret=0;
        for(var i=0;i<this.data.length;i++){
            ret+=parseInt(this.data[i].qtyAl,10);
        }
        return ret;
    },
    /**
     * edit by Robin 2010.5.7
     * 更新行合计（配货量）用cellData 中的color,docNo,store定位所有一行的配货量
     * 注意：行合计的单元ID是由color,docNo,store合起来的字符串
     * Edit by Robin 2010.5.11 修改 不用检索this.data中的符合一行的元素然后累加，而是直接修改行合计单元的数量
     * @param cellData 单元数据 必须有color,docNo,store属性
     * @param realQtyAlChange 实际单元配货编辑改变量
     */
    update_row_count:function(cellData,realQtyAlChange){
    		if(cellData.docNo&&cellData.store&&cellData.color){
      			var e =jQuery("#"+cellData.color+cellData.docNo+cellData.store);
      			e.html((parseInt(e.html(),10)+realQtyAlChange)+"");
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
    forChangeType:function(type){
        if(type=="FWD"){
            return "新货订单";
        }else if(type=="INS"){
            return "补货订单";
        }else{
            return "";
        }
    },
    /*
     ×让自动配货界面隐藏
     */     
    closeAuto:function(){
    	jQuery("#alert-auto-dist").hide();
    },
    exec_dist:function(){
     	if(!confirm("自动配货会清空已编辑内容，确认继续？")){
          return;
      }
    	var expr;
    	var expr0;
    	if(jQuery("#all-order").is(":checked")){
    		expr="#ph-from-right-table>table input[docType][sty][store]";
    		expr0="#ph-from-right-table>table input[docType][sty][store][value!=''][value!='0']";
    	}else{
    		expr="#ph-from-right-table>table:visible input[docType][sty][store]";
    		expr0="#ph-from-right-table>table:visible input[docType][sty][store][value!=''][value!='0']"
    	}
    	var dist_type=jQuery("#dist_type").val();
    	if(jQuery("#"+dist_type)[0]){
    		var dist_param=jQuery("#"+dist_type).val();
    	}
    	var tot_can_dist=parseInt(jQuery("#currentCan").html(),10);
    	tot_can_dist=isNaN(tot_can_dist)?0:tot_can_dist;
    	jQuery(expr0).each(function(){
    		dist.autoDistForCell(0,this);
    	});
    	if(dist_type=="specNumber"){
    		this.auto_dist_for_specNumber(dist_param,tot_can_dist,expr);
    	}else if(dist_type=="fowNotOrderPercent"){
    		this.auto_dist_for_fowNotOrderPercent(dist_param,tot_can_dist,expr);
    	}else if(dist_type=="fowOrderPercent"){
    		this.auto_dist_for_fowOrderPercent(tot_can_dist,expr);
    	}
    	jQuery("#alert-auto-dist").hide();
    },
    auto_dist_for_specNumber:function(dist_param,tot_can_dist,expr){
    	dist_param=parseInt(dist_param,10);
    	dist_param=isNaN(dist_param)?0:dist_param;
    	this.tot_can_dist=tot_can_dist;
    	jQuery(expr).each(function(){
    		var qtyCan=dist.get_barcode_can_dist(jQuery(this).attr("barCode"),jQuery(this).attr("docType"));
    		if(qtyCan>0){
		  		var qtyRem=parseInt(jQuery(this).attr("qtyRem"),10);
					
					var qty=Math.min(dist_param,qtyCan,qtyRem);
		  		if((dist.tot_can_dist-dist_param)<0){
		  			return;
		  		}
	  			dist.tot_can_dist-=dist.autoDistForCell(qty,this);
    		}
    	});
    },
    auto_dist_for_fowNotOrderPercent:function(dist_param,tot_can_dist,expr){
    	dist_param=parseFloat(dist_param);
    	dist_param=isNaN(dist_param)?0:dist_param;
    	this.tot_can_dist=tot_can_dist;
    	jQuery(expr).each(function(){
    		var qtyCan=dist.get_barcode_can_dist(jQuery(this).attr("barCode"),jQuery(this).attr("docType"));
    		if(qtyCan>0){
	    		var qty=parseInt(dist_param*parseInt(jQuery(this).attr("qtyRem"),10),10);
	    		if(qty>qtyCan){
	    			qty=qtyCan;
	    		}
	    		if((dist.tot_can_dist-qty)<0){
	    			return;
	    		}
    		 dist.tot_can_dist-=dist.autoDistForCell(qty,this);
    		}    		
    	});    	
    },
    auto_dist_for_fowOrderPercent:function(tot_can_dist,expr){
    	this.tot_can_dist=tot_can_dist;
    	jQuery(expr).each(function(){
    		var qtyCanDist=dist.get_barcode_can_dist(jQuery(this).attr("barCode"),jQuery(this).attr("docType"));
    		if(qtyCanDist>0){
		  		var qtyRem=parseInt(jQuery(this).attr("qtyRem"),10);
		  		var qtyCan=parseInt(jQuery(this).attr("qtyCan"),10);;
		  		var qtyRemForAllOrder=dist.get_qty_rem_for_all_order(jQuery(this).attr("barCode"),jQuery(this).attr("docType"));
		  		var percent=qtyRem/qtyRemForAllOrder;
		  		var qty=parseInt(percent*qtyCan,10);
		  		qty=qty>qtyRem?qtyRem:qty;
		  		if(qty>qtyCanDist){
		  			qty=qtyCanDist;
		  		}
		  		if((dist.tot_can_dist-qty)<0){
		  			return;
		  		}
		  		dist.tot_can_dist-=dist.autoDistForCell(qty,this);
		  	}
    	});     
    },        
    /*
     ×显示自动配货界面
     */    
    autoDist:function(){
      if($("orderStatus").value=="2"){
          return;
      }    	
    	jQuery("#alert-auto-dist").show();
    	var tot_can=parseInt(jQuery("#tot-can").html(),10);
    	
    	var tot_can1=parseInt(jQuery("#input-5").html(),10);
    	
    	jQuery("#all-order").attr("checked","checked");
    	jQuery("#all-order").attr("can-dist",tot_can);
    	jQuery("#current-style").attr("can-dist",tot_can1);
    	jQuery("#all-can-dist").html(tot_can+"");
    	jQuery("#percentage").val(1);
    	jQuery("#currentCan").html(tot_can+"");
      $("isChanged").value='true';
    },
    /*
     ×@param qty 自动要编辑的数量
     *@param e 所要编辑的单元
     * 返回实际配货数量
     */     
    autoDistForCell:function(qty,e){
    	var cellData1={};
      cellData1.barCode=jQuery(e).attr("barCode");
      cellData1.docNo = jQuery(e).attr("docNo");
      cellData1.store=jQuery(e).attr("store");
      
      var dataCell1=dist.v2m_get_ret(cellData1)[0];
      var oldQtyAl=parseInt(dataCell1.qtyAl,10);//未编辑前的单元的已配量
      var nowQty=qty;
      
      var qtyAlChange=nowQty-oldQtyAl;//改变的数量
      
      var barCodeCanDist=dist.get_barcode_can_dist(jQuery(e).attr("barCode"),jQuery(e).attr("docType"));
     	var qtyRem=parseInt(dataCell1.qtyRem,10);
      if(qtyAlChange>barCodeCanDist||nowQty>qtyRem) {
      	return 0;
      }else{
        var cellData={};
        jQuery(e).val(qty);
        cellData.color = jQuery(e).attr("color");
        cellData.barCode=jQuery(e).attr("barCode");
        cellData.docNo = jQuery(e).attr("docNo");
        cellData.store=jQuery(e).attr("store");
        cellData.qtyAl=qty;
        cellData.sty=jQuery(e).attr("sty");
        cellData.docType=jQuery(e).attr("docType");
        cellData.size=jQuery(e).attr("size");
        var realQtyAlChange=qty-oldQtyAl;//实际单元配货量改变数
       	dist.update_when_cell_real_change(cellData,realQtyAlChange);
       	return qty;
      }
    },
    allOrderDist:function(){
    	var all_order_can_dist=parseInt(jQuery("#all-order").attr("can-dist"),10);
    	var percentage=jQuery("#percentage").val();
      percentage=isNaN(parseFloat(percentage))?0:parseFloat(percentage);
    	jQuery("#all-can-dist").html(all_order_can_dist);
    	jQuery("#currentCan").html(parseInt(all_order_can_dist*percentage,10));
    },
    currentStyleDist:function(){
    	var current_style_can_dist=parseInt(jQuery("#current-style").attr("can-dist"),10);
    	var percentage=jQuery("#percentage").val();
      percentage=isNaN(parseFloat(percentage))?0:parseFloat(percentage);
    	jQuery("#all-can-dist").html(current_style_can_dist);
    	jQuery("#currentCan").html(parseInt(current_style_can_dist*percentage,10));
  	},
    /*
     ×Json对象转化为数组
     ×itemColor:后台传入的color数组或者对象（第一层）
     */    
    forMetrixChangeToArr:function(itemColor){
        var colorArr=new Array();
        if(this.checkIsArray(itemColor)){
            for(var i=0;i<itemColor.length;i++){
            	var itemStore=itemColor[i].c_store;
            	colorArr[i]={};
                colorArr[i].name=itemColor[i].xmlns;
                colorArr[i].stores=this.forItemStorChangeToArr(itemStore);
            }
          }else{
          	var itemStore=itemColor.c_store;
          	colorArr[0]={};
          	colorArr[0].name=itemColor.xmlns;
          	colorArr[0].stores=this.forItemStorChangeToArr(itemStore);
          }
        return colorArr;
    },
    /*
     ×Json对象转化为数组
     ×itemStore:color的下一层（第二层）门店层数组或者对象
     */     
    forItemStorChangeToArr:function(itemStor){
    	var storArr=new Array();
    	if(this.checkIsArray(itemStor)){
    		for(var j=0;j<itemStor.length;j++){
           	var itemDocno=itemStor[j].w.docno;
           	storArr[j]={};
	        storArr[j].name=itemStor[j].xmlns;
	        storArr[j].docnos=this.forItemDocnoChangeToArr(itemDocno);
          }
    	}else{
    		var itemDocno=itemStor.w.docno;
    		storArr[0]={};
	        storArr[0].name=itemStor.xmlns;
	        storArr[0].docnos=this.forItemDocnoChangeToArr(itemDocno);
    	}
    	return storArr;
    },
    /*
     ×Json对象转化为数组
     ×itemDocno:store的下一层（第三层）订单号层数组或者对象
     */      
    forItemDocnoChangeToArr:function(itemDocno){
    	var docnoArr=new Array();
    	if(this.checkIsArray(itemDocno)){
          for(var jj=0;jj<itemDocno.length;jj++){
              docnoArr[jj]={};
              docnoArr[jj].date=itemDocno[jj].billdate;
              docnoArr[jj].no = itemDocno[jj].xmlns;
              docnoArr[jj].type = itemDocno[jj].sotype;
              var itemTag=itemDocno[jj].q.array.tag_c;
              docnoArr[jj].tag=this.forItemTagChangeToArr(itemTag);
            }
          }else{
              docnoArr[0]={};
              docnoArr[0].date=itemDocno.billdate;
              docnoArr[0].no = itemDocno.xmlns;
              docnoArr[0].type = itemDocno.sotype;
              var itemTag=itemDocno.q.array.tag_c; 
              docnoArr[0].tag=this.forItemTagChangeToArr(itemTag);         	
          }
        return docnoArr;
    },
    /*
     ×Json对象转化为数组
     *itemTag:docno的下一层（第四层）具体明细层数组或者对象
     *包括 尺寸数组，可用库存数组，订单剩余量数组，订单量数组，条码数组，已配量数组
     */      
    forItemTagChangeToArr:function(itemTag){
    	var tag={};
    	var size=new Array();
      var can=new Array();
      var rem=new Array();
      var dest=new Array();
      var barCode=new Array();
      var qtyAl=new Array();
      if(this.checkIsArray(itemTag)){
          for(var s=0;s<itemTag.length;s++) {
              size[s]=itemTag[s].content?itemTag[s].content:itemTag[s];
              can[s]=itemTag[s].content?itemTag[s].QTYCAN:'non';
              rem[s]=itemTag[s].content?itemTag[s].QTYREM:'non';
              dest[s]=itemTag[s].content?itemTag[s].DESTQTY:'non';
              barCode[s]=itemTag[s].content?itemTag[s].m_product_alias_id:'non';
              qtyAl[s]=itemTag[s].content?itemTag[s].QTY_ALLOT:'non';
          }
      }else{
          size[0]=itemTag.content?itemTag.content:itemTag;
          can[0]=itemTag.content?itemTag.QTYCAN:'non';
          rem[0]=itemTag.content?itemTag.QTYREM:'non';
          dest[0]=itemTag.content?itemTag.DESTQTY:'non';
          barCode[0]=itemTag.content?itemTag.m_product_alias_id:'non';
          qtyAl[0]=itemTag.content?itemTag.QTY_ALLOT:'non';
      }
      tag.size=size;
      tag.can=can;
      tag.rem=rem;
      tag.dest=dest;
      tag.barCode=barCode;
      tag.qtyAl=qtyAl;
      return tag;
    },
    /*
     ×根据x-index,y-index得到下个元素，主要用于响应向下时自动到下个单元
     * @param x x-index 注意是从0开始的
     * @param y y-index 注意是从0开始的
     * @param style 款号
     * @param yMax 该款号矩阵y-index的最大值
     */    
    get_next_y_cell_down:function(x,y,style,yMax){
    	if(y<yMax){
    		var a=jQuery("#"+style+"-"+x+"-"+(y+1),jQuery("#"+style)[0]);
    		if(a[0]){
    			a.focus();
    		}else{
    			this.get_next_y_cell_down(x,y+1,style,yMax);
    		}
    	}else{
    		this.get_next_y_cell_down(x,-1,style,yMax);
    	}
    },    
    /*
     ×根据x-index,y-index得到下个元素，主要用于响应向上时自动到下个单元
     * @param x x-index 注意是从0开始的
     * @param y y-index 注意是从0开始的
     * @param style 款号
     * @param yMax 该款号矩阵y-index的最大值
     */    
    get_next_y_cell_up:function(x,y,style,yMax){
    	if(y>0){
    		var a=jQuery("#"+style+"-"+x+"-"+(y-1),jQuery("#"+style)[0]);
    		if(a[0]){
    			a.focus();
    		}else{
    			this.get_next_y_cell_up(x,y-1,style,yMax);
    		}
    	}else{
    		this.get_next_y_cell_up(x,yMax+1,style,yMax);
    	}
    },    
    /*
     ×根据x-index,y-index得到下个元素，主要用于响应向右时自动到下个单元
     * @param x x-index 注意是从0开始的
     * @param y y-index 注意是从0开始的
     * @param style 款号
     * @param xMax 该款号矩阵x-index的最大值
     */    
    get_next_x_cell_right:function(x,y,style,xMax){
    	if(x<xMax){
    		var a=jQuery("#"+style+"-"+(x+1)+"-"+y,jQuery("#"+style)[0]);
    		if(a[0]){
    			a.focus();
    		}else{
    			this.get_next_x_cell_right(x+1,y,style,xMax);
    		}
    	}else{
    		this.get_next_x_cell_right(-1,y,style,xMax);
    	}
    },
    /*
     ×根据x-index,y-index得到下个元素，主要用于响应向左时自动到下个单元
     * @param x x-index 注意是从0开始的
     * @param y y-index 注意是从0开始的
     * @param style 款号
     * @param xMax 该款号矩阵x-index的最大值     
     */    
    get_next_x_cell_left:function(x,y,style,xMax){
    	if(x>0){
    		var a=jQuery("#"+style+"-"+(x-1)+"-"+y,jQuery("#"+style)[0]);
    		if(a[0]){
    			a.focus();
    		}else{
    			this.get_next_x_cell_left(x-1,y,style,xMax);
    		}
    	}else{
    		this.get_next_x_cell_left(xMax+1,y,style,xMax);
    	}
    },    
    /*
     ×根据x-index,y-index得到下个元素，主要用于响应回车键时自动到下个单元
     * @param x x-index 注意是从0开始的
     * @param y y-index 注意是从0开始的
     * @param style 款号
     * @param xMax 该款号矩阵x-index的最大值
     * @param yMax 该款号矩阵y-index的最大值
     */      
    get_next_cell:function(x,y,style,xMax,yMax){
    	if(x<xMax){
    		var a=jQuery(("#"+style+"-"+(x+1)+"-"+y),jQuery("#"+style)[0]);
    		if(a[0]){
    			a.focus();
    		}else{
    			this.get_next_cell(x+1,y,style,xMax,yMax);
    		}
    	}else if(y<yMax){
    			this.get_next_cell(-1,y+1,style,xMax,yMax);
    	}else{
    		this.get_next_cell(-1,0,style,xMax,yMax);
    	}
    },
    forChangeDate:function(date){
      return date.substring(2,4)+"-"+date.substring(4,6)+"-"+date.substring(6);
    },
    forColorSpan:function(color){
        var count=0;
        for(var i=0;i<color.stores.length;i++){
            count+=color.stores[i].docnos.length;
        }
        return count*4;
    },
    forStorSpan:function(stor){
       return stor.docnos.length*4;
    },
    forTableShowStyle:function(tagTot){
        var str= "";
        str+="<col width=\"50\"/><col width=\"70\"/><col width=\"110\"/><col width=\"65\"/><col width=\"65\"/><col width=\"65\">";
        for(var i=0;i<tagTot;i++){
            str+="<col width=\"65\"/>";
        }
        str+="<col width=\"65\"/>";
        return str;
    },
    _executeCommandEvent :function (evt) {
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
    tabToArr:function(tab){
        var cellArr=new Array();
        for(var i=0;i<tab.rows.length;i++){
            cellArr[i]=new Array();
            for(var j=0;j<tab.rows[i].cells.length;j++){
                cellArr[i][j]=tab.rows[i].cells[j];
            }
        }
        return cellArr;
    },
    autoView1:function(){
        window.onbeforeunload=function(){
        		if(window.location==dist.windowLocation){
            	if( $("isChanged").value=='true'){
 	               		return "页面数据已改动，还未保存！";
		            }else{
		                return;
		            }
          	}
       	 }
  
        jQuery(document).bind("keyup",function(event){
            if(event.ctrlKey==true&&event.which==38){
                var divs=jQuery("#category_manu li>div");
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
                var divs=jQuery("#category_manu li>div");
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
				jQuery("#pdt-search").bind("keyup",function(event){
					if(event.target==this&&event.which==13){
						dist.pdt_search();
					}
				});
        jQuery("#ph-from-right-table table input").bind("focus",function(event){
        	if(event.target==this){
            var e=Event.element(event)
            /* edit by Robin 2010.5.7 */
						$("input-2").innerHTML=dist.dataForStyleQtyAl[jQuery(e).attr("sty")];
                    
            var barCodeCanDist=dist.get_barcode_can_dist(jQuery(e).attr("barCode"),jQuery(e).attr("docType"));
            $("input-1").innerHTML=barCodeCanDist;
            $("tot-ready").innerHTML=dist.allQtyAl;
            $("rs").innerHTML=jQuery(e).attr("qtyRem");
            /*end*/
            dwr.util.selectRange(this,0,100);
          }
        });
        jQuery("#ph-from-right-table table input").bind("keydown",function(event){
            if(event.which==13){
            	if(event.target=this){
                var x=parseInt(jQuery(this).attr("x-index"),10);
                var y=parseInt(jQuery(this).attr("y-index"),10);
                var style=jQuery(this).attr("sty");
                var xMax=parseInt(jQuery("#"+style).attr("x-length"),10)-1;
    						var yMax=parseInt(jQuery("#"+style).attr("y-length"),10)-1;
    						dist.get_next_cell(x,y,style,xMax,yMax);
              }
            }
        });
        jQuery("#ph-from-right-table table input").bind("keyup",function(event){
            if(event.target==this){
                this.status=1;
                /*
                 *当输入的是数字的时候响应
                 *动态显示条码当前可配，款号当前已配，总已配
                 */
                if((event.which>=48&&event.which<=57)||(event.which>=96&&event.which<=105)||event.which==8||event.which==46){
                    $("isChanged").value='true';
                    var cellData1={};
				            cellData1.barCode=jQuery(this).attr("barCode");
				            cellData1.docNo = jQuery(this).attr("docNo");
				            cellData1.store=jQuery(this).attr("store");
				            if(event.which==8||event.which==46){
                    	if(this.value==""||this.value.strip()==""){
                      		this.value=0;
                    		}
                		}
				            var dataCell1=dist.v2m_get_ret(cellData1)[0];
				            var oldQtyAl=parseInt(dataCell1.qtyAl,10);//未编辑前的单元的已配量
				            var nowQty=parseInt(jQuery(this).val(),10);//响应事件后的数量
				            if(isNaN(nowQty)){
				            	jQuery(this).val("0");
				            	nowQty=0;
				            }
                    var qtyAlChange=nowQty-oldQtyAl;//改变的数量
                    
                    var barCodeCanDist=dist.get_barcode_can_dist(jQuery(this).attr("barCode"),jQuery(this).attr("docType"));
                   
                    if(qtyAlChange>barCodeCanDist) {
                        alert("当前可配量已小于0！请重新分配！");
                        this.value = 0;
                        dwr.util.selectRange(this,0,100);
                    }
										var qtyRem=parseInt(dataCell1.qtyRem,10);
                    if(nowQty>qtyRem){
                        alert("配置量大于未配量，请重新配置！");
                        this.value=0;
                        dwr.util.selectRange(this,0,100);
                    }
                    var newQtyAl=parseInt(jQuery(this).val(),10);
                    var cellData={};
                    cellData.color = jQuery(this).attr("color");
                    cellData.barCode=jQuery(this).attr("barCode");
                    cellData.docNo = jQuery(this).attr("docNo");
                    cellData.store=jQuery(this).attr("store");
                    cellData.qtyAl=newQtyAl;
                    cellData.sty=jQuery(this).attr("sty");
                    cellData.docType=jQuery(this).attr("docType");
                    cellData.size=jQuery(this).attr("size");
                    
                    var realQtyAlChange=newQtyAl-oldQtyAl;//实际单元配货量改变数
                   	
                   	dist.update_when_cell_real_change(cellData,realQtyAlChange);
                    
                    $("input-2").innerHTML=dist.dataForStyleQtyAl[jQuery(this).attr("sty")];
                    $("tot-ready").innerHTML=dist.allQtyAl;
                    var barCodeCanDist=dist.get_barcode_can_dist(cellData.barCode,jQuery(this).attr("docType"));
                    $("input-1").innerHTML=barCodeCanDist;
                            
                    $("rs").innerHTML=jQuery(this).attr("qtyRem");
                    
                    //alert(Object.toJSON(dist.v2m_get_ret(cellData)));
                }else if(event.which==37){ //响应左键事件，及表格中输入框中移动
                		var x=parseInt(jQuery(this).attr("x-index"),10);
                		var y=parseInt(jQuery(this).attr("y-index"),10);
                		var style=jQuery(this).attr("sty");
                		var xMax=parseInt(jQuery("#"+style).attr("x-length"),10)-1;
                    dist.get_next_x_cell_left(x,y,style,xMax);
                }else if(event.which==39){//右
                		var x=parseInt(jQuery(this).attr("x-index"),10);
                		var y=parseInt(jQuery(this).attr("y-index"),10);
                		var style=jQuery(this).attr("sty");
                		var xMax=parseInt(jQuery("#"+style).attr("x-length"),10)-1;
                    dist.get_next_x_cell_right(x,y,style,xMax);
                }else if(event.which==38){//上
                		var x=parseInt(jQuery(this).attr("x-index"),10);
                		var y=parseInt(jQuery(this).attr("y-index"),10);
                		var style=jQuery(this).attr("sty");
                		var yMax=parseInt(jQuery("#"+style).attr("y-length"),10)-1;                	
                		dist.get_next_y_cell_up(x,y,style,yMax)
                }else if(event.which==40){//下
                		var x=parseInt(jQuery(this).attr("x-index"),10);
                		var y=parseInt(jQuery(this).attr("y-index"),10);
                		var style=jQuery(this).attr("sty");
                		var yMax=parseInt(jQuery("#"+style).attr("y-length"),10)-1;                	
                		dist.get_next_y_cell_down(x,y,style,yMax)
                }
            }
        });
        jQuery("#ph-from-right-table>table input:first").focus();
    },
    /*
     ×根据单元格元素cellData，更新当单元格编辑后数据改变时相关
     * @param cellData 单元格数据，必须包含barCode,docNo,store,qtyAl,color,sty,docType,size
     * @param realQtyAlChange 实际改变数量（相对于未编辑以前）
     */      
    update_when_cell_real_change:function(cellData,realQtyAlChange){
    		this.allQtyAl+=realQtyAlChange;//总已配
    		var cellData1={};
				cellData1.barCode=cellData.barCode;
        cellData1.docNo = cellData.docNo;
        cellData1.store=cellData.store;
        cellData1.qtyAl=cellData.qtyAl;
    		this.update_v2mdata_celldata(cellData1);//更新单元
        var cellData2={};
        cellData2.color = cellData.color;
        cellData2.docNo = cellData.docNo;
        cellData2.store=cellData.store;    		
    		this.update_row_count(cellData2,realQtyAlChange);
    		this.update_style_qty_al(cellData.sty,realQtyAlChange);
       	this.update_barcode_can_dist(cellData.barCode,cellData.docType,realQtyAlChange);
        this.update_style_tot_al_for_col(cellData.size,cellData.sty,realQtyAlChange);
    },
    showContent1:function(tb,type){
        var lies=$("category_manu").getElementsByTagName("li");
        var tabs=$("ph-from-right-table").getElementsByTagName("table");
		if(type!="no"){
			for(var d=0;d<lies.length;d++){
				lies[d].firstChild.style.backgroundColor="";
				lies[d].firstChild.style.color="";
			}
		}
        for(var i=0;i<tabs.length;i++){
            tabs[i].style.display="none";
        }
        $(tb).style.display="";
        var strA=$(tb).title.split(":");
        $("input-5").innerHTML=strA[0];
        $("input-4").innerHTML=strA[1];
        jQuery("td>input:first",$(tb)).focus()
    },
    pdt_data:function(e){
        var arr=this.tabToArr(e);
        var pdtrs=0;
        var pdtrem=0;
        for(var i=0;i<arr.length;i++){
            pdtrs+=parseInt(arr[i][7].firstChild.innerHTML.strip(),10);
            pdtrem+=parseInt(arr[i][6].firstChild.innerHTML.strip(),10);
        }
        $("input-5").innerHTML=pdtrem;
        $("input-4").innerHTML=pdtrs;
        var tab=$("table_title_tot");
        this.equal_w(tab,e);
    },
    equal_w:function(tab1,tab2){
        var cells1=tab1.rows[0];
        var cells2=tab2.rows[0];
        for(var i=0;i<cells1.length;i++){
            cells1[i].width=cells2[i].width||cells2.style.width;
        }
    },
    pdt_search:function(){
        var cdt=$("pdt-search").value;
        if($("showStyle").value=="metrix"){
		        var pdts=new Array();
		        if(!cdt||!cdt.strip()){
		        	for(var i=0;i<this.product.length;i++){
								pdts[i]=this.product[i];
							}
							$("category_manu").innerHTML=this.manuStr;
		        }else{
							cdt=cdt.strip();
							var manuStr="";
							var reg= new RegExp(cdt,"i");
							 for(var i=0;i<this.product.length;i++){
								if(reg.test(this.product[i].name)){
									pdts.push(this.product[i]);
								}
							}
							for(var j=0;j<pdts.length;j++){
								manuStr+="\n<li><div class=\"txt-on\"  onclick='javascript:$(\"pdt-img\").src = \"/pdt/"+pdts[j].M_PRODUCT_LIST+"_1_2.jpg\";" +
			                              "$(\"ph-pic-img-txt\").innerHTML=\""+pdts[j].name+"<br/>"+pdts[j].value+"\";" +
			                              "dist.showContent1(\""+pdts[j].name+"\");" +
			                              "this.style.backgroundColor=\"#8db6d9\"; this.style.color=\"white\";'"+
			                              (j==0?"  style='background:#8db6d9'":"")+">"+pdts[j].name+"</div></li>\n";
							}
							$("category_manu").innerHTML=manuStr;
					}
					if(pdts[0])this.showContent1(pdts[0].name,"no");
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