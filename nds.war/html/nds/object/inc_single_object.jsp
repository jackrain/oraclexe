<table class="<%=uiConfig.getCssClass()%>" cellspacing="1" cellpadding="0" align="center">
<%
    colIdx=-1;
    //lable_des="<a>&nbsp;</a>";
    //String lable_des;
    //String rms;
    for(int i=columnIndex;i< columns.size();i++){
    	colIdx++;
    	columnIndex++;
        column=(Column)columns.get(i);
        String showcomment=column.getShowcomment();
        //out.print("showcomment "+showcomment);
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
		// if button, or security grade greater than user's sgrade, will not display
		boolean shouldDescTdDisplay=!(ds.getObjectType()==DisplaySetting.OBJ_BUTTON || column.getSecurityGrade()>userWeb.getSecurityGrade());
%>
    <td id="tdd_<%=column.getId()%>" width="<%=widthPerColumn*2/3%>%" nowrap align="left" valign='middle' <%=(shouldDescTdDisplay?"class='desc'":"")%>>
	<%
	if(shouldDescTdDisplay){
	//cyl lable 动态关联字段
		if(column.getJSONProps()!=null){
			JSONObject jor=column.getJSONProps();
			if(jor.has("islable")){
				//System.out.println("adsfasdfadsf");
				//System.out.println(data);
				//lable_des=dataWithoutNBSP;
				continue;
			}else if(jor.has("lable")){
		  JSONObject jo=column.getJSONProps().getJSONObject("lable");
		  int lable_id=jo.optInt("id",0);
		  String lable_name=jo.optString("name","");
		  Column lable_col=(Column)table.getColumn(lable_id);
		  //lable_des=lable_col.getDefaultValue(bReplaceVariable);
		  String lable_des=new String();
		  //QueryResultMetaData meta= result.getMetaData();
		  if(result !=null){
      int pos = result.getMetaData().findPositionInSelection(
								lable_col);// starts from 0
		  lable_des= result.getString(pos+1,false);
		  }
			else{
			lable_des= objprefs.getProperty(lable_col.getName(),
						userWeb.getUserOption(lable_col.getName(),lable_col.getDefaultValue(bReplaceVariable)));
				}
		  //System.out.println(lable_col.getDefaultValue(bReplaceVariable));
		  //System.out.println(dataWithoutNBSP1);
//		  System.out.println(desc);
		  //System.out.println(tableId);
		  //支持lable_id change write
    %>
    <div id="tdc_<%=lable_id%>" onclick="oc.lable_change(<%=lable_id%>);" class="desc-txt<%=column.isNullable()?"":" nn"%>"><FONT face='华文行楷' color='blue' size=5><%=lable_des%>:</FONT></div>
    <input style="display:none;width:83px;" name="<%=lable_name%>" id="column_<%=lable_id%>" type="text" maxLength="16" value="<%=lable_des%>"/>
   <%}else if(jor.has("reflable")){
   	 JSONObject jo=column.getJSONProps().getJSONObject("reflable");
   	 int lable_id=jo.optInt("ref_id",0);
		 int lable_tabid=jo.optInt("tabid",0);
		 Table reftable= manager.getTable(lable_tabid);
		 query=QueryEngine.getInstance().createRequest(userWeb.getSession());
		 query.setMainTable(lable_tabid);
		 query.addSelection(reftable.getAlternateKey().getId());
		 query.addParam( reftable.getPrimaryKey().getId(), ""+ lable_id);
	   QueryResult rs=QueryEngine.getInstance().doQuery(query); 
	   if(lable_id !=0 || (rs!=null && rs.getTotalRowCount()>0)){
	    while(rs.next()) {
	       desc=rs.getObject(1).toString(); 
	    }
	  }%>
	  <div class="desc-txt<%=column.isNullable()?"":" nn"%>"><%=desc%>:</div>
    <%}else {%>
   	<div class="desc-txt<%=column.isNullable()?"":" nn"%>"><%=desc%>:</div>
	 <%}%>
   <%}else{ %>
    <div class="desc-txt<%=column.isNullable()?"":" nn"%>"><%=desc%>:</div>
	 <%}%>
<%}%>
    </td>
    <td  id="tdv_<%=column.getId()%>" class="value" width="<%=widthPerColumn*4/3%>%" nowrap align="left" valign='middle' <%=(ds.getColumns()-1)*2>0? "colspan='"+((ds.getColumns()-1)*2+1)+"'":"" %>>
      <%
    //check security grade
    if( userWeb.getSecurityGrade()>=column.getSecurityGrade()){
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
						a.put("onkeydown", "oc.moveTableFocus(event)");
                    %>
                    <input:select name="<%=inputName%>" default="<%=dataValue%>" attributes="<%= a %>" options="<%= o %>" attributesText="<%=(attributesText+fixedColumnMark)%>" />
                    <%
                    }
                }else{%>
                    <span id="<%=column_acc_Id%>"><%=data%></span>
               <%}
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
						a.put("onkeydown", "oc.moveTableFocus(event)");
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
				h.put("onkeydown", "oc.moveTableFocus(event)");
	            if(fkQueryModel!=null){
	            	//add key catcher 
	            	//h.put("onkeydown",fkQueryModel.getKeyEventScript());
	            	//column.getRegExpression() may be a javascript function 
	            	if(column.isFilteredByWildcard() && Validator.isNotNull(column.getRegExpression())){
	            		h.put("readonly","readonly");
	            	}
	  						if(WebUtils.getBrowserType(request)==0){
	  						//特此注意在IE8下可能发生value循环BUG
							//修正bug在ie8下如果有查询条件设有过滤时
							//查询返回结果焦点触发onblur清除id的问题
	            	h.put("onKeyPress","oc.onKeyPress(event)");
		            }else{
		            h.put("oninput","oc.onKeyPress(event)");	
		            	//h.put("onblur", "oc.isempty("+column_acc_Id+","+"fk_"+column_acc_Id+")");
		            }
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
				//System.out.print(inputName+"       "+column.getSQLType());
               if (column.getType() == 3)
                    h.put("onfocus", "WdatePicker()");
                    else if (column.getType() == 1) {
                   h.put("onfocus", "WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss'})");
                }
                h.put("title", model.getInputBoxIndicator(column,column_acc_Id,locale));
                String attributeText2= (column.getJSONProps()!=null?column.getJSONProps().optString("input_attr",""):"");
                //System.out.println(column.getName()+"~~~"+attributeText2+"!!!!!!!!!!!!!!!!!");
	            %>
	     <%
	      if(column.getJSONProps()!=null){
				JSONObject jor=column.getJSONProps();
				if(jor.has("ispassword")){ %>
				<input:password name="<%=inputName%>" attributes="<%= h %>" default="<%=dataWithoutNBSP %>" attributesText="<%=(attributeText2+" "+attributesText+fixedColumnMark)%>"/><%= type%>
			<%}else{%>
				<input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=dataWithoutNBSP %>" attributesText="<%=(attributeText2+" "+attributesText+fixedColumnMark)%>"/><%= type%>
			<%}}else{%>
	      <input:text name="<%=inputName%>" attributes="<%= h %>" default="<%=dataWithoutNBSP %>" attributesText="<%=(attributeText2+" "+attributesText+fixedColumnMark)%>"/><%= type%>
				<%}%>
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
				//htextArea.put("onkeydown", "oc.moveTableFocus(event)");
				%>
				<input:textarea name="<%=inputName%>" attributes="<%= htextArea %>" default="<%=dataWithoutNBSP %>" attributesText="<%=(attributesText+fixedColumnMark)%>"/><%= type%>
				
    <%      }else if( ds.getObjectType()==DisplaySetting.OBJ_CLOB){
    				/**
    				net.fckeditor.FCKeditor fckEditor = new net.fckeditor.FCKeditor(request,column_acc_Id,"98%","370px",null, null, "/html/nds/js/fckeditor");
    				fckEditor.setValue(dataWithoutNBSP==null?"":dataWithoutNBSP);
							**/
				com.ckeditor.CKEditorConfig settings = new com.ckeditor.CKEditorConfig();
				settings.addConfigValue("width", "800");
				//settings.addConfigValue("width", "200");				 
				com.ckeditor.EventHandler eventHandler = new com.ckeditor.EventHandler();
				eventHandler.addEventHandler("instanceReady", "function iResize(ev) {var iFrames = jQuery('iframe');var height=0;for (var i = 0, j = iFrames.length; i < j; i++) {height += iFrames[i].contentWindow.document.body.offsetHeight;}ev.editor.resize(800,height+200);}");

            
				%>
				<textarea cols="80" id="<%=column_acc_Id%>" name="<%=column_acc_Id%>" rows="10"><%=dataWithoutNBSP==null?"":dataWithoutNBSP%></textarea>
				<ckeditor:replace replace="<%=column_acc_Id%>" config="<%=settings%>" events="<%=eventHandler%>" basePath="/html/nds/js/ckedit/ckeditor/" />
				<!--div class="toggleFCKeditorBar"><a href="javascript:toggleFCKeditor(FCKeditorAPI.GetInstance('<%=column_acc_Id%>'));">
					<span id="<%=column_acc_Id%>_tb"><%= PortletUtils.getMessage(pageContext, "switch-fckeditor",null)%></span></a>
				</div-->
				<!--%=fckEditor%-->
				<!--ckeditor:editor basePath="/html/nds/js/ckedit/ckeditor/" config="<%=settings%>" events="<%=eventHandler%>" editor="<%=column_acc_Id%>" value="<%=dataWithoutNBSP%>" /-->
    <%      }else if ( ds.getObjectType()==DisplaySetting.OBJ_FILE){
    %>		
    			<input id="<%=column_acc_Id%>" type='hidden' name="<%=inputName%>" value="<%=dataDB==null?"":dataDB%>">
    			<span id="att_<%=column_acc_Id%>"><%=dataWithoutNBSP==null?"":dataWithoutNBSP%></span>
    <%		}else if( ds.getObjectType()==DisplaySetting.OBJ_IMAGE){
    			int maximagewidth= (ds.getColumns()==1?200:500);
    %>
				<input type='hidden' id="<%=column_acc_Id%>" name="<%=inputName%>" value="<%=dataDB==null?"":dataDB%>">
				<%
				String imgHREFStyle="";
				String Pdata="";
				if(nds.util.Validator.isNull((String)dataDB)){
					imgHREFStyle="style='display:none;'";
				}
				if(dataDB!=null&&((String)dataDB).indexOf("Attach")>0){
				Pdata=dataDB+"&thum=Y";
				}else{
				Pdata=(String)dataDB;
				}
    			%>
				<a <%=imgHREFStyle%> id="imga_<%=column_acc_Id%>" target="_blank" href="<%=dataDB==null?"":dataDB%>"><img id="img_<%=column_acc_Id%>" border=0 src="<%=dataDB==null?"":Pdata%>" class="img-<%=columnsPerRow%>-<%=ds.getColumns()%>"  >
	<%			if(column.getJSONProps()!=null&&dataDB!=null){
				JSONObject jor=column.getJSONProps();
				if(jor.has("imgshow")){
					JSONObject img_opt=null;
					JSONObject jo=column.getJSONProps().getJSONObject("imgshow");
					if(jo.has("option")){
						img_opt=jo.getJSONObject("option");
					}
				%>
				<script>
					try{jQuery('#imga_<%=column_acc_Id%>').jqzoom(<%=img_opt%>);}catch(e){};
				</script>
				<%}
				}%>
				</a>
	<%			}else if( ds.getObjectType()==DisplaySetting.OBJ_XML){
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
                <span id="<%=namespace%>cbt_<%=column.getId()%>"  onclick="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' title='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
                <script>
                	<%if(Validator.isNotNull(column.getRegExpression())){%>
                		createAction("<%=column_acc_Id%>", "<%=column.getRegExpression()%>");
                	<%}%>	
                	createButton(document.getElementById("<%=namespace%>cbt_<%=column.getId()%>"));
                </script>
                <%if (coid !=-1){%>
                	<a <%=fkURLTarget%> href='<%=QueryUtils.getTableRowURL(column.getReferenceTable(),true)+"&id="+coid%>'><img border="0" src="/html/nds/images/out.png"/></a>
                <%}
                }
            }else if(column.getJSONProps()!=null){
            	//动态配置弹出动作定义qlink
			      JSONObject jor=column.getJSONProps();
						if(jor.has("qlink")){
							JSONObject jo=column.getJSONProps().getJSONObject("qlink");
							String on_ac=jo.optString("ac","");
              %>
                <span id="<%=namespace%>cbt_<%=column.getId()%>"  onclick="<%=on_ac%>"><img border=0 width=16 height=16 align=absmiddle src='/html/nds/images/find.gif' title='Find'></span>
              <%
							}
            }
            if ( ds.getObjectType()==DisplaySetting.OBJ_FILE ||ds.getObjectType()==DisplaySetting.OBJ_IMAGE ){
            
            %>
             <span id="<%=namespace%>att_<%=column.getId()%>" onclick="javascript:showDialog('<%=NDS_PATH+"/objext/upload.jsp?table="+tableId+"&column="+column.getId()+"&objectid="+objectId+"&input="+column_acc_Id%>',940, 400,false)"><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/attach.gif' title='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-config" ,null)%>'>
             </span>
             <script>
  						createButton(document.getElementById("<%=namespace%>att_<%=column.getId()%>"));
  	  			 </script>
            <%
            }
            //自动备注显示 cyl 10.11
            //out.print(showcomment);
            if (showcomment.equals("Y")){
            	//out.print(showcomment);
            	String rms=TableManager.getInstance().getComments(column);
            	%>
              <div id="rms_<%=column.getId()%>" class="obj-rms_v"><%=rms==null?"":rms%></div>
              <script type="text/javascript">  
        			jQuery(function(){  
            			jQuery("#column_"+<%=column.getId()%>).focus(function () {  
  									jQuery("#rms_"+<%=column.getId()%>).css('display','block'); 
            			 }).blur(function () {  
                		jQuery("#rms_"+<%=column.getId()%>).css('display','none');
            			});  
        				});  
    					</script>
            	<%}
               
        }// end if column isModifiable()
        else{ // begin column not isModifiable()
            if( column.getReferenceTable() !=null){
                if( data==null || "".equals(data)){%> 
                	<%= PortletUtils.getMessage(pageContext, "maintain-by-sys" ,null)%>
                	
                <%}else{
                	String objectURL=QueryUtils.getTableRowURL(column.getReferenceTable(),true);
                	%>
                 	<a <%=fkURLTarget%> href='<%=objectURL+"&input=false&id="+coid%>'><span id="<%=column_acc_Id%>"><%=data%></span></a>
                 <%}
            }else{
                // button check
                if(ds.getObjectType()==DisplaySetting.OBJ_BUTTON){
                	nds.web.button.ButtonCommandUI uic= (nds.web.button.ButtonCommandUI)column.getUIConstructor();
                	out.print( uic.constructHTML(request, column, objectId));
                }else{// not button
	                if( data ==null || "".equals(data)){%>
						<%= PortletUtils.getMessage(pageContext, "maintain-by-sys" ,null)%>
	                <%}else{
	                	 if (ds.getObjectType()==DisplaySetting.OBJ_IMAGE){
			        			int maximagewidth= (ds.getColumns()==1?200:500);
			        			if(!nds.util.Validator.isNull((String)dataDB)){
	                	 	%>
	                	 	<a <%=fkURLTarget%> href="<%=dataDB%>"><img border=0 src="<%=dataDB%>" class="img-<%=columnsPerRow%>-<%=ds.getColumns()%>" onmousewheel="resize_img_by_wheel(this);"></a>
	                	<%     }
	                	 }else{
	                		if(ds.getObjectType()==DisplaySetting.OBJ_TEXTAREA || ds.getObjectType()==DisplaySetting.OBJ_XML){
            					java.util.Hashtable htextArea = new java.util.Hashtable();
            					htextArea.put("cols", ""+ ds.getCharsPerRow());
            					htextArea.put("rows", ""+  ds.getRows());
            					htextArea.put("wrap", "soft");
            					htextArea.put("tabIndex", (++tabIndex)+"");
            					htextArea.put("class", TableQueryModel.getTextAreaInputCssClass(columnsPerRow,column));
							%>
								<input:textarea name="<%=inputName%>" attributes="<%= htextArea %>" default="<%=dataWithoutNBSP %>" attributesText="readonly"/>
							<%}else if( ds.getObjectType()==DisplaySetting.OBJ_CLOB){
								/**
    							net.fckeditor.FCKeditor fckEditor = new net.fckeditor.FCKeditor(request,column_acc_Id,"98%","370px","None", null, "/html/nds/js/fckeditor");
    							fckEditor.setValue(dataWithoutNBSP==null?"":dataWithoutNBSP);
							   **/
							   com.ckeditor.CKEditorConfig settings = new com.ckeditor.CKEditorConfig();
								settings.addConfigValue("width", "800");				 
								com.ckeditor.EventHandler eventHandler = new com.ckeditor.EventHandler();
								eventHandler.addEventHandler("instanceReady", "function iResize(ev) {var iFrames = jQuery('iframe');var height=200;for (var i = 0, j = iFrames.length; i < j; i++) {height += iFrames[i].contentWindow.document.body.offsetHeight;}ev.editor.resize(800,height);}");

							%>
								<!--%=fckEditor%-->
								<!--ckeditor:editor basePath="/html/nds/js/ckedit/ckeditor/" config="<%=settings%>" events="<%=eventHandler%>" editor="<%=column_acc_Id%>" value="<%=dataWithoutNBSP%>" /-->
    						<textarea cols="80" id="<%=column_acc_Id%>" name="<%=column_acc_Id%>" rows="10"><%=dataWithoutNBSP==null?"":dataWithoutNBSP%></textarea>
    						<ckeditor:replace replace="<%=column_acc_Id%>" config="<%=settings%>" events="<%=eventHandler%>" basePath="/html/nds/js/ckedit/ckeditor/" />			
    						<%}else {%>
	                	 	<span id="<%=column_acc_Id%>"><%=data%></span>
	                	 	 <%}
	                	 }
	                }
                }
           }
        }

      }//end if value ==null
  }// end security grade check          
  %>
    </td>
<%
   if(colIdx%columnsPerRow == (columnsPerRow -1))out.print("</tr>");
    }//for(int i=0;i< columns.size();i++)
%>
</table>
