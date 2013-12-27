<%
rfts= userWeb.constructTabs(table, objectId);
totalTabs = rfts.size(); // ref-by-tables and the table its self
if(totalTabs>1){ // skip table itself, as in first tab
%>
<div id="tabs">
<ul>
<%
	for (int iRFTPtr = 1; iRFTPtr < rfts.size(); iRFTPtr++) {
		rft= (RefByTable) rfts.get(iRFTPtr);
		String tabName =rft.getDescription(locale);
		String tabHREF = NDS_PATH + "/step/ajaxtab.jsp?table="+ tableId+"&id="+ objectId+"&p_nextstep=-2&select_tab="+ rft.getId()+(isInput?"":"&input=false");
		String tabId="tab"+(iRFTPtr-1);
	%> 
		<li><a href="<%=tabHREF%>" title="<%=tabId%>"><span><%=tabName%></span></a></li>
	<%
	}
%>
</ul>
</div>
<%
if( manager.getColumn(table.getName(), "status")!=null ){
	if(status!=2){%>
		<div class="div_step"><input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "pre-step",null)%>" onclick="step.preStep();">
		<input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>" onclick="step.doSubmit();"></div>
	<%}else{%>
		<div class="div_step"><input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "object.unsubmit",null)%>" onclick="step.doSubmit();">
		<input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "complete",null)%>" onclick="step.closeDialog();"></div>
<%}
}else{%>
	<div class="div_step"><input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "pre-step",null)%>" onclick="step.preStep();">
	<input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "complete",null)%>" onclick="step.closeDialog();"></div>
<%}%>
<%
/**
 Will hide first, then show. 
 After loaded into html, and execute all scripts, will call load()
*/
%>
<script>
	jQuery('#tabs ul').tabs({ cache:false})
	.bind('select.ui-tabs', function(e, ui) {
		if(gc!=null && gc.checkDirty()==true) return false;
        <%
        for (int iRFTPtr = 1; iRFTPtr < rfts.size(); iRFTPtr++) {
        %>	
        	$("tab<%=String.valueOf(iRFTPtr-1)%>").innerHTML="";
        <%
        }
        %>
        inlineObject=null;
        return true;
    })
    .bind('load.ui-tabs', function(e, ui) {
        if(gc!=null)gc.destroy();
		if( $("embed-items")!=null){
			GridControl.main();
			gc.setObjectPage("/html/nds/step/index.jsp");
		}
    });
</script>
<%
}//end totalTabs>0
%>
