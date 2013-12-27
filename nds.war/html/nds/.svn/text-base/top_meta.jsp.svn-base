<%@ include file="/html/common/init.jsp" %>
<%@ include file="/html/common/themes/top_meta.jsp" %>
<%@ include file="/html/common/themes/top_meta-ext.jsp" %>
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico">
<%if(GetterUtil.getBoolean(PropsUtil.get(PropsUtil.JAVASCRIPT_FAST_LOAD)) ){ %>
<script language="JavaScript" src="/html/nds/js/header_aio_<%=locale.toString()%>_min.js"></script>
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/header_aio_min.css">
<%}else{%>
<script language="JavaScript" src="/html/nds/js/top_css_ext.js"></script>
<script type="text/javascript" language="JavaScript1.5" src="/html/nds/js/ieemu.js"></script>
<script language="JavaScript" src="/html/nds/js/cb2.js"></script>
<script language="JavaScript" src="/html/js/sniffer.js"></script>
<!--
<%if(BrowserSniffer.is_mozilla(request)){%>
	<script language="JavaScript" src="/html/nds/js/xmenu.js"></script>
	<script language="JavaScript" src="/html/nds/js/cssexpr.js"></script>
	<link type="text/css" rel="stylesheet" href="/html/nds/css/xmenu.css">
	<link type="text/css" rel="stylesheet" href="/html/nds/css/xmenu.windows.css">
<%}else{%>	
	<link type="text/css" rel="StyleSheet" href="/html/nds/js/menu4/skins/officexp/officexp.css">
	<script language="JavaScript" src="/html/nds/js/menu4/poslib.js"></script>
	<script language="JavaScript" src="/html/nds/js/menu4/scrollbutton.js"></script>
	<script language="JavaScript" src="/html/nds/js/menu4/menu4.js"></script>
	<%if ( ParamUtil.get(request, "enable_context_menu", false)==false){%>
	<script language="JavaScript" src="/html/nds/js/initctxmenu_<%=locale.toString()%>.js"></script>
	<%}else{%>
	<script>
	 //disable context menu control in top_css_ext.js 
	  document.detachEvent( "oncontextmenu",noContextMenu );
	</script>
	<%}
}%>-->
<script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-1.7.2.js"></script>
<script>
   jQuery.noConflict();
</script>
<script language="javascript" src="/html/nds/js/jquery1.3.2/hover_intent.min.js"></script>
<script language="javascript" src="/html/nds/js/prototype.js"></script>

	<script language="JavaScript" src="/html/nds/js/common.js"></script>
	<script language="JavaScript" src="/html/nds/js/print.js"></script>
	<script language="JavaScript" src="/html/js/ajax.js"></script>
	<script language="JavaScript" src="/html/js/util.js"></script>
	<script language="javascript" src="/html/nds/js/formkey.js"></script>
<!--script type="text/javascript" src="/html/nds/js/selectableelements.js"></script>
<script type="text/javascript" src="/html/nds/js/selectabletablerows.js"></script-->
<!--script language="JavaScript" src="/html/js/dragdrop/coordinates.js"></script>
<script language="JavaScript" src="/html/js/dragdrop/drag.js"></script-->
<!--script language="JavaScript" src="/html/js/dragdrop/dragdrop.js"></script-->
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<script language="javascript" src="/html/nds/js/application.js"></script>
<!--script language="javascript" src="/html/nds/js/alerts.js"></script-->
<script language="javascript" src="/html/nds/js/init_object_query_<%=locale.toString()%>.js"></script>
<script type="text/javascript" src="/html/nds/js/object_query.js"></script>
<!--script language="javascript" src="/html/nds/js/calendar.js"></script-->
<script language="javascript" src="/html/nds/js/artDialog4/jquery.artDialog.js?skin=chrome"></script>
<script language="javascript" src="/html/nds/js/artDialog4/plugins/iframeTools.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-ui-1.8.21.custom.min.js"></script>
<script language="javascript" src="/html/nds/js/jdate/My97DatePicker/WdatePicker.js"></script>
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/portal.css">
<link type="text/css" rel="StyleSheet" href="/html/nds/css/cb2.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/nds_portal.css">
<link type="text/css" rel="StyleSheet" href="<%=userWeb.getThemePath()%>/css/custom-ext.css">
<!--link type="text/css" href="/html/nds/js/jquery1.3.2/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet" /-->
<link type="text/css" rel="StyleSheet" href="/html/nds/js/jdate/My97DatePicker/skin/WdatePicker.css"/>
<!--link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/ui.tabs.css"-->
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/aple_menu.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/object.css">
<%}%>
<title><%= request.getParameter("html_title")==null?"":request.getParameter("html_title") %></title>

