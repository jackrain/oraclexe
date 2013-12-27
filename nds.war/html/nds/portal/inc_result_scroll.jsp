<table border="0" cellpadding="0" cellspacing="2" id="scrolltb">
<tr>
<td><input type="checkbox" id="chk_select_all" value="1" onclick="pc.selectAll()"> <%= PortletUtils.getMessage(pageContext, "select-all",null)%></td>
<%/*if(table.isSubTotalEnabled()){ %>
<td><input type="checkbox" id="chk_select_all_fullrange" value='1' onclick="pc.toggleSubTotal()"><%= PortletUtils.getMessage(pageContext, "show-total",null)%></td>
<%}*/%>
<td id="begin_btn" onclick="pc.scrollPage('begin_btn')"><img src="<%=NDS_PATH%>/images/begin.gif" width="16" height="16"></td>
<td id="prev_btn" onclick="pc.scrollPage('prev_btn')"><img src="<%=NDS_PATH%>/images/back.gif" width="16" height="16"></td>
<td id="next_btn" onclick="pc.scrollPage('next_btn')"><img src="<%=NDS_PATH%>/images/next.gif" width="16" height="16"></td>
<td id="end_btn" onclick="pc.scrollPage('end_btn')"><img src="<%=NDS_PATH%>/images/end.gif" width="16" height="16"></td>
<td>
<%= PortletUtils.getMessage(pageContext, "show-page-number",null)%>
<select size="1" id="range_select" onChange="pc.scrollPage('range_select')">
<%
int[] selectRanges= QueryUtils.SELECT_RANGES;
for(int i =0;i<selectRanges.length;i++){
	int t1=selectRanges[i];
%>
  <option value="<%=t1%>" <%=(t1==QueryUtils.DEFAULT_RANGE)?"selected":"" %>><%=t1%></option>
<%
}
%>
</select><%= PortletUtils.getMessage(pageContext, "show-page-number-end",null)%>,
<!--<a href='javascript:pc.analyzeGrid()'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "analyze-grid",null)%></span>]</a>
<a href='javascript:pc.exportGrid()'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "export",null)%></span>]</a>-->
<%
/**
some company does not want to have edit feature here
*/
if(canModify && listEditable){
%>
<a href='javascript:pc.switchView()'>[<span class="link_cn" id="switch-view-txt"><%=(listViewPermissionType==3? PortletUtils.getMessage(pageContext, "read-only-view",null):PortletUtils.getMessage(pageContext, "modify-view",null))%></span>]</a>
<%}%>
<a href='javascript:pc.refreshGrid()'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "refresh",null)%></span>]</a>
<span id="txtRange"></span>
&nbsp;-&nbsp;<%=table.getDescription(locale)%>

</td>
</tr></table>
<script>
	createButton(document.getElementById("begin_btn"));
	createButton(document.getElementById("prev_btn"));
	createButton(document.getElementById("next_btn"));
	createButton(document.getElementById("end_btn"));
</script>	
       
