<%@ include file="/html/nds/common/init.jsp" %>
<%@ page language="java" import="java.util.*,nds.control.event.DefaultWebEvent" pageEncoding="utf-8"%>
<%!
private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("itemdetail.jsp");
private final static int TABINDEX_START=20000;
private static boolean showSizeDesc=false;//most company will not show size desc
static{
	Configurations conf2= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
	showSizeDesc="true".equals(conf2.getProperty("pdt.matrix.size.show_desc"));
}

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
 fix column in table
 get table head
 **/
 private StringBuffer getAttributeTable_head(HashMap instances,int level, List attributes,List attributeValues, String prefix, List inputList,List li_store,List li_dest,int store_objectId, int dest_objectId,Table store_table,Table dest_table,boolean directory_store,boolean directory_dest,UserWebImpl userWeb){
	int attrId=Tools.getInt( ((List)attributes.get(level)).get(0),-1);
	String attrName= (String)((List)attributes.get(level)).get(1);
	List attrValues= (List) attributeValues.get(level);
	/*MessagesHolder mh= MessagesHolder.getInstance();
	UserWebImpl usr=(UserWebImpl) WebUtils.getSessionContextManager(request.getSession(true)).getActor(nds.util.WebKeys.USER);
	Locale locale= user.getLocale();
	*/
	StringBuffer sb=new StringBuffer();
		DefaultWebEvent event=new DefaultWebEvent("CommandEvent");
	MessagesHolder mh= MessagesHolder.getInstance();
	int levels= attributes.size();
	sb.append("<table align='left' id='modify_table_head' class='itemdetail_table' border='1' cellspacing='0' cellpadding='0'  bordercolordark='#FFFFFF' bordercolorlight='#FFFFFF'>");
	int j,k, vId, lastVId;
	String vDesc, lastVDesc;
	Object instanceId;
  if(level==levels-2){
 		// table, first row is the last level, first column is the second last level
 		int lastAttrId= Tools.getInt(((List)attributes.get(level+1)).get(0),-1);
 		String lastAttrName= (String)((List)attributes.get(level+1)).get(1);
 		List lastAttrValues= (List) attributeValues.get(level+1);

 		sb.append("<thead><tr><td style='width:62px;'>&nbsp;</td>");
 		for(j=0;j<lastAttrValues.size();j++){
	 		lastVDesc= (String)((List)lastAttrValues.get(j)).get(1);
	 		lastVId= Tools.getInt(((List)lastAttrValues.get(j)).get(0),-1);
	 		sb.append("<td class='hd' style='width:54px;'>").append(lastVDesc).append("</td>");
	 	}
	 	sb.append("<td class='hd' style='width:45px;'>").append(mh.getMessage(event.getLocale(), "row_total")).append("</td>");
	 	sb.append("</tr></thead></table>");
 }
  	return sb;
 }



