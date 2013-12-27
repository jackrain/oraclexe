<%@ page language="java"  pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="nds.control.util.*" %>
<%@ page import="nds.web.config.*" %>
<%@ page import="nds.schema.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    if(userWeb==null || userWeb.getUserId()==userWeb.GUEST_ID){
        response.sendRedirect("/c/portal/login");
        return;
    }
    if(!userWeb.isActive()){
        session.invalidate();
        com.liferay.util.servlet.SessionErrors.add(request,"USER_NOT_ACTIVE");
        response.sendRedirect("/login.jsp");
        return;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>导出设置</title>
    <link href="dd.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="/html/nds/js/jquery1.2.3/jquery.js"></script>
    <script language="javascript" src="/html/js/ajax.js"></script>
    <script language="javascript" src="/html/nds/js/jquery1.2.3/hover_intent.js"></script>
    <script>
        jQuery.noConflict();
    </script>
    <script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
    <script language="javascript" src="/html/nds/js/prototype.js"></script>
    <script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
    <script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
    <script language="javascript" src="/html/nds/js/application.js"></script>
    <script language="javascript" src="/export/export.js"></script>
    <script language="javascript" src="/html/nds/js/calendar.js"></script>
</head>

<body>
<script type="text/javascript">
    jQuery(document).ready(function(){export.load();});
</script>
<iframe id="CalFrame" name="CalFrame" frameborder=0 src=/html/nds/common/calendar.jsp style="display:none;position:absolute; z-index:9999"></iframe>
<form id="form1" name="form1" method="post" action="">
    <div id="dd-main">
        <div id="dd-title"></div>
        <div id="dd-content">

            <div class="dd-bg">
                <div class="dd-title">数据导出</div>
                <div class="dd-txt">
                    <table width="480" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="100"><div class="dd-left-txt">单据起始时间：</div></td>
                            <td width="140">
                                <div class="dd-right-txt">
                                    <input type="text" class="ipt-110"  title="8位日期，如20090823" id="column_29995"/>
                                    <span  class="coolButton">
                                        <a onclick="event.cancelBubble=true;" href="javascript:showCalendar('imageCalendar1',false,'column_29995',null,null,true);"><img id="imageCalendar1" src="images/datenum.gif" width="16" height="18" align="absmiddle" /></a>
                                    </span>
                                </div>
                            </td>
                            <td width="100"><div class="dd-left-txt">单据结束时间：</div></td>
                            <td width="140">
                                <div class="dd-right-txt">
                                    <input type="text" class="ipt-110" title="8位日期，如20090823" id="column_29997"/>
                                    <span  class="coolButton">
                                        <a onclick="event.cancelBubble=true;" href="javascript:showCalendar('imageCalendar2',false,'column_29997',null,null,true);"><img id="imageCalendar2" src="images/datenum.gif" width="16" height="18" align="absmiddle" /></a>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td><div class="dd-left-txt">
                                <input type="image" name="imageField" src="images/dd-btn-dc.gif" onclick="export.doexport();"/>
                            </div></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="dd-height"></div>
            <div class="dd-border">
                <div class="dd-tab"><span>历史导出</span></div>
                <div id="tableContent">
                </div>
            </div>
        </div>
    </div>
</form>
</body>
</html>
