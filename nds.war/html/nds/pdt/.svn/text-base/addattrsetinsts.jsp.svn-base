<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>

<%!
/**
 draw table of n level, checkbox name should in format like '_id1_id2_id3', id1 for first level,id2 for second, and so on
 @param prefix - is the prefix for checkbox name, for level 0, it will be "", for level 1, it will be "_id1", for level 2 "id1_ids2"
 
*/
 private StringBuffer getAttributeTable(int level, List attributes,List attributeValues, String prefix){
	int attrId=Tools.getInt( ((List)attributes.get(level)).get(0),-1);
	String attrName= (String)((List)attributes.get(level)).get(1);
	List attrValues= (List) attributeValues.get(level);
	StringBuffer sb=new StringBuffer();
	int levels= attributes.size();
	sb.append("<table align='left' border='1' cellspacing='0' align='center' bordercolordark='#FFFFFF' bordercolorlight='#999999'>");
	int j,k, vId, lastVId;
	String vDesc, lastVDesc;
	if(level<levels-2 && levels>2){
	 	//iteration
		for(j=0;j<attrValues.size();j++){
	 		vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);	
	 		sb.append("<tr><td><input type='checkbox' id='").append(prefix).append("_").append(vId).
	 		append("' onclick='selectAll(\"").append(prefix).append("_").append(vId).append("\")'>").
	 		append(vDesc).append("</td><td>&nbsp;</td></tr>");
	 		sb.append("<tr><td>&nbsp;</td><td>").append(
	 		getAttributeTable(level+1,attributes,attributeValues, prefix+"_"+vId)).
	 		append("</td></tr>");
	 	}
 	}else if(level==levels-2){
 		// table, first row is the last level, first column is the second last level
 		int lastAttrId= Tools.getInt(((List)attributes.get(level+1)).get(0),-1);
 		String lastAttrName= (String)((List)attributes.get(level+1)).get(1);
 		List lastAttrValues= (List) attributeValues.get(level+1);
 		
 		sb.append("<tr><td>&nbsp;</td>");
 		for(j=0;j<lastAttrValues.size();j++){
	 		lastVDesc= (String)((List)lastAttrValues.get(j)).get(1);	
	 		lastVId= Tools.getInt(((List)lastAttrValues.get(j)).get(0),-1);
	 		sb.append("<td><span class='cursor' onclick='selectAll2(\"").append(prefix).
	 		append("\",\"").append("_").append(lastVId).
	 		append("\")'>").append(lastVDesc).append("</span></td>");
	 	}
	 	sb.append("</tr>");
 		for(j=0;j<attrValues.size();j++){
 			vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);	
	 		sb.append("<tr><td><span class='cursor' onclick='selectAll(\"").append(prefix).append("_").append(vId).
	 		append("\")'>").append(vDesc).append("</span></td>");
	 		for(k=0;k<lastAttrValues.size();k++){
	 			lastVId =Tools.getInt(((List)lastAttrValues.get(k)).get(0),-1);	
	 			sb.append("<td><input type='checkbox' name='instance' id='").
	 			append(prefix).append("_").append(vId).append("_").append(lastVId).append("' value='").
	 			append(prefix).append("_").append(vId).append("_").append(lastVId).append("'></td>");
	 		}
	 		sb.append("</tr>");
	 	}
 	}else{
 		// only one column
 		for(j=0;j<attrValues.size();j++){
	 		vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);	
	 		sb.append("<tr><td><input type='checkbox' name='instance' value='_").append(vId).append("'>").append(vDesc).append("</td></tr>");
	 	}
 	}
	sb.append("</table>");
 	return sb;
 }
%>
<%
/*
  Add attributeSetInstance(s) for select attributeSet.
  The attributeSet should have at least one List type attribute.
  
  The created page will be a indent tree table type, last attribute will be show as column of the tree table
  @param objectid - m_attributeset.id
*/
int objectId= Tools.getInt(request.getParameter("objectid"),-1);     
int columnId= Tools.getInt(request.getParameter("columnid"),-1);


TableManager manager=TableManager.getInstance();
Table table= manager.getColumn(columnId).getTable();

if((userWeb.getPermission("M_ATTRIBUTESETINSTANCE_LIST")& nds.security.Directory.WRITE )!= nds.security.Directory.WRITE )
	throw new NDSException("@no-permission@");

