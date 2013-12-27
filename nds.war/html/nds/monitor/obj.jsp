<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="nds.monitor.MonitorManager" %>
<%@ page import="nds.web.config.*" %>
<%@ page import="nds.util.Tools" %>
<%@ page import="java.sql.*" %>
<%@ page import="net.fckeditor.FCKeditor" %>
<%@ page import="org.apache.jasper.runtime.HttpJspBase" %>
<%@ page import="org.apache.jasper.runtime.JspSourceDependent" %>
<%@ page import="org.apache.jasper.runtime.TagHandlerPool" %>
<%@ page import="org.apache.taglibs.standard.tag.rt.core.IfTag" %>
<%@ page import="org.json.JSONObject" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%@include file="/html/nds/common/init.jsp"%>
<%
    MonitorManager.getInstance().checkMonitorPlugin();
    TableManager manager = TableManager.getInstance();
    Table table = manager.findTable(request.getParameter("table"));
    userWeb.checkPermission("AD_MONITOR_LIST", 3);
    int monitorId = Tools.getInt(request.getParameter("id"), -1);
    JSONObject jo;
    if (monitorId != -1)
    {
      if (!userWeb.hasObjectPermission("AD_MONITOR", monitorId, 3)) throw new NDSException("@no-permission@");
      List al = QueryEngine.getInstance().doQueryList("select props, ad_table_id from ad_monitor where id=?", new Object[] { Integer.valueOf(monitorId) });
      if (al.size() > 0) {
        Clob props = (Clob)((List)al.get(0)).get(0);
        jo = new JSONObject(props.getSubString(1L, (int)props.length()));
        table = manager.getTable(Tools.getInt(((List)al.get(0)).get(1), -1));
      } else {
        throw new NDSException("监控器配置未找到(id=" + monitorId + ")");
      }
    } else {
      jo = new JSONObject();
    }
%>
<head>
<meta content="text/html; charset=UTF-8" http-equiv="content-type">
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico">
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

<script language="javascript" src="/html/nds/js/rest.js"></script>
<script language="javascript" src="/html/nds/monitor/monitor.js"></script>
<link type="text/css" rel="StyleSheet" href="monitors.css">
<title>配置对象监控器</title>
</head>
<body id="maintab-body">
<input type="hidden" name="table" id="table" value="<%=table.getId()%>">
<input type="hidden" name="monitor_type" id="monitor_type" value="obj">
<div class="btns">
<input class="cbutton" type="button" accesskey="S" value="保存(S)" onclick="mm.doSave()">
<input class="cbutton" type="button" accesskey="A" value="另存为(A).." onclick="mm.showSaveAsDlg()">
<input class="cbutton" type="button" accesskey="T" value="立刻运行(T)" onclick="mm.runNow()">
<!--<input class="cbutton" type="button" accesskey="T" value="测试(T).." onClick="mm.testMontior()" />-->
<span id="closebtn"><input type="button" class="cbutton" value="关闭(C)" accesskey="C" onclick="window.close()" name="Close"></span>
</div>
<div id="tabs">
	
