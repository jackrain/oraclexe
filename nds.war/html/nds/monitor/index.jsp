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
       int id = Tools.getInt(request.getParameter("id"), -1);
       if (id != -1) {
         String mType = (String)QueryEngine.getInstance().doQueryOne("select monitor_type from ad_monitor where id=?", new Object[] { Integer.valueOf(id) });
         if (Validator.isNotNull(mType)) { response.sendRedirect("/html/nds/monitor/" + mType + ".jsp?id=" + id);
           return;
         }
       }
       response.sendRedirect("/html/nds/monitor/new.jsp?table=" + request.getParameter("table"));
%>