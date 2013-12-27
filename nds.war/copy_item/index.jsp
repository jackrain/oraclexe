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
    int tableId,orderId;
    try{
        tableId=Integer.parseInt(request.getParameter("tableid"));
        orderId=Integer.parseInt(request.getParameter("id"));
    }catch (NullPointerException e){
        tableId=-1;
        orderId=-1;
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
    Locale loc=userWeb.getLocale();
    Table tb=TableManager.getInstance().getTable(tableId);
    String realTbName=tb.getRealTableName()==null?tb.getName():tb.getRealTableName();
    String cgy=tb.getDescription(loc);
    String docNo=String.valueOf(QueryEngine.getInstance().doQueryOne("select DOCNO from "+realTbName+" where id="+orderId));
    ArrayList<Column> cols=tb.getAllColumns();
    String[] distes=new String[2];
    String[] colnames=new String[2];
    String[] queryStoreSql=new String[2];
    int[] refTableId=new int[2];
    int[] colId=new int[2];
    for(int i=0;i<cols.size();i++){
        Column col= (Column)cols.get(i);
        String colName=col.getName();
        String realTableName=col.getReferenceTable()==null?"":col.getReferenceTable().getRealTableName();
        if(realTableName.equals("C_STORE")){
            if(col.isMaskSet(Column.MASK_CREATE_EDIT)){
                if(distes[0]==null||distes[0].equals("")){
                    colId[0]=col.getId();
                    refTableId[0]=col.getReferenceTable().getId();
                    distes[0]=col.getDescription(loc);
                }else{
                    colId[1]=col.getId();
                    refTableId[1]=col.getReferenceTable().getId();
                    distes[1]=col.getDescription(loc);
                }
                if(colnames[0]==null||colnames[0].equals("")){
                    colnames[0]=colName;
                    queryStoreSql[0]="select a."+colName+",b.name from "+realTbName+" a,c_store b where b.id=a."+colName+" and a.id="+orderId;
                }else{
                    colnames[1]=colName;
                    queryStoreSql[1]="select a."+colName+",b.name from "+realTbName+" a,c_store b where b.id=a."+colName+" and a.id="+orderId;
                }
            }
        }
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="Shortcut Icon" href="/html/nds/images/portal.ico" />
    <script language="javascript" src="/html/nds/js/top_css_ext.js"></script>
    <script language="javascript" language="javascript1.5" src="/html/nds/js/ieemu.js"></script>
    <script language="javascript" src="/html/nds/js/cb2.js"></script>
    <script language="javascript" src="/html/nds/js/xp_progress.js"></script>
    <script language="javascript" src="/html/nds/js/helptip.js"></script>
    <script language="javascript" src="/html/nds/js/common.js"></script>
    <script language="javascript" src="/html/nds/js/print.js"></script>
    <script language="javascript" src="/html/nds/js/prototype.js"></script>
	<!--script language="javascript" src="/html/nds/js/jquery1.2.3/jquery.js"></script-->
	<!--script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-1.7.2.min.js"></script-->
	<script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-1.7.2.js"></script>
	<!--script language="javascript" src="/html/nds/js/jquery1.2.3/hover_intent.js"></script>
	<script language="javascript" src="/html/nds/js/jquery1.3.2/jquery.ui.tabs.js"></script-->
	<script language="javascript" src="/html/nds/js/jquery1.3.2/hover_intent.min.js"></script>
	<!--script language="javascript" src="/html/nds/js/jquery1.2.3/ui.tabs.js"></script-->
<script>
	jQuery.noConflict();
</script>		
    <script language="javascript" src="/html/js/sniffer.js"></script>
    <script language="javascript" src="/html/js/ajax.js"></script>
    <script language="javascript" src="/html/js/util.js"></script>
    <script language="javascript" src="/html/js/portal.js"></script>
    <script language="javascript" src="/html/nds/js/formkey.js"></script>
    <!--script type="text/javascript" src="/html/nds/js/selectableelements.js"></script>
    <script type="text/javascript" src="/html/nds/js/selectabletablerows.js"></script-->
    <script language="javascript" src="/html/nds/js/calendar.js"></script>
    <script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
    <script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
    <script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
    <script language="javascript" src="/html/nds/js/application.js"></script>
    <!--script language="javascript" src="/html/nds/js/alerts.js"></script-->
    <script language="javascript" src="/html/nds/js/dw_scroller.js"></script>
    <script type="text/javascript" src="/html/nds/js/init_object_query_zh_CN.js"></script>
    <script language="javascript" src="/html/nds/js/init_objcontrol_zh_CN.js"></script>
    <script language="javascript" src="/html/nds/js/obj_ext.js"></script>
    <script language="javascript" src="/html/nds/js/gridcontrol.js"></script>
    <script type="text/javascript" src="/html/nds/js/object_query.js"></script>
    <script language="javascript" src="/copy_item/copy_item.js"></script>
    <script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-ui-1.8.21.custom.min.js"></script>
    <script language="javascript" src="/html/nds/js/artDialog4/jquery.artDialog.js?skin=chrome"></script>
		<script language="javascript" src="/html/nds/js/artDialog4/plugins/iframeTools.js"></script>
    <link href="cc.css" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet" href="/html/nds/themes/classic/01/css/objdropmenu.css">
    <link type="text/css" rel="StyleSheet" href="/html/nds/css/cb2.css">
    <link type="text/css" rel="StyleSheet" href="/html/nds/themes/classic/01/css/custom-ext.css" />
    <link type="text/css" rel="stylesheet" href="/html/nds/themes/classic/01/css/ui.tabs.css"/>
    <link type="text/css" rel="stylesheet" href="/html/nds/themes/classic/01/css/portal.css"/>
    <link type="text/css" rel="stylesheet" href="/html/nds/themes/classic/01/css/object.css"/>
    <% if(tableId==-1||orderId==-1||docNo.equals("")){%>
    <script type="text/javascript">
        document.write("tableId 为空或orderId为空！");
    </script>
    <%}%>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <title>设置复制条件</title>

</head>
<body height="670px">
<iframe id="CalFrame" name="CalFrame" frameborder=0 src=/html/nds/common/calendar.jsp style="display:none;position:absolute; z-index:9999"></iframe>
<input type="hidden" id="tableid" value="<%=tableId%>"/>
<input type="hidden" id="orderid" value="<%=orderId%>"/>
<div id="cc-main">
    <div id="cc-title"></div>
    <div id="cc-content">
        <div class="cc-bg">
            <div class="cc-title">单据编号</div>
            <div class="cc-txt">
                <table width="460" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="100"><div class="cc-left-txt">单据编号：</div></td>
                        <td width="130">
                            <div class="cc-right-txt">
                                <input name="Input" type="text" class="ipt-110" value="<%=docNo%>" disabled="true"/>
                            </div>
                        </td>
                        <td width="100"><div class="cc-left-txt">单据类型：</div></td>
                        <td width="130">
                            <div class="cc-right-txt">
                                <input name="Input" type="text" class="ipt-110" value="<%=cgy%>" readonly="true" />
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="cc-height"></div>
                     <%
                        Date tody=new Date();
                        SimpleDateFormat fmt=new SimpleDateFormat("yyyyMMdd");
                        String def=fmt.format(tody);
                      /*  Long stL=tody.getTime()-24*60*60*1000*10l;
                        Date std=new Date(stL);
                        String st=fmt.format(std);*/
                    %>
        <div class="cc-bg">
            <div class="cc-title">单据日期</div>
            <div class="cc-txt">
                <table width="400" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <div class="cc-right-txt"><input type="text" value="<%=def%>" class="ipt-110" title="8位日期，如20090823" id="column_29995"/>
                                <span  class="coolButton">
                                    <a onclick="event.cancelBubble=true;" href="javascript:showCalendar('imageCalendar23',false,'column_29995',null,null,true);"><img id="imageCalendar23" width="16" height="18" border="0" align="absmiddle" title="Find" src="images/datenum.gif"/> </a>
                                </span>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="cc-height"></div>
        <div class="cc-bg">
            <div class="cc-title">店仓条件</div>
            <div class="cc-txt">
                <table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <%if(distes[0]!=null&&!distes[0].equals("")){
                        		List ls=QueryEngine.getInstance().doQueryList(queryStoreSql[0]);
                        		String storeId0=(((List)ls.get(0)).get(0)).toString();
                        		String storeName0=(String)((List)ls.get(0)).get(1);
                        %>
                        <td width="85" style="text-align:right;">
                            <input type="hidden" id="distes0" value="<%=distes[0]%>"/><!--发货店仓--><%=distes[0]%>：
                        </td>
                        <td width="160">
                            <div class="cc-right-txt">
                                <input type="hidden" id="colid0" value="<%=colId[0]%>"/>
                                <input name="Input" type="text" class="ipt-110" id="column_<%=colId[0]%>" readonly="true" value="<%=storeName0%>"/>
                                <input type="hidden" id="fk_column_<%=colId[0]%>" name="C_ORIG_ID" value="<%=storeId0%>">
                                <input id="c_store_name" type="hidden" value="<%=colnames[0]%>"/>
                                <span  class="coolButton" id="cbt_<%=colId[0]%>" onaction="oq.toggle('/html/nds/query/search.jsp?table=<%=refTableId[0]%>&return_type=s&column=<%=colId[0]%>&accepter_id=column_<%=colId[0]%>&qdata='+encodeURIComponent(document.getElementById('column_<%=colId[0]%>').value)+'&queryindex='+encodeURIComponent(document.getElementById('queryindex_-1').value),'column_<%=colId[0]%>')">
                                    <img width="16" height="16" border="0" align="absmiddle" title="Find" src="images/find.gif"/>
                                </span>
                                <script type="text/javascript" >createButton(document.getElementById("cbt_<%=colId[0]%>"));</script>
                            </div>
                        </td>
                        <%}%>
                        <%if(distes[1]!=null&&!distes[1].equals("")){
                        		List ls=QueryEngine.getInstance().doQueryList(queryStoreSql[1]);
                        		String storeId1=(((List)ls.get(0)).get(0)).toString();
                        		String storeName1=(String)((List)ls.get(0)).get(1);
                        %>
                        <td width="85" class="cc-left-txt" style="text-align:right;" align="right">
                            <!--收货店仓--><%=distes[1]%>：
                            <input type="hidden" id="distes1" value="<%=distes[1]%>"/>
                        </td>
                        <td width="160">
                            <div class="cc-right-txt">
                            <input type="hidden" id="colid1" value="<%=colId[1]%>"/>
                            <input id="c_dest_name" type="hidden" value="<%=colnames[1]%>"/>
                            <input name="Input" type="text" class="ipt-110" id="column_<%=colId[1]%>" readonly="true" value="<%=storeName1%>"/>
                            <input type='hidden' id="fk_column_<%=colId[1]%>" name="C_ORIG_ID" value='<%=storeId1%>'>
                            <span  class="coolButton" id="cbt_<%=colId[1]%>" onaction="oq.toggle('/html/nds/query/search.jsp?table=<%=refTableId[1]%>&return_type=s&column=<%=colId[1]%>&accepter_id=column_<%=colId[1]%>&qdata='+encodeURIComponent(document.getElementById('column_<%=colId[1]%>').value)+'&queryindex='+encodeURIComponent(document.getElementById('queryindex_-1').value),'column_<%=colId[1]%>')">
                                <img width="16" height="16" border="0" align="absmiddle" title="Find" src="images/find.gif"/>
                            </span>
                            <script type="text/javascript" >createButton(document.getElementById('cbt_<%=colId[1]%>'));</script>
                            </div>
                        </td>
                        <%}%>
                    </tr>
                </table>
            </div>
        </div>
        <div class="cc-height"></div>
        <div class="cc-bg01">
            <div class="cc-title">复制要求</div>
            <div class="cc-txt">
                <table width="460" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="180"><div class="cc-left-txt">复制单据数量和原单据的比例：</div></td>
                        <td width="80"><div class="cc-right-txt">
                         <select class="ipt-60" id="per">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="20">20</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                            <option value="24">24</option>
                            <option value="25">25</option>
                            <option value="26">26</option>
                            <option value="26">26</option>
                            <option value="27">27</option>
                            <option value="28">28</option>
                            <option value="29">29</option>
                            <option value="30">30</option>
                        </select></div></td>
                        <td width="100"><div class="cc-right-txt">
                            <input type="hidden" id="ctype" value="1"/>
                            <label><input name="radiobutton" type="radio" checked="checked" onclick="$('ctype').value='1'"/>正向复制</label></div></td>
                        <td width="100"><div class="cc-right-txt"><label><input name="radiobutton" type="radio" onclick="$('ctype').value='-1'"/>
                            反向复制</label></div></td>
                    </tr>
                    <tr>
                        <td><div class="cc-left-txt">复制单据价格重新取
                        </div></td>
                        <td><div class="cc-right-txt">
                            <label>
                                <input name="checkbox" id="reprice" type="checkbox" value="Y" checked="checked" />
                            </label></div></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="cc-height"></div>
        <div id="cc-btn"><input name="" type="image" src="images/cc-btn-qd.gif" width="48" height="20" onclick="ci.copy()"/>&nbsp;&nbsp;<input name="" type="image" src="images/cc-btn-qx.gif" width="48" height="20" onclick="ci.closeDialog();" /></div>
    </div>
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
</td></tr></table>
</body>
</html>
