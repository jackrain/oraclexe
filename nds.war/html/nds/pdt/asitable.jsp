<%@ include file="/html/nds/common/init.jsp" %>
<%!
private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("asitable.jsp");

 /**
 * This is to record input element sequence, and will create next input element for each input
 */
 private void prepareAttributeTable(HashMap instances,int level, List attributes,List attributeValues, String prefix, List inputList){
	int attrId=Tools.getInt( ((List)attributes.get(level)).get(0),-1);
	String attrName= (String)((List)attributes.get(level)).get(1);
	List attrValues= (List) attributeValues.get(level);
	int levels= attributes.size();
	int j,k, vId, lastVId;
	String vDesc, lastVDesc;
	String key;
	Object instanceId;
	if(level<levels-2 && levels>2){
	 	//iteration
		for(j=0;j<attrValues.size();j++){
	 		vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		prepareAttributeTable(instances,level+1,attributes,attributeValues, prefix+"_"+vId, inputList);
	 	}
 	}else if(level==levels-2){
 		// table, first row is the last level, first column is the second last level
 		int lastAttrId= Tools.getInt(((List)attributes.get(level+1)).get(0),-1);
 		String lastAttrName= (String)((List)attributes.get(level+1)).get(1);
 		List lastAttrValues= (List) attributeValues.get(level+1);
 		for(j=0;j<lastAttrValues.size();j++){
	 		lastVDesc= (String)((List)lastAttrValues.get(j)).get(1);	
	 		lastVId= Tools.getInt(((List)lastAttrValues.get(j)).get(0),-1);
	 	}
 		for(j=0;j<attrValues.size();j++){
 			vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);	
	 		for(k=0;k<lastAttrValues.size();k++){
	 			lastVId =Tools.getInt(((List)lastAttrValues.get(k)).get(0),-1);	
	 			key= prefix+"_"+vId+"_"+lastVId;
	 			instanceId= instances.get(key);
	 			if(instanceId!=null){
	 				inputList.add(instanceId);
	 			}
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
	 			inputList.add(instanceId);
	 		}
	 	}
 	}
 }
