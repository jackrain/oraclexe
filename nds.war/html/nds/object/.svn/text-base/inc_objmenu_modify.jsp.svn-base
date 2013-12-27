<div id="objdropmenu" class="obj-dock-list-container">
<ul class='obj-dock-list'>
<%
validCommands.clear();
if( objectId == -1){
    if(canAdd){
		validCommands.add( commandFactory.newButtonInstance("Template", 
			PortletUtils.getMessage(pageContext, "object.template",null),
			"oc.doTemplate()", null
		));
    }
}else{
	if(canAdd){
    	validCommands.add( commandFactory.newButtonInstance("NewObject", 
			PortletUtils.getMessage(pageContext, "object.newobject",null),
			"oc.doNewObject()",null
		));
    }	
	validCommands.add( commandFactory.newButtonInstance("CopyTo", 
			PortletUtils.getMessage(pageContext, "object.copyto",null),
			"oc.doCopyTo()",null
			));
	validCommands.add( commandFactory.newButtonInstance("PrintFile", 
			PortletUtils.getMessage(pageContext, "object.printfile",null),
			"oc.doPrintFile()",null
			));	
	validCommands.add( commandFactory.newButtonInstance("PrintSetting", 
			PortletUtils.getMessage(pageContext, "object.printsetting",null),
			"oc.doPrintSetting()",null
			));	

	otherviews= Collections.EMPTY_LIST;
	//item table should not show other views
	if(manager.getParentTable(table)==null) otherviews=userWeb.constructViews(table,objectId);
	if(!otherviews.isEmpty()){
		if(otherviews.size()==1){
	 		validCommands.add( commandFactory.newButtonInstance("OtherViews", 
				PortletUtils.getMessage(pageContext, "object.otherviews",null),
				"oc.doShowObject("+ ((Table) otherviews.get(0)).getId()+")",null
			));	
	 	}else{
	 		viewIdString="";
	 		for(int oi=0;oi<otherviews.size();oi++){
	  			viewIdString += ((Table)otherviews.get(oi)).getId()+"_";
	  		}
	  		validCommands.add( commandFactory.newButtonInstance("OtherViews", 
				PortletUtils.getMessage(pageContext, "object.otherviews",null),
				"oc.doSelectView('"+ viewIdString +"')",null
			));	
	 	}
	}
}

for(int i=0;i< validCommands.size();i++){
	btn=null;
	Object cmd= validCommands.get(i);
	if(cmd instanceof String){
		btn=commandFactory.getButton((String)cmd);
	}else if(cmd instanceof Button){
		btn=(Button)cmd;
	}
	if(btn==null) throw new Error("Internal error: command not found:"+ cmd);
%>
	<%=btn.toMenuItem()%>
<%	
}
// these are list menuitems of webaction
for(int i=0;i<waObjMenuItems.size();i++){ 
%>
	<%=waObjMenuItems.get(i).toHTML(locale,actionEnv)%>
<%
}%>
</ul></div>
		


