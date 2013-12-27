<%= PortletUtils.getMessage(pageContext, "quick-search",null)%>
<%=QueryUtils.getQuickSearchComboBox("quick_search_column", table.getColumns(EditableGridMetadata.ITEM_COLUMN_MASKS,false,userWeb.getSecurityGrade()),locale)%>
<%= PortletUtils.getMessage(pageContext, "satisfy-condition",null)%>
<input type="text" size="10" maxlength="255" id="quick_search_data" onKeyPress="dwr.util.onReturn(event, doQuickSearch)">
<input class="cbutton" type='button' name='searchItemBtn' value='<%= PortletUtils.getMessage(pageContext, "search",null)%>' onclick="doQuickSearch()" >

