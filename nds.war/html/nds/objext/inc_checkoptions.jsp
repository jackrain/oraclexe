<script>
function checkSelected(optionControl, desc){
if( optionControl==undefined) return true;
      for(i=0; i<optionControl.options.length; i++) {
        if (optionControl.options[i].selected) {
            if( optionControl.options[i].value =='0'){
                alert("\<%= PortletUtils.getMessage(pageContext, "please-select",null)%>"+desc+"!");
                optionControl.focus();
                return false;
            }
        }
      }
      return true;
}
function checkNotNull(control,desc){
if( control==undefined) return true;
    if(isWhitespace(control.value)){
        alert(desc+"<%= PortletUtils.getMessage(pageContext, "can-not-be-null",null)%>!");
        control.focus();
        return false;
    }
    return true;
}
function checkIsDate(control,desc){
if( control==undefined) return true;
    if(!isValidDate(control.value)){
        alert(desc+"<%= PortletUtils.getMessage(pageContext, "must-be-date-type",null)%>!");
        control.focus();
        return false;
    }
    return true;
}
function checkIsNumber(control,desc){
if( control==undefined || control.disabled) return true;
    if(isNaN(control.value,10)){//Modify by Hawke
        alert(desc+"<%= PortletUtils.getMessage(pageContext, "must-be-number-type",null)%>!");
        control.focus();
        return false;
    }
    return true;
}
//By Hawke begin
function checkPzNumber(control,desc){
	if( control==undefined||control.disabled) return true;
    if(!checkIsNumber(control,desc)) return false;
    if(parseInt(control.value,10)<=0)
    {
        alert(desc+"<%= PortletUtils.getMessage(pageContext, "must-greater-than",null)%>0!");
        control.focus();
        return false;
    }
    return true;
}
function checkPazNumber(control,desc){
	if( control==undefined||control.disabled) return true;
    if(!checkIsNumber(control,desc)) return false;
    if(parseInt(control.value,10)<0)
    {
        alert(desc+"<%= PortletUtils.getMessage(pageContext, "must-greater-or-equal-than",null)%>0!");
        control.focus();
        return false;
    }
    return true;
}
function checkNotNullArrayItem(controlName,i, desc,nullable){
	if (isWhitespace(controlName[i].value)){
		if( document.<%=form_name%>.selectedItemIdx[i].checked && ! nullable) {
			 alert(desc+'(<%=PortletUtils.getMessage(pageContext, "line",null)%>:'+(i+1)+')'+'<%= PortletUtils.getMessage(pageContext, "can-not-be-null",null)%>!');
			 return 1;
		}
		return 2;
	}
	return 3;
}
function checkNullable(controlName,desc,nullable){
	if (isWhitespace(controlName.value)){
		if(!nullable) {
			 alert(desc+'(<%=PortletUtils.getMessage(pageContext, "line",null)%>:'+(i+1)+')'+'<%= PortletUtils.getMessage(pageContext, "can-not-be-null",null)%>!');
			 return 1;
		}
		return 2;
	}
	return 3;
}
function checkPzNumberArray(controlName,desc, nullable){
    if( controlName==undefined) return true;
    if(checkIsArray(controlName)){
        for(i=0;i<controlName.length;i++){
            ni= checkNotNullArrayItem(controlName, i, desc,nullable);
            if (ni==1) return false;
            if(ni==2) continue;
            if(!checkPzNumber(controlName[i],desc+'(<%=PortletUtils.getMessage(pageContext, "line",null)%>:'+(i+1)+')'))
                return false;
        }
    }else{//only one line
        ni=checkNullable(controlName, desc , nullable);
        if(ni==1) return false;
        if(ni==2) return true;
        if(!checkPzNumber(controlName,desc))
            return false;
    }
    return true;
}
function checkPazNumberArray(controlName,desc,nullable){
	if( controlName==undefined) return true;
    if(checkIsArray(controlName)){
        for(i=0;i<controlName.length;i++){
            ni= checkNotNullArrayItem(controlName, i, desc,nullable);
            if (ni ==1 ) return false;
            if(ni==2) continue;
            if(!checkPazNumber(controlName[i],desc+'(<%=PortletUtils.getMessage(pageContext, "line",null)%>:'+(i+1)+')'))
                return false;
        }
    }else{
        ni=checkNullable(controlName, desc , nullable);
        if(ni==1) return false;
        if(ni==2) return true;
        if(!checkPazNumber(controlName,desc))
            return false;
    }
    return true;
}
function checkIsDateArray(controlName,desc,nullable){
	if( controlName==undefined) return true;
    if(checkIsArray(controlName)){
        for(i=0;i<controlName.length;i++){
            ni= checkNotNullArrayItem(controlName, i, desc,nullable);
            if (ni ==1 ) return false;
            if(ni==2) continue;
            if(!checkIsDate(controlName[i],desc+'(<%=PortletUtils.getMessage(pageContext, "line",null)%>:'+(i+1)+')'))
                return false;
        }
    }else{
        ni=checkNullable(controlName, desc , nullable);
        if(ni==1) return false;
        if(ni==2) return true;
        if(!checkIsDate(controlName,desc))
            return false;
    }
    return true;
}

