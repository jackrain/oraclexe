<%@ page language="java"  pageEncoding="utf-8"%>
<%@ page import="java.util.Date,java.util.regex.Pattern,java.util.regex.Matcher" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="nds.control.web.UserWebImpl" %>
<%@ page import="nds.query.QueryEngine" %>
<%@ page import="nds.control.web.WebUtils" %>
<%@ page import="nds.schema.Table" %>
<%@ page import="nds.schema.TableManager" %>
<%@ page import="nds.schema.TableImpl" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    
    //得到保存自动配货方式和值到COOKIE下次自动引用
    String autoDistType="-1";
    String autoDistValue=null;
    Cookie[] cookies=request.getCookies();
    for(int c=0;c<cookies.length;c++){
    	Cookie cookie=cookies[c];
    	if(cookie.getName().equals("JNBYAUTODISTTYPE")){
    		autoDistType=cookie.getValue();
    	}else if(cookie.getName().equals("JNBYAUTODISTVALUE")){
    		autoDistValue=cookie.getValue();	
    	}
    }
    //end
    
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
    Table t=TableManager.getInstance().getTable("M_ALLOT");
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
    String tableName=t.getName();
    int distributionTableId=t.getId();
    String comp=String.valueOf(QueryEngine.getInstance().doQueryOne("select VALUE from AD_PARAM where NAME='portal.company'"));
    String orgStore=String.valueOf(QueryEngine.getInstance().doQueryOne("SELECT b.ad_table_id from ad_column a,ad_column b where a.name= 'M_ALLOT.C_ORIG_ID' and a.ref_column_id=b.id"));
    String destStore=String.valueOf(QueryEngine.getInstance().doQueryOne("select a.REGEXPRESSION from ad_column a where a.name= 'M_ALLOT.DEST_FILTER'"));
    String column=String.valueOf(QueryEngine.getInstance().doQueryOne("select id from ad_column where name='M_ALLOT.B_SO_FILTER'"));
    String orgStoreColumn=String.valueOf(QueryEngine.getInstance().doQueryOne("select id from ad_column where name='M_ALLOT.C_ORIG_ID'"));
   	Pattern p=Pattern.compile("\"table\":\"(\\w+)\"");
    Matcher m=p.matcher(destStore);
    if(m.find()){
        destStore=m.group(1);
     }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>配货单</title>
<link href="jnby.css" rel="stylesheet" type="text/css" />
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
    <script type="text/javascript" src="/dist-jnby/dist-jnby.js"></script>
    <link type="text/css" rel="stylesheet" href="/html/nds/themes/classic/01/css/header_aio_min.css"/>
    <link typ e="text/css" rel="stylesheet" href="/html/nds/css/nds_header.css"/>       
</head>
<script language="javascript">
	<% if(id!=-1){ %>
    jQuery(document).ready(function(){dist.reShow();});
  <%}%>
    if(!window.document.addEventListener){
        window.document.attachEvent("onkeydown",hand11);
        function hand11()
        {
            if(window.event.keyCode==13){
                return false;
            }
        }
    }
</script>

<body>
<input type="hidden" id="load_model" value="metrix"/>
<input type="hidden" id="load_type" value="<%=id==-1?"load":"reload"%>"/>
<input type="hidden" id="showStyle" value="list">
<input type="hidden" id="orderStatus" value="1"/>
<input type="hidden" id="fund_balance" value="<%=id!=-1?id:""%>"/>
<input type="hidden" id="isChanged" value="false"/>
<input type="hidden" id="autoDistType" value="<%=autoDistType%>">
<input type="hidden" id="autoDistValue" value="<%=autoDistValue%>">
	<iframe id="CalFrame" name="CalFrame" frameborder=0 src=/html/nds/common/calendar.jsp style="display:none;position:absolute; z-index:9999"></iframe>
<div id="jnby-btn">
	<div id="jnby-from-btn">
	  <input type="image" name="imageField" src="images/ph-btn-zj.gif"  onclick="dist.showObject('fund_balance.jsp',710,250)"/>
    <input type="image" name="imageField2" src="images/btn-yp.gif" onclick="dist.showObject('show-item.jsp',730,390)" />
    <input type="image" name="imageField2" src="images/ph-btn-ph.gif" onclick="dist.auto_dist()" />
		<input type="image" name="imageField4" src="images/ph-btn-xz.gif" onclick="window.location='/dist-jnby/index.jsp?&id=-1';"/>
    <!--<input type="image" name="imageField3" src="images/ph-btn-bc.gif" onclick="dist.saveDate('sav')"/>-->
    <input type="image" name="imageField4" src="images/ph-btn-dj.gif" onclick="dist.saveDate('ord')"/>
		<input type="image" name="imageField4" src="images/ph-btn-gb.gif" onclick="window.close();"/>
  </div>
