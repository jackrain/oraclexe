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
		String tabHREF = NDS_PATH + "/object/ajaxtab.jsp?table="+ tableId+"&id="+ objectId+"&select_tab="+ rft.getId()+(isInput?"":"&input=false");
		String tabId="tab"+(iRFTPtr-1);
	%> 
		<li><a href="<%=tabHREF%>" title="<%=tabId%>"><span><%=tabName%></span></a></li>
	<%
	}
%>
</ul>
</div>
<%
/**
 Will hide first, then show. 
 After loaded into html, and execute all scripts, will call load()
 	//jQuery('#tabs ul').tabs({ cache:false})
*/
%>
<script>
	
	jQuery('#tabs').tabs({cache:false,collapsible:true})
	//tabsselect
	//.bind('select.ui-tabs', function(e, ui) {
	.bind('tabsselect', function(e, ui) {
		//alert(222);
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
    //.bind('load.ui-tabs', function(e, ui) {
    .bind('tabsload', function(e, ui) {
    	//alert(333);
        if(gc!=null)gc.destroy();
        
		if( $("embed-items")!=null){
			//alert(123);
			GridControl.main();
			gc.setObjectPage("/html/nds/object/object.jsp");
		}
    });
</script>
<%
}//end totalTabs>0
%>
