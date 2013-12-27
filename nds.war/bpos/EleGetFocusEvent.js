function hasAttr(el, name){  

  var attr = el.getAttributeNode && el.getAttributeNode(name);  
  //var attr =el.getAttributeNode(name);  
	//return attr ? true : false ;
  return attr ? attr.specified : false 

}  

function addEvent(obj,type,callback){  

  if ( obj.addEventListener ) {  

    obj.addEventListener( type, callback, false );  

  } else if ( obj.attachEvent ) {  

    obj.attachEvent( "on" + type, callback );  

  }  

}  

function getfocus(el,fn){  

  if(!hasAttr(el,"tabindex"))  

    el.tabIndex = -1;  

  addEvent(el,"focus",function(e){  
		if(fn)
    fn.call(el,(e || window.event));  

  });  

} 