function checkIsNumberArray(controlName,desc,nullable){
	//alert("into checkIsNumberArray:"+ controlName + ", "+ desc + ","+ nullable);
	if( controlName==undefined) return true;
    if(checkIsArray(controlName)){
        for(i=0;i<controlName.length;i++){
            ni= checkNotNullArrayItem(controlName, i, desc,nullable);
            //alert("ni="+ ni+", in checkNotNullArrayItem");
            if (ni ==1 ) return false;
            if(ni==2) continue;
            if(!checkIsNumber(controlName[i],desc+'(<%=PortletUtils.getMessage(pageContext, "line",null)%>:'+(i+1)+')'))
                return false;
        }
    }else{
        ni=checkNullable(controlName, desc , nullable);
        if(ni==1) return false;
        if(ni==2) return true;
        if(!checkIsNumber(controlName,desc))
            return false;
    }
    return true;
}
function checkNullableArray(controlName,desc,nullable){
	if( controlName==undefined) return true;
	if(checkIsArray(controlName)){
        for(i=0;i<controlName.length;i++){
            ni=checkNotNullArrayItem(controlName, i, desc,nullable);
            if (ni ==1 ) return false;
        }
    }else{
        ni=checkNullable(controlName, desc , nullable);
        if(ni==1) return false;
    }
    return true;
}
function checkSelectedArray(optionControl, desc){
if( optionControl==undefined) return true;
if(!isSelectInputArray(optionControl)) return checkSelected(optionControl, desc);
var b;
for(j=0;j<optionControl.length;j++){
   if(	!checkIsArray(document.<%=form_name%>.selectedItemIdx)){
		// only one row
		b=document.<%=form_name%>.selectedItemIdx.checked;   	
   }else{
   		b=document.<%=form_name%>.selectedItemIdx[j].checked;
   }
   if(b){
      for(i=0; i<optionControl[j].options.length; i++) {
        if (optionControl[j].options[i].selected) {
            if( optionControl[j].options[i].value =="0"){
                alert("\<%= PortletUtils.getMessage(pageContext, "please-select",null)%>"+"'"+desc+"'"+"(<%=PortletUtils.getMessage(pageContext, "line",null)%>:"+(j+1)+")");
                optionControl[j].focus();
                return false;
            }
        }
      }
   }
}
return true;
}

function searchItem(form, searchData, searchColumn){
	form.quick_search_data.value=searchData;
	form.quick_search_column.value=searchColumn;
	form.quick_search.value="true";
	form.input.value="false";
	form.submit();
}
function checkItemsChecked(controlName){
    if(controlName.value == undefined){
        for(i=0;i<controlName.length;i++){
            if(controlName[i].checked == true)
                return true;
        }
    }else{
        if(controlName.checked == true)
            return true;
    }
    return false;
}
</script>
