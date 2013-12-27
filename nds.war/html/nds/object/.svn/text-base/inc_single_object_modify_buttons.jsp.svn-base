<%
validCommands.clear();
if( objectId == -1){
    if(canAdd){
 		validCommands.add( commandFactory.newButtonInstance("Create", 
			PortletUtils.getMessage(pageContext, "object.create",null),
			"oc.doCreate()",null,"/html/nds/images/tb_new.gif"
		));
    }
}else{
	if(canModify){
		validCommands.add( commandFactory.newButtonInstance("Modify", 
			PortletUtils.getMessage(pageContext, "object.modify",null),
			"oc.doModify()",null,"/html/nds/images/tb_modify.gif"
		));
	}
	if(canDelete){
		validCommands.add( commandFactory.newButtonInstance("Delete", 
			PortletUtils.getMessage(pageContext, "object.delete",null),
			"oc.doDelete()",null,"/html/nds/images/tb_delete.gif"
		));
	}
	if(canVoid){
		validCommands.add( commandFactory.newButtonInstance("Void", 
			PortletUtils.getMessage(pageContext, "object.void",null),
			"oc.doVoid()",null,"/html/nds/images/tb_void.gif"
		));
	}
	if(canSubmit){
		boolean shouldWarn=Tools.getYesNo(userWeb.getUserOption("WARN_ON_SUBMIT","Y"),true);
		validCommands.add( commandFactory.newButtonInstance("Submit", 
			PortletUtils.getMessage(pageContext, "object.submit",null),
			"oc.doSubmit("+ canModify +","+shouldWarn+")",null,"/html/nds/images/tb_submit.gif"
		));
		validCommands.add( commandFactory.newButtonInstance("SubmitPrint", 
			PortletUtils.getMessage(pageContext, "object.submitprint",null),
			"oc.doSubmitPrint("+ canModify +","+shouldWarn+")",null
		));
	}
	validCommands.addAll(table.getExtendButtons(objectId, userWeb));
	
	validCommands.add( commandFactory.newButtonInstance("Print", 
			PortletUtils.getMessage(pageContext, "object.print",null),
			"oc.doPrint()",null,"/html/nds/images/tb_print.gif"
			));	
	validCommands.add( commandFactory.newButtonInstance("Refresh", 
			PortletUtils.getMessage(pageContext, "object.refresh",null),
			"oc.doRefresh()",null,"/html/nds/images/tb_refresh.gif"
			));	
}
%>
<%@ include file="inc_command.jsp" %>
<%
// these are list buttons of webaction
for(int wasi=0;wasi<waObjButtons.size();wasi++){
	out.print(waObjButtons.get(wasi).toHREF(locale,actionEnv)); 
}
%>


