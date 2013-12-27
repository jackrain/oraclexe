var jc=null;
var JC=Class.create();
JC.prototype={
   initialize: function() {
	 	this.docMsg={};
	 	this.eleMsg={};
	 	this.objInterval=null;//window.setInterval
	 	this.refreshDocMsg();
	 },
	 //刷新DOC CSS信息 --this.docMsg
	 refreshDocMsg:function(){
	 	this.docMsg.width=parseInt(document.body.clientWidth,10);
	 	this.docMsg.height=parseInt(document.body.clientHeight,10);
	 	this.docMsg.scrollTop=parseInt(document.body.scrollTop,10);
	 	this.docMsg.scrollLeft=parseInt(document.body.scrollLeft,10);
	 },
	 //刷新元素 CSS信息--this.eleMsg 通常情况下一个特效只会针对一个元素如：DIV 此方法 是将该元素的信息实时保存到全局变量中
	 refreshEleMsg:function(e){
	 	var eleMsg={};
	 	eleMsg.top=parseInt(e.style.top,10);
	 	eleMsg.left=parseInt(e.style.left,10);
	 	eleMsg.offsetHeight=parseInt(e.offsetHeight,10);
	 	eleMsg.offsetWidth=parseInt(e.offsetWidth,10);
	 	this.eleMsg=eleMsg;
	},
	/**
	 *改变指定元素的样式，现在只有top,left,offsetHeight,offsetWidth..可扩展
	 *修改的规则 是：当msg对象中有时则更新
	 *param: e 元素
	 *param:msg 
	 */
	updateEleMsg:function(e,msg){
		if(msg.top){
			e.style.top=msg.top;
		}
		if(msg.left){
			e.style.left=msg.left;
		}
		if(msg.offsetHeight){
			e.style.offsetHeight=msg.offsetHeight;
		}
		if(msg.offsetWidth){
			e.style.offsetWidth=msg.offsetWidth;
		}
		if(msg.visibility){
			e.style.visibility=msg.visibility;
		}
	},
	/**
	 *弹出像MSN提示信息的效果框
	 *前提是在页面中必须有设定好的div;实际应用中应该对div中的数据进行处理；
	 *param:div 制定元素
	 */
	popUpEffectLikeMsn:function(div){
	 	this.refreshEleMsg(div);
	 	var msg={};
	 	msg.top=this.docMsg.scrollTop+this.docMsg.height+10;
	 	msg.left=this.docMsg.scrollLeft+this.docMsg.width-this.eleMsg.offsetWidth;
	 	msg.visibility="visible";
	 	this.updateEleMsg(div,msg);
	 	this.objInterval=window.setInterval(function(){jc.moveLikeMsn(div)},10);
	},
	clearTnterval:function(){
		if(this.objInterval)window.clearInterval(this.objInterval);
	},
	/**
	 *让div如MSN弹出信息的效果
	 */
	moveLikeMsn:function(div){
		if(parseInt(div.style.top,10)<=(this.docMsg.height-this.eleMsg.offsetHeight+this.docMsg.scrollTop)){
			this.clearTnterval();
			window.setTimeout(function(){jc.resizeElement(div)},1);
		}
		this.refreshEleMsg(div);
		var msg={};
		msg.top=this.eleMsg.top-1;
		this.updateEleMsg(div,msg);
	},
	/**
	 *此方法应在onresize事件时调用
	 */
	resizeElement:function(div){
		this.refreshEleMsg(div);
	//	this.refreshDocMsg();
		var msg={};
		msg.top=this.docMsg.height-this.eleMsg.offsetHeight+this.docMsg.scrollTop;
		msg.left=this.docMsg.width-this.eleMsg.offsetWidth+this.docMsg.scrollLeft;
		this.updateEleMsg(div,msg);
	},
	//隐藏div并除掉效果
	hideElementAndClearInterval:function(div){
		this.clearTnterval();
		var msg={};
		msg.visibility="hidden";
		this.updateEleMsg(div,msg);
	}
}	
JC.main=function(){
	jc=new JC();	
}
jQuery(document).ready(JC.main);


