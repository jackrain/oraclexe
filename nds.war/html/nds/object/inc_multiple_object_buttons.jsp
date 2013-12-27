<%
    /**
    included in inc_multiple_object_modify.jsp
     */
%>
<input class="cbutton" type="button" onclick="gc.openLineInNewWindow(true)" name="itemOpenLine" value="<%=PortletUtils.getMessage(pageContext, "open-in-new-window",null)%>">
<%if(table.isActionEnabled(Table.ADD)){%>	
<input class="cbutton" type="button" onclick="gc.newLine(true)" name="itemNewLine" value="<%=PortletUtils.getMessage(pageContext, "new-line",null)%>">
<%}%>
<%if(table.isActionEnabled(Table.DELETE)){%>
<input class="cbutton" type="button" onclick="gc.deleteSelected()" name="itemDeleteLine" value="<%=PortletUtils.getMessage(pageContext, "object.deleteline",null)%>">
<%}%>


