var box=null;
var BOX=Class.create();
BOX.prototype={
    initialize:function(){
        this.boxItem="";
        this.returnData=null;
        this.addr=new Array();
        this.aa=true;
        this.orderTotNum=0;
        this.record=new Array();
        this.m_item=new Array();
        this.jo=null;
        this.barcodeItem=new Object();
        this.category=new Object();
        this.data=new Array();
        this.additionalItem=new Array();//超量明细 ADD by robin20110601 可扫入超出原单的条码明细
        this.barCodeError=0;//当扫描发生错误时，此值为1，否则为0
        this.correctErrorCode=0;//纠错确认代码，默认为0;
        this.correctErrorButContinueCode=1;//错误确认但是仍然继续操作代码，默认为1；
        this.boxType="out";//Add by Robin 20110519 入库装箱和出库装箱JS合并；值："out","in"
        this.additionalQty=0;
        this.totQtyCan=0;//Add by Robin 20110520 总拣货量
        this.PDTADDSDESCS={}//Add by gxy 20110707条码配饰明细对象
        this.scanBoxno=0;//Add by gxy 20110727扫描时当前箱号
        this.scanCategory=0;
        this.sover=false;
        this.bjz=false;//Add by gxy20111108选箱装箱
        this.c_box=[];//Add by gxy 选择操作的箱
        this.barray=[];//可操作箱
        this.lastbox=1;//增加箱号时记录前一箱
        this.delbox=[];//记录删除的箱号
        this.barcodeInterceptMinLen=13;//允许截取条码的最低长度
        this.barcodeMaxLen=20;//the max length of barcode for scan
        this.barcodeCutlen=0;
        this.eve=new Object();
        dwr.util.setEscapeHtml(false);
        dwr.engine._errorHandler =  function(message, ex){
            while(ex!=null && ex.cause!=null) ex=ex.cause;
            if(ex!=null)message=ex.message;
            if (message == null || message == "") alert("A server error has occured. More information may be available in the console.");
            else if (message.indexOf("0x80040111") != -1) dwr.engine._debug(message);
            else alert(message);
        };
        application.addEventListener("DO_LOAD",this._onLoadBox,this);
        application.addEventListener("DO_SAVE",this._onSave,this);
        application.addEventListener( "PrintJasper", this._onPrintJasper, this);
        application.addEventListener( "SavePrintSetting", this._onSavePrintSetting, this);
        application.addEventListener( "SavePrintSettingForSingleBox", this._onSavePrintSettingForSingleBox, this);
    },
    loadBox:function(jo,jo2){
    	//alert(Object.toJSON(jo2));
        if(jo)
        this.jo=jo;
        if(jo2)
        this.jo2=jo2;//国标码
        
        
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="DO_LOAD";
        var m_box_id=$("m_box_id").value;
        var param={"m_box_id":m_box_id};
        evt.param=Object.toJSON(param);
        //alert("1:  "+evt.param);
        var b_box=this.boxType=="out"?"m_box":"m_v_box";
        if(document.getElementById("b_box")&&document.getElementById("b_box").value=="M_V_LESSBOX")b_box="m_v_lessbox";
        if(document.getElementById("b_box")&&document.getElementById("b_box").value=="M_V_INBOX")b_box="m_v_inbox";
        evt.table=b_box;
        //evt.table=this.boxType=="out"?"m_box":"m_v_box";
        evt.action="pick";
        evt.permission="r";
        if(this.boxType=="out")
        jQuery("#boxadd,#boxdel,#barcode").attr("disabled","true");
        this._executeCommandEvent(evt);
    },
    doSaveSettings:function(tem,tableId){
        var evt={};
        evt.command="SavePrintSetting";
        evt.callbackEvent="SavePrintSetting";
        evt.tableid= tableId;
        evt.template=tem;
        evt.format="pdf";
        this._executeCommandEvent(evt);
    },

    savePrintSettingForSingleBox:function(tem,tableId){
        var evt={};
        evt.command="SavePrintSetting";
        evt.callbackEvent="SavePrintSettingForSingleBox";
        evt.tableid= tableId;
        evt.template=tem;
        evt.format="pdf";
        this._executeCommandEvent(evt);
    },
    _onSavePrintSetting:function(e){
        this.doPrint();
    },
    _onSavePrintSettingForSingleBox:function(e){
        this.getBoxNoId();
    },
    doPrint:function(){
        var evt={};
        evt.tag="Print";
        evt.command="PrintJasper";
        var m_box_id=$("m_box_id").value;
        evt.callbackEvent="PrintJasper";
        evt.params={"table":jQuery("#m_box_table_id").val(),"id":m_box_id};
        this._executeCommandEvent(evt);
    },
    changeString2int:function(s){
    	if(!s)s=0;
    	var i=parseInt(s,10);
    	i=isNaN(i)?0:i;
    	return i;
    },
    del:function(){
        if($("status").value.strip()=="2"){
            alert("单据已提交，不可操作！");
            return;
        }
        var es= jQuery("#showContent>div:visible table:visible tr:visible :checkbox:checked");
        var len=es.length;
        var selCategory=$("selCategory").value.strip();
        var selBox=$("selBox").value.strip();
        var count=0;
        if(this.skuAddRange>0)
        var additionalQtycount=0;
        var isadd=true;
        if(len>0){
            $("isSaved").value="unSave";
            for(var i=0;i<len;i++){
                var divS=jQuery(jQuery(es[i]).parent("td").siblings(":last")).children("div");
                var amount=this.changeString2int(divS.text());
                count+=amount;
                var id=divS.attr("id");
                var barcode=id.replace(selCategory,"").replace("_"+selBox,"");
                if(this.skuAddRange>0){
                	var codeTotal=this.changeString2int(box.barcodeAmount(barcode));
              		var qtyCan=this.changeString2int(divS.attr("title"));
              		//alert("codeTotal:  "+codeTotal+"  qtyCan:  "+qtyCan+"  "+additionalQtycount+"  "+amount);
              		if(codeTotal>qtyCan){
              			if((codeTotal-qtyCan)>amount){
              				additionalQtycount+=amount;
              			}else{
              				additionalQtycount+=codeTotal-qtyCan;
              				jQuery(es[i]).parent("td").parent("tr").removeAttr("additional");
              			}
              		}else{
              			isadd=false;	
              		}
                }
                this.barcodeItem[barcode]=parseInt(this.barcodeItem[barcode],10)-amount;
                divS.html("");
                $(id).parentNode.parentNode.parentNode.removeChild($(id).parentNode.parentNode);
                es[i].checked=false;
                var box_item={};
              	box_item.m_box_no=selBox;
              	box_item.qty_ady=amount;
              	box_item.m_product_alias=barcode;
              	box_item.categorymark=jQuery.trim(jQuery("#"+selCategory+"M").text());
              	this.ADUm_item('delete',box_item);
            }
        }else{
            alert("请选择明细！");
        }
       var oldBox=this.changeString2int(jQuery("#currentBox").text());
       var oldTot=this.changeString2int(jQuery("#totBox").text());
       //alert(oldBox+"  "+count+"  "+oldTot);
       jQuery("#currentBox").text(oldBox-count);
       jQuery("#"+selCategory+"Table_"+selBox).attr("total",jQuery("#currentBox").text());
       jQuery("#totBox").text(oldTot-count);
       //alert(this.additionalQty+"   "+additionalQtycount);
       if(this.skuAddRange>0)
       this.additionalQty-=additionalQtycount;
       if(additionalQtycount==0&&len>0&&isadd)this.additionalQty=additionalQtycount;
       this.updateAdditionalText();
    },
    /**
     *Add by Robin 20101215 检查item 是否已存在于this.m_item中
     *@param item 目标明细
     */
    checkExistInM_item:function(item){
    	for(var i=0;i<this.m_item.length;i++){
  			if(this.m_item[i].m_product_alias==item.m_product_alias&&this.m_item[i].m_box_no==item.m_box_no&&this.m_item[i].categorymark==item.categorymark){
  				return true;
  			}
  		}
  		return false;
    },
    /**
     *Add by Robin 20101215 新增对this.m_item的 增删改 操作
     *@param action 增、改：AU、删:delete
     *@param item 目标明细
     */
    ADUm_item:function(action,item){
    	if(action==='AU'){
    		var a=false;
    		for(var i=0;i<this.m_item.length;i++){
    				
	    			if(this.m_item[i].m_product_alias==item.m_product_alias&&this.m_item[i].m_box_no==item.m_box_no&&this.m_item[i].categorymark==item.categorymark){
	    				this.m_item[i].qty_ady=item.qty_ady;
	    				a=true;
	    				break;
	    			}
	    		}
	     	if(!a){
	     		//alert("item:"+Object.toJSON(item));
	     		this.m_item.push(item);
	     	}
    	}else if(action==='delete'){
    		if(item.m_product_alias){
	    		for(var i=0;i<this.m_item.length;i++){
	    			if(this.m_item[i].m_product_alias==item.m_product_alias&&this.m_item[i].m_box_no==item.m_box_no&&this.m_item[i].categorymark==item.categorymark){
	    				this.m_item.splice(i,1);
	    				//这里要注意，splice操作以后数据的原当前位以后的元素都向左移了一位故i要减1
	    				i--
	    			}
	    		}
    			//alert(this.m_item.length);
	    	}else{
	    		for(var j=0;j<this.m_item.length;j++){	    			
	    			if(this.m_item[j].m_box_no==item.m_box_no&&this.m_item[j].categorymark==item.categorymark){
	    				this.m_item.splice(j,1);
	    				j--;
	    			}
	    		}
	    	}
    	}
    },
    //Add by robin 20110519 创建拣货明细的TR
    createTrBym_box_item:function(styleName,styleValue,value1_code,value2_code,barcode,qty,destination,additional,index,dQTY){
    	//alert(Object.toJSON(this.m_item));
    	var bg=false;
    	var s=0;
    	for(var i=0;i<this.m_item.length;i++){
    		if(this.m_item[i].m_product_alias==barcode){
    			s+=this.m_item[i].qty_ady;
    		}
    	}
    	//alert(qty+"  "+dQTY+"  "+s+"  "+index);
    	if(qty<dQTY||qty<s)bg=true;
    	//alert(this.m_item.length);
    	var tr="<tr height=\"29\" style=\""+(additional?"display:none;":"")+"\" "+(additional?"add=\"true\"":"")+">"+
             "<td bgcolor=\"#8db6d9\" style=\""+(bg?"background-color:yellow":"")+"\" class=\"td-bg\"><input type='checkbox'></td>"+
             "<td bgcolor=\"#8db6d9\" style=\""+(bg?"background-color:yellow":"")+"\" class=\"td-bg\"><div class=\"td-font\">"+styleName+"</div></td>"+
             "<td bgcolor=\"#8db6d9\" style=\""+(bg?"background-color:yellow":"")+"\" class=\"td-bg\"><div class=\"td-font\">"+styleValue+"</div></td>"+
             "<td bgcolor=\"#8db6d9\" style=\""+(bg?"background-color:yellow":"")+"\" class=\"td-bg\"><div class=\"td-font\">"+value1_code+"</div></td>"+
             "<td bgcolor=\"#8db6d9\" style=\""+(bg?"background-color:yellow":"")+"\" class=\"td-bg\"><div class=\"td-font\">"+value2_code+"</div></td>"+
             "<td bgcolor=\"#8db6d9\" style=\""+(bg?"background-color:yellow":"")+"\" class=\"td-bg\"><div class=\"td-font\" id=\""+destination+barcode+"_"+index+"\" title=\""+qty+"\" name='scan'>"+dQTY+"</div></td></tr>";
	    //alert(tr);
      return tr;
    },
    sort_barray:function(barray){
    	//alert(barray.length+"before_barray"+barray);
    	/*
    	barray.sort(function(e1,e2){
    		return e1>e2?1:(e1<e2?-1:0);
    	});
    	*/
    	var temp=0;
    	for(var i=0;i<barray.length;i++){
    		for(var j=i+1;j<barray.length;j++){
    			if(parseInt(barray[i])>parseInt(barray[j])){
    				temp=barray[i];
    				barray[i]=barray[j];
    				barray[j]=temp;
    			}
    		}
    	}
    	
    },
    _attHead:function(barray){
    	//alert(" :  "+barray);	
    	var ba="";
    	jQuery("#alert-message").css("display","block");
    	jQuery("#boxjz").css("display","block");
    	for(var i=0;i<barray.length;i++){
    		ba+="<input id=\"aa"+barray[i]+"\" type='checkbox' value=\""+barray[i]+"\"/>"+barray[i];
    	}
    	jQuery("#stable").html(""+ba+"");
    	//alert(this.choosebox());
    },
    removeM:function(){
    	jQuery("#alert-message").css("display","none");
    	jQuery("#boxjz").css("display","none");
    	jQuery("#barcode").focus();
    	//alert(this.c_box.length+"::  "+this.c_box);
    	if(this.c_box.length<=0)
    		this._onLoadBox_later(this.eve);	
    },
    choosebox:function(){
    	var cb= jQuery("#boxjz>div:visible :checkbox:checked");
    	//alert(cb.length);
    	var cbs=[];
    	if(cb.length<=0){
    		alert("请选择操作箱");
    		return;
    	}
    	for(var i=0;i<cb.length;i++){
    		cbs[i]=jQuery(jQuery(cb[i])).val();
    	}
    	//alert(cbs);
    	this.c_box=cbs;
    	this.removeM();
    	this._onLoadBox_later(this.eve);	
    },
    _onLoadBox:function(e){
    	var time1=new Date();
      time1=time1.getSeconds();
      var data=e.getUserData();
      var ret=data.jsonResult.evalJSON();
      this.returnData=ret;      
    	this.eve=e;
  	  this.barcodeCutlen=parseInt(jQuery("#barcode_cut_len").val(),10);
  	  if(isNaN(this.barcodeCutlen)) this.barcodeCutlen=0;
  	  if(document.getElementById("bjz")&&document.getElementById("bjz").value=="true")this.bjz=true;
			
			if(!ret.data||ret.data=="null"){
          alert("没有数据！");
          return;
      }
      //alert(Object.toJSON(ret));
      if(ret.M_BOX_LOAD){
      	//alert(ret.M_BOX_LOAD.BOXNO);
      	if(this.checkIsArray(ret.M_BOX_LOAD.BOXNO)){
      		for(var i=0;i<ret.M_BOX_LOAD.BOXNO.length;i++){
      			for(var j=i+1;j<ret.M_BOX_LOAD.BOXNO.length;j++){
      				if(ret.M_BOX_LOAD.BOXNO[i]===ret.M_BOX_LOAD.BOXNO[j]){
      					j=++i;
      				}
      			}
      			this.barray[this.barray.length]=ret.M_BOX_LOAD.BOXNO[i];
      		}
      	}else{
      		this.barray[0]=ret.M_BOX_LOAD.BOXNO;
      	}
      }else{
      	this.barray[0]=1;	
      }
      //alert(this.barray.length+"  :   "+this.barray);
      this.sort_barray(this.barray);
      if(this.bjz&&this.barray.length>1){
      	this._attHead(this.barray);
      	return;
      }else{
      	this._onLoadBox_later(this.eve);
      	return;
      }
    	
    },
    _onLoadBox_later:function(e){
        var time1=new Date();
        time1=time1.getSeconds();
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        this.returnData=ret;				
				if(!ret.data||ret.data=="null"){
            alert("没有数据！");
            return;
        }
        //alert(this.c_box);
        //alert(Object.toJSON(ret));
        
        //Add by gxy 判断ADDSDESC是否存在
        if(ret.M_BOX_LOAD&&ret.M_BOX_LOAD.ADDSDESC){
        	//alert(Object.toJSON(ret.M_BOX_LOAD.ADDSDESC));
        	if(this.checkIsArray(ret.M_BOX_LOAD.ADDSDESC)){
        		var adds=ret.M_BOX_LOAD.ADDSDESC;
	        	for(var i=0;i<adds.length;i++){
	        		if(adds[i]&&jQuery.trim(adds[i]).length!=0){
						var pdt=ret.M_BOX_LOAD.m_product_no[i];
	        			this.PDTADDSDESCS[pdt]=adds[i];
	        		}
	        	}
        	}else{
        		var pdt=ret.M_BOX_LOAD.m_product_no;
        		this.PDTADDSDESCS[pdt]=ret.M_BOX_LOAD.ADDSDESC;
        	}      	
        }
       
        //alert(Object.toJSON(this.PDTADDSDESCS));
        $("docon").value=ret.M_BOX_HD.DOCON;
        $("tableType").value=ret.M_BOX_HD.TABLETYPE;
        $("status").value=ret.M_BOX_HD.STATUS;
        $("desc").value=ret.M_BOX_HD.desc||"";
        if(ret.M_BOX_HD.STATUS==2){
            $("submitImge").style.display="";
        }
        if(!$("customer")||$("customer").value!="jz"){
            var ops=$("boxRule").options;
            for(var i=0;i<ops.length;i++){
                if(ops[i].value==ret.M_BOX_HD.BOXRULE){
                    ops[i].selected = true;
                }
            }
            var adds=ret.ADDRESS||"";
            if(this.checkIsArray(adds)){
                $("address").value=adds[0];
            }else{
                $("address").value=adds;
            }
        }
        var manuS="<input type=\"hidden\" id=\"selCategory\" value=\"\"/>";
        //当前选中箱号 input隐藏
        var manuBox="<input type =\"hidden\" id=\"selBox\" value=\"1\"/>";
        var itemS="";
        var destination=ret.DESTINATION;
        //alert(ret.DESTINATION);
        var totBox=0;
        var destinations=new Array();
        if(this.checkIsArray(destination)){
            destinations=destination;
            this.addr=adds;
        }else{
            this.addr[0]=adds;
            destinations[0]=destination;
        }
        if(this.checkIsArray(ret.data)){
          this.data=ret.data;  
        }else{
           this.data[0]=ret.data;
        }
        this.skuAddRange=0;
        if($("skuAddRange")&&$("skuAddRange").value)
        	this.skuAddRange=parseInt($("skuAddRange").value,10);
        var minBoxNo=new Array();
        for(var j=0;j<destinations.length;j++){
            this.category[destinations[j]]=j;
            manuS+="<li id=\""+j+"M\" style=\"cursor:pointer;width:110px;\" onclick=\"box.selCategorySty(event,'"+j+"',"+j+")\" ><span id=\""+j+"eq\"><img name='uneq' src=\"images/inco-uneq.gif\"  width=\"16\" height=\"16\"/></span>"+destinations[j]+"</li>";
            manuBox+="<ul id=\""+j+"Num\">";
            if(!ret.M_BOX_LOAD){
            	manuBox+="<li id=\""+j+"_1\" style=\"cursor:pointer;width:75px;\" onclick=\"box.selSty(event,'"+j+"',1);this.style.backgroundColor='#ddd';\">"+(this.bjz?"<input type=\"checkbox\" name=\"subbox\" id=\"1\" value=\"1\" onclick=\"box.selSty(event,'"+j+"',1);\" "+(this.bjz?"checked":"")+"/>":"")+"1</li>";
            }else{
                var boxNoes=new Array();
                if(this.checkIsArray(ret.M_BOX_LOAD.m_product_no)){
                    var pdtNo=ret.M_BOX_LOAD.m_product_no;
                    for(var u=0;u<pdtNo.length;u++){
                        if(ret.M_BOX_LOAD.categorymark[u]==destinations[j]){
                            boxNoes.push(ret.M_BOX_LOAD.BOXNO[u]);
                        }
                    }
                }else{
                    if(ret.M_BOX_LOAD.categorymark==destinations[j]){
                        boxNoes.push(ret.M_BOX_LOAD.BOXNO);
                    }
                }
                if(boxNoes.length>0){
                    boxNoes=ztools.mergeArr(boxNoes).sort(function(a,b){
                        var v1=parseInt(a,10);
                        var v2=parseInt(b,10);
                        if(isNaN(v1)||isNaN(v2)){
                            return -1;
                        }else{
                            return v1-v2;
                        }
                    });
                    minBoxNo[j]={};
                    minBoxNo[j].minbox=boxNoes[0];
                    minBoxNo[j].dest = destinations[j];
                    //alert(this.barray+"  "+this.c_box);
                    if(this.c_box.length>0){
                    	for(var nk=0;nk<this.barray.length;nk++){
                    		var che=false;
                    		for(var v=0;v<this.c_box.length;v++){
                    			if(parseInt(this.barray[nk])==this.c_box[v]){
                    				che=true;
                    			}
                    		}
                    		manuBox+="<li id=\""+j+"_"+this.barray[nk]+"\" style=\"cursor:pointer;width:75px;\" onclick=\"box.selSty(event,'"+j+"',"+this.barray[nk]+");this.style.backgroundColor='#ddd';\">"+(this.bjz?"<input type=\"checkbox\" name=\"subbox\" onclick=\"box.selSty(event,'"+j+"',"+this.barray[nk]+");\" id=\""+this.barray[nk]+"\" value=\""+this.barray[nk]+"\" "+(che?"checked":"")+">":"")+this.barray[nk]+"</li>";
                    	}
                    }else{
                    	for(var nk=0;nk<this.barray.length;nk++){
	                      manuBox+="<li id=\""+j+"_"+this.barray[nk]+"\" style=\"cursor:pointer;width:75px;\" onclick=\"box.selSty(event,'"+j+"',"+this.barray[nk]+");this.style.backgroundColor='#ddd';\">"+(this.bjz?"<input type=\"checkbox\" name=\"subbox\" onclick=\"box.selSty(event,'"+j+"',"+this.barray[nk]+");\" id=\""+this.barray[nk]+"\" value=\""+this.barray[nk]+"\" checked>":"")+this.barray[nk]+"</li>";
	                    }
                    }
                }else{
                	manuBox+="<li id=\""+j+"_1\" style=\"cursor:pointer;width:75px;\" onclick=\"box.selSty(event,'"+j+"',1);this.style.backgroundColor='#ddd';\">"+(this.bjz?"<input type=\"checkbox\" name=\"subbox\" onclick=\"box.selSty(event,'"+j+"',1);\" id=\"1\" value=\"1\" "+(this.bjz?"checked":"")+">":"")+"1</li>";
                }
            }
            /*manuBox+="<li id=\""+j+"\" style=\"display:none;cursor:pointer;width:60px;\" onclick=\"box.selSty(event,'"+j+"');this.style.backgroundColor='#ddd';\"></li>"+
                     "</ul>";*/
            manuBox+="</ul>";
            itemS+="<div class=\"zh-from-left02\" id=\""+j+"TableDiv\" style=\"overflow-y:auto;overflow-x:hidden;height:282px;\"><input type=\"hidden\"/>"+
                   "<table id=\""+j+"Table_1\" width=\"99%\" style=\"table-layout:fixed;display:none;\" border=\"1\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#8db6d9\" bordercolorlight=\"#FFFFFF\" bordercolordark=\"#FFFFFF\" bgcolor=\"#8db6d9\" class=\"modify_table\">"+
                   "<col width=\"40\">"+
                   "<col width=\"142\">"+
                   "<col width=\"142\">"+
                   "<col width=\"130\">"+
                   "<col width=\"130\">"+
                   "<col width=\"auto\">";
                   
            itemS+="</tbody></table></div>";         
        }
				jQuery("#destination").html(manuS);
        jQuery("#zh-xh").html(manuBox);
        jQuery("#showContent").html(itemS);
        $("selCategory").value=this.category[destinations[0]];
        var minbox=1;
        this.totAlQty=0;
        for(var o=0;o<destinations.length;o++){
            for(var u=0;u<minBoxNo.length;u++){
                if(minBoxNo[u].dest=destinations[o]){
                    minbox=minBoxNo[u].minbox;
                }
            }
            if(!ret.M_BOX_LOAD){
                this.cloneT(this.category[destinations[o]]+"Table",1);
            }else{
            	//alert(Object.toJSON(ret.M_BOX_LOAD));
                var tableState=false;
                if(this.checkIsArray(ret.M_BOX_LOAD.m_product_no)){
                    var pdtNo=ret.M_BOX_LOAD.m_product_no;
                    //this.cloneT(this.category[destinations[o]]+"Table",minbox);
                    for(var g=0;g<pdtNo.length;g++){
                    	var qtyOut=this.changeString2int(ret.M_BOX_LOAD.QTYOUT[g]);
                  	
                  		if(ret.M_BOX_LOAD.categorymark[g]==destinations[o]){
                        totBox+=qtyOut;
                        tableState=true;
                        if(ret.M_BOX_LOAD.BOXNO[g]==minbox){
                            if(qtyOut>0){
                            	 this.fillScanQtyToHTML(destinations[o],ret.M_BOX_LOAD.m_product_no[g],ret.M_BOX_LOAD.BOXNO[g],ret.M_BOX_LOAD.QTYOUT[g]);
                            	 jQuery("#"+this.category[destinations[o]]+"Table_"+ret.M_BOX_LOAD.BOXNO[g]).attr("total",box.countBoxOnLoad(ret,this.category[destinations[o]],ret.M_BOX_LOAD.BOXNO[g]));
                            }
                        }
                        this.totAlQty+=qtyOut;
                        var box_item={};
                      	box_item.m_box_no=ret.M_BOX_LOAD.BOXNO[g];
                      	box_item.qty_ady=parseInt(ret.M_BOX_LOAD.QTYOUT[g],10);
                      	box_item.m_product_alias=ret.M_BOX_LOAD.m_product_no[g];
                      	box_item.categorymark=destinations[o];
                      	this.ADUm_item('AU',box_item);
                      }	
                       
                    }
                }else{
                    if(ret.M_BOX_LOAD.categorymark==destinations[o]){
                        this.cloneT(this.category[destinations[o]]+"Table",ret.M_BOX_LOAD.BOXNO);
                        var qtyOut=this.changeString2int(ret.M_BOX_LOAD.QTYOUT);
                        this.totAlQty+=qtyOut;
                        if(qtyOut>0){
                        		var box_item={};
                          	box_item.m_box_no=ret.M_BOX_LOAD.BOXNO;
                          	box_item.qty_ady=parseInt(ret.M_BOX_LOAD.QTYOUT,10);
                          	box_item.m_product_alias=ret.M_BOX_LOAD.m_product_no;
                          	box_item.categorymark=destinations[o];
                          	this.ADUm_item('AU',box_item);
                          	totBox+=qtyOut;
                          	jQuery("#"+this.category[destinations[o]]+"Table_"+ret.M_BOX_LOAD.BOXNO).attr("total",box.countBoxOnLoad(ret,this.category[destinations[o]],ret.M_BOX_LOAD.BOXNO));
                          	this.fillScanQtyToHTML(destinations[o],ret.M_BOX_LOAD.m_product_no,ret.M_BOX_LOAD.BOXNO,ret.M_BOX_LOAD.QTYOUT);
                        }
                        tableState=true;
                    }
                }
                if(!tableState)this.cloneT(this.category[destinations[o]]+"Table",1);
            }
            jQuery("#"+this.category[destinations[o]]+"Num > li")[0].style.backgroundColor="#ddd";
            if(o>0){
                $(this.category[destinations[o]]+"TableDiv").style.display="none";
                $(this.category[destinations[o]]+"Num").style.display="none";
            }
        }
        jQuery("#destination > li")[0].style.backgroundColor="#ddd";
        if(this.boxType=="out")
        jQuery("#boxadd,#boxdel,#barcode").removeAttr("disabled");
        this.showFirst($("selCategory").value);
        this.countBox();
        if(ret.M_BOX_HD.STATUS==2){
            jQuery("#barcode").attr("disabled","true");
            jQuery("#pdt_count").attr("disabled","true");
            jQuery("#desc").attr("disabled","true");
            jQuery("#model").attr("disabled","true");
        }
        $("isSaved").value="save";
        this.codeModel();
        if(this.returnData.M_BOX_LOAD&&this.returnData.M_BOX_LOAD.m_product_no){
            this.getBarcodeItem();
            //this.refreshAdditionalItem();
            this.additionalQty=this.getTotAdditionalQty();
        }
        //alert(this.c_box);
        if(this.c_box.length<=0)
        	jQuery("#barcode").focus();
        	
        jQuery("#totBox").text(totBox);
        this.updateAdditionalText();
        var time2=new Date();
        time2=time2.getSeconds();
        
        try{
        console.log("create page time:"+(time2-time1));
        }catch(e){
        }
        jQuery("#correctErrorCode").bind("keyup",function(event){if(event.target==this&&event.which==13){box.onCorrectError();}});
        if(!window.document.addEventListener){
            window.document.attachEvent("onkeydown",hand11);
            function hand11()
            {
                if(window.event.keyCode==13){
                    return false;
                }
            }
        }
    },
    //获取barcode存在于this.additionalItem的索引，没有则返回-1
    getBarcodeIndexInAdditionalItem:function(barcode){
    	for(var i=0;i<this.additionalItem.length;i++){
    		if(this.additionalItem[i].barcode==barcode)return i;
    	}
    	return -1;
    },
    //更新超量明细
    addQtyAdditionalItem:function(barcode,qty){
    	var index=this.checkBarcodeExistInAdditionalItem(barcode);
    	if(index!=-1){
    		this.additionalItem[index].qty+=this.changeString2int(qty);
    		if(this.additionalItem[index].qty<0)this.additionalItem[index].qty=0;
    	}else{
    		var qy=this.changeString2int(qty);
    		if(qy>0){
    			var item={};
    			item.barcode=barcode;
    			item.qty=qy;
    			this.additionalItem.push(item);
    		}
    	}
    	
    },
    //初始化超量明细
    refreshAdditionalItem:function(){
    	//先找不存在的条码
    	a:for(var i=0;i<this.m_item.length;i++){
    			for(var j=0;j<this.data.length;j++){
    				if(this.m_item[i].m_product_alias==this.data[j].m_box_item.NO)continue a;
    			}
    			this.addQtyAdditionalItem(this.m_item[i].m_product_alias,this.m_item[i].qty_ady);
    		}
    	//存在超量
    	for(var k=0;k<this.data.length;k++){
    		var qty=this.changeString2int(this.data[k].m_box_item.QTY);
    		var qty_al=this.barcodeItem[this.data[k].m_box_item.m_product_alias];
    		qty_al=qty_al?qty_al:0;
    		if(qty_al>qty){
    			this.addQtyAdditionalItem(this.data[k].m_box_item.m_product_alias,(qty_al-qty));
    		}
    	}
    },
    //页面装载时 计算出总的超出量
    getTotAdditionalQty:function(){
    	var totAdditionalQty=0;
    	var totBarcodeItemQtyInOder=0;
			//alert(this.data.length+"  "+Object.toJSON(this.barcodeItem)+"  "+Object.toJSON(this.data));
			for(var i=0;i<this.data.length;i++){
    		var barcode=this.data[i].m_box_item.NO;
    		var barcodeItemQty=this.changeString2int(this.barcodeItem[barcode]);
    		totBarcodeItemQtyInOder+=barcodeItemQty;
    		var diff=this.changeString2int(this.data[i].m_box_item.QTY);
    		diff=barcodeItemQty-diff;
    		totAdditionalQty+=diff>0?diff:0;
    	}
    	var totAlQty=0;
	    for(var j=0;j<this.m_item.length;j++){
				totAlQty+=this.changeString2int(this.m_item[j].qty_ady);
	    }
		//alert(totAdditionalQty+"   "+totAlQty+"   "+totBarcodeItemQtyInOder);
	  totAdditionalQty+=totAlQty-totBarcodeItemQtyInOder;
		return totAdditionalQty;
    },
    updateAdditionalText:function(){
    	jQuery("#totAdditional").text(this.additionalQty>0?this.additionalQty:0);
    },
    //Add by Robin 20110519 获取增加条码行（TR）的第一个
    getFirstAdditionalTr:function(){
    	return jQuery("#showContent>div:visible>table:visible tr[add='true']:first");
    },
    /**
     *Add by Robin 20110519 当该条码不存在单据中时，查找当前箱下的TABLE下的第一个含有属性add='true'的TR，将条码信息填入、置上扫描数量并属性add删除
     *由于条码不存在单据中故款号 及颜色 尺寸信息都需要与服务器交互获得，故得使用AJAX请求。
     *为了区分是装载单箱时还是扫描的插入加入参数 isScan,扫描时需要控制所有动作按钮及输入框禁用
     */
    fillScanQtyToHtmlWhenBarcodeNotInOrder:function(destination,barcode,boxNo,qtyOut,isScan){
    	if(isScan){
    		this.loadingMessage();
    		jQuery("#zh-btn input").attr("disabled","true");
    		jQuery("#zh-cz-height input").attr("disabled","true");
    	}
    	jQuery.ajax({
    		type:"POST",
    		url:"getBarcodeInfo.jsp",
    		data:"Barcode="+barcode,
    		error:function(){
    			if(isScan){
    				alert("网络不畅,请稍后再试！");
    				jQuery("#zh-btn image,image").removeAttr("disabled");
    				jQuery("#zh-cz-height input").removeAttr("disabled");
    			}
    		},
    		success:function(data){
    			data=jQuery.trim(data);
    			if(isScan){
    				jQuery("#zh-btn input").removeAttr("disabled");
    				jQuery("#zh-cz-height input").removeAttr("disabled");
    			}
    			if(data!="error"){
    				data=data.evalJSON();
    				var eleTr=box.getFirstAdditionalTr();
    				jQuery("td:eq(1)>div",eleTr).html(data.name);
    				jQuery("td:eq(2)>div",eleTr).html(data.value);
    				jQuery("td:eq(3)>div",eleTr).html(data.value1_code+"");
    				jQuery("td:eq(4)>div",eleTr).html(data.value2_code+"");
    				jQuery("td:eq(5)>div",eleTr).attr("id",box.category[destination]+barcode+"_"+boxNo);
    				jQuery("td:eq(5)>div",eleTr).attr("title",0);
    				jQuery("td:eq(5)>div",eleTr).html(qtyOut);
    				eleTr.removeAttr("add");
    				eleTr.children().css("backgroundColor","yellow");
    				eleTr.attr("additional","true");
    				eleTr.show();
    				//当扫描条码时，若没有添加,data.addsdesc输入条码的配饰
    				//判断this.PDTADDSDESCS内是否有该条码barcode
    				var pdts=box.PDTADDSDESCS;
    				if(!pdts[barcode]){
    					pdts[barcode]=data.addsdesc;
    				}
    				//alert(Object.toJSON(pdts));
    				
    				if(isScan){
						box.todoWhenScanBarcodeSucc(barcode,qtyOut);
    					box.additionalQty+=box.changeString2int(qtyOut);
    					box.updateAdditionalText();
    				}
    			}else{
    				alert("条码不存在！");
    				jQuery("#barcode").val("");
						if(jQuery("#alert-error").is(":hidden")){
       	 			jQuery("#barcode").focus();
      			}
    			}
    			
    		}
    	});
    	
    },
    //Add by Robin 20110519 将已扫描的数量填入到界面上，单箱LOAD时的动作
    fillScanQtyToHTML:function(destination,barcode,boxNo,qtyOut){
    	var eleDiv=$(this.category[destination]+barcode+"_"+boxNo);
    	if(eleDiv){
    		eleDiv.innerHTML=qtyOut;
    		var eleTr=eleDiv.parentNode.parentNode;
    		eleTr.style.display="";
    		var qtyCan=this.changeString2int(eleDiv.title);
    		if(qtyOut>qtyCan){
    			jQuery(eleTr).attr("additional","true");
    			jQuery(eleTr).children().css("backgroundColor","yellow");
    		}
    	}else{
    		this.fillScanQtyToHtmlWhenBarcodeNotInOrder(destination,barcode,boxNo,qtyOut,false);
    	}
    	//todo......
    },
    
    loadingMessage:function(){
    	dwr.util.useLoadingMessage("数据处理中...");
    },
    load:function(){
        var w = window.opener;
        if(w==undefined)w= window.parent;
        var e=jQuery(w.document).find("div[class='pop-up-inner']")[0];
        var e1=jQuery(e).find("table[class='pop-up-header']")[0];
        jQuery(e1).find("td").html("");
        jQuery(e1).find("td").html("");
    },
    closePop:function(){
        var isSave=$("isSaved").value.strip();
        var w = window.opener;
        if(w==undefined)w= window.parent;
        if(isSave!="save"){
            if(confirm("数据已变动，您还没有保存！确定结束装箱？")){
                if (w){
                    var iframe=w.document.getElementById("popup-iframe-0");
                    if(iframe){
                        //w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'));",1);
                        art.dialog.close();
                        return true;
                    }
                }
                return false;
            }
        }else{
            if (w){
                var iframe=w.document.getElementById("popup-iframe-0");
                if(iframe){
                    //w.setTimeout("Alerts.killAlert(document.getElementById('popup-iframe-0'));",1);
                    art.dialog.close();
                    return true;
                }
            }
            return false;
        }
    },
    removeMask:function(){
          jQuery("#alert-message").css("display","none");
          jQuery("#showBarcode").css("display","none");
     },
    showCurrentBarcode:function(){
        var str="<table id='modify_table_product'  sytle=\"table-layout:fixed;float:left;margin-left:5px;\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" bgcolor=\"#8db6d9\">";
        str+="<tr><td class='hd' bgcolor=\"#FFFFFF\" width='50'>序号</td><td class='hd' bgcolor=\"#FFFFFF\" width='150'>条码</td></tr>";
        for(var i=0;i<this.record.length;i++){
             str+="<tr><td class='hi' bgcolor=\"#FFFFFF\" width='50'>"+(i+1)+"</td><td class='hi' bgcolor=\"#FFFFFF\" width='150'>"+this.record[i]+"</td></tr>";
				}
        str+="</table>"
        jQuery("#barcode_table").html(str);
        jQuery("#alert-message").css("display","block");
        jQuery("#showBarcode").css("display","");
    },
    getOrderTotNum:function(data){
        var items=new Array();
        if(this.checkIsArray(data)){
            items=data;
        }else{
            items[0]=data;
        }
        var num=0;
        for(var i=0;i<items.length;i++){
            var numitem=this.changeString2int(items[i].m_box_item.QTY);
            num+=numitem;
        }
        return num;
    },
    printBox:function(boxNoId){
        var evt={};
        evt.tag="Print";
        evt.command="PrintJasper";
        evt.callbackEvent="PrintJasper";
        evt.params={"table":jQuery("#m_boxitem_table_id").val(),"id":boxNoId};
        this._executeCommandEvent(evt);
    },
    getBoxNoId:function(){
        jQuery.get(this.boxType=="out"?"getBoxNoId.jsp":"getBoxNoIdIn.jsp",{"boxno":$("selBox").value,"boxid":$("m_box_id").value},function(data){
            box.printBox(data.strip());
        });
    },
    waitOneMomentToPrint:function(){
        if($('disabledZone'))$('disabledZone').style.visibility = 'hidden';
        window.print_iframe.focus();
        window.print_iframe.print();
        if(oc._closeWindow) {
            alert(gMessageHolder.CLOSE_AFTER_PRINT);
            oc._closeWindowOrShowMessage(null);
        }
    },
    _onPrintJasper:function(e){
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
                setTimeout('box.waitOneMomentToPrint()', 1000);
            };
            ifm.location.href= f;
        }
    },
    cloneT:function(categoryTable,index){
    	var itemS="";
   		var j=categoryTable.replace("Table","");
   		this.scanCategory=j;
   		this.scanBoxno=index;
      itemS+="<div class=\"zh-from-left02\" id=\""+j+"TableDiv\" style=\"overflow-y:auto;overflow-x:hidden;height:282px;\"><input type=\"hidden\"/>"+
             "<table id=\""+j+"Table_"+index+"\" width=\"99%\" style=\"table-layout:fixed;\" border=\"1\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#8db6d9\" bordercolorlight=\"#FFFFFF\" bordercolordark=\"#FFFFFF\" bgcolor=\"#8db6d9\" class=\"modify_table\">"+
             "<col width=\"40\">"+
             "<col width=\"142\">"+
             "<col width=\"142\">"+
             "<col width=\"130\">"+
             "<col width=\"130\">"+
             "<col width=\"auto\">";
      if(this.returnData.M_BOX_LOAD&&this.m_item.length<=0){
		    var ms=this.returnData.M_BOX_LOAD;
	    }else if(this.m_item&&this.m_item.length>0){
        var ms=this.m_item;
  		}else{
  			return;	
  		}
      var des=new Array();
      if(this.checkIsArray(this.returnData.DESTINATION)){
      	des=this.returnData.DESTINATION;	
      }else{
      	des[0]=this.returnData.DESTINATION;	
      }
      //alert("111:"+this.m_item.length);
      if(this.m_item&&this.m_item.length>0){
      	ms=this.m_item;
      	for(var n=0;n<ms.length;n++){
      		for(var s=0;s<this.data.length;s++){
            if(ms[n].qty_ady>0&&index==ms[n].m_box_no&&this.data[s].m_box_item.DESTINATION==ms[n].categorymark&&ms[n].m_product_alias==this.data[s].m_box_item.NO){
            	 itemS+=this.createTrBym_box_item(this.data[s].m_box_item.NAME,this.data[s].m_box_item.VALUE,this.data[s].m_box_item.VALUE1_CODE,this.data[s].m_box_item.VALUE2_CODE,this.data[s].m_box_item.NO,this.data[s].m_box_item.QTY,j,false,index,ms[n].qty_ady);
            }
          }
      	}
      }else{
      	var mbl=[];
      	var msboxno=[];
      	var mscat=[];
      	var msqty=[];
    	  if(this.returnData.M_BOX_LOAD){
    	  	 if(this.checkIsArray(ms.m_product_no)){
    	  	 	 mbl=ms.m_product_no;
	      		 msboxno=ms.BOXNO;
	      		 mscat=ms.categorymark;
	      		 msqty=ms.QTYOUT;
    	  	 }else{
      	 		 mbl[0]=ms.m_product_no;
	      		 msboxno[0]=ms.BOXNO;
	      		 mscat[0]=ms.categorymark;
	      		 msqty[0]=ms.QTYOUT;
      		 }
	      }else{
	     	  mbl=des;	
	      }
	      //alert(mbl.length+"  "+Object.toJSON(ms));
      	for(var m=0;m<mbl.length;m++){
      		//alert(msqty[m]+"  "+index+"   "+msboxno[m]+"   "+des[j]+"   "+mscat[m]);
      		if(index==msboxno[m]&&des[j]==mscat[m]){
      			for(var s=0;s<this.data.length;s++){
              if(msqty[m]>0&&this.data[s].m_box_item.DESTINATION==des[j]&&mbl[m]==this.data[s].m_box_item.NO){
              	itemS+=this.createTrBym_box_item(this.data[s].m_box_item.NAME,this.data[s].m_box_item.VALUE,this.data[s].m_box_item.VALUE1_CODE,this.data[s].m_box_item.VALUE2_CODE,this.data[s].m_box_item.NO,this.data[s].m_box_item.QTY,j,false,index,msqty[m]);
              }
            }
      		}
      	}
      }

      itemS+="</tbody></table></div>";
      jQuery("#showContent").html(itemS);
      $("selBox").value=index;
    },
    selCategorySty:function(event,category,count){
        $("selCategory").value=category;
        var uls=jQuery("#zh-xh > ul");
        var divs=jQuery("#showContent > div");
        for(var i=0;i<uls.length;i++){
            uls[i].style.display="none";
        }
        for(var j=0;j<divs.length;j++){
            divs[j].style.display="none";
        }
        var lies=jQuery("#destination > li");
        var lies1=jQuery("#"+category+"Num > li");
        for(var ss=0;ss<lies.length;ss++){
            if(lies[ss].style.backgroundColor!=""){
                lies[ss].style.backgroundColor="";
                lies[ss].firstChild.firstChild.style.backgroundColor="";
                for(var ui=0;ui<lies1.length;ui++){
                    if(lies1[ui].style.backgroundColor!=""){
                        $("selBox").value=lies1[ui].innerHTML.strip();
                    }
                }
            }
        }
        Event.element(event).style.backgroundColor="#ddd";
        $(category+"TableDiv").style.display="";
        $(category+"Num").style.display="";
        $("address").value=this.addr[count];  //del if(count>=0)....
        this.countBox();
    },
    addBox:function(category){
        if($("status").value.strip()=="2"){
            alert("单据已提交，不可操作！");
            return;
        }
        this.add(category);
    },
    getTotBoxNum:function(){
    	var count=0;
    	for(var i=0;i<this.m_item.length;i++){
    		count+=this.m_item[i].qty_ady;
    	}
    	return count;
    },
    //获得单箱的总数量
    getOneBoxNum:function(boxNo){
    	var category=jQuery.trim(jQuery("#"+$("selCategory").value.strip()+"M").text());
    	var count=0;
			//alert(this.m_item.length+"  "+boxNo+"  "+Object.toJSON(this.m_item));
    	for(var i=0;i<this.m_item.length;i++){
			//alert(this.m_item[i].m_box_no+"  "+boxNo+"  "+this.m_item[i].categorymark+"  "+category);
    		if(this.m_item[i].m_box_no==boxNo&&this.m_item[i].categorymark==category){
				count+=this.m_item[i].qty_ady;
    		}
    	}
		return count;
    },
    will_inputbox:function(b,w){
    	var i=[];
    	this.sort_barray(this.barray);
    	for(var m=1;m<b;m++){
    		for(var n=0;n<w;n++){
    			if(parseInt(this.barray[n])>=m){
	    			if(parseInt(this.barray[n])==m){
	    				break;
	    			}else{
	    				i.push(m);
	    				break;
	    			}
	    		}
    		}
    	}
    	//alert(i);
    	return i;
    },
    //获取已扫描的箱号有哪些
    box_select:function(){  
    	jQuery("#alert-message").css("display","block");  	
    	jQuery("#boxselect").css("display","block");
    	var s="请输入";
	    var t=0;
	    for(var i=0;i<this.barray.length;i++){
	    	if(t<parseInt(this.barray[i]))t=parseInt(this.barray[i]);
	    }
	    //alert("未出现的箱号:    "+this.will_inputbox(t,this.barray.length));
	    var noselectbox=this.will_inputbox(t,this.barray.length);
	    for(var j=0;j<noselectbox.length;j++){
	    	if(j<3){
	   			s+=" "+noselectbox[j]+" ";
	   		}else if(j>=3&&j==noselectbox.length-1){
	   			s+="...";
	   		}
	    }
	    if(t==0)t=1;
	    s+=" >"+t+"号的箱子";
	    //alert(s);
    	document.getElementById("input_box").innerHTML=s;
    	this.lastbox=t;
	    jQuery("#box_add").focus();
	    jQuery("#box_add").bind("keydown",function(event){
          var prop=window.document.getElementById("box_add").value;
          if(event.which==13){
          	if(prop>0)
              box.operatebox();
          }
      });
    },
    operatebox:function(){
    	var o=document.getElementById("box_add").value;
    	if(o==""){
    		alert("请输入操作箱号");
    	}else if(o<0){
    		alert("请输入正确的箱号");
    	}else{
	    	//判断输入的数值有效
	    	for(var i=0;i<this.barray.length;i++){
	    		if(o==this.barray[i]){
	    			alert("输入箱已存在，不可增加");
	    			document.getElementById("box_add").value="";
	    			jQuery("#box_add").focus();
	    			return;
	    		}
	    	}
	    	document.getElementById("box_add").value="";
	    	this.barray.push(o);
	    	this.sort_barray(this.barray);
    		this.add_inputbox(this.scanCategory,o);
	    }
    },
    defaultbox:function(){
    	//alert(this.lastbox+"default_0:"+this.barray.length+"  "+this.barray);
    	this.sort_barray(this.barray);
    	this.barray.push(parseInt(this.lastbox)+1);
    	this.add_inputbox(this.scanCategory,parseInt(this.lastbox)+1);
    },
    add:function(category){
    	if(this.bjz){
    		this.box_select();
    	}else{
    		this.add_inputbox(category);	
    	}	
    },
    search_behind:function(input_box){
    	for(var i=0;i<this.barray.length;i++){
    		//if(parseInt(this.barray[i])<input_box&&parseInt(this.barray[i+1])==input_box)
    		if(i==0&&parseInt(this.barray[i])==input_box)return this.barray[i+1];
    		if(parseInt(this.barray[i])==input_box) return this.barray[i-1];
    	}
    	return input_box;
    },
    add_inputbox:function(category,o){
    	//alert(category+"  "+o+"  "+$("selBox").value);
        var currentBoxNo=$("selBox").value.strip();
        var addBoxCount=parseInt(currentBoxNo)+1;
        if(o>0)addBoxCount=o;
        //alert(this.barray);
        //判断当前箱号添加的位置this.lastbox-最后一箱
        if($(category+"_"+addBoxCount)){
            var lies=jQuery("#"+category+"Num > li");
            addBoxCount=parseInt(lies[lies.length-2].innerHTML)+1;
            dwr.util.cloneNode(category,{idSuffix:"_"+addBoxCount});
        }else{
        	var behind=0;
        	if(o>0){
        		//扫描的存在的前一箱
        		behind=this.search_behind(o);
        		//alert(behind+"  "+this.scanBoxno+"  "+o);
        	}
        	//alert(this.scanBoxno+"  "+o+"　"+behind);
        	if(this.scanBoxno>o&&behind>o){
        		jQuery("<li id=\""+category+"_"+addBoxCount+"\" style=\"cursor:pointer;width:75px;\" onclick=\"box.selSty(event,'"+category+"',"+addBoxCount+");this.style.backgroundColor='#ddd';\">"+(o>0?"<input type=\"checkbox\"id=\""+addBoxCount+"\" value=\""+addBoxCount+"\" onclick=\"box.selSty(event,'"+category+"',"+addBoxCount+")\" name=\"subbox\" checked /> ":"")+addBoxCount+"</li>").insertBefore("#"+category+"_"+((o>0)?(behind):(addBoxCount-1)));
        	}else{
        		jQuery("<li id=\""+category+"_"+addBoxCount+"\" style=\"cursor:pointer;width:75px;\" onclick=\"box.selSty(event,'"+category+"',"+o+");this.style.backgroundColor='#ddd';\">"+(o>0?"<input type=\"checkbox\" id=\""+addBoxCount+"\" value=\""+addBoxCount+"\" onclick=\"box.selSty(event,'"+category+"',"+addBoxCount+")\" name=\"subbox\" checked > ":"")+addBoxCount+"</li>").insertAfter("#"+category+"_"+((o>0)?(behind):(addBoxCount-1)));
        	}
        }
				jQuery("#alert-message").css("display","none");
				jQuery("#boxselect").css("display","none");
				$(category+"_"+addBoxCount).style.display="";
         //$(category+"_"+addBoxCount).innerText=addBoxCount;
         this.cloneT(category+"Table",addBoxCount);
         for(var i=0;i<this.delbox.length;i++){
	        if(this.delbox==o){
	        	this.delbox.splice(i,1);	
	        }
	       }
	       $("isSaved").value="unSave";
         $(category+"_"+addBoxCount).scrollIntoView();
				jQuery("#"+category+"_"+addBoxCount).click();
    },
    delBox:function(category){
        this.dele(category);
    },
    getTotAlQty:function(){
    	var totAlQty=0;
    	for(var i=0;i<this.m_item.length;i++){
    		totAlQty+=this.m_item[i].qty_ady;
    	}
    	return totAlQty;
    },
    //删除单箱时处理数据
    doWhenDeleteOneBox:function(boxNo,category){
    	var c=jQuery.trim(jQuery("#"+category+"M").text());
    	for(var i=0;i<this.m_item.length;i++){
    		if(this.m_item[i].m_box_no==boxNo&&this.m_item[i].categorymark==c){
    			this.barcodeItem[this.m_item[i].m_product_alias]=this.changeString2int(this.barcodeItem[this.m_item[i].m_product_alias])-this.m_item[i].qty_ady;
    		}
    	}
    	$(category+"_"+boxNo).remove();
      $(category+"Table"+"_"+boxNo).remove();
      //记录被删除的箱号
      this.delbox.push(boxNo); 
      //this.barray更新
      for(var j=0;j<this.barray.length;j++){
      	if(boxNo==parseInt(this.barray[j])){
      		this.barray.splice(j,1);	
      	}
      }
      var box_item={};
    	box_item.m_box_no=boxNo;
    	box_item.categorymark=c;
    	this.ADUm_item('delete',box_item);
    	
     	jQuery("#totBox").text(this.getTotBoxNum());
     	this.showAdditionalQty();
    },
    showAdditionalQty:function(){
    	this.additionalQty=this.getTotAdditionalQty();
    	this.updateAdditionalText();
    },
    
    dele:function(category){
        if($("status").value.strip()=="2"){
            alert("单据已提交，不可操作！");
            return;
        }
        if(!$(category+"_"+$("selBox").value)){
            alert("请选择箱号！");
            return;
        }
        if(confirm("确认删除"+$("selBox").value+"号箱?")){
            if(jQuery("#"+category+"Num > li").length>=2){
            	  //var cb=jQuery("#zh-from-left01>div:visible :checkbox:checked");
				        if(!(jQuery("#"+this.scanBoxno+"").is(":checked"))&&this.bjz){
				        	alert("请选中复选框，且只能删除当前箱");	
				        	return;
				        }
				        
                this.doWhenDeleteOneBox(jQuery.trim($("selBox").value),category);
            }else{
                alert("最后一箱不可删除！");
            }
            this.showFirst(category);
        }
        $("isSaved").value="unSave";
    },
    //获取扫描箱号的barray下标
    index_barray:function(bjz_first){
    	for(var i=0;i<this.barray.length;i++){
    		if(this.barray[i]==bjz_first)return i;
    	}
    	return bjz_first;
    },
    showFirst:function(category){
        var lies=jQuery("#"+category+"Num > li");
        var bjz_first=jQuery("input[type=checkbox][@checked]").val();
        
        var cb=jQuery("#zh-from-left01>div:visible :checkbox:checked");
        //alert(cb.length+"  "+lies.length+"    "+bjz_first);
        var in_barray=this.index_barray(bjz_first);
        if(this.bjz&&bjz_first&&cb.length>0){
        	jQuery(lies[in_barray]).click();
        }else{
        	jQuery(lies[0]).click();
        }
        this.countBox();
    },
    selSty:function(event,category,j){
    	//alert(Object.toJSON(this.m_item));
    	//alert(j+"  a:"+this.scanBoxno);
    		var boxNo=0;
        boxNo=Event.element(event).innerHTML.strip();
        if(this.bjz)boxNo=this.scanBoxno;
        if(this.bjz&&j>0){
        	boxNo=j;
        	$("selBox").value=j;
        }
        this.scanBoxno=boxNo;
        this.scanCategory=category;
        //this.cloneT(category+"Table",boxNo);
        this.cloneT_two(category+"Table",boxNo);
        this.select(event,category,boxNo);
    },
    cloneT_two:function(categoryTable,index){
    	//alert(index+" :  ");
    	var itemS="";
   		var j=categoryTable.replace("Table","");
   		this.scanCategory=j;
   		this.scanBoxno=index;
      itemS+="<div class=\"zh-from-left02\" id=\""+j+"TableDiv\" style=\"overflow-y:auto;overflow-x:hidden;height:282px;\"><input type=\"hidden\"/>"+
             "<table id=\""+j+"Table_"+index+"\" width=\"99%\" style=\"table-layout:fixed;\" border=\"1\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#8db6d9\" bordercolorlight=\"#FFFFFF\" bordercolordark=\"#FFFFFF\" bgcolor=\"#8db6d9\" class=\"modify_table\">"+
             "<col width=\"40\">"+
             "<col width=\"142\">"+
             "<col width=\"142\">"+
             "<col width=\"130\">"+
             "<col width=\"130\">"+
             "<col width=\"auto\">";
      var ms=this.m_item;
    		
      var des=new Array();
      if(this.checkIsArray(this.returnData.DESTINATION)){
      	des=this.returnData.DESTINATION;	
      }else{
      	des[0]=this.returnData.DESTINATION;	
      }
      if(this.m_item&&this.m_item.length>0){
      	for(var n=0;n<ms.length;n++){
      		for(var s=0;s<this.data.length;s++){
            if(ms[n].qty_ady>0&&index==ms[n].m_box_no&&this.data[s].m_box_item.DESTINATION==ms[n].categorymark&&ms[n].m_product_alias==this.data[s].m_box_item.NO){
            	 itemS+=this.createTrBym_box_item(this.data[s].m_box_item.NAME,this.data[s].m_box_item.VALUE,this.data[s].m_box_item.VALUE1_CODE,this.data[s].m_box_item.VALUE2_CODE,this.data[s].m_box_item.NO,this.data[s].m_box_item.QTY,j,false,index,ms[n].qty_ady);
            }
          }
      	}
      }

      itemS+="</tbody></table></div>";
      jQuery("#showContent").html(itemS);
      $("selBox").value=index;
    },
    firstlayout:function(boxNo,tcode){
    	 if(this.m_item){
    		for(var m=0;m<this.m_item.length;m++){
    			if(boxNo>this.returnData.M_BOX_LOAD.BOXNO[m]&&this.m_item[m].m_product_alias==tcode){
    				return true;	
    			}
    		}	
    	}
    	
    	return false;   
    },
    select:function(event,category,boxno){
    		var lies=$(category+"Num").getElementsByTagName("li");
    		//alert(boxno+"  "+lies.length);
    		for(var i=0;i<lies.length ;i++){
            lies[i].style.backgroundColor="";
        }
        if(this.bjz&&boxno>0){
        	jQuery("#"+category+"_"+boxno+"").css("backgroundColor","#ddd");
        	$("selBox").value=boxno;
        }else{
        	$("selBox").value=Event.element(event).innerHTML.strip();
        }
        this.countBox();
    },
    countBoxOnLoad:function(ret,selCategory,selBox){
        var category=jQuery("#"+selCategory+"M").text().strip();
        var count=0;
        var categorys=new Array();
        var boxNoes=new Array();
        var qtyout=new Array();
        if(this.checkIsArray(ret.M_BOX_LOAD.categorymark)){
            categorys=ret.M_BOX_LOAD.categorymark;
            boxNoes=ret.M_BOX_LOAD.BOXNO;
            qtyout=ret.M_BOX_LOAD.QTYOUT;
        }else{
            categorys[0]=ret.M_BOX_LOAD.categorymark;
            boxNoes[0]=ret.M_BOX_LOAD.BOXNO;
            qtyout[0]=ret.M_BOX_LOAD.QTYOUT;
        }
        var len=categorys.length;
        for(var i=0;i<len;i++){
           if(categorys[i]==category&&boxNoes[i]==selBox){
               count+=parseInt(qtyout[i]);
           }
        }
        return count;
    },
    countBox:function(){
    	 var count=this.getOneBoxNum($("selBox").value.strip());
       jQuery("#currentBox").text(count);
			 jQuery($($("selCategory").value+"Table_"+$("selBox").value)).attr("total",count);       
    },
    pdtModel:function(){
        jQuery("#barcode").unbind("keydown");
        jQuery("#barcode").bind("keydown",function(event){cstable.handlerMe(event)});
        jQuery("#barcode").bind("keyup",function(e){tooltips.inputHandler(e);});
        jQuery("#barcode").bind("focus",function(e){tooltips.focusHandler(e)});
        jQuery("#forCode").bind("mousedown",function(e){tooltips.mousedownHandler()});
        jQuery("#forCode").bind("mouseup",function(e){tooltips.mouseupHandler()});
        jQuery("#barcode").bind("blur",function(e){tooltips.tipHide(e);});
        jQuery("#forCode").bind("mousemove",function(e){tooltips.setKeymode(e);});
    },
    codeModel:function(){
        jQuery("#barcode").unbind("keydown");
        jQuery("#barcode").unbind("keyup");
        jQuery("#barcode").unbind("focus");
        jQuery("#forCode").unbind("mousedown");
        jQuery("#forCode").unbind("mouseup");
        jQuery("#barcode").unbind("blur");
        jQuery("#forCode").unbind("mousemove");
        jQuery("#barcode").bind("keydown",function(event){
            var prop=window.document.getElementById("barcode").value;
            if(event.which==13){
            	if(prop.length==0&&jQuery.trim(prop).length==0)return;
                box.codeRt(event);
            }
        });
    },
    getTargetD:function(code){
        var targetD=$($("selCategory").value.strip()+code+"_"+$("selBox").value.strip());
        return targetD;
    },
    /**
     *获取播放 wav 声音的flash播放器
     */
    getPlayer:function(pid) {
					var obj = document.getElementById(pid);
					if (obj.doPlay) return obj;
					for(i=0; i<obj.childNodes.length; i++) {
								var child = obj.childNodes[i];
								if (child.tagName == "EMBED") return child;
					}
		},
		//播放
    doPlay:function(fname) {
				var player=this.getPlayer("playErrorSoundTest");
					//player.play(fname);
		},
		doStop:function() {
			var player=getPlayer("playErrorSoundTest");
			//player.doStop();
		},
		playErrorSound:function(){
			/*
			if($("sound").value&&$("sound").value.strip()!="0")
				null;*/
			//this.doPlay();
					if($("jpId")){
						jQuery("#jpId").jPlayer("stop");
            jQuery("#jpId").jPlayer("play");
            return;
        }
		},
    playScan:function(){
      /*
      if($("sound").value&&$("sound").value.strip()!="0")
        null;*/
      //this.doPlay();
          if($("jpsId")){
            jQuery("#jpsId").jPlayer("stop");
            jQuery("#jpsId").jPlayer("play");
            return;
        }
    },
    /**
    原方法有第二次不播放的问题
    playErrorSound:function(){
        if($("sound").value&&$("sound").value.strip()!="0"){
            if(!app1){
                var app1=FABridge.b_playErrorSound.root();
                app1.setStr($("sound").value.strip());
            }
            app1.getErrorSound().play();
        }
    },**/
    /**
     * edit by Robin 2010.5.10
     * 当条码扫描错误时，弹出红色界面后输入验证码（默认为0）时解除红色界面
     */    
    onCorrectError:function(){
    	var errorMeg=window.document.getElementById("errorMeg").innerHTML;
    	var eg=window.document.getElementById("pdwarn").innerHTML;
    	var code=$("barcode").value.strip().toUpperCase();
    	var targetD=this.getTargetD(code);
      if(!targetD){
          if(this.jo&&this.jo[code]){
              code=this.jo[code];
              targetD=this.getTargetD(code);
          }         
          if(this.jo2&&this.jo2[code]){
          	  code=this.jo2[code];
              targetD=this.getTargetD(code);
          }
      }
      var messa="该商品含饰品:"+this.PDTADDSDESCS[code];
      var cec=window.document.getElementById("correctErrorCode").value+"";
      cec=jQuery.trim(cec);
    	if(cec==(this.correctErrorCode+"")){
				jQuery("#alert-error").hide();
				jQuery("#correctErrorCode").val("");
			  jQuery("#barcode").val("");
        jQuery("#barcode").focus();
    	}else if(this.PDTADDSDESCS[code]&&cec==(this.correctErrorButContinueCode+"")&&errorMeg==messa){
    		jQuery("#alert-error").hide();
				jQuery("#correctErrorCode").val("");
    		this.dealWhenCodeRt(false,"pdw");
    	}else if($("skuAddRange")&&$("skuAddRange").value&&cec==(this.correctErrorButContinueCode+"")&&errorMeg!=messa&&eg!="请输入确认码(默认为0):"){
    		jQuery("#alert-error").hide();
				jQuery("#correctErrorCode").val("");
				this.sku_cloneT();
    	}else{
    		this.playErrorSound();
    	}
    },
    sku_cloneT:function(){
    	var code=$("barcode").value.strip().toUpperCase();
    	var count=this.changeString2int($("pdt_count").value);
    	if($("isRecoil").value!="normal"){
      	count=-count;
      }
    	var targetD=$($("selCategory").value.strip()+code+"_"+$("selBox").value.strip());
    	if(targetD){
        var qc=this.changeString2int(targetD.title);
      }else{
      	var qc=0;	
      }
			//alert(box.scanCategory+"   "+box.scanBoxno+"   "+code+"   "+count);
    	//alert(Object.toJSON(this.data));
    	var num=0;
    	var num1=0;
    	var itemS="";
    	itemS+="<div class=\"zh-from-left02\" id=\""+box.scanCategory+"TableDiv\" style=\"overflow-y:auto;overflow-x:hidden;height:282px;\"><input type=\"hidden\"/>"+
             "<table id=\""+box.scanCategory+"Table_"+box.scanBoxno+"\" width=\"99%\" style=\"table-layout:fixed;\" border=\"1\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#8db6d9\" bordercolorlight=\"#FFFFFF\" bordercolordark=\"#FFFFFF\" bgcolor=\"#8db6d9\" class=\"modify_table\">"+
             "<col width=\"40\">"+
             "<col width=\"142\">"+
             "<col width=\"142\">"+
             "<col width=\"130\">"+
             "<col width=\"130\">"+
             "<col width=\"auto\">";
      for(var i=0;i<this.m_item.length;i++){
      	if(this.m_item[i].m_box_no==box.scanBoxno&&this.m_item[i].m_product_alias==code){
      		if(this.m_item[i].qty_ady+count>=0)this.m_item[i].qty_ady+=count;
      		num=this.m_item[i].qty_ady;
      	}
      	if(this.m_item[i].m_product_alias==code){
      		num1+=this.m_item[i].qty_ady;
      	}
      	//alert(i+"  "+this.m_item[i].qty_ady);
      }
      
        //alert(Object.toJSON(this.m_item));
      	for(var j=0;j<this.m_item.length;j++){
      		if(box.scanBoxno==this.m_item[j].m_box_no&&this.m_item[j].m_product_alias==code){
      			//当前箱 当前扫描条码存在 
      			//alert(j+"  "+this.m_item[j].qty_ady);
      			var box_item={};
	        	box_item.m_box_no=box.scanBoxno;
	        	box_item.qty_ady=this.m_item[j].qty_ady;
	        	box_item.m_product_alias=code;
	        	box_item.categorymark=jQuery.trim(jQuery("#"+box.scanCategory+"M").text());
	        	this.ADUm_item('AU',box_item);
	        	break;
      		}else{
      			if(j==this.m_item.length-1&&count>0){
      			//扫描到最后该箱没有该条码//
      			//alert(j+"  "+count);
	      			var box_item={};
		        	box_item.m_box_no=box.scanBoxno;
		        	box_item.qty_ady=count;
		        	box_item.m_product_alias=code;
		        	box_item.categorymark=jQuery.trim(jQuery("#"+box.scanCategory+"M").text());
		        	this.ADUm_item('AU',box_item);
		        }
      		}
      	}
      	//第一条数据就超量
      	if(this.m_item.length==0){
      		var box_item={};
        	box_item.m_box_no=box.scanBoxno;
        	box_item.qty_ady=count;
        	box_item.m_product_alias=code;
        	box_item.categorymark=jQuery.trim(jQuery("#"+box.scanCategory+"M").text());
        	this.ADUm_item('AU',box_item);
        		
      	}
      	//修改添加成功后，扫描画出该箱
        //alert(Object.toJSON(this.m_item));
      	for(var j=0;j<this.m_item.length;j++){
      		for(var s=0;s<this.data.length;s++){
      			if(box.scanBoxno==this.m_item[j].m_box_no&&this.m_item[j].m_product_alias==this.data[s].m_box_item.NO){
      				 if(this.m_item[j].qty_ady>0){
	             	 itemS+=this.createSku(this.data[s].m_box_item.NAME,this.data[s].m_box_item.VALUE,this.data[s].m_box_item.VALUE1_CODE,this.data[s].m_box_item.VALUE2_CODE,this.data[s].m_box_item.NO,this.data[s].m_box_item.QTY,box.scanCategory,box.scanBoxno,this.m_item[j].qty_ady);	
	             }
      			}
      		}
      	}
      
      itemS+="</tbody></table></div>";
      jQuery("#showContent").html(itemS);
      //alert(Object.toJSON(this.m_item));
      box.barcodeItem[code]=num1+num;
      //alert("x   "+Object.toJSON(box.barcodeItem));
      jQuery("#barcode").val("");
			jQuery("#barcode").focus();
			
			this.countBox();
			var tb=this.getTotBoxNum();
			//alert(tb);
      jQuery("#totBox").text(tb);
      this.additionalQty=this.getTotAdditionalQty();
      this.updateAdditionalText();
    },
    createSku:function(styleName,styleValue,value1_code,value2_code,barcode,qty,destination,index,dQTY,f){
    	//alert(f);
    	if(!f)f=false;
    	var s=0;
    	for(var i=0;i<this.m_item.length;i++){
    		if(this.m_item[i].m_product_alias==barcode){
    			s+=this.m_item[i].qty_ady;
    		}
    	}
    	//alert("createSku:   "+dQTY+"  "+qty+"  "+s);
    	if(dQTY<=qty&&qty<s||dQTY>qty)f=true;
    	var tr="<tr height=\"29\" >"+
             "<td bgcolor=\"#8db6d9\" style=\""+(f?"background-color:yellow":"")+"\" class=\"td-bg\"><input type='checkbox'></td>"+
             "<td bgcolor=\"#8db6d9\" style=\""+(f?"background-color:yellow":"")+"\" class=\"td-bg\"><div class=\"td-font\">"+styleName+"</div></td>"+
             "<td bgcolor=\"#8db6d9\" style=\""+(f?"background-color:yellow":"")+"\" class=\"td-bg\"><div class=\"td-font\">"+styleValue+"</div></td>"+
             "<td bgcolor=\"#8db6d9\" style=\""+(f?"background-color:yellow":"")+"\" class=\"td-bg\"><div class=\"td-font\">"+value1_code+"</div></td>"+
             "<td bgcolor=\"#8db6d9\" style=\""+(f?"background-color:yellow":"")+"\" class=\"td-bg\"><div class=\"td-font\">"+value2_code+"</div></td>"+
             "<td bgcolor=\"#8db6d9\" style=\""+(f?"background-color:yellow":"")+"\" class=\"td-bg\"><div class=\"td-font\" id=\""+destination+barcode+"_"+index+"\" title=\""+qty+"\" name='scan'>"+dQTY+"</div></td></tr>";
             
      return tr;	
    },
    
    /**
     * edit by Robin 2010.5.10
     * 当条码扫描错误时，弹出红色界面
     */
    onBarCodeError:function(errorMeg,code,count){
    	jQuery("#alert-error").show();
    	jQuery("#alert-error").focus();
    	jQuery("#correctErrorCode").focus();
    	jQuery("#errorMeg").html(errorMeg);
    	var messag="该商品含饰品:"+code;
    	
    	//判断count与codeTotal之和>0
    	
    	if(errorMeg==messag){
    		jQuery("#pdwarn").html("请输入 0不扫描，1扫描");	
    	}else if($("skuAddRange")&&$("skuAddRange").value>0&&count>=0){ 
    		jQuery("#pdwarn").html("请输入确认码(返回输入0，继续输入1):");	
    	}else{    		
    		jQuery("#pdwarn").html("请输入确认码(默认为0):");		
    	}
    },
    scan_cloneT:function(code,count,categoryTable,index,al){
    	//该箱没有该条码的明细,但该明细存在data里
    	var sm_item=box.m_item;
   		var itemS="";
   		var j=categoryTable.replace("Table","");
      itemS+="<div class=\"zh-from-left02\" id=\""+j+"TableDiv\" style=\"overflow-y:auto;overflow-x:hidden;height:282px;\"><input type=\"hidden\"/>"+
             "<table id=\""+j+"Table_"+index+"\" width=\"99%\" style=\"table-layout:fixed;\" border=\"1\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#8db6d9\" bordercolorlight=\"#FFFFFF\" bordercolordark=\"#FFFFFF\" bgcolor=\"#8db6d9\" class=\"modify_table\">"+
             "<col width=\"40\">"+
             "<col width=\"142\">"+
             "<col width=\"142\">"+
             "<col width=\"130\">"+
             "<col width=\"130\">"+
             "<col width=\"auto\">";

    var samount=0;
    if(box.checkIsArray(box.returnData.data)&&box.returnData.data){
	    for(var f=0;f<box.returnData.data.length;f++){
	    		if(box.returnData.data[f].m_box_item.NO==code){
	    			samount=box.returnData.data[f].m_box_item.QTY;	
	    		}
	    }
	  }
    if(!(box.checkIsArray(box.returnData.data))&&box.returnData.data){
    	samount=box.returnData.data.m_box_item.QTY;	
    }
    	var scodeinfo={};
    	var stot=0;
  		//判断该条码总的数量是否超量
    	for(var m=0;m<sm_item.length;m++){
  			if(sm_item[m].m_product_alias==code){
    			stot+=sm_item[m].qty_ady;
    		}
	    }
    	for(var sm=0;sm<sm_item.length;sm++){
    		if(sm_item[sm].m_box_no==index&&sm_item[sm].m_product_alias==code){
    			//当前箱子有该条码明细时,判断是否超量
    			this.sover=true;
    			if(samount>=(sm_item[sm].qty_ady+count)&&samount>=(stot+count)&&sm_item[sm].qty_ady>0&&(sm_item[sm].qty_ady+count)>=0){
    				sm_item[sm].qty_ady+=count;	
    				this.sover=false;
    			}
    		}
    	}
    	if(!al&&(stot+count)<=samount||al&&stot==0&&(stot+count)<=samount){
    			//此箱没有该条码明细时，将box.returnData.data[i].m_box_item的信息输入
    			var sreturn=new Array();
    			if(box.checkIsArray(box.returnData.data)&&box.returnData.data){
	    			sreturn=box.returnData.data;
	    		}
else if(!(box.checkIsArray(box.returnData.data))&&box.returnData.data){
	    			sreturn[0]=box.returnData.data;	
	    		}
    			for(var sr=0;sr<sreturn.length;sr++){
    				if(sreturn[sr].m_box_item.NO==code){
    					//记录code的信息
    					scodeinfo.NAME=sreturn[sr].m_box_item.NAME;	
    					scodeinfo.VALUE=sreturn[sr].m_box_item.VALUE;	
    					scodeinfo.VALUE1_CODE=sreturn[sr].m_box_item.VALUE1_CODE;	
    					scodeinfo.VALUE2_CODE=sreturn[sr].m_box_item.VALUE2_CODE;	
    					scodeinfo.NO=sreturn[sr].m_box_item.NO;	
    					scodeinfo.QTY=sreturn[sr].m_box_item.QTY;
    					if(samount>=count){
    						scodeinfo.dQTY=count;
    					}else{
    						scodeinfo.dQTY=0;
    					}
	    			}
    			}
    			this.sover=false;
    			if(scodeinfo.dQTY<0)this.sover=true;
    		}else if(!al&&(stot+count)>samount){
    			this.sover=true;
    		}
    	for(var n=0;n<sm_item.length;n++){
    		for(var s=0;s<this.data.length;s++){
          if(index==sm_item[n].m_box_no&&this.data[s].m_box_item.DESTINATION==sm_item[n].categorymark&&sm_item[n].m_product_alias==this.data[s].m_box_item.NO&&sm_item[n].qty_ady>0){
          		itemS+=this.createTrBym_box_item(this.data[s].m_box_item.NAME,this.data[s].m_box_item.VALUE,this.data[s].m_box_item.VALUE1_CODE,this.data[s].m_box_item.VALUE2_CODE,this.data[s].m_box_item.NO,this.data[s].m_box_item.QTY,j,false,index,sm_item[n].qty_ady);
          }
        }
    	}
    	//alert(Object.toJSON(scodeinfo));
    	if(scodeinfo.NAME&&scodeinfo.dQTY!=0&&scodeinfo.dQTY>0){
    		itemS+=this.createTrBym_box_item(scodeinfo.NAME,scodeinfo.VALUE,scodeinfo.VALUE1_CODE,scodeinfo.VALUE2_CODE,scodeinfo.NO,scodeinfo.QTY,j,false,index,scodeinfo.dQTY);	
    	}
			/*
      if(this.skuAddRange>0){
      	for(var p=0;p<this.skuAddRange;p++){
      		itemS+=this.createTrBym_box_item("","","","","-"+p+"-",0,j,true,index);
      	}
      }
      */
      itemS+="</tbody></table></div>";
      jQuery("#showContent").html(itemS);
      $("selBox").value=index;
    },
    dealWhenCodeRt:function(needAlert,pdw){
    	var code=$("barcode").value.strip().toUpperCase();
    	if(this.barcodeCutlen>0&&code.length>this.barcodeInterceptMinLen)code=code.substr(0,code.length-this.barcodeCutlen);
    	if(!code)return;
      if($("customer")&&code.length > this.barcodeMaxLen){
      	this.playErrorSound();
				this.onBarCodeError("条码过长！");
      	return;
      }
      var targetD=this.getTargetD(code);
      if(!targetD){
      		
          if(this.jo&&this.jo[code]){
              code=this.jo[code];
              targetD=this.getTargetD(code);
          }
          if(this.jo2&&this.jo2[code]){
          	  code=this.jo2[code];
              targetD=this.getTargetD(code);
          }
      }
      var count=this.changeString2int($("pdt_count").value);
      if($("isRecoil").value!="normal"){
      	count=-count;
      }
      	
	    for(var i=0;i<this.data.length;i++){
	    	if(this.data[i].m_box_item.ADDSDESC&&jQuery.trim(this.data[i].m_box_item.ADDSDESC).length>0){
		      if(!this.PDTADDSDESCS[code]&&code==this.data[i].m_box_item.NO){
		  			this.PDTADDSDESCS[code]=this.data[i].m_box_item.ADDSDESC;
		  			break;
		  		}
	 	  	}
  		}
	  	
      //Add by gxy20110707 增加条码配饰明细判断
      if(needAlert&&!pdw){
	      if(this.PDTADDSDESCS){
		    		if(this.PDTADDSDESCS[code]&&this.PDTADDSDESCS[code]!="null"){
		    			var message="该商品含饰品:"+this.PDTADDSDESCS[code];
		    			this.onBarCodeError(message,this.PDTADDSDESCS[code]);
		    			return;
		    		}
	      }
      }
  		
      if(!targetD){
      	var rd=new Array();
      	if(box.checkIsArray(box.returnData.data)){
	      	rd=box.returnData.data;
	      }else{
	      	rd[0]=box.returnData.data
	      }
	    		for(var r=0;r<rd.length;r++){
	    			if(rd[r].m_box_item.NO==code){
	    				//该箱没有该条码的明细,但该明细存在data里
	    				this.scan_cloneT(code,count,this.scanCategory+"Table",this.scanBoxno);
	    				break;
	    			}else if(rd[r].m_box_item.NO!=code&&r==rd.length-1){
		          this.playErrorSound();
		          if(this.skuAddRange>0&&!needAlert&&!pdw||this.skuAddRange>0&&!needAlert&&pdw&&pdw=="allowout"){
		          	if(code)
		          	//当可超量时进入下面方法后调用box.scan_cloneT(code,count,this.scanCategory+"Table",this.scanBoxno,pdw);
		          	this.fillScanQtyToHtmlWhenBarcodeNotInOrder(jQuery("#"+jQuery.trim($("selCategory").value)+"M").text(),code,jQuery.trim($("selBox").value),count,true);
		          }else{
			        	 this.onBarCodeError("没有匹配的商品!");
			        }
		          return;
	    			}
	    		}	
      }else{
      		//扫描时条码在此箱
      		this.scan_cloneT(code,count,this.scanCategory+"Table",this.scanBoxno,"already");
      }
      
      var reco=this.getrecord(code);
      //var reco=this.record[this.record.length-1];
      if(reco){
          this.revertBackgroud(reco);
      }
      if(this.record.length>19){
          this.record.shift();
      }
      this.record.push(code);

      var snum=0;
      for(var g=0;g<box.m_item.length;g++){
      		if(box.m_item[g].m_product_alias==code&&box.m_item[g].m_box_no==this.scanBoxno){
      			snum=box.m_item[g].qty_ady;	
      		}
      }
      
      //alert(count+"  "+snum);
      if(this.sover){
      		this.playErrorSound();
         this.onBarCodeError("不能为负或扫描数量已大于单据数量！",code,(snum+count));	
         return;
      }
      
      if(this.aa){
          this.orderTotNum=this.getOrderTotNum(this.returnData.data);
          this.aa = false;
      }    	
     this.todoWhenScanBarcodeSucc(code,snum,count);
     this.additionalQty=this.getTotAdditionalQty();
     //alert(" 2: "+this.additionalQty);
     this.playScan();
     this.updateAdditionalText();
    },
    getrecord:function(code){
    	for(var r=0;r<box.m_item.length;r++){
    		this.record[r]=box.m_item[r].m_product_alias;
    	}	
    	for(var i=0;i<this.record.length;i++){
    		if(code==this.record[i]){
    			return code;
    		}	
    	}
    	return;
    },
    codeRt:function(event){
        if(event.which==13){
            this.dealWhenCodeRt(true);
        }
    },
    //Edit by Robin 20110520 当扫描条码成功后动作
    todoWhenScanBarcodeSucc:function(code,qty,oldqty){
		//alert(qty+"  "+oldqty);
    	if(!oldqty)oldqty=0;
    	var va=0;
    	if(qty==0&&$("isRecoil").value=="normal")qty=oldqty;
		
    	  var box_item={};
      	box_item.m_box_no=jQuery.trim($("selBox").value);
      	box_item.qty_ady=qty;
      	box_item.m_product_alias=code;
      	box_item.categorymark=jQuery.trim(jQuery("#"+jQuery.trim($("selCategory").value)+"M").text());
		this.ADUm_item('AU',box_item);
        if(this.barcodeItem[code]){
            this.barcodeItem[code]=parseInt(this.barcodeItem[code],10)+oldqty;
        }else{
        	 if(qty==oldqty){
        	 	va=oldqty;
        	 }else{
        		va=qty-oldqty; 
        	 }
          this.barcodeItem[code]=va;
        }
        this.countBox();
		var tb=this.getTotBoxNum();
        jQuery("#totBox").text(tb);
        var totB=this.changeString2int(tb);
		if(totB==box.orderTotNum){
            $($("selCategory").value+"eq").innerHTML="<img name='eq' src=\"images/inco-eq.gif\"  width=\"16\" height=\"16\"/>";
        }else{
            $($("selCategory").value+"eq").innerHTML="<img name='uneq' src=\"images/inco-uneq.gif\"  width=\"16\" height=\"16\"/>";
        }
        jQuery("#barcode").val("");
				if(jQuery("#alert-error").is(":hidden")){
       	 		jQuery("#barcode").focus();
      	}
        $("isSaved").value="unSave";
  	},
    revertBackgroud:function(code){
    		var targetD=$($("selCategory").value.strip()+code+"_"+$("selBox").value.strip());
    		var eg=window.document.getElementById("pdwarn").innerHTML;
    		var count=this.changeString2int($("pdt_count").value);
    		if($("isRecoil").value!="normal"){
	      	count=-count;
	      }
        if(targetD){
        	//获得title
	        var qtyCan=this.changeString2int(targetD.title);
	      }else{
	      	var qtyCan=0;	
	      }
        var codeTotal=parseInt(box.barcodeAmount(code),10);
        //反冲时
        if(codeTotal<0)codeTotal=0;
        //alert(" : "+qtyCan+" "+codeTotal);
        
        if(targetD){
        	if($("skuAddRange")&&$("skuAddRange").value)codeTotal+=count;
        	//alert(qtyCan+" xxx  "+codeTotal);
	        if(qtyCan>=codeTotal){
	        	var targetTr=targetD.parentNode.parentNode;
	        	if(jQuery(targetTr).attr("additional")!="true"){
	        		jQuery(targetTr).children().css("backgroundColor","#E9F1F8");
		       }
		      }else if($("skuAddRange")&&$("skuAddRange").value&&eg=="不能为负或扫描数量已大于单据数量！"){
		     		jQuery(targetD.parentNode.parentNode).children().css("backgroundColor","yellow");
	     	  }
				}
    },
    //根据条码查找所在箱号；用于装载页面时有些箱号未装载情况无法条码扫描验证
    getBarcodeItem:function(){
        var barcodes=this.returnData.M_BOX_LOAD.m_product_no;
        var qtys=this.returnData.M_BOX_LOAD.QTYOUT;
        var qtyArr=new Array();
        var barcodeArr=new Array();
        if(this.checkIsArray(barcodes)){
            barcodeArr=barcodes;
            qtyArr=qtys;
        }else{
            barcodeArr[0]=barcodes;
            qtyArr[0]=qtys;
        }
        for(var i=0;i<barcodeArr.length;i++){
            var barcode=barcodeArr[i];
            if(this.barcodeItem[barcode]){
                this.barcodeItem[barcode]=parseInt(this.barcodeItem[barcode],10)+parseInt(qtyArr[i],10);
            }else{
                this.barcodeItem[barcode]=qtyArr[i];
            }
        }
    },
    //计算一个分类标识下一个条码的合计输入数
    barcodeAmount:function(barcode){
    		//alert(Object.toJSON(this.barcodeItem));
        return this.barcodeItem[barcode]||0;
    },
    lastboxs:function(item){
    	var t_item=[];
    	if(this.checkIsArray(item)){
    		for(var i=0;i<item.length;i++){
    			for(var j=i+1;j<item.length;j++){
    				if(item[i].m_box_no===item[j].m_box_no){
    					j=++i;
    				}
    			}
    			t_item[t_item.length]=item[i].m_box_no;
    		}
    	}else{
    		t_item[0]=item.m_box_no;
    	}
    	var l_item=[];
    	for(var k=0;k<t_item.length;k++){
    		if(jQuery("#"+t_item[k]+"").is(":checked")){
    			l_item.push(t_item[k]);
    		}
    	}
    	return l_item;
    },
    //m_item 全部箱条码  t_item选中箱条码
    last_item:function(m_item,t_item){
    	var save_item=[];
    	//alert(Object.toJSON(m_item));
    	//alert(Object.toJSON(t_item));
    	for(var i=0;i<m_item.length;i++){
    		for(var j=0;j<t_item.length;j++){
    			if(m_item[i].m_box_no==t_item[j]){
    				var sigle={};
    				sigle.m_box_no=m_item[i].m_box_no;
    				sigle.qty_ady=m_item[i].qty_ady;
    				sigle.m_product_alias=m_item[i].m_product_alias;
    				sigle.categorymark=m_item[i].categorymark;
    				save_item.push(sigle);
    			}
    		}
    	}
    	//this.m_item=save_item;
    	return save_item;
    },
    toSave:function(finish){
        if(this.aa){
            this.orderTotNum=this.getOrderTotNum(this.returnData.data);
            this.aa = false;
        }
        if($("status").value.strip()=="2"){
            alert("单据已提交，不可操作！");
            return;
        }
        var evt={};
        evt.command="DBJSONXML";
        evt.callbackEvent="DO_SAVE";
        var desc=$("desc").value||"-1";
        var m_box_id=$("m_box_id").value;
        
        var b_box=this.boxType=="out"?"m_box":"m_v_box";
        if(document.getElementById("b_box")&&document.getElementById("b_box").value=="M_V_LESSBOX")b_box="m_v_lessbox";
        if(document.getElementById("b_box")&&document.getElementById("b_box").value=="M_V_INBOX")b_box="m_v_inbox";
        //alert(document.getElementById("b_box").value+"  :   "+b_box);
        var f="N";
        if(finish){
            f=finish;
            var tota=this.changeString2int($("totBox").innerHTML.strip());
            if(this.orderTotNum!=tota){
                if(!confirm("存在未完全匹配单据，结束装箱？")){
                    return;
                }
            }
        }
        
				this.clear0qtyitem(this.m_item);
				//alert("a :   "+Object.toJSON(this.m_item)); 
				//获取保存时箱号
				var t_item=this.lastboxs(this.m_item);
				//alert("c :   "+Object.toJSON(this.last_item(this.m_item,t_item))); 
				//alert(this.delbox);
				if(this.bjz){
					var bridge_item=this.last_item(this.m_item,t_item);
					var param={"m_box_id":m_box_id,"delbox":this.delbox,"m_item":bridge_item,"finish":f,"desc":desc};
        	if(t_item.length<1){
						alert("请选择并确认保存的箱有数据");
						return;
					}
        	if(!confirm("确认保存"+t_item+"号箱吗？"))return;
				}else{
        	var param={"m_box_id":m_box_id,"m_item":this.m_item,"finish":f,"desc":desc};
        }
        evt.param=Object.toJSON(param);
        //alert(evt.param);
        //evt.table=this.boxType=="out"?"m_box":"m_v_box";
        evt.table=b_box;
        evt.action="save";
        evt.permission="r";
        evt.isclob=true;
        //alert(Object.toJSON(evt));
        this._executeCommandEvent(evt);
    },
    //清理所有为qty_ady为0的item
    clear0qtyitem:function(m_item){
    	for(var i=0;i<m_item.length;i++){
    		if(m_item[i].qty_ady==0&&m_item.length>1){
    			m_item.splice(i,1);
    			i--;
    		}
    	}
    },
    loadingMessage:function(){
    	dwr.util.useLoadingMessage("数据处理中...");
    },
    _onSave:function(e){
        var data=e.getUserData();
        var ret=data.jsonResult.evalJSON();
        if(ret.data=="OK"&&!ret.check){
            alert("保存成功！");
            $("isSaved").value="save";
        }else if(ret.data=="OK"&&ret.check=="E"){
            alert("装箱成功！");
            $("isSaved").value="save";
            this.closePop();
        }
        else{
            alert("失败！");
        }
    },
    _finish:function(){

    },

    _executeCommandEvent :function (evt) {
    	  this.loadingMessage();
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
    checkIsObject:function(o){
        return (typeof(o)=="object");
    },

    checkIsArray: function(o){
        return (this.checkIsObject(o) && (o.length) &&(!this.checkIsString(o)));
    },
    checkIsString:function(o){
        return (typeof(o)=="string");
    },
    checkIsNum:function(event){
        if(window.event) var event=window.event;
        var c=parseInt(Event.element(event).value);
        if(isNaN(c)||c<0){
            alert("请输入正确有效的数字！");
            Event.element(event).value=0;
            Event.element(event).focus();
        }else{
            Event.element(event).value=c;
        }
    },
    showObject:function(url, theWidth, theHeight,option){
        if( theWidth==undefined || theWidth==null) theWidth=956;
        if( theHeight==undefined|| theHeight==null) theHeight=670;
        var options={width:theWidth,height:theHeight,title:gMessageHolder.IFRAME_TITLE, modal:true,centerMode:"xy",maxButton:true};
        if(option!=undefined)
            Object.extend(options, option);
        Alerts.popupIframe(url,options);
        Alerts.resizeIframe(options);
        Alerts.center();
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
    }
}
BOX.main=function(){
    box=new BOX();
};
jQuery(document).ready(BOX.main);

