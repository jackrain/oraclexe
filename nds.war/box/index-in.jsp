<%@ page language="java"  pageEncoding="utf-8"%>
<%@ page import="nds.control.web.UserWebImpl" %>
<%@ page import="nds.query.QueryEngine" %>
<%@ page import="nds.control.web.WebUtils" %>
<%@ page import="nds.schema.Table" %>
<%@ page import="nds.schema.TableManager" %>
<%@ page import="nds.schema.TableImpl" %>
<%@ page import="java.util.List" %>
<%
    UserWebImpl userWeb =null;
    try{
		userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));
	}catch(Throwable userWebException){
		System.out.println("########## found userWeb=null##########"+userWebException);
	}
    int m_box_id=Integer.parseInt(request.getParameter("id"));
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
    Table t=TableManager.getInstance().getTable("M_V_BOX");
    
    String tableName=t.getName();
    int tableId=t.getId();
    String tableId2=String.valueOf(QueryEngine.getInstance().doQueryOne("select id from AD_TABLE where NAME='M_BOXITEM'"));
    
     //Add by Robin 20110519 装箱单扫描条码及数量可大于原单
    String skuCanBgOrderQty=String.valueOf(QueryEngine.getInstance().doQueryOne("select value from ad_param where name='box.in.skuCanBgOrderQty'"));
    String skuAddRange="0";
    if("true".equals(skuCanBgOrderQty)){
    	skuAddRange=String.valueOf(QueryEngine.getInstance().doQueryOne("select value from ad_param where name='box.in.skuAddRange'"));
    }
    
    boolean  hasWritePermission=userWeb.hasObjectPermission(tableName,m_box_id,nds.security.Directory.WRITE);
    boolean hasReadPermission=userWeb.hasObjectPermission(tableName,m_box_id,nds.security.Directory.READ);
    boolean hasSubmitPermission=userWeb.hasObjectPermission(tableName,m_box_id,nds.security.Directory.SUBMIT);
    String sound=userWeb.getUserOption("ALERT_SOUND","");
    String comp=String.valueOf(QueryEngine.getInstance().doQueryOne("select VALUE from AD_PARAM where NAME='portal.company'"));
    int barcodeCutLength=nds.util.Tools.getInt(QueryEngine.getInstance().doQueryOne("select VALUE from AD_PARAM where NAME='portal.6001'"),0);
    java.util.List newOldBar=QueryEngine.getInstance().doQueryList("select distinct o.no,n.no from M_BOX_PICKUP i, M_PDT_ALIAS_CON c, M_PRODUCT_ALIAS n, M_PRODUCT_ALIAS o where n.ID=c.M_PDA_NEW_ID AND o.ID=c.M_PDA_OLD_ID and i.m_product_id=n.m_product_id and i.m_attributesetinstance_id=n.m_attributesetinstance_id and i.m_box_id="+m_box_id );
    org.json.JSONObject jo=new org.json.JSONObject();
    for(int joi=0;joi<newOldBar.size();joi++){
     	jo.put( (String)((List)newOldBar.get(joi)).get(0),(String)((List)newOldBar.get(joi)).get(1) );
    } 
    java.util.List intsCode=QueryEngine.getInstance().doQueryList("select distinct o.intscode,o.no  from M_BOX_PICKUP i, M_PRODUCT_ALIAS o WHERE  o.ID=i.m_productalias_id  and i.m_box_id="+m_box_id );
    org.json.JSONObject jo2=new org.json.JSONObject();
    for(int jo2i=0;jo2i<intsCode.size();jo2i++){
     	jo2.put( (String)((List)intsCode.get(jo2i)).get(0),(String)((List)intsCode.get(jo2i)).get(1) );
    } 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <% if(!hasReadPermission){ %>
    <script type="text/javascript">alert("您没有查看装箱单的权限！")</script>     
    <% return;}%>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <link href="zh.css" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet" href="/html/nds/themes/classic/01/css/object_aio_min.css">
    <script language="javascript" language="javascript1.5" src="/html/nds/js/ieemu.js"></script>
    <script language="javascript" src="/html/nds/js/prototype.js"></script>
    <script language="javascript" src="/html/nds/js/objdropmenu.js"></script>
    <script language="javascript" src="/html/nds/js/print.js"></script>
    <script language="javascript" src="/html/nds/js/cb2.js"></script>
    <script language="javascript" src="/html/nds/js/jquery1.2.3/jquery.js"></script>
    <script language="javascript" src="/html/nds/js/jquery1.2.3/hover_intent.js"></script>
    <script>
        jQuery.noConflict();
    </script>
    <script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
    <script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
    <script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
    <script language="javascript" src="/html/nds/js/application.js"></script>
    <script language="javascript" src="/html/nds/js/alerts.js"></script>
    <script language="javascript" src="/box/oc.js"></script>
    <script type="text/javascript" src="/flash/FABridge.js"></script>
    <script type="text/javascript" src="/flash/playErrorSound.js"></script>
    <script type="text/javascript" src="/box/ztools.js"></script>
    <script type="text/javascript" src="/box/box.js"></script>
    <title>检货装箱单</title>
