<tr><td>
	<table border="0" cellpadding="0" cellspacing="0"   width="100%" >
	<form action="<portlet:renderURL windowState="<%= renderRequest.getWindowState().toString() %>"></portlet:renderURL>" method="post" name="<portlet:namespace />search_fm">
	<tr>
	<td align="left">
	<iframe id="<%=portlet.getPortletId()%>" src="<%=contextPath%>/html/portlet/nds/news/scroll.jsp?url=<%=portletURLToString%>" height=18 width=<%=scrollWidth-40%> Frameborder=No Border=0 Marginwidth=0 Marginheight=0 Scrolling=No></iframe>
	</td></tr>	
	<tr><td>
	
	<%		
		PairTable pt=(PairTable)dao.getNewsCategories(request);
		pt.put("-1", PortletUtils.getMessage(pageContext, "all","ALL"));
		for(Iterator it= pt.keys();it.hasNext();){
			Object k=it.next();
			int ncKey= Tools.getInt(k,-1);
			Object ncValue= pt.get(k);
   %>
   	
   	<% if(categoryId!=ncKey){%>
   	<a class="gamma" href="<portlet:renderURL  windowState="<%= renderRequest.getWindowState().toString() %>"><portlet:param name="categoryid" value="<%=""+ncKey%>" /></portlet:renderURL>">
   		<%=ncValue%>
   	</a>
   	<%}else{%>
   	<font class="beta"><b><%=ncValue%></b></font><font color="red">*</font>
   	<%}%>
   	 &nbsp; <%= PortletUtils.getMessage(pageContext, "newscategory-seperator","|")%> &nbsp;
   	</font>
    <%
		}
		//search and rss feed
		/**
		* if user is logged , the rss will be fixed to the company of that user
		*/
	%>
		<input name="<portlet:namespace />categoryid" type="hidden" value="<%= categoryId %>">
		<input class="form-text" name="<portlet:namespace />keywords" size="15" type="text" value="<%=(keywords==null?"":keywords)%>">
	</td><td align="right">
		<a class="bg" href="<%="/news/xml?adclientid="+userWeb.getAdClientId()+"&categoryid="+categoryId+"&keywords="+(keywords==null?"":java.net.URLEncoder.encode(keywords,"UTF-8"))%>">
		<img border="0" height="14" hspace="0" src="<%=NDS_PATH%>/images/rss.gif" vspace="0" width="36"></a>
	</td></tr></form>
	</table>
</td></tr>

 
