<%
if((canModify||canDelete||canSubmit)&& isWriteEnabled && hasWritePermission){
	if(object_page_url.indexOf("input=false")>0){
		modifyPageUrl=StringUtils.replace(object_page_url,"input=false","input=true");
	}else
		modifyPageUrl=object_page_url + "&input=true";

	validCommands.add( commandFactory.newButtonInstance("GoModifyPage", 
		PortletUtils.getMessage(pageContext, "object.gomodifypage",null),
		"ptc.doGoModifyPage("+ tableId+","+ objectId+",'"+modifyPageUrl+"')"
		));
}
if(objectId!=-1){
    // get extended buttones
    validCommands.addAll(table.getExtendButtons(objectId, userWeb));
}
validCommands.add( commandFactory.newButtonInstance("CopyTo", 
		PortletUtils.getMessage(pageContext, "object.copyto",null),
		"ptc.doCopyTo("+ tableId+","+ objectId+",'"+java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""))+"')"
		));
validCommands.add( commandFactory.newButtonInstance("Print", 
		PortletUtils.getMessage(pageContext, "object.print",null),
		"ptc.doPrint("+ tableId+","+ objectId+")"
		));		

otherviews= Collections.EMPTY_LIST;
//item table should not show other views
if(manager.getParentTable(table)==null) otherviews=userWeb.constructViews(table,objectId);
if(!otherviews.isEmpty()){
	if(otherviews.size()==1){
 		validCommands.add( commandFactory.newButtonInstance("OtherViews", 
			PortletUtils.getMessage(pageContext, "object.otherviews",null),
			"ptc.doShowObject("+ ((Table) otherviews.get(0)).getId()+","+ objectId+")"
		));	
 	}else{
 		viewIdString="";
 		for(int oi=0;oi<otherviews.size();oi++){
  			viewIdString += ((Table)otherviews.get(oi)).getId()+"_";
  		}
  		validCommands.add( commandFactory.newButtonInstance("OtherViews", 
			PortletUtils.getMessage(pageContext, "object.otherviews",null),
			"ptc.doSelectView("+ viewIdString +","+ objectId+")"
		));	
 	}
}
%>
<div class="linkbtn">
<%@ include file="inc_command.jsp" %>
</div>