</head>
<body class="body-bg">
<script language="javascript">
    jQuery(document).ready(function(){box.boxType="in";box.load()});
    jQuery(document).ready(function(){box.loadBox(<%=jo%>);});
</script>
<%if(!sound.equals("0")){%>
<object width="1" height="1" align="middle" id="playErrorSoundTest" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" style="float:right">
		<embed width="1" height="1" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" 
		allowscriptaccess="always" bgcolor="#ffffff" 
		src="/flash/wavplayer.swf?gui=mini&amp;sound=<%=sound.trim()%>&amp;">
</object>
<input type="hidden" id="sound" value="<%=sound%>"/>
<%}%>
<input id="skuAddRange" type="hidden" value="<%=skuAddRange%>"/>
<input id="m_box_id" type="hidden" value="<%=m_box_id%>"/>
<input id="m_box_table_id" type="hidden" value="<%=tableId%>"/>
<input id="m_boxitem_table_id" type="hidden" value="<%=tableId2%>"/>
<input id="barcode_cut_len" type="hidden" value="<%=barcodeCutLength%>"/>
<div id="zh-container">
    <div id="zh-btn">
        <% if(hasWritePermission){%>
        <input name="" type="image" src="images/btn-bc.gif" width="58" height="20"  onclick="box.toSave();"/>
        <input name="" type="image" src="images/btn-sc.gif" width="78" height="20" onclick="box.del();"/>
        <% }%>
        <%if(!comp.equals("玖姿")){%>
       <%
        	String lilyallprint=String.valueOf(QueryEngine.getInstance().doQueryOne("select id from ad_cxtab where name='打印含汇总箱单(入库装箱单)'"));
        	String singleBoxPrint=String.valueOf(QueryEngine.getInstance().doQueryOne("select id from ad_cxtab where name='单箱打印(入库装箱单)'"));
        	String allBoxPrint=String.valueOf(QueryEngine.getInstance().doQueryOne("select id from ad_cxtab where name='按单套打(入库装箱单)'"));
        %>
        <input type="button" value="打印含汇总箱单" width="91" id="box-button" onclick="box.doSaveSettings('cx<%=lilyallprint%>',<%=tableId%>);"/>
        <input type="button" value="单箱打印" id="box-button1" width="78" height="20" onclick="box.savePrintSettingForSingleBox('cx<%=singleBoxPrint%>',<%=tableId2%>);"/>
        <input name="" type="image" src="images/btn-td.gif" width="78" height="20" onclick="box.doSaveSettings('cx<%=allBoxPrint%>',<%=tableId%>);"/>
        <%}else{%>
        <%
        	String singleBoxPrint=String.valueOf(QueryEngine.getInstance().doQueryOne("select id from ad_cxtab where name='入库装箱单箱打印-款号模式'"));
        	String orderPrint=String.valueOf(QueryEngine.getInstance().doQueryOne("select id from ad_cxtab where name='入库单按单打印-款号模式'"));
        %>        	
        <input name="" type="image" src="images/btn-dy.gif" width="78" height="20" onclick="box.savePrintSettingForSingleBox('cx<%=singleBoxPrint%>',<%=tableId2%>);"/>
        <input type="button" value="按单打印" width="60" id="box-button1" onclick="box.doSaveSettings('cx<%=orderPrint%>',<%=tableId%>);"/>
        <%}%>
        <% if(hasSubmitPermission){%>
        <input name="" type="image" src="images/btn-zx.gif" width="78" height="20" onclick="box.toSave('T');"/>
        <%}%>
        <input name="" type="image" src="images/btn-ck.gif" width="78" height="20" onclick="popup_window('/html/nds/object/object.jsp?table=<%=tableId%>&id=<%=m_box_id%>&fixedcolumns=','_blank')"/>
        <input name="" type="image" src="images/btn-gb.gif" width="58" height="20" onclick="box.closePop()"/>
        <input type="hidden" id="status" value=""/>
        <%if(comp.equals("玖姿")){%><input type="hidden" id="customer" value="jz"><%}%>
    </div>
    <div id="zh-main">
        <table  border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="8" height="395" valign="top"><img src="images/main-left-bg<%if(comp.equals("玖姿")){%>01<%}%>.gif" width="8" height="395" /></td>
                <td  valign="top" background="images/main-center-bg<%if(comp.equals("玖姿")){%>01<%}%>.gif">
                    <div id="zh-table">
                        <table  border="0" cellspacing="1" cellpadding="0" align="center">
                            <tr>
                                <td class="zh-desc" width="50" valign="top" nowrap="" align="right"><div class="desc-txt">单号：</div></td>
                                <td class="zh-value" width="130" valign="top" nowrap="" align="left"><input class="ipt-4-2" readonly="" id="docon" name="" type="text" style="border:0"/></td>
                                <td class="zh-desc" width="70" valign="top" nowrap="" align="right"><div class="desc-txt">单据类型：</div></td>
                                <td class="zh-value" width="130" valign="top" nowrap="" align="left"><input readonly="" class="ipt-4-2" id="tableType" name="" type="text" style="border:0"/></td>
                                <%if(comp.equals("玖姿")){%>
                                <td class="zh-desc" valign="top" nowrap="" align="right" width="80"><div class="desc-txt">备注：</div></td>
                                <td align="left" valign="top" nowrap="" class="zh-value" width="450"><input class="ipt-4-440" id="desc" name="" type="text" /></td>
                            </tr>
                            <tr>
                                <td colspan="6" width="500">&nbsp;</td>
                            </tr>
                            <%}else{%>
                            <td class="zh-desc" width="70" valign="top" nowrap="" align="right"><div class="desc-txt">装箱规则：</div></td>
                            <td class="zh-value" width="130" valign="top" nowrap="" align="left">
                                <select id="boxRule" class="objsl" tabindex="1" name="doctype">
                                    <option value="0">--请选择--</option>
                                    <option selected="true" value="DES">按目的地装箱</option>
                                    <option value="ORD">按单装箱</option>
                                </select>
                            </td>
                            <td class="zh-desc" width="70" valign="top" nowrap="" align="left"><div class="desc-txt">收货地址：</div></td>
                            <td class="zh-value" width="230" valign="top" nowrap="" align="left"><input id="address" readonly="" class="ipt-4-220" name="" type="text" style="border:0" /></td>
                            </tr>
                            <tr>
                                <td class="zh-desc" valign="top" nowrap="" align="right" width="70"><div class="desc-txt">备注：</div></td>
                                <td colspan="5" align="left" valign="top" nowrap="" class="zh-value" width="450"><input class="ipt-4-440" id="desc" name="" type="text" /></td>
                                <td class="zh-desc" valign="top" nowrap="" align="left" width="70">&nbsp;</td>
                                <td class="zh-value" valign="top" nowrap="" align="left" width="230">&nbsp;</td>
                            </tr>
                            <%}%>
                        </table>
                    </div>
                    <div class="zh-height"></div>
                    <div id="zh-table">
                        <div id="zh-from-left">
                            <div id="zh_left_lb" <%if(comp.equals("玖姿")){%>style="display:none;"<%}%>>
                                <div id="zh-left-lb-title" class="zh-left-lb-title">分类标识</div>
                                <div id="zh-lb">
                                    <ul id="destination">
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <%if(comp.equals("玖姿")){%><DIV><%}%>
                        <div id="zh-from-left01">
                            <div  class="zh-left-lb-title">箱号</div>
                            <div id="zh-xh" style="overflow-y:auto;overflow-x:hidden;">
                            </div>
                            <div class="zh-xh-height"><input type="button" value="增加" onclick="box.addBox($('selCategory').value);"  class="cbutton"/><input type ="button" value="删除" onclick="box.delBox($('selCategory').value)"  class="cbutton"/></div>
                        </div>
                        <div class="zh-from-left02">
                            <table width="99%"  border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#8db6d9" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#8db6d9" class="modify_table" style="table-layout:fixed;">
                                <col width="40">
                                <col width="142">
                                <col width="142">
                                <col width="130">
                                <col width="130">
                                <col width="auto">
                                <tr>
                                    <th  bgcolor="#8db6d9" class="table-title-bg"><div class="td-title"></div></th>
                                    <th  bgcolor="#8db6d9" class="table-title-bg"><div class="td-title">款号</div></th>
                                    <th  bgcolor="#8db6d9" class="table-title-bg"><div class="td-title">品名</div></th>
                                    <th  bgcolor="#8db6d9" class="table-title-bg"><div class="td-title">色号</div></th>
                                    <th  bgcolor="#8db6d9" class="table-title-bg"><div class="td-title">尺寸</div></th>
                                    <th  bgcolor="#8db6d9" class="table-title-bg"><div class="td-title">扫描数量</div></th>
                                </tr>
                            </table>
                        </div>
                        <div id ="showContent">
                        </div>
                        <%if(comp.equals("玖姿")){%></div><%}%>
                    </div>
                </td>
                <td width="8" valign="top"><img src="images/main-right-bg.gif" width="8" height="395" /></td>
            </tr>
        </table>
        <input type="hidden" id="isSaved"/>
    </div>
    <div class="zh-height"></div>
    <div id="zh-cz-bg"><input type="hidden" id="isRecoil" value="normal"/>
        <div id="zh-cz-height"><table width="600" border="0" cellspacing="1" cellpadding="0" align="center">
            <tr>
                <td class="zh-desc" width="80" valign="top" nowrap="" align="right">
                    <div class="desc-txt">
                        <select id="model" width="60" tabindex="1" name="doctype" onchange="if($('model').value =='pdt'){box.pdtModel()}else{box.codeModel()}">
                            <option selected="true" value="code">条码模式</option>
                            <option value="pdt">款号模式</option>
                        </select>
                    </div>
                </td>
                <td class="zh-value" width="110" valign="top" nowrap="" align="left"><input id="barcode" class="ipt-4-160" name="" type="text"/></td>
                <td class="zh-desc" width="70" valign="top" nowrap="" align="right"><div class="desc-txt" >数量：</div></td>
                <td class="zh-value" width="50" valign="top" nowrap="" align="left"><input id="pdt_count" width="48" type="text" class="ipt-4-40" value="1" onblur="box.checkIsNum(event)" /></td>
                <td width="100"><nobr><input name="isRecoil" type="radio" value="normal" checked onclick="$('isRecoil').value='normal';"/>扫描&nbsp;<input name="isRecoil" type="radio" value="recoil" onclick="$('isRecoil').value='recoil';" />反冲</nobr></td>
                <td class="zh-desc" width="110" valign="top" nowrap="" align="right"><div class="desc-txt" style="color:red;font-size:16px;font-weight:bold;" >箱合计：</div></td>
                <td class="zh-desc" width="40" valign="top" nowrap="" align="left"><div class="desc-txt" style="text-align:left;font-size:16px;font-weight:bold;" id="currentBox"></div>
                <td class="zh-desc" width="90" valign="top" nowrap="" align="right"><div class="desc-txt" style="color:red;font-size:16px;font-weight:bold;" >总合计：</div></td>
                <td class="zh-desc" width="40" valign="top" nowrap="" align="left"><div class="desc-txt" style="text-align:left;font-size:16px;font-weight:bold;" id="totBox"></div></td>
                <%if("true".equals(skuCanBgOrderQty)){%>
                <td class="zh-desc" width="90" valign="top" nowrap="" align="right"><div class="desc-txt" style="color:yellow;font-size:16px;font-weight:bold;" >总超量：</div></td>
                <td class="zh-desc" width="40" valign="top" nowrap="" align="left"><div class="desc-txt" style="color:red;text-align:left;font-size:16px;font-weight:bold;" id="totAdditional"></div></td>
                <%}%>
                <td><input type="button" class="command2_button" value="最近已扫条码" onclick="box.showCurrentBarcode()"></td>
            </tr>
        </table></div>
    </div>
