<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%!
 /**
 	#session timeout checker for client portal page, this is to set the interval for checking in minutes, nomally it should be 1/10 of session timeout time
#value 0 (default) means not check timeout of session
	@param "ss" - ad_subsystem.id, if set, will show subsystem only
	@param "table" - table id or name for viewing, should direct to that table immediately
	@param "popup" - only when "false" will update current user's setting, disable popup portal next time, other values will do nothing
	@param redirect - if set, should be an URL, and we will popup that url as welcome window (overwrite default welcome window)
 */ 
 private static int intervalForCheckTimeout=Tools.getInt(((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("portal.session.checkinterval","0"),0);
 private static boolean defaultSsviewFirst="true".equals( ((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("portal.ssview","false"));
 private static boolean defaultboshome="true".equals( ((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("boshome","false"));
%>

<%
 String dialogURL=request.getParameter("redirect");
 if(userWeb==null || userWeb.getUserId()==userWeb.GUEST_ID){
 	/*session.invalidate();
 	com.liferay.util.servlet.SessionErrors.add(request,PrincipalException.class.getName());
 	response.sendRedirect("/login.jsp");*/
 	//System.out.println("portal.jsp:redirect to login");
 	response.sendRedirect("/c/portal/login"+
 		(nds.util.Validator.isNotNull(dialogURL)?"?redirect="+
 			java.net.URLEncoder.encode(dialogURL,"UTF-8"):""));
 	return;
 }
 if(!userWeb.isActive()){
 	session.invalidate();
 	com.liferay.util.servlet.SessionErrors.add(request,"USER_NOT_ACTIVE");
 	response.sendRedirect("/login.jsp");
 	return;
 }

if(nds.util.Validator.isNotNull(dialogURL)){
	response.sendRedirect(dialogURL);
 	return;
}
if(nds.util.Validator.isNull(dialogURL)){
	Boolean welcome=(Boolean)userWeb.getProperty("portal.welcome",Boolean.TRUE);
	if(welcome.booleanValue()){
		dialogURL= userWeb.getWelcomePage();
		//userWeb.setProperty("portal.welcome",Boolean.FALSE);
	}
}
String directTb=request.getParameter("table");
boolean isNotPopupPortal="false".equals(request.getParameter("popup"));//Tools.getYesNo(userWeb.getUserOption("POPUP_PORTAL","Y"), true);
if(isNotPopupPortal){
	//update current user's setting, no exception will be thrown
	userWeb.saveUserOption("POPUP_PORTAL","N",false);
}
TableManager manager=TableManager.getInstance();
Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
nds.query.web.SubSystemView ssv=new nds.query.web.SubSystemView();

boolean ssviewFirst=Tools.getYesNo(userWeb.getUserOption("SSVIEW",defaultSsviewFirst?"Y":"N"),false);

int  msgref_time=Integer.parseInt(userWeb.getUserOption("REFTIME","300"));

int ssId=Tools.getInt(request.getParameter("ss"),-1);
/*
if(ssId==-1 && nds.util.Validator.isNull(directTb)&&defaultboshome){
	List<SubSystem> sss =ssv.getSubSystems(request, nds.query.web.SubSystemView.PERMISSION_VIEWABLE);
	SubSystem ss=sss.get(0);
	ssId=ss.getId();
}
*/
if(ssId==-1 && nds.util.Validator.isNull(directTb) && ssviewFirst && !defaultboshome){
	request.getRequestDispatcher("/html/nds/portal/ssv/index.jsp").forward(request, response);
	return;
}

boolean fav_show=Tools.getYesNo(userWeb.getUserOption("FAV_SHOW",defaultSsviewFirst?"Y":"N"),true);

nds.util.License.LicenseType ltype=nds.control.web.WebUtils.getLtype();
String mms=nds.control.web.WebUtils.getMms();
String cp=nds.control.web.WebUtils.getCompany();
//System.out.println("ltype "+ltype.toString());
//System.out.println("aaaaaaaaaaa");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>NewBos <%="<"+cp+">"%></title>
<!--meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9"-->
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9"/>
<!--script language = javascript>max.Click();</script-->
<!--script type="text/javascript" src="/flash/FABridge.js"></script>
<script type="text/javascript" src="/flash/playErrorSound.js"></script-->
<%@ include file="top_meta.jsp" %>
<script>
<%
	if(nds.util.Validator.isNotNull(directTb)){
%>	
jQuery(document).ready(function(){pc.navigate('<%=directTb%>')});
<%	}else{
		if(nds.util.Validator.isNotNull(dialogURL)){
%>
function loadWelcomePage(){
	pc.welcome("<%=dialogURL%>");
	//window.location.href="<%=dialogURL%>";
}
jQuery(document).ready(loadWelcomePage);
<%		}	
	}
	// check whether to check timeout for portal page
	if(intervalForCheckTimeout>0){
%>	
	setInterval("checkTimeoutForPortal(<%=session.getMaxInactiveInterval()%>)", <%=intervalForCheckTimeout*60000%>);
<%
	}
%>
jQuery(document).ready(function(){
/*
横动调跟随变化标题坐标
*/
	<%if(mms != null && mms.length() != 0) {out.print(mms);}%>
	jQuery('#roll').hide();
	jQuery("#portal-content").scroll(function() {
		if(jQuery("#portal-content").scrollTop() >= 200){
			jQuery('#roll').fadeIn(400);
			jQuery('#page-nav-commands').css("position","absolute");
    }
    else
    {
    jQuery('#roll').fadeOut(200);
    jQuery('#page-nav-commands').css("position","relative");
    }
    if(jQuery("#portal-content").scrollLeft()>=1){
    var left_scr=jQuery("#portal-content").scrollLeft();
    jQuery('#page-table-query').css("margin-left",8+left_scr);
    //jQuery('.table-buttons2').css("padding-left",2+left_scr);
    jQuery('#page-nav-commands').css("right",4-left_scr);
    
    }else{
    jQuery('#page-table-query').css("margin-left",8);
    //jQuery('.table-buttons2').css("padding-left",2);
    jQuery('#page-nav-commands').css("right",4);
    }
  });

  jQuery('#roll_top').click(function(){jQuery("#portal-content").animate({scrollTop: '0px'}, 500);});
  jQuery('#roll_bottom').click(function(){jQuery("#portal-content").animate({scrollTop:jQuery('#list-legend').offset().top}, 500);});
  //jQuery('#flyout-ribbon').FlyoutRibbon();
  pc.resize();
});

jQuery(function(){
var onAutocompleteSelect =function(value, data){
pc.navigate(data);
}; 
var options = {
serviceUrl: 'QueryServices.jsp',//获取数据的后台页面
width: 150,//提示框的宽度
delimiter: /(,|;)\s*/,//分隔符
onSelect: onAutocompleteSelect,//选中之后的回调函数
deferRequestBy: 0, //单位微秒
params: {country: 'Yes' },//参数
noCache: false //是否启用缓存 默认是开启缓存的
//minChars:2
};
a1 = jQuery("#pojam").autocomplete(options);
a1.enable();
});

<%if(msgref_time>0){%>
jQuery(document).ready(function(){

setInterval("pc.msgrefrsh()",<%=msgref_time%>*1000);			

});
<%}%>
</script>
</head>
<%if(ltype.toString().equals("Evaluation")){%>
<body style="background:url('/servlets/binserv/Image?image=apt') !important">
<%}else{%>
<body>
<%}%>
<%@ include file="body_meta.jsp"%>
<!--object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
        id="playErrorSoundTest" width="1" height="1"
        codebase="file://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab" style="float:right">
    <param name="movie" value="/flash/playErrorSound.swf"/>
    <param name="flashvars" value="bridgeName=b_playErrorSound"/>
    <param name="quality" value="high" />
    <param name="allowScriptAccess" value="sameDomain"/>
    <embed src="/flash/playErrorSound.swf" quality="high"
           width="1" height="1" name="playErrorSoundTest"
           align="middle"
           play="true"
           loop="false"
           quality="high"
           allowScriptAccess="sameDomain"
           type="application/x-shockwave-flash"
           pluginspage="http://www.adobe.com/go/getflashplayer"
           flashvars="bridgeName=b_playErrorSound">
    </embed>
</object>
<input type="hidden" id="sound" value="/flash/sound/news.flv"/-->
<div id="portal-top">
	<div id="page-top-banner">
		<%@ include file="top.jsp" %>
	</div>
	<%
	// check navigation
	String linkFile= conf.getProperty("ui.treelink.navigation");
	if(linkFile !=null){
	%>
		<jsp:include page="<%=linkFile%>" flush="true"/>
	<%}else{
	%>
		<%@ include file="navigation.jsp" %>
	<%	
	  }
	%>
</div>
<div id="portal-main" style="margin-left:0px">		
	<table id="page-table" cellpadding="0" cellspacing="0" >
	<tr><td width="1%" norwap class="topleft" >
		   <table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tr><td id="portal-menu" style="display:block;vertical-align:top;">
			<div style="margin:0;overflow:hidden;" >
			<%@ include file="list_menu.jsp" %>
			</div>
		   	</td><td id="portal-separator" style="vertical-align:top;width:7px;height:100%;display:none;" >
			<div id="leftToggler" style="vertical-align:middle;" class="leftToggler" onclick="pc.menu_toggle(this);" onmouseover="pc.menu_hl(1);" onmouseout="pc.menu_hl(0);"  >

				</div></td>
			</tr></table></td>
		<td style="vertical-align:top;width:100%;align:left;">
	<div id="portal-content" style=""></div>	
	</td></tr>
	</table>
</div>
<div id="cmdmsg" style="display:none;" ondblclick="$('cmdmsg').hide()"></div>
<div id="jpId"></div>
<div id="jp_container" class="jp-audio"></div>
<div id="portal-bottom">
	<iframe id="print_iframe" name="print_iframe" width="1" height="1" src="<%= contextPath %>/html/common/null.html"></iframe>
	<%@ include file="bottom.jsp" %>
</div>
<div id="roll" style="display:none; "><div title="" id="roll_top"></div><div title="" id="roll_bottom"></div></div>
</body>
<%
 if(!fav_show){
%>
 <input id="fav_show" value=1 type="hidden"/>
<%}%>
</html>

