var fair=null;
var FAIR=Class.create();
FAIR.prototype={
	initialize: function() {
		this.range=24;
		this.records=0;
		this.startidx=0;
		this.data1=[];
		this.pagenum=0;
		this.data3=[];
		this.querytype="all";
		this.tag="";
		this.categoryid=""; 
		this.srinfo ="";
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
	application.addEventListener( "FAIR_LOAD_MASTER", this._onloadMasterObject, this);
	application.addEventListener( "FAIR_LOAD_ONEFAIR", this._onloadoneObject, this);
	application.addEventListener( "FAIR_LOAD_MATCH_ONEFAIR", this._onloadmatchoneObject, this);
	application.addEventListener( "FAIR_SAVEORDER", this._onfairsaveorder, this);
	application.addEventListener( "FAIR_SAVEORDER_MATCH", this._onfairsaveordermatch, this);
	application.addEventListener( "FAIR_LOAD_MYORDER", this._onfairloadmyorder, this);
	application.addEventListener( "FAIR_DELPDT", this._onfairloadmyorder, this);
  },
  loadFairObject: function(){
		var evt={};
		evt.command="DBJSONXML";
		evt.callbackEvent="FAIR_LOAD_MASTER";
		var fairid =$("fairid").value;
		if(this.srinfo==""){
		var querytype =$("querytype").value;
	  }else{
	   var querytype ="search";
	  }
		var tag =$("tag").value;
		var range =$("range").value;
		var startidx =$("startidx").value;
		var categoryid =$("categoryid").value;
		var param={"fairid":fairid,"querytype":querytype,"tag":tag,"range":range,"startidx":startidx,"categoryid":categoryid,"srinfo":this.srinfo};
		evt.param=Object.toJSON(param);
		evt.table="b_fair";
		evt.action="listpdt";
		evt.permission="r";		
		this._executeCommandEvent(evt);				
	},

	 _onloadMasterObject:function(e){
	 	var data=e.getUserData(); // data
	 	//if(data!=null){
	//	var data="{\"fairid\":3,\"startidx\":0,\"range\":24,\"records\":144,\"pagenum\":6,\"data\":[{\"pdtid\":123,\"name\":\"防风上衣\",\"tag\":\"新品促销\",\"code\":\"CN30349-23\",\"retailprice\":134.3,\"poprice\":26.5,\"ordernum\":12,\"orderamt\":142433}]}";
    	var ret=data.jsonResult.evalJSON();
   if(ret.data!="null"){
	//	var ret=data.evalJSON();
		this.startidx=ret.startidx;
		this.range=ret.range;
		this.records=ret.records;
		this.pagenum =ret.pagenum;
		var fairstr="";
		var fairid =ret.fairid;
		if($("srinfo")!=null){
		  Form.Element.focus('srinfo');
		  $("srinfo").value=this.srinfo;
	  }
		var querytype =$("querytype").value;
		var nowpage=parseInt(this.startidx)+1;
		var m=parseInt(parseInt(this.startidx)/6);
		fairstr="<div class=\"relative01\"><div id=\"pageSum\"><span>每页显示数量:</span>";
		if(this.range==12){
			fairstr+="<a title=\"每页显示数量:12\" class=\"now_page\" href=\"javascript:fair.displaypagenum(12)\" style=\"cursor:hand\">12</a><a title=\"每页显示数量:24\" href=\"javascript:fair.displaypagenum(24);\">24</a><a title=\"每页显示数量:36\" href=\"javascript:fair.displaypagenum(36);\">36</a></div>";
		}else if(this.range==24){
			fairstr+="<a title=\"每页显示数量:12\" href=\"javascript:fair.displaypagenum(12);\">12</a><a title=\"每页显示数量:24\" class=\"now_page\" href=\"javascript:fair.displaypagenum(24);\">24</a><a title=\"每页显示数量:36\" href=\"javascript:fair.displaypagenum(36);\">36</a></div>";	
		}else if(this.range==36){
			fairstr+="<a title=\"每页显示数量:12\" href=\"javascript:fair.displaypagenum(12);\">12</a><a title=\"每页显示数量:24\"  href=\"javascript:fair.displaypagenum(24);\">24</a><a title=\"每页显示数量:36\" class=\"now_page\" href=\"javascript:fair.displaypagenum(36);\">36</a></div>";	
		}
		fairstr=fairstr+"<div class=\"page_out\"><div class=\"page\" id=\"orderpage1\">";
	    if(this.startidx==0){
	        fairstr+="<a class=\"unclick noborder\">《上一页</a>";
	    }else{
	       	fairstr+="<a class=\"noborder\" href=\"javascript:fair.prepage();\">《上一页</a>";
	    }
	    for(var k=6*m+1;k<=this.pagenum&&k<=6*(m+1)+1;k++){
	       if(k==nowpage){
	     		fairstr+="<a class=\"now_page\" href=\"javascript:fair.anypage("+k+");\" >"+k+"</a>";
	      }else{	
	       fairstr+="<a  href=\"javascript:fair.anypage("+k+");\" >"+k+"</a>";
	      }
	    }
	    if(this.pagenum>6*(m+1)+1){
	       fairstr+="<span>...</span><a href=\"javascript:fair.anypage("+this.pagenum+");\" >"+this.pagenum+"</a>";
	      }
	    if(this.pagenum>parseInt(this.startidx)+1){    
	       fairstr+="<a class=\"noborder\" href=\"javascript:fair.nextpage();\">下一页》</a></div>";
	     }else{
	      fairstr+="<a class=\"unclick noborder\">下一页》</a>";
	    }
		fairstr+="</div></div>";
		fairstr+="<div class=\"clear\"></div>";
		if(this.checkIsArray(ret.data)){
		  this.data1=ret.data;
		  if(this.data1.length>0){
			var name="";
			var value="";
			for(var j=0;j<this.data1.length;j++){
			  var rank=parseInt(this.startidx)*parseInt(this.range)+j+1;
				if(this.data1[j].name!=null){
					name =this.data1[j].name ;
				}else{
					name="";
				}
				if(this.data1[j].value!=null){
					value =this.data1[j].value ;
				}else{
					value="";
				}
		       fairstr+="<div style=\"background-color: rgb(240, 240, 240);\" class=\"brand_summary\" id=\""+this.data1[j].id+"\" onmouseover=\"javascritp:document.getElementById('"+this.data1[j].id+"').style.backgroundColor='#d9c9c1'\" onmouseout=\"javascritp:document.getElementById('"+this.data1[j].id+"').style.backgroundColor='#f0f0f0'\">";
		       if(this.checkvalue(this.data1[j].tag)==""||this.data1[j].tag==""){
		        	if(querytype=="hotrank"||querytype=="coldrank"){
		        		   fairstr+="<div><div class=\"decount\"><a href=\"javascript:fair.catagrorytag('"+this.data1[j].tag+"');\">&nbsp;&nbsp;&nbsp;&nbsp;</a></div><div class=\"productrank\">"+rank+"</div></div>";
		        	}else{
		        		  fairstr+="<span class=\"decount\"><a href=\"javascript:fair.catagrorytag('"+this.data1[j].tag+"');\">&nbsp;&nbsp;&nbsp;&nbsp;</a></span>";
		        	}
		        }else{
		         	 if(querytype=="hotrank"||querytype=="coldrank"){
		        		   fairstr+="<div><div class=\"decount\"><a href=\"javascript:fair.catagrorytag('"+this.data1[j].tag+"');\">"+this.checkvalue(this.data1[j].tag)+"</a></div><div class=\"productrank\">"+rank+"</div></div>";
		        	 }else{
		        		   fairstr+="<span class=\"decount\"><a href=\"javascript:fair.catagrorytag('"+this.data1[j].tag+"');\">"+this.checkvalue(this.data1[j].tag)+"</a></span>";
		        	 }
			    }
			   fairstr+="<div class=\"pic_height\"><a target=\"_self\" href=\"/html/nds/fair/order.jsp?pdtid="+this.data1[j].id+"&fairid="+fairid+"\"><img src=\"/pdt/"+this.data1[j].id+"_1_2.jpg\" width=140px height=180px></a></div>";
			   fairstr+="<div class=\"relative\"><a  target=\"_self\" title=\""+value+"\" href=\"/html/nds/fair/order.jsp?pdtid="+this.data1[j].id+"&fairid="+fairid+"\">"+this.checkvalue(value)+"</a><br>";
			   fairstr+="<a target=\"_self\" title=\""+name+"\" href=\"/html/nds/fair/order.jsp?pdtid="+this.data1[j].id+"&fairid="+fairid+"\">["+this.checkvalue(name)+"]</a>";
         fairstr+="<span class=\"decount_price\">标准价:￥"+this.checkvalue(this.data1[j].retailprice)+"</span><br>";
          if(this.data1[j].poprice/this.data1[j].retailprice< 1){
           	 fairstr+="<div class=\"cost\">订货单价<span class=\"discount_rate\">("+Math.round(this.data1[j].poprice/this.data1[j].retailprice*1000)/100+"折):￥"+this.checkvalue(this.data1[j].poprice)+"</span><br/>";
           }else{
             fairstr+="<div class=\"cost\">订货单价:￥<span class=\"discount_rate\">"+this.checkvalue(this.data1[j].poprice)+"</span><br/>";
           }
            if(querytype=="hotrank"||querytype=="coldrank"){
               	if(this.checkvalue(this.data1[j].all_qty)==""){
		        		   fairstr+="<span>总订货数:0</span><br/><span>我的订单:"+this.checkvalue(this.data1[j].ordernum)+"</span><br/><span>订货金额:￥"+this.checkvalue(this.data1[j].orderamt)+"</span>";
		        	  }else{
		        	   	 fairstr+="<span>总订货数:"+this.checkvalue(this.data1[j].all_qty)+"</span><br/><span>我的订单:"+this.checkvalue(this.data1[j].ordernum)+"</span><br/><span>订货金额:￥"+this.checkvalue(this.data1[j].orderamt)+"</span>";
		        		}
		        	}else{
		        		 fairstr+="<span>订货数量:"+this.checkvalue(this.data1[j].ordernum)+"</span><br/><span>订货金额:￥"+this.checkvalue(this.data1[j].orderamt)+"</span>";
		        	}
              
               fairstr+="<a href=\"/html/nds/fair/order.jsp?pdtid="+this.data1[j].id+"&fairid="+fairid+"\" class=\"icon_file\" title=\"订货\">&nbsp;</a>";
               fairstr+="</div></div></div></div>";
 		  }	
		}
	 }else{
	  	var data2=ret.data;
	  	var name="";
		var value="";
		if(data2.name!=null){
		   name =data2.name;
		}else{
			name="";
		}
		if(data2.value!=null){
			value =data2.value;
		}else{
			value="";
		}
     var rank=parseInt(this.startidx)*parseInt(this.range)+1;
		fairstr+="<div style=\"background-color: rgb(240, 240, 240);\" class=\"brand_summary\" id=\""+data2.id+"\" onmouseover=\"javascritp:document.getElementById('"+data2.id+"').style.backgroundColor='#d9c9c1'\" onmouseout=\"javascritp:document.getElementById('"+data2.id+"').style.backgroundColor='#f0f0f0'\">";
     if(this.checkvalue(data2.tag)==""||data2.tag==""){
      	 if(querytype=="hotrank"||querytype=="coldrank"){
		        fairstr+="<div><div class=\"decount\"><a href=\"javascript:fair.catagrorytag('"+data2.tag+"');\">&nbsp;&nbsp;&nbsp;&nbsp;</a></div><div class=\"productrank\">"+rank+"</div></div>";
		     }else{
		        fairstr+="<span class=\"decount\"><a href=\"javascript:fair.catagrorytag('"+data2.tag+"');\">&nbsp;&nbsp;&nbsp;&nbsp;</a></span>";
		     }
		 }else{
		  	 if(querytype=="hotrank"||querytype=="coldrank"){
		        fairstr+="<div><div class=\"decount\"><a href=\"javascript:fair.catagrorytag('"+data2.tag+"');\">"+this.checkvalue(data2.tag)+"</a></div></div> class=\"productrank\">"+rank+"</div></div>";
		     }else{
		        fairstr+="<span class=\"decount\"><a href=\"javascript:fair.catagrorytag('"+data2.tag+"');\">"+this.checkvalue(data2.tag)+"</a></span>";
		     }
		 }
		fairstr+="<div class=\"pic_height\"><a target=\"_self\" href=\"/html/nds/fair/order.jsp?pdtid="+data2.id+"&fairid="+fairid+"\"><img src=\"/pdt/"+data2.id+"_1_2.jpg\"  width=140px height=180px></a></div>";
		fairstr+="<div class=\"relative\"><a  target=\"_blank\" title=\""+value+"\" href=\"/html/nds/fair/order.jsp?pdtid="+data2.id+"&fairid="+fairid+"\">"+this.checkvalue(value)+"</a><br>";
		fairstr+="<a target=\"_self\" title=\""+name+"\" href=\"/html/nds/fair/order.jsp?pdtid="+data2.id+"&fairid="+fairid+"\">["+this.checkvalue(name)+"]</a>";
        fairstr+="<span class=\"decount_price\">标准价:￥"+this.checkvalue(data2.retailprice)+"</span><br>";
        if(data2.poprice/data2.retailprice< 1){
         	fairstr+="<div class=\"cost\">订货单价<span class=\"discount_rate\">("+Math.round(data2.poprice/data2.retailprice*1000)/100+"折):￥"+this.checkvalue(data2.poprice)+"</span><br/>";
        }else{
            fairstr+="<div class=\"cost\">订货单价:￥<span class=\"discount_rate\">"+this.checkvalue(data2.poprice)+"</span><br/>";    
        }
         if(querytype=="hotrank"||querytype=="coldrank"){
          	 if(this.checkvalue(data2.all_qty)==""){
		            fairstr+="<span>总订货数:0</span><br/><span>我的订单:"+this.checkvalue(data2.ordernum)+"</span><br/><span>订货金额:￥"+this.checkvalue(data2.orderamt)+"</span>";
		         }else{
		          	fairstr+="<span>总订货数:"+this.checkvalue(data2.all_qty)+"</span><br/><span>我的订单:"+this.checkvalue(data2.ordernum)+"</span><br/><span>订货金额:￥"+this.checkvalue(data2.orderamt)+"</span>";
		          }
		     }else{
		        fairstr+="<span>订货数量:"+this.checkvalue(data2.ordernum)+"</span><br/><span>订货金额:￥"+this.checkvalue(data2.orderamt)+"</span>";
		     }
        fairstr+="<a href=\"/html/nds/fair/order.jsp?pdtid="+data2.id+"&fairid="+fairid+"\" class=\"icon_file\" title=\"订货\">&nbsp;</a>";
        fairstr+="</div></div></div></div>";
	 }
	   fairstr+="<div class=\"clear\"></div>"; 
	   fairstr+="<div class=\"page page1\" id=\"orderpage2\">";
	   if(this.startidx==0){
	     fairstr+="<a class=\"unclick noborder\">《上一页</a>";
	    }else{
	       	fairstr+="<a  class=\"noborder\" href=\"javascript:fair.prepage();\">《上一页</a>";
	    }
	    for(var k=6*m+1;k<=this.pagenum&&k<=6*(m+1)+1;k++){
	       if(k==nowpage){
	     	fairstr+="<a class=\"now_page\" href=\"javascript:fair.anypage("+k+");\" >"+k+"</a>";
	      }else{	
	       fairstr+="<a href=\"javascript:fair.anypage("+k+");\" >"+k+"</a>";
	      }
	    }
	    if(this.pagenum>6*(m+1)+1){
	       fairstr+="<span>...</span><a href=\"javascript:fair.anypage("+this.pagenum+");\" >"+this.pagenum+"</a>";
	      }
	    if(this.pagenum>parseInt(this.startidx)+1){     
	       fairstr+="<a class=\"noborder\" href=\"javascript:fair.nextpage();\">下一页》</a></div>";
	     }else{
	      fairstr+="<a class=\"unclick noborder\">下一页》</a></div>";
	    }
		 $("detail_view_inner").innerHTML=fairstr;
	   $("fairid").value=ret.fairid;
	    if(ret.totqty!=""){
	 			 $("totqty").innerHTML=ret.totqty;
	   }
	}else{
					$("detail_view_inner").innerHTML="没有商品数据信息！";
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
	  loadOneFairObject: function(pdtid){
		var evt={};
		evt.command="DBJSONXML";
		evt.callbackEvent="FAIR_LOAD_ONEFAIR";
		var fairid =$("fairid").value;
		$("pdtid").value=pdtid;
		var loadrefby=true;
		var loadcategory=true;
		var namespace ='a';
		var param={"fairid":fairid,"pdtid":pdtid,"loadrefby":loadrefby,"loadcategory":loadcategory};
		evt.param=Object.toJSON(param);
		evt.table="b_fair";
		evt.action="loadpdt";
		evt.pageurl="/html/nds/pdt/asitable.jsp?compress=f&pdtid="+pdtid+"&namespace="+namespace;
		evt.permission="r";		
		this._executeCommandEvent(evt);				
	},
	
	  loadMatchOneFairObject: function(pdtid){
		var evt={};
		evt.command="DBJSONXML";
		evt.callbackEvent="FAIR_LOAD_MATCH_ONEFAIR";
		var fairid =$("fairid").value;
		var loadrefby=false;
		var loadcategory=false;
		var namespace ='b';
		var param={"fairid":fairid,"pdtid":pdtid,"loadrefby":loadrefby,"loadcategory":loadcategory};
		evt.param=Object.toJSON(param);
		evt.table="b_fair";
		evt.action="loadpdt";
		evt.permission="r";
		evt.pageurl="/html/nds/pdt/asitable.jsp?compress=f&pdtid="+pdtid+"&namespace="+namespace;		
		this._executeCommandEvent(evt);				
	},
	
	_onloadoneObject:function(e){
		var data=e.getUserData(); 
	    var rettemp=data.jsonResult.evalJSON();
	    var page=data.pagecontent;
	    var ret=rettemp.data;
		var category = ret.category;
		var refbypdts = ret.refbypdts;
		var oderinfo =ret.oderinfo||"";
		var asi=ret.asi;
		var qty=ret.qty;
		var photo=ret.photo||"";
		jQuery("li").remove(".jcarousel-item"); 
    	jQuery("div").remove(".jcarousel-next"); 
    	jQuery("div").remove(".jcarousel-prev"); 
        this.creatlis("mycarousel",category,ret.id);
         var divstr="";
         var flag=1;
          for(var n=1;n<=photo.length;n++){	       
           if(photo[n-1]=="1"){
               if(flag==1){
            	   $("color_default").value=n;
            	     $("view_big").src="/pdt/"+ret.id+"_"+n+"_3.jpg";
            	   flag=2;
                 }
           	divstr+="<img src=\"/pdt/"+ret.id+"_"+n+"_1.jpg\" onmouseover=\"javascript:document.getElementById('view_big').src='/pdt/"+ret.id+"_"+n+"_3.jpg',document.getElementById('color_default').value="+n+"\">";
           }
        }
         $("pro_small").innerHTML=divstr; 
         $("p_name").innerHTML=this.checkvalue(ret.value)+"<span class=\"decountone ifo\">"+this.checkvalue(ret.tag)+"</span>";
         $("p_code").innerHTML =this.checkvalue(ret.name);
         $("p_price").innerHTML =this.checkvalue(ret.poprice);
          if(ret.poprice/ret.retailprice< 1){
           	 $("p_discount").innerHTML ="("+Math.round(ret.poprice/ret.retailprice*1000)/100+")折";
          } 	
         $("p_marketprice").innerHTML ="标准价:￥"+this.checkvalue(ret.retailprice)+"元";
         $("p_material").innerHTML=this.checkvalue(ret.material);
          if(oderinfo!=""&&this.checkvalue(oderinfo.amt)==""){
           	if(this.checkvalue(oderinfo.quota)==""){ 
           		$("customeinfo").innerHTML="您当前累计订货：￥0";
           	}else{
           		 $("customeinfo").innerHTML="您当前累计订货：￥0"+",距离订货指标尚有：￥"+this.checkvalue(oderinfo.quota);
           	}
           }else{
            	if(oderinfo!=""&&this.checkvalue(oderinfo.quota)==""){ 
           		  $("customeinfo").innerHTML="您当前累计订货：￥"+this.checkvalue(oderinfo.amt);
           	    }else{
           		  $("customeinfo").innerHTML="您当前累计订货：￥"+this.checkvalue(oderinfo.amt)+",距离订货指标尚有：￥"+this.checkvalue(oderinfo.quota);
           	    }
           	}	
          if(ret.desc==undefined||ret.desc==""){;
             $("desc").innerHTML="没有该商品的信息！";
          }else{
           	 $("desc").innerHTML=this.checkvalue(ret.desc);
          }
          $("p_img").innerHTML="<a target=\"_blank\" onclick=\"javascript:fair.imageopen("+ret.id+");\"><img src=\"images/zoom.gif\" alt=\"点击放大\"  width=\"31\" class=\"zoom\" style=\"cursor: pointer;\" border=\"0\"></a>";
         this.creatlis("mycarouse2",refbypdts,ret.id);
         $("detail_view_match").style.display="none"; 
         $("p_matrix").innerHTML=page;
          if(oderinfo!=""&&this.checkvalue(oderinfo.totqty)!=""){
         $("totqty").innerHTML=oderinfo!=""?oderinfo.totqty:"";
          }
         $("cnt").innerHTML =oderinfo!=""?this.checkvalue(oderinfo.ordernum):"";
          if(oderinfo!=""&&this.checkvalue(oderinfo.ordernum)!=""){
             $("totamt").innerHTML=Math.round(parseInt(oderinfo.ordernum)*parseFloat(ret.poprice)*100)/100;
         }else{
          	$("totamt").innerHTML=0;
         }
      if(this.checkIsArray(asi)){
            for(var n=0;n<asi.length;n++){
             	$("a"+asi[n]).value=qty[n];
            }
        }else if(asi!=undefined){
         	$("a"+asi).value=qty;
        }
       if(oderinfo!=""&&this.checkvalue(oderinfo.qty)!=""){
          	$("totamt").value=parseInt($("p_price").value)*this.checkvalue(oderinfo.qty);
        }
	},
	
	imageopen:function(id){
		var imageindex =$("color_default").value;
		window.open('/html/nds/fair/image.jsp?pdtid='+id+'&imageindex='+imageindex ,'_blank','height=400,width=350,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	},
	
	imageopen_match:function(id){
		var imageindex =$("color_default_match").value;
		window.open('/html/nds/fair/image.jsp?pdtid='+id+'&imageindex='+imageindex ,'_blank','height=400,width=350,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	},
	
	
	_onloadmatchoneObject:function(e){
		 var data=e.getUserData(); 
	   var rettemp=data.jsonResult.evalJSON();
	   var page=data.pagecontent;
	   var ret=rettemp.data;
	   var asi=ret.asi;
		 var qty=ret.qty;
		 var oderinfo =ret.oderinfo||"";
		 var photo=ret.photo||"";
     var divstr="";
     var flag=1;
        for(var n=1;n<=photo.length;n++){
           	if(photo[n-1]=="1"){
           		if(flag==1){
            	   $("color_default_match").value=n;
            	    $("view_big_match").src="/pdt/"+ret.id+"_"+n+"_3.jpg";
            	   flag=2;
                 }
           	divstr+="<img src=\"/pdt/"+ret.id+"_"+n+"_1.jpg\" onmouseover=\"javascript:document.getElementById('view_big_match').src='/pdt/"+ret.id+"_"+n+"_3.jpg',document.getElementById('color_default_match').value="+n+"\">";
          }	
        }
         $("pro_small_match").innerHTML=divstr; 
         $("p_name_match").innerHTML=this.checkvalue(ret.value)+"<span class=\"decountone ifo\">"+this.checkvalue(ret.tag)+"</span>";
         $("p_code_match").innerHTML =this.checkvalue(ret.name);
         $("p_price_match").innerHTML =this.checkvalue(ret.poprice);
         if(ret.poprice/ret.retailprice< 1){
           	 $("p_discount_match").innerHTML ="("+Math.round(ret.poprice/ret.retailprice*1000)/100+")折";
          } 
         $("p_marketprice_match").innerHTML ="标准价:￥"+this.checkvalue(ret.retailprice)+"元";
         $("p_material_match").innerHTML=this.checkvalue(ret.material);
          if(ret.desc==undefined||ret.desc==""){;
             $("desc_match").innerHTML="没有该匹配商品的信息！";
          }else{
           	 $("desc_match").innerHTML=this.checkvalue(ret.desc);
          }
            $("p_img_match").innerHTML="<a target=\"_blank\" onclick=\"javascript:fair.imageopen_match("+ret.id+");\"><img src=\"images/zoom.gif\" alt=\"点击放大\"  width=\"31\" class=\"zoom\" style=\"cursor: pointer;\" border=\"0\"></a>";
         $("detail_view_match").style.display="block"; 
         $("p_matrix_match").innerHTML=page;
          if(oderinfo!=""&&this.checkvalue(oderinfo.totqty)!=""){
            $("totqty").innerHTML=oderinfo.totqty;
          }
          if(oderinfo!=""&&this.checkvalue(oderinfo.ordernum)!=""){
               $("cnt_match").innerHTML =this.checkvalue(oderinfo.ordernum);
           }else{
            	$("cnt_match").innerHTML =0;
            }
             if(oderinfo!=""&&this.checkvalue(oderinfo.ordernum)!=""){
             $("totamt_match").innerHTML=Math.round(parseInt(oderinfo.ordernum)*parseFloat(ret.poprice)*100)/100;
            }else{
             	$("totamt_match").innerHTML=0;
            }
         $("match_id").value=ret.id;
         if(this.checkIsArray(asi)){
            for(var n=0;n<asi.length;n++){
             	$("b"+asi[n]).value=qty[n];
            }
         }else if(asi!=undefined){
         	$("b"+asi).value=qty;
         }
         if(oderinfo!=""&&this.checkvalue(oderinfo.qty)!=""){
          	$("totamt_match").value=parseInt($("p_price_match").value)*this.checkvalue(oderinfo.qty);
        }
	},

	creatlis:function(carouse,category,pdtid){
    	if(this.checkIsArray(category)){
		  for(var i=0;i<category.length;i++){
			 li1 =document.createElement("li");
			 linkurl=document.createElement("a");
			linkurl.href="javascript:fair.loadOneFairObject("+category[i]+");";
			if(carouse=="mycarousel"){
		//	linkurl.setAttribute("onclick","fair.loadOneFairObject("+category[i]+");");
		    linkurl.href="javascript:fair.loadOneFairObject("+category[i]+");";
		    }else{
		   //  linkurl.setAttribute("onclick","fair.loadMatchOneFairObject("+category[i]+");");
		     linkurl.href="javascript:fair.loadMatchOneFairObject("+category[i]+");";
		    }
			var img=document.createElement("img");
			img.src="/pdt/"+category[i]+"_1_2.jpg";
			if(category[i]==pdtid){ 
				img.className="prodImg focus_item";
			}else{
				img.className="prodImg";
			}
			linkurl.appendChild(img);
			li1.appendChild(linkurl);
			$(carouse).appendChild(li1);	
		}
	 }else if(category!=undefined){
	  	  
	  	    
	  		var li1 =document.createElement("li");
			var linkurl=document.createElement("a");
			if(carouse=="mycarousel"){
			//  linkurl.setAttribute("onclick","fair.loadOneFairObject("+category+");");
			  linkurl.href="javascript:fair.loadOneFairObject("+category+");";
		    }else{
		      //linkurl.setAttribute("onclick","fair.loadMatchOneFairObject("+category+");");
		      linkurl.href="javascript:fair.loadMatchOneFairObject("+category+");";
		    }
			var img=document.createElement("img");
			img.src="/pdt/"+category+"_1_2.jpg";
			linkurl.appendChild(img);
			li1.appendChild(linkurl);
			$(carouse).appendChild(li1);
	}  
	if(carouse=="mycarousel"){
	  	jQuery("#mycarousel").ready(function(){jQuery("#mycarousel").jcarousel();});
	}else if(category!=undefined){
		jQuery("#mycarouse2").ready(function(){jQuery("#mycarouse2").jcarousel();});
	}
   },
	
	saveorder: function(){
		var evt={};
		var asi=[];
   	    var qty=[];
   	    var i=0;
		var fairid =$("fairid").value;
		var pdtid =$("pdtid").value;
		evt.command="DBJSONXML";
		evt.callbackEvent="FAIR_SAVEORDER";
   	    var asiinfo=$("p_matrix").getElementsBySelector('[class="inputline"]');
   	    var r=/^[0-9]*[1-9][0-9]*$/;
        for(var n=0;n<asiinfo.length;n++){
      	 if(asiinfo[n].value!=""&asiinfo[n].value!=0){
      	  	if(isNaN(asiinfo[n].value)){
      	  		alert("输的数额有不是数字！");
      	  		return;
      	  	}else if(asiinfo[n].value<0){
      	  		alert("输的数额有负数！");
      	  		return;      	  		
      	  	}else if(!r.test(asiinfo[n].value)){
      	  		alert("输的数额不能为小数！");
      	  		return; 
      	  	}
      	   qty[i]=asiinfo[n].value;
      	   asi[i]=asiinfo[n].name;
      	    i=i+1;
          } 
        }
		var param={"fairid":fairid,"pdtid":pdtid,"qty":qty,"asi":asi};
		evt.param=Object.toJSON(param);
		evt.table="b_fair";
		evt.action="saveorder";
		evt.permission="r";		
		this._executeCommandEvent(evt);	
	},
	saveorder_match:function(){
		var evt={};
		var asi=[];
   	    var qty=[];
   	    var i=0;
		evt.command="DBJSONXML";
		var fairid =$("fairid").value;
		var pdtid =$("match_id").value;
		evt.callbackEvent="FAIR_SAVEORDER_MATCH";	
        var asiinfo=$("p_matrix_match").getElementsBySelector('[class="inputline"]');
         var r=/^[0-9]*[1-9][0-9]*$/;
        for(var n=0;n<asiinfo.length;n++){
      	 if(asiinfo[n].value!=""&asiinfo[n].value!=0){
			if(isNaN(asiinfo[n].value)){
      	  		alert("输的数额有不是数字！");
      	  		return;
      	  	}else if(asiinfo[n].value<0){
      	  		alert("输的数额有负数！");
      	  		return;      	  		
      	  	}else if(!r.test(asiinfo[n].value)){
      	  		alert("输的数额不能为小数！");
      	  		return; 
      	  	}
      	   qty[i]=asiinfo[n].value;
      	   asi[i]=asiinfo[n].name;
      	    i=i+1;
          }
        }
		var param={"fairid":fairid,"pdtid":pdtid,"qty":qty,"asi":asi};
		evt.param=Object.toJSON(param);
		evt.table="b_fair";
		evt.action="saveorder";
		evt.permission="r";		
		this._executeCommandEvent(evt);	
	},
		
	_getInputs:function(form){
	    form = $(form);
	    var inputs = $A(form.getElementsByTagName('input'));
	    return inputs.map(Element.extend);
	},
	
	_onfairsaveorder :function(e){
		var data=e.getUserData(); 
	    var rettemp=data.jsonResult.evalJSON();
	    var ret=rettemp.data;
	    var oderinfo =ret.oderinfo||"";
	       if(this.checkvalue(oderinfo.amt)==""){
           	if(oderinfo!=""&&this.checkvalue(oderinfo.quota)==""){ 
           		$("customeinfo").innerHTML="您当前累计订货：￥0";
           	}else{
           		 $("customeinfo").innerHTML="您当前累计订货：￥0"+",距离订货指标尚有：￥"+this.checkvalue(oderinfo.quota);
           	}
           }else{
            	if(oderinfo!=""&&this.checkvalue(oderinfo.quota)==""){ 
           		  $("customeinfo").innerHTML="您当前累计订货：￥"+this.checkvalue(oderinfo.amt);
           	    }else{
           		  $("customeinfo").innerHTML="您当前累计订货：￥"+this.checkvalue(oderinfo.amt)+",距离订货指标尚有：￥"+this.checkvalue(oderinfo.quota);
           	    }
           	}
	    $("cnt").innerHTML =oderinfo!=""?this.checkvalue(oderinfo.qty):"";
		if(oderinfo!=""&&this.checkvalue(oderinfo.totqty)!=""){
			$("totqty").innerHTML=oderinfo.totqty;
		}
        if(oderinfo!=""&&this.checkvalue(oderinfo.qty)!=""){
        	$("totamt").innerHTML=Math.round(parseInt(oderinfo.qty)*parseFloat(ret.poprice)*100)/100;
		}else{
			$("totamt").innerHTML=0;
		}
	},
	
	_onfairsaveordermatch:function(e){
		var data=e.getUserData(); 
	    var rettemp=data.jsonResult.evalJSON();
	    var ret=rettemp.data;
	    var oderinfo =ret.oderinfo||"";
	       if(oderinfo!=""&&this.checkvalue(oderinfo.amt)==""){
           	if(this.checkvalue(oderinfo.quota)==""){ 
           		$("customeinfo").innerHTML="您当前累计订货：￥0";
           	}else{
           		 $("customeinfo").innerHTML="您当前累计订货：￥0"+",距离订货指标尚有：￥"+this.checkvalue(oderinfo.quota);
           	}
           }else{
            	if(oderinfo!=""&&this.checkvalue(oderinfo.quota)==""){ 
           		  $("customeinfo").innerHTML="您当前累计订货：￥"+this.checkvalue(oderinfo.amt);
           	    }else{
           		  $("customeinfo").innerHTML="您当前累计订货：￥"+this.checkvalue(oderinfo.amt)+",距离订货指标尚有：￥"+this.checkvalue(oderinfo.quota);
           	    }
           	}
	   	$("cnt_match").innerHTML =oderinfo!=""?this.checkvalue(oderinfo.qty):"";
	    if(oderinfo!=""&&this.checkvalue(oderinfo.totqty)!=""){
         $("totqty").innerHTML=oderinfo.totqty;
          }
		if(oderinfo!=""&&this.checkvalue(oderinfo.qty)!=""){
        	$("totamt_match").innerHTML=Math.round(parseInt(oderinfo.qty)*parseFloat(ret.poprice)*100)/100;
		}else{
			$("totamt_match").innerHTML=0;
		}
	},
	
	myorder:function(){
		var evt={};
		evt.command="DBJSONXML";
		evt.callbackEvent="FAIR_LOAD_MYORDER";
		var fairid =$("fairid").value;
		var startidx =$("startidx").value;
		var range =$("range").value;
		var param={"fairid":fairid,"startidx":startidx,"range":range,"querytype":"my"};
		evt.param=Object.toJSON(param);
		evt.table="b_fair";
		evt.action="listpdt";
		evt.permission="r";		
		this._executeCommandEvent(evt);
	},

	_onfairloadmyorder:function(e){
	    var data=e.getUserData(); 
	    var ret=data.jsonResult.evalJSON();
	    if(ret.data!="null"){
	    this.startidx=ret.startidx;
		this.range=ret.range;
		this.records=ret.records;
		this.pagenum =ret.pagenum;
		var fairstr="";
		var fairid =ret.fairid;
		var nowpage=parseInt(this.startidx)+1;
		var m=parseInt(parseInt(this.startidx)/6);
		$("totamt").innerHTML="支付金额:"+ret.totamt+"元";
		$("totqty").innerHTML =ret.totqty;
	    if(this.startidx==0){
	     fairstr+="<a class=\"unclick noborder\">《上一页</a>";
	    }else{
	       	fairstr+="<a  class=\"noborder\" href=\"javascript:fair.prepageorder();\">《上一页</a>";
	    }
	    for(var k=6*m+1;k<=this.pagenum&&k<=6*(m+1)+1;k++){
	       if(k==nowpage){
	     	fairstr+="<a class=\"now_page\" href=\"javascript:fair.anypageorder("+k+");\" >"+k+"</a>";
	      }else{	
	       fairstr+="<a href=\"javascript:fair.anypageorder("+k+");\" >"+k+"</a>";
	      }
	    }
	    if(this.pagenum>6*(m+1)+1){
	       fairstr+="<span>...</span><a href=\"javascript:fair.anypageorder("+this.pagenum+");\" >"+this.pagenum+"</a>";
	      }
	    if(this.pagenum>parseInt(this.startidx)+1){     
	       fairstr+="<a class=\"noborder\" href=\"javascript:fair.nextpageorder();\">下一页》</a>";
	     }else{
	      fairstr+="<a class=\"unclick noborder\">下一页》</a>";
	    }
	    $("pagechoosetop").innerHTML=fairstr;
	    $("pagechoosebottom").innerHTML=fairstr;
	     fairstr ="";
	     if(this.checkIsArray(ret.data)){
		  this.data3=ret.data;
		  if(this.data3.length>0){
			var name="";
			var value="";
			for(var j=0;j<this.data3.length;j++){
				
				if(this.data3[j].name!=null){
					name =this.data3[j].name ;
				}else{
					name="";
				}
				if(this.data3[j].value!=null){
					value =this.data3[j].value ;
				}else{
					value="";
				}
		       fairstr+="<div style=\"background-color: rgb(240,240,240);\" class=\"brand_summaryx\" id=\""+this.data3[j].id+"\" onmouseover=\"javascritp:document.getElementById('"+this.data3[j].id+"').style.backgroundColor='#d9c9c1'\" onmouseout=\"javascritp:document.getElementById('"+this.data3[j].id+"').style.backgroundColor='#f0f0f0'\">";
		       if(this.checkvalue(this.data3[j].tag)==""||this.data3[j].tag==""){
		         fairstr+="<span class=\"decountone\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>";
		        }else{
			     fairstr+="<span class=\"decountone\">"+this.checkvalue(this.data3[j].tag)+"</span>";
			   }
			   fairstr+="<div class=\"pic_height\"><a target=\"_self\" href=\"/html/nds/fair/order.jsp?pdtid="+this.data3[j].id+"&fairid="+fairid+"\"><img src=\"/pdt/"+this.data3[j].id+"_1_2.jpg\" width=\"140px\" height=\"180px\"></a></div>";
			   fairstr+="<div class=\"relative01\">"+this.checkvalue(value)+"<br>";
			   fairstr+="["+this.checkvalue(name)+"]<br>";
               fairstr+="<span class=\"decount_price\">标准价:￥"+this.checkvalue(this.data3[j].retailprice)+"</span><br>";
               if(this.data3[j].poprice/this.data3[j].retailprice< 1){
                	 fairstr+="<div class=\"cost\">订货单价<span class=\"discount_rate\">("+Math.round(this.data3[j].poprice/this.data3[j].retailprice*1000)/100+"折):￥"+this.checkvalue(this.data3[j].poprice)+"</span><br/></span><span>订货数量:"+this.checkvalue(this.data3[j].ordernum)+"</span><br/><span>订货金额:￥"+this.checkvalue(this.data3[j].orderamt)+"</span></div></div>";
                }else{
                 	fairstr+="<div class=\"cost\">订货单价:￥<span class=\"discount_rate\">"+this.checkvalue(this.data3[j].poprice)+"</span><br/></span><span>订货数量:"+this.checkvalue(this.data3[j].ordernum)+"</span><br/><span>订货金额:￥"+this.checkvalue(this.data3[j].orderamt)+"</span></div></div>";
                 
                }
                fairstr+="<div class=\"icon_revised_delete\"><div class=\"icon_revised\"><a target=\"_self\" href=\"/html/nds/fair/order.jsp?pdtid="+this.data3[j].id+"&fairid="+fairid+"\"><img src=\"/html/nds/fair/images/icon_revised.gif\" width=\"31\" height=\"16\"/></a></div><div class=\"icon__delete\"><a target=\"_self\" href=\"javascript:fair.delpdt("+fairid+","+this.data3[j].id+")\"><img src=\"/html/nds/fair/images/icon_delete.gif\" width=\"31\" height=\"16\" /></a></div></div>";        
                fairstr+="</div>";
             
 			}	
		}
	 }else{
	  	var data2=ret.data;
	  	var name="";
		var value="";
		if(data2.name!=null){
		   name =data2.name;
		}else{
			name="";
		}
		if(data2.value!=null){
			value =data2.value;
		}else{
			value="";
		}
		fairstr+="<div style=\"background-color: rgb(240, 240, 240);\" class=\"brand_summaryx\" id=\""+data2.id+"\" onmouseover=\"javascritp:document.getElementById('"+data2.id+"').style.backgroundColor='#d9c9c1'\" onmouseout=\"javascritp:document.getElementById('"+data2.id+"').style.backgroundColor='#f0f0f0'\">";
	    if(this.checkvalue(data2.tag)==""||data2.tag==""){
		    fairstr+="<span class=\"decountone\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>";
		}else{
		    fairstr+="<span class=\"decountone\">"+this.checkvalue(data2.tag)+"</span>";
	    }
		fairstr+="<div class=\"pic_height\"><a target=\"_self\" href=\"/html/nds/fair/order.jsp?pdtid="+data2.id+"&fairid="+fairid+"\"><img src=\"/pdt/"+data2.id+"_1_2.jpg\" width=\"140px\" height=\"180px\"></a></div>";
		fairstr+="<div class=\"relative01\">"+this.checkvalue(value)+"<br>";
		fairstr+="["+this.checkvalue(name)+"]<br>";
        fairstr+="<span class=\"decount_price\">标准价:￥"+this.checkvalue(data2.retailprice)+"</span><br>";
        if(data2.poprice/data2.retailprice< 1){
         	 fairstr+="<div class=\"cost\">订货单价<span class=\"discount_rate\">("+Math.round(data2.poprice/data2.retailprice*1000)/100+"折):￥"+this.checkvalue(data2.poprice)+"</span><br/></span><span>订货数量:"+this.checkvalue(data2.ordernum)+"</span><br/><span>订货金额:￥"+this.checkvalue(data2.orderamt)+"</span></div></div>";
        }else{
             fairstr+="<div class=\"cost\">订货单价:￥<span class=\"discount_rate\">"+this.checkvalue(data2.poprice)+"</span><br/></span><span>订货数量:"+this.checkvalue(data2.ordernum)+"</span><br/><span>订货金额:￥"+this.checkvalue(data2.orderamt)+"</span></div></div>";             
        }
          fairstr+="<div class=\"icon_revised_delete\"><div class=\"icon_revised\"><a target=\"self\" href=\"/html/nds/fair/order.jsp?pdtid="+data2.id+"&fairid="+fairid+"\"><img src=\"/html/nds/fair/images/icon_revised.gif\" width=\"31\" height=\"16\"/></a></div><div class=\"icon__delete\"><a target=\"_self\" href=\"javascript:fair.delpdt("+fairid+","+data2.id+")\"><img src=\"/html/nds/fair/images/icon_delete.gif\" width=\"31\" height=\"16\" /></a></div></div>";        
         fairstr+="</div>";
	 }
	 	$("myorder").innerHTML=fairstr;
	}else{
		$("myorder").innerHTML="";
	}
   },
     
      delpdt:function(fairid,pdtid){
       	if(confirm("您确认删除该订单吗")){
	       	var evt={};
			evt.command="DBJSONXML";
			evt.callbackEvent="FAIR_DELPDT";				 
	    	var startidx =$("startidx").value;
			var range =$("range").value;
			var param={"fairid":fairid,"startidx":startidx,"range":range,"querytype":"delmy","pdtid":pdtid};
			evt.param=Object.toJSON(param);
			evt.table="b_fair";
			evt.action="listpdt";
			evt.permission="r";
			this._executeCommandEvent(evt);	
		}	
    },
    
   searchproduct:function(srinfo){
		var evt={};
		evt.command="DBJSONXML";
		evt.callbackEvent="FAIR_LOAD_MASTER";
		var fairid =$("fairid").value;
		var querytype =$("querytype").value;
		var tag =$("tag").value;
		var range =$("range").value;
		var startidx =$("startidx").value;
		var categoryid =$("categoryid").value;
		this.srinfo=srinfo;
		var param={"fairid":fairid,"querytype":"search","tag":tag,"range":range,"startidx":startidx,"categoryid":categoryid,"srinfo":this.srinfo};
		evt.param=Object.toJSON(param);
		evt.table="b_fair";
		evt.action="listpdt";
		evt.permission="r";		
		this._executeCommandEvent(evt);				
  },
        
     	onMatrixKey: function(event, nextInputId){
		if(event.keyCode==13){
			if(event.ctrlKey||event.altKey || event.shiftKey){
				gc.saveItemDetail();
				return true;
			}else{
				var ne=$(nextInputId);
				if(ne!=null) {
					ne.focus();
					dwr.util.selectRange(ne, 0, this.MAX_INPUT_LENGTH);
				}
				return false;
			}
		}
		return true;		
	},
 	/*
	    显示最新商品
	*/
	fasionproduct:function(){
    $("hotproduct").className="current";
		//$("querytype").value="hot";
		$("querytype").value="hotrank";
		$("startidx").value=0;
		$("range").value="24"; 
    $("allproduct").className="";
    $("leastproduct").className="";
     this.srinfo ="";
		this.loadFairObject();
	},
	
	fasionproduct_rank:function(){
    $("allproduct").className="current";
		$("querytype").value="hotrank";
		$("startidx").value=0;
		$("range").value="24"; 
    $("hotproduct").className="";
    $("leastproduct").className="";
    this.srinfo ="";
		this.loadFairObject();
	},
	/*
	    显示所有商品
	*/
	allproduct:function(){
		$("allproduct").className="current";
		$("querytype").value="all";
		$("startidx").value=0;
		$("range").value="24"; 
		$("hotproduct").className="";
    $("leastproduct").className="";
    this.srinfo ="";
		this.loadFairObject();
	},
	/*
	显示最少订货
	*/
	leastproduct:function(){
		$("leastproduct").className="current";
	 // $("querytype").value="cold";
	   $("querytype").value="coldrank";
		$("startidx").value=0;
		$("range").value="24";
		$("hotproduct").className="";
    $("allproduct").className="";
    this.srinfo ="";
		this.loadFairObject(); 	
	},
	
	leastproduct_rank:function(){
		$("allproduct").className="current";
	  $("querytype").value="coldrank";
		$("startidx").value=0;
		$("range").value="24";
		$("hotproduct").className="";
    $("leastproduct").className="";
    this.srinfo ="";
		this.loadFairObject(); 	
	},
	
	checkvalue:function(value){
		if(value==undefined){
			return "";
		}else{
			return value;
		}
	},
	
	/*
	    显示上一页商品
	*/
	prepage:function(){
      $("startidx").value =$("startidx").value-1;
	     this.loadFairObject();
	},
	prepageorder:function(){
      $("startidx").value =$("startidx").value-1;
	     this.myorder();
	},
	anypageorder:function(pageindex){
		$("startidx").value =pageindex-1;
		 this.myorder();
	},
	 nextpageorder:function(){
	   $("startidx").value =parseInt($("startidx").value)+1; 
	   this.myorder();
	},	
	/*
	    显示下一页商品
	*/
    nextpage:function(){
	   $("startidx").value =parseInt($("startidx").value)+1; 
	   this.loadFairObject();
	},
	/*
	    显示任何一页商品
	*/
	anypage:function(pageindex){
		$("startidx").value =pageindex-1;
		 this.loadFairObject();
	},	
	
	/*
	显示当前页面显示多少个商品
	*/
	displaypagenum:function(pagenum){
		$("startidx").value=0;
		$("range").value=pagenum; 
		 this.loadFairObject();
	},
	/*
	    显示上一页订单
	*/
	premyorder:function(){
	   $("startidx").value =$("startidx").value-1;
	     this.myorder();
	},
	/*
	    显示下一页订单
	*/
    nextmyorder:function(){
	 $("startidx").value =parseInt($("startidx").value)+1; 
	   this.myorder();
	},
	/*
	    显示任何一页订单
	*/
	anymyorder:function(pageindex){
		$("startidx").value =pageindex-1;
		 this.myorder();
	},	
	
	/*
	显示当前页面显示多少个订单
	*/
	displaymyorder:function(pagenum){
    	$("startidx").value=0;
		$("range").value=pagenum; 
		if(pagenum==12){
			$("per_"+pagenum).className="now_page";
			$("per_24").className="";
			$("per_36").className="";
		}else if(pagenum==24){
			$("per_"+pagenum).className="now_page";
			$("per_12").className="";
		    $("per_36").className="";
		}else if(pagenum==36) { 
			$("per_"+pagenum).className="now_page";
			$("per_12").className="";
		    $("per_24").className="";	
	    }
		 this.myorder();
	},
	/*
	按分类选择显示商品
	*/
	productcategory:function(categoryid){
		 this.srinfo ="";
		$("querytype").value="category";
		$("categoryid").value=categoryid;
		$("startidx").value=0;
		document.getElementById("range").value="24"; 
		 this.loadFairObject();
	},
	/*
	按商品类型选择显示商品
	*/
	 catagrorytag:function(ptdtag){
	  this.srinfo ="";
		$("querytype").value="tag";
		$("tag").value=ptdtag;
		$("startidx").value=0;
		$("range").value="24";
		 this.loadFairObject();
	},
	
 checkIsObject:function(o) {
  return (typeof(o)=="object");
 },
 
  checkIsArray: function(o) {
  return (this.checkIsObject(o) && (o.length) &&(!this.checkIsString(o)));
 },
	produceimg:function(){
				
 },
 search_index:function(){
		 	 fair.searchproduct(document.getElementById("srinfo").value);
	},
  search_order:function(){
		var fairid=$("fairid").value;
     	window.location="/html/nds/fair/index.jsp?fairid="+fairid+"&srinfo="+document.getElementById("srinfox").value;
	},
 onReturn_index:function(event){
     if (!event) event = window.event;
     if (event && event.keyCode && event.keyCode == 13) fair.search_index();
 },
   	
 onReturn_order:function(event){
     if (!event) event = window.event;
     if (event && event.keyCode && event.keyCode == 13){
     	var fairid=$("fairid").value;
     	window.location="/html/nds/fair/index.jsp?fairid="+fairid+"&srinfo="+document.getElementById("srinfox").value;
    }
 },
 
  checkIsString:function (o) {
  return (typeof(o)=="string");
}
};
FAIR.main = function () {
	fair=new FAIR();
};

/**
* Init
*/
jQuery(document).ready(FAIR.main);
