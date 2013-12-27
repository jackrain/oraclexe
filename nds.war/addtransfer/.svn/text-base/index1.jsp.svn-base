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
   	Pattern p=Pattern.compile("\"table\":\"(\\w+)\"");
    Matcher m=p.matcher(destStore);
    if(m.find()){
        destStore=m.group(1);
     }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>配货单</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
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
    <script language="javascript" src="/distribution/distribution.js"></script>
    <link type="text/css" rel="stylesheet" href="/html/nds/themes/classic/01/css/header_aio_min.css"/>
    <link typ e="text/css" rel="stylesheet" href="/html/nds/css/nds_header.css"/>
    <link href="ph.css" rel="stylesheet" type="text/css"/>
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

<body id="boo">
<input type="hidden" id="load_model" value="metrix"/>
<input type="hidden" id="load_type" value="<%=id==-1?"load":"reload"%>"/>
<input type="hidden" id="showStyle" value="list">
<input type="hidden" id="orderStatus" value="1"/>
<input type="hidden" id="isChanged" value="false"/>
<input type="hidden" id="currSty" value=""/>
<iframe id="CalFrame" name="CalFrame" frameborder=0 src=/html/nds/common/calendar.jsp style="display:none;position:absolute; z-index:9999"></iframe>
<div id="ph-btn">
    <div id="ph-from-btn">
        <input type="hidden" id="fund_balance" value="<%=id!=-1?id:""%>"/>
        <input type="image" name="imageField4" src="images/ph-btn-xz.gif" onclick="window.location='/distribution/index.jsp?&&fixedcolumns=&id=-1';"/>
        <%if((permission&nds.security.Directory.WRITE)==nds.security.Directory.WRITE){%>
        <input type="image" name="imageField3" src="images/ph-btn-bc.gif" onclick="dist.saveDate('sav');"/>
        <%
            }
            if((permission&nds.security.Directory.SUBMIT)==nds.security.Directory.SUBMIT){
        %>
        <input type="image" name="imageField4" src="images/ph-btn-dj.gif" onclick="dist.saveDate('ord');"/>
        <%}%>
        <input type="image" name="imageField" src="images/ph-btn-zj.gif"  onclick="dist.showFund();"/>
        <!--<input type="image" name="imageField2" src="images/ph-btn-ph.gif" onclick="var totCan=$('tot-can').innerHTML;dist.showObject('auto_dist.jsp?totcan='+(totCan||0),650,500)" />-->
        <input type="image" name="imageField2" src="images/ph-btn-ph.gif" onclick="dist.autoDist();" />
        <%if(!comp.equals("玖姿")){%>
        <input type="button" id="box-button1" value="定配分析" class="command2_button" width="78" height="20" onclick="dist.analysis();"/>
        <%}%>
	      <input type="image" name="imageField6" src="images/btn-ck.gif" onclick="dist.showObject('mingxi.jsp?m_allot_id='+jQuery('#fund_balance').val(),930,400)"/>
         <input type="button" id="button2" value="刷新" onclick="window.location.reload();"/>
        <input type="image" name="imageField4" src="images/ph-btn-gb.gif" onclick="window.close();"/>

    </div>
