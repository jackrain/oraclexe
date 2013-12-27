<%
// more link
if(!"NONE".equals(uiConfig.getMoreStyle())  && !"TITLE".equals(uiConfig.getMoreStyle()) ){
	String moreURL= uiConfig.getMoreURL();
	if("BAR".equals(uiConfig.getMoreStyle()) || nds.util.Validator.isNull(moreURL) ){
		if(startIndex> 1){%>    		
			<a class="btn" href="javascript:ptc.scrollPage('<%=namespace%>','begin_btn')" title="<%= PortletUtils.getMessage(pageContext, "first-page",null)%>">
				&lt;&lt;
			</a>
			<a class="btn" href="javascript:ptc.scrollPage('<%=namespace%>','prev_btn')" title="<%= PortletUtils.getMessage(pageContext, "previous-page",null)%>">
				&lt;
			</a>
		<%}
		if(endIndex<totalCount){%>
			<a class="btn" href="javascript:ptc.scrollPage('<%=namespace%>','next_btn')" title="<%= PortletUtils.getMessage(pageContext, "next-page",null)%>">
				&gt;
			</a>
			<a class="btn" href="javascript:ptc.scrollPage('<%=namespace%>','end_btn')" title="<%= PortletUtils.getMessage(pageContext, "last-page",null)%>">
				&gt;&gt;
			</a>
		<%}
%>		<span><%=startIndex %>-<%=endIndex%>/<%=totalCount%></span>
<%		
	}else{
		String cls="text-more";
		if("TEXT_RIGHT".equals(uiConfig.getMoreStyle())) cls="text-more-right";
	%>
			<div class="<%=cls%>"><a class="action" href="<%=moreURL%>"><%=LanguageUtil.get(pageContext, "text-more")+table.getDescription(locale)%></a></div>
<%				
	}
}// end 	"NONE".equals(uiConfig.getMoreStyle()
%>


