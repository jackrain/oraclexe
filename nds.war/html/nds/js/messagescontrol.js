jQuery.noConflict();
// mc object to dispaly messages delivered to user from u_note
//the following files are used or modified
//html/nds/js/messagescontrol.js
//html/nds/js/jquery1.3.2/*
//html/nds/theme/ui-lightness/* the file ui.tab.css was replaced with old version from jquery 1.2.3
//html/nds/portal/top_meta.jsp, table.jsp, getmessages.jsp
	
	
var mc;//message control
var MC=Class.create();
MC.prototype={
		
  initialize:function(){
    this.modal=null;
    this.URL="/html/nds/portal/getmessage.jsp";
    this.messages=[];
    this.title=null;
    this. timeoutId=null;
    this.mcount=null;
    jQuery(document.body).append("<div id=\"dialog\" title=\""+gMessageHolder.NOTICE+"\" style=\"display:none;background-color:white;\"><div id='dialog-dt' ></div></div>");
    },
	load:function(){
        var date=new Date();
        jQuery.ajax({
        url: mc.URL+"?t="+date.getTime(),
        success: function(response) {
        //alert(new XMLSerializer().serializeToString(response));
      var result=mc.analyseM(response) ;
      var mstr=result[0];
      var title=result[1];
      var shortTitle=result[2];
      var mcount=result[3];
      var urgentcount=result[4];
      var noshow=result[5];
      
      if (mcount==0) return;
      if(noshow==1)return;
      //mc.playsound();
      mc.showMessages();
      //mc.playsound();
      jQuery("#dialog-dt").html(mstr);
      jQuery("#ui-dialog-title-dialog").html(title);
      if(!mc.modal){
          mc.timeoutId=setTimeout("mc.fadeMessage();",1000);
          jQuery("#dialog").parent().mouseenter(function(){if(mc.timeoutId!=null)clearTimeout(mc.timeoutId);});
         }
			
		}, 
		error:function(xhr) {}
		});//end of ajax call
		
	 },  //end of load dialog
	refresh:function(){
		var date=new Date();
		jQuery.ajax({
		url: mc.URL+"?t="+date.getTime(),
		success: function(response) {
			//alert(new XMLSerializer().serializeToString(response));
      var result=mc.analyseM(response) ;
      var mstr=result[0];
      var title=result[1];
      var shortTitle=result[2];
      var mcount=result[3];
      var urgentcount=result[4];
      var noshow=result[5];
	
      if (mcount==0) mstr="";
			jQuery("#dialog-dt").html(mstr);
			jQuery("#dialog-title").html(shortTitle);
			jQuery("#dialog-title").focus();
	  }, 
		error:function(xhr){}
		});//end of ajax call
		
	},  //end of refresh
	analyseM:function(response){
			var root = response.documentElement;
			
			// loop through all tree children
			var cs = mc.getChildren(root,"message");
			var noshow=mc.getChildren(root,"noshow");
			var str="<div style='height:150px;overflow-y:scroll;overflow-x:visible;'><table cellspacing='0' cellpadding='0' ><thead><tr><th></th><th>"+gMessageHolder.PRIORITY+"</th><th>"+gMessageHolder.RELEASETIME+"</th><th>"+gMessageHolder.SERIALNO+"</th><th>"+gMessageHolder.TITLE+"</th></tr></thead><tbody>";
			var count=0;//count no. of most emergent message
			var priority;
			var index=0;
			for (var i = 0; i < cs.length; i++) {	
				index++;
				priority=mc.getChildValue(cs[i],"PRIORITYRULE"); 
				str+="<tr id='dialog-tbr"+i+"' "+(priority=='1'?"style='background-color:#FFFFFF;'":"")+" onclick='mc.go("+mc.getChildValue(cs[i],"ID")+");' ";
				str+=" onmouseover='mc.highlight(this);'";
				str+="><td style='border-bottom:1px dotted grey;'>"+index+"</td>";	
				if (priority=='1'){count++;str +="<td style='border-bottom:1px dotted grey;'><span style='color:red'>!!!</span></td>";}
				else if (priority=='2'){str+="<td style='border-bottom:1px dotted grey;'><span style='color:red'>!!</font></td>";}
				else str+="<td style='border-bottom:1px dotted grey;'>&nbsp;</td>";
				str+="<td style='border-bottom:1px dotted grey;'>"+mc.getChildValue(cs[i],"CREATIONDATE").substr(0,10)+"</td>";
				str+="<td style='border-bottom:1px dotted grey;padding-left:5px;'>"+mc.getChildValue(cs[i],"NO")+"</td>";
				str+="<td style='border-bottom:1px dotted grey;padding-left:5px;' title='"+mc.getChildValue(cs[i],"DESCRIPTION")+"'>"+mc.getChildValue(cs[i],"TITLE")+"</td>";
				str+="</tr>";
			}
  		str+="</tbody></table></div>";
			if(mc.title==null)mc.title=jQuery("#dialog").attr("title");
			var title=mc.title;
			var shortTitle="";
			if (count>0){
				title+="  &nbsp; &nbsp;<span id='dialog-title' style='color:red;'>"+gMessageHolder.URGENT_MESSAGE.replace('$$',count)+"!!!</span>";
				shortTitle=gMessageHolder.URGENT_MESSAGE.replace('$$',count)+"!!!";}
			else{
				 title+="  &nbsp; &nbsp;<span id='dialog-title'>"+gMessageHolder.CONFIRM_MESSAGE.replace('$$',cs.length)+".</span>";			
			   shortTitle=gMessageHolder.CONFIRM_MESSAGE.replace('$$',cs.length)+".";
			}
			title+="&nbsp;<input type='button' value='"+gMessageHolder.ALL_NOTICES+"' style='vertical-align:middle;padding-top:4px;cusor:pointer;position:relative;left:"+((count>0)?"50":"120")+"px;' onclick='mc.go();'>";
			mc.modal=(count>0);
			mc.mcount=cs.length;
			return [str,title,shortTitle,cs.length,count,noshow.length];
		
	},	
	highlight:function(which){//alert(which);
		for(var i=0;i<mc.mcount;i++){
			jQuery("#dialog-tbr"+i).css("background-color" ,"#FFFFFF");
			}
		 jQuery(which).css("background-color","#D2DFE9"); 
		  //document.getElementById("#dialog-tb").rows[1].css("background-color","#D2DFE9");
    },
	showMessages:function(modal) {
		
		var setting={
			//bgiframe: true,
			//modal: true,
			resizable:false,
			width:420,
			height:200,
			position:['right','bottom']
			
		};
		if(mc.modal)setting.modal=true;
		jQuery("#dialog").dialog(setting);

	 },
	 fadeMessage:function(){
		jQuery("#dialog").parent().mouseenter(function(){
			  if(mc.timeoutId!=null)clearTimeout(mc.timeoutId);
			  jQuery("#dialog").parent().stop();
				jQuery("#dialog").parent().css('opacity',1);
				});
		jQuery("#dialog").parent().fadeOut(3000,function(){jQuery("#dialog").dialog('close');});
		//mc.playsound();
	 },
	 go:function(targetId){
      if(targetId==null){
	  		pc.navigate('u_note');
	  		jQuery("#dialog").dialog('close');
	    }else{
	     	 jQuery("#dialog").parent().css("z-index","90");
	     	 if(mc.modal)jQuery("#dialog").parent().prev(".ui-widget-overlay ").css("z-index","89");
	     	 if(!mc.modal){jQuery("#dialog").parent().stop();
	     	jQuery("#dialog").parent().css('opacity',1);}
	     	var Option={onClose:function(){return mc.refresh();}} ;
	    	 showObject("/html/nds/object/object.jsp?table=10083&&fixedcolumns=&id="+targetId,956,570,Option);
	    	  
	    	  }

	},
    xml2Str:function(xmlNode){
	try {
      // Gecko- and Webkit-based browsers (Firefox, Chrome), Opera.
		return (new XMLSerializer()).serializeToString(xmlNode);
		}
		catch (e) {
     try {
        // Internet Explorer.
        return xmlNode.xml;
     }
     catch (e) {  
        //Other browsers without XML Serializer
        alert('Xmlserializer not supported');
		}
	 }
		return false;
	},
	 getChildValue:function (node,nodename){
	  var value="";
	  for(var i=0; i<node.childNodes.length;i++){
		if (node.childNodes[i].tagName==nodename)value=node.childNodes[i].childNodes[0].nodeValue;
	  }
	  return value;
	},
    getChildren:function(node,nodename){
	  var childs=[];
	  for (var i=0;i<node.childNodes.length;i++){
		if (node.childNodes[i].tagName==nodename)childs.push(node.childNodes[i]);
	  }
	  return childs;
	},
    playsound:function(){
    	//alert('sound !!!!');
        if($("sound").value&&$("sound").value.strip()!="0"){
            if(!app1){
                var app1=FABridge.b_playErrorSound.root();
                app1.setStr($("sound").value.strip());
            }
            app1.getErrorSound().play();
        }
        }
  
};
MC.main = function(){ mc=new MC();mc.load();},
jQuery(document).ready(MC.main);
