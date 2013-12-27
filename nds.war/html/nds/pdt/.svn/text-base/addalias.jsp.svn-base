<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%!
private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("itemdetail.jsp");
private final static int TABINDEX_START=20000;
/**
 draw table of n level, checkbox name should in format like '_id1_id2_id3', id1 for first level,id2 for second, and so on
 @param prefix - is the prefix for checkbox name, for level 0, it will be "", for level 1, it will be "_id1", for level 2 "id1_ids2"
 @param instances - valid instances of current set, value:instanceid, key  _valueid1_valueid2
 @param aliasRecords Hashmap that contains existing records of alias table. Key: instanceid, value: instanceid 
*/
 private StringBuffer getAttributeTable(HashMap instances,int level, List attributes,List attributeValues, String prefix,HashMap aliasRecords){
 	String nextInputId;
	int attrId=Tools.getInt( ((List)attributes.get(level)).get(0),-1);
	String attrName= (String)((List)attributes.get(level)).get(1);
	List attrValues= (List) attributeValues.get(level);
	StringBuffer sb=new StringBuffer();
	int levels= attributes.size();
	sb.append("<table align='left' border='1' cellspacing='0' align='center' bordercolordark='#FFFFFF' bordercolorlight='#999999' class='modify_table'>");
	int j,k, vId, lastVId;
	String vDesc, lastVDesc;
	String key;
	Object instanceId;
	if(level<levels-2 && levels>2){
	 	//iteration
		for(j=0;j<attrValues.size();j++){
	 		vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);	

	 		sb.append("<tr><td><input type='checkbox' id='").append(prefix).append("_").append(vId).
	 		append("' onclick='selectAll(\"").append(prefix).append("_").append(vId).append("\")'>").
	 		append(vDesc).append("</td><td>&nbsp;</td></tr>");
	 		sb.append("<tr><td>&nbsp;</td><td>").append(
	 		getAttributeTable(instances,level+1,attributes,attributeValues, prefix+"_"+vId,aliasRecords)).
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
	 		sb.append("<td class='hd'><span class='cursor' onclick='selectAll2(\"").append(prefix).
	 		append("\",\"").append("_").append(lastVId).
	 		append("\")'>").append(lastVDesc).append("</span></td>");
	 	}
	 	sb.append("</tr>");
 		for(j=0;j<attrValues.size();j++){
 			vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);	
	 		sb.append("<tr><td class='hd'><span class='cursor' onclick='selectAll(\"").append(prefix).append("_").append(vId).
	 		append("\")'>").append(vDesc).append("</span></td>");
	 		for(k=0;k<lastAttrValues.size();k++){
	 			lastVId =Tools.getInt(((List)lastAttrValues.get(k)).get(0),-1);	
	 			key= prefix+"_"+vId+"_"+lastVId;
	 			instanceId= instances.get(key);
	 			
	 			if(instanceId!=null){
		 			sb.append("<td><input type='checkbox' name='A").append(instanceId).append("' id='").
		 			append(prefix).append("_").append(vId).append("_").append(lastVId).append("' value='Y'");
		 			if(aliasRecords.get(instanceId)!=null) sb.append(" checked ");
		 			sb.append("></td>");
	 			}else{
	 				sb.append("<td>&nbsp;</td>");
	 			}
	 		}
	 		sb.append("</tr>");
	 		if((j-18)%20==0){
	 		 	sb.append("<tr><td>&nbsp;</td>");
			 	for(int m =0;m<lastAttrValues.size();m++){
				 	lastVDesc= (String)((List)lastAttrValues.get(m)).get(1);	
				 	lastVId= Tools.getInt(((List)lastAttrValues.get(m)).get(0),-1);
				 	sb.append("<td class='hd'><span class='cursor' onclick='selectAll2(\"").append(prefix).
				 	append("\",\"").append("_").append(lastVId).
				 	append("\")'>").append(lastVDesc).append("</span></td>");
				}
				sb.append("</tr>");
	 		}
	 	}
 	}else{
 		// only one column
 		for(j=0;j<attrValues.size();j++){
	 		vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);
	 		key= "_"+vId;
	 		instanceId= instances.get(key);
	 		if(instanceId!=null){
	 			sb.append("<tr><td><input type='checkbox' value='Y' name='A").append(instanceId).append("' id='P").append(instanceId).append("'");
	 			if(aliasRecords.get(instanceId)!=null) sb.append(" checked ");
	 			sb.append(">").append("</td></tr>");
	 		}
	 	}
 	}
	sb.append("</table>");
 	return sb;
 }
