<%@ page language="java" import="nds.query.QueryEngine, cn.com.burgeon.tasks.webpos.DateGeneration"  pageEncoding="utf-8"%>
<%
String storeId=request.getParameter("si");
if(null==storeId||storeId.trim().equals("")){
	out.print("错误：未传入店仓信息！");
	return;
}
int rangType=nds.util.Tools.getInt(QueryEngine.getInstance().doQueryOne("select value from ad_param where name='webpos.vipAreaRange'"),-1);
if(rangType==-1){
	out.print("错误：系统参数webpos.vipAreaRange没有或设置错误！");
	return;
}
String range="all";
int rangeId=0;
if(rangType==1){
	range="store";
	rangeId=Integer.parseInt(storeId);
}else if(2==rangType){
	range="city";
	rangeId=nds.util.Tools.getInt(QueryEngine.getInstance().doQueryOne("select C_CITY_ID from c_store where id="+storeId),-1);
}
  java.util.Date d = new java.util.Date(System.currentTimeMillis());
  java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyyMMdd");
  String df = sf.format(d);
DateGeneration dg=new DateGeneration();
try{
	if(dg.generateVipDB(range,rangeId,df)){
		out.print("filename:"+range+"_"+rangeId+"_"+df+".7z");
	}else{
		out.print("数据正在生成，请稍后下载！");
	}
}catch(Exception e){
	out.print("下载文件遇到错误，信息："+e.getMessage());
}
  
%>





