<%@ page language="java" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
<title>Portal</title>
<link href="/fair/base.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="/html/nds/js/prototype.js"></script>
<script type="text/javascript" src="/fair/jquery.js"></script>
<script type="text/javascript" src="/fair/jquery.jcarousel.pack.js"></script>
<script>
	jQuery.noConflict();
</script>	
<script language="JavaScript" src="/html/nds/js/formkey.js"></script>
<script language="javascript" src="/html/nds/js/calendar.js"></script>
<script type='text/javascript' src='/servlets/dwr/interface/Controller.js'></script>
<script type='text/javascript' src='/servlets/dwr/engine.js'></script>
<script type='text/javascript' src='/servlets/dwr/util.js'></script>
<script language="javascript" src="/html/nds/js/application.js"></script>
<script language="javascript" src="/html/nds/js/alerts.js"></script>
<script language="javascript" src="/fair/fair.js"></script>
<script src="/fair/outline.js"></script>
</head>
<% 
 if(!FairManager.getInstance().isAgent(userWeb.getUserId())){
    response.sendRedirect("/index.jsp");
 }
List fairlist =FairManager.getInstance().loadFairs(userWeb);
if(fairlist.size()==0){
    	response.sendRedirect("/fair/nofairinfo.jsp");
}
String currfairname ="";
  if(fairid==-1){
   fairid =Tools.getInt(((List)fairlist.get(0)).get(0),-1);
   }
   for(int m=0;m<fairlist.size();m++){
	 if(Tools.getInt(((List)fairlist.get(m)).get(0),-1)==fairid){
		currfairname=(String)((List)fairlist.get(m)).get(1);
		 break;
	   }
	}			
%>
<body><div id="hdr_topsec"><div id="hdr_mainmsg">
	<a href="/fair/index.jsp" class="hdr_logo" title="logo">logo</a>
		<div id="channel">
			<div class="wel_msg"><%=userWeb.getUserDescription()%>，您好，您当前的主题是：<%=currfairname%></div>
			<ul>
				<li><a href="/fair/index.jsp" title="订货会首页">订货会首页</li>
				<li><a href="/html/nds/portal/portal.jsp" title="业务系统">业务系统</a></li>
				<li><a href="/fair/my_order.jsp?fairid=<%=fairid%>" title="我的订单">我的订单</a></li>
				<li><a href="<%= themeDisplay.getURLSignOut() %>" title="退出"><bean:message key="sign-out" /></a></li>
		  </ul>
		</div>
		<div id="buycart" class="buycart">
			<span id="itemnum">您的<a href="/fair/my_order.jsp?fairid=<%=fairid%>" title="订单袋">订单袋</a>有<span class="txt_highlight bold" id="totqty">0</span>件物品</span>
	  </div>
  </div>
</div>
<div id="hdr_tabbar">
	<div id="hdr_maintab">
<span><center><a href="/fair/index.jsp?fairid=<%=fairid%>" target="_self"><%=currfairname%></a></center></span>
<ul>
	<%
	for(int i=0;i<fairlist.size();i++){
	if(Tools.getInt(((List)fairlist.get(i)).get(0),-1)!=fairid){
	%>
	<li><a href="/fair/index.jsp?fairid=<%=Tools.getInt(((List)fairlist.get(i)).get(0),-1)%>" target="_self" ><%=((List)fairlist.get(i)).get(1)%></a></li>
	<%}}%>
</ul>
</div>
</div>