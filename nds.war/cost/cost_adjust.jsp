<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%= PortletUtils.getMessage(pageContext, "price-adjust-module",null) %>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="enable_context_menu" value="true" />	
	<liferay-util:param name="table_width" value="100%" />
</liferay-util:include>
<iframe id=CalFrame name=CalFrame frameborder=0 src=<%=NDS_PATH%>/common/calendar.jsp style=display:none;position:absolute;z-index:99999></iframe>
<script language="javascript">
document.bgColor="<%=colorScheme.getPortletBg()%>";
</script>
<script language="JavaScript" src="/html/nds/js/formkey.js"></script>
<script type='text/javascript' src='/html/nds/js/dw_scroller.js'></script>
<script language="javascript" src="<%=NDS_PATH%>/js/calendar.js"></script>
<script type='text/javascript' src='/html/nds/js/util.js'></script> 
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<script language="javascript" src="/html/nds/js/application.js"></script>
<script language="javascript" src="/html/nds/js/alerts.js"></script>
<script language="javascript" src="/cost/cost.js"></script>
<script type="text/javascript" src="/html/nds/js/init_object_query_zh_CN.js"></script>
<link type="text/css" rel="stylesheet" href="/cost/link.css">
<table width="954" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="21"><img src="images/table_left_top.gif" width="21" height="20" /></td>
            <td width="915" background="images/table_center_top.gif" height="20"></td>
            <td width="18"><img src="images/table_right_top.gif" width="18" height="20" /></td>
          </tr>
          <tr>
            <td width="21" background="images/table_left_center.gif"></td>
            <td width="915" valign="top" background="images/table_center_center.gif"><table width="799" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center" valign="top"><div class="from_top_text"></div></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
			  <td height="429" valign="top" background="images/var_index_bg.gif"><table width="799" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="30" height="30">&nbsp;</td>
                  <td width="365">&nbsp;</td>
                  <td width="12" rowspan="4">&nbsp;</td>
                  <td width="362">&nbsp;</td>
                  <td width="30" height="30">&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td height="190" valign="top"><table width="320" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><img src="images/title01.gif" width="163" height="30" /></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="td_text"><%= PortletUtils.getMessage(pageContext, "sell-adjust-info",null)%></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="td_text"> 
                      		<input class="cbutton" type="button" value='<%= PortletUtils.getMessage(pageContext, "creat-sell-adjust",null)%>' onclick="javascript:window.location.href='/html/nds/object/object.jsp?table=b_slpriceadj&fixedcolumns=&id=-1'"/>&nbsp;&nbsp;
                      		<input class="cbutton" type="button" value="查看销售价调整单" onclick="javascript:cost._closeWindowOrShowMessage('b_slpriceadj')"/>
  						</td>
                    </tr>
                  </table></td>
                  <td valign="top"><table width="320" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><img src="images/title02.gif" width="179" height="28" /></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="td_text"><%= PortletUtils.getMessage(pageContext, "retail-adjust-info",null)%></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="td_text" >
                      	<br>
                      	<br>
                      		<input class="cbutton" type="button" value='<%= PortletUtils.getMessage(pageContext, "creat-retail-adjust",null)%>' onclick="javascript:window.location.href='/html/nds/object/object.jsp?table=b_rtpadj&fixedcolumns=&id=-1'"/>&nbsp;&nbsp;
                      		<input class="cbutton" type="button" value="查看零售价调整单" onclick="javascript:cost._closeWindowOrShowMessage('b_rtpadj')"/>
  					</td>
                    </tr>
                  </table></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td height="30">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td height="150" valign="top"><table width="320" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><img src="images/title03.gif" width="180" height="28" /></td>
                    </tr>
                    <tr>
                      <td class="td_text"><%= PortletUtils.getMessage(pageContext, "sell-adjust-set",null)%></td>
                    </tr>
                      <tr>
                      <td >&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="td_text">
                      	<input class="cbutton" type="button" value="生成明细" onclick="javascript:cost.createretail();"/>&nbsp;&nbsp;&nbsp;&nbsp;
						<input class="cbutton" type="button" value='更新明细' onclick="javascript:cost.updateretail();"/>&nbsp;&nbsp;&nbsp;&nbsp;
						<input class="cbutton" type="button" value="查看明细" onclick="javascript:cost._closeWindowOrShowMessage('b_salepriceite')"/>
						</td>
                    </tr>
                  </table></td>
                  <td valign="top"><table width="320" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><img src="images/title04.gif" width="139" height="29" /></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td align="center" class="td_text"><a onclick="javascript:window.location.href='/cost/cost_query.jsp'"><img src="images/pic_cx.gif" width="80" height="80" /></a></td>
                    </tr>
                    
                  </table></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td height="30">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td height="30">&nbsp;</td>
                </tr>
              </table></td>
			  </tr>
            </table></td>
            <td width="18" background="images/table_right_center.gif"></td>
          </tr>
          <tr>
            <td><img src="images/table_left_bottom.gif" width="21" height="20" /></td>
            <td background="images/table_center_bottom.gif">&nbsp;</td>
            <td><img src="images/table_right_bottom.gif" width="18" height="20" /></td>
          </tr>
</table>