</div>
<iframe id="print_iframe" name="print_iframe" width="1" height="1" src="/html/common/null.html"></iframe>
<div id="forCode" style="cursor:default;display:none;border: 1px solid rgb(0, 0, 0);background-color:white;width:auto; max-height:300px;z-index:99;overflow-y:auto;" tabindex='0'></div>
<div id="dialouge" class="pop-up-outer" align="center" style="position:absolute;top:18%;left:18%;z-index:101;background-color:#FFFFFF;display:none;opacity:1;WIDTH:650px;;height:auto;">
    <table class="pop-up-header" cellspacing="0" cellpadding="0" border="0">
        <tr><td id="pop-up-title-0" class="pop-up-title" width="99%" align="left"></td>
            <td class="pop-up-close" width="1%">
                <a onclick="cstable.removeMask();" title="Close" href="javascript:void(0)"><img border="0" src="/html/nds/images/close.gif"/></a>
            </td>
        </tr>
    </table>
    <div id="stock_table" style="OVERFLOW: auto;width:100%;width:auto; max-height:300px;text-align:left;">
    </div>
    <div style="float:left;margin-left:8px;margin-top:5px;margin-bottom:5px;">
        <input id="but_J" class="command2_button" type="button" accesskey="J" value="保存(J)" name="createinstances" onclick="cstable.saveData();"/>
        <input id="but_Q" class="command2_button" type="button" accesskey="Q" value="取消(Q)" name="cancel" onclick="cstable.removeMask();"/>
    </div>
