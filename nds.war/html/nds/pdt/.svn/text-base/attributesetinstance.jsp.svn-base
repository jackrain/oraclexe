<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
	/**
	if attributesetinstanceid or attributeset id not found in request parameter, redirect to set selection page first
	@param id - attributesetinstanceid
	@param setid - attributesetid
    @param input - false for view only
	*/
	int id= Tools.getInt(request.getParameter("id"), -1);
	int setId = Tools.getInt(request.getParameter("setid"), -1);
	if(setId==-1 && id==-1){
		//redirect to set selection page
		pageContext.getServletContext().getRequestDispatcher(NDS_PATH+"/pdt/sel_attributeset.jsp").forward(request,response);
		return;
	}
	boolean isInput=ParamUtils.getBooleanParameter(request, "input",true);
	String tabName=nds.schema.TableManager.getInstance().getTable("m_attributesetinstance").getDescription(locale);
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=tabName%>" />
</liferay-util:include>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%!
  private String getDisplayData(String v){
  	return Validator.isNull(v)? "&nbsp;":v;
  }
%>
<%
TableManager manager=TableManager.getInstance();
Table table= manager.getTable("m_attributeset");
if(id!=-1){
	int objPerm= userWeb.getObjectPermission("M_ATTRIBUTESETINSTANCE", id);
	if((objPerm & nds.security.Directory.WRITE )!= nds.security.Directory.WRITE ){
		if(objPerm==0) throw new NDSException("@no-permission@");
		else isInput=false;
	}
}else{
	int dirPerm=userWeb.getPermission("M_ATTRIBUTESETINSTANCE_LIST");
	if((dirPerm  & nds.security.Directory.WRITE) != nds.security.Directory.WRITE )
		 throw new NDSException("@no-permission@");
}

QueryEngine engine=QueryEngine.getInstance();

List instanceProperties=null;
HashMap instanceValues=new HashMap();// key m_attribute.id (integer), value: attributeinstance.valueid or value when valueid is empty
HashMap instanceDisplayValues= new HashMap(); // key m_attribute.id (integer), value: attributeinstance.value (string)
if(id!=-1){
	instanceProperties=engine.doQueryList("select description,M_ATTRIBUTESET_ID,to_char(GUARANTEEDATE,'YYYY/MM/DD'),M_LOT_ID,SERNO,LOT from m_attributesetinstance where id="+id);
	if(instanceProperties==null){
		id= -1;
			
	}else {
	  setId=Tools.getInt( ((List)instanceProperties.get(0)).get(1),-1);
	  List iv= engine.doQueryList("select i.M_ATTRIBUTE_ID, i.VALUE, i.M_ATTRIBUTEVALUE_ID, case when v.name=v.value then v.name else  v.name||'(' || v.value ||')' end from m_attributeinstance i, m_attributevalue v where i.M_ATTRIBUTESETINSTANCE_ID="+ id+ " and v.id(+)=i.M_ATTRIBUTEVALUE_ID");
	  if(iv!=null){
  		for(int i=0;i<iv.size();i++){
  			if( ((List)iv.get(i)).get(2)!=null){
				// list box			
				instanceValues.put( new Integer(Tools.getInt( ((List)iv.get(i)).get(0),-1)),
  			 		String.valueOf(((List)iv.get(i)).get(2)));
	  			instanceDisplayValues.put( new Integer(Tools.getInt( ((List)iv.get(i)).get(0),-1)),
  			 		((List)iv.get(i)).get(3));
  			}else{
  				// not list
  				instanceValues.put( new Integer(Tools.getInt( ((List)iv.get(i)).get(0),-1)),
  			 		((List)iv.get(i)).get(1));
				instanceDisplayValues.put( new Integer(Tools.getInt( ((List)iv.get(i)).get(0),-1)),
  			 		((List)iv.get(i)).get(1));  			 	
  			}
  		}
	  }
	}
}
if(instanceProperties==null){
	ArrayList ip=new ArrayList();
	ip.add("");
	ip.add(new Integer(-1));
	ip.add("");
	ip.add(new Integer(-1));
	ip.add("");
	ip.add("");
	instanceProperties=new ArrayList();
	instanceProperties.add(ip);
}