/**
 draw table of n level, checkbox name should in format like '_id1_id2_id3', id1 for first level,id2 for second, and so on
 @param prefix - is the prefix for checkbox name, for level 0, it will be "", for level 1, it will be "_id1", for level 2 "id1_ids2"
 @param instances - valid instances of current set, value:instanceid, key  _valueid1_valueid2, contains a special value
  named "inputCount" which is used for calcuate input tabIndex, and will get updated each time a new input elements added
*/
 private StringBuffer getAttributeTable(HashMap instances,int level, List attributes,List attributeValues, String prefix, List inputList,List li_store,List li_dest,int store_objectId, int dest_objectId,Table store_table,Table dest_table,boolean directory_store,boolean directory_dest,UserWebImpl userWeb){
 	int totalInputs= inputList.size();
 	String nextInputId;
	int attrId=Tools.getInt( ((List)attributes.get(level)).get(0),-1);
	String attrName= (String)((List)attributes.get(level)).get(1);
	List attrValues= (List) attributeValues.get(level);
	/*MessagesHolder mh= MessagesHolder.getInstance();
	UserWebImpl usr=(UserWebImpl) WebUtils.getSessionContextManager(request.getSession(true)).getActor(nds.util.WebKeys.USER);
	Locale locale= user.getLocale();
	*/
	StringBuffer sb=new StringBuffer();
	DefaultWebEvent event=new DefaultWebEvent("CommandEvent");
	MessagesHolder mh= MessagesHolder.getInstance();
	int levels= attributes.size();
	sb.append("<table align='left' id='modify_table_product' class='modify_table' border='1' cellspacing='0' cellpadding='0'  bordercolordark='#FFFFFF' bordercolorlight='#FFFFFF' style='position: relative; left: 0px; top: 0px;'>");
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
	 		sb.append("<tr><td class='hd'>").
	 		append(vDesc).append("</td><td>&nbsp;</td></tr>");
	 		sb.append("<tr><td>&nbsp;</td><td>").append(
	 		getAttributeTable(instances,level+1,attributes,attributeValues, prefix+"_"+vId, inputList,li_store,li_dest,store_objectId,dest_objectId,store_table,dest_table,directory_store,directory_dest,userWeb)).
	 		append("</td></tr>");
	 	}
 	}else if(level==levels-2){
 		// table, first row is the last level, first column is the second last level
 		int lastAttrId= Tools.getInt(((List)attributes.get(level+1)).get(0),-1);
 		String lastAttrName= (String)((List)attributes.get(level+1)).get(1);
 		List lastAttrValues= (List) attributeValues.get(level+1);

 		sb.append("<tr style='display:none;'><td>&nbsp;</td>");
 		for(j=0;j<lastAttrValues.size();j++){
	 		lastVDesc= (String)((List)lastAttrValues.get(j)).get(1);
	 		lastVId= Tools.getInt(((List)lastAttrValues.get(j)).get(0),-1);
	 		sb.append("<td class='hd'>").append(lastVDesc).append("</td>");
	 	}
	 	sb.append("<td class='hd'>").append(mh.getMessage(event.getLocale(), "row_total")).append("</td>");
	 	sb.append("</tr>");

 		for(j=0;j<attrValues.size();j++){
 			vId=Tools.getInt(((List)attrValues.get(j)).get(0),-1);
	 		vDesc= (String)((List)attrValues.get(j)).get(1);
	 		sb.append("<tr><td class='hd' style='width:62px;'>").append(vDesc).append("</td>");
	 		for(k=0;k<lastAttrValues.size();k++){
	 			lastVId =Tools.getInt(((List)lastAttrValues.get(k)).get(0),-1);
	 			key= prefix+"_"+vId+"_"+lastVId;
	 			instanceId= instances.get(key);
	 			boolean flag_store =false;
	 			boolean flag_dest =false;
	 			if(instanceId!=null){
	 				nextInputId= inputCount+1>=totalInputs ?  ((Integer)inputList.get(0)).toString() : ((Integer)inputList.get(inputCount+1)).toString();
		 			sb.append("<td style='width:54px;'><input class='inputline' type='text' tabIndex='").append((inputCount+TABINDEX_START)).append("' size='5' name='A").append(instanceId).append("' id='P").
		 			append(instanceId).append("' value='' onkeydown='return gc.onMatrixKey(event,").append(j).append(",").append(k).append(");'").append(" 	onchange='return gc.oncellchange(").append(j).append(",").append(k).append(");'").append("><br><div class='product-storage'>");
		 			if(store_objectId!=-1){
			 			if(li_store.size()>0){
			 				for(int m=0;m<li_store.size();m++){
			 					int temp=Tools.getInt(((List)li_store.get(m)).get(0),-1);
			 					if(temp==Tools.getInt(instanceId,0)){
			 						sb.append("<div class='psl'>");
			 						if(directory_store){
					 					sb.append("<div class='s'>").append(Tools.getInt(((List)li_store.get(m)).get(1),0)).append("</div>");
					 					sb.append("<div class='c'>").append(Tools.getInt(((List)li_store.get(m)).get(3),0)).append("</div>");
					 					sb.append("<div class='v'>").append(Tools.getInt(((List)li_store.get(m)).get(4),0)).append("</div>");
					 				}else{
					 					if(Tools.getInt(((List)li_store.get(m)).get(1),0)>0){
					 						sb.append("<div class='s'>").append(mh.getMessage(event.getLocale(), "enough_goods")).append("</div>");
					 					}else{
					 						sb.append("<div class='s'>").append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
					 					}
					 					if(Tools.getInt(((List)li_store.get(m)).get(3),0)>0){
					 						sb.append("<div class='c'>").append(mh.getMessage(event.getLocale(), "enough_goods")).append("</div>");
					 					}else{
					 						sb.append("<div class='c'>").append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
					 					}
					 					if(Tools.getInt(((List)li_store.get(m)).get(4),0)>0){
					 						sb.append("<div class='v'>").append(mh.getMessage(event.getLocale(), "enough_goods")).append("</div>");
					 					}else{
					 						sb.append("<div class='v'>").append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
					 					}

					 				}
					 				sb.append("</div>");
					 				flag_store =true;
				 					break;
		 				  		}
			 				}
			 			}
			 			if(!flag_store){
			 				if(directory_store){
			 					sb.append("<div class='psl'><div class='s'>&nbsp;</div><div class='c'>&nbsp;</div><div class='v'>&nbsp;</div></div>");
			 				}else{
			 					sb.append("<div class='psl'>").append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
			 				}
			 			}
			 		}
		 			if(dest_objectId!=-1){
			 			if(li_dest.size()>0){
			 				for(int m=0;m<li_dest.size();m++){
			 					int temp=Tools.getInt(((List)li_dest.get(m)).get(0),-1);
			 					if(temp==Tools.getInt(instanceId,0)){
			 						sb.append("<div class='psr'>");
					 				if(directory_dest){
					 					sb.append(Tools.getInt(((List)li_dest.get(m)).get(1),0)).append("</div>");
					 				}else{
					 					if(Tools.getInt(((List)li_dest.get(m)).get(1),0)>0){
					 						sb.append(mh.getMessage(event.getLocale(), "enough_goods")).append("</div>");
					 					}else{
					 						sb.append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
					 					}
					 				}
					 				flag_dest =true;
					 				break;
			 				  	}
			 				}
			 			}
			 			if(!flag_dest){
			 				if(directory_dest){
			 					sb.append("<div class='psr'></div>");
			 				}else{
			 					sb.append("<div class='psr'>").append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
			 				}
			 			}
		 			}
		 			sb.append("</div></td>");
		 			inputCount++;
	 			}else{
	 				sb.append("<td></td>");
	 			}
	 		}
	 		sb.append("<td id='tot_");
	 		sb.append(j);
	 		sb.append("'align='center' valign='top' style='width:45px;max-width:45px;'>&nbsp;</td>");
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
	 			sb.append("<tr><td><input class='inputline' type='text' tabIndex='").append((inputCount+TABINDEX_START)).append("' size='5' value='' name='A").
	 			append(instanceId).append("' value='' onkeydown='return gc.onMatrixKey(event,0,").append(j).append(");'").append(" onblur='return gc.oncellchange(0,").append(j).append(");'").append("><br><div class='product-storage'>");
	 			boolean flag_store =false;
	 			boolean flag_dest =false;
	 			if(store_objectId!=-1){
		 			if(li_store.size()>0){
			 				for(int m=0;m<li_store.size();m++){
			 					int temp=Tools.getInt(((List)li_store.get(m)).get(0),-1);
			 					if(temp==Tools.getInt(instanceId,0)){
			 						sb.append("<div class='psl'>");
			 						if(directory_store){
					 					sb.append("<div class='s'>").append(Tools.getInt(((List)li_store.get(m)).get(1),0)).append("</div>");
					 					sb.append("<div class='c'>").append(Tools.getInt(((List)li_store.get(m)).get(3),0)).append("</div>");
					 					sb.append("<div class='v'>").append(Tools.getInt(((List)li_store.get(m)).get(4),0)).append("</div>");
					 				}else{
					 					if(Tools.getInt(((List)li_store.get(m)).get(1),0)>0){
					 						sb.append("<div class='s'>").append(mh.getMessage(event.getLocale(), "enough_goods")).append("</div>");
					 					}else{
					 						sb.append("<div class='s'>").append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
					 					}
					 					if(Tools.getInt(((List)li_store.get(m)).get(3),0)>0){
					 						sb.append("<div class='c'>").append(mh.getMessage(event.getLocale(), "enough_goods")).append("</div>");
					 					}else{
					 						sb.append("<div class='c'>").append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
					 					}
					 					if(Tools.getInt(((List)li_store.get(m)).get(4),0)>0){
					 						sb.append("<div class='v'>").append(mh.getMessage(event.getLocale(), "enough_goods")).append("</div>");
					 					}else{
					 						sb.append("<div class='v'>").append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
					 					}

					 				}
					 				sb.append("</div>");
					 				flag_store =true;
					 				break;
			 				  	}
			 				}
			 			}
			 			if(!flag_store){
			 				if(directory_store){
			 					sb.append("<div class='psl'>&nbsp;</div>");
			 				}else{
			 					sb.append("<div class='psl'>").append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
			 				}
			 			}
		 			}
		 			if(dest_objectId!=-1){
			 			if(li_dest.size()>0){
			 				for(int m=0;m<li_dest.size();m++){
			 					int temp=Tools.getInt(((List)li_dest.get(m)).get(0),-1);
			 					if(temp==Tools.getInt(instanceId,0)){
			 						sb.append("<div class='psr'>");
					 				if(directory_dest){
					 					sb.append(Tools.getInt(((List)li_dest.get(m)).get(1),0)).append("</div>");
					 				}else{
					 					if(Tools.getInt(((List)li_dest.get(m)).get(1),0)>0){
					 						 	sb.append(mh.getMessage(event.getLocale(), "enough_goods")).append("</div>");
					 					}else{
					 							sb.append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
					 					}
					 				}
					 				flag_dest =true;
					 				break;
			 				  	}
			 				}
			 			}
			 			if(!flag_dest){
			 				if(directory_dest){
			 					sb.append("<div class='psr'>&nbsp;</div>");
			 				}else{
			 					sb.append("<div class='psr'>").append(mh.getMessage(event.getLocale(), "lack_goods")).append("</div>");
			 				}
			 			}
		 			}
		 			sb.append("</div></td>");
		 			sb.append("<td id='tot_");
	 				sb.append(j);
	 				sb.append("' align='center' valign='top'></td>");
	 				sb.append("</tr>");
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
  Create json object for all attributes selected with input number

  @param table - table id ,which contains columns: m_attributesetinstance_id,m_product_id
  @param pdtid    - product id
  @param asid - attribute set id of that product
*/
TableManager manager=TableManager.getInstance();

Table table = manager.getTable(Tools.getInt(request.getParameter("table"),-1));
if (!table.isActionEnabled(Table.ADD) ||( (table.getColumn("m_product_id")==null && !table.getName().equalsIgnoreCase("m_product"))
				|| table.getColumn("m_attributesetinstance_id")==null)) throw new NDSException("@no-permission@");
if((userWeb.getPermission(table.getSecurityDirectory())& nds.security.Directory.WRITE )!= nds.security.Directory.WRITE ){
	out.print(PortletUtils.getMessage(pageContext, "no-permission",null));
	return;
}
int productId=Tools.getInt(request.getParameter("pdtid"),-1);
int setId=Tools.getInt(request.getParameter("asid"),-1);
int store_colId=Tools.getInt(request.getParameter("store_colId"),-1);
String storedata=(String)request.getParameter("storedata");
int dest_colId=Tools.getInt(request.getParameter("dest_colId"),-1);
String destdata=(String)request.getParameter("destdata");
Column store_col =manager.getColumn(store_colId);
Column dest_col =manager.getColumn(dest_colId);
boolean flagstore =false;
boolean flagdest =false;
Table store_table =null;
Table dest_table =null;
String attribueSetName=(String) QueryEngine.getInstance().doQueryOne("select name from m_attributeset where id="+ setId);
String showSizeStyle = (String)QueryEngine.getInstance().doQueryOne("select value from ad_param where name='portal.4084'");
String showColStyle = (String)QueryEngine.getInstance().doQueryOne("select value from ad_param where name='portal.4085'");
List attributes=QueryEngine.getInstance().doQueryList("select a.id, a.name, a.clrsize from m_attribute a, m_attributeuse u where a.isactive='Y' and a.ATTRIBUTEVALUETYPE='L' and a.id=u.m_attribute_id and u.m_attributeset_id="+setId+" order by u.orderno asc");
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
   if (Tools.getInt(((List)attributes.get(i)).get(2), -1) == 2)
   {
     if ("NAME".equals(showSizeStyle)) {
       sql = "select v.id, v.NAME from m_attributevalue v where v.isactive='Y' and v.m_attribute_id=" + aid;
     }
     else
     {
       if ("VALUENAME".equals(showSizeStyle))
         sql = "select v.id, case when v.name=v.value then v.name else  v.name||'(' || v.value ||')' end from m_attributevalue v where v.isactive='Y' and v.m_attribute_id=" + aid;
       else
         sql = "select v.id, v.value from m_attributevalue v where v.isactive='Y' and v.m_attribute_id=" + aid;
     }
   }
   else
   {
     if ("NAME".equals(showColStyle)) {
       sql = "select v.id, v.NAME from m_attributevalue v where v.isactive='Y' and v.m_attribute_id=" + aid;
     }
     else
     {
       if ("VALUENAME".equals(showColStyle))
         sql = "select v.id, case when v.name=v.value then v.name else  v.name||'(' || v.value ||')' end from m_attributevalue v where v.isactive='Y' and v.m_attribute_id=" + aid;
       else
         sql = "select v.id, v.value from m_attributevalue v where v.isactive='Y' and v.m_attribute_id=" + aid;
     }
   }
	if(checkAliasTableForAttributeSetInstanceExistance){
		sql+=" and exists(select 1 from m_product_alias a, m_attributeinstance si,m_attributesetinstance asi "+
		"where a.isactive='Y' and a.m_product_id="+productId+" and asi.id=a.M_ATTRIBUTESETINSTANCE_ID  and asi.M_ATTRIBUTESET_ID="+ setId+
		" and a.M_ATTRIBUTESETINSTANCE_ID=si.M_ATTRIBUTESETINSTANCE_ID and si.M_ATTRIBUTEVALUE_ID=v.id and si.M_ATTRIBUTE_ID="+ aid +")";
	}
		sql = sql + " order by to_number(martixcol),value";
		attributeValues.add(QueryEngine.getInstance().doQueryList(sql));
}


List attributeInstances=QueryEngine.getInstance().doQueryList(
"select distinct si.id, ai.m_attributevalue_id, u.orderno from m_attributesetinstance si , m_attributeinstance ai, m_attributeuse u "+
"where si.isactive='Y' and ai.isactive='Y' and ai.m_attributesetinstance_id= si.id and u.m_attributeset_id= si.m_attributeset_id and u.m_attribute_id= ai.m_attribute_id "+
"and si.lot is null and si.serno is null and si.GUARANTEEDATE is null "+
"and si.m_attributeset_id="+setId+checkAliasTableForAttributeSetInstanceExistanceStr+" order by si.id, u.orderno");

HashMap instances=new HashMap();// key:instanceid, value  _valueid1_valueid2
Integer key; StringBuffer sb;
if(attributeInstances!=null)for(int i=0;i<attributeInstances.size();i++){
	key= new Integer(Tools.getInt( ((List)attributeInstances.get(i)).get(0),-1));
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

//check read permission on V_FA_STORAGE.storage of specified store
Table faStorageTable= manager.getTable("V_FA_STORAGE");

ArrayList inputList=new ArrayList();
prepareAttributeTable(instances2,0,attributes,attributeValues,"", inputList);
List li_store=QueryEngine.getInstance().doQueryList("select t.m_attributesetinstance_id,t.qty, t.id,t.qtyconsign, t.qtycan from V_FA_STORAGE t  where t.C_STORE_ID=(select d.id from c_store d where d.name="+QueryUtils.TO_STRING(storedata)+") and t.m_product_id="+productId);
List li_dest=QueryEngine.getInstance().doQueryList("select t.m_attributesetinstance_id,t.qty,t.id,t.qtyconsign, t.qtycan from V_FA_STORAGE t  where t.C_STORE_ID=(select d.id from c_store d where d.name="+QueryUtils.TO_STRING(destdata)+") and t.m_product_id="+productId);
int dest_objectId=-1;
int store_objectId=-1;
boolean directory_store=false;
boolean directory_dest=false;
// id of V_FA_STORAGE, from first store
int idOfanyOfStoreStorage=-1;
int idOfanyOfDestStorage=-1;
if(li_store!=null && li_store.size()>0)  idOfanyOfStoreStorage=Tools.getInt(((List)li_store.get(0)).get(2),-1);
if(li_dest!=null && li_dest.size()>0)  idOfanyOfDestStorage=Tools.getInt(((List)li_dest.get(0)).get(2),-1);
%>
<div id="itemdetail_div">
<table cellpadding="1" cellspacing="0" border="0" width="100%"  style="margin-top: 5px;">
<tr><td><%= PortletUtils.getMessage(pageContext, "bg-batch-value",null)%>:
<input type="text" id="itemdetail_defaultvalue" value="" size="10"> &nbsp;
<span style="display:none"><input type="checkbox" id="itemdetail_notnull" value="1"></span><!--<%= PortletUtils.getMessage(pageContext, "do-not-create-record-for-null",null)%>-->
<input class="command2_button" type="button" name="clearinstances" value="<%=PortletUtils.getMessage(pageContext, "clear-all",null)%>(K)" onclick="gc.clearItemDetailInputs()" accessKey="K" >&nbsp;&nbsp;
<span id="all_total_desc"><%= PortletUtils.getMessage(pageContext, "all_total",null)%>:&nbsp;<span id="tot_product"></span></span>
</td></tr>
<tr><td><%= PortletUtils.getMessage(pageContext, "dispatcher_storage",null)%>&nbsp;&nbsp;&nbsp;&nbsp;
<%
	if(store_col!=null){
		store_table =store_col.getReferenceTable();
		store_objectId=Tools.getInt(QueryEngine.getInstance().doQueryOne("select id from c_store where name="+QueryUtils.TO_STRING(storedata)+""),-1);
		if("root".equals(userWeb.getUserName())||
			(idOfanyOfStoreStorage!=-1 && userWeb.hasObjectPermission("V_FA_STORAGE",idOfanyOfStoreStorage,nds.security.Directory.READ))){
				directory_store=true;
		}
%>
<span id="store1_desc"><%=store_col.getDescription(locale)%>:<%=storedata%></span>
<span class="store1_desc_s"><input type="checkbox" id="sqty" value="sqty" checked onclick="gc.showQty('s')"><%=PortletUtils.getMessage(pageContext, "show_qty",null)%></span>
<span class="store1_desc_c"><input type="checkbox" id="cqty" value="cqty" checked onclick="gc.showQty('c')"><%=PortletUtils.getMessage(pageContext, "show_qty_consign",null)%></span>
<span class="store1_desc_v"><input type="checkbox" id="vqty" value="vqty" checked onclick="gc.showQty('v')"><%=PortletUtils.getMessage(pageContext, "show_qty_valid",null)%></span>
&nbsp; &nbsp;
<%}%>
<%
	if(dest_col!=null){
		dest_table=dest_col.getReferenceTable();
		dest_objectId=Tools.getInt(QueryEngine.getInstance().doQueryOne("select id from c_store where name="+QueryUtils.TO_STRING(destdata)+""),-1);
		if("root".equals(userWeb.getUserName())||
			(idOfanyOfDestStorage!=-1 && userWeb.hasObjectPermission("V_FA_STORAGE",idOfanyOfDestStorage,nds.security.Directory.READ))){
				directory_dest =true;
		}
%>
<span style="background-color:#C0FEC0;"><%=dest_col.getDescription(locale)%>:<%=destdata%></span>
<%}%></td></tr>
<tr><td>
<form id="itemdetail_form" onsubmit="return false;">
<div id="itemdetail_div" style="width:100%; height:420px;overflow-y: hidden; overflow-x: scroll; border-width:thin;border-style:groove;border-color:#CCCCCC;padding:0px">
<div id="H_itemdetail_head" style="width: 100%;overflow: hidden; position: relative; z-index: 12;">
<%=getAttributeTable_head(instances2,0,attributes,attributeValues,"",inputList,li_store,li_dest,store_objectId,dest_objectId,store_table,dest_table,directory_store,directory_dest,userWeb)%>
</div>
<div id="D_itemdetail_table" style="width: 100%; max-height: 380px; min-height: 300px; overflow-y: scroll; overflow-x: hidden; z-index: 11;">
<%=getAttributeTable(instances2,0,attributes,attributeValues,"",inputList,li_store,li_dest,store_objectId,dest_objectId,store_table,dest_table,directory_store,directory_dest,userWeb)%>
</div>
</div>
</form>
</td></tr>
<tr><td>
<input class="command2_button" type="button" name="createinstances" value="<%=PortletUtils.getMessage(pageContext, "object.save",null)%>(J)" onclick="gc.saveItemDetail()" accessKey="J" >
<input class="command2_button" type="button" name="cancel" value="<%=PortletUtils.getMessage(pageContext, "cancel",null)%>(Q)" onclick='art.dialog.get("art_itemdetail_div").close();' accessKey="Q" >
</td></tr>
</table>
</div>
<script type="text/javascript">
	var theadTd = jQuery("#modify_table_head").find("thead tr:first td");
	theadTd[theadTd.size()-1].style.paddingRight=getScrollbarWidth()+"px";
	function getScrollbarWidth() 
	{
		if (scrollbarWidth) return scrollbarWidth;
		var div = jQuery('<div style="width:50px;height:50px;overflow:hidden;position:absolute;top:-200px;left:-200px;"><div style="height:400px;"></div></div>'); 
		jQuery('body').append(div); 
		var w1 = jQuery('div', div).innerWidth(); 
		div.css('overflow-y', 'auto'); 
		var w2 = jQuery('div', div).innerWidth(); 
		jQuery(div).remove(); 
		scrollbarWidth = (w1 - w2);
		return scrollbarWidth;
	}
</script>
<%}catch(Throwable t){
	logger.error("/html/nds/pdt/itemdetail.jsp", t);
	out.print(PortletUtils.getMessage(pageContext, "exception",null)+":"+ t.getMessage());
}%>
