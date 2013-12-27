function checkModifiedLine(controlName,line){
        if(controlName.value == undefined){
            if(line < controlName.length)
            {
                controlName[line].checked = true;
                //alert(line+':Got');
            }
        }else{
            if(line == 0)
                controlName.checked = true;
        }
  }
  
function unselectall()
{
    if(document.getElementById("myCheckBoxAll").checked){
		document.getElementById("myCheckBoxAll").checked = document.getElementById("myCheckBoxAll").checked&0;
    } 	
}

function selectall(theForm, length)
{
    document.getElementById("myCheckBoxAll").checked = document.getElementById("myCheckBoxAll").checked|0;

    if (length == 0 ){
          return; 
    }
    if (length ==1 )
    {
       theForm.selectedItemIdx.checked=document.getElementById("myCheckBoxAll").checked ;
    }
   
    if (length>1)
    {
      for (var i = 0; i < length; i++)
       {
        theForm.selectedItemIdx[i].checked=document.getElementById("myCheckBoxAll").checked;         
       }
    }

} 
  function doSubmit(form, start,range){
   form.range.value=range;
   form.start.value=start;
   form.submit();
  }
  function setIndex(form,index){
    form.start.value=index;
    form.submit();

  }
  //Hawke begin
  function changeControlValue(control, value){
        control.value = value;
  }
  function reOrder(formName,columnValue){
        if(formName.elements["order/columns"].value == columnValue){
            if(formName.elements["order/asc"].value == 'true')
                formName.elements["order/asc"].value = 'false';
            else
                formName.elements["order/asc"].value = 'true'
        }else{
            formName.elements["order/columns"].value = columnValue;
        }
        setIndex(formName,1);
  }
  function createReport(form){
        changeControlValue(form.resulthandler,"/html/nds/reports/create_report.jsp");
        form.submit();
  }
  function checkModifiedLine(controlName,line){
        if(controlName.value == undefined){
            if(line < controlName.length)
            {
                controlName[line].checked = true;
                //alert(line+':Got');
            }
        }else{
            if(line == 0)
                controlName.checked = true;
        }
  }
  function inputChanged(id,e){
  	var array = id.split('_');
	if(array.length < 3){
		alert("id("+")"+id+" has error!");
		return;
	}
	var row = array[1];
	checkModifiedLine(document.sheet_item_modify.selectedItemIdx,row);
  }
  function checkboxChanged(id,e){
  	// set hidden input value
  	document.getElementById(id).value=(document.getElementById("chk_"+id).checked?"Y":"N");
  	alert(document.getElementById(id).value);
  	inputChanged(id,e);
 }
  function changeFocusOnCell(row,col){
	var nId = "column_" + row + "_" + col;
	//alert("Next Id:"+nId);
 	var obj = document.getElementById([nId]);
	try{if(obj != null)
		obj.focus();
	}catch(ex){
		//for checkbox, the column_x_y will be hidden, and the checkbox object will have name chkn_column_x_y
		var obj = document.getElementById(["chkn_"+nId]);
		try{
			if(obj != null)
				obj.focus();
		}catch(ex){
		}
	}
  	
  }
  function move(id,e){
	//document.getElementById(['']);
	var array = id.split('_');
	if(array.length < 3){
		alert("id("+")"+id+" has error!");
		return;
	}
	var row = array[1];
	var col = array[2];
	switch(e.keyCode){
		case 37:{
			var object = document.getElementById(id);
			if(object.type=="text" &&object.value.length > 0)
				return;
			//alert("LEFT");
			col--;
			changeFocusOnCell(row,col);
			break;
		}
		case 38:{
			//alert("UP");
			row--;
			changeFocusOnCell(row,col);
			break;
		}
		case 39: {
			var object = document.getElementById(id);
			if(object.value.length > 0)
				return;
			//alert("RIGHT");
			col++;
			changeFocusOnCell(row,col);
			break;
		}
		case 40:
		case 13:{
			//alert("DOWN");
			row++;
			changeFocusOnCell(row,col);
			break;
		}
        default:{
             if(e.keyCode != 9 && e.keyCode !=16)
                   checkModifiedLine(document.sheet_item_modify.selectedItemIdx,row);
        }
	}
	//alert("I got "+e.keyCode);
  }
  function refresh(form){
    form.submit();
  }

  function openScript(theURL) {
    var W=420,H=500;
    var newWindow=window.open(theURL,"FlinkWindow",'width=' + W + ',height=' + H + ',dependent=yes,resizable=1,scrollbars=yes,menubar=no,status=yes' );
    newWindow.focus();
  }

    function addKeyCatcher(Frame,Form){
	    if(Form.elements.length==0) return true;
	    _Frame=Frame;
	    _Form=Form;
	    for(var i=0;i<Form.elements.length;i++){
		    Form.elements[i].onkeypress=keyCatcher;
	    }
	    keyCatcher(true);
    }

    function keyCatcher(bFirst){
	    var thisKey;
	    var srcElement;
	    if(bFirst){
		    thisKey=13;
		    srcElement=_Form.elements[_Form.elements.length-1];
	    }else{
		    thisKey = _Frame.window.event.keyCode;
		    srcElement = _Frame.window.event.srcElement;
		    if(isReservedKeycode(thisKey)) return false;
		    if(thisKey==27){
			    _Frame.window.event.srcElement.blur();
			    _Frame.window.event.srcElement.focus();
			    return true;
		    }

		    if(_Frame.window.event.srcElement.type.toUpperCase()=='TEXTAREA')
			    return true;
	    }

	    if(thisKey!=13) return true;

	    for(var i=0,iThis=-1;;)	{
		    if(_Form.elements[i]==srcElement){
			    if(iThis==i) return true;
			    iThis = i;
		    }

		    if(i==(_Form.elements.length-1)) i=0;
		    else i++;

		    if(iThis==-1) continue;

		    var toItem=_Form.elements[i];
		    if(toItem.tagName.toUpperCase()=="FIELDSET") continue;
		    if(!isDisplay(toItem)) continue;

		    var sType=toItem.type.toUpperCase();
		    if(sType=='HIDDEN'||sType=='BUTTON'||sType=='SUBMIT'||sType=='RESET')  continue;

		    var bText=(sType=='TEXT'||sType=='PASSWORD'||sType=='TEXTAREA');
		    if(bText&&toItem.readOnly) continue;
		    if(toItem.disabled)  continue;
			if(toItem.name !="T8") continue; // this is added by naeco to avoid on other input fields

		    if(bText) toItem.select();
		    toItem.focus();
		    return false;
	    }
    }
    //////////////////end of focusnext ///////////////

    /////to decide the display property of an item style//////////
    function isDisplay(pelement){
	    if(pelement.tagName=="INPUT"&&pelement.type=="hidden") return false;
	    while(pelement.tagName!="BODY"&&pelement.style.display!="none")
		    pelement=pelement.parentElement;
	    if(pelement.tagName=="BODY") return true;
	    else return false;
    }

    //To determine not press these keys
    function isReservedKeycode(keycode){
	    switch(keycode){
		    case 39:		//char: '
		    case 94:		//char: ^
		    case 96:		//char: `
		    case 124:		//char: |
		    return true;
	    }
	    return false;
    }

    // To Submit a Form
    function doAction(Form){
        Form.method = 'post';
        Form.submit();
    }

