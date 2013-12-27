<%
if( objectId == -1){
    if(canAdd){
 		validCommands.add( commandFactory.newButtonInstance("Create", 
			PortletUtils.getMessage(pageContext, "object.create",null),
			"ptc.doCreate('"+namespace+"','"+ table.getName()+"')"
		));
    }
}else{
	if(canModify){
		validCommands.add( commandFactory.newButtonInstance("Modify", 
			PortletUtils.getMessage(pageContext, "object.modify",null),
			"ptc.doModify('"+namespace+"','"+ table.getName()+"')"
		));
	}
	if(canDelete){
		validCommands.add( commandFactory.newButtonInstance("Delete", 
			PortletUtils.getMessage(pageContext, "object.delete",null),
			"ptc.doModify('"+namespace+"','"+ table.getName()+"','"+ table.getDescription(locale)+"')"
		));
	}
	if(canSubmit){
		validCommands.add( commandFactory.newButtonInstance("Submit", 
			PortletUtils.getMessage(pageContext, "object.submit",null),
			"ptc.doModify('"+namespace+"','"+ table.getName()+"')"
		));
	}
	validCommands.addAll(table.getExtendButtons(objectId, userWeb));
	if(canAdd){
    	validCommands.add( commandFactory.newButtonInstance("NewObject", 
			PortletUtils.getMessage(pageContext, "object.newobject",null),
			"ptc.doShowObject("+tableId+",-1)"
		));
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
}
%>
<div class="linkbtn">
<%@ include file="inc_command.jsp" %>
</div>
<script>
function <%=namespace%>checkOptions(){
	var fm=$("<%=namespace%>fm");
  <%
    for( int i=0;i< columns.size();i++){
        Column col=(Column) columns.get(i);
        // if the column is in fixed column list, do not check it.
        if( fixedColumns.get(new Integer(col.getId()))!=null) continue;
        //skip checkbox, whether you check or not, value is set
        if( col.getDisplaySetting().getObjectType()== DisplaySetting.OBJ_CHECK) continue;
        String colName= col.getName().toLowerCase();
        String colDesc=col.getDescription(locale);
        Column col2=col;
        
        if( col.getReferenceTable()!=null) {
            col2= col.getReferenceTable().getAlternateKey();
            colName =colName +"__"+ col2.getName().toLowerCase();
            colDesc += col2.getDescription(locale);
        }

        if( col.isModifiable(actionType)){
            if( col.getValues(locale) !=null && !col.isNullable()){
                out.println(" if(!checkSelected(fm,\""+colName+"\",\""+colDesc+"\")) return false;");
            }else{
                // check for value nullable
                if( !col.isNullable()){
                    out.println(" if(!checkNotNull(fm,\""+colName+"\",\""+colDesc+"\")) return false;");
                    switch( col2.getType()){
                        case Column.DATE:
                        case Column.DATENUMBER:
                            out.println(" if(!checkIsDate(fm,\""+colName+"\",\""+colDesc+"\")) return false;");
                            break;
                        case Column.NUMBER:
                            out.println(" if(!checkIsNumber(fm,\""+colName+"\",\""+colDesc+"\")) return false;");
                            break;
                    }
                }
            }

        }
    }
   %>
}
</script>