/**
 draw table of n level, checkbox name should in format like '_id1_id2_id3', id1 for first level,id2 for second, and so on
 @param prefix - is the prefix for checkbox name, for level 0, it will be "", for level 1, it will be "_id1", for level 2 "id1_ids2"
 @param instances - valid instances of current set, value:instanceid, key  _valueid1_valueid2, contains a special value
  named "inputCount" which is used for calcuate input tabIndex, and will get updated each time a new input elements added
   @param nameSpace, each id of asi input will prefixed with this string
   @param startTabIndex, the start tab index of the table
*/
 private StringBuffer getAttributeTable(HashMap instances,int level, List attributes,List attributeValues, String prefix, List inputList,String nameSpace, int startTabIndex){
 	int totalInputs= inputList.size();
 	String nextInputId;
	int attrId=Tools.getInt( ((List)attributes.get(level)).get(0),-1);
	String attrName= (String)((List)attributes.get(level)).get(1);
	List attrValues= (List) attributeValues.get(level);
	StringBuffer sb=new StringBuffer();
	int levels= attributes.size();
	sb.append("<table border='0' align='center' cellpadding='1' cellspacing='1' class='table_bg'>");
	int j,k, vId, lastVId;
	String vDesc, lastVDesc;
	String key;
	Object instanceId;
	int inputCount=((Integer) instances.get("inputCount")).intValue();
	if(level<levels-2 && levels>2){
	 	//iteration
		for(j=0;j<attrValues.size();j++){
	 		vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);	
	 		sb.append("<tr><td class='td_bg'>").
	 		append(vDesc).append("</td><td class='td_bg'>&nbsp;</td></tr>");
	 		sb.append("<tr><td class='td_bg'>&nbsp;</td><td class='td_bg'>").append(
	 		getAttributeTable(instances,level+1,attributes,attributeValues, prefix+"_"+vId, inputList, nameSpace, startTabIndex)).
	 		append("</td></tr>");
	 	}
 	}else if(level==levels-2){
 		// table, first row is the last level, first column is the second last level
 		int lastAttrId= Tools.getInt(((List)attributes.get(level+1)).get(0),-1);
 		String lastAttrName= (String)((List)attributes.get(level+1)).get(1);
 		List lastAttrValues= (List) attributeValues.get(level+1);
 		sb.append("<tr><td class='td_bg_center'>&nbsp;</td>");
 		for(j=0;j<lastAttrValues.size();j++){
	 		lastVDesc= (String)((List)lastAttrValues.get(j)).get(1);	
	 		lastVId= Tools.getInt(((List)lastAttrValues.get(j)).get(0),-1);
	 		sb.append("<td class='td_bg'>").append(lastVDesc).append("</td>");
	 	}
	 	sb.append("</tr>");
 		for(j=0;j<attrValues.size();j++){
 			vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);	
	 		sb.append("<tr><td class='td_bg'>").append(vDesc).append("</td>");
	 		for(k=0;k<lastAttrValues.size();k++){
	 			lastVId =Tools.getInt(((List)lastAttrValues.get(k)).get(0),-1);	
	 			key= prefix+"_"+vId+"_"+lastVId;
	 			instanceId= instances.get(key);
	 			
	 			if(instanceId!=null){
	 				nextInputId= inputCount+1>=totalInputs ?  ((Integer)inputList.get(0)).toString() : ((Integer)inputList.get(inputCount+1)).toString();
		 			sb.append("<td class='td_bg_center'><input class='inputline' type='text' tabIndex='").append((inputCount+startTabIndex)).append("' size='5' style='width: 30px; height: 14px; line-height: 14px;' name=").append(instanceId).append(" id='").append(nameSpace).
		 			append(instanceId).append("' value='' onkeydown='return fair.onMatrixKey(event,\"").append(nameSpace).append(nextInputId).append("\");'></td>");
		 			//
		 			inputCount++;
	 			}else{
	 				sb.append("<td class='td_bg_center'></td>");
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
	 			nextInputId= inputCount+1>=totalInputs ?  ((Integer)inputList.get(0)).toString() : ((Integer)inputList.get(inputCount+1)).toString();
	 			sb.append("<tr><td class='td_bg_center'><input class='inputline' type='text' tabIndex='").append((inputCount+startTabIndex)).append("' size='5'style='width: 30px; height: 14px; line-height: 14px;' value='' name=").
	 			append(instanceId).append(" id='").append(nameSpace).append(instanceId).append("' onkeydown='return fair.onMatrixKey(event,\"").append(nameSpace).append(nextInputId).append("\");'>").append("</td></tr>");
	 			inputCount++;
	 		}
	 	}
 	}
	sb.append("</table>");
	instances.put("inputCount", new Integer(inputCount));
 	return sb;
 }
