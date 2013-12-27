<%
    /**
     * This is only for portal now, using QueryListConfig
     *
     */
    String return_type= "n";
    String accepter_id= null;
    int tab_count= 1;     
List<ColumnLink> qColumns=qlc.getConditions(userWeb.getSecurityGrade());
//System.out.println(qColumns.size());
%>
<form id="list_query_form" name="list_query_form" method="post" action="/servlets/QueryInputHandler" onSubmit="pc.queryList();return false;" >
<input type='hidden' name='table' value='<%=tableId %>'>
<input type='hidden' name='tab_count' value='<%=tab_count%>'>
<input type='hidden' name='return_type' value='<%=return_type %>'>
<input type='hidden' name='accepter_id' value='<%=accepter_id %>'>
<input type='hidden' name='qlcid' value='<%=qlc.getId()%>'>
<input type='hidden' name='param_count' value='<%=qColumns.size() %>'>
<input type='hidden' name='resulthandler' value='/html/nds/portal/table_list.jsp'>
<input type='hidden' name='show_maintableid' value='true'>
  
<table border="0" cellspacing="0" cellpadding="0" align='center' width="98%" bordercolordark="#FFFFFF" bordercolorlight="#999999">
  <tr>
    <td  colspan="2">
      <table align="center" border="0" cellpadding="1" cellspacing="1" width="100%" >
        <%
        int columnsPerRow=4;// 4 field per row
        int widthPerColumn= (int)(100/(columnsPerRow*2));
		  
		boolean firstDateColumnFound=false;
		for(int i=0;i< qColumns.size();i++){
			ColumnLink clink=qColumns.get(i);
			Column column=clink.getLastColumn();
			String desc= clink.getDescription(locale);
			String inputName=clink.toHTMLString();
			int inputSize= (column.getReferenceTable()!=null? column.getReferenceTable().getAlternateKey().getLength():column.getLength());
      String type=TableQueryModel.toTypeDesc(column,locale);
			nds.util.PairTable values = column.getValues(locale);
			if(i%columnsPerRow == 0)out.print("<tr>");
        %>
          <td height="18" width="<%=widthPerColumn*2/3%>%" nowrap align="left">
			<div class="desc-txt"><%=desc%>:</div>
          </td>
          <td height="18" width="<%=widthPerColumn*4/3%>%" nowrap align="left">
           <%
            if(values != null){
                StringHashtable o = new StringHashtable();
                o.put(PortletUtils.getMessage(pageContext, "combobox-select-all",null),"0");
                Iterator i1 = values.keys();
                Iterator i2 = values.values();
                while(i1.hasNext() && i2.hasNext())
                {
                    String tmp1 = String.valueOf(i2.next());
                    String tmp2 = String.valueOf(i1.next());
                    // add = so will match identically
                    o.put(tmp1,"="+tmp2); // tmp1 is limit-description, tmp2 is limit-value
                }
                java.util.HashMap a = new java.util.HashMap();
           		String defaultSelectValue="0";
           		if("STATUS".equals(column.getName())){defaultSelectValue="=1";}
           		if("ISACTIVE".equals(column.getName())){defaultSelectValue="=Y";}
           %>
           <input:select name="<%=inputName%>" default="<%=defaultSelectValue%>" attributes="<%= a %>" options="<%= o %>" />
           <%
           		
            }// end if(value != null)
            else{
                String defaultValue= userWeb.getUserOption(column.getName(),"");
                java.util.Hashtable h = new java.util.Hashtable();
                   h.put("size", "15");
	            if((column.getReferenceTable()!=null && column.getReferenceTable().getAlternateKey().isUpperCase())||
	            	column.isUpperCase()){
	            	h.put("class","qline ucase");
	            }else
	            	h.put("class","qline");
	            	h.put("onkeypress", "pc.onSearchReturn(event)");
              	h.put("id",inputName);                  
            	if(column.getReferenceTable() !=null){                                   
                    //String url="/html/nds/query/search.jsp?table="+column.getReferenceTable().getId()+"&column="+column.getId()+"&return_type=m&accepter_id="+inputName;
                    FKObjectQueryModel fkQueryModel=new FKObjectQueryModel(column.getReferenceTable(), inputName,column,null,false);
                    fkQueryModel.setQueryindex(-1);
                    if(nds.util.Validator.isNotNull(defaultValue)) defaultValue="="+defaultValue;
            %>
              		<input:text name="<%=inputName%>" default="<%=defaultValue%>" attributes="<%= h %>" /><%= type%>
                    <input type='hidden' name='<%=inputName+"/sql"%>' id='<%=inputName + "_sql"%>' />
                    <input type='hidden' name='<%=inputName+"/filter"%>' id='<%=inputName + "_filter"%>' />
                    <span id='<%=inputName+"_link"%>' title="popup" onclick="<%=fkQueryModel.getButtonClickEventScript()%>">
                    	<img id='<%=inputName+"_img"%>' border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/filterobj.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'>
                    </span>
						<script>createButton(document.getElementById("<%=inputName+"_link"%>"));</script>	
                    <%
            	}else{
            		//will check type first, for number, construct operator, for date, two fields, for string, contains or equal
            		if(column.getType()==Column.DATE||column.getType()==Column.DATENUMBER ){
                  
            			String showDefaultRange=firstDateColumnFound?"N":"Y";// only first date column will have default range set
                  String showTime = column.getType() == Column.DATE?"Y":"N";
            		%>
            		<input:daterange id="<%=inputName%>" name="<%=inputName%>" showTime="<%= showTime %>" showDefaultRange="<%=showDefaultRange%>" attributes="<%= h %>"/>
            		<%	firstDateColumnFound=true;
            		}else if(column.getType()==Column.NUMBER){
            		%>
            		<input:text name="<%=inputName%>" default="<%=defaultValue%>" attributes="<%= h %>" /><%= type%>
            		    <!--span id='<%=inputName+"_link"%>' title="popup" onaction="oq.tog('<%=inputName%>')">
                    	<img id='<%=inputName+"_img"%>' border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/record.gif'>
                    </span-->
								<!--script>createButton(document.getElementById("<%=inputName+"_link"%>"));</script-->	
            		<%
            		}else if(column.getType()==Column.STRING){
            		%>
            		<input:text name="<%=inputName%>" default="<%=defaultValue%>" attributes="<%= h %>" /><%= type%>
            		    <!--span id='<%=inputName+"_link"%>' title="popup" onaction="oq.tog('<%=inputName%>')">
                    	<img id='<%=inputName+"_img"%>' border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/record.gif'>
                    </span-->
								<!--script>createButton(document.getElementById("<%=inputName+"_link"%>"));</script-->	
            		<%
            		}
            	}

            }%>
          </td>
        <%
        if(i%columnsPerRow == (columnsPerRow -1))out.print("</tr>");
        }
      %>
      </table>
    </td>
  </tr>
</table>
<input type='hidden' name='show_all' value='true'>
<input type='hidden' name='queryindex_-1' id='queryindex_-1' value="-1" />
</form>

