function swatchOver(thisvalue,name,value,image){
 	document.getElementById(name+'_'+thisvalue).style.border= '2px solid #a89387';
	document.getElementById('span_'+name).innerHTML =  value;
	if(name=="size"){
		$('#s_message').css({display: 'none'});
	}
	if(image != null){
		document.getElementById('view_big').src = image;
	}
 }
 function swatchOut(thisvalue,name,value,id){
    var default_value = document.getElementById(id).value;
	if(name=="color"){
		var pre_value = $('#pre_color_name').val();
	}
	if(name=="size"){
		var pre_value = $('#pre_size_name').val();
	}
	if(default_value != thisvalue){
    	var default_obj = document.getElementById('pre_image');
 		document.getElementById(name+'_'+thisvalue).style.border= '2px solid #fff';
		document.getElementById('span_'+name).innerHTML =  pre_value;
		if(name=="size"){
			if(pre_value==""){
				$('#s_message').css({display: 'inline'});
			}
		}
		document.getElementById('view_big').src = default_obj.value;
		
	}
 }
 function swatchClick(thisvalue,name,value,id){
    var default_value = document.getElementById(id).value;
	var img = document.getElementById('view_big').src;
	var PId = $('#products_id').val();

	if(default_value != thisvalue){
		if( document.getElementById(name+'_'+default_value)){
	    	document.getElementById(name+'_'+default_value).style.border= '2px solid #fff';
		}
		$('#color_default').val(img);
		$('#pre_image').val(img);
		if(name=="color"){
			$('#pre_color_name').val(value);
			ajax_function(thisvalue,PId);
		}
		if(name=="size"){
			if($('#message').css('display') == 'block'){
				$('#message').css({display: 'none'});
				$('#messagebtm').css({visibility:'hidden'});
			}
			document.getElementById('pre_size_name').value = value;
		}
    	document.getElementById(name+'_'+thisvalue).style.border= '2px solid #a89387';
		document.getElementById(id).value =  thisvalue;
	}else{
		if($('#message').css('display') == 'block'){
			$('#message').css({display: 'none'});
			$('#messagebtm').css({visibility:'hidden'});
		}
	}
 }
 
 function bateswatchClick(thisvalue,name,value,id){
    var default_value = document.getElementById(id).value;
	var img = document.getElementById('view_big').src;
	var PId = $('#products_id').val();

	if(default_value != thisvalue){
		if( document.getElementById(name+'_'+default_value)){
	    	document.getElementById(name+'_'+default_value).style.border= '2px solid #fff';
		}
		$('#color_default').val(img);
		$('#pre_image').val(img);
		if(name=="color"){
			$('#pre_color_name').val(value);
			bateajax_function(thisvalue,PId);
		}
		if(name=="size"){
			if($('#message').css('display') == 'block'){
				$('#message').css({display: 'none'});
				$('#messagebtm').css({visibility:'hidden'});
			}
			document.getElementById('pre_size_name').value = value;
		}
    	document.getElementById(name+'_'+thisvalue).style.border= '2px solid #a89387';
		document.getElementById(id).value =  thisvalue;
	}
 }
 
 function bateajax_function(color,id){
	$.ajax({
			url: batebase_host+"product/item/productsizeforajax/",
			type:"get",
			dateType: "html",
			data: "varcolor="+color+"&varPId="+id,
			success: function(html){
				$('#choose_size').html(html);
			}});
}

 function ajax_function(color,id){
	var obj = document.getElementById('choose_size');
	if($('#message').css('display') == 'block'){
		$('#message').css({display: 'none'});
		$('#messagebtm').css({visibility:'hidden'});
	}
	$.ajax({
			url: base_host+"ajax/ajax_size.php",
			type:"get",
			dateType: "text",
			data: "varcolor="+color+"&varPId="+id,
			success: function(msg){
				obj.innerHTML = msg;
			}});
}


function DisplayDiv(sid,pid,Did){
	$('#'+Did).html('<iframe src="http://buy.'+document.domain+'/login.php?osCsid='+sid+'&products_id='+pid+'&Did='+Did+'" width="378" height="191" scrolling="no" frameborder="0"></iframe>');
	$('#'+Did).css({display:'block'});
}

function DisplayDiv_faq(sid,pid,verify){
	var content = $('#content').val();
	var code = $('#identifying').val();
	var check;
	if($('#check').attr('checked')){
		check = 1;
	}else{
		check = 0;
	}
	
	$('#pop_faq').html('<iframe src="pop_faq_signin_success.php?osCsid='+sid+'&products_id='+pid+'&content='+content+'&code='+code+'&check='+check+'&verify='+verify+'" width="378" height="191" scrolling="no" frameborder="0"></iframe>');
	$('#pop_faq').css({display:'block'});
}

function   cleandefaults(obj)  
  {  
        if(obj.value!='')  
              {  
                  obj.value='';  
                  return;  
              }   
  } 
  
  function pop_link(){
	var url = window.parent.location.href;
	window.parent.location.href = member_host+'/accounts/login/?url='+url;
}

function browseViewedImage(offset,maxNum,items){
	var obj = document.getElementById("recent_view");
	$.ajax({
			url: base_host+"ajax/ajax_viewed.php",
			type:"get",
			dataType: "html",
			data: "varoffset="+offset+"&varmaxNum="+maxNum+"&varItems="+items ,
			success: function(html){
				$('#recent_view').html(html);
			}});	 
}