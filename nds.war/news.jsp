<%@ page language="java" import="java.util.*,nds.velocity.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %> 
<%@ include file="/html/portal/init.jsp" %>
<%
  // int clientId= userWeb.getAdClientId();
 //  String webDomain=userWeb.getClientDomain();
 
   WebClient myweb=new WebClient(37, "","burgeon",false);
   boolean flag=true;
   int id=Tools.getInt(request.getParameter("id"),-1);
   String newsstr="";
   if(id==-1){
      newsstr=(String)request.getParameter("newsstr");
      if(newsstr==null){
        	response.sendRedirect("/index.jsp");
       }
      flag=false;
     }  
      Map mainnews=null;
      String doctype="";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>burgeon portal--伯俊软件</title>
<link href="/style-portal.css" rel="stylesheet" type="text/css" />
<script src="/html/js/sniffer.js" type="text/javascript"></script>
<script src="/html/js/ajax.js" type="text/javascript"></script>
<script language="javascript" src="/html/nds/js/prototype.js"></script>
<script type="text/javascript" src="/html/nds/js/top_css_ext.js"></script>
<script type="text/javascript" language="JavaScript1.5" src="/html/nds/js/ieemu.js"></script>
<script type="text/javascript" src="/html/nds/js/cb2.js"></script>
<script type="text/javascript" src="/servlets/dwr/interface/Controller.js"></script>
<script type="text/javascript" src="/servlets/dwr/engine.js"></script>
<script type="text/javascript" src="/servlets/dwr/util.js"></script>
<script language="javascript" src="/html/nds/js/jquery/jquery.js"></script>
<script>
jQuery.noConflict();
</script>		
<script type="text/javascript" src="/html/nds/js/portletcontrol.js"></script>
<script language="javascript" src="/html/nds/js/init_portletcontrol_zh_CN.js"></script>
<script type="text/javascript" src="/html/nds/js/selectableelements.js"></script>
<script type="text/javascript" src="/html/nds/js/selectabletablerows.js"></script>
<script type="text/javascript" src="/html/nds/js/calendar.js"></script>
</head>

<body>
<div id="head-login">
  <div id="logo-01">
  	<div class="logo-right"></div>
<div class="logo-left"><a href="/index.jsp"><img src="/images/left-logo.png" width="136" height="150" border="0" /></a></div>
  </div> 
</div>
<div id="news_content">
<div id="news_left">
<div id="news_left_top"></div>
<div id="news_left_center">
<div id="news_center_left">
<ul>
      <li><a href="/news.jsp?newsstr=latest">公司动态</a></li>
      <li><a href="/news.jsp?newsstr=industry">行业动态 </a></li>
</ul>
</div>
</div>
<div id="news_left_bottom"></div>
</div>
<div id="news_right">
	<%if(flag==true){
	 mainnews=myweb.getObject("u_news",id,2);
	 doctype=(String)mainnews.get("doctype");
	}
	%>
	<% if(newsstr.equals("company")||doctype.equals("company")){%>
<div id="news_right_top"><img src="/images/news_right_title01.gif" width="100" height="50" /></div>
	<% }else if(newsstr.equals("latest")||doctype.equals("latest")){%>
		<div id="news_right_top"><img src="/images/news_right_title.gif" width="100" height="50" /></div>
		<% }else if(newsstr.equals("industry")||doctype.equals("industry")){%>
		<div id="news_right_top"><img src="/images/news_right_title02.gif" width="100" height="50" /></div>
	<%}%>
<div id="news_right_center">
<div id="news_center_right" > 
<% if(flag==false){   
   out.print(myweb.forwardToString("/list/view.jsp?compress=f&dataconf="+newsstr+"&uiconf="+newsstr+"_list",request,response));
%>
<%}else{
  String subject=(String)mainnews.get("subject");
 
  String datenum=(String)myweb.getDate(mainnews.get("publishdate"));
  String content=(String)mainnews.get("content");
  int cnt=Tools.getInt(mainnews.get("readcnt"),1);
%>
<div class="news_center_right_border">
<div class="news_center_right_title"><%=subject%></div>
<div class="news_center_right_text">发布于：<%=datenum%></div>
<% myweb.updateNewsCounter(id);
%>
<div class="news_center_right_text02">浏览次数：<%=cnt%>次</div>
</div>
<div class="news_center_right_text01"><%=content%></div>
<%}%>
</div>
</div>
<div id="news_right_bottom"></div>
</div>
</div>
<div id="bottom">
<div id="bottom-bg">
<div id="bottom-left">
了解更多产品请点击：<br />
<a href="http://www.burgeon.com.cn" target="_parent" class="bottom-text">www.burgeon.com.cn</a></div>
<div id="bottom-right">
公司简介 | 联系我们 | 法律声明 | 服务体系 | 伯俊论坛<br />
&copy;2008 上海伯俊软件科技有限公司 版权所有 保留所有权
</div>
</div>
</div>
</body>
</html>