%>
<%
/*
  Add alias(s) for select product, that product should have attributeSet set and all set's attributes are List type.
  
  The created page will be a indent tree table type, last attribute will be show as column of the tree table
  @param pdtid    - product id
*/
if((userWeb.getPermission("M_PRODUCT_ALIAS_LIST")& nds.security.Directory.WRITE )!= nds.security.Directory.WRITE )
	throw new NDSException("@no-permission@");

QueryEngine engine=QueryEngine.getInstance();
TableManager manager=TableManager.getInstance();
int pdtId=Tools.getInt(request.getParameter("pdtid"),-1);
String pdtName= (String) engine.doQueryOne("select name from m_product where id="+ pdtId);
int brandid=Tools.getInt(engine.doQueryOne("select m_dim1_id from m_product where id="+ pdtId),-1);
String brandsql="";
if(brandid!=-1){
brandsql="v.m_dim1_id="+String.valueOf(brandid)+" and";
}
int setId=nds.util.Tools.getInt(engine.doQueryOne("select M_ATTRIBUTESET_ID from m_product where id="+pdtId),-1);
String attribueSetName=(String) engine.doQueryOne("select name from m_attributeset where id="+ setId);
List attributes=engine.doQueryList("select a.id, a.name, a.clrsize from m_attribute a, m_attributeuse u where a.isactive='Y' and a.ATTRIBUTEVALUETYPE='L' and a.id=u.m_attribute_id and u.m_attributeset_id="+setId+" order by u.orderno asc");
if(attributes.size()<1) throw new NDSException("Not find List type attribute in set id="+ setId);
List attributeValues=new ArrayList(); //elements are List, whose elements are List with 2 elements, first is id, second is desc
for(int i=0;i< attributes.size();i++){
	if( Tools.getInt(((List)attributes.get(i)).get(2),-1)==2){
		//cloth size, not color, should display only value without name
		attributeValues.add( engine.doQueryList("select v.id, v.value from m_attributevalue v where v.isactive='Y' and v.m_attribute_id="+((List)attributes.get(i)).get(0) + " order by to_number(martixcol),value"));
	}else{
		attributeValues.add( engine.doQueryList("select v.id, case when v.name=v.value then v.name else  v.name||'(' || v.value ||')' end from m_attributevalue v where v.isactive='Y' and "+brandsql+" v.m_attribute_id="+((List)attributes.get(i)).get(0) + " order by to_number(martixcol),value"));
	}
}
List attributeInstances=engine.doQueryList(
"select distinct si.id, ai.m_attributevalue_id, u.orderno from m_attributesetinstance si , m_attributeinstance ai, m_attributeuse u "+
"where si.isactive='Y' and ai.isactive='Y' and ai.m_attributesetinstance_id= si.id and u.m_attributeset_id= si.m_attributeset_id and u.m_attribute_id= ai.m_attribute_id "+
"and si.lot is null and si.serno is null and si.GUARANTEEDATE is null "+
"and si.m_attributeset_id="+setId+" order by si.id, u.orderno");

HashMap instances=new HashMap();// key:instanceid, value  _valueid1_valueid2
Integer key; StringBuffer sb;
if(attributeInstances!=null)for(int i=0;i<attributeInstances.size();i++){
	key= new Integer(Tools.getInt( ((List)attributeInstances.get(i)).get(0) ,-1));
	sb=(StringBuffer)instances.get(key);
	if(sb==null){
		sb=new StringBuffer("_");
		sb.append(((List)attributeInstances.get(i)).get(1));
		instances.put(key, sb);
	}else{
		sb.append("_").append(((List)attributeInstances.get(i)).get(1));
	}
}
HashMap instances2=new HashMap();// value:instanceid, key  _valueid1_valueid2
for(Iterator it= instances.keySet().iterator();it.hasNext();){
	key=(Integer) it.next();
	instances2.put(instances.get(key).toString(),key);
}
/**
 Load existing alias of that product
*/ 
 HashMap aliases= new HashMap();// key: instanceid, value: instanceid
 List aliasRecords= engine.doQueryList("select m_attributesetinstance_id from m_product_alias where m_product_id="+ pdtId);
 if(aliasRecords!=null){
 	for(int i=0;i< aliasRecords.size();i++){
 		key= new Integer(Tools.getInt(aliasRecords.get(i) ,-1));
 		aliases.put(key,key);
 	}
 }