</div>
<div id="jnby-container">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td colspan="2" bordercolor="#f0f0f0">
<div id="jnby-serach-bg">
<div id="queryDetail" class="obj">
			<table width="970" border="0" cellspacing="1" cellpadding="0" class="obj" align="center">
  <tr>
     <td class="jnby-desc" width="80" valign="top" nowrap="" align="right"><div class="desc-txt">订单类型<font color="red">*</font>：</div></td>
     <td class="jnby-value" width="220" valign="top" nowrap="" align="left">
    	<select id="column_26991" class="objsl" tabindex="1" name="doctype">
				<option value="0">--请选择--</option>
				<option value="FWD">期货订单</option>
				<option value="INS">现货订单</option>
				<option selected="selected" value="ALL">全部</option>
			</select>
      <label style="display:none">
      <input id="isprepack" name="canModify" type="checkbox" value="checkbox"/>是否预发</label>
    </td>
    <td class="jnby-desc" width="100" valign="top" nowrap="" align="right"><div class="desc-txt">发货店仓<font color="red">*</font>：</div></td>
    <td class="jnby-value" width="170" valign="top" nowrap="" align="left"><input id="column_26992" name="" type="text" class="ipt-4-2" /><input type="hidden" id="fk_column_26992" name="C_ORIG_ID" value=""><span  class="coolButton" id="cbt_26992" onaction="oq.toggle('/html/nds/query/search.jsp?table=<%=orgStore%>&return_type=s&column=<%=orgStoreColumn %>&accepter_id=column_26992&qdata='+encodeURIComponent(document.getElementById('column_26992').value)+'&queryindex='+encodeURIComponent(document.getElementById('queryindex_-1').value),'column_26992')"><img width="16" height="16" border="0" align="absmiddle" title="Find" src="images/find.gif"/></span>
    <script type="text/javascript" >createButton(document.getElementById("cbt_26992"));</script></td>
    <td class="jnby-desc" width="100" valign="top" nowrap="" align="right"><div class="desc-txt">收货店仓<font color="red">*</font>：</div></td>
    <td class="jnby-value" width="180" valign="top" nowrap="" align="left">
    	<input type='hidden' id='column_26993' name="column_26993" value=''>
      <input name="" readonly type="text" class="ipt-4-2" id='column_26993_fd' value="" >
      <span  class="coolButton" id="column_26993_link" title=popup onaction="oq.toggle_m('/html/nds/query/search.jsp?table=<%=destStore%>&return_type=f&accepter_id=column_26993', 'column_26993');"><img id='column_26993_img' width="16" height="16" border="0" align="absmiddle" title="Find" src="images/filterobj.gif"/></span>
      <script type="text/javascript" >createButton(document.getElementById('column_26993_link'));</script></td>
    <td class="jnby-value" width="120" valign="top" nowrap="" align="left"><img src="images/color-p.gif" width="16" height="16" align="absmiddle" /> 现货订单</td>
  </tr>
  <tr>
    <td class="jnby-desc" width="80" valign="top" nowrap="" align="right"><div class="desc-txt">选择款号<font color="red">*</font>：</div></td>
    <td class="jnby-value" width="220" valign="top" nowrap="" align="left">
    	<input type='hidden' id='column_26994' name="product_filter" value=''>
      <input type="text" class="ipt-4-2"  readonly id='column_26994_fd' value="" />
      <span  class="coolButton" id="column_26994_link" title=popup onaction="oq.toggle_m('/html/nds/query/search.jsp?table=M_ALLOT_PRODUCT&return_type=f&accepter_id=column_26994', 'column_26994');"><img id='column_26994_img' width="16" height="16" border="0" align="absmiddle" title="Find" src="images/filterobj.gif"/></span>
      <script type="text/javascript" >createButton(document.getElementById('column_26994_link'));</script>
   </td>
   <!--起止时间-->
   <%
      Date tody=new Date();
      SimpleDateFormat fmt=new SimpleDateFormat("yyyyMMdd");
      String end=fmt.format(tody);
      Long stL=tody.getTime()-24*60*60*1000*180l;
      Date std=new Date(stL);
      String st=fmt.format(std);
  %>
   <td class="jnby-desc" width="100" valign="top" nowrap="" align="right"><div class="desc-txt"> 订单时间(起)<font color="red">*</font>：</div></td>
   <td class="jnby-value" width="170" valign="top" nowrap="" align="left"><input name="" type="text" class="ipt-4-2" title="8位日期，如20070823" id="column_26995" value="<%=st%>"/><span id="cbt_26992" class="coolButton">
   	<a onclick="event.cancelBubble=true;" href="javascript:showCalendar('imageCalendar23',false,'column_26995',null,null,true);"><img id="imageCalendar23" width="16" height="18" border="0" align="absmiddle" title="Find" src="images/datenum.gif"/></a></span></td>
    <td class="jnby-desc" width="100" valign="top" nowrap="" align="right"><div class="desc-txt">订单时间(止)<font color="red">*</font>：</div></td>
    <td class="jnby-value" width="180" valign="top" nowrap="" align="left"><input name="" type="text" class="ipt-4-2" title="8位日期，如20070823" id="column_269966"  value="<%=end%>" /><span id="cbt_26992" class="coolButton">
    	<a onclick="event.cancelBubble=true;" href="javascript:showCalendar('imageCalendar144',false,'column_269966',null,null,true);">
    	<img id='imageCalendar144' width="16" height="18" border="0" align="absmiddle" title="Find" src="images/datenum.gif"/></a></span>
    </td>
    <td class="jnby-value" width="120" valign="top" nowrap="" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td class="jnby-desc" valign="top" nowrap="" align="right">物流备注<font color="red">*</font>：</td>
    <td width="220" align="left" valign="top" nowrap="" class="jnby-value"><input id="notes" type="text" name="canModify" class="ipt-4-220" /></td>
    <td class="jnby-desc" valign="top" nowrap="" align="right">配单日期<font color="red">*</font>：</td>
    <td class="jnby-value" valign="top" nowrap="" align="left">
    	<input id="distdate" name="canModify" type="text" title="8位日期，如20070823" value="<%=end%>" class="ipt-4-2" />
    		<span  class="coolButton" name="canShow">
           <a onclick="window.event.cancelBubble=true;" href="javascript:showCalendar('imageCalendar3',false,'distdate',null,null,true);"><img id="imageCalendar3" width="16" height="18" border="0" align="absmiddle" title="Find" src="images/datenum.gif"/></a>
       	</span>
    	</td>
    <td class="jnby-desc" valign="top" nowrap="" align="right"><div class="jnby-txt">本单金额：</div></td>
    <td class="jnby-value" valign="top" nowrap="" align="left" width="180" id="amount"></td>
    <td width="120" align="left" valign="top" nowrap="" class="jnby-value"><%if(id==-1){%><input id="query-dist" type="image" name="imageField5" src="images/btn-search01.gif" onclick="dist.queryObject()" /><%}%></td>
  </tr>