/*TOOLTIPS CLASS*/
var tooltips;
var TOOLTIPS=Class.create();
TOOLTIPS.prototype={
    initialize:function(){
        this.textboxcontent=$("barcode").value;
        this.totaldata=0;
        this.focusshow=true;
        this.mousedown=false;
        this.currentrowid=null;
        this.tipgetrun=false;
        this.keymode=false;
        this.ieclicked=false;
        this.counter=0;
    },
    bindevents:function(){
        for(var j=0;j<this.totaldata;j++){
            jQuery("#sn"+j).bind("mouseover",function(e){tooltips.setMouseOver(e)});
            jQuery("#sn"+j).bind("mouseout",function(e){tooltips.removeColors(e)});
            jQuery("#sn"+j).bind("click",function(e){tooltips.setValueOnClick(e)});
        }
        jQuery("#fc_close").bind("click",function(e){tooltips.ieclicked=true;tooltips.focusshow = false;tooltips.tipHideFocus(e);});
    },
    setCaretPosition:function(elemId, caretPos) {
        if(!window.event)return;
        var elem = document.getElementById(elemId);
        if(elem != null) {
            if(elem.createTextRange) {
                var range = elem.createTextRange();
                range.move('character', caretPos);
                range.select();
            }
            else {
                if(elem.selectionStart){
                    elem.focus();
                    elem.setSelectionRange(caretPos, caretPos);
                }
                else
                    elem.focus();
            }
        }
    },
    mouseupHandler:function(e){
        this.mousedown=false;
    },
    mousedownHandler:function(e){
        this.mousedown=true;
    },
    inputHandler:function(e){
        var evt=window.event?window.event:e;
        var key=(window.event)?evt.keyCode:evt.which;
        // $("pdt_count").value=key;
        if((key==38)||(key==40)){this.updnkeyHandler(e);return;}
        if((key==13)||(key==27)){
            // if((key==13)&&(window.event)){window.event.cancelBubble();window.event.returnValue=false;}
            this.focusshow=false;
            this.tipHide();
            return;} //for enter and esc keys hide the tips
        var textchanged=(!(this.textboxcontent==$("barcode").value));
        if(!textchanged)return;
        this.textboxcontent = $("barcode").value;
        this.tipGet();
        this.tipShow();
    },
    sleep:function(millis){
        var date = new Date();
        var curDate = null;
        do { curDate = new Date(); }
        while(curDate-date < millis);
    },

    focusHandler:function(e){
        //this.counter++;$("pdt_count").value = this.counter;   this.sleep(2000);
        if(this.focusshow){
            this.tipShow();
        }else{
            if(window.event){
                if(this.ieclicked){
                    this.ieclicked=false;
                }else{this.focusshow=true; }
            }
            if(!window.event)this.focusshow=true;
        }
        if(window.event) this.setCaretPosition("barcode",$("barcode").value.length);

    },
    tipShow:function(){
        if((jQuery("#forCode").css("display")!="none" )&&(!this.tipgetrun)){this.tipgetrun=false;return;}
        var top = jQuery("#barcode").offset().top;
        var left = jQuery("#barcode").offset().left;
        jQuery("#forCode").css("left",left)
                .css("width","auto")
                .css("top",top-jQuery("#forCode").height()-5)
                .css("height","auto")
                .css("position","absolute")
                .css("z-index",999);
        if(jQuery("#forCode").css("bottom")>jQuery("#forCode").css("height")){
            jQuery("#forCode").css("top",top+jQuery("#barcode").height() + 5);
        }
        if (this.totaldata>0){jQuery("#forCode").css("display","block");  }
        else{ jQuery("#forCode").css("display","none");}
        this.tipvisible = true;
    },
    getStyleArray:function(){
        var styles=[[],[]];
        var code=$("barcode").value;
        var reg=new RegExp(code,"i");
        var category=jQuery("#"+$("selCategory").value.strip()+"M").text();
        if(code.length>0){
            if(box.checkIsArray(box.returnData.data)){
                for(var i=0;i<box.returnData.data.length;i++){
                    if(reg.test(box.returnData.data[i].m_box_item.NAME)&&category==box.returnData.data[i].m_box_item.DESTINATION){
                        if(styles[0].indexOf(box.returnData.data[i].m_box_item.NAME)==-1){
                            styles[0].push(box.returnData.data[i].m_box_item.NAME);
                            styles[1].push(box.returnData.data[i].m_box_item.VALUE);
                        }
                    }
                }
            }else{
                if(reg.test(box.returnData.data.m_box_item.NAME)&&category==box.returnData.data.m_box_item.DESTINATION){
                    styles[0].push(box.returnData.data.m_box_item.NAME);
                    styles[1].push(box.returnData.data.m_box_item.VALUE);
                }
            }
        }
        return styles;
    },
    tipGet:function(){
        this.tipgetrun=true;
        var totaldata=0;
        var code=$("barcode").value;
        var styles=this.getStyleArray();
        var str="<table id='fc_data'>";
        if(code.length>0){
            for(var i=0; i<styles[0].length;i++){
                totaldata++;
                str+="<tr  id='sn"+(totaldata-1)+"'><td nowrap>"+styles[0][i]+"</td><td nowrap>"+styles[1][i]+"</td></tr>";
            }
        }//end of if code length
        str+="</table>";
        str+="<div align=right><a style='cursor:pointer;color:#0000ff' id='fc_close'>关闭</a></div>";
        $("forCode").innerHTML=str;
        this.totaldata=totaldata;
        this.bindevents();
        return totaldata;
    },
    setValueOnClick:function(e){
        if(window.event)this.ieclicked=true;
        var evt=window.event?window.event:e;
        var target=Event.element(evt);
        target=target.parentNode;
        if(target.tagName=='TR'){
            $("barcode").value = target.cells[0].innerHTML;
            this.textboxcontent=target.cells[0].innerHTML;
        }
        this.focusshow=false;
        this.tipHideFocus();
    },
    setMouseOver:function(e){
        if(this.keymode)return;
        var evt=e?e:Event;
        var target=evt.target?evt.target:evt.srcElement;
        target=target.parentNode;
        jQuery("#"+target.id).css("backgroundColor","#CCCCFF");
        this.currentrowid=target.id;
    },
    removeColors:function(e){
        for (var i=0;i<this.totaldata;i++){
            jQuery("#sn"+i).css("backgroundColor","#FFFFFF");
        }
        this.currentrowid=null;
    },
    tipHide:function(e){
        if(!this.mousedown){jQuery("#forCode").css("display","none");this.keymode=false;}
    },
    tipHideFocus:function(e){
        this.tipHide();
        jQuery("#barcode").focus();
    },
    setKeymode:function(e){
        if((this.currentrowid)&&(this.keymode)){
            jQuery("#"+this.currentrowid).css("backgroundColor","#FFFFFF");
        }
        this.keymode=false;
    },
    updnkeyHandler:function(e){
        var evt=window.event?window.event:e;
        var key=(window.event)?evt.keyCode:evt.which;
        if((key!=38)&&(key!=40)){return;}
        this.tipShow();
        this.keymode=true;
        var totalrows=this.totaldata;
        var targetrowno=null;
        if(this.currentrowid){
            targetrowno=parseInt(this.currentrowid.substring(2));
            targetrowno=(key==38)?(targetrowno-1):(targetrowno+1);
            if(targetrowno>(totalrows-1))targetrowno=null;
            if(targetrowno<0)targetrowno=null;
        } else{
            targetrowno=(key==38)?(targetrowno=(totalrows-1)):(targetrowno=0);
        }
        this.setValueOnKey(targetrowno);
    },
    setValueOnKey:function(targetrowno){
        this.removeColors();
        if(targetrowno!=null&&this.totaldata>0){
            $("barcode").value=$("fc_data").rows[targetrowno].cells[0].innerHTML;
            $("sn"+targetrowno).style.backgroundColor = "#CCCCFF";
            this.currentrowid="sn"+targetrowno;
        }else{
            $("barcode").value=this.textboxcontent;
            this.currentrowid=null;
        }
    }
},
        TOOLTIPS.main = function(){ tooltips=new TOOLTIPS(); tooltips.bindevents();},
        jQuery(document).ready(TOOLTIPS.main);

