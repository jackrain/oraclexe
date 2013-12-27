var dist=null;
var DIST=Class.create();
DIST.prototype={
    initialize: function() {
       this.itemStr="";
        this.manuStr="";
        this.allot_id=null;
        this.manu=null;
        this.item=null;
        //dwr.util.useLoadingMessage(gMessageHolder.LOADING);
        dwr.util.setEscapeHtml(false);
        /** A function to call if something fails. */
        dwr.engine._errorHandler =  function(message, ex) {
            while(ex!=null && ex.cause!=null) ex=ex.cause;
            if(ex!=null)message=ex.message;// dwr.engine._debug("Error: " + ex.name + "," + ex.message+","+ ex.cause.message, true);
            if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
            else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
            else alert(message);
        };
        application.addEventListener( "DO_QUERY", this._onloadDisplay, this);
        application.addEventListener("FUND_BALANCE",this._onfundQuery,this);
        application.addEventListener("DO_SAVE",this._onsaveDate,this);

    },
    queryObject: function(){
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="DO_QUERY";
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
        var orig_in_sql=xml2json.parser($("column_26993").value).filter.sql;

        if(!$("column_26994").value){
            alert("款号不能为空！");
            return;
        }
        var product_filter=xml2json.parser($("column_26994").value).filter.sql;

        var reg=/^\d{8}$/;
        var billdatebeg=$("column_26995").value.trim();
        if(!reg.test(billdatebeg)){
            alert("开始日期格式不对！请输入8位有效数字。");
            return;
        }

        var billdateend=$("column_269966").value.trim();
         if(!reg.test(billdateend)){
            alert("结束日期格式不对！请输入8位有效数字。");
            return;
        }

        var param={"or_type":doctype,"c_dest":orig_in_sql,"c_orig":orig_out_fk,"m_product":product_filter,
            "datest":billdatebeg,"datend":billdateend};
        evt.param=Object.toJSON(param);
        evt.table="m_allot";
        evt.action="distribution";
        evt.permission="r";
        this._executeCommandEvent(evt);
    },
   saveDate:function(){
       var evt={};
       evt.command="DBJSONXML";
       evt.callbackEvent="DO_SAVE";
       var m_allot_id=$("fund_balance").value||"null";
       var m_item=new Array();
        
       if(this.checkIsArray(this.item)){
           var itema=this.item;
           for(var i=0;i<itema.length;i++){
               var ii={};
               if($(itema[i].M_PRODUCT_ALIAS_ID).value&&$(itema[i].M_PRODUCT_ALIAS_ID).value.strip()!=""){
                   ii.qty_ady=$(itema[i].M_PRODUCT_ALIAS_ID).value;
                   ii.m_product_alias_id=itema[i].M_PRODUCT_ALIAS_ID;
                   m_item.push(ii);
               }
           }
       }else{
           var itema=this.item;
           if($(itema.M_PRODUCT_ALIAS_ID).value&&$(itema.M_PRODUCT_ALIAS_ID).value.strip()!="") {
               ii.qty_ady=$(itema.M_PRODUCT_ALIAS_ID).value;
               ii.m_product_alias_id=itema.M_PRODUCT_ALIAS_ID;
               m_item.push(ii);
           }
       }
      // var param={"m_allot_id":m_allot_id,"m_item":[{"m_product_alias_id":"89994,89990","qty_ady":"4,4"}, {"m_product_alias_id":"89990","qty_ady":"4"}]}
       var param={};
       param.m_allot_id=m_allot_id;
       param.m_item=(m_item.length==0?"null":m_item); 
			 alert(Object.toJSON(param));     
       evt.param=Object.toJSON(param);
       evt.table="m_allot";
       evt.action="save";
       evt.permission="r";
       this._executeCommandEvent(evt);
   },
    _onsaveDate:function(e){
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        alert(ret.data);
    },
   //经销商资金余额
    fundQuery:function(){
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="FUND_BALANCE";
        var w=window.parent;
        if(!w)w=window.opener;
        var m_allot_id=w.document.getElementById("fund_balance").value||"null";
        var param={"m_allot_id":m_allot_id};
        evt.param=Object.toJSON(param);
        evt.table="m_allot";
        evt.action = "cus";
        evt.permission="r";
        this._executeCommandEvent(evt);
    },
    _onfundQuery:function(e){
        var data=e.getUserData();
         var ret=data.jsonResult.evalJSON();
        var fundStr="<tr>\n<td width=\"70\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">序号</div></td>"+
                                "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">经销商</div></td>"+
                                "<td width=\"80\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">资金余额</div></td>"+
                                "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">已占用金额</div></td>"+
                                "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">可用金额</div></td>"+
                                "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">本次配货金额</div></td>"+
                                "<td width=\"90\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">剩余金额</div></td>"+
                                "<td width=\"100\" bgcolor=\"#8db6d9\" class=\"table-title-bg\"><div class=\"td-title\">提货余额下限</div></td>"+
                                "</tr>";
        if(ret.data=="null"){
            fundStr="<div style='font-size:20px;color:red;text-align:center;font-weight:bold;vertical-align:middle'>您没有选择经销商！</div>";
        }else{
             var funditem=ret.data;
            if(this.checkIsArray(funditem)){
                for(var i=0;i<funditem.length;i++){
                    fundStr+="<tr>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+(i+1)+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.NAME+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEEREMAIN+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEECHECKED+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEECANTAKE+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEEALLOT+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEEREM+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem[i].facusitem.FEELTAKE+"</div></td>"+
                           " </tr>";
                }
            }
            else{
               fundStr+="<tr>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+1+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem.facusitem.NAME+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem.facusitem.FEEREMAIN+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem.facusitem.FEECHECKED+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem.facusitem.FEECANTAKE+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem.facusitem.FEEALLOT+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem.facusitem.FEEREM+"</div></td>"+
                                "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+funditem.facusitem.FEELTAKE+"</div></td>"+
                           " </tr>";
            }
        }
          $("fund_table").innerHTML=fundStr;
    },



    _onloadDisplay:function(e){
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        this.itemStr="";
        this.manuStr="";
        this.namu=null;
        if(ret.data){
            this.itemStr+="<div style='font-size:20px;color:red;text-align:center;font-weight:bold;vertical-align:middle'>没有数据！</div>";
        }
       else{
            this.allot_id=ret.m_allot_id;
            this.manu=ret.oderinfo;
            this.item=ret.orderitem;
            if(this.checkIsArray(ret.oderinfo)){
                var manu=ret.oderinfo;
                for(var i=0;i<manu.length;i++){
                    if(i==0){
                        $("ph-pic-img-txt").innerHTML=manu[i].name+" <br/>"+manu[i].value;
                        $("pdt-img").src = "/pdt/"+manu[i].M_PRODUCT_LIST+"_1_2.jpg";
                    }
                    this.manuStr+="\n<li><div class=\"txt-on\"  onclick='javascript:$(\"pdt-img\").src = \"/pdt/"+manu[i].M_PRODUCT_LIST+"_1_2.jpg\";" +
                                                                                 "$(\"ph-pic-img-txt\").innerHTML=\""+manu[i].name+"<br/>"+manu[i].value+"\";" +
                                                                                 "dist.showContent(document.getElementById(\""+manu[i].M_PRODUCT_LIST+"\"));" +
                                                                                 "this.style.backgroundColor=\"#0099cc\";'"+
                                                                                    (i==0?"  style='background:#0099cc'":"")+">"+manu[i].name+"</div></li>\n";
                    this.itemStr+="<table id='"+manu[i].M_PRODUCT_LIST+ "' width=\"100%\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#8db6d9\" bordercolorlight=\"#FFFFFF\" bordercolordark=\"#FFFFFF\" bgcolor=\"#8db6d9\" class=\"modify_table\""+(i!=0?" style='display:none'":"")+">\n";
                    if(this.checkIsArray(ret.orderitem)){
                        var item=ret.orderitem;
                        var count=0;
                        for(var j=0;j<item.length;j++){
                            if(item[j].M_PRODUCT_ID==manu[i].M_PRODUCT_LIST){
                                count++;
                                this.itemStr+="<tr>\n<td width=\"40\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\" >"+count+"</div></td>\n"+
                                         "<td width=\"75\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+item[j].VALUE1+"</div></td>\n"+
                                         "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+item[j].VALUE2+"</div></td>\n"+
                                         "<td width=\"95\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+item[j].NAME+"</div></td>\n"+
                                         "<td width=\"115\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+item[j].DOCNO+"</div></td>\n"+
                                         "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+item[j].QTY_SO+"</div></td>\n"+
                                         "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font-blue\">"+item[j].QTYCAN+"</div></td>\n"+
                                         "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font-purple\">"+item[j].QTYREM+"</div></td>\n"+
                                         "<td width=\"100\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\"><input name=\"textfield2\" id='"+item[j].M_PRODUCT_ALIAS_ID+"' type=\"text\" class=\"td-font-input\" size=\"15\" /></div></td>\n"+
                                         "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+item[j].DESTQTY+"</div></td>\n</tr>\n";
                            }
                        }
                    }
                    else{
                        if(item[j].M_PRODUCT_ID==manu[i].M_PRODUCT_LIST)
                            this.itemStr+="<tr><td width=\"40\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\" >"+1+"</div></td>\n"+
                                     "<td width=\"75\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+ret.orderitem.VALUE1+"</div></td>\n"+
                                     "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+ret.orderitem.VALUE2+"</div></td>\n"+
                                     "<td width=\"95\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\" style='width:100px'>"+ret.orderitem.NAME+"</div></td>\n"+
                                     "<td width=\"115\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\" style='width:110px'>"+item[j].DOCNO+"</div></td>\n"+
                                     "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+ret.orderitem.QTY_SO+"</div></td>\n"+
                                     "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font-blue\">"+ret.orderitem.QTYCAN+"</div></td>\n"+
                                     "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font-purple\">"+ret.orderitem.QTYREM+"</div></td>\n"+
                                     "<td width=\"100\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\"><input name=\"textfield2\" id='"+ret.orderitem.M_PRODUCT_ALIAS_ID+"' type=\"text\" class=\"td-font-input\" size=\"15\" /></div></td>\n"+
                                     "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+ret.orderitem.DESTQTY+"</div></td>\n</tr>\n";
                    }
                }
            }
            else{
                var manu=ret.oderinfo;
                 $("ph-pic-img-txt").innerHTML=manu.name+" <br/>"+manu.value;
                 $("pdt-img").src = "/pdt/"+manu.M_PRODUCT_LIST+"_1_2.jpg";
                 $("ph-pic-img-txt").innerHTML=manu.name+" <br/>"+manu.value;
                this.manuStr+="\n<li><div class=\"txt-on\"  onclick='javascript:$(\"pdt-img\").src = \"/pdt/"+manu.M_PRODUCT_LIST+"_1_2.jpg\";$(\"ph-pic-img-txt\").innerHTML=\""+manu.name+"<br/>"+manu.value+"\";dist.showContent(document.getElementById(\""+manu.M_PRODUCT_LIST+"\"));this.style.backgroundColor=\"#0099cc\"'  style='background:#0099cc'>"+manu.name+"</div></li>\n";
                this.itemStr+="\n<table id='"+manu.M_PRODUCT_LIST+ "' width=\"100%\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#8db6d9\" bordercolorlight=\"#FFFFFF\" bordercolordark=\"#FFFFFF\" bgcolor=\"#8db6d9\" class=\"modify_table\">\n";
                if(this.checkIsArray(ret.orderitem)){
                    var item=ret.orderitem;
                    var count=0;
                    for(var j=0;j<item.length;j++){
                        if(item[j].M_PRODUCT_ID==manu.M_PRODUCT_LIST){
                            count++;
                            this.itemStr+="\n<tr>\n<td width=\"40\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\" >"+count+"</div></td>\n"+
                                     "<td width=\"75\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+item[j].VALUE1+"</div></td>\n"+
                                     "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+item[j].VALUE2+"</div></td>\n"+
                                     "<td width=\"95\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\" style='width:100px'>"+item[j].NAME+"</div></td>\n"+
                                     "<td width=\"115\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\" style='width:110px'>"+item[j].DOCNO+"</div></td>\n"+
                                     "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+item[j].QTY_SO+"</div></td>\n"+
                                     "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font-blue\">"+item[j].QTYCAN+"</div></td>\n"+
                                     "<td width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font-purple\">"+item[j].QTYREM+"</div></td>\n"+
                                     "<td width=\"100\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\"><input name=\"textfield2\" id='"+item[j].M_PRODUCT_ALIAS_ID+"' type=\"text\" class=\"td-font-input\" size=\"15\" /></div></td>\n"+
                                     "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+item[j].DESTQTY+"</div></td>\n</tr>\n";
                        }
                    }
                    this.itemStr+="</table>";
                }
                else{
                    if(item[j].M_PRODUCT_ID==manu.M_PRODUCT_LIST)
                        this.itemStr+="\n<tr>\n<td width=\"40\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\" >"+1+"</div></td>\n"+
                                 "<td  width=\"75\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+ret.orderitem.VALUE1+"</div></td>\n"+
                                 "<td  width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+ret.orderitem.VALUE2+"</div></td>\n"+
                                 "<td  width=\"95\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\" style='width:100px'>"+ret.orderitem.NAME+"</div></td>\n"+
                                 "<td  width=\"115\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\" style='width:110px'>"+item[j].DOCNO+"</div></td>\n"+
                                 "<td  width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+ret.orderitem.QTY_SO+"</div></td>\n"+
                                 "<td  width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font-blue\">"+ret.orderitem.QTYCAN+"</div></td>\n"+
                                 "<td  width=\"65\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font-purple\">"+ret.orderitem.QTYREM+"</div></td>\n"+
                                 "<td  width=\"100\" bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\"><input name=\"textfield2\"  id='"+ret.orderitem.M_PRODUCT_ALIAS_ID+"' type=\"text\" class=\"td-font-input\" size=\"15\" /></div></td>\n"+
                                 "<td bgcolor=\"#8db6d9\" class=\"td-bg\"><div class=\"td-font\">"+ret.orderitem.DESTQTY+"</div></td>\n</tr>\n</table>";
                }
            }
        }
        $("category_manu").innerHTML=this.manuStr;
        $("ph-from-right-table").innerHTML=this.itemStr;
        var orig_out=$("column_26993_fd");
        var tabs=$("ph-from-right-table").getElementsByTagName("table");
        var tot_can=0;
        var tot_rem=0;

        for(var i=0;i<tabs.length;i++){
            var inp=$("input-1");
            var inp2=$("rs");
            var inp3=$("input-2");
            var arrCell=this.tabToArr(tabs[i]);
            for(var j=0;j<arrCell.length;j++){
                tot_can+=parseInt(arrCell[j][6].firstChild.innerHTML);
                tot_rem+=parseInt(arrCell[j][7].firstChild.innerHTML);
            }
            this.autoView(8,orig_out,tabs[i],inp,inp2,inp3);
            this.keyListener(tabs[i],8);

        }
        $("tot-can").innerHTML=tot_can;
        $("tot-rem").innerHTML=tot_rem;
        $("fund_balance").value=this.allot_id;
        for(var jj=0;jj<tabs.length;jj++){
             if(tabs[jj].style.display!="none"){
                this.pdt_data(tabs[jj]);
            }
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
     /*
     *tab:需要转换为二维数组的表格
     *子元素是td
     */
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
    /*
     focusCol:需要响应手输的列数；
     orig:页面返回的收货店仓字符串；
     tab:目标表格；
     target1，target2...:动态显示计数结果的元素(input)
     */
    autoView:function(focusCol,orig,tab,target1,target2,target3){

        var cellArr=this.tabToArr(tab);

        for (var k = 0; k < cellArr.length; k++) {

            (function(){
                //定义s让count（）调用
                var s=k;
                cellArr[k][focusCol].firstChild.firstChild.onfocus =function () {
                    var style_rem=isNaN(parseInt(cellArr[s][6].firstChild.innerHTML))?0:parseInt(cellArr[s][6].firstChild.innerHTML);
                    var rs=0;
                    var tot=0;
                    for(var aa=0;aa<cellArr.length;aa++){
                        tot+=isNaN(parseInt(cellArr[aa][focusCol].firstChild.firstChild.value))?0:parseInt(cellArr[aa][focusCol].firstChild.firstChild.value);
                        if(cellArr[aa][1].firstChild.innerHTML==cellArr[s][1].firstChild.innerHTML&&cellArr[aa][2].firstChild.innerHTML==cellArr[s][2].firstChild.innerHTML){
                            style_rem-=isNaN(parseInt(cellArr[aa][focusCol].firstChild.firstChild.value))?0:parseInt(cellArr[aa][focusCol].firstChild.firstChild.value);
                            rs+=parseInt(cellArr[aa][7].firstChild.innerHTML);
                        }
                    }
                    target1.innerHTML=isNaN(style_rem)?0:style_rem;
                    target2.innerHTML=rs;
                    target3.innerHTML=tot;
                   var tot_ready=0;
                   var tables=$("ph-from-right-table").getElementsByTagName("table");
                    for(var k=0;k<tables.length;k++){
                        var acs=dist.tabToArr(tables[k]);
                        for(var kk=0;kk<acs.length;kk++){
                           tot_ready+= isNaN(parseInt(acs[kk][8].firstChild.firstChild.value))?0:parseInt(acs[kk][8].firstChild.firstChild.value);
                        }
                    }
                    $("tot-ready").innerHTML=tot_ready;
                    for(var ss=0;ss<cellArr[s].length;ss++){
                        cellArr[s][ss].firstChild.style.backgroundColor="#00ffff";
                    }
                };
                cellArr[k][focusCol].firstChild.firstChild.onblur =function () {
                    for(var ss=0;ss<cellArr[s].length;ss++){
                        cellArr[s][ss].firstChild.style.backgroundColor="#e9f1f8";
                    }
                };
                cellArr[k][focusCol].firstChild.firstChild.onkeyup=function(event){
                    if(event.keyCode<=57&&event.keyCode>=48){
                      var style_rem=isNaN(parseInt(cellArr[s][6].firstChild.innerHTML))?0:parseInt(cellArr[s][6].firstChild.innerHTML);
                        for(var aa=0;aa<cellArr.length;aa++){
                            if(cellArr[aa][1].firstChild.innerHTML==cellArr[s][1].firstChild.innerHTML&&cellArr[aa][2].firstChild.innerHTML==cellArr[s][2].firstChild.innerHTML){
                                style_rem-=isNaN(parseInt(cellArr[aa][focusCol].firstChild.firstChild.value.trim()))?0:parseInt(cellArr[aa][focusCol].firstChild.firstChild.value.trim());
                            }
                        }
                        target1.innerHTML=isNaN(style_rem)?0:style_rem;
                        if(style_rem<0){
                            cellArr[s][focusCol].firstChild.firstChild.value=0;
                            alert("可配量已小于0！请重新输入！");
                        }
                    }
                }
            })();
        }

    },

    /*
     * 表格中增加上下键，回车键（向下）的事件响应
     * tab:目标表格
     * colIndex:响应的列
     */
    keyListener:function (tab,colIndex){
        var tabArr=this.tabToArr(tab);
        for(var i=0;i<tabArr.length;i++){
            (function(){
                var s=i;
                //兼容不是ie的浏览器
                if(tabArr[i][colIndex].firstChild.firstChild.addEventListener)
                    tabArr[i][colIndex].firstChild.firstChild.addEventListener("keydown",handler,false);
                else{
                    alert("dddd");
                    tabArr[i][colIndex].firstChild.firstChild.attachEvent("onkeydown",handler);
                }
                function handler(e){
                    //兼容不是IE浏览器
                    if(!event)var event=e;

                    if(event.keyCode)var code=event.keyCode;
                    //兼容不是IE浏览器,FIREFOX不支持KEYCODE 支持WHICH但键盘代码是一样的
                    else if(event.which) code=event.which;

                    if(code==40||code==13){
                        tabArr[s+1][colIndex].firstChild.firstChild.focus();
                    }
                    if(code==38){
                        tabArr[s-1][colIndex].firstChild.firstChild.focus();
                    }
                }
            })();
        }

    },
    showContent:function(e){
       var lies=$("category_manu").getElementsByTagName("li");
       var tabs=$("ph-from-right-table").getElementsByTagName("table");
       for(var d=0;d<lies.length;d++){
         lies[d].firstChild.style.backgroundColor="";
       }
      for(var i=0;i<tabs.length;i++){
          tabs[i].style.display="none";
      }
      if(e){
          e.style.display="";
          this.pdt_data(e);
      }
    },
    pdt_data:function(e){
        var arr=this.tabToArr(e);
        var pdtrs=0;
        var pdtrem=0;
        for(var i=0;i<arr.length;i++){
            pdtrs+=parseInt(arr[i][7].firstChild.innerHTML.trim());
            pdtrem+=parseInt(arr[i][6].firstChild.innerHTML.trim());
        }
        $("input-5").innerHTML=pdtrem;
        $("input-4").innerHTML=pdtrs;
        var tab=$("table_title_tot");
        this.equal_w(tab,e);
    },
    /*tab1:目标表（含title的表)
    * tab2:实际对其的表*/
    equal_w:function(tab1,tab2){
        var cells1=tab1.rows[0];
        var cells2=tab2.rows[0];
        for(var i=0;i<cells1.length;i++){
            cells1[i].width=cells2[i].width||cells2.style.width;
        }
    },
    pdt_search:function(){
        var cdt=$("pdt-search").value;
        this.showContent();
        if(!cdt||!cdt.trim()){
           if(this.checkIsArray(this.manu)){
               $("ph-pic-img-txt").innerHTML=this.manu[0].name+" <br/>"+this.manu[0].value;
               $("pdt-img").src = "/pdt/"+this.manu[0].M_PRODUCT_LIST+"_1_2.jpg";
               this.showContent($(this.manu[0].M_PRODUCT_LIST));
           }else {
               $("ph-pic-img-txt").innerHTML=this.manu.name+" <br/>"+this.manu.value;
               $("pdt-img").src = "/pdt/"+this.manu.M_PRODUCT_LIST+"_1_2.jpg";
               this.showContent($(this.manu.M_PRODUCT_LIST));
           }
            $("category_manu").innerHTML=this.manuStr;
        }else{
            cdt=cdt.trim();
            var reg=new RegExp(cdt,"i");
            var strTemp="";
            if(this.checkIsArray(this.manu)){
                var count=0;
                for(var i=0;i<this.manu.length;i++){
                    if(reg.test(this.manu[i].name)){
                        count++;
                        strTemp+="\n<li><div class=\"txt-on\"  onclick='javascript:$(\"pdt-img\").src = \"/pdt/"+this.manu[i].M_PRODUCT_LIST+"_1_2.jpg\";$(\"ph-pic-img-txt\").innerHTML=\""+this.manu[i].name+"<br/>"+this.manu[i].value+"\";dist.showContent(document.getElementById(\""+this.manu[i].M_PRODUCT_LIST+"\"));this.style.backgroundColor=\"#0099cc\"'"+(count==1?"  style='background:#0099cc'":"")+">"+this.manu[i].name+"</div></li>\n";
                        if(count==1){
                            $("ph-pic-img-txt").innerHTML=this.manu[i].name+" <br/>"+this.manu[i].value;
                            $("pdt-img").src = "/pdt/"+this.manu[i].M_PRODUCT_LIST+"_1_2.jpg";
                            this.showContent($(this.manu[i].M_PRODUCT_LIST));
                        }

                    }
                }
            }else if(reg.test(this.manu.name)){
                strTemp="\n<li><div class=\"txt-on\"  onclick='javascript:$(\"pdt-img\").src = \"/pdt/"+this.manu.M_PRODUCT_LIST+"_1_2.jpg\";$(\"ph-pic-img-txt\").innerHTML=\""+this.manu.name+"<br/>"+this.manu.value+"\";dist.showContent(document.getElementById(\""+this.manu.M_PRODUCT_LIST+"\"));this.style.backgroundColor=\"#0099cc\"'  style='background:#0099cc'>"+this.manu.name+"</div></li>\n";
                $("ph-pic-img-txt").innerHTML=this.manu.name+" <br/>"+this.manu.value;
                $("pdt-img").src = "/pdt/"+this.manu.M_PRODUCT_LIST+"_1_2.jpg";
                this.showContent($(this.manu.M_PRODUCT_LIST));
            }
            $("category_manu").innerHTML=strTemp;
        }
        var orig_out=$("column_26993_fd");
        var tabs=$("ph-from-right-table").getElementsByTagName("table");
        var tot_can=0;
        var tot_rem=0;

        for(var i=0;i<tabs.length;i++){

            var inp=$("input-1");
            var inp2=$("rs");
            var inp3=$("input-2");

            var arrCell=this.tabToArr(tabs[i]);
            for(var j=0;j<arrCell.length;j++){
                tot_can+=parseInt(arrCell[j][7].firstChild.innerHTML);
                tot_rem+=parseInt(arrCell[j][6].firstChild.innerHTML);

            }
            this.autoView(8,orig_out,tabs[i],inp,inp2,inp3);
            this.keyListener(tabs[i],8);
        }
        $("tot-can").innerHTML=tot_can;
        $("tot-rem").innerHTML=tot_rem;
    },
    showObject:function(url, theWidth, theHeight,option){
        if( theWidth==undefined || theWidth==null) theWidth=956;
        if( theHeight==undefined|| theHeight==null) theHeight=570;
        var options={width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE, modal:true,centerMode:"xy",maxButton:true};
        if(option!=undefined)
            Object.extend(options, option);
        Alerts.popupIframe(url,options);
        Alerts.resizeIframe(options);
        Alerts.center();
    }
}
DIST.main = function () {
    dist=new DIST();
};

/**
 * Init
 */
jQuery(document).ready(DIST.main);

String.prototype.trim=function(){
     return this.replace(/(^\s*)|(\s*$)/g, '');
 }
 /**
 *删除左边的空格
 */
 String.prototype.ltrim=function()
 {
   return this.replace(/(^s*)/g,'');
 }
/**
 *删除右边的空格
*/
 String.prototype.rtrim=function()
 {
   return this.replace(/(s*$)/g,'');
 }


