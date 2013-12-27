<%=QueryUtils.getQuickSearchComboBox(namespace+searchBoxName+"quick_search_column", table.getIndexedColumns(),locale)%>
<%= PortletUtils.getMessage(pageContext, "satisfy-condition",null)%>
<input type="text" class="form-text"  size="30" maxlength="255" id="<%=namespace+searchBoxName%>quick_search_data" 
	onKeyPress="if (event.keyCode == 13) { ptc.quickSearch('<%=namespace%>','<%=searchBoxName%>'); return false;}">
<input type="button" class="portlet-form-button" value="<%= PortletUtils.getMessage(pageContext, "search",null)%>" 
	onclick="ptc.quickSearch('<%=namespace%>','<%=searchBoxName%>')" >
<input type="button" class="portlet-form-button" value="<%= PortletUtils.getMessage(pageContext, "search-in-result",null)%>" 
	onclick="ptc.quickSearch('<%=namespace%>','<%=searchBoxName%>',true)" >