</div>
<div id="showBarcode" class="pop-up-outer" align="center" style="position:absolute;top:18%;left:35%;z-index:101;background-color:#FFFFFF;display:none;opacity:1;WIDTH:203px;;height:auto;">
    <table class="pop-up-header" cellspacing="0" cellpadding="0" border="0">
        <tr><td class="pop-up-title" width="99%" align="left"></td>
            <td class="pop-up-close" width="1%">
                <a onclick="box.removeMask();" title="Close" href="javascript:void(0)"><img border="0" src="/html/nds/images/close.gif"/></a>
            </td>
        </tr>
    </table>
    <div id="barcode_table" style="OVERFLOW: auto;width:100%;width:auto; max-height:300px;text-align:center;">
    </div>
</div>
<div id="submitImge" style="height:60px;top:0px;z-index:111;position:absolute;right:0px;width:80px;display:none;">
    <img src="/html/nds/images/submitted-small_zh_CN.gif"/>
</div>
<div id="alert-message" style="position:absolute;top:0pt;left:0pt;z-index:100;background-color:#000000;opacity:0.51;filter:alpha(opacity=41);height:100%;width:100%;display:none;"></div>

<div id="alert-error" style="position:absolute;top:0pt;left:0pt;z-index:111;opacity:0.81;height:100%;width:100%;display:none;background-color:#024770">
 <div height="400px"  width="100%" id="errorMeg" style="color:#FF0000;font-size:16pt;FONT-WEIGHT:bold;margin-top:100px;" align="center" valign="middle">
</div>
 <div width="100%" style="margin-top:20px;"> 
	<table width="100%">
	<tr>
		<td width="50%" style="color:#FF0000;font-size:14pt" align="right" id="pdwarn" value="<%=skuCanBgOrderQty%>">
			请输入确认码<%if("true".equals(skuCanBgOrderQty)){%>(返回输入0，继续输入1)<%}else{%>(默认为0)<%}%>：
		</td>
		<td nowrap="" width="50%" valign="top" align="left" class="zh-value"><input type="text" style="border:1px solid #7F9DB9;color:#333333;padding-top:2px;vertical-align:bottom;width:170px;" id="correctErrorCode"></td>
	</tr>
	</table>
 </div>
</div>

</body>
</html>