List attributeSetProperties=(List)engine.doQueryList("select name, ISSERNO,M_SERNOCTL_ID,ISSERNOMANDATORY,ISLOT,M_LOTCTL_ID,ISLOTMANDATORY,ISGUARANTEEDATE,GUARANTEEDAYS,ISGUARANTEEDATEMANDATORY from m_attributeset where id="+ setId).get(0);
String attribueSetName=(String)attributeSetProperties.get(0);
List attributes=engine.doQueryList("select a.id, a.name,a.ATTRIBUTEVALUETYPE,a.ISMANDATORY,a.DESCRIPTION from m_attribute a, m_attributeuse u where a.id=u.m_attribute_id and u.m_attributeset_id="+setId+" order by u.orderno asc");
//if(attributes.size()<1) throw new NDSException("Not find List type attribute in set id="+ setId);
List attributeValues=new ArrayList(); //elements are List, whose elements are List with 2 elements, first is id, second is desc
for(int i=0;i< attributes.size();i++){
	attributeValues.add( engine.doQueryList("select v.id, case when v.name=v.value then v.name else  v.name||'(' || v.value ||')' end from m_attributevalue v where v.m_attribute_id="+((List)attributes.get(i)).get(0)));
}
ArrayList validCommands=new ArrayList();
ButtonFactory cf= ButtonFactory.getInstance(pageContext,locale);
if(isInput)
validCommands.add(cf.newButtonInstance("CreateAttributeSetInstance",pageContext));
else{
validCommands.add("GoModifyPage");
}
String form_name="form1";
Column instanceDescColumn=TableManager.getInstance().getColumn("m_attributesetinstance","description");
String inputName, dataValue,desc,type;
Column column;

%>
<!--iframe id=CalFrame name=CalFrame frameborder=0 src=<%=NDS_PATH%>/common/calendar.jsp style=display:none;position:absolute;z-index:99999></iframe-->
<!--script language="javascript" src="<%=NDS_PATH%>/js/calendar.js"></script-->
<script language="JavaScript" src="<%=NDS_PATH%>/js/formkey.js"></script>
<script>
function doGoModifyPage(){
	window.location="<%=NDS_PATH+"/pdt/attributesetinstance.jsp?id="+ id+"&input=true"%>";
}
function generateLot(lotctlid){
<%//currrently lot is not controlled by m_lotctrl%>
}
function generateSerNO(serctlid){
	form1.btnserno.disabled=true;
	showProgressWnd();
	hidden_iframe.document.location="<%=NDS_PATH%>/pdt/genserno.jsp?id="+serctlid;
}

