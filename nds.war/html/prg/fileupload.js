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
		jQuery("#fileInput1").uploadify({
			'swf'           : '/html/prg/upload/uploadify.swf',
			'uploader'      : '/control/uploadkey',
			//'cancelImg'   : '/html/prg/upload/uploadify-cancel.png',
			'folder'        : '/html/nds',
			'multi'         : false,
			//'auto'			:false,
			'sizeLimit'     : this._upinit.sizeLimit,
			'buttonText'	: this._upinit.buttonText,
			'fileDesc'      : this._upinit.fileDesc,
			'fileExt'       : this._upinit.fileExt,
			'formData'	: this._para,
			'method'   : 'post',
			onUploadError: function (evt, b, c, s) {
			//alert(123);
	         if (b== 404)
	            alert('Could not find upload script.');
	         else
	            alert('error '+b+": "+c);
			},
			onUploadSuccess: function(a,b,response){
				// you can handle response here
				/*$("#output").css("display","block");
				 */
				jQuery("#whole").html(b);
				//alert(response);
				//window.location.href="/html/prg/regSuccess.jsp";
				return true;
			}
		});			
	},
	
	beginUpload:function(){
		var para=this._para;
		//jQuery('#fileInput1').Settings("scriptData",para,true);	
		jQuery('#fileInput1').uploadify('upload','*'); }
};
FileUpload.main = function () {
	fup=new FileUpload();
};
jQuery(document).ready(FileUpload.main);