<ul class="ui-tabs-nav"><li class=""><a href="#tab1"><span>控制参数</span></a></li>
<li class="ui-tabs-selected"><a href="#tab2"><span>提醒内容</span></a></li></ul>
  <div id="tab1" class="ui-tabs-panel ui-tabs-hide" style="min-width: 0px;"><div class="dtable">
  <table border="0" cellpadding="5" cellspacing="0" class="mtable">
	<tbody>
		<tr><td class="np">监控对象:</td><td class="nv"><a href="javascript:dlgo(<%=manager.getTable("ad_table").getId()%>,<%=table.getId()%>)"><%=table.getDescription(locale)%>
		</a></td></tr>
		<tr><td class="np">模板名称:</td><td class="nv"><input type="text" id="name" name="name" size="80" value=""></td></tr>
		<tr><td class="np">触发行为:</td><td class="nv"><input type="checkbox" id="send_sms" name="name" value="true">发短信 
		&nbsp;<input type="checkbox" id="send_sms2" name="send_sms2" value="true">发短信(通道2)
		&nbsp;<input type="checkbox" id="send_mail" name="send_mail" value="true">发邮件
		&nbsp;<input type="checkbox" id="send_notice" name="send_notice" value="true">发系统通知
		&nbsp;<span style="display:none"><input type="checkbox" id="send_chat" name="send_chat" value="true">在线消息</span>
		<input type="checkbox" id="actionchk" name="actionchk" value="true">执行动作
		<div id="div_action"><select id="action">
			<%
			  if (table.isActionEnabled(2)) {%>
            <option value="D">删除</option>"
        <%}
        if (table.isActionEnabled(4)) {%>
           <option value="S">提交</option>"
        <%}
        if (table.isActionEnabled(5)) {%>
           <option value="U">取消提交</option>"
        <%}
        List was = table.getWebActions(WebAction.DisplayTypeEnum.ObjButton);
        for (int wasi = 0; wasi < was.size(); wasi++) {
          WebAction wa = (WebAction)was.get(wasi);
        %>
          <option value="<%=wa.getId()%>"><%=wa.getDescription()%></option>
        <%}
  
        was = table.getWebActions(WebAction.DisplayTypeEnum.ObjMenuItem);
        for (int wasi = 0; wasi < was.size(); wasi++) {
          WebAction wa = (WebAction)was.get(wasi);
          %>
         <option value="<%=wa.getId()%>"><%=wa.getDescription()%></option>
       <%}%>
		</select> &nbsp;&nbsp;<a href="javascript:void(0)" onclick="mm.toggleNote('note3')">&nbsp;?&nbsp;</a><br>
		<div class="note" style="display:none" id="note3">动作将在触发条件满足时，信息创建后（而不是发送）立刻执行，执行人为监控模板的创建人。
		</div></div></td></tr>
		<tr>
		<td class="np">检查时点:</td><td class="nv"><input type="radio" id="byaction" value="byaction" name="checktype" onclick="mm.checktypeChanged()" checked="">即时触发
		<div id="div_byaction" style="visibility: visible;">&nbsp;<input type="checkbox" name="ac" id="ac" value="true">新增后
		&nbsp;<input type="checkbox" id="am" name="am" value="true">修改后
		&nbsp;<input type="checkbox" id="bd" name="bc" value="true">删除前
		&nbsp;<input type="checkbox" id="submit" name="submit" value="true">提交后
		&nbsp;<input type="checkbox" id="unsubmit" name="unsubmit" value="true">取消提交后
		&nbsp;<input type="checkbox" id="auditing" name="auditing" value="true">待批
		&nbsp;<input type="checkbox" id="reject" name="reject" value="true">驳回
		&nbsp;
    <%
         List wa = table.getWebActions(WebAction.DisplayTypeEnum.ObjButton);
        for (int i = 0; i < wa.size(); i++) {
          WebAction wact = (WebAction)wa.get(i);
          if ((wact.getActionType() == WebAction.ActionTypeEnum.StoredProcedure) || (wact.getActionType() == WebAction.ActionTypeEnum.BeanShell) || (wact.getActionType() == WebAction.ActionTypeEnum.OSShell) || (wact.getActionType() == WebAction.ActionTypeEnum.Python))
          {
    %>
          <input type="checkbox" id="wa<%=wact.getId()%>" title="webaction" name="<%=wact.getId()%>" value="true"><%=wact.getDescription()%>&nbsp;
         <% } 
        }
        wa = table.getWebActions(WebAction.DisplayTypeEnum.ObjMenuItem);
        for (int i = 0; i < wa.size(); i++) {
          WebAction wact = (WebAction)wa.get(i);
          if ((wact.getActionType() == WebAction.ActionTypeEnum.StoredProcedure) || (wact.getActionType() == WebAction.ActionTypeEnum.BeanShell) || (wact.getActionType() == WebAction.ActionTypeEnum.OSShell) || (wact.getActionType() == WebAction.ActionTypeEnum.Python))
          {%>
          <input type="checkbox" id="wa<%=wact.getId()%>" title="webaction" name="<%=wact.getId()%>" value="true"><%=wact.getDescription()%>&nbsp;
         <% }
        }
    %>
    </div>
		<br><input type="radio" id="byperiod" name="checktype" value="byperiod" onclick="mm.checktypeChanged()">周期性检查
		<div id="div_bypeirod">
		<%
		 int queueColumnId = manager.getColumn("ad_monitor.ad_queue_id").getId();
		 int queueTableId = manager.getTable("ad_processqueue").getId();
		%>
		<input type="text" readonly="" value="" size="20" maxlength="20" id="ad_queue_name">
	   <input type="hidden" value="" name="ad_queue_id" id="fk_ad_queue_name">
	   <span onaction="dq.toggle('/html/nds/query/dropdown.jsp?table=<%=queueTableId%>&amp;return_type=s&amp;column=<%=queueColumnId%>&amp;accepter_id=ad_queue_name&amp;qdata='+encodeURIComponent(document.getElementById('ad_queue_name').value),'ad_queue_name')" id="cbt_<%=queueColumnId%>" class="coolButton">
		<img width="16" height="16" border="0" align="absmiddle" src="/html/nds/images/dropdown.gif">
		</span>
		<script>createButton(document.getElementById("cbt_"+<%=queueColumnId%>));</script>
		</td>
