<table border="0" cellpadding="0" cellspacing="0" width="95%">
<%
//wide one 
scrollWidth=RES_WIDE -40;
columnsPerRow=2;
recordCount=20;

i=-1;
%>
<%@ include file="/html/portlet/nds/news/inc_scroll.jsp" %>
<tr><td>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<%
 result= dao.find(request, recordCount, startIndex, categoryId,keywords);
 while(result.next()){
 	 i++;
 	 oid=((java.math.BigDecimal)result.getObject(1)).intValue();
 	 subject= (String)result.getObject(2);
 	 style= (String) result.getObject(4);
 	 if(Validator.isNull(subject)){
 	 	subject=StringUtils.NBSP;
 	 }else{
 	 	subject=StringUtils.shortenInBytes(subject, maxSubjectLength);
 	 }
 	 if(result.getObject(3) !=null){ 
 	 	date= df.format((Date)result.getObject(3));
 	 }else{
 	 	date=StringUtils.NBSP;
 	 }
 	 contenturl= (String) result.getObject(5);
 	 if(style==null) style="gamma";
 	 if(i%columnsPerRow==0)out.print("<tr>");
%>
			<td>
				<font class="gamma" size="2">
				<%if (contenturl==null){%>
				<a class="<%=style%>" href="javascript:opw_<%=renderResponse.getNamespace()%>(<%=oid%>)">
					<%=subject %>
				</a>
				<%}else{%>
				<a class="<%=style%>" href='javascript:popup_window("<%=contenturl%>")'>
					<%=subject %><img border=0 src="<%=NDS_PATH+"/images/outlink.png"%>" class="outlink">
				</a>
				<%}%>
				</font>
				&nbsp;&nbsp;
				<span class='dateview'>
				<%= date%>
				</span>	
			</td>
<%
	if(i%columnsPerRow == (columnsPerRow -1))out.print("</tr>");
 }
 if(i%columnsPerRow != (columnsPerRow -1)){
 	for(int j=0;j< i%columnsPerRow -((columnsPerRow -1));j++) out.print("<td>&nbsp;</td>");
 	out.print("</tr>");
 }
%>
</table>
</td></tr>
<%@ include file="/html/portlet/nds/news/inc_more.jsp" %>
</table>
