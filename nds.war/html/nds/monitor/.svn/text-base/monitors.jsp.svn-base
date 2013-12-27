<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="nds.monitor.MonitorManager" %>
<%@ page import="nds.web.config.*" %>
<%@ page import="nds.query.QueryEngine" %>
<%@ page import="nds.schema.Table" %>
<%@ page import="nds.schema.TableManager" %>
<%@ page import="nds.util.Tools" %>
<%@ page import="java.sql.*" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%@include file="/html/nds/common/init.jsp"%>
<% 
       MonitorManager.getInstance().checkMonitorPlugin();
       Table table = TableManager.getInstance().findTable(request.getParameter("table"));
     	 userWeb.checkPermission(table.getSecurityDirectory(), 1); 
     	 List monitors = MonitorManager.getInstance().getModifiableMonitors(table, userWeb);
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
<input type="hidden" name="table" id="table" value="<%=table.getId()%>" />
<div id="mmain">
	<p><%=table.getDescription(locale)%>具有以下监控模板:</p>
<div id="monitors">
<% if(monitors.size() == 0){%>
<p>当前尚未配置管理级别的监控器</p>
<%}else{ 
	for(int i=0;i<monitors.size();i++){%>
	<div class="monitor"> 
		<div class="mname"><a href='javascript:mm.modify("<%=((List)monitors.get(i)).get(0)%>")'</a><%=((List)monitors.get(i)).get(1)%></div>
	 <div class="actions">
		<span title="修改" id="<%=((List)monitors.get(i)).get(0)%>_modify_link" onaction='mm.modify("<%=((List)monitors.get(i)).get(0)%>")'>
		<img id="<%=((List)monitors.get(i)).get(0)%>_modify_img" border="0" width="16" height="16" align="absmiddle" src="/html/nds/images/tb_edit.gif">
		</span>
		<script>createButton(document.getElementById("<%=((List)monitors.get(i)).get(0)%>_modify_link"))</script>
		<span title="删除" id="<%=((List)monitors.get(i)).get(0)%>_delete_link" onaction='mm.del("<%=((List)monitors.get(i)).get(0)%>")'>
			<img id="<%=((List)monitors.get(i)).get(0)%>_delete_img" border="0" width="16" height="16" align="absmiddle" src="/html/nds/images/tb_delete.gif"/>
			</span>
			<script>createButton(document.getElementById("<%=((List)monitors.get(i)).get(0)%>_delete_link"))</script>
      </div>
      </div>
<%}
}%>
      <div class="btns">
      	<input type="button" class="cbutton" accesskey="A" onclick="mm.newMontior()" value="新增(A)"> &nbsp;
      	<span id="closebtn"></span>
      </div>
  </div>
</div>
<script>jQuery(document).ready(MonitorManager.main);</script>
</body>
</html>
