<%
rfts= userWeb.constructTabs(table, objectId);
totalTabs = rfts.size(); 
if(totalTabs>1){
%>
<div id="tabs">
<ul>
<%
		rft= (RefByTable) rfts.get(p_nextstep);
		String tabName =rft.getDescription(locale);
		String tabHREF = NDS_PATH + "/step/ajaxtab.jsp?table="+ tableId+"&id="+ objectId+"&select_tab="+ rft.getId()+(isInput?"":"&input=false");
		String tabId="tab"+(p_nextstep-1);
	%> 
		<li><a href="<%=tabHREF%>" title="<%=tabId%>"><span><%=tabName%></span></a></li>
</ul>
</div>
<div class="div_step"><input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "pre-step",null)%>" onclick="step.preStep();">
<input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "next-step",null)%>" onclick="step.doSaveLineStep();"></div>
<script>
	jQuery('#tabs ul').tabs({ cache:false})
	.bind('select.ui-tabs', function(e, ui) {
		if(gc!=null && gc.checkDirty()==true) return false;	
        $("tab<%=String.valueOf(p_nextstep-1)%>").innerHTML="";
        inlineObject=null;
        return true;
    })
    .bind('load.ui-tabs', function(e, ui) {
        if(gc!=null)gc.destroy();
		if($("embed-items")!=null){
			GridControl.main();
			gc.setObjectPage("/html/nds/step/index.jsp");
		}
    });
</script>
<%
}//end totalTabs>0
%>