</table>
			</div>
</div></td>
</tr>
  <tr>
    <td colspan="2"><div class="jnby-height"></div></td>
  </tr>
<tr>
<td colspan="2" bgcolor="#e6edf1">
			<table width="1120" border="0" cellspacing="1" cellpadding="0" class="obj" align="left">
  <tr>
  	<td class="jnby-desc" width="80" valign="top" nowrap="" align="right"><div id="jnby-serach-title" style="display:none">
<input id="model" name="" type="checkbox" value="" checked="checked" />
店仓模式
          </div></td>
    <td class="jnby-desc" width="80" valign="top" nowrap="" align="right"><div class="desc-txt">可配：</div></td>
    <td class="jnby-value" width="120" valign="top" nowrap="" align="left"><div class="jnby-txt" id="qty-can">0</div></td>
    <td class="jnby-desc" width="80" valign="top" nowrap="" align="right"><div class="desc-txt">追单可配：</div></td>
    <td class="jnby-value" width="120" valign="top" nowrap="" align="left"><div class="jnby-txt" id="qty-consign">0</div></td>
    <td class="jnby-desc" width="90" valign="top" nowrap="" align="right"><div class="desc-txt">当前放量可配：</div></td>
    <td class="jnby-value" width="110" valign="top" nowrap="" align="left"><div class="jnby-txt" id="qty-addnow">0</div></td>
    <td width="120" class="jnby-desc" align="right"><div class="jnby-test">总未配量：</div></td>
    <td width="80" class="jnby-value" align="left"><div id="jnby-tot-qty" class="jnby-txt"></div></td>
    <td width="120" class="jnby-desc" align="right"><div class="jnby-test">总配货量：</div></td>
    <td width="80" class="jnby-value" align="left"><div id="jnby-tot-qty-al" class="jnby-txt"></div></td>
    </tr>
