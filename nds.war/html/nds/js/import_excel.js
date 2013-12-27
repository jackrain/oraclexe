var impxls;
ImportXLS = Class.create();
// define constructor
ImportXLS.prototype = {
	initialize: function() {
		jQuery("#txt-param").css('display','none');
		jQuery("#q_progress").attr("display", "none");
	},
	isFlashInstalled:function(){
		return swfobject.getFlashPlayerVersion().major>9;
		//return true;//swfobject.getFlashPlayerVersion().major>9;
	},
	initForm:function(upinit,para){
		jQuery("#btnImport").removeAttr('disabled');
		this._upinit=upinit;
		this._para=para;
		if(this.isFlashInstalled()){
			jQuery("#fileInput1").uploadify({
				'swf'      : '/html/nds/js/upload/uploadify.swf',
				'uploader'        : '/control/importexcel',
				//'cancelImg'     : '/html/nds/images/cancel.png',
				'folder'        : '/html/nds',
				'multi'         : false,
				'auto'          : false,
				//'wmode'		: 'transparent',
				/*'buttonImg'	: '/html/nds/images/cancel.png',*/
				'fileSizeLimit'     : this._upinit.sizeLimit,
				'buttonText'	: this._upinit.buttonText,
				'fileTypeDesc'      : this._upinit.fileDesc,
				'fileTypeExts'       : '*.xls;*.csv;*.txt;*.xlsx',
				'successTimeout' : 3600,
				//'formData'	: this._para,
				'method'   : 'post',
				onUploadError: function (evt, b, c, s) {
		         if (b== 404)
		            alert('Could not find upload script.');
		         else
		            alert('error '+errorObj.type+": "+errorObj.info);
		         jQuery("#btnImport").removeAttr('disabled');
				},
				onUploadSuccess: function(a,b,response){
					/*var ele = Alerts.fireMessageBox(
					{
						width: 550,height:300,
						modal: true,
						title: "Information",
						maxButton:false,
						closeButton:true
					});
					ele.innerHTML= response;*/
					jQuery("#output").css("display","block");
					jQuery("#whole").html(b);
					//jQuery("#whole").html(response);
					return true;
				},
				onQueueComplete:function (queueData) {
		         	if(queueData.uploadsSuccessful>0){
		         	}
		         	jQuery("#btnImport").removeAttr('disabled');
		         	return true;
				}
			});		
		}else{
			//flash not good	
			//jQuery("#noflash").css("display","block");
		}
		jQuery("#file_format_xls")[0].checked=true;
		this.updateFormat();
	},
	updateFormat:function(){
		var fmt=jQuery("input[name='file_format']:checked").val();
		if(fmt=="xls"){
			jQuery("#fmt-xls").css('display','block');
			jQuery("#fmt-txt").css('display','none');
			jQuery("#fmt-pd").css('display','none');
			jQuery("#txt-param").css('display','none');
			jQuery("#startRow").val("2");
			jQuery("#start-column").css('display','inline');
			jQuery("#start-skip").css('display','none');
		}else if(fmt=="txt"){
			jQuery("#fmt-xls").css('display','none');
			jQuery("#fmt-txt").css('display','block');
			jQuery("#fmt-pd").css('display','none');
			jQuery("#txt-param").css('display','block');
			jQuery("#startRow").val("1");
			jQuery("#start-column").css('display','none');
			jQuery("#start-skip").css('display','none');
		}else if(fmt=="pandian"){
			jQuery("#fmt-xls").css('display','none');
			jQuery("#fmt-txt").css('display','none');
			jQuery("#fmt-pd").css('display','block');
			jQuery("#txt-param").css('display','none');
			jQuery("#startRow").val("1");
			jQuery("#start-column").css('display','none');
			jQuery("#start-skip").css('display','none');
			
			jQuery("#txt_type_fix").checked=true;
			//jQuery("#txt_fix_len").value="20,5,1";
		}
	},
	updateTxtType:function(){
		var fmt=jQuery("input[name='txt_type']:checked").val();
		if(fmt=="token"){
			jQuery("#txt-token").css('display','block');
			jQuery("#txt-fix").css('display','none');
			jQuery("#collen").css('display','none');
			jQuery("#start-column").css('display','inline');
			jQuery("#start-skip").css('display','none');
			
		}else{
			jQuery("#txt-token").css('display','none');
			jQuery("#txt-fix").css('display','block');
			jQuery("#collen").css('display','block');
			jQuery("#start-column").css('display','none');
			jQuery("#start-skip").css('display','inline');
		}
	},
	beginImport:function(){
		jQuery("#btnImport").attr("disabled", "disabled");
		jQuery("#whole").html('');
		jQuery("#q_progress").attr("display", "block");
		var para=this._para;
		var a=new Array();
		if(para.partial_update){
			jQuery("input[name='update_columns2']:checked").each(function(i){a.push(jQuery(this).val());});
			if(a.length==1){
				alert(jQuery("#selcol").html());
				jQuery("#btnImport").attr("disabled", "");
				return;
			}
			para.update_columns=a.join(",");
			jQuery("#update_columns").val(a.join(","));
		}
		
		var fmt=jQuery("input[name='file_format']:checked").val();
		para.file_format=fmt;
		if(fmt!="xls"){
			para.file_format="txt";
			if(fmt=="pandian")para.txt_type="fix";
			else para.txt_type=jQuery("input[name='txt_type']:checked").val();
			if(para.txt_type==undefined || para.txt_type=="" || para.txt_type=="undefined"){
				para.txt_type="token";
			}
			if(para.txt_type=="token" ){
				var t="";
				if(jQuery("#token_tab")[0].checked) t+="[\\t]";
				if(jQuery("#token_comma")[0].checked) t+="[,]";
				if(jQuery("#token_semi")[0].checked) t+="[;]";
				if(jQuery("#token_space")[0].checked) t+="[ ]";
				if(jQuery("#token_others")[0].checked) t+="["+ jQuery("#token_other")[0].value +"]";
				para.txt_token=t;
			}else{
				var l="";
				if(fmt=="pandian"){
					l="20,5,0";
				}else{
					jQuery("input[name='collen']").each(function(i){ 
						if(l!="") l+=",";
						if(isNaN(jQuery(this).val()) || parseInt(jQuery(this).val())<0 ) l+="0";
						else l+=parseInt(jQuery(this).val());
					});
				}
				para.txt_fix_len=l;
			}
			para.multiply_num=parseInt(jQuery("#multiply_num").val());
			if(para.multiply_num<=0)para.multiply_num=1;
		}
		para.startRow=parseInt(jQuery("#startRow").val());
		if(para.startRow<=0)para.startRow=1;
		//support startColumn 20100424 yfzhu
		para.startColumn=parseInt(jQuery("#start-column").val());
		if(para.startColumn<=0)para.startColumn=1;
		para.startSkip=parseInt(jQuery("#start-skip").val());
		if(para.startSkip<=0)para.startSkip=0;
		
		para.bgrun=jQuery("#bgrun")[0].checked;
		if(jQuery("#update_on_unique_constraints").length>0)
			para.update_on_unique_constraints=jQuery("#update_on_unique_constraints")[0].checked;
		
		if(!this.isFlashInstalled()){
			document.getElementById("txt_token").value=para.txt_token;
			document.getElementById("txt_fix_len").value=para.txt_fix_len;
			document.getElementById("form1").action="/control/importexcel";
			document.getElementById("form1").submit();
		}else{
			para.multiply_num=parseInt(jQuery("#multiply_num").val());
				if(para.multiply_num<=0)para.multiply_num=1;
			para.startRow=parseInt(jQuery("#startRow").val());
			if(para.startRow<=0)para.startRow=1;
			//support startColumn 20100424 yfzhu
			if(parseInt(jQuery("#start-column").val())!=undefined)	para.startColumn=parseInt(jQuery("#startColumn").val());
			if(para.startColumn<=0)para.startColumn=1;
			if(parseInt(jQuery("#start-skip").val())!=undefined)	para.startSkip=parseInt(jQuery("#startSkip").val());
			if(para.startSkip<=0)para.startSkip=0;
			jQuery('#fileInput1').uploadify("settings","formData",para);	
			jQuery('#fileInput1').uploadify('upload','*');
		}
 	}
};
ImportXLS.main = function () {
	impxls=new ImportXLS();
};
jQuery(document).ready(ImportXLS.main);