function checkSelected(optionControl, desc){
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
function doCreateAttributeSetInstance(){
	var form=form1;
	if(!checkNotNull(form.name,"<%=instanceDescColumn.getDescription(locale)%>"))return false;		
<%
	if(	"Y".equals(attributeSetProperties.get(1)) && "Y".equals(attributeSetProperties.get(3))){
		out.println(" if(!checkNotNull(form.serno,\""+ manager.getColumn("m_attributesetinstance","SERNO").getDescription(locale)+"\")) return false;");
	}
	if(	"Y".equals(attributeSetProperties.get(4)) && "Y".equals(attributeSetProperties.get(6))){
		out.println(" if(!checkNotNull(form.lot,\""+ manager.getColumn("m_attributesetinstance","lot").getDescription(locale)+"\")) return false;");
	}
	if(	"Y".equals(attributeSetProperties.get(7)) && "Y".equals(attributeSetProperties.get(9))){
		out.println(" if(!checkNotNull(form.guaranteedate,\""+ manager.getColumn("m_attributesetinstance","guaranteedate").getDescription(locale)+"\")) return false;");
	}
	for(int i=0;i<attributes.size();i++){
		boolean isMandatory="Y".equals( ((List)attributes.get(i)).get(3));
		inputName= "A"+ ((List)attributes.get(i)).get(0);
		desc=(String) (((List)attributes.get(i)).get(1));
		if("L".equals(((List)attributes.get(i)).get(2))){
			if(isMandatory){
				out.println(" if(!checkSelected(form."+inputName+",\""+desc+"\")) return false;");
			}
		}else{
			if(isMandatory){
				out.println(" if(!checkNotNull(form."+inputName+",\""+desc+"\")) return false;");
			}
			if("N".equals(((List)attributes.get(i)).get(2))){
				out.println(" if(!checkIsNumber(form."+inputName+",\""+desc+"\")) return false;");
			}
		}
		
	}
%>    
    submitForm(form1);
	
}
</script>

<form name="form1" method="post" action="<%=contextPath %>/control/command">
  <input type='hidden' name='id' value='<%=id%>' >
  <input type='hidden' name='setid' value='<%=setId%>' >
  <input type="hidden" name="formRequest" value="<%=NDS_PATH+"/pdt/attributesetinstance.jsp?id="+id+"&setid="+setId%>">  
  <input type='hidden' name="command" value="SaveAttributeSetInstance">
<br>
<%@ include file="/html/nds/objext/inc_command.jsp" %>

<table align="center" border="1" width="98%" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#999999"><tr><td><br>
<table align="center" border="0" width="100%" cellpadding="1" cellspacing="1" align="center" >
<tr><td width="10%" nowrap><%=TableManager.getInstance().getTable("M_attributeset").getDescription(locale)%>:</td><td width="40%" align="left">
<a href="<%=NDS_PATH+"/object/object.jsp?table="+table.getId()+"&id="+setId%>"><%=attribueSetName%></a>
</td><td width="50%">&nbsp;</td></tr>
<%
	int tabIndex=0;
	String defaultValue;
	java.util.Hashtable h = new java.util.Hashtable();
    h.put("id", "instance_desc");
    h.put("size",  String.valueOf(instanceDescColumn.getDisplaySetting().getCharsPerRow()));
    h.put("maxlength", String.valueOf(instanceDescColumn.getLength()));
    h.put("tabIndex", (++tabIndex)+"");
    h.put("class","inputline");
    
	type=TableQueryModel.toTypeIndicator(Column.STRING,instanceDescColumn.getLength(),"","name",locale);
	desc=instanceDescColumn.getDescription(locale);
	defaultValue=  (String)((List)instanceProperties.get(0)).get(0);
%>
<tr><td height="18" width="100" nowrap><%=desc%><font color='red'>*</font>:</td><td colspan=2 align="left">
<% if(isInput){%>
<input:text name="name" attributes="<%= h %>" default="<%=(defaultValue)%>"/><%= type%></td>
<%}else{%>
<%=getDisplayData(defaultValue)%>
<%}%>
</tr>
<%
	if(	"Y".equals(attributeSetProperties.get(1))){
		int sernoctrlId= Tools.getInt(attributeSetProperties.get(2),-1);
		String isSernoMandatory= (String)attributeSetProperties.get(3);
		column= manager.getColumn("m_attributesetinstance","SERNO");
		 h = new java.util.Hashtable();
    	 h.put("id", "serno");
    	 h.put("size",  String.valueOf(column.getDisplaySetting().getCharsPerRow()));
    	 h.put("maxlength", String.valueOf(column.getLength()));
    	 h.put("tabIndex", (++tabIndex)+"");
    	 h.put("class","inputline");
    	type=TableQueryModel.toTypeIndicator(Column.STRING,column.getLength(),"","serno",locale);
    	desc=column.getDescription(locale);
    	if("Y".equals(isSernoMandatory)){
    		desc += "<font color='red'>*</font>";
    	}
    	defaultValue=  (String)((List)instanceProperties.get(0)).get(4);
%>
<tr><td height="18" width="100" nowrap><%=desc%>:</td><td>
<% if(isInput){%>
<input:text name="serno" attributes="<%= h %>" default="<%=(defaultValue)%>"/><%= type%> </td><td>

<%
	    if(sernoctrlId!=-1){
%>	<input type="button" id="btnserno" onclick="generateSerNO(<%=sernoctrlId%>)" value="<%=PortletUtils.getMessage(pageContext, "generate-serno",null)%>">
<%	    }
%>
</td>
<%}else{%>
<%=getDisplayData(defaultValue)%></td><td></td>
<%}%>
</tr>
<%    	
	}// end SERNO
	if(	"Y".equals(attributeSetProperties.get(4))){
		int lotctrlId=  Tools.getInt(attributeSetProperties.get(5),-1);
		String isLotMandatory= (String)attributeSetProperties.get(6);
		column= manager.getColumn("m_attributesetinstance","lot");
 		h = new java.util.Hashtable();
    	 h.put("id", "lot");
    	 h.put("size",  String.valueOf(column.getDisplaySetting().getCharsPerRow()));
    	 h.put("maxlength", String.valueOf(column.getLength()));
    	 h.put("tabIndex", (++tabIndex)+"");
    	 h.put("class","inputline");
    	 type=TableQueryModel.toTypeIndicator(Column.STRING,column.getLength(),"","lot",locale);
    	 desc=column.getDescription(locale);
    	if("Y".equals(isLotMandatory)){
    		desc += "<font color='red'>*</font>";
    	}
    	String url= request.getContextPath()+"/servlets/query?table="+manager.getTable("m_lot").getId()+"&return_type=s&accepter_id="+form_name+".lot";
    	defaultValue=  (String)((List)instanceProperties.get(0)).get(5);
%>

<tr><td height="18" width="100" nowrap><%=desc%>:</td><td height="18" colspan=2>
<%if(isInput){%>
<input:text name="lot" attributes="<%= h %>" default="<%=(defaultValue)%>"/><%= type%> 
<span id="cbt_lot"  onaction=popup_window("<%=url%>","<%="T"+System.currentTimeMillis() %>")><img border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
<script>createButton(document.getElementById("cbt_lot"));</script>
<%
	    if(lotctrlId!=-1){
%>	<input type="button" id="btnlot" onclick="generateLot(<%=lotctrlId%>)" value="<%=PortletUtils.getMessage(pageContext, "generate-lot",null)%>">
<%	    }
}else{%>
 <%=getDisplayData(defaultValue)%>
<%}
%>
</td>
</tr>
<%    	
	}// end Lot
	if("Y".equals(attributeSetProperties.get(7))){
		int days=  Tools.getInt(attributeSetProperties.get(8),-1);
		String isGuaranteeDateMandatory= (String)attributeSetProperties.get(9);
		column= manager.getColumn("m_attributesetinstance","GUARANTEEDATE");
 		h = new java.util.Hashtable();
    	 h.put("id", "guaranteedate");
    	 h.put("size",  String.valueOf(column.getDisplaySetting().getCharsPerRow()));
    	 h.put("maxlength", String.valueOf(column.getLength()));
    	 h.put("tabIndex", (++tabIndex)+"");
    	 h.put("class","inputline");
    	 type=TableQueryModel.toTypeIndicator(Column.DATE,column.getLength(),"","guaranteedate",locale);
    	 desc=column.getDescription(locale);
    	if("Y".equals(isGuaranteeDateMandatory)){
    		desc += "<font color='red'>*</font>";
    	}
    	String defaultDate= (String)((List)instanceProperties.get(0)).get(2);
    	if(Validator.isNull(defaultDate)){
	        Calendar c= Calendar.getInstance();
	        c.setTime(new java.util.Date());
	        c.add(Calendar.DATE, days);
	        defaultDate=((java.text.SimpleDateFormat)QueryUtils.inputDateFormatter.get()).format(c.getTime());
        }
    	
%>
<tr height="18"><td width="100" nowrap><%=desc%>:</td><td colspan=2>
<%if(isInput){%>
<input:text name="guaranteedate" attributes="<%= h %>" default="<%=defaultDate%>"/><%= type%>
<%}else{%>
 <%=getDisplayData(defaultValue)%>
<%}
%>
</td>
</tr>
<%    	
	}// end GUARANTEEDATE
%>	
<tr><td height=18 valign='bottom' align='left' colspan='3'><font class='beta'><b><%=manager.getTable("m_attribute").getDescription(locale)%></b></font><div class='hrRule'></div></td></tr>
<%  

	for(int i=0;i<attributes.size();i++){
		inputName= "A"+ ((List)attributes.get(i)).get(0); // 0 is attribute id
		desc=(String) (((List)attributes.get(i)).get(1)); // 1 is attribute desc
		//defaultValue
		defaultValue=(String) instanceValues.get( new Integer(Tools.getInt(((List)attributes.get(i)).get(0),-1)));
		String displayValue= getDisplayData((String) instanceDisplayValues.get( new Integer(Tools.getInt(((List)attributes.get(i)).get(0),-1))));
		
		if(defaultValue==null) defaultValue="";
		java.util.HashMap a = new java.util.HashMap();
		a.put("tabIndex", (++tabIndex)+"");
		String comment= (String) ((List)attributes.get(i)).get(4);
		if(Validator.isNull(comment)) comment="";
		else comment="----"+ comment;
		if("Y".equals( ((List)attributes.get(i)).get(3))) desc +="<font color='red'>*</font>";
%><tr><td height=18 width=100 nowrap align='left'><%=desc %>:</td><td>

<%		
		if(!isInput){
%>
		<%=displayValue%> </td><td></td></tr>
<%		}else{		
		if("L".equals(((List)attributes.get(i)).get(2))){
			// list
		    StringHashtable o = new StringHashtable();
    		o.put( PortletUtils.getMessage(pageContext, "combobox-select",null),"0");
			List options=(List)attributeValues.get(i);
			if(options!=null)
				for(int j=0;j<options.size();j++){
					o.put( ((List)options.get(j)).get(1), String.valueOf( ((List)options.get(j)).get(0)));
				}
%>
  <input:select name="<%=inputName%>" attributes="<%= a %>" default="<%=(defaultValue)%>" options="<%= o %>"/> 
<%			
		}else if("N".equals(((List)attributes.get(i)).get(2))){
	 		// number
	 		a.put("class","inputline");
	 		type=TableQueryModel.toTypeIndicator(Column.NUMBER,38,"",inputName,locale);
%>	 		
<input:text name="<%=inputName%>" attributes="<%= a %>" default="<%=(defaultValue)%>"/><%= type%>
<%	 	}else{
	 		// string
			a.put("class","inputline");	 		
	 		type=TableQueryModel.toTypeIndicator(Column.STRING,120,"",inputName,locale);
%>
<input:text name="<%=inputName%>" attributes="<%= a %>" default="<%=(defaultValue)%>"/><%= type%>
<%	 	} 
%>	 	
</td><td align='left'><span class='gamma' ><%=comment%></span></td></tr>  
<%		}//end isinput
	}//end attributes
%>


<tr><td colspan=3><br></td></tr>  
</table>
</td></tr></table>
</form>
    </div>
</div>

<%@ include file="/html/nds/footer.jsp" %>