</table>

</td>
</tr>
  <tr>
    <td colspan="2"><div class="jnby-height"></div></td>
  </tr>
  <tr>
<td valign="top" align="center" colspan="2">
<div id="result-scroll">
 <table cellspacing="2" cellpadding="0" border="0" id="scrolltb">
<tbody>
<tr>
<td onaction="dist.start_page();" id="begin_btn" class="coolButtonDisabled"><img height="16" width="16" src="/html/nds/images/begin.gif"></td>
<td onaction="dist.pre_page();" id="prev_btn" class="coolButtonDisabled"><img height="16" width="16" src="/html/nds/images/back.gif"></td>
<td onaction="dist.next_page();" id="next_btn" class="coolButton"><img height="16" width="16" src="/html/nds/images/next.gif"></td>
<td onaction="dist.end_page();" id="end_btn" class="coolButton"><img height="16" width="16" src="/html/nds/images/end.gif"></td>
<td>
<select onchange="dist.change_range()" id="range_select" size="1">
  <option selected="" value="20">20</option>
  <option value="30">30</option>
  <option value="50">50</option>
  <option value="100">100</option>
  <option value="200">200</option>
</select>行/页,
<span id="txtRange">0-0/0</span>
</td>
</tr></tbody></table>
<script>
createButton(document.getElementById("begin_btn"));
createButton(document.getElementById("prev_btn"));
createButton(document.getElementById("next_btn"));
createButton(document.getElementById("end_btn"));
</script>	
       
</div>
<div id="jnby-main">
<div id="jnby-from" style="display:none">	
	<div class="table" >
	<div class="table-head">
	<div class="span-18">序<br />号</div>
<div class="span-15">收货<br />店仓</div>
<div class="span-15">款<br />号</div>
<div class="span-15">品<br />名</div>
<div class="span-12">颜<br />色</div>
<div class="span-12">尺<br />寸</div>
<div class="span-15">单据<br />编号</div>
<div class="span-12">订单<br />量</div>
<div class="span-12">已配<br />量</div>
<div class="span-16">发货仓<br />库存</div>
<div class="span-12">未<br />配</div>
<div class="span-12">配<br />货</div>
<div class="span-12">可<br />配</div>
<div class="span-13">追单<br />可配</div>
<div class="span-14">当前放<br />量可配</div>
<div class="span-13">放<br />量 </div>
<div class="span-13">状<br />态</div>
<div class="span-16">发货<br />日期</div>
</div>
<div id="table-main" class="main_content" style="height: 480px; width: 1016px; visibility: visible; opacity: 1;">

</div>
</div>
</div>

<div id="jnby-from1" >	
<div class="table" >
<div class="table-head">
<div class="span-18">序<br />号</div>
<div class="span-15">款<br />号</div>
<div class="span-15">品<br />名</div>
<div class="span-12">颜<br />色</div>
<div class="span-12">尺<br />寸</div>
<div class="span-15">收货<br />店仓</div>
<div class="span-15">单据<br />编号</div>
<div class="span-12">订单<br />量</div>
<div class="span-12">已配<br />量</div>
<div class="span-16">发货仓<br />库存</div>
<div class="span-12">未<br />配</div>
<div class="span-12">配<br />货</div>
<div class="span-12">可<br />配</div>
<div class="span-13">追单<br />可配</div>
<div class="span-14">当前放<br />量可配</div>
<div class="span-13">放<br />量 </div>
<div class="span-13">状<br />态</div>
<div class="span-16">发货<br />日期</div>
</div>
<div id="table-main1" class="main_content" style="height: 340px; width: 1016px; visibility: visible; opacity: 1;">

</div>
</div>
</div>
</div>
</td>
  </tr>
</table>

</div>
<div id="jnby-footer">
<div id="jnby-footer-bg"></div>
<div id="jnby-footer-txt">&copy;2008 上海伯俊软件科技有限公司 版权所有 保留所有权 | 商标 | 隐私权声明 </div>
</div>
<input type='hidden' name='queryindex_-1' id='queryindex_-1' value="-1" />
<div id="submitImge" style="height:60px;top:0px;z-index:111;position:absolute;right:0px;width:80px;display:none;">
    <img src="/html/nds/images/submitted-small_zh_CN.gif"/>
