/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license

<!-- ckeditor/config.js -->
function e(id){
 return document.getElementById(id)
} 

function getWindowHeight() {
 var elem = (document.compatMode === "CSS1Compat") ? document.documentElement : document.body;
 return elem.clientHeight;
}

function calculateOffsetTop(element, opt_top) {
 var top = opt_top || null;
 var offset = 0;
 for(var elem = element; elem && elem != opt_top; elem = elem.offsetParent) {
  offset += elem.offsetTop;
 }
 
 return offset;
}

function dynamicEditorHeight() {
 var window_h = getWindowHeight();
 alert(window_h);
 var resizer_height = window_h - calculateOffsetTop(e(document.forms[0].id));
 var title_field_h = e("content_title").offsetHeight || 20;
 var toolbar_h = 62; // double line toolbar
 var btm_grab_div_h = 21;
 var submit_btn_h = (document.forms[0].commit) ? document.forms[0].commit.offsetHeight : 0;
 var padding_h = 60;
 resizer_height -= (title_field_h + toolbar_h + btm_grab_div_h + submit_btn_h + padding_h + 50); // extra buffer to avoid window scrollbar
 return(resizer_height);
}
 /*
CKEDITOR.editorConfig = function( config ) { 
 config.height = dynamicEditorHeight();
};
*/
CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	//配置默认配置 
	 
	 config.language = 'zh-cn'; //配置语言 
	 // config.uiColor = '#FFF'; //背景颜色 
	  config.width = 800; //宽度 
	  //config.height =400;
	 // config.height = dynamicEditorHeight(); //高度 
	 // config.skin = 'v2'; //编辑器皮肤样式 
	 // 取消 “拖拽以改变尺寸”功能 
	  config.resize_enabled = false; 
	 // 使用基础工具栏 
	 // config.toolbar = "Basic"; 
	 // 使用全能工具栏 
	 config.toolbar = "Full"; 
	 config.toolbarCanCollapse = true; 
	   //工具栏默认是否展开
    config.toolbarStartupExpanded = false; 
	config.enterMode=2;
	//config.removePlugins='elementspath';
	 //使用自定义工具栏 
	 // config.toolbar = 
	 // [ 
	 // ['Source', 'Preview', '-'], 
	 // ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', ], 
	 // ['Undo', 'Redo', '-', 'Find', 'Replace', '-', 'SelectAll', 'RemoveFormat'], 
	 // ['Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', SpecialChar','PageBreak'], 
	 // '/', 
	 // ['Bold', 'Italic', 'Underline', '-', 'Subscript', 'Superscript'], 
	 // ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', 'Blockquote'], 
	 // ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'], 
	 // ['Link', 'Unlink', 'Anchor'], 
	 // '/', 
	 // ['Format', 'Font', 'FontSize'], 
	 // ['TextColor', 'BGColor'], 
	 // ['Maximize', 'ShowBlocks', '-', 'About'] 
	 // ];
	 // 在 CKEditor 中集成 CKFinder，注意 ckfinder 的路径选择要正确。 
	config.toolbar_Full = [
	// ['Source','-','Save','NewPage','Preview','-','Templates'],
	// ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
	// ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	// ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
	// '/',
	['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
	['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	['Link','Unlink','Anchor'],
	['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
	'/',
	['Styles','Format','Font','FontSize'],
	['TextColor','BGColor']
	];
	 config.filebrowserBrowseUrl = '/html/nds/js/ckedit/ckfinder/ckfinder.html',
	 config.filebrowserImageBrowseUrl = '/html/nds/js/ckedit/ckfinder/ckfinder.html?type=Images',
	 config.filebrowserFlashBrowseUrl = '/html/nds/js/ckedit/ckfinder/ckfinder.html?type=Flash',
	 config.filebrowserUploadUrl = '/html/nds/js/ckedit/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Files',
	 config.filebrowserImageUploadUrl = '/html/nds/js/ckedit/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Images',
	 config.filebrowserFlashUploadUrl = '/html/nds/js/ckedit/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Flash',
	 config.filebrowserWindowWidth = '1000',
	 config.filebrowserWindowHeight = '700'
};

