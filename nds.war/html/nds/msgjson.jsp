<%@ include file="/html/nds/common/init.jsp" %>
<%
ValueHolder holder= (ValueHolder)request.getAttribute(nds.util.WebKeys.VALUE_HOLDER);
%>
<%=((org.json.JSONObject)(holder.get("data"))).get("message")%>