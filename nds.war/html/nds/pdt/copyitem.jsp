<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
 
<%!
/**
 draw table of n level, checkbox name should in format like '_id1_id2_id3', id1 for first level,id2 for second, and so on
 @param prefix - is the prefix for checkbox name, for level 0, it will be "", for level 1, it will be "_id1", for level 2 "id1_ids2"
 @param instances - valid instances of current set, value:instanceid, key  _valueid1_valueid2
*/
 private StringBuffer getAttributeTable(HashMap instances,int level, List attributes,List attributeValues, String prefix){
	int attrId=Tools.getInt( ((List)attributes.get(level)).get(0),-1);
	String attrName= (String)((List)attributes.get(level)).get(1);
	List attrValues= (List) attributeValues.get(level);
	StringBuffer sb=new StringBuffer();
	int levels= attributes.size();
	sb.append("<table align='left' border='1' cellspacing='0' align='center' bordercolordark='#FFFFFF' bordercolorlight='#999999'>");
	int j,k, vId, lastVId;
	String vDesc, lastVDesc;
	String key;
	Object instanceId;
	if(level<levels-2 && levels>2){
	 	//iteration
		for(j=0;j<attrValues.size();j++){
	 		vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);	
	 		sb.append("<tr><td>").
	 		append(vDesc).append("</td><td>&nbsp;</td></tr>");
	 		sb.append("<tr><td>&nbsp;</td><td>").append(
	 		getAttributeTable(instances,level+1,attributes,attributeValues, prefix+"_"+vId)).
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
	 		sb.append("<td>").append(lastVDesc).append("</td>");
	 	}
	 	sb.append("</tr>");
 		for(j=0;j<attrValues.size();j++){
 			vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);	
	 		sb.append("<tr><td>").append(vDesc).append("</td>");
	 		for(k=0;k<lastAttrValues.size();k++){
	 			lastVId =Tools.getInt(((List)lastAttrValues.get(k)).get(0),-1);	
	 			key= prefix+"_"+vId+"_"+lastVId;
	 			instanceId= instances.get(key);
	 			
	 			if(instanceId!=null){
		 			sb.append("<td><input type='text' size='5' name='A").append(instanceId).append("' id='").
		 			append(instanceId).append("' value=''></td>");
	 			}else{
	 				sb.append("<td></td>");
	 			}
	 		}
	 		sb.append("</tr>");
	 	}
 	}else{
 		// only one column
 		for(j=0;j<attrValues.size();j++){
	 		vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);
	 		key= "_"+vId;
	 		instanceId= instances.get(key);
	 		if(instanceId!=null){
	 			sb.append("<tr><td><input type='text' size='5' value='' name='A").append(instanceId).append("'>").append("</td></tr>");
	 		}
	 	}
 	}
	sb.append("</table>");
 	return sb;
 }
%>
<%
/*
  Copy to other attributes of the same record, only one column will be filled
  Table should be m_product, or other table which contains : m_attributesetinstance_id,m_product_id
  @param table - table record to be copied
  @param id    - record it to be copied
  @param mainobjecttableid - main object id for item table
  @param fixedcolumn - fixed columns if have.
*/
TableManager manager=TableManager.getInstance();
Table table = manager.getTable(Tools.getInt(request.getParameter("table"),-1));

if (!table.isActionEnabled(Table.ADD) ||( (table.getColumn("m_product_id")==null && !table.getName().equalsIgnoreCase("m_product")) 
				|| table.getColumn("m_attributesetinstance_id")==null)) throw new NDSException("@no-permission@");
if((userWeb.getPermission(table.getSecurityDirectory())& nds.security.Directory.WRITE )!= nds.security.Directory.WRITE )
	throw new NDSException("@no-permission@");

