<%
result=null;
boolean tabflag=false;
if( objectId != -1){
	query=QueryEngine.getInstance().createRequest(userWeb.getSession());
    query.setMainTable(tableId);
	query.addAllShowableColumnsToSelection(Column.MODIFY);
    query.addParam( table.getPrimaryKey().getId(), ""+ objectId );
	result=QueryEngine.getInstance().doQuery(query);
}
if(objectId == -1 || (result!=null && result.getTotalRowCount()>0)){
	actionType= objectId ==-1?Column.ADD:Column.MODIFY;
	columns=table.getShowableColumns(actionType);
	int initstatus=0;//status;
	if(objectId!=-1){
		try{
			if( manager.getColumn(table.getName(), "status")!=null )
				initstatus= QueryEngine.getInstance().getSheetStatus(table.getRealTableName(),objectId);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>
<div id="obj-top">
	<div></div>
	<div id="tabs1">
	  <ul>	
	  <%if(p_nextstep==0&&initstatus!=2){
	  		tabflag=true;
	  %>
		<%if(objectId != -1){%>
			<li class="currleft"><span class="precurr"><%=PortletUtils.getMessage(pageContext, "modify.docno",null)%></span></li>
		<%}else{%>
			<li class="currleft"><span class="precurr"><%=PortletUtils.getMessage(pageContext, "add.docno",null)%></span></li>
		<%}
	  }else if(p_nextstep!=0){
	  		tabflag=false;
	  		if(objectId != -1){
			%>
				<li class="left"><span class="prenocurr"><%=PortletUtils.getMessage(pageContext, "modify.docno",null)%></span></li>
			<%}else{%>
			 	<li class="left"><span class="prenocurr"><%=PortletUtils.getMessage(pageContext, "add.docno",null)%></span></li>
		<%}}%>
	    <%
	    String sql_step="select ad_refby_table_id from AD_REFBYTABLE t where t.ad_table_id="+table.getId()+" and t.isactive='Y' order by t.orderno asc";
	    List al_step=QueryEngine.getInstance().doQueryList(sql_step);
	    Table tablerfts=null;
	    if(al_step.size()>0){
	    	for(int i=0;i<al_step.size();i++){
	    		tablerfts=TableManager.getInstance().getTable(Tools.getInt(al_step.get(i),-1));
	    		String stylestr="";
	    		String tabName =tablerfts.getDescription(locale);
	    		if(tabName.length()==4){
	    			stylestr="padding:3px 43px";
	    		}else if(tabName.length()==5){
	    			stylestr="padding:3px 37px";
	    		}else if(tabName.length()==6){
	    			stylestr="padding:3px 31px";
	    		}else if(tabName.length()==7){
	    			stylestr="padding:3px 25px";
	    		}else if(tabName.length()==8){
	    			stylestr="padding:3px 19px";
	    		}else if(tabName.length()==9){
	    			stylestr="padding:3px 13px";
	    		}else if(tabName.length()==10){
	    			stylestr="padding:3px 7px";
	    		}
	    		if(i+1==p_nextstep&&initstatus!=2){ 
	    			tabflag=true;	
	    %> 
	    			<%System.out.print(tabName.length());%>
	    			<li class="left"><span class="crosscurr" style="<%=stylestr%>"><%=tabName%></span></li>	    		
	    	  <%}else{
	    			if(tabflag){
	    		%>
	    				<li class="currleft"><span class="crossnocurr" style="<%=stylestr%>"><%=tabName%></span></li>
	    			<%}else{%>
	    				<li class="left"><span class="allnocurr" style="<%=stylestr%>"><%=tabName%></span></li>
	    	   <%	}
	    		tabflag=false;
	    		}
	    	}
	    }%>
	    	<%if( manager.getColumn(table.getName(), "status")!=null ){
	    	    if(p_nextstep!=-2&&initstatus!=2){
	    	    	if(tabflag){%> 
	    				<li class="currleft"><span class="crossnocurr"style="padding:3px 43px"><%=PortletUtils.getMessage(pageContext, "submit.docno",null)%></span></li>
	    				<li class="left"><span class="endnocurr"><%=PortletUtils.getMessage(pageContext, "complete",null)%></span></li>
	    			<%}else{%>
	    				<li class="left"><span class="allnocurr"style="padding:3px 43px"><%=PortletUtils.getMessage(pageContext, "submit.docno",null)%></span></li>
	    				<li class="left"><span class="endnocurr"><%=PortletUtils.getMessage(pageContext, "complete",null)%></span></li>
	    			<%}%>
	    		<%}else if(p_nextstep==-2&&initstatus!=2){%>
	    			<li class="left"><span class="crosscurr" style="padding:3px 43px"><%=PortletUtils.getMessage(pageContext, "submit.docno",null)%></span></li>
	    			<li class="currleft"><span class="nocurrtabs"><%=PortletUtils.getMessage(pageContext, "complete",null)%></span></li>
	    		<%}else if(p_nextstep==-2&&initstatus==2){%>
	    			<li class="left"><span class="allnocurr" style="padding:3px 43px"><%=PortletUtils.getMessage(pageContext, "submit.docno",null)%></span></li>
	    			<li class="left"><span class="currtabs"><%=PortletUtils.getMessage(pageContext, "complete",null)%></span></li>
	    		<%}%>
	    	<%}else{
	    		 if(p_nextstep!=-2){
	    		 	if(tabflag){
	    	%>
	    		 		<li class="currleft"><span class="nocurrtabs"><%=PortletUtils.getMessage(pageContext, "complete",null)%></span></li>
	    		 	<%}else{%>
	    		 		<li class="left"><span class="endnocurr"><%=PortletUtils.getMessage(pageContext, "complete",null)%></span></li>
	    		 	<%}%>
	    		<%}else{%>
	    			<li class="left"><span class="currtabs"><%=PortletUtils.getMessage(pageContext, "complete",null)%></span></li>
			<%	}
			}%>
		
	  </ul>
	</div>
</div>
<div class="<%=uiConfig.getCssClass()%>" id="<%=uiConfig.getCssClass()%>">
	<%
    //if true, will show data without variable, else show variable directly. This is used for template setting page
    //@see inc_template.jsp/inc_batchupdate.jsp
    bReplaceVariable= true;
    //load preference values from ad_user_pref, key name: column.name.tolowercase
    //not do cache, because the synchronization between cache and db is not implemented currently.
    objprefs= userWeb.getPreferenceValues("template."+table.getName().toLowerCase(),false,bReplaceVariable);

	model= new TableQueryModel(tableId, actionType,isInput,true,locale);
	if(result!=null)result.next();
	columnIndex=0;

	%>
	<input type="hidden" id="p_nextstep" name="p_nextstep" value="<%=p_nextstep%>">
	<input type="hidden" id="nextstep" name="nextstep" value="<%=nextstep%>">
	<%if(p_nextstep==0&&initstatus!=2){%>	
	<div class="obj" id="obj_inputs_1"><!--OBJ_INPUTS1_BEGIN-->
		<%@ include file="/html/nds/step/inc_single_object.jsp" %><!--OBJ_INPUTS1_END-->
	</div>
	<div class="div_step"><input class="cbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "next-step",null)%>" onclick="javascript:step.savehead();"></div>
	<%}else if(p_nextstep!=0&&p_nextstep!=-2&&initstatus!=2){%>
		<div class="obj" id="obj_inputs_1"><!--OBJ_INPUTS1_BEGIN-->
			<%@ include file="inc_single_object_view.jsp" %><!--OBJ_INPUTS1_END-->
		</div>
		<%@ include file="/html/nds/step/inc_tabs.jsp" %>
	<%}else if(p_nextstep==-2||initstatus==2){%>
	  <%@ include file="/html/nds/step/object_view.jsp" %>
	<%}%>
</div>
<%}// end if(objectId == -1 || (result!=null && result.getTotalRowCount()>0)){
else{%>
		<div class="msg-error"><%=PortletUtils.getMessage(pageContext, "object-not-exists",null)%></div>
<%}%>