request.setAttribute("page_help", "AddAlias");
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="body_background" value="<%=colorScheme.getPortletBg()%>" />
	<liferay-util:param name="html_title" value="<%=PortletUtils.getMessage(pageContext, "set-product-alias",null)%>" />
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
    var checks= $("form1").getInputs('checkbox');
	for (var i = 0; i < checks.length; i++){
	  var e = checks[i];
   	  if (e.type.toLowerCase() == "checkbox" && e.id.indexOf(prefix)==0 &&
   	  	e.id.length>leng && e.id.substr(e.id.length-leng)==checkBoxId) {
		 b=!e.checked;
		 break;
	  }
	}   	
	for (var i = 0; i < checks.length; i++){
	  var e =  checks[i];
   	  if (e.type.toLowerCase() == "checkbox"  && e.id.indexOf(prefix)==0 &&
   	  	e.id.length>leng && e.id.substr(e.id.length-leng)==checkBoxId) {
		 e.checked=b;
	  }
	}   	
    
}
function selectAll(checkBoxId){
    var b=true;
    var ckbid=checkBoxId+"_";
     var checks= $("form1").getInputs('checkbox');
    if($(checkBoxId)!=null) b=$(checkBoxId).checked;
    else{
		for (var i = 0; i < checks.length; i++){
		  var e = checks[i];
	   	  if (e.type.toLowerCase() == "checkbox" &&  e.id.indexOf(ckbid)==0) {
			 b=!e.checked;
			 break;
		  }
		}   	
    }
	for (var i = 0; i < checks.length; i++){
	  var e = checks[i];
   	  if (e.type.toLowerCase() == "checkbox" && e.id.indexOf(ckbid)==0) {
		 e.checked=b;
	  }
	}   	
    
}
</script>
<form id="form1" name="form1" method="post" action="/control/command">
<table border=0 width="100%">
  <input type='hidden' name='pdtid' value='<%=pdtId%>' >
  <input type='hidden' name='setid' value='<%=setId%>' >
  <input type='hidden' name="next-screen" value="<%=NDS_PATH%>/info.jsp">
  <input type='hidden' name="command" value="CreateAlias">
<tr><td><%= PortletUtils.getMessage(pageContext, "setting-alias-naming-rule-for",null)%>&nbsp;&nbsp;
	<a href="<%=NDS_PATH+"/object/object.jsp?table="+manager.getTable("m_product").getId()+"&id="+pdtId%>"><%=pdtName%></a>,
	<a href="<%=NDS_PATH+"/object/object.jsp?table="+manager.getTable("m_attributeset").getId()+"&id="+setId%>"><%=attribueSetName%></a>:</td></tr>
<tr><td><input type="text" name="r0" value="" size=2>
<%
	List cls= manager.getTable("m_product").getShowableColumns(Column.QUERY_LIST);
	ArrayList showColumns=new ArrayList();
	for(int i=0;i<cls.size();i++){
		Column col= (Column)cls.get(i);
		if(col.getType()== Column.STRING && col.getDisplaySetting().getObjectType()== DisplaySetting.OBJ_TEXT && col.isModifiable(Column.ADD)){
			showColumns.add(col);
		}
	}
%>	
<%=QueryUtils.getQuickSearchComboBox("pdtcolumn",showColumns,locale)%>
	<input type="text" name="r1" value="" size=2>
<%  
	for(int i=0;i<attributes.size();i++){
		if(i>0){
%>		<input type="text" name="<%="r"+(i+1)%>" value="" size=2>
<%		}
%>	
		<%=(((List)attributes.get(i)).get(1))%>
<%		
	}
%><input type="text" name="r<%=attributes.size()+1%>" value="" size=2><br><br>
</td></tr>
<tr><td>
<input class="cbutton" type='button' name='createinstances' value='<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>' onclick="javascript:form1.submit();" >
<%@ include file="/html/nds/common/helpbtn.jsp"%>
<span id="closebtn"></span>
<Script language="javascript">
if( window.self==window.top){
	$("closebtn").innerHTML="<input class='cbutton' type='button' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>(C)' accessKey='C' onclick='window.close();' name='Close'>";
}
</script>
</td></tr>
<tr><td><%= PortletUtils.getMessage(pageContext, "tick-alias-to-be-created",null)%></td></tr>
<tr><td>
<%=getAttributeTable(instances2,0,attributes,attributeValues,"",aliases)%>
</td></tr>
</table>
</form>
<%@ include file="/html/nds/footer_info.jsp" %>

