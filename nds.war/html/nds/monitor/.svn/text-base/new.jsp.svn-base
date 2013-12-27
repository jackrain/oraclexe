<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="nds.monitor.MonitorManager" %>
<%@ page import="nds.web.config.*" %>
<%@ page import="nds.query.QueryEngine" %>
<%@ page import="nds.query.QueryUtils" %>
<%@ page import="nds.schema.Table" %>
<%@ page import="nds.schema.TableManager" %>
<%@ page import="nds.util.Tools" %>
<%@ page import="java.sql.*" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%@include file="/html/nds/common/init.jsp"%>
<%
    MonitorManager.getInstance().checkMonitorPlugin();
		Table table = TableManager.getInstance().findTable(request.getParameter("table"));
	   int adTableId = TableManager.getInstance().getTable("ad_table").getId();
	   int columnId = TableManager.getInstance().getColumn("ad_monitor.ad_table_id").getId();
		
%>
<html>
<head>
<meta content="text/html; charset=UTF-8" http-equiv="content-type">
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico">
<%if(GetterUtil.getBoolean(PropsUtil.get(PropsUtil.JAVASCRIPT_FAST_LOAD)) ){ %>
<script language="JavaScript" src="/html/nds/js/header_aio_<%=locale.toString()%>_min.js"></script>
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/header_aio_min.css">
<%}else{%>
<script language="JavaScript" src="/html/nds/js/top_css_ext.js"></script>
<script type="text/javascript" language="JavaScript1.5" src="/html/nds/js/ieemu.js"></script>
<script language="JavaScript" src="/html/nds/js/cb2.js"></script>
<script language="JavaScript" src="/html/js/sniffer.js"></script>
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
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<script language="javascript" src="/html/nds/js/application.js"></script>

<script language="javascript" src="/html/nds/js/init_object_query_<%=locale.toString()%>.js"></script>
<script type="text/javascript" src="/html/nds/js/object_query.js"></script>

<script language="javascript" src="/html/nds/js/artDialog4/jquery.artDialog.js?skin=chrome"></script>
<script language="javascript" src="/html/nds/js/artDialog4/plugins/iframeTools.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-ui-1.8.21.custom.min.js"></script>
<script language="javascript" src="/html/nds/js/jdate/My97DatePicker/WdatePicker_dp.js"></script>
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/portal.css">
<link type="text/css" rel="StyleSheet" href="/html/nds/css/cb2.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/nds_portal.css">
<link type="text/css" rel="StyleSheet" href="<%=userWeb.getThemePath()%>/css/custom-ext.css">

<link type="text/css" rel="StyleSheet" href="/html/nds/js/jdate/My97DatePicker/skin/WdatePicker.css"/>

<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/aple_menu.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/object.css">
<%}%>
<script language="javascript" src="/html/nds/js/rest.js"></script>
<script language="javascript" src="/html/nds/monitor/monitor.js"></script>
<link type="text/css" rel="StyleSheet" href="monitors.css">
<title>配置监控器</title>
</head>
<body id="maintab-body">
<div id="mmain">
<div id="gt">
选择要监控的表<span class="nnul">*</span>:&nbsp;&nbsp;
<input id="column_42866" readonly="" type="text" value="<%=table==null?"":table.getName()%>" size="20" maxlength="40" tabindex="2" name="ad_table_id__name">
<input id="fk_column_42866" type="hidden" value="<%=table==null?"":Integer.valueOf(table.getId())%>" name="AD_TABLE_ID">
<span id="cbt_42866" class="coolButton" onaction="oq.toggle('/html/nds/query/search.jsp?table=<%=adTableId%>&amp;return_type=s&amp;column=<%=columnId%>&amp;accepter_id=column_42866&amp;qdata='+encodeURIComponent(document.getElementById('column_42866').value)+'&amp;queryindex=-1','column_42866')">
<img width="16" height="16" border="0" align="absmiddle" title="Find" src="/html/nds/images/find.gif">
</span>
<script>createButton(document.getElementById("cbt_42866"));</script>
</div>
<p>选择监控器类型:</p>
<div id="monitors">
<div class="monitortype" onclick="mm.newtype('obj')" title="点击框格选择单对象类型并进入下一步">
<span class="mtt"><img src="monitor.png">&nbsp;针对单个对象的监控管理</span><br><br>
这种模板可以针对单对象（记录）的属性变化或者用户操作进行后续的提醒和监控。
比如，在出库单提交后发送通知短信给收货人，或者在VIP等级变化时通知VIP本人。
这种模板的内容都是一个对象一条提醒信息。
</div>
<div class="monitortype" onclick="mm.newtype('list')" title="点击框格选择列表类型并进入下一步">
<span class="mtt"><img src="monitor.png">&nbsp;针对列表的监控管理</span><br><br>
对数据列表进行检查，找出其中含有监控信息的相关记录，以表格形式发送给相关监控人员。
例如，针对安全库存的定期检查，将库存不足的商品列表分别发送给相应仓库的管理人员。
针对多个仓库，可以一次性产生不同的通知邮件。列表提醒的内容是表格.
</div>
<div class="btns">
<span id="closebtn"/>
</div>
</div>
</div>
<script>jQuery(document).ready(MonitorManager.main); 
jQuery("div.monitortype").mouseover(function(){
jQuery(this).addClass("mtover");}).mouseout(function(){
jQuery(this).removeClass("mtover")}); 
</script>
</body>
<html>
