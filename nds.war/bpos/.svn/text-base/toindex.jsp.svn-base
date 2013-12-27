<%@ page language="java" import="java.util.*,java.text.SimpleDateFormat" pageEncoding="utf-8"%>
<%
 nds.portlet.util.UserUtils.initPageContext(request, response); // portal4.0
	String NDS_PATH=nds.util.WebKeys.NDS_URI;
	String contextPath="";
	int RES_TOTAL=1024;
	int DEFAULT_TAB_WIDTH=740;
	nds.control.web.UserWebImpl userWeb =null;
	if(com.liferay.portal.util.ShutdownUtil.isShutdown()){
		session.invalidate();
	}
	try{
		userWeb= ((nds.control.web.UserWebImpl)nds.control.web.WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
	}catch(Throwable userWebException){
		System.out.println("########## found userWeb=null##########"+userWebException);
	}
	
if(userWeb==null || userWeb.isGuest()){
	if(request.getParameter("checkSession")!=null){out.write("noSession");return;}
	String redirect=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString() ,"UTF-8");
	 response.sendRedirect("/c/portal/login?redirect="+redirect);
	return;
}
//add by robin 20120306
String popUpMode=(String)nds.query.QueryEngine.getInstance().doQueryOne("select value from ad_param where name='webpos.popUpMode'");
if(request.getParameter("checkSession")!=null)return;
String storeName=(String)session.getAttribute("storeId");

if(null!=popUpMode&&"redirect".equals(popUpMode.trim())){
	SimpleDateFormat sf=new SimpleDateFormat("yyyyMMdd-HH:mm:ss");
	response.sendRedirect("/bpos/index.jsp?time="+sf.format(new Date()));
	return;
}
%>
<script language="javascript"> 
	function change2TwoD(num){
		var r=num;
		if(num<10){
			r="0"+num;
		}
		return r;
	}
	var t=new Date();
  var year=t.getYear();
  var m=change2TwoD(t.getMonth()+1);
  var d=change2TwoD(t.getDate());
  var h=change2TwoD(t.getHours());
  var mi=change2TwoD(t.getMinutes());
  var s=change2TwoD(t.getSeconds());
	var win=window.open("/bpos/index.jsp?time="+year+m+d+"-"+h+":"+mi+":"+s,"<%=storeName.trim()%>","fullscreen=1,top=0,left=0,menubar=yes,scrollbar=no,Location=0,toolbar=no,resizable=yes,status=no" );	  
	if(win==null) {
		window.location.href="/bpos/login.jsp?redirect=%2Fbpos%2Ftoindex.jsp&help=help";
	}else {
		if(window.name!="<%=storeName.trim()%>"){
			window.opener=null;
			window.open("","_parent","");
			window.close();
		}
	}
</script>
