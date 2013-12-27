//document.write('<iframe id=CalFrame name=CalFrame frameborder=0 src=calendar.htm style=display:none;position:absolute;z-index:100></iframe>');
document.onclick=hideCalendar;

function showCalendar(sImg,bOpenBound,sFld1,sFld2,sCallback,bIsDateNumber)
{
	
	var fld1,fld2;
	var cf=document.getElementById("CalFrame");
	if(cf==null) return;
	var wcf=window.frames.CalFrame;
	var oImg=document.getElementById(sImg);
	if(!oImg){alert(sImg+" does not exists");return;}
	if(!sFld1){alert("Not set input object");return;}
	fld1=document.getElementById(sFld1);
	if(!fld1){alert("Input object does not exists");return;}
	if(fld1.tagName!="INPUT"||fld1.type!="text"){alert("Wrong input object");return;}
	if(sFld2)
	{
		fld2=document.getElementById(sFld2);
		if(!fld2){alert("Ref input object does not exists");return;}
		if(fld2.tagName!="INPUT"||fld2.type!="text"){alert("Ref object type error");return;}
	}
	if(!wcf.bCalLoaded){alert("Calendar control not loaded, please refresh page");return;}
	if(cf.style.display=="block"){cf.style.display="none";return;}
	
	var eT=0,eL=0,p=fld1;//oImg;
	var sT=document.body.scrollTop,sL=document.body.scrollLeft;
	var eH=oImg.height,eW=oImg.width;
	while(p&&p.tagName!="BODY"){eT+=p.offsetTop;eL+=p.offsetLeft;p=p.offsetParent;}
	
	//cf.style.top=(document.body.clientHeight-(eT-sT)-eH>=cf.height)?eT+eH:(eT-cf.Height);
	//cf.style.left=(document.body.clientWidth-(eL-sL)>=cf.width)?eL:eL+eW-cf.width;
	
	//2009-8-17 modify by zhou
	cf.style.top=((document.body.clientHeight-(eT-sT)-eH>=cf.height)?eT+eH:(eT-cf.Height))+"px";
	cf.style.left=((document.body.clientWidth-(eL-sL)>=cf.width)?eL:eL+eW-cf.width)+"px";
	//END..
	
	cf.style.display="block";
	
	wcf.openbound=bOpenBound;
	wcf.fld1=fld1;
	wcf.fld2=fld2;
	wcf.callback=sCallback;
	wcf.initCalendar(bIsDateNumber);
}
function hideCalendar()
{
	var cf=document.getElementById("CalFrame");
	if(cf==null) return;
	cf.style.display="none";
}