</div>
<div id="ph-container">
<table  border="0" cellspacing="0" cellpadding="0">
<tr>
    <td colspan="2" class="ph-td-bg">
        <div id="ph-serach">
            <div id="ph-serach-title">
                <div id="menu">
                    <a href="#" onclick="dist.showDetail();">
                        <span class="left"></span>
                        明细查询 </a>
                    <a href="#" onclick="dist.showDocuments()">
                        <span class="left"></span>
                        单据号查询 </a>
                </div>
            </div>
            <div id="ph-serach-bg">
                <div id="Details" class="obj">
                    <table style="padding-left:10px" border="0" cellspacing="1" cellpadding="0" class="obj" align="left">
                        <tr>
                            <td class="ph-desc" width="75" valign="top" nowrap="" align="right"><div class="desc-txt">订单类型<font color="red">*</font>：</div></td>
                            <td class="ph-value" width="180" valign="top" nowrap="" align="left"><select id="column_26991" class="objsl" tabindex="1" name="doctype">
                                <option value="0">--请选择--</option>
                                <option value="FWD">新货订单</option>
                                <option value="INS">补货订单</option>
                                <option selected="selected" value="ALL">全部</option>
                            </select></td>
                            <!--发货店仓-->
                            <td class="ph-desc" width="75" valign="top" nowrap="" align="right"><div class="desc-txt">发货店仓<font color="red">*</font>：</div></td>
                            <td class="ph-value" width="180" valign="top" nowrap="" align="left"><input name="c_orig_id__name" readonly="" type="text" class="ipt-4-2"  id="column_26992"  value="" />
                                <input type="hidden" id="fk_column_26992" name="C_ORIG_ID" value="">
                  <span  class="coolButton" id="cbt_26992" onaction="oq.toggle('/html/nds/query/search.jsp?table=<%=orgStore%>&return_type=s&column=26992&accepter_id=column_26992&qdata='+encodeURIComponent(document.getElementById('column_26992').value)+'&queryindex='+encodeURIComponent(document.getElementById('queryindex_-1').value),'column_26992')"><img width="16" height="16" border="0" align="absmiddle" title="Find" src="images/find.gif"/></span>
                      <script type="text/javascript" >createButton(document.getElementById("cbt_26992"));</script>
                            </td>
                            <!--收货店仓-->
                            <td class="ph-desc" width="75" valign="top" nowrap="" align="right"><div class="desc-txt">收货店仓<font color="red">*</font>：</div></td>
                            <td class="ph-value" width="180" valign="top" nowrap="" align="left">
                                <input type='hidden' id='column_26993' name="column_26993" value=''>
                                <input name="" readonly type="text" class="ipt-4-2" id='column_26993_fd' value="" >
                                    <span  class="coolButton" id="column_26993_link" title=popup onaction="oq.toggle_m('/html/nds/query/search.jsp?table=<%=destStore%>&return_type=f&accepter_id=column_26993', 'column_26993');"><img id='column_26993_img' width="16" height="16" border="0" align="absmiddle" title="Find" src="images/filterobj.gif"/></span>
                                <script type="text/javascript" >createButton(document.getElementById('column_26993_link'));</script>
                            </td>
                            
                            <td class="ph-desc" width="75" valign="top" nowrap="" align="right"><div class="desc-txt">自动提交销售单<input type="checkbox" name="canModify" id="isautosubsal" checked="checked"><font color="red"></font></div></td>
                            <!--
                            <td class="ph-value" width="80" valign="top" nowrap="" align="left"><input id="switchModel" type="button" value="切换为矩阵模式" style="font-size:14px;" onclick="dist.switchModel();"></td>
                            -->
                            <td></td>
                        </tr>
                        <tr>
                            <!--选择款号-->
                            <td class="ph-desc" valign="top" nowrap="" align="right"><div class="desc-txt">选择款号<font color="red">*</font>：</div></td>
                            <td class="ph-value"  valign="top" nowrap="" align="left">
                                <input type='hidden' id='column_26994' name="product_filter" value=''>
                                <input type="text" class="ipt-4-2"  readonly id='column_26994_fd' value="" />
        <span  class="coolButton" id="column_26994_link" title=popup onaction="oq.toggle_m('/html/nds/query/search.jsp?table='+'m_product'+'&return_type=f&accepter_id=column_26994', 'column_26994');"><img id='column_26994_img' width="16" height="16" border="0" align="absmiddle" title="Find" src="images/filterobj.gif"/></span>
                                <script type="text/javascript" >createButton(document.getElementById('column_26994_link'));</script>
                            </td>
                            <!--起止时间-->
                            <%
                                Date tody=new Date();
                                SimpleDateFormat fmt=new SimpleDateFormat("yyyyMMdd");
                                String end=fmt.format(tody);
                                Long stL=tody.getTime()-24*60*60*1000*10l;
                                Date std=new Date(stL);
                                String st=fmt.format(std);
                            %>
                            <td class="ph-desc" valign="top" nowrap="" align="right"><div class="desc-txt"> 订单时间(起)<font color="red">*</font>：</div></td>
                            <td class="ph-value"  valign="top" nowrap="" align="left">
                                <input type="text" class="ipt-4-2" name="billdatebeg"  tabIndex="5" maxlength="10" size="20" title="8位日期，如20070823" id="column_26995" value="<%=st%>" />
                                <span  class="coolButton">
                                    <a onclick="event.cancelBubble=true;" href="javascript:showCalendar('imageCalendar23',false,'column_26995',null,null,true);"><img id="imageCalendar23" width="16" height="18" border="0" align="absmiddle" title="Find" src="images/datenum.gif"/></a>
                                </span>
                            </td>
                            <td class="ph-desc" valign="top" nowrap="" align="right"><div class="desc-txt">订单时间(止)<font color="red">*</font>：</div></td>
                            <td class="ph-value" valign="top" nowrap="" align="left">
                                <input name="billdateend" type="text"  class="ipt-4-2" maxlength="10" size="20" title="8位日期，如20070823" id="column_269966"  value="<%=end%>"/>
        <span  class="coolButton">
            <a onclick="event.cancelBubble=true;" href="javascript:showCalendar('imageCalendar144',false,'column_269966',null,null,true);"><img id='imageCalendar144' width="16" height="18" border="0" align="absmiddle" title="Find" src="images/datenum.gif"/></a>
        </span>
                            </td>
                            <!--查询条件提交按钮-->
                            <td class="ph-value" width="80" valign="top" nowrap="" align="left"><%if(id==-1){%><input type="image" name="imageField5" src="images/btn-search01.gif" onclick="dist.queryObject()" /><%}%>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="ph-desc"  valign="top" nowrap="nowrap" align="right">
                                <div class="desc-txt" align="center" style="color:blue;">物流备注*：</div>
                            </td>
                            <td class="ph-value" valign="top" align="left" >
                                <input type="text" name="canModify" class="notes" id="notes"/>
                            </td>
                            <td class="ph-desc" valign="top" nowrap="" align="right"><div class="desc-txt">配单日期<font color="red">*</font>：</div></td>
                            <td class="ph-value"  valign="top" nowrap="" align="left">
                                <input type="text" name="canModify" class="ipt-4-2" name="billdatebeg"  tabIndex="5" maxlength="10" size="20" title="8位日期，如20070823" id="distdate" value="<%=end%>" />
                                <span  class="coolButton" name="canShow">
                                    <a onclick="window.event.cancelBubble=true;" href="javascript:showCalendar('imageCalendar3',false,'distdate',null,null,true);"><img id="imageCalendar3" width="16" height="18" border="0" align="absmiddle" title="Find" src="images/datenum.gif"/></a>
                                </span>
                            </td>
                             <td class="ph-desc" valign="top" align="right">
                                <div class="desc-txt" align="center" id="idocnoType" style="color:red;font-size:14px;display:none;">*期货优先</div>
                            </td>
                            <td class="ph-desc" valign="top" align="left">
                                  <div class="desc-txt" align="left" style="color:blue;float:left;font-size:15px;font-weight:bold;vertical-align:bottom;">本单金额：</div><div id="amount1" style="color:black;float:left;font-size:15px;margin-top:3px;"></div>
                            </td>
                        </tr>
                    </table>
                </div>
                <!--单据号查询表格-->
                <div id="Documents" class="djh-table" style="display:none">
                    <table style="padding-left:12px" border="0" cellspacing="1" cellpadding="0" class="obj" align="left">
                        <tr>
                            <td align="right" valign="top" nowrap="nowrap" class="ph-desc"><div class="desc-txt">单据号<font color="red">*</font>：</div></td>
                            <td class="ph-value" width="165" valign="top" nowrap="" align="left">
                                <input name="Input2" type="text" readonly="true" class="ipt-4-2" id="column_41520_fd" value=""/>
                                <input type="hidden" id="column_41520" name="DOCUMENT_ID" value="">
                        <span id="column_41520_link" class="coolButton" title=popup onaction="oq.toggle_m('/html/nds/query/search.jsp?table='+'b_so'+'&return_type=f&column=<%=column%>&accepter_id=column_41520', 'column_41520');"><img id='column_41520_img' width="16" height="16" border="0" align="absmiddle" title="Find" src="images/filterobj.gif"/></span>
                                <script type="text/javascript" >createButton(document.getElementById('column_41520_link'));</script>
                            </td>
                            <td align="right" valign="top" nowrap="nowrap" class="ph-desc"><div class="desc-txt">备&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  注：</div></td>
                            <td class="ph-value" width="185" valign="top" nowrap="" align="left">
                                <input type="text" readonly="true" class="notes" id="commonNotes"/>
                            </td>
                            <td class="ph-desc" width="75" valign="top" nowrap="" align="right"><div class="desc-txt">自动提交销售单<input type="checkbox" name="canModify" id="isautosubsal2" checked="checked"><font color="red"></font></div></td>
                            <td class="ph-value" width="150" valign="top" nowrap="nowrap" align="center">
                                <%if(id==-1){%><input type="image" name="imageField5" src="images/btn-search01.gif" onclick="dist.queryObject('doc')" /><%}%>
                            </td>
                        </tr>
                        <tr>
                            <td class="ph-desc"  valign="top" nowrap="" align="right">
                                <div class="desc-txt" align="center" style="color:blue;">物流备注*：</div>
                            </td>
                            <td class="ph-value" valign="top" align="left">
                                <input type="text" name="canModify" class="notes" id="orderNotes"/>
                            </td>
                            <td class="ph-desc" valign="top" nowrap="" align="right"><div class="desc-txt">配单日期<font color="red">*</font>：</div></td>
                            <td class="ph-value"  valign="top" nowrap="" align="left">
                                <input type="text" name="canModify" class="ipt-4-2" name="billdatebeg"  tabIndex="5" maxlength="10" size="20" title="8位日期，如20070823" id="distdate1" value="<%=end%>" />
                                <span  class="coolButton" name="canShow">
                                    <a onclick="window.event.cancelBubble=true;" href="javascript:showCalendar('imageCalendar31',false,'distdate1',null,null,true);"><img id="imageCalendar31" width="16" height="18" border="0" align="absmiddle" title="Find" src="images/datenum.gif"/></a>
                                </span>
                            </td>
                            <td class="ph-desc" valign="top" width="200">
                                <span name="canShow" id="docnoType" style="color:red;font-weight:bold;font-size:14px;display:none;">*期货优先</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span name="canShow"  style="color:blue;font-size:15px;font-weight:bold;vertical-align:bottom;" >本单金额：</span><span name="canShow" id="amount" style="color:black;font-size:15px;"></span>
                            </td>
                          
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </td>
</tr>
<tr>
    <td colspan="2"><div class="ph-height"></div></td>