int id= Tools.getInt(request.getParameter("id"),-1);
int setId=-1;
int productId=-1;
if( table.getName().equalsIgnoreCase("M_PRODUCT")){
	setId= nds.util.Tools.getInt(QueryEngine.getInstance().doQueryOne(
			"select m_attributeset_id from m_product where id ="+id),-1);
	productId=id;		
}else{
	// m_product_id should exists
	productId=nds.util.Tools.getInt(QueryEngine.getInstance().doQueryOne(
			"select m_product_id from "+table.getRealTableName()+" where id="+id),-1);
	setId= nds.util.Tools.getInt(QueryEngine.getInstance().doQueryOne(
			"select m_attributeset_id from m_product where id ="+productId),-1);
	
}
QueryEngine engine=QueryEngine.getInstance();
String attribueSetName=(String) engine.doQueryOne("select name from m_attributeset where id="+ setId);
List attributes=engine.doQueryList("select a.id, a.name from m_attribute a, m_attributeuse u where a.ATTRIBUTEVALUETYPE='L' and a.id=u.m_attribute_id and u.m_attributeset_id="+setId+" order by u.orderno asc");
if(attributes.size()<1) throw new NDSException("Not find List type attribute in set id="+ setId);
List attributeValues=new ArrayList(); //elements are List, whose elements are List with 2 elements, first is id, second is desc
for(int i=0;i< attributes.size();i++){
	attributeValues.add( engine.doQueryList("select v.id, case when v.name=v.value then v.name else  v.name||'(' || v.value ||')' end from m_attributevalue v where v.m_attribute_id="+((List)attributes.get(i)).get(0)));
}
/**
* Should we check product alias table records to confirm that attribute set instance is suit for specifiec product
  This is mainly useful for fashion industry, in which all products share the same attribute set.
*/
Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
boolean checkAliasTableForAttributeSetInstanceExistance="true".equalsIgnoreCase(conf.getProperty("product.check_alias_table_for_attribute_instance","true"));
String checkAliasTableForAttributeSetInstanceExistanceStr="";
if(checkAliasTableForAttributeSetInstanceExistance){
	checkAliasTableForAttributeSetInstanceExistanceStr=" and exists(select 1 from m_product_alias a where a.m_product_id="+productId+" and a.M_ATTRIBUTESETINSTANCE_ID=si.id)";
}
List attributeInstances=engine.doQueryList(
"select distinct si.id, ai.m_attributevalue_id, u.orderno from m_attributesetinstance si , m_attributeinstance ai, m_attributeuse u "+
"where ai.m_attributesetinstance_id= si.id and u.m_attributeset_id= si.m_attributeset_id and u.m_attribute_id= ai.m_attribute_id "+
"and si.lot is null and si.serno is null and si.GUARANTEEDATE is null "+
"and si.m_attributeset_id="+setId+checkAliasTableForAttributeSetInstanceExistanceStr+" order by si.id, u.orderno");

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

%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="body_background" value="<%=colorScheme.getPortletBg()%>" />
	<liferay-util:param name="html_title" value="<%=PortletUtils.getMessage(pageContext, "copyitem",null)%>" />
</liferay-util:include>

<STYLE>
<!--
.cursor {  cursor: hand}
-->
</STYLE>
<table border=0 width="100%">
<form name="form1" method="post" action="/control/command">
  <input type='hidden' name='id' value='<%=id%>' >
  <input type='hidden' name='table' value='<%=table.getId()%>' >
  <input type='hidden' name="next-screen" value="<%=NDS_PATH%>/info.jsp">
  <input type='hidden' name="command" value="CopyItemForMM">
  <input type='hidden' name="fixedcolumns" value="<%=request.getParameter("fixedcolumns")%>">
  <input type='hidden' name="mainobjecttableid" value="<%=request.getParameter("mainobjecttableid")%>">
  
<tr><td><%= PortletUtils.getMessage(pageContext, "select-column-to-be-filled",null)%>:
&nbsp;&nbsp;<%=QueryUtils.getQuickSearchComboBox("fillcolumn",table.getModifiableColumns(Column.ADD),locale)%>
&nbsp;&nbsp;<%= PortletUtils.getMessage(pageContext, "default-value",null)%>:
<input type="text" name="defaultvalue" value="" size=10> &nbsp;
<input type="checkbox" name="notnull" value="1" checked><%= PortletUtils.getMessage(pageContext, "do-not-create-record-for-null",null)%>
</td></tr>
<tr><td><%= PortletUtils.getMessage(pageContext, "input-value-for-each-attribute",null)%></td></tr>
<tr><td>
<%=getAttributeTable(instances2,0,attributes,attributeValues,"")%>
</td></tr>
<tr><td>
<input class="command2_button" type='button' name='createinstances' value='<%=PortletUtils.getMessage(pageContext, "object.submit",null)%>' onclick="javascript:form1.submit();" >
<span id="tag_close_window"></span>
<Script language="javascript">
 // check show close window button or not
 if(  self==top){
 	document.getElementById("tag_close_window").innerHTML=
 	 "<input class='command_button' type='button' name='Cancle' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>' onclick='javascript:window.close();' >";
 }
</script>
</td></tr>
</form>
</table>
<%@ include file="/html/nds/footer_info.jsp" %>