QueryEngine engine=QueryEngine.getInstance();
String attribueSetName=(String) engine.doQueryOne("select name from m_attributeset where id="+ objectId);
List attributes=engine.doQueryList("select a.id, a.name from m_attribute a, m_attributeuse u where a.ATTRIBUTEVALUETYPE='L' and a.id=u.m_attribute_id and u.m_attributeset_id="+objectId+" order by u.orderno asc");
if(attributes.size()<1) throw new NDSException("Not find List type attribute in set id="+ objectId);
List attributeValues=new ArrayList(); //elements are List, whose elements are List with 2 elements, first is id, second is desc
for(int i=0;i< attributes.size();i++){
	attributeValues.add( engine.doQueryList("select v.id, case when v.name=v.value then v.name else  v.name||'(' || v.value ||')' end from m_attributevalue v where v.m_attribute_id="+((List)attributes.get(i)).get(0)));
}

request.setAttribute("page_help", "AddAttributeSetInstances");
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="body_background" value="<%=colorScheme.getPortletBg()%>" />
	<liferay-util:param name="html_title" value="<%=PortletUtils.getMessage(pageContext, "create-attribute-instances",null)%>" />
</liferay-util:include>
<STYLE>
<!--
.cursor {  cursor: hand}
-->
</STYLE>
<script>

function selectAll2(prefix,checkBoxId){
    var b=true;
    var leng= checkBoxId.length;
	for (var i = 0; i < form1.length; i++){
	  var e = form1.elements[i];
   	  if (e.type.toLowerCase() == "checkbox" && e.name=='instance' && e.id.indexOf(prefix)==0 &&
   	  	e.id.length>leng && e.id.substr(e.id.length-leng)==checkBoxId) {
		 b=!e.checked;
		 break;
	  }
	}   	
	for (var i = 0; i < form1.length; i++){
	  var e = form1.elements[i];
   	  if (e.type.toLowerCase() == "checkbox" && e.name=='instance' && e.id.indexOf(prefix)==0 &&
   	  	e.id.length>leng && e.id.substr(e.id.length-leng)==checkBoxId) {
		 e.checked=b;
	  }
	}   	
    
}
function selectAll(checkBoxId){
    var b=true;
    var ckbid=checkBoxId+"_";
    if(form1.elements(checkBoxId)!=null) b=form1.elements(checkBoxId).checked;
    else{
		for (var i = 0; i < form1.length; i++){
		  var e = form1.elements[i];
	   	  if (e.type.toLowerCase() == "checkbox" && e.name=='instance' && e.id.indexOf(ckbid)==0) {
			 b=!e.checked;
			 break;
		  }
		}   	
    }
	for (var i = 0; i < form1.length; i++){
	  var e = form1.elements[i];
   	  if (e.type.toLowerCase() == "checkbox" && e.name=='instance' && e.id.indexOf(ckbid)==0) {
		 e.checked=b;
	  }
	}   	
    
}
</script>
<table border=0 width="100%">
<form name="form1" method="post" action="/control/command">
  <input type='hidden' name='objectid' value='<%=objectId%>' >
  <input type='hidden' name="next-screen" value="<%=NDS_PATH%>/info.jsp">
  <input type='hidden' name="command" value="CreateAttributeSetInstances">
<tr><td><%= PortletUtils.getMessage(pageContext, "setting-attribute-instance-naming-rule-for",null)%>&nbsp;&nbsp;<a href="<%=NDS_PATH+"/object/object.jsp?table="+table.getId()+"&id="+objectId%>"><%=attribueSetName%></a>:</td></tr>
<tr><td><input type="text" name="r0" value="" size=2>
<%  
	for(int i=0;i<attributes.size();i++){
		if(i>0){
%>		<input type="text" name="<%="r"+i%>" value="" size=2>
<%		}
%>	
		<%=(((List)attributes.get(i)).get(1))%>
<%		
	}
%><input type="text" name="r<%=attributes.size()%>" value="" size=2><br><br>
</td></tr>
<tr><td><%= PortletUtils.getMessage(pageContext, "tick-instances-to-be-created",null)%></td></tr>
<tr><td>
<%=getAttributeTable(0,attributes,attributeValues,"")%>
</td></tr>
<tr><td>
<input class="command2_button" type='button' name='createinstances' value='<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>' onclick="javascript:form1.submit();" >
<%@ include file="/html/nds/common/helpbtn.jsp"%>
<span id="closebtn"></span>
<Script language="javascript">
if( window.self==window.top){
	$("closebtn").innerHTML="<input class='command_button' type='button' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>(C)' accessKey='C' onclick='window.close();' name='Close'>";
}
</script>
</td></tr>
</form>
</table>
<%@ include file="/html/nds/footer_info.jsp" %>