</tr>
<tr>
    <td colspan="2" bgcolor="#e6edf1">
    	<div id='ph-piother' style="position:relative;z-index:2;background-color:#e6edf1;width:auto">
        <div id="ph-pic">
        <div id="ph-pic-img">
            <div id="ph-pic-img-width">
                <div id="ph-pic-img-border"><img id="pdt-img" width="90" height="75" /></div>
                <div id="ph-pic-img-txt"></div>
            </div></div>
        <div id="ph-pic-left">
            <div id="ph-pic-txt">
                <ul>
                    <li>
                        <div class="left">可用库存：</div>
                        <div class="right" id="tot-can"></div>
                    </li>
                    <li>
                        <div class="left">订单余量：</div>
                        <div class="right" id="tot-rem"></div>
                    </li>
                    <li>
                        <div class="left-red">当前已配：</div>
                        <div class="right-red" id="tot-ready"></div>
                    </li>
                </ul>
            </div>
        </div>
        <div id="ph-pic-left01">
            <div id="ph-pic-txt">
                <ul>
                    <li>
                        <div class="left">可用库存：</div>
                        <div class="right" id="input-5"></div>
                    </li>
                    <li>
                        <div class="left">订单余量：</div>
                        <div class="right" id="input-4"></div>
                    </li>
                    <li>
                        <div class="left-red">当前已配：</div>
                        <div class="right-red" id="input-2"></div>
                    </li>
                </ul>
            </div>
        </div>
        <div id="ph-pic-right">
            <div id="ph-pic-txt">
                <ul>
                    <li>
                        <div class="left">订单余量：</div>
                        <div class="right" id="rs"></div>
                    </li>
                    <li>
                        <div class="left-red">当前可配：</div>
                        <div class="right-red" id="input-1"></div>
                    </li>
                </ul>
            </div>
        </div>
    </div></div></td>