/*CSTABLE CLASS*/
var cstable;
var CSTABLE=Class.create();
CSTABLE.prototype={
    initialize:function(){
        this.currentstyle=null;
        this.styleDetail=[[],[],[],[]];
        this.retData=new Array();
         if(!window.document.addEventListener){
            window.document.attachEvent("onkeydown",hand11);
            function hand11()
            {
                if(window.event.keyCode==13){
                    return false;
                }
            }
        }
    },
    handlerMe:function(e){
        var event=null;
        window.event?event=window.event:event=e;
        var key=null;
        event.keyCode?key=event.keyCode:key=event.which;
        this.currentstyle=$("barcode").value;
        if(key==13){
            if(this.checkValidStyle()){
                $("barcode").blur();
                this.showMask();
                $("pop-up-title-0").innerHTML="款号:<span style='color:red;'>"+this.currentstyle+"</span>  装箱明细！";

            }
        }

    },
    //bindevents:function(){},
    checkValidStyle:function(){
        var category=jQuery("#"+$("selCategory").value.strip()+"M").text().strip();
        if(box.checkIsArray(box.returnData.data)){
            for(var i=0;i<box.returnData.data.length;i++){
                if(box.returnData.data[i].m_box_item.NAME==this.currentstyle&&box.returnData.data[i].m_box_item.DESTINATION==category)return true;
            }
        }else{
            if(box.returnData.data.m_box_item.NAME==this.currentstyle&&box.returnData.data.m_box_item.DESTINATION==category)return true;
        }
        return false;
    },
    getSingleValueArray:function(source){
        var temp=[];
        for(var i=0;i<source.length;i++){
            if(temp.indexOf(source[i])==-1)temp.push(source[i]);
        }
        return temp;
    },
    showStockTable:function(){
        jQuery("#stock_table").html("");
        this.styleDetail=[[],[],[],[]];
        var category=jQuery("#"+$("selCategory").value.strip()+"M").text().strip();
        if(box.checkIsArray(box.returnData.data)){
            var sdata=ztools.sortJSON(box.returnData.data,"m_box_item.VALUE2_CODE",2);
            for(var i=0;i<sdata.length;i++){
                if(sdata[i].m_box_item.NAME==this.currentstyle&&sdata[i].m_box_item.DESTINATION==category){
                    this.styleDetail[0].push(sdata[i].m_box_item.VALUE1_CODE);
                    this.styleDetail[1].push(sdata[i].m_box_item.VALUE2_CODE);
                    this.styleDetail[2].push(sdata[i].m_box_item.QTY);
                    this.styleDetail[3].push(sdata[i].m_box_item.NO);
                }
            }
        }
        else{
            if(box.returnData.data.m_box_item.NAME==this.currentstyle&&box.returnData.data.m_box_item.DESTINATION==category){
                this.styleDetail[0].push(box.returnData.data.m_box_item.VALUE1_CODE);
                this.styleDetail[1].push(box.returnData.data.m_box_item.VALUE2_CODE);
                this.styleDetail[2].push(box.returnData.data.m_box_item.QTY);
                this.styleDetail[3].push(box.returnData.data.m_box_item.NO);
            }
        }
        var colors=this.getSingleValueArray(this.styleDetail[0]);
        var sizes=this.getSingleValueArray(this.styleDetail[1]);
        var qtys=new Array(colors.length);
        var nums=new Array(colors.length);
        for (var j=0;j<qtys.length;j++){
            qtys[j]=new Array(sizes.length);
            nums[j]=new Array(sizes.length);
        }
        for (i=0;i<colors.length;i++){
            for(j=0;j<sizes.length;j++){
                qtys[i][j]=0;
            }
        }
        for(i=0;i<this.styleDetail[0].length;i++){
            j=colors.indexOf(this.styleDetail[0][i]);
            k=sizes.indexOf(this.styleDetail[1][i]);
            qtys[j][k]=this.styleDetail[2][i];
            nums[j][k]=this.styleDetail[3][i];
        }
        var str="<table id='modify_table_product'  sytle=\"table-layout:fixed;float:left;margin-left:5px;\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" bgcolor=\"#8db6d9\">";
        var len=sizes.length;
        for(var s=0;s<len+2;s++){
            str+="<col width=\"80\"/>";
        }
        str+="<tr><td class='hd' bgcolor=\"#FFFFFF\">色号/尺寸</td>";
        for (j=0;j<sizes.length;j++){
            str+="<td class='hd' bgcolor=\"#FFFFFF\">"+sizes[j]+"</td>";
        }
        str+="<td class='hd' bgcolor=\"#FFFFFF\">行合计</td></tr>";
        var k=0;
        for (i=0;i<colors.length;i++){
            str+="<tr><td class='hd' bgcolor=\"#FFFFFF\">"+colors[i]+"</td>";
            for(j=0;j<sizes.length;j++){
                if(qtys[i][j]){
                    k++;
                    str+="<td  class='hi' bgcolor=\"#FFFFFF\"><input id='cs"+k+"' class='inputline' type='text' value='' style='width:97%;border:0' name='"+nums[i][j]+"' title='"+qtys[i][j]+"' /></td>";
                }else
                    str+="<td style='background-color:#eeeeee' class='hi' bgcolor=\"#FFFFFF\"></td>";
            }
            str+="<td  class='hi' bgcolor=\"#FFFFFF\"></td></tr>";
        }
        str+="</table>";
        str+="<div style='display:inline-block;'></div>";
        $("stock_table").innerHTML=str;
        $("modify_table_product").width=(len+2)*80;
        if(!window.document.addEventListener){
            window.document.attachEvent("onkeydown",hand11);
            function hand11()
            {
                if(window.event.keyCode==13){
                    return false;
                }
            }
        }
        jQuery("#stock_table table input").bind("keydown",function(event){
            var code=event.which;
            if(code==13&&jQuery("#dialouge").css("display")!="none"){
                cstable.saveData();
            }
        });
        jQuery("#stock_table table input").bind("keyup",function(event){
            var e=jQuery(this)[0];
            var tab=jQuery(e).parents("table")[0];
            var p=jQuery(e).parents("tr")[0];
            var rowInput=jQuery(p).find("input");
            var inputIndex=rowInput.index(e);
            var index=jQuery(p).children().index(jQuery(e).parent()[0]);
            var indexD=tab.rows[0].cells.length-jQuery(p).children().length;
            var rowIndex=jQuery(tab.rows).index(p);
            var col=new Array();//所在input列td组
            for(var j=1;j<tab.rows.length;j++){
                var lenC0=tab.rows[0].cells.length;
                var lenCj=tab.rows[j].cells.length;
                col[j-1]=tab.rows[j].cells[index+indexD-(lenC0-lenCj)];
            }
            var colForinput=jQuery(col).find("input");
            var colIndex=colForinput.index(e);
            var code=event.which;
            if((code>=48&&code<=57)||(code>=96&&code<=105)){
                var qty=parseInt(this.title.strip());
                var rQty=box.changeString2int(this.value);
                if(rQty>qty){
                    this.value=0;
                    alert("您最多只能输入"+qty+"件！");
                    dwr.util.selectRange(this,0,100);
                }
                if(qty<0){
                    this.value=0;
                    alert("您输入的数量不能小于0！");
                    dwr.util.selectRange(this,0,100);
                }
            }else if(code==37){ //响应上下左右键事件，及表格中输入框中移动
                if(rowInput[inputIndex-1]){
                    rowInput[inputIndex-1].focus();
                }else{
                    rowInput[rowInput.length-1].focus();
                }
            }else if(code==39){
                if(rowInput[inputIndex+1]){
                    rowInput[inputIndex+1].focus();
                }else{
                    rowInput[0].focus();
                }
            }else if(code==38){
                if(colForinput[colIndex-1]){
                    colForinput[colIndex-1].focus();
                }else{
                    colForinput[colForinput.length-1].focus();
                }
            }else if(code==40){
                if(colForinput[colIndex+1]){
                    colForinput[colIndex+1].focus();
                }else{
                    colForinput[0].focus();
                }
            }
            var rowSum=0;
            rowInput.each(function(){
                rowSum+=box.changeString2int(this.value);
            });
            jQuery(p).children()[jQuery(p).children().length-1].innerHTML=rowSum;
            event.stopPropagation();
        });
        if(jQuery("#stock_table table input").length>1){
            jQuery("#stock_table table input")[1].focus();
            jQuery("#stock_table table input")[0].focus();
        }else{
            jQuery("#stock_table table input")[0].focus();
        }
    },
    showMask:function(e){
        jQuery("#alert-message").css("display","block");
        jQuery("#dialouge").css("display","block");
        this.showStockTable();
    },
    removeMask:function(e){
        jQuery("#alert-message").css("display","none");
        jQuery("#dialouge").css("display","none");
    },
    saveData:function(){
    		
        this.removeMask();
        if(box.aa){
            box.orderTotNum=box.getOrderTotNum(box.returnData.data);
            box.aa = false;
        }
        var retDataes=jQuery("table input[value!='']",$("stock_table"));
        for(var i=0;i<retDataes.length;i++){
            var cou=box.changeString2int(retDataes[i].value);
            if($("isRecoil").value!="normal")cou=-cou;
            if(cou!=0){
                this.metrixRt(retDataes[i].name, cou);
            }
        }
        var tot=box.changeString2int(jQuery("#totBox").text());
        if(tot==box.orderTotNum){
           $($("selCategory").value+"eq").innerHTML="<img name='eq' src=\"images/inco-eq.gif\"  width=\"16\" height=\"16\"/>";
        }else{
           $($("selCategory").value+"eq").innerHTML="<img name='uneq' src=\"images/inco-uneq.gif\"  width=\"16\" height=\"16\"/>";
        }
        $("isSaved").value="unSave";
        jQuery("#barcode").val("");
        //jQuery("#barcode").focus();
    },
    metrixRt:function(code,count){
        count=parseInt(count);
        var des=new Array();
	      if(box.checkIsArray(box.returnData.DESTINATION)){
	      	des=box.returnData.DESTINATION;	
	      }else{
	      	des[0]=box.returnData.DESTINATION;	
	      }
        //判断此箱有此条码的明细没？默认无
        var flag=false;
        var newn=0;
        for(var i=0;i<box.m_item.length;i++){
        	if(box.m_item[i].m_box_no==box.scanBoxno&&box.m_item[i].m_product_alias==code&&box.m_item[i].categorymark==des[box.scanCategory]&&box.m_item[i].qty_ady>0){
        		flag=true;	
        		break;
        	}
        }
        if(newn==0)newn=count;
        if(!flag){
        	box.scan_cloneT(code,count,box.scanCategory+"Table",box.scanBoxno);
        }else{
        	box.scan_cloneT(code,count,box.scanCategory+"Table",box.scanBoxno,"already");	
        }
        for(var i=0;i<box.m_item.length;i++){
        	if(box.m_item[i].m_box_no==box.scanBoxno&&box.m_item[i].m_product_alias==code&&box.m_item[i].categorymark==des[box.scanCategory]&&box.m_item[i].qty_ady>0){
        		newn=box.m_item[i].qty_ady;	
        	}
        }
        if(box.sover){
        	box.playErrorSound();
         box.onBarCodeError("不能为负或扫描数量已大于单据数量！");	
         return;
        }
        var box_item={};
	      box_item.m_box_no=box.scanBoxno;
	      box_item.qty_ady=newn;
	      box_item.m_product_alias=code;
	      box_item.categorymark=jQuery.trim(jQuery("#"+jQuery.trim($("selCategory").value)+"M").text());
	      if(newn>0){
		      box.ADUm_item('AU',box_item);
		    }else{
		    	box.ADUm_item('delete',box_item);	
		    }
        if(box.barcodeItem[code]){
            box.barcodeItem[code]=newn;
        }else{
            box.barcodeItem[code]=count;
        }
        box.countBox();
        var tb=box.getTotBoxNum();
        jQuery("#totBox").text(tb);
    }
}
CSTABLE.main = function(){ cstable=new CSTABLE();},
        jQuery(document).ready(CSTABLE.main);
