<table class="<%=uiConfig.getCssClass()%>" cellspacing="1" cellpadding="0" align="center">
<%
    colIdx=-1;
    for(int i=columnIndex;i< columns.size();i++){
    	colIdx++;
    	columnIndex++;
        column=(Column)columns.get(i);
        ds= column.getDisplaySetting();
        String attributesText="";//Validator.isNull(column.getRegExpression())? " ": column.getRegExpression()+" ";
        if(colIdx%columnsPerRow == 0){
        	colIdx=0;
        	if(ds.getObjectType()==DisplaySetting.OBJ_BLANK&& seperateObjectByBlank){
        		break;
        	}
%>
	<tr<%=(ds.getObjectType()==DisplaySetting.OBJ_BLANK?" class='blankrow'":"")%>>
<%     }   
        if(ds.isUIController()){
        	if (ds.getObjectType()==DisplaySetting.OBJ_HR){
        		// occupy whole row
        		if(colIdx !=0){
        			for(int ri=0;ri< columnsPerRow-colIdx;ri++) out.print("<td>&nbsp;</td><td>&nbsp;</td>");
        			out.print("</tr><tr>");
        		}
        		//out.print("<td colspan='"+(columnsPerRow*2)+"'><font class='beta'><b>"+column.getDescription(locale)+"</b></font><div class='hrRule'><span/></div></td>");
        		out.print("<td colspan='"+(columnsPerRow*2)+"'><div class='tabnav-"+columnsPerRow+"'><span>"+column.getDescription(locale)+"</span></div></td>");
        		out.print("</tr>");
        		colIdx=-1;
        	}else{
        		// blank
        		if(seperateObjectByBlank){
	        		if( ds.getColumns()> columnsPerRow-colIdx){
	        			// occupy whole row
	        			if(colIdx !=0){
	        				out.print("<td colspan='"+(columnsPerRow-colIdx)*2 +"'/>");
	        				out.print("</tr>");
	        			}
	        		}
	        		break;
        		}else{
	        		if( ds.getColumns()> columnsPerRow-colIdx){
	        			// occupy whole row
	        			if(colIdx !=0){
	        				for(int ri=0;ri< columnsPerRow-colIdx;ri++) out.print("<td></td><td></td>");
	        				out.print("</tr><tr class='blankrow'>");
	        			}
	        		}
	        		out.print("<td colspan='"+(ds.getColumns()*2)+"'>&nbsp;</td>");
	        		if(colIdx+ds.getColumns()>columnsPerRow-1 ){
	        			colIdx=-1;
	        			out.print("</tr>");
	        		}// colIdx will be increment 1 after continue
        		}
        	}
       		continue;
        }
        
        dataValue = "";
		fixedColumnMark= (fixedColumns.get(new Integer(column.getId())) ==null)?"":"DISABLED";
		isFixedColumn= (fixedColumns.get(new Integer(column.getId())) ==null)?false:true;
		
        String desc=  model.getDescriptionForColumn(column);
        dataWithoutNBSP=null;
        if(result !=null){
              data=result.getString(i+1,true);
              dataWithoutNBSP=result.getString(i+1,false);
              coid=result.getObjectID( i+1);
              dataDB =result.getObject(i+1);
        }else{
        	//dataWithoutNBSP=objprefs.getProperty(column.getName(),column.getDefaultValue(bReplaceVariable));
        	dataWithoutNBSP=objprefs.getProperty(column.getName(), 
        		userWeb.getUserOption(column.getName(),column.getDefaultValue(bReplaceVariable)));
        	if(bReplaceVariable)dataWithoutNBSP=userWeb.replaceVariables(dataWithoutNBSP);
        	dataDB = dataWithoutNBSP;
        }
        refTable= column.getReferenceTable();
/**Note : the inputName should not get from model, which is for Query, not this one*/
//                          String inputName=model.getNameForInput(column);
        inputName=column.getName().toLowerCase();
	    column_acc_Id="column_"+column.getId();
        
        type=model.toTypeIndicator(column,column_acc_Id,locale);
        
        if( refTable !=null) {
               inputName=inputName+"__"+ refTable.getAlternateKey().getName().toLowerCase();
               
        }
        inputSize=bReplaceVariable?model.getSizeForInput(column):4000;// if show variable, which may be script,so should be longer

        values = column.getValues(locale);
        
		if( ds.getColumns()> columnsPerRow-colIdx){      
			// start from first column  
		 	// occupy previous whole row
        	if(colIdx !=0){
        		for(int ri=0;ri< columnsPerRow-colIdx;ri++) out.print("<td></td><td></td>");
        		out.print("</tr><tr>");
        		colIdx=0;
        	}
        	
        }
		colIdx=colIdx+ds.getColumns()-1; 
%>
	<%
	if(!(ds.getObjectType()==DisplaySetting.OBJ_BUTTON )){
    %>
    <td width="<%=widthPerColumn*2/3%>%" nowrap align="left" valign='top' class="desc">
    <div class="desc-txt"><%=desc%>:</div>
    </td>
    <td class="value" width="<%=widthPerColumn*4/3%>%" nowrap align="left" valign='top' <%=(ds.getColumns()-1)*2>0? "colspan='"+((ds.getColumns()-1)*2+1)+"'":"" %>>
      <%
      
    if(values != null){// combox or check
        //Hawke Begin
        StringHashtable o = new StringHashtable();
        o.put( PortletUtils.getMessage(pageContext, "combobox-select",null),"0");
        Iterator i1 = values.keys();
        Iterator i2 = values.values();
        while(i1.hasNext() && i2.hasNext())
        {
            String tmp1 = String.valueOf(i2.next());
            String tmp2 = String.valueOf(i1.next());
            o.put(tmp1,tmp2);
            
            if(data != null && data.equals(tmp1))
                dataValue = tmp2;
        }
        java.util.HashMap a = new java.util.HashMap();
        a.put("id", column_acc_Id);
        //Hawke end
            if(data !=null){
                data=data.trim();
						
                if(canEdit && column.isModifiable(actionType)){
                	a.put("tabIndex", (++tabIndex)+"");
                	if(ds.getObjectType()==DisplaySetting.OBJ_CHECK){
                    %>
                    <input:checkbox name="<%=inputName%>" default="<%=dataValue%>" value="Y" attributes="<%=a%>" attributesText="<%=(attributesText+"class='cbx2'")%>"/>
                    <%}else{
                    	a.put("class", "objsl");
                    %>
                    <input:select name="<%=inputName%>" default="<%=dataValue%>" attributes="<%= a %>" options="<%= o %>" attributesText="<%=(attributesText+fixedColumnMark)%>" />
                    <%
                    }
                }else{
                    out.print(data);
                }
            }else{
                if( canEdit&&column.isModifiable(actionType)){
                	a.put("tabIndex", (++tabIndex)+"");
                	//String defaultValue=objprefs.getProperty(column.getName(),column.getDefaultValue(bReplaceVariable));
		        	String defaultValue=objprefs.getProperty(column.getName(), 
        			userWeb.getUserOption(column.getName(),column.getDefaultValue(bReplaceVariable)));
                	if(defaultValue==null) defaultValue="0";
                	if(bReplaceVariable) defaultValue=userWeb.replaceVariables(defaultValue);
                	if(ds.getObjectType()==DisplaySetting.OBJ_CHECK){
                    %>
                    <input:checkbox name="<%=inputName%>" default="<%=defaultValue%>" value="Y" attributes="<%=a%>" attributesText="<%=(attributesText+"class='cbx2'")%>"/>
                    <%}else{
                    	a.put("class", "objsl");
                    %>
                    <input:select name="<%=inputName%>" default="<%=defaultValue%>" attributes="<%= a %>" options="<%= o %>" attributesText="<%=(attributesText+fixedColumnMark)%>" />
                    <%}
                }else{
                %>
                    <%= PortletUtils.getMessage(pageContext, "maintain-by-sys",null)%>
                    <%
                }
            }
    }// end if(value != null)
    else{ // begin if value ==null
        if(column.getReferenceTable() !=null){		
    	  	fkQueryModel=new FKObjectQueryModel(true,column.getReferenceTable(), column_acc_Id,column,null);
    	  	fkQueryModel.setQueryindex(-1);
    	  }else{
    	  	fkQueryModel=null;
				}
    	  
          if( canEdit&& column.isModifiable(actionType)){
			if(dataWithoutNBSP==null && isFixedColumn){
            	// is fixed column, so will be maintained by system
            	dataWithoutNBSP=PortletUtils.getMessage(pageContext, "maintain-by-sys" ,null);
            }
            if( ds.getObjectType()==DisplaySetting.OBJ_TEXT){
	            java.util.Hashtable h = new java.util.Hashtable();
	            h.put("id", column_acc_Id);
	            h.put("size", "" + ds.getCharsPerRow());
	            h.put("maxlength", String.valueOf(inputSize));
	            h.put("tabIndex", (++tabIndex)+"");
	            h.put("class", TableQueryModel.getTextInputCssClass(columnsPerRow,column));
	            if(fkQueryModel!=null){
	            	//add key catcher 
	            	//h.put("onkeydown",fkQueryModel.getKeyEventScript());
	            	if(column.isFilteredByWildcard() && Validator.isNotNull(column.getRegExpression())){
	            		h.put("readonly","readonly");
	            	}
	            	h.put("onkeypress","oc.onKeyPress(event)");
	            	
	            }//end if(fkQueryModel!=null)
	            if(column.isAutoComplete()){
	             	boolean flag=true;
	            	for(int j=0;j<dcqjsonarraylist.length();j++){
	            		if(dcqjsonarraylist.getJSONObject(j).get("column_acc_Id").equals(column_acc_Id)){
	            			flag=false;break;
	            		}
	            	}
	            	if(flag){
						dcqjsonObject=new org.json.JSONObject();
						dcqjsonObject.put("column_acc_Id",column_acc_Id);
						dcqjsonObject.put("tableId",column.getReferenceTable().getId());
						dcqjsonObject.put("columnId",column.getId());
						dcqjsonObject.put("newvalue","");
						dcqjsonObject.put("oldvalue","");
						dcqjsonarraylist.put(dcqjsonObject);
					}
					h.put("autocomplete","off");
	            }
				if(Validator.isNotNull(column.getRegExpression())){
                	h.put("onchange", column.getRegExpression()+"()");
                }
                h.put("title", model.getInputBoxIndicator(column,column_acc_Id,locale));
                
	            %>
	            <input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=dataWithoutNBSP %>" attributesText="<%=(attributesText+fixedColumnMark)%>"/><%= type%>
				<%if(fkQueryModel!=null){%>
				<input type="hidden" id="fk_<%=column_acc_Id%>" name="<%=column.getName()%>" value="<%=(coid==-1?"":String.valueOf(coid))%>">
				<%}
			}else if( ds.getObjectType()==DisplaySetting.OBJ_TEXTAREA){
	            java.util.Hashtable htextArea = new java.util.Hashtable();
	            htextArea.put("id", column_acc_Id);
	            htextArea.put("cols", ""+ ds.getCharsPerRow());
	            htextArea.put("rows", ""+  ds.getRows());
	            htextArea.put("wrap", "soft");
	            htextArea.put("tabIndex", (++tabIndex)+"");
	            htextArea.put("class", TableQueryModel.getTextAreaInputCssClass(columnsPerRow,column));
				%>
				<input:textarea name="<%=inputName%>" attributes="<%= htextArea %>" default="<%=dataWithoutNBSP %>" attributesText="<%=(attributesText+fixedColumnMark)%>"/><%= type%>
				
    <%      }else if( ds.getObjectType()==DisplaySetting.OBJ_CLOB){
    				net.fckeditor.FCKeditor fckEditor = new net.fckeditor.FCKeditor(request,column_acc_Id,"98%","370px",null, null, "/html/nds/js/fckeditor");
    				fckEditor.setValue(dataWithoutNBSP==null?"":dataWithoutNBSP);
				%>
				<%=fckEditor%>
    <%      }else if ( ds.getObjectType()==DisplaySetting.OBJ_FILE){
    %>		
    			<input type='hidden' name="<%=inputName%>" value="<%=dataDB==null?"":dataDB%>">
    			<%=dataWithoutNBSP%>
    <%		}else if( ds.getObjectType()==DisplaySetting.OBJ_IMAGE){
    			int maximagewidth= (ds.getColumns()==1?200:500);
    %>
    			<input type='hidden' name="<%=inputName%>" value="<%=dataDB==null?"":dataDB%>">
    			<%if(!nds.util.Validator.isNull((String)dataDB)){%>
    				<a href="<%=dataDB%>"><img border=0 src="<%=dataDB%>" class="img-<%=columnsPerRow%>-<%=ds.getColumns()%>"  onmousewheel="resize_img_by_wheel(this);"></a>
    			<%}%>	
    <%  	}else if( ds.getObjectType()==DisplaySetting.OBJ_XML){
    			java.util.Hashtable hxml = new java.util.Hashtable();
	            hxml.put("tabIndex", (++tabIndex)+"");
	            
	            hxml.put("class",ds.getRows()>1? TableQueryModel.getTextAreaInputCssClass(columnsPerRow,column):TableQueryModel.getTextInputCssClass(columnsPerRow,column));
	            String filterXml=(dataDB==null?"":dataDB.toString());
	            nds.schema.Filter fo=new nds.schema.Filter(filterXml);
	         %>
	            <input:filter id="<%=column_acc_Id%>" columnId="<%=String.valueOf(column.getId())%>" desc="<%=fo.getDescription()%>" xml="<%=filterXml%>" name="<%=inputName%>" attributes="<%=hxml%>" attributesText=""/>
	<% 		}else{
    			throw new NDSException("Unexpected condition flow reached for "+ column +"("+ds.getObjectType()+")!"+ ", values="+ values);
    		}
    		// adding button if possible
            if(column.getReferenceTable() !=null){
                if(isFixedColumn==false){
                %>
                <span id="<%=namespace%>cbt_<%=column.getId()%>"  onaction="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' title='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
                <script>
                	<%if(Validator.isNotNull(column.getRegExpression())){%>
                		createAction("<%=column_acc_Id%>", "<%=column.getRegExpression()%>");
                	<%}%>	
                	createButton(document.getElementById("<%=namespace%>cbt_<%=column.getId()%>"));
                </script>
                <%if (coid !=-1){%>
                	<a href='<%=QueryUtils.getTableRowURL(column.getReferenceTable(),true)+"&id="+coid%>'><%= PortletUtils.getMessage(pageContext, "ref-object-view" ,"|")%></a>
                <%}
                }
            }
            if ( ds.getObjectType()==DisplaySetting.OBJ_FILE ||ds.getObjectType()==DisplaySetting.OBJ_IMAGE ){
            %>
            	<a href="javascript:popup_window('<%=NDS_PATH+"/objext/upload.jsp?table="+tableId+"&column="+column.getId()+"&objectid="+objectId%>')"><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/attach.gif' title='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-config" ,null)%>'></a>
            <%
            }
               
        }// end if column isModifiable()
        else{ // begin column not isModifiable()
            if( column.getReferenceTable() !=null){
                if( data==null || "".equals(data)){%> 
                	<%= PortletUtils.getMessage(pageContext, "maintain-by-sys" ,null)%>
                	
                <%}else{
                	String objectURL=QueryUtils.getTableRowURL(column.getReferenceTable(),true);
                	%>
                 	<a href='<%=objectURL+"&input=false&id="+coid%>'><span id="<%=column_acc_Id%>"><%=data%></span></a>
                 <%}
            }else{
                // button check
                if(ds.getObjectType()!=DisplaySetting.OBJ_BUTTON){
	                if( data ==null || "".equals(data)){%>
						<%= PortletUtils.getMessage(pageContext, "maintain-by-sys" ,null)%>
	                <%}else{
	                	 if (ds.getObjectType()==DisplaySetting.OBJ_IMAGE){
			        			int maximagewidth= (ds.getColumns()==1?200:500);
			        			if(!nds.util.Validator.isNull((String)dataDB)){
	                	 	%>
	                	 	<a href="<%=dataDB%>"><img border=0 src="<%=dataDB%>" class="img-<%=columnsPerRow%>-<%=ds.getColumns()%>" onmousewheel="resize_img_by_wheel(this);"></a>
	                	<%     }
	                	 }else{
	                		if(ds.getObjectType()==DisplaySetting.OBJ_TEXTAREA){
            					java.util.Hashtable htextArea = new java.util.Hashtable();
            					htextArea.put("cols", ""+ ds.getCharsPerRow());
            					htextArea.put("rows", ""+  ds.getRows());
            					htextArea.put("wrap", "soft");
            					htextArea.put("tabIndex", (++tabIndex)+"");
            					htextArea.put("class", TableQueryModel.getTextAreaInputCssClass(columnsPerRow,column));
							%>
								<input:textarea name="<%=inputName%>" attributes="<%= htextArea %>" default="<%=dataWithoutNBSP %>" attributesText="readonly"/>
							<%}else if( ds.getObjectType()==DisplaySetting.OBJ_CLOB){
    							net.fckeditor.FCKeditor fckEditor = new net.fckeditor.FCKeditor(request,column_acc_Id,"98%","370px","None", null, "/html/nds/js/fckeditor");
    							fckEditor.setValue(dataWithoutNBSP==null?"":dataWithoutNBSP);
							%>
								<%=fckEditor%>
    						<%}else {%>
	                	 	<span id="<%=column_acc_Id%>"><%=data%></span>
	                	 	 <%}
	                	 }
	                }
                }
           }
        }

      }//end if value ==null
                
  %>
    </td>
<%
   if(colIdx%columnsPerRow == (columnsPerRow -1))out.print("</tr>");
    }//for(int i=0;i< columns.size();i++)
 }//not button
%>

</table>
