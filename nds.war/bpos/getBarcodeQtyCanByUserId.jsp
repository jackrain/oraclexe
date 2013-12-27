<%@ page language="java" import="java.util.*,java.util.List,nds.query.QueryEngine,nds.util.Tools" pageEncoding="utf-8"%>
<%
String storeId=(String)session.getAttribute("storeId");
if(null==storeId)storeId=request.getParameter("storeid");
String barcode=request.getParameter("barcode");
String styles=request.getParameter("styles");
String flag=request.getParameter("flag_num");
try{
			
    
	if(styles!=null){	
		List sizeSort=QueryEngine.getInstance().doQueryList("select a2.value,a2.name from M_ATTRIBUTE a1,M_ATTRIBUTEVALUE  a2 ,m_product a3 where a3.name= '"+styles+"' and a1.id=a2.m_attribute_id and a3.M_SIZEGROUP_ID=a1.id and a2.CLRSIZE=2 and a1.CLRSIZE=2 order by  lpad(a2.martixcol,2,0) asc");
   ArrayList tempsizesort=new ArrayList();
   ArrayList tempsizesort3=new ArrayList();
    for(int i=0;i<sizeSort.size();i++){
    ArrayList tempsizesort2=new ArrayList();
    tempsizesort2.add("'"+((List)sizeSort.get(i)).get(0)+"'");
    tempsizesort2.add("'"+((List)sizeSort.get(i)).get(1)+"'");
    tempsizesort.add(tempsizesort2);
 
    }																													//select  m.id,t.qtycan from  V_FA_STORAGE t ,m_product_alias m , m_product p where t.c_store_id=4005 and t.m_productalias_id=m.id and m.M_PRODUCT_ID = p.ID and p.NAME='AS001'	
		List qtyCans=QueryEngine.getInstance().doQueryList("select m.id,t.qtycan from  V_FA_STORAGE t ,m_product_alias m ,m_product p where t.c_store_id="+storeId+" and t.m_productalias_id=m.id and m.M_PRODUCT_ID=p.ID AND p.NAME='"+styles+"'");
   tempsizesort3.add(tempsizesort);
   tempsizesort3.add(qtyCans);
    %><%=tempsizesort3%><%
	}
	if(barcode!=null&&!flag.equals("1")){
		int qtyCan=-99999;
		qtyCan=Tools.getInt(QueryEngine.getInstance().doQueryOne("select t.qtycan from  V_FA_STORAGE t ,m_product_alias m where t.c_store_id="+storeId+" and t.m_productalias_id=m.id AND m.no='"+barcode+"'"),-99999);
	  %><%=qtyCan%><%
	}else if(barcode!=null&&flag.equals("1")){
  int qtyCan=-99999;
		qtyCan=Tools.getInt(QueryEngine.getInstance().doQueryOne("select sum(t.qtycan) from  V_FA_STORAGE t ,m_product m where t.c_store_id="+storeId+" and t.m_product_id=m.id AND m.name='"+barcode+"'"),-99999);
    %><%=qtyCan%><%
 }
}catch(Throwable t){}
%>