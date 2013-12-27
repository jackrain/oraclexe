var impxls;
ImportXLS = Class.create();
// define constructor
ImportXLS.prototype = {
	initialize: function() {
		$("#txt-param").css('display','none');
		
	},
	initForm:function(upinit,para){
		this._upinit=upinit;
		this._para=para;
		$("#fileInput1").uploadify({
			'uploader'      : '/html/nds/js/uploadify.swf',
			'script'        : '/control/importexcel',
			'cancelImg'     : '/html/nds/images/cancel.png',
			'folder'        : '/html/nds',
			'multi'         : false,
			'wmode'		: 'transparent',
			/*'buttonImg'	: '/html/nds/images/cancel.png',*/
			'sizeLimit'     : this._upinit.sizeLimit,
			'buttonText'	: this._upinit.buttonText,
			'fileDesc'      : this._upinit.fileDesc,
			'fileExt'       : '*.txt',
			onError: function (evt, b, c, errorObj) {
	         if (errorObj.info == 404)
	            alert('Could not find upload script.');
	         else
	            alert('error '+errorObj.type+": "+errorObj.info);
	         $("#btnImport").removeAttr('disabled');
			},
			onComplete:function(a,b,c,response,e){
				/*var ele = Alerts.fireMessageBox(
				{
					width: 550,height:300,
					modal: true,
					title: "Information",
					maxButton:false,
					closeButton:true
				});
				ele.innerHTML= response;*/
				$("#output").css("display","block");
				$("#whole").html(response);
				return true;
			},
			onAllComplete:function (evt, data) {
	         	if(data.filesUploaded>0){
	         		
	         	}
	         	$("#btnImport").removeAttr('disabled');
	         	return true;
			}
		});			
	},
	beginImport:function(){
		$("#btnImport").attr("disabled", "disabled");
		$("#whole").html('');
		var para=this._para;
		var a=new Array();
		para.file_format="txt";
		para.txt_type="token";
		para.txt_token="[\\t]";
		para.multiply_num=1;
		para.startRow=1;
		para.bgrun=false;
		para.update_on_unique_constraints=false;
		$('#fileInput1').uploadifySettings("scriptData",para,true);	
		$('#fileInput1').uploadifyUpload();
 	}
};
ImportXLS.main = function () {
	impxls=new ImportXLS();
};
jQuery(document).ready(ImportXLS.main);