</tr>
	
<tr>
<td class="np"><a href="javascript:void(0)" onclick="mm.setCondition()">条件设置..</a><br>
<a href="javascript:void(0)" onclick="mm.clearCondition()">清空</a><br>
</td><td class="nv">
  <input type="hidden" name="condition" id="condition" value="">
  <input type="hidden" name="condition_sql" id="condition_sql" value="">
  <textarea name="condition_desc" id="condition_desc" rows="10" readonly=""></textarea>
</td>
</tr>

<tr>
<td class="np">发送时间:</td><td class="nv">
<input type="radio" name="exectimeType" id="exectimeType_wait" value="wait">检查时间后<input type="text" id="waitTime" value="0" size="5" name="waitTime"> 分钟 &nbsp;&nbsp;&nbsp; <input type="radio" name="exectimeType" id="exectimeType_spec" value="spec">检查时间后的<input type="text" id="specHour" name="specHour" value="22" size="4"> 时<input type="text" name="specMinute" id="specMinute" value="00" size="4">分
</td>
</tr>

<tr>
<td class="np">补充检查程序:</td><td class="nv"><input type="text" id="preTrigger" name="preTrigger" value="" size="20"> &nbsp;&nbsp; &nbsp;&nbsp;
补充触发程序:<input type="text" id="postTrigger" name="postTrigger" value="" size="20"> <a href="javascript:void(0)" onclick="mm.toggleNote('note1')">&nbsp;?&nbsp;</a><br>
<div class="note" style="display:none" id="note1">即时触发情况下，补充检查和触发程序与原操作在同一个事务中</div>
</td>
</tr>

<tr>
<td class="np">重复控制:</td><td class="nv">
<input type="text" name="ctrlDuplicate" id="ctrlDuplicate" value="24" size="5">小时内不重复提醒相同记录
</td>
</tr>

<tr>
<td class="np">邮件附件:</td><td class="nv"><div>
<select id="printTemplate" name="printTemplate">
<option value="null" selected="">--不生成附件--</option>
<%
        List al = QueryEngine.getInstance().doQueryList("select id, name from ad_cxtab where ad_table_id=? and reporttype='P' order by orderno, id", new Object[] { Integer.valueOf(table.getId()) });
        for (int i = 0; i < al.size(); i++) {
          List advTemplate = (List)al.get(i);
          Object id = advTemplate.get(0);
          String name = (String)advTemplate.get(1);
          //System.out.print(name);
 %>
         <option value="cx"<%=id%> >打印模板:<%=name%></option>
        <%}%>
</select> &nbsp; 格式：<select id="printFileType" name="printFileType"><option value="pdf">PDF</option><option value="xls">Excel</option>
<option value="csv">CSV</option><option value="htm">Html</option></select> &nbsp;&nbsp;<a href="javascript:void(0)" onclick="mm.toggleNote('note2')">&nbsp;?&nbsp;</a>
</div>
<div class="note" style="display:none" id="note2">选择打印模板后，将以创建人身份打印并创建为邮件附件</div>
</td>
</tr>

<tr>
<td class="np">优先等级:</td><td class="nv"><select id="priorityRule" name="priorityRule"><option value="3">一般</option><option value="2">紧急</option><option value="1">非常紧急</option></select> <a href="javascript:void(0)" onclick="mm.toggleNote('notep')">&nbsp;?&nbsp;</a><br>
                <div class="note" style="display:none" id="notep">
                	对于邮件和系统通知提醒(弹出式)，紧急和非常紧急将显示惊叹号，对于短信，此设置无效
                </div>
</td>
</tr>

