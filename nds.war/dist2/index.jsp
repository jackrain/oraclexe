<%@ page language="java"  pageEncoding="utf-8"%>
<%@ page import="nds.control.web.UserWebImpl" %>
<%@ page import="nds.control.web.WebUtils" %>
<%@ page import="nds.schema.Table" %>
<%@ page import="nds.schema.TableManager" %>
<%@ page import="nds.schema.TableImpl" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    UserWebImpl userWeb =null;
    try{
        userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));
    }catch(Throwable userWebException){
        System.out.println("########## found userWeb=null##########"+userWebException);
    }
    String idS=request.getParameter("id");
    int id=-1;
    if (idS != null){
        id=Integer.parseInt(idS);
    }
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
    Table t=TableManager.getInstance().getTable("M_V_ALLOT");
    String tableName=t.getName();
    int dist2TableId=t.getId();
     String directory=t.getSecurityDirectory();
    int permission=userWeb.getPermission(directory);
     if((permission&nds.security.Directory.READ)==0){
%>
<script type="text/javascript">
    document.write("<span color='red' algin='center'>您没有权限！</span>")
</script>
<%
            return;
        }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>配货单</title>
    <link rel="Shortcut Icon" href="/html/nds/images/portal.ico" />
    <script language="javascript" src="/html/nds/js/top_css_ext.js"></script>
    <script language="javascript" language="javascript1.5" src="/html/nds/js/ieemu.js"></script>
    <script language="javascript" src="/html/nds/js/cb2.js"></script>
    <script language="javascript" src="/html/nds/js/common.js"></script>
    <script language="javascript" src="/html/nds/js/print.js"></script>
    <script language="javascript" src="/html/nds/js/prototype.js"></script>
    <script language="javascript" src="/html/nds/js/jquery1.2.3/jquery.js"></script>
    <script language="javascript" src="/html/nds/js/jquery1.2.3/hover_intent.js"></script>
    <script language="javascript" src="/html/nds/js/jquery1.2.3/ui.tabs.js"></script>
    <script>
        jQuery.noConflict();
    </script>
    <script language="javascript" src="/html/js/sniffer.js"></script>
    <script language="javascript" src="/html/js/ajax.js"></script>
    <script language="javascript" src="/html/js/util.js"></script>
    <script language="javascript" src="/html/nds/js/objdropmenu.js"></script>
    <script type="text/javascript" src="/html/nds/js/selectableelements.js"></script>
    <script type="text/javascript" src="/html/nds/js/selectabletablerows.js"></script>
    <script language="javascript" src="/html/nds/js/calendar.js"></script>
    <script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
    <script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
    <script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
    <script language="javascript" src="/html/nds/js/application.js"></script>
    <script language="javascript" src="/html/nds/js/alerts.js"></script>
    <script language="javascript" src="/html/nds/js/init_objcontrol_zh_CN.js"></script>
    <script type="text/javascript" src="/html/nds/js/object_query.js"></script>
    <script language="javascript" src="dist2.js"></script>
    <link type="text/css" rel="stylesheet" href="/html/nds/themes/classic/01/css/header_aio_min.css">
    <link typ e="text/css" rel="stylesheet" href="/html/nds/css/nds_header.css">
    <link href="ph.css" rel="stylesheet" type="text/css"/>
    <%
            Date tody=new Date();
            SimpleDateFormat fmt=new SimpleDateFormat("yyyyMMdd");
            String end=fmt.format(tody);
            Long stL=tody.getTime()-24*60*60*1000*10l;
            Date std=new Date(stL);
            String st=fmt.format(std);
     %>
</head>
<% if(id!=-1){ %>
<script language="javascript">
    jQuery(document).ready(function(){dist.reShow();});
</script>
<%}%>
<body class="body-bg">
<iframe id="CalFrame" name="CalFrame" frameborder=0 src=/html/nds/common/calendar.jsp style="display:none;position:absolute; z-index:9999"></iframe>
<div id="ph-btn">
	<div id="ph-from-btn">
        <input type="hidden" id="load_type" value="<%=id==-1?"load":"reload"%>"/>
        <input type="hidden" id="fund_balance" value="<%=id!=-1?id:""%>"/>
        <input type="hidden" id="isChanged" value="false">
        <input type="hidden" id="orderStatus" value="1"/>
        <input type="image" name="imageField4" src="images/ph-btn-xz.gif" onclick="window.location='/dist2/index.jsp?&&fixedcolumns=&id=-1';"/>
        <%if((permission&nds.security.Directory.WRITE)==nds.security.Directory.WRITE){%>
        <input type="image" name="imageField3" src="images/ph-btn-bc.gif" onclick="dist.saveDate('sav');"/>
        <%
            }
            if((permission&nds.security.Directory.SUBMIT)==nds.security.Directory.SUBMIT){
        %>
        <input type="image" name="imageField4" src="images/ph-btn-dj.gif" onclick="dist.saveDate('ord');"/>
        <%}%>
        <input type="image" name="imageField" src="images/ph-btn-zj.gif"  onclick="dist.showObject('fund_balance.jsp',710,250)"/>
        <input type="image" name="imageField2" src="images/btn-k.gif" onclick="dist.exec_dist('style');" />
        <input type="image" name="imageField2" src="images/btn-zd.gif" onclick="dist.exec_dist('all');" />
        <input type="image" name="imageField4" src="images/ph-btn-gb.gif" onclick="window.close();"/>
    </div>
