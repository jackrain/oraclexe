/**
* oFrame - frame object
* oDim - "Width" or "Height"
*/ 
function getFrameSize(oFrame,oDim) {
 if(oFrame['inner'+oDim]) {
   return oFrame['inner'+oDim]; }
 oFrame = oFrame.document;
 if(oFrame.documentElement&&oFrame.documentElement['client'+oDim]) {
   return oFrame.documentElement['client'+oDim]; }
 if(oFrame.body&&oFrame.body['client'+oDim]) {
   return oFrame.body['client'+oDim]; }
 return 0;
}

function getSelectedItemIdx(){
      var selectedIdx=Array();
      var i=0,j;
      var itemIdObjs=document.getElementsByName("selectedItemIdx");
      if ( itemIdObjs !=null ){
      	 if (itemIdObjs.length!=null){
		      for(j=0;j< itemIdObjs.length;j++){
	          	if( itemIdObjs[j].checked==true){
	              	     selectedIdx[i++]= j;
	          	}
      	      }
      	 }else{
      	     // only one item
      	     if( itemIdObjs.checked==true){
              	 selectedIdx[0]= 0;
             }
      	 }
      }else{
      }
      
      return selectedIdx;
  }
function onResizeWindow(){
 /* handle resize window event 
 	Find in documents whose name is "resizableDiv", resize that div element to window size - 20
 */
 var control=document.getElementById("resizableDiv");
 
 if(control!=null){
	if(control.length!=null){
		//array
		for(i=0;i<control.length;i++){
			try{
				eval("resizeDiv_"+control[i].attributes("name").value+"(control[i]);");
			}catch(ex){
				//alert("Script error when resize div:"+ex.message);
			}
        }

	}else{
		//element one
		try{
			eval("resizeDiv_"+control.attributes("name").value+"(control);");
		}catch(ex){
			//alert("Script error when resize div:"+ex.message);
		}
	}
 }
 
 
}

function resize_img_by_wheel(o){
	/* param o - image object 
	sample:  <img name="imagedoc" src="inv003.jpg" onload="if(this.width>200)this.width=200;"  onmousewheel="resize_img_by_wheel(this);"> 	
	*/
    var zoom=parseInt(o.style.zoom, 10)||100;
    zoom+=event.wheelDelta/12;
    if (zoom>0) 
        o.style.zoom=zoom+'%';
        return false;
}
function isValidDate(strDate){
	strDate=String(strDate);
	if(strDate.indexOf("$")>-1) return true;//support sysdate 20100428 yfzhu
	strDate=strDate.split(" ")[0];
	var dteDate;
	var day, month, year;
	if (strDate.length==8 && !isNaN(parseInt(strDate,10))){
		year =parseInt(strDate.substr(0,4),10);
		month =parseInt(strDate.substr(4,2),10)-1;
		day=parseInt(strDate.substr(6,2),10);
	}else{
		var datePat = /^(\d{1,4})(\/)(\d{1,2})(\/)(\d{2})$/;
		var matchArray = strDate.match(datePat);
		
		if (matchArray == null)
		return false;
		
		year = matchArray[1]; // p@rse date into variables
		month = matchArray[3];
		day = matchArray[5];
		month--;
	}
	dteDate=new Date(year,month,day);
	return ((day==dteDate.getDate()) && (month==dteDate.getMonth()) && (year==dteDate.getFullYear()));
}
// Object type
function checkIsObject(o) {
  return (typeof(o)=="object");
}
function checkIsArray(o) {
  return (checkIsObject(o) && (o.length) &&(!checkIsString(o)));
}
function isSelectInputArray(o){
	// above has a bug on input type select, that also has property .length
	return (checkIsArray(o) && o[0].options!=undefined);
}
function isFunction(o) {
  return (typeof(o)=="function");
}
function checkIsString(o) {
  return (typeof(o)=="string");
}
function pop_up(url, window_name){
    var newWindow=window.open(url,window_name,'dependent=yes,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,status=yes,width=780,height=500,left=0,top=0' );
    newWindow.focus();
    //window.showModalDialog(url, window, "dialogHeight=500px;dialogWidth=770px;resizable=yes;center=no;help=no;status=yes;scroll=yes");
}
function toggleButtons(form, isDisable){
	for (var i = 0; i < form.length; i++){
		var e = form.elements[i];
		if (e.type.toLowerCase() == "button" || e.type.toLowerCase() == "reset" || e.type.toLowerCase() == "submit") {
			e.disabled=isDisable;
		}
	}
}
function executeLoadedScript(el) {
	var scripts = el.getElementsByTagName("script");

	for (var i = 0; i < scripts.length; i++) {
		if (scripts[i].src) {
			var head = document.getElementsByTagName("head")[0];
			var scriptObj = document.createElement("script");

			scriptObj.setAttribute("type", "text/javascript");
			scriptObj.setAttribute("src", scripts[i].src);

			head.appendChild(scriptObj);
		}
		else {
			try {
				if (is_safari) {
					eval(scripts[i].innerHTML);
				}
				else if (is_mozilla) {
					eval(scripts[i].textContent);
				}
				else {
					eval(scripts[i].text);
				}
			}
			catch (e) {
				//alert(e);
			}
		}
	}
}  
var Column={STRING:2,NUMBER:0,DATE:1, DATENUMBER:3};
/**
 datefrom can be retrieved from eleId+"_1",
 dateto can be retrieved from eleId+"_2"
*/
function dateRangeChanged(eleId){
	var df= document.getElementById(eleId+"_1");
	var dt= document.getElementById(eleId+"_2");
	var dr= document.getElementById(eleId);
	if(df==null || dt==null) alert("daterange input construction error");
	dr.value="";
	if(df.value.length==0){
		if(dt.value.length==0){
			dr.value="";
		}else{
			if(!isValidDate(dt.value)){
				alert( gMessageHolder==undefined? dt.value+ " is not a valid date type": dt.value+" "+gMessageHolder.MUST_BE_DATE_TYPE);
			}else
				dr.value="<="+ dt.value;	
		}
	}else{
		if(!isValidDate(df.value)){
			alert( gMessageHolder==undefined? df.value+ " is not a valid date type": df.value+" "+gMessageHolder.MUST_BE_DATE_TYPE);
		}else{
			if(dt.value.length==0){
				dr.value=">="+ df.value;
			}else{
				if(!isValidDate(dt.value)){
					alert( gMessageHolder==undefined? dt.value+ " is not a valid date type": dt.value+" "+ gMessageHolder.MUST_BE_DATE_TYPE);
				}else
					dr.value=df.value+"~"+ dt.value;
			}
		}
	}
}
  	