<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
   String func="pc.qrpt";
   Configurations conf=(Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS);
   String home_xml=conf.getProperty("home.xml","/html/nds/portal/home.xml.jsp");
%>
<table><tr><td>
<script>
pc.createTree("<%= PortletUtils.getMessage(pageContext, "navitab",null)%>", "<%=home_xml%>", "javascript:pc.navigate('/html/nds/custom/index.jsp')");
pc.navigate('/html/nds/custom/index.jsp');
</script></td></tr></table>
