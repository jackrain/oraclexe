var outlineItems = new Array();

function outlineInit()
{
	var elements = outlineGetTopLevelLists();
	for (var i = 0; (i < elements.length); i++) {
		outlineInitOutline(elements[i]);
	}		
}

function outlineInitOutline(outline)
{
	var kids = outline.childNodes;
	for (var i = 0; (i < kids.length); i++) {
		var kid = kids[i];
		if (kid.nodeName == "LI") {
			outlineInitItem(kid);
		}
	}
}

function outlineInitItem(item)
{
	var kids = item.childNodes;
	var hasKids = false;
	var outlines = new Array();
	for (var i = 0; (i < kids.length); i++) {
		var kid = kids[i];	
		if (kid.nodeName == "UL") {
			kid.style.display = "none";
			outlineInitOutline(kid);
			hasKids = true;
			outlines[outlines.length] = kid;
		}
	}
	if (hasKids) {
		item.style.cursor = "pointer";
		var len = outlineItems.length;
		outlineItems[len] = item;
		// We can't just modify item.innerHTML, because that would
		// invalidate JavaScript objects that already refer to
		// other elements in the outlineItems array. So we use
		// the clunky DOM way of creating a span element. Then we
		// tuck the "a" element inside it so we can use
		// innerHTML for that and avoid various IE bugs.
		var span = document.createElement("span");
		span.innerHTML = "<a href='#' " +
			"onClick='outlineItemClickByOffset(" + len + 
			"); return false' " +
			"class='olink'>" +
			"<img class='oimg' alt='Open' src='/html/nds/wuliu/lct/show.gif'></a>";
		item.insertBefore(span, kids[0]);
		item.onclick = outlineItemClick;
	}
}

function outlineGetTarget(evt)
{
	var target;
        if (!evt) {
                // Old IE
                evt = window.event;
        }
	// Prevent double event firing (sigh)
	evt.cancelBubble = true;
	if (evt.stopPropagation) {
		evt.stopPropagation();
	}
        var target = evt.target;
        if (!target) {
                // Old IE
                target = evt.srcElement;
        }
	return target;
}

function outlineItemClickByOffset(id)
{
	outlineItemClickBody(outlineItems[id]);
}

function outlineItemClick(evt)
{
	target = outlineGetTarget(evt);
	outlineItemClickBody(target);
}

function outlineItemClickBody(target)
{
	var closed = true;
	var kids = target.childNodes;
	var hasKids = false;
	for (var i = 0; (i < kids.length); i++) {
		var kid = kids[i];	
		if (kid.nodeName == "UL") {
			if (kid.style.display == "none") {
				kid.style.display = "block";
			} else {	
				kid.style.display = "none";
				closed = false;
			}
			hasKids = true;
		}
	}
	if (!hasKids) {
		// We're here because of a click on a
		// childless node. Ignore that.
		return;
	}	
	var img = outlineGetImg(target);
	if (closed) {
		// We've just opened it, show close button
		img.src = "/html/nds/wuliu/lct/hide.gif";
		img.alt = "Close";
	} else {
		img.src = "/html/nds/wuliu/lct/show.gif";
		img.alt = "Open";
	}
}
	
function outlineGetImg(target)
{
	return outlineGetDescendantWithClassName(target, "oimg");
}

function outlineGetDescendantWithClassName(parent, cn)
{
	// Regular expression: beginning with class name, or
	// class name preceded by a space; and ending with class name, or
	// class name followed by a space. Covers the ways a single class
	// name can appear with or without others in the className attribute.
	var elements = parent.childNodes;
	var length = elements.length;
	var i;
	var regexp = new RegExp("(^| )" + cn + "( |$)");
	for (i = 0; (i < length); i++) {
		if (regexp.test(elements[i].className)) {
			return elements[i];
		}
		var result = outlineGetDescendantWithClassName(
			elements[i], cn);	
		if (result) {
			return result;
		}
	}
	return null;
}

function outlineGetTopLevelLists()
{
	// Regular expression: beginning with class name, or
	// class name preceded by a space; and ending with class name, or
	// class name followed by a space. Covers the ways a single class
	// name can appear with or without others in the className attribute.
	var cn = "outline";
	var elements = document.getElementsByTagName("ul");
	var length = elements.length;
	var i;
	var regexp = new RegExp("(^| )" + cn + "( |$)");
	var results = new Array();
	for (i = 0; (i < length); i++) {
		if (regexp.test(elements[i].className)) {
			results.push(elements[i]);
		}
	}
	return results;
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