%>
<%
try{
/*
  Create blank attributeset instance table for input, each asi input has id format "namespace"+asiid
  This page will check user read permission on m_product
  @param pdtid    - product id
  @param namespace	 - will set as prefix for asi input id, so more asitable can be set in the same page
  					 for instance, in fair/order.jsp, two tables will show, it should better set namespace with only one character, and
  					 not use same character for asi tables in the same page,as startTabIndex= char(namespace[0])*1000
*/
TableManager manager=TableManager.getInstance();
Table table = manager.getTable("m_product");
/*if((userWeb.getPermission(table.getSecurityDirectory())& nds.security.Directory.READ )!= nds.security.Directory.READ ){
	out.print(PortletUtils.getMessage(pageContext, "no-permission",null));
	return;
}
*/
int productId=Tools.getInt(request.getParameter("pdtid"),-1);
String nameSpace= request.getParameter("namespace");
if(nameSpace==null || nameSpace.length()!=1) throw new NDSException("namespace("+nameSpace+") should be one character");
QueryEngine engine=QueryEngine.getInstance();
int setId=Tools.getInt(engine.doQueryOne("select M_ATTRIBUTESET_ID from m_product where id="+ productId),-1);
String attribueSetName=(String) engine.doQueryOne("select name from m_attributeset where id="+ setId);
List attributes=engine.doQueryList("select a.id, a.name, a.clrsize from m_attribute a, m_attributeuse u where a.isactive='Y' and a.ATTRIBUTEVALUETYPE='L' and a.id=u.m_attribute_id and u.m_attributeset_id="+setId+" order by u.orderno asc");
if(attributes.size()<1) throw new NDSException("Not find List type attribute in set id="+ setId);

/**
* Should we check product alias table records to confirm that attribute set instance is suit for specifiec product
  This is mainly useful for fashion industry, in which all products share the same attribute set.
*/
Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
boolean checkAliasTableForAttributeSetInstanceExistance="true".equalsIgnoreCase(conf.getProperty("product.check_alias_table_for_attribute_instance","true"));
String checkAliasTableForAttributeSetInstanceExistanceStr="";

if(checkAliasTableForAttributeSetInstanceExistance){
	checkAliasTableForAttributeSetInstanceExistanceStr=" and exists(select 1 from m_product_alias a where a.isactive='Y' and a.m_product_id="+productId+" and a.M_ATTRIBUTESETINSTANCE_ID=si.id)";
}

List attributeValues=new ArrayList(); //elements are List, whose elements are List with 2 elements, first is id, second is desc
for(int i=0;i< attributes.size();i++){
	Object aid=((List)attributes.get(i)).get(0);
	String sql;
	if( Tools.getInt(((List)attributes.get(i)).get(2),-1)==2){
		//cloth size, not color, should display only value without name
		sql="select v.id, v.value from m_attributevalue v where v.isactive='Y' and v.m_attribute_id="+aid;
	}else{
		sql="select v.id, case when v.name=v.value then v.name else  v.name||'(' || v.value ||')' end "+
								"from m_attributevalue v where v.isactive='Y' and v.m_attribute_id="+aid ;
	}
	if(checkAliasTableForAttributeSetInstanceExistance){
		sql+=" and exists(select 1 from m_product_alias a, m_attributeinstance si,m_attributesetinstance asi "+
		"where a.isactive='Y' and a.m_product_id="+productId+" and asi.id=a.M_ATTRIBUTESETINSTANCE_ID  and asi.M_ATTRIBUTESET_ID="+ setId+
		" and a.M_ATTRIBUTESETINSTANCE_ID=si.M_ATTRIBUTESETINSTANCE_ID and si.M_ATTRIBUTEVALUE_ID=v.id and si.M_ATTRIBUTE_ID="+ aid +")";
	}
	sql +=" order by to_number(martixcol),value";
	attributeValues.add( engine.doQueryList(sql));
}


List attributeInstances=engine.doQueryList(
"select distinct si.id, ai.m_attributevalue_id, u.orderno from m_attributesetinstance si , m_attributeinstance ai, m_attributeuse u "+
"where si.isactive='Y' and ai.isactive='Y' and ai.m_attributesetinstance_id= si.id and u.m_attributeset_id= si.m_attributeset_id and u.m_attribute_id= ai.m_attribute_id "+
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
instances2.put("inputCount", new Integer(0));// this will be updated when recursing instances

ArrayList inputList=new ArrayList();
prepareAttributeTable(instances2,0,attributes,attributeValues,"", inputList);
int startTabIndex=100* (int)(nameSpace.charAt(0));
%>
<%=getAttributeTable(instances2,0,attributes,attributeValues,"",inputList,nameSpace,startTabIndex)%>
<%}catch(Throwable t){
	logger.error("/html/nds/pdt/itemdetail.jsp", t);
	out.print(PortletUtils.getMessage(pageContext, "exception",null)+":"+ t.getMessage());
}%>