function makeArray(n) {
   for (var i = 1; i <= n; i++) {
      this[i] = 0
   }
   return this
}


function isEmpty(s)
{   return ((s == null) || (s.length == 0))
}


function isWhitespace (s)
{   var i;
    if (isEmpty(s)) return true;
    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (" ".indexOf(c) == -1) return false;
    }
    return true;
}


function stripCharsInBag (s, bag)
{   var i;
    var returnString = "";
    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}


function stripCharsNotInBag (s, bag)
{   var i;
    var returnString = "";
    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (bag.indexOf(c) != -1) returnString += c;
    }
    return returnString;
}


function stripWhitespace (s)
{   return stripCharsInBag (s, whitespace)
}


function charInString (c, s)
{   for (i = 0; i < s.length; i++)
    {   if (s.charAt(i) == c) return true;
    }
    return false
}


function stripInitialWhitespace (s)
{   var i = 0;
    while ((i < s.length) && charInString (s.charAt(i), whitespace))
       i++;
    return s.substring (i, s.length);
}


function isLetter (c)
{   return ( ((c >= "a") && (c <= "z")) || ((c >= "A") && (c <= "Z")) )
}


function isDigit (c)
{   return ((c >= "0") && (c <= "9"))
}


function isLetterOrDigit (c)
{   return (isLetter(c) || isDigit(c))
}


