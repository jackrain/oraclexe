<table border="0" cellpadding="0" cellspacing="2">
<tr>
<td><input type="checkbox" id="chk_select_all" value="1" onclick="gc.selectAll()"> <%= PortletUtils.getMessage(pageContext, "select-all",null)%></td>
<td id="begin_btn" onclick="gc.scrollPage('begin_btn')"><img src="<%=NDS_PATH%>/images/begin.gif" width="16" height="16"></td>
<td id="prev_btn" onclick="gc.scrollPage('prev_btn')"><img src="<%=NDS_PATH%>/images/back.gif" width="16" height="16"></td>
<td id="next_btn" onclick="gc.scrollPage('next_btn')"><img src="<%=NDS_PATH%>/images/next.gif" width="16" height="16"></td>
<td id="end_btn" onclick="gc.scrollPage('end_btn')"><img src="<%=NDS_PATH%>/images/end.gif" width="16" height="16"></td>
<td>
<%= PortletUtils.getMessage(pageContext, "show-page-number",null)%>
<select size="1" id="range_select" onChange="gc.scrollPage('range_select')">
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
<%if(canAdd||canModify){%>
<a href='javascript:gc.importGrid()'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "object.listimport",null)%></span>]</a>
<%}%>
<a href='javascript:gc.exportGrid()'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "export",null)%></span>]</a>
<!--<a href='javascript:gc.analyzeGrid()'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "analyze-grid",null)%></span>]</a>-->
<a href='javascript:gc.refreshGrid()'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "refresh",null)%></span>]</a>
<span id="txtRange"></span>
</td>
<script>
	createButton(document.getElementById("begin_btn"));
	createButton(document.getElementById("prev_btn"));
	createButton(document.getElementById("next_btn"));
	createButton(document.getElementById("end_btn"));
</script>	

</tr></table>
       