</tr>
<tr>
    <td colspan="2"><div class="ph-height"></div></td>
</tr>
<tr>
    <td valign="top" align="left">
        <div id="ph-from-left">
            <div id="ph-from-left-bg">
                <div class="left-search">
                    <div><input name="textfield" type="text" class="left-search-input" id="pdt-search"/></div>
                </div>
                <div id="left-section-height"></div>
                <div id="left-section">
                    <ul id="category_manu"></ul>
                </div>
            </div>
        </div></td>
    <td width="97%"  valign="top" align="left">
        <div class="ph-from-right">
            <div id="ph-from-right-border">
                <div id="ph-from-right-b">
                    <div id="ph-from-right-table"></div>
                    <div style="height:17px"></div>
                </div>
            </div>
        </div>
    </td>
</tr>
<tr>
    <td colspan="2">
        <div id="ph-footer">
            <div id="ph-footer-bg"></div>
            <div id="ph-footer-txt">&copy;2008 上海伯俊软件科技有限公司 版权所有 保留所有权 | 商标 | 隐私权声明 </div>
        </div>
    </td>
</tr>
</table>
</div>
<div id="submitImge" style="left:30px;top:80px;z-index:111;position:absolute;display:none;">
    <img src="/html/nds/images/submitted.gif"/>
