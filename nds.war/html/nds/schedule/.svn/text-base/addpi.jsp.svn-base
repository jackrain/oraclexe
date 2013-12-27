<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
	/**
	Create AD_PInstance according to ad_process definition
	@param id - ad_process.id
	*/
	String tabName=PortletUtils.getMessage(pageContext, "create-pinstance",null);
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=tabName%>" />
</liferay-util:include>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * Create AD_PInstance according to ad_process definition
	@param id - ad_process.id
     */
     /**------check permission on ad_pinstance creation---**/
WebUtils.checkDirectoryWritePermission("AD_PINSTANCE_LIST",request);

int pid= Tools.getInt(request.getParameter("id"),-1);
String processName= (String)QueryEngine.getInstance().doQueryOne("select name from ad_process where id="+pid);
List params= QueryEngine.getInstance().doQueryList("select name,description,comments,orderno,ad_column_id,valuetype,valuelength,nullable,valuedefault,ad_limitvalue_group_id from ad_process_para where ad_process_id="+pid+" order by orderno asc");
ArrayList validCommands=new ArrayList();
ButtonFactory cf= ButtonFactory.getInstance(pageContext,locale);
validCommands.add("Submit");//cf.newButtonInstance("CreateProcessInstance",pageContext));
String name,desc,comments, valuetype, nullable, url,type, inputType,valuedefault;
int orderno, columnId, valuelength,limitvalueGroupId;


%>
<iframe id=CalFrame name=CalFrame frameborder=0 src=<%=NDS_PATH%>/common/calendar.jsp style=display:none;position:absolute;z-index:99999></iframe>
<script language="javascript" src="<%=NDS_PATH%>/js/calendar.js"></script>
<script language="JavaScript" src="<%=NDS_PATH%>/js/formkey.js"></script>
<script>
function checkIsDate(control,desc){
if( control==undefined) return true;
    if(!isValidDate(control.value)){
        alert(desc+"<%= PortletUtils.getMessage(pageContext, "must-be-date-type",null)%>!");
        control.focus();
        return false;
    }
    return true;
}
function checkSelected(optionControl, desc){
if( optionControl==undefined) return true;
      for(i=0; i<optionControl.options.length; i++) {
        if (optionControl.options[i].selected) {
            if( optionControl.options[i].value =='0'){
                alert("\<%= PortletUtils.getMessage(pageContext, "please-select",null)%>"+desc+"!");
                optionControl.focus();
                return false;
            }
        }
      }
      return true;
}
function checkNotNull(control,desc){
    if(isWhitespace(control.value)){
        alert(desc+"<%= PortletUtils.getMessage(pageContext, "can-not-be-null",null)%>!");
        control.focus();
        return false;
    }
    return true;
}
function checkIsNumber(control,desc){
    if(isNaN(control.value,10)){//Modify by Hawke
        alert(desc+"<%= PortletUtils.getMessage(pageContext, "must-be-number-type",null)%>!");
        control.focus();
        return false;
    }
    return true;
}
function doSubmit(){
	var form=form1;
	if(!checkNotNull(form.queue,"<%=LanguageUtil.get(pageContext, "auto-update-schedule")%>"))return false;		
<%
	if(params!=null)for(int i=0;i<params.size();i++){
		boolean isMandatory=(!"Y".equals( (String)((List)params.get(i)).get(7)));
		name= (String)((List)params.get(i)).get(0);
		desc= (String)((List)params.get(i)).get(1);
		valuetype=(String)((List)params.get(i)).get(5);
		if (Validator.isNull(valuetype)) valuetype="S";
		limitvalueGroupId= Tools.getInt(((List)params.get(i)).get(9),-1);
		if(isMandatory){
			if(limitvalueGroupId==-1){
				out.println(" if(!checkNotNull(form."+name+",\""+desc+"\")) return false;");
			}else{
				out.println(" if(!checkSelected(form."+name+",\""+desc+"\")) return false;");
			}
		}
		
		if("N".equals(valuetype)){
			out.println(" if(!checkIsNumber(form."+name+",\""+desc+"\")) return false;");	
		}else if("D".equals(valuetype)){
			out.println(" if(!checkIsDate(form."+name+",\""+desc+"\")) return false;");	
		}	
	}
%>    
    submitForm(form1);
	
}
</script>
<p>
<form name="form1" method="post" action="/control/command" >
  <input type='hidden' name='pid' value='<%=pid%>' >
  <input type='hidden' name="command" value="CreateProcessInstance">
<br>
<%@ include file="/html/nds/objext/inc_command.jsp" %>
<table align="center" border="0" width="98%" cellspacing="0" cellpadding="0" align="center"><tr><td><br>
<table align="center" border="0" width="100%" cellpadding="1" cellspacing="1" align="center" >
<tr>
<td height="18" width="100" nowrap align="left"><%=TableManager.getInstance().getTable("ad_process").getDescription(locale) %>:</td>
<td height="18" width="30%" align="left">
<a href="<%=NDS_PATH+"/object/object.jsp?table="+TableManager.getInstance().getTable("ad_process").getId()+"&id="+pid%>"><%=processName%></a>
</td><td align='left'></td>
</tr>

<tr>
<td height="18" width="100" nowrap align="left"><%= LanguageUtil.get(pageContext, "auto-update-schedule") %><font color="red">*</font>:</td>
<td height="18" width="30%" align="left">
<input type="text" class="inputline"  MAXLENGTH="80" id="queueid" name="queue" value="">
<%=TableQueryModel.toTypeIndicator( Column.STRING,80,"","queue",locale)%>
<span id="cbt_pq"  onaction=popup_window("<%="/servlets/query?table="+TableManager.getInstance().getTable("ad_processqueue").getId()+"&return_type=s&accepter_id="%>form1.queueid","<%="T"+System.currentTimeMillis() %>")><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
<script>createButton(document.getElementById("cbt_pq"));</script>	
</td><td></td>
</tr>
<tr>
<td height="18" width="100" nowrap align="left"><%= LanguageUtil.get(pageContext, "record-no") %>:</td>
<td height="18" width="30%" align="left">
<input type="text" class="inputline"  MAXLENGTH="40" id="recordno" name="recordno" value="">
<%=TableQueryModel.toTypeIndicator( Column.STRING,40,"","queue",locale)%>
</td><td align='left'><span class='gamma' >--<%=LanguageUtil.get(pageContext, "record-no-comments") %></span></td>
</tr>

<tr><td height=18 valign='bottom' align='left' colspan='3'><font class='beta'><b><%=TableManager.getInstance().getTable("ad_pinstance_para").getDescription(locale)%></b></font><div class='hrRule'></div></td></tr>
<%
if(params!=null)for(int i=0;i<params.size();i++){
	name= (String)((List)params.get(i)).get(0);
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
	if(columnId!=-1) url=request.getContextPath()+"/servlets/query?table="+TableManager.getInstance().getColumn(columnId).getTable().getId()+"&return_type=s&accepter_id=form1."+name;
%>
    <tr><td height="18" width="120" nowrap align="left"><%=desc%><%="Y".equals(nullable)?"":"<font color='red'>*</font>"%>:</td>
    <td height="18" width="30%" align="left">
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
    <td align='left'><span class='gamma' ><%=comments%></span></td>
    </tr>
<%}//end params%>
 </table><br><br>
</td></tr></table> 
 </form>
    </div>
</div>	
<%@ include file="/html/nds/footer.jsp" %>