</div>
<!-- 自动配货 -->
<div id="auto_dist" style="z-index:100;display:none;position:absolute;">
<div id="auto-bg">
<div id="auto-menu">
<div id="auto-menu-right"><input onclick="dist.closeAuto();" type="image" src="images/btn-gb.gif" width="21" height="21" /></div>
<div id="auto-menu-left">自动配货</div>
</div>
<div id="auto-main">
<div id="auto-cl">
<div id="auto-bl-title">选择配货策略</div>
<div id="auto-cl-txt">
<table width="440" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="13" align="right"><label>
      <input id='spec_number' name="dist_type" onclick="checkType(event);" type="radio" value="spec_number" checked="checked" />
      </label></td>
    <td width="135"><div class="jnby-left-txt">指定配货数量：</div></td>
    <td width="312"><div class="jnby-right-txt"><input name="" id="specNumber"  type="text" class="right-input" /></div></td>
    </tr>
  <tr>
    <td width="13">&nbsp;</td>
    <td colspan="2"><div class="jnby-right-txt">说明：所有商品均按此外指定的数量配货。</div></td>
    </tr>
  <tr>
    <td width="13" align="right"><label>
      <input id='not_order' type="radio" onclick="checkType(event);" name="dist_type" value="not_order"/>
      </label></td>
    <td width="135"><div class="jnby-left-txt">按未配量比例配货：</div></td>
    <td width="312"><div class="jnby-right-txt"><input name="" type="text" class="right-input" onblur="checkFloat(event)" disabled="true" value="1" id="fowNotOrderPercent"/></div></td>
    </tr>
  <tr>
    <td width="13">&nbsp;</td>
    <td colspan="2"><div class="jnby-right-txt">说明：按照未配量<font color="red">*</font>此处指定的比例为所有商品配货。</div></td>
    </tr>
  <tr>
    <td width="13" align="right"><label>
      <input id='order' type="radio" value="order" name="dist_type" onclick="checkType(event);"/>
      </label></td>
    <td width="150"><div class="jnby-left-txt"><font color="red">*</font>按订单订货比例配货<font color="red">*</font></div></td>
    <td></td>
    </tr>
  <tr>
    <td width="13">&nbsp;</td>
    <td colspan="2"><div class="jnby-right-txt">说明：按照可配量<font color="red">*</font>订货比例为所有商品配货(订货比例指同一商品不同订单订
货数量占所有订单订货总量的比例)。</div></td>
    </tr>
    <td colspan="3" height="10"></td>
    </tr>
  <tr>
    <td colspan="3"><div class="jnby-right-notes">注意：无论选择哪种配货策略，均受到可配货总量的限制，即配货总数量不能大于可配货总量。</div></td>
    </tr>
</table>
</div>
</div>
<div class="auto-height"></div>
<div id="auto-btn"><input type="image" src="images/btn-cd.gif" width="34" height="20" onclick="dist.exec_dist();"/>&nbsp;&nbsp;<input name="" type="image" src="images/btn-qx.gif" onclick="dist.closeAuto();" width="34" height="20" /></div>
	<input type="hidden" id="dist_type" value='<%=autoDistType.equals("-1")?"specNumber":autoDistType%>'/>
	<script type="text/javascript">
	var disttype='<%=autoDistType%>';
	if(disttype!='-1'){
		if(disttype=="specNumber"){
			jQuery("#spec_number").attr("checked","checked");
			jQuery("#specNumber").val(<%=autoDistValue%>);
		}else if(disttype=="fowNotOrderPercent"){
			jQuery("#not_order").attr("checked","checked");
			jQuery("#fowNotOrderPercent").val(<%=autoDistValue%>);
		}else{
			jQuery("#order").attr("checked","checked");
		}
	}
        function checkFloat(event){
        	var e=Event.element(event);
        	var percent=jQuery(e).val();
        	percent=isNaN(parseFloat(percent))?0:parseFloat(percent);
		      if(percent>1||percent<0){
		          alert("请输入小于1的正小数！");
		          jQuery(e).val("1");
		          jQuery(e).focus();
		      }
		  	}
        function checkType(event){
        	var e=Event.element(event);
        	if(e.value=="spec_number"){
        		jQuery("#specNumber").removeAttr("disabled");
        		jQuery("#dist_type").val("specNumber");
        	}else if(e.value=="not_order"){
        		jQuery("#fowNotOrderPercent").removeAttr("disabled");
        		jQuery("#dist_type").val("fowNotOrderPercent");
        	}else if(e.value=="order"){
        		jQuery("#fowOrderPercent").removeAttr("disabled");
        		jQuery("#dist_type").val("fowOrderPercent");
        	}
        }
    </script>
</div>
</div>
</div>
</body>
</html>