function isInteger (s)
{   var i;
    if (isEmpty(s))
       if (isInteger.arguments.length == 1) return defaultEmptyOK;
       else return (isInteger.arguments[1] == true);
    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (!isDigit(c)) return false;
    }
    return true;
}


function isSignedInteger (s)
{   if (isEmpty(s))
       if (isSignedInteger.arguments.length == 1) return defaultEmptyOK;
       else return (isSignedInteger.arguments[1] == true);
    else {
        var startPos = 0;
        var secondArg = defaultEmptyOK;
        if (isSignedInteger.arguments.length > 1)
            secondArg = isSignedInteger.arguments[1];
        if ( (s.charAt(0) == "-") || (s.charAt(0) == "+") )
           startPos = 1;
        return (isInteger(s.substring(startPos, s.length), secondArg))
    }
}


function isPositiveInteger (s)
{   var secondArg = defaultEmptyOK;
    if (isPositiveInteger.arguments.length > 1)
        secondArg = isPositiveInteger.arguments[1];
    return (isSignedInteger(s, secondArg)
         && ( (isEmpty(s) && secondArg)  || (parseInt (s) > 0) ) );
}


function isNonnegativeInteger (s)
{   var secondArg = defaultEmptyOK;
    if (isNonnegativeInteger.arguments.length > 1)
        secondArg = isNonnegativeInteger.arguments[1];
    return (isSignedInteger(s, secondArg)
         && ( (isEmpty(s) && secondArg)  || (parseInt (s) >= 0) ) );
}


function isNegativeInteger (s)
{   var secondArg = defaultEmptyOK;
    if (isNegativeInteger.arguments.length > 1)
        secondArg = isNegativeInteger.arguments[1];
    return (isSignedInteger(s, secondArg)
         && ( (isEmpty(s) && secondArg)  || (parseInt (s) < 0) ) );
}


function isNonpositiveInteger (s)
{   var secondArg = defaultEmptyOK;
    if (isNonpositiveInteger.arguments.length > 1)
        secondArg = isNonpositiveInteger.arguments[1];
    return (isSignedInteger(s, secondArg)
         && ( (isEmpty(s) && secondArg)  || (parseInt (s) <= 0) ) );
}


function isFloat (s)
{   var i;
    var seenDecimalPoint = false;
    if (isEmpty(s))
       if (isFloat.arguments.length == 1) return defaultEmptyOK;
       else return (isFloat.arguments[1] == true);
    if (s == decimalPointDelimiter) return false;
    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if ((c == decimalPointDelimiter) && !seenDecimalPoint) seenDecimalPoint = true;
        else if (!isDigit(c)) return false;
    }
    return true;
}


function isSignedFloat (s)
{   if (isEmpty(s))
       if (isSignedFloat.arguments.length == 1) return defaultEmptyOK;
       else return (isSignedFloat.arguments[1] == true);
    else {
        var startPos = 0;
        var secondArg = defaultEmptyOK;
        if (isSignedFloat.arguments.length > 1)
            secondArg = isSignedFloat.arguments[1];
        if ( (s.charAt(0) == "-") || (s.charAt(0) == "+") )
           startPos = 1;
        return (isFloat(s.substring(startPos, s.length), secondArg))
    }
}


function isAlphabetic (s)
{   var i;
    if (isEmpty(s))
       if (isAlphabetic.arguments.length == 1) return defaultEmptyOK;
       else return (isAlphabetic.arguments[1] == true);
    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (!isLetter(c))
        return false;
    }
    return true;
}


function isAlphanumeric (s)
{   var i;
    if (isEmpty(s))
       if (isAlphanumeric.arguments.length == 1) return defaultEmptyOK;
       else return (isAlphanumeric.arguments[1] == true);
    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (! (isLetter(c) || isDigit(c) ) )
        return false;
    }
    return true;
}



function isEmail (s)
{   if (isEmpty(s))
       if (isEmail.arguments.length == 1) return defaultEmptyOK;
       else return (isEmail.arguments[1] == true);
    if (isWhitespace(s)) return false;
    var i = 1;
    var sLength = s.length;
    while ((i < sLength) && (s.charAt(i) != "@"))
    { i++
    }
    if ((i >= sLength) || (s.charAt(i) != "@")) return false;
    else i += 2;
    while ((i < sLength) && (s.charAt(i) != "."))
    { i++
    }
    if ((i >= sLength - 1) || (s.charAt(i) != ".")) return false;
    else return true;
}


