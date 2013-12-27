<%
result= dao.findRelativeNews(request, newsObject.getKeywords(),11);
if( result!=null && result.getRowCount()>1){// one is myself
%>
<div class="news-relate-link"><%=PortletUtils.getMessage(pageContext, "relative-link",null)%></div>
<table border=0 cellSpacing=0 cellPadding=0 width="90%" border=0 align="center">
<%              		
 while(result.next()){
 	 oid=((java.math.BigDecimal)result.getObject(1)).intValue();
 	 if(oid==objectId) continue;
 	 subject= (String)result.getObject(2);
 	 style= (String) result.getObject(4);
 	 if(Validator.isNull(subject)){
 	 	subject=StringUtils.NBSP;
 	 }else{
 	 	subject=subject ;//StringUtils.shortenInBytes(subject, maxSubjectLength);
 	 }
 	 if(result.getObject(3) !=null){ 
 	 	date= longdf.format((Date)result.getObject(3));
 	 }else{
 	 	date=StringUtils.NBSP;
 	 }
 	 contenturl= (String) result.getObject(5);
 	 clientName=(String)result.getObject(6);
 	 
 	 if(style==null) style="gamma";
%>
<tr><td>
	<font class="gamma" size="2">
	[<%=clientName%>]&nbsp;
				<%if (contenturl==null){%>
				<a class="<%=style%>" href="javascript:opw_<%=renderResponse.getNamespace()%>(<%=oid%>)">
					<%=subject %>
				</a>
				<%}else{%>
				<a class="<%=style%>" href='javascript:popup_window("<%=contenturl%>")'>
					<%=subject %><img border=0 src="<%=NDS_PATH+"/images/outlink.png"%>" class="outlink">
				</a>
				<%}%>
	</font>&nbsp;&nbsp;
	<span class='dateview'><%= date%></span> 
</td></tr>
<%}%>
</table>
<%}//end result.getRowCount()>0
%>
