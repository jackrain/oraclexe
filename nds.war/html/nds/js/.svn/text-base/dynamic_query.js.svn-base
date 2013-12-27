var dcq;
var DynamicQuery = Class.create();
DynamicQuery.prototype = {
	initialize: function() {
		this.isIE=navigator.userAgent.indexOf("MSIE")!=-1&&!window.opera;
		this.isGecko=(navigator.userAgent.indexOf("Gecko")>-1)&&(navigator.userAgent.indexOf("KHTML")==-1);
		this.E=false;
		this.mouseOnSug=false;
		this.K=false;
		this.c=-1;
		this.SD={};
		this.timer1=0;
		this.timer2=0;
	  this.timer3=0;
//		application.addEventListener( "SaveOption", this._onSaveOption, this);
	},
   
 	cs:function(){
		 if(this.isIE){
			   $("sugif").style.display="none";
		  }
		    $("sug").style.display="none";
		},
		
	ct:function(){
		var trs=$("sug_t").rows;  
		for(var i=0;i<trs.length;i++){
			trs[i].className="ml";   
			}
	 },
	clktr:function(j){
	 	return function(){
	 		   $("kw").blur();
	 		   dcq.cs();
	 		   dcq.tj(j);
	 		   clearTimeout(this.timer1);
	 		   this.timer1=0;
	 		   clearTimeout(this.timer2);
	 		   this.timer2=0;
	 		   $("kw").value=this.cells[0].innerHTML;
	 		  };
	  }, 
	  
 tj:function(rsp){
	//$("oq").value=this.SD.q;
		$("oq").value="sdss";
		$("rsp").value=rsp;
		this.cs();
	 },
	 setSug:function(){
		this.SD={q:'dd',p:true,s:['ddmap','ddos','dds','ddr','ddos·À»ðÇ½','ddr3','ddr2','ddx','ddp','ddu']};
		 $("kw").onkeydown=this.kd;
     var isClkSug=false;
     $("kw").onblur=function(e){
   	     if(!isClkSug){
   			        dcq.cs();
   	}
   			isClkSug=false;
   }
	 	if(typeof (this.SD)!="object"||typeof (this.SD.s)=="undefined"){
	 		return ;
	 	} 
	 	var tab=document.createElement("table");
	  with(tab){id="sug_t"; style.width="100%"; style.backgroundColor="#fff"; cellspacing=0; cellpadding=0;style.cursor="default";}
	  var tb=document.createElement("tbody");
	  tab.appendChild(tb);
	  for(var i=0;i< this.SD.s.length;i++){
	  	var tr=tb.insertRow(-1);
	  	tr.onmouseover=function(){
	  		dcq.ct;    
	  		this.className="mo";
	  		this.mouseOnSug=true;
	  	};
	  	tr.onmouseout=dcq.ct;
	  	tr.onmousedown=function(e){
	  		this.E=true;//@@@@@
	  		if(!this.isIE){
	  			e.stopPropagation();
	  			return false;
	  		}
	  	};
	  	tr.onclick=this.clktr(i);
	  	var td=tr.insertCell(-1);
	  	td.innerHTML=this.SD.s[i];
	  }
	  var th=tb.insertRow(-1);
	  var td=th.insertCell(-1);
	  td.style.textAlign="right";
	  var oa=document.createElement("A");
	  oa.href="javascript:void(0)";
	  oa.innerHTML="¹Ø±Õ";
	  oa.onclick=dcq.cs();
	  td.appendChild(oa);
	  $("sug").innerHTML="";
	  $("sug").appendChild(tab);
    $("sug").style.width=(this.isIE?$("kw").offsetWidth:$("kw").offsetWidth-2)+"px";
     $("sug").style.top=(this.isGecko?$("kw").offsetHeight-1:$("kw").offsetHeight)+"px";
	  $("sug").style.display="block";
	  if(this.isIE){
	  	var sug_if=$("sugif");
	  	with(sug_if.style){
	  		display="";
	  		position="absolute";
	  		top=$("kw").offsetHeight+"px";
	  		left="0px";
	  		width=$("sug").offsetWidth+"px";
	  		height=tab.offsetHeight+"px";
	  	}
	  }
	  this.c=-1;
	  this.s3=""; 
	},
	
	kd:function(e){
		e=e||window.event;
		this.K=false;
		var ctr;
		if(e.keyCode==13){
			if(this.isIE){
				e.returnValue=false;
			}else{
				e.preventDefault();
			}
			if(this.c>=0){
				dcq.tj(this.c);
				}
				return;
		}
		if(e.keyCode==38||e.keyCode==40){
		 this.mouseOnSug=false;
			if($("sug").style.display!="none"){
			 		var trs=$("sug_t").rows;
			 		var l=trs.length-1;
			 		for(var i=0;i<l;i++){
			 			if(trs[i].className=="mo"){
			 				this.c=i;break;
			 			}
			 		}
			 		 dcq.ct();
			 		if(e.keyCode==38){
			 		 if(this.c==0){
			 		//	$("kw").value=this.SD.q;
			 			$("kw").value="ss";
			 			this.c=-1;
			 			this.K=true;
			 		 }else{
			 		 	 if(this.c==-1){
			 		 		  this.c=l;
			 		 		}
            	ctr=trs[--this.c];
			 		 	 ctr.className="mo";
			 		 	 $("kw").value=ctr.cells[0].innerHTML;//@@@@@
			 		 }
			 	}
			 	if(e.keyCode==40){
			 		if(this.c==l-1){
			 		//	$("kw").value=this.SD.q;
			 		   $("kw").value="ss";
			 			this.c=-1;
			 			this.K=true;
			 	  }else{
			 	  	ctr=trs[++this.c];
			 	  	ctr.className="mo";
			 	  	$("kw").value=ctr.cells[0].innerHTML;//@@@@@@
			 	  }
			 	}
			 	if(!this.isIE){
			 		e.preventDefault();
			 		}
			 	}
		}
  },
 cb:function(){
   	var b=true;
   	var bs=$("kw").value;
   	if(typeof ($("sug_t"))!="undefined"&&$("sug_t")!=null){//@@@@@
   		var trs=$("sug_t").rows;
   		for(var i=0;i<trs.length;i++){
   			if(trs[i].className=="mo"){
   				if(bs==trs[i].cells[0].innerHTML&&!mouseOnSug){
   					b=false;
   				}
   			}
   		}
   	}
   },
  resetSuggestion:function(){
   		if($("sug").style.display!="none"){
   			 setTimeout(function(){cs();if(this.SD!=null){this.setSug(this.SD);$("kw").focus()}},100);
   			 }
  },
  
  fn:function(){
  	 document.onmousedown=function(e){
   		e=e||window.event;
   		var elm=e.target||e.srcElement;
   		if(elm==$("kw")){
   			return;
   		}
   		while(elm=elm.parentNode){
   			if(elm==$("sug")||elm==$("kw")){
   				isClkSug=true;
   				return; 
   			}
   		}
   		if(timer3==0){
   			timer3=setTimeout(cs,200);
   		}
   	}
  	
  } 
	
}
DynamicQuery.main = function () {
	dcq=new DynamicQuery();
};
jQuery(document).ready(DynamicQuery.main);