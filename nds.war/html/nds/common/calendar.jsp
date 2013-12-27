<%@ include file="/html/nds/common/init.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<style type=text/css>
td{font-size:12;font-family:arial;text-align:center}
td.dt{font-size:11;font-family:arial;text-align:center}
a{color:blue}
a:hover{color:red}
a.bt{color:#888888}
</style>

<script language="JavaScript">
<!--

function SymError()
{
  return true;
}

window.onerror = SymError;

//-->
</script>

<script language=javascript>
<!--//
var str='',i,j,yy,mm,openbound,callback;
var fld1,fld2;
var wp=window.parent;
var cf=wp.document.getElementById("CalFrame");
var fld,curday,today=new Date(); 
var bIsDateNumberFormat=false;
var sToday=
today.setHours(0);today.setMinutes(0);today.setSeconds(0);today.setMilliseconds(0);
//var lastyear=today.getYear(),lastmonth=today.getMonth();
function parseDate(s)
{
	if(bIsDateNumberFormat){
		if(s.length!=8 || isNaN(s)){
			return today;
		}else{
			return new Date(parseInt(s.substr(0,4),10), parseInt(s.substr(4,2),10)-1, parseInt(s.substr(6,2),10));
			
		}
	}
	var reg=new RegExp("[^0-9-]","")
	if(s.search(reg)<0)return today;
	var ss=s.split("/");
	if(ss.length!=3)return today;
	if(isNaN(ss[0])||isNaN(ss[1])||isNaN(ss[2]))return today;
	return new Date(parseInt(ss[0],10),parseInt(ss[1],10)-1,parseInt(ss[2],10));
}
function resizeCalendar(){cf.width=144;cf.height=192;}
function initCalendar(bIsDateNumber)
{
	bIsDateNumberFormat=bIsDateNumber;
	if(fld1&&fld1.value.length>0){curday=parseDate(fld1.value);}
	else if(fld2&&fld2.value.length>0){curday=parseDate(fld2.value);}
	else curday=today;
	drawCalendar(curday.getFullYear(),curday.getMonth());
}
function drawCalendar(y,m)
{
	var x=new Date(y,m,1),mv=x.getDay(),d=x.getDate(),de;
	yy=x.getFullYear();mm=x.getMonth();
	document.getElementById("yyyymm").innerHTML=yy+"."+(mm+1>9?mm+1:"0"+(mm+1));
	for(var i=1;i<=mv;i++)
	{
		de=document.getElementById("d"+i);
		de.innerHTML="";
		de.bgColor="";
	}
	while(x.getMonth()==mm)
	{
		de=document.getElementById("d"+(d+mv));
		de.bgColor="white";
		if(x.getTime()==today.getTime()){
			de.innerHTML="<a href=javascript:setDate("+d+");><font color=red>"+d+"</font></a>";
		}else if(x.getTime()<today.getTime())
			if(openbound){de.innerHTML="<a href=javascript:setDate("+d+"); class=bt>"+d+"</a>";}
			else{
				de.bgColor="#F6F6F6";
				de.innerHTML="<font color=#888888>"+"<a href=javascript:setDate("+d+");>"+d+"</a>"+"</font>";
			}
		else
			de.innerHTML="<a href=javascript:setDate("+d+");>"+d+"</a>";

		if(x.getTime()==curday.getTime())
			de.bgColor="#dddddd";
			
		x.setDate(++d);
	}
	while(d+mv<=42)
	{
		de=document.getElementById("d"+(d+mv));
		de.innerHTML="";
		de.bgColor="";
		d++;
	}
}
function setDate(d)
{
	var dstr;
	if(bIsDateNumberFormat)dstr=yy+""+(mm+1>9?mm+1:"0"+(mm+1))+""+(d>9?d:"0"+(d));
	else dstr=yy+"/"+(mm+1>9?mm+1:"0"+(mm+1))+"/"+(d>9?d:"0"+(d));
	if(callback&&callback.length>0){eval("wp."+callback+"(\""+dstr+"\")");}
	else{fld1.value=dstr;if(fld1.onchange)fld1.onchange();}
	wp.hideCalendar();
}
function setToday(){
	var dstr;
	if(bIsDateNumberFormat)dstr=today.getFullYear()+""+(today.getMonth()+1>9?today.getMonth()+1:"0"+(today.getMonth()+1))+""+(today.getDate()>9?today.getDate():"0"+(today.getDate())) ;
	else dstr=today.getFullYear()+"/"+(today.getMonth()+1>9?today.getMonth()+1:"0"+(today.getMonth()+1))+"/"+(today.getDate()>9?today.getDate():"0"+(today.getDate())) ;
	if(callback&&callback.length>0){eval("wp."+callback+"(\""+dstr+"\")");}
	else{fld1.value=dstr;if(fld1.onchange)fld1.onchange();}
	wp.hideCalendar();
}
//-->
</script>
</head>

<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0 onload="resizeCalendar();">
<table id=tbl0 bgcolor=#336699 border=0 cellpadding=1 cellspacing=0><tr><td>
<table width=100% border=0 cellpadding=2 cellspacing=1 bgcolor=white>
<tr bgcolor=gray>
<td width=16 id=prev><a href=javascript:drawCalendar(yy,mm-1);><img src="/html/nds/images/calendar_prev.gif" border=0 width="16" height="16"></a></td>
<td width=99% id=yyyymm style=font-size:11;color:white></td>
<td width=16 id=next><a href=javascript:drawCalendar(yy,mm+1);><img src="/html/nds/images/calendar_next.gif" border=0 width="16" height="16"></a></td>
</tr>
</table>
<table width=142 border=0 bgcolor=white cellpadding=0 cellspacing=2>
<tr height=18><td width=18><font color=red><%=PortletUtils.getMessage(pageContext, "calendar.sunday",null)%></font></td><td width=18><%=PortletUtils.getMessage(pageContext, "calendar.monday",null)%></td><td width=18><%=PortletUtils.getMessage(pageContext, "calendar.tuesday",null)%></td><td width=18><%=PortletUtils.getMessage(pageContext, "calendar.wednesday",null)%></td><td width=18><%=PortletUtils.getMessage(pageContext, "calendar.thursday",null)%></td><td width=18><%=PortletUtils.getMessage(pageContext, "calendar.friday",null)%></td><td width=18><font color=green><%=PortletUtils.getMessage(pageContext, "calendar.saturday",null)%></font></td></tr>
<tr height=1><td colspan=7 bgcolor=gray></td></tr>
<script language=javascript>
<!--//
for(i=0;i<6;i++)
{
	str+="<tr height=18>";
	for(j=1;j<=7;j++)str+="<td id=d"+(i*7+j)+" class=dt></td>";
	str+="</tr>";
}
document.write(str);
//-->
</script>
<tr height=1><td colspan=7 bgcolor=gray></td></tr>
<tr height=18><td colspan=7><a href="javascript:setToday();"><%=PortletUtils.getMessage(pageContext, "calendar.today",null)%></a>
&nbsp;&nbsp;<a href="javascript:wp.hideCalendar();"><%=PortletUtils.getMessage(pageContext, "calendar.close",null)%></a>
</td></tr>
</table>
</td></tr></table>
<script language=javascript>
<!--//
var bCalLoaded=true;
//-->
</script>
</body>
</html>
