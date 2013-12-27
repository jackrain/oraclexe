<table border="0" cellpadding="4" cellspacing="0" width="95%">

<%
///////Narrow //////////////////////////////////////////////////////////////////////////

		scrollWidth=RES_NARROW;
%>
<%
 result= dao.find(request, 10, 0,-1,null);
 while(result.next()){
 	 oid=((java.math.BigDecimal)result.getObject(1)).intValue();
 	 subject= (String)result.getObject(2);
 	 style= (String) result.getObject(4);
 	 if(Validator.isNull(subject)){
 	 	subject=StringUtils.NBSP;
 	 }else{
 	 	subject=StringUtils.shortenInBytes(subject, maxSubjectLength);
 	 }
 	 if(result.getObject(3) !=null){ 
 	 	date= df.format((java.util.Date)result.getObject(3));
 	 }else{
 	 	date=StringUtils.NBSP;
 	 }
 	 contenturl= (String) result.getObject(5);
 	 if(style==null) style="gamma";
%>
		<tr>
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
			</td>
		</tr>
<%
 }
 
%>
<%@ include file="/html/portlet/nds/news/inc_more.jsp" %>
</table>
