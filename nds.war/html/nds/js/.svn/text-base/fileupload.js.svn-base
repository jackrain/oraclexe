var fup;
FileUpload = Class.create();
// define constructor
FileUpload.prototype = {
	initialize: function() {
		//this methond will be called when class initialized
	},
	initForm:function(upinit,para){
		this._upinit=upinit;
		this._para=para;
		$("#fileInput1").uploadify({
			'uploader'      : '/html/nds/js/uploadify.swf',
			'script'        : '/control/fileupload',
			'cancelImg'     : '/html/nds/images/cancel.png',
			'folder'        : '/html/nds',
			'multi'         : false,
			'wmode'		: 'transparent',
			'sizeLimit'     : this._upinit.sizeLimit,
			'buttonText'	: this._upinit.buttonText,
			'fileDesc'      : this._upinit.fileDesc,
			'fileExt'       : this._upinit.fileExt,
			onError: function (evt, b, c, errorObj) {
	         if (errorObj.info == 404)
	            alert('Could not find upload script.');
	         else
	            alert('error '+errorObj.type+": "+errorObj.info);
			},
			onComplete:function(a,b,c,response,e){
				// you can handle response here
				/*$("#output").css("display","block");
				$("#whole").html(response);*/
				alert(response);
				return true;
			},
			onAllComplete:function (evt, data) {
	         	return true;
			}
		});			
	},
	
	beginUpload:function(){
		var para=this._para;
		$('#fileInput1').uploadifySettings("scriptData",para,true);	
		$('#fileInput1').uploadifyUpload();
 	}
};
FileUpload.main = function () {
	fup=new FileUpload();
};
jQuery(document).ready(FileUpload.main);