</div>
<div id="ph-container">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td colspan="2" background="images/ph-pic-bg.gif"><div id="ph-serach">
  <div id="orderSearch" class="djh-table">
      <table width="660" border="0" cellspacing="1" cellpadding="0" class="obj" align="center">
    <tr>
      <td width="100" align="right" valign="top" nowrap="nowrap" class="ph-desc"><div class="desc-txt">订单号<font color="red">*</font>：</div></td>
        <td nowrap="" align="left" width="16%" valign="top" class="ph-value">
            <input type="text" value="" id="column_40252" readonly="true" class="ipt-4-2" size="20" maxlength="80" tabindex="1" name="b_so_id__docno"/>
            <input type="hidden" value="" name="B_SO_ID" id="fk_column_40252"/>
            <span onaction="oq.toggle('/html/nds/query/search.jsp?table=b_so&amp;return_type=s&amp;column=40252&amp;accepter_id=column_40252&amp;qdata='+encodeURIComponent(document.getElementById('column_40252').value)+'&amp;queryindex=','column_40252')" id="cbt_40252" class="coolButton"><img height="16" border="0" align="absmiddle" width="16" title="Find" src="/html/nds/images/find.gif"/></span>
            <script>
                createButton(document.getElementById("cbt_40252"));
            </script>
        </td>
      <td class="ph-value" width="100" valign="top" nowrap="nowrap" align="left"><div class="desc-txt">店仓<font color="red">*</font>：</div></td>
        <td class="ph-value" width="160" valign="top" nowrap="nowrap" align="left"><input type='hidden' id='column_26993' name="column_26993" value=''>
            <input name="" readonly type="text" class="ipt-4-2" id='column_26993_fd' value="" >
            <span  class="coolButton" id="column_26993_link" title=popup onaction="dist.getCustomId();"><img id='column_26993_img' width="16" height="16" border="0" align="absmiddle" title="Find" src="images/filterobj.gif"/></span>
            <script type="text/javascript" >createButton(document.getElementById('column_26993_link'));</script>
        </td>
        <td class="ph-desc" valign="top" nowrap="" align="right"><div class="desc-txt">配单日期<font color="red">*</font>：</div></td>
        <td class="ph-value"  valign="top" nowrap="" align="left">
            <input type="text" name="canModify" class="ipt-4-2" name="billdatebeg"  tabIndex="5" maxlength="10" size="20" title="8位日期，如20070823" id="distdate" value="<%=end%>" />
                                <span  class="coolButton" name="canShow">
                                    <a onclick="event.cancelBubble=true;" href="javascript:showCalendar('imageCalendar3',false,'distdate',null,null,true);"><img id="imageCalendar3" width="16" height="18" border="0" align="absmiddle" title="Find" src="images/datenum.gif"/></a>
                                </span>
        </td>
        <td class="ph-value" width="80" valign="top" nowrap="" align="left"><%if(id==-1){%><input type="image" name="imageField5" src="images/btn-search01.gif" onclick="dist.queryObject()" /><%}%>
        </td>
         <td width="100" align="right" valign="top" nowrap="nowrap" class="ph-desc">
            <div class="desc-txt" align="right" style="color:blue;">物流备注*：</div>
        </td>
        <td nowrap="" align="left" valign="top" class="ph-value" colspan="2">
            <input type="text" class="notes" id="notes" name="canModify"/>
        </td>
    </tr>
  </table>
  </div>
<div id="ph-pic">
<div id="ph-pic-img">
             <div id="ph-pic-img-width">
			<div id="ph-pic-img-border"><img src="images/img.jpg" width="90" height="75" /></div>
			<div id="ph-pic-img-txt"></div>
			</div></div>
<div id="ph-pic-left">
			<div id="ph-pic-txt">
			<ul>
			<li>
			<div class="left">可用库存：</div>
			<div class="right" id="totStyleCan"></div>
			</li>
			<li>
			<div class="left">订单余量：</div>
			<div class="right" id="totStyleRem"></div>
			</li>
			<li>
			<div class="left-red">当前已配：</div>
			<div class="right-red" id="totStyleAlready"></div>
			</li>
			</ul>
			</div>
	  </div>
<div id="ph-pic-right">
			<div id="ph-pic-txt">
			<ul>
			<li>
			<div class="left">订单余量：</div>
			<div class="right" id="barcodeRem"></div>
			</li>
			<li>
			<div class="left-red">当前已配：</div>
			<div class="right-red" id="barcodeAlready"></div>
			</li>
			</ul>
			</div>
	  </div>
</div>
</div></td>
</tr>
  <tr>
    <td colspan="2"><div class="ph-height"></div></td>
  </tr>
  <tr>
    <td valign="top" width="1%" align="left">
<div id="ph-from-left">
<div id="ph-from-left-bg">
<div class="left-search">
			  <div><input name="textfield" type="text" class="left-search-input" id="quickSearch"/></div>
		  </div>
			<div id="left-section-height"></div>
<div id="left-section">
              <ul id="styleManu">
              </ul>
		  </div>
</div>
</div></td>
    <td valign="top" width="99%" align="left">
        <div class="ph-from-right">
            <div id="ph-from-right-border">
<div id="ph-from-right-b">
  <div id="ph-from-right-table">
  </div>
  <div class="ph-height"></div>
	  </div>
</div></div></td>
  </tr>
</table>
</div>
<div id="submitImge" style="left:30px;top:80px;z-index:111;position:absolute;display:none;">
    <img src="/html/nds/images/submitted.gif"/>
</div>
</body>
</html>