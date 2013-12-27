<%@ include file="/html/nds/common/init.jsp" %>
<%
ValueHolder holder= (ValueHolder)request.getAttribute(nds.util.WebKeys.VALUE_HOLDER);
String msg=((org.json.JSONObject)(holder.get("data"))).optString("url");
if(msg!=null){
%>
<script language="javascript">
window.location.href="<%=msg%>";
</script>
<%}%>
