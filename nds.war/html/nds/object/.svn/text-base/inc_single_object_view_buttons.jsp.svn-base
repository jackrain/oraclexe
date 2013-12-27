<%
validCommands.clear();
if((canModify||canDelete||canSubmit)&& isWriteEnabled && hasWritePermission){
	if(object_page_url.indexOf("input=false")>0){
		modifyPageUrl=StringUtils.replace(object_page_url,"input=false","input=true");
	}else
		modifyPageUrl=object_page_url + "&input=true";

	validCommands.add( commandFactory.newButtonInstance("GoModifyPage", 
		PortletUtils.getMessage(pageContext, "object.gomodifypage",null),
		"oc.doGoModifyPage("+ tableId+","+ objectId+",'"+modifyPageUrl+"')"
		));
}
if(canSubmit){
	boolean shouldWarn=Tools.getYesNo(userWeb.getUserOption("WARN_ON_SUBMIT","Y"),true);
	validCommands.add( commandFactory.newButtonInstance("Submit", 
		PortletUtils.getMessage(pageContext, "object.submit",null),
		"oc.doSubmit("+ canModify +","+shouldWarn+")",null
	));
	validCommands.add( commandFactory.newButtonInstance("SubmitPrint", 
		PortletUtils.getMessage(pageContext, "object.submitprint",null),
		"oc.doSubmitPrint("+ canModify +","+shouldWarn+")",null
	));
	
}
if(status==3){
	validCommands.add( commandFactory.newButtonInstance("GoAuditPage", 
		PortletUtils.getMessage(pageContext, "object.goauditpage",null),
		"oc.doGoAuditPage()","G"
	));
}
//unsubmit support
if( table.isActionEnabled(Table.AUDIT) && table.isActionEnabled(Table.SUBMIT) && status==2){
	//
	if( (perm & 9 )==9){ 
	
		boolean shouldWarn=Tools.getYesNo(userWeb.getUserOption("WARN_ON_SUBMIT","Y"),true);
		validCommands.add( commandFactory.newButtonInstance("Unsubmit", 
			PortletUtils.getMessage(pageContext, "object.unsubmit",null),
			"oc.doUnsubmit("+shouldWarn+")",null
		));
	}
}
if(canUnvoid){
		validCommands.add( commandFactory.newButtonInstance("Unvoid", 
			PortletUtils.getMessage(pageContext, "object.unvoid",null),
			"oc.doUnvoid()",null
		));
		if(canDelete){
			validCommands.add( commandFactory.newButtonInstance("Delete", 
			PortletUtils.getMessage(pageContext, "object.delete",null),
			"oc.doDelete()",null,"/html/nds/images/tb_delete.gif"
			));
		}
}
if(objectId!=-1){
    // get extended buttones
    validCommands.addAll(table.getExtendButtons(objectId, userWeb));
}
validCommands.add( commandFactory.newButtonInstance("Print", 
		PortletUtils.getMessage(pageContext, "object.print",null),
		"oc.doPrint("+ tableId+","+ objectId+")",null,"/html/nds/images/tb_print.gif"
		));		
validCommands.add( commandFactory.newButtonInstance("Refresh", 
			PortletUtils.getMessage(pageContext, "object.refresh",null),
			"oc.doRefresh()",null,"/html/nds/images/tb_refresh.gif"
			));	

%>
<%@ include file="inc_command.jsp" %>
<%
// these are list buttons of webaction
for(int wasi=0;wasi<waObjButtons.size();wasi++){
	out.print(waObjButtons.get(wasi).toHREF(locale,actionEnv)); 
}
%>
