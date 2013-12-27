<!--iframe id=CalFrame name=CalFrame frameborder=0 src=<%=NDS_PATH%>/common/calendar.jsp style=display:none;position:absolute;z-index:99999></iframe-->
<div id=ProgressWnd style="position: absolute; left:300px; top:2px;z-index: 100;padding:2px;display:block;">
	<script>
		var progressBar = createBar(150, 14, "#FFFFFF", 1, "#000000", "<%=colorScheme.getPortletTitleBg()%>", 150, 10, 3, "");
		progressBar.togglePause();
		progressBar.hideBar();
	</script>
</div>						
<div id="timeoutBox">
	<div id="timeout-txt"><blink><%= PortletUtils.getMessage(pageContext, "time-out-warning",null)%></blink></div>
	<div id="timeout-btn"><input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "time-out-refresh",null)%>" onclick="pc.timeoutRefresh()">&nbsp;
<input class="cbutton"  type="button" value="<%=PortletUtils.getMessage(pageContext, "time-out-wait",null)%>" onclick="pc.timeoutWait()"></div>
</div>
<%if(ssId!=-1){%>
<div id="objmenu" class="obj-dock interactive-mode">
	<!--%@ include file="inc_ssmenu.jsp" %-->
	</div>
<%}%>