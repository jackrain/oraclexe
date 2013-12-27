<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
 /**
    如果Referer对应的url里存在redirect参数，此参数对应的url将作为welcome对话框的网址
     此功能用于用户点击审核单据的链接，在未登录情况下的重定向
   
    */
 String referer=request.getHeader("Referer");
 //System.out.println("/html/nds/portal/index.jsp:Referer:"+referer);
 String redirect ="";
 
 if(nds.util.Validator.isNotNull(referer)){
 	  java.net.URL url=new  java.net.URL(referer);
 	  String q=url.getQuery();
 	  if(q!=null){
	 	  com.Ostermiller.util.CGIParser parser= new com.Ostermiller.util.CGIParser(q,"UTF-8");
	 	  redirect=parser.getParameter("redirect");
	 	  if(nds.util.Validator.isNotNull(redirect)){
	 	  	 redirect ="?redirect="+java.net.URLEncoder.encode(redirect,"UTF-8");
	 	  }else  redirect ="";
 	  }
 }else if( nds.util.Validator.isNotNull( request.getParameter("redirect"))){
 	redirect ="?redirect="+java.net.URLEncoder.encode(request.getParameter("redirect"),"UTF-8");
}
 if(userWeb==null || userWeb.getUserId()==userWeb.GUEST_ID){
 	/*session.invalidate();
 	com.liferay.util.servlet.SessionErrors.add(request,PrincipalException.class.getName());
 	response.sendRedirect("/login.jsp");*/
 	response.sendRedirect("/c/portal/login");
 	return;
 }
 if(!userWeb.isActive()){
 	session.invalidate();
 	com.liferay.util.servlet.SessionErrors.add(request,"USER_NOT_ACTIVE");
 	response.sendRedirect("/login.jsp");
 	return;
 } 
 boolean isPopupPortal=Tools.getYesNo(userWeb.getUserOption("POPUP_PORTAL","N"), true);
 if(!isPopupPortal || nds.util.Validator.isNotNull(redirect)){
 	response.sendRedirect("/html/nds/portal/portal.jsp"+redirect);
 	return;
 }
  if(true){
 	response.sendRedirect("/c");
 	return;
 } 
%>
<html>
<head>
<meta content="text/html; charset=UTF-8" http-equiv="content-type">
<title><%=userWeb.getClientDomainName()%></title>
<style>
.warning{
color:#FF0000;
}
a{
 color:#0000FF;
}
</style>	
<script language="javascript" >
 
 function enter(bPopup){
	  	window.open("portal.jsp?popup="+bPopup,"_self","");
	     }
</script>
</head>
<body onload="openPortal()">
<div id="tag_close_window" class="warning">
</div> 
<p><div class="warning">
<%=PortletUtils.getMessage(pageContext, "login-directly-warning",null)%>
</div>
<p>
<input type="button" onclick="enter(true);" value="<%=PortletUtils.getMessage(pageContext, "enter-here",null)%>">
<input type="button" onclick="enter(false);" value="<%=PortletUtils.getMessage(pageContext, "nopopup-portal",null)%>">
<script>
function openPortal(){
	var opn=window.open("portal.jsp","","width="+screen.availWidth+",height="+screen.availHeight+",top=0,left=0,menubar=no,status=yes,location=no,scrollbars=yes,resizable=yes");
	if(opn!=null && !opn.closed){
		opn.focus();
//	 	document.getElementById("tag_close_window").innerHTML=
	 	 //'The application is opened in another window, just close this page or <a href="javascript:openPortal()">reopen the application</a>.<p>\u7cfb\u7edf\u5c06\u5728\u53e6\u4e00\u4e2a\u7a97\u53e3\u4e2d\u663e\u793a\uff0c\u8bf7\u5173\u95ed\u5f53\u524d\u7f51\u9875\uff0c\u6216<a href="javascript:openPortal()">\u70b9\u51fb\u8fd9\u91cc\u518d\u6b21\u8fdb\u5165\u7cfb\u7edf</a>';
		
		closewindow();
	}else{
	 	//document.getElementById("tag_close_window").innerHTML=
	 	// "This page will popup a new window to let you enter system. Check your browser settings if you have not seen the new window.<p>\u5f53\u524d\u9875\u9762\u5c06\u5f39\u51fa\u4e00\u4e2a\u7a97\u53e3\u8ba9\u60a8\u8fdb\u5165\u7cfb\u7edf\uff0c\u5982\u60a8\u672a\u770b\u5230\u5f39\u51fa\u7a97\u53e3\uff0c\u8bf7\u68c0\u67e5\u6d4f\u89c8\u5668\uff08\u6216\u5916\u6302\u62e6\u622a\u5668\uff09\u8bbe\u7f6e\uff0c\u9700\u5141\u8bb8\u672c\u7f51\u7ad9\u5f39\u51fa\u7a97\u53e3\u548c\u8fd0\u884cjavascript\u811a\u672c";
	}	
}	
function closewindow() 
{ 
try{
var ua=navigator.userAgent;
var ie=navigator.appName=="Microsoft Internet Explorer"?true:false ;
if(ie){ 
    var IEversion=parseFloat(ua.substring(ua.indexOf("MSIE ")+5,ua.indexOf(";",ua.indexOf("MSIE ")))) 
 if(IEversion< 5.5){ 
    var str  ="<object id=noTipClose classid=\"clsid:ADB880A6-D8FF-11CF-9377-00AA003B7A11\">";
    str += "<param name=\"Command\" value=\"Close\"></object>"; 
    document.body.insertAdjacentHTML("beforeEnd", str); 
    document.all.noTipClose.Click(); 
    } 
    else{ 
    window.opener =null; 
    window.close(); 
    } 
} 
else{ 
window.close();
} 
}catch(e){}
}

var secs;
var timerID = null;
var timerRunning = false;
var delay = 1000;

function InitializeTimer()
{
    // Set the length of the timer, in seconds
    secs = 10;
    StopTheClock();
    StartTheTimer()
}

function StopTheClock()
{
    if(timerRunning)
        clearTimeout(timerID);
    timerRunning = false;
}

function StartTheTimer()
{
    if (secs==0)
    {
        StopTheClock();
        closewindow();
    }
    else
    {
        if(secs<3 && opn==null){
         	StopTheClock();
         	return;
        }
        self.status = secs;
        secs = secs - 1;
        timerRunning = true;
        timerID = self.setTimeout("StartTheTimer()", delay);
    }
}

</script>
<noscript>
Please allow script to run for this website.
</noscript>	
</body> 
</html>

