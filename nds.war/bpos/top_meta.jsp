<%/**
 本文件内容使用ant task 进行javascript, css 文件的合并和压缩操作，对本文件进行的修改需要更新对应的ant build 文件
*/
%>
<%@ include file="/html/common/themes/top_meta.jsp" %>
<%@ include file="/html/common/themes/top_meta-ext.jsp" %>
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico" />
<%if(GetterUtil.getBoolean(PropsUtil.get(PropsUtil.JAVASCRIPT_FAST_LOAD)) ){ %>
<script language="javascript" src="/html/nds/js/portal_aio_<%=locale.toString()%>_min.js"></script>
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/portal_aio_min.css">
<%}else{%>
<script language="javascript" src="/html/nds/js/common.js"></script>
<script language="javascript" src="/html/nds/js/top_css_ext.js"></script>
<script language="javascript1.5" src="/html/nds/js/ieemu.js"></script>
<script language="javascript" src="/html/nds/js/cb2.js"></script>
<script language="javascript" src="/html/nds/js/xp_progress.js"></script>
<script language="javascript" src="/html/nds/js/helptip.js"></script>
<script language="javascript" src="/html/nds/js/print.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-1.7.2.js"></script>
<script>
   jQuery.noConflict();
</script>
<!--script language="javascript" src="/html/nds/js/jquery1.2.3/hover_intent.js"></script-->

<script language="javascript" src="/html/nds/js/jquery1.3.2/hover_intent.min.js"></script>
<script language="javascript" src="/html/nds/js/prototype.js"></script>
<script language="javascript" src="/html/nds/js/CloneTableHeader.js"></script>		
<script language="javascript" src="/html/js/sniffer.js"></script>
<script language="javascript" src="/html/js/ajax.js"></script>
<script language="javascript" src="/html/js/util.js"></script>
<!--script language="javascript" src="/html/js/portal.js"></script-->
<script language="javascript" src="/html/nds/js/xloadtree111/xtree.js"></script>
<script language="javascript" src="/html/nds/js/xloadtree111/xmlextras.js"></script>
<script language="javascript" src="/html/nds/js/xloadtree111/xloadtree.js"></script>
<script language="javascript" src="/html/nds/js/formkey.js"></script>
<script language="javascript" src="/html/nds/js/rest.js"></script>
<!--script language="javascript" src="/html/nds/js/selectableelements.js"></script>
<script language="javascript" src="/html/nds/js/selectabletablerows.js"></script->
<!--script language="javascript" src="/html/js/dragdrop/coordinates.js"></script>
<script language="javascript" src="/html/js/dragdrop/drag.js"></script-->
<!--script language="javascript" src="/html/nds/js/calendar.js"></script-->
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<script language="javascript" src="/html/nds/js/application.js"></script>
<!--script language="javascript" src="/html/nds/js/alerts.js"></script-->
<script language="javascript" src="/html/nds/js/dw_scroller.js"></script>
<!--script language="javascript" src="/html/nds/js/portletcontrol.js"></script-->
<script language="javascript" src="/html/nds/js/init_portalcontrol_<%=locale.toString()%>.js"></script>
<script language="javascript" src="/html/nds/js/portalcontrol.js"></script>
<script language="javascript" src="/html/nds/js/object_query.js"></script>
<script language="javascript" src="/html/nds/js/categorymenu.js"></script>
<script language="javascript" src="/html/nds/js/dockmenu.js"></script>
<script language="javascript" src="/html/nds/js/outline.js"></script>
<script language="javascript" src="/html/nds/js/jdate/My97DatePicker/WdatePicker.js"></script>
<!--script language="javascript" src="/html/nds/js/flyout/flyout.ribbon.min.js"></script-->

<!--[if IE]><script language="javascript" src="/html/nds/js/jquery1.3.2/jquery.bgiframe.js"></script><![endif]-->
<!--script language="javascript" src="/html/nds/js/jquery1.3.2/ui.core.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.3.2/ui.dialog.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.3.2/ui.draggable.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.3.2/ui.resizable.js"></script>

<script language="javascript" src="/html/nds/js/jquery1.3.2/ui.tabs.js"></script>
<script language="javascript" src="/html/nds/js/messagescontrol.js"></script-->
<!--script language="javascript" src="/html/nds/js/jquery1.3.2/jquery.bgiframe.js"></script-->
<!--script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-ui-1.7.3.custom.min.js"></script-->
<script language="javascript" src="/html/nds/js/artDialog4/jquery.artDialog.js?skin=chrome"></script>
<script language="javascript" src="/html/nds/js/artDialog4/plugins/iframeTools.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-ui-1.8.21.custom.min.js"></script>
<!--script language="javascript" src="/html/nds/js/jquery1.3.2/jquery.bgpos.js"></script-->
<script language="javascript" src="/html/nds/js/jquery1.3.2/jquery.autocomplete-min.js"></script>
<script type="text/javascript" src="/html/nds/js/jplay/jquery.jplayer.min.js"></script>
<!--link type="text/css" rel="stylesheet" href="/html/nds/js/artdialog4/skin/chrome.css" /-->
<link type="text/css" rel="stylesheet" href="/html/nds/js/xloadtree111/xtree.css" />
<link type="text/css" rel="StyleSheet" href="/html/nds/css/portlet.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/object.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/portal_header.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/portal.css">
<link type="text/css" rel="StyleSheet" href="/html/nds/css/cb2.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/nds_portal.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/dockmenu.css">
<link type="text/css" rel="StyleSheet" href="<%=userWeb.getThemePath()%>/css/custom-ext.css" />
<!--link type="text/css" rel="StyleSheet" href="<%=userWeb.getThemePath()%>/css/ui.tabs.css" /-->
<link type="text/css" rel="StyleSheet" href="<%=userWeb.getThemePath()%>/css/autocomplete.css" />
<link type="text/css" rel="StyleSheet" href="<%=userWeb.getThemePath()%>/css/aple_menu.css" />
<!--link type="text/css" rel="StyleSheet" href="<%=userWeb.getThemePath()%>/css/pag-tab.css" /-->
<link type="text/css" href="/html/nds/js/jquery1.3.2/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet" />
<link type="text/css" rel="StyleSheet" href="/html/nds/js/jdate/My97DatePicker/skin/WdatePicker.css"/>
<!--link type="text/css" rel="StyleSheet" href="/html/nds/js/flyout/flyout.ribbon.css"></script-->
<!--link type="text/css" rel="StyleSheet" href="<%=userWeb.getThemePath()%>/css/jquery-ui-1.7.3.custom.css" /-->
<!--link type="text/css" rel="stylesheet" href="/html/nds/themes/ui-lightness/ui.all.css" /-->
<!--script language="javascript" src="/html/nds/js/objdropmenu.js"></script-->
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/objdropmenu.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/drop_menu3.css">
<%}//end JAVASCRIPT_FAST_LOAD
%>
<title><%=userWeb.getClientDomainName()%></title>