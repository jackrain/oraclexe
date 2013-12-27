<%@ include file="/html/nds/common/init.jsp" %>

<%
	/**
	  Parameters:
	  	sqlresult - ResultSet, contains data
	*/	 	
	ResultSet results=(ResultSet)request.getAttribute("sqlresult");
	if( results==null){
		out.println("Error, not set resultset!");
		return;
	}
	
%>

<table width="98%" border="1" cellspacing="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#999999">

<tr bgcolor="#EBF5FD">
<% for (int ct = 1;ct <= results.getMetaData().getColumnCount();ct++) {%>
<td align="center">
<span><%= results.getMetaData().getColumnLabel(ct) %></span>
</td><%} %>
</tr>
<% 	int nextNum=0;
 	boolean whiteBg=false;
 	String cell;
while (results.next()){ 
	if(nextNum%1==0) whiteBg = (whiteBg==false);
	nextNum ++;
%>
<tr bgcolor='<%=(whiteBg?"#FFFFFF":"#f0f0f0")%>'>
<% for (int ct = 1;ct <= results.getMetaData().getColumnCount();ct++) {
	 cell=results.getString(ct);
%>
<td nowrap height="20">
<%= (nds.util.Validator.isNull(cell)?"&nbsp;":cell)  %>
</td>
<%} %>
</tr>
<% } %>
    </table>
<p><b><%=PortletUtils.getMessage(pageContext, "result-count",null)%>:</b><%=nextNum%>
</p>









 