</div>
<div id="obj-bottom">
    <iframe id="print_iframe" name="print_iframe" width="1" height="1" src="/html/common/null.html"></iframe>
</div>
<input type='hidden' name='queryindex_-1' id='queryindex_-1' value="-1" />
<table><tr><td>
    <script>
        jQuery(document).ready(function(){dcq.createdynlist([])});
        var ti=setInterval("dcq.dynquery();",500);
    </script>
</td></tr>
</table>
	<div id="alert-auto-dist" style="position:absolute;top:0pt;left:0pt;z-index:100;background-color:#024770;height:100%;width:100%;display:none;">
		<div id="auto-bg">
		<div id="auto-menu"><input name="" type="image" src="images/btn-gb.gif" width="21" height="21" onclick="dist.closeAuto();" /></div>
			<div id="auto-main">
				<div id="tabsG">
  				<ul>
    				<li>请选择配货模式</li>
	<li><input id="all-order" name="auto-model" type="radio" value="all-order" can-dist="" checked="checked" onclick='dist.allOrderDist();' />整单</li>
    <li><input id="current-style" name="auto-model" type="radio" value="current-style" can-dist="" onclick='dist.currentStyleDist();' />当前款</li>
  				</ul>
			 </div>
			<div id="auto-border">
				<div id="auto-bl">
					<div id="auto-bl-title">设置可配总量比例</div>
					<div id="auto-bl-txt">
						<table width="440" border="0" align="center" cellpadding="0" cellspacing="0">
  						<tr>
								<td width="100"><div class="ph-left-txt">当前可配总量：</div></td>
								<td width="40"><div id="all-can-dist" class="ph-right-txt"></div></td>
								<td width="100"><div class="ph-left-txt" title="填入小数如：0.66">本次可配比例：</div></td>
								<td width="60"><div class="ph-right-txt"><input type="text" class="ipt-4-1" value="1" id="percentage" onblur="generateCan();"/></div></td>
								<td width="100"><div class="ph-left-txt">本次可配数量：</div></td>
								<td width="40"><div class="ph-right-txt" id="currentCan"></div></td>
							</tr>
						</table>
					</div>
        </div>
				<div class="auto-height"></div>
				<div id="auto-cl">
					<div id="auto-bl-title">选择配货策略</div>
					<div id="auto-cl-txt">
							<table width="440" border="0" align="center" cellpadding="0" cellspacing="0">
							  <tr>
							    <td width="13" align="right"><label>
      <input name="dist_type" onclick="checkType(event);" type="radio" value="spec_number" checked="checked" />
      </label></td>
							    <td width="150"><div class="ph-left-txt">指定配货数量<font color="red">*</font>：</div></td>
							    <td width="297"><div class="ph-right-txt"><input name="" id="specNumber" type="text" class="right-input" /></div></td>
							  </tr>
							  <tr>
							    <td width="13">&nbsp;</td>
							    <td colspan="2"><div class="ph-right-txt">说明：所有商品均按此外指定的数量配货。</div></td>
							  </tr>
							  <tr>
							    <td width="13" align="right"><label>
      <input type="radio" onclick="checkType(event);" name="dist_type" value="not_order" />
      </label></td>
							    <td width="150"><div class="ph-left-txt">按未配量比例配货<font color="red">*</font>：</div></td>
							    <td width="297"><div class="ph-right-txt"><input onblur="checkFloat(event)" disabled="true" id="fowNotOrderPercent" name="" type="text" value="1" class="right-input" /></div></td>
							  </tr>
							  <tr>
							    <td width="13">&nbsp;</td>
							    <td colspan="2"><div class="ph-right-txt">说明：按照未配量此处指定的比例为所有商品配货。</div></td>
							  </tr>
							  <tr>
    							<td width="13" align="right">
    								<label>
      								<input type="radio" value="order" name="dist_type" onclick="checkType(event);">
      							</label>
      						</td>
   							 <td width="160" align=left colspan=2><font color="red">*</font>按订单订货比例配货<font color="red">*</font></td>
  							</tr>
							  <tr>
							    <td width="13">&nbsp;</td>
							    <td colspan="2"><div class="ph-right-txt">说明：按照可配量订货比例为所有商品配货(订货比例指同一商品不同订单订
							货数量占所有订单订货总量的比例)。</div></td>
							  </tr>
							  <tr>
							    <td colspan="3" height="10"></td>
							  </tr>
							  <tr>
							    <td colspan="3"><div class="ph-right-notes">注意：无论选择哪种配货策略，均受到可配货总量的限制，即配货总数量不能大于
							      可配货总量。</div></td>
							  </tr>
							</table>
						</div>
					</div>
					<div class="auto-height"></div>
					<div id="auto-btn"><input name="" type="image" src="images/btn-cd.gif" onclick="dist.exec_dist();" width="34" height="20" />&nbsp;&nbsp;<input name="" type="image" src="images/btn-qx.gif" width="34" height="20" onclick="dist.closeAuto();" /></div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="dist_type" value="specNumber"/>
	<script type="text/javascript">
        function  generateCan(){
            var totCan=parseInt(jQuery("#all-can-dist").html());
            var percentage=jQuery("#percentage").val();
            percentage=isNaN(parseFloat(percentage))?0:parseFloat(percentage);
            if(percentage>1||percentage<0){
                alert("请输入小于1的正小数！");
                jQuery("#percentage").val("1");
                jQuery("#percentage").focus();
            }
            jQuery("#currentCan").html(Math.round(totCan*parseFloat(jQuery("#percentage").val())));
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
        	jQuery("#specNumber,#fowNotOrderPercent,#fowOrderPercent").attr("disabled","true").val("");
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
</body>
</html>
