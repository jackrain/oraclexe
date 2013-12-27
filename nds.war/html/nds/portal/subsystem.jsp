<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
   TableManager manager=TableManager.getInstance();
   int subSystemId=Tools.getInt( request.getParameter("id"), -1);
   SubSystem subSystem=(SubSystem)manager.getSubSystem(subSystemId);
   String desc=subSystem.getDescription(locale);
   String func="pc.qrpt";
   String url=subSystem.getPageURL();
   if(url!=null){
%>
<jsp:include page="<%=url%>" flush="true" />
              <%
				}%>

<table><tr><td>
<script type="text/javascript">
 webFXTreeConfig.autoExpandAll=true;
 var tree=pc.createTree("<%=desc%>","/html/nds/portal/subsystem.xml.jsp?id=<%=subSystemId%>", <%=(url==null?"null":"\"javascript:pc.navigate('"+url+"')\"")%>);
</script>    
</td></tr></table>
