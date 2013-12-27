
<c:if test="<%= isSelectedTab %>">
	<td title="<%= tabName %>" valign="bottom" width="<%= tabPixels %>">
		<table border="0" cellpadding="0" cellspacing="0" width="<%= tabPixels %>">

			<tr>
				<td <%= borderColor %> rowspan="2"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
				<td <%= borderColor %>><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="<%= tabPixels - 2 %>"></td>
				<td <%= borderColor %> rowspan="2"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
			</tr>
			<tr>
				<td class="gamma"><img border="0" height="4" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="<%= tabPixels - 2 %>"></td>
			</tr>

		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="<%= tabPixels %>">
		<tr class="gamma">
			<td <%= borderColor %> rowspan="2" width="1"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
			<td align="center" nowrap width="<%= tabPixels - 2 %>">
				<font class="gamma" size="2">&nbsp;<b>
				<%if (tabHREF!=null) {%>
				<a id="ctrl_<%=layoutCounter%>" class="gamma" href="<%= tabHREF %>"><%= StringUtils.shortenInBytes(tabName, tabNameMaxLength,".") %></a>
				<%}else{%>
				<%= tabName %>
				<%}%>
				</b>&nbsp;</font>
			</td>
			<td <%= borderColor %> rowspan="2" width="1"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
		</tr>
		<tr class="gamma">
			<td><img border="0" height="3" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
		</tr>
		</table>
	</td>
</c:if>

<c:if test="<%= !isSelectedTab %>">
	<td title="<%= tabName %>" valign="bottom" width="<%= tabPixels %>">
		<table border="0" cellpadding="0" cellspacing="0" width="<%= tabPixels %>">

			<tr>
				<td <%= borderColor %> rowspan="2"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
				<td <%= borderColor %>><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="<%= tabPixels - 2 %>"></td>
				<td <%= borderColor %> rowspan="2"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
			</tr>
			<tr>
				<td class="beta"><img border="0" height="4" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="<%= tabPixels - 2 %>"></td>
			</tr>

		</table>

		<table border="0" cellpadding="0" cellspacing="0" width="<%= tabPixels %>">
		<tr class="beta">
			<td <%= borderColor %> rowspan="2" width="1"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
			<td align="center" nowrap width="<%= tabPixels - 2 %>">
				<font class="beta" size="2">&nbsp;<a id="ctrl_<%=layoutCounter%>" class="beta" href="<%= tabHREF %>"><%= StringUtils.shortenInBytes(tabName, tabNameMaxLength,".") %></a>&nbsp;</font>
			</td>
			<td <%= borderColor %> rowspan="2" width="1"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
		</tr>
		<tr class="beta">
			<td><img border="0" height="3" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
		</tr>
		</table>
	</td>
</c:if>

<c:if test="<%= tabSeparationPixels > 0 %>">
	<td width="<%= tabSeparationPixels %>"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="<%= tabSeparationPixels %>"></td>
</c:if>