<tr>
<td class="np">&nbsp;</td><td class="nv"><input type="checkbox" id="isactive" name="isactive" value="Y" checked="">可用</td>
</tr>
</tbody>
</table>
</div>
</div>

<div id="tab2" class="ui-tabs-panel" style="min-width: 0px;"><div class="dtable">
<table border="0" cellpadding="5" cellspacing="0" class="mtable">
<tbody>
<tr>
	<td class="np"><a href="javascript:void(0)" onclick="mm.addRecipient('to')">接收人..</a><br><br>
		&nbsp;<a href="javascript:void(0)" onclick="mm.delRecipient('to')">删除选中项</a></td><td class="nv">
    	<ul class="recul ui-tabs-nav" id="recul_to"></ul>
    </td>
</tr>

<tr>
	<td class="np"><a href="javascript:void(0)" onclick="mm.addRecipient('cc')">抄送..</a>&nbsp;
		<a href="javascript:void(0)" onclick="mm.toggleNote('notecc')">&nbsp;?&nbsp;</a><br><br>
		&nbsp;<a href="javascript:void(0)" onclick="mm.delRecipient('cc')">删除选中项</a></td><td class="nv">
		<ul class="recul ui-tabs-nav" id="recul_cc"></ul>
		<div class="note" style="display:none" id="notecc">抄送人是获得接收人信息的复制品，所有抄送人收到的内容都一样。如果信息内容与接收人相关，则每个接收人收到的信息都将复制给所有抄送人</div>
	</td>
</tr>

<tr>
	<td class="np">内容标题:</td><td class="nv">
	  <input type="text" value="" id="subject" size="80" name="subject">
	</td>
</tr>

<tr>
	<td class="np">内容: <br><br><br>
	  <!--<a href="javascript:void(0)" onClick="mm.selectBodyTemplate()">选择模板..</a>-->
	  <br><br>
    <a href="javascript:void(0)" onclick="mm.switchBody()">切换文本/HTML</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="mm.toggleNote('note4')">&nbsp;?&nbsp;</a>
    </td>
    
    <td class="nv">
        <div id="div_body_text" style="">
          <textarea name="body_text" cols="60" rows="12" id="body_text"></textarea>
        </div>
        <div id="div_body_html" style="display: none;">
	       <%
			 FCKeditor fckEditor = new FCKeditor(request, "body_html", "98%", "370px", null, null, "/html/nds/js/fckeditor");
       fckEditor.setValue(jo.optString("body_html", ""));
			 out.print(fckEditor);
          %>
				</div>				
				</div>
				<div class="note" style="display:none" id="note4">邮件和系统通知可以采用HTML/TEXT两种形式展示（HTML优先），短信只读取TEXT设置的内容</div>
    </td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<script>
jQuery('#tabs').tabs();
jQuery(document).ready(function(){mm=new MonitorManager();mm.loadMonitor(<%=monitorId%>,<%=jo%>); });
</script>
	<div id="dlg_saveas" style="display: none">
		<div id="TMPLdlg_saveas_content"
			style="border-width: 1; border-style: solid; padding: 0px; border-color: #cccccc;">
			<table cellpadding="4" cellspacing="0" border="0" width="400"
				height="100">
				<tr>
					<td width="15%" nowrap>另存名称:<font color="red">*</font>:
					</td>
					<td width="85%" align="left"><input type="text"
						id="TMPLsaveasname" value="" size="60" maxlength="255"
						onkeydown="mm.saveNameKeyDown(event)" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td valign="top"><input class="command2_button" type='button'
						id="TMPLbtn_save_as" size="20" value='确定' onclick="mm.saveAsNow()">
						&nbsp; <input class="command2_button" type='button'
						id="TMPLbtn_cancel_dim" size="20" value='取消'
						onclick='art.dialog.list["SaveAsDlg"].close()'> <br> <br></td>
				</tr>
			</table>
		</div>
	</div>
	<div id="loadingZone"
		style="position: absolute; z-index: 1000; top: 0px; right: 0px; display: none;">
		<div id="loadingMsgZone"
			style="padding: 4px; background: red none repeat scroll 0% 0%; position: absolute; top: 0px; right: 0px; width: 80px; -moz-background-clip: border; -moz-background-origin: padding; -moz-background-inline-policy: continuous; color: white; font-family: Arial, Helvetica, sans-serif;">服务器处理中</div>
	</div>
</body>
</html>