function isURL (s)
{   if (isEmpty(s))
       if (isURL.arguments.length == 1) return defaultEmptyOK;
       else return (isURL.arguments[1] == true);
    if (isWhitespace(s)) return false;
	s = s.toLowerCase();
	if (s.indexOf('http://www') == -1){
		return false;
	}
	else
	{
		return true;
	}
}


function isYear (s)
{   if (isEmpty(s))
       if (isYear.arguments.length == 1) return defaultEmptyOK;
       else return (isYear.arguments[1] == true);
    if (!isNonnegativeInteger(s)) return false;
    return ((s.length == 2) || (s.length == 4));
}


function isIntegerInRange (s, a, b)
{   if (isEmpty(s))
       if (isIntegerInRange.arguments.length == 1) return defaultEmptyOK;
       else return (isIntegerInRange.arguments[1] == true);
    if (!isInteger(s, false)) return false;
    var num = parseInt (s,10);
    return ((num >= a) && (num <= b));
}


function isMonth (s)
{   if (isEmpty(s))
       if (isMonth.arguments.length == 1) return defaultEmptyOK;
       else return (isMonth.arguments[1] == true);
    return isIntegerInRange (s, 1, 12);
}


function isDay (s)
{   if (isEmpty(s))
       if (isDay.arguments.length == 1) return defaultEmptyOK;
       else return (isDay.arguments[1] == true);
    return isIntegerInRange (s, 1, 31);
}


function daysInFebruary (year)
{
    return (  ((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0) ) ) ? 29 : 28 );
}


function isDate (year, month, day)
{
    if (! (isYear(year, false) && isMonth(month, false) && isDay(day, false))) return false;
    var intYear = parseInt(year,10);
    var intMonth = parseInt(month,10);
    var intDay = parseInt(day,10);
    if (intDay > daysInMonth[intMonth]) return false;
    if ((intMonth == 2) && (intDay > daysInFebruary(intYear))) return false;
    return true;
}


function checkEmail (theField, emptyOK)
{   if (checkEmail.arguments.length == 1) emptyOK = defaultEmptyOK;
    if ((emptyOK == true) && (isEmpty(theField.value))) return true;
    else if (!isEmail(theField.value, false))
       return warnInvalid (theField, iEmail);
    else return true;
}

function checkYear (theField, emptyOK)
{   if (checkYear.arguments.length == 1) emptyOK = defaultEmptyOK;
    if ((emptyOK == true) && (isEmpty(theField.value))) return true;
    if (!isYear(theField.value, false))
       return warnInvalid (theField, iYear);
    else return true;
}


function checkMonth (theField, emptyOK)
{   if (checkMonth.arguments.length == 1) emptyOK = defaultEmptyOK;
    if ((emptyOK == true) && (isEmpty(theField.value))) return true;
    if (!isMonth(theField.value, false))
       return warnInvalid (theField, iMonth);
    else return true;
}


function checkDay (theField, emptyOK)
{   if (checkDay.arguments.length == 1) emptyOK = defaultEmptyOK;
    if ((emptyOK == true) && (isEmpty(theField.value))) return true;
    if (!isDay(theField.value, false))
       return warnInvalid (theField, iDay);
    else return true;
}


function checkDate (yearField, monthField, dayField, labelString, OKtoOmitDay)
{
    if (checkDate.arguments.length == 4) OKtoOmitDay = false;
    if (!isYear(yearField.value)) return warnInvalid (yearField, iYear);
    if (!isMonth(monthField.value)) return warnInvalid (monthField, iMonth);
    if ( (OKtoOmitDay == true) && isEmpty(dayField.value) ) return true;
    else if (!isDay(dayField.value))
       return warnInvalid (dayField, iDay);
    if (isDate (yearField.value, monthField.value, dayField.value))
       return true;
    alert (iDatePrefix + labelString + iDateSuffix)
    return false
}

function LeapYear(intYear) {
if (intYear % 100 == 0) {
if (intYear % 400 == 0) { return true; }
}
else {
if ((intYear % 4) == 0) { return true; }
}
return false;
}