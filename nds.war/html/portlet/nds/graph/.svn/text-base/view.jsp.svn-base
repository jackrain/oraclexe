<%@ include file="/html/portlet/nds/init.jsp" %>
<%
try{
Portlet portlet = PortletManagerUtil.getPortletById(company.getCompanyId(), portletConfig.getPortletName());
String portletName=portletConfig.getPortletName();
String reportName= layoutId+"."+portletName;
Properties props= userWeb.getPreferenceValues(reportName,true);
boolean isShowBorders=("1".equals(props.getProperty("show_borders", "1")));
String graphUpdateDate=null;
boolean graphCacheExists=false;
String boxTitle =props.getProperty("title", portletConfig.getResourceBundle(locale).getString(WebKeys.JAVAX_PORTLET_TITLE));
String title=props.getProperty("title");
String curTime=""+System.currentTimeMillis();
%>
<a name="p_<%= portletConfig.getPortletName() %>"></a>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr id="p_p_id_<%= portletConfig.getPortletName() %>">
	<td align="center">
		<c:if test="<%= isShowBorders %>">
			<%@ include file="/html/portlet/nds/graph/view_page.jsp" %>
		</c:if>
		<c:if test="<%= !isShowBorders %>">
			<table border="0" cellpadding="0" cellspacing="0">
			<c:if test="<%= nds.util.Validator.isNotNull(title)%>">	
			<tr><td>
				<table border="0" cellpadding="2" cellspacing="0">
				<tr>
					<td nowrap><font class="beta" size="2"><b>&nbsp;<%= title %>&nbsp;</b></font></td>
				</tr>
				</table>
			</td></tr>		
			</c:if>
			<tr><td>
			<%@ include file="/html/portlet/nds/graph/view_page_content.jsp" %>
			</td></tr>
			</table>
		</c:if>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td align="right"><font class="bg" size="1">
		<c:if test="<%= graphCacheExists %>">
			<span STYLE='COLOR: <%=colorScheme.getPortletTitleBg()%>;'><%=PortletUtils.getMessage(pageContext, "last-modified",null)%> &nbsp;<%= graphUpdateDate%></span>&nbsp;
			&nbsp;<a class="bg" href="<portlet:actionURL><portlet:param name="t" value="<%=curTime%>" /><portlet:param name="struts_action" value="/ndsgraph/refresh" /></portlet:actionURL>"><%=PortletUtils.getMessage(pageContext, "refresh",null)%></a>
			&nbsp;<a class="bg" href="javascript:popup_window('/html/nds/olap/olap.jsp?id=<%=props.getProperty("query")%>')"><%=PortletUtils.getMessage(pageContext, "analysis",null)%></a>&nbsp;
		</c:if>
		[<a class="bg" href="<portlet:actionURL><portlet:param name="struts_action" value="/ndsgraph/setup" /></portlet:actionURL>" styleClass="bg"><bean:message key="setup" /></a>]
		</font></td></tr></table>
		<br>
	</td>
</tr>
</table>
<%}catch(Exception ext){
	ext.printStackTrace();
	out.print("Error:"+ext.getMessage());
}%>



