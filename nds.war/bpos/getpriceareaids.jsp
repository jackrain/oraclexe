<%@ page language="java" import="java.util.*,nds.query.*"  pageEncoding="utf-8"%>
<%
String storeids=request.getParameter("storeids");
if(null==storeids||storeids.trim().equals("")){
	out.print("错误：没有店仓！可能原因：版本已升级，还未安装，请稍等一会！");
	return;
}
String r="area:";
String yesNoPrice=String.valueOf(QueryEngine.getInstance().doQueryOne("select value from ad_param where name='retailprice.flat_price'"));
if("true".equals(yesNoPrice)){
	r+=0;
	out.print(r);
	return;
}
List ret=QueryEngine.getInstance().doQueryList("select c_pricearea_id from c_store where id in("+storeids+")");
if(ret.size()>0){
	for(int i=0;i<ret.size();i++){
		if(null==ret.get(i)){
			out.print("严重错误：有店仓未设置价格区域可能导致无法正常零售，请联系管理员！");
			return;
		}
		if(i==0){
			r+=ret.get(i);
		}else{
			r+=","+ret.get(i);
		}
	}
	out.print(r);
}else{
	out.print("错误：系统中未找到对应的店仓，请联系管理员");
}
%>





