<table align="center" border="0" cellpadding="1" cellspacing="1" style="width:100%">
<%
	for(int i=0;i< qColumns.size();i++){
      Column column=(Column)qColumns.get(i);
	  boolean isAK= (column.isAlternateKey()); //ak has qdata as default value
      String desc=  model.getDescriptionForColumn(column);
      String fkDesc= model.getDescriptionForFKColumn(column);
      if (! "".equals(fkDesc)) fkDesc= "("+ fkDesc+")";
      String inputName="tab"+tabIdx+"_"+model.getNameForInput(column);
      String cs= model.getColumns(column);
      int inputSize=model.getSizeForInput(column);
      String type=model.getTypeMeaningForInput(column);
      nds.util.PairTable values = column.getValues(locale);
      if(i%columnsPerRow == 0)out.print("<tr>");
      String column_desc="column_"+column.getId()+"_desc"; // equals column_acc_Id + "_desc"
%>
      <td height="18" width="<%=widthPerColumn*2/3%>%" nowrap align="left">
			<div class="desc-txt"><%=column.getDescription(locale)%>:</div>
      </td>
      <td height="18" width="<%=widthPerColumn*4/3%>%" nowrap align="left">

          <input type="hidden" name="<%=inputName%>/columns" value="<%=cs%>" >
       <%
        if(values != null){// ÏÔÊ¾combox»òradio
            StringHashtable o = new StringHashtable();
            o.put(PortletUtils.getMessage(pageContext, "combobox-select",null),"0");
            Iterator i1 = values.keys();
            Iterator i2 = values.values();
            while(i1.hasNext() && i2.hasNext())
            {
                String tmp1 = String.valueOf(i2.next());
                String tmp2 = String.valueOf(i1.next());
                o.put(tmp1,"="+tmp2); // tmp1 is limit-description, tmp2 is limit-value
            }
            java.util.HashMap a = new java.util.HashMap();
            inputName += "/value";
           
            // special handling "isactive" field
            if("isactive".equalsIgnoreCase(column.getName()) && !"n".equals(returnType)){
            // not attributesText="disabled", so user can still change it,especially in security filter setting
       %>
       <input:select name="<%=inputName%>" default="=Y" attributes="<%= a %>" options="<%= o %>" />
       <input type="hidden" name="<%=inputName%>" value="=Y">
       <%	}else{
       %>
       <input:select name="<%=inputName%>" default="0" attributes="<%= a %>" options="<%= o %>" />
       <%
       		}
        }// end if(value != null)
        else{
            String column_acc_Id="tab"+tabIdx+"_column_"+column.getId();
            String column_acc_name= inputName;
            String defaultValue="";
            if(isAK) defaultValue=qdata;
            java.util.Hashtable h = new java.util.Hashtable();
               h.put("size", "15");
            if((column.getReferenceTable()!=null && column.getReferenceTable().getAlternateKey().isUpperCase())||
            	column.isUpperCase()){
            	h.put("class","qline3 ucase");
            }else
            	h.put("class","qline3");
            	h.put("onkeypress", "oq.onSearchReturn(event)");
            	//edit by Robin 2010-08-12
            	h.put("id",column_acc_Id);
               inputName += "/value";
			if(column.getReferenceTable() !=null){                                   
               	FKObjectQueryModel fkQueryModel=new FKObjectQueryModel(column.getReferenceTable(), column_acc_Id,column,null,false);
               	fkQueryModel.setQueryindex(queryindex);
               	
        %>
        <input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=defaultValue%>"/><%= type%>
				<input type='hidden' name='<%=column_acc_name+"/sql"%>' id='<%=column_acc_Id + "_sql"%>' />
				<input type='hidden' name='<%=column_acc_name+"/filter"%>' id='<%=column_acc_Id + "_filter"%>' />
				<span id='<%=column_acc_Id+"_link"%>' title="popup" onclick="<%=fkQueryModel.getButtonClickEventScript()%>">
						<img id='<%=column_acc_Id+"_img"%>' border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/filterobj.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'>
				</span>
				<script>createButton(document.getElementById("<%=column_acc_Id+"_link"%>"));</script>	
                <%/* 
                Do not support open search form again currently
                %>
                    <span id='<%=column_acc_Id+"_link"%>' name="popup" onaction=pop_up_or_clear(this,"<%=url%>","<%="T"+System.currentTimeMillis() %>","<%=column_acc_Id%>")><img id='<%=column_acc_Id+"_img"%>' border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'></span>
					<script>createButton(document.getElementById("<%=column_acc_Id+"_link"%>"));</script>	
				<%*/%>	
                <%
        	}else{
        		//will check type first, for number, construct operator, for date, two fields, for string, contains or equal
        		if(column.getType()==Column.DATE||column.getType()==Column.DATENUMBER ){
        			String showDefaultRange=firstDateColumnFound?"N":"Y";// only first date column will have default range set
        		%>
        		<input:daterange id="<%=column_acc_Id%>" name="<%=inputName%>" showDefaultRange="<%=showDefaultRange%>" attributes="<%= h %>"/>
        		<%
        			firstDateColumnFound=true;
        		}else if(column.getType()==Column.NUMBER){
        		%>
        		<input:text name="<%=inputName%>" attributes="<%= h %>" /><%= type%>
        		<!--Edit by robin 2010-08-12-->
        		<!--span id='<%=column_acc_Id+"_link"%>' title="popup" onaction="oq.tog('<%=column_acc_Id%>')">
							<img id='<%=column_acc_Id+"_img"%>' border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/record.gif'>
						</span-->
						<!--script>createButton(document.getElementById("<%=column_acc_Id+"_link"%>"));</script-->	
        		<!--end-->
        		<%
        		}else if(column.getType()==Column.STRING){
        		%>
        		<input:text name="<%=inputName%>" attributes="<%= h %>" /><%= type%>
        		<!--Edit by robin 2010-08-12>
        		<!--span id='<%=column_acc_Id+"_link"%>' title="popup" onaction="oq.tog('<%=column_acc_Id%>')">
							<img id='<%=column_acc_Id+"_img"%>' border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/record.gif'>
						</span-->
						<!--script>createButton(document.getElementById("<%=column_acc_Id+"_link"%>"));</script-->	
						<!--end-->
        		<%
        		}
        	}
        }%>
      </td>
<%
if(i%columnsPerRow == (columnsPerRow -1))out.print("</tr>");
}%>
</table>
	