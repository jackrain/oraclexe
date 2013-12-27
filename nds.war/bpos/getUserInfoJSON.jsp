<%@ page language="java" import="java.util.List,nds.query.QueryEngine,org.json.JSONObject,org.json.JSONArray" pageEncoding="utf-8"%>
<%
//Logger logger=LoggerManager.getInstance().getLogger("webpos.getUserInfoJSON.jsp------>");
String storeIds=request.getParameter("storeids");
List ls=QueryEngine.getInstance().doQueryList("select a.ID,a.NAME,a.TRUENAME,a.PASSWORDHASH,a.EMAIL,a.ISSALER,a.AREAMNG_ID,a.C_CUSTOMER_ID,a.C_STORE_ID,a.ISRET,a.C_SUPPLIER_ID,a.webpos_per,b.no,b.TIMECARDNO from users a,hr_employee b where a.isactive='Y'and a.hr_employee_id=b.id(+)  and a.c_store_id in("+storeIds+")");
JSONArray ja=new JSONArray();
if(0<ls.size()){
	for(int i=0;i<ls.size();i++){
		JSONObject jo=new JSONObject();
		jo.put("ID",String.valueOf(((List)ls.get(i)).get(0)));
		jo.put("NAME",String.valueOf(((List)ls.get(i)).get(1)));
		jo.put("TRUENAME",String.valueOf(((List)ls.get(i)).get(2)));
		jo.put("PASSWORD",String.valueOf(((List)ls.get(i)).get(3)));
		jo.put("EMAIL",String.valueOf(((List)ls.get(i)).get(4)));
		jo.put("ISSALER",String.valueOf(((List)ls.get(i)).get(5)));
		jo.put("AREAMNG_ID",String.valueOf(((List)ls.get(i)).get(6)));
		jo.put("C_CUSTOMER_ID",String.valueOf(((List)ls.get(i)).get(7)));
		jo.put("C_STORE_ID",String.valueOf(((List)ls.get(i)).get(8)));
		jo.put("ISRET",String.valueOf(((List)ls.get(i)).get(9)));
		jo.put("C_SUPPLIER_ID",String.valueOf(((List)ls.get(i)).get(10)));
		jo.put("WEBPOS_PER",String.valueOf(((List)ls.get(i)).get(11)));
		jo.put("CODE",String.valueOf(((List)ls.get(i)).get(12)));
		jo.put("CARDNO",String.valueOf(((List)ls.get(i)).get(13)));
		ja.put(jo);
	}
	JSONObject joa=new JSONObject();
	JSONObject jot=new JSONObject();
	jot.put("Table",ja);
	joa.put("param",jot);
	out.print(joa.toString());
}
%>