
<%
    /**
     * 读取AD_OPTION表中的设置
     */
 %>
<%
  if(params!=null)for(int i=0;i<params.size();i++){
	name= (String)((List)params.get(i)).get(0);
	desc= (String)((List)params.get(i)).get(1);
	comments= (String)((List)params.get(i)).get(2);
	if (Validator.isNull(comments)) comments="";
	orderno=Tools.getInt(((List)params.get(i)).get(3),i);
	columnId= Tools.getInt(((List)params.get(i)).get(4),-1);
	valuetype=(String)((List)params.get(i)).get(5);
	if (Validator.isNull(valuetype)) valuetype="S"; // for string
	valuelength=Tools.getInt(((List)params.get(i)).get(6),20);
	nullable=(String)((List)params.get(i)).get(7);
	if (Validator.isNull(nullable)) valuetype="Y"; // for string
	valuedefault=(String)((List)params.get(i)).get(8);
	if (Validator.isNull(valuedefault)) valuedefault=""; // for string
	if(params1!=null){
	 for(int j=0;j<params1.size();j++){
	 description= (String)((List)params1.get(j)).get(0);
	 if(description.equals(name.toUpperCase())){
	    valuedefault=(String)((List)params1.get(j)).get(1); 
	    if(valuedefault==null){
	      valuedefault="";
	      }
	     }
	   }
	 }
	inputType="text"; type=TableQueryModel.toTypeIndicator( Column.STRING,valuelength,"",name,locale);	
	limitvalueGroupId= Tools.getInt(((List)params.get(i)).get(9),-1);
	if(limitvalueGroupId!=-1){
		// selection
		inputType="select";
	}
	if("N".equals(valuetype)){
		type=TableQueryModel.toTypeIndicator( Column.NUMBER,valuelength,"",name,locale);	
	}else if("D".equals(valuetype)){
		type=TableQueryModel.toTypeIndicator( Column.DATE,valuelength,"",name,locale);	
	}else if("B".equals(valuetype)){
		inputType="textarea";
		type=TableQueryModel.toTypeIndicator( Column.STRING,valuelength,"",name,locale);	
	}
	// url=null;
	// if(columnId!=-1) url=request.getContextPath()+"/servlets/query?table="+TableManager.getInstance().getColumn(columnId).getTable().getId()+"&return_type=s&accepter_id=form1."+name;
%>
  <table>
    <tr><td height="18" width="200" align="left" ><%=desc%><%="Y".equals(nullable)?"":"<font color='red'>*</font>"%>:</td>
    <td height="18" width="250" align="left">
    	<%
    	 String column_acc_Id="column_"+columnId;
	     Column column=(Column)TableManager.getInstance().getColumn(columnId);	
	     String classx="ipt-2-1";
	     if(column!=null)classx=TableQueryModel.getTextInputCssClass(2,column);
    	%>
    <%if("text".equals(inputType)){%>
	    <%if(columnId!=-1){     
	     FKObjectQueryModel fkQueryModel=new FKObjectQueryModel(true,column.getTable(),column_acc_Id,column,null);
	     fkQueryModel.setQueryindex(-1);
	    %>
	     <input type='text' class="<%=classx %>" MAXLENGTH="<%=valuelength%>" id='column_<%=column.getId()%>' name='<%=name%>' value='<%=valuedefault%>'><%=type%>
         <span id="cbt_<%=column.getId()%>"  onaction="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
         <script>createButton(document.getElementById("cbt_<%=column.getId()%>"));</script>
    	<%}else{%>
    	<input type='text' class="<%=classx %>" MAXLENGTH="<%=valuelength%>" id="<%=name%>" name='<%=name%>' value='<%=valuedefault%>'><%=type%>
    	<%}%>
    <%}else if("textarea".equals(inputType)){%>
    	<textarea cols="35" rows="6" wrap="soft" MAXLENGTH="<%=valuelength%>" id="<%=name%>" name='<%=name%>'><%=valuedefault%></textarea><%=type%>
    <%}else if("select".equals(inputType)){
		List values= QueryEngine.getInstance().doQueryList("select value,description from ad_limitvalue where ad_limitvalue_group_id="+limitvalueGroupId+" order by orderno asc");
		
    	StringHashtable o = new StringHashtable();
    	o.put( PortletUtils.getMessage(pageContext, "combobox-select",null),"0");
    	
    	for(int j=0;j<values.size();j++){
    		o.put((String)((List)values.get(j)).get(1),(String)((List)values.get(j)).get(0) );
    	}
    	java.util.HashMap a = new java.util.HashMap();
    %>
        <input:select name="<%=name%>" default="<%=valuedefault%>" attributes="<%= a %>" options="<%= o %>"/>
    <%}%>
    </td>
    <td align='left'><span class="<%=classx %>"><%=comments%></span></td>
    </tr>
    <%}%>
  </table>


	
