<%@ include file="/html/nds/common/init.jsp" %>

<%!
private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("processparam.jsp");
%>
<table align="center" border="0" width="100%" cellpadding="1" cellspacing="1" align="center" >

<%
try{
/*
  show process params for input
  
  @param processid - ad_process.id
*/
logger.error( "processparam.jsp:"+ response.getCharacterEncoding()+",out="+out);
int pid= Tools.getInt(request.getParameter("processid"),-1);
if(pid==-1){
%>
<tr><td>
<script>
CxtabControl.prototype.validateProcessParam=function(){
	return true;	
};
</script>
<i><%=PortletUtils.getMessage(pageContext, "no-cxtab-process",null)%></i>
</td></tr>
<%
}else{
String processName= (String)QueryEngine.getInstance().doQueryOne("select name from ad_process where id="+pid);
List params= QueryEngine.getInstance().doQueryList("select name,description,comments,orderno,ad_column_id,valuetype,valuelength,nullable,valuedefault,ad_limitvalue_group_id from ad_process_para where ad_process_id="+pid+" order by orderno asc");
String name,desc,comments, valuetype, nullable, url,type, inputType,valuedefault;
int orderno, columnId, valuelength,limitvalueGroupId;
if(params!=null && params.size()>0){
%>
<tr><td height=18 valign='bottom' align='left' colspan='3'><font class='beta'><b><%=PortletUtils.getMessage(pageContext, "set-cxtab-process-params",null)+"("+processName+")"%></b></font><div class='hrRule'></div>
<script>
CxtabControl.prototype.validateProcessParam=function(){
<%
	if(params!=null)for(int i=0;i<params.size();i++){
		boolean isMandatory=(!"Y".equals( (String)((List)params.get(i)).get(7)));
		name= "preps_"+(String)((List)params.get(i)).get(0);
		desc= (String)((List)params.get(i)).get(1);
		valuetype=(String)((List)params.get(i)).get(5);
		if (Validator.isNull(valuetype)) valuetype="S";
		limitvalueGroupId= Tools.getInt(((List)params.get(i)).get(9),-1);
		if(isMandatory){
			if(limitvalueGroupId==-1){
				out.println(" if(!checkNotNull($(\""+name+"\"),\""+desc+"\")) return false;");
			}else{
				out.println(" if(!checkSelected($(\""+name+"\"),\""+desc+"\")) return false;");
			}
		}
		
		if("N".equals(valuetype)){
			out.println(" if(!checkIsNumber($(\""+name+"\"),\""+desc+"\")) return false;");	
		}else if("D".equals(valuetype)){
			out.println(" if(!checkIsDate($(\""+name+"\"),\""+desc+"\")) return false;");	
		}	
	}
%>    
	return true;	
};
</script>
</td></tr>
<%
	for(int i=0;i<params.size();i++){
		name="preps_"+ (String)((List)params.get(i)).get(0);
		desc= (String)((List)params.get(i)).get(1);
		comments= (String)((List)params.get(i)).get(2);
		if (Validator.isNull(comments)) comments="";
		else comments="--"+ comments;
		orderno=Tools.getInt(((List)params.get(i)).get(3),i);
		columnId= Tools.getInt(((List)params.get(i)).get(4),-1);
		valuetype=(String)((List)params.get(i)).get(5);
		if (Validator.isNull(valuetype)) valuetype="S"; // for string
	
		valuelength=Tools.getInt(((List)params.get(i)).get(6),20);
		nullable=(String)((List)params.get(i)).get(7);
		if (Validator.isNull(nullable)) valuetype="Y"; // for string
		valuedefault=(String)((List)params.get(i)).get(8);
		if (Validator.isNull(valuedefault)) valuedefault=""; // for string
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
		url=null;
		if(columnId!=-1) url=request.getContextPath()+"/servlets/query?table="+TableManager.getInstance().getColumn(columnId).getTable().getId()+"&return_type=s&accepter_id="+name;
%>
    <tr><td height="18" width="10%" nowrap align="left"><%=desc%><%="Y".equals(nullable)?"":"<font color='red'>*</font>"%>:</td>
    <td height="18" width="40%" align="left">
    <%if("text".equals(inputType)){%>
    	<input type='text' class="inputline" MAXLENGTH="<%=valuelength%>" id="<%=name%>" name='<%=name%>' value='<%=valuedefault%>'><%=type%>
	    <%if(url!=null){%>
    	<span id="cbt_<%=name%>"  onclick=popup_window("<%=url%>","<%="T"+System.currentTimeMillis() %>")><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
		<script>createButton(document.getElementById("cbt_<%=name%>"));</script>	
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
    <td align='left' width="50%"><span class='gamma' ><%=comments%></span></td>
    </tr>
<%	}//end for params
%>
<%  }else{
%>
<tr><td>
<script>
CxtabControl.prototype.validateProcessParam=function(){
	return true;	
};
</script>
<i><%=PortletUtils.getMessage(pageContext, "no-cxtab-process-params",null)+"("+processName+")"%></i>
</td></tr>
<%  
  }	
%>
<%
 }//end pid!=-1
}catch(Throwable t){
	logger.error("/html/nds/cxtab/processparam.jsp", t);
	out.print(PortletUtils.getMessage(pageContext, "exception",null)+":"+ t.getMessage());
}%>
</table>	

