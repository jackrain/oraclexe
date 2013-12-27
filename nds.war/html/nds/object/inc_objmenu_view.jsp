<div id="objdropmenu" class='obj-dock interactive-mode'><div class='table-buttons btn-more'>
<input type="button" value="<%=PortletUtils.getMessage(pageContext, "more",null)%>">
</div>
<ul class='obj-dock-list'>
<%
validCommands.clear();

validCommands.add( commandFactory.newButtonInstance("CopyTo", 
		PortletUtils.getMessage(pageContext, "object.copyto",null),
		"oc.doCopyTo("+ tableId+","+ objectId+",'"+java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""))+"')"
		));
validCommands.add( commandFactory.newButtonInstance("PrintFile", 
		PortletUtils.getMessage(pageContext, "object.printfile",null),
		"oc.PrintFile()",null
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
			"oc.doShowObject("+ ((Table) otherviews.get(0)).getId()+","+ objectId+")"
		));	
 	}else{
 		viewIdString="";
 		for(int oi=0;oi<otherviews.size();oi++){
  			viewIdString += ((Table)otherviews.get(oi)).getId()+"_";
  		}
  		validCommands.add( commandFactory.newButtonInstance("OtherViews", 
			PortletUtils.getMessage(pageContext, "object.otherviews",null),
			"oc.doSelectView('"+ viewIdString +"',"+ objectId+")"
		));	
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
		


